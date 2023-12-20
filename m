Return-Path: <linux-kernel+bounces-6911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44450819F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABF61F287BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02A03A266;
	Wed, 20 Dec 2023 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzQKicn2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33238DE9;
	Wed, 20 Dec 2023 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55372c1338bso3720585a12.2;
        Wed, 20 Dec 2023 04:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703076033; x=1703680833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/8vsrFsmIdkN6wX+xgjZzrqJBCn9bwK4adiKoP4ah4=;
        b=CzQKicn2MIokPQ0Qtpcr/iiB7dAvWxlQPI9p69Cwc9t4vVyR+Y9y2fj0qv2EHsTJ0b
         +SZwStExf2fhCJ1IW2LnY+1S9TcGGskBCQDfdL9ntaXFIqTSc0aW8GjqBTUtDNkvYnrl
         WXeJ2xH98+cQj77BMGqTbNe5fSboO8c23xO7qaQuNipzZANR/D60WJjzw/CIYf7yGh7B
         QISuFB0Ka8hCXMxf2QweVmK4GVXSefwAYCt5uypqNQ+G5PbY+A3ovFwBdaQmSKSKe/Jm
         2OGbRdK7pY+BhuyXfhYYnJ8XgG8q4MXJnZWDSK5X4QBbZj3nyenzlAQzR759piZgS8oX
         nV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703076033; x=1703680833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/8vsrFsmIdkN6wX+xgjZzrqJBCn9bwK4adiKoP4ah4=;
        b=lTcqJf5OQoJKy7vEIvd8haz1iYg94+iRJrc0WnoGXQXLwZwgGjy+FpvniDOwGZTv1C
         slPE/qeK19uswI67SAYtZJy6HETdgsCGTHlKF4FDcq95nzliXz38TwwyyGuc/5d4xdfg
         gom4YwRW2Vwj1G6XjCpgeBTe/Rp35w9DITrnDJ+pvRxFkcJVPLZ7+PH7W1cnCd8PSmZC
         tJnzPmA50TEb1NoJULgUZGq5Vs/O2Px5P0UvNZXQuZYn64pW3b9zYT9z/BIp9SKbJRBs
         KyPKL/yS4/OLQ+17oI5CEEkZJM6b7N7hiJpit4AsGbXj66wEysLjwvDTHggQYP5eFrOE
         PHjQ==
X-Gm-Message-State: AOJu0YxeoWD81w/kFiqYWVMQSd/mdVDJi4V0T7dwWLPlIiHwGPGc2eeK
	7v0kds6PaC+nazfngLhfnss=
X-Google-Smtp-Source: AGHT+IEddufbwv0CffqXBbRkP0gjGsls1zIkKQt72ukCuasMEuDugArS5PCYwMpWd6ZKRUv64IooIw==
X-Received: by 2002:a17:906:fa84:b0:a19:a19a:eac2 with SMTP id lt4-20020a170906fa8400b00a19a19aeac2mr8418440ejb.123.1703076033051;
        Wed, 20 Dec 2023 04:40:33 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906345600b00a269597d173sm604258ejb.135.2023.12.20.04.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:40:32 -0800 (PST)
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
Subject: [PATCH v3 5/5] media: i2c: alvium: fix req_fr check into alvium_s_frame_interval()
Date: Wed, 20 Dec 2023 13:40:23 +0100
Message-Id: <20231220124023.2801417-6-tomm.merciai@gmail.com>
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

Actually req_fr check into alvium_s_frame_interval() is wrong.
In particular req_fr can't be >=max and <= min at the same time.
Fix this using clamp and remove dft_fr parameter from
alvium_get_frame_interval() not more used.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index 240bf991105e..01111a00902d 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1171,12 +1171,10 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
 }
 
 static int alvium_get_frame_interval(struct alvium_dev *alvium,
-				     u64 *dft_fr, u64 *min_fr, u64 *max_fr)
+				     u64 *min_fr, u64 *max_fr)
 {
 	int ret = 0;
 
-	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
-		    dft_fr, &ret);
 	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R,
 		    min_fr, &ret);
 	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R,
@@ -1647,7 +1645,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 {
 	struct alvium_dev *alvium = sd_to_alvium(sd);
 	struct device *dev = &alvium->i2c_client->dev;
-	u64 req_fr, dft_fr, min_fr, max_fr;
+	u64 req_fr, min_fr, max_fr;
 	struct v4l2_fract *interval;
 	int ret;
 
@@ -1657,7 +1655,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 	if (fi->interval.denominator == 0)
 		return -EINVAL;
 
-	ret = alvium_get_frame_interval(alvium, &dft_fr, &min_fr, &max_fr);
+	ret = alvium_get_frame_interval(alvium, &min_fr, &max_fr);
 	if (ret) {
 		dev_err(dev, "Fail to get frame interval\n");
 		return ret;
@@ -1670,9 +1668,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
 
 	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
 		       fi->interval.numerator);
-
-	if (req_fr >= max_fr && req_fr <= min_fr)
-		req_fr = dft_fr;
+	req_fr = clamp(req_fr, min_fr, max_fr);
 
 	interval = v4l2_subdev_state_get_interval(sd_state, 0);
 
-- 
2.34.1


