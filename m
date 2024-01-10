Return-Path: <linux-kernel+bounces-22681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B2182A17C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4E0283233
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD4D4F8B9;
	Wed, 10 Jan 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DYtCGZ85"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652604F892
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5955a4a9b23so2450180eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916278; x=1705521078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoFvxKWdDooo1qSzC88EM9Nr4w+h9Vd46EFkbYPsSPw=;
        b=DYtCGZ85pbfryJGNqhUF4Mwq/s2IJBCLYdbVXcZLOQTTMhJS86QolB3UIl1+Emd3nB
         P6ckUQiZlcgKwajSzt4FjkrPaY87p8sqQWrhlaIclD27u9YQLMHhY1Fw+l/lU4d0lejW
         ubUKXLJgEZ8pRnHY0PT5osdpTQDm3alUwirTkAbcpz6EFjJcGt6hI+kwYpkxx8PYImOJ
         oTyfdO73QCXeXWx1hl9OHm6IvpZmEovhyGlhSvzb8fxNsQq+ckrJk8f2MSywULRb0aF+
         +wscSNVNacPlJS89FFH+DcLyrhP5gyhytLFKeL8R5/EWqDtXyeopuhGVbeqURHNH4+3f
         6HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916278; x=1705521078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoFvxKWdDooo1qSzC88EM9Nr4w+h9Vd46EFkbYPsSPw=;
        b=KKdAmgtQ+76da44NNLXhbWWMQr7myrblhzrrcZZWhg2fQDEHvH3TYU/HTodIA5xeJe
         4RBhsfcJizJR1lNKzq31M/o6jUKESGWueua/g8dsljs1QN7zJTtyZ1s2t2g43Ijrh1Ll
         40TyvKtKEJV64s53wakykcc7NIQjXtTQNsF1GjSlzJOIGAvXJs/dbp85+AWdtBvIk8Rz
         xsvxjm4aIbz3h7GhPA7hpE/Ogr9xorbshbdrJeJ6Iu25+IYSoJHkx/bd8N2Y84UCqVl5
         jXMoMe8J+1OdvE40sTc8vixu+kYxizRgZTyOxQdn034vhs3QBzwUfWWY7PrRr7V3cKT8
         5ayg==
X-Gm-Message-State: AOJu0Yzt+DQZ49WlpoDUHzv0p2MkzejxAMk+/EGFVpb3F9a29lTP2gsn
	YRLuXj/1pqfczP6RVnhZGDeSv4Cfdl+O0Q==
X-Google-Smtp-Source: AGHT+IHrT/0uM2BhirfFIgGw42yzsFECk08FhInWXcIqOlIBJJbxXE41ntQmPNJUuiNBiHuZt4yDqw==
X-Received: by 2002:a05:6820:1ca2:b0:594:3789:1aaf with SMTP id ct34-20020a0568201ca200b0059437891aafmr100073oob.15.1704916278503;
        Wed, 10 Jan 2024 11:51:18 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:18 -0800 (PST)
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
Subject: [PATCH 10/13] iio: buffer: dmaengine: export devm_iio_dmaengine_buffer_alloc()
Date: Wed, 10 Jan 2024 13:49:51 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-10-e42c6a986580@baylibre.com>
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

This changes devm_iio_dmaengine_buffer_alloc() to an exported symbol.
This will be used by drivers that need to allocate a DMA buffer without
attaching it to an IIO device.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/driver-api/driver-model/devres.rst   |  1 +
 drivers/iio/buffer/Kconfig                         | 14 +++++++-------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  3 ++-
 include/linux/iio/buffer-dmaengine.h               |  2 ++
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index b23d4a2b68a6..60e4b7ba38e5 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -285,6 +285,7 @@ I2C
 IIO
   devm_iio_device_alloc()
   devm_iio_device_register()
+  devm_iio_dmaengine_buffer_alloc()
   devm_iio_dmaengine_buffer_setup()
   devm_iio_kfifo_buffer_setup()
   devm_iio_kfifo_buffer_setup_ext()
diff --git a/drivers/iio/buffer/Kconfig b/drivers/iio/buffer/Kconfig
index 925c5bf074bc..27d82fb4bc4d 100644
--- a/drivers/iio/buffer/Kconfig
+++ b/drivers/iio/buffer/Kconfig
@@ -40,6 +40,13 @@ config IIO_BUFFER_HW_CONSUMER
 	  Should be selected by drivers that want to use the generic Hw consumer
 	  interface.
 
+config IIO_HW_TRIGGERED_BUFFER
+	tristate "Industrial I/O hardware triggered buffer support"
+	select AUXILIARY_BUS
+	select IIO_TRIGGER
+	help
+	  Provides helper functions for setting up hardware triggered buffers.
+
 config IIO_KFIFO_BUF
 	tristate "Industrial I/O buffering based on kfifo"
 	help
@@ -53,10 +60,3 @@ config IIO_TRIGGERED_BUFFER
 	select IIO_KFIFO_BUF
 	help
 	  Provides helper functions for setting up triggered buffers.
-
-config IIO_HW_TRIGGERED_BUFFER
-	tristate "Industrial I/O hardware triggered buffer support"
-	select AUXILIARY_BUS
-	select IIO_TRIGGER
-	help
-	  Provides helper functions for setting up hardware triggered buffers.
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index c67ddf963bfb..03225939f223 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -244,7 +244,7 @@ static void __devm_iio_dmaengine_buffer_free(void *buffer)
  *
  * The buffer will be automatically de-allocated once the device gets destroyed.
  */
-static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
+struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
 	const char *channel)
 {
 	struct iio_buffer *buffer;
@@ -261,6 +261,7 @@ static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
 
 	return buffer;
 }
+EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_alloc);
 
 /**
  * devm_iio_dmaengine_buffer_setup() - Setup a DMA buffer for an IIO device
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 5c355be89814..3ac616ddf5b9 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -10,6 +10,8 @@
 struct iio_dev;
 struct device;
 
+struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
+						   const char *channel);
 int devm_iio_dmaengine_buffer_setup(struct device *dev,
 				    struct iio_dev *indio_dev,
 				    const char *channel);

-- 
2.43.0


