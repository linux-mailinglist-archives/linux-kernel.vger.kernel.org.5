Return-Path: <linux-kernel+bounces-6907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD22D819F35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500BCB24DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DAE34569;
	Wed, 20 Dec 2023 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5UnaQr/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF212554D;
	Wed, 20 Dec 2023 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-553e22940a3so679582a12.1;
        Wed, 20 Dec 2023 04:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703076027; x=1703680827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWwFXzxbsWD+eQjlH7n7kgrlKUOxZZeQ7Eomxz4YCo4=;
        b=Z5UnaQr/HdRHA1eQFkaE68RA7ya68TpG2RIyCF2+wnXbSDC8ZDcKmWNMwe6uRncuuq
         beZuJYLLU0e0+r5jnmSiKvzjduYBEUugluNRPnbGkMlpJeTXKSe/HP8JUzDUHrQdIsJL
         cZOqB9F6tzwDgZ0i2GgfzEXnSh3lAKy0ArnbLIoOS5NbNp1jVqPQgoahVQUAXHhTej0P
         INutTStSnwSfZgayJRsGPlExnqRk2T4zZ7ekIIXUNBYD6/Dq7ZLCDYj0Lrqro2GPe1uP
         29hCEt3AaxeFDQduoQpFezsuE2OhczOQPJVo4Cs3rrEF4/RT6GndbC//KgKTlJCEPJqx
         ALUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703076027; x=1703680827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWwFXzxbsWD+eQjlH7n7kgrlKUOxZZeQ7Eomxz4YCo4=;
        b=FXJMT1bmCqA6KRr7xRJ3FnxndPvR/jg6t4UI15CMzVtxJqo+Rt69WIcEhyvjhtfstZ
         d9BBdZ5WYxhEFLpF5c+2y2Iw94Rt3Du1AhUml3zGfMosxcxFmK4HvGiDVbkpT2q9vTC6
         3iT/8AjU9K7/l8aAPaRjZiLXrIQnflIlQUEC1aUUUvtJKb1HH7y3vIjDV62JY/3l7+xa
         B4uMEIkz20zeasp5MVfLAmIa0fmg4hjEJWaO2bOWtDmL9DlLui6FChi3J5CQds2tqFry
         fkwyZ4eW409rfYN1gdx/FUjT26oaKMVt09sypEiW0ai1xHM+OHdITPvL7yf56NAkNjDZ
         TMVg==
X-Gm-Message-State: AOJu0Yw1fAmzsoAwLNnEW2b53AjIW762CulEOdZetfLkK5Ig2E0KIcwg
	YtnFfLNQMqyJLQS3SgZyd28=
X-Google-Smtp-Source: AGHT+IHUWqxbR0nJod7+isZAgxPzMZ14Bc06V9NidblLYHUio4wotzNWyRMIK4uplPjI9kJDNjoRRQ==
X-Received: by 2002:a17:907:e8f:b0:a1c:9738:2235 with SMTP id ho15-20020a1709070e8f00b00a1c97382235mr14670778ejc.118.1703076027037;
        Wed, 20 Dec 2023 04:40:27 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id d22-20020a170906345600b00a269597d173sm604258ejb.135.2023.12.20.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:40:26 -0800 (PST)
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
Subject: [PATCH v3 1/5] media: i2c: alvium: removal of dft_fr, min_fr and max_fr
Date: Wed, 20 Dec 2023 13:40:19 +0100
Message-Id: <20231220124023.2801417-2-tomm.merciai@gmail.com>
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

The dft_fr, min_fr and max_fr fields of the alvium_dev structure are
only used to pass results from alvium_get_frame_interval() to its
caller. Replace them with function parameters.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes Since v1:
 - Fixed commit body as suggested by LPinchart
 - Fixed alvium_get_frame_interval just return ret as suggested by LPinchart
 - Removed unrelated chnages from the commit as suggested by LPinchart

Changes Since v2:
 - Collected tag from LPinchart

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


