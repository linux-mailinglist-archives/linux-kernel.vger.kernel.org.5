Return-Path: <linux-kernel+bounces-106857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 726F687F492
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD49B21138
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718A8F9D1;
	Tue, 19 Mar 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaarPMbT"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF231C3E;
	Tue, 19 Mar 2024 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710808181; cv=none; b=iCCYC2Knk1+DI0KxBkPQNMPlyfpuaP9jJS1dsAr7jUZeeL+EQQs2iLJrUkCo9pJUkGn8EJ1LGHXQsBIMootUd3BQpPlBusH4hFljwKSCh6bfvHH/EPmASLMGnEfT/SuznHO+GC8UVakaJT+0qFlV2R1bhtZarYJnav7wwMotONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710808181; c=relaxed/simple;
	bh=SMjamXsghAruaajF6BqKqPaV4kuSE+ultexCBLkmd4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cd0HOeJuzU0boXSYvFXiVhVhhb589JxkOHfh41mFqAq3EInS2ZcZdcJpqGwoPH6MazxPko7NGNZ2ksXzfWW/u9HtCFMQxZbHc6UjbDC7KgrE4o2+kHV4phdwjhhGPpQCRJ8wkzmb6p3seY41+GD1944VRGdBqF66SoXx5rsJf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaarPMbT; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56899d9bf52so6434523a12.2;
        Mon, 18 Mar 2024 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710808177; x=1711412977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMzVP/ZU7ElAGknHYusFFOwN83HKOtk44T/24Gy6kBs=;
        b=SaarPMbTj+zIpvInorMHwQY4t9qiJhj63A6Xza4B3L296AsiXF7kUuNDEL+hki/x1Z
         xQzHDQZmZ5m7QRnG0U0uWSLUzvwsdx5dtZfTPq3z7dCkxoI2wfQjzfA6qvrTTTDXzr1v
         DhGlQ+JDVj4He+laAdVFwbsZQ66gpK+EpYVagBuq8iQftAZ9wdnNL+C+3ZzALUhSZjp3
         jlnvcwiPTZJjIaXxTTG8On5qVHe2bjfrwPM/WN9kVIAt5e/TVrvzGQL902H/JD06f8+A
         hzdXhM1egW2VA8VNZUU2aPfQwlwjVyYx2K8y4QlEKrSEM3IrgRjzQJwlkUdU4An1wN4e
         T/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710808177; x=1711412977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMzVP/ZU7ElAGknHYusFFOwN83HKOtk44T/24Gy6kBs=;
        b=isYIQM/RCOYc6Jr4BXPRGp3OJgqgtF+bpFfpMGvm/UOJbnauGB/RPloOYTtgRcYDNG
         9r8zVN28n6BF7LxYv0CDOblvkMjawXjjzU25wwXq7quscrinmPPQD28yAd+tnrVRGIuj
         IBG1gOY1jLg0mFw3QD4pPnb7LGMFCjanosCZuxeFxQnQLxC5b0vTcZsEqWfGkvauIN6J
         iY7myB9H3Ye1/5ph+/lZr07STB6/6vLgn/jPWCj/szJD6VZ3lX9GBfFQs7jpmoE4Gge/
         wY10CG7KMT+p3FqE/L6QoIIPTH6ch6QAF8NC0wkf5IxtCAYoOQGjAsJs+dnJo/gkZBU2
         nC9g==
X-Forwarded-Encrypted: i=1; AJvYcCUAxPP15uyagaIwTXo5WF45KHEqxYZ/VUOlKJq/BOn/1iaPEESKdUZqZGvdYjAH2T5bAtI4mOokspaZcof/b0z7LZVV4tmbBv9ybwjZVl3Adc47Fl1XBJ4dDOeZiy8WnTmo7gWcCowX
X-Gm-Message-State: AOJu0YzPV5eWAq2yVgbHdGgZvZZpQMXoaXZM+zOhxQ91e+psMlnIQ6qv
	EyeNnkxbGIlhpmv3skPSf+J34kHITqXyQtyLCLwYSKq3IqJP0aWC
