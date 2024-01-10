Return-Path: <linux-kernel+bounces-22684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD082A189
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA981C22D03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7C85576B;
	Wed, 10 Jan 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w7f2pkFZ"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF45027C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59502aa878aso2286457eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916281; x=1705521081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEIVZQBdPUNnjAlN4uqFphv/2LrUKMCMcEQYLMsoqo8=;
        b=w7f2pkFZfTgn8a/UxuzC9V+sUXfy70U27Cq2Grf+5kwldDIsXZFMt+s7LLZ5UNBXXs
         B9TTqh0z6HVewLwvFBUduFTSc96+anVUQG+iB2cWmHunGVL+U952IlQqau7eguDlKa5Y
         bNXgiaGecmNdxX8LqsQ312wPxqm58niFPlJuBAFY+rwTxpI/3XwPeLqoS+PoAPX7NsMb
         vvEUFFaMU0qu3v5xF9YLGKZflRTEFuK2zXN4mjHy0Jv4OmjhXNXAuEDgi8ZXrDuDNqJH
         ftAQ5x1NhbuQdgYvrIsgc4Iy2NHF0nWQiDBnRT8C+qVNKTkhGe0+2XLFKZb5L/mxfR38
         Lyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916281; x=1705521081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEIVZQBdPUNnjAlN4uqFphv/2LrUKMCMcEQYLMsoqo8=;
        b=MVCpMJHjgbIrc433/4/nUe9GCiBqXkImS0jEEBDtj2WQsgyWeOjwrwmE7ZdMTmb+xq
         yIhAEJ16DVxLbPRz0C/mTbzjrqC57FgMqJH7xdHifaDtvpgM6x4Wlu49L7eKJHPfdCJV
         8x/eT2zLLLwNpXlwX1H6yDnL5ySdyzjqTrSl+p/JEWHL5sFu4zaAFM4zZsDpMWsHrIZj
         mGVVao3llboIH76WvFYWQQzFu9mUEf2AKkvjyWhbUSemuz8FUQbVYJ8FFVZoGGueWvPp
         6EiP0ijGKQjha+zAIFzMy32zT86LMFGfUQHkUxYtHcfYDX8f//3ukrSiaMo0TwCsX2Gi
         kqFQ==
X-Gm-Message-State: AOJu0Yy9ZodKtLDLYZioVkZeHH+RdhgmV27pgR2VOqcrnqyEg+1QnTeg
	ujlEVr/lT7gfWVyFsiuqWuJZlVko+fT2Vw==
X-Google-Smtp-Source: AGHT+IGVUnlE5QFB5qOf5dH/lNuXEUJWtpYSg/QjEdM8LJ0UAk97dhRGFSNb5W/kbU8O5dA7eDesFA==
X-Received: by 2002:a05:6820:1ac3:b0:596:31c6:c13c with SMTP id bu3-20020a0568201ac300b0059631c6c13cmr119862oob.12.1704916281170;
        Wed, 10 Jan 2024 11:51:21 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:20 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Frank Rowand <frowand.list@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] iio: adc: ad7380: add SPI offload support
Date: Wed, 10 Jan 2024 13:49:54 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-13-e42c6a986580@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This extends the ad7380 ADC driver to use the offload capabilities of
capable SPI controllers. When offload support is available, a hardware
triggered buffer is used to allow sampling a high rates without CPU
intervention.

To keep things simple, when this feature is present in hardware we
disable the usual IIO triggered buffer and software timestamp rather
than trying to support multiple buffers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/Kconfig  |  1 +
 drivers/iio/adc/ad7380.c | 84 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index cbfd626712e3..da44b585ea46 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -128,6 +128,7 @@ config AD7380
 	select IIO_BUFFER
 	select IIO_TRIGGER
 	select IIO_TRIGGERED_BUFFER
+	select IIO_HW_TRIGGERED_BUFFER
 	help
 	  AD7380 is a family of simultaneous sampling ADCs that share the same
 	  SPI register map and have similar pinouts.
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 80712aaa9548..a71e8b81950b 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -20,6 +20,7 @@
 #include <linux/sysfs.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/hw_triggered_buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
@@ -133,6 +134,7 @@ struct ad7380_state {
 	struct spi_device *spi;
 	struct regulator *vref;
 	struct regmap *regmap;
+	struct spi_offload *spi_offload;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -335,6 +337,50 @@ static const struct iio_info ad7380_info = {
 	.debugfs_reg_access = &ad7380_debugfs_reg_access,
 };
 
+static int ad7380_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	struct spi_transfer xfer = {
+		.bits_per_word = st->chip_info->channels[0].scan_type.realbits,
+		.len = 4,
+		.rx_buf = SPI_OFFLOAD_RX_SENTINEL,
+	};
+
+	return spi_offload_prepare(st->spi_offload, st->spi, &xfer, 1);
+}
+
+static int ad7380_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+
+	return spi_offload_enable(st->spi_offload);
+}
+
+static int ad7380_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+
+	spi_offload_disable(st->spi_offload);
+
+	return 0;
+}
+
+static int ad7380_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+
+	spi_offload_unprepare(st->spi_offload);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad7380_buffer_ops = {
+	.preenable = &ad7380_buffer_preenable,
+	.postenable = &ad7380_buffer_postenable,
+	.predisable = &ad7380_buffer_predisable,
+	.postdisable = &ad7380_buffer_postdisable,
+};
+
 static int ad7380_init(struct ad7380_state *st)
 {
 	int ret;
@@ -417,11 +463,39 @@ static int ad7380_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = ad7380_2_channel_scan_masks;
 
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad7380_trigger_handler, NULL);
-	if (ret)
-		return ret;
+	st->spi_offload = spi_offload_get(spi, 0);
+	if (IS_ERR(st->spi_offload)) {
+		ret = PTR_ERR(st->spi_offload);
+
+		if (ret == -EOPNOTSUPP)
+			st->spi_offload = NULL;
+		else
+			return dev_err_probe(&spi->dev, ret,
+					     "failed to get SPI offload\n");
+	}
+
+	if (st->spi_offload) {
+		/*
+		 * We can't have a soft timestamp (always last channel) when
+		 * using a hardware triggered buffer.
+		 */
+		indio_dev->num_channels -= 1;
+
+		ret = devm_iio_hw_triggered_buffer_setup(&spi->dev,
+							 indio_dev,
+							 st->spi_offload->dev,
+							 &ad7380_buffer_ops);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "failed to setup offload\n");
+	} else {
+		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad7380_trigger_handler,
+						      NULL);
+		if (ret)
+			return ret;
+	}
 
 	ret = ad7380_init(st);
 	if (ret)

-- 
2.43.0


