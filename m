Return-Path: <linux-kernel+bounces-134587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC589B34D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B100282AE4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A912E3BB23;
	Sun,  7 Apr 2024 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4R3L2nu"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB03BB47;
	Sun,  7 Apr 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712510974; cv=none; b=Lz8dkx24F4TvU4COJchCsA9kLekkj+0x/T8y01n2ammMVmBIWCrywI1mczREQ2yEIGzuPFFrZ3Sf9xJ7fyxG2JqOtCAxKl94hWtMFcfAIjsU3d84IWknWoCl4cmqKeR9Dp5VXC4W5SN6dZlmlJbdrZiNuzvTUXFoIlPucS8erIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712510974; c=relaxed/simple;
	bh=Jdc0wLX+fk5t1+2IKwat9IaVO8nZ0lUDPM0814id3BM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWbCU01xImgOEMgbizgyGzELwkJjDo/Q6vghHd0uMoDYtpv04UwRQbfXA7syREEkBirplwQGBMl6/XqOHO264cBkuRU0x6PrWwLOsFOniCTOqsTa/Lx5W9leQF5R/Yqqa2QEPBG8ZU2wbsofSuxXQjSi7dIeKJZkx/nCGBWKxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4R3L2nu; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516dd07d373so561442e87.3;
        Sun, 07 Apr 2024 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712510969; x=1713115769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SCyxLWaZEa4L05RgWq0j9mxubTTHnaebNVCJHbyK/0=;
        b=B4R3L2nuaYuKUTocq4By1mV8VA9TsQUeIPWD8/lIpZzr2DRu8CfGa6z3v8XISqH2Kw
         u+SwPYK6A0zs2qfDPAY49G0Y4otOayBEhmvp9XA6IfgDoLJVP4R6g8gjFHEWfWLG8xwg
         DY78VUE/naK7crDAg2i7s9NT0O8DN6y6k3G4iTVvHWcSTcEOxt7z34lCvp41wj0cwh67
         L5LJpLM4U3XpM1Qo8TF8gJP0e6W0sDAT2iM9//BR3/m2b2qAK7xpYU7qGlUChSbdIzX4
         ZoYZ4OQoi/M369ICafXy6aRl2rSYhKiYdIeROJHMjVwXYRG+xU7qM6BmdmbRaSeSaPlK
         0r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712510969; x=1713115769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SCyxLWaZEa4L05RgWq0j9mxubTTHnaebNVCJHbyK/0=;
        b=EJlfxp3pXmLt8pR0JLdd80BU4IlRVuswVd0jrtuPKiMnWP4bj9U8VO4B7RPGXS6Q3S
         VxhEn01SuBxLqh8mS6ziWayLqRAa5QfUPwJIwaMsP/wTl7TMdE2CGjwI2y4ft7wsguXp
         ukbgq2sAnHCsY560aFUSNQMzklzVq4LQ0tQFIfOfwF8fMi0QIh9fW6ZilvZWs/2GF/bc
         H2OMJwJdh2szMByexLKIARpM01z+/Y+b00BRY46d+dMgEbtfgViXEL+qKYPuCeSjI64l
         OsJrMm6dHe+4QeekfGc9iA+WthfkGcXHbBojErpMAkPqZ9Oh3XG2PsqmfkHXH+oniDof
         kK/A==
X-Forwarded-Encrypted: i=1; AJvYcCU/8zbp7MaaB7iGi2YmDQc1uaPzsum+97s0k9boI3KoGdMIvEI2B7jhA1n6yhfmg941qp/3Z/VQnjpKtrMlOAiyx1yLbAUorohqyXJTwogPfid1qrJZ+wJVSQrebW9ms+TEMpiMSBzv
X-Gm-Message-State: AOJu0Yxg70O910AIPDmJSS+mG5jZ14p3WAOjBpN9it+TR3IHg43UHhhW
	CBAocOrf+Av9eYhgA2x4CkkJTCpIP9s7EoVl7ZKW4bGG7o4T61ID8sFN69ECN1qmug==
