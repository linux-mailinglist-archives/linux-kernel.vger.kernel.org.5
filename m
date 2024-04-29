Return-Path: <linux-kernel+bounces-162871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064008B618A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889131F210BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBA613C819;
	Mon, 29 Apr 2024 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB6xdQav"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80C13BC07;
	Mon, 29 Apr 2024 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417266; cv=none; b=Q7qM/w/zD7km042k1ITe4KQnQoao89KQLqG8AcxtgERURSvLjT0nVQdMJesqISWd67ZX9nfJkdXv+Jn7PbzVsn7Mx6Z3bb01Eih8EJjkhjwk4XtvawfmgpHcXHofHn06vxWLGSa3152sQTuSpbflw0BMLZhLp6StqsA40dnxOZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417266; c=relaxed/simple;
	bh=vvmZIswHnUku9oseN2P7rPEbCOHxM5/CeF3KATn7JoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fi8UDbKKerNUPXG2E8OHjwFE8D2bJLQEuBnOeKTzJ3NNEsahQAGMe/MlXKz4/6izIeIRGevTBBhm/U3Nmq//6R31Q4MCVbPV0z5lsCHRcUt0p++Govv2nNc4UFqMl504erFuU9sW8UeRdo7sNaJz+elRDyvV2ap2NqYABtfHQdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB6xdQav; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so24805675e9.1;
        Mon, 29 Apr 2024 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417262; x=1715022062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Red/pDio/w2Qf/LzYh3/cV5la/dSjroNao1MDcKrofI=;
        b=GB6xdQav2A5KKGlVxDbSOUzU9cX94dUR4NXGYc69D1z3NTByFZ1Um9YhQDternMcvN
         PqHRHRSPZvM59SanRkIaYtlXPjVDOY31ZAaqNO5I40xY5JQnKr2BLSxhkd9EjrNAEybh
         FduCsK+QQVXrHXwLQqMuAiyj8/XLGba2r/XAyAr+4s47ykj8cjTOzVMA+52cb2R072SW
         C2rjw0GNNyK71Xem0419xulJSXLfZ7KFlXAkVmBiDvN+u4vcpjpIALYGXKPhQSvTudEL
         wVR86M5maUFTvXMlMwBbgEUF2/rR7JblZWHLya6LcblSAknTyHSkF4UrZFrUKa5k10ME
         7A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417262; x=1715022062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Red/pDio/w2Qf/LzYh3/cV5la/dSjroNao1MDcKrofI=;
        b=bk5TEYr5h5p9W+eKn0d/2WcUG7xzxraRhnLZ9WJpek9Xl7cH77ifG8mtV/I9DsMhJe
         wtqt8XFNShhgo3L6IKhojsrLb/z5uXLhKdTJ16vgJV4rLpTaijgxigozyw+l1/fRytTX
         q8sq8NvTgz8DXnr1XrJaT1WnP4YlrC1XELD54B16Jr2saXDYONf8ZA2pHdTxuFA8s9tY
         MQdZngWmIG63rtNljdZhrymP4VObxeNbEue+hghnrESMxT4r2uxRPGHXJbYu81WfXyBW
         quFJ6pqOzKJkK2oW0J8zlfT+VjPMcMObbJjb+X5vHh/OUporM2Fy2o87RxkEdCsi6DLO
         zCBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVRA0uVocnRuTaM1YgTizMm6llJG23ZQqOw9eMCCvcocRUqUKTG3WZlTvrvkGjStvc45yrmRLoGKOMMnGhwkDZpvMD4T2SOGvkCxn987L5N6U7FaNw05Cds54Gh2C49r/7Hu6qT8sd
X-Gm-Message-State: AOJu0Yz/AcLT1yFfdMymz09IkriIV+c3kEB6wmkwSOBqpoxBgThktDkY
	w1Nhqfn7zpUiGoUfQL2k0RwkqV5uaoPJ933KFBwUaLhMCwgcZ41W
X-Google-Smtp-Source: AGHT+IFTaKaPF8v7IF8APw16pwoa+pMny0mbHJOCE6KMF4+X92iL8bQGrpYGrWpXEYGmKytihixt1g==
X-Received: by 2002:adf:e487:0:b0:34c:d63a:aa20 with SMTP id i7-20020adfe487000000b0034cd63aaa20mr465102wrm.19.1714417262069;
        Mon, 29 Apr 2024 12:01:02 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:abbf:c98a:cf84:d14c])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0034c78bba70bsm8469456wrl.72.2024.04.29.12.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:01:01 -0700 (PDT)
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
Subject: [PATCH v5 05/10] iio: pressure: bmp280: Make return values consistent
Date: Mon, 29 Apr 2024 21:00:41 +0200
Message-Id: <20240429190046.24252-6-vassilisamir@gmail.com>
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