X-Google-Smtp-Source: AGHT+IF1wVCIj9x9kfGmOlbhoujL4cDxeeZCo9Gnx1Mq3n80p5S5rQeU0bSMC8a0ATF/jc1UnTUt/Q==
X-Received: by 2002:a05:6402:4581:b0:56b:7f52:d56a with SMTP id ig1-20020a056402458100b0056b7f52d56amr661735edb.7.1710808176993;
        Mon, 18 Mar 2024 17:29:36 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:8c96:c55f:eab0:860])
        by smtp.gmail.com with ESMTPSA id co24-20020a0564020c1800b00568c613570dsm2700227edb.79.2024.03.18.17.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 17:29:36 -0700 (PDT)
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
Subject: [PATCH v3 3/6] iio: pressure: Generalize read_{temp/press/humid}() functions
Date: Tue, 19 Mar 2024 01:29:22 +0100
Message-Id: <20240319002925.2121016-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240319002925.2121016-1-vassilisamir@gmail.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the coefficients for the IIO standard units and the return
IIO value inside the chip_info structure.

Remove the calculations with the coefficients for the IIO unit
compatibility from inside the read_{temp/press/humid}() functions
and move it to the general read_raw() function.

Execute the calculations with the coefficients inside the read_raw()
oneshot capture function.

In this way, all the data for the calculation of the value are
located in the chip_info structure of the respective sensor.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 189 +++++++++++++++--------------
 drivers/iio/pressure/bmp280.h      |  13 +-
 2 files changed, 106 insertions(+), 96 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f7a13ff6f26c..6d6173c4b744 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -363,10 +363,9 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 	return (u32)p;
 }
 
-static int bmp280_read_temp(struct bmp280_data *data,
-			    int *val, int *val2)
+static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 adc_temp, comp_temp;
+	s32 adc_temp;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
@@ -382,29 +381,20 @@ static int bmp280_read_temp(struct bmp280_data *data,
 		dev_err(data->dev, "reading temperature skipped\n");
 		return -EIO;
 	}
-	comp_temp = bmp280_compensate_temp(data, adc_temp);
 
-	/*
-	 * val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		*val = comp_temp * 10;
-		return IIO_VAL_INT;
-	}
+	if (comp_temp)
+		*comp_temp = bmp280_compensate_temp(data, adc_temp);
 
 	return 0;
 }
 
-static int bmp280_read_press(struct bmp280_data *data,
-			     int *val, int *val2)
+static int bmp280_read_press(struct bmp280_data *data, u32 *comp_press)
 {
-	u32 comp_press;
 	s32 adc_press;
 	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp280_read_temp(data, NULL, NULL);
+	ret = bmp280_read_temp(data, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -421,22 +411,19 @@ static int bmp280_read_press(struct bmp280_data *data,
 		dev_err(data->dev, "reading pressure skipped\n");
 		return -EIO;
 	}
-	comp_press = bmp280_compensate_press(data, adc_press);
 
-	*val = comp_press;
-	*val2 = 256000;
+	*comp_press = bmp280_compensate_press(data, adc_press);
 
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
-static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
+static int bmp280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
 {
-	u32 comp_humidity;
 	s32 adc_humidity;
 	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp280_read_temp(data, NULL, NULL);
+	ret = bmp280_read_temp(data, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -453,11 +440,10 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 		dev_err(data->dev, "reading humidity skipped\n");
 		return -EIO;
 	}
-	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
 
-	*val = comp_humidity * 1000 / 1024;
+	*comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
 
-	return IIO_VAL_INT;
+	return 0;
 }
 
 static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
@@ -465,6 +451,8 @@ static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
 				   int *val, int *val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
+	int chan_value;
+	int ret;
 
 	guard(mutex)(&data->lock);
 
@@ -472,11 +460,29 @@ static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			return data->chip_info->read_humid(data, val, val2);
+			ret = data->chip_info->read_humid(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = data->chip_info->humid_coeffs[0] * chan_value;
+			*val2 = data->chip_info->humid_coeffs[1];
+			return data->chip_info->humid_coeffs_type;
 		case IIO_PRESSURE:
-			return data->chip_info->read_press(data, val, val2);
+			ret = data->chip_info->read_press(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = data->chip_info->press_coeffs[0] * chan_value;
+			*val2 = data->chip_info->press_coeffs[1];
+			return data->chip_info->press_coeffs_type;
 		case IIO_TEMP:
-			return data->chip_info->read_temp(data, val, val2);
+			ret = data->chip_info->read_temp(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = data->chip_info->temp_coeffs[0] * chan_value;
+			*val2 = data->chip_info->temp_coeffs[1];
+			return data->chip_info->temp_coeffs_type;
 		default:
 			return -EINVAL;
 		}
@@ -787,6 +793,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
 
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
+static const int bmp280_temp_coeffs[] = { 10, 1 };
+static const int bmp280_press_coeffs[] = { 1, 256000 };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -815,6 +823,11 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
+	.temp_coeffs = bmp280_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp280_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
@@ -841,6 +854,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 }
 
 static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
+static const int bme280_humid_coeffs[] = { 1000, 1024 };
 
 const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -863,6 +877,14 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BMP280_OSRS_HUMIDITY_16X - 1,
 
+	.temp_coeffs = bmp280_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp280_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+	.humid_coeffs = bme280_humid_coeffs,
+	.humid_coeffs_type = IIO_VAL_FRACTIONAL,
+
+
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
@@ -988,9 +1010,8 @@ static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
 	return comp_press;
 }
 
-static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 comp_temp;
 	u32 adc_temp;
 	int ret;
 
@@ -1006,29 +1027,20 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 		dev_err(data->dev, "reading temperature skipped\n");
 		return -EIO;
 	}
-	comp_temp = bmp380_compensate_temp(data, adc_temp);
 
-	/*
-	 * Val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		/* IIO reports temperatures in milli Celsius */
-		*val = comp_temp * 10;
-		return IIO_VAL_INT;
-	}
+	if (comp_temp)
+		*comp_temp = bmp380_compensate_temp(data, adc_temp);
 
 	return 0;
 }
 
