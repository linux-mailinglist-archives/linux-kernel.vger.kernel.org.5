Return-Path: <linux-kernel+bounces-162868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7AA8B6184
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4342A1F22248
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C7F13B7A7;
	Mon, 29 Apr 2024 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIwcWfMs"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE513AA53;
	Mon, 29 Apr 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417262; cv=none; b=mGI9AP49BHdB1wVrnpvLJ9n1f7Nsdkt9IUgDI8RIVk6s58zMMk9vDliHn8G6w6ZREe/C9PSEW2zghZ3tRfnwTtvI0hFHg1B3pBJN9XDhWTdeuM0k2VhcTCOKwx+wB+4Uahu8WaIpQrsZQjhu9SzFxfLUWuf6pVumt2mdfbrgaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417262; c=relaxed/simple;
	bh=pyKoEaZamqmkgEdCEotX1uvTz2PnX/XidujYA1x1BcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHIv64gFjod36ixW4FVV/hlUuOlZ6+ptL0u2Ms0vQ85PA+jofMi/NNspJAc5nHKXzQY64kVpw1rAFtkbz+59CKiMhndLlBpo5+hfE9nZmew7e3zughI/x4YIhuDUKzzvbdvhHE90isjUqkwma+RW0OaU3igMGc4wkM+RxB7muqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIwcWfMs; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34c1fff534fso3556324f8f.1;
        Mon, 29 Apr 2024 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417258; x=1715022058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ABoaoYIXELoew2vdUdRbCooyvR0CbBpVkqKlUmodqI=;
        b=BIwcWfMs2ZlzXpw7qtZGRig6+jSUVhu2izDU6LXESvjkcwSZHwq8a1sEMxFJ9OOGgk
         AnB9yz7rezv5goylPZdYG5AtNUryxTytO7libQx58VkTlCu/KvYTvER7p8Kdwz/CCEGw
         Bd5mLBkkr97zHYQUvUjTFj08XkV5IrFupGFaR0ruRVJmZ/1cHGTn9XL2PJXiv+J1Mojn
         X4atFtxrogR44WMx0GqZ25ayAVr/xVjAP1anW5ASzRr4+A5GWmIAdsFTw2VI7oH6Q67y
         xx6RkA4yaghMW4Dptei9fg4DfAx/Q+N9VsZuseUQ7KhWB2NJUrn5C7KBLCZsciHSfF+C
         HZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417258; x=1715022058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ABoaoYIXELoew2vdUdRbCooyvR0CbBpVkqKlUmodqI=;
        b=oWYRnwrpm8L1oGCYdTPfW5dfMF7rfuTO2zz/WjGRhmJ/1AcPwphTEjuS5sNbrw4+ZJ
         vWoK5ZBQ3xfOmHz/WFKP1aE7MMnSr6E+QXahCJA3oNCavB5+cI/2KIhmB7L/fSf6CIvh
         e8I3rwkTS1MKkdLJKOf5bVTSboPxnd6vyOdW3L50azxHzP111BV4H3sgQ4Dp8t9zMFTP
         Mx9pgSDO0rNzrZz/jAg4h0FpQg9DFvWdzbBC5FEw81hae12JpwausbIXCYh4XsyNdR4L
         Rw/SrxlhTCREAtoeslW0WGVQZFVhf5fr8WTHzz5xUnIKLf629um6qxxgH/sh5jC7HCKt
         n40g==
X-Forwarded-Encrypted: i=1; AJvYcCUSBYXSX6FxNchczTN6W9SZq3QbJBNAg3XpRbnfnf2hqU8eotxaTC4aAogyP5NxAJX9eUX0slsQq2rq25WhUMjiCRuOnbGrtZODSXNTq+2me0PqQLyPPEdYg1DyScRWQlhX7skDB9SF
X-Gm-Message-State: AOJu0YwLePj5GT7N/EvONaw379zZjFXG4jq4mn/rAmp7Kz24vA/drTmz
	QqBkGNK+4DK84422HgzNXgR0/+3Vawo2nTB5AMRncMZCrXOpvFJH
X-Google-Smtp-Source: AGHT+IGLEfDCV+e7r+nDAh6M0jbAdlcqvCpiOYUCgBWQxUEmkW7tvwDhUrkoPqqdzk/j4VxXa2Y8Tw==
X-Received: by 2002:adf:f6cc:0:b0:34a:d5e:afd2 with SMTP id y12-20020adff6cc000000b0034a0d5eafd2mr7998940wrp.4.1714417258581;
        Mon, 29 Apr 2024 12:00:58 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:abbf:c98a:cf84:d14c])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0034c78bba70bsm8469456wrl.72.2024.04.29.12.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:00:57 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v5 02/10] iio: pressure: bmp280: Use BME prefix for BME280 specifics
