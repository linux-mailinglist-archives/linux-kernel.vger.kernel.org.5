Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868327F923E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjKZKeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKZKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:33:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB024C3;
        Sun, 26 Nov 2023 02:34:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso4274815a12.1;
        Sun, 26 Nov 2023 02:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700994844; x=1701599644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=++pAsBCBye9HWqAS80vhRpoxhO/0QXW+MlhrMMfw3wQ=;
        b=idx7etA+PlheapFKrL3QQe/TA05DHja4F2/5oWY/iJh/5pRXENxlgQcaDGI31QzEy5
         Lv8bhG1CDMIYQ6Kx4BghZQr53v9o2uqwpVxIed6mvXZoYJ7Ri1LDl8KjzFvlaV9ZBNuk
         vragrSSIak8mrEM8toaTiFKHHVEXWdBAUpOFoGrRkfxSJtTwlM0VL2QPk4v1ndrz64mS
         Bw7LQWfMIV+EIwIF/sEwTy4t5758tAGSyfn28iyDQw3qIlOGcBG4QYz+/QICaV/L5M2L
         KyraJ9AKJS9U2DwoiXSMlOwrfN3wkp50dYqQiJElTZy66gPwUqCkcNZm9ETyqugqsbsp
         HoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700994844; x=1701599644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++pAsBCBye9HWqAS80vhRpoxhO/0QXW+MlhrMMfw3wQ=;
        b=h3A7FrjKOIoY+boRMJlnXEs8G+QS8U6tQX2zoY7rdF8TDZOdtxl72w6m8+NNjiH6uL
         4u0ATp8U65i2yv1YDrHvGi5z0PcD2XHfa7EenqKBTvbk/yLde1DZloKfSmu7aL7nkmbR
         MllqjEwF4ukCEaTvc30fyXzVkllzvPbYfs0/BBohJpFVu7Y7mYr95NjhIKp5DSUO5HbR
         P/Q/rv9rf/gfNo6Az0CdL1l63O27pGnGbZQG5nVe68//h6oFgdSRRSeDEZTS7kODTsi6
         4V6TAN3EMaCzFWPKe6O4TMSCDCBUxuNwIotA2gRrjtADJm+8l2psxCXaO9blkKG1kKZy
         wSNg==
X-Gm-Message-State: AOJu0Yxj27YqdkXEbw3tf5nQLXqCZLYK1+ZB+kFMfAZ8pq3GNLIETt6n
        emcm01JLVnVSS6Bdn/4U0Xw=
X-Google-Smtp-Source: AGHT+IGC+lRaJEEXcYqJeFb7BjquIz04H/2YeRTCIEUfPqs+Hzj1Fr19ZVUU4pS+X1eGq21Ui3cpGg==
X-Received: by 2002:a50:9b04:0:b0:543:70c2:aa8d with SMTP id o4-20020a509b04000000b0054370c2aa8dmr5837963edi.15.1700994843895;
        Sun, 26 Nov 2023 02:34:03 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-2-39-142-131.cust.vodafonedsl.it. [2.39.142.131])
        by smtp.gmail.com with ESMTPSA id eh9-20020a0564020f8900b005486f7f654dsm4056348edb.7.2023.11.26.02.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 02:34:03 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: ov5640: use subdev active state
Date:   Sun, 26 Nov 2023 11:34:01 +0100
Message-Id: <20231126103401.2617585-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Port the ov5640 sensor driver to use the subdev active state.

After the ov5640 configurations steps call v4l2_subdev_init_finalize
that finalizes the initialization of the subdevice.
From now we use subdevice active state to simplify format handling and
locking

