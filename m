Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B97C786D22
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbjHXKtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbjHXKt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:49:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DDC10DA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:49:27 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so46808101fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692874165; x=1693478965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2QSKQ/83/43p/qAa+Lm0R0OYAZElaQVoZevD5EWLWg=;
        b=KCzIc1MjLtX5BE4+VRpevemNFKGb2TsLLDtvnq8nmjtJ5ztTPV0U9cuTmKjtcCGiQL
         vb9CpFodiXI8uCZJwLY2+k0Pjpws0By7nuHsUWdycBYGZRtW/1jjC38XiIX8WSwe3yn0
         oJ2cV69iq0g8y3YG6gkTdMBBXlfASdfH9MPnndExKR8NTQKzjH3p1fBrGKIdu+7kDgBT
         jkcK8hrHx0I3PIHw08eOVQzYUsMHIU1+WADHo3fFVT0NA6SS6eZ8c8TqcUecLc5VwsSN
         NJ2uIgvFJCj9rjgrfLk9j4CZczZPwAZpzO2pcXUibujsQXD1cMvn+Jn4G5ISYuaRoocM
         Xv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874165; x=1693478965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2QSKQ/83/43p/qAa+Lm0R0OYAZElaQVoZevD5EWLWg=;
        b=KvP9FgUKFPh42Wt0fmF8jO41fuI8hRUF4sBkerOncTGISkDAGvIlwv6VLZu6cMf61g
         DqXcoDoBm650y96SAX5OnuDOKf3IbKdmnV1iiJ8JmBF/S4LmcP59X4kZwGrBvSHbmpkf
         +7gFuTwMxT4XDSltVnkS8X+C4JeIe/qok5lOBke5fYacbCxJ38JMpBGuZU3YalZzqFVw
         GbN3Vf130OCBFXUops9EYBeSzj7wa51TEM5H6gRTaQGUw5TyNLOZSTbglmLdR0CbY1C4
         W825teFZL/2icQC5jHWVo/xe/KbIkRndzHQJKtpagobPCw3YjmNxe5TyiC2rsP8R0jQa
         P9SA==
X-Gm-Message-State: AOJu0YyIbWSNVve+wFUwc7nUjLPmfBtI+RyntwXmxFgh0Tj4Aco+bzTE
        RpKTE5Zb6HDuqnHAZxEQRdC/RfMnLumEzqMLPht76w==
X-Google-Smtp-Source: AGHT+IElyEncgNbRYW+dsOkc7aLQbs5D+YwNHeV6E3BV249cK6RVTDS/4OzZhsIPXWb4GX1jA00G5w==
X-Received: by 2002:a2e:9c99:0:b0:2bc:dd6b:9220 with SMTP id x25-20020a2e9c99000000b002bcdd6b9220mr3407626lji.24.1692874165470;
        Thu, 24 Aug 2023 03:49:25 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id k25-20020a05600c0b5900b003feea62440bsm2223743wmr.43.2023.08.24.03.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:49:24 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH v2] leds: max5970: Add support for max5970
Date:   Thu, 24 Aug 2023 12:49:08 +0200
Message-ID: <20230824104909.2451625-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

The MAX5970 is hot swap controller and has 4 indication LED.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V2:
- Add of_node_put before return.
- Code cleanup
- Refactor code & remove max5970_setup_led function.
---
 drivers/leds/Kconfig        |  11 ++++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-max5970.c | 110 ++++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 drivers/leds/leds-max5970.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index b92208eccdea..03ef527cc545 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -637,6 +637,17 @@ config LEDS_ADP5520
 	  To compile this driver as a module, choose M here: the module will
 	  be called leds-adp5520.
 
+config LEDS_MAX5970
+	tristate "LED Support for Maxim 5970"
+	depends on LEDS_CLASS
+	depends on MFD_MAX5970
+	help
+	  This option enables support for the Maxim MAX5970 & MAX5978 smart
+	  switch indication LEDs via the I2C bus.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called leds-max5970.
+
 config LEDS_MC13783
 	tristate "LED Support for MC13XXX PMIC"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index d7348e8bc019..6eaee0a753c6 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_LEDS_LP8501)		+= leds-lp8501.o
 obj-$(CONFIG_LEDS_LP8788)		+= leds-lp8788.o
 obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
 obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
+obj-$(CONFIG_LEDS_MAX5970)		+= leds-max5970.o
 obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
diff --git a/drivers/leds/leds-max5970.c b/drivers/leds/leds-max5970.c
new file mode 100644
index 000000000000..79277d47e1bc
--- /dev/null
+++ b/drivers/leds/leds-max5970.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for leds in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/leds.h>
+#include <linux/mfd/max5970.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define ldev_to_maxled(c)       container_of(c, struct max5970_led, cdev)
+
+struct max5970_led {
+	struct device *dev;
+	struct regmap *regmap;
+	struct led_classdev cdev;
+	unsigned int index;
+};
+
+static int max5970_led_set_brightness(struct led_classdev *cdev,
+				      enum led_brightness brightness)
+{
+	struct max5970_led *ddata = ldev_to_maxled(cdev);
+	int ret, val;
+
+	/* Set/clear corresponding bit for given led index */
+	val = !brightness ? BIT(ddata->index) : 0;
+
+	ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
+	if (ret < 0)
+		dev_err(cdev->dev, "failed to set brightness %d", ret);
+
+	return ret;
+}
+
+static int max5970_led_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev->parent);
+	struct regmap *regmap;
+	struct device_node *led_node;
+	struct device_node *child;
+	struct max5970_led *ddata[MAX5970_NUM_LEDS];
+	int ret = -ENODEV, num_leds = 0;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	led_node = of_get_child_by_name(np, "leds");
+	if (!led_node)
+		return -ENODEV;
+
+	for_each_available_child_of_node(led_node, child) {
+		u32 reg;
+
+		if (of_property_read_u32(child, "reg", &reg))
+			continue;
+
+		if (reg >= MAX5970_NUM_LEDS) {
+			dev_err(dev, "invalid LED (%u >= %d)\n", reg, MAX5970_NUM_LEDS);
+			continue;
+		}
+
+		ddata[num_leds] = devm_kzalloc(dev, sizeof(struct max5970_led), GFP_KERNEL);
+		if (!ddata[num_leds]) {
+			of_node_put(child);
+			return -ENOMEM;
+		}
+
+		ddata[num_leds]->index = reg;
+		ddata[num_leds]->regmap = regmap;
+		ddata[num_leds]->dev = dev;
+
+		if (of_property_read_string(child, "label", &ddata[num_leds]->cdev.name))
+			ddata[num_leds]->cdev.name = child->name;
+
+		ddata[num_leds]->cdev.max_brightness = 1;
+		ddata[num_leds]->cdev.brightness_set_blocking = max5970_led_set_brightness;
+		ddata[num_leds]->cdev.default_trigger = "none";
+
+		ret = devm_led_classdev_register(ddata[num_leds]->dev, &ddata[num_leds]->cdev);
+		if (ret < 0) {
+			of_node_put(child);
+			dev_err(dev, "Failed to initialize LED %u\n", reg);
+			return ret;
+		}
+		num_leds++;
+	}
+
+	return ret;
+}
+
+static struct platform_driver max5970_led_driver = {
+	.driver = {
+		.name = "max5970-led",
+	},
+	.probe = max5970_led_probe,
+};
+
+module_platform_driver(max5970_led_driver);
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_AUTHOR("Naresh Solanki <Naresh.Solanki@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
+MODULE_LICENSE("GPL");

base-commit: baca986e1f2c31f8e4b2a6d99d47c3bc844033e8
-- 
2.41.0

