Return-Path: <linux-kernel+bounces-87120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C974886CFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F1D2822AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86013F436;
	Thu, 29 Feb 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii0Fcwiq"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CA13C9D6;
	Thu, 29 Feb 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225649; cv=none; b=F9QnH+1Ndc040GiFmgKdG4C6Jj+PDqUtQxKlx7idl7DHBNHI+9U/oHCsPZYsr0EmLy5LeHR2hencXv8mWQfuiLKsKae8Pn+5U8tWqdPI4Pu1psTsuKfBdzU427089tUR+nD0RbLXmATZT2NtWi7ii+azPhmhudQpn1AsOn9lARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225649; c=relaxed/simple;
	bh=z/lcJOGKZxYkIfwlG9//CrwgZ9h35lvAEPnEpxJLkdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gm3XwyTubAODfDpAjM2m1P0XuWHbMTAEVdo+rMfXn1mgeKtBVZZc7H3Voj/Zlq2tOBEiXqM/uCkXAKhe7SpQeAwsqEMUlGK7pP6VHBzaVFgVAs2957pSHnptmwGokEhLt13u2K47X7QKEjcZVB/Owj2tQiRXOgniKIneJJx56b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii0Fcwiq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5131f3fc695so1241404e87.1;
        Thu, 29 Feb 2024 08:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709225645; x=1709830445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXRW1q4CHfYIIhyxDIUYDtnj8kIO+nPksr2cH8/pox8=;
        b=Ii0FcwiqZScOf5IF1Xst7M5NFnJze8agWGPGumlPp6nqZ1OVfSZY0/0H766M1lOM2d
         saMUqQ2u/P701/ecQZmYPoqQPZDSE50CEPPNMpv07K3W7vaM6Bku0c/2u82dDFZ8sDyb
         Sdy0zfk+/Ee1e45g9iMAzLr/wtoVWJ5aLroz6I7JFUprwUYB6LtFMV6Orm/CyDC9yrMk
         9eD+NL0R4L0tdvsrKBVTMjp7+46bzwbX4+/laXlvSDVl36H7TT4PDu6K1PupQBlL6BVc
         rzw9yhgtuZByZ/FFGwOpaRJEieAlagdNDMHeBf2k0+HUI2x9AJPZSGljj5t6qbLE06M5
         luuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709225645; x=1709830445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXRW1q4CHfYIIhyxDIUYDtnj8kIO+nPksr2cH8/pox8=;
        b=C3hINPJt29rGRysSIVQvFDWGB3QpEOHd3SmrtD0YOjMznVRMPQYqQZ/o5LfFCve/5r
         V0etYyJ2YiiV1Xo1EVfpcRoLr0UB1TNQKwlD8buXHAI1fFsc0p9QPaMxvNuuIm/217BJ
         wxUheAEy4f25sT2xkE0+ORYqMS8S9iLBag2gB8Cph75LrA1hKW8C4JaCMjB1qXx0aXqq
         FBBw/kLkfS3G86eKm4gQtDwjEoIBJuiGiBp/siaLcoruQJHeGnQhyQVpfTl0dXc1IHvO
         oodLI3s93q3k953hKCTFrQ6ADC8UhNke8Y0bp3mMEX9batErXhE0yNuVqslxNtE62g9V
         Yzcg==
X-Forwarded-Encrypted: i=1; AJvYcCWMkQINxYG5kjsBfY4LWg2d7EmQG+V1ktdeLyMaSxx8GTu7OiY6O5KtfzhJivbZa3XYhqNoCIL3fdTGHYDGRDlUkLOtrpatp1LKUXsT
X-Gm-Message-State: AOJu0YyDhdsttXlWjn58NeWbdLf1yqEQNwCDrNjsBIZ8kN2WTW1GSwWY
	tFDimpUiYpggxvEL54rdd8kFb1vGw5Vk9qwk61lVRCbhPm74uaq5OPNJBsr1sD8=
X-Google-Smtp-Source: AGHT+IEvsn4oYmH+ZHpMlUcrlrdmWavZQ3NAfN3rfUc8h0wwMj74Swwx9te38DBZBpT7NhOcAEUmhw==
X-Received: by 2002:a05:6512:3b2a:b0:513:27a1:2fc7 with SMTP id f42-20020a0565123b2a00b0051327a12fc7mr1770408lfv.46.1709225645300;
        Thu, 29 Feb 2024 08:54:05 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id d12-20020ac25ecc000000b005131cf043f8sm308235lfq.155.2024.02.29.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 08:54:04 -0800 (PST)
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
Subject: [PATCH v3 14/20] media: i2c: ov4689: Implement manual color balance controls
Date: Thu, 29 Feb 2024 19:53:27 +0300
Message-ID: <20240229165333.227484-15-mike.rudenko@gmail.com>
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

The OV4689 sensor has separate red and blue gain settings (up to 4x).
Implement appropriate controls in the driver. Default gain values
are not modified.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 1450db7302b7..6c36fe5f3b44 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -56,6 +56,13 @@
 #define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
 					 OV4689_TIMING_FLIP_DIGITAL)
 
+#define OV4689_REG_WB_GAIN_RED		CCI_REG16(0x500c)
+#define OV4689_REG_WB_GAIN_BLUE		CCI_REG16(0x5010)
+#define OV4689_WB_GAIN_MIN		1
+#define OV4689_WB_GAIN_MAX		0xfff
+#define OV4689_WB_GAIN_STEP		1
+#define OV4689_WB_GAIN_DEFAULT		0x400
+
 #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
 #define OV4689_TEST_PATTERN_ENABLE	0x80
 #define OV4689_TEST_PATTERN_DISABLE	0x0
@@ -632,6 +639,12 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_DIGITAL_GAIN:
 		cci_write(regmap, OV4689_REG_DIG_GAIN, ctrl->val, &ret);
 		break;
+	case V4L2_CID_RED_BALANCE:
+		cci_write(regmap, OV4689_REG_WB_GAIN_RED, ctrl->val, &ret);
+		break;
+	case V4L2_CID_BLUE_BALANCE:
+		cci_write(regmap, OV4689_REG_WB_GAIN_BLUE, ctrl->val, &ret);
+		break;
 	default:
 		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
 			 __func__, ctrl->id, ctrl->val);
@@ -662,7 +675,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 
 	handler = &ov4689->ctrl_handler;
 	mode = ov4689->cur_mode;
-	ret = v4l2_ctrl_handler_init(handler, 13);
+	ret = v4l2_ctrl_handler_init(handler, 15);
 	if (ret)
 		return ret;
 
@@ -709,6 +722,14 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
 			  OV4689_DIG_GAIN_MIN, OV4689_DIG_GAIN_MAX,
 			  OV4689_DIG_GAIN_STEP, OV4689_DIG_GAIN_DEFAULT);
 
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_RED_BALANCE,
+			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
+			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
+
+	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_BLUE_BALANCE,
+			  OV4689_WB_GAIN_MIN, OV4689_WB_GAIN_MAX,
+			  OV4689_WB_GAIN_STEP, OV4689_WB_GAIN_DEFAULT);
+
 	if (handler->error) {
 		ret = handler->error;
 		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);
-- 
2.43.0


