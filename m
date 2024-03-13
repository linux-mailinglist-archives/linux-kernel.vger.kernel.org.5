Return-Path: <linux-kernel+bounces-102284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B223D87B02C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFAA1F2B9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E46F10F1;
	Wed, 13 Mar 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WshdTlhi"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D342453381;
	Wed, 13 Mar 2024 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351621; cv=none; b=eysZ0QgRmSeAo8DHf4z2G4Fk6G/HMg8OugH3aRBvPwY7OO8pQZt7a7APhB3o3MidJIMby4rHmzhvIoL+rGFMeJKDgAqpBfYA2tUJAEVjWCikwmlSg23596LKvhyuFyN745Vqx750QNoZDDVUdcJkEeXxMS+nJiEY5zTvaIDz7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351621; c=relaxed/simple;
	bh=On9sVYDLvPUcsKk2DF0yvW4V+rsN3YG+MuHq8vOLHfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fh+/sA9TbD5bRDs6RQvjSJ3NKpt4UdEQ2JRmcjdG3kkgQdc8uXNoeN5D9X/tHFRRwxH82SAQAc3qbr7wXCjELjI1OpCg8AAoMH3NEEtestMh3759lLyz9KBg/OiEVjxDkUV8GY/tIXvHDqBWDBIO4vELRmobC+sEnQh2h51hFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WshdTlhi; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51320ca689aso150766e87.2;
        Wed, 13 Mar 2024 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351618; x=1710956418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hB48c/985v0iXsymw7ct5Hw7M/WwZxYtKNkSzqMQG38=;
        b=WshdTlhiuEdLHw/0cTJHWcvfJrKxNRh/krLWZKWZd0q6ivfABHRlbwTTL1E8wdaIHG
         b3DjCEDLF17pbFJ5QUiRJbP1OTzTCeWL6kaiXp98HGPlhHZ4wvCm34Vmo4RqFl4rnqVy
         hoCZ7IOJyfJe5qNzRsvhDfAmkJidfO9POflFyfXb8x/tHVvp+WmwQYOcNY9RN0uhIqQk
         7Kmc5Ju82uHbqstTAd/Bdek9irSAi4pRVd91F8QOpTctc9Pazx4NjRCtBSa0W15nbc8R
         BYMxPsv7tA+ofTwpWtVK05il8q/VYFCiw2GoC0GJt8zayG5U7vAJte6rj1OSSRCdQWS2
         /AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351618; x=1710956418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hB48c/985v0iXsymw7ct5Hw7M/WwZxYtKNkSzqMQG38=;
        b=mUByMCKNObeRvePgtMOD3FOlLmVOxkZNCVnlJJzGtjxbE2kKWrt40tENpsP7LssxR+
         bGex9apgyNcnTVeuyyfGMAmGa7EoT5djn3nDPmLtFD6mV8gnEtM5d5PdbvaFiYiI2uB6
         vsoDW79km/Fzyr0FCwQj6r3mrQ31BOhiYBuMZ1GhE2RhoaZT47kQTKz2GU1fo5xVJvyo
         VpHc3/zhJWarr4NYaVVNXPl722nuqto92w08twn2PWEPmiq9WNmNObvwwshMNbI3uCLl
         VKvWwAqZ/Dj8DwXvroHO7bnc+JF5PhhzyM+BFNWGMjKjmUxe2W+sDRzhqVsooxVJlzR7
         dewQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBtFQNFvX7ZhEe3lKwlQtorueE8bClNpXtD1ge5a9MxzA8cfhCZi8uchZNwJyVDmYPvIj32T71xGe6GpCr1kqYUZBqyt3pFwQuKMYreGzvyjcGP0vTfsi8HCDQiJzALjhGjs75MbqE
X-Gm-Message-State: AOJu0YzHnKD7PYm1pHstKFl0K2aBIXDManJv24InlXTg+U7NXNWPJ8Px
	yx7NDmPj7MaPLxn+YHUmiy14RVrOt0EMj2OSQjDIiearoeh+yAZp2Xp8pJtu0M3Wf0Hp
X-Google-Smtp-Source: AGHT+IFfBnoncQGUY2cQcKcc2zKkLrdLPxIKy/eJtxbuwTU3/HG88bh8J9UNaCNd/AulgCrVppEiBQ==
X-Received: by 2002:a05:6512:522:b0:513:bc99:677 with SMTP id o2-20020a056512052200b00513bc990677mr3676970lfc.27.1710351617983;
        Wed, 13 Mar 2024 10:40:17 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:fa35:157e:1a40:3463])
        by smtp.gmail.com with ESMTPSA id m17-20020a1709061ed100b00a449076d0dbsm5028215ejj.53.2024.03.13.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:40:17 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	linus.walleij@linaro.org,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 2/6] iio: pressure: Simplify read_* functions
Date: Wed, 13 Mar 2024 18:40:03 +0100
Message-Id: <20240313174007.1934983-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240313174007.1934983-1-vassilisamir@gmail.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the coefficients for the IIO standard units inside the chip_info
structure.

