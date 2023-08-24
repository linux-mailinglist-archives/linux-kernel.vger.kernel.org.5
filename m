Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FE5786D81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjHXLOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbjHXLNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:13:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811D6172D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:13:50 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c73c21113so621166f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692875629; x=1693480429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DkwdpEsnZjrBHPvFI7R2mEJyzdrosQr2sd/FTGz51gs=;
        b=RCqQTVbnib3XzB0myr4N9s4B/TVmbRl8bAB5maubjYQUpcmstTpY0j+u0mGyvvlH9B
         J6KbFYDRcpo9CMpjPVR2TLfztDk3Hengnw95zp4j7AbuGdtXo4xY7pUftdecwbC+IJvJ
         /Gj3+1ILWdJqYboVY6ifF1hNvH0V99Jrfez2QGWLyus8DkFq7BXVFTDK/bV+JlEJh37d
         q7O7a2nrLFxoxG9DKs6LeLFHg1OdvYQkppMRJd+Lebh3GdXrIJSA1jmZP1uX5JAtYa2p
         xiqiaf/EZN5OiLkGOo+0/sFNTKpqYh5KgogoNUPMAFn2JVCQ1+ZBfxrQQbQx/FUkswMB
         m09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692875629; x=1693480429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkwdpEsnZjrBHPvFI7R2mEJyzdrosQr2sd/FTGz51gs=;
        b=I/xq0b1OhWlP5grGiBqOs8/uPBv6s7n8/3P63CLRdoyxOgWcTGYUxHl/++4FZnugXy
         OPAD57t0Iz6fS+LPyTXp9KXNiT23dMclyB+sNJqvqbYgxrd1KJElZ44Gu+3mqgh0HCjl
         qxPOcsdJDqlTJVL8iEYb48dwh3W7g/SYQ28K9wZBayJuU3BxgfJqHhX/p/+/GKm8hJ0x
         ZpKCVJpfYIkaHvsDBn6ceZEz/KA4mZF3x40mbq8NYrPf3DcKXqV2pP56dkHN3a+9o6uk
         dMFnAIIaphWJqtdd0wLV6Ho+cf1XJPekJaw0DEKl0/0FC+mWt3JI2WNOuLqBO/aJgJfy
         tCDA==
X-Gm-Message-State: AOJu0Yy/t3SomRNSM74RitDY/amWtwyljBWJbBZXpSrkw3EsFDZlC1Dk
        3sV3Wl83H8cLRRrVgjiqTdxmFsWutXm26PY1Zn+8JA==
X-Google-Smtp-Source: AGHT+IHDvGqxKdCBn8C3V++imu78i7LpYDx7TqRwzi7mHrcuuPJF6pJtBG1YuCQlBTISfoEFIFwNKw==
X-Received: by 2002:adf:f4c9:0:b0:317:5ddb:a8bf with SMTP id h9-20020adff4c9000000b003175ddba8bfmr11529921wrp.29.1692875628844;
        Thu, 24 Aug 2023 04:13:48 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id j16-20020a056000125000b0031779a6b451sm21973021wrx.83.2023.08.24.04.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:13:48 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH v3] leds: max5970: Add support for max5970
Date:   Thu, 24 Aug 2023 13:13:36 +0200
Message-ID: <20230824111337.2589755-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Changes in V3:
- Drop array for ddata variable.
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
index 000000000000..c9685990e26e
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
+	struct max5970_led *ddata;
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
+		ddata = devm_kzalloc(dev, sizeof(struct max5970_led), GFP_KERNEL);
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
+		ret = devm_led_classdev_register(ddata->dev, &ddata->cdev);
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

