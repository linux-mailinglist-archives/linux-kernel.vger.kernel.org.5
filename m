Return-Path: <linux-kernel+bounces-104814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2673487D415
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7291F2151B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D5354FA0;
	Fri, 15 Mar 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVCmF8rv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986A54BFF;
	Fri, 15 Mar 2024 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528640; cv=none; b=guBHTGx9pipGg/PL25WvX8YvkI2M8+4pzfnrSuO/2VjJyK9A9rMNBKvk2AJuWqZSFCnY0D4W3xnqxNXb7m4XTM/5+8nuPSCEKTF8U8TE1BzQ7i6MZofIo2w88mmJA8QjTQTcX+nr35QeouBm2CCadi8mdbqK5TFW4DBqT/849Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528640; c=relaxed/simple;
	bh=kFQBiuri4m776gOwS+ygG0tyAeEvje7rOeXQ0QCJANA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StWUA9HJ1hvoGd+aH2H8NSK0mSikcCGfrttXVypAYLNi7LmZeUNKoC4jnKZcOCVP8O22d0PWmlwaW/IZpXykSCMsD+ONWeV8dZ0PawB9jQ9AA2ChMwwILj+seWkU3/XM2HAHZvO3AttMEkZnuPWC5DmFUuE83ZXZKA/AFJ3EI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVCmF8rv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6da202aa138so1453323b3a.2;
        Fri, 15 Mar 2024 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710528633; x=1711133433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9UjJ7GsfcyWYu7K9Rx0VvyWCR0FVADYowXJP0DCHdw=;
        b=AVCmF8rvLhZvw2xU9xJsAUXkw7mL2QUFYSaCEoPmRojMGuaSoBR7SH8pKPZ27F7nfQ
         yH1RfrpkjyI7ny0vRQahyh9If+xS+++fuzQV/arSAfI6GiPT61RIKPind0TlyUuuNRdi
         6kdTjauAFWr0ZZCwF6ql62852fIWiYhbv8yY9d98jfBYU7pfsqmpP9mwRvzIQd1NCXyw
         2a2TN3kiaR+edik0QQ4hI45FeVGLpM09ZWuaLqvK9VFIYk1eiZvh75vfdm5cyTuhVuRg
         WnRA/lt0/FySRsvoZ8yTbYSfH2q3IDZO0lRCIR7tXwczNJzqgLiXFfR0H4mOlqmkhtp0
         3wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528633; x=1711133433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9UjJ7GsfcyWYu7K9Rx0VvyWCR0FVADYowXJP0DCHdw=;
        b=hzpO55bhRopCm8awcGCe6tZeXxrheoHB2ooBBLtM1mtDS4uYdFz6gaZYCtBGra0Eyq
         cnBIqtDskohY6sjXo6rGUdTkkPH5mU3MGijpg58OB7YhaGMkmqNRfaccTPM2nysq3pWS
         yMRsbFf/IvfhKbm7zVk+atwedlvy5d2HHW7PU3YUSI1dZVIKBErS/pamh3N5sbRmiRJT
         RE/ONHAzCR4i9o/0veyqwpgzQzWwqcDfVsJu7/+Dk4HndptNegzEXbNoJL04nHdzFw2A
         cykoXD4YlriqBUD0eQbNXwXM5V0wySajCr5Eu4s2hS2jAee6SgE4/6OZL/kBXgdYvErH
         AGLw==
X-Forwarded-Encrypted: i=1; AJvYcCXY2RSt06/1D3pxKSsOX8g3W19ahpMqD4K4FlY2/IB/l9W+S9TlNcmYOP2VUWsmeZOTQJsUfHhzCx+ZhOetMmXjI8zDJtSj3UxiX9mBcYWoxiH80HHgEkX/h2mjdqti+bqVSJuBZ6PImtflmsa5+zjwtGMRsr+B91BP8t0z4XvmiqUAkw==
X-Gm-Message-State: AOJu0YxBOdX3JMNHiDLdV0mzc4Zz3+uE1Dp/wD98yIbk/PV6PVjv/ymg
	6iCw4CifJOFdwj5xYzPl+nZKSwRLCvyF2pvwvSqEvcGfk4wAkN2JH2ytFPmGAexo1g==
X-Google-Smtp-Source: AGHT+IHIK2oeyfiUn0JBesE1uDiyFTvFVanUxllwDGEKH8lwSZ7ATWmd7nm7r8oEXCgcS5WKonCljw==
X-Received: by 2002:a05:6a20:8e19:b0:1a3:49e9:1b6f with SMTP id y25-20020a056a208e1900b001a349e91b6fmr5070984pzj.8.1710528628351;
        Fri, 15 Mar 2024 11:50:28 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a0022d100b006e6cc998be8sm3580784pfj.207.2024.03.15.11.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:50:27 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH v3 7/8] mikrobus: Add mikrobus driver
