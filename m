Return-Path: <linux-kernel+bounces-87118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38186CFD4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0515DB26BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16D84AEF9;
	Thu, 29 Feb 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxNZF7dx"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53A134436;
	Thu, 29 Feb 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225646; cv=none; b=KeZ9vA/FVzXlLK2FGD5MXNUmrQwhsws6M2z4Brz48HPxpsj8U47GZOeLD1R2e0LMJA/LgpzCT/QuHdCImFVwlEvcmIBmcM7rAexA9JC8cR55iG1UzMl5CEK305lU3H42eMB6ty33cySmrQLP4bBPJywYYoDVMxqkS3McCZfMul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225646; c=relaxed/simple;
	bh=SyZ9/l4hqqx6qeHjDJINR2+KFh3XcHfLWKiQUoRtv14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dB5xdqvgRMJO4p5ZmZuxPkqoAFDt9y2y0Yu7M/6vE4HD4JfNI0JEdm+jSybV11aceIXOdi3KG4qzdmtffKgenTvm0z4xY0VZnTuPta8wszk31uQQB4r5dMgJUiHw0iEmCgcHOtJ6DDL+ze4e8C+H8LXC2qWrX/5L0cw/pWLvvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxNZF7dx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513181719easo716740e87.3;
        Thu, 29 Feb 2024 08:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225642; x=1709830442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A+7fqGlgqB2e7gBYOUtUusaDBZS2HZQOBIfzoUKKJI=;
        b=KxNZF7dxNZePeZPvIxcRjGQ14GMznYSRUEbneeBS/Rph78l+IKfraacGxBPNFPWlvl
         Ecsh0fbaay+efdz5H/iRKCDOGF/e61M5PVHfy+f2Epp3DrXKDY2rWUPY4SQjS20H0aqZ
         4UPs3wMA4nEyWukQK/IPP7oYygUTFHAFpWGG9J+AXnxz5ON3C7h6KqO+KJ92JUD7qP8e
         tDk/GPaW3Vao7G4xtyx6DmgMf/eBK2H0h8CfR7SYiKXkVDlIF8mo5PeHWTy6tMxIwe+j
         3wBrMspG1q1kVal8DcyM3wRIKYh+Q2j3JqnDwwVM6TiE1Ni7kwChGIZtuGk6qlSgKNLd
         2SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225642; x=1709830442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4A+7fqGlgqB2e7gBYOUtUusaDBZS2HZQOBIfzoUKKJI=;
        b=PFGMPDPs369VqpGvChTJuu7to3db0e7OSJj+ymWlxzXC94k6NF61WXmz6Yl7y8wb+X
         kj2Vr/5mhkvs5xntSBNahSSyTnOR+my74UXeX00tUKV5hgZzESGzlJD0RlFW/b7yd6bI
         lRMr525nnNG61A02BNvLIkCSBXb6BFcD7Ovxrgn4xC3I+Tvx7A3UgwnbkL+IpY173pbL
         ThPVnwOJZb7VOqaV1yqMmqNHlHPgIHldWFo1zggbzBwGGagt10UhZrz5/yysjhoYABsW
         nZtYH8Dg/BpYpfFVAgGqzR6rzoFzVy2/vxD0xZ7+D8TyjaOCCtHGCNwITTqVYMD4qsNv
         3xBw==
X-Forwarded-Encrypted: i=1; AJvYcCXtqgLfNUpgKaaG3T3jyH+n722SpD9detd9QvRTHh6m22Ub8Ze0z3QvhGS0WbDB40fai1LdhoG66yCruUTAtoug99JIeZbcIpoxMl25
X-Gm-Message-State: AOJu0YwcaJsO+52QPxlbkKsxbuvkbRE9NcfX5FtcQZpIGp4cTlFBbCOQ
	cvIFbSRyn4jyIuTamcoHBqL3fZ5CYF8EfsWc9gCGY9l9OhW1JXuCpYwemYOd24k=
X-Google-Smtp-Source: AGHT+IHxHlgzXmfvpveI97xGc+iqGkr14wdZpTmusShiUw11YBd0OWd92+C3hP8mdXnqBz447bGIxg==
X-Received: by 2002:a05:6512:2023:b0:513:1cf5:bcb0 with SMTP id s3-20020a056512202300b005131cf5bcb0mr1859303lfs.27.1709225642583;
        Thu, 29 Feb 2024 08:54:02 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id h6-20020a19ca46000000b00513273f4176sm250162lfj.143.2024.02.29.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:54:02 -0800 (PST)
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
Subject: [PATCH v3 12/20] media: i2c: ov4689: Implement vflip/hflip controls
Date: Thu, 29 Feb 2024 19:53:25 +0300
Message-ID: <20240229165333.227484-13-mike.rudenko@gmail.com>
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

The OV4689 sensor supports horizontal and vertical flipping. Add
appropriate controls to the driver. Toggling both array flip and
digital flip bits allows to achieve flipping while maintaining output
Bayer order. Note that the default value of hflip control corresponds
to both bits set, as it was before this patch.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 8283a9ac86c9..01ee8cadb7c9 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -42,6 +42,14 @@
 #define OV4689_REG_VTS			CCI_REG16(0x380e)
 #define OV4689_VTS_MAX			0x7fff
 
+#define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820)
+#define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821)
+#define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
+#define OV4689_TIMING_FLIP_ARRAY	BIT(1)
+#define OV4689_TIMING_FLIP_DIGITAL	BIT(2)
+#define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
+					 OV4689_TIMING_FLIP_DIGITAL)
+
 #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
@@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
 	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
 	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
 	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
-	{CCI_REG8(0x3821), 0x06}, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
 
 	/* OTP control */
 	{CCI_REG8(0x3d85), 0x36}, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
@@ -607,6 +614,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 			  (ctrl->val + ov4689->cur_mode->width) /
 			  OV4689_HTS_DIVIDER, &ret);
 		break;
+	case V4L2_CID_VFLIP:
+		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
+				OV4689_TIMING_FLIP_MASK,
+				ctrl->val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
+		break;
+	case V4L2_CID_HFLIP:
+		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
+				OV4689_TIMING_FLIP_MASK,
+				ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -637,7 +654,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 10);
+	ret = v4l2_ctrl_handler_init(handler, 12);
 	if (ret)
 		return ret;
 
@@ -677,6 +694,9 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 				     ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
 				     0, 0, ov4689_test_pattern_menu);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.43.0


