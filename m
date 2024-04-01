Return-Path: <linux-kernel+bounces-127007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A28945AD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2BD1F21DAD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EEC5490C;
	Mon,  1 Apr 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEZAgqQR"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3862B524BE;
	Mon,  1 Apr 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712000958; cv=none; b=lH25cOPD+QSLYOyR7tWEBgvSZlFDjz/ArbaFSqLwULcITA1uruZDYhXW2zkPAiCAs5RBXKXdH3rs2CiNFZFH18aV1s8+oCgnNhNQ4ZogDX86rtYGFMHnSx90G2px358x1yJrwg0VGnltvIlS8leGIMCvqYg/7igiid8VOi5BNMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712000958; c=relaxed/simple;
	bh=0tEgwdAwdlUtsG5TVVFCmyeARPff6RL2/ajnWue8kac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3ykcctudR/SZBWfk3bHhFs5pih/G3BARLgpV9QCz2LwQ09nY63ZFjStQR5/z0wxwhQxZ0Kg5CkJr5Jiz506yUyLJPDK7BZ+6S5J9hoxMDAfwciGOi89fHVefSwSoRl5OxRxgu6JJd9fImy0Kfys5YUqEfjxajBpLRTypcSu8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEZAgqQR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4734ae95b3so562753366b.0;
        Mon, 01 Apr 2024 12:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712000955; x=1712605755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzxEGJuLh2FGOqj/Kc9LOkhC9QKX86lS8A0OCMB6aaE=;
        b=iEZAgqQRc4dR+jMTGmlsUPdjNhmBu0OyLSou6AKsBERFSIevP6kJH0eE4c0vB89WSJ
         DfWmbU958WznyhMokeD+lNMEwOgeEXZcABM5dO/sRXM2zwCPwEZMqAJK0v3pUgMEaCuI
         p7J0pwm6xoDnHxfnKjEcgpid0hg2pDkN+fLGVyV1O4GmV6VwfTiv7I8LQyN4ZFJQER1R
         nbFJNSDXTdlw984nPGSLz4tQ2/00hOSNIRhYGxeYMiCIqJv9Us1Ay6707aXh/5/8/POc
         Dc6iw6OmUgFXN4iCgShpp9bKXlowhYuHl4TtuMuiNWr9OwwzDWDizNptof25cWmqBBF/
         RVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712000955; x=1712605755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzxEGJuLh2FGOqj/Kc9LOkhC9QKX86lS8A0OCMB6aaE=;
        b=PLQ0LPuGSEYitmek+ryxmlAXePIB9IGoh4zjECwGaRzCbaxShxbkF34RauzpEdLAQO
         Qkap8vFY5og/t30DUrB7atdrsTJtRVKZQ3tsU1K8E/sCrSOlln6lcOVQWvSWmGYSQe0q
         jZ7wg2O+CNacyn+pytQYWLjFgZ4dxBaZLrbdj/iL97ng7O8W4DM6YnfATwLluvCb/pOL
         CvqRC5yFMqnXHHTIlbJMQdKpftn8Xm+RiRqgh5m3WKeTDrxPHOT/vy8Qvv9onc5GXta5
         7IOMwU1w/yUWJtBS57haNLZ1r4Mgci7Vk2CBliD4F1nBWDpNcLBvyVQPfGn/B2YccK/2
         uIug==
X-Forwarded-Encrypted: i=1; AJvYcCUK1vZBHlVLRwpsXcEh/DRfs95/GRQTPXFd8vsHgc644kUSB/0y7zURcg3fHfAYc1eTjA7Cn90+3oFVUphsd65sXMfevslASbqXnpYiXiHvuVCXwUdMVRD2INDPfn44hYRlzcFOXAaECA==
X-Gm-Message-State: AOJu0YyYZ/kGTumlY34SCLUs4tvN5nEAVMjmClagb5WwJ0TGqCv3Y1hm
	3aMuTHV7QfVlTxjw6LoD635xDg9S8ZJF53u+PDdiO7GLYqFwoTvz
X-Google-Smtp-Source: AGHT+IHge/DJLc7dTkUrTGkVUkMnYqgpDVPwEiXbFBWCMpvE6rREj6PqkmDxr/cgyt2cH+6WvbiRcg==
X-Received: by 2002:a17:906:910:b0:a47:3555:6b73 with SMTP id i16-20020a170906091000b00a4735556b73mr6127782ejd.39.1712000955289;
        Mon, 01 Apr 2024 12:49:15 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a4588098c5esm5540575ejc.132.2024.04.01.12.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:49:14 -0700 (PDT)
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
Subject: [PATCH v7 1/8] iio: accel: adxl345: Make data_range obsolete
Date: Mon,  1 Apr 2024 19:48:59 +0000
Message-Id: <20240401194906.56810-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240401194906.56810-1-l.rubusch@gmail.com>
References: <20240401194906.56810-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8bd30a23e..ff89215e9 100644
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
@@ -202,6 +205,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
 	u32 regval;
+	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |
+					 ADXL345_DATA_FORMAT_JUSTIFY |
+					 ADXL345_DATA_FORMAT_FULL_RES |
+					 ADXL345_DATA_FORMAT_SELF_TEST);
 	int ret;
 
 	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
@@ -218,15 +225,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 
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
+	/* Enable full-resolution mode */
+	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
+			data_format_mask, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to set data range\n");
 
 	indio_dev->name = data->info->name;
-- 
2.25.1


