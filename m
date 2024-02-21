Return-Path: <linux-kernel+bounces-74514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF29F85D557
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2E11C21041
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8DE3D978;
	Wed, 21 Feb 2024 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="D5U5RqGD"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2193CF68
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510870; cv=none; b=QCdMXPZ5eeLvsEv/eohBG1XJ1EqjBGqRrky4avVedBHqoOh/SfUQtpJsP/UIfoNVtbuqt3jcMuYfBXiqpbUIkc2DQJFypcQl/LediaydcKKix8d53IQwg5v8oiNvE98eC5G5MP2HwE4eo/QyPVr8wrkBYAOIVqN6d6FtJDmx3aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510870; c=relaxed/simple;
	bh=1O49FRnw3Hx1RJ2xYsw7QP73lcqSRFPxuNQD9VyTp7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qBEIWXLo4uSCShrrZnZJGpLHDekYlioEiu5DD2lpg2Ws9QVzewu3D5LxCTdEWbmpcB+tboD7Qh/mnj0gAXQOVgQvz+z8mfVRcz02MEyJIDfQBJrQhGdvE1l/hzs1VuAg2AorjlNTklkYMTrbMAl31s+iSRUGp5ZwbSKNB6+/eH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=D5U5RqGD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d3b72f710so2251695f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708510867; x=1709115667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87IsNEl8BjvsGXxmFyPTEb2xKBWIImpeQ3mV7pifE5I=;
        b=D5U5RqGDui/TUgZpjQ29o/5wYs4kbbJDCvLKzRXpsMc2pA7/u4JGSbLkcjv2btZbBU
         9nHDDFqJava8Q+MTTDreGVlc6hZ7Vw4nTZU60dfG+8dBAH1e5yi4A4fOgRY4QT/EVk1t
         eGSAWIzKjPlrZB5abDbBN+YC2D8gP2YN8pADdpg92tosMa6FMxMsdud2zcQ+ZL2xfq/7
         uD5yGjJRjS4WWSUe9dbjtT2ZlYTe/GWnGusU6sajZuzZ1CQoFbUvTqyBB9N1eKp4G1QB
         c8CxInvsIkDZ7gPLcKKSX98Y4SmnhURsPNZUkzKODQOMNgWYSQpMJ/J3hDsOGO2/Uqxo
         gl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708510867; x=1709115667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87IsNEl8BjvsGXxmFyPTEb2xKBWIImpeQ3mV7pifE5I=;
        b=H4eojd63KenERlMjpUbxfNQYqrm3S/GnnsRM1EQNMnn7lnCnrk57HmbUZLKQ/VrPWl
         WWhla5qkF9UYdP28hM92IvRw2x9QSH/6AF8XUEwjkk2pRcfZw3XSoslXefahfq6jdyN2
         YSUXd1fFbI8FMq8JsrXiDLeNFMsZ6fcHUIPt5zpTuD/KHznX5WURTMlNM5FtKABsELll
         N+oAoR8lSxt6qfVElQOtarHwvkYPBaHc33wfkTI/DEPTlfAn2rh+PTi8+lCDxxrtI5te
         2D2TGeSUc3dIs6AXHJBdl9XFNjtmWz1+2U2wGGvn0MKsQosecx3XfP13wyKjD1PuoVOT
         2UHw==
X-Forwarded-Encrypted: i=1; AJvYcCUEyqfA2BYQQcczlyWTiEJ5NNEVjGTYM1PstyjXwuH28F5qgrz8p5lWKOoOyZg3aADtqwUmS6sMikXaNRx2O5Y8E/zITSKvU14FB4f7
X-Gm-Message-State: AOJu0Yxns4QXyKh/NPdc0IbuuMJB1FUTtqiIQ5FV9FVJYjzIogmd27qE
	nNe+kbkpn9QLVZs0BDdACuipPG/xJcq2PmUhpdw8xwpLtCu29Jve4lrkd8nCGPk=
X-Google-Smtp-Source: AGHT+IFrwmedY5fYo7zrkWyQlIzX/qQpVRT1u5MDlvclQOGRNKL1zkU+zYRWoNBHgcMURCtuMKHsrg==
X-Received: by 2002:adf:ec44:0:b0:33d:3ceb:5308 with SMTP id w4-20020adfec44000000b0033d3ceb5308mr6394172wrn.42.1708510866730;
        Wed, 21 Feb 2024 02:21:06 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:9a9e:4b2:5ad4:f63e])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d444b000000b0033b7ce8b496sm16461338wrr.108.2024.02.21.02.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 02:21:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Herve Codina <herve.codina@bootlin.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpio: don't warn about removing GPIO chips with active users anymore
Date: Wed, 21 Feb 2024 11:21:03 +0100
Message-Id: <20240221102103.10099-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With SRCU we can now correctly handle the situation when a GPIO provider
is removed while having users still holding references to GPIO
descriptors. Remove all warnings emitted in this situation.

Suggested-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3c22920bd201..63e793a410e3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1106,7 +1106,6 @@ EXPORT_SYMBOL_GPL(gpiochip_add_data_with_key);
 void gpiochip_remove(struct gpio_chip *gc)
 {
 	struct gpio_device *gdev = gc->gpiodev;
-	unsigned int i;
 
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
 	gpiochip_sysfs_unregister(gdev);
@@ -1130,15 +1129,6 @@ void gpiochip_remove(struct gpio_chip *gc)
 	 */
 	gpiochip_set_data(gc, NULL);
 
-	for (i = 0; i < gdev->ngpio; i++) {
-		if (test_bit(FLAG_REQUESTED, &gdev->descs[i].flags))
-			break;
-	}
-
-	if (i != gdev->ngpio)
-		dev_crit(&gdev->dev,
-			 "REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED\n");
-
 	/*
 	 * The gpiochip side puts its use of the device to rest here:
 	 * if there are no userspace clients, the chardev and device will
@@ -2329,10 +2319,9 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 	return ret;
 }
 
-static bool gpiod_free_commit(struct gpio_desc *desc)
+static void gpiod_free_commit(struct gpio_desc *desc)
 {
 	unsigned long flags;
-	bool ret = false;
 
 	might_sleep();
 
@@ -2357,23 +2346,18 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 #ifdef CONFIG_OF_DYNAMIC
 		WRITE_ONCE(desc->hog, NULL);
 #endif
-		ret = true;
 		desc_set_label(desc, NULL);
 		WRITE_ONCE(desc->flags, flags);
 
 		gpiod_line_state_notify(desc, GPIOLINE_CHANGED_RELEASED);
 	}
-
-	return ret;
 }
 
 void gpiod_free(struct gpio_desc *desc)
 {
 	VALIDATE_DESC_VOID(desc);
 
-	if (!gpiod_free_commit(desc))
-		WARN_ON(1);
-
+	gpiod_free_commit(desc);
 	module_put(desc->gdev->owner);
 	gpio_device_put(desc->gdev);
 }
-- 
2.40.1


