Return-Path: <linux-kernel+bounces-10376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819FE81D380
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52981C21942
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F3FDDA0;
	Sat, 23 Dec 2023 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U234a5ha"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94CCA56;
	Sat, 23 Dec 2023 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a268836254aso297566566b.1;
        Sat, 23 Dec 2023 02:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703325857; x=1703930657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u1s4557zbTOOS16Lfx7qWy5eSiqww2Gpgji4CedyAA=;
        b=U234a5haMD/fdE7dMDmZ4fjMsXQSGTUqwN9h2HRlXcU5ghlSZDeeKlbCpe9x/X99rb
         Ox+URxDwWOYXFDYqBKkDabHLJE6h1VMtlA9nDtGjqWx3nd+tKCbg2u3qTo+fCpB+ELwK
         r9YI1zpRoXXKC/1gGgC99tLv3SZuOhSVDdGt3F+NWCGgHrtMr1pQr+f4Gk7Eu151ISPZ
         mQMwHZfRAB3gzk6c6hDhJNhHMB5Z8DkmOp2Qp0TTOtf1PUPPXJibLx+w6trnxK84KWmZ
         0n9Zr3eikU77s4h6mCk/efeFiV6eljwSXN+2sj0zf15IePqc+S0sNpqFQBGOv8sFYUPU
         QkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703325857; x=1703930657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u1s4557zbTOOS16Lfx7qWy5eSiqww2Gpgji4CedyAA=;
        b=swCUt+BgvnpTqSh9t8Q9qtEoW5T2XcfoJKD4eak0df9q+4qm0Ck+5ETSGZngqsZw2/
         /CeEf/WCLuRLx356o0dJ7vlOuN18brnF7kBAe08faqJBEwN8OtESvfWKhQqomqzNiSxq
         j7KcfyChd3A5DGrMak9CqaRYHCnYhPZs7IytHjLzPLWEilSaWoGid+1rdBBHpRQv364R
         sSVHtYMZ7zvox/XLQcsHfN37z6M/tBAzHsYXlr02FLT/OhZqMEjuT8HafWqPKdzY3MEP
         Z4hIPcojKWIxQ3QzHnQ7/Gb03GlNSzbZkjsN71cWalgj00Qk5R5pNkcpBrQEeHucr4oz
         g+eg==
X-Gm-Message-State: AOJu0YzTECMMiXn7Olx5Qzy9JwTXcpOQEDVmt4Dyt6vwIGjtFxsfcc9f
	nrI3DkZrZL9lg97SpG2i+nQ=
X-Google-Smtp-Source: AGHT+IH30mMmOZYCPEJXW3gSwe93qKkub0ja/IINtiUOynwy5/CnZIrYObFP935E2JE7Xkl4wG7VGA==
X-Received: by 2002:a17:906:3a8e:b0:a26:9920:abe0 with SMTP id y14-20020a1709063a8e00b00a269920abe0mr1304681ejd.62.1703325857011;
        Sat, 23 Dec 2023 02:04:17 -0800 (PST)
Received: from cjw-notebook.. (188-23-116-43.adsl.highway.telekom.at. [188.23.116.43])
        by smtp.gmail.com with ESMTPSA id su24-20020a17090703d800b00a26ab41d0f7sm2357765ejb.26.2023.12.23.02.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 02:04:16 -0800 (PST)
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christoph Winklhofer <cj.winklhofer@gmail.com>
Subject: [PATCH v2 3/3] w1: add UART w1 bus driver
Date: Sat, 23 Dec 2023 11:04:08 +0100
Message-ID: <20231223100408.44056-4-cj.winklhofer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223100408.44056-1-cj.winklhofer@gmail.com>
References: <20231223100408.44056-1-cj.winklhofer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
the Serial Device Bus to create the 1-Wire timing patterns. The driver
was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
DART-6UL" with a DS18S20 temperature sensor.

The 1-Wire timing pattern and the corresponding UART baud-rate with the
interpretation of the transferred bytes are described in the document:

Link: https://www.analog.com/en/technical-articles/using-a-uart-to-implement-a-1wire-bus-master.html

