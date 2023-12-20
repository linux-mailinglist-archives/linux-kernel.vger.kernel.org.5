Return-Path: <linux-kernel+bounces-6610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67313819AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F5F1C22451
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1D71F600;
	Wed, 20 Dec 2023 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZyZjVPe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342C21D6AE;
	Wed, 20 Dec 2023 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso761860a12.1;
        Wed, 20 Dec 2023 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703062575; x=1703667375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jIpVU9lsgBmtKqRr7Ozp3idnHWbKwd3zW4X8TzJVcM=;
        b=aZyZjVPefqdNn2j7Awh2BjuEvMiQivun/jLc8QC8hBHQMqFIC0ErAd5UOK4X3i8XoP
         yUFJaeMwLbOGaipjbz62PYYYsZd+SturHDUldPRlBItAw731oWphbxYYLlB9yRlnCZan
         iOfQDmfmclmBCXFriRu07rqyd0Rt0LtTMGDtD5Q9BC6Zp9qsgRP3L7NyCFuH0Al/5T5O
         uvxqXrz6pl44HiqyhMLlaEGL4NKqzGGe6GQI1ymlg3hN7A/Z+onzdwy6Q+OwTmMEobid
         P8jupxxiWuzBsa92Ig271bzEGP+1z/BpL2jj2BJm/toBMAbPnz0uOj9IsCk60OSqIhIK
         aZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062575; x=1703667375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jIpVU9lsgBmtKqRr7Ozp3idnHWbKwd3zW4X8TzJVcM=;
        b=VaFipnHrHFQU51b00hAkXjz9jf7dhVekh5A4uhKItidrxTdOEEMbNbiKSZg9VeqgtJ
         GDX1AKMYiJuoBJe/iyRWG7/8r0bi4bK4DrH2lmSsxpS44zTd7ZF157hZLITumiE/1L9p
         EwmV9JGUEKOcznnGl2E8GV5dK0GkkQUqVb5qqz+Wyu5Xzv+oINH7F+uhIzmzCEm21rH8
         ZqWdDLoe1SZojxcN2AuJMyDLBek9gsEjdLUzdL3akBoloo756MLRITNUuHxMPWsChhay
         jtSERrELf/mQXLxl6O8olI6hLeX1FvGpf2odJtpDlG71kOImeO3Jx385hA6KHdH5yvK0
         DF2Q==
X-Gm-Message-State: AOJu0YwXtG4MByEcMAVLWcb+jC7Q1Gv8X34VLwDji0fuSat+jBn5ealT
	eNjGKKJwc3U/SMAGxb98Hi8=
X-Google-Smtp-Source: AGHT+IF/L8rSeFC824o91YIxIVHp8hzrCeVTrWauPjnN5DlvT3StN0Mi01SKdFVTtYbc+Xn06dtQwA==
X-Received: by 2002:a50:f689:0:b0:553:fbff:d2cd with SMTP id d9-20020a50f689000000b00553fbffd2cdmr1070edn.83.1703062575304;
        Wed, 20 Dec 2023 00:56:15 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id cq12-20020a056402220c00b0055335e89ed8sm3532169edb.30.2023.12.20.00.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:56:14 -0800 (PST)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: linuxfancy@googlegroups.com,
	laurent.pinchart@ideasonboard.com,
	martin.hecht@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] media: i2c: alvium: removal of fr field
Date: Wed, 20 Dec 2023 09:56:07 +0100
Message-Id: <20231220085609.2595732-3-tomm.merciai@gmail.com>
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

The fr (frame rate) field of the alvium_dev structure is
only used to pass result from alvium_set_frame_interval() to
alvium_set_frame_rate() that writes this info into the hw reg.
Replace them with function parameter.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 24 ++++++++++++------------
 drivers/media/i2c/alvium-csi2.h |  1 -
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 0dcd69bf9f92..a9ff6cc97cff 100644
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
+	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
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


