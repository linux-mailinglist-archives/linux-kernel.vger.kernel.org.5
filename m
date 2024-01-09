Return-Path: <linux-kernel+bounces-20349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C166827D92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAA728549A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5FE610A;
	Tue,  9 Jan 2024 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTEeucN7"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381D4418;
	Tue,  9 Jan 2024 03:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3e2972f65so6966425ad.3;
        Mon, 08 Jan 2024 19:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704772276; x=1705377076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+yR4EqaYq6z4nX4LbOLDFnP56WybFB5TP6rPmKwx7o=;
        b=CTEeucN7ZGDK+4Mg8ZMT5aIEp2bxNX5c0t9Q+RMX6rn5waGuQhcZHXinSGO/qvwyvn
         1HCCXHrBJkVZMBE7KarXA6O4aNjP1WnAJIxLyJg7st4UamU9yZrGlwlybvCnecpppjqq
         OnBxwBNQHySh02d4QFpRkNEJ/7BDjykElDnd8+nXfHozlt+Xaa29XMHaL0xtc0CZQrpX
         ZQWrN6iFSZb/I3/Vws/vYKpGIZvx8zWVAMPCNDpMiXEbC7gLAjzN32MRR/THAuAarw4O
         /e0dc0etrxmfuUVELbs0pakoCG6auyLvRO/vobeJ1KveoHKlo11nDdQTDwuFDKAwPLE9
         7OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704772276; x=1705377076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+yR4EqaYq6z4nX4LbOLDFnP56WybFB5TP6rPmKwx7o=;
        b=rFi5vweMiZzVQyrOuDbYxmkCTUm1WZiQYa3rzCNZiDJc4ou1czg4IuKIhu009xilyl
         y+ckNOSy4vMCA4kLRPgo0lfR62C1JoakfDm19xZ2GBlqWC6pyilxILIfWn3dLpjYqxrT
         //saMHfMuMYVS9lpM+G7mplduWJ+r/HK1ZqAuZA6ThUOtC2tSoGxvK/rkueDCl61t7gg
         4nWR2C5ContYHir44cbdb6CVys1xWyoxA4NyTtGbOrzJRsWKvvRK0eR54zdEHWSHChgW
         Gcm8gqdCbKlW57FsbnXqlq1fYn0mGR3SFfPwUlZPNTS5nOA//ZBDtDD2YxWqkoiy3vNu
         4RRA==
X-Gm-Message-State: AOJu0Yx1j2K0JRcnNn1Cr+IUw2OLaw9tzz1eMMegXPcAilDf+49xJbCw
	oQNF8YPLjCrffIEHiOhCw5U=
X-Google-Smtp-Source: AGHT+IHrYj01y1M36dZ16g1mgwvR0qsPgN5R91TMJr+d2pLsg+RLm1UIVt0iZtJ2NG+GPmRnm1JAIA==
X-Received: by 2002:a17:902:ba8e:b0:1d4:6486:b013 with SMTP id k14-20020a170902ba8e00b001d46486b013mr2192538pls.8.1704772276210;
        Mon, 08 Jan 2024 19:51:16 -0800 (PST)
Received: from nvrmnd.lan ([218.186.180.226])
        by smtp.gmail.com with ESMTPSA id m16-20020a170902db1000b001d4e04b4938sm647471plx.85.2024.01.08.19.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 19:51:15 -0800 (PST)
From: Vinay Varma <varmavinaym@gmail.com>
To: 
Cc: jacopo.mondi@ideasonboard.com,
	sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	Vinay Varma <varmavinaym@gmail.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: i2c: imx219: implement v4l2 selection api
Date: Tue,  9 Jan 2024 11:50:44 +0800
Message-ID: <20240109035045.552097-1-varmavinaym@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3q6andka2su7i43xz2ok44ejvtb3hdjdn6xretyde7sdcvtd7l@lz2syngckivi>
References: <3q6andka2su7i43xz2ok44ejvtb3hdjdn6xretyde7sdcvtd7l@lz2syngckivi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch exposes the hw's crop and compose capabilities by implementing
the selection API. Horizontal and vertical binning being separate
registers `imx219_binning_goodness` computes the best possible height
and width of the compose specification using the selection flags. Compose
operation updates the subdev's format object to keep them in sync.

