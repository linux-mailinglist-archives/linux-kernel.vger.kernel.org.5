Return-Path: <linux-kernel+bounces-128371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EFF895A08
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4FEB24805
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E40915AD8F;
	Tue,  2 Apr 2024 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3XvdOyd"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C515AAC9;
	Tue,  2 Apr 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076380; cv=none; b=I2FJGurDiGdxTU6QVg6wmuL/+FZdX/HAUSKqdIBf9v05nXNA0mI/Qmv3JJyluhImOjEwJ0kM9qdD70MQfvgLWst/o9JUMGOxJQrcazDYHg4H0O4ZQloypKDxjHeb3KOfef3Hx+474pqhn05AZG5AHB6sRtQ1kedItayoZh/QaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076380; c=relaxed/simple;
	bh=p9Dddd2V1n+rmD1qDYTdwmyLSKw+UqqIeEou+gt2b/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoYwP3Pe3wAakQ1kQdxhWsIea5ZxJ3KL1P6aSp6sq3SvTvYD2KCbdtiHWCW4TYl4lG2RrHu3a2abnaC9cUUO6bkDU1+HWZfgL9yHCFUsMcz/vr0sdtWSBZU0ckqmyNKjVUcbCOd2FNWhDN5WaqyKmjOI3kn9JXRkFKzbdLv4QLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3XvdOyd; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6eedf3e99so316321fa.1;
        Tue, 02 Apr 2024 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076376; x=1712681176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngAa270WUPsZp48uTGGMM7fPG1prY3FiJDKrNebGRfg=;
        b=O3XvdOydtvYGqNhDEmJTqUD4c4fGIW9TfrU2UEYy5eJMrQpVRE2X7RmGue1ch4hUHK
         uiH6cFY77XpBvWpgIfhTHY5IPWbHU5LrrrP8JJfghZLvQV7Gzaz093pJx5bpp8gKCjr8
         GLWfG4OYxJZxKtOwNPQZChnVHPQyIo6IqTDVdJEYMpBatTvu6XP1xq+L0tBiu3yehKnH
         ZX3i4c+gUVOEPH08p8o4iMeTZdQ6Q5svkzJLLE0SlQ2W0TYPwEFntHchoerK6wo5gclT
         ei8iGkc41eqK5V0sd+gdqNMDNg+W7oePvQMa8BUAtNDhxx/uvQfXYpjDY9eK24lgly1H
         MxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076376; x=1712681176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngAa270WUPsZp48uTGGMM7fPG1prY3FiJDKrNebGRfg=;
        b=uiVuVkF6fRDCvEXa7bpiFB1TOABedDto5tAIoKRUrNPibKAfuT4AEZ7yH0mJVYrElu
         LVLhaUQnfuDQs1s/w1ym8CTKwHR71v5dfE1GHBF2Uj3gVG4vR3kd7dZFqwEb+LCGdv4t
         WhzwmVFJvr0YhI1zCQzBoG9Hv2gaznvSjmRP8qegnT3UHwaB4VKPlkhqzhJ5m1nehzC0
         9LS3s0aoYkqv4V2pCa6Tgep+958mBbMJhvkP8upqpj4VBQ7QE2LaXYqVkRAMC3oULCKe
         bOo2ST5fN+Ov4SCdUII7YdHRb1ccm6x7YYQOm4xJooINowoxfI+GipDwA3KwVBS6ql1n
         mf4w==
X-Forwarded-Encrypted: i=1; AJvYcCWsbw7o7dr6EsaH6qU3Jyx950WeJXoDkzzqr4qTLg4ICMMOM5Bwnfb3OUqGkaa8Heujf+bSPaFg1/d1ERUNQUlmAih7l9fHOdwfRUAI
X-Gm-Message-State: AOJu0YyOPMwClyDmCw9FmgptyEyN5k1z5u82netq0OEbabdwB4icutT/
	YyxtwsaP+4ShFhswsQKOgp7Vxoo8VaxPJYtWVNfGS2N4q7IjZ5Kg5Ay0dMIONcPiRA==
X-Google-Smtp-Source: AGHT+IEeldKMunA/Y2xY4aktPwfyalDim0v7bNvFrnQC0AyHnPn+I8CDmrZbVBr8+Bs83UFD/VXw2A==
X-Received: by 2002:a2e:b8d4:0:b0:2d5:9d0c:9590 with SMTP id s20-20020a2eb8d4000000b002d59d0c9590mr11630ljp.19.1712076376062;
        Tue, 02 Apr 2024 09:46:16 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id h6-20020a2e9ec6000000b002d6bd3b6bcbsm1713013ljk.33.2024.04.02.09.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:15 -0700 (PDT)
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
Subject: [PATCH v4 05/20] media: i2c: ov4689: Remove i2c_client from ov4689 struct
Date: Tue,  2 Apr 2024 19:45:36 +0300
Message-ID: <20240402164552.19171-6-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
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
index d31659139a6e..56bf1d964e43 100644
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