-static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp380_read_press(struct bmp280_data *data, u32 *comp_press)
 {
-	s32 comp_press;
 	u32 adc_press;
 	int ret;
 
 	/* Read and compensate for temperature so we get a reading of t_fine */
-	ret = bmp380_read_temp(data, NULL, NULL);
+	ret = bmp380_read_temp(data, NULL);
 	if (ret)
 		return ret;
 
@@ -1044,13 +1056,10 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 		dev_err(data->dev, "reading pressure skipped\n");
 		return -EIO;
 	}
-	comp_press = bmp380_compensate_press(data, adc_press);
 
-	*val = comp_press;
-	/* Compensated pressure is in cPa (centipascals) */
-	*val2 = 100000;
+	*comp_press = bmp380_compensate_press(data, adc_press);
 
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp380_read_calib(struct bmp280_data *data)
@@ -1218,6 +1227,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
+static const int bmp380_temp_coeffs[] = { 10, 1 };
+static const int bmp380_press_coeffs[] = { 1, 100000 };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
@@ -1244,6 +1255,11 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.temp_coeffs = bmp380_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp380_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp380_chip_config,
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
@@ -1364,9 +1380,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
  * for what is expected on IIO ABI.
  */
 
-static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 {
-	s32 raw_temp;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
@@ -1376,25 +1391,17 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
 		return ret;
 	}
 
-	raw_temp = get_unaligned_le24(data->buf);
-	if (raw_temp == BMP580_TEMP_SKIPPED) {
+	*raw_temp = get_unaligned_le24(data->buf);
+	if (*raw_temp == BMP580_TEMP_SKIPPED) {
 		dev_err(data->dev, "reading temperature skipped\n");
 		return -EIO;
 	}
 
-	/*
-	 * Temperature is returned in Celsius degrees in fractional
-	 * form down 2^16. We rescale by x1000 to return milli Celsius
-	 * to respect IIO ABI.
-	 */
-	*val = raw_temp * 1000;
-	*val2 = 16;
-	return IIO_VAL_FRACTIONAL_LOG2;
+	return 0;
 }
 
-static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
 {
-	u32 raw_press;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
@@ -1404,18 +1411,13 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
 		return ret;
 	}
 
