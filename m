Return-Path: <linux-kernel+bounces-105528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFED87DFC1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F711F21D6A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1420C1EB5E;
	Sun, 17 Mar 2024 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuNdlqMw"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360F2134A;
	Sun, 17 Mar 2024 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704320; cv=none; b=AIRom+1ENG+KF2l+z9L7d2Rm8tEdos8+qIomoY11EHZ605NKW5+8kRUbUiuBelfN/5tZJvqkmM2ojZfpn86kXCL6zUOQ4OlFWEzYiBGmy37uxdqRMWgRUog7UUMD1VAZY3LbnuL1DAIgziaWdYYiF5OIXm2GkCdDfZWFtkk4yd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704320; c=relaxed/simple;
	bh=XoSg38IRIP3vuOnHVR6tVgbooonWmcwUrJ3fe5/rHdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIQ6UinwPOYqFFxXKZgQi/vD5c6XkNdn/AnBrvOun6mMY0hS3GvjWwxFOPJeOTZ9RwKv2Q7vE0EGoxx1XHgJnvIBNLSPXP9u+FLyMhZUiG/ehiDcqYJPkYprkoogvIYO6Jl5JO/iavXIMeLuM/cn9i+xB5aAR/5h4Iahz307IOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuNdlqMw; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e125818649so1419218a34.1;
        Sun, 17 Mar 2024 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704316; x=1711309116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIjZbYAaC7Szl64I9+yOIL6zkvga0zthWgnNY93d+E4=;
        b=GuNdlqMw49dwj2TSfkwCR/RLoAW1uDfXXFJdkth7lUvTtid6/0ybjlzt6XScFtwTNI
         +Ns1Uji9Cho2wuhhNY1MZwh+NYvP7o0MGrSh8ACxiN7wHpw0UT3EG4uckXuYXV0uRg9X
         m+0bcpRTpAZgeCcBwjt5ugttB65PmuKfxdMxc2mQWsp2osP0PaWprrVEAqRKhmzo+EAa
         K/hElXoeSP0m8k1BsDOrPmRnZM8cgWo4SKOqEqrnMfaPDclhCPVrhQ8dp/Qo6eMsCzdh
         o6JkAxZvbdRou6wjzYDXOWlzmrPV3d4xB7V5R097kgeZGOtA+1xx3CgGyBQVnWryYGW1
         a+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704316; x=1711309116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIjZbYAaC7Szl64I9+yOIL6zkvga0zthWgnNY93d+E4=;
        b=cFrMzas451lWof9HT9nQVcS6Vq6pYdahz12RzoIKseciP09o7JBluq3WSnXJUpWOm/
         iT6GmUJZB6XOOXG9vqAs3KNQ79Zhta8tqxUQisTrqeXtpKrMwT6Zsw9FsFz5pIMHqWgT
         fkskapoOwqwUTLsqx64d5d5fdALnHPdkzekqPYyclVMs+Ql2fwRDJ9ne+GLqFuxJzLMN
         QnobZwrtLW4U+LdUMjiWZzlSmCqTMjd0EZyxFPOTi9nwvbG7PVjNDWUyetD9JunARcwe
         WgU7QjRZh5170C5rGxKtY5nXELbQtgh0eEmPxEjl1ERtDCvoiuNTz1Wah06yxoxDB75P
         LcqA==
X-Forwarded-Encrypted: i=1; AJvYcCUdUbNlW2BkW2UYy87QXVk+kDN17ymdu16+GERPMJGMhs/SwcVzPUld9xJBiL/8xfKDpuEH85hc2jR9U5j4Y2TZaNfHUswhT4QkudQtM48zHa1xGqxgAuH2BJNpaWKq5F+IYKq85Q==
X-Gm-Message-State: AOJu0Yz/L67QmAkjMj52rg1k+pekIMYVs+I50U4vt+8wGH29Og7beQhZ
	dVfvV3L5zUze9fA2chuBt8n4uvrGxhDVN4m4hkdFunlYaL1odGm/iJ+u5otPCMo=
X-Google-Smtp-Source: AGHT+IE2ShYpKMdMbrRjB8C0x2MiX9wzjENIjU3Z/Sg7Mgzto4T5JKCuVzFq+s5AReUmk2BJ3DJ13A==
X-Received: by 2002:a05:6358:59a2:b0:17b:6171:adaa with SMTP id c34-20020a05635859a200b0017b6171adaamr8729146rwf.20.1710704315465;
        Sun, 17 Mar 2024 12:38:35 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id st6-20020a17090b1fc600b0029bbdc920besm6125995pjb.44.2024.03.17.12.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:38:34 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org (open list)
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	lorforlinux@beagleboard.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vaishnav M A <vaishnav.a@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
	Vaishnav M A <vaishnav@beagleboard.org>
Subject: [PATCH v4 4/5] mikrobus: Add mikroBUS driver
Date: Mon, 18 Mar 2024 01:07:12 +0530
Message-ID: <20240317193714.403132-5-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240317193714.403132-1-ayushdevel1325@gmail.com>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DONOTMERGE

this patch depends on Patch 1, 2, 3

mikroBUS driver aims to split the platform aspects of mikroBUS (pinmux,
SPI/I2C/GPIO controller .etc) from the add-on board information, thus
requiring one device tree overlay per port and just a single manifest
describing the add-on board.

The driver exposes a sysfs entry that allows passing mikroBUS manifest of
add-on board to the driver. The driver then parses this manifest, sets up
the pins and protocols and allows using the appropriate Linux driver. Here
is an example:

```
cat /lib/firmware/mikrobus/AMBIENT-2-CLICK.mnfb > /sys/bus/mikrobus/devices/mikrobus-0/new_device
```

Another sysfs entry is exposed that allows removing a previously
registered mikrobus add-on board:

```
echo " " > /sys/bus/mikrobus/devices/mikrobus-0/delete_device
```

100s of mikroBUS addon board manifests can be found in the clickID
repository.

In the future the driver also aims to support plug and play support
using 1-wire EEPROM and mikroBUS over greybus.

Link: https://www.mikroe.com/clickid ClickID

Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 MAINTAINERS                               |   1 +
 drivers/misc/Kconfig                      |   1 +
 drivers/misc/Makefile                     |   1 +
 drivers/misc/mikrobus/Kconfig             |  15 +
 drivers/misc/mikrobus/Makefile            |   5 +
 drivers/misc/mikrobus/mikrobus_core.c     | 696 ++++++++++++++++++++++
 drivers/misc/mikrobus/mikrobus_core.h     | 151 +++++
 drivers/misc/mikrobus/mikrobus_manifest.c | 503 ++++++++++++++++
 drivers/misc/mikrobus/mikrobus_manifest.h |  29 +
 9 files changed, 1402 insertions(+)
 create mode 100644 drivers/misc/mikrobus/Kconfig
 create mode 100644 drivers/misc/mikrobus/Makefile
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 69418a058c6b..83bc5e48bef9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14772,6 +14772,7 @@ M:	Ayush Singh <ayushdevel1325@gmail.com>
 M:	Vaishnav M A <vaishnav@beagleboard.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
