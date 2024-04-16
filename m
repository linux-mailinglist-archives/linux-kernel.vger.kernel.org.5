Return-Path: <linux-kernel+bounces-147717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706438A7817
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6501F2137F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414A41411DE;
	Tue, 16 Apr 2024 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJvw7l9U"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80A13E052;
	Tue, 16 Apr 2024 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307554; cv=none; b=qA4QdQGppCJgm4qKa53gCWbwQgnbCIJ6ATXI1GbfFNhPFNRY433bG/vPy6ENKzmnGg6ABpGMAHtzqDha/SoXjSaxY04T/EddL7xb1Thrbbn85oOJadC9Piou4vTXWCW/++pRMEhBlLPTR4oeWrqpN+aqQngF5SJSX9wPwSnoO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307554; c=relaxed/simple;
	bh=fpjcBYWKI7/oU2A5MYkdaQS7my7qviwEtb9hhcIwAKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxFeOUK0LI2KyhoKG3QJ3v57TWYnt7baleisRQUk2BIBnEO+8YdiTfU5wa2VX1vMnL5/nWmfFcXCMHUzwIZF7fDqBQt8AphX5HoCrQLAsb3KoyZz+kg130CrcUjCGxttzfj8U2aahlpaqRyesXs+DsgbvvNuEPnWCeWee4NReGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJvw7l9U; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518c9ff3e29so3592674e87.0;
        Tue, 16 Apr 2024 15:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713307550; x=1713912350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WTz6RxNbzEeUZHtBYgSuV5IA4nML2YqNqY1OSaSBE4=;
        b=CJvw7l9U/paOx4tnDJPccXphixbSR6aEJBRAVyGk/1xvedQ8uy3IX5ki1Btr++YISR
         NR+NeVWdxXxRGlRjAEn99Dwp1kYuR1QDIvzTE7Bq9EI277hn04bmx+gr85LsTB43+BdX
         LfsuK7ZFnt6UlQ3MO3wTl34CRWzFxISY9tZEojJaGs5oQBK9OTRoR91EsLRBYFIQ9EZ2
         UqJ82uJr4jQxCeZwcDTaiKKu4G5qo4c8sjJwNq49SkBUhOd2g9ZR5KSPJe5G9Q+B2iuV
         CWd3qRpXP8xq72Xy6QOVkSD0afvr4I2QVirBadowiCj7gGv9KtmJ0zlw2ypFF8Ct/ZUV
         eo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307550; x=1713912350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WTz6RxNbzEeUZHtBYgSuV5IA4nML2YqNqY1OSaSBE4=;
        b=dfCZGpOzl6aZGQs0eLix1aqyFTuVllRvMJky037WxDZaCU7EUkm8zwsb6M7zyVL3fO
         XtM9VIsNuf4bOxjJSC4Vyc0GoD4qtvPgk4mDm002bZWB9mbIKTo3W6r544OJOuiYNllu
         p49L6G36AW0lecfGa1+WMJFLb7HO97S3BDXOOqR7dnP3cxq6Nmoa3Bg3uElL1GU81gNz
         sX/4FHf1d4bUebuszd9B3jNOIOoTb2Lhn7KdDpAiEL9+cuZSmf07W1QxzftOWxBysOyz
         jpIxjSTi46/HwOAjR3kH7qWTIKjASkKwjh+aFzA/lSXDl5q2Zu6mbfdSgV5Q1PxtcR+6
         YX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVm88chDLDbx4+/mCZbu8Us3l6VA6UkVccWJ8WMqa0mnFQrewDtdMxFdTcXQEWMq80vgmNH8LfJcfwMXCfOH81DpDnH5z2/eWSVa8hl
X-Gm-Message-State: AOJu0YwANfmJkdjXuUn2+q8eNygeDlQzPyW7ahID2ZppRtgfMsItiGk4
	1SUh+R8mBohpRgsLcrohvOwvOd13let4qB1NcD54xiShx2i03XE6DQm16BIhK1A=
