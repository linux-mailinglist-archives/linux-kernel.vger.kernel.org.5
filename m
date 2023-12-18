Return-Path: <linux-kernel+bounces-4191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899208178FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5BC1C25572
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F0A74E29;
	Mon, 18 Dec 2023 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqvXmH1u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2971477;
	Mon, 18 Dec 2023 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso3901608e87.2;
        Mon, 18 Dec 2023 09:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921266; x=1703526066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0/5NCPPEP08dxHiHIezXLBrilHL+5rztH1UO29obAo=;
        b=PqvXmH1uUnkEz93haJsEFNRHyvGppMKE/C31snNWw6Mp2zk47O8wZP1wcH4bHbjkIX
         0qA81yYknYGq5sQJ9HWHX/qI82mBOhPSnjVWnv5UTIajDY7Q/V0060zW2U96H8MiNbYW
         3iOMbj75ja5rQr6QOtEU3gzGZ5uLGSL5kzgWIUOPuH1VuFAf0+9ukeegFq7laIxcUQss
         HNBLAHu4HL5ETFSkKgsgAKkPU9oT4qvlsSarJ+mIf4MmrHJ2y5qWHAh1lCCh18n3d2dB
         n2VTlI/cK8gXT/fqituofYxwGA+XBkAzof1zj5CgbXdFNrrVkBo7RNlclIQZryh63Obk
         5W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921266; x=1703526066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0/5NCPPEP08dxHiHIezXLBrilHL+5rztH1UO29obAo=;
        b=o1pnAVNq/7bbzufwbMKt8P7MO03r85nJfqJLn7vqogwSvCF7rGYKkOf7ijt72KmJwV
         vpPl0EkYnKUf5J1fPcRZ4rQ6G7mGZNdhKX1RhPTNhc/EOBHjFXnRg9mwDPu+mUPiECfF
         I2Phe6mBthvxckYOhMzIyCOpetfqE+8sytZJ3PHgZBCm+kMAVZOT5WY55SZ4wffDk8yi
         EA07YoRCqdt6/6wdomtOUnYJcGh/WF98R7FvE9ujJ8uYLULT+zmx1l4Lpw8Q5NioTXlh
         OoL0VZbIjOxQEj3Vddm+wBvjRMc0dbE6B1B58nrtOHtIvf2mohWAO+8vAlG4ROD/8K6L
         aYlw==
X-Gm-Message-State: AOJu0Yw+8cETf0IrCn5BYJsllb8t6e8JVKUIIPCWvYyDxKCiO8IN0VlO
	bFDtdjneZQuRi+DXWTwiuDR3OGQcbYpFdw==
X-Google-Smtp-Source: AGHT+IF9ey4UQ6SUMpAGvUqYRTmdaHtMtctv+O6YHO1u0m2u4Rue0WRtBrlpVqU33PMFNKB4V2vFxg==
X-Received: by 2002:a05:6512:1586:b0:50e:719:6feb with SMTP id bp6-20020a056512158600b0050e07196febmr4040180lfb.213.1702921266432;
        Mon, 18 Dec 2023 09:41:06 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id f8-20020a193808000000b0050d12fe487bsm1077566lfa.277.2023.12.18.09.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:06 -0800 (PST)
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
Subject: [PATCH v2 07/20] media: i2c: ov4689: Use sub-device active state
Date: Mon, 18 Dec 2023 20:40:28 +0300
Message-ID: <20231218174042.794012-8-mike.rudenko@gmail.com>
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

Use sub-device active state. Employ control handler lock to
synchronize access to the active state and s_stream.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 75 ++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 43 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index d42f5d1a1ba8..501901aad4ae 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -86,7 +86,6 @@ struct ov4689 {
 
 	u32 clock_rate;
 
-	struct mutex mutex; /* lock to protect ctrls and cur_mode */
 	struct v4l2_ctrl_handler ctrl_handler;
 	struct v4l2_ctrl *exposure;
 
@@ -319,19 +318,6 @@ static int ov4689_set_fmt(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int ov4689_get_fmt(struct v4l2_subdev *sd,
-			  struct v4l2_subdev_state *sd_state,
-			  struct v4l2_subdev_format *fmt)
-{
-	struct v4l2_mbus_framefmt *mbus_fmt = &fmt->format;
-	struct ov4689 *ov4689 = to_ov4689(sd);
-
-	/* only one mode supported for now */
-	ov4689_fill_fmt(ov4689->cur_mode, mbus_fmt);
-
-	return 0;
-}
-
 static int ov4689_enum_mbus_code(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_state *sd_state,
 				 struct v4l2_subdev_mbus_code_enum *code)
@@ -405,10 +391,11 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 {
 	struct ov4689 *ov4689 = to_ov4689(sd);
+	struct v4l2_subdev_state *sd_state;
 	struct device *dev = ov4689->dev;
 	int ret = 0;
 
-	mutex_lock(&ov4689->mutex);
+	sd_state = v4l2_subdev_lock_and_get_active_state(&ov4689->subdev);
 
 	if (on) {
 		ret = pm_runtime_resume_and_get(dev);
@@ -443,7 +430,7 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 	}
 
 unlock_and_return:
-	mutex_unlock(&ov4689->mutex);
+	v4l2_subdev_unlock_state(sd_state);
 
 	return ret;
 }
@@ -506,18 +493,13 @@ static int __maybe_unused ov4689_power_off(struct device *dev)
 	return 0;
 }
 
-static int ov4689_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
+static int ov4689_init_state(struct v4l2_subdev *sd,
+			     struct v4l2_subdev_state *sd_state)
 {
-	struct ov4689 *ov4689 = to_ov4689(sd);
-	struct v4l2_mbus_framefmt *try_fmt;
-
-	mutex_lock(&ov4689->mutex);
-
-	try_fmt = v4l2_subdev_state_get_format(fh->state, 0);
-	/* Initialize try_fmt */
-	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], try_fmt);
+	struct v4l2_mbus_framefmt *fmt =
+		v4l2_subdev_state_get_format(sd_state, 0);
 