Date: Mon, 29 Apr 2024 21:00:38 +0200
Message-Id: <20240429190046.24252-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429190046.24252-1-vassilisamir@gmail.com>
References: <20240429190046.24252-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the rest of the defines and function names that are
used specifically by the BME280 humidity sensor to BME280
as it is done for the rest of the BMP{0,1,3,5}80 sensors.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c   | 37 +++++++++++------------
 drivers/iio/pressure/bmp280-regmap.c |  8 ++---
 drivers/iio/pressure/bmp280.h        | 45 +++++++++++++++-------------
 3 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 1a3241a41768..edfa66953f87 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -235,14 +235,14 @@ static int bme280_read_calib(struct bmp280_data *data)
 	 * Humidity data is only available on BME280.
 	 */
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &tmp);
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H1, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H1 comp value\n");
 		return ret;
 	}
 	calib->H1 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H2,
 			       &data->le16, sizeof(data->le16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H2 comp value\n");
@@ -250,14 +250,14 @@ static int bme280_read_calib(struct bmp280_data *data)
 	}
 	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H3, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H3 comp value\n");
 		return ret;
 	}
 	calib->H3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H4,
 			       &data->be16, sizeof(data->be16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H4 comp value\n");
@@ -266,15 +266,15 @@ static int bme280_read_calib(struct bmp280_data *data)
 	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
 				  (be16_to_cpu(data->be16) & 0xf), 11);
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
 			       &data->le16, sizeof(data->le16));
 	if (ret < 0) {
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
-	calib->H5 = sign_extend32(FIELD_GET(BMP280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
+	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H6 comp value\n");
 		return ret;
@@ -290,7 +290,7 @@ static int bme280_read_calib(struct bmp280_data *data)
  *
  * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
  */
-static u32 bmp280_compensate_humidity(struct bmp280_data *data,
+static u32 bme280_compensate_humidity(struct bmp280_data *data,
 				      s32 adc_humidity)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
@@ -430,7 +430,7 @@ static int bmp280_read_press(struct bmp280_data *data,
 	return IIO_VAL_FRACTIONAL;
 }
 
-static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
+static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_humidity;
 	s32 adc_humidity;
@@ -441,7 +441,7 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
 			       &data->be16, sizeof(data->be16));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read humidity\n");
@@ -454,7 +454,7 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 		dev_err(data->dev, "reading humidity skipped\n");
 		return -EIO;
 	}
-	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
+	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
 
 	*val = comp_humidity * 1000 / 1024;
 
@@ -538,7 +538,7 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
+static int bme280_write_oversampling_ratio_humid(struct bmp280_data *data,
 						 int val)
 {
 	const int *avail = data->chip_info->oversampling_humid_avail;
@@ -682,7 +682,7 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&data->lock);
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = bmp280_write_oversampling_ratio_humid(data, val);
+			ret = bme280_write_oversampling_ratio_humid(data, val);
 			break;
 		case IIO_PRESSURE:
 			ret = bmp280_write_oversampling_ratio_press(data, val);
@@ -832,16 +832,15 @@ EXPORT_SYMBOL_NS(bmp280_chip_info, IIO_BMP280);
 
 static int bme280_chip_config(struct bmp280_data *data)
 {
-	u8 osrs = FIELD_PREP(BMP280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
+	u8 osrs = FIELD_PREP(BME280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
 	int ret;
 
 	/*
 	 * Oversampling of humidity must be set before oversampling of
 	 * temperature/pressure is set to become effective.
 	 */
-	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
-				  BMP280_OSRS_HUMIDITY_MASK, osrs);
-
+	ret = regmap_update_bits(data->regmap, BME280_REG_CTRL_HUMIDITY,
+				 BME280_OSRS_HUMIDITY_MASK, osrs);
 	if (ret < 0)
 		return ret;
 
@@ -869,12 +868,12 @@ const struct bmp280_chip_info bme280_chip_info = {
 
 	.oversampling_humid_avail = bmp280_oversampling_avail,
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
-	.oversampling_humid_default = BMP280_OSRS_HUMIDITY_16X - 1,
+	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
-	.read_humid = bmp280_read_humid,
+	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
 };
 EXPORT_SYMBOL_NS(bme280_chip_info, IIO_BMP280);
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index 3ee56720428c..fa52839474b1 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -45,7 +45,7 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case BMP280_REG_CONFIG:
-	case BMP280_REG_CTRL_HUMIDITY:
+	case BME280_REG_CTRL_HUMIDITY:
 	case BMP280_REG_CTRL_MEAS:
 	case BMP280_REG_RESET:
 		return true;
@@ -57,8 +57,8 @@ static bool bmp280_is_writeable_reg(struct device *dev, unsigned int reg)
 static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case BMP280_REG_HUMIDITY_LSB:
-	case BMP280_REG_HUMIDITY_MSB:
+	case BME280_REG_HUMIDITY_LSB:
+	case BME280_REG_HUMIDITY_MSB:
 	case BMP280_REG_TEMP_XLSB:
 	case BMP280_REG_TEMP_LSB:
 	case BMP280_REG_TEMP_MSB:
@@ -167,7 +167,7 @@ const struct regmap_config bmp280_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
-	.max_register = BMP280_REG_HUMIDITY_LSB,
+	.max_register = BME280_REG_HUMIDITY_LSB,
 	.cache_type = REGCACHE_RBTREE,
 
 	.writeable_reg = bmp280_is_writeable_reg,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 5812a344ed8e..91d4457a9230 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -192,8 +192,6 @@
 #define BMP380_PRESS_SKIPPED		0x800000
 
 /* BMP280 specific registers */
-#define BMP280_REG_HUMIDITY_LSB		0xFE
-#define BMP280_REG_HUMIDITY_MSB		0xFD
 #define BMP280_REG_TEMP_XLSB		0xFC
 #define BMP280_REG_TEMP_LSB		0xFB
 #define BMP280_REG_TEMP_MSB		0xFA
@@ -207,15 +205,6 @@
 #define BMP280_REG_CONFIG		0xF5
 #define BMP280_REG_CTRL_MEAS		0xF4
 #define BMP280_REG_STATUS		0xF3
-#define BMP280_REG_CTRL_HUMIDITY	0xF2
-
-/* Due to non linear mapping, and data sizes we can't do a bulk read */
-#define BMP280_REG_COMP_H1		0xA1
-#define BMP280_REG_COMP_H2		0xE1
-#define BMP280_REG_COMP_H3		0xE3
-#define BMP280_REG_COMP_H4		0xE4
-#define BMP280_REG_COMP_H5		0xE5
-#define BMP280_REG_COMP_H6		0xE7
 
 #define BMP280_REG_COMP_TEMP_START	0x88
 #define BMP280_COMP_TEMP_REG_COUNT	6
@@ -223,8 +212,6 @@
 #define BMP280_REG_COMP_PRESS_START	0x8E
 #define BMP280_COMP_PRESS_REG_COUNT	18
 
-#define BMP280_COMP_H5_MASK		GENMASK(15, 4)
-
 #define BMP280_CONTIGUOUS_CALIB_REGS	(BMP280_COMP_TEMP_REG_COUNT + \
 					 BMP280_COMP_PRESS_REG_COUNT)
 
@@ -235,14 +222,6 @@
 #define BMP280_FILTER_8X		3
 #define BMP280_FILTER_16X		4
 
-#define BMP280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
-#define BMP280_OSRS_HUMIDITY_SKIP	0
-#define BMP280_OSRS_HUMIDITY_1X		1
-#define BMP280_OSRS_HUMIDITY_2X		2
-#define BMP280_OSRS_HUMIDITY_4X		3
-#define BMP280_OSRS_HUMIDITY_8X		4
-#define BMP280_OSRS_HUMIDITY_16X	5
-
 #define BMP280_OSRS_TEMP_MASK		GENMASK(7, 5)
 #define BMP280_OSRS_TEMP_SKIP		0
 #define BMP280_OSRS_TEMP_1X		1
@@ -264,6 +243,30 @@
 #define BMP280_MODE_FORCED		1
 #define BMP280_MODE_NORMAL		3
 
+/* BME280 specific registers */
+#define BME280_REG_HUMIDITY_LSB		0xFE
+#define BME280_REG_HUMIDITY_MSB		0xFD
+
+#define BME280_REG_CTRL_HUMIDITY	0xF2
+
+/* Due to non linear mapping, and data sizes we can't do a bulk read */
+#define BME280_REG_COMP_H1		0xA1
+#define BME280_REG_COMP_H2		0xE1
+#define BME280_REG_COMP_H3		0xE3
+#define BME280_REG_COMP_H4		0xE4
+#define BME280_REG_COMP_H5		0xE5
+#define BME280_REG_COMP_H6		0xE7
+
+#define BME280_COMP_H5_MASK		GENMASK(15, 4)
+
+#define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
+#define BME280_OSRS_HUMIDITY_SKIP	0
+#define BME280_OSRS_HUMIDITY_1X		1
+#define BME280_OSRS_HUMIDITY_2X		2
+#define BME280_OSRS_HUMIDITY_4X		3
+#define BME280_OSRS_HUMIDITY_8X		4
+#define BME280_OSRS_HUMIDITY_16X	5
+
 /* BMP180 specific registers */
 #define BMP180_REG_OUT_XLSB		0xF8
 #define BMP180_REG_OUT_LSB		0xF7
-- 
2.25.1


