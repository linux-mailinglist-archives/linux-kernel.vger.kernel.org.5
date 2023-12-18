Return-Path: <linux-kernel+bounces-4195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F4A817903
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B698281FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E67AE60;
	Mon, 18 Dec 2023 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHhhqRoN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0174E3B;
	Mon, 18 Dec 2023 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cc6b5a8364so17406451fa.2;
        Mon, 18 Dec 2023 09:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921273; x=1703526073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdSh6oi/Iw5H+Kb8gikp+vFtU20wx36V3GBFieJ685E=;
        b=SHhhqRoNIZftU/A3sMPzQ+C5C9VRLXfXm3IMq9yQfvJoopMPe/W3v/7shcP7YjQ45B
         SYNs7dmvhToSvf2A30amfD7HpHsLW+s/ZlX3H3PKlXpvCKMHTWzbtA9u8rZkBtj8Ldd+
         AQAk9h5Ldx1cv+ymKR73O79vtyPQ8zYrCk2miRFOawGA7hxcVBKqC+et+SWR+euj/Bwo
         UMafa0IgsEvTCJK4rZIfF8ohlJ0XEKuSARfuDaP0CQmFksBXS6ap6r/Tsx6wxhxF0o3y
         hcoaUbQwfv2ZJTT38DTapVgXgGqT2oD5J9AlSPsZUmwOaUkmo7FQYnUgyroDI3E9FBNh
         E2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921273; x=1703526073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdSh6oi/Iw5H+Kb8gikp+vFtU20wx36V3GBFieJ685E=;
        b=J20SG5KeoCgmvtlDfBMby2azUV9nHKXxT8aN1XQO8+izWxe0ErEwqWLsaKds3cpytk
         ImTjJbZEb7VkXD+itGB6HxsujAyESTpRWNN/BbD8jNkTuRiCawxtiFsct9v0kOvj/T8e
         oZ8wkyUGvJONuljpCsglX01cbBIG5KbM7ZZOJkkPKp37Dy7cNBHE2EZ3inSkdAzuWJEs
         yAG7AwjS7npJJCAVAX5zGWyrkim57pwyhGMaZxyrK2bv1EaHUdJfV6m2BbEhHkNE6pqp
         plNN3R6739O1x9/9uGZGwRve++y3BkOg9q0S8XNU9nJrOsQh7hG38F6ImzyMZVPrYMyz
         adWA==
X-Gm-Message-State: AOJu0YxhIuUaiiHnN6chESz+RLpavDTkl8dMqBvn4wlcyPNvoPm5Vudc
	ZzK7b5o/OGxwJmoBctD0BKiTesL2sqNGqA==
X-Google-Smtp-Source: AGHT+IFqVvCBigspIn7uwDT5zzsfSE7dmH82IPrSC1aeSAceHNjVmNZfRrkSE2tAH9f8by/veLnI3g==
X-Received: by 2002:a2e:b892:0:b0:2cb:5b8a:7013 with SMTP id r18-20020a2eb892000000b002cb5b8a7013mr7039683ljp.75.1702921273170;
        Mon, 18 Dec 2023 09:41:13 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id h4-20020a2ebc84000000b002cc6fa877cesm543853ljf.76.2023.12.18.09.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:41:12 -0800 (PST)
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
Subject: [PATCH v2 12/20] media: i2c: ov4689: Implement vflip/hflip controls
Date: Mon, 18 Dec 2023 20:40:33 +0300
Message-ID: <20231218174042.794012-13-mike.rudenko@gmail.com>
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
index 06ed9d22b2c8..6cf986bf305d 100644
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


