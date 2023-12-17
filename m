Return-Path: <linux-kernel+bounces-2572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF29815EF1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2087E282D8B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E635A347AC;
	Sun, 17 Dec 2023 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg57VAxc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F60932C84;
	Sun, 17 Dec 2023 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5522ba3f94aso2302702a12.1;
        Sun, 17 Dec 2023 04:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702815644; x=1703420444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV4tUKQSEvk0f5P2I2zO6ntBly6ayKPyNhOH2Mn+g8s=;
        b=jg57VAxcgbF2rOowVFsQPmOxP8G5F26W5wUOSvfti/iYYJwNLTtHMxOHffFNCeeuSo
         31hJ9Lcb49HEFph8uUlGcN8jVL1PGWKbBc7T182kb85ZTDzS4RUzISBF1fn3z4yx2Qaf
         3KMahk3WgTQ2jP25RAr8RdOwFgEopWCWVN++juZkpQ/6sdhmJIL0pK8CgNCxTW8Fp0KA
         3eusVteWc9lynM2Hh+qLMXdKEEPcN3Ypp47JtXbR9sX1gIEBOySWcH2OnqgNX/YdUbBf
         RcMNwpnyY6Tam7HiFCmX6edRtd7mui7emK9zVE3tYfFmKK9FUs37GtlpnKO9oAnD3uJw
         t+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702815644; x=1703420444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SV4tUKQSEvk0f5P2I2zO6ntBly6ayKPyNhOH2Mn+g8s=;
        b=EQkpYHN+J02iD8oSaTkSUKSbrHHK6sawXBaBsyf60d6YHbVEIz2ohoqh5wkZJzPrYc
         qyFQxWR29rGtI2cs5NYtra4PuvfazhwE+Gi6RL/lze9LsOkHosCucsd+lbZ5Y2aVsgrM
         C4w1NstkaZxczPcAWCEccxbVe/xARMPFZslSHvWZBegFpEHII6Yi0XekN2diY1y5Tkue
         SAkGHlfawjxywqaSyquKp7vIck3o5wzDbsjHgZY1yG7DGwt8/o3piRgAsEkg63F8vJfR
         CiY4e7jYfNb6fsidERpp+DQc6P7Eo2CKuPtDE/M+tK1WBj1V6mPYpPRCVWnSLrp4nFUO
         d+1Q==
X-Gm-Message-State: AOJu0YyY8qbVh8HyTkqRfCxeNVYvjVw3rubSFGby4cmuC6hjZSDE05Lo
	z6NldfntxXBNa5XNQ7RWN3QDDq320JLwMA==
X-Google-Smtp-Source: AGHT+IH8ZCpwS6c9At/ojDrFTRbi4L+arpGWf7pVBbrjc7rf0y5Q6S3Al2ji4pl6zZYPu/ghwxnEtQ==
X-Received: by 2002:a50:c251:0:b0:552:918f:1346 with SMTP id t17-20020a50c251000000b00552918f1346mr1524393edf.80.1702815644428;
        Sun, 17 Dec 2023 04:20:44 -0800 (PST)
