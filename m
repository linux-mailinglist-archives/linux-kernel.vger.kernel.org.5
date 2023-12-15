Return-Path: <linux-kernel+bounces-614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057B681438A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B262C28427A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55FF182B5;
	Fri, 15 Dec 2023 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnkV30fS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E64171D6;
	Fri, 15 Dec 2023 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a1d93da3eb7so44806966b.0;
        Fri, 15 Dec 2023 00:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702628699; x=1703233499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXavCEOPr4iSD0C6FGudUMpba9nYCcbhn+aT3MsQBmU=;
        b=YnkV30fShGc0OWirWhG8DX/e3A/gPD/t7Ht7+4ebZ1aaUSgJXZNcfd7sV7NvBIn0hf
         VLLMc6IOgXISQ4nOwiqovyMsM/EFvF/MOtNGDAVwerZ4xQb1AE0c/740agRFrwPF2hI+
         4WP6E9JwVq+IsfcEchrcOnNCf2zNTcfbhommopPIUCLi26jMdmJOA3xMGVnFNJZx5pKY
         bpSTSwNzicLVDGRAPqkIqfyiey5keTUx9m2A9hdVYsoGrecqgFFgLH36as60vrjdT79j
         yynwTRwuOOmrTbrmYXep3Mmd2Mz/Zgh6nlrbtVCvNeUXmvs1ctn9xy8T2qCGIFxkgEBi
         knAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628699; x=1703233499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXavCEOPr4iSD0C6FGudUMpba9nYCcbhn+aT3MsQBmU=;
        b=lOV9I+1cMSB1BPQ8Dy9vXxWBCFx6Ld/a3PLbFYDvZbHyx6Rks6brPHBCZUhIbR7Hkz
         RDV+1O6lSUaT6VRCSuHmLIqIj5F96bWYbW8C0xiKH4eVtw7tpAbuE85lnlJ5+hVn+Z6g
         ScKZO9mZaA8CNaAtXJ/Pj/txlNx08GExn70/EBPtyIVKqMYEd/dMbgfyKPE7I1umsg9W
         I6foa0hSObRcn0LK91knFw1aGKX/wm+FtJoxJU0aji7U1wYgkqCZUy5eKjn/vWqeVBCE
         Evh+bdWM0yDPS+S0KtGZoKZK4RWB2G+eF0QDUiPfzulwWmMeZktcnc3eY7Lkw6pFVR8E
         FEsA==
X-Gm-Message-State: AOJu0YyWzdWsvwLXgiCW2ymTv9BnWFsvUwGbGhGM8IDHn+ZSW3XI0FXQ
	AjJJjibBrD6comU4VGMGTno=
X-Google-Smtp-Source: AGHT+IGl3C8K5Cey16qOIp2+DSDUrXM2P0vgoy5y9p/ZYLInnc7buNdYQYPbC7AkTYhNOrygMRURxw==
X-Received: by 2002:a17:907:503:b0:9c4:b8c9:1bf4 with SMTP id wj3-20020a170907050300b009c4b8c91bf4mr4291794ejb.19.1702628698533;
        Fri, 15 Dec 2023 00:24:58 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id un7-20020a170907cb8700b00a1b65249053sm10395951ejc.128.2023.12.15.00.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:24:58 -0800 (PST)
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
Subject: [PATCH 2/3] media: i2c: alvium: inline set_frame_interval into s_frame_interval
Date: Fri, 15 Dec 2023 09:24:51 +0100
Message-Id: <20231215082452.1720481-3-tomm.merciai@gmail.com>
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

Inline alvium_s_frame_interval function into alvium_s_frame_interval.
This to clean the driver code.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 56 ++++++++++++---------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index c4b7851045a1..fde456357be1 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1662,16 +1662,25 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int alvium_set_frame_interval(struct alvium_dev *alvium,
-				     struct v4l2_subdev *sd,
-				     struct v4l2_subdev_state *sd_state,
-				     struct v4l2_subdev_frame_interval *fi,
-				     u64 *req_fr)
+static int alvium_s_frame_interval(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_state *sd_state,
+				   struct v4l2_subdev_frame_interval *fi)
 {
+	struct alvium_dev *alvium = sd_to_alvium(sd);
 	struct device *dev = &alvium->i2c_client->dev;
-	u64 dft_fr, min_fr, max_fr;
+	u64 req_fr, dft_fr, min_fr, max_fr;
 	int ret;
 
+	/*
+	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
+	 * subdev active state API.
+	 */
+	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
+		return -EINVAL;
+
+	if (alvium->streaming)
+		return -EBUSY;
+
 	if (fi->interval.denominator == 0)
 		return -EINVAL;
 
@@ -1686,42 +1695,17 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
 	dev_dbg(dev, "fi->interval.denominator = %d\n",
 		fi->interval.denominator);
 
-	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
+	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
 		       fi->interval.numerator);
 
-	if (*req_fr >= max_fr && *req_fr <= min_fr)
-		*req_fr = dft_fr;
+	if (req_fr >= max_fr && req_fr <= min_fr)
+		req_fr = dft_fr;
 
-	alvium->fr = *req_fr;
+	alvium->fr = req_fr;
 	alvium->frame_interval.numerator = fi->interval.numerator;
 	alvium->frame_interval.denominator = fi->interval.denominator;
 
-	return 0;
-}
-
-static int alvium_s_frame_interval(struct v4l2_subdev *sd,
-				   struct v4l2_subdev_state *sd_state,
-				   struct v4l2_subdev_frame_interval *fi)
-{
-	struct alvium_dev *alvium = sd_to_alvium(sd);
-	u64 req_fr;
-	int ret;
-
-	/*
-	 * FIXME: Implement support for V4L2_SUBDEV_FORMAT_TRY, using the V4L2
-	 * subdev active state API.
-	 */
-	if (fi->which != V4L2_SUBDEV_FORMAT_ACTIVE)
-		return -EINVAL;
-
-	if (alvium->streaming)
-		return -EBUSY;
-
-	ret = alvium_set_frame_interval(alvium, sd, sd_state, fi, &req_fr);
-	if (!ret)
-		ret = alvium_set_frame_rate(alvium, req_fr);
-
-	return ret;
+	return alvium_set_frame_rate(alvium, req_fr);
 }
 
 static int alvium_enum_mbus_code(struct v4l2_subdev *sd,
-- 
2.34.1


