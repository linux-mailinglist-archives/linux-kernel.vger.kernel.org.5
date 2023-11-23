Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6057F6039
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbjKWN2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345466AbjKWN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:28:04 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC1D62
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:28:07 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a00a9c6f283so120319766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1700746086; x=1701350886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QV98IcOEB2mGkUK9HbyaOsyZut+dAy3dRloMdrb/xJo=;
        b=YU0iYCwlFYsueB9XF2q0CXCHuzTNsKnYWHlBTLuRIhRml/EdQH2BSLe5ueAu7TCUCI
         jTuZFXX3zb4nqrEAYvbe9l/jIttZZv/L4PMG5DOwybix84jieNA78gGmpMY/VkHLmaeX
         B6kU3w25WlrrTmbJ0C84BpTWs98YBjTeR0GfLT7BEqv0lUT1AK4GLWOOI6rE9qS9s6d7
         kJzZFRd94abiJVjGxZNSqottPAxP0S/f8Lu6kX6UOHecSnGslNM49AhpZqnjvoLTLdae
         JLNF2jLn05rDmlruNBT3+6mPX5DDC67k9uYewuMI56ZArq4Wdbgcn4CY2RjVuni/tEEd
         EpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746086; x=1701350886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QV98IcOEB2mGkUK9HbyaOsyZut+dAy3dRloMdrb/xJo=;
        b=spVzd+ryVzN4CadHQArZgzl9Vb+qpuJEVbytku8gGLTeCUUcEIrbYzC80NABhIr1tz
         LVndu54mNeVnZZ6kwBWid9pKJ9ilTqlWM+xtRzn3fIvKku88GVCXkSJoC+lJslf1crSz
         EwLQwEaCSi6eB6WifvwfImgjreuUJRkwTHtLrKBJpc7XwRF5rcGdwXE/fMUEDJquaMAa
         72OZW6f013yq0D6UM0FDlP95+XNju2MGaDF6F4hQzM2cxjvCriUdDFPVaS3mBJkoXxwn
         7AQ+dD4N1fptgT70KISWpUBvOFOhi8XAyuhgGYEYmDAQ6TYuESqMMqTRMZJli/F9lZGF
         piVA==
X-Gm-Message-State: AOJu0YykHBckXd5sqwtUbYLXqsRgBWDV0lL2UxZh+nvtOhl07PdLQ4wO
        6xWzu9hr3F4tcNckVn364CrYvw==
X-Google-Smtp-Source: AGHT+IG0rIzX/GbTE1ChinuMTNv4LrhiX2EguPkdr14yTXNjoPSPSmIriaidjBWhJKJmbNa6dS4oWg==
X-Received: by 2002:a17:906:2249:b0:9fd:4bed:72af with SMTP id 9-20020a170906224900b009fd4bed72afmr4260455ejr.72.1700746085961;
        Thu, 23 Nov 2023 05:28:05 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id q22-20020a1709064c9600b009ae69c303aasm778834eju.137.2023.11.23.05.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:28:05 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH v5] leds: max5970: Add support for max5970
Date:   Thu, 23 Nov 2023 13:28:02 +0000
Message-ID: <20231123132803.1107174-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

The MAX5970 is hot swap controller and has 4 indication LED.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Reviewed-by: Lee Jones <lee@kernel.org>
---
Changes in V5:
- Replace -EPROBE_DEFER with -ENODEV
Changes in V4:
- Compact declaration of variable to single line
- Use sizeof(*ddata) instead of sizeof(struct max5970_led).
- Use the shorter 'dev' version whilst it's available
Changes in V3:
- Drop array for ddata variable.
Changes in V2:
- Add of_node_put before return.
- Code cleanup
- Refactor code & remove max5970_setup_led function.
---
 drivers/leds/Kconfig        |  11 ++++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-max5970.c | 109 ++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/leds/leds-max5970.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6292fddcc55c..da60940d711f 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -638,6 +638,17 @@ config LEDS_ADP5520
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
index 000000000000..456a16a47450
--- /dev/null
+++ b/drivers/leds/leds-max5970.c
@@ -0,0 +1,109 @@
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
+	struct device_node *led_node, *child;
+	struct max5970_led *ddata;
+	int ret = -ENODEV, num_leds = 0;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -ENODEV;
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
+		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+		if (!ddata) {
+			of_node_put(child);
+			return -ENOMEM;
+		}
+
+		ddata->index = reg;
+		ddata->regmap = regmap;
+		ddata->dev = dev;
+
+		if (of_property_read_string(child, "label", &ddata->cdev.name))
+			ddata->cdev.name = child->name;
+
+		ddata->cdev.max_brightness = 1;
+		ddata->cdev.brightness_set_blocking = max5970_led_set_brightness;
+		ddata->cdev.default_trigger = "none";
+
+		ret = devm_led_classdev_register(dev, &ddata->cdev);
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

base-commit: b9604be241587fb29c0f40450e53d0a37dc611b5
-- 
2.41.0

