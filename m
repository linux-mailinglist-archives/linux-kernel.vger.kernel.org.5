Return-Path: <linux-kernel+bounces-26062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B0382DAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52ABA1F218B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4A617C7C;
	Mon, 15 Jan 2024 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DT6TcV7i"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA317BB6;
	Mon, 15 Jan 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e69b31365so23227425e9.0;
        Mon, 15 Jan 2024 05:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705326865; x=1705931665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5qolQ87aTSbCoc4qJCcoqJU8CDtjmKNVlB4VBqvWgA=;
        b=DT6TcV7iH8uvCeST+UMLxQDRDwdjUWeq6ISsRepq6x2Q0eTYX6T1fwqQO0PJhz/fie
         h0Bu8FL1vMS4TacE5IsPuf6BB4AQT5PGidj7bIFYuFWUNDEKrCWB4rmo1uwkxk4uAf5y
         ObHMAV531X0zC5aG6hzNhvNgmD453VSDOJfQ4NUv1I6s3UM1j1MhiHIlR3s8qKz8/sIQ
         fmb9hsm9lv/V4N5K+YWHbo6Mw3rLLLd1RCElt3gxlvsz02euCDxjHF443Z06IZiET9e6
         U8SO6o8w6SccpBlXOS8yynOu+WSinX1XO7+P3n3qbtItDbTQC42AUsDzqCYOybuNS6SA
         7z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705326865; x=1705931665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5qolQ87aTSbCoc4qJCcoqJU8CDtjmKNVlB4VBqvWgA=;
        b=TnERLo3QLFEBKT11t7RLpucqcw/2sDKtS0xCF3W8sPczXkoAk5xeeouPDUvgCD5Z/s
         AuTgET/HwOTPQXCzAH3GeGiIhGweGlZmEhcpW3TRDVr9Hk+QsdSRhuop+fOzfbySocJu
         ttemjt9M6A6N53E5oUAlT7XXScmsWw7ZQYpdpavOmWu2LyJlItdV2KFVwMrPlrCKdgmW
         HwDLKrBLlkfqp6ylkP3xff8Z95JJgV28Llt06+N9BoVLNrqyZihlgqLo1scfTeCLxASY
         CWtoJYyWMVbA3TVgzfpJoUWd8J38tvRgulieVY73gP64aF9vXiYoq3zSiSpBC9K69Bvv
         v6gg==
X-Gm-Message-State: AOJu0YyuyyO0kxQExs97SbYRvyjEecLkhib5D8lCc6+ejLhybscHVSys
	WlNLrb495OxOfefmbhCm23c=
X-Google-Smtp-Source: AGHT+IGeZDnOuwK+SStvqrIg42ObTkVHhbrxmW0PVEZfk89R09AB6yFKR65Z6iYr1104TSAosP1sdQ==
X-Received: by 2002:a05:600c:234a:b0:40d:9485:bafe with SMTP id 10-20020a05600c234a00b0040d9485bafemr2903809wmq.149.1705326864885;
        Mon, 15 Jan 2024 05:54:24 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b0040e6efeac9esm7979651wmo.48.2024.01.15.05.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 05:54:24 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH 2/2] iio: adc: ad7173: add support for additional models
Date: Mon, 15 Jan 2024 15:53:05 +0200
Message-ID: <20240115135416.10595-3-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240115135416.10595-1-mitrutzceclan@gmail.com>
References: <20240115135416.10595-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Analog Devices AD7172-2, AD7175-8, AD7177-2

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/adc/ad7173.c | 76 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 7a7e8262f189..8ca9871cc9cb 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
+ * AD717X family SPI ADC driver
+ *
+ * Suported devices:
+ *  AD7172-2 AD7172-4 AD7173-8 AD7175-2 AD7175-8 AD7176-2 AD7177-2
+ *
  * Copyright (C) 2015, 2023 Analog Devices, Inc.
  */
 
@@ -59,10 +63,13 @@
 #define AD7173_AIN_TEMP_POS	17
 #define AD7173_AIN_TEMP_NEG	18
 
-#define AD7172_ID			0x00d0
+#define AD7172_2_ID			0x00d0
+#define AD7172_4_ID			0x2050
 #define AD7173_ID			0x30d0
-#define AD7175_ID			0x0cd0
+#define AD7175_2_ID			0x0cd0
+#define AD7175_8_ID			0x3cd0
 #define AD7176_ID			0x0c90
+#define AD7177_ID			0x4fd0
 #define AD7173_ID_MASK			GENMASK(15, 4)
 
 #define AD7173_ADC_MODE_REF_EN		BIT(15)
@@ -104,15 +111,19 @@
 #define AD7173_SETUP_REF_SEL_EXT_REF	0x0
 #define AD7173_VOLTAGE_INT_REF_uV	2500000
 #define AD7173_TEMP_SENSIIVITY_uV_per_C	477
