Return-Path: <linux-kernel+bounces-18809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EAA82634F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13225282872
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD48912B6E;
	Sun,  7 Jan 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWxpXghw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999A125C5;
	Sun,  7 Jan 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-204a16df055so835725fac.0;
        Sat, 06 Jan 2024 23:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704613381; x=1705218181; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNKji9NxWGIfJI5662GCEQ8jNTqt/barrReQ9fFAVgs=;
        b=XWxpXghwAPQxuDKaxF/pegD076DjYtdHWnJqMQWA1kuoHMTYDwqVhf6gztLzjdwqtn
         wxfSNlcsps57N0S35KIimExIiIsHs7mR7g+k0m9tzLAaEbZuWD72X6hptdEEAadjil23
         z8weegC1Mbt9h74vuv+i/mlOqhnixl6d2XxGl/R/5r5MoathF/kV3HnLMirmN9WCOFph
         0i9fb0XffsvjJOjHe0phL6tGt8e1WyL9pH784In/mu/tHPCpF51Rf+5AENi6CAngETZ5
         rdr52KZ+zza91Q6f2EJ1CxzcoCv+ztXS21FiiAztjIS/K3pZI1YPBgesK0VX9uCH6fd3
         R3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704613381; x=1705218181;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNKji9NxWGIfJI5662GCEQ8jNTqt/barrReQ9fFAVgs=;
        b=nSRx7tkGt39PiPRT3u1nwi6Jec6REx5BXA9axD4vNyvVjstLWvQOfrbWq5ZRrWJeAd
         DSmcJPwa0rqYzVk0MMgrxIzQ67s8NjbVHJbSem2Sf1gTd0zLcGFfyRx1LCLCKf30Z7vk
         X6cx7jPem6DTp26Bbrilz8OQ3sNCCQ6AKezGLbKbZ0j0Oj8P5ZynR7bQaQcz2ULRapGT
         rH7CYLV9cCSQOuWfRWmeMYvwynYbWsrfc8UCvD/fxphY/VEHudQeros3pU0fYmCelz4S
         SxkzEVrEPkWzLptNyT2ufaE+HZiyi4B54XGUCcjMkNJooMMqm+TGjeJbkk+oYgtqaVUh
         De1A==
X-Gm-Message-State: AOJu0Yzn9IHHSgnoOrHZ5LZRyWuO1KctmKiKvxfM27AAROUzEA9SEb7k
	1KF1D3yO7DPj7RDPTY0kQQc=
X-Google-Smtp-Source: AGHT+IGSSfZGKp52IWknFCtLFDkGSmSiPW8wdo64nUSkh6BqrZyWVjGPg9sA8CINiGyPZeecpiF/BA==
X-Received: by 2002:a05:6871:8802:b0:204:1d3e:94d with SMTP id te2-20020a056871880200b002041d3e094dmr2694830oab.11.1704613381412;
        Sat, 06 Jan 2024 23:43:01 -0800 (PST)
Received: from localhost ([218.186.180.226])
        by smtp.gmail.com with ESMTPSA id nb12-20020a17090b35cc00b0028658c6209dsm4136040pjb.2.2024.01.06.23.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 23:43:01 -0800 (PST)
Date: Sun, 7 Jan 2024 15:42:59 +0800
From: Vinay Varma <varmavinaym@gmail.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"open list:SONY IMX219 SENSOR DRIVER" <linux-media@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: i2c: imx219: implement the v4l2 selection api
Message-ID: <kv6yfyahbud474e75y4jaczg64pcowvlz7i52kikknuh6wje5o@4k2hikwcueoy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch exposes IMX219's crop and compose capabilities
by implementing the selection API. Horizontal and vertical
binning being separate registers, `imx219_binning_goodness`
computes the best possible height and width of the compose
specification using the selection flags. Compose operation
updates the subdev's format object to keep them in sync.

