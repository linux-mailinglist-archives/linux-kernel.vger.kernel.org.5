Return-Path: <linux-kernel+bounces-604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F71814376
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E606B1C22623
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F04B12E4E;
	Fri, 15 Dec 2023 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQDEfI4y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68716418;
	Fri, 15 Dec 2023 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54f4b31494fso630746a12.1;
        Fri, 15 Dec 2023 00:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702628499; x=1703233299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LiWcmWF3ECN1EHsWLphg963xq61PlotZ875/+bCwtkY=;
        b=bQDEfI4ygoVZ2degyXgWnfnMXagCYM4mci4FsSwsxNCXi1C6308KCrZRDAlRopi/8f
         yVLOWzjmEN7BCGTwSf+QydfNYGOPcxOEEhUemBOZMSQ317bvuz+JMYUYkuk8M9dnC8cd
         MIQqkr0A4uc/UDa6VwEKy9Kti6ApJcHfCH76Z4nAaqBPW286HLuiWlqF+hSrA83tptzv
         MEYhjfPAPDgIWvdIQ48RUYgXcBrU+YYY7PW4czRw7unT6AV/5wNQEypEuhQ9qC5EODNd
         E0hRs0jEB5y6sgnbKjAnhdoYDRKoNwj+fTXxxSczVnWIL8OWd+Zrfag/OsmA6/9KPROd
         Ec8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628499; x=1703233299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiWcmWF3ECN1EHsWLphg963xq61PlotZ875/+bCwtkY=;
        b=n7UCy/KVOqZOAoYu/fQe3TWHlSs4+z1pGVOJiPclJJXNwj2Rf0+cTZ7FD45M2ExQJ0
         xlU6lcw8F95Ev19IDOlKGoPZ//EuXMuyXCAZwV6kd7A9tEc0I3gVC6QV0G9IXwSujpuJ
         U8e7ohn4f8O3fzbtp0kAZ//tg1qrFiU4GEoUQ4ZfBdmg7wrv337qsKqAKi5MzAafdanH
         WCD2QWF9NeeZfHq/p+Yt/k+fGbhEPfI2yjI0dDKezxA9vWXKf/E+nb5G+f4RnIS6oonv
         oSsni3QDqfaVV5h/4soNczXQo2ZGU8YqjETJ7nD9VrpEDv7F9eT/bNgtGqoQMEzQ68bz
         nEFA==
X-Gm-Message-State: AOJu0YyOIZNbt1ScaVKzdytaQEnROBRxvFvun8Tk772/EmalE6NnIcE4
	EqWL/5sDRG62RvU2QH+RcDg=
X-Google-Smtp-Source: AGHT+IHuyIchFw4EB2nRZd5zCepUqx0SjHR4Q1uiqd7WZ1L4ag8QnK5EtQSeDxvk5A+zMJSCRxRV4g==
X-Received: by 2002:a50:d7d4:0:b0:54c:542d:3afb with SMTP id m20-20020a50d7d4000000b0054c542d3afbmr12320236edj.36.1702628499242;
        Fri, 15 Dec 2023 00:21:39 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id m29-20020a50999d000000b0054cc903baadsm7911591edb.30.2023.12.15.00.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:21:38 -0800 (PST)
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
Date: Fri, 15 Dec 2023 09:21:36 +0100
Message-Id: <20231215082136.1720379-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
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


