Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7195F786D78
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbjHXLKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbjHXLKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:10:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F51A10FA;
        Thu, 24 Aug 2023 04:10:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so10474887e87.0;
        Thu, 24 Aug 2023 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692875431; x=1693480231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzTn37NhbD/APGPKPSueAFzFYve8TPijkZqKUT+Scqc=;
        b=gf8WV3zaeFI5FGp20fEVwAKmNRV4ZIV3Vd5dQpRtrctM9MGVJJpbHJ1gGEoyqmyIhK
         YPJ0r4eRQOxaTzR6vRkBebSaEQaC2EstipahIgYU5V1q78keL8mrRSo/ZVOYFh7LecwP
         5hbTfvuHOkD3aYlj5ovBds99hgMcY9mMKWoZGmUnw1/AjyvbZT1TTRHrtODHwlaknqdB
         JUvzXmr0SRzGDVNmDSgPdVkpOnNQa541bRQ8FDlEoppxa/jilJXtlCZdG8qIijG/+/rv
         5KbDwR2ep9hSfuqmQH0Cn88pJr1mVDk0loc//vggSihdstBzqUrppETH8F6qkRs2VIZi
         ClWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692875431; x=1693480231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzTn37NhbD/APGPKPSueAFzFYve8TPijkZqKUT+Scqc=;
        b=eTxn3eMes9kOMfhWO4Fs16M24dXPWjc8QXrpBIvpSDApaWynBvISFFo9cjnAm4Zgf2
         nsAz1PjA8qcPuHUQdRhWSAhF01+wlFGjeuEyVXBKHsiKuR59HgcYHuEc1aKc5booYv3t
         2AUDLea8UHvQTP1W09mTJ9T1oyEvSts1l29YHYmJ9XjoXBG6Nr8oeueb5qdpAaDcPY5g
         v2FlBkdBdhkI6CJKg297C4CiWNNiX0i2IDY9pS3VJvAvSGnYNYl3UuMAxLxiLmxQOfJy
         BQrOis357woSxlVeppVEQCaJmEcPW1AcaouF1dY7WvNnGaNtXXumVs8wFUFQ2W7hTaEY
         aW9g==
X-Gm-Message-State: AOJu0Yxgh1u3RI2G2qczKUPFc4VdyI/K/CN3usgZqpbiUzVw3gN4Uk0d
        ZqR4ALlouDCfzcsOrTibbESZ0STKPwCxjg==
X-Google-Smtp-Source: AGHT+IErmwwg+0aSYpkqgZXk+jMOBmAeeR0WHAVP8ASzCMlqgS72erkEW2vhcLVs4nU4ZXV15JSrWA==
X-Received: by 2002:a05:6512:ad3:b0:4f7:6966:36fb with SMTP id n19-20020a0565120ad300b004f7696636fbmr12263084lfu.12.1692875430726;
        Thu, 24 Aug 2023 04:10:30 -0700 (PDT)
Received: from fedora.dev.tbscz ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id l8-20020a056402028800b005232e637c24sm972876edv.84.2023.08.24.04.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:10:30 -0700 (PDT)
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
Subject: [PATCHv5 4/4] wiegand: add Wiegand GPIO bitbanged controller driver
Date:   Thu, 24 Aug 2023 13:10:15 +0200
Message-Id: <20230824111015.57765-5-m.zatovic1@gmail.com>
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

This controller formats the data to a Wiegand format and bit-bangs
the message on devicetree defined GPIO lines.

The driver creates a dev file for writing messages on the bus.
It also creates a sysfs file to control the payload length of
messages(in bits). If a message is shorter than the set payload
length, it will be discarded. On the other hand, if a message is
longer, the additional bits will be stripped off.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../ABI/testing/sysfs-driver-wiegand-gpio     |   9 +
 MAINTAINERS                                   |   2 +
 drivers/wiegand/Kconfig                       |  11 +
 drivers/wiegand/Makefile                      |   1 +
 drivers/wiegand/wiegand-gpio.c                | 192 ++++++++++++++++++
 5 files changed, 215 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 create mode 100644 drivers/wiegand/wiegand-gpio.c