Throughout the driver there are quite a few places were return
values are treated as errors if they are negative or not-zero.
This commit tries to make the return values of those functions
consistent and treat them as errors in case there is a negative
value since the vast majority of the functions are returning
erorrs coming from regmap_*() functions.

While at it, add error messages that were not implemented before.

Finally, remove any extra error checks that are dead code.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 175 ++++++++++++++++-------------
 1 file changed, 96 insertions(+), 79 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index ed49e0779d41..8290028824e9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -222,10 +222,8 @@ static int bme280_read_calib(struct bmp280_data *data)
 
 	/* Load shared calibration params with bmp280 first */
 	ret = bmp280_read_calib(data);
-	if  (ret < 0) {
-		dev_err(dev, "failed to read calibration parameters\n");
+	if  (ret < 0)
 		return ret;
-	}
 
 	/*
 	 * Read humidity calibration values.
@@ -552,7 +550,7 @@ static int bme280_write_oversampling_ratio_humid(struct bmp280_data *data,
 			data->oversampling_humid = ilog2(val);
 
 			ret = data->chip_info->chip_config(data);
-			if (ret) {
+			if (ret < 0) {
 				data->oversampling_humid = prev;
 				data->chip_info->chip_config(data);
 				return ret;
@@ -577,7 +575,7 @@ static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
 			data->oversampling_temp = ilog2(val);
 
 			ret = data->chip_info->chip_config(data);
-			if (ret) {
+			if (ret < 0) {
 				data->oversampling_temp = prev;
 				data->chip_info->chip_config(data);
 				return ret;
@@ -602,7 +600,7 @@ static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
 			data->oversampling_press = ilog2(val);
 
 			ret = data->chip_info->chip_config(data);
-			if (ret) {
+			if (ret < 0) {
 				data->oversampling_press = prev;
 				data->chip_info->chip_config(data);
 				return ret;
@@ -627,7 +625,7 @@ static int bmp280_write_sampling_frequency(struct bmp280_data *data,
 			data->sampling_freq = i;
 
 			ret = data->chip_info->chip_config(data);
-			if (ret) {
+			if (ret < 0) {
 				data->sampling_freq = prev;
 				data->chip_info->chip_config(data);
 				return ret;
@@ -651,7 +649,7 @@ static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
 			data->iir_filter_coeff = i;
 
 			ret = data->chip_info->chip_config(data);
-			if (ret) {
+			if (ret < 0) {
 				data->iir_filter_coeff = prev;
 				data->chip_info->chip_config(data);
 				return ret;
@@ -841,8 +839,10 @@ static int bme280_chip_config(struct bmp280_data *data)
 	 */
 	ret = regmap_update_bits(data->regmap, BME280_REG_CTRL_HUMIDITY,
 				 BME280_OSRS_HUMIDITY_MASK, osrs);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to set humidity oversampling");
 		return ret;
+	}
 
 	return bmp280_chip_config(data);
 }
@@ -892,7 +892,7 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
 
 	/* Check if device is ready to process a command */
 	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to read error register\n");
 		return ret;
 	}
@@ -903,7 +903,7 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
 
 	/* Send command to process */
 	ret = regmap_write(data->regmap, BMP380_REG_CMD, cmd);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to send command to device\n");
 		return ret;
 	}
@@ -911,7 +911,7 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
 	usleep_range(data->start_up_time, data->start_up_time + 100);
 	/* Check for command processing error */
 	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &reg);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "error reading ERROR reg\n");
 		return ret;
 	}
@@ -1003,7 +1003,7 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
 			       data->buf, sizeof(data->buf));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
 	}
@@ -1036,12 +1036,12 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 
 	/* Read and compensate for temperature so we get a reading of t_fine */
 	ret = bmp380_read_temp(data, NULL, NULL);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
 			       data->buf, sizeof(data->buf));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
 	}
@@ -1069,9 +1069,9 @@ static int bmp380_read_calib(struct bmp280_data *data)
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START,
 			       data->bmp380_cal_buf,
 			       sizeof(data->bmp380_cal_buf));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev,
-			"failed to read temperature calibration parameters\n");
+			"failed to read calibration parameters\n");
 		return ret;
 	}
 
@@ -1137,7 +1137,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 				 BMP380_CTRL_SENSORS_MASK,
 				 BMP380_CTRL_SENSORS_PRESS_EN |
 				 BMP380_CTRL_SENSORS_TEMP_EN);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev,
 			"failed to write operation control register\n");
 		return ret;
