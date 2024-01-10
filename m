Return-Path: <linux-kernel+bounces-22673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F082A149
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEDB1C227E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C104F1F8;
	Wed, 10 Jan 2024 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uRW3y8ic"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1B4E1DD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-58e256505f7so2394544eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916270; x=1705521070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHagqwNMpxV+ArB//eIyw4qGareX65jGuTeaGwQAWsQ=;
        b=uRW3y8icnWgWb6xtSearcTxgGNwi5i4a22I88Zu+ouS9ndBNBfMSoIodQ3U1XYGxp6
         o0ZT84iWXAlnVB3vGQ9vb0yvZ/WbIxUT2lHSZ7Fzp/TA/47a11u2rZj5yu6tIfGD4hJ8
         YZgg3R+zejFSJOzxsnvA7cEMxRLF52v368L/7CodKkmjnpGldI20uMQh6MxXK3XXKa1B
         H1zGFbeU47coAZT6pz5CcncQCNaABtkYGF0/p/US4IJemJgTUuQbKl+G/4ePazRSDLx9
         ZjRmUCZSHfsI0wCH3+VcYmzXM3bAT1TyvIZCb72O/XGEIhxgiclzueTD6MsOHBlw0DpS
         IVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916270; x=1705521070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHagqwNMpxV+ArB//eIyw4qGareX65jGuTeaGwQAWsQ=;
        b=Vs/HnIxaKucwwI6RSLxUDjJHrZSJrO1T7sZ30MmoJZSfMd+JNqHS8mRQW7HGHpOkLV
         1ATNN3uNhnmS6u2PK4ouka1e2cI0kpPtIZIa7NdItLLKjjMrvGwgnTEX+C21i/nec1eS
         ZSofMPG8YqQ+YUU1mB3IDc7+YM8x/kV4CjU2L153KES5lEuLD0dmVt9MEPI0+LG2f9AY
         K4NQWIRZPQh9BkbEwEK5Dkzx+wUIjdddPyusOoZ96cDcwY2hVWfLkfyU3mHYGa2ihQwR
         WG9ZF5p8zKPC4A04kd9qAhGvIB5rylpHIttb8Qwl0IbhXJhaSIBcCtyTSrXR9YnChb/H
         LewQ==
X-Gm-Message-State: AOJu0YzBYTB0sVTnXOl8Y9qBaQvvZelxjZPAAbNpuHdPFY5hPM5CTGR8
	SbTkuKatEkc5PLOm1m+XwRkN485D7rGPIg==
X-Google-Smtp-Source: AGHT+IFz2vHsP2VCChuXJsq+dXZdcNh9nCjfnHY2y1NETdUBAZFsR2IUd2+i849e6W9zmWjqlmEvCg==
X-Received: by 2002:a4a:1781:0:b0:598:6ed0:4015 with SMTP id 123-20020a4a1781000000b005986ed04015mr106322ooe.3.1704916270068;
        Wed, 10 Jan 2024 11:51:10 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:09 -0800 (PST)
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
Subject: [PATCH 01/13] spi: add core support for controllers with offload capabilities
Date: Wed, 10 Jan 2024 13:49:42 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
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

This adds a feature for specialized SPI controllers that can record
a series of SPI transfers, including tx data, cs assertions, delays,
etc. and then play them back using a hardware trigger without CPU
intervention.

The intended use case for this is with the AXI SPI Engine to capture
data from ADCs at high rates (MSPS) with a stable sample period.

Most of the implementation is controller-specific and will be handled by
drivers that implement the offload_ops callbacks. The API follows a
prepare/enable pattern that should be familiar to users of the clk
subsystem.

Consumers of this API will make calls similar to this:

    /* in probe() */
    offload = spi_offload_get(spi, 0);
    ...

    /* in some setup function */
    ret = spi_offload_prepare(offload, xfers, ARRAY_SIZE(xfers));
    ...

    /* in some enable function */
    ret = spi_offload_enable(offload);
    ...

    /* in corresponding disable function */
    spi_offload_disable(offload);
    ...

    /* in corresponding teardown function */
    spi_offload_unprepare(offload);
    ...

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c       |  39 +++++++++++++++
 include/linux/spi/spi.h | 123 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a4b8c07c5951..f1d66b5d5491 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3057,6 +3057,13 @@ static int spi_controller_check_ops(struct spi_controller *ctlr)
 		}
 	}
 
+	if (ctlr->offload_ops && !(ctlr->offload_ops->get &&
+				   ctlr->offload_ops->prepare &&
+				   ctlr->offload_ops->unprepare &&
+				   ctlr->offload_ops->enable &&
+				   ctlr->offload_ops->disable))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -4448,6 +4455,38 @@ int spi_write_then_read(struct spi_device *spi,
 }
 EXPORT_SYMBOL_GPL(spi_write_then_read);
 
