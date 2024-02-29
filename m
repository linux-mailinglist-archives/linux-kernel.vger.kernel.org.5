Return-Path: <linux-kernel+bounces-87122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBBA86CFDD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A0C1F22C40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E776142907;
	Thu, 29 Feb 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwiO5yyn"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96F13F447;
	Thu, 29 Feb 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225652; cv=none; b=ufTa7hHCXzVghPg1AEgauIDhGRd6Gk1BvNnwY4WlIWKRK2OCJ9FSm/FVP4nmlKEGZUhpnPvhXhlDmLueM4Wka8GYmLZ1t1s4aBAmiZtJOpUX1qMEtY+F53h7FWlBamjY4HCOUfJ8kw2N5st0egdSz02sCEAu+kdP0Qc5vkD5dGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225652; c=relaxed/simple;
	bh=HAjPxsQllXt2MklENcFQtTk5KhZZGpOecO/Grls893k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ebca3rOnIdjPdU1gKPndnEtkftcTVaTgJTY6x0wIDuDfUqwdi8Yc53ljxk5lqQAfdZ4Cn0aRDRS1GxHCnGdQaaZrc7G/p9vZCOnbXPBrHH/Lb1ZQilWBCj3RfJlkCodg2+NXAcX2Sq40j+0fu5oRRczgW7PG4zCC1OIZHQh7nrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwiO5yyn; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d1094b5568so12035331fa.1;
        Thu, 29 Feb 2024 08:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225648; x=1709830448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9mcS8uBRt1ITRRT7Y6UHyXWxG9Pu0ZSy0V3XZb129M=;
        b=jwiO5yynWPrlDpA2JeorAb0ILqXaoCLV9K7GvK20BW1MAa+R587Rh8efxVIL3O4pwq
         v3B4M5KtbLMkyYZJ0EfJ6YBT+2sCOPSYN16cRtgICWo1hjKbfbOLTCtUjDeyR19VVjV9
         fSwyK8TStr4RUJAjjuCXL15sQMS7M3m8fCR7ZoLsEtTv6vKWecASAXse6bBSrfIMKYCt
         OaYj2JZKDgokVWmJDpnFTrMc8wfZARnNp424MJGC59xT8gelrnkLjrALo3DVq4nCg88T
         lh9EQ9a7IsQJWaZXo7nqDhRQXAjh3xz2lH9hUsC/FN8hgRcqzi5aacgoxFskgHKgXWCh
         v8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225648; x=1709830448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9mcS8uBRt1ITRRT7Y6UHyXWxG9Pu0ZSy0V3XZb129M=;
        b=TPhYJgxQtsQ+mlXDLb5bmTyW7ma4Y0mV5TstVqMTXenrgf1QNmPRYI0gzfRS2xffYu
         t2WOYMSVMfSBue1w4OjKkFijcnbll/f4lYT1bSQHKyslcfbzPMtHLEnyHCGsyPHvNR6t
         9D7by5sujGXcLZ1YQY7XOoOVjw8v/Mw4RrUhC43XZgrjyCF0CLoS3nDIXd6bmxYhFpqs
         jmePnswMABYoaB64/7YdNZT3AGnGXSlLqqSGmYjWtKds63ShPV2wawrfPsL9nycYgFWV
         gdIm5EM6fNw8SJG6y39iKIyKstPBHF87+tX+ETRP6jeOrO/lazeRcGRDo9uEze1Mgcnf
         6eqA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ivtFtDo7EO/QjUGociXWvyY/3+G4AQba1nq6NzBm9RMxhRC+zW96c/C7yTeQnZMyYEyVdcXCdfL0R1kyoNFeP85SmdLm0HFGHd0w
X-Gm-Message-State: AOJu0YxW9pTVy+rGH+QiYph17eZMilTf2QQC8OkGWNU2WRLEfwtczyzz
	xizgog/DVdduXG1bqBN0O0MF/3J1NXpkyeCIsj1JMrdDb5Abrj7nZ8ZG58yvWhs=
X-Google-Smtp-Source: AGHT+IG7mmSwSPHwCsovawh9rkEDXG4GDNSicttsi2KVCcA8Ya5smKfNaIlV2i1UEOqIVr4hAHDZbw==
X-Received: by 2002:a2e:874c:0:b0:2d2:2cb4:f80d with SMTP id q12-20020a2e874c000000b002d22cb4f80dmr1769957ljj.10.1709225648113;
        Thu, 29 Feb 2024 08:54:08 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id x22-20020a2e7c16000000b002d2d439efa8sm260275ljc.105.2024.02.29.08.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:54:07 -0800 (PST)
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
Subject: [PATCH v3 16/20] media: i2c: ov4689: Set timing registers programmatically
Date: Thu, 29 Feb 2024 19:53:29 +0300
Message-ID: <20240229165333.227484-17-mike.rudenko@gmail.com>
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
index cc8d9fa369e7..d34699f35270 100644
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
 			pm_runtime_put(dev);
-- 
2.43.0


