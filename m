Return-Path: <linux-kernel+bounces-147706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A878A77FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B295B22E46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422C213BC2D;
	Tue, 16 Apr 2024 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA5ivX/7"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B8D13AD2A;
	Tue, 16 Apr 2024 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307540; cv=none; b=nLNwyAgMzr/nJtBPD/CWlcV2LLvViVxIx/mYwi0mOi99FFkBNMioPZHFwpvacSjgfxlD+j/R6gZKoo8vZDOBr9UGu6CK+wY6K8qgd1MpQQBH1O/p+zDzF4JJJplnfptgyAwbt7s3H6uIUhC0YIhRz/7Lm9V78uNWAoaFkf2uqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307540; c=relaxed/simple;
	bh=Az1qPONXhvU7zLA+l9wbEw7Pq7A1FrFAxWKB/xjwA4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7rRkM7UAFRctpv9Rrulfa0GdzH9+iLPdEVnvY7fG0Kwtps5VA79SePyc1RFboq6/XqTwwHgv92S9frOiW4RHSM/X7xB33tXUBNOwwNr807I+fuoynh1QrDcR6PgHTuKA6NyRe+HZZqljHvI5UZyKikELWtXXKtJyEgFgmUj990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA5ivX/7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d2600569so6339396e87.0;
        Tue, 16 Apr 2024 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307536; x=1713912336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjf5sKRPFKmqZtF9xerWNP7YPIPFDcYHmMoKl8ei6RA=;
        b=FA5ivX/7jagiPlAlz4pA6dueDknXHsfw8SAxWfchESY5RbO3hR381G7feVYMPUwHed
         Gazc/5fRk/6CFD3YQRTo5fmNkKvyqF+2KnXKBKquVuuS0fwfCMpLArRN1wSfGLzs5nVW
         s2dWZggzN7C7Km2AhetyCKa7nT8ikq9L091+YXcol5khG0FMmRplaVEdMwdNImYW2ego
         4v/2UnAHzFJ/ReOBzb1+jF10s6/gizJHNJ1XykCs73IAIjVv/Mlp4gBNzi+sols7jCUc
         Hy+AGgOuU3F1WWx3Y7OLN1ptErXJLs/NpuSmqas6srTLiiShukOZ5WFVDTbYx0KXC/im
         0IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307536; x=1713912336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjf5sKRPFKmqZtF9xerWNP7YPIPFDcYHmMoKl8ei6RA=;
        b=ieXcIGe1XAwXWyqfKorHFuHUbdqsEKLOz7393MWgpnVCn3z0st+oWSEgTmY+X+J6os
         xl0ZV1kNcE0pMUnkIZnlKp+BwCnB0f//Pf7Kp04H4CRKXfYyiLAm1eRV+/XwNENzt3Gc
         V5a6F3Hslg7xfvo9c+nirD8tcYENim/Q6VOxoG03MHnH56+cbKtIq3bv6tRGPRXIamWZ
         Abr4ludBcAl8qC7Mxjf00TxF8LBEchPoctH3Qy/CzPlj/CGYZdVfaum+OFCVe2g7xT6A
         twsarTzbIXaB9IQ7KQ9paIUN9xs9xEaUAssV5DvutTQypJC1OaGW7x5wU1urQgiWgn8I
         ozZA==
X-Forwarded-Encrypted: i=1; AJvYcCXvUeQ0ioBa6MSa8+ynIxGsw3k/1U/LHZMF823qLSbwayYhxinh5OaLYTyn2Ob5KYT9ks1pzwB9ti6xg2zQ+B9hmaBpvSE9Kmlu+e8J
X-Gm-Message-State: AOJu0Yz1g2KIG0q2XHcdqcZYYzWwQhOMLwMZFev7p2fyICap21+iKLXZ
	XiDbjmu+dKCBaKJK2O7JYzQo635yZYbER5VCviGQxQM12p+5si+4+KplPvtpyAI=
X-Google-Smtp-Source: AGHT+IGdCCbPYmi32d5FO1fSAsqP6VWKrzXnj0yw6bAy07Ja4NdpC0ERwjRUVuH/7HWulrLwj+lRrg==
X-Received: by 2002:a19:6441:0:b0:516:582:2348 with SMTP id b1-20020a196441000000b0051605822348mr9532300lfj.54.1713307535911;
        Tue, 16 Apr 2024 15:45:35 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id g22-20020a19ee16000000b00518e9495a30sm748394lfb.97.2024.04.16.15.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:35 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v5 05/16] media: i2c: ov4689: Remove i2c_client from ov4689 struct