+F:	drivers/misc/mikrobus/*
 
 MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 4fb291f0bf7c..3d5c36205c6c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -591,4 +591,5 @@ source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
 source "drivers/misc/mchp_pci1xxxx/Kconfig"
+source "drivers/misc/mikrobus/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ea6ea5bbbc9c..b9ac88055b87 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -68,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
 obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
 obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
+obj-y				+= mikrobus/
diff --git a/drivers/misc/mikrobus/Kconfig b/drivers/misc/mikrobus/Kconfig
new file mode 100644
index 000000000000..aa57b994dc66
--- /dev/null
+++ b/drivers/misc/mikrobus/Kconfig
@@ -0,0 +1,15 @@
+menuconfig MIKROBUS
+	tristate "Module for instantiating devices on mikroBUS ports"
+	depends on GPIOLIB
+	help
+	  This option enables the mikroBUS driver. mikroBUS is an add-on
+	  board socket standard that offers maximum expandability with
+	  the smallest number of pins. The mikroBUS driver instantiates
+	  devices on a mikroBUS port described mikroBUS manifest which is
+	  passed using a sysfs interface.
+
+
+	  Say Y here to enable support for this driver.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called mikrobus.ko
diff --git a/drivers/misc/mikrobus/Makefile b/drivers/misc/mikrobus/Makefile
new file mode 100644
index 000000000000..0e51c5a7db4b
--- /dev/null
+++ b/drivers/misc/mikrobus/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# mikroBUS Core
+
+obj-$(CONFIG_MIKROBUS) += mikrobus.o
+mikrobus-y :=	mikrobus_core.o	mikrobus_manifest.o
diff --git a/drivers/misc/mikrobus/mikrobus_core.c b/drivers/misc/mikrobus/mikrobus_core.c
new file mode 100644
index 000000000000..6aa20cef8e3b
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_core.c
@@ -0,0 +1,696 @@
+// SPDX-License-Identifier: GPL-2.0:
+/*
+ * mikroBUS driver for instantiating add-on
+ * board devices with an identifier EEPROM
+ *
+ * Copyright 2020 Vaishnav M A, BeagleBoard.org Foundation.
+ * Copyright 2024 Ayush Singh <ayushdevel1325@gmail.com>
+ */
+
+#define pr_fmt(fmt) "mikrobus:%s: " fmt, __func__
+
+#include "linux/gpio/driver.h"
+#include "linux/gpio/machine.h"
+#include "linux/gpio/consumer.h"
+#include "linux/greybus/greybus_manifest.h"
+#include "linux/i2c.h"
+#include "linux/irq.h"
+#include "linux/pinctrl/consumer.h"
+#include "linux/platform_device.h"
+#include "linux/spi/spi.h"
+
+#include "mikrobus_core.h"
+#include "mikrobus_manifest.h"
+
+static struct class_compat *mikrobus_port_compat_class;
+
+static const struct bus_type mikrobus_bus_type = {
+	.name = "mikrobus",
+};
+
+static int mikrobus_board_register(struct mikrobus_port *port,
+				   struct addon_board_info *board);
+static void mikrobus_board_unregister(struct mikrobus_port *port,
+				      struct addon_board_info *board);
+
+/*
+ * mikrobus_pinctrl_select: Select pinctrl state for mikrobus pin
+ *
+ * @port: mikrobus port
+ * @pinctrl_selected: pinctrl state to be selected
+ */
+static int mikrobus_pinctrl_select(struct mikrobus_port *port,
+				   const char *pinctrl_selected)
+{
+	struct pinctrl_state *state;
+	int ret;
+
+	state = pinctrl_lookup_state(port->pinctrl, pinctrl_selected);
+	if (IS_ERR(state)) {
+		return dev_err_probe(&port->dev, PTR_ERR(state),
+				     "failed to find state %s",
+				     pinctrl_selected);
+	}
+
+	ret = pinctrl_select_state(port->pinctrl, state);
+	if (ret) {
+		return dev_err_probe(&port->dev, ret,
+				     "failed to select state %s",
+				     pinctrl_selected);
+	}
+	dev_dbg(&port->dev, "setting pinctrl %s", pinctrl_selected);
+
+	return 0;
+}
+
+/*
+ * mikrobus_pinctrl_setup: Setup mikrobus pins to either default of gpio
+ *
+ * @port: mikrobus port
+ * @board: mikrobus board or NULL for default state
+ *
+ * returns 0 on success, negative error code on failure
+ */
+static int mikrobus_pinctrl_setup(struct mikrobus_port *port,
+				  struct addon_board_info *board)
+{
+	int ret;
+
+	if (!board || board->pin_state[MIKROBUS_PIN_PWM] == MIKROBUS_STATE_PWM)
+		ret = mikrobus_pinctrl_select(port, "pwm_default");
+	else
+		ret = mikrobus_pinctrl_select(port, "pwm_gpio");
+	if (ret)
+		return ret;
+
+	if (!board || board->pin_state[MIKROBUS_PIN_RX] == MIKROBUS_STATE_UART)
+		ret = mikrobus_pinctrl_select(port, "uart_default");
+	else
+		ret = mikrobus_pinctrl_select(port, "uart_gpio");
+	if (ret)
+		return ret;
+
+	if (!board || board->pin_state[MIKROBUS_PIN_SCL] == MIKROBUS_STATE_I2C)
+		ret = mikrobus_pinctrl_select(port, "i2c_default");
+	else
+		ret = mikrobus_pinctrl_select(port, "i2c_gpio");
+	if (ret)
+		return ret;
+
+	if (!board || board->pin_state[MIKROBUS_PIN_MOSI] == MIKROBUS_STATE_SPI)
+		ret = mikrobus_pinctrl_select(port, "spi_default");
+	else
+		ret = mikrobus_pinctrl_select(port, "spi_gpio");
+
+	return ret;
+}
+
+/*
+ * new_device_store: Expose sysfs entry for adding new board
+ *
+ * new_device_store: Allows userspace to add mikroBUS boards that lack 1-wire
+ * EEPROM for board identification by manually passing mikroBUS manifest
+ */
+static ssize_t new_device_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+	struct addon_board_info *board;
+	int ret;
+
+	if (port->board)
+		return dev_err_probe(dev, -EBUSY,
+				     "already has board registered");
+
+	board = devm_kzalloc(&port->dev, sizeof(*board), GFP_KERNEL);
+	if (!board)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&board->manifest_descs);
+	INIT_LIST_HEAD(&board->devices);
+
+	ret = mikrobus_manifest_parse(board, (void *)buf, count);
+	if (ret < 0) {
+		ret = dev_err_probe(dev, -EINVAL, "failed to parse manifest");
+		goto err_free_board;
+	}
+
+	ret = mikrobus_board_register(port, board);
+	if (ret) {
+		ret = dev_err_probe(dev, -EINVAL, "failed to register board %s",
+				    board->name);
+		goto err_free_board;
+	}
+
+	return count;
+
+err_free_board:
+	devm_kfree(&port->dev, board);
+	return ret;
+}
+static DEVICE_ATTR_WO(new_device);
+
+/*
+ * delete_device_store: Expose sysfs entry for deleting board
+ */
+static ssize_t delete_device_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+
+	if (!port->board)
+		return dev_err_probe(dev, -ENODEV,
+				     "does not have registered boards");
+
+	mikrobus_board_unregister(port, port->board);
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL,
+				  delete_device_store);
+
+static struct attribute *mikrobus_port_attrs[] = { &dev_attr_new_device.attr,
+						   &dev_attr_delete_device.attr,
+						   NULL };
+ATTRIBUTE_GROUPS(mikrobus_port);
+
+static void mikrobus_port_release(struct device *dev)
+{
+}
+
+static const struct device_type mikrobus_port_type = {
+	.groups = mikrobus_port_groups,
+	.release = mikrobus_port_release,
+};
+
+static int mikrobus_irq_get(struct mikrobus_port *port, int irqno, int irq_type)
+{
+	int irq;
+
+	if (irqno > port->gpios->ndescs - 1)
+		return dev_err_probe(&port->dev, -ENODEV,
+				     "GPIO %d does not exist", irqno);
+
+	irq = gpiod_to_irq(port->gpios->desc[irqno]);
+	if (irq < 0)
+		return dev_err_probe(&port->dev, -EINVAL,
+				     "could not get irq %d", irqno);
+
+	irq_set_irq_type(irq, irq_type);
+
+	return irq;
+}
+
+static int mikrobus_gpio_setup(struct gpio_desc *gpio, int gpio_state)
+{
+	switch (gpio_state) {
+	case MIKROBUS_STATE_INPUT:
+		return gpiod_direction_input(gpio);
+	case MIKROBUS_STATE_OUTPUT_HIGH:
+		return gpiod_direction_output(gpio, 1);
+	case MIKROBUS_STATE_OUTPUT_LOW:
+		return gpiod_direction_output(gpio, 0);
+	case MIKROBUS_STATE_PWM:
+	case MIKROBUS_STATE_SPI:
+	case MIKROBUS_STATE_I2C:
+	default:
+		return 0;
+	}
+}
+
+static char *mikrobus_gpio_chip_name_get(struct mikrobus_port *port, int gpio)
+{
+	struct gpio_chip *gpiochip;
+
+	if (gpio > port->gpios->ndescs - 1)
+		return NULL;
+
+	gpiochip = gpiod_to_chip(port->gpios->desc[gpio]);
+	return kmemdup(gpiochip->label, strlen(gpiochip->label), GFP_KERNEL);
+}
+
+static int mikrobus_gpio_hwnum_get(struct mikrobus_port *port, int gpio)
+{
+	struct gpio_chip *gpiochip;
+
+	if (gpio > port->gpios->ndescs - 1)
+		return -ENODEV;
+
+	gpiochip = gpiod_to_chip(port->gpios->desc[gpio]);
+	return desc_to_gpio(port->gpios->desc[gpio]) - gpiochip->base;
+}
+
+static void mikrobus_board_device_release_all(struct addon_board_info *info)
+{
+	struct board_device_info *dev, *next;
+
+	list_for_each_entry_safe(dev, next, &info->devices, links) {
+		list_del(&dev->links);
+		kfree(dev);
+	}
+}
+
+static int mikrobus_device_register(struct mikrobus_port *port,
+				    struct board_device_info *dev,
+				    char *board_name)
+{
+	struct gpiod_lookup_table *lookup;
+	struct spi_board_info *spi_info;
+	struct i2c_board_info *i2c_info;
+	struct platform_device *pdev;
+	struct fwnode_handle *fwnode;
+	struct spi_device *spi;
+	struct i2c_client *i2c;
+	int i, ret;
+
+	dev_info(&port->dev, "registering device : %s", dev->drv_name);
+
+	if (dev->gpio_lookup) {
+		lookup = dev->gpio_lookup;
+
+		switch (dev->protocol) {
+		case GREYBUS_PROTOCOL_SPI:
+			lookup->dev_id = kasprintf(GFP_KERNEL, "%s.%u",
+						   dev->drv_name,
+						   port->chip_select[dev->reg]);
+			break;
+		case GREYBUS_PROTOCOL_RAW:
+			lookup->dev_id = kasprintf(GFP_KERNEL, "%s.%u",
+						   dev->drv_name, dev->reg);
+			break;
+		default:
+			lookup->dev_id = kmemdup(dev->drv_name,
+						 strlen(dev->drv_name),
+						 GFP_KERNEL);
+		}
+
+		dev_info(&port->dev, "adding lookup table : %s",
+			 lookup->dev_id);
+
+		for (i = 0; i < dev->num_gpio_resources; i++) {
+			lookup->table[i].key = mikrobus_gpio_chip_name_get(
+				port, lookup->table[i].chip_hwnum);
+			lookup->table[i].chip_hwnum = mikrobus_gpio_hwnum_get(
+				port, lookup->table[i].chip_hwnum);
+		}
+
+		gpiod_add_lookup_table(lookup);
+	}
+
+	switch (dev->protocol) {
+	case GREYBUS_PROTOCOL_SPI:
+		spi_info =
+			devm_kzalloc(&port->dev, sizeof(*spi_info), GFP_KERNEL);
+		strscpy_pad(spi_info->modalias, dev->drv_name,
+			    sizeof(spi_info->modalias));
+		if (dev->irq)
+			spi_info->irq =
+				mikrobus_irq_get(port, dev->irq, dev->irq_type);
+		if (dev->properties) {
+			fwnode = fwnode_create_software_node(dev->properties,
+							     NULL);
+			spi_info->swnode = to_software_node(fwnode);
+		}
+		spi_info->chip_select = port->chip_select[dev->reg];
+		spi_info->max_speed_hz = dev->max_speed_hz;
+		spi_info->mode = dev->mode;
+
+		spi = spi_new_device(port->spi_ctrl, spi_info);
+		devm_kfree(&port->dev, spi_info);
+		if (!spi)
+			return dev_err_probe(&port->dev, -ENODEV,
+					     "failed to register spi device");
+		dev->dev_client = (void *)spi;
+		break;
+	case GREYBUS_PROTOCOL_I2C:
+		i2c_info =
+			devm_kzalloc(&port->dev, sizeof(*i2c_info), GFP_KERNEL);
+		if (!i2c_info)
+			return -ENOMEM;
+
+		strscpy_pad(i2c_info->type, dev->drv_name,
+			    sizeof(i2c_info->type));
+		if (dev->irq)
+			i2c_info->irq =
+				mikrobus_irq_get(port, dev->irq, dev->irq_type);
+		if (dev->properties) {
+			fwnode = fwnode_create_software_node(dev->properties,
+							     NULL);
+			i2c_info->swnode = to_software_node(fwnode);
+		}
+		i2c_info->addr = dev->reg;
+
+		i2c = i2c_new_client_device(port->i2c_adap, i2c_info);
+		devm_kfree(&port->dev, i2c_info);
+		if (IS_ERR(dev->dev_client))
+			return dev_err_probe(&port->dev,
+					     PTR_ERR(dev->dev_client),
+					     "failed to register i2c device");
+		dev->dev_client = (void *)i2c;
+		break;
+	case GREYBUS_PROTOCOL_RAW:
+		pdev = platform_device_alloc(dev->drv_name, 0);
+		if (!pdev)
+			return -ENOMEM;
+
+		if (dev->properties) {
+			ret = device_create_managed_software_node(
+				&pdev->dev, dev->properties, NULL);
+			if (ret)
+				return dev_err_probe(
+					&port->dev, ret,
+					"failed to create software node");
+		}
+		ret = platform_device_add(dev->dev_client);
+		if (ret)
+			return dev_err_probe(
+				&port->dev, ret,
+				"failed to register platform device");
+		dev->dev_client = (void *)pdev;
+		break;
+	case GREYBUS_PROTOCOL_UART:
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void mikrobus_device_unregister(struct mikrobus_port *port,
+				       struct board_device_info *dev,
+				       char *board_name)
+{
+	dev_info(&port->dev, "removing device %s", dev->drv_name);
+	if (dev->gpio_lookup) {
+		gpiod_remove_lookup_table(dev->gpio_lookup);
+		kfree(dev->gpio_lookup->dev_id);
+		kfree(dev->gpio_lookup);
+	}
+
+	kfree(dev->properties);
+
+	switch (dev->protocol) {
+	case GREYBUS_PROTOCOL_SPI:
+		spi_unregister_device((struct spi_device *)dev->dev_client);
+		break;
+	case GREYBUS_PROTOCOL_I2C:
+		i2c_unregister_device((struct i2c_client *)dev->dev_client);
+		break;
+	case GREYBUS_PROTOCOL_RAW:
+		platform_device_unregister(
+			(struct platform_device *)dev->dev_client);
+		break;
+	case GREYBUS_PROTOCOL_UART:
+		break;
+	}
+}
+
+static int mikrobus_board_register(struct mikrobus_port *port,
+				   struct addon_board_info *board)
+{
+	struct board_device_info *devinfo, *next;
+	int ret, i;
+
+	if (WARN_ON(list_empty(&board->devices)))
+		return false;
+
+	if (port->pinctrl) {
+		ret = mikrobus_pinctrl_setup(port, board);
+		if (ret)
+			dev_err(&port->dev,
+				"failed to setup pinctrl state [%d]", ret);
+	}
+
+	if (port->gpios) {
+		for (i = 0; i < port->gpios->ndescs; i++) {
+			ret = mikrobus_gpio_setup(port->gpios->desc[i],
+						  board->pin_state[i]);
+			if (ret)
+				dev_err(&port->dev,
+					"failed to setup gpio %d, state %d", i,
+					board->pin_state[i]);
+
+			gpiochip_free_own_desc(port->gpios->desc[i]);
+		}
+	}
+
+	list_for_each_entry_safe(devinfo, next, &board->devices, links)
+		mikrobus_device_register(port, devinfo, board->name);
+
+	port->board = board;
+	return 0;
+}
+
+static void mikrobus_board_unregister(struct mikrobus_port *port,
+				      struct addon_board_info *board)
+{
+	struct board_device_info *devinfo, *next;
+
+	if (WARN_ON(list_empty(&board->devices)))
+		return;
+
+	list_for_each_entry_safe(devinfo, next, &board->devices, links)
+		mikrobus_device_unregister(port, devinfo, board->name);
+
+	mikrobus_board_device_release_all(board);
+	devm_kfree(&port->dev, board);
+	port->board = NULL;
+}
+
+static int mikrobus_port_register(struct mikrobus_port *port)
+{
+	int ret;
+
+	port->dev.bus = &mikrobus_bus_type;
+	port->dev.type = &mikrobus_port_type;
+	dev_set_name(&port->dev, "mikrobus-%d", port->id);
+
+	dev_info(&port->dev, "registering port %s", dev_name(&port->dev));
+
+	ret = device_register(&port->dev);
+	if (ret)
+		return dev_err_probe(&port->dev, ret,
+				     "port '%d': can't register device (%d)",
+				     port->id, ret);
+
+	ret = class_compat_create_link(mikrobus_port_compat_class, &port->dev,
+				       port->dev.parent);
+	if (ret)
+		dev_warn(&port->dev,
+			 "failed to create compatibility class link");
+
+	return ret;
+}
+
+static void mikrobus_port_delete(struct mikrobus_port *port)
+{
+	if (port->board)
+		return dev_err(
+			&port->dev,
+			"attempting to delete port with registered boards, port [%s]",
+			dev_name(&port->dev));
+
+	class_compat_remove_link(mikrobus_port_compat_class, &port->dev,
+				 port->dev.parent);
+
+	devm_pinctrl_put(port->pinctrl);
+	put_device(&port->spi_ctrl->dev);
+	gpiod_put_array(port->gpios);
+	put_device(&port->i2c_adap->dev);
+
+	device_unregister(&port->dev);
+	memset(&port->dev, 0, sizeof(port->dev));
+}
+
+static int mikrobus_port_probe_pinctrl_setup(struct mikrobus_port *port)
+{
+	struct device *dev = port->dev.parent;
+	struct pinctrl_state *state;
+	int ret;
+
+	state = pinctrl_lookup_state(port->pinctrl, PINCTRL_STATE_DEFAULT);
+	if (IS_ERR(state))
+		return dev_err_probe(dev, PTR_ERR(state),
+				     "failed to find state %s",
+				     PINCTRL_STATE_DEFAULT);
+
+	ret = pinctrl_select_state(port->pinctrl, state);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to select state %s",
+				     PINCTRL_STATE_DEFAULT);
+
+	ret = mikrobus_pinctrl_setup(port, NULL);
+	if (ret)
+		dev_err(dev, "failed to select pinctrl states [%d]", ret);
+
+	return ret;
+}
+
+static int mikrobus_port_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mikrobus_port *port;
+	struct device_node *np;
+	int ret;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->dev.parent = dev;
+	port->dev.of_node = pdev->dev.of_node;
+
+	/* port id */
+	port->id = of_alias_get_id(dev->of_node, "mikrobus");
+	if (port->id) {
+		ret = dev_err_probe(dev, -EINVAL, "invalid mikrobus id");
+		goto err_port;
+	}
+
+	/* I2C setup */
+	np = of_parse_phandle(dev->of_node, "i2c-adapter", 0);
+	if (!np) {
+		ret = dev_err_probe(dev, -ENODEV, "cannot parse i2c-adapter");
+		goto err_port;
+	}
+	port->i2c_adap = of_find_i2c_adapter_by_node(np);
+	of_node_put(np);
+	if (!port->i2c_adap) {
+		ret = dev_err_probe(dev, -ENODEV, "cannot find i2c adapter");
+		goto err_port;
+	}
+
+	/* GPIO setup */
+	port->gpios = gpiod_get_array(dev, "mikrobus", GPIOD_OUT_LOW);
+	if (IS_ERR(port->gpios)) {
+		ret = dev_err_probe(dev, PTR_ERR(port->gpios),
+				    "failed to get gpio array [%ld]",
+				    PTR_ERR(port->gpios));
+		goto free_i2c;
+	}
+
+	/* SPI setup */
+	np = of_parse_phandle(dev->of_node, "spi-controller", 0);
+	if (!np) {
+		ret = dev_err_probe(dev, -ENODEV,
+				    "cannot parse spi-controller");
+		goto free_gpio;
+	}
+	port->spi_ctrl = of_find_spi_controller_by_node(np);
+	of_node_put(np);
+	if (!port->spi_ctrl) {
+		ret = dev_err_probe(dev, -ENODEV, "cannot find spi controller");
+		goto free_gpio;
+	}
+	ret = device_property_read_u32_array(dev, "spi-cs", port->chip_select,
+					     MIKROBUS_NUM_CS);
+	if (ret) {
+		dev_err(dev, "failed to get spi-cs [%d]", ret);
+		goto free_spi;
+	}
+
+	/* pinctrl setup */
+	port->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(port->pinctrl)) {
+		ret = dev_err_probe(dev, PTR_ERR(port->pinctrl),
+				    "failed to get pinctrl [%ld]",
+				    PTR_ERR(port->pinctrl));
+		goto free_spi;
+	}
+	ret = mikrobus_port_probe_pinctrl_setup(port);
+	if (ret) {
+		dev_err(dev, "failed to setup pinctrl [%d]", ret);
+		goto free_pinctrl;
+	}
+
+	/* TODO: UART */
+	/* TODO: PWM */
+
+	ret = mikrobus_port_register(port);
+	if (ret) {
+		dev_err(dev, "port : can't register port [%d]", ret);
+		goto free_pinctrl;
+	}
+
+	platform_set_drvdata(pdev, port);
+
+	return 0;
+
+free_pinctrl:
+	devm_pinctrl_put(port->pinctrl);
+free_spi:
+	put_device(&port->spi_ctrl->dev);
+free_gpio:
+	gpiod_put_array(port->gpios);
+free_i2c:
+	put_device(&port->i2c_adap->dev);
+err_port:
+	put_device(&port->dev);
+	return ret;
+}
+
+static int mikrobus_port_remove(struct platform_device *pdev)
+{
+	struct mikrobus_port *port = platform_get_drvdata(pdev);
+
+	mikrobus_port_delete(port);
+	return 0;
+}
+
+static const struct of_device_id mikrobus_port_of_match[] = {
+	{ .compatible = "mikrobus-connector" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mikrobus_port_of_match);
+
+static struct platform_driver mikrobus_port_driver = {
+	.probe = mikrobus_port_probe,
+	.remove = mikrobus_port_remove,
+	.driver = {
+		.name = "mikrobus",
+		.of_match_table = mikrobus_port_of_match,
+	},
+};
+
+static int mikrobus_init(void)
+{
+	int ret;
+
+	ret = bus_register(&mikrobus_bus_type);
+	if (ret) {
+		pr_err("bus_register failed (%d)", ret);
+		return ret;
+	}
+
+	mikrobus_port_compat_class = class_compat_register("mikrobus-port");
+	if (!mikrobus_port_compat_class) {
+		ret = -ENOMEM;
+		pr_err("class_compat register failed (%d)", ret);
+		goto class_err;
+	}
+
+	ret = platform_driver_register(&mikrobus_port_driver);
+	if (ret)
+		pr_err("driver register failed [%d]", ret);
+
+	return ret;
+
+class_err:
+	bus_unregister(&mikrobus_bus_type);
+	return ret;
+}
+subsys_initcall(mikrobus_init);
+
+static void mikrobus_exit(void)
+{
+	platform_driver_unregister(&mikrobus_port_driver);
+	bus_unregister(&mikrobus_bus_type);
+	class_compat_unregister(mikrobus_port_compat_class);
+}
+module_exit(mikrobus_exit);
+
+MODULE_AUTHOR("Vaishnav M A <vaishnav@beagleboard.org>");
+MODULE_AUTHOR("Ayush Singh <ayushdevel1325@beagleboard.org>");
+MODULE_DESCRIPTION("mikroBUS main module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/mikrobus/mikrobus_core.h b/drivers/misc/mikrobus/mikrobus_core.h
new file mode 100644
index 000000000000..1d41ee32ca94
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_core.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mikroBUS Driver for instantiating add-on board devices
+ *
+ * Copyright 2020 Vaishnav M A, BeagleBoard.org Foundation.
+ * Copyright 2024 Ayush Singh <ayushdevel1325@gmail.com>
+ */
+
+#ifndef __MIKROBUS_H
+#define __MIKROBUS_H
+
+#include "linux/device.h"
+
+#define MIKROBUS_VERSION_MAJOR 0x00
+#define MIKROBUS_VERSION_MINOR 0x03
+
+#define MIKROBUS_NUM_PINCTRL_STATE 4
+#define MIKROBUS_NUM_CS 2
+
+#define MIKROBUS_PINCTRL_PWM 0
+#define MIKROBUS_PINCTRL_UART 1
+#define MIKROBUS_PINCTRL_I2C 2
+#define MIKROBUS_PINCTRL_SPI 3
+
+enum mikrobus_property_type {
+	MIKROBUS_PROPERTY_TYPE_MIKROBUS = 0x00,
+	MIKROBUS_PROPERTY_TYPE_PROPERTY,
+	MIKROBUS_PROPERTY_TYPE_GPIO,
+	MIKROBUS_PROPERTY_TYPE_U8,
+	MIKROBUS_PROPERTY_TYPE_U16,
+	MIKROBUS_PROPERTY_TYPE_U32,
+	MIKROBUS_PROPERTY_TYPE_U64,
+};
+
+enum mikrobus_pin {
+	MIKROBUS_PIN_PWM = 0x00,
+	MIKROBUS_PIN_INT,
+	MIKROBUS_PIN_RX,
+	MIKROBUS_PIN_TX,
+	MIKROBUS_PIN_SCL,
+	MIKROBUS_PIN_SDA,
+	MIKROBUS_PIN_MOSI,
+	MIKROBUS_PIN_MISO,
+	MIKROBUS_PIN_SCK,
+	MIKROBUS_PIN_CS,
+	MIKROBUS_PIN_RST,
+	MIKROBUS_PIN_AN,
+	MIKROBUS_PORT_PIN_COUNT,
+};
+
+enum mikrobus_pin_state {
+	MIKROBUS_STATE_INPUT = 0x01,
+	MIKROBUS_STATE_OUTPUT_HIGH,
+	MIKROBUS_STATE_OUTPUT_LOW,
+	MIKROBUS_STATE_PWM,
+	MIKROBUS_STATE_SPI,
+	MIKROBUS_STATE_I2C,
+	MIKROBUS_STATE_UART,
+};
+
+/*
+ * board_device_info describes a single device on a mikrobus add-on
+ * board, an add-on board can present one or more device to the host
+ *
+ * @gpio_lookup: used to provide the GPIO lookup table for
+ * passing the named GPIOs to device drivers.
+ * @properties: used to provide the property_entry to pass named
+ * properties to device drivers, applicable only when driver uses
+ * device_property_read_* calls to fetch the properties.
+ * @num_gpio_resources: number of named gpio resources for the device,
+ * used mainly for gpiod_lookup_table memory allocation.
+ * @num_properties: number of custom properties for the device,
+ * used mainly for property_entry memory allocation.
+ * @protocol: used to know the type of the device and it should
+ * contain one of the values defined under 'enum greybus_class_type'
+ * under linux/greybus/greybus_manifest.h
+ * @reg: I2C address for the device, for devices on the SPI bus
+ * this field is the chip select address relative to the mikrobus
+ * port:0->device chip select connected to CS pin on mikroBUS port
+ *	1->device chip select connected to RST Pin on mikroBUS port
+ * @mode: SPI mode
+ * @max_speed_hz: SPI max speed(Hz)
+ * @drv_name: device_id to match with the driver
+ * @irq_type: type of IRQ trigger , match with defines in linux/interrupt.h
+ * @irq: irq number relative to the mikrobus port should contain one of the
+ * values defined under 'enum mikrobus_pin'
+ * @id: device id starting from 1
+ */
+struct board_device_info {
+	struct gpiod_lookup_table *gpio_lookup;
+	struct property_entry *properties;
+	struct list_head links;
+	unsigned short num_gpio_resources;
+	unsigned short num_properties;
+	unsigned short protocol;
+	unsigned short reg;
+	unsigned int mode;
+	void *dev_client;
+	u32 max_speed_hz;
+	char *drv_name;
+	int irq_type;
+	int irq;
+	int id;
+};
+
+/*
+ * addon_board_info describes a mikrobus add-on device the add-on
+ * board, an add-on board can present one or more device to the host
+ *
+ * @manifest_descs: list of manifest descriptors
+ * @devices: list of devices on the board
+ * @pin_state: the state of each pin on the mikrobus port required
+ * for the add-on board should contain one of the values defined under
+ * 'enum mikrobus_pin_state' restrictions are as per mikrobus standard
+ * specifications.
+ * @name: add-on board name
+ */
+struct addon_board_info {
+	struct list_head manifest_descs;
+	struct list_head devices;
+	u8 pin_state[MIKROBUS_PORT_PIN_COUNT];
+	char *name;
+};
+
+/*
+ * mikrobus_port describes the peripherals mapped to a mikrobus port.
+ *
+ * @chip_select: chip select number mapped to the SPI CS pin on the
+ * mikrobus port and the RST pin on the mikrobus port
+ * @board: pointer to the attached add-on board.
+ * @spi_ctrl: SPI controller attached to the mikrobus port.
+ * @i2c_adap: I2C adapter attached to the mikrobus port.
+ * @gpios: GPIOs attached to the mikrobus port.
+ * @pinctrl: pinctrl attached to the mikrobus port.
+ * @dev: device structure for the mikrobus port.
+ * @id: port id starting from 1
+ */
+struct mikrobus_port {
+	u32 chip_select[MIKROBUS_NUM_CS];
+	struct addon_board_info *board;
+	struct spi_controller *spi_ctrl;
+	struct i2c_adapter *i2c_adap;
+	struct gpio_descs *gpios;
+	struct pinctrl *pinctrl;
+	struct device dev;
+	int id;
+};
+
+#define to_mikrobus_port(d) container_of(d, struct mikrobus_port, dev)
+
+#endif /* __MIKROBUS_H */
diff --git a/drivers/misc/mikrobus/mikrobus_manifest.c b/drivers/misc/mikrobus/mikrobus_manifest.c
new file mode 100644
index 000000000000..5f30620277be
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_manifest.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mikroBUS manifest parsing, an
+ * extension to Greybus Manifest Parsing
+ * under drivers/greybus/manifest.c
+ *
+ * Copyright 2014-2015 Google Inc.
+ * Copyright 2014-2015 Linaro Ltd.
+ * Copyright 2024 Ayush Singh <ayushdevel1325@gmail.com>
+ */
+
+#define pr_fmt(fmt) "mikrobus_manifest:%s: " fmt, __func__
+
+#include "linux/gpio/machine.h"
+#include "linux/greybus/greybus_manifest.h"
+#include "linux/property.h"
+#include "mikrobus_manifest.h"
+
+struct manifest_desc {
+	struct list_head links;
+	size_t size;
+	void *data;
+	enum greybus_descriptor_type type;
+};
+
+static void manifest_descriptor_release_all(struct addon_board_info *board)
+{
+	struct manifest_desc *descriptor, *next;
+
+	list_for_each_entry_safe(descriptor, next, &board->manifest_descs,
+				 links) {
+		list_del(&descriptor->links);
+		kfree(descriptor);
+	}
+}
+
+static int board_descriptor_add(struct addon_board_info *board,
+				struct greybus_descriptor *desc, size_t size)
+{
+	struct greybus_descriptor_header *desc_header = &desc->header;
+	struct manifest_desc *descriptor;
+	size_t desc_size, expected_size;
+
+	if (size < sizeof(*desc_header)) {
+		pr_err("short descriptor (%zu < %zu)", size,
+		       sizeof(*desc_header));
+		return -EINVAL;
+	}
+
+	desc_size = le16_to_cpu(desc_header->size);
+	if (desc_size > size) {
+		pr_err("incorrect descriptor size (%zu != %zu)", size,
+		       desc_size);
+		return -EINVAL;
+	}
+
+	expected_size = sizeof(*desc_header);
+	switch (desc_header->type) {
+	case GREYBUS_TYPE_STRING:
+		expected_size += sizeof(struct greybus_descriptor_string);
+		expected_size += desc->string.length;
+		expected_size = ALIGN(expected_size, 4);
+		break;
+	case GREYBUS_TYPE_PROPERTY:
+		expected_size += sizeof(struct greybus_descriptor_property);
+		expected_size += desc->property.length;
+		expected_size = ALIGN(expected_size, 4);
+		break;
+	case GREYBUS_TYPE_DEVICE:
+		expected_size += sizeof(struct greybus_descriptor_device);
+		break;
+	case GREYBUS_TYPE_MIKROBUS:
+		expected_size += sizeof(struct greybus_descriptor_mikrobus);
+		break;
+	case GREYBUS_TYPE_INTERFACE:
+		expected_size += sizeof(struct greybus_descriptor_interface);
+		break;
+	case GREYBUS_TYPE_CPORT:
+		expected_size += sizeof(struct greybus_descriptor_cport);
+		break;
+	case GREYBUS_TYPE_BUNDLE:
+		expected_size += sizeof(struct greybus_descriptor_bundle);
+		break;
+	case GREYBUS_TYPE_INVALID:
+	default:
+		pr_err("invalid descriptor type %d", desc_header->type);
+		return -EINVAL;
+	}
+
+	descriptor = kzalloc(sizeof(*descriptor), GFP_KERNEL);
+	if (!descriptor)
+		return -ENOMEM;
+
+	descriptor->size = desc_size;
+	descriptor->data = (char *)desc + sizeof(*desc_header);
+	descriptor->type = desc_header->type;
+	list_add_tail(&descriptor->links, &board->manifest_descs);
+
+	return desc_size;
+}
+
+static char *mikrobus_string_get(struct addon_board_info *board, u8 string_id)
+{
+	struct greybus_descriptor_string *desc_string;
+	struct manifest_desc *descriptor;
+	bool found = false;
+	char *string;
+
+	if (!string_id)
+		return NULL;
+
+	list_for_each_entry(descriptor, &board->manifest_descs, links) {
+		if (descriptor->type != GREYBUS_TYPE_STRING)
+			continue;
+
+		desc_string = descriptor->data;
+		if (desc_string->id == string_id) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return ERR_PTR(-ENOENT);
+
+	string = kmemdup(&desc_string->string, desc_string->length + 1,
+			 GFP_KERNEL);
+	if (!string)
+		return ERR_PTR(-ENOMEM);
+
+	string[desc_string->length] = '\0';
+
+	return string;
+}
+
+static void mikrobus_state_get(struct addon_board_info *board)
+{
+	struct greybus_descriptor_mikrobus *mikrobus;
+	struct greybus_descriptor_interface *interface;
+	struct manifest_desc *descriptor;
+	bool found = false;
+	size_t i;
+
+	list_for_each_entry(descriptor, &board->manifest_descs, links) {
+		if (descriptor->type == GREYBUS_TYPE_MIKROBUS) {
+			mikrobus = descriptor->data;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_err("mikrobus descriptor not found");
+		return;
+	}
+
+	for (i = 0; i < MIKROBUS_PORT_PIN_COUNT; i++)
+		board->pin_state[i] = mikrobus->pin_state[i];
+
+	found = false;
+	list_for_each_entry(descriptor, &board->manifest_descs, links) {
+		if (descriptor->type == GREYBUS_TYPE_INTERFACE) {
+			interface = descriptor->data;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		pr_err("interface descriptor not found");
+		return;
+	}
+
+	board->name = mikrobus_string_get(board, interface->product_stringid);
+}
+
+static struct property_entry *
+mikrobus_property_entry_get(struct addon_board_info *board, u8 *prop_link,
+			    int num_properties)
+{
+	struct greybus_descriptor_property *desc_property;
+	struct manifest_desc *descriptor;
+	struct property_entry *properties;
+	bool found = false;
+	char *prop_name;
+	int i, ret;
+	u64 *val_u64;
+	u32 *val_u32;
+	u16 *val_u16;
+	u8 *val_u8;
+
+	properties = kcalloc(num_properties, sizeof(*properties), GFP_KERNEL);
+	if (!properties)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < num_properties; i++) {
+		list_for_each_entry(descriptor, &board->manifest_descs, links) {
+			if (descriptor->type != GREYBUS_TYPE_PROPERTY)
+				continue;
+
+			desc_property = descriptor->data;
+			if (desc_property->id == prop_link[i]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			ret = -ENOENT;
+			goto early_exit;
+		}
+
+		prop_name = mikrobus_string_get(
+			board, desc_property->propname_stringid);
+		if (!prop_name) {
+			ret = -ENOENT;
+			goto early_exit;
+		}
+
+		switch (desc_property->type) {
+		case MIKROBUS_PROPERTY_TYPE_U8:
+			val_u8 = kmemdup(&desc_property->value,
+					 (desc_property->length) * sizeof(u8),
+					 GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] =
+					PROPERTY_ENTRY_U8(prop_name, *val_u8);
+			else
+				properties[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(
+					prop_name, (void *)desc_property->value,
+					desc_property->length);
+			break;
+		case MIKROBUS_PROPERTY_TYPE_U16:
+			val_u16 = kmemdup(&desc_property->value,
+					  (desc_property->length) * sizeof(u16),
+					  GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] =
+					PROPERTY_ENTRY_U16(prop_name, *val_u16);
+			else
+				properties[i] = PROPERTY_ENTRY_U16_ARRAY_LEN(
+					prop_name, (void *)desc_property->value,
+					desc_property->length);
+			break;
+		case MIKROBUS_PROPERTY_TYPE_U32:
+			val_u32 = kmemdup(&desc_property->value,
+					  (desc_property->length) * sizeof(u32),
+					  GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] =
+					PROPERTY_ENTRY_U32(prop_name, *val_u32);
+			else
+				properties[i] = PROPERTY_ENTRY_U32_ARRAY_LEN(
+					prop_name, (void *)desc_property->value,
+					desc_property->length);
+			break;
+		case MIKROBUS_PROPERTY_TYPE_U64:
+			val_u64 = kmemdup(&desc_property->value,
+					  (desc_property->length) * sizeof(u64),
+					  GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] =
+					PROPERTY_ENTRY_U64(prop_name, *val_u64);
+			else
+				properties[i] = PROPERTY_ENTRY_U64_ARRAY_LEN(
+					prop_name, (void *)desc_property->value,
+					desc_property->length);
+			break;
+		default:
+			ret = -EINVAL;
+			goto early_exit;
+		}
+	}
+	return properties;
+
+early_exit:
+	kfree(properties);
+	return ERR_PTR(ret);
+}
+
+static u8 *mikrobus_property_link_get(struct addon_board_info *board,
+				      u8 prop_id,
+				      struct board_device_info *board_dev,
+				      u8 prop_type)
+{
+	struct greybus_descriptor_property *desc_property;
+	struct manifest_desc *descriptor;
+	bool found = false;
+	u8 *val_u8;
+
+	if (!prop_id)
+		return NULL;
+
+	list_for_each_entry(descriptor, &board->manifest_descs, links) {
+		if (descriptor->type != GREYBUS_TYPE_PROPERTY)
+			continue;
+
+		desc_property = descriptor->data;
+		if (desc_property->id == prop_id &&
+		    desc_property->type == prop_type) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return ERR_PTR(-ENOENT);
+
+	val_u8 = kmemdup(&desc_property->value, desc_property->length,
+			 GFP_KERNEL);
+	if (prop_type == MIKROBUS_PROPERTY_TYPE_GPIO)
+		board_dev->num_gpio_resources = desc_property->length;
+	else if (prop_type == MIKROBUS_PROPERTY_TYPE_PROPERTY)
+		board_dev->num_properties = desc_property->length;
+
+	return val_u8;
+}
+
+static int
+mikrobus_manifest_attach_device(struct addon_board_info *board,
+				struct greybus_descriptor_device *dev_desc)
+{
+	struct greybus_descriptor_property *desc_property;
+	u8 *gpio_desc_link, *prop_link, *gpioval;
+	struct board_device_info *board_dev;
+	struct gpiod_lookup_table *lookup;
+	struct manifest_desc *descriptor;
+	int ret, i;
+
+	board_dev = kzalloc(sizeof(*board_dev), GFP_KERNEL);
+	if (!board_dev)
+		return -ENOMEM;
+
+	board_dev->id = dev_desc->id;
+	board_dev->drv_name =
+		mikrobus_string_get(board, dev_desc->driver_stringid);
+	if (!board_dev->drv_name) {
+		ret = -ENOENT;
+		goto err_free_board_dev;
+	}
+
+	board_dev->protocol = dev_desc->protocol;
+	board_dev->reg = dev_desc->reg;
+	board_dev->irq = dev_desc->irq;
+	board_dev->irq_type = dev_desc->irq_type;
+	board_dev->max_speed_hz = le32_to_cpu(dev_desc->max_speed_hz);
+	board_dev->mode = dev_desc->mode;
+	pr_info("parsed device %d, driver=%s", board_dev->id,
+		board_dev->drv_name);
+
+	if (dev_desc->prop_link > 0) {
+		prop_link = mikrobus_property_link_get(
+			board, dev_desc->prop_link, board_dev,
+			MIKROBUS_PROPERTY_TYPE_PROPERTY);
+		if (!prop_link) {
+			ret = -ENOENT;
+			goto err_free_board_dev;
+		}
+
+		pr_info("device %d, number of properties=%d", board_dev->id,
+			board_dev->num_properties);
+		board_dev->properties = mikrobus_property_entry_get(
+			board, prop_link, board_dev->num_properties);
+	}
+
+	if (dev_desc->gpio_link > 0) {
+		gpio_desc_link = mikrobus_property_link_get(
+			board, dev_desc->gpio_link, board_dev,
+			MIKROBUS_PROPERTY_TYPE_GPIO);
+		if (!gpio_desc_link) {
+			ret = -ENOENT;
+			goto err_free_board_dev;
+		}
+
+		pr_info("device %d, number of gpio resource=%d", board_dev->id,
+			board_dev->num_gpio_resources);
+		lookup = kzalloc(struct_size(lookup, table,
+					     board_dev->num_gpio_resources),
+				 GFP_KERNEL);
+		if (!lookup) {
+			ret = -ENOMEM;
+			goto err_free_board_dev;
+		}
+
+		for (i = 0; i < board_dev->num_gpio_resources; i++) {
+			list_for_each_entry(descriptor, &board->manifest_descs,
+					    links) {
+				if (descriptor->type != GREYBUS_TYPE_PROPERTY)
+					continue;
+
+				desc_property = descriptor->data;
+				if (desc_property->id == gpio_desc_link[i]) {
+					gpioval = desc_property->value;
+					lookup->table[i].chip_hwnum =
+						gpioval[0];
+					lookup->table[i].flags = gpioval[1];
+					lookup->table[i]
+						.con_id = mikrobus_string_get(
+						board,
+						desc_property
+							->propname_stringid);
+					break;
+				}
+			}
+		}
+		board_dev->gpio_lookup = lookup;
+	}
+
+	list_add_tail(&board_dev->links, &board->devices);
+	return 0;
+
+err_free_board_dev:
+	kfree(board_dev);
+	return ret;
+}
+
+static int mikrobus_manifest_parse_devices(struct addon_board_info *board)
+{
+	struct greybus_descriptor_device *desc_device;
+	struct manifest_desc *desc, *next;
+	int ret, devcount = 0;
+
+	list_for_each_entry_safe(desc, next, &board->manifest_descs, links) {
+		if (desc->type != GREYBUS_TYPE_DEVICE)
+			continue;
+
+		desc_device = desc->data;
+		ret = mikrobus_manifest_attach_device(board, desc_device);
+		devcount++;
+	}
+
+	return devcount;
+}
+
+static size_t mikrobus_manifest_header_validate(void *data, size_t size)
+{
+	struct greybus_manifest_header *header = data;
+	u16 manifest_size = le16_to_cpu(header->size);
+
+	if (manifest_size < sizeof(*header)) {
+		pr_err("short manifest (%zu < %zu)", size, sizeof(*header));
+		return -EINVAL;
+	}
+
+	if (header->version_major > MIKROBUS_VERSION_MAJOR) {
+		pr_err("manifest version too new (%u.%u > %u.%u)",
+		       header->version_major, header->version_minor,
+		       MIKROBUS_VERSION_MAJOR, MIKROBUS_VERSION_MINOR);
+		return -EINVAL;
+	}
+
+	return manifest_size;
+}
+
+int mikrobus_manifest_parse(struct addon_board_info *board, void *data,
+			    size_t size)
+{
+	struct greybus_manifest_header *header;
+	struct greybus_manifest *manifest;
+	struct greybus_descriptor *desc;
+	int dev_count, desc_size, ret;
+	u16 manifest_size;
+
+	if (size < sizeof(*header)) {
+		pr_err("short manifest (%zu < %zu)", size, sizeof(*header));
+		return -EINVAL;
+	}
+
+	ret = mikrobus_manifest_header_validate(data, size);
+	if (ret < 0) {
+		pr_err("invalid manifest header: %u", manifest_size);
+		return ret;
+	}
+
+	manifest = data;
+	manifest_size = ret;
+
+	if (manifest_size != size) {
+		pr_err("invalid manifest size(%zu < %u)", size, manifest_size);
+		return -EINVAL;
+	}
+
+	desc = manifest->descriptors;
+	size -= sizeof(*header);
+	while (size) {
+		desc_size = board_descriptor_add(board, desc, size);
+		if (desc_size < 0) {
+			pr_err("invalid manifest descriptor, size: %u",
+			       desc_size);
+			return -EINVAL;
+		}
+
+		desc = (void *)desc + desc_size;
+		size -= desc_size;
+	}
+
+	mikrobus_state_get(board);
+	dev_count = mikrobus_manifest_parse_devices(board);
+	pr_info("%s manifest parsed with %d devices", board->name, dev_count);
+	manifest_descriptor_release_all(board);
+
+	return dev_count;
+}
diff --git a/drivers/misc/mikrobus/mikrobus_manifest.h b/drivers/misc/mikrobus/mikrobus_manifest.h
new file mode 100644
index 000000000000..39ae53a25fc4
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_manifest.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mikroBUS manifest definition
+ * extension to Greybus Manifest Definition
+ *
+ * Copyright 2014-2015 Google Inc.
+ * Copyright 2014-2015 Linaro Ltd.
+ *
+ * Released under the GPLv2 and BSD licenses.
+ */
+
+#ifndef __MIKROBUS_MANIFEST_H
+#define __MIKROBUS_MANIFEST_H
+
+#include "mikrobus_core.h"
+
+/*
+ * mikrobus_manifest_header - parse mikroBUS manifest
+ *
+ * @info: addon board info structure to populate with parsed information
+ * @data: pointer to the manifest blob
+ * @size: size of the manifest blob
+ *
+ * returns: number of devices on success, negative error code on failure
+ */
+int mikrobus_manifest_parse(struct addon_board_info *info, void *data,
+			    size_t size);
+
+#endif /* __MIKROBUS_MANIFEST_H */
-- 
2.44.0


