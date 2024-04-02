Return-Path: <linux-kernel+bounces-128383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C684A895A23
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17408B280D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109261598FE;
	Tue,  2 Apr 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvAggzOI"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BE115D5D0;
	Tue,  2 Apr 2024 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076408; cv=none; b=hSFgy/nVlHnp4/RJC8Ku6GeVB3SBySzTsis55hMxahhnUbQx3mMP2wrptCaRCBlixsRVSfVf5nlOU0UCtgDh0OmE5m8FPf4JlJKCfhtQNzrI56NLeOkAql5bMz4IZjYoBqPHMJP8X2rDr/g2UNVgq0oL/Iie6nNxl7jPCv7hlcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076408; c=relaxed/simple;
	bh=zGtceHW/mP3xG38cn1DELrT+RqT+ddVvufN7PUJAceE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNOcAGJCp+7AKVvNMjH5YOjQBiL/ui2E8t59hbKp+ZtP7R/QyR36LxNYDOKtU8btfKcuKuoQrsn3zeHpPRgE40Vb5HrZn1HqQ6sCpZrqxfBHp9x/U1C68v9A7pbCHds5uWlCuIj4eQN/uJKxIoC5fQvaLWnOryTtOzlGw39t0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvAggzOI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-515d55ab035so2334686e87.2;
        Tue, 02 Apr 2024 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076404; x=1712681204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7n0wOn/YxRcGWzj6wWOulepB7Wyh9A6yoFC9z+wNv+Q=;
        b=TvAggzOI8KYHCvC3+xxtwN+zVz4rY2CUlOyeYFkZ3mUlm+KhyfpLSvBQwzI4Otf2je
         dW3dZDdpemZ0anKJ+T5Oe4VmIZLLevTvhdqfPEgg7Gx66LG5UzM3HmlVK++oTVfwGlUi
         V+9wXnCb+zu1a7A4xRywiB+a1XpgF4sdVM0PpTkyvM6DmpA9pWvUyKvB0t17Y8NhsUcE
         y9OlcLheQtbOBu4V4C9gygrge+pZ0wLURpzRCzDb8AgYK7jckbeh6jG3CnM+S257cmap
         mkU3w0AZyJKfjYb/2OFc/dtcj28HDF17/3w9lzw8Om9GrgvcQZKXC+ALxT08OjNXe9Ye
         ml9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076404; x=1712681204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7n0wOn/YxRcGWzj6wWOulepB7Wyh9A6yoFC9z+wNv+Q=;
        b=aESr4VIWmGAy7XNJ5klZ/VigcuVoEDkgyUgAaVLMebSR5FM7SSoW/g2hPYjxvtVThz
         T78I/rAvFwH0u4w54X/U1qySlaK58VT0MGpXTwDdM0J+LwVQVyNvSHP3RXcECxu8UUoK
         94oxHqFpaqNsWU5Zc3M/8Nxnuy828NIwkXB1ufyx2JYii2uFaV56+T3HFX8K6KnfPt7b
         sZcURT7VXxDZjZeKowrcbQGje9s7XkDh5L9xKGN+fwp1crJEAxpcn5R6jYNtaQF0bUQ7
         brfFV3FNpTZ/PnMOep8V7VOa0L9CEng/t95RCN8l9RbRvEh9j4f8nchwFfpnGTFUBf9V
         CeIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT8ej9SiNF6OGH9ANqizo5Mu6vBL/u4YecI1XLftHwb9AYwagGpBsMvm2IqGSh3P/scavUk3fHIzzz6Cx5O47BNB7RTnihV8UY5Opo
X-Gm-Message-State: AOJu0YwO4CvdsSWJi9K4UZWKLTIQHdaxGZBb4cyr6JB8bS4+bTmnRRTT
	zntbdvqlq2AjaJubkcq6G0BWfKUuv8cNaXFLJz/YnrKqk42MIUQm2ghKqKm12pUs9g==
