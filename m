Return-Path: <linux-kernel+bounces-30563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD3E83208F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F741F249FF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D1B321A1;
	Thu, 18 Jan 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+MtcGaf"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040BF32193;
	Thu, 18 Jan 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610626; cv=none; b=XCryTFozCAwErhNAjFSl54gwLCwQINL07JQXpCdwrBJJBenS3p2UZ5UYzy8czWca/fLMKuBwDSkDRKg0Lk4SXFx7nEpFYgVRx1giGn2RULDoajxlhUJV1VCZqdee7v0ab3YTBJlNtkmgd36zPhFRiVG4mV2eAwjJCL/HdLh2A/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610626; c=relaxed/simple;
	bh=R06cQdi4MNgbIu422h++0jlD99NL6HlGgH6a1VBS/Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ee/tWd5OCOX+hArxP2vQk/dAlj76DxyGA2WWW4c0+7Dc9hAV6j0nydwH1viX1Aicnstje6ljYIXXmPkePxcrXOFxClLsl0oLXIWws/MBd750GbznwfLRVUv08mwMOrc2mptX0fVnmYCJKuNlrDLlM9dPK9bun7aNTWANEpuFqDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+MtcGaf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3379e942685so5266f8f.0;
        Thu, 18 Jan 2024 12:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705610623; x=1706215423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uiSxlbKBjhgqtlbTNin6t3C+/oKvkiypv2RdUBSMVWY=;
        b=e+MtcGafDwO/xllcO26hXzCrMIzfPsiaG0YQSkqct9WvEMtZbZoq9RywQzADSLI7nR
         6s+R3dJF2AesY/y0TKbrrm8KC18Q3U0yfbwjdZIA53OT5yelBL0BwCSztT9g53sxFpoO
         D83S9XNal7ETErr6uVgAr4lYTcWnt06YbljYW+lwR81Bkt/AMo7QlMjJ1TbkHiIbU+cL
         4dgUq3Thoc3LZ7iCMvSlyyZxbte6I4Lck8LbnOd4CLSFJeKdHpdINhlU73PC5b7Rvt8C
         rGdoB0n5gRTEHZZAymxecEozoxmlUG41D+MHKOjPyGV5wdRVotUM6muE+ZRZP2svEPOx
         w0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610623; x=1706215423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiSxlbKBjhgqtlbTNin6t3C+/oKvkiypv2RdUBSMVWY=;
        b=wF7UcFTIj/ZgoLUyAM38J+WLYgyYvYUC4EskfxIRl7+GFU8cOcIXNLDoLfo9Lf2d4c
         NgHmvu527XU2Sa1Gr8cOe33cbdq/jYWB0BiMkWYYihiMLHB4NR5d+6dyGDTMk0eXhiYF
         Ff//6hEzfOKk6Mf1ePW/q3JviFwXOMojZaveUofWNS4Oj9NSd6NrzBgq9RKJUsSNNHVr
         7Tv8oK+nxHL2pfdWGATVaU3thgkc1e+DZcF8sw+73Dck3tSrkWvA9AE0qB95KBOF6PHT
         qgkusYjSi8e/PkFWjaTyAQSosO22UuWBSTitHlRyN0kttnjkYESNqb6vur8FksvtUeDd
         kgSQ==
X-Gm-Message-State: AOJu0YxyaWxfiFOn9ZQU1DiB2pZraHO3xQd6/iN+ov3xvMcJAveE3H88
	0hHuTHKqGSs9AZMPJiK+iAbza1wsO3gCKSs3pCSQAKQ/bkOyzesY
X-Google-Smtp-Source: AGHT+IEUyom4MGuWcRz66WV0lIcVR2TV8yFNeBnaSaTRsj2AiRY+WxjgR7r10CAeyxuuHw6IOU0zGg==
X-Received: by 2002:adf:fd51:0:b0:337:3904:9a2b with SMTP id h17-20020adffd51000000b0033739049a2bmr353670wrs.0.1705610622980;
        Thu, 18 Jan 2024 12:43:42 -0800 (PST)
Received: from desktop-nixos-martino.. ([2a01:e11:5004:180::bd5a:12c2])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b0040e4ca7fcb4sm26900115wms.37.2024.01.18.12.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 12:43:42 -0800 (PST)
From: Martino Fontana <tinozzo123@gmail.com>
To: djogorchock@gmail.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Martino Fontana <tinozzo123@gmail.com>,
	Ryan McClelland <rymcclel@gmail.com>
Subject: [PATCH v2] HID: nintendo: use ida for LED player id
Date: Thu, 18 Jan 2024 21:35:40 +0100
Message-ID: <20240118204057.17776-4-tinozzo123@gmail.com>
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