Signed-off-by: Vinay Varma <varmavinaym@gmail.com>
---
Changes since v1:
- Rebase on media-master; fix conflicts
- Rewrap commit message to 75 chars
- Fix alignment of a constant
- Remove unnecessary braces
- Reverse christmas tree ordering of variables in new functions
---
 drivers/media/i2c/imx219.c | 223 +++++++++++++++++++++++++++++++------
 1 file changed, 191 insertions(+), 32 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index e17ef2e9d9d0..8a5fee27af45 100644
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
+#define IMX219_VTS_DEF			1763
 
 #define IMX219_VBLANK_MIN		4
 
@@ -146,6 +148,7 @@
 #define IMX219_PIXEL_ARRAY_TOP		8U
 #define IMX219_PIXEL_ARRAY_WIDTH	3280U
 #define IMX219_PIXEL_ARRAY_HEIGHT	2464U
+#define IMX219_MIN_COMPOSE_SIZE		8U
 
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
 
@@ -809,6 +814,38 @@ static int imx219_enum_frame_size(struct v4l2_subdev *sd,
 	return 0;
 }
 
+static void imx219_refresh_ctrls(struct v4l2_subdev *sd,
+				 struct v4l2_subdev_state *state,
+				 unsigned int vts_def)
+{
+	struct v4l2_mbus_framefmt *fmt = v4l2_subdev_state_get_format(state, 0);
+	struct imx219 *imx219 = to_imx219(sd);
+	int exposure_max;
+	int exposure_def;
+	int hblank;
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
@@ -816,7 +853,7 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 	struct imx219 *imx219 = to_imx219(sd);
 	const struct imx219_mode *mode;
 	struct v4l2_mbus_framefmt *format;
-	struct v4l2_rect *crop;
+	struct v4l2_rect *crop, *compose;
 	unsigned int bin_h, bin_v;
 
 	mode = v4l2_find_nearest_size(supported_modes,
@@ -842,34 +879,14 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
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
+	compose = v4l2_subdev_state_get_compose(state, 0);
+	compose->width = format->width;
+	compose->height = format->height;
+	compose->left = 0;
+	compose->top = 0;
+
+	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+		imx219_refresh_ctrls(sd, state, mode->vts_def);
 
 	return 0;
 }
@@ -884,6 +901,10 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
 		return 0;
 	}
 
+	case V4L2_SEL_TGT_COMPOSE:
+		sel->r = *v4l2_subdev_state_get_compose(state, 0);
+		return 0;
+
 	case V4L2_SEL_TGT_NATIVE_SIZE:
 		sel->r.top = 0;
 		sel->r.left = 0;
@@ -900,11 +921,148 @@ static int imx219_get_selection(struct v4l2_subdev *sd,
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
+static bool imx219_set_selection_crop(struct v4l2_subdev *sd,
+				      struct v4l2_subdev_state *sd_state,
+				      struct v4l2_subdev_selection *sel)
+{
+	struct v4l2_rect *compose, *crop;
+	struct v4l2_mbus_framefmt *fmt;
+	u32 max_binning;
+
+	crop = v4l2_subdev_state_get_crop(sd_state, 0);
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
+	compose = v4l2_subdev_state_get_compose(sd_state, 0);
+	fmt = v4l2_subdev_state_get_format(sd_state, 0);
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
+	struct v4l2_rect *compose, *crop;
+	int best_goodness;
+
+	compose = v4l2_subdev_state_get_compose(state, 0);
+	if (v4l2_rect_equal(compose, &sel->r))
+		return false;
+
+	crop = v4l2_subdev_state_get_crop(state, 0);
+	best_goodness = INT_MIN;
+	for (int i = 0; i < ARRAY_SIZE(binning_ratios); ++i) {
+		u32 width = crop->width / binning_ratios[i];
+		int goodness = imx219_binning_goodness(width, sel->r.width,
+						       sel->flags);
+
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
+
+		if (goodness > best_goodness) {
+			best_goodness = goodness;
+			compose->height = height;
+		}
+	}
+	sel->r = *compose;
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
+			v4l2_subdev_state_get_compose(sd_state, 0);
+		struct v4l2_mbus_framefmt *fmt =
+			v4l2_subdev_state_get_format(sd_state, 0);
+
+		fmt->height = compose->height;
+		fmt->width = compose->width;
+		if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+			imx219_refresh_ctrls(sd, sd_state, IMX219_VTS_DEF);
+	}
+
+	return 0;
+}
+
 static int imx219_init_state(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_state *state)
 {
@@ -937,6 +1095,7 @@ static const struct v4l2_subdev_pad_ops imx219_pad_ops = {
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = imx219_set_pad_format,
 	.get_selection = imx219_get_selection,
+	.set_selection = imx219_set_selection,
 	.enum_frame_size = imx219_enum_frame_size,
 };
 
-- 
2.43.0


