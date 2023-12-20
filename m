Return-Path: <linux-kernel+bounces-6910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63100819F3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DD71C22D52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E8D38FA6;
	Wed, 20 Dec 2023 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpaUlPBR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CE2554D;
	Wed, 20 Dec 2023 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso7763207a12.3;
        Wed, 20 Dec 2023 04:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703076032; x=1703680832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxRqSeGzX02JEgJLfNTXcC5rilET35Ihn8r4o8gFqV8=;
        b=mpaUlPBR8R28Qa1un9ZZ9suIx2AZWxLxHwjLa46HUmQ71eu71qJvR9Y6MpZrl1bhVb
         MwM/IsK9Gob/RLNdXDF2uA+nX7nmxOktkmAjWgxyh72/SUTmTUErlBpbRS7ZBv0x5rjv
         BGROh5Uw0A7ms+iwnjbeTry9XbK8VHASjjY00d23CvWxDlpwdbQNWf0MkrzD6C1p6PfY
         xaMf4nDbygvYc6HSx0JcZ+jR9ImSSCusdiDPijnd0VRyHn7+eoPCMTmifL3ivIsL6+F1
         8RJ/hLDIloxWISaYc/y48bsEZeV31jNl/bgJ+8aGAjWMt3LOAt14OMq76kAATVXe5Ddv
         bdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703076032; x=1703680832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxRqSeGzX02JEgJLfNTXcC5rilET35Ihn8r4o8gFqV8=;
        b=w4QzgHyaJqi4bPGEXS6L58BHGB2tqxNcptdrbkaiTvpKJGRimd1zDP3x+AqY0mDIxQ
         5CsA2eN2R3B6CXhzv57MI0D7F+OONSGYZ/KHVRX0EjLbI5A6BucJSgkjT79rKC8tCQjU
         B501QvsB7p71d/hRFQMkZaJNb/o/SurNP6oAa7FRQKhqR6f51wwvBabeOUT5Fnrlldfi
         esbkG4SJV08Lm3T8PKfnK++cCOvMw6X8yIW9EqQk8CjN6vgxUbXCABJAX6lxxD0lM4JP
         dK28NaRhw+VFAUcBzeqHgHHCDhDGJNfGxrZL0KZW7dUVhG7bp5KCcAxqUX3hZewBmleH
         ZnhQ==
X-Gm-Message-State: AOJu0YyfCHTadytNOd6DAiswH+wzlrKQijDCFC0VUrSxNSqiodkFzVQs
	s6wPvIoP6Ib3jvS6BO9NuG0=
X-Google-Smtp-Source: AGHT+IFc194CyjndQWvUJB6ENPNZtvGbOdf5FJ+ccq08DrmYdW9fRQz61yllo+akG4LZ7dEg4G/Y3w==
X-Received: by 2002:a17:906:1042:b0:a22:e690:f09f with SMTP id j2-20020a170906104200b00a22e690f09fmr7025864ejj.143.1703076031569;
        Wed, 20 Dec 2023 04:40:31 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906345600b00a269597d173sm604258ejb.135.2023.12.20.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:40:31 -0800 (PST)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: linuxfancy@googlegroups.com,
	sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	martin.hecht@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] media: i2c: alvium: store frame interval in subdev state
Date: Wed, 20 Dec 2023 13:40:22 +0100
Message-Id: <20231220124023.2801417-5-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220124023.2801417-1-tomm.merciai@gmail.com>
References: <20231220124023.2801417-1-tomm.merciai@gmail.com>
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
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes Since v1:
 - Removed FIXME comment and active state check into alvium_s_frame_interval
   as suggested by LPinchart.
 - Fixed call alvium_set_frame_rate() only for active state into alvium_s_frame_interval
   as suggested by LPinchart.

Changes Since v2:
 - Collected tag from LPinchart

 drivers/media/i2c/alvium-csi2.c | 48 +++++++++++----------------------
 drivers/media/i2c/alvium-csi2.h |  1 -
 2 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index ef137e6a2811..240bf991105e 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1641,25 +1641,6 @@ static int alvium_hw_init(struct alvium_dev *alvium)
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
@@ -1667,15 +1648,9 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 	struct alvium_dev *alvium = sd_to_alvium(sd);
 	struct device *dev = &alvium->i2c_client->dev;
 	u64 req_fr, dft_fr, min_fr, max_fr;
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
 
@@ -1699,8 +1674,13 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
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
@@ -1850,6 +1830,7 @@ static int alvium_init_state(struct v4l2_subdev *sd,
 {
 	struct alvium_dev *alvium = sd_to_alvium(sd);
 	struct alvium_mode *mode = &alvium->mode;
+	struct v4l2_fract *interval;
 	struct v4l2_subdev_format sd_fmt = {
 		.which = V4L2_SUBDEV_FORMAT_TRY,
 		.format = alvium_csi2_default_fmt,
@@ -1867,6 +1848,11 @@ static int alvium_init_state(struct v4l2_subdev *sd,
 	*v4l2_subdev_state_get_crop(state, 0) = sd_crop.rect;
 	*v4l2_subdev_state_get_format(state, 0) = sd_fmt.format;
 
+	/* Setup initial frame interval*/
+	interval = v4l2_subdev_state_get_interval(state, 0);
+	interval->numerator = 1;
+	interval->denominator = ALVIUM_DEFAULT_FR_HZ;
+
 	return 0;
 }
 
@@ -2236,7 +2222,7 @@ static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
 	.set_fmt = alvium_set_fmt,
 	.get_selection = alvium_get_selection,
 	.set_selection = alvium_set_selection,
-	.get_frame_interval = alvium_g_frame_interval,
+	.get_frame_interval = v4l2_subdev_get_frame_interval,
 	.set_frame_interval = alvium_s_frame_interval,
 };
 
@@ -2257,10 +2243,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
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


