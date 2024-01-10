Return-Path: <linux-kernel+bounces-22679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4591382A175
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A401F23A14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729794F8BE;
	Wed, 10 Jan 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t5cFwVVr"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA04F5F4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-598699c0f1eso1522518eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916277; x=1705521077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7PWqKKUmIJfOHhEo7bhsOSHT+T28MHjs59pcUd3qYA=;
        b=t5cFwVVrDBIe40U3IAx7Z1O+47Lx54RlcTqA3y0fMFCB64JCJhuuZpRxk00nUy1m7h
         KfKCp9HBFNuikxuFJ4nyxFfQEZNvZn+V8lsornUMDLTtrxya/FWDNToWAt55IcK3w4AF
         WBI+oMOCWY7OKRuKaRecyMQONOop4mfIenpX34EUFWprGnUrml0Gw3x42DtrDjy0wvGE
         zLuvtEiWo3ctyWLpkMd4zwjnBaO9TuxBTKRXbDPnMgyfVcCXJ4LLd+664kIGTKYxcsfc
         in/BI5UiCACx+64qcV4ID97rqUzxl3BBFR1E/DuO6xQTeX7xU9nzOH5pmekUBjxZ/f5b
         Izpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916277; x=1705521077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7PWqKKUmIJfOHhEo7bhsOSHT+T28MHjs59pcUd3qYA=;
        b=jtpEC2GEduBpDFyRhDp4MGAgQWY/EYuGaU1iGiEiXy2iYiv28agWgB9Tk1jXR6Rv8q
         U+N8cKllCU2lNkBovVBbeemnOmJqVuXVofBBQ/1+OHQPj7CnOGodplNfLMvXyJgkPBvT
         zj8wqwHMqeHS39lQjI5tYCQUNOjObM9c1wumH0240/2ylo0oxJYfZ+EF0HPpbkQD+axQ
         9CHvxWTQ84/pZEMDPRBnDErHkRZ24AlP4lJul3BE98Quzb5tw4FKR4kkNJ9VCk0czJVf
         3u+NSxFY6kMBXR5DyJX3F+NeEKRubTwZGKB1wEDcykBiobo1/z+QjUfpPAOKVG7itGCc
         6nHQ==
X-Gm-Message-State: AOJu0YwdSmu1u8d42mqNDb+A8jgAOZCg3ToZozR9fwdAV+aFpGWAinF4
	k6xuvn0kk0vcOdm+OTuEsBV0GqtrXEFPIw==
X-Google-Smtp-Source: AGHT+IG/pQstA269+Q9le7ThaVf0owpqSI3RhN8sLNCjdHTp/Q1xvhsyx76vcyZGXAyczFLDe5FZbA==
X-Received: by 2002:a4a:9b17:0:b0:591:c16b:eb29 with SMTP id a23-20020a4a9b17000000b00591c16beb29mr92673ook.13.1704916276715;
        Wed, 10 Jan 2024 11:51:16 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:16 -0800 (PST)
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
Subject: [PATCH 08/13] iio: buffer: add new hardware triggered buffer driver
Date: Wed, 10 Jan 2024 13:49:49 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-8-e42c6a986580@baylibre.com>
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

This adds a new hardware triggered buffer driver for the IIO subsystem.
This driver is intended to be used by IIO device drivers that have
a hardware buffer that is triggered by a hardware signal.

It is expected that components such as those providing a backend via the
IIO backend framework will provide the actual implementation of this
functionality by registering a matching device on the auxiliary bus.
The auxiliary bus was chosen since it allows us to make use of existing
kernel infrastructure instead of implementing our own registration and
lookup system.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/driver-api/driver-model/devres.rst   |   1 +
 drivers/iio/buffer/Kconfig                         |   7 ++
 drivers/iio/buffer/Makefile                        |   1 +
 .../iio/buffer/industrialio-hw-triggered-buffer.c  | 104 +++++++++++++++++++++
 include/linux/iio/hw_triggered_buffer.h            |  14 +++
 include/linux/iio/hw_triggered_buffer_impl.h       |  16 ++++
 6 files changed, 143 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index c5f99d834ec5..b23d4a2b68a6 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -296,6 +296,7 @@ IIO
   devm_iio_channel_get()
   devm_iio_channel_get_all()
   devm_iio_hw_consumer_alloc()
+  devm_iio_hw_triggered_buffer_setup()
   devm_fwnode_iio_channel_get_by_name()
 
 INPUT
diff --git a/drivers/iio/buffer/Kconfig b/drivers/iio/buffer/Kconfig
index 047b931591a9..925c5bf074bc 100644
--- a/drivers/iio/buffer/Kconfig
+++ b/drivers/iio/buffer/Kconfig
@@ -53,3 +53,10 @@ config IIO_TRIGGERED_BUFFER
 	select IIO_KFIFO_BUF
 	help
 	  Provides helper functions for setting up triggered buffers.
+
+config IIO_HW_TRIGGERED_BUFFER
+	tristate "Industrial I/O hardware triggered buffer support"
+	select AUXILIARY_BUS
+	select IIO_TRIGGER
+	help
+	  Provides helper functions for setting up hardware triggered buffers.
diff --git a/drivers/iio/buffer/Makefile b/drivers/iio/buffer/Makefile
index 1403eb2f9409..d1142bb20f61 100644
--- a/drivers/iio/buffer/Makefile
+++ b/drivers/iio/buffer/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_IIO_BUFFER_DMA) += industrialio-buffer-dma.o
 obj-$(CONFIG_IIO_BUFFER_DMAENGINE) += industrialio-buffer-dmaengine.o
 obj-$(CONFIG_IIO_BUFFER_HW_CONSUMER) += industrialio-hw-consumer.o
 obj-$(CONFIG_IIO_TRIGGERED_BUFFER) += industrialio-triggered-buffer.o
