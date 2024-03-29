Return-Path: <linux-kernel+bounces-124787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF20891C81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F85C1F21080
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D133188A7B;
	Fri, 29 Mar 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeFtYHvx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04587188A94;
	Fri, 29 Mar 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716141; cv=none; b=KxagoDEmc+q6z1UIn5Le9KaIH8BnS0CmjJ1uEF3crudu2FOauzDXhcQBjy2N9/mExRoD6ysQlbw+y1bqsCKa/+Fk+R/xIN7uhKdZDF5MvU1BE7DSsbt+ZlZwKcIovIpS5IF/7G+L0oPjp8BYvC3c0jXRMrmcwULzuvdcvQEc1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716141; c=relaxed/simple;
	bh=DDAHmHLVYwUSJ0kNAPqiwPFaGOmoZ0D2WTfjUM8BPRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7F58NQzcDwjHZ5blvx4eDIQaVgcXDp0t4ZwMtmyynKnTpEeoGcEkXjsZhW6n59fBXjZfcgLPqn2csgQJLDAl871Yz7zsJGfISU/9iZJ8r5eIpu4kV8KqClMUnYdryrcd6vRZDbXVTNSLsgtuMCqvzM5RyHG6eAfQXMfAaN/IGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeFtYHvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16713C43390;
	Fri, 29 Mar 2024 12:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716140;
	bh=DDAHmHLVYwUSJ0kNAPqiwPFaGOmoZ0D2WTfjUM8BPRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeFtYHvx1VraOo+3YROPr56RBoiWKUI7jTrVKX2bX94RDSlbYJWsCzlsi9v/TGWzi
	 rVXmorpxykgqRPG5Mos4Yazmsb6nmQi3G3ldlrwNuUU8YyASlALG0X1hGjgYOCnhte
	 yhIwed6bQhExS3jIHp9sMJ/G0KMRQD6lhjolsKQwFFA2JaZ9lS1sFVTRfMDrehLTft
	 qzPxM6sCWrn02PHlEk4mytGvvx2tDT/BtbHe0sFhvR13IiSvtCWj2idU5wqNfyMbMi
	 qd4czvmKLllj5V9hlnz3efbqDSVQzRIiW5YN8kkf2NU1JDYmGSz4SA+/dePQVgXbq3
	 JPHLWCJOJt1Pg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markuss Broks <markuss.broks@gmail.com>,
	Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 77/98] input/touchscreen: imagis: Add support for Imagis IST3038B
Date: Fri, 29 Mar 2024 08:37:48 -0400
Message-ID: <20240329123919.3087149-77-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Markuss Broks <markuss.broks@gmail.com>

[ Upstream commit 10ad7d7a428f7bb336c3cb226ab8aa0e6a947dac ]

Imagis IST3038B is another variant of Imagis IST3038 IC, which has
a different register interface from IST3038C (possibly firmware defined).
This should also work for IST3044B (though untested), however other
variants using this interface/protocol(IST3026, IST3032, IST3026B,
IST3032B) have a different format for coordinates, and they'd need
additional effort to be supported by this driver.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
Link: https://lore.kernel.org/r/20240301164659.13240-4-karelb@gimli.ms.mff.cuni.cz
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/imagis.c | 58 ++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index e67fd30110278..9af8a6332ae67 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -11,9 +11,13 @@
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
+#define IST3038B_REG_STATUS		0x20
+#define IST3038B_REG_CHIPID		0x30
+#define IST3038B_WHOAMI			0x30380b
+
 #define IST3038C_HIB_ACCESS		(0x800B << 16)
 #define IST3038C_DIRECT_ACCESS		BIT(31)
-#define IST3038C_REG_CHIPID		0x40001000
+#define IST3038C_REG_CHIPID		(0x40001000 | IST3038C_DIRECT_ACCESS)
 #define IST3038C_REG_HIB_BASE		0x30000100
 #define IST3038C_REG_TOUCH_STATUS	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS)
 #define IST3038C_REG_TOUCH_COORD	(IST3038C_REG_HIB_BASE | IST3038C_HIB_ACCESS | 0x8)
