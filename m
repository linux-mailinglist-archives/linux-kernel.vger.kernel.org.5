Return-Path: <linux-kernel+bounces-22683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9434182A188
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CBC1C22D35
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C089453E09;
	Wed, 10 Jan 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cbfW3zrC"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418DD50254
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-598a5448ef5so270389eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916280; x=1705521080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAfisbraTIzPK5DNS+hXkieTeMFvO6LSXMmUPvgA/Yc=;
        b=cbfW3zrCzDrC2BsJDrvGh2OelkTFByfUxrTt4miiSoq3fT2DmiaOTNftPRWZpCoOMx
         d2gRMxkafALFBhuUMrgpW94onVz/j6zq9twsooZAcfDJjKfKEzZgraYwAbGXhD6Zghsq
         jJx0T8rDjFrVaUrO+t8X0MvaVxOgQ1xgAUgJ7fvEBYdarHT4UnehFRbSfLRMMDBJXRTn
         K9GOLzBYfxx6vyu/gIx8rYr65+rrnCasMncpBEp/1+vTM69O9WL8Au56+V2Lkx0qVqFO
         oWYSHYXHlXnI4J7I5KebEWMiw2meBOD2gser2+Kfzy+h/VdaDE9HkkEk7D0wSLUYyIdz
         MmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916280; x=1705521080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAfisbraTIzPK5DNS+hXkieTeMFvO6LSXMmUPvgA/Yc=;
        b=VVWtVYp+WxiOuBn8aK91EVcotEuzCA1zkqTyEykJDOwrENJNUs64sjX4H0kbiqPg58
         u/UYbYeofU3wxd+X6AmTaY3lkZlBLSmLjB9OgC15e5J+QicqKWFAPqVztzDFG3IAAonq
         NLfGH/MzkMknt5YQ9hX7K+sTmIXC3xPrVC9YuqHrUEWm8tLENHREzXQ4EPcqmSpkQnXz
         cMVhM8O+tlLsAMujuZe0wW2DMdwGLETGXGzbru3JvdqRjrJTfGODZWF0c6dXsKFw6OrW
         nJDhLx4eBVdrk8rpVVmPyRp6eusVpvQeBhLLOe8wlJxj//oMY6ur6XLKeS7Busfq9m5/
         Vfqw==
X-Gm-Message-State: AOJu0YzIFvBqEpx32weLE+QWJx8IcFECUOvH4CAN7eGvTKS/l+PIp13h
	FTRRpLRqoqMDPMktiB1keufwhPDzuIU8K1oS4kE9T6nAzKo=
X-Google-Smtp-Source: AGHT+IHTumG0RvNmGteYGaGu6Rft2bQuoGUvLiP+GdymDcLixB0l11q6v2G9HH89HiPnDLtdCilfmg==
X-Received: by 2002:a4a:3503:0:b0:590:2b6d:a862 with SMTP id l3-20020a4a3503000000b005902b6da862mr94634ooa.15.1704916280323;
        Wed, 10 Jan 2024 11:51:20 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.19
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
Subject: [PATCH 12/13] iio: offload: add new PWM triggered DMA buffer driver
Date: Wed, 10 Jan 2024 13:49:53 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-12-e42c6a986580@baylibre.com>
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

This adds a new driver for handling SPI offloading using a PWM as the
trigger and DMA for the received data. This will be used by ADCs in
conjunction with SPI controllers with offloading support to be able
to sample at high rates without CPU intervention.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 .../iio/buffer/industrialio-hw-triggered-buffer.c  |   1 +
 drivers/iio/offload/Kconfig                        |  21 ++
 drivers/iio/offload/Makefile                       |   2 +
 drivers/iio/offload/iio-pwm-triggered-dma-buffer.c | 212 +++++++++++++++++++++
 6 files changed, 238 insertions(+)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 52eb46ef84c1..56738282d82f 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -90,6 +90,7 @@ source "drivers/iio/imu/Kconfig"
 source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 source "drivers/iio/multiplexer/Kconfig"
+source "drivers/iio/offload/Kconfig"
 source "drivers/iio/orientation/Kconfig"
 source "drivers/iio/test/Kconfig"
 if IIO_TRIGGER
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 9622347a1c1b..20acf5e1a4a7 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -34,6 +34,7 @@ obj-y += imu/
 obj-y += light/
 obj-y += magnetometer/
 obj-y += multiplexer/