X-Google-Smtp-Source: AGHT+IH3Nnq/nE1mFhVulNu1GdLqGssJkJZpgG3dJMGuw5dVKuDkg547AfV/mEpOgcUkOcdHVVP/SQ==
X-Received: by 2002:a05:6512:3a8e:b0:516:c9a7:82de with SMTP id q14-20020a0565123a8e00b00516c9a782demr5445827lfu.38.1712510969032;
        Sun, 07 Apr 2024 10:29:29 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c509:e54e:6ef:eb0c])
        by smtp.gmail.com with ESMTPSA id j22-20020aa7c416000000b0056e4b9ec1aasm1307134edq.52.2024.04.07.10.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 10:29:28 -0700 (PDT)
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
Subject: [PATCH v4 1/6] iio: pressure: bmp280: Various driver cleanups
Date: Sun,  7 Apr 2024 19:29:15 +0200
Message-Id: <20240407172920.264282-2-vassilisamir@gmail.com>
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

Various driver cleanups including:

a) change names of functions that are used by all sensors from
   bmp280_read_raw_* to bmp_read_raw_* to make it more clear that
   these functions are general and not tied to the BMP280 sensor.

b) modify some defines that are used only by the BME280 sensor
   to use the naming convention BME280_* and not BMP280_*.

c) add various error messages that were not implemented.

d) sort headers.

e) fix various indentation errors which were found by checkpatch.pl.

g) Add identifier names in function definitions which were warned
   by checkpatch.pl.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c   | 244 ++++++++++++++-------------
 drivers/iio/pressure/bmp280-i2c.c    |   2 +-
 drivers/iio/pressure/bmp280-regmap.c |   8 +-
 drivers/iio/pressure/bmp280-spi.c    |   8 +-
 drivers/iio/pressure/bmp280.h        |  50 +++---
 5 files changed, 159 insertions(+), 153 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 09f53d987c7d..1c51139cbfcf 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -52,7 +52,6 @@
  */
 enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
 
-
 enum bmp380_odr {
 	BMP380_ODR_200HZ,
 	BMP380_ODR_100HZ,
@@ -71,7 +70,7 @@ enum bmp380_odr {
 	BMP380_ODR_0_01HZ,
 	BMP380_ODR_0_006HZ,
 	BMP380_ODR_0_003HZ,
-	BMP380_ODR_0_0015HZ,
+	BMP380_ODR_0_0015HZ
 };
 
 enum bmp580_odr {
@@ -106,7 +105,7 @@ enum bmp580_odr {
 	BMP580_ODR_1HZ,
 	BMP580_ODR_0_5HZ,
 	BMP580_ODR_0_25HZ,
-	BMP580_ODR_0_125HZ,
+	BMP580_ODR_0_125HZ
 };
 
 /*
@@ -131,7 +130,7 @@ enum {
 	BMP380_P8 = 16,
 	BMP380_P9 = 17,
 	BMP380_P10 = 19,
-	BMP380_P11 = 20,
+	BMP380_P11 = 20
 };
 
 static const struct iio_chan_spec bmp280_channels[] = {
@@ -181,11 +180,10 @@ static int bmp280_read_calib(struct bmp280_data *data)
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	int ret;
 
-
 	/* Read temperature and pressure calibration values. */
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
 			       data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev,
 			"failed to read temperature and pressure calibration parameters\n");
 		return ret;
@@ -222,7 +220,7 @@ static int bme280_read_calib(struct bmp280_data *data)
 
 	/* Load shared calibration params with bmp280 first */
 	ret = bmp280_read_calib(data);
-	if  (ret < 0) {
+	if  (ret) {
 		dev_err(dev, "failed to read common bmp280 calibration parameters\n");
 		return ret;
 	}
@@ -235,47 +233,47 @@ static int bme280_read_calib(struct bmp280_data *data)
 	 * Humidity data is only available on BME280.
 	 */
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &tmp);
-	if (ret < 0) {
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H1, &tmp);
+	if (ret) {
 		dev_err(dev, "failed to read H1 comp value\n");
 		return ret;
 	}
 	calib->H1 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H2,
 			       &data->le16, sizeof(data->le16));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "failed to read H2 comp value\n");
 		return ret;
 	}
 	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
