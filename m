Return-Path: <linux-kernel+bounces-87113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E6286CFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62231C230CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FDB7A157;
	Thu, 29 Feb 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/LoaHrP"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C27827F;
	Thu, 29 Feb 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225641; cv=none; b=MoSYQJQz071Z4Ic09S2Z9EYAKR+b49qW5oJ6bkKq94GhCYNYqE02l6DhFsuGFvcn1PMg8PWNnimCyyGd2MkFFBdeLv/DlMk5C9ccfx2GGFZJD/PdZihZwlqGkjP2oAGtNTZrA/7iXz71OvUYymvL2BOOSZGIu5EwYQRrdWjTOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225641; c=relaxed/simple;
	bh=ROQpCos746Zb3F1h9fLdI7HgIH3KQz5Xo0S4OnBLwVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMNHFIJ/BhNJZweZtINwTPcSPsxBCcWtB2Pjp9qeQAYd2tS/oMbKtOLjzrghcJlZ2uorBb6SXtLDx54iOkPIcW3MeQcjVT5O+8EilFIKmi871U/WNm464PEx4dt+OFGkvmk7Wu+C3E2+KeRWI+rUZFRVeSYqs4cGpVaCqsbMCzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/LoaHrP; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5131d0c3517so1075538e87.1;
        Thu, 29 Feb 2024 08:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225636; x=1709830436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw8k74BHt2o626Rf41Ehs+KdDJYpQNXuHT/61zn25bs=;
        b=d/LoaHrPL32RwGJ2MEa46UnLrwLO2fm585k8DibX8bEtrw3LtoVzDnp7aoq07TpEIc
         IdkGjsP5NzlyirPAZUUfSWliwFOfdzbWTH3t8h/skS/j69CG1mpZgnm4cuLKr3qI81dv
         dRRtZJroDm/kFGKnPv7sYjioyzZkj7lwNZMz7JhO5r7/qWLIUEF5qTJBF7mDetmPKmPJ
         /iw7/KHh8jK4GZk7ZmfyR+b2FRKiQxfB6xbBXvFkj9fj36bKqREbs/YPEp8/IajGAbB+
         znPoZAQb3uT2d3ToraqivRp3tKLdbjp7bRz19a1R2dY/6Fj1FL46zDum0mUQb4vJQjuf
         pH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225636; x=1709830436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sw8k74BHt2o626Rf41Ehs+KdDJYpQNXuHT/61zn25bs=;
        b=ADn23GPgoZqlwQRxetxOmrFQj2/6RwfArejwlRIj5+79Iu34KLSnyXqR0dpdIcsQqg
         /5YWOjPkroPN0NteLUra3gvHe7ACnhe13tdQh9cLxTNfsclplfZ7knJiijepxJqVhFmX
         Iy4IVN0K8v2xEoOi9CgNMn9Ua2BgWXH0tsjB/gSSiyODI/JmXMoSvsp4KcIAJGvxSDVL
         BhwBrmf65Vd9rQeYjG9603mSItaobX9iwa87zkT0GVdPmL/bxsYvoWc8p9IyxfwQsKNh
         LutZYV6gDIMwLRQxy9o2KVTZoHbrQLdESItD9XGSO4d7ML4V8TgO2rgXPqubOT92xm9r
         hH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXyI1OM5HONSchvtqGY4MoqG5+5vynP3z3KKyx9SIlIeKiq5KQoqeZNFfNJW+SmixAsrrXA1huMpLg30aNeZ9HPbc13vqmnUtQco2f
X-Gm-Message-State: AOJu0YzZmZkRrEfFeJjv0K2z8rbP4r++KdLCxwbPYkCJBbhSO3YO9+Yu
	6EKnG2gtIcngyahgT2AQ0hR9LtpRN/10YypIs26Ttk92XJhsa3NdGx08kEnH2Mo=
X-Google-Smtp-Source: AGHT+IHYGIK+btFwCkcrMJOBbWpQPUcD7ZY9P5QWL8rwYyFqwJr0SK38e8FszACQymiJ5JQdm3ZX7A==
X-Received: by 2002:ac2:410c:0:b0:513:2d00:df3d with SMTP id b12-20020ac2410c000000b005132d00df3dmr73881lfi.1.1709225636040;
        Thu, 29 Feb 2024 08:53:56 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id c17-20020a197611000000b0051319cbe2e5sm311685lff.16.2024.02.29.08.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:53:55 -0800 (PST)
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
Subject: [PATCH v3 07/20] media: i2c: ov4689: Use sub-device active state
Date: Thu, 29 Feb 2024 19:53:20 +0300
Message-ID: <20240229165333.227484-8-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229165333.227484-1-mike.rudenko@gmail.com>
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 75 ++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 44 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 1bc00404f3fb..47feb6b5ede8 100644
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
@@ -649,7 +631,6 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 	ret = v4l2_ctrl_handler_init(handler, 10);
 	if (ret)
 		return ret;
-	handler->lock = &ov4689->mutex;
 
 	ctrl = v4l2_ctrl_new_int_menu(handler, NULL, V4L2_CID_LINK_FREQ, 0, 0,
 				      link_freq_menu_items);
@@ -862,13 +843,15 @@ static int ov4689_probe(struct i2c_client *client)
 		return dev_err_probe(dev, ret,
 				     "Failed to get power regulators\n");
 
-	mutex_init(&ov4689->mutex);
-
 	sd = &ov4689->subdev;
 	v4l2_i2c_subdev_init(sd, client, &ov4689_subdev_ops);
+	sd->internal_ops = &ov4689_internal_ops;
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	ret = ov4689_initialize_controls(ov4689);
-	if (ret)
-		goto err_destroy_mutex;
+	if (ret) {
+		dev_err(dev, "Failed to initialize controls\n");
+		return ret;
+	}
 
 	ret = ov4689_power_on(dev);
 	if (ret)
@@ -878,19 +861,24 @@ static int ov4689_probe(struct i2c_client *client)
 	if (ret)
 		goto err_power_off;
 
-	sd->internal_ops = &ov4689_internal_ops;
-	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 
-	ov4689->pad.flags = MEDIA_PAD_FL_SOURCE;
 	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
+	ov4689->pad.flags = MEDIA_PAD_FL_SOURCE;
 	ret = media_entity_pads_init(&sd->entity, 1, &ov4689->pad);
 	if (ret < 0)
 		goto err_power_off;
 
+	sd->state_lock = ov4689->ctrl_handler.lock;
+	ret = v4l2_subdev_init_finalize(sd);
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
@@ -899,14 +887,14 @@ static int ov4689_probe(struct i2c_client *client)
 
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
@@ -918,9 +906,8 @@ static void ov4689_remove(struct i2c_client *client)
 
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


