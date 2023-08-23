Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7BB785CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbjHWP7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbjHWP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:59:00 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77193E7B;
        Wed, 23 Aug 2023 08:58:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so7182695e9.3;
        Wed, 23 Aug 2023 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692806335; x=1693411135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKUVthr6t5bmWGdyIQiDlm1KkqWyaS0Rldoy3Q9+o54=;
        b=l7C03TEoGxnD0VjymYuY7aMYiCLzSvNfIDcsiS8MpyB2/d3kedhiHsbNmp+eT3O1jz
         aZrFlUMUn+fw78BvF7Jfco7kTLmxShGys4HUG35uiWPRiUVy4CBjtPQXI7d/kHg6+Gb+
         nLA9QxTnqjmdNs0+9YkLciQknTtOFJwEOB/PxNRcqLVNXI4uAM71od3T/TughtZ026wn
         wLPR4y3stynXoEjOom9l6wy6fJl/oLWlUDWSXEjCeFMsg6Q+Bww5ZBOCZbfvqktw736g
         Zya7FhVvwYupa3QsAQUL4daG89r7JKzH9lPYhMmGnNvrIgySwtf5gXTaE0IkoHN8jZT6
         kJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692806335; x=1693411135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKUVthr6t5bmWGdyIQiDlm1KkqWyaS0Rldoy3Q9+o54=;
        b=PIsqgs9+Be91Rs8yoBQbjAihGw25F6dNXz0GRHvNBXYxm39JZiUrH8YRKdPeYaY3U4
         N+/u6vTUa9X/gDVxh2+5ne+vTjF0YMJHtLQoQHdYjokRb3sZY6I3tmHi2tfh+ZEJluJE
         VQ2HMpsMeYztwUW2k0m5AmOSP9VJI9n9WNo8zxXe0MVb8MiwWDeYjEBd0RlyXExWSDis
         azYq2XTsdQD8vYhM2/RctibHvoK/sxQ4xwCfB8RyjN2FmmPxs4x3fOkHNZhdlZ7ITrbU
         ADlerBMvdNY1WX6HeiOisP23SyrhzSxiOOW6Y1/gvAvzcN6X58ZOZAe8Q9jYDInIOcfh
         t7TQ==
X-Gm-Message-State: AOJu0YyFgK5cQjLnENL9nqJJqhYJy2Yuj02U3/jJ2GJEOp5xsl81tUi6
        HdlKTuyd7+BMKsVrJF0A7J33cuN4aq0=
X-Google-Smtp-Source: AGHT+IFXMTP4E2+qXRT8jTrU+745y0DWfAbqvC1SfwZn2qNCyfR/9vbAYlW9Bj6fKB6lbqy7Kcxu9A==
X-Received: by 2002:a05:600c:255:b0:3fa:97ad:2ba5 with SMTP id 21-20020a05600c025500b003fa97ad2ba5mr9632016wmj.31.1692806335466;
        Wed, 23 Aug 2023 08:58:55 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b003fe195cecb3sm17044613wmj.38.2023.08.23.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:58:55 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] iio: pressure: bmp280: Allow multiple chips id per family of devices
Date:   Wed, 23 Aug 2023 17:58:06 +0200
Message-ID: <7bdfbfeb106acc5560e6cb090131f105b2d2e418.1692805377.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1692805377.git.ang.iglesiasg@gmail.com>
References: <cover.1692805377.git.ang.iglesiasg@gmail.com>
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
index 6089f3f9d8f4..4a544a20d6cb 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -40,6 +40,7 @@
 #include <linux/completion.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <linux/overflow.h>
 
 #include <asm/unaligned.h>
 
@@ -794,10 +795,12 @@ static int bmp280_chip_config(struct bmp280_data *data)
 }
 
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
+static const uint8_t bmp280_chip_ids[] = { BMP280_CHIP_ID };
 
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
 
+static const uint8_t bme280_chip_ids[] = { BME280_CHIP_ID };
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
+static const uint8_t bmp380_chip_ids[] = { BMP380_CHIP_ID };
 
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
+static const uint8_t bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
 
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
+static const uint8_t bmp180_chip_ids[] = { BMP180_CHIP_ID };
 
 const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
-	.chip_id = BMP180_CHIP_ID,
+	.chip_id = bmp180_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bmp180_chip_ids),
 	.regmap_config = &bmp180_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
@@ -2077,7 +2089,7 @@ int bmp280_common_probe(struct device *dev,
 	struct bmp280_data *data;
 	struct gpio_desc *gpiod;
 	unsigned int chip_id;
-	int ret;
+	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -2142,10 +2154,31 @@ int bmp280_common_probe(struct device *dev,
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
+		if (check_mul_overflow(5, data->chip_info->num_chip_id, &nbuf))
+			return ret;
+
+		buf = kmalloc_array(nbuf, sizeof(char), GFP_KERNEL);
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
index ff72e82f55ad..c2acc9315223 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -418,7 +418,8 @@ struct bmp280_data {
 
 struct bmp280_chip_info {
 	unsigned int id_reg;
-	uint8_t chip_id;
+	const uint8_t *chip_id;
+	int num_chip_id;
 
 	const struct regmap_config *regmap_config;
 
-- 
2.42.0