diff --git a/Documentation/ABI/testing/sysfs-driver-wiegand-gpio b/Documentation/ABI/testing/sysfs-driver-wiegand-gpio
new file mode 100644
index 000000000000..6bf6c2b93bf7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-wiegand-gpio
@@ -0,0 +1,9 @@
+What:		/sys/devices/platform/.../wiegand-gpio-attributes/payload_len
+Date:		August 2023
+Contact:	Martin Zaťovič <m.zatovic1@gmail.com>
+Description:
+		Read/set the payload length of messages sent by Wiegand GPIO
+		bit-banging controller in bits. The default value is 26, as
+		that is the most widely-used message length of Wiegand messages.
+		Controller will only send messages of at least the set length
+		and it will strip off bits of longer messages.
diff --git a/MAINTAINERS b/MAINTAINERS
index fb158e74ca4b..221ffa766ed0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22932,7 +22932,9 @@ F:	include/linux/wiegand.h
 WIEGAND GPIO BITBANG DRIVER
 M:	Martin Zaťovič <m.zatovic1@gmail.com>
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 F:	Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
+F:	drivers/wiegand/wiegand-gpio.c
 
 WILOCITY WIL6210 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/wiegand/Kconfig b/drivers/wiegand/Kconfig
index 09ac10217ede..17fd367a9004 100644
--- a/drivers/wiegand/Kconfig
+++ b/drivers/wiegand/Kconfig
@@ -23,3 +23,14 @@ config WIEGAND
 
 	  This Wiegand support can also be built as a module. If so, the module
 	  will be called wiegand.
