Return-Path: <linux-kernel+bounces-613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8855814389
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602FD1F25592
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF6171DB;
	Fri, 15 Dec 2023 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTIHG7CN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1212E40;
	Fri, 15 Dec 2023 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a22f2a28c16so52157466b.0;
        Fri, 15 Dec 2023 00:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702628697; x=1703233497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiWcmWF3ECN1EHsWLphg963xq61PlotZ875/+bCwtkY=;
        b=eTIHG7CNtuTIsy1p9b1EshQ96WasPGw4TqF7QoA5XUD2Xv03oE9q64e+jofRcPmY1K
         MdBvIFMmAmd/vWkpGjSvmFTMd1lawoC2O+6CFbNAVyjze9wQ4LgRDNAAg4ejrlEDbziM
         ayVptMppyXLNZXrpH+vqg1NUCtxtb+d5jRP1EhStHkC6b0MC3hchaoC1BFjzelFg27Wp
         CPXbQC2tdhYvUPW68lfuM2SPwjULVcMZslDH2+ErN+BuVNXWwZz95yt9I8eHxTJHYH6A
         18dYoY2bd3rhuQpSYOaePjtkY46GL76c8cgu6CIqPAzq3y2BJxhNOD/pFbpbWQpPhpfv
         c6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628697; x=1703233497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiWcmWF3ECN1EHsWLphg963xq61PlotZ875/+bCwtkY=;
        b=lM7HoP7AD+Sp6xZ5CrS6FWaitvnUgbVqrkuYPCGUXBMwnOhcpdr2Zi0wCDJW2b7I01
         2RokihiGrjgZhgmlh5qoqU0TPhWS8ZQKDNiwmZOxQOhMhwzeekLVAuyw7LcD1GyeKNOt
         ER/2yCpkoSH4JW4qE7jRMQZ0CJ0rDpf6YBPi4ugCQ11yTk3HRx00ckZk3fjyTnhVm3tQ
         OiymE/iuV0dQO1kPvBZ4I64uQIeW5fReZXUAeJvk59r5Z+S9eOdI4+gSeGXgvZ5LcqHp
         sLgpEoRKt5de/VENoNtBEJGy3lCh1JDdyZD9SEw8/GqHDvQoQ0HECKdfIjJLu1Htj243
         VcMQ==
X-Gm-Message-State: AOJu0YxFNTKV84hrDN/TbRQD6PBjtTVDHlP37u5pg+v6aNPYzv9T988V
	guJ856tYLRfGUJLWb/9cKvQ=
X-Google-Smtp-Source: AGHT+IGo5SfWEhbBQyTNURRiTXDMeP5uROQfe2ogLhMjzmtSPlpiB02zE+JFb0Ki5lLBfP72bbpwGQ==
X-Received: by 2002:a17:907:7e8c:b0:a10:f087:ba43 with SMTP id qb12-20020a1709077e8c00b00a10f087ba43mr4299846ejc.43.1702628696676;
        Fri, 15 Dec 2023 00:24:56 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id un7-20020a170907cb8700b00a1b65249053sm10395951ejc.128.2023.12.15.00.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:24:56 -0800 (PST)
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
Subject: [PATCH 1/3] media: i2c: alvium: removal of dft_fr, min_fr and max_fr
Date: Fri, 15 Dec 2023 09:24:50 +0100
Message-Id: <20231215082452.1720481-2-tomm.merciai@gmail.com>
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

Remove driver private data dft_fr, min_fr and max_fr.
Those are used only in alvium_set_frame_interval function.
Use local ones instead.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 45 +++++++++++++++------------------
 drivers/media/i2c/alvium-csi2.h |  3 ---
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 34ff7fad3877..c4b7851045a1 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1170,40 +1170,36 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
 	return 0;
 }
 
-static int alvium_get_frame_interval(struct alvium_dev *alvium)
+static int alvium_get_frame_interval(struct alvium_dev *alvium,
+				     u64 *dft_fr, u64 *min_fr, u64 *max_fr)
 {
-	u64 dft_fr, min_fr, max_fr;
 	int ret = 0;
 
 	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
-		    &dft_fr, &ret);
+		    dft_fr, &ret);
 	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R,
-		    &min_fr, &ret);
+		    min_fr, &ret);
 	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R,
-		    &max_fr, &ret);
+		    max_fr, &ret);
 	if (ret)
 		return ret;
 
-	alvium->dft_fr = dft_fr;
-	alvium->min_fr = min_fr;
-	alvium->max_fr = max_fr;
-
 	return 0;
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
@@ -1667,36 +1663,36 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
 }
 
 static int alvium_set_frame_interval(struct alvium_dev *alvium,
-				     struct v4l2_subdev_frame_interval *fi)
+				     struct v4l2_subdev *sd,
+				     struct v4l2_subdev_state *sd_state,
+				     struct v4l2_subdev_frame_interval *fi,
+				     u64 *req_fr)
 {
 	struct device *dev = &alvium->i2c_client->dev;
-	u64 req_fr, min_fr, max_fr;
+	u64 dft_fr, min_fr, max_fr;
 	int ret;
 
 	if (fi->interval.denominator == 0)
 		return -EINVAL;
 
-	ret = alvium_get_frame_interval(alvium);
+	ret = alvium_get_frame_interval(alvium, &dft_fr, &min_fr, &max_fr);
 	if (ret) {
 		dev_err(dev, "Fail to get frame interval\n");
 		return ret;
 	}
 
-	min_fr = alvium->min_fr;
-	max_fr = alvium->max_fr;
-
 	dev_dbg(dev, "fi->interval.numerator = %d\n",
 		fi->interval.numerator);
 	dev_dbg(dev, "fi->interval.denominator = %d\n",
 		fi->interval.denominator);
 
-	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
+	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
 		       fi->interval.numerator);
 
-	if (req_fr >= max_fr && req_fr <= min_fr)
-		req_fr = alvium->dft_fr;
+	if (*req_fr >= max_fr && *req_fr <= min_fr)
+		*req_fr = dft_fr;
 
-	alvium->fr = req_fr;
+	alvium->fr = *req_fr;
 	alvium->frame_interval.numerator = fi->interval.numerator;
 	alvium->frame_interval.denominator = fi->interval.denominator;
 
@@ -1708,6 +1704,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_frame_interval *fi)
 {
 	struct alvium_dev *alvium = sd_to_alvium(sd);
+	u64 req_fr;
 	int ret;
 
 	/*
@@ -1720,9 +1717,9 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 	if (alvium->streaming)
 		return -EBUSY;
 
-	ret = alvium_set_frame_interval(alvium, fi);
+	ret = alvium_set_frame_interval(alvium, sd, sd_state, fi, &req_fr);
 	if (!ret)
-		ret = alvium_set_frame_rate(alvium);
+		ret = alvium_set_frame_rate(alvium, req_fr);
 
 	return ret;
 }
diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
index 8b554bffdc39..a6529b28e7dd 100644
--- a/drivers/media/i2c/alvium-csi2.h
+++ b/drivers/media/i2c/alvium-csi2.h
@@ -443,9 +443,6 @@ struct alvium_dev {
 
 	struct alvium_mode mode;
 	struct v4l2_fract frame_interval;
-	u64 dft_fr;
-	u64 min_fr;
-	u64 max_fr;
 	u64 fr;
 
 	u8 h_sup_csi_lanes;
-- 
2.34.1