Signed-off-by: Vinay Varma <varmavinaym@gmail.com>
---
 drivers/media/i2c/imx219.c | 222 +++++++++++++++++++++++++++++++------
 1 file changed, 190 insertions(+), 32 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 39943d72c22d..27d85fb7ad51 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -29,6 +29,7 @@
 #include <media/v4l2-event.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-mediabus.h>
+#include <media/v4l2-rect.h>
 
 /* Chip ID */
 #define IMX219_REG_CHIP_ID		CCI_REG16(0x0000)
@@ -73,6 +74,7 @@
 /* V_TIMING internal */
 #define IMX219_REG_VTS			CCI_REG16(0x0160)
 #define IMX219_VTS_MAX			0xffff
+#define IMX219_VTS_DEF 1763
 
 #define IMX219_VBLANK_MIN		32
 
@@ -146,6 +148,7 @@
 #define IMX219_PIXEL_ARRAY_TOP		8U
 #define IMX219_PIXEL_ARRAY_WIDTH	3280U
 #define IMX219_PIXEL_ARRAY_HEIGHT	2464U
+#define IMX219_MIN_COMPOSE_SIZE 8U
 
 /* Mode : resolution and related config&values */
 struct imx219_mode {
@@ -284,6 +287,8 @@ static const u32 imx219_mbus_formats[] = {
 #define IMX219_XCLR_MIN_DELAY_US	6200
 #define IMX219_XCLR_DELAY_RANGE_US	1000
 
+static const u32 binning_ratios[] = { 1, 2 };
+
 /* Mode configs */
 static const struct imx219_mode supported_modes[] = {
 	{
@@ -296,19 +301,19 @@ static const struct imx219_mode supported_modes[] = {
 		/* 1080P 30fps cropped */
 		.width = 1920,
 		.height = 1080,
-		.vts_def = 1763,
+		.vts_def = IMX219_VTS_DEF,
 	},
 	{
 		/* 2x2 binned 30fps mode */
 		.width = 1640,
 		.height = 1232,
-		.vts_def = 1763,
+		.vts_def = IMX219_VTS_DEF,
 	},
 	{
 		/* 640x480 30fps mode */
 		.width = 640,
 		.height = 480,
-		.vts_def = 1763,
+		.vts_def = IMX219_VTS_DEF,
 	},
 };
 
@@ -809,6 +814,39 @@ static int imx219_enum_frame_size(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static void imx219_refresh_ctrls(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *state,
+				 unsigned int vts_def)
+{
+	int exposure_max;
+	int exposure_def;
+	int hblank;
+	struct imx219 *imx219 = to_imx219(sd);
+	struct v4l2_mbus_framefmt *fmt =
+		v4l2_subdev_get_pad_format(sd, state, 0);
+
+	/* Update limits and set FPS to default */
+	__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
+				 IMX219_VTS_MAX - fmt->height, 1,
+				 vts_def - fmt->height);
+	__v4l2_ctrl_s_ctrl(imx219->vblank, vts_def - fmt->height);
+	/* Update max exposure while meeting expected vblanking */
+	exposure_max = vts_def - 4;
+	exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
+			       exposure_max :
+			       IMX219_EXPOSURE_DEFAULT;
+	__v4l2_ctrl_modify_range(imx219->exposure, imx219->exposure->minimum,
+				 exposure_max, imx219->exposure->step,
+				 exposure_def);
+	/*
+	 * Currently PPL is fixed to IMX219_PPL_DEFAULT, so hblank
+	 * depends on mode->width only, and is not changeble in any
+	 * way other than changing the mode.
+	 */
+	hblank = IMX219_PPL_DEFAULT - fmt->width;
+	__v4l2_ctrl_modify_range(imx219->hblank, hblank, hblank, 1, hblank);
+}
+
 static int imx219_set_pad_format(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_state *state,
 				 struct v4l2_subdev_format *fmt)
@@ -816,7 +854,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	struct imx219 *imx219 = to_imx219(sd);
 	const struct imx219_mode *mode;
 	struct v4l2_mbus_framefmt *format;
-	struct v4l2_rect *crop;
+	struct v4l2_rect *crop, *compose;
 	unsigned int bin_h, bin_v;
 
 	mode = v4l2_find_nearest_size(supported_modes,
@@ -842,34 +880,14 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	crop->left = (IMX219_NATIVE_WIDTH - crop->width) / 2;
 	crop->top = (IMX219_NATIVE_HEIGHT - crop->height) / 2;
 
-	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE) {
-		int exposure_max;
-		int exposure_def;
-		int hblank;
-
-		/* Update limits and set FPS to default */
-		__v4l2_ctrl_modify_range(imx219->vblank, IMX219_VBLANK_MIN,
-					 IMX219_VTS_MAX - mode->height, 1,
-					 mode->vts_def - mode->height);
-		__v4l2_ctrl_s_ctrl(imx219->vblank,
-				   mode->vts_def - mode->height);
-		/* Update max exposure while meeting expected vblanking */
-		exposure_max = mode->vts_def - 4;
-		exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
-			exposure_max : IMX219_EXPOSURE_DEFAULT;
-		__v4l2_ctrl_modify_range(imx219->exposure,
-					 imx219->exposure->minimum,
-					 exposure_max, imx219->exposure->step,
-					 exposure_def);
-		/*
-		 * Currently PPL is fixed to IMX219_PPL_DEFAULT, so hblank
-		 * depends on mode->width only, and is not changeble in any
-		 * way other than changing the mode.
-		 */
-		hblank = IMX219_PPL_DEFAULT - mode->width;
-		__v4l2_ctrl_modify_range(imx219->hblank, hblank, hblank, 1,
-					 hblank);
-	}
+	compose = v4l2_subdev_get_pad_compose(sd, state, 0);
+	compose->width = format->width;
+	compose->height = format->height;
+	compose->left = 0;
+	compose->top = 0;
+
+	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+		imx219_refresh_ctrls(sd, state, mode->vts_def);
 
 	return 0;
 }
@@ -884,6 +902,11 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
 		return 0;
 	}
 
+	case V4L2_SEL_TGT_COMPOSE: {
+		sel->r = *v4l2_subdev_get_pad_compose(sd, state, 0);
+		return 0;
+	}
+
 	case V4L2_SEL_TGT_NATIVE_SIZE:
 		sel->r.top = 0;
 		sel->r.left = 0;
@@ -900,11 +923,145 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
 		sel->r.height = IMX219_PIXEL_ARRAY_HEIGHT;
 
 		return 0;
+
+	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+	case V4L2_SEL_TGT_COMPOSE_PADDED:
+		sel->r.top = 0;
+		sel->r.left = 0;
+		sel->r.width = IMX219_PIXEL_ARRAY_WIDTH;
+		sel->r.height = IMX219_PIXEL_ARRAY_HEIGHT;
+		return 0;
 	}
 
 	return -EINVAL;
 }
 
