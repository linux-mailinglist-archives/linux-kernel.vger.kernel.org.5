Return-Path: <linux-kernel+bounces-6909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EAC819F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BD328831F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63438DDA;
	Wed, 20 Dec 2023 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlpSaHlY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0663236AFC;
	Wed, 20 Dec 2023 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso7035914a12.2;
        Wed, 20 Dec 2023 04:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703076030; x=1703680830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1+J3MJbe6MF9SpStiPnGtAPzoLLgmQl4VRPW/1tgxQ=;
        b=XlpSaHlYpchzXtGkcAJdmai0rUofRjl/aFSK9mYoZRsKqSMLry7taKJdsW02+4zDgN
         JKgFdJFeVkGKNTThFNnOiQYAnuWl3xjzuPIpCHv5lkXhQon72HaGoex5qDlLAYEBDx7+
         mWBsKubF3zwqzOUrLrehgv22zsF7QFzmx8zPFa2kCiZfpa+yG8O/n79cfkXkAkgGIB0c
         +9dia1ROvm68P98tYV2WfmagbfE4w9psCrEXkao2wVneirTAi/BKWRjeS0x69PICAkzG
         QurxdMTvYxFHkKjVYy0B8gJ9UhLTpNQNlsIF9Y8SY0YS2TLHL1fmK1vPJkCK97L5PzgG
         osaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703076030; x=1703680830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1+J3MJbe6MF9SpStiPnGtAPzoLLgmQl4VRPW/1tgxQ=;
        b=jQJXYA3iKHF5qMWLx4rPghn85jZaN0jcaE+5DMaTU+339WqGbAlqq9mNfqCdBGp2Vf
         imIzfFDDXwseu1HS8HtQMXbM4onOeAfErrVdXCRmU/RqaCexKlFLC97sv6hynIcp8oC+
         tZIR11MVbXqO/TNU91A48g4tfgHbPp+FO+52rR+acfDt0Mn5rUqaZKN+qNvzuRT69kqG
         qIKfikm9BRw5xNmANLw/hzQmR3XnfKRq/0+7yB0FYQhvFylsLQylkprBQHOGs0SkA7Is
         kwB4r+ejzCeWxI2NRR33546BuhUUP/DiEakJqVeuylS0G/I3ZMSiQ+tBfMTo6ia3cY9/
         EBzA==
X-Gm-Message-State: AOJu0YzuPE5XRsn4Hg96rba4aQYyopnMsfZGHnvzGLnMx3s88CE9WSsa
	vPpemuM5Kom8+aZ44aQmzKI=
X-Google-Smtp-Source: AGHT+IEE98HodO2AD8+mijr1sF+n/30cm466JNlWXVHm5yqEretfJkovm7hMxLiFQLSQKUgfT4fGtw==
X-Received: by 2002:a17:906:208d:b0:a23:3753:c64c with SMTP id 13-20020a170906208d00b00a233753c64cmr3567114ejq.57.1703076030054;
        Wed, 20 Dec 2023 04:40:30 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906345600b00a269597d173sm604258ejb.135.2023.12.20.04.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:40:29 -0800 (PST)
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
Subject: [PATCH v3 3/5] media: i2c: alvium: inline set_frame_interval into s_frame_interval
Date: Wed, 20 Dec 2023 13:40:21 +0100
Message-Id: <20231220124023.2801417-4-tomm.merciai@gmail.com>
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

Inline alvium_set_frame_interval() into alvium_s_frame_interval().
The alvium_set_frame_interval() is called once only, by
alvium_s_frame_interval(). The latter is a thin wrapper around the
former. Inline the function in its caller to make the code more
readable.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes Since v1:
 - Now this commit is the 3/4 of the series
 - Fixed commit body as suggested by LPinchart

Changes Since v2:
 - Removed req_fr initializzation as suggested by LPinchart
 - Collected tag from LPinchart

 drivers/media/i2c/alvium-csi2.c | 52 ++++++++++++---------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 994372030be9..ef137e6a2811 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1660,14 +1660,25 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int alvium_set_frame_interval(struct alvium_dev *alvium,
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
 
@@ -1682,41 +1693,16 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
 	dev_dbg(dev, "fi->interval.denominator = %d\n",
 		fi->interval.denominator);
 
-	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
+	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
 		       fi->interval.numerator);
 
-	if (*req_fr >= max_fr && *req_fr <= min_fr)
-		*req_fr = dft_fr;
+	if (req_fr >= max_fr && req_fr <= min_fr)
+		req_fr = dft_fr;
 
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
-	ret = alvium_set_frame_interval(alvium, fi, &req_fr);
-	if (!ret)
-		ret = alvium_set_frame_rate(alvium, req_fr);
-
-	return ret;
+	return alvium_set_frame_rate(alvium, req_fr);
 }
 
 static int alvium_enum_mbus_code(struct v4l2_subdev *sd,
-- 
2.34.1


