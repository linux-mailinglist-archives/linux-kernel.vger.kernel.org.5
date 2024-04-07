Return-Path: <linux-kernel+bounces-134590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AA789B351
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55091F21F93
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57A93F8DA;
	Sun,  7 Apr 2024 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k310dBbX"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F13C47D;
	Sun,  7 Apr 2024 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510977; cv=none; b=HKTEPDwAucb2Nn8V4Xt2piAhcMpgB0It9srkWbXILTe9zzSKq+Spvm+9+3ufwounAGARydL+ki/YlTSO8P//hphJUIm7+2Pkk2pGCoNEky3c5xmHz3TiMza8B+QuFulUDTkA00dJxulSchUs9v9K1eJiKOMri7muo54vwCY9K0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510977; c=relaxed/simple;
	bh=yUqUUcC44/LOzWuz3SkaTE4TJz8LrAkjrG+mJXhuy4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t0cCNeEGQpSTkonhlL6/dU2fHTa97cBq25hx/O5fj15rSGxTR9sW6rduAxcP4F8OLenPLM5PtV0SKyCe4ClznpBYwtdI26xKgoe1LwKbXY7qUxl356QTl4ZJxgCRG/ivTqqLavE6jUNN46kbuZxSGWIkcVNiiqttdtaxVqE52EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k310dBbX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so1548443a12.2;
        Sun, 07 Apr 2024 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712510973; x=1713115773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCUG0KoQ+d3ijHrxH7Wc6avudpBAZew8YPIhl9S0AEU=;
        b=k310dBbXQyYAlyAwNEUObJuFlsOxTYYR44PAeo2N8Kaz7rtg+5fKRNQotDVVCoaRtc
         HJffFIWk+jkmqI4herF1Yyw1BUCB3YrbP4n2Od+Kx0h7zeNItHjfWKG7akvCLBswpAS5
         oOBo6l+1W9yPD3Hd1jrFkUZAdekOcS0vUGEbc5QbIlduzJmfVskPcy6C8vEyWt0HjSRr
         Vs5XzPHIPXrklo+rSo7pTUYfDpOOEBrLUddL9AJhxaGkuAoIjzU+TQcfL3R/vVXQhRtJ
         oluH0Q3whZexNd34SZCdY9e4ynsozcXDSuw1NgcIquQmaOq/iIqX5JCyHt3pDr1cGmti
         V4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712510973; x=1713115773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCUG0KoQ+d3ijHrxH7Wc6avudpBAZew8YPIhl9S0AEU=;
        b=CcoD5qdcre9JEsGHmVxrvwRXRif2KqaFn5Razxrp6R4zDMPTj1tD15vQebMkMrKbhs
         StGOV1VyLXrHFO02IpGRTmze6mfVXneOYgWFvuYehMC+5AZFVwA0glaebP17jcTlsQ2S
         ugFnxURwxXTAQOyxop5DqF7cWVkh2BNoXms5gSt9RcRPXc9HvtDgAl7AWMuW2TyVQwMA
         bAMXRULaRbgzVosq5k+6ZyVrwoMonb8i9zAr5du2WxHzR5uVGvSGnoz2iU+gu5UcJKte
         oyoMqPgGJl6pbrxNVvX7gJfGxsv6IIUmQfZb3N8faMXNMo5MINhcXl1jy+MO8jvvCfV6
         yI8w==
X-Forwarded-Encrypted: i=1; AJvYcCXsiPna0xANBshEZRsLoMrYUs/K76lcqG/m7Dh/qEnmgvFwYxACmmEgSm0LN4lKlmRHPLN+gQ+eCSFrIqX9tfHGropbcYkNKRdHOyxYEBXukEXiWV6wuTc9elZIg21BJWaP5FWuzWLC
X-Gm-Message-State: AOJu0YxF9+mfwVKxU2bHrPdeqsezXOiJMjQ+1a9MgrEi8dBe2mxwNE4K
	IZKQhwFNFTHUUS6rpudrmUT2pgCMftO6ye/hgBIIjZugin/bgvUr