-	raw_press = get_unaligned_le24(data->buf);
-	if (raw_press == BMP580_PRESS_SKIPPED) {
+	*raw_press = get_unaligned_le24(data->buf);
+	if (*raw_press == BMP580_PRESS_SKIPPED) {
 		dev_err(data->dev, "reading pressure skipped\n");
 		return -EIO;
 	}
-	/*
-	 * Pressure is returned in Pascals in fractional form down 2^16.
-	 * We rescale /1000 to convert to kilopascal to respect IIO ABI.
-	 */
-	*val = raw_press;
-	*val2 = 64000; /* 2^6 * 1000 */
-	return IIO_VAL_FRACTIONAL;
+
+	return 0;
 }
 
 static const int bmp580_odr_table[][2] = {
@@ -1720,6 +1722,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
 
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
+static const int bmp580_temp_coeffs[] = { 1000, 16 };
+static const int bmp580_press_coeffs[] = { 1, 64000 };
 
 const struct bmp280_chip_info bmp580_chip_info = {
 	.id_reg = BMP580_REG_CHIP_ID,
@@ -1746,6 +1750,11 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.temp_coeffs = bmp280_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
+	.press_coeffs = bmp280_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
@@ -1873,25 +1882,17 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 	return (data->t_fine + 8) >> 4;
 }
 
-static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp180_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 adc_temp, comp_temp;
+	s32 adc_temp;
 	int ret;
 
 	ret = bmp180_read_adc_temp(data, &adc_temp);
 	if (ret)
 		return ret;
 
-	comp_temp = bmp180_compensate_temp(data, adc_temp);
-
-	/*
-	 * val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		*val = comp_temp * 100;
-		return IIO_VAL_INT;
-	}
+	if (comp_temp)
+		*comp_temp = bmp180_compensate_temp(data, adc_temp);
 
 	return 0;
 }
@@ -1953,15 +1954,13 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 	return p + ((x1 + x2 + 3791) >> 4);
 }
 
-static int bmp180_read_press(struct bmp280_data *data,
-			     int *val, int *val2)
+static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
 {
-	u32 comp_press;
 	s32 adc_press;
 	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp180_read_temp(data, NULL, NULL);
+	ret = bmp180_read_temp(data, NULL);
 	if (ret)
 		return ret;
 
@@ -1969,12 +1968,9 @@ static int bmp180_read_press(struct bmp280_data *data,
 	if (ret)
 		return ret;
 
-	comp_press = bmp180_compensate_press(data, adc_press);
-
-	*val = comp_press;
-	*val2 = 1000;
+	*comp_press = bmp180_compensate_press(data, adc_press);
 
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp180_chip_config(struct bmp280_data *data)
@@ -1985,6 +1981,8 @@ static int bmp180_chip_config(struct bmp280_data *data)
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
+static const int bmp180_temp_coeffs[] = { 100, 1 };
+static const int bmp180_press_coeffs[] = { 1, 1000 };
 
 const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -2005,6 +2003,11 @@ const struct bmp280_chip_info bmp180_chip_info = {
 		ARRAY_SIZE(bmp180_oversampling_press_avail),
 	.oversampling_press_default = BMP180_MEAS_PRESS_8X,
 
+	.temp_coeffs = bmp180_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp180_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp180_chip_config,
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 4012387d7956..6d1dca31dd52 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -448,10 +448,17 @@ struct bmp280_chip_info {
 	int num_sampling_freq_avail;
 	int sampling_freq_default;
 
+	const int *temp_coeffs;
+	const int temp_coeffs_type;
+	const int *press_coeffs;
+	const int press_coeffs_type;
+	const int *humid_coeffs;
+	const int humid_coeffs_type;
+
 	int (*chip_config)(struct bmp280_data *);
-	int (*read_temp)(struct bmp280_data *, int *, int *);
-	int (*read_press)(struct bmp280_data *, int *, int *);
-	int (*read_humid)(struct bmp280_data *, int *, int *);
+	int (*read_temp)(struct bmp280_data *, s32 *);
+	int (*read_press)(struct bmp280_data *, u32 *);
+	int (*read_humid)(struct bmp280_data *, u32 *);
 	int (*read_calib)(struct bmp280_data *);
 	int (*preinit)(struct bmp280_data *);
 };
-- 
2.25.1