X-Google-Smtp-Source: AGHT+IGB7LS9wMcFQ0S6eTDnN9bYm09RdOyuVYHNdSFSUUnkSwMDTKhVUyExFTpXH5jyhVXnjxBjNg==
X-Received: by 2002:ac2:5981:0:b0:513:cbde:8764 with SMTP id w1-20020ac25981000000b00513cbde8764mr8912100lfn.57.1712076403977;
        Tue, 02 Apr 2024 09:46:43 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id q6-20020a0565123a8600b00515b216a5basm1739682lfu.304.2024.04.02.09.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:43 -0700 (PDT)
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
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v4 17/20] media: i2c: ov4689: Configurable analogue crop
Date: Tue,  2 Apr 2024 19:45:48 +0300
Message-ID: <20240402164552.19171-18-mike.rudenko@gmail.com>
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

Implement configurable analogue crop via .set_selection call.
ov4689_init_cfg is modified to initialize default subdev selection.
Offsets are aligned to 2 to preserve Bayer order, selection width is
aligned to 4 and height to 2 to meet hardware requirements.

Experimentally discovered values of the cropping-related registers and
vfifo_read_start for various output sizes are used. Default BLC anchor
positions are used for the default analogue crop, scaling down
proportionally for the smaller crop sizes.

When analogue crop is adjusted, several consequential actions take
place: the output format is reset, exposure/vblank/hblank control
ranges and default values are adjusted accordingly. Additionally,
ov4689_set_ctrl utilizes pad crop instead of cur_mode width and
height for HTS and VTS calculation. Also, ov4689_enum_frame_sizes is
modified to report crop size as available frame size.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 276 ++++++++++++++++++++++++++++---------
 1 file changed, 212 insertions(+), 64 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 4b099213dfea..f25bc260dde2 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -45,8 +45,12 @@
 #define OV4689_REG_V_CROP_START		CCI_REG16(0x3802)
 #define OV4689_REG_H_CROP_END		CCI_REG16(0x3804)
 #define OV4689_REG_V_CROP_END		CCI_REG16(0x3806)
+
 #define OV4689_REG_H_OUTPUT_SIZE	CCI_REG16(0x3808)
+#define OV4689_H_OUTPUT_SIZE_DEFAULT	2688
+
 #define OV4689_REG_V_OUTPUT_SIZE	CCI_REG16(0x380a)
+#define OV4689_V_OUTPUT_SIZE_DEFAULT	1520
 
 #define OV4689_REG_HTS			CCI_REG16(0x380c)
 #define OV4689_HTS_DIVIDER		4
@@ -96,6 +100,19 @@
 #define OV4689_DUMMY_ROWS		8	/* 8 dummy rows on each side */
 #define OV4689_DUMMY_COLUMNS		16	/* 16 dummy columns on each side */
 
+/*
+ * These values are not hardware limits, but rather the minimums that
+ * the driver has been tested to.
+ */
+#define OV4689_H_CROP_MIN		128
+#define OV4689_V_CROP_MIN		128
+
+/*
+ * Minimum working vertical blanking value. Found experimentally at
+ * minimum HTS values.
+ */
+#define OV4689_VBLANK_MIN		31
+
 static const char *const ov4689_supply_names[] = {
 	"avdd", /* Analog power */
 	"dovdd", /* Digital I/O power */
@@ -134,7 +151,7 @@ struct ov4689 {
 	u32 clock_rate;
 
 	struct v4l2_ctrl_handler ctrl_handler;
-	struct v4l2_ctrl *exposure;
+	struct v4l2_ctrl *exposure, *hblank, *vblank;
 
 	const struct ov4689_mode *cur_mode;
 };
@@ -320,24 +337,27 @@ static const struct ov4689_gain_range ov4689_gain_ranges[] = {
 	},
 };
 
