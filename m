Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE1877AAC1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHMTEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHMTEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:04:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863A31707;
        Sun, 13 Aug 2023 12:04:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so32858445e9.3;
        Sun, 13 Aug 2023 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691953489; x=1692558289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT6KvO6AkG+6UUYiAgRCVtBsyH8WyFbCMZiWCINn7DE=;
        b=E6+akNCQTxQYkXQYuWbDEBrQbAOHKMdT4572BAhnUIHfO4GBE4qtnpCEXzvTrTGTsc
         wYfomeW6rdTeuzVCP4D5Z9yMgRtg0OH+G0mmS5AkZDJBb+jyoR9dIAiTS+OtggQmBO9y
         OnspnDdC5rNaxsa7OBZJcMVaMr4+Mv2ZSXmvNS1Q9FWb8CAAbaP1ZAG+0ZmHxjs7Og+d
         Q7w2il4caniXlHhgfrntbEnOGIi3dCWU+2MsmDtVh2aQ1a7IJ882PZvdQJjHEGaPnUWB
         G/3skx3sSorjyGWpge3hnPhOicA5a6eX9H95H6MdzGzP3I4aDGPUEBuTp5HDR2K4goEx
         70sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953489; x=1692558289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qT6KvO6AkG+6UUYiAgRCVtBsyH8WyFbCMZiWCINn7DE=;
        b=hltFgAdtgwDTdQ12RSc7Q968xaySx1uOxWctcxnQMWEhUuK54ypbBCvShSsXhw1/Jl
         iQm63S6mvBDTY7JuVe/bTmjNxGvQcJNr62LtxdEWrN0Ja3KQi/14pncLSFeuFaAPP4d3
         b//9ERvzxzTHRFNBjxf+yrZV4JEb2VfYThNHP8A//aCoyR6w+1UgEwH1la2UdAo4cQvr
         QD0OZJAlQ7QKsHAzXP9BhI9eDFKZK+SrswlB0pVjPQAZMsEzD/06RKZRGvYneEtRbsYB
         X3FHG1yY4sDcEFj3yA/BNGKAxQ4fsQwz8zIG0ArJLS5uZGnMwjUj+ATztnKW7hk54hbR
         wm+w==
X-Gm-Message-State: AOJu0YycOn7ZIzM6IXA8AYIf3SPhOa+gqf/kwce/wSAVxr4GOHcPfBHA
        +YN8D1bwZvjK0IXEknn20TWDkwERibU=
X-Google-Smtp-Source: AGHT+IH1k4jtcM6E8Pg42kqKa7x9Q0PedVf0YNMtW1XV/VkS3m9sp4jIpmwX5znViAg+uLzMQuEh5g==
X-Received: by 2002:a7b:ca52:0:b0:3fb:ab56:a66c with SMTP id m18-20020a7bca52000000b003fbab56a66cmr5700357wml.10.1691953488460;
        Sun, 13 Aug 2023 12:04:48 -0700 (PDT)
Received: from localhost.localdomain (35.red-83-35-63.dynamicip.rima-tde.net. [83.35.63.35])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4d42000000b00317ca89f6c5sm12111678wru.107.2023.08.13.12.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 12:04:48 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 1/3] iio: pressure: bmp280: i2c: Rearrange vars in reverse xmas tree order
Date:   Sun, 13 Aug 2023 21:03:54 +0200
Message-ID: <6a32c9c607b248abded7d3f843b000bfbd9a8a29.1691952005.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691952005.git.ang.iglesiasg@gmail.com>
References: <cover.1691952005.git.ang.iglesiasg@gmail.com>
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

Minor cleanup reordering local variable declarations following reverse
christmas tree convention.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6089f3f9d8f4..ea02a623bb58 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -766,8 +766,8 @@ static const struct iio_info bmp280_info = {
 
 static int bmp280_chip_config(struct bmp280_data *data)
 {
-	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
-		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
+	u8 osrs = FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1) |
+		  FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1);
 	int ret;
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index dbe630ad05b5..693eb1975fdc 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -7,9 +7,9 @@
 
 static int bmp280_i2c_probe(struct i2c_client *client)
 {
-	struct regmap *regmap;
-	const struct bmp280_chip_info *chip_info;
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct bmp280_chip_info *chip_info;
+	struct regmap *regmap;
 
 	chip_info = device_get_match_data(&client->dev);
 	if (!chip_info)
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 1dff9bb7c4e9..1c9c01f1b1c7 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -14,8 +14,7 @@
 static int bmp280_regmap_spi_write(void *context, const void *data,
                                    size_t count)
 {
-	struct device *dev = context;
-	struct spi_device *spi = to_spi_device(dev);
+	struct spi_device *spi = to_spi_device(context);
 	u8 buf[2];
 
 	memcpy(buf, data, 2);
@@ -31,8 +30,7 @@ static int bmp280_regmap_spi_write(void *context, const void *data,
 static int bmp280_regmap_spi_read(void *context, const void *reg,
                                   size_t reg_size, void *val, size_t val_size)
 {
-	struct device *dev = context;
-	struct spi_device *spi = to_spi_device(dev);
+	struct spi_device *spi = to_spi_device(context);
 
 	return spi_write_then_read(spi, reg, reg_size, val, val_size);
 }
-- 
2.41.0

