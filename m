Return-Path: <linux-kernel+bounces-6611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055DE819AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F274B25E28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D14200CD;
	Wed, 20 Dec 2023 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf8zYxAT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D521DA5E;
	Wed, 20 Dec 2023 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-553b3ee88c0so1142012a12.0;
        Wed, 20 Dec 2023 00:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703062577; x=1703667377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afxqRg0BdzPXAqeEmb0814lNgbcWkJx4M3LyS7SIRlE=;
        b=Lf8zYxAT9PB+T77ilVlTE88tLKnHbHsUl7OX2CiZceS9Z4me37V6MnsLx5Hfme5l1V
         oy+W9gb6cf2ewhd92sZsUn0bKiNczFIfhsW+NL6hUtOpLVKqG9oRoQYIr5LwL/OrTN4f
         OemmhnFyAtFQB2CSZ8BO5q7S7K3b5RDiQRykFg9C5FvpF9C6QcQaTasj7eK8DZrXuYqZ
         i3DaASdL6KW6U5liqGWY57tgXfgYb1dHhPqX04cM6TgBLvAAYGqHUWN+i5fibKOMlmWY
         rlbX625rcMo12jyf8+VAOSeF4OqBx87iuVE8quF3IPwKfqgGKAYwT+RSAoTKjCl8We86
         093g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062577; x=1703667377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afxqRg0BdzPXAqeEmb0814lNgbcWkJx4M3LyS7SIRlE=;
        b=LB8zCAosdXcSQo+PfbRp+ERexpocxZKkcD3f8DN7/0pSD94phzRNJcNOtnxUQNgcev
         vzJQwEfIlq9mGbNxatJM8HVAXMutqu0QoDxpn/pUlYbtvlQFftELIaPaFIs6mrPLjroH
         fMFEtnSpyUyyt4tR2g+0zvyIeO7iu2Jeg8mz7kp+pfIAvPuKju++4EmGh2iBjg/vh9Ce
         ieN9XjfY5fEnINXXXrsd2ufNELVs7ZC+JZwwLPFA5/yOBmx6HqDAXU7vLOOU162RvIS3
         ORoioxYHFABpJNoQZ3yf0VA65odAq7aWsluijiKgaj/TNIXPPgXsBATmVKB9ni5pxaOl
         mkCA==
X-Gm-Message-State: AOJu0Yx6aTjlWP/xh1tB6eNUzqUl5ScfpG4mQ+64PaRs5JlkttMcugqV
	A5A+BdvBAhIiQIax3zim9jo=
X-Google-Smtp-Source: AGHT+IFraZjA1I+MpAWdI3cvbHqa2lA82OBgPoS3jakLWY53Us/2Nqyhv8I2jZDKhxR2gg6RmWlOvg==
X-Received: by 2002:a05:6402:230f:b0:551:80b7:6b60 with SMTP id l15-20020a056402230f00b0055180b76b60mr7099528eda.36.1703062576831;
        Wed, 20 Dec 2023 00:56:16 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id cq12-20020a056402220c00b0055335e89ed8sm3532169edb.30.2023.12.20.00.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:56:16 -0800 (PST)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: linuxfancy@googlegroups.com,
	laurent.pinchart@ideasonboard.com,
	martin.hecht@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] media: i2c: alvium: inline set_frame_interval into s_frame_interval
Date: Wed, 20 Dec 2023 09:56:08 +0100
Message-Id: <20231220085609.2595732-4-tomm.merciai@gmail.com>
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

Inline alvium_set_frame_interval() into alvium_s_frame_interval().
The alvium_set_frame_interval() is called once only, by
alvium_s_frame_interval(). The latter is a thin wrapper around the
former. Inline the function in its caller to make the code more
readable.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
Changes Since v1:
 - Now this commit is the 3/4 of the series
 - Fixed commit body as suggested by LPinchart

 drivers/media/i2c/alvium-csi2.c | 51 ++++++++++++---------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index a9ff6cc97cff..b234d74454bf 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -1660,14 +1660,26 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
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
+	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
 	u64 dft_fr, min_fr, max_fr;
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
 
@@ -1682,41 +1694,16 @@ static int alvium_set_frame_interval(struct alvium_dev *alvium,
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
-	u64 req_fr = ALVIUM_DEFAULT_FR_HZ;
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