-static void ov4689_fill_fmt(const struct ov4689_mode *mode,
-			    struct v4l2_mbus_framefmt *fmt)
-{
-	fmt->code = MEDIA_BUS_FMT_SBGGR10_1X10;
-	fmt->width = mode->width;
-	fmt->height = mode->height;
-	fmt->field = V4L2_FIELD_NONE;
-}
-
 static int ov4689_set_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_state *sd_state,
 			  struct v4l2_subdev_format *fmt)
 {
-	struct v4l2_mbus_framefmt *mbus_fmt = &fmt->format;
-	struct ov4689 *ov4689 = to_ov4689(sd);
+	struct v4l2_mbus_framefmt *format;
+	struct v4l2_rect *crop;
+
+	crop = v4l2_subdev_state_get_crop(sd_state, fmt->pad);
+	format = v4l2_subdev_state_get_format(sd_state, fmt->pad);
+
+	format->width = crop->width;
+	format->height = crop->height;
 
-	/* only one mode supported for now */
-	ov4689_fill_fmt(ov4689->cur_mode, mbus_fmt);
+	format->code = MEDIA_BUS_FMT_SBGGR10_1X10;
+	format->field = V4L2_FIELD_NONE;
+	format->colorspace = V4L2_COLORSPACE_RAW;
+	format->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	format->quantization = V4L2_QUANTIZATION_FULL_RANGE;
+	format->xfer_func = V4L2_XFER_FUNC_NONE;
+
+	fmt->format = *format;
 
 	return 0;
 }
@@ -357,16 +377,20 @@ static int ov4689_enum_frame_sizes(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_state *sd_state,
 				   struct v4l2_subdev_frame_size_enum *fse)
 {
-	if (fse->index >= ARRAY_SIZE(supported_modes))
+	const struct v4l2_rect *crop;
+
+	if (fse->index >= 1)
 		return -EINVAL;
 
 	if (fse->code != MEDIA_BUS_FMT_SBGGR10_1X10)
 		return -EINVAL;
 
-	fse->min_width = supported_modes[fse->index].width;
-	fse->max_width = supported_modes[fse->index].width;
-	fse->max_height = supported_modes[fse->index].height;
-	fse->min_height = supported_modes[fse->index].height;
+	crop = v4l2_subdev_state_get_crop(sd_state, 0);
+
+	fse->min_width = crop->width;
+	fse->max_width = crop->width;
+	fse->max_height = crop->height;
+	fse->min_height = crop->height;
 
 	return 0;
 }