+obj-y += offload/
 obj-y += orientation/
 obj-y += position/
 obj-y += potentiometer/
diff --git a/drivers/iio/buffer/industrialio-hw-triggered-buffer.c b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
index 7a8a71066b0e..a2fae6059616 100644
--- a/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
@@ -86,6 +86,7 @@ static int iio_hw_trigger_buffer_probe(struct auxiliary_device *adev,
 }
 
 static const struct auxiliary_device_id iio_hw_trigger_buffer_id_table[] = {
+	{ .name = "pwm-triggered-dma-buffer.triggered-buffer" },
 	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, iio_hw_trigger_buffer_id_table);
diff --git a/drivers/iio/offload/Kconfig b/drivers/iio/offload/Kconfig
new file mode 100644
index 000000000000..760c0cfe0e9c
--- /dev/null
+++ b/drivers/iio/offload/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# SPI offload handlers for Industrial I/O
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "SPI offload handlers"
+
+config IIO_PWM_TRIGGERED_DMA_BUFFER
+	tristate "PWM trigger and DMA buffer connected to SPI offload"
+	select AUXILIARY_BUS
+	select IIO_BUFFER_DMAENGINE
+	help
+	  Provides a periodic hardware trigger via a PWM connected to the
+	  trigger input of a SPI offload and a hardware buffer implemented
+	  via DMA connected to the data output stream the a SPI offload.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called "iio-pwm-triggered-dma-buffer".
+
+endmenu
diff --git a/drivers/iio/offload/Makefile b/drivers/iio/offload/Makefile
new file mode 100644
index 000000000000..7300ce82f066
--- /dev/null
+++ b/drivers/iio/offload/Makefile
@@ -0,0 +1,2 @@
+
+obj-$(CONFIG_IIO_PWM_TRIGGERED_DMA_BUFFER) := iio-pwm-triggered-dma-buffer.o
diff --git a/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c b/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
new file mode 100644
index 000000000000..970ea82316f6
--- /dev/null
+++ b/drivers/iio/offload/iio-pwm-triggered-dma-buffer.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Platform driver for a PWM trigger and DMA buffer connected to a SPI
+ * controller offload instance implementing the iio-hw-triggered-buffer
+ * interface.
+ *
+ * Copyright (C) 2023 Analog Devices, Inc.
+ * Copyright (C) 2023 BayLibre, SAS
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/pwm.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/hw_triggered_buffer_impl.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/sysfs.h>
+
+struct iio_pwm_triggered_dma_buffer {
+	struct iio_hw_triggered_buffer_device hw;
+	struct pwm_device *pwm;
+};
+
+static const struct iio_trigger_ops iio_pwm_triggered_dma_buffer_ops;
+
+static int iio_pwm_triggered_dma_buffer_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_pwm_triggered_dma_buffer *st = iio_trigger_get_drvdata(trig);
+
+	if (state)
+		return pwm_enable(st->pwm);
+
+	pwm_disable(st->pwm);
+
+	return 0;
+}
+
+static int iio_pwm_triggered_dma_buffer_validate_device(struct iio_trigger *trig,
+							struct iio_dev *indio_dev)
+{
+	/* Don't allow assigning trigger via sysfs. */
+	return -EINVAL;
+}
+
+static const struct iio_trigger_ops iio_pwm_triggered_dma_buffer_ops = {
+	.set_trigger_state = iio_pwm_triggered_dma_buffer_set_state,
+	.validate_device = iio_pwm_triggered_dma_buffer_validate_device,
+};
+
+static u32 axi_spi_engine_offload_pwm_trigger_get_rate(struct iio_trigger *trig)
+{
+	struct iio_pwm_triggered_dma_buffer *st = iio_trigger_get_drvdata(trig);
+	u64 period_ns = pwm_get_period(st->pwm);
+
+	if (period_ns)
+		return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, period_ns);
+
+	return 0;
+}
+
+static int
+axi_spi_engine_offload_set_samp_freq(struct iio_pwm_triggered_dma_buffer *st,
+				     u32 requested_hz)
+{
+	int period_ns;
+
+	if (requested_hz == 0)
+		return -EINVAL;
+
+	period_ns = DIV_ROUND_UP(NSEC_PER_SEC, requested_hz);
+
+	/*
+	 * FIXME: We really just need a clock, not a PWM. The current duty cycle
+	 * value is a hack to work around the edge vs. level offload trigger
+	 * issue in the ADI AXI SPI Engine firmware.
+	 */
+	return pwm_config(st->pwm, 10, period_ns);
+}
+
+static ssize_t sampling_frequency_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct iio_trigger *trig = to_iio_trigger(dev);
+
+	return sysfs_emit(buf, "%u\n",
+			  axi_spi_engine_offload_pwm_trigger_get_rate(trig));
+}
+
+static ssize_t sampling_frequency_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct iio_trigger *trig = to_iio_trigger(dev);
+	struct iio_pwm_triggered_dma_buffer *st = iio_trigger_get_drvdata(trig);
+	int ret;
+	u32 val;
+
+	ret = kstrtou32(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = axi_spi_engine_offload_set_samp_freq(st, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static DEVICE_ATTR_RW(sampling_frequency);
+
+static struct attribute *iio_pwm_triggered_dma_buffer_attrs[] = {
+	&dev_attr_sampling_frequency.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(iio_pwm_triggered_dma_buffer);
+
+static void iio_pwm_triggered_dma_buffer_adev_release(struct device *dev)
+{
+}
+
+static void iio_pwm_triggered_dma_buffer_unregister_adev(void *adev)
+{
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int iio_pwm_triggered_dma_buffer_probe(struct platform_device *pdev)
+{
+	struct iio_pwm_triggered_dma_buffer *st;
+	struct auxiliary_device *adev;
+	int ret;
+
+	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->pwm = devm_pwm_get(&pdev->dev, NULL);
+	if (IS_ERR(st->pwm))
+		return dev_err_probe(&pdev->dev, PTR_ERR(st->pwm),
+				     "failed to get PWM\n");
+
+	st->hw.buffer = devm_iio_dmaengine_buffer_alloc(&pdev->dev, "rx");
+	if (IS_ERR(st->hw.buffer))
+		return dev_err_probe(&pdev->dev, PTR_ERR(st->hw.buffer),
+				     "failed to allocate buffer\n");
+
+	st->hw.trig = devm_iio_trigger_alloc(&pdev->dev, "%s-%s-pwm-trigger",
+					     dev_name(pdev->dev.parent),
+					     dev_name(&pdev->dev));
+	if (!st->hw.trig)
+		return -ENOMEM;
+
+	st->hw.trig->ops = &iio_pwm_triggered_dma_buffer_ops;
+	st->hw.trig->dev.parent = &pdev->dev;
+	st->hw.trig->dev.groups = iio_pwm_triggered_dma_buffer_groups;
+	iio_trigger_set_drvdata(st->hw.trig, st);
+
+	/* start with a reasonable default value */
+	ret = axi_spi_engine_offload_set_samp_freq(st, 1000);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to set sampling frequency\n");
+
+	ret = devm_iio_trigger_register(&pdev->dev, st->hw.trig);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register trigger\n");
+
+	adev = &st->hw.adev;
+	adev->name = "triggered-buffer";
+	adev->dev.parent = &pdev->dev;
+	adev->dev.release = iio_pwm_triggered_dma_buffer_adev_release;
+	adev->id = 0;
+
+	ret = auxiliary_device_init(adev);
+	if (ret)
+		return ret;
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(&pdev->dev,
+			iio_pwm_triggered_dma_buffer_unregister_adev, adev);
+}
+
+static const struct of_device_id iio_pwm_triggered_dma_buffer_match_table[] = {
+	{ .compatible = "adi,spi-offload-pwm-trigger-dma-buffer" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, iio_pwm_triggered_dma_buffer_match_table);
+
+static struct platform_driver iio_pwm_triggered_dma_buffer_driver = {
+	.probe = iio_pwm_triggered_dma_buffer_probe,
+	.driver = {
+		.name = "iio-pwm-triggered-dma-buffer",
+		.of_match_table = iio_pwm_triggered_dma_buffer_match_table,
+	},
+};
+module_platform_driver(iio_pwm_triggered_dma_buffer_driver);
+
+MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
+MODULE_DESCRIPTION("AXI SPI Engine Offload PWM Trigger");
+MODULE_LICENSE("GPL");

-- 
2.43.0


