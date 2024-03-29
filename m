Return-Path: <linux-kernel+bounces-123916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FE2890FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BEA7B23DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD67D14295;
	Fri, 29 Mar 2024 00:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSr3SP5E"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA95223;
	Fri, 29 Mar 2024 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672842; cv=none; b=duoqFBR2a+wzs4/PqCTK19Ear386EmdoCU+iMDhlw7CHEVpQLLXhQ7Owg42dkRkb9EWpkJilMfG/2Cc5lHWO04ofvfzqk0MpgD00GbAwSlrSogxtVK13+5bvNm1WjEyiIItkhhpk0YrN20uzEKTn5WqpXz3zn9/TfthoPCXzy2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672842; c=relaxed/simple;
	bh=Thuwc5jU/GgWSwwKqdNAbuidpQuzlLpjhLu2hWojAgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A8eDOHUPpTIumRnGxzQqDrsSdwie/w1qGh7I2LWodiEKJvIiCLNXiImeYjrND7lSTbU+bCvn47aMccEWPPljMLasx/dO5QDVDPM03WXtB7jKa1Rw49CPrt46xIlO1V1BXLY4PgTpOYPfxOm81eIXBQjf/9v222NlL5lf1pd5xHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSr3SP5E; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so22552911fa.1;
        Thu, 28 Mar 2024 17:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711672838; x=1712277638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en74PRYThtLoO+VTh1LsA/OHt41VMEnZsO14VQkkbVY=;
        b=mSr3SP5EXoTN8Voh0QJzDBPfJ0SqMG1j2blUWHlDepcUCEb4YJQ8plSKlhEBQpgQtf
         dm1IfNK23TMyEzT61BOdMprJdcq40v3qTTZffSlQjX2Ig2DyeRRMXBB8pzx/WZQOGIu0
         hus6KKFHYGy67ejUfaLT/PG7/tgTN8NTUHCfYuNXJH68DbOpLqo6W0eKn4AC8cDxQZL3
         /Pmef/NFuIv0KgHrJFKMAj8c8LEQ5kaL1LCOu1Ae/GlRzMTMEcacOqak+OVf1PxsAOuv
         Ss+5+WE+V/9taqAgbMHD6sAM6k6GjZuXP+GFJtPWH41VoNdXP/8XuiMbOoKaomZ+n5xz
         nuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672838; x=1712277638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=en74PRYThtLoO+VTh1LsA/OHt41VMEnZsO14VQkkbVY=;
        b=R1dt6L/se4dvgQj3ttgobJaIbxTTolDDu9MdHq1EQhFaZcHmRmi68CHRO9niBZM/pM
         OOK6SIJ5w9sdj8KBkREA3uwHzv4RMm+wU/pBF2z9aicqCeIDGBzwjJw/cyP4EBlnO/UJ
         7GerFGZ27DbhyWFcga6k48LXBVT08IE+B4xol53gNnUGAvHSHJetoOcBPXgreOzSGp04
         VQ+TeE0rO+KEUdrsVMExOq1hjeGwC566Evl+Zg3cVrl4czFKTvPvtMrRfH+GbRfYwj5D
         8rYV9ZzLirzonfDKxw3OLsFcWk1thCQi1OvaF/mNkdw/Zsk/R69cF3kVGwtSLwqtw89c
         q1IA==
X-Forwarded-Encrypted: i=1; AJvYcCUV6yt7RL6RvC567hkxqE5SgGpnJvxKZRtiXjt91IfFtqp3LuQCtzFLoZALBVIOAzxTHA+4fssScX7hLMtnP7fvKHUGQnYaslihNn23kaCxWKUOGyey+esZVNbv74eXcvQ1Dcd2yXVzEg==
X-Gm-Message-State: AOJu0Yykv0syq9c4tdXAtvNdi/PCLJd667aS1uV6pZIItUoXjQdoyjHk
	bWn8u93W7+UokO3Jv+r4lU5zD2qmkwInJfSfKn2RxmuJhOHzdwaK
X-Google-Smtp-Source: AGHT+IHLEdypJQUYV/jdgCcMH1dpYnvwd01rFstgAhUY5O5VaHOzyRoH/NtD1Mf9a3Jp+miVgCO3Ow==
X-Received: by 2002:a2e:a4c3:0:b0:2d4:83f9:2e21 with SMTP id p3-20020a2ea4c3000000b002d483f92e21mr356943ljm.42.1711672838244;
        Thu, 28 Mar 2024 17:40:38 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e0700b00568e3d3337bsm1391679edh.18.2024.03.28.17.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:40:37 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 1/7] iio: accel: adxl345: Make data_range obsolete
Date: Fri, 29 Mar 2024 00:40:24 +0000
Message-Id: <20240329004030.16153-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329004030.16153-1-l.rubusch@gmail.com>
References: <20240329004030.16153-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace write() data_format by regmap_update_bits() to keep bus specific
pre-configuration which might have happened before on the same register.
The bus specific bits in data_format register then need to be masked out,

Remove the data_range field from the struct adxl345_data, because it is
not used anymore.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8bd30a23e..f4dec5ff1 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -37,7 +37,11 @@
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
 
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0)	/* Set the g range */
+#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2)	/* Left-justified (MSB) mode */
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3)	/* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7)	/* Enable a self test */
+
 #define ADXL345_DATA_FORMAT_2G		0
 #define ADXL345_DATA_FORMAT_4G		1
 #define ADXL345_DATA_FORMAT_8G		2
@@ -48,7 +52,6 @@
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
-	u8 data_range;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -202,6 +205,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
 	u32 regval;
+	unsigned int data_format_mask;
 	int ret;
 
 	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
@@ -218,15 +222,23 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
-	/* Enable full-resolution mode */
-	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
 	data->info = device_get_match_data(dev);
 	if (!data->info)
 		return -ENODEV;
 
-	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
-			   data->data_range);
-	if (ret < 0)
+	/*
+	 * Only allow updates of bus independent bits to the data_format
+	 * register. Keep the bus specific pre-configuration.
+	 */
+	data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
+				  ADXL345_DATA_FORMAT_JUSTIFY |
+				  ADXL345_DATA_FORMAT_FULL_RES |
+				  ADXL345_DATA_FORMAT_SELF_TEST);
+
+	/* Enable full-resolution mode */
+	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+			data_format_mask, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to set data range\n");
 
 	indio_dev->name = data->info->name;
-- 
2.25.1


