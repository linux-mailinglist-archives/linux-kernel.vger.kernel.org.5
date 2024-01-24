Return-Path: <linux-kernel+bounces-37096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B829A83AB7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6928B2957A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537B7C08F;
	Wed, 24 Jan 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCtjoMkB"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AEF7C090
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105730; cv=none; b=KZqPHzcZ81ayUOjp9oq0qXbABZQ2/Njrcqj+i1mP1nC73o7WUF4IkOq1ev5R6VxpQWaVU5U9qWM4wPN1FfsBQYseog8cHB5EPDmK8NbdR0xVskr3sOSJT814bXZOaKxPmkdD9Qf9xK3Jd7GPYKXO5HH6EGaJqjQBmEH/Jm7XNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105730; c=relaxed/simple;
	bh=SXgjaHAj6mc5bUoF/0ublXUVySE2uQcKr8Ju/E+GUFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJBz6bISges2Ve605eq3VHzsED2gO7fURRwxWPs8I6XbYIwcVPdkxKSfzNhY4eJ9Y6/wzP8Iyhe3WwUY8BTf+wtGyClbya72FSClrCaHHHI9kP93yU5caPpgcNZ+16EEeUzqfI5O7I/U+kDNp4o0dnAwRvzJLxIGJ5sjyQdBIY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dCtjoMkB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5100b424f8fso1717620e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706105725; x=1706710525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Emu9TGmELjy3ceHR0soeUQYq/a/KfpUveoio5V7U5Xk=;
        b=dCtjoMkBZiBnh1uqZqVSrH5uPUKKQEMZfoCYRJxAVUm9K6DVIuFeFoR/2eyzy6QEpq
         VW40pmawSkIQZbq4pyM20SSLWo2sEYrUrPUcv51OTcZzbGrQ6mixVLZv/wiZlfxs57A5
         7wla1NLiBOoMg8nqJRkhWJ0kdaxzuqmFCUmAdTkJveYj0rFCWyiiRCkXIi7iTelCeWpm
         5XMX2NEBCljrCdN7/uySTJg9dkcvOKiHfvUF8RcIEiyEBW6Q+6VapzYjnsEBcY75Yp9u
         z4jK7dt+st47mf3Zb0nXmifzAuctHiovfXDc+wFn+7Nipi6AcJLdavecTPPkYAvwD9wZ
         Bshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105725; x=1706710525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Emu9TGmELjy3ceHR0soeUQYq/a/KfpUveoio5V7U5Xk=;
        b=dO0K5I1EJvjsU29Y1re6UYmkPI/mXbZhwOt611fyHtRC8usXTRV9I3k7mTd4ANSX/S
         vmLrQzgPVgoxA5cq9GGz+jV3BlBpxTZNRrbgiz18yuXWoW9yLwW+S2lDrVOgt9qTTZec
         XXcGtR7brcsCQj9Ium06A8gevd+O5WTTuM1WRvIhHTY9cA4fKjqqU+ZlvLd2DxGdgnq8
         KVy2WeizjeawOqbZKQmVt7Qt9GeVGgzhwEMlJv2dohVmCmZeLtU6jYRFOFRGJFFJLqmj
         Iw1rK6MrPcYx5fRjFojCRTJIpdoKW0g5a1Y90v9CbgGz+MU4lC89vR6Nf1jb/jezsqUG
         nrKQ==
X-Gm-Message-State: AOJu0Yw5e42Ny1/cQ7fGNh/StFy+C2TBR7PfXmDwxTYgviKyywy5PphX
	+8hzkkOpwyTWHLzJoPW6FY7iK300y130unOHNckRlGxKYs4yf+z7hVS98AFFei0=
X-Google-Smtp-Source: AGHT+IHc46rAxq1R2suh/qkOcv105YlkAEWHIOmow9ewHTYWO5FRW47hScfpHJ8HFVuGgx0owI33Fw==
X-Received: by 2002:a05:6512:2808:b0:50e:ccfa:56c3 with SMTP id cf8-20020a056512280800b0050eccfa56c3mr4497154lfb.34.1706105725323;
        Wed, 24 Jan 2024 06:15:25 -0800 (PST)
Received: from ttritton.c.googlers.com.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id vu3-20020a170907a64300b00a2d7f63dd71sm12399097ejc.29.2024.01.24.06.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:15:25 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	bettyzhou@google.com,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH 3/3] selftests/seccomp: user_notification_addfd check nextfd is available
Date: Wed, 24 Jan 2024 14:13:57 +0000
Message-ID: <20240124141357.1243457-4-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240124141357.1243457-1-terry.tritton@linaro.org>
References: <20240124141357.1243457-1-terry.tritton@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the user_notification_addfd test checks what the next expected
file descriptor will be by incrementing a variable nextfd. This does not
account for file descriptors that may already be open before the test is
started and will cause the test to fail if any exist.

Replace nextfd++ with a function get_next_fd which will check and return
the next available file descriptor.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index da11b95b8872..cacf6507f690 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4044,6 +4044,16 @@ TEST(user_notification_filter_empty_threaded)
 	EXPECT_GT((pollfd.revents & POLLHUP) ?: 0, 0);
 }
 
+
+int get_next_fd(int prev_fd)
+{
+	for (int i = prev_fd + 1; i < FD_SETSIZE; ++i) {
+		if (fcntl(i, F_GETFD) == -1)
+			return i;
+	}
+	_exit(EXIT_FAILURE);
+}
+
 TEST(user_notification_addfd)
 {
 	pid_t pid;
@@ -4060,7 +4070,7 @@ TEST(user_notification_addfd)
 	/* There may be arbitrary already-open fds at test start. */
 	memfd = memfd_create("test", 0);
 	ASSERT_GE(memfd, 0);
-	nextfd = memfd + 1;
+	nextfd = get_next_fd(memfd);
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	ASSERT_EQ(0, ret) {
@@ -4071,7 +4081,8 @@ TEST(user_notification_addfd)
 	/* Check that the basic notification machinery works */
 	listener = user_notif_syscall(__NR_getppid,
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	ASSERT_EQ(listener, nextfd++);
+	ASSERT_EQ(listener, nextfd);
+	nextfd = get_next_fd(nextfd);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
@@ -4126,14 +4137,16 @@ TEST(user_notification_addfd)
 
 	/* Verify we can set an arbitrary remote fd */
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
-	EXPECT_EQ(fd, nextfd++);
+	EXPECT_EQ(fd, nextfd);
+	nextfd = get_next_fd(nextfd);
 	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/* Verify we can set an arbitrary remote fd with large size */
 	memset(&big, 0x0, sizeof(big));
 	big.addfd = addfd;
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD_BIG, &big);
-	EXPECT_EQ(fd, nextfd++);
+	EXPECT_EQ(fd, nextfd);
+	nextfd = get_next_fd(nextfd);
 
 	/* Verify we can set a specific remote fd */
 	addfd.newfd = 42;
@@ -4171,7 +4184,8 @@ TEST(user_notification_addfd)
 	 * Child has earlier "low" fds and now 42, so we expect the next
 	 * lowest available fd to be assigned here.
 	 */
-	EXPECT_EQ(fd, nextfd++);
+	EXPECT_EQ(fd, nextfd);
+	nextfd = get_next_fd(nextfd);
 	ASSERT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/*
-- 
2.43.0.429.g432eaa2c6b-goog


