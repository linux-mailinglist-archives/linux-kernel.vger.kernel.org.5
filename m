Return-Path: <linux-kernel+bounces-168427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3248BB879
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919EEB23CAB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B4485C56;
	Fri,  3 May 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeMu8V0P"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEFA83A0A;
	Fri,  3 May 2024 23:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714779967; cv=none; b=QSN0Hb0XUjnCAM+zNVJjTzOD+A0WcqKmtFYeKFx+8dSXDpA6uNRxrdZn0TQgIvoajfeJlMz047V8Dh5HzqPxLibB4xznftzUX5+hSliARhm2dT0wEN/LeYPt0LKSZj3ONBxLyuTM4d7AbGkwMk1UL+DujV627S8FdE3UHR+YvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714779967; c=relaxed/simple;
	bh=HRvQk9b/K7HZOxSSzejbeCSRLm1DlQOMMPjy4DManVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ns09zrMB9VlQf8dsIZ1M1cXLWlXieVLkBQL3Y8L1T0qY3T3ifq8eCy74HnmEDplzBR0NeDzIlRyHgGsK7NO+455IJOkEtHhfEAyekeyQupf/Z8EGPGjl9ahkI+92CbRN2iY3Phs+VAMlT3jYpBtQhNr7gukiZbB0r60NMpX2pUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VeMu8V0P; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41bca450fa3so1916245e9.2;
        Fri, 03 May 2024 16:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714779963; x=1715384763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQ27P8NHgDwJonUKu3W8XEwzbx8MLfRfBETpEWbGxAE=;
        b=VeMu8V0PxV0hEmWagII45N5qIU+PP9qS9lnpBE7zK3mBzT5A96eVe2BnK1Ta2tvr4E
         QBo0YEoKJtX+thDq4Y8YiaGdNbgNSKJ+6vPvtabrOm2t/VmH8nHwF/97qgbVJgzyuUHb
         hhd+geiOjzAJJy1QVnfvXgoGQqihcenTBkCeXgFSZshe5q4jqkeDEsAXsewSZdHL053n
         sdFPLFd1G6B3bsRY0vLJPdWDzu1HkopSyum8knvvF8ya+maKKaAomA7SRUph3Z0WHZQY
         a88Aq83pPX9ibsMeknIGgb5dfEUeuFaJ4Q1GlPQSmaD/h7qOMU4Z0Sf8VqN7UL+kLhV7
         DXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714779963; x=1715384763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQ27P8NHgDwJonUKu3W8XEwzbx8MLfRfBETpEWbGxAE=;
        b=SwlpTmw9ay4eGe8ca+EMy7Xd4NQoBgeAo0xT2SHDshOZhJfLaxfRcTE9VDaSw2dAyG
         0LQhE19710ii7gyNIuYl0Zx9fFmmM2YrZRFeF7jH2MfuTWFauloOiI5UbRi0iNMIHuxY
         vkmB4GD+XzjrIPq5TF57n5LcmTLHi5QDLXXzGyzY3QlxFY0Z0zg5LsMya/vWqHPmW0WE
         wyEDtW/VFUqpcPmD+E7NLt7XSXFTiqGPRswxp2cEQTkYfnzMLczZ8fHBxzS8uhQGVws7
         EXq5l8ct09ZFVFojwU2277pRzZxk+doF55k5HvPNCOp4thRWj39KUzeD2VZtKL1ksHcn
         J1VA==
X-Forwarded-Encrypted: i=1; AJvYcCVGDfZ94NlMV1C9DsCsuqGWMzZSyFjvEp63PxlDctIZKMpmEAYFASaJziS8TiVNeeIEpL/Mb5aRNSHm0+ZiP2ZeEMYPpo9JTVQP5RX6jDkYn/GjqruPfeLj1JsucBVGQmzu+lg1htnLTQ==
X-Gm-Message-State: AOJu0YyYF9pBrGVK6GJ8WydhsDE2VmpU6UAEcxYrWIkNUvIESCWAc2K6
	d0iltLgA64ps9itLFeP685puUxzsYzx4bL/ohS+6QIWTmctSjsuDospSuMmw
X-Google-Smtp-Source: AGHT+IEIg6yIdrFxO3m2BMCBqpqiFGsp7ECsNsU7Dc15pHS7kjDD/VJh6fCt5RJygLk+T07gBvWMWg==
X-Received: by 2002:a05:600c:4f07:b0:41d:d406:9416 with SMTP id l7-20020a05600c4f0700b0041dd4069416mr3282862wmq.34.1714779963171;
        Fri, 03 May 2024 16:46:03 -0700 (PDT)