-	if (ret < 0) {
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H3, &tmp);
+	if (ret) {
 		dev_err(dev, "failed to read H3 comp value\n");
 		return ret;
 	}
 	calib->H3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H4,
 			       &data->be16, sizeof(data->be16));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "failed to read H4 comp value\n");
 		return ret;
 	}
 	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
 				  (be16_to_cpu(data->be16) & 0xf), 11);
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
 			       &data->le16, sizeof(data->le16));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
-	calib->H5 = sign_extend32(FIELD_GET(BMP280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
+	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
 
-	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
-	if (ret < 0) {
+	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
+	if (ret) {
 		dev_err(dev, "failed to read H6 comp value\n");
 		return ret;
 	}
@@ -283,14 +281,14 @@ static int bme280_read_calib(struct bmp280_data *data)
 
 	return 0;
 }
+
 /*
  * Returns humidity in percent, resolution is 0.01 percent. Output value of
  * "47445" represents 47445/1024 = 46.333 %RH.
  *
  * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
  */
-static u32 bmp280_compensate_humidity(struct bmp280_data *data,
-				      s32 adc_humidity)
+static u32 bme280_compensate_humidity(struct bmp280_data *data, s32 adc_humidity)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s32 var;
@@ -305,7 +303,7 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
 	var = clamp_val(var, 0, 419430400);
 
 	return var >> 12;
-};
+}
 
 /*
  * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
@@ -314,8 +312,7 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
  *
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
-static s32 bmp280_compensate_temp(struct bmp280_data *data,
-				  s32 adc_temp)
+static s32 bmp280_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s32 var1, var2;
@@ -337,8 +334,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
  *
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
-static u32 bmp280_compensate_press(struct bmp280_data *data,
-				   s32 adc_press)
+static u32 bmp280_compensate_press(struct bmp280_data *data, s32 adc_press)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s64 var1, var2, p;
@@ -363,15 +359,14 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 	return (u32)p;
 }
 
-static int bmp280_read_temp(struct bmp280_data *data,
-			    int *val, int *val2)
+static int bmp280_read_temp(struct bmp280_data *data, int *val, int *val2)
 {
 	s32 adc_temp, comp_temp;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
 			       data->buf, sizeof(data->buf));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
 	}
@@ -396,8 +391,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	return 0;
 }
 
-static int bmp280_read_press(struct bmp280_data *data,
-			     int *val, int *val2)
+static int bmp280_read_press(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_press;
 	s32 adc_press;
@@ -405,12 +399,12 @@ static int bmp280_read_press(struct bmp280_data *data,
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
 	ret = bmp280_read_temp(data, NULL, NULL);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
 			       data->buf, sizeof(data->buf));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
 	}
@@ -429,7 +423,7 @@ static int bmp280_read_press(struct bmp280_data *data,
 	return IIO_VAL_FRACTIONAL;
 }
 
-static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
+static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_humidity;
 	s32 adc_humidity;
@@ -437,12 +431,12 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
 	ret = bmp280_read_temp(data, NULL, NULL);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
+	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
 			       &data->be16, sizeof(data->be16));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to read humidity\n");
 		return ret;
 	}
@@ -453,16 +447,16 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 		dev_err(data->dev, "reading humidity skipped\n");
 		return -EIO;
 	}
-	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
+	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
 
 	*val = comp_humidity * 1000 / 1024;
 
 	return IIO_VAL_INT;
 }
 
-static int bmp280_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
+static int bmp_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int ret;
@@ -537,8 +531,7 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
-					       int val)
+static int bmp_write_oversampling_ratio_humid(struct bmp280_data *data, int val)
 {
 	const int *avail = data->chip_info->oversampling_humid_avail;
 	const int n = data->chip_info->num_oversampling_humid_avail;
@@ -562,8 +555,7 @@ static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
 	return -EINVAL;
 }
 
-static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
-					       int val)
+static int bmp_write_oversampling_ratio_temp(struct bmp280_data *data, int val)
 {
 	const int *avail = data->chip_info->oversampling_temp_avail;
 	const int n = data->chip_info->num_oversampling_temp_avail;
@@ -587,8 +579,7 @@ static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
 	return -EINVAL;
 }
 
-static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
-					       int val)
+static int bmp_write_oversampling_ratio_press(struct bmp280_data *data, int val)
 {
 	const int *avail = data->chip_info->oversampling_press_avail;
 	const int n = data->chip_info->num_oversampling_press_avail;
@@ -612,8 +603,7 @@ static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
 	return -EINVAL;
 }
 
-static int bmp280_write_sampling_frequency(struct bmp280_data *data,
-					   int val, int val2)
+static int bmp_write_sampling_frequency(struct bmp280_data *data, int val, int val2)
 {
 	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
 	const int n = data->chip_info->num_sampling_freq_avail;
@@ -637,7 +627,7 @@ static int bmp280_write_sampling_frequency(struct bmp280_data *data,
 	return -EINVAL;
 }
 
-static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
+static int bmp_write_iir_filter_coeffs(struct bmp280_data *data, int val)
 {
 	const int *avail = data->chip_info->iir_filter_coeffs_avail;
 	const int n = data->chip_info->num_iir_filter_coeffs_avail;
@@ -662,9 +652,9 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
 	return -EINVAL;
 }
 
-static int bmp280_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int bmp_write_raw(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 int val, int val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
 	int ret = 0;
@@ -681,13 +671,13 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 		mutex_lock(&data->lock);
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			ret = bmp280_write_oversampling_ratio_humid(data, val);
+			ret = bmp_write_oversampling_ratio_humid(data, val);
 			break;
 		case IIO_PRESSURE:
-			ret = bmp280_write_oversampling_ratio_press(data, val);
+			ret = bmp_write_oversampling_ratio_press(data, val);
 			break;
 		case IIO_TEMP:
-			ret = bmp280_write_oversampling_ratio_temp(data, val);
+			ret = bmp_write_oversampling_ratio_temp(data, val);
 			break;
 		default:
 			ret = -EINVAL;
@@ -700,7 +690,7 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		pm_runtime_get_sync(data->dev);
 		mutex_lock(&data->lock);
-		ret = bmp280_write_sampling_frequency(data, val, val2);
+		ret = bmp_write_sampling_frequency(data, val, val2);
 		mutex_unlock(&data->lock);
 		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
@@ -708,7 +698,7 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		pm_runtime_get_sync(data->dev);
 		mutex_lock(&data->lock);
-		ret = bmp280_write_iir_filter_coeffs(data, val);
+		ret = bmp_write_iir_filter_coeffs(data, val);
 		mutex_unlock(&data->lock);
 		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
@@ -720,10 +710,10 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int bmp280_read_avail(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     const int **vals, int *type, int *length,
-			     long mask)
+static int bmp_read_avail(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  const int **vals, int *type, int *length,
+			  long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
 
@@ -760,9 +750,9 @@ static int bmp280_read_avail(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info bmp280_info = {
-	.read_raw = &bmp280_read_raw,
-	.read_avail = &bmp280_read_avail,
-	.write_raw = &bmp280_write_raw,
+	.read_raw = &bmp_read_raw,
+	.read_avail = &bmp_read_avail,
+	.write_raw = &bmp_write_raw,
 };
 
 static int bmp280_chip_config(struct bmp280_data *data)
@@ -772,22 +762,20 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
-				 BMP280_OSRS_TEMP_MASK |
-				 BMP280_OSRS_PRESS_MASK |
-				 BMP280_MODE_MASK,
-				 osrs | BMP280_MODE_NORMAL);
-	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to write ctrl_meas register\n");
+				BMP280_OSRS_TEMP_MASK |
+				BMP280_OSRS_PRESS_MASK |
+				BMP280_MODE_MASK,
+				osrs | BMP280_MODE_NORMAL);
+	if (ret) {
+		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
 	}
 
 	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
 				 BMP280_FILTER_MASK,
 				 BMP280_FILTER_4X);
-	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to write config register\n");
+	if (ret) {
+		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
 
@@ -833,18 +821,19 @@ EXPORT_SYMBOL_NS(bmp280_chip_info, IIO_BMP280);
 
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
-	if (ret < 0)
+	ret = regmap_update_bits(data->regmap, BME280_REG_CTRL_HUMIDITY,
+				 BME280_OSRS_HUMIDITY_MASK, osrs);
+	if (ret) {
+		dev_err(data->dev, "failed to set humidity oversampling\n");
 		return ret;
+	}
 
 	return bmp280_chip_config(data);
 }
@@ -870,12 +859,12 @@ const struct bmp280_chip_info bme280_chip_info = {
 
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
@@ -1116,7 +1105,7 @@ static const int bmp380_odr_table[][2] = {
 	[BMP380_ODR_0_01HZ]	= {0, 12207},
 	[BMP380_ODR_0_006HZ]	= {0, 6104},
 	[BMP380_ODR_0_003HZ]	= {0, 3052},
-	[BMP380_ODR_0_0015HZ]	= {0, 1526},
+	[BMP380_ODR_0_0015HZ]	= {0, 1526}
 };
 
 static int bmp380_preinit(struct bmp280_data *data)
@@ -1138,8 +1127,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 				 BMP380_CTRL_SENSORS_PRESS_EN |
 				 BMP380_CTRL_SENSORS_TEMP_EN);
 	if (ret) {
-		dev_err(data->dev,
-			"failed to write operation control register\n");
+		dev_err(data->dev, "failed to write operation control register\n");
 		return ret;
 	}
 
@@ -1216,7 +1204,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		}
 		if (tmp & BMP380_ERR_CONF_MASK) {
 			dev_warn(data->dev,
-				"sensor flagged configuration as incompatible\n");
+				 "sensor flagged configuration as incompatible\n");
 			return -EINVAL;
 		}
 	}
@@ -1345,10 +1333,6 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 		poll = 50;
 		timeout = 400;
 	}
-	if (ret) {
-		dev_err(data->dev, "failed to write command sequence\n");
-		return -EIO;
-	}
 
 	/* Wait until NVM is ready again */
 	ret = regmap_read_poll_timeout(data->regmap, BMP580_REG_STATUS, reg,
@@ -1460,7 +1444,7 @@ static const int bmp580_odr_table[][2] = {
 	[BMP580_ODR_1HZ] =	{1, 0},
 	[BMP580_ODR_0_5HZ] =	{0, 500000},
 	[BMP580_ODR_0_25HZ] =	{0, 250000},
-	[BMP580_ODR_0_125HZ] =	{0, 125000},
+	[BMP580_ODR_0_125HZ] =	{0, 125000}
 };
 
 static const int bmp580_nvmem_addrs[] = { 0x20, 0x21, 0x22 };
@@ -1501,8 +1485,8 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 		if (ret)
 			goto exit;
 
-		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
-				       sizeof(data->le16));
+		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB,
+				       &data->le16, sizeof(data->le16));
 		if (ret) {
 			dev_err(data->dev, "error reading nvm data regs\n");
 			goto exit;
@@ -1546,7 +1530,8 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 	while (bytes >= sizeof(*buf)) {
 		addr = bmp580_nvmem_addrs[offset / sizeof(*buf)];
 
-		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR, BMP580_NVM_PROG_EN |
+		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
+				   BMP580_NVM_PROG_EN |
 				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
 		if (ret) {
 			dev_err(data->dev, "error writing nvm address\n");
@@ -1554,8 +1539,8 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 		}
 		data->le16 = cpu_to_le16(*buf++);
 
-		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB, &data->le16,
-					sizeof(data->le16));
+		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB,
+					&data->le16, sizeof(data->le16));
 		if (ret) {
 			dev_err(data->dev, "error writing LSB NVM data regs\n");
 			goto exit;
@@ -1607,20 +1592,24 @@ static int bmp580_preinit(struct bmp280_data *data)
 
 	/* Post powerup sequence */
 	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to establish comms with the chip\n");
 		return ret;
+	}
 
 	/* Print warn message if we don't know the chip id */
 	if (reg != BMP580_CHIP_ID && reg != BMP580_CHIP_ID_ALT)
