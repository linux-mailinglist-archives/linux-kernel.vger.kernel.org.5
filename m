Return-Path: <linux-kernel+bounces-98285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BAB8777DF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B761C281B44
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F839AC9;
	Sun, 10 Mar 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEo6HF+6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3458121115;
	Sun, 10 Mar 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710093884; cv=none; b=fTbfKAAHyYjhWGceb9B8g4n4qJKZzgx/DdUdEiywfzLksVxdrIZKapjRadxLCUsQJpJpjEm48+UWTjLo1bGyE2hQtPKFJj11jHRAJai/24CU8RCaUkSl1SbCm1Cv2F+HtpzdiTZngV+KYW4+Wc4NeDohlGfqfbqsZaAGzwRdXKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710093884; c=relaxed/simple;
	bh=fV5YTCkM2Qgs1Gvd3HP80W70n2zL1tizithA6j4sDkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WcAGJkAH6RBPoVb2cYpZgZQOhpwPAOVXK9htQoXm3i4In9PE5wZ9Vou2fZvmttD/wcrXfQVYRn8xeKe5rJWXHjSUXSEobDnKuN9O9lHiTEXPjK2BdejnE4BfaQvUJB9a0tbvDIdfjgwPjy5QiWztroH9jseW2R4ld4iy10N7DQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEo6HF+6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4605ff6c0dso50201566b.1;
        Sun, 10 Mar 2024 11:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710093881; x=1710698681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IjAFSTMXb9qClnLSQddLYlevCEevCWio8ObZ+ZIIo7k=;
        b=BEo6HF+6T4msFqaNnF3kjqthIaAJTNxt8LQgfW0IeJhsTjuIsXa2TB9K4AfMQeR5L+
         5+bBxd+JQoQizWbqaNmRek6NLReJ31XNnvgyA5IRYzYYl6MxZqBScb5/8nytS5EMSGa6
         Sby3uuBqNQzwpafYvNIZytqcdhTostep2HN8S2507XbJqZOkbwFe6MPQdD+AinQm+u0s
         /oSoND7q1ZaI3Sl4DAUgccsjmbonEwLIfA63PqHgPEK0JYaGdGBaJU43zP29czJsNeT8
         WBbX/Z3jyCQg3qQDsP7uDZrlC/GCz3mYkDCFgPgUCc6M0wPkGsnJZRWvUbDQI3p5vHMk
         an5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710093881; x=1710698681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjAFSTMXb9qClnLSQddLYlevCEevCWio8ObZ+ZIIo7k=;
        b=ZcjuewUN1LPboVDYXpseXk4my9un/TduaboNUK7pfmebS5N4C3Okk8iehcQCf8TgiM
         EQ3pxl+R2jX8+R9KoAu/u3FvjbZJ484bBykuf1ubidGiYmxzeQhF2iq4j9V8P29im/zx
         TxUqHnkWVxgJO4GugJdBy/sOgGWkcLTAuqPXsHXjE8S75eCquj8b7PFrNYLaQhGEIgTi
         UYV9RsjIdMI1m128RSF8muxBY8oArBSifR5j+X2qLI9eyyLUJxubrC845loMk573cLaH
         ywCogzPQPdmq5n8bd5NLg9z1PPkgASMNxgkMyzyNiXSsMhlsXQocIvU0eDq30x+GA6RN
         35pw==
X-Forwarded-Encrypted: i=1; AJvYcCXDOP+0p0AqCnHQbzKsHNXHf1lK7BSE58GFXWJJsmly9Z2mLCYEA5HoR2DaNh40ah/XibaYTyqcfM7g+/9M98UQwqA7fa6+bovLp3DVl3seJq9Opi/quGWN0dJRnZJrXGWAzMSowtrgZe8=
X-Gm-Message-State: AOJu0YyHW3siW8QU9ERU0LF3XGn+ORmn0V7dzFucxcoaGmONRrhnKLX9
	4+Z9Bbog75mJ7qJZ8A/w184s5Cqq6lqv5BFWLqU5XBtEctA704bv
X-Google-Smtp-Source: AGHT+IG4QPMN4VvnyBTUkFcyRBV9mgbCH/Lilj0rLNBLyxkGCfg6HZHL6F84ImJx6NEiPfRtdb1izQ==
X-Received: by 2002:a05:6402:370e:b0:568:4b7b:acd2 with SMTP id ek14-20020a056402370e00b005684b7bacd2mr1861927edb.0.1710093881182;
        Sun, 10 Mar 2024 11:04:41 -0700 (PDT)
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180::bd5a:12c2])
        by smtp.gmail.com with ESMTPSA id fd15-20020a056402388f00b00568601d3a7bsm22096edb.53.2024.03.10.11.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:04:40 -0700 (PDT)
From: Martino Fontana <tinozzo123@gmail.com>
To: djogorchock@gmail.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martino Fontana <tinozzo123@gmail.com>,
	Ryan McClelland <rymcclel@gmail.com>
Subject: [PATCH v2] HID: nintendo: use ida for LED player id
Date: Sun, 10 Mar 2024 19:01:53 +0100
Message-ID: <20240310180322.25508-2-tinozzo123@gmail.com>
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

 drivers/hid/hid-nintendo.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index ccc4032fb2b0..6ab4c2ec4a5d 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -34,6 +34,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/hid.h>
+#include <linux/idr.h>
 #include <linux/input.h>
 #include <linux/jiffies.h>
 #include <linux/leds.h>
@@ -569,6 +570,7 @@ static const enum led_brightness joycon_player_led_patterns[JC_NUM_LED_PATTERNS]
 struct joycon_ctlr {
 	struct hid_device *hdev;
 	struct input_dev *input;
+	u32 player_id;
 	struct led_classdev leds[JC_NUM_LEDS]; /* player leds */
 	struct led_classdev home_led;
 	enum joycon_ctlr_state ctlr_state;
@@ -2283,7 +2285,8 @@ static int joycon_home_led_brightness_set(struct led_classdev *led,
 	return ret;
 }
 
-static DEFINE_SPINLOCK(joycon_input_num_spinlock);
+static DEFINE_IDA(nintendo_player_id_allocator);
+
 static int joycon_leds_create(struct joycon_ctlr *ctlr)
 {
 	struct hid_device *hdev = ctlr->hdev;
@@ -2294,20 +2297,19 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
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
@@ -2789,6 +2791,7 @@ static void nintendo_hid_remove(struct hid_device *hdev)
 	spin_unlock_irqrestore(&ctlr->lock, flags);
 
 	destroy_workqueue(ctlr->rumble_queue);
+	ida_free(&nintendo_player_id_allocator, ctlr->player_id);
 
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
-- 
2.43.1