Remove the calculations with the coefficients for the IIO compatibility
from inside the read_(temp/press/humid) functions and move it to the
read_raw function.

Execute the calculations with the coefficients inside the read_raw
oneshot capture functions.

Also fix raw_* and comp_* values signs.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 150 +++++++++++++----------------
 drivers/iio/pressure/bmp280.h      |  10 +-
 2 files changed, 74 insertions(+), 86 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 871b2214121b..dfd845acfa22 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -363,8 +363,7 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 	return (u32)p;
 }
 
-static int bmp280_read_temp(struct bmp280_data *data,
-			    int *val, int *val2)
+static s32 bmp280_read_temp(struct bmp280_data *data)
 {
 	s32 adc_temp, comp_temp;
 	int ret;
@@ -384,27 +383,17 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	}
 	comp_temp = bmp280_compensate_temp(data, adc_temp);
 
-	/*
-	 * val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		*val = comp_temp * 10;
-		return IIO_VAL_INT;
-	}
-
-	return 0;
+	return comp_temp;
 }
 
-static int bmp280_read_press(struct bmp280_data *data,
-			     int *val, int *val2)
+static u32 bmp280_read_press(struct bmp280_data *data)
 {
 	u32 comp_press;
 	s32 adc_press;
 	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp280_read_temp(data, NULL, NULL);
+	ret = bmp280_read_temp(data);
 	if (ret < 0)
 		return ret;
 
@@ -423,20 +412,17 @@ static int bmp280_read_press(struct bmp280_data *data,
 	}
 	comp_press = bmp280_compensate_press(data, adc_press);
 
-	*val = comp_press;
-	*val2 = 256000;
-
-	return IIO_VAL_FRACTIONAL;
+	return comp_press;
 }
 
-static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
+static u32 bmp280_read_humid(struct bmp280_data *data)
 {
 	u32 comp_humidity;
 	s32 adc_humidity;
 	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp280_read_temp(data, NULL, NULL);
+	ret = bmp280_read_temp(data);
 	if (ret < 0)
 		return ret;
 
@@ -455,9 +441,7 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	}
 	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
 
-	*val = comp_humidity * 1000 / 1024;
-
-	return IIO_VAL_INT;
+	return comp_humidity;
 }
 
 static int bmp280_read_raw(struct iio_dev *indio_dev,
@@ -474,13 +458,27 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = data->chip_info->read_humid(data, val, val2);
+			ret = data->chip_info->read_humid(data);
+			*val = data->chip_info->humid_coeffs[0] * ret;
+			*val2 = data->chip_info->humid_coeffs[1];
+			ret = IIO_VAL_FRACTIONAL;
 			break;
 		case IIO_PRESSURE:
-			ret = data->chip_info->read_press(data, val, val2);
+			ret = data->chip_info->read_press(data);
+			*val = data->chip_info->press_coeffs[0] * ret;
+			*val2 = data->chip_info->press_coeffs[1];
+			ret = IIO_VAL_FRACTIONAL;
 			break;
 		case IIO_TEMP:
-			ret = data->chip_info->read_temp(data, val, val2);
+			ret = data->chip_info->read_temp(data);
+			*val = data->chip_info->temp_coeffs[0] * ret;
+			*val2 = data->chip_info->temp_coeffs[1];
+
+			if (!strcmp(indio_dev->name, "bmp580"))
+				ret = IIO_VAL_FRACTIONAL_LOG2;
+			else
+				ret = IIO_VAL_FRACTIONAL;
+
 			break;
 		default:
 			ret = -EINVAL;
@@ -796,6 +794,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
 
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
+static const int bmp280_temp_coeffs[] = { 10, 1 };
+static const int bmp280_press_coeffs[] = { 1, 256000 };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -824,6 +824,9 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
+	.temp_coeffs = bmp280_temp_coeffs,
+	.press_coeffs = bmp280_press_coeffs,
+
 	.chip_config = bmp280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
@@ -850,6 +853,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 }
 
 static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
+static const int bme280_humid_coeffs[] = { 1000, 1024 };
 
 const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -872,6 +876,10 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BMP280_OSRS_HUMIDITY_16X - 1,
 
+	.temp_coeffs = bmp280_temp_coeffs,
+	.press_coeffs = bmp280_press_coeffs,
+	.humid_coeffs = bme280_humid_coeffs,
+
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
@@ -997,7 +1005,7 @@ static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
 	return comp_press;
 }
 
-static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
+static s32 bmp380_read_temp(struct bmp280_data *data)
 {
 	s32 comp_temp;
 	u32 adc_temp;
@@ -1017,27 +1025,17 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 	}
 	comp_temp = bmp380_compensate_temp(data, adc_temp);
 
-	/*
-	 * Val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		/* IIO reports temperatures in milli Celsius */
-		*val = comp_temp * 10;
-		return IIO_VAL_INT;
-	}
-
-	return 0;
+	return comp_temp;
 }
 