-		dev_warn(data->dev, "preinit: unexpected chip_id\n");
+		dev_warn(data->dev, "unexpected chip_id\n");
 
 	ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to read nvm status\n");
 		return ret;
+	}
 
 	/* Check nvm status */
 	if (!(reg & BMP580_STATUS_NVM_RDY_MASK) || (reg & BMP580_STATUS_NVM_ERR_MASK)) {
-		dev_err(data->dev, "preinit: nvm error on powerup sequence\n");
+		dev_err(data->dev, "nvm error on powerup sequence\n");
 		return -EIO;
 	}
 
@@ -1655,6 +1644,10 @@ static int bmp580_chip_config(struct bmp280_data *data)
 				 BMP580_DSP_COMP_MASK |
 				 BMP580_DSP_SHDW_IIR_TEMP_EN |
 				 BMP580_DSP_SHDW_IIR_PRESS_EN, reg_val);
+	if (ret) {
+		dev_err(data->dev, "failed to change DSP mode settings\n");
+		return ret;
+	}
 
 	/* Configure oversampling */
 	reg_val = FIELD_PREP(BMP580_OSR_TEMP_MASK, data->oversampling_temp) |
@@ -1763,7 +1756,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
 
-static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
+static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 {
 	const int conversion_time_max[] = { 4500, 7500, 13500, 25500 };
 	unsigned int delay_us;
@@ -1774,8 +1767,10 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 		reinit_completion(&data->done);
 
 	ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to write crtl_meas register\n");
 		return ret;
+	}
 
 	if (data->use_eoc) {
 		/*
@@ -1798,12 +1793,16 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 	}
 
 	ret = regmap_read(data->regmap, BMP280_REG_CTRL_MEAS, &ctrl);
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to read ctrl_meas register\n");
 		return ret;
+	}
 
 	/* The value of this bit reset to "0" after conversion is complete */
-	if (ctrl & BMP180_MEAS_SCO)
+	if (ctrl & BMP180_MEAS_SCO) {
+		dev_err(data->dev, "conversion didn't complete\n");
 		return -EIO;
+	}
 
 	return 0;
 }
