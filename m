Return-Path: <linux-kernel+bounces-112339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043A887899
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E2CB2421A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDC73EA91;
	Sat, 23 Mar 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z47IzWox"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF5F9EC;
	Sat, 23 Mar 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711196444; cv=none; b=fHfEqMN21EX/vpfvTPdmVa7enJlnZ7mQ0i2HybTzZuvjLHQ9RopYROGjDDYhQuR65RTIOIzgS66/Vvvd+G6OrVsGaqkvPwAidvV0dPUwFNJR6RlbMyPNDzQzxMpDZRU4pTBYvwfauQRHygIESjlYpBtcORL82lxBRmnYRxXeyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711196444; c=relaxed/simple;
	bh=6ticcK4tk3gbdNMWg4cy9Rctjbu6e1KTIJk2wbKW1QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZdox6SlOIVLoFfcwuQpmIWq0zUPYHSvBuUUyLJten/idkPBL/x2XFfYpvApn9/D4yokpORwoJI5jnzJMX2GwPtHZfbDhxWkbNvWLrZH7O7e5MQXsq4GCwVcHpzBUQCEGPt/oHn/cUH2B5k1nPbv/zTv9V7YAlrsq2SlMjAtdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z47IzWox; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44665605f3so337918666b.2;
        Sat, 23 Mar 2024 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711196440; x=1711801240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1Jw5oqKQgZS0ALGTocIoCK3m4+0eTU5v4LaaAReICg=;
        b=Z47IzWoxgQCAdR5C4iz2QuNZ5Wuono2j3Kur5mYBl+4gHtCEHOBSiLv69wLlR4RfVt
         ZYXLtN01K0cfn89a8Nsa8cNfzG+yuSGrwkxH6gOAzz0rRCkcjz4CKThvmkq2Xk1TXvNI
         LbkIW4a0FV7UPBBwAUt44JTsRWl+kscNsnzV8VKHVIkP13E9XpCI4J+d7cnFBKqQ3Jho
         75JuVHrXOKdFiKfLDfV+03E6u73iorx+Jsg8/pcWHlKVnM3u0VUmooQwozN4C+nuVqQT
         SpK8Hnee6N9oSHvRkwFomcu4Ql5nuNtY5exZtdEAqzk/51CYOim/h3Dm5cZHdEqh+EEm
         Jjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711196440; x=1711801240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1Jw5oqKQgZS0ALGTocIoCK3m4+0eTU5v4LaaAReICg=;
        b=qMDmbDR300UU4HU1TxHCF1BwcbftsM7b1vazauk1D2dwm+e3z0aXWBBPLs4x0PBzmB
         wEr1BTa0RKVwOv6hPUhDhzd57RZmgdJjcjzUbOale2k1QV5rV881E4m7VsKrm/Fnsj+c
         ruB91KNX3g6CYSXLXmsKdmVeMGFf+0OqDjogr8/MLorBF8bnxDOgfaUC2hgQs42nGqon
         FP0miLQvDgek1kMC7wGrRJvJJ9PaXRTpH983z3/PZqgavOIzciUCJkzNyP96yl0V4H8G
         etcWUp82bO7edIOs3hgZ3kYF+BeeE2BxEdkiOed7HCm9l44W+tQ51WNr2Zgd/O+mNzWV
         iubw==
X-Forwarded-Encrypted: i=1; AJvYcCVBMvF9OLGuDvtEZEiqH27vHyG1kCA8CxgXQc3dZYxm8Twv+9wAJTnkLds5RKf9JpiWlFyxgj5v2GSHl5U5yUhW1xBtg9sGo1Gq+PCBP6/Gmk8QW6BPyu+83WKWEO14kqvHpSnESLzO+A==
X-Gm-Message-State: AOJu0YyOsiyk5NoeFIkykbAGuAcisv7CaGJ0w2ZklBtP/POWe3y8cmhi
	prztBj7De9Rv7G9fKI2w3o0n1/5H9+QSxKTWpLLDNjSB423vGih4WyNHNsoD/ho=
X-Google-Smtp-Source: AGHT+IFMXXWvbnEu3yNR+TnQhMi1OEbFTUSFn6yDOSyDGtsO8WrBRrTrDw16uHPYuG5SVYKcpBfNBw==
X-Received: by 2002:a17:906:3ca:b0:a46:d49d:eebb with SMTP id c10-20020a17090603ca00b00a46d49deebbmr1457512eja.16.1711196440632;
        Sat, 23 Mar 2024 05:20:40 -0700 (PDT)
Received: from 764c7355c69b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id gx24-20020a1709068a5800b00a46f0d133b9sm857265ejc.98.2024.03.23.05.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 05:20:40 -0700 (PDT)
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
Subject: [PATCH v3 1/6] iio: accel: adxl345: Pass function pointer to core
Date: Sat, 23 Mar 2024 12:20:25 +0000
Message-Id: <20240323122030.21800-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240323122030.21800-1-l.rubusch@gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
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
index 284bd387c..3c1ded0c2 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -28,6 +28,7 @@ struct adxl345_chip_info {
 	int uscale;
 };
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap);
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8bd30a23e..ae12836b5 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -197,13 +197,21 @@ static void adxl345_powerdown(void *regmap)
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


