Return-Path: <linux-kernel+bounces-165493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB38B8D36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A58B28A9EC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEA213440F;
	Wed,  1 May 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="NzNCnMkK"
Received: from mail-108-mta223.mxroute.com (mail-108-mta223.mxroute.com [136.175.108.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A1130A6B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577519; cv=none; b=GKlt+HZ3P0aa+CTobGod+YRlHnVIRA7eRkzkZPXKpZklGdme3npJFxk2z6gUq1fXCWwbfBVK+BJUNVt0ngrpc+ThEPEun/WBGAp1N7ipLIMCNRIacIjwxbk5h+yygR5L6E+Jh5IOYcxnmgGZIQfdXDQPKsfDYFFQNI7Yad1BI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577519; c=relaxed/simple;
	bh=QmPjBLQG9aOEYbUtznTGPd79fnS6w6xjFP1zW/w1XI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAOGnMrcpQjSrOsdkJcmhZBvJBIS50Sso0YZ8Ap7d/vkKs89VW1wE3DwwFmjggxEWNGmfIXFui6Cvxg3DN8CMZYPC/7KEf59SsNjjmeuFipSQ6LniJX93jRclrl8lMbI+v4d0Q7gCs7582KWz7feQ3mT+LH+Y+IUxgRYvKH2TWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=NzNCnMkK; arc=none smtp.client-ip=136.175.108.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta223.mxroute.com (ZoneMTA) with ESMTPSA id 18f34c2fcd30008ca2.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 May 2024 15:25:45 +0000
X-Zone-Loop: 8bf553c439d75ee06f73a57435a49f12758ed60db998
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8DfpOiOatSFelR7+oCkigfhbjrDa6jazPRZ3mzGqo9c=; b=NzNCnMkK7QuQ4NKJtBPEsbGe1T
	45S1vVAFo4W1xJ/o0AFb3U+QjRADQzfu0UktKFJXCoKkEPysCV3NPSn22z8bRVIQRL0KL3lwc/ZNm
	jc1a8/oRBe5RSgCssnhTop3ZBT9CU8iS8MQnneOMjVfmCBGBxkNMTIYYba+gZBhu0e1z8fvG56f2y
	Xf5j9TdBjwd2a3FsOZDh18JmV6siM7oZANXVJgiuv+0RWBlyJXTdVR9f9TEEsVSNhB6DHkr74rRcG
	Jzz5EDAHkBjmeuI9F55mmjTiOJ031+ygmzmgukv2+I8qiyvHkqjnqnTo+w58TZ629Ps12jUrhEnW6
	9hufvvfw==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>
Subject: [PATCH v5 20/25] media: i2c: imx258: Make HFLIP and VFLIP controls writable
Date: Wed,  1 May 2024 09:24:37 -0600
Message-ID: <20240501152442.1072627-21-git@luigi311.com>
In-Reply-To: <20240501152442.1072627-1-git@luigi311.com>
References: <20240501152442.1072627-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The sensor supports H & V flips, but the controls were READ_ONLY.

Note that the Bayer order changes with these flips, therefore
they set the V4L2_CTRL_FLAG_MODIFY_LAYOUT property.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/imx258.c | 100 ++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 54f7625e60a3..f043200e336e 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -78,8 +78,8 @@
 
 /* Orientation */
 #define REG_MIRROR_FLIP_CONTROL		0x0101
-#define REG_CONFIG_MIRROR_FLIP		0x03
-#define REG_CONFIG_FLIP_TEST_PATTERN	0x02
+#define REG_CONFIG_MIRROR_HFLIP		0x01
+#define REG_CONFIG_MIRROR_VFLIP		0x02
 
 /* IMX258 native and active pixel array size. */
 #define IMX258_NATIVE_WIDTH		4224U
@@ -484,6 +484,23 @@ static const struct imx258_variant_cfg imx258_pdaf_cfg = {
 	.num_regs = ARRAY_SIZE(imx258_pdaf_cfg_regs),
 };
 
+/*
+ * The supported formats.
+ * This table MUST contain 4 entries per format, to cover the various flip
+ * combinations in the order
+ * - no flip
+ * - h flip
+ * - v flip
+ * - h&v flips
+ */
+static const u32 codes[] = {
+	/* 10-bit modes. */
+	MEDIA_BUS_FMT_SRGGB10_1X10,
+	MEDIA_BUS_FMT_SGRBG10_1X10,
+	MEDIA_BUS_FMT_SGBRG10_1X10,
+	MEDIA_BUS_FMT_SBGGR10_1X10
+};
+
 static const char * const imx258_test_pattern_menu[] = {
 	"Disabled",
 	"Solid Colour",
@@ -670,6 +687,8 @@ struct imx258 {
 	struct v4l2_ctrl *vblank;
 	struct v4l2_ctrl *hblank;
 	struct v4l2_ctrl *exposure;
+	struct v4l2_ctrl *hflip;
+	struct v4l2_ctrl *vflip;
 
 	/* Current mode */
 	const struct imx258_mode *cur_mode;
@@ -768,9 +787,23 @@ static int imx258_write_regs(struct imx258 *imx258,
 	return 0;
 }
 
+/* Get bayer order based on flip setting. */
+static u32 imx258_get_format_code(const struct imx258 *imx258)
+{
+	unsigned int i;
+
+	lockdep_assert_held(&imx258->mutex);
+
+	i = (imx258->vflip->val ? 2 : 0) |
+	    (imx258->hflip->val ? 1 : 0);
+
+	return codes[i];
+}
+
 /* Open sub-device */
 static int imx258_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 {
+	struct imx258 *imx258 = to_imx258(sd);
 	struct v4l2_mbus_framefmt *try_fmt =
 		v4l2_subdev_state_get_format(fh->state, 0);
 	struct v4l2_rect *try_crop;
@@ -778,7 +811,7 @@ static int imx258_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 	/* Initialize try_fmt */
 	try_fmt->width = supported_modes[0].width;
 	try_fmt->height = supported_modes[0].height;
-	try_fmt->code = MEDIA_BUS_FMT_SBGGR10_1X10;
+	try_fmt->code = imx258_get_format_code(imx258);
 	try_fmt->field = V4L2_FIELD_NONE;
 
 	/* Initialize try_crop */
@@ -871,10 +904,6 @@ static int imx258_set_ctrl(struct v4l2_ctrl *ctrl)
 		ret = imx258_write_reg(imx258, IMX258_REG_TEST_PATTERN,
 				IMX258_REG_VALUE_16BIT,
 				ctrl->val);
-		ret = imx258_write_reg(imx258, REG_MIRROR_FLIP_CONTROL,
-				IMX258_REG_VALUE_08BIT,
-				!ctrl->val ? REG_CONFIG_MIRROR_FLIP :
-				REG_CONFIG_FLIP_TEST_PATTERN);
 		break;
 	case V4L2_CID_WIDE_DYNAMIC_RANGE:
 		if (!ctrl->val) {
@@ -897,6 +926,15 @@ static int imx258_set_ctrl(struct v4l2_ctrl *ctrl)
 				       IMX258_REG_VALUE_16BIT,
 				       imx258->cur_mode->height + ctrl->val);
 		break;
+	case V4L2_CID_VFLIP:
+	case V4L2_CID_HFLIP:
+		ret = imx258_write_reg(imx258, REG_MIRROR_FLIP_CONTROL,
+				       IMX258_REG_VALUE_08BIT,
+				       (imx258->hflip->val ?
+					REG_CONFIG_MIRROR_HFLIP : 0) |
+				       (imx258->vflip->val ?
+					REG_CONFIG_MIRROR_VFLIP : 0));
+		break;
 	default:
 		dev_info(&client->dev,
 			 "ctrl(id:0x%x,val:0x%x) is not handled\n",
@@ -918,11 +956,13 @@ static int imx258_enum_mbus_code(struct v4l2_subdev *sd,
 				  struct v4l2_subdev_state *sd_state,
 				  struct v4l2_subdev_mbus_code_enum *code)
 {
-	/* Only one bayer order(GRBG) is supported */
+	struct imx258 *imx258 = to_imx258(sd);
+
+	/* Only one bayer format (10 bit) is supported */
 	if (code->index > 0)
 		return -EINVAL;
 
-	code->code = MEDIA_BUS_FMT_SBGGR10_1X10;
+	code->code = imx258_get_format_code(imx258);
 
 	return 0;
 }
@@ -931,10 +971,11 @@ static int imx258_enum_frame_size(struct v4l2_subdev *sd,
 				  struct v4l2_subdev_state *sd_state,
 				  struct v4l2_subdev_frame_size_enum *fse)
 {
+	struct imx258 *imx258 = to_imx258(sd);
 	if (fse->index >= ARRAY_SIZE(supported_modes))
 		return -EINVAL;
 
-	if (fse->code != MEDIA_BUS_FMT_SBGGR10_1X10)
+	if (fse->code != imx258_get_format_code(imx258))
 		return -EINVAL;
 
 	fse->min_width = supported_modes[fse->index].width;
@@ -945,12 +986,13 @@ static int imx258_enum_frame_size(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static void imx258_update_pad_format(const struct imx258_mode *mode,
+static void imx258_update_pad_format(struct imx258 *imx258,
+				     const struct imx258_mode *mode,
 				     struct v4l2_subdev_format *fmt)
 {
 	fmt->format.width = mode->width;
 	fmt->format.height = mode->height;
-	fmt->format.code = MEDIA_BUS_FMT_SBGGR10_1X10;
+	fmt->format.code = imx258_get_format_code(imx258);
 	fmt->format.field = V4L2_FIELD_NONE;
 }
 
@@ -962,7 +1004,7 @@ static int __imx258_get_pad_format(struct imx258 *imx258,
 		fmt->format = *v4l2_subdev_state_get_format(sd_state,
 							    fmt->pad);
 	else
-		imx258_update_pad_format(imx258->cur_mode, fmt);
+		imx258_update_pad_format(imx258, imx258->cur_mode, fmt);
 
 	return 0;
 }
@@ -998,13 +1040,12 @@ static int imx258_set_pad_format(struct v4l2_subdev *sd,
 
 	mutex_lock(&imx258->mutex);
 
-	/* Only one raw bayer(GBRG) order is supported */
-	fmt->format.code = MEDIA_BUS_FMT_SBGGR10_1X10;
+	fmt->format.code = imx258_get_format_code(imx258);
 
 	mode = v4l2_find_nearest_size(supported_modes,
 		ARRAY_SIZE(supported_modes), width, height,
 		fmt->format.width, fmt->format.height);
-	imx258_update_pad_format(mode, fmt);
+	imx258_update_pad_format(imx258, mode, fmt);
 	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY) {
 		framefmt = v4l2_subdev_state_get_format(sd_state, fmt->pad);
 		*framefmt = fmt->format;
@@ -1154,15 +1195,6 @@ static int imx258_start_streaming(struct imx258 *imx258)
 		return ret;
 	}
 
-	/* Set Orientation be 180 degree */
-	ret = imx258_write_reg(imx258, REG_MIRROR_FLIP_CONTROL,
-			       IMX258_REG_VALUE_08BIT, REG_CONFIG_MIRROR_FLIP);
-	if (ret) {
-		dev_err(&client->dev, "%s failed to set orientation\n",
-			__func__);
-		return ret;
-	}
-
 	/* Apply customized values from user */
 	ret =  __v4l2_ctrl_handler_setup(imx258->sd.ctrl_handler);
 	if (ret)
@@ -1315,7 +1347,6 @@ static int imx258_init_controls(struct imx258 *imx258)
 	struct i2c_client *client = v4l2_get_subdevdata(&imx258->sd);
 	const struct imx258_link_freq_config *link_freq_cfgs;
 	struct v4l2_fwnode_device_properties props;
-	struct v4l2_ctrl *vflip, *hflip;
 	struct v4l2_ctrl_handler *ctrl_hdlr;
 	const struct imx258_link_cfg *link_cfg;
 	s64 vblank_def;
@@ -1340,16 +1371,15 @@ static int imx258_init_controls(struct imx258 *imx258)
 	if (imx258->link_freq)
 		imx258->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
-	/* The driver only supports one bayer order and flips by default. */
-	hflip = v4l2_ctrl_new_std(ctrl_hdlr, &imx258_ctrl_ops,
-				  V4L2_CID_HFLIP, 1, 1, 1, 1);
-	if (hflip)
-		hflip->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	imx258->hflip = v4l2_ctrl_new_std(ctrl_hdlr, &imx258_ctrl_ops,
+					  V4L2_CID_HFLIP, 0, 1, 1, 1);
+	if (imx258->hflip)
+		imx258->hflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
-	vflip = v4l2_ctrl_new_std(ctrl_hdlr, &imx258_ctrl_ops,
-				  V4L2_CID_VFLIP, 1, 1, 1, 1);
-	if (vflip)
-		vflip->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	imx258->vflip = v4l2_ctrl_new_std(ctrl_hdlr, &imx258_ctrl_ops,
+					  V4L2_CID_VFLIP, 0, 1, 1, 1);
+	if (imx258->vflip)
+		imx258->vflip->flags |= V4L2_CTRL_FLAG_MODIFY_LAYOUT;
 
 	link_freq_cfgs = &imx258->link_freq_configs[0];
 	link_cfg = link_freq_cfgs[imx258->lane_mode_idx].link_cfg;
-- 
2.44.0


