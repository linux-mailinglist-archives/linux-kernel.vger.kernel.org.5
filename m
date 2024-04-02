Return-Path: <linux-kernel+bounces-128373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74886895A0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CA91F26CEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2779159900;
	Tue,  2 Apr 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afCjTe9x"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198CC15ADB5;
	Tue,  2 Apr 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076384; cv=none; b=CqgW3kfCbAE0/ucuMd4NTV0pEdzbdrPAoXnid3hRTy5WdEsz1eYrjYFRvcLMqAYYwKPoHTQi3Qr9GdhafUrv33Udbzp+4bZ6Q915SoU98Sha9+HjOSlulqaeh6yAe+/jvK9Aid0sIPWxQBq/rn6pe5wCZ/mpws88bV8lV62T6kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076384; c=relaxed/simple;
	bh=PezL7D+Pvsshgetm3G1N+7+g6nb2hjIHSc+E8dQbKkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDE/Mce6g2UYuCnJIkRIBBXF/gNpqBs9YqMjvEcI3XidMIZRN3WH5ZM3rCI7CKVfizIdQAURWoj9vs4Munz8loq67SBcCIPIvFOqr6oNt2/nb7A7BrrSXlBw4VdkmbGV4h2qtsONoBUkW7jQLbsEvLKkbozunsDsU/XpN4cpSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afCjTe9x; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d485886545so89420441fa.2;
        Tue, 02 Apr 2024 09:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076381; x=1712681181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW12xdwqhFyVlstnzDlKEo1hjQER7vyVi6VDlDpxBck=;
        b=afCjTe9xePMrFQ6uJZzTN194atH79FL3jIp0cu42Fljn2kXZ0cvDtIbqD5t+hAterT
         QNTz9F0UVB2dCqAsggBiUpYNSQkJBfrrGxnDdmLazOMbqk0JY95/0ytJP8eJsXm5gikD
         4Vjl1FVY2lBIuFkFA0ujmV+e94xS0ygalWMw/JfyI6gQ4OLYY6vBJbL65SdyTpf3AMXK
         JPSHaNoaex/WbU7QqVMTLqM/2bpUNfXi5RjWe2pBlOZJQPmvLQHFbNXtMTS+mil4J9oK
         Vdm/IeiFcxpYQd4VyCtNzSEA/QNSEK7BBMbjT+Ocf8KZKDvdka0/3OZpOAwe7TfiUZIE
         /K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076381; x=1712681181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sW12xdwqhFyVlstnzDlKEo1hjQER7vyVi6VDlDpxBck=;
        b=IQGJC5EA+7cmRYqmpO+eFzwSZACrdE5vR4HFy/93KFOSFP8eop0fBlZqQaHdj2VJDo
         vcQMnkooGm8ybe/q/WRvXKn/3uR+W3fSylULyAx3vNRjbivBgbzd4YM2ntBGLq5sa7aQ
         6CJ+lDI+/kX6ReTuq3OoheOrQZGWbGuFbNJwPiWwPMwhgwDIWjb8XZf3XAOZhjI8z4+h
         LvwadHgQtcMqhyy0I6IiSPuYN15xsjneUCKBTuUANInd1PxKRyvZ5cEiYNaHKRvBamcS
         pAop4ZHdxCfCFZ3OkIvkm/2UuEYztJFG3UaMxJmOIvCq//FVkPmorBRb+u0Uvr8zDlM1
         obBg==
X-Forwarded-Encrypted: i=1; AJvYcCWqTyy9NbvzM5TIucgc/+ZL/dbxcV+mysCQ07uusnSHdLyOiV7XqpvsnlHuWC+kdiraCHT7jycQPRN6VhLLT6TFHBSuWu3MdrUNpKE7
X-Gm-Message-State: AOJu0YwNcds7uIQFtA57Bq8OgfS/DGZDQW7KU5yLXvbdQtazMLGKFI6q
	IHS/X87EJxNdQRazVA5J4XIbOeKEfqoWED7jXS373Hnjf5yoXfG2ep7qVvaRVHuLGw==
X-Google-Smtp-Source: AGHT+IElujoMbJrQExxXSZ5akHVrCcF1zv+LA2fDgfPBF6IpBYsIoMiWWNet2DG/FJ9HI5dD6iXE3w==
X-Received: by 2002:a05:651c:83:b0:2d6:c749:17bc with SMTP id 3-20020a05651c008300b002d6c74917bcmr1931478ljq.31.1712076380159;
        Tue, 02 Apr 2024 09:46:20 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id v1-20020a2e87c1000000b002d6b4a9a61csm1702418ljj.132.2024.04.02.09.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:19 -0700 (PDT)
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
Subject: [PATCH v4 07/20] media: i2c: ov4689: Use sub-device active state
Date: Tue,  2 Apr 2024 19:45:38 +0300
Message-ID: <20240402164552.19171-8-mike.rudenko@gmail.com>
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
2.44.0