@@ -388,20 +412,14 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 				struct v4l2_subdev_state *state,
 				struct v4l2_subdev_selection *sel)
 {
-	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
-		return -EINVAL;
-
 	switch (sel->target) {
-	case V4L2_SEL_TGT_CROP_BOUNDS:
-		sel->r.top = 0;
-		sel->r.left = 0;
-		sel->r.width = OV4689_PIXEL_ARRAY_WIDTH;
-		sel->r.height = OV4689_PIXEL_ARRAY_HEIGHT;
-		return 0;
 	case V4L2_SEL_TGT_CROP:
+		sel->r = *v4l2_subdev_state_get_crop(state, sel->pad);
+		return 0;
+	case V4L2_SEL_TGT_CROP_BOUNDS:
 	case V4L2_SEL_TGT_CROP_DEFAULT:
-		sel->r.top = OV4689_DUMMY_ROWS;
 		sel->r.left = OV4689_DUMMY_COLUMNS;
+		sel->r.top = OV4689_DUMMY_ROWS;
 		sel->r.width =
 			OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_COLUMNS;
 		sel->r.height =
@@ -412,37 +430,141 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 	return -EINVAL;
 }
 
-static int ov4689_setup_timings(struct ov4689 *ov4689)
+/*
+ * Minimum working HTS value for given output width (found
+ * experimentally).
+ */
+static unsigned int ov4689_hts_min(unsigned int width)
+{
+	return max_t(unsigned int, 3156, 224 + width * 19 / 16);
+}
+
+static void ov4689_update_ctrl_ranges(struct ov4689 *ov4689,
+				      struct v4l2_rect *crop)
+{
+	struct v4l2_ctrl *exposure = ov4689->exposure;
+	struct v4l2_ctrl *vblank = ov4689->vblank;
+	struct v4l2_ctrl *hblank = ov4689->hblank;
+	s64 def_val, min_val, max_val;
+
+	min_val = ov4689_hts_min(crop->width) - crop->width;
+	max_val = OV4689_HTS_MAX - crop->width;
+	def_val = clamp_t(s64, hblank->default_value, min_val, max_val);
+	__v4l2_ctrl_modify_range(hblank, min_val, max_val, hblank->step,
+				 def_val);
+
+	min_val = OV4689_VBLANK_MIN;
+	max_val = OV4689_HTS_MAX - crop->width;
+	def_val = clamp_t(s64, vblank->default_value, min_val, max_val);
+	__v4l2_ctrl_modify_range(vblank, min_val, max_val, vblank->step,
+				 def_val);
+
+	min_val = exposure->minimum;
+	max_val = crop->height + vblank->val - 4;
+	def_val = clamp_t(s64, exposure->default_value, min_val, max_val);
+	__v4l2_ctrl_modify_range(exposure, min_val, max_val, exposure->step,
+				 def_val);
+}
+
+static int ov4689_set_selection(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *state,
+				struct v4l2_subdev_selection *sel)
 {
-	const struct ov4689_mode *mode = ov4689->cur_mode;
+	struct ov4689 *ov4689 = to_ov4689(sd);
+	struct v4l2_mbus_framefmt *format;
+	struct v4l2_rect *crop;
+	struct v4l2_rect rect;
+
+	if (sel->target != V4L2_SEL_TGT_CROP)
+		return -EINVAL;
+
+	rect.left = clamp(ALIGN(sel->r.left, 2), OV4689_DUMMY_COLUMNS,
+			  OV4689_PIXEL_ARRAY_WIDTH);
+	rect.top = clamp(ALIGN(sel->r.top, 2), OV4689_DUMMY_ROWS,
+			 OV4689_PIXEL_ARRAY_HEIGHT);
+
+	rect.width = clamp_t(unsigned int, ALIGN(sel->r.width, 4),
+			     OV4689_H_CROP_MIN, OV4689_PIXEL_ARRAY_WIDTH -
+			     2 * OV4689_DUMMY_COLUMNS);
+	rect.height = clamp_t(unsigned int, ALIGN(sel->r.height, 2),
+			      OV4689_V_CROP_MIN, OV4689_PIXEL_ARRAY_HEIGHT -
+			      2 * OV4689_DUMMY_ROWS);
+
+	crop = v4l2_subdev_state_get_crop(state, sel->pad);
+
+	if (rect.width != crop->width || rect.height != crop->height) {
+		/*
+		 * Reset the output image size if the crop rectangle size has
+		 * been modified.
+		 */
+		format = v4l2_subdev_state_get_format(state, sel->pad);
+		format->width = rect.width;
+		format->height = rect.height;
+
+		if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE)
+			ov4689_update_ctrl_ranges(ov4689, &rect);
+	}
+
+	*crop = rect;
+	sel->r = rect;
+
+	return 0;
+}
+
+static int ov4689_setup_timings(struct ov4689 *ov4689,
+				struct v4l2_subdev_state *state)
+{
+	const struct v4l2_mbus_framefmt *format;
 	struct regmap *rm = ov4689->regmap;
+	const struct v4l2_rect *crop;
 	int ret = 0;
 
-	cci_write(rm, OV4689_REG_H_CROP_START, 8, &ret);
-	cci_write(rm, OV4689_REG_V_CROP_START, 8, &ret);
-	cci_write(rm, OV4689_REG_H_CROP_END, 2711, &ret);
-	cci_write(rm, OV4689_REG_V_CROP_END, 1531, &ret);
+	format = v4l2_subdev_state_get_format(state, 0);
+	crop = v4l2_subdev_state_get_crop(state, 0);
+
+	cci_write(rm, OV4689_REG_H_CROP_START, crop->left, &ret);
+	cci_write(rm, OV4689_REG_V_CROP_START, crop->top, &ret);
+	cci_write(rm, OV4689_REG_H_CROP_END, crop->left + crop->width + 1, &ret);
+	cci_write(rm, OV4689_REG_V_CROP_END, crop->top + crop->height + 1, &ret);
 
-	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, mode->width, &ret);
-	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, mode->height, &ret);
+	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, format->width, &ret);
+	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, format->height, &ret);
 
