Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA182786D76
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbjHXLKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbjHXLKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:10:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FCF10F3;
        Thu, 24 Aug 2023 04:10:27 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50091b91a83so3628140e87.3;
        Thu, 24 Aug 2023 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692875426; x=1693480226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s42+DFrevokm9VL5slrY4KpYoHMGEtCKcBKMFJcHsF8=;
        b=bZ69Q1bTEFb9HG2ao6kvUwcWSiGT3jimWQ1pHvND7XELw7738tgozh7MrHACAtXGBW
         mw7DUrO44jisP9b5grh4KH78aP8Nf4f97sQhbQmMW9yI9SyzF4kxAoAk/mVfrkrdYLrJ
         jMcAj8fqUtWji4EtGiAf7jh/JwOhbUy86oxV7JmSEmMuFGFbS6xOTUFfTAfxPTw+EX7k
         p3h5YzneDVEt05Wjor+sJ0oGj+hdgz5EbYHQHdmYcXwcVcF/8UgjHClCymdMje7y0S84
         0H40rEXv6dpKpiNc9ICMlGVC2dOCkwtTaXjcd3tjrZFL/OdYmGlyp8ZRjWZgdP2VnYoG
         9oSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692875426; x=1693480226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s42+DFrevokm9VL5slrY4KpYoHMGEtCKcBKMFJcHsF8=;
        b=WApW2HDK7NACf5L+2P0TH9AInyKtBot+SdqtPJm7e2lMgIgQ1mVE0weOit51PJSvZA
         ns2jeZjWbXy9kaQqw0xVL47VtvKFq/jDaLk4Loy1y36HbyWoHNOXF90o5C0FvHKuDb8U
         mTIwAi0ysKNYBk0Hnj0VeSGLNv/w8hJoGlmut+ENItWT5pbxncn5MgMDucmcLu18r4vP
         RQDPaDJ1AD3v9twMEZaLrlbfmmZA1BkMjgj0+6YHI6qio2ff/zelyzssYAQ99fuMxoPn
         C4tAo9dOxJNJgwPs9KD4LtiBp50O5TLhgp2AZN7ZPlStomkVZKIc59tr867d/4MqFkyE
         tOqA==
X-Gm-Message-State: AOJu0YybjNJA440HfIZSpavBCk2kSixOkLHaUzYLvCcTrP/bja39nIGC
        uLzVZSkM8vjyZyZUS/8ciTxIE/KB844L6w==
X-Google-Smtp-Source: AGHT+IGAcoU3owbnj3ogWUVD22tLIval59j2f0nMSWMw+kFV2pGZTOmGDL+9nB6MRtAIGqYquZs7oA==
X-Received: by 2002:a05:6512:2524:b0:4fe:5a4b:911d with SMTP id be36-20020a056512252400b004fe5a4b911dmr11383178lfb.64.1692875425546;
        Thu, 24 Aug 2023 04:10:25 -0700 (PDT)
Received: from fedora.dev.tbscz ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id l8-20020a056402028800b005232e637c24sm972876edv.84.2023.08.24.04.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:10:24 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, quic_jhugo@quicinc.com,
        nipun.gupta@amd.com, tzimmermann@suse.de, ogabbay@kernel.org,
        mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv5 2/4] wiegand: add Wiegand bus driver
Date:   Thu, 24 Aug 2023 13:10:13 +0200
Message-Id: <20230824111015.57765-3-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230824111015.57765-1-m.zatovic1@gmail.com>
References: <20230824111015.57765-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wiegand protocol serves as a standardized interface protocol, extensively
employed within electronic access control systems, to facilitate data exchange
between credentials, readers, and door controllers. Its inception can be
attributed to the widespread adoption of Wiegand card readers, leveraging the
Wiegand effect - a physical phenomenon wherein a Wiegand wire (or card)
generates small yet distinct magnetic fields. A Wiegand reader detects the
magnetic pulses emitted by the internal wires of the card.

Three wires are central to the Wiegand protocol: a common ground wire and two
distinct data wires designated as DATA0 and DATA1. During periods of inactivity,
both DATA0 and DATA1 lines remain pulled up. For transmitting a '0,' the DATA0
line is pulled down while DATA1 remains pulled up; conversely, transmitting
a '1' causes DATA1 to be pulled down while DATA0 remains pulled up. Notably,
this protocol ensures that the two lines never simultaneously experience a low
state.