Date: Wed, 17 Apr 2024 01:45:13 +0300
Message-ID: <20240416224524.1511357-6-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416224524.1511357-1-mike.rudenko@gmail.com>
References: <20240416224524.1511357-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'client' field within the 'ov4689' structure is solely used to
access its 'dev' member. This commit removes the 'client' field and
directly stores a pointer to the 'struct device'.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 06a3e02b5c80..a3fb6498753f 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -74,7 +74,7 @@ struct ov4689_mode {
 };
 
 struct ov4689 {
-	struct i2c_client *client;
+	struct device *dev;
 	struct regmap *regmap;
 	struct clk *xvclk;
 	struct gpio_desc *reset_gpio;
@@ -405,13 +405,13 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 {
 	struct ov4689 *ov4689 = to_ov4689(sd);
-	struct i2c_client *client = ov4689->client;
+	struct device *dev = ov4689->dev;
 	int ret = 0;
 
 	mutex_lock(&ov4689->mutex);
 
 	if (on) {
-		ret = pm_runtime_resume_and_get(&client->dev);
+		ret = pm_runtime_resume_and_get(dev);
 		if (ret < 0)
 			goto unlock_and_return;
 
@@ -420,26 +420,26 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 					  ov4689->cur_mode->num_regs,
 					  NULL);
 		if (ret) {
-			pm_runtime_put(&client->dev);
+			pm_runtime_put(dev);
 			goto unlock_and_return;
 		}
 
 		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
 		if (ret) {
-			pm_runtime_put(&client->dev);
+			pm_runtime_put(dev);
 			goto unlock_and_return;
 		}
 
 		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 				OV4689_MODE_STREAMING, NULL);
 		if (ret) {
-			pm_runtime_put(&client->dev);
+			pm_runtime_put(dev);
 			goto unlock_and_return;
 		}
 	} else {
 		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 			  OV4689_MODE_SW_STANDBY, NULL);
-		pm_runtime_put(&client->dev);
+		pm_runtime_put(dev);
 	}
 
 unlock_and_return:
@@ -553,7 +553,6 @@ static const struct v4l2_subdev_ops ov4689_subdev_ops = {
  */
 static int ov4689_map_gain(struct ov4689 *ov4689, int logical_gain, int *result)
 {
-	const struct device *dev = &ov4689->client->dev;
 	const struct ov4689_gain_range *range;
 	unsigned int n;
 
@@ -564,7 +563,8 @@ static int ov4689_map_gain(struct ov4689 *ov4689, int logical_gain, int *result)
 	}
 
 	if (n == ARRAY_SIZE(ov4689_gain_ranges)) {
-		dev_warn_ratelimited(dev, "no mapping found for gain %d\n",
+		dev_warn_ratelimited(ov4689->dev,
+				     "no mapping found for gain %d\n",
 				     logical_gain);
 		return -EINVAL;
 	}
@@ -580,7 +580,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct ov4689 *ov4689 =
 		container_of(ctrl->handler, struct ov4689, ctrl_handler);
-	struct i2c_client *client = ov4689->client;
+	struct device *dev = ov4689->dev;
 	int sensor_gain;
 	s64 max_expo;
 	int ret;
@@ -597,7 +597,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	}
 
-	if (!pm_runtime_get_if_in_use(&client->dev))
+	if (!pm_runtime_get_if_in_use(dev))
 		return 0;
 
 	switch (ctrl->id) {
@@ -618,13 +618,13 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
 		break;
 	default:
-		dev_warn(&client->dev, "%s Unhandled id:0x%x, val:0x%x\n",
+		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
 		ret = -EINVAL;
 		break;
 	}
 
-	pm_runtime_put(&client->dev);
+	pm_runtime_put(dev);
 
 	return ret;
 }
@@ -689,8 +689,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	if (handler->error) {
 		ret = handler->error;
-		dev_err(&ov4689->client->dev, "Failed to init controls(%d)\n",
-			ret);
+		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
 		goto err_free_handler;
 	}
 
@@ -716,7 +715,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 static int ov4689_check_sensor_id(struct ov4689 *ov4689,
 				  struct i2c_client *client)
 {
-	struct device *dev = &ov4689->client->dev;
+	struct device *dev = ov4689->dev;
 	u64 id = 0;
 	int ret;
 
@@ -744,7 +743,7 @@ static int ov4689_configure_regulators(struct ov4689 *ov4689)
 	for (i = 0; i < ARRAY_SIZE(ov4689_supply_names); i++)
 		ov4689->supplies[i].supply = ov4689_supply_names[i];
 
-	return devm_regulator_bulk_get(&ov4689->client->dev,
+	return devm_regulator_bulk_get(ov4689->dev,
 				       ARRAY_SIZE(ov4689_supply_names),
 				       ov4689->supplies);
 }
@@ -813,7 +812,8 @@ static int ov4689_probe(struct i2c_client *client)
 	if (!ov4689)
 		return -ENOMEM;
 
-	ov4689->client = client;
+	ov4689->dev = dev;
+
 	ov4689->cur_mode = &supported_modes[OV4689_MODE_2688_1520];
 
 	ov4689->xvclk = devm_clk_get_optional(dev, NULL);
-- 
2.44.0


