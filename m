Return-Path: <linux-kernel+bounces-4190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2229C8178F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B962857A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935C77409F;
	Mon, 18 Dec 2023 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgELI1Vk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E272077;
	Mon, 18 Dec 2023 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e3cdcf010so1205263e87.2;
        Mon, 18 Dec 2023 09:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921263; x=1703526063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GECqqIbmwZQzSgkD0rH9gtwmMolx6aq5Ff6gT7Rc18w=;
        b=OgELI1Vk+W2KzNTapnFPdr9D1qPmDJ8YzbDGUXxuBHxtsb6SHVFA7KMb/IzD0c26f0
         HV0E9ZyF9+iKFKFkbmAJPDs991h09PST2Sc2v6aBNiIrAkfhITDENq1OqqH/k0FOfiUj
         5dGTWLqY6FwnD7zksSedN9p8ggbJdmdjCJYTwBCD8n0OJt+exWDOgBN4a1pC45Ci45AI
         cFl0a5SDQppnm7o/vtb7TDB79rtVjEx9jCssLfQ2ijW9R63FpnJqY43CJqIOUmJrbK/c
         sDWpcrzT6BxQxCrYq1yEK99YsJx/KwxJRvjUZ0ZMLY/NrCw+88OPr+lB9g223bLUnbkN
         kXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921263; x=1703526063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GECqqIbmwZQzSgkD0rH9gtwmMolx6aq5Ff6gT7Rc18w=;
        b=nIAhzJaJk2rpnqyzpoYt7mE1kUGp4ecMmlRSIpv/N4XfjIasGDrkOyQIC0pk7liQws
         ZdG1Wz7rtRMPP088Ju462kORd9EFxrAVGEIjeJvz+BYPetdkIL23BcrdImwApA4PWbFH
         XWtHAatywOW4PShloEShOyNE+7073zDRppMLIaOSglR/EWjM/FOXnPd4pZx3l3lexbFs
         2HUdHgI/V6aD9HCuR2l4W2xF6/Xd5+KlP6GBicdTKb8Bya/w4cGeCw0GGCod2J5QVjgL
         us2SzfCX7Mz6m+1NdT2f1xvvasXPLtRcEu3sp6SEF29+y6hp0OYI0JCvrFvNLjrJmnp9
         BecA==
X-Gm-Message-State: AOJu0YxZcKsu3NR86QHP+06/1uizYD1+m4YLWCpSCJ/5uANQLujP4Gda
	m6+4tykIa2l5Qy0+cQKxwmSjEMAznNSFWQ==
X-Google-Smtp-Source: AGHT+IH+6Q93ikV/7PYO3Q+G/bwQHdgApa4/3jJQQUsD51UtW4bsyp0kRfsY8nvSS9xmtw39ltLtdA==
X-Received: by 2002:a2e:a588:0:b0:2cb:3169:b348 with SMTP id m8-20020a2ea588000000b002cb3169b348mr4599390ljp.96.1702921263307;
        Mon, 18 Dec 2023 09:41:03 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id k9-20020a05651c10a900b002cc74569398sm363278ljn.15.2023.12.18.09.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:02 -0800 (PST)
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
Subject: [PATCH v2 05/20] media: i2c: ov4689: Remove i2c_client from ov4689 struct
Date: Mon, 18 Dec 2023 20:40:26 +0300
Message-ID: <20231218174042.794012-6-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218174042.794012-1-mike.rudenko@gmail.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
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
index 6ea1c37323d1..3b20eba59c9c 100644
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
2.43.0


