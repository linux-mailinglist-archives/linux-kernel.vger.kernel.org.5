Return-Path: <linux-kernel+bounces-123920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DE2890FC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2065B1C247A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B5B2CCA4;
	Fri, 29 Mar 2024 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHuUY5si"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02B2030A;
	Fri, 29 Mar 2024 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672846; cv=none; b=kirONW8wADtUzgYDGtsSA4fWRSe01vMm47Rn8w7dFsHxlKu+QZbcUnRuicTLlxwRdVn6BypeyXpaK/HuAUnnfGxonEARAq7uFdAjImLkxr30yCdmNQ82YjEHcSZcDaA9h2zMo/CGWE4JFmEj6FMUHRFD9EX/2TMWdFQNodz1IoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672846; c=relaxed/simple;
	bh=oe2RXd+B/kQL8oyi62iLzgDBkf6gznV4J0J+6lN30JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCmWCHLTPtjk8Itelfi8RBrr+XO+vx81Ob1NF723GnmtDeCsBOGda3YJ5vEDf2k/mRx//aDh1hIrjCehSrQM4KlIlsn7VS8ppg50yJO+USsrpyyh/X8EWKK7JCn2Q4nx8bvJxkdnwJenrM8bms549zlyQjtJRoZtvYrWASYco28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHuUY5si; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so2320001a12.0;
        Thu, 28 Mar 2024 17:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711672844; x=1712277644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25bHY0K50SUaaxuJWFWNToTcw1xP3p6yUVsyZaDNXuk=;
        b=SHuUY5sikOzR/voppv/Zdi8AzGHaQFqID2UI7JWJ+UOFBCHgx7htK91S1qb3FLH/zv
         LtgSpLEF39Dyrnjg4n7PSglJUZmgQfp+3hKshiuS/aNes7KD36GxHr5rLCPBIefWRysZ
         ROqTjElWxlrXaQYGMsgYKE0gmMlUTJv41oKVOJ31OCMk/3Pab11WWS5CCqCzzdhQueZp
         UBvXDmJH8W+Q/xRfk43klRlfdDvDfIiM2cS7XOtGb7dfFU23evXDiJna6ksQi5lFhk3r
         Muvd8h40y3oCDaJrGwOzrOGQzSOJexZneVUtbDRmFmQhlcmStQmFEmMSg9d2nEG1C7+d
         7vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672844; x=1712277644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25bHY0K50SUaaxuJWFWNToTcw1xP3p6yUVsyZaDNXuk=;
        b=E5q2vkLEAehkT18disADzGqWtHRuCo1UV0CLZD0s/6NOxwBSSBikmHDJxFJsufbIsz
         S4WBbsTWS9BLdsSLPS2/3XSOtRpu5GqzOOVeJBa1JwCN2hRRHE3+8tPmaEFGN5J+ZGaH
         30sqhLcFOqJd+lEePFZxk7tmzcgq5w1xtjxRp+zjJVRFXrhba5Xdm21tFVSYyJQ/3kwq
         9Fw3dd3/dvY4aue/bGE1Muui+IGHMvH9V/Z+n5kXUpS9KipJJy1p0z5kRbacF9EG/LB0
         T4uSTG2fKx8W2HPZHC9VXwU61rVJ6GQmOnKMv3KumMkczp9JU7YdLsT5Soe1EUeyNH0T
         OL9w==
X-Forwarded-Encrypted: i=1; AJvYcCW+SqgaiAwh94A8dh6zWJmVbXL4QH9vXHcYCeSmpIhM4pLPBZdpxQUDbzIL4+K7Fs6M2L2tcn7kI2xx1b9oYrJFmXbOVaYdC78OPSVKJSnjYzulXkRtkSKOHtRicfiNSEdi4CNuEDFijg==
X-Gm-Message-State: AOJu0Yw4YSXOiloxx3wegoIiDUXJelvdPYesoL85NIDf6ppogaNqR5dP
	F2wRzqTnHwqmsTU1rweylpyQAOyXFs0Ym3d5yhszSBk4TJPEEGYP
X-Google-Smtp-Source: AGHT+IHOzJY+LqCV0Q2eXYcdIO6pQJc1IX2G6da9ikb6LnpJkPyvSQEwMOY9zbqXY9Xjlx0MJ4FTXA==
X-Received: by 2002:a05:6402:50cd:b0:568:9936:b2e with SMTP id h13-20020a05640250cd00b0056899360b2emr522221edb.24.1711672843837;
        Thu, 28 Mar 2024 17:40:43 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e0700b00568e3d3337bsm1391679edh.18.2024.03.28.17.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:40:43 -0700 (PDT)
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
Subject: [PATCH v6 5/7] iio: accel: adxl345: Pass function pointer to core
Date: Fri, 29 Mar 2024 00:40:28 +0000
Message-Id: <20240329004030.16153-6-l.rubusch@gmail.com>
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

Provide a way for bus specific pre-configuration by adding a function
pointer argument to the driver core's probe() function, and keep
the driver core implementation bus independent.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  3 ++-
 drivers/iio/accel/adxl345_core.c | 10 +++++++++-
 drivers/iio/accel/adxl345_i2c.c  |  2 +-
 drivers/iio/accel/adxl345_spi.c  |  2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 732820d34..e859c01d4 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -60,6 +60,7 @@ struct adxl345_chip_info {
 	int uscale;
 };
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap);
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 2d229fa80..83d7e7d4e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -168,7 +168,8 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap)
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       int (*setup)(struct device*, struct regmap*))
 {
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
@@ -176,6 +177,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	unsigned int data_format_mask;
 	int ret;
 
+	/* Perform optional initial bus specific configuration */
+	if (setup) {
+		ret = setup(dev, regmap);
+		if (ret)
+			return ret;
+	}
+
 	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index a3084b0a8..4065b8f7c 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap);
+	return adxl345_core_probe(&client->dev, regmap, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_i2c_info = {
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 93ca349f1..1c0513bd3 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -33,7 +33,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap);
+	return adxl345_core_probe(&spi->dev, regmap, NULL);
 }
 
 static const struct adxl345_chip_info adxl345_spi_info = {
-- 
2.25.1