Received: from localhost.localdomain (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id es21-20020a056402381500b0055267663784sm3495621edb.11.2023.12.17.04.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 04:20:44 -0800 (PST)
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Winklhofer <cj.winklhofer@gmail.com>
Subject: [PATCH 2/2] w1: add UART w1 bus driver
Date: Sun, 17 Dec 2023 13:20:04 +0100
Message-ID: <20231217122004.42795-3-cj.winklhofer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217122004.42795-1-cj.winklhofer@gmail.com>
References: <20231217122004.42795-1-cj.winklhofer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a UART 1-wire bus driver. The driver utilizes the UART interface via
the Serial Device Bus to create the 1-wire timing patterns. The driver
was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
DART-6UL" with a DS18S20 temperature sensor.

The 1-wire timing pattern and the corresponding UART baud-rate with the
interpretation of the transferred bytes are described in the document:

Link: https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html

In short, the UART peripheral must support full-duplex and operate in
open-drain mode. The timing patterns are generated by a specific
combination of baud-rate and transmitted byte, which corresponds to a
1-Wire read bit, write bit or reset.

Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
---
 Documentation/w1/masters/index.rst   |   1 +
 Documentation/w1/masters/w1-uart.rst |  48 +++++++
 drivers/w1/masters/Kconfig           |  10 ++
 drivers/w1/masters/Makefile          |   1 +
 drivers/w1/masters/w1-uart.c         | 189 +++++++++++++++++++++++++++
 5 files changed, 249 insertions(+)
 create mode 100644 Documentation/w1/masters/w1-uart.rst
 create mode 100644 drivers/w1/masters/w1-uart.c

diff --git a/Documentation/w1/masters/index.rst b/Documentation/w1/masters/index.rst
index 4442a98850ad..cc40189909fd 100644
--- a/Documentation/w1/masters/index.rst
+++ b/Documentation/w1/masters/index.rst
@@ -12,3 +12,4 @@
    mxc-w1
    omap-hdq
    w1-gpio
+   w1-uart
diff --git a/Documentation/w1/masters/w1-uart.rst b/Documentation/w1/masters/w1-uart.rst
new file mode 100644
index 000000000000..0f546cf77f13
--- /dev/null
+++ b/Documentation/w1/masters/w1-uart.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=====================
+Kernel driver w1-uart
+=====================
+
+Author: Christoph Winklhofer <cj.winklhofer@gmail.com>
+
+
+Description
+-----------
+
+UART 1-wire bus driver. The driver utilizes the UART interface via the
+Serial Device Bus to create the 1-Wire timing patterns as described in
+the document `"Using a UART to Implement a 1-Wire Bus Master"`_.
+
+.. _"Using a UART to Implement a 1-Wire Bus Master": https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html
+
+In short, the UART peripheral must support full-duplex and operate in
+open-drain mode. The timing patterns are generated by a specific
+combination of baud-rate and transmitted byte, which corresponds to a
+1-Wire read bit, write bit or reset pulse.
+
+For instance the timing pattern for a 1-Wire reset and presence detect uses
+the baud-rate 9600, i.e. 104.2 us per bit. The transmitted byte 0xf0 over
+UART (least significant bit first, start-bit low) sets the reset low time
+for 1-Wire to 521 us. A present 1-Wire device changes the received byte by
+pulling the line low, which is used by the driver to evaluate the result of
+the 1-Wire operation.
+
+Similar for a 1-Wire read bit or write bit, which uses the baud-rate
+115200, i.e. 8.7 us per bit. The transmitted byte 0x00 is used for a
+Write-0 operation and the byte 0xff for Read-0, Read-1 and Write-1.
+
+
+Usage
+-----
+
+Specify the UART 1-wire bus in the device tree by adding the single child
+onewire to the serial node (e.g. uart0). For example:
+::
+
+  @uart0 {
+    ...
+    onewire {
+      compatible = "w1-uart";
+    };
+  };
diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 513c0b114337..e6049a75b35b 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -78,5 +78,15 @@ config W1_MASTER_SGI
 	  This support is also available as a module.  If so, the module
 	  will be called sgi_w1.
 
+config W1_MASTER_UART
+	tristate "UART 1-wire driver"
+	depends on SERIAL_DEV_BUS
+	help
+	  Say Y here if you want to communicate with your 1-wire devices using
+	  UART interface.
+
+	  This support is also available as a module.  If so, the module
+	  will be called w1-uart.
+
 endmenu
 
diff --git a/drivers/w1/masters/Makefile b/drivers/w1/masters/Makefile
index 6c5a21f9b88c..227f80987e69 100644
--- a/drivers/w1/masters/Makefile
+++ b/drivers/w1/masters/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_W1_MASTER_MXC)		+= mxc_w1.o
 obj-$(CONFIG_W1_MASTER_GPIO)		+= w1-gpio.o
 obj-$(CONFIG_HDQ_MASTER_OMAP)		+= omap_hdq.o
 obj-$(CONFIG_W1_MASTER_SGI)		+= sgi_w1.o
