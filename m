Return-Path: <linux-kernel+bounces-147712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3058A780C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CBD2847BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA7E13D242;
	Tue, 16 Apr 2024 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz88lBYm"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925613C915;
	Tue, 16 Apr 2024 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307548; cv=none; b=G1yAwQQZ2WmhdIS8Lw6u/bTwpwds4xrv2Z7+CU+/JHOKL3jGc9DfClUeXQTKkx7yuUCIrLC4mNr+X6YA7lDhsQijJJd38kUwdy8IYV5ce/eXVY8tDgPEt5Kqd8b8/yrlqu9IfezTpOCB6sZmrFFlU9Wk0kOix/t34HcEz6/F8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307548; c=relaxed/simple;
	bh=m9CFC3S9xdi685DiojYl567zsahvLdjx6bORHbJsrUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5f8uYjWzk4wvi5WiTjIX9vz/6tSptTB5eF5aZx4y1SYQLnBeKIAmvt4muX+eK2tqagWTtNRQptDszE2gCTdc7PZvHJ79LLop4HXNBG7um3B+xFNbhov7+23ZuCrRINN6psNEeMm5ul4lNmGO+5Xc6SIQQaTBWUmGxEtUPJrPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz88lBYm; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so48865931fa.3;
        Tue, 16 Apr 2024 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307544; x=1713912344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIGVqgD2Rn8KY+nqi4UbhbJ6rG2DCyQeOTXHZE77sPQ=;
        b=bz88lBYmjZMrnfra1HzKLQL8Gp8t+wlYyByoIDCq9r0c8m4DUFXeERpO1AxI/GdVGi
         YR59EPu8dJYEow+kUfUHkjJ7r3xoX1Q9UynpeYrLfSpbp6iUyrcmGW5z55dSH5N8JMJp
         vGd32x3FU31KsrxQCzAszim+Ow4atvpmcKkHMWgiJu+dQ6LA72ueDkLwVm5/xFBeL9J4
         gqCEcXCv6Rn7euTIng0ZWJYaXGMBcD5j+lkkTWh47TRgq7PVV78dxEYeMqmpRG34l8d+
         Q6Pfh06fo5dViP9oMMnIUimaLOU0hGgk+XRTlCJDhOCrRmD1TmHo2tZtSIk3cMxL803g
         fJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307544; x=1713912344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIGVqgD2Rn8KY+nqi4UbhbJ6rG2DCyQeOTXHZE77sPQ=;
        b=qCw+XqmlKz1B5JV/A61HuCeBPXRomRVad3wXqI/Ut4PwQ5jEENyzbhclyfpI5JlY+s
         6DwDydhYlXfI5HKoevZDlylxQbRJ3dDBa06xzhk/bcuERAtABfBI8MLRT1EIuxP9w2hc
         D8CsFQwYgMsVfmGJQqE5am5046Q6e6m3zPYZR15gGcRi8VVLP6OyCIfkhVePpTpGJYcA
         3Kr88FlMTpdk2NPCPQWpVAxihJ2ugf3WZL+4W6S3YgzUft+CCVH/LhWnBNxTgGQWEpiW
         np9ZWOnZXLy9aub+goiSn5y82Ipp+6jTXV7G9BOUNjSTrex0MXi4gz3BizpRn/ZARgT1
         UZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1+A3zijpUYpTrVFWjduedByy0xZPaGBrC3HmlHCZBbHA4Ewhm3VoEprQqut5OmXLwBJR0DWp/5be7rmHtYJYkGbFWhoGy2Yor3iA
X-Gm-Message-State: AOJu0YxSzyYJBKThkhXvHvdFMST52viqWGka0KWFRd1n3xgRjNad0qCU
	PQSzjhKeIU1oT13ZpYiXU3MdW3wFCTWfM8oqJASsIoGmScDdF1ZPlLAaTAJuieU=
X-Google-Smtp-Source: AGHT+IHs2NGWFAPmERxTGL+gsDdRK02P16sQp5TY0po/RJfR+9tB9Ko+hbbIAdKVq3tT7vKzZEPVTg==
X-Received: by 2002:a2e:965a:0:b0:2d6:c29c:a4e9 with SMTP id z26-20020a2e965a000000b002d6c29ca4e9mr8630177ljh.22.1713307543929;
        Tue, 16 Apr 2024 15:45:43 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id u22-20020a2e8456000000b002da25e60918sm1214638ljh.18.2024.04.16.15.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:43 -0700 (PDT)
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
Subject: [PATCH v5 11/16] media: i2c: ov4689: Make horizontal blanking configurable
Date: Wed, 17 Apr 2024 01:45:19 +0300
Message-ID: <20240416224524.1511357-12-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416224524.1511357-1-mike.rudenko@gmail.com>
References: <20240416224524.1511357-1-mike.rudenko@gmail.com>
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
index 31352838c3ff..e478c1f7a8c2 100644
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
 	{ CCI_REG8(0x3801), 0x08 }, /* H_CROP_START_L h_crop_start[7:0] = 0x08 */
 	{ CCI_REG8(0x3805), 0x97 }, /* H_CROP_END_L h_crop_end[7:0] = 0x97 */
-	{ CCI_REG8(0x380c), 0x0a }, /* TIMING_HTS_H hts[14:8] = 0x0a */
-	{ CCI_REG8(0x380d), 0x0e }, /* TIMING_HTS_L hts[7:0] = 0x0e */
 	{ CCI_REG8(0x3811), 0x08 }, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
 	{ CCI_REG8(0x3813), 0x04 }, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
 	{ CCI_REG8(0x3819), 0x01 }, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
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


