Return-Path: <linux-kernel+bounces-4203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3367B817914
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6AB1F26B26
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F117CCF9;
	Mon, 18 Dec 2023 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqYJWlQA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570F7BF1E;
	Mon, 18 Dec 2023 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50bf3efe2cbso3902119e87.2;
        Mon, 18 Dec 2023 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921284; x=1703526084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHqK0z9IV6ZOZWTMnd7JXt+0Ad1t2MqCYHzreFmr3TI=;
        b=KqYJWlQAqXL44D+SgOZTUKoAR9vXNBoYIPumTOB52XCdswIemi9CDqWxgZWVzg9zvJ
         HxpfhSiShEToEKVBUZzm/GrCWpxaA/P99Nq7/Qo6SfjRufz58TwVpg4FW6oCSE3w9fmQ
         IuQyLvp0BCo4S4GY+hxwiD/qvHWutHZaDl8uPlyjzmI4ml2xrJpFnT/D1Ig8zX8mbQD6
         EA7WSZJcb2jbJQ1u66HvlnZzEKwX+B1UBNxepsRK89A57psoweL8cCE8g+SUkOlsX+uZ
         k7jQls4MHC85fyAe3uqhYgP7wyMD92NU3ClqqcYZV8MmlMjCN+fI2WxsUgQZ2bdVy/VE
         LM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921284; x=1703526084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHqK0z9IV6ZOZWTMnd7JXt+0Ad1t2MqCYHzreFmr3TI=;
        b=Y7SkKP+ghhjTpN7F7dbW209nsYbMVkEtdC90W4F7v1hTof7YO+6ch8gxtUCXLkOn5K
         K6I2ktIVYdqZjEFjLLDgdzPI6iWjMP83tpkJ+pCvD3oLqH7mC9CZ4QfXv1tAj6stFDm4
         lv06pPoxUrmFdc5uhWMoki95DfCMBS91sMJYgpvOzBFlul1DiCMdrRaWtlVlhmLh/WVV
         ZkXscd4aF/zdgWSPtOSAQSnWwFsyI6K/2jbuYz9ls5EPCGkIEHvHLoLkUze+bptx/gUS
         lQCKF0lH5SqxRnQOQoBT6XZEussWYS9kUjmNqJIgMMGU7SPrFpkDNqd3ud6ny11QHmBt
         cAPA==
X-Gm-Message-State: AOJu0YyhMHrlENDptJioij/WjHRBYXppac+/IdT8BSZv+EXlWiApxJfh
	vt8iz2C9ImolcLODECXIbSjRijPNbR9jHQ==
X-Google-Smtp-Source: AGHT+IEpb4sp6Kfh0nmEz0ULo0Gw9gQBAtjjzpl6Cjjh4YC8PN0rOvZ8HtxbANHht7INMJlMwxwMug==
X-Received: by 2002:a05:6512:21cf:b0:50b:e29b:2f01 with SMTP id d15-20020a05651221cf00b0050be29b2f01mr3241140lft.264.1702921284219;
        Mon, 18 Dec 2023 09:41:24 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25628000000b0050bfd8cc09bsm2958946lff.149.2023.12.18.09.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:23 -0800 (PST)
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
Subject: [PATCH v2 18/20] media: i2c: ov4689: Eliminate struct ov4689_mode
Date: Mon, 18 Dec 2023 20:40:39 +0300
Message-ID: <20231218174042.794012-19-mike.rudenko@gmail.com>
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

With the output frame size now controlled by selection rather than
cur_mode, this commit relocates pixel rate and default VTS to
defines. Consequently, it removes struct ov4689_mode and the cur_mode
field from struct ov4689.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 70 +++++++++-----------------------------
 1 file changed, 17 insertions(+), 53 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index d2d3e5517576..e997c3231e85 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -57,6 +57,8 @@
 #define OV4689_HTS_MAX			0x7fff
 
 #define OV4689_REG_VTS			CCI_REG16(0x380e)
+/* Default VTS corresponds to 30 fps at default crop and minimal HTS */
+#define OV4689_VTS_DEF			4683
 #define OV4689_VTS_MAX			0x7fff
 
 #define OV4689_REG_H_WIN_OFF		CCI_REG16(0x3810)
@@ -94,6 +96,7 @@
 
 #define OV4689_LANES			4
 #define OV4689_XVCLK_FREQ		24000000
+#define OV4689_PIXEL_RATE		480000000
 
 #define OV4689_PIXEL_ARRAY_WIDTH	2720
 #define OV4689_PIXEL_ARRAY_HEIGHT	1536
@@ -119,24 +122,6 @@ static const char *const ov4689_supply_names[] = {
 	"dvdd", /* Digital core power */
 };
 
