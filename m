Return-Path: <linux-kernel+bounces-4534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B83817EED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5B31F24B32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6929C7472;
	Tue, 19 Dec 2023 00:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/sQHyqb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5E07487;
	Tue, 19 Dec 2023 00:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28b09aeca73so2641370a91.1;
        Mon, 18 Dec 2023 16:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702946580; x=1703551380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffh92IUvZFZtna8N0uVZPGMddG5lUwJz9m6EExTUMzk=;
        b=O/sQHyqb9JGfJ9sZ4maOyIPf4slX/25XgfsUfDFcSFG7EKLWciWBrhXHgwmqhuwpX2
         qLpHubmSHWnH1pZ5nxaGrA9H3TQ3+CIxSATiEUfSnEIUxAMs/JHayFWETlVetukjA+To
         Xu+QxJEnzOZr5NBLDlfyclAvfWa+e0iWsxBdyiP9Ao6oonmJYtWZoeUiDxPmkRiYo7+z
         viBQ423NMo1a8n/mJuJDE3gMYxLavOtS6e2Dt4A1n6l09X7QgNneIEnbx+wc04hj87KH
         vengecKZO9w4vaCaDdAGaDJSKHrp68+YyzQU+wOtLqkMZCjkaxXCcfMtka2q5YYdOoj9
         0aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702946580; x=1703551380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffh92IUvZFZtna8N0uVZPGMddG5lUwJz9m6EExTUMzk=;
        b=DH90P2cstaHT1NFO5yXOzSALiOndYkGmxN5hdJ2SJb+dF0rHX8vQuaYiU4ErgSGajU
         t9/HLLe204tv1nVpkjB2kq9TGOH2nxvwtf7wRsOZU9lWQXoOvjxQzgp1vyqIZDbR3mKr
         FXp4eApbiOOrSSJfOvnMMB+O1yyuRaSCawww4xend/fWu/kHW6BClRIm0wxXkENiXYp4
         o/TuR61FbOFHrfwRQZnEgXGGYQfQaqVplBXemevT0Xo+dQe47C04UTA2O37/eTI/12rO
         xOaizpv4uIuOT9QPjl2okkTmqqywtHoLdMzvHox5NRLmX9sPlW3DU/vXc5MMuJB1m6gV
         eyuA==
X-Gm-Message-State: AOJu0YxB2aA1HBwhB7jWlvHaLoUD0Fl0XjyCvxPArfFJM6tKLugUQH0G
	0LnTnXvqBFIt+POf/GArnI8cvjfwxsg=
X-Google-Smtp-Source: AGHT+IGWKwbwmSr9oQ/EaxBLNcC5i98atAzc1L9Fzj2QL27e9+mxJ7tCtr3d/Bv+8coaZaHQ6pqUfw==
X-Received: by 2002:a17:90a:db0c:b0:28b:6da5:e87c with SMTP id g12-20020a17090adb0c00b0028b6da5e87cmr318119pjv.5.1702946579803;
        Mon, 18 Dec 2023 16:42:59 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a3f0900b0028ae3b5dde9sm173484pjc.12.2023.12.18.16.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:42:59 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v5 4/5] gpiolib: cdev: fully adopt guard() and scoped_guard()
