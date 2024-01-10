Return-Path: <linux-kernel+bounces-22678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169F82A16F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D0A1F237E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990B4EB3F;
	Wed, 10 Jan 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RVhbHay3"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24DB4F1E4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-598890b5b9dso896448eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916274; x=1705521074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rtpyz2iiOS/zOtpHDt2wgyhpTSxFEj3qm5hO7mpmzwg=;
        b=RVhbHay3gZyrSslLRfgAYADLWalPcSPtBDp7BVCF9F1ZMIMLM8mbVk1fMMFvyqu78Q
         k/BXeSo+wB7PBtmpUv8XMJd8+sKVrGI4S02Q+IlcKGA9i8IctV4ZN0z4eKtJYVfYltMQ
         70PAT/TgF/0CsxQJsYT32O6HsdKLzVTS1uZGBNA35LV0ZH3zAsnLu9QF2bwAz3enXSHg
         04J5AJLKgHiDtSph6Zu0HWhqV3SPhZGzTyB9DNBVttheqPJG2b7VQU/i6t8vdjptvqo3
         YwLjrWhe5BPRzw5OejuUoBQXgGSqquenj/NOprpsTytVgvLjq/uWF4Dh0XPkrK9bXZli
         Wj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916274; x=1705521074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rtpyz2iiOS/zOtpHDt2wgyhpTSxFEj3qm5hO7mpmzwg=;
        b=A/EXctEZda/r4lCvktbKytjv1PoelWfGmKs3SwpPlFKrgdpWZFlA1Hzk+BOhgZ0+kr
         do+xX37GRe0GM8sbZtGL6iNbq/7U7QAcUn2r90Zg1cnEWONKcwcJRxv1oyaqf6YPQeKm
         cbt4Pl5JBk074klBC7yGH28vQL+UYoTdAQXG+jGRjNsdJqdK8gvP9iz5TPgZaGFPJlnj
         RY79jkSD/y1WwB3PMRbd1V9tVy/nqdNK6gmXQzW9I7vrVNrdgzZGcdPhPfSReggmPaX7
         lrLUzc9FMn3zy/30egiZE18pdt8vxZUHMyIqtH32rpNb8pslR8mxZCDMWcDEoJxHMdVf
         iuKg==
X-Gm-Message-State: AOJu0Yz43vRRDbHHjwVYFsxG2VM6A+AChTgDyDI93J+c+uh3CvHFKluE
	sFLgVXB6m4A4cFOp62GLiZXy/L4Wskys7w==
X-Google-Smtp-Source: AGHT+IHc4sNQXYEuciW9GRpQ8zDDHu5jhYMUf3CF7UcMErZxuLOTHOlO+9T2OSQ/blaf7Jl7ugn6bw==
X-Received: by 2002:a4a:d2c7:0:b0:594:12f5:81f3 with SMTP id j7-20020a4ad2c7000000b0059412f581f3mr102811oos.8.1704916273902;
        Wed, 10 Jan 2024 11:51:13 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:13 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/13] spi: axi-spi-engine: add SPI offload support
Date: Wed, 10 Jan 2024 13:49:46 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-5-e42c6a986580@baylibre.com>
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

This adds an implementation of the SPI offload_ops to the AXI SPI Engine
driver to provide offload support.

Offload lookup is done by device property lookup. SPI Engine commands
and tx data  are recorded by writing to offload-specific FIFOs in the
SPI Engine hardware.