+
+config WIEGAND_GPIO
+	tristate "GPIO-based wiegand master (write only)"
+	depends on WIEGAND
+	help
+	  This GPIO bitbanging Wiegand controller uses the libgpiod library to
+	  utilize GPIO lines for sending Wiegand data. Userspace may access the
+	  Wiegand GPIO interface via a dev file.
+
+	  This support is also available as a module. If so, the module will be
+	  called wiegand-gpio.
diff --git a/drivers/wiegand/Makefile b/drivers/wiegand/Makefile
index d17ecb722c6e..ddf697e21088 100644
--- a/drivers/wiegand/Makefile
+++ b/drivers/wiegand/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_WIEGAND)			+= wiegand.o
+obj-$(CONFIG_WIEGAND_GPIO)		+= wiegand-gpio.o
diff --git a/drivers/wiegand/wiegand-gpio.c b/drivers/wiegand/wiegand-gpio.c
new file mode 100644
index 000000000000..448bfefaa7d9
--- /dev/null
+++ b/drivers/wiegand/wiegand-gpio.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/wiegand.h>
+
+#define WIEGAND_DEFAULT_PAYLOAD_LEN 26
+
+struct wiegand_gpio {
+	struct device *dev;
+	struct wiegand_controller *ctlr;
+	struct gpio_descs *gpios;
+};
+
+static ssize_t store_ulong(u32 *val, const char *buf, size_t size, unsigned long max)
+{
+	int rc;
+	u32 new;
+
+	rc = kstrtou32(buf, 0, &new);
+	if (rc)
+		return rc;
+
+	if (new > max)
+		return -ERANGE;
+
+	*val = new;
+	return size;
+}
+
+/*
+ * Attribute file for setting payload length of Wiegand messages.
+ */
+static ssize_t payload_len_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct wiegand_gpio *wiegand_gpio = dev_get_drvdata(dev);
+	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
+
+	return sysfs_emit(buf, "%u\n", ctlr->payload_len);
+}
+
+static ssize_t payload_len_store(struct device *dev, struct device_attribute *attr, const char *buf,
+			size_t count)
+{
+	struct wiegand_gpio *wiegand_gpio = dev_get_drvdata(dev);
+	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
+
+	return store_ulong(&(ctlr->payload_len), buf, count, WIEGAND_MAX_PAYLEN_BYTES * 8);
+}
+static DEVICE_ATTR_RW(payload_len);
+
+static struct attribute *wiegand_gpio_attrs[] = {
+	&dev_attr_payload_len.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(wiegand_gpio);
+
+/**
+ * wiegand_gpio_send_bit - Sends a single bit
+ *
+ * @wiegand_gpio: Instance of the Wiegand
+ * @value: Bit value to send
+ * @last: Indicates last bit of a message
+ *
+ * To send a bit of value 1 following the wiegand protocol, one must set
+ * the wiegand_data_hi to low for the duration of pulse. Similarly to send
+ * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
+ * This way the two lines are never low at the same time.
+ */
+void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value, bool last)
+{
+	u32 sleep_len;
+	struct wiegand_timing *timing = &wiegand_gpio->ctlr->timing;
+	u32 pulse_len = timing->pulse_len;
+	u32 interval_len = timing->interval_len;
+	u32 frame_gap = timing->frame_gap;
+	struct gpio_desc *gpio = value ? wiegand_gpio->gpios->desc[1] :
+						wiegand_gpio->gpios->desc[0];
+
+	gpiod_set_value_cansleep(gpio, 0);
+	udelay(pulse_len);
+	gpiod_set_value_cansleep(gpio, 1);
+
+	if (last)
+		sleep_len = frame_gap - pulse_len;
+	else
+		sleep_len = interval_len - pulse_len;
+
+	fsleep(sleep_len);
+}
+
+static int wiegand_gpio_write_by_bits(struct wiegand_gpio *wiegand_gpio, u16 bitlen)
+{
+	unsigned int i;
+	bool value;
+
+	for (i = 0; i < bitlen - 1; i++) {
+		value = test_bit(i, wiegand_gpio->ctlr->data_bitmap);
+		wiegand_gpio_send_bit(wiegand_gpio, value, false);
+	}
+
+	value = test_bit(bitlen - 1, wiegand_gpio->ctlr->data_bitmap);
+	wiegand_gpio_send_bit(wiegand_gpio, value, true);
+
+	return 0;
+}
+
+int wiegand_gpio_transfer_message(struct wiegand_controller *ctlr)
+{
+	struct wiegand_gpio *wiegand_gpio = wiegand_primary_get_devdata(ctlr);
+	u8 msg_bitlen = ctlr->payload_len;
+
+	wiegand_gpio_write_by_bits(wiegand_gpio, msg_bitlen);
+
+	return 0;
+}
+
+static int wiegand_gpio_request(struct device *dev, struct wiegand_gpio *wiegand_gpio)
+{
+	wiegand_gpio->gpios = devm_gpiod_get_array(dev, "data", GPIOD_OUT_HIGH);
+
+	if (IS_ERR(wiegand_gpio->gpios))
+		dev_err(dev, "unable to get gpios\n");
+
+	return PTR_ERR_OR_ZERO(wiegand_gpio->gpios);
+}
+
+static int wiegand_gpio_probe(struct platform_device *device)
+{
+	int status;
+	struct wiegand_controller *primary;
+	struct wiegand_gpio *wiegand_gpio;
+	struct device *dev = &device->dev;
+
+	primary = devm_wiegand_alloc_controller(dev, sizeof(*wiegand_gpio), false);
+	if (!primary)
+		return -ENOMEM;
+
+	primary->transfer_message = &wiegand_gpio_transfer_message;
+	primary->payload_len = WIEGAND_DEFAULT_PAYLOAD_LEN;
+
+	wiegand_gpio = wiegand_primary_get_devdata(primary);
+	wiegand_gpio->ctlr = primary;
+
+	platform_set_drvdata(device, wiegand_gpio);
+
+	primary->bus_num = device->id;
+	wiegand_gpio->dev = dev;
+
+	status = wiegand_gpio_request(dev, wiegand_gpio);
+	if (status)
+		return dev_err_probe(dev, status, "failed at requesting GPIOs\n");
+
+	status = gpiod_direction_output(wiegand_gpio->gpios->desc[0], 1);
+	if (status)
+		return dev_err_probe(dev, status, "failed to set GPIOs direction\n");
+
+	status = gpiod_direction_output(wiegand_gpio->gpios->desc[1], 1);
+	if (status)
+		return dev_err_probe(dev, status, "failed to set GPIOs direction\n");
+
+	status = devm_wiegand_register_controller(dev, primary);
+	if (status)
+		dev_err_probe(dev, status, "failed to register primary\n");
+	return 0;
+}
+
+static const struct of_device_id wiegand_gpio_dt_idtable[] = {
+	{ .compatible = "wiegand-gpio", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, wiegand_gpio_dt_idtable);
+
+static struct platform_driver wiegand_gpio_driver = {
+	.driver = {
+		.name	= "wiegand-gpio",
+		.of_match_table = wiegand_gpio_dt_idtable,
+		.dev_groups = wiegand_gpio_groups,
+	},
+	.probe		= wiegand_gpio_probe,
+};
+module_platform_driver(wiegand_gpio_driver);
+
+MODULE_IMPORT_NS(WIEGAND);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Wiegand write-only driver realized by GPIOs");
+MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");
-- 
2.40.1