-	cci_write(rm, OV4689_REG_H_WIN_OFF, 8, &ret);
-	cci_write(rm, OV4689_REG_V_WIN_OFF, 4, &ret);
+	cci_write(rm, OV4689_REG_H_WIN_OFF, 0, &ret);
+	cci_write(rm, OV4689_REG_V_WIN_OFF, 0, &ret);
 
-	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, 167, &ret);
+	/*
+	 * Maximum working value of vfifo_read_start for given output
+	 * width (found experimentally).
+	 */
+	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, format->width / 16 - 1, &ret);
 
 	return ret;
 }
 
-static int ov4689_setup_blc_anchors(struct ov4689 *ov4689)
+/*
+ * Setup black level compensation anchors. For the default frame width
+ * default anchors positions are used. For smaller crop sizes they are
+ * scaled accordingly.
+ */
+static int ov4689_setup_blc_anchors(struct ov4689 *ov4689,
+				    struct v4l2_subdev_state *state)
 {
+	unsigned int width_def = OV4689_H_OUTPUT_SIZE_DEFAULT;
 	struct regmap *rm = ov4689->regmap;
+	const struct v4l2_rect *crop;
 	int ret = 0;
 
-	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START, 16, &ret);
-	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END, 1999, &ret);
-	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START, 2400, &ret);
-	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END, 2415, &ret);
+	crop = v4l2_subdev_state_get_crop(state, 0);
+
+	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START,
+		  OV4689_ANCHOR_LEFT_START_DEF * crop->width / width_def, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END,
+		  OV4689_ANCHOR_LEFT_END_DEF * crop->width / width_def, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START,
+		  OV4689_ANCHOR_RIGHT_START_DEF * crop->width / width_def, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END,
+		  OV4689_ANCHOR_RIGHT_END_DEF * crop->width / width_def, &ret);
 
 	return ret;
 }
@@ -470,13 +592,13 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 			goto unlock_and_return;
 		}
 
-		ret = ov4689_setup_timings(ov4689);
+		ret = ov4689_setup_timings(ov4689, sd_state);
 		if (ret) {
 			pm_runtime_put(dev);
 			goto unlock_and_return;
 		}
 
-		ret = ov4689_setup_blc_anchors(ov4689);
+		ret = ov4689_setup_blc_anchors(ov4689, sd_state);
 		if (ret) {
 			pm_runtime_put(dev);
 			goto unlock_and_return;
@@ -568,10 +690,25 @@ static int __maybe_unused ov4689_power_off(struct device *dev)
 static int ov4689_init_state(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_state *sd_state)
 {
-	struct v4l2_mbus_framefmt *fmt =
-		v4l2_subdev_state_get_format(sd_state, 0);
+	u32 width_def = OV4689_H_OUTPUT_SIZE_DEFAULT;
+	u32 height_def = OV4689_V_OUTPUT_SIZE_DEFAULT;
+
+	struct v4l2_subdev_selection sel  = {
+		.target = V4L2_SEL_TGT_CROP,
+		.r.left = OV4689_DUMMY_COLUMNS,
+		.r.top = OV4689_DUMMY_ROWS,
+		.r.width = width_def,
+		.r.height = height_def,
+	};
+	struct v4l2_subdev_format format = {
+		.format = {
+			.width = width_def,
+			.height = height_def,
+		},
+	};
 
-	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], fmt);
+	ov4689_set_selection(sd, sd_state, &sel);
+	ov4689_set_fmt(sd, sd_state, &format);
 
 	return 0;
 }
