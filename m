Return-Path: <linux-kernel+bounces-4196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87172817905
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36861F250DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB6A7AE69;
	Mon, 18 Dec 2023 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYK9cAKi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF974E11;
	Mon, 18 Dec 2023 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e2786e71fso2878247e87.0;
        Mon, 18 Dec 2023 09:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921272; x=1703526072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igV7Ve8Ucn2LM2ubX7Qcip8JZf24Gs2gYDiFdHkxUQU=;
        b=bYK9cAKiLB0u5Z33wLjDshCONzQTSmjs5bRvbSw4RwBxp27hCEsQg3PYwMjdVo8vn2
         0o1owbpZaPI9eTQwDnTGATecbKKWCiuykXBIBfFsxSkstJjLSmGQMnvDIkovChAOc8nx
         tv/mN2IXuxoLNvO9bkClM7jgJZO8umOMAaTt+8osL14tThYK55QjeRGqzMNJ3a5gsVXw
         +3FoXPWpbVWF/IZZwj7qNyAPoSToz3fZC65LQZLBFkKHI5eFf/3Tz5uvSjXm6GYgyc6v
         VKbDh1/Dq/3E/3UQE+Q4NjRtY6zmu6utFf2uP/Z/DFKW8WdIE9WaH6+2Aswo4NERFp7E
         EzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921272; x=1703526072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igV7Ve8Ucn2LM2ubX7Qcip8JZf24Gs2gYDiFdHkxUQU=;
        b=Zw3jM2rCq3Y1GyJkBek5hlnHc/oQK5sX5wREp7XY2kQ1wfWJk23j5WJLDx/Uolt2Bd
         LkzYp8ZdJy1uE1UMd+R2sjyTv8Yt4wocSH0xZx0DNwxgSeGzjSDRqEqg7mDMfDl7iZ3D
         N+eGJFy8bq5ZWjFhXO7LYa0Aa9PPe88UuvNZ+OAsmKin+TeYfECjHf/ulkP+1XtGKt1U
         f4hrhYpm0eGGUwBfS44zVgIk1bZcqTEoH3uhhtuGGByVTjO5qYd8szJXSBIVFiZTyZaC
         putZAF5B2aqMC7z1sRKRcRcugVnyPaSXuaP8ihbSqg7ideuBAKKZWLRBDB8jcf12jmEY
         Zm0Q==
X-Gm-Message-State: AOJu0Yw7lYAkTiPGJvoJtItToXJ6ZuWWGU3SFXB9nONJGTJdLyqswkFm
	jT7Ny/kIvtkL9KPxjyLiWRIJqPDQK2BXtA==
X-Google-Smtp-Source: AGHT+IEdIPR+5KEcCNv7f8DKqR65FcwbOO//8A7m0jr26KxioscuwxQg3gDh8JSe61bbNnthGdRrvw==
X-Received: by 2002:a05:6512:230d:b0:50e:3758:94d4 with SMTP id o13-20020a056512230d00b0050e375894d4mr1547865lfu.117.1702921271769;
        Mon, 18 Dec 2023 09:41:11 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id m18-20020a056512115200b0050bf6d3416asm2955631lfg.156.2023.12.18.09.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:11 -0800 (PST)
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
Subject: [PATCH v2 11/20] media: i2c: ov4689: Make horizontal blanking configurable
Date: Mon, 18 Dec 2023 20:40:32 +0300
Message-ID: <20231218174042.794012-12-mike.rudenko@gmail.com>
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

Make horizontal blanking configurable. To do so, set HTS register
according to the requested horizontal blanking in ov4689_set_ctrl
instead of the register table. Default HTS value is not changed by
this patch. Minimal HTS value is found experimentally and corresponds
to 90 fps framerate at minimum vertical blanking. Real HTS value is
the register value multiplied by 4.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index cf1303744e7c..06ed9d22b2c8 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -30,13 +30,17 @@
 #define OV4689_REG_EXPOSURE		CCI_REG24(0x3500)
 #define OV4689_EXPOSURE_MIN		4
 #define OV4689_EXPOSURE_STEP		1