Co-developed-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 270 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 270 insertions(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 58280dd1c901..1d7ddc867b50 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -2,9 +2,11 @@
 /*
  * SPI-Engine SPI controller driver
  * Copyright 2015 Analog Devices Inc.
+ * Copyright 2023 BayLibre, SAS
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/idr.h>
 #include <linux/interrupt.h>
@@ -38,11 +40,22 @@
 #define SPI_ENGINE_REG_SDI_DATA_FIFO		0xe8
 #define SPI_ENGINE_REG_SDI_DATA_FIFO_PEEK	0xec
 
+#define SPI_ENGINE_MAX_NUM_OFFLOADS		32
+
+#define SPI_ENGINE_REG_OFFLOAD_CTRL(x)		(0x100 + (SPI_ENGINE_MAX_NUM_OFFLOADS * x))
+#define SPI_ENGINE_REG_OFFLOAD_STATUS(x)	(0x104 + (SPI_ENGINE_MAX_NUM_OFFLOADS * x))
+#define SPI_ENGINE_REG_OFFLOAD_RESET(x)		(0x108 + (SPI_ENGINE_MAX_NUM_OFFLOADS * x))
+#define SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(x)	(0x110 + (SPI_ENGINE_MAX_NUM_OFFLOADS * x))
+#define SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(x)	(0x114 + (SPI_ENGINE_MAX_NUM_OFFLOADS * x))
+
 #define SPI_ENGINE_INT_CMD_ALMOST_EMPTY		BIT(0)
 #define SPI_ENGINE_INT_SDO_ALMOST_EMPTY		BIT(1)
 #define SPI_ENGINE_INT_SDI_ALMOST_FULL		BIT(2)
 #define SPI_ENGINE_INT_SYNC			BIT(3)
 
+#define SPI_ENGINE_OFFLOAD_CTRL_ENABLE		BIT(0)
+#define SPI_ENGINE_OFFLOAD_STATUS_ENABLED	BIT(0)
+
 #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
 #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
 #define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
@@ -76,6 +89,10 @@
 #define SPI_ENGINE_CMD_SYNC(id) \
 	SPI_ENGINE_CMD(SPI_ENGINE_INST_MISC, SPI_ENGINE_MISC_SYNC, (id))
 
+/* default sizes - can be changed when SPI Engine firmware is compiled */
+#define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
+#define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
+
 struct spi_engine_program {
 	unsigned int length;
 	uint16_t instructions[];
@@ -107,6 +124,10 @@ struct spi_engine_message_state {
 	u8 sync_id;
 };
 
+struct spi_engine_offload {
+	unsigned int index;
+};
+
 struct spi_engine {
 	struct clk *clk;
 	struct clk *ref_clk;
@@ -119,6 +140,9 @@ struct spi_engine {
 	struct spi_controller *controller;
 
 	unsigned int int_enable;
+
+	struct spi_offload offloads[SPI_ENGINE_MAX_NUM_OFFLOADS];
+	struct spi_engine_offload offload_priv[SPI_ENGINE_MAX_NUM_OFFLOADS];
 };
 
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
@@ -603,6 +627,239 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	return 0;
 }
 
+static struct spi_offload *spi_engine_offload_get(struct spi_device *spi,
+						  unsigned int index)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_offload *offload;
+	u32 vals[SPI_ENGINE_MAX_NUM_OFFLOADS];
+	int ret;
+
+	/* Use the adi,offloads array to find the offload at index. */
+
+	if (index >= ARRAY_SIZE(vals))
+		return ERR_PTR(-EINVAL);
+
+	ret = device_property_read_u32_array(&spi->dev, "adi,offloads", vals,
+					     index + 1);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (vals[index] >= SPI_ENGINE_MAX_NUM_OFFLOADS)
+		return ERR_PTR(-EINVAL);
+
+	offload = &spi_engine->offloads[vals[index]];
+
+	return offload;
+}
+
+static int spi_engine_offload_prepare(struct spi_offload *offload,
+				      struct spi_message *msg)
+{
+	struct spi_controller *host = offload->controller;
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_program p_dry, *p __free(kfree) = NULL;
+	struct spi_transfer *xfer;
+	void __iomem *cmd_addr;
+	void __iomem *sdo_addr;
+	size_t tx_word_count = 0;
+	unsigned int i;
+
+	/* count total number of tx words in message */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (!xfer->tx_buf)
+			continue;
+
+		if (xfer->bits_per_word <= 8)
+			tx_word_count += xfer->len;
+		else if (xfer->bits_per_word <= 16)
+			tx_word_count += xfer->len / 2;
+		else
+			tx_word_count += xfer->len / 4;
+	}
+
+	/* REVISIT: could get actual size from devicetree if needed */
+	if (tx_word_count > SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE)
+		return -EINVAL;
+
+	spi_engine_precompile_message(msg);
+
+	/* dry run to get length */
+	p_dry.length = 0;
+	spi_engine_compile_message(msg, true, &p_dry);
+
+	/* REVISIT: could get actual size from devicetree if needed */
+	if (p_dry.length > SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE)
+		return -EINVAL;
+
+	p = kzalloc(sizeof(*p) + sizeof(*p->instructions) * p_dry.length, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	spi_engine_compile_message(msg, false, p);
+
+	cmd_addr = spi_engine->base + SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(priv->index);
+	sdo_addr = spi_engine->base + SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(priv->index);
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (!xfer->tx_buf)
+			continue;
+
+		if (xfer->bits_per_word <= 8) {
+			const u8 *buf = xfer->tx_buf;
+
+			for (i = 0; i < xfer->len; i++)
+				writel_relaxed(buf[i], sdo_addr);
+		} else if (xfer->bits_per_word <= 16) {
+			const u16 *buf = xfer->tx_buf;
+
+			for (i = 0; i < xfer->len / 2; i++)
+				writel_relaxed(buf[i], sdo_addr);
+		} else {
+			const u32 *buf = xfer->tx_buf;
+
+			for (i = 0; i < xfer->len / 4; i++)
+				writel_relaxed(buf[i], sdo_addr);
+		}
+	}
+
+	for (i = 0; i < p->length; i++)
+		writel_relaxed(p->instructions[i], cmd_addr);
+
+	return 0;
+}
+
+static void spi_engine_offload_unprepare(struct spi_offload *offload)
+{
+	struct spi_controller *host = offload->controller;
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+
+	writel_relaxed(1, spi_engine->base +
+			  SPI_ENGINE_REG_OFFLOAD_RESET(priv->index));
+	writel_relaxed(0, spi_engine->base +
+			  SPI_ENGINE_REG_OFFLOAD_RESET(priv->index));
+}
+
+static int spi_engine_offload_enable(struct spi_offload *offload)
+{
+	struct spi_controller *host = offload->controller;
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	unsigned int reg;
+
+	reg = readl_relaxed(spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->index));
+	reg |= SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
+	writel_relaxed(reg, spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->index));
+
+	return 0;
+}
+
+static void spi_engine_offload_disable(struct spi_offload *offload)
+{
+	struct spi_controller *host = offload->controller;
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	unsigned int reg;
+
+	reg = readl_relaxed(spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->index));
+	reg &= ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
+	writel_relaxed(reg, spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->index));
+}
+
+static const struct spi_controller_offload_ops spi_engine_offload_ops = {
+	.get = spi_engine_offload_get,
+	.prepare = spi_engine_offload_prepare,
+	.unprepare = spi_engine_offload_unprepare,
+	.enable = spi_engine_offload_enable,
+	.disable = spi_engine_offload_disable,
+};
+
+static void spi_engine_offload_release(void *p)
+{
+	struct spi_offload *offload = p;
+	struct platform_device *pdev = container_of(offload->dev,
+						    struct platform_device, dev);
+
+	offload->dev = NULL;
+	platform_device_unregister(pdev);
+}
+
+/**
+ * devm_spi_engine_register_offload() - Registers platform device for offload.
+ *
+ * @dev: The parent platform device node.
+ * @offload: The offload firmware node.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int devm_spi_engine_register_offload(struct device *dev,
+					    struct spi_engine *spi_engine,
+					    struct fwnode_handle *fwnode)
+{
+	struct platform_device_info pdevinfo = {
+		.parent = dev,
+		.name = "offload",
+		.fwnode = fwnode,
+	};
+	struct platform_device *pdev;
+	struct spi_offload *offload;
+	u32 index;
+	int ret;
+
+	ret = fwnode_property_read_u32(fwnode, "reg", &index);
+	if (ret)
+		return ret;
+
+	if (index >= SPI_ENGINE_MAX_NUM_OFFLOADS)
+		return -EINVAL;
+
+	pdevinfo.id = index;
+
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	offload = &spi_engine->offloads[index];
+	offload->dev = &pdev->dev;
+
+	return devm_add_action_or_reset(dev, spi_engine_offload_release, offload);
+}
+
+/**
+ * spi_engine_offload_populate() - Registers platform device for each offload instance.
+ * @host: The SPI controller.
+ * @spi_engine: The SPI engine.
+ * @dev: The parent platform device.
+ */
+static void spi_engine_offload_populate(struct spi_controller *host,
+					struct spi_engine *spi_engine,
+					struct device *dev)
+{
+	struct fwnode_handle *offloads;
+	struct fwnode_handle *child;
+	int ret;
+
+	/* offloads are optional */
+	offloads = device_get_named_child_node(dev, "offloads");
+	if (!offloads)
+		return;
+
+	fwnode_for_each_available_child_node(offloads, child) {
+		ret = devm_spi_engine_register_offload(dev, spi_engine, child);
+		if (ret)
+			dev_warn(dev, "failed to register offload: %d\n", ret);
+	}
+
+	fwnode_handle_put(offloads);
+}
+
 static void spi_engine_timeout(struct timer_list *timer)
 {
 	struct spi_engine *spi_engine = from_timer(spi_engine, timer, watchdog_timer);
@@ -633,6 +890,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	unsigned int version;
 	int irq;
 	int ret;
+	int i;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -670,6 +928,15 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	for (i = 0; i < SPI_ENGINE_MAX_NUM_OFFLOADS; i++) {
+		struct spi_engine_offload *priv = &spi_engine->offload_priv[i];
+		struct spi_offload *offload = &spi_engine->offloads[i];
+
+		priv->index = i;
+		offload->controller = host;
+		offload->priv = priv;
+	}
+
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_RESET);
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
@@ -692,6 +959,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->prepare_message = spi_engine_prepare_message;
 	host->unprepare_message = spi_engine_unprepare_message;
 	host->num_chipselect = 8;
+	host->offload_ops = &spi_engine_offload_ops;
 
 	if (host->max_speed_hz == 0)
 		return dev_err_probe(&pdev->dev, -EINVAL, "spi_clk rate is 0");
@@ -702,6 +970,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
+	spi_engine_offload_populate(host, spi_engine, &pdev->dev);
+
 	return 0;
 }
 

-- 
2.43.0


