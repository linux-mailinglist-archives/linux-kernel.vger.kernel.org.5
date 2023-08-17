Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A408777FF82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355167AbjHQVHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355183AbjHQVGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:06:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F8C3592;
        Thu, 17 Aug 2023 14:06:36 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso2805625e9.1;
        Thu, 17 Aug 2023 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692306394; x=1692911194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8D65RO4TicM3yySoHyKlC8kqpobwM0KQee+7dlD+z/E=;
        b=ONUt3wfirs3OEDp5fqvZ9JgpziHlwpHKH0NWRvxdUwK/1oV4NMq4bn3PRXic3wY0i5
         zNS59hW3vAJu9eS+PJt6LCkK1FDSdwWt8sMcnLkVoPHloEqi6r2xM4KhMwt5mQbJOXmd
         RUgASKqhtFtaG/Fmq1Y0+WBhHaJyzrNbmDLoscNJjO4OFMcGgRM0gqY9umpeVsrAZoCM
         izU72F2BHlUoqLmUxiJtsPOXYNcANCBFLoMFU5mIWzCwI43NO4uPZUal16TqKRpWLD8e
         kluD+t4W9gFKcQzeK7Km3+SKm8JPYGHhVL5EhyiOuoEfEceaWdAVtWU2XrHYvty3eCZ1
         kIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306394; x=1692911194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8D65RO4TicM3yySoHyKlC8kqpobwM0KQee+7dlD+z/E=;
        b=NTJcJ3CRAqGPwV/qONlhPH43g0tdbzIKiSD5CED87YY5Gc4hjlnlijP6mqrBf9ierA
         MmpwqfUZwGUmUbPtUzuvj1eodCvanwdjOp9y3OiwOixNV8+cxLv05IiodzVKYZNHu11v
         Br+818GUYeoqxFbkLifplEKhidxYeHa3kstFfixvwozU1vtIqtSMMkqfA4xsYCw9iRIN
         7ptlchbBM3PsMqnl8LvyTPCVZnQTj3bNKxRxRhv1dIBft6+MUlU5SKej+zjrAVB3x0R5
         iPLRxr4NaPipMO0k28oHKWoLgyGYmtL26lX82ptqTjHr8pSoa6Q7dvl9PMu3ugOF9M+t
         2aug==
X-Gm-Message-State: AOJu0YxtwMRtzPjVU/Bvx2JZZH9QOsby5+0oJ1E6Pz1Bd2LcfKB+Vf4i
        KT4wwTvwdfXhGrZjvI5lepEi7fOHQtk=
X-Google-Smtp-Source: AGHT+IESr0C+aCLYifZsULxC6svhkOrCO1IO76ruULU1GXq3xPUzIvcMB4z3GHb5B1XaRDG7joDNMQ==
X-Received: by 2002:a05:600c:b58:b0:3fb:403d:90c5 with SMTP id k24-20020a05600c0b5800b003fb403d90c5mr629356wmr.39.1692306394431;
        Thu, 17 Aug 2023 14:06:34 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600c11cf00b003fe215e4492sm669727wmi.4.2023.08.17.14.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:06:34 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] iio: pressure: bmp280: Allow multiple chips id per family of devices
Date:   Thu, 17 Aug 2023 23:05:21 +0200
Message-ID: <8856287079b5dc1099f5b98a0168f008fbb8debd.1692305434.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692305434.git.ang.iglesiasg@gmail.com>
References: <cover.1692305434.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve device detection in certain chip families known to have various
chip ids.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6089f3f9d8f4..67941a67e513 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -794,10 +794,12 @@ static int bmp280_chip_config(struct bmp280_data *data)
 }
 
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
+static const int bmp280_chip_ids[] = { BMP280_CHIP_ID };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
-	.chip_id = BMP280_CHIP_ID,
+	.chip_id = bmp280_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bmp280_chip_ids),
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
@@ -846,9 +848,12 @@ static int bme280_chip_config(struct bmp280_data *data)
 	return bmp280_chip_config(data);
 }
 
+static const int bme280_chip_ids[] = { BME280_CHIP_ID };
+
 const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
-	.chip_id = BME280_CHIP_ID,
+	.chip_id = bme280_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
@@ -1220,10 +1225,12 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
+static const int bmp380_chip_ids[] = { BMP380_CHIP_ID };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
-	.chip_id = BMP380_CHIP_ID,
+	.chip_id = bmp380_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bmp380_chip_ids),
 	.regmap_config = &bmp380_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
@@ -1720,10 +1727,12 @@ static int bmp580_chip_config(struct bmp280_data *data)
 }
 
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
+static const int bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
 
 const struct bmp280_chip_info bmp580_chip_info = {
 	.id_reg = BMP580_REG_CHIP_ID,
-	.chip_id = BMP580_CHIP_ID,
+	.chip_id = bmp580_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bmp580_chip_ids),
 	.regmap_config = &bmp580_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
@@ -1983,10 +1992,12 @@ static int bmp180_chip_config(struct bmp280_data *data)
 
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
+static const int bmp180_chip_ids[] = { BMP180_CHIP_ID };
 
 const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
-	.chip_id = BMP180_CHIP_ID,
+	.chip_id = bmp180_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bmp180_chip_ids),
 	.regmap_config = &bmp180_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
@@ -2077,7 +2088,7 @@ int bmp280_common_probe(struct device *dev,
 	struct bmp280_data *data;
 	struct gpio_desc *gpiod;
 	unsigned int chip_id;
-	int ret;
+	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -2142,10 +2153,30 @@ int bmp280_common_probe(struct device *dev,
 	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
 	if (ret < 0)
 		return ret;
-	if (chip_id != data->chip_info->chip_id) {
-		dev_err(dev, "bad chip id: expected %x got %x\n",
-			data->chip_info->chip_id, chip_id);
-		return -EINVAL;
+
+	ret = -EINVAL;
+	for (i = 0; i < data->chip_info->num_chip_id; i++) {
+		if (chip_id == data->chip_info->chip_id[i]) {
+			ret = 0;
+			break;
+		}
+	}
+
+	if (ret) {
+		// 0x<id>, so four chars per number plus one space + ENDL
+		size_t nbuf = 5*data->chip_info->num_chip_id*sizeof(char);
+		char *buf = kmalloc(nbuf, GFP_KERNEL);
+
+		if (!buf)
+			return ret;
+
+		for (i = 0; i < data->chip_info->num_chip_id; i++)
+			snprintf(&buf[i*5], nbuf, "0x%x ", data->chip_info->chip_id[i]);
+		buf[nbuf-1] = '\0';
+
+		dev_err(dev, "bad chip id: expected [ %s ] got 0x%x\n", buf, chip_id);
+		kfree(buf);
+		return ret;
 	}
 
 	if (data->chip_info->preinit) {
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 5c0563ce7572..d68745254340 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -418,7 +418,8 @@ struct bmp280_data {
 
 struct bmp280_chip_info {
 	unsigned int id_reg;
-	const unsigned int chip_id;
+	const unsigned int *chip_id;
+	int num_chip_id;
 
 	const struct regmap_config *regmap_config;
 
-- 
2.41.0

