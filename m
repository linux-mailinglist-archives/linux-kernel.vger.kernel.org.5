Return-Path: <linux-kernel+bounces-165401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2943D8B8C4E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928AE1F21357
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2E1304BA;
	Wed,  1 May 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Je228iL"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3812FF7C
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575359; cv=none; b=LsbrpeAdXEv+gkKhKARHTZlRzOrrjw5GGccIyIZvFwLnr4/1Ro1GtNoM4DFb5MGJir2LaTTCst8WqUnyViPiW7meqcctUny07EmBGvGBIrKUfKsUJlRw3Poxbb4yU3y4HI11rqPiZDvhH86nUde5IsapLPqpMa4qUBEjSA0vQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575359; c=relaxed/simple;
	bh=PlVN8xXeJpQxRFCg/Zbc/zFXTyCgg9A5cV1m+rK2HuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYE6UNbYCqUqYfBs+FCTc5+4N67qG9SaQbrW+t87mMNOx5EmmqRpRbGNdLa1WNPyBR2yhwlzhYLzMoWV8gdZXVUj0UBIXXT+J6EF/TG4TIr1MeLZKPfxBWChB8CJCOPyFfR1bHp+J0W5/OTYXuX9cVvQnhgDYLgbeb8QnNh/5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3Je228iL; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d858501412so88263171fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714575355; x=1715180155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAPd7+I9U5+1I8Z6YQiXd//LKxCaLInr9ip5Pmkk0XE=;
        b=3Je228iL7Mk2LUzdz6SM9FguE3nmTT0wxhTQCPrYrWycUUeTssu+km+wPpPFnNATkA
         +Cl3TFOFjD5n7MlCKB7ccQ2+XRb+yLETHGdTr4nhrhHpM3CdQZTo/lxerlY0NjgSaxZ2
         Q40bgK++cKLVx1LttwDI1jK2PXPNWZqsaQRFxmS3ol9a82ka4ppBRHq6cO8uG2/cEkMW
         asMLLrHX4BxnVraBv95VUQ1d0T1A1WrwS02BsRaOcxmRewVZBqfjVUti7E2vvsGYfvyF
         nNe2+8r8yXb1HRlg6OMGfI9Sad38FUut3/ig1t/RD/Zg5MIUeY8u1c6t//2Ak2uvbUZ4
         Hezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575355; x=1715180155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAPd7+I9U5+1I8Z6YQiXd//LKxCaLInr9ip5Pmkk0XE=;
        b=Fc8MKQTMS04TxF1hG+JjbB9C8rbmA0f+4TBNoMdubZzCjDHDILMtGwhpL3o5gLJzJA
         Bv8lTVor0Kqk75hEmo9soVeGCYxrEfUNBwuw3PxqRyf8qd6gbhXUr+2U3JiRSPYvpvxS
         8tuO8nMX6SB0KL74E/AG5ne563zq7g6+g+Uo1+UNOVibb2DFzL3CmS/EJNzMAaAoHph6
         QNTpIpfyyTpz/P2LIHl1G+/1um0HYRBlHbLueDQloS+L+03kfJtZ7roIY8Aj7DaOC4M4
         KYY776UGL/PRM/5X3a5fWZ0huwlBdzi/J06uFMrtnrP7RoEer7ndiC4GInNqSk7+Goil
         ioIA==
X-Forwarded-Encrypted: i=1; AJvYcCX5IHsbLleQ7D/oLTtUGJEq9suqCxjkwYwQPH1uF/5HM7RnaHuBaH25NVLMCaiHPtONK5AON34o+MitU86JVAolpEmu/LyJHxgqHi0v
X-Gm-Message-State: AOJu0Yy8FktQ+RcUl04EtetZUsZdxKy4NiqJtIB25CbmRZtnVIcV6Ybl
	wI0p61AZLD5b9oOsI/0NtWGsDDs1dFZqORx9LAofI6O2BxKYa4fylklWkSp2SMI=
X-Google-Smtp-Source: AGHT+IETnXzT+yQs6Yj2CWqIQQetQPoDaLRkkWGMsrtIM9SAobTswOR6AFvtKqMV9AqyM9AlDvmm6w==
X-Received: by 2002:a2e:a7d1:0:b0:2e0:4a32:1f41 with SMTP id x17-20020a2ea7d1000000b002e04a321f41mr2092149ljp.19.1714575353548;
        Wed, 01 May 2024 07:55:53 -0700 (PDT)
Received: from [192.168.1.61] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b00418a386c17bsm2422999wms.12.2024.05.01.07.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:55:53 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 01 May 2024 16:55:38 +0200
Subject: [PATCH RFC v6 05/10] iio: adc: ad7380: prepare for parts with more
 channels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-adding-new-ad738x-driver-v6-5-3c0741154728@baylibre.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

The current driver supports only parts with 2 channels.
In order to prepare the support of new compatible ADCs with more
channels, this commit:
  - defines MAX_NUM_CHANNEL to specify the maximum number of
    channels currently supported by the driver
  - adds available_scan_mask member in ad7380_chip_info structure
  - fixes spi xfer struct len depending on number of channels
  - fixes scan_data.raw buffer size to handle more channels
  - adds a timing specifications structure in ad7380_chip_info structure

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index d6abce6d45d3..201006d878f1 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -29,6 +29,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#define MAX_NUM_CHANNELS		2
 /* 2.5V internal reference voltage */
 #define AD7380_INTERNAL_REF_MV		2500
 
