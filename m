Return-Path: <linux-kernel+bounces-117378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A211488AAA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7705529F25B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E33D12AACF;
	Mon, 25 Mar 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzpIQPkc"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3143E498;
	Mon, 25 Mar 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380895; cv=none; b=DgyNCTnscmyNJ/B1pR7MecPHg7jvARgRU0+oZDp4t6ceTpHQjqiyvhH28MA8L7+/EWSOT07GXNVUXhq7n6Rmd3j4S7bNx2zvZYwo2naWXvNrRdLeSnhUOEkM5tzkl+evM8zXyy3yNUsDore/rk3Ddwvh0zw6OQf6KP4iysq0yYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380895; c=relaxed/simple;
	bh=/2mSw34ubOjCSkINOakka+pJYxBDJy/KNLR6V7CRKgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C40/kdC/uw04g3PaeJKvTi4p6Wqcvr2n8lb4eEX4UTsgYqRMmE6AYcEI3iqHWyBwCAO97lEFztSQMSDpHn/7wrZYiVlbuBGXoeo5j3wj0a/EzjQv2IiyRbgsPuTK9AIXA6hDBtw/6aF2Z41rEeNZEpozth9pWrUu2QU+9UjKw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzpIQPkc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so3152792a12.0;
        Mon, 25 Mar 2024 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711380891; x=1711985691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJsG/u26fANj8HMmDcxhC2mSREXIwDZdu5OFv3zb+zw=;
        b=bzpIQPkc4IkKaNvbI9ksSqTbIaJpAaKVU/o7t/HkIdsuHm0Vi/dMmVPdhs+yD5zgrK
         lT8bEJ1qzjiJKNhlKmRfj0PaPTYDUc62OkcpC5ABtsd/fhsJJxy8/haAFbv2uGB2kdwF
         WEt9nOJSSdY70AB1snp+sE+CTfLJldqKKrd3tR/Z1yV5V5G/BSZtGRkPVZg0RcR2rvCL
         ZdA/Q/VXQeVVJmR9ctvht1IiQsxnxKGEUUCH6bth555ffUCzYR/MEp9S+bcCbP/xsjlB
         9tfxBfDyPDghJD5VzJ5ZvsLCddjPVlpxFZkTNeWvHqYyqYBM/8a/uULaE8fd9d3Cdks1
         bcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711380891; x=1711985691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJsG/u26fANj8HMmDcxhC2mSREXIwDZdu5OFv3zb+zw=;
        b=Oj8lSWJ0lM34tFbH22pAYlrug67G7RSkq8hMupe2mVMqCObnWdMIyB2obHxONqzVWU
         cJT35rfNbBx86IZvA3kNoPizfZHmdp1YUP9anLiOIpB+7G//zd9F78pZxotU3PBblVw2
         WepE/wqzuppNsvA3dtJL390BuU8YusGAKr1Fvtwbclmu8RXhz7upaP6nnT3UbaBIv514
         tA74nYB8ZQhjxcxEFZDFl1zAOeYZ07go06rWP6N1hVwgwTtt7SKvwLNrhYgzW+tzz97q
         4/YsnBjrEffxotYcWEVB0Rg3/oOeNnptZIaxZwCFPEK3b7XXe4aS+HaxHvZrX+YwUyeZ
         xVfw==
X-Forwarded-Encrypted: i=1; AJvYcCVZHaQwl89MgL2/H/T7Bj2GAvxBam6W0oMRwZKBE5b6HC88Jj1PIUo7UIg9NLcycuXl7CTn7cHKx2plprq+ODkip6y5u9FHw+N5KGF5E9/eRHliC0uVDegWT7/GyPcT2RDlLi6CJcT7IQ==
X-Gm-Message-State: AOJu0YydiPJCuy1fjVQZ7vCMaplFVvFqaIwszocErpdXXpXPmrQBUX3u
	ABwC144+MJpuke+BKeO42k0sYn+/OCTNiQpO/N+HzpgC+eYcy26K
X-Google-Smtp-Source: AGHT+IFy1Y3RJgXdyJqmoq/0ZsaeR1o3plSyfFO1h4d1uVZLkNnbWutn3mNYRx/Hg1zkERxFJtrcbg==
X-Received: by 2002:a17:907:994a:b0:a46:b798:9571 with SMTP id kl10-20020a170907994a00b00a46b7989571mr4404426ejc.58.1711380891621;
        Mon, 25 Mar 2024 08:34:51 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090626cd00b00a45200fe2b5sm3142382ejc.224.2024.03.25.08.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:34:51 -0700 (PDT)
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
Subject: [PATCH v4 5/7] iio: accel: adxl345: Pass function pointer to core
Date: Mon, 25 Mar 2024 15:33:54 +0000
Message-Id: <20240325153356.46112-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240325153356.46112-1-l.rubusch@gmail.com>
References: <20240325153356.46112-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function pointer argument to the probe function in
the core module to provide a way to pre-configure the bus.

The passed setup function can be prepared in the bus
specific spi or the i2c module, or NULL otherwise. It shall
then be executed in the bus independent core module.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  3 ++-
 drivers/iio/accel/adxl345_core.c | 10 +++++++++-
 drivers/iio/accel/adxl345_i2c.c  |  2 +-
 drivers/iio/accel/adxl345_spi.c  |  2 +-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index ee169fed4..620a2e0f0 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -59,6 +59,7 @@ struct adxl345_chip_info {
 	int uscale;
 };
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap);
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index eba9c048a..476d729bc 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -168,13 +168,21 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap)
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+	int (*setup)(struct device*, struct regmap*))
 {
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
 	u32 regval;
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