+/**
+ * spi_offload_prepare - prepare offload hardware for a transfer
+ * @offload:	The offload instance.
+ * @spi:	The spi device to use for the transfers.
+ * @xfers:	The transfers to be executed.
+ * @num_xfers:	The number of transfers.
+ *
+ * Records a series of transfers to be executed later by the offload hardware
+ * trigger.
+ *
+ * Return: 0 on success, else a negative error code.
+ */
+int spi_offload_prepare(struct spi_offload *offload, struct spi_device *spi,
+			struct spi_transfer *xfers, unsigned int num_xfers)
+{
+	struct spi_controller *ctlr = offload->controller;
+	struct spi_message msg;
+	int ret;
+
+	spi_message_init_with_transfers(&msg, xfers, num_xfers);
+
+	ret = __spi_validate(spi, &msg);
+	if (ret)
+		return ret;
+
+	msg.spi = spi;
+	ret = ctlr->offload_ops->prepare(offload, &msg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_offload_prepare);
+
 /*-------------------------------------------------------------------------*/
 
 #if IS_ENABLED(CONFIG_OF_DYNAMIC)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 5d65a6273dcf..f116dfc1d52c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -28,6 +28,8 @@ struct spi_transfer;
 struct spi_controller_mem_ops;
 struct spi_controller_mem_caps;
 struct spi_message;
+struct spi_controller_offload_ops;
+struct spi_offload;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
@@ -713,6 +715,9 @@ struct spi_controller {
 	const struct spi_controller_mem_ops *mem_ops;
 	const struct spi_controller_mem_caps *mem_caps;
 
+	/* Operations for controllers with offload support. */
+	const struct spi_controller_offload_ops *offload_ops;
+
 	/* GPIO chip select */
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
@@ -1505,6 +1510,124 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
 
 /*---------------------------------------------------------------------------*/
 
+/*
+ * Offloading support.
+ *
+ * Some SPI controllers support offloading of SPI transfers. Essentially,
+ * this allows the SPI controller to record SPI transfers and then play them
+ * back later via a hardware trigger.
+ */
+
+/**
+ * SPI_OFFLOAD_RX - placeholder for indicating read transfers for offloads
+ *
+ * Assign xfer->rx_buf to this value for any read transfer passed to
+ * spi_offload_prepare(). This will act as a flag to indicate to the offload
+ * that it should do something with the data read during this transfer. What
+ * that something can be is determined by the specific hardware, e.g. it could
+ * be piped to DMA or a DSP, etc.
+ */
+#define SPI_OFFLOAD_RX_SENTINEL ((void *)1)
+
+/**
+ * struct spi_controller_offload_ops - callbacks for offload support
+ *
+ * Drivers for hardware with offload support need to implement all of these
+ * callbacks.
+ */
+struct spi_controller_offload_ops {
+	/**
+	 * @get: Callback to get the offload assigned to the given SPI device.
+	 * Index is an index in the offloads array fwnode property of the device.
+	 * Implementations must return the pointer to the device or a negative
+	 * error code (return -ENODEV rather than NULL if no matching device).
+	 */
+	struct spi_offload *(*get)(struct spi_device *spi, unsigned int index);
+	/**
+	 * @prepare: Callback to prepare the offload for the given SPI message.
+	 * @msg and any of its members (including any xfer->tx_buf) is not
+	 * guaranteed to be valid beyond the lifetime of this call.
+	 */
+	int (*prepare)(struct spi_offload *offload, struct spi_message *msg);
+	/**
+	 * @unprepare: Callback to release any resources used by prepare().
+	 */
+	void (*unprepare)(struct spi_offload *offload);
+	/**
+	 * @enable: Callback to enable the offload.
+	 */
+	int (*enable)(struct spi_offload *offload);
+	/**
+	 * @disable: Callback to disable the offload.
+	 */
+	void (*disable)(struct spi_offload *offload);
+};
+
+/** struct spi_offload - offload handle */
+struct spi_offload {
+	/** @controller: The associated SPI controller. */
+	struct spi_controller *controller;
+	/** @dev: The device associated with the offload instance. */
+	struct device *dev;
+	/** @priv: Private instance data used by the SPI controller. */
+	void *priv;
+};
+
+/**
+ * spi_offload_get - gets an offload assigned to the given SPI device
+ * @spi: SPI device.
+ * @index: Index of the offload in the SPI device's fwnode int array.
+ *
+ * The lifetime of the returned offload is tied to the struct spi_controller
+ * instance. Since @spi owns a reference to the controller, most consumers
+ * should not have to do anything extra. But if the offload is passed somewhere
+ * outside of the control of the SPI device driver, then an additional reference
+ * to the controller must be made.
+ *
+ * Return: Pointer to the offload handle or negative error code.
+ */
+static inline struct spi_offload *spi_offload_get(struct spi_device *spi,
+						  unsigned int index)
+{
+	if (!spi->controller->offload_ops)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return spi->controller->offload_ops->get(spi, index);
+}
+
+int spi_offload_prepare(struct spi_offload *offload, struct spi_device *spi,
+			struct spi_transfer *xfers, unsigned int num_xfers);
+
+/**
+ * spi_offload_unprepare - releases any resources used by spi_offload_prepare()
+ * @offload: The offload instance.
+ */
+static inline void spi_offload_unprepare(struct spi_offload *offload)
+{
+	offload->controller->offload_ops->unprepare(offload);
+}
+
+/**
+ * spi_offload_enable - enables the offload
+ * @offload: The offload instance.
+ * Return: 0 on success or negative error code.
+ */
+static inline int spi_offload_enable(struct spi_offload *offload)
+{
+	return offload->controller->offload_ops->enable(offload);
+}
+
+/**
+ * spi_offload_disable - disables the offload
+ * @offload: The offload instance.
+ */
+static inline void spi_offload_disable(struct spi_offload *offload)
+{
+	offload->controller->offload_ops->disable(offload);
+}
+
+/*---------------------------------------------------------------------------*/
+
 /*
  * INTERFACE between board init code and SPI infrastructure.
  *

-- 
2.43.0