-#define OV4689_VTS_MAX			0x7fff
 
 #define OV4689_REG_GAIN			CCI_REG16(0x3508)
 #define OV4689_GAIN_STEP		1
 #define OV4689_GAIN_DEFAULT		0x80
 
+#define OV4689_REG_HTS			CCI_REG16(0x380c)
+#define OV4689_HTS_DIVIDER		4
+#define OV4689_HTS_MAX			0x7fff
+
 #define OV4689_REG_VTS			CCI_REG16(0x380e)
+#define OV4689_VTS_MAX			0x7fff
 
 #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
 #define OV4689_TEST_PATTERN_ENABLE	0x80
@@ -61,6 +65,7 @@ struct ov4689_mode {
 	u32 width;
 	u32 height;
 	u32 hts_def;
+	u32 hts_min;
 	u32 vts_def;
 	u32 exp_def;
 	u32 pixel_rate;
@@ -104,7 +109,7 @@ struct ov4689_gain_range {
 
 /*
  * Xclk 24Mhz
- * max_framerate 30fps
+ * max_framerate 90fps
  * mipi_datarate per lane 1008Mbps
  */
 static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
@@ -175,8 +180,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	/* Timing control */
 	{CCI_REG8(0x3801), 0x08}, /* H_CROP_START_L h_crop_start[7:0] = 0x08 */
 	{CCI_REG8(0x3805), 0x97}, /* H_CROP_END_L h_crop_end[7:0] = 0x97 */
-	{CCI_REG8(0x380c), 0x0a}, /* TIMING_HTS_H hts[14:8] = 0x0a */
-	{CCI_REG8(0x380d), 0x0e}, /* TIMING_HTS_L hts[7:0] = 0x0e */
 	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
 	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
 	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
@@ -237,7 +240,8 @@ static const struct ov4689_mode supported_modes[] = {
 		.crop_top = 8,
 		.crop_left = 16,
 		.exp_def = 1536,
-		.hts_def = 4 * 2574,
+		.hts_def = 10296,
+		.hts_min = 3432,
 		.vts_def = 1554,
 		.pixel_rate = 480000000,
 		.reg_list = ov4689_2688x1520_regs,
@@ -598,6 +602,11 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_TEST_PATTERN:
 		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
 		break;
+	case V4L2_CID_HBLANK:
+		cci_write(regmap, OV4689_REG_HTS,
+			  (ctrl->val + ov4689->cur_mode->width) /
+			  OV4689_HTS_DIVIDER, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -622,8 +631,8 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 	struct v4l2_ctrl_handler *handler;
 	const struct ov4689_mode *mode;
 	s64 exposure_max, vblank_def;
+	s64 hblank_def, hblank_min;
 	struct v4l2_ctrl *ctrl;
-	s64 h_blank_def;
 	int ret;
 
 	handler = &ov4689->ctrl_handler;
@@ -640,11 +649,11 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 	v4l2_ctrl_new_std(handler, NULL, V4L2_CID_PIXEL_RATE, 0,
 			  mode->pixel_rate, 1, mode->pixel_rate);
 
-	h_blank_def = mode->hts_def - mode->width;
-	ctrl = v4l2_ctrl_new_std(handler, NULL, V4L2_CID_HBLANK, h_blank_def,
-				 h_blank_def, 1, h_blank_def);
-	if (ctrl)
-		ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	hblank_def = mode->hts_def - mode->width;
+	hblank_min = mode->hts_min - mode->width;
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HBLANK,
+			  hblank_min, OV4689_HTS_MAX - mode->width,
+			  OV4689_HTS_DIVIDER, hblank_def);
 
 	vblank_def = mode->vts_def - mode->height;
 	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VBLANK,
-- 
2.43.0


