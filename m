Return-Path: <linux-kernel+bounces-4201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97295817910
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0E01C257DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83F27C659;
	Mon, 18 Dec 2023 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8kNAbtN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239E7BEE3;
	Mon, 18 Dec 2023 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e24e92432so2957279e87.2;
        Mon, 18 Dec 2023 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921281; x=1703526081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5pi4djYNxaCEjMPJwbP6idbsJSRFN1lOjcDzQOgWR4=;
        b=j8kNAbtNnjMj2XxDRPyh0EZ29zeysA/dfD7n5xMMa6rjjENChCW2yHqMYPvyq9Sah+
         gxwXHwguJLnpP75OHllozbQaO1TnxQ79XeKSGjFLA7JpjwZOWV4/4pmAt1NQ50KsSufw
         WiDkxeHbj7ev8zHV+qEykG9OJqxzXElBZdPwM/0KLctru4Koc75pVxJwhiol9o1llB88
         ty8hg/Hl095eXtEjlc2QdAowXmuNSLJiKaNpFksCov3fu0UA+r9K4cFANxRqSAWyiSIX
         OrrVUtF8Xy8hs9D7YtsX5YsspZ6Osm5jO/RxVV+048HO8Sq+OE6totN+eDvhZNVD5cNa
         7HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921281; x=1703526081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5pi4djYNxaCEjMPJwbP6idbsJSRFN1lOjcDzQOgWR4=;
        b=qoVRrdzFjYn4YDtnAueNnBOwC3KELQ7MefcCs/yzlw2Bc/MaEfQCiV1z6dNF7nGK8q
         JkKJsYgoUkApYsdYKL0ui2j86SzwsqHgYhO4wByE0cYZwEOMWvLz4M7SkoXBcc8uY6x9
         NkJvnzD1jq8EGCmKedcWiOUWREC1FffeQJno6ejV2dkNqVy8zV+ceR1IGmV3ccPY3/8j
         C/XZ5mtp4pDw05N5wr4XGQmuk201FczblaSoVTyKgp+m9l5BZL0XN7wGca4NfRodKM28
         cnS1oGrYqT+uLS1QISMvRetEfNkKcDXjECUkINDGl7NJrlsI7D3g5asMTLDQUYTVKBDP
         K9qQ==
X-Gm-Message-State: AOJu0Yy16F5DXqhpEz2soDvGr2jpsSImCjTzY67b3d/VdowZJXAjoUGC
	Qz6Ml7XMSbHQYo/y73h603ma7Y6XC98HcA==
X-Google-Smtp-Source: AGHT+IHul+BYeWgrfH3xAh5Y8sk8RJ8gwUR9wSYw6i0vNiaJJNOlA7jkIcC1bZs2PHWnfRZOw9nuDQ==
X-Received: by 2002:ac2:43d0:0:b0:50e:3afa:7e34 with SMTP id u16-20020ac243d0000000b0050e3afa7e34mr760175lfl.111.1702921278264;
        Mon, 18 Dec 2023 09:41:18 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id dx6-20020a0565122c0600b0050bca70287esm2957427lfb.50.2023.12.18.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:17 -0800 (PST)
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
Subject: [PATCH v2 16/20] media: i2c: ov4689: Set timing registers programmatically
Date: Mon, 18 Dec 2023 20:40:37 +0300
Message-ID: <20231218174042.794012-17-mike.rudenko@gmail.com>
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

Set timing-related and BLC anchor registers via cci calls instead of
hardcoding them in the register table. This prepares the driver for
implementation of configurable analogue crop and binning. No
functional change intended.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 83 +++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 15 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 475508559e3e..3b73ee282761 100644
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
 #define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820)
 #define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821)
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
 	{CCI_REG8(0x3798), 0x1b},
 
 	/* Timing control */
-	{CCI_REG8(0x3801), 0x08}, /* H_CROP_START_L h_crop_start[7:0] = 0x08 */
-	{CCI_REG8(0x3805), 0x97}, /* H_CROP_END_L h_crop_end[7:0] = 0x97 */
-	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
-	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
 	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
 
 	/* OTP control */
@@ -218,22 +235,11 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{CCI_REG8(0x401b), 0x00}, /* DEBUG_MODE */
 	{CCI_REG8(0x401d), 0x00}, /* DEBUG_MODE */
 	{CCI_REG8(0x401f), 0x00}, /* DEBUG_MODE */
-	{CCI_REG8(0x4020), 0x00}, /* ANCHOR_LEFT_START_H anchor_left_start[11:8] = 0 */
-	{CCI_REG8(0x4021), 0x10}, /* ANCHOR_LEFT_START_L anchor_left_start[7:0] = 0x10 */
-	{CCI_REG8(0x4022), 0x07}, /* ANCHOR_LEFT_END_H anchor_left_end[11:8] = 0x07 */
-	{CCI_REG8(0x4023), 0xcf}, /* ANCHOR_LEFT_END_L anchor_left_end[7:0] = 0xcf */
-	{CCI_REG8(0x4024), 0x09}, /* ANCHOR_RIGHT_START_H anchor_right_start[11:8] = 0x09 */
-	{CCI_REG8(0x4025), 0x60}, /* ANCHOR_RIGHT_START_L anchor_right_start[7:0] = 0x60 */
-	{CCI_REG8(0x4026), 0x09}, /* ANCHOR_RIGHT_END_H anchor_right_end[11:8] = 0x09 */
-	{CCI_REG8(0x4027), 0x6f}, /* ANCHOR_RIGHT_END_L anchor_right_end[7:0] = 0x6f */
 
 	/* ADC sync control */
 	{CCI_REG8(0x4500), 0x6c}, /* ADC_SYNC_CTRL */
 	{CCI_REG8(0x4503), 0x01}, /* ADC_SYNC_CTRL */
 
-	/* VFIFO */
-	{CCI_REG8(0x4601), 0xa7}, /* VFIFO_CTRL_01 r_vfifo_read_start[7:0] = 0xa7 */
-
 	/* Temperature monitor */
 	{CCI_REG8(0x4d00), 0x04}, /* TPM_CTRL_00 tmp_slope[15:8] = 0x04 */
 	{CCI_REG8(0x4d01), 0x42}, /* TPM_CTRL_01 tmp_slope[7:0] = 0x42 */
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
 			pm_runtime_put_sync(dev);
-- 
2.43.0


