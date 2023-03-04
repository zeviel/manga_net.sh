#!/bin/bash

api="https://api.aninetapi.com/api"
user_id=0


function login() {
	# 1 - email: (string): <email>
	# 2 - password: (string): <password>
	response=$(curl --request POST \
		--url "$api/Manga/Login" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--data '{
			"email": "'$1'",
			"password": "'$2'"
		}')
	if [ -n $(jq -r ".token" <<< "$response") ]; then
		token=$(jq -r ".token" <<< "$response")
		user_id=$(jq -r ".userId" <<< "$response")
	fi
	echo $response
}

function get_cookies() {
	curl --request GET \
		--url "$api/Manga/GetCookies" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_update_link() {
	curl --request GET \
		--url "$api/Manga/GetUpdateLink" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_genres() {
	curl --request GET \
		--url "$api/Manga/Genre" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_hot_mangas() {
	# 1 - skip: (integer): <skip - default: 0>
	# 2 - take: (integer): <take - default: 100>
	curl --request GET \
		--url "$api/Manga/Hot?userId=$user_id&skip=${1:-0}&take=${2:-100}" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_new_mangas() {
	# 1 - skip: (integer): <skip - default: 0>
	# 2 - take: (integer): <take - default: 100>
	curl --request GET \
		--url "$api/Manga/NewManga?userId=$user_id&skip=${1:-0}&take=${2:-100}" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_filtered_mangas() {
	# 1 - new_mangas: (boolean): <true, false - default: false>
	# 2 - has_manga: (boolean): <true, false - default: true>
	# 3 - sort: (string): <sort - default: members>
	# 4 - statuses: (integer): <statuses - default: 1>
	# 5 - manga_webtoon: (integer): <manga_webtoon - default: 0>
	# 6 - minimum_chapters: (integer): <minimum_chapters - default: 0>
	# 7 - maximum_chapters: (integer): <maximum_chapters - default: 0>
	# 8 - other_user_id: (integer): <other_user_id - default: 0>
	# 9 - user_id: (integer): <user_id - default: 0>
	# 10 - take: (integer): <take - default: 100>
	# 11 - skip: (integer): <skip - default: 0>
	curl --request GET \
		--url "$api/Manga/FilteredList?newMangas=${1:-false}&hasManga=${2:-true}&sort=${3:-members}&statuses=${4:-1}&mangaWebtoon=${5:-0}&minChapters=${6:-0}&maxChapters=${7:-0}&otherUserId=${8:-0}&userId=${9:-0}&take=${10:-100}&skip=${11:-0}" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}


function register() {
	# 1 - name: (string): <name>
	# 2 - email: (string): <email>
	# 3 - password: (string): <password>
	curl --request POST \
		--url "$api/Manga/Register" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--data '{
			"name": "'$1'",
			"email": "'$2'",
			"password": "'$3'",
		}'
}

function get_user_info() {
	# 1 - user_id: (integer): <user_id>
	curl --request GET \
		--url "$api/Manga/MangaUser?userId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_user_latest_comments() {
	# 1 - user_id: (integer): <user_id>
	curl --request GET \
		--url "$api/Manga/UserLatestComments?userId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_user_favorites() {
	# 1 - user_id: (integer): <user_id>
	curl --request GET \
		--url "$api/Manga/GetFavoriteManga?userId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_user_feed() {
	# 1 - user_id: (integer): <user_id>
	curl --request GET \
		--url "$api/Manga/UserFeed?userId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function search_manga() {
	# 1 - name: (string): <name>
	curl --request GET \
		--url "$api/Manga/FastSearch?name=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_manga_info() {
	# 1 - manga_id: (integer): <manga_id>
	curl --request GET \
		--url "$api/Manga/Description?mangaId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_manga_comments() {
	# 1 - manga_id: (integer): <manga_id>
	# 2 - skip: (integer): <skip - default: 0>
	# 3 - take: (integer): <take - default: 100>
	# 4 - sort: (string): <replies, likes - default: date>
	curl --request GET \
		--url "$api/Manga/CommentsForList?mangaId=$1&skip=${2:-0}&take=${3:-100}&sort=${4:-date}" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function ban_user() {
	# 1 - user_id: (integer): <user_id>
	curl --request POST \
		--url "$api/Manga/BanUser?userId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function comment_manga() {
	# 1 - manga_id: (integer): <manga_id>
	# 2 - text: (string): <text>
	# 3 - is_spoiler: (boolean): <true, false default: false>
	curl --request POST \
		--url "$api/Manga/Comment" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $token" \
		--data '{
			"userId": "'$user_id'",
			"mangaId": "'$1'",
			"text": "'$2'",
			"spoilers": "'${3-:false}'"
		}'
}

function edit_comment() {
	# 1 - comment_id: (integer): <comment_id>
	# 2 - text: (string): <text>
	# 3 - is_spoiler: (boolean): <true, false default: false>
	curl --request PUT \
		--url "$api/Manga/Comment" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $token" \
		--data '{
			"commentId": "'$1'",
			"text": "'$2'",
			"isSpoiler": "'${3-:false}'"
		}'
}


function delete_comment() {
	# 1 - comment_id: (integer): <comment_id>
	curl --request DELETE \
		--url "$api/Manga/Comment?commentId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $token"
}

function get_manga_chapters() {
	# 1 - manga_id: (integer): <manga_id>
	# 2 - skip: (integer): <skip - default: 0>
	# 3 - take: (integer): <take - default: 10000>
	# 4 - manga_provider_id: (integer): <manga_provider_id - default: 1>
	curl --request GET \
		--url "$api/Manga/GetChapters?mangaId=$1&skip=${2:-0}&take=${3:-10000}&mangaProviderId=${4:-1}" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_similar_mangas() {
	# 1 - manga_id: (integer): <manga_id>
	# 2 - count: (integer): <count - default: 5>
	curl --request GET \
		--url "$api/Manga/SimilarManga?Id=$1&count=${2-:5}" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function add_favorite() {
	# 1 - manga_id: (integer): <manga_id>
	curl --request POST \
		--url "$api/Manga/AddFavorite?userId=$user_id&mangaId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $token"
}

function remove_favorite() {
	# 1 - manga_id: (integer): <manga_id>
	curl --request DELETE \
		--url "$api/Manga/RemoveFavorite?userId=$user_id&mangaId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $token"
}

function like_comment() {
	# 1 - comment_id: (integer): <comment_id>
	# 2 - is_like: (boolean): <true, false default: true>
	curl --request POST \
		--url "$api/Manga/CommentLike" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $token" \
		--data '{
			"userId": "'$user_id'",
			"commentId": "'$1'",
			"isLike": "'${2-:true}'"
		}'
}

function search_user_by_name() {
	# 1 - name: (string): <name>
	# 2 - count: (integer): <count - default: 100>
	# 3 - skip: (integer): <skip - default: 0>
	curl --request GET \
		--url "$api/Manga/UserByName?name=$1&count=${2-:100}&skip=${3-:0}" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_predictions() {
	# 1 - skip: (integer): <skip - default: 0>
	# 2 - take: (integer): <take - default: 10>
	curl --request GET \
		--url "$api/Manga/GetPrediction?userId=$user_id&skip=${1-:0}&take=${2-:10}" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function send_friend_request() {
	# 1 - user_id: (integer): <user_id>
	curl --request POST \
		--url "$api/Manga/MangaFriend?userId=$user_id&friendId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $token"
}

function remove_friend_request() {
	# 1 - user_id: (integer): <user_id>
	curl --request DELETE \
		--url "$api/Manga/RemoveMangaFriend?userId=$user_id&friendId=$1" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $token"
}

function get_last_updates() {
	# 1 - skip: (integer): <skip - default: 0>
	# 2 - take: (integer): <take - default: 10>
	curl --request GET \
		--url "$api/Manga/LatestNotifications?userId=$user_id&skip=${1-:0}&take=${2-:10}" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function get_avatars() {
	curl --request GET \
		--url "$api/Manga/MangaAvatars" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json"
}

function edit_profile() {
	# 1 - username: (string): <username - default: null>
	# 2 - avatar_id: (integer): <avatar_id - default: 0>
	# 3 - is_hentai: (boolean): <true, false - default: null>
	# 4 - is_yaoi: (boolean): <true, false - default: null>
	# 5 - is_incognito: (boolean): <true, false - default: null>
	curl --request PUT \
		--url "$api/Manga/ChangeUserInfo" \
		--user-agent "Dart/2.19 (dart:io)" \
		--header "content-type: application/json" \
		--header "authorization: Bearer $token" \
		--data '{
			"userId": "'$user_id'",
			"userName": '${1-:null}',
			"avatarId": '${2-:0}',
			"isHentai": '${3-:null}',
			"isYaoi": '${4-:null}',
			"isIncognito": '${5-:null}'
		}'
}