References:
 - https://patchwork.kernel.org/project/linux-media/patch/20230710155203.92366-6-jacopo.mondi@ideasonboard.com/
 - https://linuxtv.org/downloads/v4l-dvb-apis/driver-api/v4l2-subdev.html#c.v4l2_subdev_cleanup

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/ov5640.c | 89 ++++++++++----------------------------
 1 file changed, 24 insertions(+), 65 deletions(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 3f79a3b77044..44a073d3df64 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -446,9 +446,6 @@ struct ov5640_dev {
 	struct gpio_desc *pwdn_gpio;
 	bool   upside_down;
 
-	/* lock to protect all members below */
-	struct mutex lock;
-
 	struct v4l2_mbus_framefmt fmt;
 	bool pending_fmt_change;
 
@@ -2784,30 +2781,6 @@ static int ov5640_try_frame_interval(struct ov5640_dev *sensor,
 	return mode ? rate : -EINVAL;
 }
 
-static int ov5640_get_fmt(struct v4l2_subdev *sd,
-			  struct v4l2_subdev_state *sd_state,
-			  struct v4l2_subdev_format *format)
-{
-	struct ov5640_dev *sensor = to_ov5640_dev(sd);
-	struct v4l2_mbus_framefmt *fmt;
-
-	if (format->pad != 0)
-		return -EINVAL;
-
-	mutex_lock(&sensor->lock);
-
-	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
-		fmt = v4l2_subdev_state_get_format(sd_state, format->pad);
-	else
-		fmt = &sensor->fmt;
-
-	format->format = *fmt;
-
-	mutex_unlock(&sensor->lock);
-
-	return 0;
-}
-
 static int ov5640_try_fmt_internal(struct v4l2_subdev *sd,
 				   struct v4l2_mbus_framefmt *fmt,
 				   const struct ov5640_mode_info **new_mode)
@@ -2958,21 +2931,14 @@ static int ov5640_set_fmt(struct v4l2_subdev *sd,
 	if (format->pad != 0)
 		return -EINVAL;
 
-	mutex_lock(&sensor->lock);
-
-	if (sensor->streaming) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (sensor->streaming)
+		return -EBUSY;
 
 	ret = ov5640_try_fmt_internal(sd, mbus_fmt, &new_mode);
 	if (ret)
-		goto out;
+		return ret;
 
-	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
-		*v4l2_subdev_state_get_format(sd_state, 0) = *mbus_fmt;
-		goto out;
-	}
+	*v4l2_subdev_state_get_format(sd_state, 0) = *mbus_fmt;
 
 	if (new_mode != sensor->current_mode) {
 		sensor->current_fr = new_mode->def_fps;
@@ -2987,26 +2953,16 @@ static int ov5640_set_fmt(struct v4l2_subdev *sd,
 
 	ov5640_update_pixel_rate(sensor);
 
-out:
-	mutex_unlock(&sensor->lock);
-	return ret;
+	return 0;
 }
 
 static int ov5640_get_selection(struct v4l2_subdev *sd,
 				struct v4l2_subdev_state *sd_state,
 				struct v4l2_subdev_selection *sel)
 {
-	struct ov5640_dev *sensor = to_ov5640_dev(sd);
-	const struct ov5640_mode_info *mode = sensor->current_mode;
-	const struct ov5640_timings *timings;
-
 	switch (sel->target) {
 	case V4L2_SEL_TGT_CROP: {
-		mutex_lock(&sensor->lock);
-		timings = ov5640_timings(sensor, mode);
-		sel->r = timings->analog_crop;
-		mutex_unlock(&sensor->lock);
-
+		sel->r = *v4l2_subdev_state_get_crop(sd_state, 0);
 		return 0;
 	}
 
@@ -3441,9 +3397,6 @@ static int ov5640_init_controls(struct ov5640_dev *sensor)
 
 	v4l2_ctrl_handler_init(hdl, 32);
 
-	/* we can use our own mutex for the ctrl lock */
-	hdl->lock = &sensor->lock;
-
 	/* Clock related controls */
 	ctrls->pixel_rate = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_PIXEL_RATE,
 			      ov5640_pixel_rates[OV5640_NUM_PIXEL_RATES - 1],
@@ -3609,9 +3562,7 @@ static int ov5640_g_frame_interval(struct v4l2_subdev *sd,
 {
 	struct ov5640_dev *sensor = to_ov5640_dev(sd);
 
-	mutex_lock(&sensor->lock);
 	fi->interval = sensor->frame_interval;
-	mutex_unlock(&sensor->lock);
 
 	return 0;
 }
@@ -3620,13 +3571,14 @@ static int ov5640_s_frame_interval(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_frame_interval *fi)
 {
 	struct ov5640_dev *sensor = to_ov5640_dev(sd);
+	struct v4l2_subdev_state *state;
 	const struct ov5640_mode_info *mode;
 	int frame_rate, ret = 0;
 
 	if (fi->pad != 0)
 		return -EINVAL;
 
-	mutex_lock(&sensor->lock);
+	state = v4l2_subdev_lock_and_get_active_state(sd);
 
 	if (sensor->streaming) {
 		ret = -EBUSY;
@@ -3663,7 +3615,7 @@ static int ov5640_s_frame_interval(struct v4l2_subdev *sd,
 		ov5640_update_pixel_rate(sensor);
 	}
 out:
-	mutex_unlock(&sensor->lock);
+	v4l2_subdev_unlock_state(state);
 	return ret;
 }
 
@@ -3694,6 +3646,7 @@ static int ov5640_enum_mbus_code(struct v4l2_subdev *sd,
 static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
 {
 	struct ov5640_dev *sensor = to_ov5640_dev(sd);
+	struct v4l2_subdev_state *state;
 	int ret = 0;
 
 	if (enable) {
@@ -3708,7 +3661,7 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
 		}
 	}
 
-	mutex_lock(&sensor->lock);
+	state = v4l2_subdev_lock_and_get_active_state(sd);
 
 	if (sensor->streaming == !enable) {
 		if (enable && sensor->pending_mode_change) {
@@ -3734,7 +3687,7 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
 	}
 
 out:
-	mutex_unlock(&sensor->lock);
+	v4l2_subdev_unlock_state(state);
 
 	if (!enable || ret) {
 		pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
@@ -3778,7 +3731,7 @@ static const struct v4l2_subdev_video_ops ov5640_video_ops = {
 static const struct v4l2_subdev_pad_ops ov5640_pad_ops = {
 	.init_cfg = ov5640_init_cfg,
 	.enum_mbus_code = ov5640_enum_mbus_code,
-	.get_fmt = ov5640_get_fmt,
+	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = ov5640_set_fmt,
 	.get_selection = ov5640_get_selection,
 	.enum_frame_size = ov5640_enum_frame_size,
@@ -3918,8 +3871,6 @@ static int ov5640_probe(struct i2c_client *client)
 	if (ret)
 		goto entity_cleanup;
 
-	mutex_init(&sensor->lock);
-
 	ret = ov5640_init_controls(sensor);
 	if (ret)
 		goto entity_cleanup;
@@ -3938,9 +3889,16 @@ static int ov5640_probe(struct i2c_client *client)
 	if (ret)
 		goto err_pm_runtime;
 
+	sensor->sd.state_lock = sensor->ctrls.handler.lock;
+	ret = v4l2_subdev_init_finalize(&sensor->sd);
+	if (ret < 0) {
+		dev_err(dev, "subdev init error: %d\n", ret);
+		goto err_pm_runtime;
+	}
+
 	ret = v4l2_async_register_subdev_sensor(&sensor->sd);
 	if (ret)
-		goto err_pm_runtime;
+		goto subdev_cleanup;
 
 	pm_runtime_set_autosuspend_delay(dev, 1000);
 	pm_runtime_use_autosuspend(dev);
@@ -3949,6 +3907,8 @@ static int ov5640_probe(struct i2c_client *client)
 
 	return 0;
 
+subdev_cleanup:
+	v4l2_subdev_cleanup(&sensor->sd);
 err_pm_runtime:
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
@@ -3957,7 +3917,6 @@ static int ov5640_probe(struct i2c_client *client)
 	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
 entity_cleanup:
 	media_entity_cleanup(&sensor->sd.entity);
-	mutex_destroy(&sensor->lock);
 	return ret;
 }
 
@@ -3973,9 +3932,9 @@ static void ov5640_remove(struct i2c_client *client)
 	pm_runtime_set_suspended(dev);
 
 	v4l2_async_unregister_subdev(&sensor->sd);
+	v4l2_subdev_cleanup(sd);
 	media_entity_cleanup(&sensor->sd.entity);
 	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
-	mutex_destroy(&sensor->lock);
 }
 
 static const struct dev_pm_ops ov5640_pm_ops = {
-- 
2.34.1

