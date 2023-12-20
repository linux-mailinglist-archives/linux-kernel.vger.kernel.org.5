Return-Path: <linux-kernel+bounces-6612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9B5819AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2CC1C257D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B25208A8;
	Wed, 20 Dec 2023 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL1r5uMd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F81F932;
	Wed, 20 Dec 2023 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55322dbabf6so4218288a12.0;
        Wed, 20 Dec 2023 00:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703062578; x=1703667378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYVOyNX8K/YP0tmvGryMk7eYWDrGsoqCCSsYGBM39r0=;
        b=bL1r5uMd7qtVkljpmwQZ22X/dgJuD1YNif4MUjsz1/EJXVmnJSWGHbN5mLg8NDKa8E
         MkIUDQ6YmczT2UTiVVEAt4EDhNVQl/e7EcKUaClG1rgRasG8O8q2daEkxlEIBOQ9m3HX
         Ox2tYToe/cRjKHvSxn0/SC/E9+91mRLk1xMALBqxf1VxhCsJwiAZ9URI8OO3v3Mq0ntL
         VCdywNOvZfP20oD24d6Zs7U/knLsZDy/VDqfqkx7K4Nc0+Tw1TORLqE54qQsVwV3UC4u
         gr/2pJA5t1+fO81DVc799I/9kFIV9oBQlJGphgbh1xWNbdL3uBJVp9oBRjjzJSiTIrbG
         jLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062578; x=1703667378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYVOyNX8K/YP0tmvGryMk7eYWDrGsoqCCSsYGBM39r0=;
        b=anzdTSTKCr/cJA8Jh6O9qXP5Oc1M2FBhBDPcnRACZgxIVO4jXm5cFNDxFOrX7O1uKt
         zcQgORR2uBcZV3TMrnHtjr2eY4Uc5QwYzjdg8mlPcC6KlK8QA7Ny2O6HWxl85Up/KnV6
         p808AJR2IIRX+Tw3wSkyqydu2qX8UiwxyF4Pgi3NPNm0e3fRus0sgwYT4ZUkpTbfCVSo
         PpXp7+hpopypOfcDVnuhbbekj7CR7JqUeRPNr6+LGqXuSFv/hXkjnT0JZT4wUKD1O9d3
         r3KYU226njtq/Db2WsDa31UntWbbEHuOWvKu7uqy0yCrXHZaRjBJClJ4jzytUdvB/jUt
         41SA==
X-Gm-Message-State: AOJu0YxfEwp+/lIt/WEZkyGdTcC0Jyhqdy+el8JqQLMLaXDutBZ1I10U
	p5h7w454yNLHP/s8dS7YcWQ=
X-Google-Smtp-Source: AGHT+IGWpRBfBRp1cwdGts7GjNjyDFE0XrLq5MdwHJTHDsBASHsizgPsfIYpEtniVKUdW2ULxGphLg==
X-Received: by 2002:a50:c25a:0:b0:553:9fab:6cb6 with SMTP id t26-20020a50c25a000000b005539fab6cb6mr1106828edf.74.1703062578516;
        Wed, 20 Dec 2023 00:56:18 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id cq12-20020a056402220c00b0055335e89ed8sm3532169edb.30.2023.12.20.00.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:56:18 -0800 (PST)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: linuxfancy@googlegroups.com,
	laurent.pinchart@ideasonboard.com,
	martin.hecht@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] media: i2c: alvium: store frame interval in subdev state
Date: Wed, 20 Dec 2023 09:56:09 +0100
Message-Id: <20231220085609.2595732-5-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220085609.2595732-1-tomm.merciai@gmail.com>
References: <20231220085609.2595732-1-tomm.merciai@gmail.com>
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
Changes Since v1:
 - Removed FIXME comment and active state check into alvium_s_frame_interval
   as suggested by LPinchart.
 - Fixed call alvium_set_frame_rate() only for active state into alvium_s_frame_interval
   as suggested by LPinchart.

 drivers/media/i2c/alvium-csi2.c | 51 +++++++++++----------------------
 drivers/media/i2c/alvium-csi2.h |  1 -
 2 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index b234d74454bf..240bf991105e 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1641,42 +1641,16 @@ static int alvium_hw_init(struct alvium_dev *alvium)
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
 {
 	struct alvium_dev *alvium = sd_to_alvium(sd);
 	struct device *dev = &alvium->i2c_client->dev;
-	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
-	u64 dft_fr, min_fr, max_fr;
+	u64 req_fr, dft_fr, min_fr, max_fr;
+	struct v4l2_fract *interval;
 	int ret;
 
-	/*
-	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
-	 * subdev active state API.
-	 */
-	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
-		return -EINVAL;
-
 	if (alvium->streaming)
 		return -EBUSY;
 
@@ -1700,8 +1674,13 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 	if (req_fr >= max_fr && req_fr <= min_fr)
 		req_fr = dft_fr;
 
-	alvium->frame_interval.numerator = fi->interval.numerator;
-	alvium->frame_interval.denominator = fi->interval.denominator;
+	interval = v4l2_subdev_state_get_interval(sd_state, 0);
+
+	interval->numerator = fi->interval.numerator;
+	interval->denominator = fi->interval.denominator;
+
+	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
+		return 0;
 
 	return alvium_set_frame_rate(alvium, req_fr);
 }
@@ -1851,6 +1830,7 @@ static int alvium_init_state(struct v4l2_subdev *sd,
 {
 	struct alvium_dev *alvium = sd_to_alvium(sd);
 	struct alvium_mode *mode = &alvium->mode;
+	struct v4l2_fract *interval;
 	struct v4l2_subdev_format sd_fmt = {
 		.which = V4L2_SUBDEV_FORMAT_TRY,
 		.format = alvium_csi2_default_fmt,
@@ -1868,6 +1848,11 @@ static int alvium_init_state(struct v4l2_subdev *sd,
 	*v4l2_subdev_state_get_crop(state, 0) = sd_crop.rect;
 	*v4l2_subdev_state_get_format(state, 0) = sd_fmt.format;
 
+	/* Setup initial frame interval*/
+	interval = v4l2_subdev_state_get_interval(state, 0);
+	interval->numerator = 1;
+	interval->denominator = ALVIUM_DEFAULT_FR_HZ;
+
 	return 0;
 }
 
@@ -2237,7 +2222,7 @@ static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
 	.set_fmt = alvium_set_fmt,
 	.get_selection = alvium_get_selection,
 	.set_selection = alvium_set_selection,
-	.get_frame_interval = alvium_g_frame_interval,
+	.get_frame_interval = v4l2_subdev_get_frame_interval,
 	.set_frame_interval = alvium_s_frame_interval,
 };
 
@@ -2258,10 +2243,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
 	struct v4l2_subdev *sd = &alvium->sd;
 	int ret;
 
-	/* Setup initial frame interval*/
-	alvium->frame_interval.numerator = 1;
-	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
-
 	/* Setup the initial mode */
 	alvium->mode.fmt = alvium_csi2_default_fmt;
 	alvium->mode.width = alvium_csi2_default_fmt.width;
diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
index 80066ac25047..9463f8604fbc 100644
--- a/drivers/media/i2c/alvium-csi2.h
+++ b/drivers/media/i2c/alvium-csi2.h
@@ -442,7 +442,6 @@ struct alvium_dev {
 	s32 inc_sharp;
 
 	struct alvium_mode mode;
-	struct v4l2_fract frame_interval;
 
 	u8 h_sup_csi_lanes;
 	u64 link_freq;
-- 
2.34.1