@@ -65,12 +66,19 @@
 #define AD7380_ALERT_LOW_TH		GENMASK(11, 0)
 #define AD7380_ALERT_HIGH_TH		GENMASK(11, 0)
 
+#define T_CONVERT_NS 190		/* conversion time */
+struct ad7380_timing_specs {
+	const unsigned int t_csh_ns;	/* CS minimum high time */
+};
+
 struct ad7380_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 	const char * const *vcm_supplies;
 	unsigned int num_vcm_supplies;
+	const unsigned long *available_scan_masks;
+	const struct ad7380_timing_specs *timing_specs;
 };
 
 #define AD7380_CHANNEL(index, bits, diff) {			\
@@ -115,16 +123,24 @@ static const unsigned long ad7380_2_channel_scan_masks[] = {
 	0
 };
 
+static const struct ad7380_timing_specs ad7380_timing = {
+	.t_csh_ns = 10,
+};
+
 static const struct ad7380_chip_info ad7380_chip_info = {
 	.name = "ad7380",
 	.channels = ad7380_channels,
 	.num_channels = ARRAY_SIZE(ad7380_channels),
+	.available_scan_masks = ad7380_2_channel_scan_masks,
+	.timing_specs = &ad7380_timing,
 };
 
 static const struct ad7380_chip_info ad7381_chip_info = {
 	.name = "ad7381",
 	.channels = ad7381_channels,
 	.num_channels = ARRAY_SIZE(ad7381_channels),
+	.available_scan_masks = ad7380_2_channel_scan_masks,
+	.timing_specs = &ad7380_timing,
 };
 
 static const struct ad7380_chip_info ad7383_chip_info = {
@@ -133,6 +149,8 @@ static const struct ad7380_chip_info ad7383_chip_info = {
 	.num_channels = ARRAY_SIZE(ad7383_channels),
 	.vcm_supplies = ad7380_2_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
+	.available_scan_masks = ad7380_2_channel_scan_masks,
+	.timing_specs = &ad7380_timing,
 };
 
 static const struct ad7380_chip_info ad7384_chip_info = {
@@ -141,6 +159,8 @@ static const struct ad7380_chip_info ad7384_chip_info = {
 	.num_channels = ARRAY_SIZE(ad7384_channels),
 	.vcm_supplies = ad7380_2_channel_vcm_supplies,
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
+	.available_scan_masks = ad7380_2_channel_scan_masks,
+	.timing_specs = &ad7380_timing,
 };
 
 struct ad7380_state {
@@ -148,15 +168,16 @@ struct ad7380_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	unsigned int vref_mv;
-	unsigned int vcm_mv[2];
+	unsigned int vcm_mv[MAX_NUM_CHANNELS];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
-	 * Make the buffer large enough for 2 16-bit samples and one 64-bit
+	 * Make the buffer large enough for MAX_NUM_CHANNELS 16-bit samples and one 64-bit
 	 * aligned 64 bit timestamp.
+	 * As MAX_NUM_CHANNELS is 2 the layout of the structure is the same for all parts
 	 */
 	struct {
-		u16 raw[2];
+		u16 raw[MAX_NUM_CHANNELS];
 
 		s64 ts __aligned(8);
 	} scan_data __aligned(IIO_DMA_MINALIGN);
@@ -194,7 +215,7 @@ static int ad7380_regmap_reg_read(void *context, unsigned int reg,
 			.tx_buf = &st->tx,
 			.cs_change = 1,
 			.cs_change_delay = {
-				.value = 10, /* t[CSH] */
+				.value = st->chip_info->timing_specs->t_csh_ns,
 				.unit = SPI_DELAY_UNIT_NSECS,
 			},
 		}, {
@@ -252,7 +273,8 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 	struct ad7380_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfer = {
 		.bits_per_word = st->chip_info->channels[0].scan_type.realbits,
-		.len = 4,
+		.len = (st->chip_info->num_channels - 1) *
+		       BITS_TO_BYTES(st->chip_info->channels->scan_type.storagebits),
 		.rx_buf = st->scan_data.raw,
 	};
 	int ret;
@@ -279,21 +301,22 @@ static int ad7380_read_direct(struct ad7380_state *st,
 			.speed_hz = AD7380_REG_WR_SPEED_HZ,
 			.bits_per_word = chan->scan_type.realbits,
 			.delay = {
-				.value = 190, /* t[CONVERT] */
+				.value = T_CONVERT_NS,
 				.unit = SPI_DELAY_UNIT_NSECS,
 			},
 			.cs_change = 1,
 			.cs_change_delay = {
-				.value = 10, /* t[CSH] */
+				.value = st->chip_info->timing_specs->t_csh_ns,
 				.unit = SPI_DELAY_UNIT_NSECS,
 			},
 		},
-		/* then read both channels */
+		/* then read all channels */
 		{
 			.speed_hz = AD7380_REG_WR_SPEED_HZ,
 			.bits_per_word = chan->scan_type.realbits,
 			.rx_buf = st->scan_data.raw,
-			.len = 4,
+			.len = (st->chip_info->num_channels - 1) *
+			       ((chan->scan_type.storagebits > 16) ? 4 : 2),
 		},
 	};
 	int ret;
@@ -474,7 +497,7 @@ static int ad7380_probe(struct spi_device *spi)
 	indio_dev->name = st->chip_info->name;
 	indio_dev->info = &ad7380_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->available_scan_masks = ad7380_2_channel_scan_masks;
+	indio_dev->available_scan_masks = st->chip_info->available_scan_masks;
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 					      iio_pollfunc_store_time,

-- 
2.44.0