X-Google-Smtp-Source: AGHT+IHb6EPb6JuEXIv1vG+2rO5MHAQ++uvAWQDk5lVB/rJ4EJ6eejB0+4vsmF5o5/LjafR45FWxZw==
X-Received: by 2002:a50:8751:0:b0:56e:dd8:2eeb with SMTP id 17-20020a508751000000b0056e0dd82eebmr5137135edv.24.1712510973219;
        Sun, 07 Apr 2024 10:29:33 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c509:e54e:6ef:eb0c])
        by smtp.gmail.com with ESMTPSA id j22-20020aa7c416000000b0056e4b9ec1aasm1307134edq.52.2024.04.07.10.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 10:29:32 -0700 (PDT)
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
	u.kleine-koenig@pengutronix.de,
	biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v4 4/6] iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
Date: Sun,  7 Apr 2024 19:29:18 +0200
Message-Id: <20240407172920.264282-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240407172920.264282-1-vassilisamir@gmail.com>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the coefficients for the IIO standard units and the IIO value
inside the chip_info structure.

Move the calculations for the IIO unit compatibility from inside the
read_{temp,press,humid}() functions and move them to the general
read_raw() function.

In this way, all the data for the calculation of the value are
located in the chip_info structure of the respective sensor.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 167 ++++++++++++++++-------------
 drivers/iio/pressure/bmp280.h      |  13 ++-
 2 files changed, 102 insertions(+), 78 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 51bcdf8cede6..d05035574683 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -439,26 +439,23 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 	return (u32)p;
 }
 
-static int bmp280_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 adc_temp, comp_temp;
+	s32 adc_temp;
 	int ret;
 
 	ret = bmp280_read_temp_adc(data, &adc_temp);
 	if (ret)
 		return ret;
 
-	comp_temp = bmp280_compensate_temp(data, adc_temp);
+	*comp_temp = bmp280_compensate_temp(data, adc_temp);
 
-	/* IIO units are in milli Celsius */
-	*val = comp_temp * 10;
-	return IIO_VAL_INT;
+	return 0;
 }
 