Date: Sat, 16 Mar 2024 00:19:05 +0530
Message-ID: <20240315184908.500352-8-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315184908.500352-1-ayushdevel1325@gmail.com>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Setup I2C, SPI, serdev controllers associated with mikrobus connector
- Check if a board with valid mikroBUS manifest is connected
- Parse the manifest and register the device to kernel

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 MAINTAINERS                               |   1 +
 drivers/misc/Kconfig                      |   1 +
 drivers/misc/Makefile                     |   1 +
 drivers/misc/mikrobus/Kconfig             |  19 +
 drivers/misc/mikrobus/Makefile            |   6 +
 drivers/misc/mikrobus/mikrobus_core.c     | 942 ++++++++++++++++++++++
 drivers/misc/mikrobus/mikrobus_core.h     | 201 +++++
 drivers/misc/mikrobus/mikrobus_id.c       | 229 ++++++
 drivers/misc/mikrobus/mikrobus_manifest.c | 502 ++++++++++++
 drivers/misc/mikrobus/mikrobus_manifest.h |  20 +
 10 files changed, 1922 insertions(+)
 create mode 100644 drivers/misc/mikrobus/Kconfig
 create mode 100644 drivers/misc/mikrobus/Makefile
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
 create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
 create mode 100644 drivers/misc/mikrobus/mikrobus_id.c
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
index 000000000000..f0770006b4fe
--- /dev/null
+++ b/drivers/misc/mikrobus/Kconfig
@@ -0,0 +1,19 @@
+menuconfig MIKROBUS
+	tristate "Module for instantiating devices on mikroBUS ports"
+	depends on GPIOLIB
+	depends on W1
+	depends on W1_MASTER_GPIO
+	help
+	  This option enables the mikroBUS driver. mikroBUS is an add-on
+	  board socket standard that offers maximum expandability with
+	  the smallest number of pins. The mikroBUS driver instantiates
+	  devices on a mikroBUS port described by identifying data present
+	  in an add-on board resident EEPROM, more details on the mikroBUS
+	  driver support and discussion can be found in this eLinux wiki :
+	  elinux.org/Mikrobus
+
+
+	  Say Y here to enable support for this driver.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called mikrobus.ko
diff --git a/drivers/misc/mikrobus/Makefile b/drivers/misc/mikrobus/Makefile
new file mode 100644
index 000000000000..c89ff2abb80e
--- /dev/null
+++ b/drivers/misc/mikrobus/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+# mikroBUS Core
+
+obj-$(CONFIG_MIKROBUS) += mikrobus.o
+mikrobus-y :=	mikrobus_core.o	mikrobus_manifest.o
+obj-$(CONFIG_MIKROBUS) += mikrobus_id.o
diff --git a/drivers/misc/mikrobus/mikrobus_core.c b/drivers/misc/mikrobus/mikrobus_core.c
new file mode 100644
index 000000000000..17718ed315b9
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_core.c
@@ -0,0 +1,942 @@
+// SPDX-License-Identifier: GPL-2.0
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
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/jump_label.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mutex.h>
+#include <linux/w1.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/driver.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/serdev.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/debugfs.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+#include <linux/clk-provider.h>
+#include <linux/greybus/greybus_manifest.h>
+#include <linux/of_platform.h>
+#include <linux/pwm.h>
+
+#include "mikrobus_core.h"
+#include "mikrobus_manifest.h"
+
+#define MIKROBUS_ID_EEPROM_MANIFEST_ADDR 0x20
+
+static DEFINE_MUTEX(core_lock);
+static DEFINE_IDR(mikrobus_port_idr);
+static struct class_compat *mikrobus_port_compat_class;
+int __mikrobus_first_dynamic_bus_num;
+static bool is_registered;
+static int mikrobus_port_id_eeprom_probe(struct mikrobus_port *port);
+
+const char *MIKROBUS_PINCTRL_STR[] = { "pwm", "uart", "i2c", "spi" };
+
+const struct bus_type mikrobus_bus_type = {
+	.name = "mikrobus",
+};
+EXPORT_SYMBOL_GPL(mikrobus_bus_type);
+
+int mikrobus_port_scan_eeprom(struct mikrobus_port *port)
+{
+	const u16 manifest_start_addr = MIKROBUS_ID_EEPROM_MANIFEST_ADDR;
+	struct addon_board_info *board;
+	int manifest_size, retval;
+	char header[12], *buf;
+
+	if (port->skip_scan)
+		return -EINVAL;
+
+	retval = nvmem_device_read(port->eeprom, manifest_start_addr, 12, header);
+	if (retval != 12) {
+		return dev_err_probe(&port->dev, -EINVAL, "failed to fetch manifest header %d\n",
+				     retval);
+	}
+
+	manifest_size = mikrobus_manifest_header_validate(header, 12);
+	if (manifest_size < 0) {
+		return dev_err_probe(&port->dev, -EINVAL, "invalid manifest size %d\n",
+				     manifest_size);
+	}
+
+	buf = kzalloc(manifest_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	retval = nvmem_device_read(port->eeprom, manifest_start_addr, manifest_size, buf);
+	if (retval != manifest_size) {
+		retval =
+			dev_err_probe(&port->dev, -EINVAL, "failed to fetch manifest %d\n", retval);
+		goto err_free_buf;
+	}
+
+	board = kzalloc(sizeof(*board), GFP_KERNEL);
+	if (!board) {
+		retval = -ENOMEM;
+		goto err_free_buf;
+	}
+
+	w1_reset_bus(port->w1_master);
+	/* set RST HIGH */
+	gpiod_direction_output(port->gpios->desc[MIKROBUS_PIN_RST], 1);
+	set_bit(W1_ABORT_SEARCH, &port->w1_master->flags);
+
+	INIT_LIST_HEAD(&board->manifest_descs);
+	INIT_LIST_HEAD(&board->devices);
+	retval = mikrobus_manifest_parse(board, buf, manifest_size);
+	if (!retval) {
+		retval = dev_err_probe(&port->dev, -EINVAL, "failed to parse manifest, size %d\n",
+				       manifest_size);
+		goto err_free_board;
+	}
+
+	retval = mikrobus_board_register(port, board);
+	if (retval) {
+		dev_err(&port->dev, "failed to register board %s\n", board->name);
+		goto err_free_board;
+	}
+
+	kfree(buf);
+	return 0;
+
+err_free_board:
+	kfree(board);
+err_free_buf:
+	kfree(buf);
+	return retval;
+}
+EXPORT_SYMBOL_GPL(mikrobus_port_scan_eeprom);
+
+static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", to_mikrobus_port(dev)->name);
+}
+static DEVICE_ATTR_RO(name);
+
+static ssize_t new_device_store(struct device *dev, struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+	struct addon_board_info *board;
+	int retval;
+
+	if (port->board)
+		return dev_err_probe(dev, -EBUSY, "already has board registered\n");
+
+	board = kzalloc(sizeof(*board), GFP_KERNEL);
+	if (!board)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&board->manifest_descs);
+	INIT_LIST_HEAD(&board->devices);
+	retval = mikrobus_manifest_parse(board, (void *)buf, count);
+	if (!retval) {
+		retval = dev_err_probe(dev, -EINVAL, "failed to parse manifest\n");
+		goto err_free_board;
+	}
+
+	retval = mikrobus_board_register(port, board);
+	if (retval) {
+		retval = dev_err_probe(dev, -EINVAL, "failed to register board %s\n", board->name);
+		goto err_free_board;
+	}
+
+	return count;
+
+err_free_board:
+	kfree(board);
+	return retval;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t delete_device_store(struct device *dev, struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+	unsigned long id;
+
+	if (kstrtoul(buf, 0, &id))
+		return dev_err_probe(dev, -EINVAL, "cannot parse board id");
+
+	if (!port->board)
+		return dev_err_probe(dev, -ENODEV, "does not have registered boards");
+
+	mikrobus_board_unregister(port, port->board);
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL, delete_device_store);
+
+static struct attribute *mikrobus_port_attrs[] = { &dev_attr_new_device.attr,
+						   &dev_attr_delete_device.attr,
+						   &dev_attr_name.attr, NULL };
+ATTRIBUTE_GROUPS(mikrobus_port);
+
+static void mikrobus_port_release(struct device *dev)
+{
+	struct mikrobus_port *port = to_mikrobus_port(dev);
+
+	mutex_lock(&core_lock);
+	idr_remove(&mikrobus_port_idr, port->id);
+	mutex_unlock(&core_lock);
+
+	kfree(port);
+}
+
+const struct device_type mikrobus_port_type = {
+	.groups = mikrobus_port_groups,
+	.release = mikrobus_port_release,
+};
+EXPORT_SYMBOL_GPL(mikrobus_port_type);
+
+static int mikrobus_w1_master_match(struct device *dev, const void *data)
+{
+	struct mikrobus_port *port;
+
+	if (dev->type != &mikrobus_port_type)
+		return 0;
+
+	port = to_mikrobus_port(dev);
+
+	return port->w1_master == data;
+}
+
+struct mikrobus_port *mikrobus_find_port_by_w1_master(struct w1_master *master)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&mikrobus_bus_type, NULL, master, mikrobus_w1_master_match);
+	if (!dev)
+		return NULL;
+
+	return (dev->type == &mikrobus_port_type) ? to_mikrobus_port(dev) : NULL;
+}
+EXPORT_SYMBOL(mikrobus_find_port_by_w1_master);
+
+int mikrobus_port_pinctrl_select(struct mikrobus_port *port)
+{
+	struct pinctrl_state *state;
+	int retval, i;
+
+	for (i = 0; i < MIKROBUS_NUM_PINCTRL_STATE; i++) {
+		state = pinctrl_lookup_state(port->pinctrl, port->pinctrl_selected[i]);
+		if (!IS_ERR(state)) {
+			retval = pinctrl_select_state(port->pinctrl, state);
+			if (retval) {
+				return dev_err_probe(&port->dev, retval,
+						     "failed to select state %s\n",
+						     port->pinctrl_selected[i]);
+			}
+			dev_dbg(&port->dev, "setting pinctrl %s\n", port->pinctrl_selected[i]);
+		} else {
+			return dev_err_probe(&port->dev, PTR_ERR(state),
+					     "failed to find state %s\n",
+					     port->pinctrl_selected[i]);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mikrobus_port_pinctrl_select);
+
+static int mikrobus_port_pinctrl_setup(struct mikrobus_port *port, struct addon_board_info *board)
+{
+	int retval;
+
+	if (board->pin_state[MIKROBUS_PIN_PWM] == MIKROBUS_STATE_PWM)
+		sprintf(port->pinctrl_selected[MIKROBUS_PINCTRL_PWM], "%s_%s",
+			MIKROBUS_PINCTRL_STR[MIKROBUS_PINCTRL_PWM], PINCTRL_STATE_DEFAULT);
+	else
+		sprintf(port->pinctrl_selected[MIKROBUS_PINCTRL_PWM], "%s_%s",
+			MIKROBUS_PINCTRL_STR[MIKROBUS_PINCTRL_PWM], MIKROBUS_PINCTRL_STATE_GPIO);
+
+	if (board->pin_state[MIKROBUS_PIN_RX] == MIKROBUS_STATE_UART)
+		sprintf(port->pinctrl_selected[MIKROBUS_PINCTRL_UART], "%s_%s",
+			MIKROBUS_PINCTRL_STR[MIKROBUS_PINCTRL_UART], PINCTRL_STATE_DEFAULT);
+	else
+		sprintf(port->pinctrl_selected[MIKROBUS_PINCTRL_UART], "%s_%s",
+			MIKROBUS_PINCTRL_STR[MIKROBUS_PINCTRL_UART], MIKROBUS_PINCTRL_STATE_GPIO);
+
+	if (board->pin_state[MIKROBUS_PIN_SCL] == MIKROBUS_STATE_I2C)
+		sprintf(port->pinctrl_selected[MIKROBUS_PINCTRL_I2C], "%s_%s",
+			MIKROBUS_PINCTRL_STR[MIKROBUS_PINCTRL_I2C], PINCTRL_STATE_DEFAULT);
+	else
+		sprintf(port->pinctrl_selected[MIKROBUS_PINCTRL_I2C], "%s_%s",
+			MIKROBUS_PINCTRL_STR[MIKROBUS_PINCTRL_I2C], MIKROBUS_PINCTRL_STATE_GPIO);
+
+	if (board->pin_state[MIKROBUS_PIN_MOSI] == MIKROBUS_STATE_SPI)
+		sprintf(port->pinctrl_selected[MIKROBUS_PINCTRL_SPI], "%s_%s",
+			MIKROBUS_PINCTRL_STR[MIKROBUS_PINCTRL_SPI], PINCTRL_STATE_DEFAULT);
+	else
+		sprintf(port->pinctrl_selected[MIKROBUS_PINCTRL_SPI], "%s_%s",
+			MIKROBUS_PINCTRL_STR[MIKROBUS_PINCTRL_SPI], MIKROBUS_PINCTRL_STATE_GPIO);
+
+	retval = mikrobus_port_pinctrl_select(port);
+	if (retval)
+		dev_err(&port->dev, "failed to select pinctrl states [%d]", retval);
+
+	return retval;
+}
+
+static int mikrobus_irq_get(struct mikrobus_port *port, int irqno, int irq_type)
+{
+	int irq;
+
+	if (irqno > port->gpios->ndescs - 1)
+		return dev_err_probe(&port->dev, -ENODEV, "GPIO %d does not exist", irqno);
+
+	irq = gpiod_to_irq(port->gpios->desc[irqno]);
+	if (irq < 0)
+		return dev_err_probe(&port->dev, -EINVAL, "could not get irq %d", irqno);
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
+	return kmemdup(gpiochip->label, MIKROBUS_NAME_SIZE, GFP_KERNEL);
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
+static int mikrobus_device_register(struct mikrobus_port *port, struct board_device_info *dev,
+				    char *board_name)
+{
+	struct regulator_consumer_supply regulator;
+	struct gpiod_lookup_table *lookup;
+	char devname[MIKROBUS_NAME_SIZE];
+	struct spi_board_info *spi_info;
+	struct i2c_board_info *i2c_info;
+	struct serdev_device *serdev;
+	struct platform_device *pdev;
+	struct fwnode_handle *fwnode;
+	struct spi_device *spi;
+	int i, retval;
+	u64 *val;
+
+	dev_info(&port->dev, "registering device : %s", dev->drv_name);
+
+	if (dev->gpio_lookup) {
+		lookup = dev->gpio_lookup;
+
+		switch (dev->protocol) {
+		case GREYBUS_PROTOCOL_SPI:
+			snprintf(devname, sizeof(devname), "%s.%u", dev_name(&port->spi_ctrl->dev),
+				 port->chip_select[dev->reg]);
+			lookup->dev_id = kmemdup(devname, MIKROBUS_NAME_SIZE, GFP_KERNEL);
+			break;
+		case GREYBUS_PROTOCOL_RAW:
+			snprintf(devname, sizeof(devname), "%s.%u", dev->drv_name, dev->reg);
+			lookup->dev_id = kmemdup(devname, MIKROBUS_NAME_SIZE, GFP_KERNEL);
+			break;
+		default:
+			lookup->dev_id = dev->drv_name;
+		}
+
+		dev_info(&port->dev, "adding lookup table : %s", lookup->dev_id);
+
+		for (i = 0; i < dev->num_gpio_resources; i++) {
+			lookup->table[i].key =
+				mikrobus_gpio_chip_name_get(port, lookup->table[i].chip_hwnum);
+			lookup->table[i].chip_hwnum =
+				mikrobus_gpio_hwnum_get(port, lookup->table[i].chip_hwnum);
+		}
+
+		gpiod_add_lookup_table(lookup);
+	}
+
+	if (dev->regulators) {
+		if (dev->protocol == GREYBUS_PROTOCOL_SPI) {
+			snprintf(devname, sizeof(devname), "%s.%u", dev_name(&port->spi_ctrl->dev),
+				 port->chip_select[dev->reg]);
+			regulator.dev_name = kmemdup(devname, MIKROBUS_NAME_SIZE, GFP_KERNEL);
+		} else if (dev->protocol == GREYBUS_PROTOCOL_RAW) {
+			snprintf(devname, sizeof(devname), "%s.%u", dev->drv_name, dev->reg);
+			regulator.dev_name = kmemdup(devname, MIKROBUS_NAME_SIZE, GFP_KERNEL);
+		} else {
+			regulator.dev_name = dev->drv_name;
+		}
+
+		for (i = 0; i < dev->num_regulators; i++) {
+			val = dev->regulators[i].value.u64_data;
+			regulator.supply =
+				kmemdup(dev->regulators[i].name, MIKROBUS_NAME_SIZE, GFP_KERNEL);
+			dev_info(&port->dev, "adding fixed regulator %llu uv, %s for %s", *val,
+				 regulator.supply, regulator.dev_name);
+			regulator_register_always_on(0, dev->regulators[i].name, &regulator, 1,
+						     *val);
+		}
+	}
+
+	switch (dev->protocol) {
+	case GREYBUS_PROTOCOL_SPI:
+		spi_info = kzalloc(sizeof(*spi_info), GFP_KERNEL);
+		strscpy_pad(spi_info->modalias, dev->drv_name, sizeof(spi_info->modalias) - 1);
+		if (dev->irq)
+			spi_info->irq = mikrobus_irq_get(port, dev->irq, dev->irq_type);
+		if (dev->properties) {
+			fwnode = fwnode_create_software_node(dev->properties, NULL);
+			spi_info->swnode = to_software_node(fwnode);
+		}
+		spi_info->chip_select = port->chip_select[dev->reg];
+		spi_info->max_speed_hz = dev->max_speed_hz;
+		spi_info->mode = dev->mode;
+
+		spi = spi_new_device(port->spi_ctrl, spi_info);
+		if (!spi)
+			return dev_err_probe(&port->dev, -ENOMEM, "failed to create spi device");
+
+		if (dev->clocks) {
+			for (i = 0; i < dev->num_clocks; i++) {
+				val = dev->clocks[i].value.u64_data;
+				dev_info(&port->dev, "adding fixed clock %s, %llu hz",
+					 dev->clocks[i].name, *val);
+				clk_register_fixed_rate(&spi->dev, dev->clocks[i].name, devname, 0,
+							*val);
+			}
+		}
+
+		dev->dev_client = (void *)spi;
+		break;
+	case GREYBUS_PROTOCOL_I2C:
+		i2c_info = kzalloc(sizeof(*i2c_info), GFP_KERNEL);
+		if (!i2c_info)
+			return -ENOMEM;
+
+		strscpy_pad(i2c_info->type, dev->drv_name, sizeof(i2c_info->type) - 1);
+		if (dev->irq)
+			i2c_info->irq = mikrobus_irq_get(port, dev->irq, dev->irq_type);
+		if (dev->properties) {
+			fwnode = fwnode_create_software_node(dev->properties, NULL);
+			i2c_info->swnode = to_software_node(fwnode);
+		}
+		i2c_info->addr = dev->reg;
+		dev->dev_client = (void *)i2c_new_client_device(port->i2c_adap, i2c_info);
+		break;
+	case GREYBUS_PROTOCOL_RAW:
+		pdev = platform_device_alloc(dev->drv_name, 0);
+		if (!pdev)
+			return -ENOMEM;
+
+		if (dev->properties) {
+			retval = device_create_managed_software_node(&pdev->dev, dev->properties,
+								     NULL);
+			if (retval)
+				return dev_err_probe(&port->dev, retval,
+						     "failed to create software node");
+		}
+		dev->dev_client = pdev;
+		platform_device_add(dev->dev_client);
+		break;
+	case GREYBUS_PROTOCOL_UART:
+		serdev = serdev_device_alloc(port->ser_ctrl);
+		if (!serdev)
+			return -ENOMEM;
+
+		if (dev->properties)
+			device_create_managed_software_node(&serdev->dev, dev->properties, NULL);
+
+		dev->dev_client = serdev;
+		serdev_device_add(serdev);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void mikrobus_device_unregister(struct mikrobus_port *port, struct board_device_info *dev,
+				       char *board_name)
+{
+	dev_info(&port->dev, "removing device %s\n", dev->drv_name);
+	if (dev->gpio_lookup) {
+		gpiod_remove_lookup_table(dev->gpio_lookup);
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
+		platform_device_unregister((struct platform_device *)dev->dev_client);
+		break;
+	case GREYBUS_PROTOCOL_UART:
+		serdev_device_remove((struct serdev_device *)dev->dev_client);
+		break;
+	}
+}
+
+int mikrobus_board_register(struct mikrobus_port *port, struct addon_board_info *board)
+{
+	struct board_device_info *devinfo, *next;
+	int retval, i;
+
+	if (WARN_ON(list_empty(&board->devices)))
+		return false;
+
+	if (port->pinctrl) {
+		retval = mikrobus_port_pinctrl_setup(port, board);
+		if (retval)
+			dev_err(&port->dev, "failed to setup pinctrl state [%d]", retval);
+	}
+
+	if (port->gpios) {
+		for (i = 0; i < port->gpios->ndescs; i++) {
+			retval = mikrobus_gpio_setup(port->gpios->desc[i], board->pin_state[i]);
+			if (retval)
+				dev_err(&port->dev, "failed to setup gpio %d, state %d", i,
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
+EXPORT_SYMBOL_GPL(mikrobus_board_register);
+
+void mikrobus_board_unregister(struct mikrobus_port *port, struct addon_board_info *board)
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
+	kfree(board);
+	port->board = NULL;
+}
+EXPORT_SYMBOL_GPL(mikrobus_board_unregister);
+
+static int mikrobus_port_id_eeprom_probe(struct mikrobus_port *port)
+{
+	static const char drvname[MIKROBUS_NAME_SIZE] = "w1-gpio\0";
+	struct platform_device *mikrobus_id_eeprom_w1_device;
+	struct gpiod_lookup_table *lookup;
+	char devname[MIKROBUS_NAME_SIZE];
+	struct w1_bus_master *bm;
+	int retval;
+
+	sprintf(port->pinctrl_selected[MIKROBUS_PINCTRL_SPI], "%s_%s",
+		MIKROBUS_PINCTRL_STR[MIKROBUS_PINCTRL_SPI], MIKROBUS_PINCTRL_STATE_GPIO);
+
+	retval = mikrobus_port_pinctrl_select(port);
+
+	/* set RST LOW */
+	gpiod_direction_output(port->gpios->desc[MIKROBUS_PIN_RST], 0);
+
+	lookup = kzalloc(struct_size(lookup, table, 1), GFP_KERNEL);
+	if (!lookup)
+		return -ENOMEM;
+
+	retval = snprintf(devname, sizeof(devname), "%s.%u", drvname, port->id);
+	lookup->dev_id = kmemdup(devname, retval + 1, GFP_KERNEL);
+	lookup->table[0].key = mikrobus_gpio_chip_name_get(port, MIKROBUS_PIN_CS);
+	lookup->table[0].flags = GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN;
+	lookup->table[0].chip_hwnum = mikrobus_gpio_hwnum_get(port, MIKROBUS_PIN_CS);
+
+	gpiochip_free_own_desc(port->gpios->desc[MIKROBUS_PIN_CS]);
+	gpiod_add_lookup_table(lookup);
+
+	mikrobus_id_eeprom_w1_device = platform_device_register_simple(drvname, port->id, NULL, 0);
+	if (IS_ERR(mikrobus_id_eeprom_w1_device)) {
+		retval = PTR_ERR(mikrobus_id_eeprom_w1_device);
+		dev_err(&port->dev, "failed to register w1-gpio device %d", retval);
+		goto early_exit;
+	}
+
+	port->w1_gpio = mikrobus_id_eeprom_w1_device;
+
+	bm = (struct w1_bus_master *)platform_get_drvdata(mikrobus_id_eeprom_w1_device);
+	if (!bm) {
+		dev_err(&port->dev, "failed to get w1_bus_master");
+		return 0;
+	}
+
+	port->w1_master = w1_find_master_device(bm);
+	if (!port->w1_master) {
+		dev_err(&port->dev, "failed to find W1 GPIO master, port [%s]", port->name);
+		goto early_exit;
+	}
+
+	port->w1_master->search_count = 4;
+
+	return 0;
+
+early_exit:
+	gpiod_remove_lookup_table(lookup);
+	kfree(lookup);
+	return -ENODEV;
+}
+
+int mikrobus_port_register(struct mikrobus_port *port)
+{
+	struct device *dev = &port->dev;
+	int retval, id;
+
+	if (WARN_ON(!is_registered))
+		return -EAGAIN;
+
+	if (dev->of_node) {
+		id = of_alias_get_id(dev->of_node, "mikrobus");
+		if (id >= 0) {
+			port->id = id;
+			mutex_lock(&core_lock);
+			id = idr_alloc(&mikrobus_port_idr, port, port->id, port->id + 1,
+				       GFP_KERNEL);
+			mutex_unlock(&core_lock);
+			if (WARN(id < 0, "couldn't get idr"))
+				return id == -ENOSPC ? -EBUSY : id;
+		}
+	} else {
+		mutex_lock(&core_lock);
+		id = idr_alloc(&mikrobus_port_idr, port, __mikrobus_first_dynamic_bus_num, 0,
+			       GFP_KERNEL);
+		mutex_unlock(&core_lock);
+		if (id < 0)
+			return id;
+
+		port->id = id;
+	}
+
+	port->dev.bus = &mikrobus_bus_type;
+	port->dev.type = &mikrobus_port_type;
+	strscpy_pad(port->name, "mikrobus-port", sizeof(port->name) - 1);
+	dev_set_name(&port->dev, "mikrobus-%d", port->id);
+	dev_info(&port->dev, "registering port mikrobus-%d ", port->id);
+
+	retval = device_register(&port->dev);
+	if (retval) {
+		dev_err(&port->dev, "port '%d': can't register device (%d)", port->id, retval);
+		put_device(&port->dev);
+		return retval;
+	}
+
+	retval = class_compat_create_link(mikrobus_port_compat_class, &port->dev, port->dev.parent);
+	if (retval)
+		dev_warn(&port->dev, "failed to create compatibility class link");
+
+	if (!port->w1_master) {
+		dev_info(&port->dev, "mikrobus port %d eeprom empty probing default eeprom",
+			 port->id);
+		mutex_lock(&core_lock);
+		retval = mikrobus_port_id_eeprom_probe(port);
+		mutex_unlock(&core_lock);
+	}
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(mikrobus_port_register);
+
+void mikrobus_port_delete(struct mikrobus_port *port)
+{
+	struct mikrobus_port *found;
+
+	mutex_lock(&core_lock);
+	found = idr_find(&mikrobus_port_idr, port->id);
+	mutex_unlock(&core_lock);
+	if (found != port) {
+		pr_err("port [%s] not registered", port->name);
+		return;
+	}
+
+	if (port->board) {
+		dev_err(&port->dev, "attempting to delete port with registered boards, port [%s]\n",
+			port->name);
+		return;
+	}
+
+	if (port->eeprom) {
+		nvmem_device_put(port->eeprom);
+		platform_device_unregister(port->w1_gpio);
+	}
+
+	class_compat_remove_link(mikrobus_port_compat_class, &port->dev, port->dev.parent);
+	device_unregister(&port->dev);
+	mutex_lock(&core_lock);
+	idr_remove(&mikrobus_port_idr, port->id);
+	mutex_unlock(&core_lock);
+	memset(&port->dev, 0, sizeof(port->dev));
+}
+EXPORT_SYMBOL_GPL(mikrobus_port_delete);
+
+static int mikrobus_port_probe_pinctrl_setup(struct mikrobus_port *port)
+{
+	struct device *dev = port->dev.parent;
+	struct pinctrl_state *state;
+	int retval, i;
+
+	state = pinctrl_lookup_state(port->pinctrl, PINCTRL_STATE_DEFAULT);
+	if (!IS_ERR(state)) {
+		retval = pinctrl_select_state(port->pinctrl, state);
+		if (retval) {
+			return dev_err_probe(dev, retval, "Failed to select state %s\n",
+					     PINCTRL_STATE_DEFAULT);
+		}
+	} else {
+		return dev_err_probe(dev, PTR_ERR(state), "failed to find state %s\n",
+				     PINCTRL_STATE_DEFAULT);
+	}
+
+	for (i = 0; i < MIKROBUS_NUM_PINCTRL_STATE; i++) {
+		port->pinctrl_selected[i] = kmalloc(MIKROBUS_PINCTRL_NAME_SIZE, GFP_KERNEL);
+		sprintf(port->pinctrl_selected[i], "%s_%s", MIKROBUS_PINCTRL_STR[i],
+			PINCTRL_STATE_DEFAULT);
+	}
+
+	retval = mikrobus_port_pinctrl_select(port);
+	if (retval)
+		dev_err(dev, "failed to select pinctrl states [%d]", retval);
+
+	return retval;
+}
+
+static int mikrobus_port_probe(struct platform_device *pdev)
+{
+	struct device_node *i2c_adap_np, *uart_np, *spi_np;
+	struct device *dev = &pdev->dev;
+	struct mikrobus_port *port;
+	int retval;
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	/* I2C setup */
+	i2c_adap_np = of_parse_phandle(dev->of_node, "i2c-adapter", 0);
+	if (!i2c_adap_np) {
+		retval = dev_err_probe(dev, -ENODEV, "cannot parse i2c-adapter");
+		goto err_port;
+	}
+	port->i2c_adap = of_find_i2c_adapter_by_node(i2c_adap_np);
+	of_node_put(i2c_adap_np);
+
+	/* GPIO setup */
+	port->gpios = gpiod_get_array(dev, "mikrobus", GPIOD_OUT_LOW);
+	if (IS_ERR(port->gpios)) {
+		retval = PTR_ERR(port->gpios);
+		dev_err(dev, "failed to get gpio array [%d]", retval);
+		goto err_port;
+	}
+
+	/* SPI setup */
+	spi_np = of_parse_phandle(dev->of_node, "spi-controller", 0);
+	if (!spi_np) {
+		retval = dev_err_probe(dev, -ENODEV, "cannot parse spi-controller");
+		goto err_port;
+	}
+	port->spi_ctrl = of_find_spi_controller_by_node(spi_np);
+	of_node_put(spi_np);
+	if (!port->spi_ctrl) {
+		retval = dev_err_probe(dev, -ENODEV, "cannot find spi controller");
+		goto err_port;
+	}
+	retval = device_property_read_u32_array(dev, "spi-cs", port->chip_select, MIKROBUS_NUM_CS);
+	if (retval) {
+		dev_err(dev, "failed to get spi-cs [%d]", retval);
+		goto err_port;
+	}
+
+	/* UART setup */
+	uart_np = of_parse_phandle(dev->of_node, "uart", 0);
+	if (!uart_np) {
+		retval = dev_err_probe(dev, -ENODEV, "cannot parse uart");
+		goto err_port;
+	}
+	port->ser_ctrl = of_find_serdev_controller_by_node(uart_np);
+	of_node_put(uart_np);
+	if (!port->ser_ctrl) {
+		retval = dev_err_probe(dev, -ENODEV, "cannot find uart controller");
+		goto err_port;
+	}
+
+	/* PWM setup */
+	port->pwm = devm_pwm_get(dev, NULL);
+	if (!port->pwm) {
+		retval = dev_err_probe(dev, -ENODEV, "cannot find pwm controller");
+		goto err_port;
+	}
+
+	/* pinctrl setup */
+	port->pinctrl = devm_pinctrl_get(dev);
+	if (IS_ERR(port->pinctrl)) {
+		retval = PTR_ERR(port->pinctrl);
+		dev_err(dev, "failed to get pinctrl [%d]", retval);
+		goto err_port;
+	}
+	port->dev.parent = dev;
+	port->dev.of_node = pdev->dev.of_node;
+	retval = mikrobus_port_probe_pinctrl_setup(port);
+	if (retval) {
+		dev_err(dev, "failed to setup pinctrl [%d]", retval);
+		goto err_port;
+	}
+
+	retval = mikrobus_port_register(port);
+	if (retval) {
+		dev_err(dev, "port : can't register port [%d]", retval);
+		goto err_port;
+	}
+
+	platform_set_drvdata(pdev, port);
+
+	return 0;
+
+err_port:
+	kfree(port);
+	return retval;
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
+		.of_match_table = of_match_ptr(mikrobus_port_of_match),
+	},
+};
+
+static int mikrobus_init(void)
+{
+	int retval;
+
+	retval = bus_register(&mikrobus_bus_type);
+	if (retval) {
+		pr_err("bus_register failed (%d)\n", retval);
+		return retval;
+	}
+
+	mikrobus_port_compat_class = class_compat_register("mikrobus-port");
+	if (!mikrobus_port_compat_class) {
+		pr_err("class_compat register failed (%d)\n", retval);
+		retval = -ENOMEM;
+		goto class_err;
+	}
+
+	retval = of_alias_get_highest_id("mikrobus");
+	if (retval >= __mikrobus_first_dynamic_bus_num)
+		__mikrobus_first_dynamic_bus_num = retval + 1;
+
+	is_registered = true;
+	retval = platform_driver_register(&mikrobus_port_driver);
+	if (retval)
+		pr_err("driver register failed [%d]\n", retval);
+
+	return retval;
+
+class_err:
+	bus_unregister(&mikrobus_bus_type);
+	idr_destroy(&mikrobus_port_idr);
+	is_registered = false;
+	return retval;
+}
+subsys_initcall(mikrobus_init);
+
+static void mikrobus_exit(void)
+{
+	platform_driver_unregister(&mikrobus_port_driver);
+	bus_unregister(&mikrobus_bus_type);
+	class_compat_unregister(mikrobus_port_compat_class);
+	idr_destroy(&mikrobus_port_idr);
+}
+module_exit(mikrobus_exit);
+
+MODULE_AUTHOR("Vaishnav M A <vaishnav@beagleboard.org>");
+MODULE_AUTHOR("Ayush Singh <ayushdevel1325@beagleboard.org>");
+MODULE_DESCRIPTION("mikroBUS main module");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/mikrobus/mikrobus_core.h b/drivers/misc/mikrobus/mikrobus_core.h
new file mode 100644
index 000000000000..8bd101828964
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_core.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mikroBUS Driver for instantiating add-on
+ * board devices with an identifier EEPROM
+ *
+ * Copyright 2020 Vaishnav M A, BeagleBoard.org Foundation.
+ */
+
+#ifndef __MIKROBUS_H
+#define __MIKROBUS_H
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
+#include <linux/spi/spi.h>
+#include <linux/serdev.h>
+#include <linux/property.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+
+#define MIKROBUS_VERSION_MAJOR 0x00
+#define MIKROBUS_VERSION_MINOR 0x03
+
+#define MIKROBUS_NAME_SIZE 40
+#define MIKROBUS_PINCTRL_NAME_SIZE 20
+
+#define MIKROBUS_NUM_PINCTRL_STATE 4
+#define MIKROBUS_NUM_CS 2
+
+#define MIKROBUS_PINCTRL_PWM 0
+#define MIKROBUS_PINCTRL_UART 1
+#define MIKROBUS_PINCTRL_I2C 2
+#define MIKROBUS_PINCTRL_SPI 3
+
+#define MIKROBUS_PINCTRL_STATE_GPIO "gpio"
+
+#define MIKROBUS_EEPROM_EXIT_ID_CMD 0xD2
+
+extern const struct bus_type mikrobus_bus_type;
+extern const struct device_type mikrobus_port_type;
+extern const char *MIKROBUS_PINCTRL_STR[];
+
+enum mikrobus_property_type {
+	MIKROBUS_PROPERTY_TYPE_MIKROBUS = 0x00,
+	MIKROBUS_PROPERTY_TYPE_PROPERTY = 0x01,
+	MIKROBUS_PROPERTY_TYPE_GPIO = 0x02,
+	MIKROBUS_PROPERTY_TYPE_U8 = 0x03,
+	MIKROBUS_PROPERTY_TYPE_U16 = 0x04,
+	MIKROBUS_PROPERTY_TYPE_U32 = 0x05,
+	MIKROBUS_PROPERTY_TYPE_U64 = 0x06,
+	MIKROBUS_PROPERTY_TYPE_REGULATOR = 0x07,
+	MIKROBUS_PROPERTY_TYPE_CLOCK = 0x08,
+};
+
+enum mikrobus_pin {
+	MIKROBUS_PIN_PWM = 0x00,
+	MIKROBUS_PIN_INT = 0x01,
+	MIKROBUS_PIN_RX = 0x02,
+	MIKROBUS_PIN_TX = 0x03,
+	MIKROBUS_PIN_SCL = 0x04,
+	MIKROBUS_PIN_SDA = 0x05,
+	MIKROBUS_PIN_MOSI = 0x06,
+	MIKROBUS_PIN_MISO = 0x07,
+	MIKROBUS_PIN_SCK = 0x08,
+	MIKROBUS_PIN_CS = 0x09,
+	MIKROBUS_PIN_RST = 0x0A,
+	MIKROBUS_PIN_AN = 0x0B,
+	MIKROBUS_PORT_PIN_COUNT = 0x0C,
+};
+
+enum mikrobus_pin_state {
+	MIKROBUS_STATE_INPUT = 0x01,
+	MIKROBUS_STATE_OUTPUT_HIGH = 0x02,
+	MIKROBUS_STATE_OUTPUT_LOW = 0x03,
+	MIKROBUS_STATE_PWM = 0x04,
+	MIKROBUS_STATE_SPI = 0x05,
+	MIKROBUS_STATE_I2C = 0x06,
+	MIKROBUS_STATE_UART = 0x07,
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
+	struct property_entry *regulators;
+	struct property_entry *clocks;
+	struct list_head links;
+	unsigned short num_gpio_resources;
+	unsigned short num_properties;
+	unsigned short num_regulators;
+	unsigned short num_clocks;
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
+ * mikrobus_port describes the peripherals mapped to a
+ * mikrobus port.
+ *
+ * @eeprom_client: i2c_client corresponding to the eeprom
+ * on the add-on board.
+ * @board: pointer to the attached add-on board.
+ * @i2c_adap: I2C adapter attached to the mikrobus port.
+ * @spi_mstr: SPI master attached to the mikrobus port.
+ * @eeprom: nvmem_device for the eeprom on the add-on board.
+ * @pwm: pwm_device attached to the mikrobus port PWM pin.
+ * @pinctrl_selected: current pinctrl_selected state.
+ * @chip_select: chip select number mapped to the SPI
+ * CS pin on the mikrobus port and the RST pin on the mikrobus
+ * port
+ * @id: port id starting from 1
+ */
+struct mikrobus_port {
+	struct addon_board_info *board;
+	struct nvmem_device *eeprom;
+	struct i2c_adapter *i2c_adap;
+	struct spi_controller *spi_ctrl;
+	struct w1_master *w1_master;
+	struct platform_device *w1_gpio;
+	struct serdev_controller *ser_ctrl;
+	struct gpio_descs *gpios;
+	struct pwm_device *pwm;
+	struct pinctrl *pinctrl;
+	struct module *owner;
+	struct device dev;
+	char name[MIKROBUS_NAME_SIZE];
+	char *pinctrl_selected[MIKROBUS_NUM_PINCTRL_STATE];
+	unsigned int chip_select[MIKROBUS_NUM_CS];
+	int skip_scan;
+	int id;
+};
+
+#define to_mikrobus_port(d) container_of(d, struct mikrobus_port, dev)
+
+void mikrobus_board_unregister(struct mikrobus_port *port, struct addon_board_info *board);
+int mikrobus_board_register(struct mikrobus_port *port, struct addon_board_info *board);
+int mikrobus_port_register(struct mikrobus_port *port);
+int mikrobus_port_pinctrl_select(struct mikrobus_port *port);
+void mikrobus_port_delete(struct mikrobus_port *port);
+int mikrobus_port_scan_eeprom(struct mikrobus_port *port);
+struct mikrobus_port *mikrobus_find_port_by_w1_master(struct w1_master *master);
+#endif /* __MIKROBUS_H */
diff --git a/drivers/misc/mikrobus/mikrobus_id.c b/drivers/misc/mikrobus/mikrobus_id.c
new file mode 100644
index 000000000000..42a0a558785d
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_id.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * mikrobus_id.c - w1 mikroBUS ID family EEPROM driver
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+
+#include <linux/crc16.h>
+#include <linux/w1.h>
+#include <linux/nvmem-provider.h>
+
+#include "mikrobus_core.h"
+
+#define W1_EEPROM_MIKROBUS_ID 0xCC
+#define W1_MIKROBUS_ID_EEPROM_SIZE 0x0200
+#define W1_MIKROBUS_ID_EEPROM_PAGE_SIZE 32
+#define W1_MIKROBUS_ID_READ_EEPROM 0x69
+#define W1_MIKROBUS_ID_WRITE_EEPROM 0x96
+#define W1_MIKROBUS_ID_RELEASE_EEPROM 0xAA
+#define W1_MIKROBUS_ID_EEPROM_READ_RETRIES 10
+
+#define W1_MIKROBUS_EEPROM_MANIFEST_START_PAGE 1
+
+static ssize_t mikrobus_manifest_store(struct device *device, struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	u8 write_request[] = { W1_MIKROBUS_ID_WRITE_EEPROM,
+			       W1_MIKROBUS_EEPROM_MANIFEST_START_PAGE };
+	u8 release_command = W1_MIKROBUS_ID_RELEASE_EEPROM;
+	struct w1_slave *sl = dev_to_w1_slave(device);
+	u16 crc, crc_read, pos = 0;
+	u8 status = 0;
+	int cnt;
+
+	if (count > W1_MIKROBUS_ID_EEPROM_SIZE)
+		return -ENOMEM;
+
+	mutex_lock(&sl->master->bus_mutex);
+
+	pr_info("mikrobus_id: writing manifest size = %lu bytes", count);
+	while (pos < count) {
+		if (w1_reset_select_slave(sl))
+			break;
+
+		w1_write_block(sl->master, write_request, sizeof(write_request));
+		crc = crc16(0, write_request, sizeof(write_request)) ^ 0xFFFF;
+		w1_read_block(sl->master, (u8 *)&crc_read, sizeof(crc_read));
+
+		if (crc != crc_read)
+			break;
+
+		for (cnt = 0; cnt < W1_MIKROBUS_ID_EEPROM_PAGE_SIZE; cnt++)
+			w1_write_8(sl->master, (u8)buf[cnt]);
+
+		crc = crc16(0, buf, W1_MIKROBUS_ID_EEPROM_PAGE_SIZE) ^ 0xFFFF;
+		usleep_range(1 * USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+		w1_read_block(sl->master, (u8 *)&crc_read, sizeof(crc_read));
+
+		if (crc != crc_read)
+			break;
+
+		w1_write_8(sl->master, release_command);
+		usleep_range(10 * USEC_PER_MSEC, 15 * USEC_PER_MSEC);
+		status = w1_read_8(sl->master);
+		w1_read_block(sl->master, (u8 *)&crc_read, sizeof(crc_read));
+		crc = crc16(0, (u8 *)&release_command, sizeof(release_command)) ^ 0xFFFF;
+
+		if (status != W1_MIKROBUS_ID_RELEASE_EEPROM)
+			break;
+
+		if (crc != crc_read)
+			break;
+
+		buf += W1_MIKROBUS_ID_EEPROM_PAGE_SIZE;
+		pos += W1_MIKROBUS_ID_EEPROM_PAGE_SIZE;
+		write_request[1]++;
+	}
+
+	pr_info("mikrobus_id: manifest written bytes: %d", pos);
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return count > pos ? count : pos;
+}
+static DEVICE_ATTR_WO(mikrobus_manifest);
+
+static struct attribute *w1_mikrobus_attrs[] = { &dev_attr_mikrobus_manifest.attr, NULL };
+
+ATTRIBUTE_GROUPS(w1_mikrobus);
+
+static int w1_mikrobus_id_readpage(struct w1_slave *sl, int pageaddr, char *buf)
+{
+	u8 crc_rdbuf[2];
+
+	if (w1_reset_select_slave(sl))
+		return -1;
+
+	w1_write_8(sl->master, W1_MIKROBUS_ID_READ_EEPROM);
+	w1_write_8(sl->master, pageaddr);
+	w1_read_block(sl->master, crc_rdbuf, 2);
+	w1_write_8(sl->master, W1_MIKROBUS_ID_RELEASE_EEPROM);
+	usleep_range(10 * USEC_PER_MSEC, 15 * USEC_PER_MSEC);
+	w1_read_block(sl->master, crc_rdbuf, 1);
+	w1_read_block(sl->master, buf, W1_MIKROBUS_ID_EEPROM_PAGE_SIZE);
+	w1_read_block(sl->master, crc_rdbuf, 2);
+
+	return 0;
+}
+
+static int w1_mikrobus_id_readbuf(struct w1_slave *sl, int count, int off, char *buf)
+{
+	int len = count - (count % W1_MIKROBUS_ID_EEPROM_PAGE_SIZE);
+	u8 pageaddr = off / W1_MIKROBUS_ID_EEPROM_PAGE_SIZE;
+	u8 temp_rdbuf[W1_MIKROBUS_ID_EEPROM_PAGE_SIZE];
+	int iter, index, ret;
+
+	while (len > 0) {
+		ret = w1_mikrobus_id_readpage(
+			sl, pageaddr, buf + (W1_MIKROBUS_ID_EEPROM_PAGE_SIZE * pageaddr - off));
+		pageaddr += 1;
+		len -= W1_MIKROBUS_ID_EEPROM_PAGE_SIZE;
+	}
+
+	if (count % W1_MIKROBUS_ID_EEPROM_PAGE_SIZE) {
+		ret = w1_mikrobus_id_readpage(sl, pageaddr, temp_rdbuf);
+		for (iter = W1_MIKROBUS_ID_EEPROM_PAGE_SIZE * pageaddr - off, index = 0;
+		     iter < count; iter++, index++)
+			buf[iter] = temp_rdbuf[index];
+	}
+
+	return ret;
+}
+
+static int w1_mikrobus_id_readblock(struct w1_slave *sl, int off, int count, char *buf)
+{
+	int tries = W1_MIKROBUS_ID_EEPROM_READ_RETRIES;
+	int ret = -EINVAL;
+	u8 *cmp;
+
+	cmp = kzalloc(count, GFP_KERNEL);
+	if (!cmp)
+		return -ENOMEM;
+
+	do {
+		w1_mikrobus_id_readbuf(sl, count, off, buf);
+
+		w1_mikrobus_id_readbuf(sl, count, off, cmp);
+		if (!memcmp(cmp, buf, count)) {
+			ret = 0;
+			break;
+		}
+	} while (--tries);
+
+	kfree(cmp);
+	return ret;
+}
+
+static int w1_mikrobus_id_nvmem_read(void *priv, unsigned int off, void *buf, size_t count)
+{
+	struct w1_slave *sl = priv;
+	int ret;
+
+	mutex_lock(&sl->master->bus_mutex);
+	ret = w1_mikrobus_id_readblock(sl, off, count, buf);
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
+static int w1_mikrobus_id_add_slave(struct w1_slave *sl)
+{
+	struct nvmem_device *nvmem;
+	struct mikrobus_port *port;
+	struct nvmem_config nvmem_cfg = {
+		.dev = &sl->dev,
+		.reg_read = w1_mikrobus_id_nvmem_read,
+		.type = NVMEM_TYPE_EEPROM,
+		.read_only = true,
+		.word_size = 1,
+		.stride = 1,
+		.size = W1_MIKROBUS_ID_EEPROM_SIZE,
+		.priv = sl,
+	};
+
+	port = mikrobus_find_port_by_w1_master(sl->master);
+	if (!port)
+		return -ENODEV;
+
+	nvmem_cfg.name = port->name;
+	nvmem = devm_nvmem_register(&sl->dev, &nvmem_cfg);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	port->eeprom = nvmem;
+	mikrobus_port_scan_eeprom(port);
+
+	return 0;
+}
+
+static const struct w1_family_ops w1_family_mikrobus_id_fops = { .add_slave =
+									 w1_mikrobus_id_add_slave,
+								 .groups = w1_mikrobus_groups };
+
+static struct w1_family w1_family_mikrobus_id = {
+	.fid = W1_EEPROM_MIKROBUS_ID,
+	.fops = &w1_family_mikrobus_id_fops,
+};
+
+static int w1_mikrobusid_init(void)
+{
+	return w1_register_family(&w1_family_mikrobus_id);
+}
+
+static void w1_mikrobusid_exit(void)
+{
+	w1_unregister_family(&w1_family_mikrobus_id);
+}
+
+module_init(w1_mikrobusid_init);
+module_exit(w1_mikrobusid_exit);
+
+MODULE_AUTHOR("Vaishnav M A <vaishnav@beagleboard.org>");
+MODULE_DESCRIPTION("w1 family CC driver for mikroBUS ID EEPROM");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("w1-family-" __stringify(W1_EEPROM_MIKROBUS_ID));
diff --git a/drivers/misc/mikrobus/mikrobus_manifest.c b/drivers/misc/mikrobus/mikrobus_manifest.c
new file mode 100644
index 000000000000..3121a1d01b8b
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_manifest.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mikroBUS manifest parsing, an
+ * extension to Greybus Manifest Parsing
+ * under drivers/greybus/manifest.c
+ *
+ * Copyright 2014-2015 Google Inc.
+ * Copyright 2014-2015 Linaro Ltd.
+ */
+
+#define pr_fmt(fmt) "mikrobus_manifest:%s: " fmt, __func__
+
+#include <linux/bits.h>
+#include <linux/types.h>
+#include <linux/property.h>
+#include <linux/greybus/greybus_manifest.h>
+
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
+	list_for_each_entry_safe(descriptor, next, &board->manifest_descs, links) {
+		list_del(&descriptor->links);
+		kfree(descriptor);
+	}
+}
+
+static int board_descriptor_add(struct addon_board_info *board, struct greybus_descriptor *desc,
+				size_t size)
+{
+	struct greybus_descriptor_header *desc_header = &desc->header;
+	struct manifest_desc *descriptor;
+	size_t desc_size, expected_size;
+
+	if (size < sizeof(*desc_header)) {
+		pr_err("short descriptor (%zu < %zu)", size, sizeof(*desc_header));
+		return -EINVAL;
+	}
+
+	desc_size = le16_to_cpu(desc_header->size);
+	if (desc_size > size) {
+		pr_err("incorrect descriptor size (%zu != %zu)", size, desc_size);
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
+	string = kmemdup(&desc_string->string, desc_string->length + 1, GFP_KERNEL);
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
+static struct property_entry *mikrobus_property_entry_get(struct addon_board_info *board,
+							  u8 *prop_link, int num_properties)
+{
+	struct greybus_descriptor_property *desc_property;
+	struct manifest_desc *descriptor;
+	struct property_entry *properties;
+	bool found = false;
+	char *prop_name;
+	int i, retval;
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
+			retval = -ENOENT;
+			goto early_exit;
+		}
+
+		prop_name = mikrobus_string_get(board, desc_property->propname_stringid);
+		if (!prop_name) {
+			retval = -ENOENT;
+			goto early_exit;
+		}
+
+		switch (desc_property->type) {
+		case MIKROBUS_PROPERTY_TYPE_U8:
+			val_u8 = kmemdup(&desc_property->value,
+					 (desc_property->length) * sizeof(u8), GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] = PROPERTY_ENTRY_U8(prop_name, *val_u8);
+			else
+				properties[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(
+					prop_name, (void *)desc_property->value,
+					desc_property->length);
+			break;
+		case MIKROBUS_PROPERTY_TYPE_U16:
+			val_u16 = kmemdup(&desc_property->value,
+					  (desc_property->length) * sizeof(u16), GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] = PROPERTY_ENTRY_U16(prop_name, *val_u16);
+			else
+				properties[i] = PROPERTY_ENTRY_U16_ARRAY_LEN(
+					prop_name, (void *)desc_property->value,
+					desc_property->length);
+			break;
+		case MIKROBUS_PROPERTY_TYPE_U32:
+			val_u32 = kmemdup(&desc_property->value,
+					  (desc_property->length) * sizeof(u32), GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] = PROPERTY_ENTRY_U32(prop_name, *val_u32);
+			else
+				properties[i] = PROPERTY_ENTRY_U32_ARRAY_LEN(
+					prop_name, (void *)desc_property->value,
+					desc_property->length);
+			break;
+		case MIKROBUS_PROPERTY_TYPE_U64:
+			val_u64 = kmemdup(&desc_property->value,
+					  (desc_property->length) * sizeof(u64), GFP_KERNEL);
+			if (desc_property->length == 1)
+				properties[i] = PROPERTY_ENTRY_U64(prop_name, *val_u64);
+			else
+				properties[i] = PROPERTY_ENTRY_U64_ARRAY_LEN(
+					prop_name, (void *)desc_property->value,
+					desc_property->length);
+			break;
+		default:
+			retval = -EINVAL;
+			goto early_exit;
+		}
+	}
+	return properties;
+
+early_exit:
+	kfree(properties);
+	return ERR_PTR(retval);
+}
+
+static u8 *mikrobus_property_link_get(struct addon_board_info *board, u8 prop_id,
+				      struct board_device_info *board_dev, u8 prop_type)
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
+		if (desc_property->id == prop_id && desc_property->type == prop_type) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return ERR_PTR(-ENOENT);
+
+	val_u8 = kmemdup(&desc_property->value, desc_property->length, GFP_KERNEL);
+	if (prop_type == MIKROBUS_PROPERTY_TYPE_GPIO)
+		board_dev->num_gpio_resources = desc_property->length;
+	else if (prop_type == MIKROBUS_PROPERTY_TYPE_PROPERTY)
+		board_dev->num_properties = desc_property->length;
+	else if (prop_type == MIKROBUS_PROPERTY_TYPE_REGULATOR)
+		board_dev->num_regulators = desc_property->length;
+	else if (prop_type == MIKROBUS_PROPERTY_TYPE_CLOCK)
+		board_dev->num_clocks = desc_property->length;
+
+	return val_u8;
+}
+
+static int mikrobus_manifest_attach_device(struct addon_board_info *board,
+					   struct greybus_descriptor_device *dev_desc)
+{
+	u8 *gpio_desc_link, *prop_link, *gpioval, *reg_link, *clock_link;
+	struct greybus_descriptor_property *desc_property;
+	struct board_device_info *board_dev;
+	struct gpiod_lookup_table *lookup;
+	struct manifest_desc *descriptor;
+	int retval, i;
+
+	board_dev = kzalloc(sizeof(*board_dev), GFP_KERNEL);
+	if (!board_dev)
+		return -ENOMEM;
+
+	board_dev->id = dev_desc->id;
+	board_dev->drv_name = mikrobus_string_get(board, dev_desc->driver_stringid);
+	if (!board_dev->drv_name) {
+		retval = -ENOENT;
+		goto err_free_board_dev;
+	}
+
+	board_dev->protocol = dev_desc->protocol;
+	board_dev->reg = dev_desc->reg;
+	board_dev->irq = dev_desc->irq;
+	board_dev->irq_type = dev_desc->irq_type;
+	board_dev->max_speed_hz = le32_to_cpu(dev_desc->max_speed_hz);
+	board_dev->mode = dev_desc->mode;
+	pr_info("parsed device %d, driver=%s", board_dev->id, board_dev->drv_name);
+
+	if (dev_desc->prop_link > 0) {
+		prop_link = mikrobus_property_link_get(board, dev_desc->prop_link, board_dev,
+						       MIKROBUS_PROPERTY_TYPE_PROPERTY);
+		if (!prop_link) {
+			retval = -ENOENT;
+			goto err_free_board_dev;
+		}
+
+		pr_info("device %d, number of properties=%d", board_dev->id,
+			board_dev->num_properties);
+		board_dev->properties =
+			mikrobus_property_entry_get(board, prop_link, board_dev->num_properties);
+	}
+
+	if (dev_desc->gpio_link > 0) {
+		gpio_desc_link = mikrobus_property_link_get(board, dev_desc->gpio_link, board_dev,
+							    MIKROBUS_PROPERTY_TYPE_GPIO);
+		if (!gpio_desc_link) {
+			retval = -ENOENT;
+			goto err_free_board_dev;
+		}
+
+		pr_info("device %d, number of gpio resource=%d", board_dev->id,
+			board_dev->num_gpio_resources);
+		lookup = kzalloc(struct_size(lookup, table, board_dev->num_gpio_resources),
+				 GFP_KERNEL);
+		if (!lookup) {
+			retval = -ENOMEM;
+			goto err_free_board_dev;
+		}
+
+		for (i = 0; i < board_dev->num_gpio_resources; i++) {
+			list_for_each_entry(descriptor, &board->manifest_descs, links) {
+				if (descriptor->type != GREYBUS_TYPE_PROPERTY)
+					continue;
+
+				desc_property = descriptor->data;
+				if (desc_property->id == gpio_desc_link[i]) {
+					gpioval = desc_property->value;
+					lookup->table[i].chip_hwnum = gpioval[0];
+					lookup->table[i].flags = gpioval[1];
+					lookup->table[i].con_id = mikrobus_string_get(
+						board, desc_property->propname_stringid);
+					break;
+				}
+			}
+		}
+		board_dev->gpio_lookup = lookup;
+	}
+
+	if (dev_desc->reg_link > 0) {
+		reg_link = mikrobus_property_link_get(board, dev_desc->reg_link, board_dev,
+						      MIKROBUS_PROPERTY_TYPE_REGULATOR);
+		if (!reg_link) {
+			retval = -ENOENT;
+			goto err_free_board_dev;
+		}
+		pr_info("device %d, number of regulators=%d", board_dev->id,
+			board_dev->num_regulators);
+		board_dev->regulators =
+			mikrobus_property_entry_get(board, reg_link, board_dev->num_regulators);
+	}
+
+	if (dev_desc->clock_link > 0) {
+		clock_link = mikrobus_property_link_get(board, dev_desc->clock_link, board_dev,
+							MIKROBUS_PROPERTY_TYPE_CLOCK);
+		if (!clock_link) {
+			retval = -ENOENT;
+			goto err_free_board_dev;
+		}
+		pr_info("device %d, number of clocks=%d", board_dev->id, board_dev->num_clocks);
+		board_dev->clocks =
+			mikrobus_property_entry_get(board, clock_link, board_dev->num_clocks);
+	}
+
+	list_add_tail(&board_dev->links, &board->devices);
+	return 0;
+
+err_free_board_dev:
+	kfree(board_dev);
+	return retval;
+}
+
+static int mikrobus_manifest_parse_devices(struct addon_board_info *board)
+{
+	struct greybus_descriptor_device *desc_device;
+	struct manifest_desc *desc, *next;
+	int retval, devcount = 0;
+
+	list_for_each_entry_safe(desc, next, &board->manifest_descs, links) {
+		if (desc->type != GREYBUS_TYPE_DEVICE)
+			continue;
+
+		desc_device = desc->data;
+		retval = mikrobus_manifest_attach_device(board, desc_device);
+		devcount++;
+	}
+
+	return devcount;
+}
+
+int mikrobus_manifest_parse(struct addon_board_info *board, void *data, size_t size)
+{
+	struct greybus_manifest_header *header;
+	struct greybus_manifest *manifest;
+	struct greybus_descriptor *desc;
+	int dev_count, desc_size;
+	u16 manifest_size;
+
+	if (size < sizeof(*header)) {
+		pr_err("short manifest (%zu < %zu)", size, sizeof(*header));
+		return -EINVAL;
+	}
+
+	manifest = data;
+	header = &manifest->header;
+	manifest_size = le16_to_cpu(header->size);
+
+	if (manifest_size != size) {
+		pr_err("invalid manifest size(%zu < %u)", size, manifest_size);
+		return -EINVAL;
+	}
+
+	if (header->version_major > MIKROBUS_VERSION_MAJOR) {
+		pr_err("manifest version too new (%u.%u > %u.%u)", header->version_major,
+		       header->version_minor, MIKROBUS_VERSION_MAJOR, MIKROBUS_VERSION_MINOR);
+		return -EINVAL;
+	}
+
+	desc = manifest->descriptors;
+	size -= sizeof(*header);
+	while (size) {
+		desc_size = board_descriptor_add(board, desc, size);
+		if (desc_size < 0) {
+			pr_err("invalid manifest descriptor, size: %u", desc_size);
+			return -EINVAL;
+		}
+
+		desc = (void *)desc + desc_size;
+		size -= desc_size;
+	}
+
+	mikrobus_state_get(board);
+	dev_count = mikrobus_manifest_parse_devices(board);
+	pr_info(" %s manifest parsed with %d devices", board->name, dev_count);
+	manifest_descriptor_release_all(board);
+
+	return true;
+}
+
+size_t mikrobus_manifest_header_validate(void *data, size_t size)
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
+		pr_err("manifest version too new (%u.%u > %u.%u)", header->version_major,
+		       header->version_minor, MIKROBUS_VERSION_MAJOR, MIKROBUS_VERSION_MINOR);
+		return -EINVAL;
+	}
+
+	return manifest_size;
+}
diff --git a/drivers/misc/mikrobus/mikrobus_manifest.h b/drivers/misc/mikrobus/mikrobus_manifest.h
new file mode 100644
index 000000000000..36b64b2093f5
--- /dev/null
+++ b/drivers/misc/mikrobus/mikrobus_manifest.h
@@ -0,0 +1,20 @@
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
+int mikrobus_manifest_parse(struct addon_board_info *info, void *data, size_t size);
+size_t mikrobus_manifest_header_validate(void *data, size_t size);
+
+#endif /* __MIKROBUS_MANIFEST_H */
-- 
2.44.0


