Return-Path: <linux-kernel+bounces-128377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E45C895A15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC635B26AAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAD815B575;
	Tue,  2 Apr 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikvyG4o7"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7A15A490;
	Tue,  2 Apr 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076394; cv=none; b=IMrpDc6abh0bJVc/vDGbjAxSCeUfFB+mKtWTmXTS4FIMR2xpUSwtWwGwqhoHnKl/kAbFq7jShfwnnvABP6Kd8pkUN2sopcSDGoCJL7OkEdoZ5Dwwpse4i8Uj+dgWBHFpbWct9VqRnCJ6HfpqmclV3+oumub0wanpfC7kz8ETFn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076394; c=relaxed/simple;
	bh=RzFpSKKrcE3MpauaojLclAEIst4A9pAAW2pTkFFPP4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwvyK3xnRlw5XVWuAEU//SX1GRmSDBjJ3xe6taBUFWqnHjH3Q3XCm+wUdMlcLcCnB5ddx2Ds8m5Bc4tLkRpDjAKCfIPwqOH+EwRCBwb09sSiKioMAtN9QgagRNZWAnB7LoGeADcxZgUcK/Su4VpU6D6H7siZLBUwGpZCMI2a6Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikvyG4o7; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516b80252c5so1233762e87.3;
        Tue, 02 Apr 2024 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076390; x=1712681190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJK2d/uG1TYIjz/7l/e24P9C1r0gQRp4/WvK+GKAQYk=;
        b=ikvyG4o7V+KD4BhotuAMeGNDPPnZnL0cCHFqgdzAQ6jdmd1QnRofpT1OWr1xiFjxoo
         qnduZ2jO9LlHkgo/6+u67oRUmP3gHmaonMBnAyPvorbqy4gBwbVy7V+uoZXhH3vQO+ZA
         g7RpDffIBWkEPxL5m8oZ9+fJs7XiHnqddfnYTy/uNQKTimOhUzhUynYNQvxKLGZr4s+z
         agk4dp9PgFR2Ahseden231nnFc/wncuwSolLBxchUYSCyEEsD5G3oKw7PJgkUNZ+LUH+
         DY6iErK94DD1+f4OXejicZSyvYhtsxNdqRoSBaQtBMZuwoP8bCleb4U66qh8SH2XJqJr
         5mdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076390; x=1712681190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJK2d/uG1TYIjz/7l/e24P9C1r0gQRp4/WvK+GKAQYk=;
        b=Yy/38OFxnMHP4LBuxNy60aP+8AcUjzEPxIc0hc9yeRMImCPSw53Tfrb9zW6ePANQIp
         myCMVR1a0JkzpVaTciyMotuRzki8aJfpzhoATRTvzNZ2Bb7dYfOdIFYqYuiUh7zEsk7X
         pZwixJodPN3AiN/3RzheNo4V8k562NEN4rVRo+7d14cVZeHP6bWTPJomoismYB81nDiZ
         Weolgu2DROIFl2izokeIgSQ8n1ScmF20fZWY9XpvtAwgNh+MTUpdKdCOqS4IAVEiHf0/
         WxsLwuvu8sg0eAcJfEPzXVIH00yItH6pzWpB3nqjsDKQtRU4QA+5dCMBvzWpWN2SwXN/
         ALFw==
X-Forwarded-Encrypted: i=1; AJvYcCUAiJeRKt4Ss3X2+aWf4g6Ho/wSRR/ffZc9ef+IwiZc6PjY5lp+8TBGAqGxhIex06DdCl30jFhEZltg5/H0uer6NyyraJOSY1lndY2G
X-Gm-Message-State: AOJu0Yw5lJ9SmTkXADfHDCKTVsZ2FAHaDS5fRzPFUZfYKH1+QLFCebUc
	R/cnddJZnW85sYutBaITwlA+MJURaf6lrGFtRzexwZg33jVx8pquhdP//cE6cQZfaQ==
X-Google-Smtp-Source: AGHT+IFSUv4FFlQ8KaA5RNyID5dwzfl7eAxNA8kQVnzaXE8i/tBTRO3Rq2yi0QNxcwZZmCrNidCThw==
X-Received: by 2002:a19:ac03:0:b0:516:a213:46d2 with SMTP id g3-20020a19ac03000000b00516a21346d2mr6370163lfc.69.1712076389446;
        Tue, 02 Apr 2024 09:46:29 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id p23-20020a19f017000000b00516b4125e28sm279936lfc.20.2024.04.02.09.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:29 -0700 (PDT)
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
Subject: [PATCH v4 11/20] media: i2c: ov4689: Make horizontal blanking configurable
Date: Tue,  2 Apr 2024 19:45:42 +0300
Message-ID: <20240402164552.19171-12-mike.rudenko@gmail.com>
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
2.44.0


