Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7B77D24E6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjJVRXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjJVRXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:23:32 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AA610CA;
        Sun, 22 Oct 2023 10:23:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so1748917f8f.2;
        Sun, 22 Oct 2023 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697995405; x=1698600205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZN0QEHYImLyvL58njc7Kf8hTMwYcRL9gq6A20t3tjE=;
        b=YENEl/s655Ztj0EBJZ3jAFoogomsQFsWkUf6Gn0H+1p1mhNlJupt38lb11hTo345vY
         LY1fJGtoDZt1TtPhARNYVVtBwMr7blcp6vHpxHfUge+nDmyn+M/p91XVG/D6Zt5faF0o
         QjjzyG/hPwdxbwj7IKrWK0vVLH1oXFKcW85JX7aBldLELLoF9KZ4Vqg2untog7YW4b6+
         KLdnqSAhjsFfTpuvhl/H4B0CfEpVb+nfiCLGrflc28QsaaaYMsIqjQWvlAiS7iW1OPB0
         tkyG4Z+M70V0hQ8MGPhPKog6ZY/nohDf8FtFR1hGYcwl50PhiUEQxCe7upbEkJ0mDD33
         e0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697995405; x=1698600205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZN0QEHYImLyvL58njc7Kf8hTMwYcRL9gq6A20t3tjE=;
        b=VDeZXCzW5+R4JNFtBack78GhPkzyuOgHVlFEy1EfT91UMnuM369Kg+MV8SFYWoDwUx
         fU7f6xlQOm0Kuh61+oT6tPOqBDe5Y966A57VtDueu+4MZ6QyfapPyE5JXxfVgPmI6KMc
         sNgW4NYH6lEZL1cy5lBVYF22Z0oOQXkzh5KW1PyxBtt1uQgDnhTBG5Ocyh6O2iFyfU1G
         TSjqO2JLqDjrgGR8MYaqc/6rEklvvaLoqnXoueawstFVFfu4719USCHv8PwoOSO41udE
         XCL5KvQNWG79ybdZuKcxjufdXm33EmVa2QwlQJfTjPp1UF2DoOxuOfUXTv45K36IyVDj
         pESQ==
X-Gm-Message-State: AOJu0Yx1AED91wckYKXd0rEiOeoEOqXKqcC0sa++eGEHK656ety90TRN
        HkfbeHZ2nw2D78/NpxKIMjdRm7dExis=
X-Google-Smtp-Source: AGHT+IHkDQ3bfQ7zHywkp5cjIG7DAoLYtCbQ7ZDHm4uyd8SghYZB3tP5E6VnYps1Ycf13sswMRHnLQ==
X-Received: by 2002:adf:ef4e:0:b0:324:8502:6355 with SMTP id c14-20020adfef4e000000b0032485026355mr4475390wrp.46.1697995405412;
        Sun, 22 Oct 2023 10:23:25 -0700 (PDT)
Received: from toolbox.taileb357.ts.net (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b0032da49e18fasm6043836wrm.23.2023.10.22.10.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 10:23:25 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 4/5] iio: pressure: bmp280: Allow multiple chips id per family of devices
Date:   Sun, 22 Oct 2023 19:22:20 +0200
Message-ID: <eade22d11e9de4405ea19fdaa5a8249143ae94df.1697994521.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697994521.git.ang.iglesiasg@gmail.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
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
When no known ids match, gives a warning but follows along what device
said on the firmware and tries to configure it.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index a2ef1373a274..deb336781b26 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -794,10 +794,12 @@ static int bmp280_chip_config(struct bmp280_data *data)
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
@@ -846,9 +848,12 @@ static int bme280_chip_config(struct bmp280_data *data)
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
@@ -1220,10 +1225,12 @@ static int bmp380_chip_config(struct bmp280_data *data)
 
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
@@ -1720,10 +1727,12 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
@@ -1983,10 +1992,12 @@ static int bmp180_chip_config(struct bmp280_data *data)
 
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
@@ -2077,6 +2088,7 @@ int bmp280_common_probe(struct device *dev,
 	struct bmp280_data *data;
 	struct gpio_desc *gpiod;
 	unsigned int chip_id;
+	unsigned int i;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -2142,12 +2154,19 @@ int bmp280_common_probe(struct device *dev,
 	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
 	if (ret < 0)
 		return ret;
-	if (chip_id != data->chip_info->chip_id) {
-		dev_err(dev, "bad chip id: expected %x got %x\n",
-			data->chip_info->chip_id, chip_id);
-		return -EINVAL;
+
+	for (i = 0; i < data->chip_info->num_chip_id; i++) {
+		if (chip_id == data->chip_info->chip_id[i]) {
+			dev_info(dev, "0x%x is a known chip id for %s\n", chip_id, name);
+			break;
+		}
+		dev_warn(dev, "chip id 0x%x does not match known id 0x%x\n",
+			 chip_id, data->chip_info->chip_id[i]);
 	}
 
+	if (i == data->chip_info->num_chip_id)
+		dev_warn(dev, "bad chip id: 0x%x is not a known chip id\n", chip_id);
+
 	if (data->chip_info->preinit) {
 		ret = data->chip_info->preinit(data);
 		if (ret)
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

