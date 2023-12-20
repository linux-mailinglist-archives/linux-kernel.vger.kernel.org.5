Return-Path: <linux-kernel+bounces-6609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7E819AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223A31C221FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA3E1DA4B;
	Wed, 20 Dec 2023 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE4RapPL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090F1D525;
	Wed, 20 Dec 2023 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e1112b95cso6013306e87.0;
        Wed, 20 Dec 2023 00:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703062574; x=1703667374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcrj7N0as+K9JwFYGseO302P7BY3oZHdFmSWKg4fM4k=;
        b=HE4RapPLUK2XqJ7yHvegv+Kn4MT2OlRSMluAbP3RUhlHkxk34I0j3MCzhcs5MV9VNT
         7DwHuoOsqCaBj1FOFRIHVXop7WTPtWGFNj6jKGL0OtsBGs2nBDLYp+cG1EOzjQcgQXCt
         +ncmJn9VGZoAoa5icByEbvcwKY6NYzluH/l/QVcu3jJnE6UGQtaAA5IRpYn1XsT8Kf9X
         El8Urz4pw6sTt50CDL5lHolMZzli890lghfOotjpuUd3pqu7NGOiCRS3bC1825OKLlDV
         8ujTdgC+00gbzuGsXUtyaZN5eyYZ7TPyqMlY1lPlcyj/FaxUhSZt8zKQbo1owk4/qhCu
         OlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062574; x=1703667374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcrj7N0as+K9JwFYGseO302P7BY3oZHdFmSWKg4fM4k=;
        b=IioqPWKLQWaWNBS7Q/gNRHrGthPdJWlYj4g6dYEueiVcpM+toc5qKolX5YNY+iuddb
         LxHJB409V3vGpb8Iuo0zzE9XdvkNGebXHHzPvJnXJj86Mzdzp6Erv25QE7X/mTlQmBL+
         jyHxlOuH9cRECGuC2bRAsZOXiijBAkrsExp4qpN/A8GpdS8hqTn9Wz0pGTO8PidYeJ+5
         gLaOzJ0jB9kRsfRjfMY13wLT84VJPtJb7CIv628o+w3mwCG7Zq7G77/KEQVYPfKT8okZ
         VRYAnwcHUim+KxioOI/Td1QO11xcNh0KZjXuHQPHL6gnbdeDvIJ1zP3Cy+nqFke/A4Mz
         4Dgw==
X-Gm-Message-State: AOJu0Yx53XkATeIyJCKlAhB4Xa3Da/DI6UT17eKUiN7t4E1+b4SWBCXE
	1hbPCaeHx5xJf0DebcZGmyU=
X-Google-Smtp-Source: AGHT+IGdq1o9spxZDiWPDJb6CVtLH2IfiX76uDlX+qHaQHgnu8Hu9bLncaDJu3gsj31S0b+54YAFBA==
X-Received: by 2002:a05:6512:a90:b0:50e:4b8a:df85 with SMTP id m16-20020a0565120a9000b0050e4b8adf85mr757640lfu.58.1703062573675;
        Wed, 20 Dec 2023 00:56:13 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id cq12-20020a056402220c00b0055335e89ed8sm3532169edb.30.2023.12.20.00.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:56:13 -0800 (PST)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: linuxfancy@googlegroups.com,
	laurent.pinchart@ideasonboard.com,
	martin.hecht@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] media: i2c: alvium: removal of dft_fr, min_fr and max_fr
Date: Wed, 20 Dec 2023 09:56:06 +0100
Message-Id: <20231220085609.2595732-2-tomm.merciai@gmail.com>
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

The dft_fr, min_fr and max_fr fields of the alvium_dev structure are
only used to pass results from alvium_get_frame_interval() to its
caller. Replace them with function parameters.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes Since v1:
 - Fixed commit body as suggested by LPinchart
 - Fixed alvium_get_frame_interval just return ret as suggested by LPinchart
 - Removed unrelated chnages from the commit as suggested by LPinchart

 drivers/media/i2c/alvium-csi2.c | 27 +++++++++------------------
 drivers/media/i2c/alvium-csi2.h |  3 ---
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 34ff7fad3877..0dcd69bf9f92 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1170,25 +1170,19 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
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
-	if (ret)
-		return ret;
-
-	alvium->dft_fr = dft_fr;
-	alvium->min_fr = min_fr;
-	alvium->max_fr = max_fr;
+		    max_fr, &ret);
 
-	return 0;
+	return ret;
 }
 
 static int alvium_set_frame_rate(struct alvium_dev *alvium)
@@ -1670,21 +1664,18 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
 				     struct v4l2_subdev_frame_interval *fi)
 {
 	struct device *dev = &alvium->i2c_client->dev;
-	u64 req_fr, min_fr, max_fr;
+	u64 req_fr, dft_fr, min_fr, max_fr;
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
@@ -1694,7 +1685,7 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
 		       fi->interval.numerator);
 
 	if (req_fr >= max_fr && req_fr <= min_fr)
-		req_fr = alvium->dft_fr;
+		req_fr = dft_fr;
 
 	alvium->fr = req_fr;
 	alvium->frame_interval.numerator = fi->interval.numerator;
diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
index b85a25169e79..17f0bbbd1839 100644
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