@@ -1151,7 +1151,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 				       BMP380_OSRS_TEMP_MASK |
 				       BMP380_OSRS_PRESS_MASK,
 				       osrs, &aux);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to write oversampling register\n");
 		return ret;
 	}
@@ -1161,7 +1161,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	ret = regmap_update_bits_check(data->regmap, BMP380_REG_ODR,
 				       BMP380_ODRS_MASK, data->sampling_freq,
 				       &aux);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to write ODR selection register\n");
 		return ret;
 	}
@@ -1171,7 +1171,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	ret = regmap_update_bits_check(data->regmap, BMP380_REG_CONFIG, BMP380_FILTER_MASK,
 				       FIELD_PREP(BMP380_FILTER_MASK, data->iir_filter_coeff),
 				       &aux);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
@@ -1190,7 +1190,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
 					BMP380_MODE_MASK,
 					FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_SLEEP));
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev, "failed to set sleep mode\n");
 			return ret;
 		}
@@ -1198,7 +1198,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
 					BMP380_MODE_MASK,
 					FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_NORMAL));
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev, "failed to set normal mode\n");
 			return ret;
 		}
@@ -1211,7 +1211,7 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 		/* Check config error flag */
 		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev, "failed to read error register\n");
 			return ret;
 		}
@@ -1269,7 +1269,7 @@ static int bmp580_soft_reset(struct bmp280_data *data)
 	int ret;
 
 	ret = regmap_write(data->regmap, BMP580_REG_CMD, BMP580_CMD_SOFT_RESET);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to send reset command to device\n");
 		return ret;
 	}
@@ -1277,13 +1277,13 @@ static int bmp580_soft_reset(struct bmp280_data *data)
 
 	/* Dummy read of chip_id */
 	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to reestablish comms after reset\n");
 		return ret;
 	}
 
 	ret = regmap_read(data->regmap, BMP580_REG_INT_STATUS, &reg);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "error reading interrupt status register\n");
 		return ret;
 	}
@@ -1308,7 +1308,7 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 
 	/* Check NVM ready flag */
 	ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to check nvm status\n");
 		return ret;
 	}
@@ -1320,7 +1320,7 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 	/* Start NVM operation sequence */
 	ret = regmap_write(data->regmap, BMP580_REG_CMD,
 			   BMP580_CMD_NVM_OP_SEQ_0);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev,
 			"failed to send nvm operation's first sequence\n");
 		return ret;
@@ -1329,7 +1329,7 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 		/* Send NVM write sequence */
 		ret = regmap_write(data->regmap, BMP580_REG_CMD,
 				   BMP580_CMD_NVM_WRITE_SEQ_1);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev,
 				"failed to send nvm write sequence\n");
 			return ret;
@@ -1341,7 +1341,7 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 		/* Send NVM read sequence */
 		ret = regmap_write(data->regmap, BMP580_REG_CMD,
 				   BMP580_CMD_NVM_READ_SEQ_1);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev,
 				"failed to send nvm read sequence\n");
 			return ret;
@@ -1350,16 +1350,12 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
 		poll = 50;
 		timeout = 400;
 	}
-	if (ret) {
-		dev_err(data->dev, "failed to write command sequence\n");
-		return -EIO;
-	}
 
 	/* Wait until NVM is ready again */
 	ret = regmap_read_poll_timeout(data->regmap, BMP580_REG_STATUS, reg,
 				       (reg & BMP580_STATUS_NVM_RDY_MASK),
 				       poll, timeout);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "error checking nvm operation status\n");
 		return ret;
 	}
@@ -1386,7 +1382,7 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
 			       sizeof(data->buf));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
 	}
@@ -1414,7 +1410,7 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
 			       sizeof(data->buf));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
 	}
@@ -1485,7 +1481,7 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 				 BMP580_MODE_MASK | BMP580_ODR_DEEPSLEEP_DIS,
 				 BMP580_ODR_DEEPSLEEP_DIS |
 				 FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_SLEEP));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to change sensor to standby mode\n");
 		goto exit;
 	}
@@ -1497,18 +1493,18 @@ static int bmp580_nvmem_read(void *priv, unsigned int offset, void *val,
 
 		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
 				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev, "error writing nvm address\n");
 			goto exit;
 		}
 
 		ret = bmp580_nvm_operation(data, false);
-		if (ret)
+		if (ret < 0)
 			goto exit;
 
 		ret = regmap_bulk_read(data->regmap, BMP580_REG_NVM_DATA_LSB,
 				       &data->le16, sizeof(data->le16));
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev, "error reading nvm data regs\n");
 			goto exit;
 		}