Timing characteristics within the Wiegand protocol lack a uniform
standardization, introducing variability between devices. Generally, pulse
durations hover between 50 to 100 microseconds, while inter-pulse gaps span 20
to 100 milliseconds. There is no stop bit or similar delimiter to signal the
conclusion of a message. Instead, the receiver either counts the bits within the
message or enforces a timeout, often set at around ten times the inter-pulse gap
duration.

The 26-Bit Wiegand Interface Standard, or 26-Bit Wiegand Format outlines the
message format most commonly used among Wiegand devices. This format allocates
the initial and terminal bits for parity. The subsequent eight bits following
the initial parity bit are reserved for the Facility Code designed for distinct
location identification. The remaining bits house the unique ID number. As the
technology evolved, new Wiegand formats emerged, including 36-bit and 37-bit
formats. It was also common practice for manufacturers to engineer devices
compatible with proprietary Wiegand formats tailored to their specifications.

The Wiegand bus driver handles Wiegand controller and Wiegand device
managemement and driver matching. The bus driver defines the structures for
Wiegand controllers and Wiegand devices. Wiegand controller structure contains
all attributes that define the communication such as the payload_len for
configuring the size of a single Wiegand message in bits, thus choosing a
format. Each Wiegand controller should be associated with one Wiegand device,
as Wiegand is typically a point-to-point bus.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 MAINTAINERS               |   2 +
 drivers/Kconfig           |   2 +
 drivers/Makefile          |   1 +
 drivers/wiegand/Kconfig   |  25 ++
 drivers/wiegand/Makefile  |   1 +
 drivers/wiegand/wiegand.c | 590 ++++++++++++++++++++++++++++++++++++++
 include/linux/wiegand.h   | 148 ++++++++++
 7 files changed, 769 insertions(+)
 create mode 100644 drivers/wiegand/Kconfig
 create mode 100644 drivers/wiegand/Makefile
 create mode 100644 drivers/wiegand/wiegand.c
 create mode 100644 include/linux/wiegand.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 75462d3746ca..0afcc88a38d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22926,6 +22926,8 @@ WIEGAND BUS DRIVER
 M:	Martin Zaťovič <m.zatovic1@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
+F:	drivers/wiegand/wiegand.c
+F:	include/linux/wiegand.h
 
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 514ae6b24cb2..6609dfd6635f 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -145,6 +145,8 @@ source "drivers/vdpa/Kconfig"
 
 source "drivers/vhost/Kconfig"
 
+source "drivers/wiegand/Kconfig"
+
 source "drivers/hv/Kconfig"
 
 source "drivers/xen/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 7241d80a7b29..898ec50cfcc4 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_VHOST_RING)	+= vhost/
 obj-$(CONFIG_VHOST_IOTLB)	+= vhost/
 obj-$(CONFIG_VHOST)		+= vhost/
 obj-$(CONFIG_VLYNQ)		+= vlynq/
+obj-$(CONFIG_WIEGAND)		+= wiegand/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_COMEDI)		+= comedi/
 obj-$(CONFIG_STAGING)		+= staging/