Date: Tue, 19 Dec 2023 08:41:57 +0800
Message-Id: <20231219004158.12405-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219004158.12405-1-warthog618@gmail.com>
References: <20231219004158.12405-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() or scoped_guard() for critical sections rather than
discrete lock/unlock pairs.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 139 ++++++++++++++----------------------
 1 file changed, 55 insertions(+), 84 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 9f5104d7532f..307d629a8889 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -748,13 +748,13 @@ static void linereq_put_event(struct linereq *lr,
 {
 	bool overflow = false;
 
-	spin_lock(&lr->wait.lock);
-	if (kfifo_is_full(&lr->events)) {
-		overflow = true;
-		kfifo_skip(&lr->events);
+	scoped_guard(spinlock, &lr->wait.lock) {
+		if (kfifo_is_full(&lr->events)) {
+			overflow = true;
+			kfifo_skip(&lr->events);
+		}
+		kfifo_in(&lr->events, le, 1);
 	}
-	kfifo_in(&lr->events, le, 1);
-	spin_unlock(&lr->wait.lock);
 	if (!overflow)
 		wake_up_poll(&lr->wait, EPOLLIN);
 	else
@@ -1487,18 +1487,13 @@ static long linereq_set_values_unlocked(struct linereq *lr,
 static long linereq_set_values(struct linereq *lr, void __user *ip)
 {
 	struct gpio_v2_line_values lv;
-	int ret;
 
 	if (copy_from_user(&lv, ip, sizeof(lv)))
 		return -EFAULT;
 
-	mutex_lock(&lr->config_mutex);
+	guard(mutex)(&lr->config_mutex);
 
-	ret = linereq_set_values_unlocked(lr, &lv);
-
-	mutex_unlock(&lr->config_mutex);
-
-	return ret;
+	return linereq_set_values_unlocked(lr, &lv);
 }
 
 static long linereq_set_config_unlocked(struct linereq *lr,
@@ -1556,13 +1551,9 @@ static long linereq_set_config(struct linereq *lr, void __user *ip)
 	if (ret)
 		return ret;
 
-	mutex_lock(&lr->config_mutex);
+	guard(mutex)(&lr->config_mutex);
 
-	ret = linereq_set_config_unlocked(lr, &lc);
-
-	mutex_unlock(&lr->config_mutex);
-
-	return ret;
+	return linereq_set_config_unlocked(lr, &lc);
 }
 
 static long linereq_ioctl_unlocked(struct file *file, unsigned int cmd,
@@ -1644,28 +1635,22 @@ static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
 		return -EINVAL;
 
 	do {
-		spin_lock(&lr->wait.lock);
-		if (kfifo_is_empty(&lr->events)) {
-			if (bytes_read) {
-				spin_unlock(&lr->wait.lock);
-				return bytes_read;
+		scoped_guard(spinlock, &lr->wait.lock) {
+			if (kfifo_is_empty(&lr->events)) {
+				if (bytes_read)
+					return bytes_read;
+
+				if (file->f_flags & O_NONBLOCK)
+					return -EAGAIN;
+
+				ret = wait_event_interruptible_locked(lr->wait,
+						!kfifo_is_empty(&lr->events));
+				if (ret)
+					return ret;
 			}
 
-			if (file->f_flags & O_NONBLOCK) {
-				spin_unlock(&lr->wait.lock);
-				return -EAGAIN;
-			}
-
-			ret = wait_event_interruptible_locked(lr->wait,
-					!kfifo_is_empty(&lr->events));
-			if (ret) {
-				spin_unlock(&lr->wait.lock);
-				return ret;
-			}
+			ret = kfifo_out(&lr->events, &le, 1);
 		}
-
-		ret = kfifo_out(&lr->events, &le, 1);
-		spin_unlock(&lr->wait.lock);
 		if (ret != 1) {
 			/*
 			 * This should never happen - we were holding the
@@ -2015,28 +2000,22 @@ static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
 		return -EINVAL;
 
 	do {
-		spin_lock(&le->wait.lock);
-		if (kfifo_is_empty(&le->events)) {
-			if (bytes_read) {
-				spin_unlock(&le->wait.lock);
-				return bytes_read;
+		scoped_guard(spinlock, &le->wait.lock) {
+			if (kfifo_is_empty(&le->events)) {
+				if (bytes_read)
+					return bytes_read;
+
+				if (file->f_flags & O_NONBLOCK)
+					return -EAGAIN;
+
+				ret = wait_event_interruptible_locked(le->wait,
+						!kfifo_is_empty(&le->events));
+				if (ret)
+					return ret;
 			}
 
-			if (file->f_flags & O_NONBLOCK) {
-				spin_unlock(&le->wait.lock);
-				return -EAGAIN;
-			}
-
-			ret = wait_event_interruptible_locked(le->wait,
-					!kfifo_is_empty(&le->events));
-			if (ret) {
-				spin_unlock(&le->wait.lock);
-				return ret;
-			}
+			ret = kfifo_out(&le->events, &ge, 1);
 		}
-
-		ret = kfifo_out(&le->events, &ge, 1);
-		spin_unlock(&le->wait.lock);
 		if (ret != 1) {
 			/*
 			 * This should never happen - we were holding the lock
@@ -2730,38 +2709,30 @@ static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
 #endif
 
 	do {
-		spin_lock(&cdev->wait.lock);
-		if (kfifo_is_empty(&cdev->events)) {
-			if (bytes_read) {
-				spin_unlock(&cdev->wait.lock);
-				return bytes_read;
-			}
+		scoped_guard(spinlock, &cdev->wait.lock) {
+			if (kfifo_is_empty(&cdev->events)) {
+				if (bytes_read)
+					return bytes_read;
 
-			if (file->f_flags & O_NONBLOCK) {
-				spin_unlock(&cdev->wait.lock);
-				return -EAGAIN;
-			}
+				if (file->f_flags & O_NONBLOCK)
+					return -EAGAIN;
 
-			ret = wait_event_interruptible_locked(cdev->wait,
-					!kfifo_is_empty(&cdev->events));
-			if (ret) {
-				spin_unlock(&cdev->wait.lock);
-				return ret;
+				ret = wait_event_interruptible_locked(cdev->wait,
+						!kfifo_is_empty(&cdev->events));
+				if (ret)
+					return ret;
 			}
-		}
 #ifdef CONFIG_GPIO_CDEV_V1
-		/* must be after kfifo check so watch_abi_version is set */
-		if (atomic_read(&cdev->watch_abi_version) == 2)
-			event_size = sizeof(struct gpio_v2_line_info_changed);
-		else
-			event_size = sizeof(struct gpioline_info_changed);
-		if (count < event_size) {
-			spin_unlock(&cdev->wait.lock);
-			return -EINVAL;
-		}
+			/* must be after kfifo check so watch_abi_version is set */
+			if (atomic_read(&cdev->watch_abi_version) == 2)
+				event_size = sizeof(struct gpio_v2_line_info_changed);
+			else
+				event_size = sizeof(struct gpioline_info_changed);
+			if (count < event_size)
+				return -EINVAL;
 #endif
-		ret = kfifo_out(&cdev->events, &event, 1);
-		spin_unlock(&cdev->wait.lock);
+			ret = kfifo_out(&cdev->events, &event, 1);
+		}
 		if (ret != 1) {
 			ret = -EIO;
 			break;
-- 
2.39.2