@@ -1541,7 +1537,7 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 				 BMP580_MODE_MASK | BMP580_ODR_DEEPSLEEP_DIS,
 				 BMP580_ODR_DEEPSLEEP_DIS |
 				 FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_SLEEP));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to change sensor to standby mode\n");
 		goto exit;
 	}
@@ -1554,7 +1550,7 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 		ret = regmap_write(data->regmap, BMP580_REG_NVM_ADDR,
 				   BMP580_NVM_PROG_EN |
 				   FIELD_PREP(BMP580_NVM_ROW_ADDR_MASK, addr));
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev, "error writing nvm address\n");
 			goto exit;
 		}
@@ -1562,19 +1558,19 @@ static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
 
 		ret = regmap_bulk_write(data->regmap, BMP580_REG_NVM_DATA_LSB,
 					&data->le16, sizeof(data->le16));
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev, "error writing LSB NVM data regs\n");
 			goto exit;
 		}
 
 		ret = bmp580_nvm_operation(data, true);
-		if (ret)
+		if (ret < 0)
 			goto exit;
 
 		/* Disable programming mode bit */
 		ret = regmap_update_bits(data->regmap, BMP580_REG_NVM_ADDR,
 					 BMP580_NVM_PROG_EN, 0);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev, "error resetting nvm write\n");
 			goto exit;
 		}
@@ -1608,25 +1604,29 @@ static int bmp580_preinit(struct bmp280_data *data)
 
 	/* Issue soft-reset command */
 	ret = bmp580_soft_reset(data);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* Post powerup sequence */
 	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
-	if (ret)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to establish comms with the chip\n");
 		return ret;
+	}
 
 	/* Print warn message if we don't know the chip id */
 	if (reg != BMP580_CHIP_ID && reg != BMP580_CHIP_ID_ALT)
-		dev_warn(data->dev, "preinit: unexpected chip_id\n");
+		dev_warn(data->dev, "unexpected chip_id\n");
 
 	ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
-	if (ret)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read nvm status\n");
 		return ret;
+	}
 
 	/* Check nvm status */
 	if (!(reg & BMP580_STATUS_NVM_RDY_MASK) || (reg & BMP580_STATUS_NVM_ERR_MASK)) {
-		dev_err(data->dev, "preinit: nvm error on powerup sequence\n");
+		dev_err(data->dev, "nvm error on powerup sequence\n");
 		return -EIO;
 	}
 
@@ -1646,7 +1646,7 @@ static int bmp580_chip_config(struct bmp280_data *data)
 				 BMP580_MODE_MASK | BMP580_ODR_DEEPSLEEP_DIS,
 				 BMP580_ODR_DEEPSLEEP_DIS |
 				 FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_SLEEP));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to change sensor to standby mode\n");
 		return ret;
 	}
@@ -1661,6 +1661,10 @@ static int bmp580_chip_config(struct bmp280_data *data)
 				 BMP580_DSP_COMP_MASK |
 				 BMP580_DSP_SHDW_IIR_TEMP_EN |
 				 BMP580_DSP_SHDW_IIR_PRESS_EN, reg_val);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to change DSP mode settings\n");
+		return ret;
+	}
 
 	/* Configure oversampling */
 	reg_val = FIELD_PREP(BMP580_OSR_TEMP_MASK, data->oversampling_temp) |
@@ -1672,7 +1676,7 @@ static int bmp580_chip_config(struct bmp280_data *data)
 				       BMP580_OSR_PRESS_MASK |
 				       BMP580_OSR_PRESS_EN,
 				       reg_val, &aux);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to write oversampling register\n");
 		return ret;
 	}
@@ -1682,7 +1686,7 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	ret = regmap_update_bits_check(data->regmap, BMP580_REG_ODR_CONFIG, BMP580_ODR_MASK,
 				       FIELD_PREP(BMP580_ODR_MASK, data->sampling_freq),
 				       &aux);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to write ODR configuration register\n");
 		return ret;
 	}
@@ -1696,7 +1700,7 @@ static int bmp580_chip_config(struct bmp280_data *data)
 				       BMP580_DSP_IIR_PRESS_MASK |
 				       BMP580_DSP_IIR_TEMP_MASK,
 				       reg_val, &aux);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
@@ -1706,7 +1710,7 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
 				BMP580_MODE_MASK,
 				FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_NORMAL));