In short, the UART peripheral must support full-duplex and operate in
open-drain mode. The timing patterns are generated by a specific
combination of baud-rate and transmitted byte, which corresponds to a
1-Wire read bit, write bit or reset.

Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
---
 Documentation/w1/masters/index.rst   |   1 +
 Documentation/w1/masters/w1-uart.rst |  53 +++++
 drivers/w1/masters/Kconfig           |  10 +
 drivers/w1/masters/Makefile          |   1 +
 drivers/w1/masters/w1-uart.c         | 307 +++++++++++++++++++++++++++
 5 files changed, 372 insertions(+)
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
index 000000000000..2d9d5ec93ddd
--- /dev/null
+++ b/Documentation/w1/masters/w1-uart.rst
@@ -0,0 +1,53 @@
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
+UART 1-Wire bus driver. The driver utilizes the UART interface via the
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
+The default baud-rate for reset and presence detection is 9600 and for
+a 1-Wire read or write operation 115200. In case the actual baud-rate
+is different from the requested one, the transmitted byte is adapted
+to generate the 1-Wire timing patterns.
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
index 000000000000..6303c8a2a53a
--- /dev/null
+++ b/drivers/w1/masters/w1-uart.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * w1-uart - UART 1-Wire bus driver
+ *
+ * Uses the UART interface (via Serial Device Bus) to create the 1-Wire
+ * timing patterns. Implements the following 1-Wire master interface:
+ *
+ * - reset_bus: requests baud-rate 9600
+ *
+ * - touch_bit: requests baud-rate 115200
+ *
+ * Author: Christoph Winklhofer <cj.winklhofer@gmail.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/completion.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
+#include <linux/w1.h>
+
+#define W1_UART_TIMEOUT msecs_to_jiffies(500)
+
+#define baud_to_bit_us(baud) (1000000 / baud)
+
+struct w1_uart_device {
+	struct serdev_device *serdev;
+	struct w1_bus_master bus;
+
+	unsigned int baud_reset;
+	unsigned char tx_reset;
+
+	unsigned int baud_touch;
+	unsigned char tx_touch;
+
+	struct completion rx_byte_received;
+	unsigned char rx_byte;
+	int rx_err;
+
+	struct mutex mutex;
+};
+
+/*
+ * Set baud-rate and tx-byte for 1-Wire reset and presence detect and
+ * adapt the tx-byte according to the actual baud-rate.
+ *
+ * Minimum reset low time is 480us and the response from a 1-Wire
+ * device is at around 570us. Reject when a bit takes longer than
+ * 500us or is to short to detect a manipulated byte.
+ *
+ */
+static int w1_uart_set_baud_reset(struct w1_uart_device *w1dev)
+{
+	struct serdev_device *serdev = w1dev->serdev;
+	unsigned int bit_us;
+	unsigned int bits_low;
+
+	w1dev->baud_reset = serdev_device_set_baudrate(serdev, 9600);
+	if (w1dev->baud_reset == 0)
+		return -EINVAL;
+
+	bit_us = baud_to_bit_us(w1dev->baud_reset);
+
+	/* reset low time is 480us */
+	if (bit_us > 500)
+		return -EINVAL;
+
+	/* At least Bit-8 should be manipulated by a present device,
+	 * which is at 570us. Bit-8 and start-bit: 9 * 65us
+	 */
+	if (bit_us < 65)
+		return -EINVAL;
+
+	/* byte to create reset pulse (start-bit is low) */
+	bits_low = 500 / bit_us;
+	w1dev->tx_reset = 0xff << bits_low;
+
+	return 0;
+}
+
+/*
+ * Set baud-rate and tx-byte for 1-Wire read and write cycle and
+ * adapt the tx-byte according to the actual baud-rate.
+ *
+ * Recommended low-time to initiate a Write-1 or Read is 6us. Time-slot
+ * for 1-Wire bit operation is 70us. Reject when a bit takes longer
+ * than 10us (recommended 6us) or the entire time-slot is to short.
+ */
+static int w1_uart_set_baud_touch(struct w1_uart_device *w1dev)
+{
+	struct serdev_device *serdev = w1dev->serdev;
+	unsigned int bits_low;
+	unsigned int bit_us;
+
+	w1dev->baud_touch = serdev_device_set_baudrate(serdev, 115200);
+	if (w1dev->baud_touch == 0)
+		return -EINVAL;
+
+	bit_us = baud_to_bit_us(w1dev->baud_touch);
+	/* low-time to start write-1 and read cycle */
+	if (bit_us > 10)
+		return -EINVAL;
+	/* 1-Wire time slot is 70 us */
+	if (bit_us < 7)
+		return -EINVAL;
+
+	/* max low time 10us */
+	bits_low = 5 / bit_us;
+	w1dev->tx_touch = 0xff << bits_low;
+
+	return 0;
+}
+
+static int w1_uart_serdev_open(struct w1_uart_device *w1dev)
+{
+	struct serdev_device *serdev = w1dev->serdev;
+	struct device *dev = &serdev->dev;
+	int ret;
+
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret < 0)
+		return ret;
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret < 0) {
+		dev_err(dev, "set parity failed\n");
+		return ret;
+	}
+
+	ret = w1_uart_set_baud_reset(w1dev);
+	if (ret < 0) {
+		dev_err(dev, "set baud-rate for reset failed\n");
+		return ret;
+	}
+
+	ret = w1_uart_set_baud_touch(w1dev);
+	if (ret < 0) {
+		dev_err(dev, "set baud-rate for touch failed\n");
+		return ret;
+	}
+
+	serdev_device_set_flow_control(serdev, false);
+
+	return 0;
+}
+
+/*
+ * Send one byte (tx_byte) and read one byte (rx_byte) via serdev.
+ */
+static int w1_uart_serdev_tx_rx(struct w1_uart_device *w1dev,
+				unsigned int baudrate, unsigned char tx_byte,
+				unsigned char *rx_byte)
+{
+	struct serdev_device *serdev = w1dev->serdev;
+	int ret;
+
+	serdev_device_write_flush(serdev);
+	serdev_device_set_baudrate(serdev, baudrate);
+
+	/* write and immediately read one byte */
+	reinit_completion(&w1dev->rx_byte_received);
+	ret = serdev_device_write_buf(serdev, &tx_byte, 1);
+	if (ret != 1)
+		return -EIO;
+	ret = wait_for_completion_interruptible_timeout(
+		&w1dev->rx_byte_received, W1_UART_TIMEOUT);
+	if (ret <= 0)
+		return -EIO;
+
+	/* locking could fail during driver remove or when serdev
+	 * is unexpectedly in the receive callback.
+	 */
+	if (!mutex_trylock(&w1dev->mutex))
+		return -EIO;
+
+	ret = w1dev->rx_err;
+	if (ret == 0)
+		*rx_byte = w1dev->rx_byte;
+
+	mutex_unlock(&w1dev->mutex);
+
+	return ret;
+}
+
+static int w1_uart_serdev_receive_buf(struct serdev_device *serdev,
+				      const unsigned char *buf, size_t count)
+{
+	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
+
+	mutex_lock(&w1dev->mutex);
+
+	/* sent a single byte and receive one single byte */
+	if (count == 1) {
+		w1dev->rx_byte = buf[0];
+		w1dev->rx_err = 0;
+	} else {
+		w1dev->rx_err = -EIO;
+	}
+
+	mutex_unlock(&w1dev->mutex);
+	complete(&w1dev->rx_byte_received);
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
+ * 1-wire reset and presence detect: A present slave will manipulate
+ * the received byte by pulling the 1-Wire low.
+ */
+static u8 w1_uart_reset_bus(void *data)
+{
+	struct w1_uart_device *w1dev = data;
+	unsigned char val;
+	int ret;
+
+	ret = w1_uart_serdev_tx_rx(w1dev, w1dev->baud_reset, w1dev->tx_reset,
+				   &val);
+	if (ret < 0)
+		return -1;
+
+	/* Device present (0) or no device (1) */
+	return val != w1dev->tx_reset ? 0 : 1;
+}
+
+/*
+ * 1-Wire read and write cycle: Only the Read-0 manipulates the
+ * received byte, all others left the line untouched.
+ */
+static u8 w1_uart_touch_bit(void *data, u8 bit)
+{
+	struct w1_uart_device *w1dev = data;
+	unsigned char val;
+	int ret;
+
+	ret = w1_uart_serdev_tx_rx(w1dev, w1dev->baud_touch,
+				   bit ? w1dev->tx_touch : 0x00, &val);
+	/* return inactive bus state on error */
+	if (ret < 0)
+		return 1;
+
+	return val == w1dev->tx_touch ? 1 : 0;
+}
+
+static int w1_uart_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct w1_uart_device *w1dev;
+	int ret;
+
+	w1dev = devm_kzalloc(dev, sizeof(*w1dev), GFP_KERNEL);
+	if (!w1dev)
+		return -ENOMEM;
+	w1dev->bus.data = w1dev;
+	w1dev->bus.reset_bus = w1_uart_reset_bus;
+	w1dev->bus.touch_bit = w1_uart_touch_bit;
+	w1dev->serdev = serdev;
+
+	init_completion(&w1dev->rx_byte_received);
+	mutex_init(&w1dev->mutex);
+
+	ret = w1_uart_serdev_open(w1dev);
+	if (ret < 0)
+		return ret;
+	serdev_device_set_drvdata(serdev, w1dev);
+	serdev_device_set_client_ops(serdev, &w1_uart_serdev_ops);
+
+	return w1_add_master_device(&w1dev->bus);
+}
+
+static void w1_uart_remove(struct serdev_device *serdev)
+{
+	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
+
+	mutex_lock(&w1dev->mutex);
+
+	w1_remove_master_device(&w1dev->bus);
+
+	mutex_unlock(&w1dev->mutex);
+}
+
+static const struct of_device_id w1_uart_of_match[] = {
+	{ .compatible = "w1-uart" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, w1_uart_of_match);
+
+static struct serdev_device_driver w1_uart_driver = {
+	.driver	= {
+		.name		= "w1-uart",
+		.of_match_table = w1_uart_of_match,
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


