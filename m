Return-Path: <linux-kernel+bounces-98352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E408778C2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7FF2815A9
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852C33BBF6;
	Sun, 10 Mar 2024 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggQcaoQw"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153313B2BD;
	Sun, 10 Mar 2024 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710109100; cv=none; b=uIiBahcXnPq+Fzl3lWQoI7F1z0zPXaoTk51SgYEqShTPy7YNGcQR13fmoyzNDOeENYY5dfVwjGm96VvF4nEpXG9qlie1Qob8sL+gblth5i3BqIkLRz5H6tACh1gl8iwpEHtb23DPba0pdRMCr+LPJR5jeJW5RR8iKkyTfLmUFxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710109100; c=relaxed/simple;
	bh=LzojmOkGyGWODGs86carqSVDvuw6ECtiishy9jfjPf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/C0uvfJMBA2GhddoIpQXqv+Pt4RTZvlm69RCELj2l2c3qEA1iyUBwfrr2EeReyuViSFkK4ZMKR8wiNbk7xJKHTBYh6k5/MnrQRnpSILO9PtOTjI1LJBxoNJ0nJRdYQ3F5zq4oQYohypV4DNGVCvED86mcYaiWqvTD9vQCQSKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggQcaoQw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5586764bd0aso1186597a12.0;
        Sun, 10 Mar 2024 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710109097; x=1710713897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gS5X6onTdeKQ+ZJfx6BgLwsymjvWUS7UTiqeOdmipA=;
        b=ggQcaoQwxbObmQLLm8kX8v56Qez8YJsL0D/h0d7q8FA0DLlE+tsbKz+5pWq4wCBCr5
         B2eHrRey0WX77smkmD8Dych1/r6/hgMyESwHpx4bUh1r87yd5niaTgL9Uh/+nUAVDSmh
         /Xe84jTskEwxtXmEjtt71iF5diQqc6C2LvSIBpfRjesaQOU+aeB/lD8BZ7SaZHUC+kVU
         n/dtCF07eUHSTqqWe3VuBpIqlb2FbZSZSH5fnxVirhpafIb+CrhKlLvPEIsp5HT4xYC6
         LEfcTB7+wVhX06aYa+boE2hRSniygczkvWQD2AH01xt23Lk20rMUCDoPZaoEFUJQUf7f
         bNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710109097; x=1710713897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gS5X6onTdeKQ+ZJfx6BgLwsymjvWUS7UTiqeOdmipA=;
        b=YN656nuuRThrKxvh1WupIiDUbX5C3u3pGIj3FLDXEp1IVoT1o5WWNyGsYIpDdN77g6
         RnNhGNiWv+Uuj7WaLN/IxWzqIJ7U3Adt17gkJpWPVdl6GNoFUeyNM8Z+qaQsZz43OMGf
         LacDyq/SzGsAYLO/eU1Tzl3DIUTl47UuINeoCNVKpYCVjsChoV6kMyApIGx4eUIXj91h
         LWwAzpx2VaLo+3V9/BXITIF32AHSjLo77U42NwgOR+zn5OhtTEiTZ8YcE0y2RGuct7Vw
         OTqfY7yYAHzKFzbpkFyTQp0hmvTu6WoJ570QyiKACL3JquumNctsFMKEOKGmNezp3ajH
         /+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnQflsGOo+7ha9iPm/dnCwqiQJ1CycWzeQPnmuf/ZDlSKgbPgPkTWgMXEFwJwah2/fbtM3PLMAF10QtuYJaLLpI9KPmkmsKqS6/9IPu12eoCsS27LAlFHPTRBbUAEj6rGUHq/iCK4IWIE=
X-Gm-Message-State: AOJu0YwFU1LNT/uwlK121La0R/ODa6FV3vNTjLC5lZJE5j2eRxSTb9gB
	QTJPhPf3vupzzwxULr9J7gWABPC5ahkhUFoTPkTGBGtrs2O3s+srxibE8FNa+Cs=
X-Google-Smtp-Source: AGHT+IETq19AUiBmONvKhgCOyeCwL8i7VwzXD4gfhndjiGT6qqFwscF0SlsD7DXFsImou2ixih51SQ==
X-Received: by 2002:a17:906:3087:b0:a45:da91:8d29 with SMTP id 7-20020a170906308700b00a45da918d29mr3063314ejv.2.1710109097140;
        Sun, 10 Mar 2024 15:18:17 -0700 (PDT)
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180::bd5a:12c2])
        by smtp.gmail.com with ESMTPSA id gq14-20020a170906e24e00b00a3d2d81daafsm2282377ejb.172.2024.03.10.15.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 15:18:16 -0700 (PDT)
From: Martino Fontana <tinozzo123@gmail.com>
To: djogorchock@gmail.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martino Fontana <tinozzo123@gmail.com>,
	Ryan McClelland <rymcclel@gmail.com>
Subject: [PATCH v3] HID: nintendo: use ida for LED player id
Date: Sun, 10 Mar 2024 23:12:30 +0100
Message-ID: <20240310221655.83528-2-tinozzo123@gmail.com>
X-Mailer: git-send-email 2.43.1
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
2.43.1