X-Google-Smtp-Source: AGHT+IFRQeiSrlNFBGze9bikBICwT+4Be4weNOJX+RPDCnHjz0mCwy8ltjNBBbW+oNSi07Q9ph7pYQ==
X-Received: by 2002:a05:6512:3b98:b0:518:fb01:448e with SMTP id g24-20020a0565123b9800b00518fb01448emr4984114lfv.57.1713307549892;
        Tue, 16 Apr 2024 15:45:49 -0700 (PDT)
Received: from localhost (95-24-153-47.broadband.corbina.ru. [95.24.153.47])
        by smtp.gmail.com with ESMTPSA id eq9-20020a056512488900b00518c3eb3a9csm981831lfb.309.2024.04.16.15.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 15:45:49 -0700 (PDT)
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
Subject: [PATCH v5 16/16] media: i2c: ov4689: Set timing registers programmatically
Date: Wed, 17 Apr 2024 01:45:24 +0300
Message-ID: <20240416224524.1511357-17-mike.rudenko@gmail.com>
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

Set timing-related and BLC anchor registers via cci calls instead of
hardcoding them in the register table. This prepares the driver for
implementation of configurable analogue crop and binning. No
functional change intended.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 83 +++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 15 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 9da4f84e63b1..0c623d43c0ad 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -41,6 +41,13 @@
 #define OV4689_DIG_GAIN_STEP		1
 #define OV4689_DIG_GAIN_DEFAULT		0x800
 
+#define OV4689_REG_H_CROP_START		CCI_REG16(0x3800)
+#define OV4689_REG_V_CROP_START		CCI_REG16(0x3802)
+#define OV4689_REG_H_CROP_END		CCI_REG16(0x3804)
+#define OV4689_REG_V_CROP_END		CCI_REG16(0x3806)
+#define OV4689_REG_H_OUTPUT_SIZE	CCI_REG16(0x3808)
+#define OV4689_REG_V_OUTPUT_SIZE	CCI_REG16(0x380a)
+
 #define OV4689_REG_HTS			CCI_REG16(0x380c)
 #define OV4689_HTS_DIVIDER		4
 #define OV4689_HTS_MAX			0x7fff
@@ -48,6 +55,9 @@
 #define OV4689_REG_VTS			CCI_REG16(0x380e)
 #define OV4689_VTS_MAX			0x7fff
 
+#define OV4689_REG_H_WIN_OFF		CCI_REG16(0x3810)
+#define OV4689_REG_V_WIN_OFF		CCI_REG16(0x3812)
+
 #define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820) /* Vertical */
 #define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821) /* Horizontal */
 #define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
@@ -56,6 +66,17 @@
 #define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
 					 OV4689_TIMING_FLIP_DIGITAL)
 
+#define OV4689_REG_ANCHOR_LEFT_START	CCI_REG16(0x4020)
+#define OV4689_ANCHOR_LEFT_START_DEF	576
+#define OV4689_REG_ANCHOR_LEFT_END	CCI_REG16(0x4022)
+#define OV4689_ANCHOR_LEFT_END_DEF	831
+#define OV4689_REG_ANCHOR_RIGHT_START	CCI_REG16(0x4024)
+#define OV4689_ANCHOR_RIGHT_START_DEF	1984
+#define OV4689_REG_ANCHOR_RIGHT_END	CCI_REG16(0x4026)
+#define OV4689_ANCHOR_RIGHT_END_DEF	2239
+
+#define OV4689_REG_VFIFO_CTRL_01	CCI_REG8(0x4601)
+
 #define OV4689_REG_WB_GAIN_RED		CCI_REG16(0x500c)
 #define OV4689_REG_WB_GAIN_BLUE		CCI_REG16(0x5010)
 #define OV4689_WB_GAIN_MIN		1
@@ -199,10 +220,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{ CCI_REG8(0x3798), 0x1b },
 
 	/* Timing control */
-	{ CCI_REG8(0x3801), 0x08 }, /* H_CROP_START_L h_crop_start[7:0] = 0x08 */
-	{ CCI_REG8(0x3805), 0x97 }, /* H_CROP_END_L h_crop_end[7:0] = 0x97 */
-	{ CCI_REG8(0x3811), 0x08 }, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
-	{ CCI_REG8(0x3813), 0x04 }, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
 	{ CCI_REG8(0x3819), 0x01 }, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
 
 	/* OTP control */