+#define AD7177_ODR_START_VALUE		0x07
 
 #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
 #define AD7173_MAX_CONFIGS		8
 
 enum ad7173_ids {
 	ID_AD7172_2,
+	ID_AD7172_4,
 	ID_AD7173_8,
 	ID_AD7175_2,
+	ID_AD7175_8,
 	ID_AD7176_2,
+	ID_AD7177_2,
 };
 
 struct ad7173_device_info {
@@ -182,7 +193,7 @@ static const unsigned int ad7175_sinc5_data_rates[] = {
 static const struct ad7173_device_info ad7173_device_info[] = {
 	[ID_AD7172_2] = {
 		.name = "ad7172-2",
-		.id = AD7172_ID,
+		.id = AD7172_2_ID,
 		.num_inputs = 5,
 		.num_channels = 4,
 		.num_configs = 4,
@@ -192,6 +203,17 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
 	},
+	[ID_AD7172_4] = {
+		.id = AD7172_4_ID,
+		.num_inputs = 9,
+		.num_channels = 8,
+		.num_configs = 8,
+		.num_gpios = 4,
+		.has_temp = false,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
 	[ID_AD7173_8] = {
 		.name = "ad7173-8",
 		.id = AD7173_ID,
@@ -206,7 +228,7 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 	},
 	[ID_AD7175_2] = {
 		.name = "ad7175-2",
-		.id = AD7175_ID,
+		.id = AD7175_2_ID,
 		.num_inputs = 5,
 		.num_channels = 4,
 		.num_configs = 4,
@@ -216,6 +238,17 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
+	[ID_AD7175_8] = {
+		.id = AD7175_8_ID,
+		.num_inputs = 17,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_gpios = 4,
+		.has_temp = true,
+		.clock = 16 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7175_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+	},
 	[ID_AD7176_2] = {
 		.name = "ad7176-2",
 		.id = AD7176_ID,
@@ -228,6 +261,17 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
+	[ID_AD7177_2] = {
+		.id = AD7177_ID,
+		.num_inputs = 5,
+		.num_channels = 4,
+		.num_configs = 4,
+		.num_gpios = 2,
+		.has_temp = true,
+		.clock = 16 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7175_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+	},
 };
 
 static const char *const ad7173_ref_sel_str[] = {
@@ -636,7 +680,10 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		freq = val * MILLI + val2 / MILLI;
-		for (i = 0; i < st->info->num_sinc5_data_rates - 1; i++)
+		//AD7177-2 has the filter values [0-6] marked as reserved
+		// datasheet page 58
+		i = (st->info->id == AD7177_ID) ? AD7177_ODR_START_VALUE : 0;
+		for (; i < st->info->num_sinc5_data_rates - 1; i++)
 			if (freq >= st->info->sinc5_data_rates[i])
 				break;
 
@@ -844,8 +891,14 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		else
 			ref_sel = ret;
 
+		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF &&
+		    st->info->id == AD7172_2_ID){
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, -EINVAL, "Internal reference is not available on ad7172-2\n");
+		}
+
 		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 &&
-		    st->info->id != AD7173_ID) {
+		    st->info->id != AD7173_ID && st->info->id != AD7172_2_ID) {
 			fwnode_handle_put(child);
 			return dev_err_probe(dev, -EINVAL, "External reference 2 is only available on ad7173-8\n");
 		}
@@ -939,21 +992,30 @@ static int ad7173_probe(struct spi_device *spi)
 static const struct of_device_id ad7173_of_match[] = {
 	{ .compatible = "adi,ad7172-2",
 	  .data = &ad7173_device_info[ID_AD7172_2]},
+	{ .compatible = "adi,ad7172-4",
+	  .data = &ad7173_device_info[ID_AD7172_4]},
 	{ .compatible = "adi,ad7173-8",
 	  .data = &ad7173_device_info[ID_AD7173_8]},
 	{ .compatible = "adi,ad7175-2",
 	  .data = &ad7173_device_info[ID_AD7175_2]},
+	{ .compatible = "adi,ad7175-8",
+	  .data = &ad7173_device_info[ID_AD7175_8]},
 	{ .compatible = "adi,ad7176-2",
 	  .data = &ad7173_device_info[ID_AD7176_2]},
+	{ .compatible = "adi,ad7177-2",
+	  .data = &ad7173_device_info[ID_AD7177_2]},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7173_of_match);
 
 static const struct spi_device_id ad7173_id_table[] = {
 	{ "ad7172-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_2]},
+	{ "ad7172-4", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_4] },
 	{ "ad7173-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7173_8]},
 	{ "ad7175-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_2]},
+	{ "ad7175-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_8]},
 	{ "ad7176-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7176_2]},
+	{ "ad7177-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7177_2]},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7173_id_table);
-- 
2.42.0


