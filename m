Return-Path: <linux-kernel+bounces-93838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B7887356A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DF7282FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABDC763E2;
	Wed,  6 Mar 2024 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP02xCKJ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221077F0C;
	Wed,  6 Mar 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723412; cv=none; b=dXDWj2m0CcQUZ44WuBTlwYaT2IlHVesrYxqfcllARDpjYaucIIRULhRgB2mfA8u5eoFUnA8no9vAqWwYGd1/H5U+090NRL3wGI22RimdsJtDRoDZnqz7EhYtO07jXaNukzNEQc1GmVMl48gSJwu9CPL8RkcOmOWcIEWIhqs2XG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723412; c=relaxed/simple;
	bh=cCljXfvf3Tdn5wKRRFO8tRDaXWfnHvEUlHofxOvby9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpzfAhcTWJqze2KgjAvPl8ik2UcvUqWt3tu0oZj1OOhzlKS8Ix+fTZPHs2L0ytg1b8orx1R0WSSXym83n8zWNKFL0jZHe0Dp4kIdoBkgbs1/mXcTSjTp40F9tjrZdzGfuaw4FjtpqB9oZrm4ENC11FKdL5zMCsObS7aMGhAhqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP02xCKJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so8149784a12.0;
        Wed, 06 Mar 2024 03:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709723409; x=1710328209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPlp539apzBwv/z9/cqIkBur4tCSM/L0oQF3M/Z4Wao=;
        b=TP02xCKJxwpO8GF5gAlcFDKM97BhfTG6eaIZCPRnQAhIGpqxqVQ+JbxcS3Ub+Ahfe6
         RZDlyLcfqoif32jpl1j+8dl73Nv3zxfDavg6VGhZGiku4xTgT7xluzhTuHDLRVkNxcll
         WN1pzd61y9YpeXephuKdq+2d2zNIT34wdcycDkvHVuZidVtbsgJZ8jE/N+xT9ZKOmZuR
         apMm0eDK7s9EixzMDZZQuwRR69lKWJGzfShQZIYICKoKzhTzBiq7yDMZihKdUNcSreNw
         ZojHYoPYGaBQgSJD6UcyZl7tTVN1XIhEvNsXu3fsECSU/U8xBLyHLCsWRDGix6qz2/rg
         NLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709723409; x=1710328209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPlp539apzBwv/z9/cqIkBur4tCSM/L0oQF3M/Z4Wao=;
        b=gmRNoPPOzJmwv0DJEg5+B7TMpcxcDYnwqS6DXqENhsMXOy41pkL4pYz6+m4twQORKp
         2Zn0/nltgBfze+5yU5SC/HH3sh/JmHYP7aeaG7nR6vAsrvefFHVlFh3oAwuHQ20aw+UP
         Xu4AW0jZiikNVWHbndH/5x0njaOdgfwHxbzqJtk7oiNne018JVT2x6WfL7FcsqciPapN
         /sZzstIOBiD7HF6gj+Zzy/4v+rpGxSxNtwLDzBw+LF+TLZMi++7sET39+h0MlvPMd7W1
         T2YbW7WWBrZe31YbgWsfISaI7VGNd9TLsEVzrBxG+onJePUwNt6ww0XM4TwNfU9/ZZPE
         BMDg==
X-Forwarded-Encrypted: i=1; AJvYcCU39mpoHGD7QAjEp6SkFZenLL8DMdfje75Rpqra4YKsHVTESyFDpXU4XcEGURow3hYOngiYeJWzTmNiDHw8LeZxTp/NDgk/i0Eg7DOU4Zxpn3Z8tRG0hqYhOMUN1hHN/7ZczotDfcN/1Q==
X-Gm-Message-State: AOJu0YzCUxqMk5yP5HFSbnFTxMMrHO9tw+610awo/sivqsoT0xYXRmuM
	CQSl/56FkJvUgx+hO12p+srvZyCdydiUWJsh0m/oo1fhrMsAMZmT
X-Google-Smtp-Source: AGHT+IElREPzfpIZiN1vyOE8TzvRAcWep8+DsUTlaRrN1rmKMsoVbP722wdkgBqxrEC9Zjt8XvjuvQ==
X-Received: by 2002:a17:906:1114:b0:a43:bb3b:3b5a with SMTP id h20-20020a170906111400b00a43bb3b3b5amr10462038eja.22.1709723408926;
        Wed, 06 Mar 2024 03:10:08 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id w26-20020a170906385a00b00a4394f052cesm7002479ejc.150.2024.03.06.03.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 03:10:08 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: dumitru.ceclan@analog.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v3 3/3] iio: adc: ad7173: add support for additional models
