Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C67C99BD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjJOPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjJOPSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:18:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF1FB;
        Sun, 15 Oct 2023 08:18:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40776b200e5so16255555e9.2;
        Sun, 15 Oct 2023 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697383089; x=1697987889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMdJnM8oHQ7eHl+UF9y/ARFxYpaLioFllg8ThKJYIfg=;
        b=M+UtqsvAtnViL34/Rjoh/Riubp27o6OMLkaELkSqKabmDk9Hx6aytZdkFYZ3PsvhIg
         07Rwaa7mu5YW5gDPLiqrPUZlG1ukUVz4JyldU8WprJWVNRknYHDxzn4+9v6LI5k7XaKK
         sU6wLuc9aK6sENiCTdIEd1P+4bmSCOUoQDThmS0PnVq0W0rkQoFXVOqUKLp8Bt22QCOW
         3w4/dUJgizxT09s0HDUUOtN8VzUowkNDvzvbH0jmdEH+GFDO/9RJEl7X2T0W5tFN0Y3+
         IY6C7z/9yClKXyoFezHjbPqDVcnfsMqiQ4rrknNnWqAHT2YTcokQ9bXPZi/e7828oq+F
         TcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697383089; x=1697987889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMdJnM8oHQ7eHl+UF9y/ARFxYpaLioFllg8ThKJYIfg=;
        b=CTuaJA3Lao6Dk6fmeeoR4mS3pp+0bvl7Aysn64zOgl82bigFiFFZySiZQeb/0p2T94
         G4cueCf+T+jBm2l+tKRr0pdk3Oufl4d16mcuPQH2nwwDgueITvE34Xx7qh01ywLXJ0uz
         6cTmxq4F0amYPJM/i7glGY6wzCtTbobruLCveNoDfGctOXEhSl3sWl+xliHDe9azIbop
         j96YeeJq3yJ5dEkZkr64yYbrTNR3eMwFeYP7h0lIjnMD09yNZtO9QkYnJAswAgP4p95T
         JoX8eiZEx8UftagCfIPifpjG027TB/yZvxrihV5jXdVcmvfeD3WavMkFq5Hbtf0pydKd
         3SHA==
X-Gm-Message-State: AOJu0Yx4gMlPsKsoS/2qRBcOFM1NgTByt7JXJJEbUjm3KOGatfZZO1eG
        TwLmyORjTEAocIu5ycG5hjxRWa1r2Zk=
X-Google-Smtp-Source: AGHT+IEHmVYTABMP6Rxh9SuqXGxC1tzOfrC1ZjC7nUsGzMqE3KM8pSLzVxxYQow+zZinwWWmWuP8zg==
X-Received: by 2002:a05:600c:3586:b0:406:849c:52c3 with SMTP id p6-20020a05600c358600b00406849c52c3mr26286281wmq.22.1697383088044;
        Sun, 15 Oct 2023 08:18:08 -0700 (PDT)
Received: from localhost.localdomain (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003fc16ee2864sm4712455wms.48.2023.10.15.08.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 08:18:07 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 4/5] iio: pressure: bmp280: Allow multiple chips id per family of devices
Date:   Sun, 15 Oct 2023 17:16:26 +0200
Message-ID: <9f8489d82325b2dfb5c8c71c3d558d509b2b01bf.1697381932.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697381932.git.ang.iglesiasg@gmail.com>
References: <cover.1697381932.git.ang.iglesiasg@gmail.com>
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
index ea02a623bb58..e3bb4d7906a9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h> /* For irq_get_irq_data() */
 #include <linux/completion.h>
+#include <linux/overflow.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
 
@@ -794,10 +795,12 @@ static int bmp280_chip_config(struct bmp280_data *data)
 }
 
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
+static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
-	.chip_id = BMP280_CHIP_ID,
+	.chip_id = bmp280_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bmp280_chip_ids),
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
@@ -846,9 +849,12 @@ static int bme280_chip_config(struct bmp280_data *data)
 	return bmp280_chip_config(data);
 }
 
+static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
+
 const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
-	.chip_id = BME280_CHIP_ID,
+	.chip_id = bme280_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
@@ -1220,10 +1226,12 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
+static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
-	.chip_id = BMP380_CHIP_ID,
+	.chip_id = bmp380_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bmp380_chip_ids),
 	.regmap_config = &bmp380_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
@@ -1720,10 +1728,12 @@ static int bmp580_chip_config(struct bmp280_data *data)
 }
 
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
+static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
 
 const struct bmp280_chip_info bmp580_chip_info = {
 	.id_reg = BMP580_REG_CHIP_ID,
-	.chip_id = BMP580_CHIP_ID,
+	.chip_id = bmp580_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bmp580_chip_ids),
 	.regmap_config = &bmp580_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
@@ -1983,10 +1993,12 @@ static int bmp180_chip_config(struct bmp280_data *data)
 
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
+static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
 
 const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
-	.chip_id = BMP180_CHIP_ID,
+	.chip_id = bmp180_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bmp180_chip_ids),
 	.regmap_config = &bmp180_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
@@ -2077,6 +2089,7 @@ int bmp280_common_probe(struct device *dev,
 	struct bmp280_data *data;
 	struct gpio_desc *gpiod;
 	unsigned int chip_id;
+	unsigned int i;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -2142,10 +2155,30 @@ int bmp280_common_probe(struct device *dev,
 	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
 	if (ret < 0)
 		return ret;
-	if (chip_id != data->chip_info->chip_id) {
-		dev_err(dev, "bad chip id: expected %x got %x\n",
-			data->chip_info->chip_id, chip_id);
-		return -EINVAL;
+
+	for (i = 0; i < data->chip_info->num_chip_id; i++) {
+		if (chip_id == data->chip_info->chip_id[i])
+			break;
+	}
+
+	if (i == data->chip_info->num_chip_id) {
+		size_t nbuf;
+		char *buf;
+
+		// 0x<id>, so four chars per number plus one space + ENDL
+		if (check_mul_overflow(data->chip_info->num_chip_id, 5, &nbuf))
+			return ret;
+
+		buf = kmalloc_array(data->chip_info->num_chip_id, 5, GFP_KERNEL);
+		if (!buf)
+			return ret;
+
+		for (i = 0; i < data->chip_info->num_chip_id; i++)
+			snprintf(&buf[i*5], nbuf - i*5, "0x%x ", data->chip_info->chip_id[i]);
+
+		dev_err(dev, "bad chip id: expected one of [ %s ] got 0x%x\n", buf, chip_id);
+		kfree(buf);
+		return ret;
 	}
 
 	if (data->chip_info->preinit) {
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 5c0563ce7572..a230fcfc4a85 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -418,7 +418,8 @@ struct bmp280_data {
 
 struct bmp280_chip_info {
 	unsigned int id_reg;
-	const unsigned int chip_id;
+	const u8 *chip_id;
+	int num_chip_id;
 
 	const struct regmap_config *regmap_config;
 
-- 
2.42.0