-	mutex_unlock(&ov4689->mutex);
+	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], fmt);
 
 	return 0;
 }
@@ -526,10 +508,6 @@ static const struct dev_pm_ops ov4689_pm_ops = {
 	SET_RUNTIME_PM_OPS(ov4689_power_off, ov4689_power_on, NULL)
 };
 
-static const struct v4l2_subdev_internal_ops ov4689_internal_ops = {
-	.open = ov4689_open,
-};
-
 static const struct v4l2_subdev_video_ops ov4689_video_ops = {
 	.s_stream = ov4689_s_stream,
 };
@@ -537,11 +515,15 @@ static const struct v4l2_subdev_video_ops ov4689_video_ops = {
 static const struct v4l2_subdev_pad_ops ov4689_pad_ops = {
 	.enum_mbus_code = ov4689_enum_mbus_code,
 	.enum_frame_size = ov4689_enum_frame_sizes,
-	.get_fmt = ov4689_get_fmt,
+	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = ov4689_set_fmt,
 	.get_selection = ov4689_get_selection,
 };
 
+static const struct v4l2_subdev_internal_ops ov4689_internal_ops = {
+	.init_state = ov4689_init_state,
+};
+
 static const struct v4l2_subdev_ops ov4689_subdev_ops = {
 	.video = &ov4689_video_ops,
 	.pad = &ov4689_pad_ops,
@@ -648,7 +630,6 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 	ret = v4l2_ctrl_handler_init(handler, 10);
 	if (ret)
 		return ret;
-	handler->lock = &ov4689->mutex;
 
 	ctrl = v4l2_ctrl_new_int_menu(handler, NULL, V4L2_CID_LINK_FREQ, 0, 0,
 				      link_freq_menu_items);
@@ -861,13 +842,15 @@ static int ov4689_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret,
 				     "Failed to get power regulators\n");
 
-	mutex_init(&ov4689->mutex);
-
 	sd = &ov4689->subdev;
 	v4l2_i2c_subdev_init(sd, client, &ov4689_subdev_ops);
+	sd->internal_ops = &ov4689_internal_ops;
+
 	ret = ov4689_initialize_controls(ov4689);
-	if (ret)
-		goto err_destroy_mutex;
+	if (ret) {
+		dev_err(dev, "Failed to initialize controls\n");
+		return ret;
+	}
 
 	ret = ov4689_power_on(dev);
 	if (ret)
@@ -877,19 +860,26 @@ static int ov4689_probe(struct i2c_client *client)
 	if (ret)
 		goto err_power_off;
 
-	sd->internal_ops = &ov4689_internal_ops;
 	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
 
 	ov4689->pad.flags = MEDIA_PAD_FL_SOURCE;
-	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
 	ret = media_entity_pads_init(&sd->entity, 1, &ov4689->pad);
 	if (ret < 0)
 		goto err_power_off;
 
+	sd->state_lock = ov4689->ctrl_handler.lock;
+	ret = v4l2_subdev_init_finalize(sd);
+
+	if (ret) {
+		dev_err(dev, "Could not register v4l2 device\n");
+		goto err_clean_entity;
+	}
+
 	ret = v4l2_async_register_subdev_sensor(sd);
 	if (ret) {
 		dev_err(dev, "v4l2 async register subdev failed\n");
-		goto err_clean_entity;
+		goto err_clean_subdev;
 	}
 
 	pm_runtime_set_active(dev);
@@ -898,14 +888,14 @@ static int ov4689_probe(struct i2c_client *client)
 
 	return 0;
 
+err_clean_subdev:
+	v4l2_subdev_cleanup(sd);
 err_clean_entity:
 	media_entity_cleanup(&sd->entity);
 err_power_off:
 	ov4689_power_off(dev);
 err_free_handler:
 	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
-err_destroy_mutex:
-	mutex_destroy(&ov4689->mutex);
 
 	return ret;
 }
@@ -917,9 +907,8 @@ static void ov4689_remove(struct i2c_client *client)
 
 	v4l2_async_unregister_subdev(sd);
 	media_entity_cleanup(&sd->entity);
-
+	v4l2_subdev_cleanup(sd);
 	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
-	mutex_destroy(&ov4689->mutex);
 
 	pm_runtime_disable(&client->dev);
 	if (!pm_runtime_status_suspended(&client->dev))
-- 
2.43.0