+obj-$(CONFIG_W1_MASTER_UART)		+= w1-uart.o
diff --git a/drivers/w1/masters/w1-uart.c b/drivers/w1/masters/w1-uart.c
new file mode 100644
index 000000000000..e0da8ebfef58
--- /dev/null
+++ b/drivers/w1/masters/w1-uart.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * w1-uart - UART 1-Wire bus driver
+ *
+ * Uses the UART interface (via Serial Device Bus) to create the 1-Wire
+ * timing patterns. Implements the following 1-Wire master interface:
+ *
+ * - reset_bus: baud-rate 9600 (bit time 104.2 us) and tx-byte 0xf0
+ *
+ * - touch_bit: baud-rate 115200 (bit time 8.7 us) and tx-byte 0x00
+ *              (Write-0) or 0xff (Read-0, Read-1, Write-1)
+ *
+ * Author: Christoph Winklhofer <cj.winklhofer@gmail.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
+#include <linux/w1.h>
+
+#define W1_UART_TIMEOUT msecs_to_jiffies(500)
+
+struct w1_uart_device {
+	struct serdev_device *serdev;
+	struct w1_bus_master bus;
+
+	struct completion buf_received;
+	atomic_t buf;
+
+	unsigned int baudrate;
+};
+
+/*
+ * Send one byte (tx_byte) and read one byte (rx_byte) via serdev.
+ */
+static int w1_uart_serdev_tx_rx(struct w1_uart_device *w1dev,
+				unsigned int baudrate, unsigned char tx_byte,
+				unsigned char *rx_byte)
+{
+	struct serdev_device *serdev = w1dev->serdev;
+	struct device *dev = &serdev->dev;
+	int ret;
+
+	serdev_device_write_flush(serdev);
+	if (w1dev->baudrate != baudrate) {
+		w1dev->baudrate = serdev_device_set_baudrate(serdev, baudrate);
+		if (w1dev->baudrate != baudrate) {
+			dev_err(dev, "set baudrate failed\n");
+			return -1;
+		}
+	}
+
+	reinit_completion(&w1dev->buf_received);
+	ret = serdev_device_write_buf(serdev, &tx_byte, 1);
+	if (ret != 1) {
+		dev_err(dev, "write failed\n");
+		return -1;
+	}
+	ret = wait_for_completion_interruptible_timeout(&w1dev->buf_received,
+							W1_UART_TIMEOUT);
+	if (ret <= 0) {
+		dev_err(dev, "receive failed\n");
+		return -1;
+	}
+
+	*rx_byte = (unsigned char)atomic_read(&w1dev->buf);
+	return 0;
+}
+
+static int w1_uart_serdev_receive_buf(struct serdev_device *serdev,
+				      const unsigned char *buf, size_t count)
+{
+	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
+
+	if (count > 0) {
+		atomic_set(&w1dev->buf, buf[count - 1]);
+		complete(&w1dev->buf_received);
+	}
+
+	return count;
+}
+
+static const struct serdev_device_ops w1_uart_serdev_ops = {
+	.receive_buf = w1_uart_serdev_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+/*
+ * 1-wire reset and presence detect:
+ * The baud-rate 9600 (104.2 us per bit) and the byte 0xf0 generates a
+ * reset low time of 521 us (start-bit low). A present slave will
+ * manipulate the received byte by pulling the 1-wire low.
+ */
+static u8 w1_uart_reset_bus(void *data)
+{
+	struct w1_uart_device *w1dev = data;
+	unsigned char buf;
+	int ret;
+
+	ret = w1_uart_serdev_tx_rx(w1dev, 9600, 0xf0, &buf);
+	if (ret < 0)
+		return -1;
+
+	/* Device present (0) or no device (1) */
+	return buf != 0xf0 ? 0 : 1;
+}
+
+/*
+ * 1-Wire read and write cycle:
+ * The baud-rate 115200 (8.7 us per bit) and the byte 0xff generates the
+ * timing pattern for Read-0, Read-1 and Write-1 operation, with a low
+ * time of 8.7 us (start-bit low). Only the Read-0 manipulates the
+ * received byte, all others left the line untouched.
+ */
+static u8 w1_uart_touch_bit(void *data, u8 bit)
+{
+	struct w1_uart_device *w1dev = data;
+	unsigned char buf;
+	int ret;
+
+	ret = w1_uart_serdev_tx_rx(w1dev, 115200, bit ? 0xff : 0x00, &buf);
+	/* return inactive bus state on error */
+	if (ret < 0)
+		return 1;
+
+	return buf == 0xff ? 1 : 0;
+}
+
+static int w1_uart_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct w1_uart_device *w1dev;
+	int ret;
+
+	w1dev = devm_kzalloc(dev, sizeof(struct w1_uart_device), GFP_KERNEL);
+	if (!w1dev)
+		return -ENOMEM;
+	w1dev->bus.data = w1dev;
+	w1dev->bus.reset_bus = w1_uart_reset_bus;
+	w1dev->bus.touch_bit = w1_uart_touch_bit;
+	w1dev->serdev = serdev;
+
+	serdev_device_set_drvdata(serdev, w1dev);
+	serdev_device_set_client_ops(serdev, &w1_uart_serdev_ops);
+
+	init_completion(&w1dev->buf_received);
+
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret < 0)
+		return ret;
+	serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	serdev_device_set_flow_control(serdev, false);
+
+	return w1_add_master_device(&w1dev->bus);
+}
+
+static void w1_uart_remove(struct serdev_device *serdev)
+{
+	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
+
+	complete(&w1dev->buf_received);
+	w1_remove_master_device(&w1dev->bus);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id w1_uart_of_match[] = {
+	{ .compatible = "w1-uart" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, w1_uart_of_match);
+#endif
+
+static struct serdev_device_driver w1_uart_driver = {
+	.driver	= {
+		.name		= "w1-uart",
+		.of_match_table	= of_match_ptr(w1_uart_of_match),
+	},
+	.probe	= w1_uart_probe,
+	.remove	= w1_uart_remove,
+};
+
+module_serdev_device_driver(w1_uart_driver);
+
+MODULE_DESCRIPTION("UART w1 bus driver");
+MODULE_AUTHOR("Christoph Winklhofer <cj.winklhofer@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