@@ -31,8 +35,17 @@
 #define IST3038C_FINGER_COUNT_SHIFT	12
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
 
+struct imagis_properties {
+	unsigned int interrupt_msg_cmd;
+	unsigned int touch_coord_cmd;
+	unsigned int whoami_cmd;
+	unsigned int whoami_val;
+	bool protocol_b;
+};
+
 struct imagis_ts {
 	struct i2c_client *client;
+	const struct imagis_properties *tdata;
 	struct input_dev *input_dev;
 	struct touchscreen_properties prop;
 	struct regulator_bulk_data supplies[2];
@@ -84,8 +97,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 	int i;
 	int error;
 
-	error = imagis_i2c_read_reg(ts, IST3038C_REG_INTR_MESSAGE,
-				    &intr_message);
+	error = imagis_i2c_read_reg(ts, ts->tdata->interrupt_msg_cmd, &intr_message);
 	if (error) {
 		dev_err(&ts->client->dev,
 			"failed to read the interrupt message: %d\n", error);
@@ -104,9 +116,13 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 	finger_pressed = intr_message & IST3038C_FINGER_STATUS_MASK;
 
 	for (i = 0; i < finger_count; i++) {
-		error = imagis_i2c_read_reg(ts,
-					    IST3038C_REG_TOUCH_COORD + (i * 4),
-					    &finger_status);
+		if (ts->tdata->protocol_b)
+			error = imagis_i2c_read_reg(ts,
+						    ts->tdata->touch_coord_cmd, &finger_status);
+		else
+			error = imagis_i2c_read_reg(ts,
+						    ts->tdata->touch_coord_cmd + (i * 4),
+						    &finger_status);
 		if (error) {
 			dev_err(&ts->client->dev,
 				"failed to read coordinates for finger %d: %d\n",
@@ -261,6 +277,12 @@ static int imagis_probe(struct i2c_client *i2c)
 
 	ts->client = i2c;
 
+	ts->tdata = device_get_match_data(dev);
+	if (!ts->tdata) {
+		dev_err(dev, "missing chip data\n");
+		return -EINVAL;
+	}
+
 	error = imagis_init_regulators(ts);
 	if (error) {
 		dev_err(dev, "regulator init error: %d\n", error);
@@ -279,15 +301,13 @@ static int imagis_probe(struct i2c_client *i2c)
 		return error;
 	}
 
-	error = imagis_i2c_read_reg(ts,
-			IST3038C_REG_CHIPID | IST3038C_DIRECT_ACCESS,
-			&chip_id);
+	error = imagis_i2c_read_reg(ts, ts->tdata->whoami_cmd, &chip_id);
 	if (error) {
 		dev_err(dev, "chip ID read failure: %d\n", error);
 		return error;
 	}
 
-	if (chip_id != IST3038C_WHOAMI) {
+	if (chip_id != ts->tdata->whoami_val) {
 		dev_err(dev, "unknown chip ID: 0x%x\n", chip_id);
 		return -EINVAL;
 	}
@@ -343,9 +363,25 @@ static int imagis_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
 
+static const struct imagis_properties imagis_3038b_data = {
+	.interrupt_msg_cmd = IST3038B_REG_STATUS,
+	.touch_coord_cmd = IST3038B_REG_STATUS,
+	.whoami_cmd = IST3038B_REG_CHIPID,
+	.whoami_val = IST3038B_WHOAMI,
+	.protocol_b = true,
+};
+
+static const struct imagis_properties imagis_3038c_data = {
+	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
+	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
+	.whoami_cmd = IST3038C_REG_CHIPID,
+	.whoami_val = IST3038C_WHOAMI,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id imagis_of_match[] = {
-	{ .compatible = "imagis,ist3038c", },
+	{ .compatible = "imagis,ist3038b", .data = &imagis_3038b_data },
+	{ .compatible = "imagis,ist3038c", .data = &imagis_3038c_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imagis_of_match);
-- 
2.43.0


