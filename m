Return-Path: <linux-kernel+bounces-106034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0477687E7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6451F2322A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9CF3527A;
	Mon, 18 Mar 2024 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4b5QrH7"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328CC2E84B;
	Mon, 18 Mar 2024 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759806; cv=none; b=g6tf4puioRl6ySe3c3bikvzR21Os8zwwl31g4NtAwyILjUQpB8qsPPQSkSA5PnHkeWTva5IxGhBDYwJhH/DnnWlyCN5iLz5OAvaa43EJ1P4nSqfStkYeP6aEnpJ2o0RVPdbwZNjVObUU3n2u/d89k3BtotwW/Fx4pkq5jUnHl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759806; c=relaxed/simple;
	bh=kM+CNVkGXDtpGZK2lVylyRb5qhDaMi0B6iIAxHjBCOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jLzKgkP7ZGc5qQmr7u9fsIJEG1KybldvAbhZKgphbmskb2oDzouKU+MiB/ZVIEa9Jc32LJ73NIQJmg8Ka1vVp5DC898SqlrPCfZVBKh2BXeX+CXB0dGHw2hmqRvNn0Iam8wice9jBbNeaiErr+naWPfVs13Qxkxd8FPRBOKqgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4b5QrH7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4132f3761dfso864965e9.1;
        Mon, 18 Mar 2024 04:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710759803; x=1711364603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRiu++OW/pfYXV9rtjA1QRBTLstgMLbJFLbS17mJSMI=;
        b=i4b5QrH76duHde4Os0n9b9dTEkf4EOc5HYuh7StGL2TuY1uEm9j9CHnbziGXRhMFZg
         YbUTIZNw7lgkRU2ujGiXX4cfKS3muDmUw8dDOs8eztd1VHDUM+IzZptsem5YPSQ3+b10
         vE692ewgrGZFalAS0KLdBPp+y03XX+w+kKGAU9CeKPXVfX5/X8hwvzKm8WIpgjVcZyNU
         dfov0vuRD4R/HIo6XhOgZ3+mlfDHkTCpKypaVRYFSOoDQqmoLzCRpUXcBSvAOhuCtgZJ
         BPxO2RYUuBLsXV2hCSJw6XZLzYlBSCLSTaa7Lh3wbw4mclDCjnUGGf6JIlpd5/WGi9Ec
         mpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710759803; x=1711364603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRiu++OW/pfYXV9rtjA1QRBTLstgMLbJFLbS17mJSMI=;
        b=TuUoTIGDq90B6hF3IVYVQX6VmqSWnAb5WHKN18KKoQynuIzqQ6mxcQ4s0p8UrQYM1n
         rkqpx9IapF1qEWStCbWTw02DYNyLtY97s9i2Pb2b/8/p3a3JEm+++uBzYauS+R5H/8lc
         6nwYOtSQh3jrVAA4gZNW4ME0X0CFmYo+0TCkzbJnLfaokH+hJf1T2FqRnn6BLIfC3E43
         y21tH2fMIXkGlDcHXfQVa3oB8TPJDRwuiNB1UPj4iCKW+9sy3kQ+hz9hwMstxNC/zRFP
         yE5fU/6ZVznAcPpNR5/sLoXHpjmz5oezJqAHO7ENrYLNiaoTgCDp4auv8o83GNYhcjbk
         S6bw==
X-Forwarded-Encrypted: i=1; AJvYcCUuYBpTj5wNOQFNAXEd6nnEdue7/0bUXWy6S73d8QrmmaMAqjGiplCZEjbkAPRIfRcDSkenz0pAcGdTaB0EInbhi37SuDrWcNVyw7Xa9jmtIgKGo0CTE6ri0ZTDfAJxDKcKmk4IpdaZOE4=
X-Gm-Message-State: AOJu0Ywj78Bdw9CRGI0ri1tHgn8/CeOtNZ1oiSvj4vowlNVcNzOYrFng
	TJ4a7twAAqcF18Z3hstw/BxIoS7MmKYHJBxEAl5y1uxEc9wjuH/Y
X-Google-Smtp-Source: AGHT+IEHxvoFz3ku714UQQV7bTYOuY+Y6bHIimclggcF1vxf+8kI2fHoDpkvdJeLCJWYeMRjSCcCsg==
X-Received: by 2002:a05:600c:1c17:b0:414:225:3699 with SMTP id j23-20020a05600c1c1700b0041402253699mr6627293wms.1.1710759803197;
        Mon, 18 Mar 2024 04:03:23 -0700 (PDT)
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180::bd5a:12c2])
        by smtp.gmail.com with ESMTPSA id je20-20020a05600c1f9400b00413e6af1bd5sm14346860wmb.47.2024.03.18.04.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:03:22 -0700 (PDT)