@@ -590,6 +727,7 @@ static const struct v4l2_subdev_pad_ops ov4689_pad_ops = {
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = ov4689_set_fmt,
 	.get_selection = ov4689_get_selection,
+	.set_selection = ov4689_set_selection,
 };
 
 static const struct v4l2_subdev_internal_ops ov4689_internal_ops = {
@@ -635,20 +773,28 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	struct ov4689 *ov4689 =
 		container_of(ctrl->handler, struct ov4689, ctrl_handler);
 	struct regmap *regmap = ov4689->regmap;
+	struct v4l2_subdev_state *sd_state;
 	struct device *dev = ov4689->dev;
+	struct v4l2_rect *crop;
+	s64 max_expo, def_expo;
 	int sensor_gain;
-	s64 max_expo;
 	int ret = 0;
 
+	sd_state = v4l2_subdev_get_locked_active_state(&ov4689->subdev);
+	crop = v4l2_subdev_state_get_crop(sd_state, 0);
+
 	/* Propagate change of current control to all related controls */
 	switch (ctrl->id) {
 	case V4L2_CID_VBLANK:
 		/* Update max exposure while meeting expected vblanking */
-		max_expo = ov4689->cur_mode->height + ctrl->val - 4;
-		__v4l2_ctrl_modify_range(ov4689->exposure,
-					 ov4689->exposure->minimum, max_expo,
-					 ov4689->exposure->step,
-					 ov4689->exposure->default_value);
+		max_expo = crop->height + ctrl->val - 4;
+		def_expo = clamp_t(s64, ov4689->exposure->default_value,
+				   ov4689->exposure->minimum, max_expo);
+
+		ret = __v4l2_ctrl_modify_range(ov4689->exposure,
+					       ov4689->exposure->minimum,
+					       max_expo, ov4689->exposure->step,
+					       def_expo);
 		break;
 	}
 
@@ -666,14 +812,14 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_VBLANK:
 		cci_write(regmap, OV4689_REG_VTS,
-			  ctrl->val + ov4689->cur_mode->height, &ret);
+			  ctrl->val + crop->height, &ret);
 		break;
 	case V4L2_CID_TEST_PATTERN:
 		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
 		break;
 	case V4L2_CID_HBLANK:
 		cci_write(regmap, OV4689_REG_HTS,
-			  (ctrl->val + ov4689->cur_mode->width) /
+			  (ctrl->val + crop->width) /
 			  OV4689_HTS_DIVIDER, &ret);
 		break;
 	case V4L2_CID_VFLIP:
@@ -739,14 +885,16 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	hblank_def = mode->hts_def - mode->width;
 	hblank_min = mode->hts_min - mode->width;
-	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HBLANK,
-			  hblank_min, OV4689_HTS_MAX - mode->width,
-			  OV4689_HTS_DIVIDER, hblank_def);
+	ov4689->hblank = v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops,
+					   V4L2_CID_HBLANK, hblank_min,
+					   OV4689_HTS_MAX - mode->width,
+					   OV4689_HTS_DIVIDER, hblank_def);
 
 	vblank_def = mode->vts_def - mode->height;
-	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VBLANK,
-			  vblank_def, OV4689_VTS_MAX - mode->height, 1,
-			  vblank_def);
+	ov4689->vblank = v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops,
+					   V4L2_CID_VBLANK, OV4689_VBLANK_MIN,
+					   OV4689_VTS_MAX - mode->height, 1,
+					   vblank_def);
 
 	exposure_max = mode->vts_def - 4;
 	ov4689->exposure =
-- 
2.44.0