@@ -218,22 +235,11 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{ CCI_REG8(0x401b), 0x00 }, /* DEBUG_MODE */
 	{ CCI_REG8(0x401d), 0x00 }, /* DEBUG_MODE */
 	{ CCI_REG8(0x401f), 0x00 }, /* DEBUG_MODE */
-	{ CCI_REG8(0x4020), 0x00 }, /* ANCHOR_LEFT_START_H anchor_left_start[11:8] = 0 */
-	{ CCI_REG8(0x4021), 0x10 }, /* ANCHOR_LEFT_START_L anchor_left_start[7:0] = 0x10 */
-	{ CCI_REG8(0x4022), 0x07 }, /* ANCHOR_LEFT_END_H anchor_left_end[11:8] = 0x07 */
-	{ CCI_REG8(0x4023), 0xcf }, /* ANCHOR_LEFT_END_L anchor_left_end[7:0] = 0xcf */
-	{ CCI_REG8(0x4024), 0x09 }, /* ANCHOR_RIGHT_START_H anchor_right_start[11:8] = 0x09 */
-	{ CCI_REG8(0x4025), 0x60 }, /* ANCHOR_RIGHT_START_L anchor_right_start[7:0] = 0x60 */
-	{ CCI_REG8(0x4026), 0x09 }, /* ANCHOR_RIGHT_END_H anchor_right_end[11:8] = 0x09 */
-	{ CCI_REG8(0x4027), 0x6f }, /* ANCHOR_RIGHT_END_L anchor_right_end[7:0] = 0x6f */
 
 	/* ADC sync control */
 	{ CCI_REG8(0x4500), 0x6c }, /* ADC_SYNC_CTRL */
 	{ CCI_REG8(0x4503), 0x01 }, /* ADC_SYNC_CTRL */
 
-	/* VFIFO */
-	{ CCI_REG8(0x4601), 0xa7 }, /* VFIFO_CTRL_01 r_vfifo_read_start[7:0] = 0xa7 */
-
 	/* Temperature monitor */
 	{ CCI_REG8(0x4d00), 0x04 }, /* TPM_CTRL_00 tmp_slope[15:8] = 0x04 */
 	{ CCI_REG8(0x4d01), 0x42 }, /* TPM_CTRL_01 tmp_slope[7:0] = 0x42 */
@@ -406,6 +412,41 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
 	return -EINVAL;
 }
 
+static int ov4689_setup_timings(struct ov4689 *ov4689)
+{
+	const struct ov4689_mode *mode = ov4689->cur_mode;
+	struct regmap *rm = ov4689->regmap;
+	int ret = 0;
+
+	cci_write(rm, OV4689_REG_H_CROP_START, 8, &ret);
+	cci_write(rm, OV4689_REG_V_CROP_START, 8, &ret);
+	cci_write(rm, OV4689_REG_H_CROP_END, 2711, &ret);
+	cci_write(rm, OV4689_REG_V_CROP_END, 1531, &ret);
+
+	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, mode->width, &ret);
+	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, mode->height, &ret);
+
+	cci_write(rm, OV4689_REG_H_WIN_OFF, 8, &ret);
+	cci_write(rm, OV4689_REG_V_WIN_OFF, 4, &ret);
+
+	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, 167, &ret);
+
+	return ret;
+}
+
+static int ov4689_setup_blc_anchors(struct ov4689 *ov4689)
+{
+	struct regmap *rm = ov4689->regmap;
+	int ret = 0;
+
+	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START, 16, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END, 1999, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START, 2400, &ret);
+	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END, 2415, &ret);
+
+	return ret;
+}
+
 static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 {
 	struct ov4689 *ov4689 = to_ov4689(sd);
@@ -429,6 +470,18 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 			goto unlock_and_return;
 		}
 
+		ret = ov4689_setup_timings(ov4689);
+		if (ret) {
+			pm_runtime_put(dev);
+			goto unlock_and_return;
+		}
+
+		ret = ov4689_setup_blc_anchors(ov4689);
+		if (ret) {
+			pm_runtime_put(dev);
+			goto unlock_and_return;
+		}
+
 		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
 		if (ret) {
 			pm_runtime_put(dev);
-- 
2.44.0


