Return-Path: <linux-kernel+bounces-87117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C1F86CFD2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C92281F2435B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782FF13C9C3;
	Thu, 29 Feb 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdlnhR1z"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87A134403;
	Thu, 29 Feb 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225645; cv=none; b=onSoqPX538r2lZ/DxNMRBAGsMHPcSwZok85I38fykeTwCa/MsOykEcmvlNnK1/CcQxGsbsbwAO6JQlbU7fwzIkuwql3T6fb//Yfh0p2zhOfMnkWlkj54iLUXxEgHeuDc4/33w7nfiMcnNI+EisEZdPETgKY/uLv/BGglVeWJR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225645; c=relaxed/simple;
	bh=ntVdPTcZpvBRjbwq47nv8+m3JpN9030guqT+pmZ++tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQBwWBIKaNy2bbBqm1hs7GPRNm2QXq8inPbD7L+MdA49fSjYB5cCjJuUk9oV/Xd13bNhs3qOrVF0QGeKatC1JTQD1VcSm8tP80JVv02um/oRNN7QjhjX0zTApswUbQwPSjGJlyBdOF0JZ+9GL3ya73HQB/kPvC8NWTG+vbHvhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdlnhR1z; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5132b1e66ddso589612e87.3;
        Thu, 29 Feb 2024 08:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225641; x=1709830441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYsTb5hvXEwkYOesWc/SeZgECL9fnzVJX2Zj7gHGLfY=;
        b=UdlnhR1zLPj+Q45DNaNgKr89Q2xwZ0tXVfflldIMFLfuM1gaMWUbm2mjVeZkvFsnuI
         WPzp5D+JDY0G7hNM6rnmCt7WUiNDgVtzqmktg9JZU9/ceLQOPxM0Wkdqd+1wDvS+UHPc
         h21Kyi42Jex1LzvVferXOzukTkiMHcUJSu35+i7Y5WefeKTiNL9lAthWex35w/95CPux
         HrXtRFC27y7vOrXFJgCq4vRrWOKKBEDAMeEMhSBtX5hWCQyjyG8HZC0HBzZUJ/km91Ge
         8dhlLXCv8v2jc9yEp5zqzPwOOEzhiLFZkpyVcR9/kSHqKfPzv8phudBOO//sS4Q28rqP
         XyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225641; x=1709830441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYsTb5hvXEwkYOesWc/SeZgECL9fnzVJX2Zj7gHGLfY=;
        b=QHdPeoi8OfiEWsR0Ie40h92ps+q2Mbhx36WqQAhl/AOrVv2shzO+97LmEiM2sTcXAH
         3KTd6BWXV1Q9vFHSunGqjn+FCmtEQ+IVBWluL8Z0HC9LeSrkLNMn14TT7FDRuI1KgS3b
         e8CRVt1V2VCH9MNujBCJi7HU5tqRVe3evdTGiRvCSk8fRCWcrzfvO44+8QWYu/jRhfkL
         efGUjYXeRAaUVmKOM0wppxeBhC4HR5bkGaBzUwcP8ldZV9xp7VfiielbKg4w/pAzj6+A
         J8pc4fXsH267eOtIoyswo3WtmsUhfRXXov+IXO/3+dVnd+ZurVYa9KMOigUNLfGQAtyT
         6LYw==
X-Forwarded-Encrypted: i=1; AJvYcCXlpQW7wMs2xCOFVsR8S0LMae1vo8Y12qlP02mttLbJN4JJ9QDFAfZlRv/4Qr50o42cistQNzMcwF4mZ3uvPiV4so0Pl7/82qjEVrxg
X-Gm-Message-State: AOJu0Yxtc1XR/SWkLklvwDbv7NvEUORbfvd6cKVJpDkW853UawZ9G5gp
	UngBFYcKlYQhQ4gle8/YvGjYkzg/2zw+HYODRvcnHjW2f/QhQKR6Rm233H7KA4o=
X-Google-Smtp-Source: AGHT+IGnqpX6o4NWb8fh8u0w4A3uzbC6yYUrPgejJGRlnziqqW8tBUlj7mdSKZsmf2FWG2UWQ0duxA==
X-Received: by 2002:a05:6512:1109:b0:513:1d10:decd with SMTP id l9-20020a056512110900b005131d10decdmr2379586lfg.34.1709225641435;
        Thu, 29 Feb 2024 08:54:01 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b005131cefefd8sm306169lfe.240.2024.02.29.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:54:01 -0800 (PST)
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
Subject: [PATCH v3 11/20] media: i2c: ov4689: Make horizontal blanking configurable
Date: Thu, 29 Feb 2024 19:53:24 +0300
Message-ID: <20240229165333.227484-12-mike.rudenko@gmail.com>
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
index 45f055c57436..8283a9ac86c9 100644
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