+#define IMX219_ROUND(dim, step, flags)                \
+	((flags) & V4L2_SEL_FLAG_GE ?                 \
+		 round_up((dim), (step)) :            \
+		 ((flags) & V4L2_SEL_FLAG_LE ?        \
+			  round_down((dim), (step)) : \
+			  round_down((dim) + (step) / 2, (step))))
+
+static int imx219_set_selection_crop(struct v4l2_subdev *sd,
+				     struct v4l2_subdev_state *sd_state,
+				     struct v4l2_subdev_selection *sel)
+{
+	u32 max_binning;
+	struct v4l2_rect *compose, *crop;
+	struct v4l2_mbus_framefmt *fmt;
+
+	crop = v4l2_subdev_get_pad_crop(sd, sd_state, 0);
+	if (v4l2_rect_equal(&sel->r, crop))
+		return false;
+	max_binning = binning_ratios[ARRAY_SIZE(binning_ratios) - 1];
+	sel->r.width =
+		clamp(IMX219_ROUND(sel->r.width, max_binning, sel->flags),
+		      max_binning * IMX219_MIN_COMPOSE_SIZE,
+		      IMX219_PIXEL_ARRAY_WIDTH);
+	sel->r.height =
+		clamp(IMX219_ROUND(sel->r.width, max_binning, sel->flags),
+		      max_binning * IMX219_MIN_COMPOSE_SIZE,
+		      IMX219_PIXEL_ARRAY_WIDTH);
+	sel->r.left =
+		min_t(u32, sel->r.left, IMX219_PIXEL_ARRAY_LEFT - sel->r.width);
+	sel->r.top =
+		min_t(u32, sel->r.top, IMX219_PIXEL_ARRAY_TOP - sel->r.top);
+
+	compose = v4l2_subdev_get_pad_compose(sd, sd_state, 0);
+	fmt = v4l2_subdev_get_pad_format(sd, sd_state, 0);
+	*crop = sel->r;
+	compose->height = crop->height;
+	compose->width = crop->width;
+	return true;
+}
+
+static int imx219_binning_goodness(u32 act, u32 ask, u32 flags)
+{
+	const int goodness = 100000;
+	int val = 0;
+
+	if (flags & V4L2_SEL_FLAG_GE)
+		if (act < ask)
+			val -= goodness;
+
+	if (flags & V4L2_SEL_FLAG_LE)
+		if (act > ask)
+			val -= goodness;
+
+	val -= abs(act - ask);
+
+	return val;
+}
+
+static bool imx219_set_selection_compose(struct v4l2_subdev *sd,
+					 struct v4l2_subdev_state *state,
+					 struct v4l2_subdev_selection *sel)
+{
+	int best_goodness;
+	struct v4l2_rect *compose, *crop;
+
+	compose = v4l2_subdev_get_pad_compose(sd, state, 0);
+	if (v4l2_rect_equal(compose, &sel->r))
+		return false;
+
+	crop = v4l2_subdev_get_pad_crop(sd, state, 0);
+
+	best_goodness = INT_MIN;
+	for (int i = 0; i < ARRAY_SIZE(binning_ratios); ++i) {
+		u32 width = crop->width / binning_ratios[i];
+		int goodness = imx219_binning_goodness(width, sel->r.width,
+						       sel->flags);
+		if (goodness > best_goodness) {
+			best_goodness = goodness;
+			compose->width = width;
+		}
+	}
+	best_goodness = INT_MIN;
+	for (int i = 0; i < ARRAY_SIZE(binning_ratios); ++i) {
+		u32 height = crop->height / binning_ratios[i];
+		int goodness = imx219_binning_goodness(height, sel->r.height,
+						       sel->flags);
+		if (goodness > best_goodness) {
+			best_goodness = goodness;
+			compose->height = height;
+		}
+	}
+	return true;
+}
+
+static int imx219_set_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *sd_state,
+				struct v4l2_subdev_selection *sel)
+{
+	bool compose_updated = false;
+
+	switch (sel->target) {
+	case V4L2_SEL_TGT_CROP:
+		compose_updated = imx219_set_selection_crop(sd, sd_state, sel);
+		break;
+	case V4L2_SEL_TGT_COMPOSE:
+		compose_updated =
+			imx219_set_selection_compose(sd, sd_state, sel);
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (compose_updated) {
+		struct v4l2_rect *compose =
+			v4l2_subdev_get_pad_compose(sd, sd_state, 0);
+		struct v4l2_mbus_framefmt *fmt =
+			v4l2_subdev_get_pad_format(sd, sd_state, 0);
+		fmt->height = compose->height;
+		fmt->width = compose->width;
+	}
+	if (compose_updated && sel->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+		imx219_refresh_ctrls(sd, sd_state, IMX219_VTS_DEF);
+
+	return 0;
+}
+
 static int imx219_init_cfg(struct v4l2_subdev *sd,
 			   struct v4l2_subdev_state *state)
 {
@@ -938,6 +1095,7 @@ static const struct v4l2_subdev_pad_ops imx219_pad_ops = {
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = imx219_set_pad_format,
 	.get_selection = imx219_get_selection,
+	.set_selection = imx219_set_selection,
 	.enum_frame_size = imx219_enum_frame_size,
 };
 
-- 
2.43.0


