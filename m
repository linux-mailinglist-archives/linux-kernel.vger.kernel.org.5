Return-Path: <linux-kernel+bounces-368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D707281401A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C79B1C22235
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B488D267;
	Fri, 15 Dec 2023 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1BTw36N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073AC8FD;
	Fri, 15 Dec 2023 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9e7f4a0d7so201773b6e.1;
        Thu, 14 Dec 2023 18:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702607979; x=1703212779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqel2RWN3Kn4ajuEozWoNvrbGTL4J41kB/Wxn1TNEfI=;
        b=i1BTw36N9iti7m1ZvH9wj6lDNfUzcZnOdEk8Ekl51L3hdOdZagD/YRapgGynwsnR3M
         xs9DHUJ7/r4slYVNLzfjDHyaX8zbKnEjWNTK3hM0GKat5UtXIqNrZjmUMcXdQfGY2LXT
         rAeHfwZWUtJhGc2peQLFA68JQfAm/hJb8ssXLGAZhLMBloTg6OhvmR17teYGJ4PrxAsZ
         WfuH7IXxMGnW8sws1Byh/235h2/yz7FGf2HSDtBu+b8dK0WhKb0/XoryrcWPi0q6EOTf
         Uo+Xy6jE/JCEQ8ZPS8EqSNvYL4UhYzADxeym5Hpta2CmY5kG1nxURF5Bt+5SrmsL1gCe
         S6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607979; x=1703212779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nqel2RWN3Kn4ajuEozWoNvrbGTL4J41kB/Wxn1TNEfI=;
        b=J/mIUxsSxQsOcgF1TGv6P+bdobJZCjAhk+n0eb2r7hn1pyG3zt3bOHFikw12gjQVk5
         TJ+Fx49KCLyzn6nJdIZOmINDQKTBPXZGNWYpNmCcHQdIEgzqd4BzF5LAAr2bD0Y13wuu
         jrlckXMp1CYkwxMc0uMn9bZ3/S1WA9fupwUAEPVsv/Je87D3R7F6jvtAPjc3rpznYqcz
         TUusATMmitLukVCul5N/jG5oz0ffNQZix+bQIL4C25VL9NyNcBHegDmhhsRkrYeN3zXA
         EXQfBtYBdRcQwvuHxuJ9gqzbPHHW7XWVQhVRfOwYSgckD/uyjfKIuetdric8DRqIUAmE
         04fw==
X-Gm-Message-State: AOJu0YwJh6ETjQMuBk56sp8WfaY1hSKJ3vG5gP0F4vtyleVxlmQOhrU+
	rxSPKX/AWtkl63nwCVjteJzBt5APFd4=
X-Google-Smtp-Source: AGHT+IHzA2AZn6CLfzKuZS9GmxUXQLymaAecITlAHsODervgC5BhErwjHMCjhE2PTLtTtaoWNQR/zw==
X-Received: by 2002:a05:6808:320c:b0:3ba:54d:413 with SMTP id cb12-20020a056808320c00b003ba054d0413mr10950544oib.54.1702607979119;
        Thu, 14 Dec 2023 18:39:39 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id fk16-20020a056a003a9000b006d26920a11dsm1437987pfb.0.2023.12.14.18.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:39:38 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 4/5] gpiolib: cdev: fully adopt guard() and scoped_guard()
Date: Fri, 15 Dec 2023 10:38:04 +0800
Message-Id: <20231215023805.63289-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215023805.63289-1-warthog618@gmail.com>
References: <20231215023805.63289-1-warthog618@gmail.com>
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
---
 drivers/gpio/gpiolib-cdev.c | 143 ++++++++++++++----------------------
 1 file changed, 57 insertions(+), 86 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index c140bcd63361..b956664f8649 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -737,13 +737,13 @@ static void linereq_put_event(struct linereq *lr,
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
@@ -1476,18 +1476,13 @@ static long linereq_set_values_unlocked(struct linereq *lr,
 static long linereq_set_values(struct linereq *lr, void __user *ip)
 {
 	struct gpio_v2_line_values lv;
-	int ret;
 
 	if (copy_from_user(&lv, ip, sizeof(lv)))
 		return -EFAULT;
 
-	mutex_lock(&lr->config_mutex);
-
-	ret = linereq_set_values_unlocked(lr, &lv);
-
-	mutex_unlock(&lr->config_mutex);
+	guard(mutex)(&lr->config_mutex);
 
-	return ret;
+	return linereq_set_values_unlocked(lr, &lv);
 }
 
 static long linereq_set_config_unlocked(struct linereq *lr,
@@ -1545,13 +1540,9 @@ static long linereq_set_config(struct linereq *lr, void __user *ip)
 	if (ret)
 		return ret;
 
-	mutex_lock(&lr->config_mutex);
-
-	ret = linereq_set_config_unlocked(lr, &lc);
+	guard(mutex)(&lr->config_mutex);
 
-	mutex_unlock(&lr->config_mutex);
-
-	return ret;
+	return linereq_set_config_unlocked(lr, &lc);
 }
 
 static long linereq_ioctl_unlocked(struct file *file, unsigned int cmd,
@@ -1633,28 +1624,22 @@ static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
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
@@ -2004,28 +1989,22 @@ static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
 		return -EINVAL;
 
 	do {
-		spin_lock(&le->wait.lock);
-		if (kfifo_is_empty(&le->events)) {
-			if (bytes_read) {
-				spin_unlock(&le->wait.lock);
-				return bytes_read;
-			}
-
-			if (file->f_flags & O_NONBLOCK) {
-				spin_unlock(&le->wait.lock);
-				return -EAGAIN;
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
@@ -2719,38 +2698,30 @@ static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
 #endif
 
 	do {
-		spin_lock(&cdev->wait.lock);
-		if (kfifo_is_empty(&cdev->events)) {
-			if (bytes_read) {
-				spin_unlock(&cdev->wait.lock);
-				return bytes_read;
-			}
-
-			if (file->f_flags & O_NONBLOCK) {
-				spin_unlock(&cdev->wait.lock);
-				return -EAGAIN;
-			}
-
-			ret = wait_event_interruptible_locked(cdev->wait,
-					!kfifo_is_empty(&cdev->events));
-			if (ret) {
-				spin_unlock(&cdev->wait.lock);
-				return ret;
+		scoped_guard(spinlock, &cdev->wait.lock) {
+			if (kfifo_is_empty(&cdev->events)) {
+				if (bytes_read)
+					return bytes_read;
+
+				if (file->f_flags & O_NONBLOCK)
+					return -EAGAIN;
+
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