-	if (ret) {
+	if (ret < 0) {
 		dev_err(data->dev, "failed to set normal mode\n");
 		return ret;
 	}
@@ -1719,7 +1723,7 @@ static int bmp580_chip_config(struct bmp280_data *data)
 		 * operating in a degraded mode.
 		 */
 		ret = regmap_read(data->regmap, BMP580_REG_EFF_OSR, &tmp);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(data->dev,
 				"error reading effective OSR register\n");
 			return ret;
@@ -1782,8 +1786,10 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 		reinit_completion(&data->done);
 
 	ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
-	if (ret)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to write crtl_meas register\n");
 		return ret;
+	}
 
 	if (data->use_eoc) {
 		/*
@@ -1806,12 +1812,16 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 	}
 
 	ret = regmap_read(data->regmap, BMP280_REG_CTRL_MEAS, &ctrl);
-	if (ret)
+	if (ret < 0) {
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
@@ -1823,13 +1833,15 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 	ret = bmp180_wait_for_eoc(data,
 				  FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_TEMP) |
 				  BMP180_MEAS_SCO);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
 			       &data->be16, sizeof(data->be16));
-	if (ret)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
+	}
 
 	*val = be16_to_cpu(data->be16);
 
@@ -1844,9 +1856,10 @@ static int bmp180_read_calib(struct bmp280_data *data)
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START,
 			       data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf));
-
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read calibration parameters\n");
 		return ret;
+	}
 
 	/* None of the words has the value 0 or 0xFFFF */
 	for (i = 0; i < ARRAY_SIZE(data->bmp180_cal_buf); i++) {
@@ -1898,7 +1911,7 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
 	int ret;
 
 	ret = bmp180_read_adc_temp(data, &adc_temp);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	comp_temp = bmp180_compensate_temp(data, adc_temp);
@@ -1924,13 +1937,15 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 				  FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_PRESS) |
 				  FIELD_PREP(BMP180_OSRS_PRESS_MASK, oss) |
 				  BMP180_MEAS_SCO);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
 			       data->buf, sizeof(data->buf));
-	if (ret)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
+	}
 
 	*val = get_unaligned_be24(data->buf) >> (8 - oss);
 
@@ -1980,11 +1995,11 @@ static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
 	ret = bmp180_read_temp(data, NULL, NULL);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = bmp180_read_adc_press(data, &adc_press);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	comp_press = bmp180_compensate_press(data, adc_press);
@@ -2062,7 +2077,7 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 			irq_trig,
 			name,
 			data);
-	if (ret) {
+	if (ret < 0) {
 		/* Bail out without IRQ but keep the driver in place */
 		dev_err(dev, "unable to request DRDY IRQ\n");
 		return 0;
@@ -2132,20 +2147,20 @@ int bmp280_common_probe(struct device *dev,
 
 	ret = devm_regulator_bulk_get(dev,
 				      BMP280_NUM_SUPPLIES, data->supplies);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(dev, "failed to get regulators\n");
 		return ret;
 	}
 
 	ret = regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
-	if (ret) {
+	if (ret < 0) {
 		dev_err(dev, "failed to enable regulators\n");
 		return ret;
 	}
 
 	ret = devm_add_action_or_reset(dev, bmp280_regulators_disable,
 				       data->supplies);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* Wait to make sure we started up properly */
@@ -2162,8 +2177,10 @@ int bmp280_common_probe(struct device *dev,
 	data->regmap = regmap;
 
 	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read chip id\n");
 		return ret;
+	}
 
 	for (i = 0; i < data->chip_info->num_chip_id; i++) {
 		if (chip_id == data->chip_info->chip_id[i]) {
@@ -2177,7 +2194,7 @@ int bmp280_common_probe(struct device *dev,
 
 	if (data->chip_info->preinit) {
 		ret = data->chip_info->preinit(data);
-		if (ret)
+		if (ret < 0)
 			return dev_err_probe(data->dev, ret,
 					     "error running preinit tasks\n");
 	}
@@ -2208,7 +2225,7 @@ int bmp280_common_probe(struct device *dev,
 	 */
 	if (irq > 0 && (chip_id  == BMP180_CHIP_ID)) {
 		ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
-		if (ret)
+		if (ret < 0)
 			return ret;
 	}
 
@@ -2225,7 +2242,7 @@ int bmp280_common_probe(struct device *dev,
 	pm_runtime_put(dev);
 
 	ret = devm_add_action_or_reset(dev, bmp280_pm_disable, dev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
@@ -2247,7 +2264,7 @@ static int bmp280_runtime_resume(struct device *dev)
 	int ret;
 
 	ret = regulator_bulk_enable(BMP280_NUM_SUPPLIES, data->supplies);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	usleep_range(data->start_up_time, data->start_up_time + 100);
-- 
2.25.1