@@ -1812,7 +1811,7 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 {
 	int ret;
 
-	ret = bmp180_measure(data,
+	ret = bmp180_wait_for_eoc(data,
 			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_TEMP) |
 			     BMP180_MEAS_SCO);
 	if (ret)
@@ -1820,8 +1819,10 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
 			       &data->be16, sizeof(data->be16));
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
+	}
 
 	*val = be16_to_cpu(data->be16);
 
@@ -1836,9 +1837,10 @@ static int bmp180_read_calib(struct bmp280_data *data)
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START,
 			       data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf));
-
-	if (ret < 0)
+	if (ret) {
+		dev_err(data->dev, "failed to read calibration parameters\n");
 		return ret;
+	}
 
 	/* None of the words has the value 0 or 0xFFFF */
 	for (i = 0; i < ARRAY_SIZE(data->bmp180_cal_buf); i++) {
@@ -1911,17 +1913,19 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 	u8 oss = data->oversampling_press;
 	int ret;
 
-	ret = bmp180_measure(data,
-			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_PRESS) |
-			     FIELD_PREP(BMP180_OSRS_PRESS_MASK, oss) |
-			     BMP180_MEAS_SCO);
+	ret = bmp180_wait_for_eoc(data,
+				  FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_PRESS) |
+				  FIELD_PREP(BMP180_OSRS_PRESS_MASK, oss) |
+				  BMP180_MEAS_SCO);
 	if (ret)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
 			       data->buf, sizeof(data->buf));
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
+	}
 
 	*val = get_unaligned_be24(data->buf) >> (8 - oss);
 
