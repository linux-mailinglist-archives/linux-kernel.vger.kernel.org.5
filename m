Return-Path: <linux-kernel+bounces-124877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49766891D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD58F1F26B94
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189B20402F;
	Fri, 29 Mar 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emw2tZP5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81820127A;
	Fri, 29 Mar 2024 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716331; cv=none; b=oBVBC3ORDHCapB1BqMdqQ9cdpSThy5mrca5qgrDoawhinkqzcebhKYJZqey+T6NE9ECs/ARx6Beowpy9VKQWDEBIzNNkCl6p8YjisGF3EgscPKEURSu0xV1diDbtT9a6Kzk2RN9+bpCq8m5LehM8J4b9ZbfJR5VwVdJ2eOyNdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716331; c=relaxed/simple;
	bh=nySabq+UwrUSB2Ol/o3MjaSe42NQvxH2YsIOw0QD4AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVOeVPR2Zz6/nJSLpTHcPuQNRqeu5C/MMy9iffeLs1vQmww2j8LsfT6LKvEDbovm1mPg/d6mmeQmjuinzrDK3NHIFwNJa/DTwUthHwYsGsXIIDuOq7w3SC/e+fB7vknVKXJb9e7ByBqZA8fopoTkEBGTimteuiFCk3vhuDEHx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emw2tZP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF26C433A6;
	Fri, 29 Mar 2024 12:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716330;
	bh=nySabq+UwrUSB2Ol/o3MjaSe42NQvxH2YsIOw0QD4AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Emw2tZP5Hfh0HpkgJqj0O42eRkic68zAY+WyGme5zSfP2qmErnArQ3drWxhWgZmqy
	 u4s54i8/aXSlF5KHxmSoo1nVP/ERvYDZpmvWlEPtZ/Ib7mUtH2P5Emh+F7PNvkqSCF
	 eCs9MEbO5jgATDbIdSUdCpEei78d81kZv/w6dKNhwaT9vQRechP0/t8MGRikHb6Cn2
	 Tu7O0LzBuXbsSggo8g6dnLz8ehxdOqR79QBH0euRvFikNpqwUr+VsQi+LtsMKuVXnz
	 Wkoa+S0HNXKa5a8ZJihBcqUUM0PevMRmYhn+pr4v98uUW0y0nHUl90Ob6K7dd14dW0
	 D58cuyKVpyi9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	markuss.broks@gmail.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 68/75] Input: imagis - add touch key support
Date: Fri, 29 Mar 2024 08:42:49 -0400
Message-ID: <20240329124330.3089520-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Duje Mihanović <duje.mihanovic@skole.hr>

[ Upstream commit 2d77f70bb7180060072b9c2406d67e4b3872af15 ]

IST3032C (and possibly some other models) has touch keys. Add support
for them to the imagis driver.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
Link: https://lore.kernel.org/r/20240306-b4-imagis-keys-v3-3-2c429afa8420@skole.hr
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/imagis.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index fe65e083fd49b..074dd6c342ecb 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -34,6 +34,7 @@
 #define IST3038C_AREA_MASK		GENMASK(27, 24)
 #define IST3038C_FINGER_COUNT_MASK	GENMASK(15, 12)
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
+#define IST3032C_KEY_STATUS_MASK	GENMASK(20, 16)
 
 struct imagis_properties {
 	unsigned int interrupt_msg_cmd;
@@ -41,6 +42,7 @@ struct imagis_properties {
 	unsigned int whoami_cmd;
 	unsigned int whoami_val;
 	bool protocol_b;
+	bool touch_keys_supported;
 };
 
 struct imagis_ts {
@@ -49,6 +51,8 @@ struct imagis_ts {
 	struct input_dev *input_dev;
 	struct touchscreen_properties prop;
 	struct regulator_bulk_data supplies[2];
+	u32 keycodes[5];
+	int num_keycodes;
 };
 
 static int imagis_i2c_read_reg(struct imagis_ts *ts,
@@ -93,7 +97,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 {
 	struct imagis_ts *ts = dev_id;
 	u32 intr_message, finger_status;
-	unsigned int finger_count, finger_pressed;
+	unsigned int finger_count, finger_pressed, key_pressed;
 	int i;
 	int error;
 
@@ -140,6 +144,12 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 				 FIELD_GET(IST3038C_AREA_MASK, finger_status));
 	}
 
+	key_pressed = FIELD_GET(IST3032C_KEY_STATUS_MASK, intr_message);
+
+	for (int i = 0; i < ts->num_keycodes; i++)
+		input_report_key(ts->input_dev, ts->keycodes[i],
+				 key_pressed & BIT(i));
+
 	input_mt_sync_frame(ts->input_dev);
 	input_sync(ts->input_dev);
 
@@ -225,6 +235,23 @@ static int imagis_init_input_dev(struct imagis_ts *ts)
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
 	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, 16, 0, 0);
+	if (ts->tdata->touch_keys_supported) {
+		ts->num_keycodes = of_property_read_variable_u32_array(
+				ts->client->dev.of_node, "linux,keycodes",
+				ts->keycodes, 0, ARRAY_SIZE(ts->keycodes));
+		if (ts->num_keycodes <= 0) {
+			ts->keycodes[0] = KEY_APPSELECT;
+			ts->keycodes[1] = KEY_BACK;
+			ts->num_keycodes = 2;
+		}
+
+		input_dev->keycodemax = ts->num_keycodes;
+		input_dev->keycodesize = sizeof(ts->keycodes[0]);
+		input_dev->keycode = ts->keycodes;
+	}
+
+	for (int i = 0; i < ts->num_keycodes; i++)
+		input_set_capability(input_dev, EV_KEY, ts->keycodes[i]);
 
 	touchscreen_parse_properties(input_dev, true, &ts->prop);
 	if (!ts->prop.max_x || !ts->prop.max_y) {
@@ -366,6 +393,7 @@ static const struct imagis_properties imagis_3032c_data = {
 	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
 	.whoami_cmd = IST3038C_REG_CHIPID,
 	.whoami_val = IST3032C_WHOAMI,
+	.touch_keys_supported = true,
 };
 
 static const struct imagis_properties imagis_3038b_data = {
-- 
2.43.0