Date: Wed,  6 Mar 2024 13:09:56 +0200
Message-ID: <20240306110956.13167-4-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306110956.13167-1-mitrutzceclan@gmail.com>
References: <20240306110956.13167-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Analog Devices AD7172-2, AD7175-8, AD7177-2.

Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 drivers/iio/adc/ad7173.c | 86 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 59a55d2944a7..4ff6ce46b02c 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1,6 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
+ * AD717x family SPI ADC driver
+ *
+ * Supported devices:
+ *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
+ *  AD7175-8/AD7176-2/AD7177-2
+ *
  * Copyright (C) 2015, 2024 Analog Devices, Inc.
  */
 
@@ -64,7 +69,11 @@
 #define AD7172_2_ID			0x00d0
 #define AD7175_ID			0x0cd0
 #define AD7176_ID			0x0c90
+#define AD7175_2_ID			0x0cd0
+#define AD7172_4_ID			0x2050
 #define AD7173_ID			0x30d0
+#define AD7175_8_ID			0x3cd0
+#define AD7177_ID			0x4fd0
 #define AD7173_ID_MASK			GENMASK(15, 4)
 
 #define AD7173_ADC_MODE_REF_EN		BIT(15)
@@ -110,20 +119,25 @@
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
 	const unsigned int *sinc5_data_rates;
 	unsigned int num_sinc5_data_rates;
+	unsigned int odr_start_value;
 	unsigned int num_channels;
 	unsigned int num_configs;
 	unsigned int num_inputs;
@@ -131,6 +145,8 @@ struct ad7173_device_info {
 	unsigned int id;
 	char *name;
 	bool has_temp;
+	bool has_int_ref;
+	bool has_ref2;
 	u8 num_gpios;
 };
 
@@ -196,6 +212,19 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_configs = 4,
 		.num_gpios = 2,
 		.has_temp = true,
+		.has_int_ref = true,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
+	[ID_AD7172_4] = {
+		.id = AD7172_4_ID,
+		.num_inputs = 9,
+		.num_channels = 8,
+		.num_configs = 8,
+		.num_gpios = 4,
+		.has_temp = false,
+		.has_ref2 = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
@@ -208,18 +237,34 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_configs = 8,
 		.num_gpios = 4,
 		.has_temp = true,
+		.has_int_ref = true,
+		.has_ref2 = true,
 		.clock = 2 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7173_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
 	},
 	[ID_AD7175_2] = {
 		.name = "ad7175-2",
-		.id = AD7175_ID,
+		.id = AD7175_2_ID,
 		.num_inputs = 5,
 		.num_channels = 4,
 		.num_configs = 4,
 		.num_gpios = 2,
 		.has_temp = true,
+		.has_int_ref = true,
+		.clock = 16 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7175_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+	},
+	[ID_AD7175_8] = {
+		.id = AD7175_8_ID,
+		.num_inputs = 17,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_gpios = 4,
+		.has_temp = true,
+		.has_int_ref = true,
+		.has_ref2 = true,
 		.clock = 16 * HZ_PER_MHZ,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
@@ -232,7 +277,21 @@ static const struct ad7173_device_info ad7173_device_info[] = {
 		.num_configs = 4,
 		.num_gpios = 2,
 		.has_temp = false,
+		.has_int_ref = true,
+		.clock = 16 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7175_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+	},
+	[ID_AD7177_2] = {
+		.id = AD7177_ID,
+		.num_inputs = 5,
+		.num_channels = 4,
+		.num_configs = 4,
+		.num_gpios = 2,
+		.has_temp = true,
+		.has_int_ref = true,
 		.clock = 16 * HZ_PER_MHZ,
+		.odr_start_value = AD7177_ODR_START_VALUE,
 		.sinc5_data_rates = ad7175_sinc5_data_rates,
 		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
 	},
@@ -656,7 +715,7 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		freq = val * MILLI + val2 / MILLI;
-		for (i = 0; i < st->info->num_sinc5_data_rates - 1; i++)
+		for (i = st->info->odr_start_value; i < st->info->num_sinc5_data_rates - 1; i++)
 			if (freq >= st->info->sinc5_data_rates[i])
 				break;
 
@@ -908,11 +967,17 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		else
 			ref_sel = ret;
 
-		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 &&
-		    st->info->id != AD7173_ID) {
+		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF &&
+		    !st->info->has_int_ref) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, -EINVAL,
+				"Internal reference is not available on current model.\n");
+		}
+
+		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 && !st->info->has_ref2) {
 			fwnode_handle_put(child);
 			return dev_err_probe(dev, -EINVAL,
-				"External reference 2 is only available on ad7173-8\n");
+				"External reference 2 is not available on current model.\n");
 		}
 
 		ret = ad7173_get_ref_voltage_milli(st, ref_sel);
@@ -1080,21 +1145,30 @@ static int ad7173_probe(struct spi_device *spi)
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
+	{ "ad7172-4", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_4]},
 	{ "ad7173-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7173_8]},
 	{ "ad7175-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_2]},
+	{ "ad7175-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_8]},
 	{ "ad7176-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7176_2]},
+	{ "ad7177-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7177_2]},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7173_id_table);
-- 
2.43.0