+obj-$(CONFIG_IIO_HW_TRIGGERED_BUFFER) += industrialio-hw-triggered-buffer.o
 obj-$(CONFIG_IIO_KFIFO_BUF) += kfifo_buf.o
diff --git a/drivers/iio/buffer/industrialio-hw-triggered-buffer.c b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
new file mode 100644
index 000000000000..7a8a71066b0e
--- /dev/null
+++ b/drivers/iio/buffer/industrialio-hw-triggered-buffer.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Analog Devices, Inc.
+ * Copyright (c) 2024 BayLibre, SAS
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/container_of.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/iio/hw_triggered_buffer_impl.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+
+static int iio_hw_triggered_buffer_match(struct device *dev, const void *match)
+{
+	return dev->parent == match;
+}
+
+static struct iio_hw_triggered_buffer_device
+*iio_hw_trigger_buffer_get(struct device *match)
+{
+	struct auxiliary_device *adev;
+
+	adev = auxiliary_find_device(NULL, match, iio_hw_triggered_buffer_match);
+	if (!adev)
+		return ERR_PTR(-ENOENT);
+
+	return container_of(adev, struct iio_hw_triggered_buffer_device, adev);
+}
+
+static void iio_hw_trigger_buffer_put(void *dev)
+{
+	put_device(dev);
+}
+
+/**
+ * devm_iio_hw_triggered_buffer_setup - Setup a hardware triggered buffer
+ * @dev:	Device for devm management
+ * @indio_dev:	An unconfigured/partially configured IIO device struct
+ * @match:	Device for matching the auxiliary bus device that provides the
+ *		interface to the hardware triggered buffer
+ * @ops:	Buffer setup functions to use for this IIO device
+ *
+ * Return: 0 on success, negative error code on failure.
+ *
+ * This function will search all registered hardware triggered buffers for one
+ * that matches the given indio_dev. If found, it will be used to setup both
+ * the trigger and the buffer on the indio_dev.
+ */
+int devm_iio_hw_triggered_buffer_setup(struct device *dev,
+				       struct iio_dev *indio_dev,
+				       struct device *match,
+				       const struct iio_buffer_setup_ops *ops)
+{
+	struct iio_hw_triggered_buffer_device *hw;
+	int ret;
+
+	hw = iio_hw_trigger_buffer_get(match);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	ret = devm_add_action_or_reset(dev, iio_hw_trigger_buffer_put, &hw->adev.dev);
+	if (ret)
+		return ret;
+
+	indio_dev->modes |= INDIO_HW_BUFFER_TRIGGERED;
+	indio_dev->trig = iio_trigger_get(hw->trig);
+	indio_dev->setup_ops = ops;
+
+	return iio_device_attach_buffer(indio_dev, hw->buffer);
+}
+EXPORT_SYMBOL_GPL(devm_iio_hw_triggered_buffer_setup);
+
+static int iio_hw_trigger_buffer_probe(struct auxiliary_device *adev,
+				       const struct auxiliary_device_id *id)
+{
+	struct iio_hw_triggered_buffer_device *hw =
+		container_of(adev, struct iio_hw_triggered_buffer_device, adev);
+
+	if (!hw->buffer || !hw->trig)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct auxiliary_device_id iio_hw_trigger_buffer_id_table[] = {
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, iio_hw_trigger_buffer_id_table);
+
+static struct auxiliary_driver iio_hw_trigger_buffer_driver = {
+	.driver = {
+		.name = "iio-hw-triggered-buffer",
+	},
+	.probe = iio_hw_trigger_buffer_probe,
+	.id_table = iio_hw_trigger_buffer_id_table,
+};
+module_auxiliary_driver(iio_hw_trigger_buffer_driver);
+
+MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
+MODULE_DESCRIPTION("IIO helper functions for setting up hardware triggered buffers");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/hw_triggered_buffer.h b/include/linux/iio/hw_triggered_buffer.h
new file mode 100644
index 000000000000..6bd8035f1b92
--- /dev/null
+++ b/include/linux/iio/hw_triggered_buffer.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IIO_HW_TRIGGEREDED_BUFFER_H_
+#define _LINUX_IIO_HW_TRIGGEREDED_BUFFER_H_
+
+struct device;
+struct iio_dev;
+struct iio_buffer_setup_ops;
+
+int devm_iio_hw_triggered_buffer_setup(struct device *dev,
+				       struct iio_dev *indio_dev,
+				       struct device *match,
+				       const struct iio_buffer_setup_ops *ops);
+
+#endif /* _LINUX_IIO_HW_TRIGGEREDED_BUFFER_H_ */
diff --git a/include/linux/iio/hw_triggered_buffer_impl.h b/include/linux/iio/hw_triggered_buffer_impl.h
new file mode 100644
index 000000000000..d9a3ad2c8c24
--- /dev/null
+++ b/include/linux/iio/hw_triggered_buffer_impl.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IIO_HW_TRIGGEREDED_BUFFER_IMPL_H_
+#define _LINUX_IIO_HW_TRIGGEREDED_BUFFER_IMPL_H_
+
+#include <linux/auxiliary_bus.h>
+
+struct iio_buffer;
+struct iio_trigger;
+
+struct iio_hw_triggered_buffer_device {
+	struct auxiliary_device adev;
+	struct iio_buffer *buffer;
+	struct iio_trigger *trig;
+};
+
+#endif /* _LINUX_IIO_HW_TRIGGEREDED_BUFFER_IMPL_H_ */

-- 
2.43.0


