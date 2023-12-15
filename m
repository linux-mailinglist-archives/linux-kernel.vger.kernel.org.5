Return-Path: <linux-kernel+bounces-615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F4B81438D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFFC28426A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F151318C25;
	Fri, 15 Dec 2023 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRCyBPsI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE9179BE;
	Fri, 15 Dec 2023 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a1f0616a15bso44121466b.2;
        Fri, 15 Dec 2023 00:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702628700; x=1703233500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he8fe2wC1JFZq/a+xpBUGEzXjsc2JCt6WRN6YaAZE7s=;
        b=CRCyBPsI1pfnsrQfwrwLJIGSAgdVINdvG3BChTidKwtK8deYRu/FdPCzvrbzPuy6n7
         CfOgydB7waM29XVdj43iRdDjGpSXdLaBqsxnLwYHfz5eYdarJsuxulZiHv7x2MBzhtQd
         Nl0HG5gmv/XfCtF8DtQxxbMIxL8tq9/OvcBE1is/T0xpB5t2kcgWXsSZt/IcEp5AaWwg
         0I8yAUedAK0BgdiLxO2l9aQ5nmamFvc8Nut70OufK/rCTkZNlYtZkLpi38YI9sz8nqWr
         7TTBPOucYKfX4OEwzKv8fzAgAGnRyMklTkp8MANTvPz457cs+KtcXxDa7LXCEGshyALY
         tM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628700; x=1703233500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he8fe2wC1JFZq/a+xpBUGEzXjsc2JCt6WRN6YaAZE7s=;
        b=EgfrY9NzZeZtctYArgMmmbpqDq0GqrdSKvc2vfUCsnawmAlzB4LVBGLAi39etTxody
         aAuNcBSbpjbtMrNjdJMjnvHyU1EYJYx2vZphnXrdlUmqlH89oEdUh0qBAEKoYxFoh40o
         F5vwxlmTdHqDt+XDyJTtE7t7oM6Jm2uVf/UKpwAYfpVe5r+hPEChA/hc1/UXbEQMPuVq
         CKuNdXeo9CaJQscBZoFCO/hwRHo7/fSDZUc5h6hZjKc2+eeWW3pCRNzdF2cQwRHMCJSB
         IBSDAFEKJFe9do5CRmAkJwVo8gMafrG2kd91Ymk6en51tBbwQ+AJvHvRQ45vGu/oTpot
         0Ajw==
X-Gm-Message-State: AOJu0Yxnou+R8+f1LRiKmENwg9/MNehiK02xIjzidCnw4wrmoTIEhA7q
	PsK8ZuAqq3jU0fL/ASHiQRU=
X-Google-Smtp-Source: AGHT+IHLtBfg1gK/5KXl5Ho6USY1DozZC7NUbaaIbFzD3YmEDcZ4+o4KYKsvfms1pqBmrDg6laPh5Q==
X-Received: by 2002:a17:906:225d:b0:a1d:251a:4056 with SMTP id 29-20020a170906225d00b00a1d251a4056mr5815033ejr.8.1702628700333;
        Fri, 15 Dec 2023 00:25:00 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id un7-20020a170907cb8700b00a1b65249053sm10395951ejc.128.2023.12.15.00.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:24:59 -0800 (PST)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: linuxfancy@googlegroups.com,
	sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	tomm.merciai@gmail.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] media: i2c: alvium: store frame interval in subdev state
Date: Fri, 15 Dec 2023 09:24:52 +0100
Message-Id: <20231215082452.1720481-4-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215082452.1720481-1-tomm.merciai@gmail.com>
References: <20231215082452.1720481-1-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the newly added storage for frame interval in the subdev state to
simplify the driver.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 40 ++++++++++-----------------------
 drivers/media/i2c/alvium-csi2.h |  2 --
 2 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index fde456357be1..81f683b3c849 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1643,25 +1643,6 @@ static int alvium_hw_init(struct alvium_dev *alvium)
 }
 
 /* --------------- Subdev Operations --------------- */