-enum ov4689_mode_id {
-	OV4689_MODE_2688_1520 = 0,
-	OV4689_NUM_MODES,
-};
-
-struct ov4689_mode {
-	enum ov4689_mode_id id;
-	u32 width;
-	u32 height;
-	u32 hts_def;
-	u32 hts_min;
-	u32 vts_def;
-	u32 exp_def;
-	u32 pixel_rate;
-	const struct cci_reg_sequence *reg_list;
-	unsigned int num_regs;
-};
-
 struct ov4689 {
 	struct device *dev;
 	struct regmap *regmap;
@@ -152,8 +137,6 @@ struct ov4689 {
 
 	struct v4l2_ctrl_handler ctrl_handler;
 	struct v4l2_ctrl *exposure, *hblank, *vblank;
-
-	const struct ov4689_mode *cur_mode;
 };
 
 #define to_ov4689(sd) container_of(sd, struct ov4689, subdev)
@@ -172,7 +155,7 @@ struct ov4689_gain_range {
  * max_framerate 90fps
  * mipi_datarate per lane 1008Mbps
  */
-static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
+static const struct cci_reg_sequence ov4689_common_regs[] = {
 	/* System control*/
 	{CCI_REG8(0x0103), 0x01}, /* SC_CTRL0103 software_reset = 1 */
 	{CCI_REG8(0x3000), 0x20}, /* SC_CMMN_PAD_OEN0 FSIN_output_enable = 1 */
@@ -273,21 +256,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{CCI_REG8(0x5503), 0x0f}, /* OTP_DPC_END_L otp_end_address[7:0] = 0x0f */
 };
 
-static const struct ov4689_mode supported_modes[] = {
-	{
-		.id = OV4689_MODE_2688_1520,
-		.width = 2688,
-		.height = 1520,
-		.exp_def = 1536,
-		.hts_def = 10296,
-		.hts_min = 3432,
-		.vts_def = 1554,
-		.pixel_rate = 480000000,
-		.reg_list = ov4689_2688x1520_regs,
-		.num_regs = ARRAY_SIZE(ov4689_2688x1520_regs),
-	},
-};
-
 static const u64 link_freq_menu_items[] = { 504000000 };
 
 static const char *const ov4689_test_pattern_menu[] = {
@@ -584,8 +552,8 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 			goto unlock_and_return;
 
 		ret = cci_multi_reg_write(ov4689->regmap,
-					  ov4689->cur_mode->reg_list,
-					  ov4689->cur_mode->num_regs,
+					  ov4689_common_regs,
+					  ARRAY_SIZE(ov4689_common_regs),
 					  NULL);
 		if (ret) {
 			pm_runtime_put_sync(dev);
@@ -863,14 +831,12 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 	struct i2c_client *client = v4l2_get_subdevdata(&ov4689->subdev);
 	struct v4l2_fwnode_device_properties props;
 	struct v4l2_ctrl_handler *handler;
-	const struct ov4689_mode *mode;
 	s64 exposure_max, vblank_def;
-	s64 hblank_def, hblank_min;
 	struct v4l2_ctrl *ctrl;
+	s64 hblank_def;
 	int ret;
 
 	handler = &ov4689->ctrl_handler;
-	mode = ov4689->cur_mode;
 	ret = v4l2_ctrl_handler_init(handler, 15);
 	if (ret)
 		return ret;
@@ -881,26 +847,26 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	v4l2_ctrl_new_std(handler, NULL, V4L2_CID_PIXEL_RATE, 0,
-			  mode->pixel_rate, 1, mode->pixel_rate);
+			  OV4689_PIXEL_RATE, 1, OV4689_PIXEL_RATE);
 
-	hblank_def = mode->hts_def - mode->width;
-	hblank_min = mode->hts_min - mode->width;
+	hblank_def = ov4689_hts_min(OV4689_H_OUTPUT_SIZE_DEFAULT) -
+		     OV4689_H_OUTPUT_SIZE_DEFAULT;
 	ov4689->hblank = v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops,
-					   V4L2_CID_HBLANK, hblank_min,
-					   OV4689_HTS_MAX - mode->width,
+					   V4L2_CID_HBLANK, hblank_def,
+					   OV4689_HTS_MAX - OV4689_H_OUTPUT_SIZE_DEFAULT,
 					   OV4689_HTS_DIVIDER, hblank_def);
 
-	vblank_def = mode->vts_def - mode->height;
+	vblank_def = OV4689_VTS_DEF - OV4689_V_OUTPUT_SIZE_DEFAULT;
 	ov4689->vblank = v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops,
 					   V4L2_CID_VBLANK, OV4689_VBLANK_MIN,
-					   OV4689_VTS_MAX - mode->height, 1,
-					   vblank_def);
+					   OV4689_VTS_MAX - OV4689_V_OUTPUT_SIZE_DEFAULT,
+					   1, vblank_def);
 
-	exposure_max = mode->vts_def - 4;
+	exposure_max = OV4689_VTS_DEF - 4;
 	ov4689->exposure =
 		v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_EXPOSURE,
 				  OV4689_EXPOSURE_MIN, exposure_max,
-				  OV4689_EXPOSURE_STEP, mode->exp_def);
+				  OV4689_EXPOSURE_STEP, exposure_max);
 
 	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_ANALOGUE_GAIN,
 			  ov4689_gain_ranges[0].logical_min,
@@ -1055,8 +1021,6 @@ static int ov4689_probe(struct i2c_client *client)
 
 	ov4689->dev = dev;
 
-	ov4689->cur_mode = &supported_modes[OV4689_MODE_2688_1520];
-
 	ov4689->xvclk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(ov4689->xvclk))
 		return dev_err_probe(dev, PTR_ERR(ov4689->xvclk),
-- 
2.43.0


