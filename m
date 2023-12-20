Return-Path: <linux-kernel+bounces-6908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D28819F39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D3C2886C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037A3786D;
	Wed, 20 Dec 2023 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CooCuy7F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277F34CFB;
	Wed, 20 Dec 2023 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e51a7545dso757715e87.2;
        Wed, 20 Dec 2023 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703076029; x=1703680829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXBdGMYmMHVBCFYQFP2cAUD5aZM2nwh97dasVmKARbo=;
        b=CooCuy7Fksw0QQjXHNwDfpYgdAOXBvL535PR9jwB3qmrliCqWnYrRB4+DnTUpxb68Z
         hNIyc4W5/rWMbmOP8TkjCWc8sCui9Rum+qZsB1qbJ+8tKiV+cLz6rIyV3w8UE7RQ2B4H
         SlOI/pHHepu05uixSbXdTuS0QPrylGLx2XybNN6x/BrvZShiIK+8Ejp2NaatfHOq7aLr
         B2jxc9kbQTO4/9q/4kkA7BsV1qd7DLebCJtooKyexkEw4yasd6uFpRQtw7yoaqCG6abq
         7X6aOoEIpxSMUUha7pwlSqOypCviqqq6N5o70hunLTVvWEG8MUIKy4ILN9b9blYj90gm
         plOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703076029; x=1703680829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXBdGMYmMHVBCFYQFP2cAUD5aZM2nwh97dasVmKARbo=;
        b=btXYkcdsN/GcE98pXyKxYfQFqHac7LzsZIw+rewXHiXNQJIX8sKebK2svXni76mP6i
         JALf2SEjAKcxqgCsmZptwILGAG4YVpFPLXqSI/IKjI5sjRnJxqX7uaJDPUqax3KL5mtn
         NqF7QS0E7GaSx5IBQmFf9sdBiTgbaIYTtdv9MHfyJOrn2spFHdnfmjEMoIE6Dx225HYj
         yboUEVmHXq5ZyZY8Cm3gCgyDPBgAs5EFVEXJ+O5ff53UjkSnxdkR/3hvGJP6oPmuyR+Z
         +n3w/U5mdbbxJj70LV/8usi13ycQMXv2BiGOrUcPkAEEPePCudlnRgRaA7NDUQQgwfo+
         ROAQ==
X-Gm-Message-State: AOJu0YwPGbpRvIGhyzHcL1AHrG1+8VcK1p74g43UCmAce8+snqZM6Kg9
	GTtbTx6ac2LsoWl0WkKSx7Q=
X-Google-Smtp-Source: AGHT+IEXT3zbVQPdznjTdLbH2SAlmB9+OqBvIQzvgjroFyRyg8ldWeebsKVH5aASbGIKS4vXqanIpw==
X-Received: by 2002:a05:6512:791:b0:50e:35e8:806f with SMTP id x17-20020a056512079100b0050e35e8806fmr2445373lfr.47.1703076028597;
        Wed, 20 Dec 2023 04:40:28 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906345600b00a269597d173sm604258ejb.135.2023.12.20.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:40:28 -0800 (PST)
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
Subject: [PATCH v3 2/5] media: i2c: alvium: remove the fr field of the alvium_dev structure
Date: Wed, 20 Dec 2023 13:40:20 +0100
Message-Id: <20231220124023.2801417-3-tomm.merciai@gmail.com>
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

The fr (frame rate) field of the alvium_dev structure is
only used to pass result from alvium_set_frame_interval() to
alvium_set_frame_rate() that writes this info into the hw reg.
Replace it with a function parameter.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes Since v2:
 - Removed req_fr initializzation as suggested by LPinchart
 - Collected tag from LPinchart
 - Fixed commit msg and body as suggested by LPinchart

 drivers/media/i2c/alvium-csi2.c | 24 ++++++++++++------------
 drivers/media/i2c/alvium-csi2.h |  1 -
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 0dcd69bf9f92..994372030be9 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1185,19 +1185,19 @@ static int alvium_get_frame_interval(struct alvium_dev *alvium,
 	return ret;
 }
 
-static int alvium_set_frame_rate(struct alvium_dev *alvium)
+static int alvium_set_frame_rate(struct alvium_dev *alvium, u64 fr)
 {
 	struct device *dev = &alvium->i2c_client->dev;
 	int ret;
 
 	ret = alvium_write_hshake(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
-				  alvium->fr);
+				  fr);
 	if (ret) {
 		dev_err(dev, "Fail to set frame rate lanes reg\n");
 		return ret;
 	}
 
-	dev_dbg(dev, "set frame rate: %llu us\n", alvium->fr);
+	dev_dbg(dev, "set frame rate: %llu us\n", fr);
 
 	return 0;
 }
@@ -1661,10 +1661,11 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
 }
 
 static int alvium_set_frame_interval(struct alvium_dev *alvium,
-				     struct v4l2_subdev_frame_interval *fi)
+				     struct v4l2_subdev_frame_interval *fi,
+				     u64 *req_fr)
 {
 	struct device *dev = &alvium->i2c_client->dev;
-	u64 req_fr, dft_fr, min_fr, max_fr;
+	u64 dft_fr, min_fr, max_fr;
 	int ret;
 
 	if (fi->interval.denominator == 0)
@@ -1681,13 +1682,12 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
 	dev_dbg(dev, "fi->interval.denominator = %d\n",
 		fi->interval.denominator);
 
-	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
+	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
 		       fi->interval.numerator);
 
-	if (req_fr >= max_fr && req_fr <= min_fr)
-		req_fr = dft_fr;
+	if (*req_fr >= max_fr && *req_fr <= min_fr)
+		*req_fr = dft_fr;
 
-	alvium->fr = req_fr;
 	alvium->frame_interval.numerator = fi->interval.numerator;
 	alvium->frame_interval.denominator = fi->interval.denominator;
 
@@ -1699,6 +1699,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_frame_interval *fi)
 {
 	struct alvium_dev *alvium = sd_to_alvium(sd);
+	u64 req_fr;
 	int ret;
 
 	/*
@@ -1711,9 +1712,9 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 	if (alvium->streaming)
 		return -EBUSY;
 
-	ret = alvium_set_frame_interval(alvium, fi);
+	ret = alvium_set_frame_interval(alvium, fi, &req_fr);
 	if (!ret)
-		ret = alvium_set_frame_rate(alvium);
+		ret = alvium_set_frame_rate(alvium, req_fr);
 
 	return ret;
 }
@@ -2273,7 +2274,6 @@ static int alvium_subdev_init(struct alvium_dev *alvium)
 	/* Setup initial frame interval*/
 	alvium->frame_interval.numerator = 1;
 	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
-	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
 
 	/* Setup the initial mode */
 	alvium->mode.fmt = alvium_csi2_default_fmt;
diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
index 17f0bbbd1839..80066ac25047 100644
--- a/drivers/media/i2c/alvium-csi2.h
+++ b/drivers/media/i2c/alvium-csi2.h
@@ -443,7 +443,6 @@ struct alvium_dev {
 
 	struct alvium_mode mode;
 	struct v4l2_fract frame_interval;
-	u64 fr;
 
 	u8 h_sup_csi_lanes;
 	u64 link_freq;
-- 
2.34.1