-static int bmp280_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp280_read_press(struct bmp280_data *data, u32 *comp_press)
 {
 	s32 adc_press, t_fine;
-	u32 comp_press;
 	int ret;
 
 	ret = bmp280_get_t_fine(data, &t_fine);
@@ -469,19 +466,14 @@ static int bmp280_read_press(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
+	*comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
-	/* IIO units are in kPa */
-	*val = comp_press;
-	*val2 = 256000;
-
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
-static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
+static int bme280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
 {
 	s32 adc_humidity, t_fine;
-	u32 comp_humidity;
 	int ret;
 
 	ret = bmp280_get_t_fine(data, &t_fine);
@@ -492,12 +484,9 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
+	*comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
 
-	/* IIO units are in 1000 * % */
-	*val = comp_humidity * 1000 / 1024;
-
-	return IIO_VAL_INT;
+	return 0;
 }
 
 static int bmp_read_raw_impl(struct iio_dev *indio_dev,
@@ -505,6 +494,8 @@ static int bmp_read_raw_impl(struct iio_dev *indio_dev,
 			     int *val, int *val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
+	int chan_value;
+	int ret;
 
 	guard(mutex)(&data->lock);
 
@@ -512,11 +503,29 @@ static int bmp_read_raw_impl(struct iio_dev *indio_dev,
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
@@ -816,6 +825,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
 
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
+static const int bmp280_temp_coeffs[] = { 10, 1 };
+static const int bmp280_press_coeffs[] = { 1, 256000 };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -844,6 +855,11 @@ const struct bmp280_chip_info bmp280_chip_info = {
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
@@ -871,6 +887,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 }
 
 static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
+static const int bme280_humid_coeffs[] = { 1000, 1024 };
 
 const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -893,6 +910,13 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
+	.temp_coeffs = bmp280_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp280_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+	.humid_coeffs = bme280_humid_coeffs,
+	.humid_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
@@ -1081,9 +1105,8 @@ static u32 bmp380_compensate_press(struct bmp280_data *data,
 	return comp_press;
 }
 
-static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 comp_temp;
 	u32 adc_temp;
 	int ret;
 
@@ -1091,16 +1114,14 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_temp = bmp380_compensate_temp(data, adc_temp);
+	*comp_temp = bmp380_compensate_temp(data, adc_temp);
 
-	/* IIO units are in milli Celsius */
-	*val = comp_temp * 10;
-	return IIO_VAL_INT;
+	return 0;
 }
 
-static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp380_read_press(struct bmp280_data *data, u32 *comp_press)
 {
-	u32 adc_press, comp_press, t_fine;
+	u32 adc_press, t_fine;
 	int ret;
 
 	ret = bmp380_get_t_fine(data, &t_fine);
@@ -1111,13 +1132,9 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
+	*comp_press = bmp380_compensate_press(data, adc_press, t_fine);
 
-	/* IIO units are in kPa */
-	*val = comp_press;
-	*val2 = 100000;
-
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp380_read_calib(struct bmp280_data *data)
@@ -1284,6 +1301,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
+static const int bmp380_temp_coeffs[] = { 10, 1 };
+static const int bmp380_press_coeffs[] = { 1, 100000 };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
@@ -1311,6 +1330,11 @@ const struct bmp280_chip_info bmp380_chip_info = {
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
@@ -1427,9 +1451,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
  * for what is expected on IIO ABI.
  */
 
-static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 {
-	s32 raw_temp;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
@@ -1439,25 +1462,17 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
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
@@ -1467,18 +1482,13 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
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
@@ -1792,6 +1802,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
 
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
+static const int bmp580_temp_coeffs[] = { 1000, 16 };
+static const int bmp580_press_coeffs[] = { 1, 64000};
 
 const struct bmp280_chip_info bmp580_chip_info = {
 	.id_reg = BMP580_REG_CHIP_ID,
@@ -1818,6 +1830,11 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.temp_coeffs = bmp580_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
+	.press_coeffs = bmp580_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
@@ -1972,20 +1989,18 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 	return (bmp180_calc_t_fine(data, adc_temp) + 8) / 16;
 }
 
-static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp180_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 adc_temp, comp_temp;
+	s32 adc_temp;
 	int ret;
 
 	ret = bmp180_read_temp_adc(data, &adc_temp);
 	if (ret)
 		return ret;
 
-	comp_temp = bmp180_compensate_temp(data, adc_temp);
+	*comp_temp = bmp180_compensate_temp(data, adc_temp);
 
-	/* IIO units are in milli Celsius */
-	*val = comp_temp * 100;
-	return IIO_VAL_INT;
+	return 0;
 }
 
 static int bmp180_read_press_adc(struct bmp280_data *data, s32 *adc_press)
@@ -2048,10 +2063,9 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press,
 	return p + ((x1 + x2 + 3791) >> 4);
 }
 
-static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
 {
 	s32 adc_press, t_fine;
-	u32 comp_press;
 	int ret;
 
 	ret = bmp180_get_t_fine(data, &t_fine);
@@ -2062,13 +2076,9 @@ static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_press = bmp180_compensate_press(data, adc_press, t_fine);
-
-	/* IIO units are in kPa */
-	*val = comp_press;
-	*val2 = 1000;
+	*comp_press = bmp180_compensate_press(data, adc_press, t_fine);
 
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp180_chip_config(struct bmp280_data *data)
@@ -2079,6 +2089,8 @@ static int bmp180_chip_config(struct bmp280_data *data)
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
+static const int bmp180_temp_coeffs[] = { 100, 1 };
+static const int bmp180_press_coeffs[] = { 1, 1000 };
 
 const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -2099,6 +2111,11 @@ const struct bmp280_chip_info bmp180_chip_info = {
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
index 6dbd7413ad3f..ccba779d7a83 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -443,10 +443,17 @@ struct bmp280_chip_info {
 	int num_sampling_freq_avail;
 	int sampling_freq_default;
 
+	const int *temp_coeffs;
+	const int temp_coeffs_type;
+	const int *press_coeffs;
+	const int press_coeffs_type;
+	const int *humid_coeffs;
+	const int humid_coeffs_type;
+
 	int (*chip_config)(struct bmp280_data *data);
-	int (*read_temp)(struct bmp280_data *data, int *val, int *val2);
-	int (*read_press)(struct bmp280_data *data, int *val, int *val2);
-	int (*read_humid)(struct bmp280_data *data, int *val, int *val2);
+	int (*read_temp)(struct bmp280_data *data, s32 *adc_temp);
+	int (*read_press)(struct bmp280_data *data, u32 *adc_press);
+	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
 	int (*read_calib)(struct bmp280_data *data);
 	int (*preinit)(struct bmp280_data *data);
 };
-- 
2.25.1


