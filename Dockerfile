#베이스 이미지를 명시해준다.
FROM node:alpine as builder
WORKDIR /usr/src/app
# package.json이 변경되지 않은 경우 dependencies를 새로 다운받을 필요없음.
# 그런 이유로 package.json 만 먼저 copy하고 npm install 실행
COPY package.json ./
RUN npm install
COPY ./ ./
# 컨테이너 시작시 실행될 명령어
CMD ["npm", "run", "build"]

FROM nginx
EXPOSE 80
COPY --from=builder /usr/src/app/build /usr/share/nginx/html