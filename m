Return-Path: <linux-kernel+bounces-1863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D12838154EC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6911C2459D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BF0A40;
	Sat, 16 Dec 2023 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrEA1z7V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C129CA;
	Sat, 16 Dec 2023 00:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so1054998b3a.2;
        Fri, 15 Dec 2023 16:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702685865; x=1703290665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCz017gwGhwzQemSmR9uwl3+atXn6JgAccEYbOS8Vz0=;
        b=jrEA1z7V8EUXik+ITlhFkCQWfNs0fAU8m0WPOCMhMznDqTKI3E72KJxL3amdMNbdbf
         68pZRaJILpuNuP0rL/N3zH+bO3cnJt7tA0M6mGN9/rDNdLxcca4a90ReTunvWEleqD4C
         OvHYKGDlZTqQ3lo4rAbX0arqRlH76GzKuSc7keXBM2ANA5U+Kl2se35skDSr9oKbnuqd
         kMP5XRHFWPMdtimAAFO1af+iOyFC8D6jDYNAbtqVpV9tZujYG3oCcWwAwo96Zn1hjqEG
         o1CtzkXvKTuBeRTD+w5VA6bq96oanMunuRaxF7gElIKXIrNVXibnqQzV+8RwC32ST4RH
         6hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685865; x=1703290665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCz017gwGhwzQemSmR9uwl3+atXn6JgAccEYbOS8Vz0=;
        b=jq1kUuSAzFaD5yDQMY1qcm0nZp4jb6C70A0e+T1BKyLL05PFX1ukbgdFzC+5tyKxci
         yItGLeWlAeg34FJZRo5MaVvP5MXdNnIfCoDwrEiOViOpF534dzrWd3K4AbIUrwQNV52z
         3Z88tlxGEiQuZaHE4yHNMPGp/eUHFF98ol9NBjyzmW4uE6gsdnIZFRXK04LkY5ckqTzr
         PKrjc9wc/5Ekddcq5hi2ZcgJ+zLfNpWMfbsgO9/Y1VRDann507dpZ3yTBW1TR2k8DkvE
         rpNeCvRYTqrZNb8waayDatgM9NXrkRQSDvoMp0A65z8DM4D7zpbe3R3Nzy23J5Uv4yb0
         x2AA==
X-Gm-Message-State: AOJu0Ywwl1m8k+xsiQFPNPFLX0cexLbO0+wNfaZOhPfLd2W1V/Qwz2N0
	BrlkHsBLUgkCl/2t66oeA19QrPYGITU=
X-Google-Smtp-Source: AGHT+IE1SrmWuyPYeIU50E6reCQRGGtLNE/UHrB92CvISutTmsF8VirHEJTcOWc2VCYwjjxskSs66w==
X-Received: by 2002:a05:6a20:b297:b0:18b:844d:778f with SMTP id ei23-20020a056a20b29700b0018b844d778fmr10927402pzb.12.1702685865093;
        Fri, 15 Dec 2023 16:17:45 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id ei39-20020a056a0080e700b006cbef269712sm14176124pfb.9.2023.12.15.16.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:17:44 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v4 4/5] gpiolib: cdev: fully adopt guard() and scoped_guard()
Date: Sat, 16 Dec 2023 08:16:51 +0800
Message-Id: <20231216001652.56276-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231216001652.56276-1-warthog618@gmail.com>
References: <20231216001652.56276-1-warthog618@gmail.com>
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
index 8c174dda622d..68fa9714e643 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -739,13 +739,13 @@ static void linereq_put_event(struct linereq *lr,
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
@@ -1478,18 +1478,13 @@ static long linereq_set_values_unlocked(struct linereq *lr,
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
@@ -1547,13 +1542,9 @@ static long linereq_set_config(struct linereq *lr, void __user *ip)
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
@@ -1635,28 +1626,22 @@ static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
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
@@ -2006,28 +1991,22 @@ static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
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
@@ -2721,38 +2700,30 @@ static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
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