-
-static int alvium_g_frame_interval(struct v4l2_subdev *sd,
-				   struct v4l2_subdev_state *sd_state,
-				   struct v4l2_subdev_frame_interval *fi)
-{
-	struct alvium_dev *alvium = sd_to_alvium(sd);
-
-	/*
-	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
-	 * subdev active state API.
-	 */
-	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
-		return -EINVAL;
-
-	fi->interval = alvium->frame_interval;
-
-	return 0;
-}
-
 static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_state *sd_state,
 				   struct v4l2_subdev_frame_interval *fi)
@@ -1669,6 +1650,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 	struct alvium_dev *alvium = sd_to_alvium(sd);
 	struct device *dev = &alvium->i2c_client->dev;
 	u64 req_fr, dft_fr, min_fr, max_fr;
+	struct v4l2_fract *interval;
 	int ret;
 
 	/*
@@ -1701,9 +1683,10 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 	if (req_fr >= max_fr && req_fr <= min_fr)
 		req_fr = dft_fr;
 
-	alvium->fr = req_fr;
-	alvium->frame_interval.numerator = fi->interval.numerator;
-	alvium->frame_interval.denominator = fi->interval.denominator;
+	interval = v4l2_subdev_state_get_interval(sd_state, 0);
+
+	interval->numerator = fi->interval.numerator;
+	interval->denominator = fi->interval.denominator;
 
 	return alvium_set_frame_rate(alvium, req_fr);
 }
@@ -1853,6 +1836,7 @@ static int alvium_init_state(struct v4l2_subdev *sd,
 {
 	struct alvium_dev *alvium = sd_to_alvium(sd);
 	struct alvium_mode *mode = &alvium->mode;
+	struct v4l2_fract *interval;
 	struct v4l2_subdev_format sd_fmt = {
 		.which = V4L2_SUBDEV_FORMAT_TRY,
 		.format = alvium_csi2_default_fmt,
@@ -1870,6 +1854,11 @@ static int alvium_init_state(struct v4l2_subdev *sd,
 	*v4l2_subdev_state_get_crop(state, 0) = sd_crop.rect;
 	*v4l2_subdev_state_get_format(state, 0) = sd_fmt.format;
 
+	/* Setup initial frame interval*/
+	interval = v4l2_subdev_state_get_interval(state, 0);
+	interval->numerator = 1;
+	interval->denominator = ALVIUM_DEFAULT_FR_HZ;
+
 	return 0;
 }
 
@@ -2239,7 +2228,7 @@ static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
 	.set_fmt = alvium_set_fmt,
 	.get_selection = alvium_get_selection,
 	.set_selection = alvium_set_selection,
-	.get_frame_interval = alvium_g_frame_interval,
+	.get_frame_interval = v4l2_subdev_get_frame_interval,
 	.set_frame_interval = alvium_s_frame_interval,
 };
 
@@ -2260,11 +2249,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
 	struct v4l2_subdev *sd = &alvium->sd;
 	int ret;
 
-	/* Setup initial frame interval*/
-	alvium->frame_interval.numerator = 1;
-	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
-	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
-
 	/* Setup the initial mode */
 	alvium->mode.fmt = alvium_csi2_default_fmt;
 	alvium->mode.width = alvium_csi2_default_fmt.width;
diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
index a6529b28e7dd..f5e26257b042 100644
--- a/drivers/media/i2c/alvium-csi2.h
+++ b/drivers/media/i2c/alvium-csi2.h
@@ -442,8 +442,6 @@ struct alvium_dev {
 	s32 inc_sharp;
 
 	struct alvium_mode mode;
-	struct v4l2_fract frame_interval;
-	u64 fr;
 
 	u8 h_sup_csi_lanes;
 	u64 link_freq;
-- 
2.34.1


