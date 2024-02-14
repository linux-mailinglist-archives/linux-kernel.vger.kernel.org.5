Return-Path: <linux-kernel+bounces-65016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1708546BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88490B21F71
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA59168D7;
	Wed, 14 Feb 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdi53vxe"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7112B69;
	Wed, 14 Feb 2024 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904846; cv=none; b=gDE9wYgWwEOjOgwpZdWVHZusIHo5rNyyO9BW2X1MvEHRETk4K5sT10IUd5HGYS/S8ffk8/0RD2FY3wfHTmTBPrtbRptmT0u5IuSwg/1wY6o/f/P5BYpjJRkrT0siVhtsOE8mmP5WVrmbi3JflCKZ1oc0nfHEy2n8BwKo9Bz9/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904846; c=relaxed/simple;
	bh=R06cQdi4MNgbIu422h++0jlD99NL6HlGgH6a1VBS/Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wzv6FsH1Vtigj9wnrzgKExJ7+LE4B0R4BxJDAKfjpjERL8/szo8qzouzQZ8i1IEnyuQnh+JuLRB+8TWtpZ9lkrcueIMcoTsBy0iTmJBZiZv9ZLIuDpffsOgt5FduwvOIh0Lv1eOuDy2NAg/mk2lxgmTuVrGdSP7++ClxSb38gNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pdi53vxe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3cedc4acd3so57679366b.1;
        Wed, 14 Feb 2024 02:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707904843; x=1708509643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uiSxlbKBjhgqtlbTNin6t3C+/oKvkiypv2RdUBSMVWY=;
        b=Pdi53vxeBuqBb5iiNrbUSmawHuTNPBTZ64IkGyv3Q6EJX5ovvBExliZoEAO74rHC6R
         +7egnV/wS5b1VNj+uRuO6Jcio2T1vcped3qulqyRBmDkYiUQ/SjMGWme7QXk5rvWGuUF
         U9Qz2XkIFEdrB8eZFRzdhsuWBGN745UEDwp6EMnI0rZQ+Jv5e08U+7gDKjiiKvS0CgDW
         lGqxw3YzKXLTI/sXqdBkOqkT3jVCsmTksDw0c8toOHN9aV+dH/ns0C/fz7ZmAmFfSYeP
         hOkEJc1e1i74zQBb12xUVUjIejgkRfGtaW4G5mibJdPbm4t8DDcrBN+BAlDkMMxYhYMV
         wAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707904843; x=1708509643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiSxlbKBjhgqtlbTNin6t3C+/oKvkiypv2RdUBSMVWY=;
        b=o/Z9aMuRYi8DgUWdqSV28o9TdTxgNvGw+DT1+pNOBVq+6ZIbJUJVNLjV7o2joq5Y1u
         dlUquA/jQyq2VCINT6iivU80RES4XE8+5XYo9a1VoXFlvaPG8EraK9AVtHMNajPVkpVq
         7Rv+iElDCzBP89AAxo8oaB3l4obj2oVxNalcIRfOuiDmt0Mkh6F9JfYIBotKFNeqI2Oi
         FjdIG2siR5WUmHzjPPOuNiemvZFY/ApCvk8XRRXHV9U9IFAZaycvVZqXyAYJdVAwtl/i
         b715Lt2vv4j/WtUhaIZS3BADSwf0uaxLUMFEjl4Ii2L7Nas4yDXNvkXtLEVKqptd0l37
         dV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwkaMQDZSLJc1oYq2CsiU6nNwnZSTky6nztkHNWvliNLUs6ymJtuAH28ZgNyUhBz9KnsMbQl6OWPoZOiPX/YI4IQ1/7IDa9BGurkaleC5XCT8YazffX2+rfCtGqRi5+B+SalGaYZEpHKQ=
X-Gm-Message-State: AOJu0YyTHAeeG84NRQ+WKu3dRO41lrcPZdVzLLiibuuRpLf9gtqvqArS
	hPD5rSwzgMOM6KrUI0XKdG46hUcmhBO6CEacb2ocuRg+LnOj01bA
X-Google-Smtp-Source: AGHT+IENcqpoxV5hNe7FBZSRoN2dpxq1P7sBzqb+6iw2m9XhFdO/Va94p/133+7MsvxX5aqG7pD9Cg==
X-Received: by 2002:a17:907:a809:b0:a3b:b390:22dd with SMTP id vo9-20020a170907a80900b00a3bb39022ddmr1840833ejc.2.1707904842432;
        Wed, 14 Feb 2024 02:00:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz4v97B5kS9ULaL9vTQkeIFJIXFdka6+v4Y+d3NOrj9xsRe2vE0W9Xx4i+r2AULs2zhPC/3sBS7DyHJ71Apl/rZSNvdm3iiVExbHjmnEUiHHzXRUATmwz6T/VHHNVxNtfIAi/r7P0SU9yhdvyZKJjogr6HbHZAFNaz/wZzfVFpArUAFW1q+VNYu/7ep11yGx/V3xTbT5WrPCjA4sJytMt08o2hZvxmFNWGB1Q2Mig=
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180::bd5a:12c2])
        by smtp.gmail.com with ESMTPSA id vu6-20020a170907a64600b00a3d19aed4cesm1134133ejc.21.2024.02.14.02.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 02:00:41 -0800 (PST)
From: Martino Fontana <tinozzo123@gmail.com>
To: djogorchock@gmail.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martino Fontana <tinozzo123@gmail.com>,
	Ryan McClelland <rymcclel@gmail.com>
Subject: [PATCH v2 RESEND] HID: nintendo: use ida for LED player id
Date: Wed, 14 Feb 2024 10:55:52 +0100
Message-ID: <20240214095653.9374-2-tinozzo123@gmail.com>
X-Mailer: git-send-email 2.43.0
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
2.43.0