From: Martino Fontana <tinozzo123@gmail.com>
To: djogorchock@gmail.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martino Fontana <tinozzo123@gmail.com>,
	Ryan McClelland <rymcclel@gmail.com>
Subject: [PATCH v3 RESEND] HID: nintendo: use ida for LED player id
Date: Mon, 18 Mar 2024 11:36:28 +0100
Message-ID: <20240318110145.18490-1-tinozzo123@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the leds pattern would just increment with every controller
connected. This wouldn't take into consideration when controllers are
disconnected. The same controller could be connected and disconnected
with the pattern increasing player count each time.

This patch changes it by using an ID allocator in order to assign the
player id, the same way hid-playstation does.

Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
Signed-off-by: Ryan McClelland <rymcclel@gmail.com>
---
Changes for v2:

ida_free now frees the correct id, instead of an id that got moduloed.

Changes for v3:

Destroy allocator when removing driver.

 drivers/hid/hid-nintendo.c | 41 ++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 997c3a1adaca..8a8ae7881469 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -28,6 +28,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/hid.h>
+#include <linux/idr.h>
 #include <linux/input.h>
 #include <linux/jiffies.h>
 #include <linux/leds.h>
@@ -427,6 +428,7 @@ static const enum led_brightness joycon_player_led_patterns[JC_NUM_LED_PATTERNS]
 struct joycon_ctlr {
 	struct hid_device *hdev;
 	struct input_dev *input;
+	u32 player_id;
 	struct led_classdev leds[JC_NUM_LEDS]; /* player leds */
 	struct led_classdev home_led;
 	enum joycon_ctlr_state ctlr_state;
@@ -1930,7 +1932,8 @@ static int joycon_home_led_brightness_set(struct led_classdev *led,
 	return ret;
 }
 
-static DEFINE_SPINLOCK(joycon_input_num_spinlock);
+static DEFINE_IDA(nintendo_player_id_allocator);
+
 static int joycon_leds_create(struct joycon_ctlr *ctlr)
 {
 	struct hid_device *hdev = ctlr->hdev;
@@ -1941,20 +1944,19 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
 	char *name;
 	int ret;
 	int i;
-	unsigned long flags;
 	int player_led_pattern;
-	static int input_num;
-
-	/*
-	 * Set the player leds based on controller number
-	 * Because there is no standard concept of "player number", the pattern
-	 * number will simply increase by 1 every time a controller is connected.
-	 */
-	spin_lock_irqsave(&joycon_input_num_spinlock, flags);
-	player_led_pattern = input_num++ % JC_NUM_LED_PATTERNS;
-	spin_unlock_irqrestore(&joycon_input_num_spinlock, flags);
 
 	/* configure the player LEDs */
+	ctlr->player_id = U32_MAX;
+	ret = ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
+	if (ret < 0) {
+		hid_warn(hdev, "Failed to allocate player ID, skipping; ret=%d\n", ret);
+		goto home_led;
+	}
+	ctlr->player_id = ret;
+	player_led_pattern = ret % JC_NUM_LED_PATTERNS;
+	hid_info(ctlr->hdev, "assigned player %d led pattern", player_led_pattern + 1);
+
 	for (i = 0; i < JC_NUM_LEDS; i++) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s:%s",
 				      d_name,
@@ -2423,6 +2425,7 @@ static void nintendo_hid_remove(struct hid_device *hdev)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 
 	destroy_workqueue(ctlr->rumble_queue);
+	ida_free(&nintendo_player_id_allocator, ctlr->player_id);
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
@@ -2468,7 +2471,19 @@ static struct hid_driver nintendo_hid_driver = {
 	.resume		= nintendo_hid_resume,
 #endif
 };
-module_hid_driver(nintendo_hid_driver);
+static int __init nintendo_init(void)
+{
+	return hid_register_driver(&nintendo_hid_driver);
+}
+
+static void __exit nintendo_exit(void)
+{
+	hid_unregister_driver(&nintendo_hid_driver);
+	ida_destroy(&nintendo_player_id_allocator);
+}
+
+module_init(nintendo_init);
+module_exit(nintendo_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Daniel J. Ogorchock <djogorchock@gmail.com>");
-- 
2.43.2