@@ -1963,8 +1967,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 	return p + ((x1 + x2 + 3791) >> 4);
 }
 
-static int bmp180_read_press(struct bmp280_data *data,
-			     int *val, int *val2)
+static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_press;
 	s32 adc_press;
@@ -2154,8 +2157,10 @@ int bmp280_common_probe(struct device *dev,
 	data->regmap = regmap;
 
 	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
-	if (ret < 0)
+	if (ret) {
+		dev_err(data->dev, "failed to read chip id\n");
 		return ret;
+	}
 
 	for (i = 0; i < data->chip_info->num_chip_id; i++) {
 		if (chip_id == data->chip_info->chip_id[i]) {
@@ -2175,7 +2180,7 @@ int bmp280_common_probe(struct device *dev,
 	}
 
 	ret = data->chip_info->chip_config(data);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	dev_set_drvdata(dev, indio_dev);
@@ -2188,7 +2193,7 @@ int bmp280_common_probe(struct device *dev,
 
 	if (data->chip_info->read_calib) {
 		ret = data->chip_info->read_calib(data);
-		if (ret < 0)
+		if (ret)
 			return dev_err_probe(data->dev, ret,
 					     "failed to read calibration coefficients\n");
 	}
@@ -2241,6 +2246,7 @@ static int bmp280_runtime_resume(struct device *dev)
 	ret = regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
 	if (ret)
 		return ret;
+
 	usleep_range(data->start_up_time, data->start_up_time + 100);
 	return data->chip_info->chip_config(data);
 }
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 34e3bc758493..5c3a63b4327c 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
 
 #include "bmp280.h"
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
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 4e19ea0b4d39..ce92f283e142 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -5,15 +5,15 @@
  * Inspired by the older BMP085 driver drivers/misc/bmp085-spi.c
  */
 #include <linux/bits.h>
-#include <linux/module.h>
-#include <linux/spi/spi.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/spi/spi.h>
 
 #include "bmp280.h"
 
 static int bmp280_regmap_spi_write(void *context, const void *data,
-                                   size_t count)
+				   size_t count)
 {
 	struct spi_device *spi = to_spi_device(context);
 	u8 buf[2];
@@ -29,7 +29,7 @@ static int bmp280_regmap_spi_write(void *context, const void *data,
 }
 
 static int bmp280_regmap_spi_read(void *context, const void *reg,
-                                  size_t reg_size, void *val, size_t val_size)
+				  size_t reg_size, void *val, size_t val_size)
 {
 	struct spi_device *spi = to_spi_device(context);
 
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 5812a344ed8e..ea8eb5691428 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/bitops.h>
 #include <linux/device.h>
-#include <linux/iio/iio.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/iio/iio.h>
 
 /* BMP580 specific registers */
 #define BMP580_REG_CMD			0x7E
@@ -192,8 +192,8 @@
 #define BMP380_PRESS_SKIPPED		0x800000
 
 /* BMP280 specific registers */
-#define BMP280_REG_HUMIDITY_LSB		0xFE
-#define BMP280_REG_HUMIDITY_MSB		0xFD
+#define BME280_REG_HUMIDITY_LSB		0xFE
+#define BME280_REG_HUMIDITY_MSB		0xFD
 #define BMP280_REG_TEMP_XLSB		0xFC
 #define BMP280_REG_TEMP_LSB		0xFB
 #define BMP280_REG_TEMP_MSB		0xFA
@@ -207,15 +207,15 @@
 #define BMP280_REG_CONFIG		0xF5
 #define BMP280_REG_CTRL_MEAS		0xF4
 #define BMP280_REG_STATUS		0xF3
-#define BMP280_REG_CTRL_HUMIDITY	0xF2
+#define BME280_REG_CTRL_HUMIDITY	0xF2
 
 /* Due to non linear mapping, and data sizes we can't do a bulk read */
-#define BMP280_REG_COMP_H1		0xA1
-#define BMP280_REG_COMP_H2		0xE1
-#define BMP280_REG_COMP_H3		0xE3
-#define BMP280_REG_COMP_H4		0xE4
-#define BMP280_REG_COMP_H5		0xE5
-#define BMP280_REG_COMP_H6		0xE7
+#define BME280_REG_COMP_H1		0xA1
+#define BME280_REG_COMP_H2		0xE1
+#define BME280_REG_COMP_H3		0xE3
+#define BME280_REG_COMP_H4		0xE4
+#define BME280_REG_COMP_H5		0xE5
+#define BME280_REG_COMP_H6		0xE7
 
 #define BMP280_REG_COMP_TEMP_START	0x88
 #define BMP280_COMP_TEMP_REG_COUNT	6
@@ -223,7 +223,7 @@
 #define BMP280_REG_COMP_PRESS_START	0x8E
 #define BMP280_COMP_PRESS_REG_COUNT	18
 
-#define BMP280_COMP_H5_MASK		GENMASK(15, 4)
+#define BME280_COMP_H5_MASK		GENMASK(15, 4)
 
 #define BMP280_CONTIGUOUS_CALIB_REGS	(BMP280_COMP_TEMP_REG_COUNT + \
 					 BMP280_COMP_PRESS_REG_COUNT)
@@ -235,13 +235,13 @@
 #define BMP280_FILTER_8X		3
 #define BMP280_FILTER_16X		4
 
-#define BMP280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
-#define BMP280_OSRS_HUMIDITY_SKIP	0
-#define BMP280_OSRS_HUMIDITY_1X		1
-#define BMP280_OSRS_HUMIDITY_2X		2
-#define BMP280_OSRS_HUMIDITY_4X		3
-#define BMP280_OSRS_HUMIDITY_8X		4
-#define BMP280_OSRS_HUMIDITY_16X	5
+#define BME280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
+#define BME280_OSRS_HUMIDITY_SKIP	0
+#define BME280_OSRS_HUMIDITY_1X		1
+#define BME280_OSRS_HUMIDITY_2X		2
+#define BME280_OSRS_HUMIDITY_4X		3
+#define BME280_OSRS_HUMIDITY_8X		4
+#define BME280_OSRS_HUMIDITY_16X	5
 
 #define BMP280_OSRS_TEMP_MASK		GENMASK(7, 5)
 #define BMP280_OSRS_TEMP_SKIP		0
@@ -449,12 +449,12 @@ struct bmp280_chip_info {
 	int num_sampling_freq_avail;
 	int sampling_freq_default;
 
-	int (*chip_config)(struct bmp280_data *);
-	int (*read_temp)(struct bmp280_data *, int *, int *);
-	int (*read_press)(struct bmp280_data *, int *, int *);
-	int (*read_humid)(struct bmp280_data *, int *, int *);
-	int (*read_calib)(struct bmp280_data *);
-	int (*preinit)(struct bmp280_data *);
+	int (*chip_config)(struct bmp280_data *data);
+	int (*read_temp)(struct bmp280_data *data, int *val, int *val2);
+	int (*read_press)(struct bmp280_data *data, int *val, int *val2);
+	int (*read_humid)(struct bmp280_data *data, int *val, int *val2);
+	int (*read_calib)(struct bmp280_data *data);
+	int (*preinit)(struct bmp280_data *data);
 };
 
 /* Chip infos for each variant */
@@ -473,7 +473,7 @@ extern const struct regmap_config bmp580_regmap_config;
 /* Probe called from different transports */
 int bmp280_common_probe(struct device *dev,
 			struct regmap *regmap,
-			const struct bmp280_chip_info *,
+			const struct bmp280_chip_info *chip_info,
 			const char *name,
 			int irq);
 
-- 
2.25.1