-static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
+static u32 bmp380_read_press(struct bmp280_data *data)
 {
-	s32 comp_press;
-	u32 adc_press;
+	u32 comp_press;
+	s32 adc_press;
 	int ret;
 
 	/* Read and compensate for temperature so we get a reading of t_fine */
-	ret = bmp380_read_temp(data, NULL, NULL);
+	ret = bmp380_read_temp(data);
 	if (ret)
 		return ret;
 
@@ -1055,11 +1053,7 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 	}
 	comp_press = bmp380_compensate_press(data, adc_press);
 
-	*val = comp_press;
-	/* Compensated pressure is in cPa (centipascals) */
-	*val2 = 100000;
-
-	return IIO_VAL_FRACTIONAL;
+	return comp_press;
 }
 
 static int bmp380_read_calib(struct bmp280_data *data)
@@ -1227,6 +1221,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
+static const int bmp380_temp_coeffs[] = { 10, 1 };
+static const int bmp380_press_coeffs[] = { 1, 100000 };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
@@ -1253,6 +1249,9 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.temp_coeffs = bmp380_temp_coeffs,
+	.press_coeffs = bmp380_press_coeffs,
+
 	.chip_config = bmp380_chip_config,
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
@@ -1373,7 +1372,7 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
  * for what is expected on IIO ABI.
  */
 
-static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
+static s32 bmp580_read_temp(struct bmp280_data *data)
 {
 	s32 raw_temp;
 	int ret;
@@ -1391,17 +1390,10 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
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
+	return raw_temp;
 }
 
-static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
+static u32 bmp580_read_press(struct bmp280_data *data)
 {
 	u32 raw_press;
 	int ret;
@@ -1418,13 +1410,8 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
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
+	return raw_press;
 }
 
 static const int bmp580_odr_table[][2] = {
@@ -1729,6 +1716,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
 
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
+static const int bmp580_temp_coeffs[] = { 1000, 16 };
+static const int bmp580_press_coeffs[] = { 1, 64000 };
 
 const struct bmp280_chip_info bmp580_chip_info = {
 	.id_reg = BMP580_REG_CHIP_ID,
@@ -1755,6 +1744,9 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.temp_coeffs = bmp580_temp_coeffs,
+	.press_coeffs = bmp580_press_coeffs,
+
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
@@ -1882,7 +1874,7 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 	return (data->t_fine + 8) >> 4;
 }
 
-static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
+static s32 bmp180_read_temp(struct bmp280_data *data)
 {
 	s32 adc_temp, comp_temp;
 	int ret;
@@ -1893,16 +1885,7 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
 
 	comp_temp = bmp180_compensate_temp(data, adc_temp);
 
-	/*
-	 * val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		*val = comp_temp * 100;
-		return IIO_VAL_INT;
-	}
-
-	return 0;
+	return comp_temp;
 }
 
 static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
@@ -1962,15 +1945,14 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 	return p + ((x1 + x2 + 3791) >> 4);
 }
 
-static int bmp180_read_press(struct bmp280_data *data,
-			     int *val, int *val2)
+static u32 bmp180_read_press(struct bmp280_data *data)
 {
 	u32 comp_press;
 	s32 adc_press;
 	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp180_read_temp(data, NULL, NULL);
+	ret = bmp180_read_temp(data);
 	if (ret)
 		return ret;
 
@@ -1980,10 +1962,7 @@ static int bmp180_read_press(struct bmp280_data *data,
 
 	comp_press = bmp180_compensate_press(data, adc_press);
 
-	*val = comp_press;
-	*val2 = 1000;
-
-	return IIO_VAL_FRACTIONAL;
+	return comp_press;
 }
 
 static int bmp180_chip_config(struct bmp280_data *data)
@@ -1994,6 +1973,8 @@ static int bmp180_chip_config(struct bmp280_data *data)
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
+static const int bmp180_temp_coeffs[] = { 100, 1 };
+static const int bmp180_press_coeffs[] = { 1, 1000 };
 
 const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -2014,6 +1995,9 @@ const struct bmp280_chip_info bmp180_chip_info = {
 		ARRAY_SIZE(bmp180_oversampling_press_avail),
 	.oversampling_press_default = BMP180_MEAS_PRESS_8X,
 
+	.temp_coeffs = bmp180_temp_coeffs,
+	.press_coeffs = bmp180_press_coeffs,
+
 	.chip_config = bmp180_chip_config,
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 4012387d7956..dde55b556ea2 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -448,10 +448,14 @@ struct bmp280_chip_info {
 	int num_sampling_freq_avail;
 	int sampling_freq_default;
 
+	const int *temp_coeffs;
+	const int *press_coeffs;
+	const int *humid_coeffs;
+
 	int (*chip_config)(struct bmp280_data *);
-	int (*read_temp)(struct bmp280_data *, int *, int *);
-	int (*read_press)(struct bmp280_data *, int *, int *);
-	int (*read_humid)(struct bmp280_data *, int *, int *);
+	s32 (*read_temp)(struct bmp280_data *);
+	u32 (*read_press)(struct bmp280_data *);
+	u32 (*read_humid)(struct bmp280_data *);
 	int (*read_calib)(struct bmp280_data *);
 	int (*preinit)(struct bmp280_data *);
 };
-- 
2.25.1