Received: from [192.168.1.130] (BC24954B.unconfigured.pool.telekom.hu. [188.36.149.75])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b0034d743eb8dfsm4819405wrt.29.2024.05.03.16.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:46:02 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Sat, 04 May 2024 01:45:24 +0200
Subject: [PATCH 1/2] iio: imu: bmi160: add support for bmi120
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240504-bmi120-v1-1-478470a85058@gmail.com>
References: <20240504-bmi120-v1-0-478470a85058@gmail.com>
In-Reply-To: <20240504-bmi120-v1-0-478470a85058@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>, 
 Danila Tikhonov <danila@jiaxyga.com>
X-Mailer: b4 0.13.0

From: Danila Tikhonov <danila@jiaxyga.com>

Add support for bmi120 low power variant of bmi160.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Co-developed-by: Barnabás Czémán <trabarni@gmail.com>
Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 24 ++++++++++++++++++++----
 drivers/iio/imu/bmi160/bmi160_i2c.c  |  3 +++
 drivers/iio/imu/bmi160/bmi160_spi.c  |  3 +++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index a77f1a8348ff..015801ad4d9a 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -26,6 +26,7 @@
 #include "bmi160.h"
 
 #define BMI160_REG_CHIP_ID	0x00
+#define BMI120_CHIP_ID_VAL	0xD3
 #define BMI160_CHIP_ID_VAL	0xD1
 
 #define BMI160_REG_PMU_STATUS	0x03
@@ -112,6 +113,11 @@
 	.ext_info = bmi160_ext_info,				\
 }
 
+const u8 bmi_chip_ids[] = {
+	BMI120_CHIP_ID_VAL,
+	BMI160_CHIP_ID_VAL,
+};
+
 /* scan indexes follow DATA register order */
 enum bmi160_scan_axis {
 	BMI160_SCAN_EXT_MAGN_X = 0,
@@ -704,6 +710,16 @@ static int bmi160_setup_irq(struct iio_dev *indio_dev, int irq,
 	return bmi160_probe_trigger(indio_dev, irq, irq_type);
 }
 
+static int bmi160_check_chip_id(const u8 chip_id)
+{
+	for (int i = 0; i < ARRAY_SIZE(bmi_chip_ids); i++) {
+		if (chip_id == bmi_chip_ids[i])
+			return 0;
+	}
+
+	return -ENODEV;
+}
+
 static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 {
 	int ret;
@@ -737,10 +753,10 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
 		dev_err(dev, "Error reading chip id\n");
 		goto disable_regulator;
 	}
-	if (val != BMI160_CHIP_ID_VAL) {
-		dev_err(dev, "Wrong chip id, got %x expected %x\n",
-			val, BMI160_CHIP_ID_VAL);
-		ret = -ENODEV;
+
+	ret = bmi160_check_chip_id(val);
+	if (ret) {
+		dev_err(dev, "Wrong chip id %x\n", val);
 		goto disable_regulator;
 	}
 
diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
index a081305254db..d0ec5301ad9a 100644
--- a/drivers/iio/imu/bmi160/bmi160_i2c.c
+++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
@@ -37,6 +37,7 @@ static int bmi160_i2c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bmi160_i2c_id[] = {
+	{"bmi120", 0},
 	{"bmi160", 0},
 	{}
 };
@@ -52,12 +53,14 @@ static const struct acpi_device_id bmi160_acpi_match[] = {
 	 * the affected devices are from 2021/2022.
 	 */
 	{"10EC5280", 0},
+	{"BMI0120", 0},
 	{"BMI0160", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
 
 static const struct of_device_id bmi160_of_match[] = {
+	{ .compatible = "bosch,bmi120" },
 	{ .compatible = "bosch,bmi160" },
 	{ },
 };
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 8b573ea99af2..9f40500132f7 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -34,18 +34,21 @@ static int bmi160_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bmi160_spi_id[] = {
+	{"bmi120", 0},
 	{"bmi160", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
 
 static const struct acpi_device_id bmi160_acpi_match[] = {
+	{"BMI0120", 0},
 	{"BMI0160", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
 
 static const struct of_device_id bmi160_of_match[] = {
+	{ .compatible = "bosch,bmi120" },
 	{ .compatible = "bosch,bmi160" },
 	{ },
 };

-- 
2.45.0