diff --git a/drivers/wiegand/Kconfig b/drivers/wiegand/Kconfig
new file mode 100644
index 000000000000..09ac10217ede
--- /dev/null
+++ b/drivers/wiegand/Kconfig
@@ -0,0 +1,25 @@
+config WIEGAND
+	tristate "Wiegand Bus driver"
+	help
+	  The "Wiegand Interface" stands as an asynchronous low-lever protocol
+	  or a wiring standard. Its primary application is within point-to-point
+	  communication scenarios, especially between a credential and a reader
+	  as well as between card reader and a door controller. Wiegand's data
+	  throughput tends to be modest relatively to other protocols and it
+	  depends upon the selected pulse duration and intervals between pulses.
+
+	  Despite its relatively advanced age, Wiegand remains extensively
+	  employed in access control systems, particularly for linking card
+	  swipe mechanisms. These mechanisms harness the Wiegand effect as a
+	  means of transferring data from a card to a reader.
+
+	  Wiegand uses two wires to transmit the data - DATA0 and DATA1. Both
+	  lines are initially pulled up. When a bit of value 0 is being
+	  transmitted, the DATA0 line is pulled down. Similarly, when a bit of
+	  value 1 is being transmitted, the DATA1 line is pulled down.
+
+	  If you want Wiegand support, you should say Y here and also to the
+	  specific controller driver(s) below.
+
+	  This Wiegand support can also be built as a module. If so, the module
+	  will be called wiegand.
diff --git a/drivers/wiegand/Makefile b/drivers/wiegand/Makefile
new file mode 100644
index 000000000000..d17ecb722c6e
--- /dev/null
+++ b/drivers/wiegand/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_WIEGAND)			+= wiegand.o
diff --git a/drivers/wiegand/wiegand.c b/drivers/wiegand/wiegand.c
new file mode 100644
index 000000000000..7cdffdd47ea3
--- /dev/null
+++ b/drivers/wiegand/wiegand.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitops.h>
+#include <linux/cdev.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/wiegand.h>
+
+#define WIEGAND_DEFAULT_PULSE_LEN 50
+#define WIEGAND_DEFAULT_INTERVAL_LEN 2000
+#define WIEGAND_DEFAULT_FRAME_GAP 2000
+
+struct bus_type wiegand_bus_type;
+
+/**
+ * struct wiegand_device - Wiegand listener device
+ *
+ * @dev: drivers structure of the device
+ * @id: unique device id
+ * @controller: Wiegand controller associated with the device
+ * @modalias: Name of the driver to use with this device, or its alias.
+ */
+struct wiegand_device {
+	struct device dev;
+	u8 id;
+	struct wiegand_controller *controller;
+	char modalias[WIEGAND_NAME_SIZE];
+};
+
+static DEFINE_IDA(wiegand_controller_ida);
+
+static ssize_t wiegand_get_user_data(struct wiegand_controller *ctlr, char __user const *buf,
+					  size_t len)
+{
+	int ret;
+
+	ret = bitmap_parse_user(buf, len, ctlr->data_bitmap, WIEGAND_MAX_PAYLEN_BYTES * 8);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int wiegand_frelease(struct inode *ino, struct file *filp)
+{
+	struct wiegand_controller *ctlr = filp->private_data;
+
+	mutex_destroy(&ctlr->file_lock);
+	return 0;
+}
+
+static ssize_t wiegand_fwrite(struct file *filp, char __user const *buf, size_t len,
+				loff_t *offset)
+{
+	int ret;
+	struct wiegand_controller *ctlr = filp->private_data;
+
+	mutex_lock(&ctlr->file_lock);
+
+	if (!buf || len == 0)
+		return -EINVAL;
+
+	ret = wiegand_get_user_data(ctlr, buf, len);
+	if (ret < 0)
+		return ret;
+
+	ctlr->transfer_message(ctlr);
+
+	mutex_unlock(&ctlr->file_lock);
+	return len;
+}
+
+static int wiegand_fopen(struct inode *ino, struct file *filp)
+{
+	int ret;
+	struct wiegand_controller *ctlr = container_of(filp->f_op, struct wiegand_controller, fops);
+
+	filp->private_data = ctlr;
+
+	mutex_lock(&ctlr->file_lock);
+
+	if ((filp->f_flags & O_ACCMODE) == O_RDONLY || (filp->f_flags & O_ACCMODE) == O_RDWR) {
+		dev_err(ctlr->miscdev.this_device, "device is write only\n");
+		ret = -EIO;
+		goto out_unlock;
+	}
+
+	mutex_unlock(&ctlr->file_lock);
+	return 0;
+
+out_unlock:
+	mutex_unlock(&ctlr->file_lock);
+	return ret;
+}
+
+static inline struct wiegand_device *to_wiegand_device(struct device *dev)
+{
+	return dev ? container_of(dev, struct wiegand_device, dev) : NULL;
+}
+
+static void wiegand_cleanup(struct wiegand_device *wiegand)
+{
+	if (wiegand->controller->cleanup)
+		wiegand->controller->cleanup(wiegand);
+}
+
+/**
+ * wiegand_controller_release - called after the final refererence decrement
+ *
+ * @dev: the controller device
+ */
+static void wiegand_controller_release(struct device *dev)
+{
+	struct wiegand_controller *ctlr;
+
+	ctlr = container_of(dev, struct wiegand_controller, dev);
+	kfree(ctlr);
+}
+
+/**
+ * wiegand_alloc_controller - allocate a new Wiegand controller
+ *
+ * @dev: the controller device
+ * @size: size of the private data to be allocated for the caller
+ * @secondary: true if the controller is a secondary controller(reads data)
+ *
+ * This function is only by Wiegand controller drivers to allocate a new Wiegand controller
+ * structure before registering it using wiegand_register_controller().
+ */
+struct wiegand_controller *wiegand_alloc_controller(struct device *dev, size_t size,
+							bool secondary)
+{
+	struct wiegand_controller *ctlr;
+	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());
+	size_t total_size;
+
+	if (check_add_overflow(size, ctlr_size, &total_size))
+		return NULL;
+
+	ctlr = kzalloc(total_size, GFP_KERNEL);
+	if (!ctlr)
+		return NULL;
+
+	device_initialize(&ctlr->dev);
+
+	ctlr->bus_num = -1;
+	ctlr->secondary = secondary;
+	ctlr->dev.parent = dev;
+	ctlr->dev.release = wiegand_controller_release;
+
+	wiegand_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
+
+	return ctlr;
+}
+EXPORT_SYMBOL_NS_GPL(wiegand_alloc_controller, WIEGAND);
+
+/**
+ * devm_wiegand_alloc_controller - device managed allocation of a new Wiegand controller
+ * @dev: physical device of Wiegand controller
+ * @size: size of the private data to be allocated for the caller
+ * @secondary: true if the controller is a secondary controller(reads data)
+ *
+ * Device managed version of wiegand_alloc_controller(). The Wiegand controller is automatically
+ * freed on driver detach.
+ */
+struct wiegand_controller *devm_wiegand_alloc_controller(struct device *dev, unsigned int size,
+							bool secondary)
+{
+	struct wiegand_controller *ctlr;
+
+	ctlr = wiegand_alloc_controller(dev, size, secondary);
+	if (ctlr)
+		ctlr->devm_allocated = true;
+	else
+		return NULL;
+
+	if (devm_add_action_or_reset(dev, wiegand_controller_put, ctlr))
+		return NULL;
+
+	return ctlr;
+}
+EXPORT_SYMBOL_NS_GPL(devm_wiegand_alloc_controller, WIEGAND);
+
+static int wiegand_controller_check_ops(struct wiegand_controller *ctlr)
+{
+	if (!ctlr->transfer_message)
+		return -EINVAL;
+	return 0;
+}
+
+/**
+ * register_wiegand_device - allocates and registers a new Wiegand device
+ *
+ * @ctlr: controller structure to attach device to
+ * @node: firmware node for the device
+ */
+static struct wiegand_device *register_wiegand_device(struct wiegand_controller *ctlr,
+							struct fwnode_handle *node)
+{
+	struct wiegand_device *wiegand;
+	int ret;
+
+	wiegand = wiegand_alloc_device(ctlr);
+	if (!wiegand)
+		return NULL;
+
+	fwnode_handle_get(node);
+	device_set_node(&wiegand->dev, node);
+
+	ret = wiegand_add_device(wiegand);
+	if (ret) {
+		dev_err(&ctlr->dev, "wiegand_device register error %pfwf\n", node);
+		goto out_node_put;
+	}
+
+	/* check if more devices are connected to the bus */
+	if (ctlr->device_count > 1)
+		dev_warn(&ctlr->dev, "Wiegand is a point-to-point bus, it is advised to only connect one device per Wiegand bus. The devices may not communicate using the same pulse length, format or else.\n");
+
+	return wiegand;
+
+out_node_put:
+	fwnode_handle_put(node);
+	put_device(&wiegand->dev);
+	wiegand_cleanup(wiegand);
+	return ERR_PTR(ret);
+}
+
+static void register_wiegand_devices(struct wiegand_controller *ctlr)
+{
+	struct wiegand_device *wiegand;
+	struct fwnode_handle *node;
+
+	fwnode_for_each_available_child_node(ctlr->dev.fwnode, node) {
+		wiegand = register_wiegand_device(ctlr, node);
+		if (IS_ERR(wiegand))
+			dev_warn(&ctlr->dev, "failed to create wiegand device for %pfwf\n", node);
+	}
+}
+
+/**
+ * wiegand_controller_get_timings - gets timings using a firmware node
+ *
+ * @ctlr: pointer to a wiegand_controller structure
+ *
+ * Tries to get timing data from a firmware node, if they are not defined, then default values are
+ * set.
+ */
+static void wiegand_controller_get_timings(struct wiegand_controller *ctlr)
+{
+	int ret;
+	u32 pulse_len, interval_len, frame_gap;
+	struct wiegand_timing *timing = &ctlr->timing;
+	struct device *ctlr_dev = &ctlr->dev;
+
+	ret = device_property_read_u32(ctlr_dev, "pulse-len-us", &pulse_len);
+	if (!ret && pulse_len > 0)
+		timing->pulse_len = pulse_len;
+	else
+		timing->pulse_len = WIEGAND_DEFAULT_PULSE_LEN;
+
+	ret = device_property_read_u32(ctlr_dev, "interval-len-us", &interval_len);
+	if (!ret && interval_len > 0)
+		timing->interval_len = interval_len;
+	else
+		timing->interval_len = WIEGAND_DEFAULT_INTERVAL_LEN;
+
+	ret = device_property_read_u32(ctlr_dev, "frame-gap-us", &frame_gap);
+	if (!ret && frame_gap > 0)
+		timing->frame_gap = frame_gap;
+	else
+		timing->frame_gap = WIEGAND_DEFAULT_FRAME_GAP;
+}
+
+static int __unregister(struct device *dev, void *null)
+{
+	wiegand_unregister_device(to_wiegand_device(dev));
+	return 0;
+}
+
+/**
+ * wiegand_unregister_controller - unregisters controller structure within Wiegand bus
+ *
+ * @ptr: pointer to a wiegand_controller structure
+ *
+ * Frees all resources allocated by the wiegand_register_controller() function.
+ * If the controller was registered using devm_wiegand_alloc_controller() then
+ * this function is called automatically on driver detach.Otherwise the function needs
+ * to be called manually. If controller is not devm managed, then the reference to the
+ * controller structure is put.
+ */
+void wiegand_unregister_controller(void *ptr)
+{
+	struct wiegand_controller *ctlr = ptr;
+	unsigned int id = ctlr->bus_num;
+
+	device_for_each_child(&ctlr->dev, NULL, __unregister);
+	ida_free(&wiegand_controller_ida, id);
+	device_del(&ctlr->dev);
+
+	kfree(ctlr->miscdev.name);
+	misc_deregister(&ctlr->miscdev);
+
+	if (!ctlr->devm_allocated)
+		put_device(&ctlr->dev);
+}
+EXPORT_SYMBOL_NS_GPL(wiegand_unregister_controller, WIEGAND);
+
+/**
+ * wiegand_register_controller - registers controller structure within bus
+ * @ctlr: controller structure to register
+ *
+ * Function checks that the message transfer functions is defined for passed controller structure,
+ * gets its attributes and finally adds the controller device and registers the controller on the
+ * bus.
+ */
+int wiegand_register_controller(struct wiegand_controller *ctlr)
+{
+	int status, id;
+
+	status = wiegand_controller_check_ops(ctlr);
+	if (status)
+		return status;
+
+	id = ida_alloc(&wiegand_controller_ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+	ctlr->bus_num = id;
+
+	wiegand_controller_get_timings(ctlr);
+
+	status = dev_set_name(&ctlr->dev, "wiegand%u", ctlr->bus_num);
+	if (status < 0)
+		goto out_free_ida;
+
+	ctlr->miscdev.name = kasprintf(GFP_KERNEL, "wiegand1");
+	if (!ctlr->miscdev.name) {
+		status = -ENOMEM;
+		goto out_free_ida;
+	}
+
+	ctlr->fops.owner = THIS_MODULE;
+	ctlr->fops.open = wiegand_fopen;
+	ctlr->fops.release = wiegand_frelease;
+	ctlr->fops.write = wiegand_fwrite;
+	ctlr->miscdev.fops = &ctlr->fops;
+	ctlr->miscdev.minor = MISC_DYNAMIC_MINOR;
+
+	status = misc_register(&ctlr->miscdev);
+	if (status) {
+		dev_err(&ctlr->dev, "couldn't register misc device\n");
+		goto out_free_ida_name;
+	}
+
+	mutex_init(&ctlr->file_lock);
+
+	status = device_add(&ctlr->dev);
+	if (status < 0)
+		goto out_free_ida_name_misc;
+
+	ctlr->device_count = 0;
+	ctlr->miscdev.parent = &ctlr->dev;
+	register_wiegand_devices(ctlr);
+
+	return status;
+
+out_free_ida_name_misc:
+	misc_deregister(&ctlr->miscdev);
+
+out_free_ida_name:
+	kfree(ctlr->miscdev.name);
+
+out_free_ida:
+	ida_free(&wiegand_controller_ida, ctlr->bus_num);
+	return status;
+}
+EXPORT_SYMBOL_NS_GPL(wiegand_register_controller, WIEGAND);
+
+int devm_wiegand_register_controller(struct device *dev, struct wiegand_controller *ctlr)
+{
+	int ret;
+
+	ret = wiegand_register_controller(ctlr);
+	if (ret < 0)
+		return ret;
+
+	return devm_add_action_or_reset(dev, wiegand_unregister_controller, ctlr);
+}
+EXPORT_SYMBOL_NS_GPL(devm_wiegand_register_controller, WIEGAND);
+
+struct wiegand_controller *wiegand_device_get_controller(struct wiegand_device *dev)
+{
+	return dev->controller;
+}
+EXPORT_SYMBOL_NS_GPL(wiegand_device_get_controller, WIEGAND);
+
+/**
+ * wiegand_dev_release - called after the final reference count decrement
+ * @dev: device to release
+ */
+static void wiegand_dev_release(struct device *dev)
+{
+	struct wiegand_device *wiegand = to_wiegand_device(dev);
+
+	wiegand_controller_put(wiegand->controller);
+	kfree(wiegand);
+}
+
+struct wiegand_device *wiegand_alloc_device(struct wiegand_controller *ctlr)
+{
+	struct wiegand_device *wiegand;
+
+	wiegand = kzalloc(sizeof(*wiegand), GFP_KERNEL);
+	if (!wiegand) {
+		wiegand_controller_put(ctlr);
+		return NULL;
+	}
+
+	wiegand->controller = ctlr;
+	wiegand->dev.parent = &ctlr->dev;
+	wiegand->dev.bus = &wiegand_bus_type;
+	wiegand->dev.release = wiegand_dev_release;
+
+	device_initialize(&wiegand->dev);
+	return wiegand;
+}
+EXPORT_SYMBOL_NS_GPL(wiegand_alloc_device, WIEGAND);
+
+static int wiegand_dev_set_name(struct wiegand_device *wiegand, u8 id)
+{
+	return dev_set_name(&wiegand->dev, "%s.%u", dev_name(&wiegand->controller->dev), id);
+}
+
+static int __wiegand_add_device(struct wiegand_device *wiegand)
+{
+	struct wiegand_controller *ctlr = wiegand->controller;
+	struct device *dev = ctlr->dev.parent;
+	int status;
+
+	status = wiegand_setup(wiegand);
+	if (status < 0) {
+		dev_err(dev, "can't setup %s, status %d\n",
+			dev_name(&wiegand->dev), status);
+		return status;
+	}
+
+	status = device_add(&wiegand->dev);
+	if (status < 0) {
+		dev_err(dev, "can't add %s, status %d\n", dev_name(&wiegand->dev), status);
+		wiegand_cleanup(wiegand);
+	} else {
+		dev_dbg(dev, "registered child %s\n", dev_name(&wiegand->dev));
+	}
+
+	return status;
+}
+
+int wiegand_add_device(struct wiegand_device *wiegand)
+{
+	struct wiegand_controller *ctlr = wiegand->controller;
+	int status;
+
+	status = wiegand_dev_set_name(wiegand, ctlr->device_count);
+	if (status)
+		return status;
+
+	status = __wiegand_add_device(wiegand);
+	if (!status) {
+		ctlr->device_count++;
+		wiegand->id = wiegand->controller->device_count;
+	}
+
+	return status;
+}
+
+int wiegand_setup(struct wiegand_device *wiegand)
+{
+	int status;
+	struct device *ctlr_dev = &wiegand->controller->dev;
+	struct wiegand_controller *ctlr = wiegand->controller;
+
+	if (ctlr->setup) {
+		status = ctlr->setup(wiegand);
+		if (status) {
+			dev_err(ctlr_dev, "failed to setup device: %d\n", status);
+			return status;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(wiegand_setup, WIEGAND);
+
+void wiegand_unregister_device(struct wiegand_device *wiegand)
+{
+	if (!wiegand)
+		return;
+
+	fwnode_handle_put(wiegand->dev.fwnode);
+	device_del(&wiegand->dev);
+	wiegand_cleanup(wiegand);
+	put_device(&wiegand->dev);
+}
+EXPORT_SYMBOL_NS_GPL(wiegand_unregister_device, WIEGAND);
+
+int wiegand_send_message(struct wiegand_device *wiegand, unsigned long *msg_bmp, u8 bitlen)
+{
+	struct wiegand_primary *primary = wiegand->controller;
+
+	if (msg_bmp == NULL)
+		return -EINVAL;
+
+	if (primary->transfer_message)
+		primary->transfer_message(primary);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(wiegand_send_message, WIEGAND);
+
+static int wiegand_match_device(struct device *dev, struct device_driver *drv)
+{
+	struct wiegand_device *wiegand_dev = to_wiegand_device(dev);
+
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	return strcmp(wiegand_dev->modalias, drv->name) == 0;
+}
+
+static int wiegand_probe(struct device *dev)
+{
+	struct wiegand_device *wiegand = to_wiegand_device(dev);
+	const struct wiegand_driver *wdrv = to_wiegand_driver(dev->driver);
+
+	return wdrv->probe(wiegand);
+}
+
+static void wiegand_remove(struct device *dev)
+{
+	const struct wiegand_driver *wdrv = to_wiegand_driver(dev->driver);
+
+	if (wdrv->remove)
+		wdrv->remove(to_wiegand_device(dev));
+}
+
+struct bus_type wiegand_bus_type = {
+	.name		= "wiegand",
+	.match		= wiegand_match_device,
+	.probe		= wiegand_probe,
+	.remove		= wiegand_remove,
+};
+EXPORT_SYMBOL_NS_GPL(wiegand_bus_type, WIEGAND);
+
+int __wiegand_register_driver(struct module *owner, struct wiegand_driver *wdrv)
+{
+	wdrv->driver.owner = owner;
+	wdrv->driver.bus = &wiegand_bus_type;
+
+	return driver_register(&wdrv->driver);
+}
+EXPORT_SYMBOL_NS_GPL(__wiegand_register_driver, WIEGAND);
+
+static int __init wiegand_init(void)
+{
+	int ret;
+
+	ret = bus_register(&wiegand_bus_type);
+	if (ret < 0)
+		pr_err("Wiegand bus registration failed: %d\n", ret);
+
+	return ret;
+}
+postcore_initcall_sync(wiegand_init);
+
+static void __exit wiegand_exit(void)
+{
+	ida_destroy(&wiegand_controller_ida);
+	bus_unregister(&wiegand_bus_type);
+}
+module_exit(wiegand_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand bus driver");
+MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
diff --git a/include/linux/wiegand.h b/include/linux/wiegand.h
new file mode 100644
index 000000000000..52d49f4efdd4
--- /dev/null
+++ b/include/linux/wiegand.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef H_LINUX_INCLUDE_LINUX_WIEGAND_H
+#define H_LINUX_INCLUDE_LINUX_WIEGAND_H
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#define WIEGAND_NAME_SIZE 32
+#define WIEGAND_MAX_PAYLEN_BYTES 256
+
+extern struct bus_type wiegand_type;
+
+struct wiegand_device;
+/**
+ * struct wiegand_timing - Wiegand timings in microseconds
+ * @pulse_len: length of the low pulse
+ * @interval_len: length of a whole bit (both the pulse and the high phase)
+ * @frame_gap: length of the last bit of a frame (both the pulse and the high phase)
+ */
+struct wiegand_timing {
+	u32 pulse_len;
+	u32 interval_len;
+	u32 frame_gap;
+};
+
+/**
+ * struct wiegand_controller - Wiegand primary or secondary interface
+ * @dev: Device interface of the controller
+ * @miscdev: Misc device associated with controller
+ * @fops: File operations
+ * @file_lock: File mutex
+ * @bus_num: Board-specific identifier for Wiegand controller
+ * @secondary: Whether the controller is a secondary(receives data)
+ * @devm_allocated: Whether the allocation of this struct is devres-managed
+ * @timing: Stores timing parameters for Wiegand communication
+ * @payload_len: Number of bits in a Wiegand message
+ * @device_count: Counter of devices connected to the same Wiegand bus(controller)
+ * @data_bitmap: Data buffer
+ * @transfer_message: Send a message on the bus
+ * @setup: Setup a device
+ * @cleanup: Cleanup after a device
+ */
+struct wiegand_controller {
+	struct device dev;
+	struct miscdevice miscdev;
+
+	struct file_operations fops;
+	struct mutex file_lock;
+
+	unsigned int bus_num;
+
+	bool secondary;
+	bool devm_allocated;
+
+	struct wiegand_timing timing;
+	u32 payload_len;
+
+	u8 device_count;
+
+	DECLARE_BITMAP(data_bitmap, WIEGAND_MAX_PAYLEN_BYTES * 8);
+
+	int (*transfer_message)(struct wiegand_controller *ctlr);
+	int (*setup)(struct wiegand_device *wiegand);
+	void (*cleanup)(struct wiegand_device *wiegand);
+};
+
+struct wiegand_driver {
+	struct device_driver driver;
+	const struct wiegand_device_id *id_table;
+	int (*probe)(struct wiegand_device *wiegand);
+	void (*remove)(struct wiegand_device *wiegand);
+};
+
+#define wiegand_primary wiegand_controller
+struct wiegand_controller *wiegand_alloc_controller(struct device *host, size_t size,
+							bool secondary);
+
+struct wiegand_controller *devm_wiegand_alloc_controller(struct device *dev,
+								unsigned int size, bool secondary);
+static inline struct wiegand_controller *devm_wiegand_alloc_primary(struct device *dev,
+								unsigned int size)
+{
+	return devm_wiegand_alloc_controller(dev, size, false);
+}
+
+int wiegand_register_controller(struct wiegand_controller *ctlr);
+int devm_wiegand_register_controller(struct device *dev, struct wiegand_controller *ctlr);
+#define wiegand_register_primary(_ctlr) wiegand_register_controller(_ctlr)
+#define devm_wiegand_register_primary(_dev, _ctlr)devm_wiegand_register_controller(_dev, _ctlr)
+void wiegand_unregister_controller(void *ctlr);
+#define wiegand_unregister_primary(_ctlr) wiegand_unregister_controller(_ctlr)
+struct wiegand_primary *wiegand_busnum_to_primary(u16 bus_num);
+
+static inline void *wiegand_controller_get_devdata(struct wiegand_controller *ctlr)
+{
+	return dev_get_drvdata(&ctlr->dev);
+}
+
+static inline void wiegand_controller_set_devdata(struct wiegand_controller *ctlr, void *data)
+{
+	dev_set_drvdata(&ctlr->dev, data);
+}
+
+#define wiegand_primary_get_devdata(_ctlr) wiegand_controller_get_devdata(_ctlr)
+#define wiegand_primary_set_devdata(_ctlr, data) wiegand_controller_set_devdata(_ctlr, data)
+
+static inline struct wiegand_controller *wiegand_controller_get(struct wiegand_controller *ctlr)
+{
+	if (!ctlr || !get_device(&ctlr->dev))
+		return NULL;
+	return ctlr;
+}
+
+static inline void wiegand_controller_put(void *ptr)
+{
+	struct wiegand_controller *ctlr = ptr;
+
+	if (ctlr)
+		put_device(&ctlr->dev);
+}
+
+struct wiegand_device *wiegand_alloc_device(struct wiegand_controller *ctlr);
+int wiegand_add_device(struct wiegand_device *wiegand);
+int wiegand_setup(struct wiegand_device *wiegand);
+void wiegand_unregister_device(struct wiegand_device *wiegand);
+struct wiegand_controller *wiegand_device_get_controller(struct wiegand_device *dev);
+
+int wiegand_send_message(struct wiegand_device *wiegand, unsigned long *msg_bmp, u8 bitlen);
+
+int __wiegand_register_driver(struct module *owner, struct wiegand_driver *wdrv);
+#define wiegand_register_driver(driver) __wiegand_register_driver(THIS_MODULE, driver)
+
+static inline void wiegand_unregister_driver(struct wiegand_driver *wdrv)
+{
+	if (wdrv)
+		driver_unregister(&wdrv->driver);
+}
+
+static inline struct wiegand_driver *to_wiegand_driver(struct device_driver *drv)
+{
+	return drv ? container_of(drv, struct wiegand_driver, driver) : NULL;
+}
+
+#endif	/* H_LINUX_INCLUDE_LINUX_WIEGAND_H */
-- 
2.40.1

