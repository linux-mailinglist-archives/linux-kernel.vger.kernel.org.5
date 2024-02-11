Return-Path: <linux-kernel+bounces-60686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F685086F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B56C2839B2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D254E5B5C5;
	Sun, 11 Feb 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="o+dcb4p/"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429785B200;
	Sun, 11 Feb 2024 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707644837; cv=none; b=RM28RcIQmxHkR3BNaDn5JaalIUs6TLOOL5OFq/SWgXrSuRHJS0gJFfsL+wy1wJiRvfm91pnQoZkd2rSGPFzXF7z4re3fTfgUszjrDAKxk5xgyj0mGxSwrYGzzKh/ledvnuJLvgMN64ZJoLfKidaA4WDyCWTEgAWYVP35F7LO2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707644837; c=relaxed/simple;
	bh=0Y2HpLfq3XSlRtw6hWY7CsACp4JJ78Job7tAlZGAt1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0yCoJ4PDVDCYJdP5Z9UlF69PB6U0UrTphMiB9ja8Igw1a4cU5NG1pS01RYuF/71WhXf7lMY2R/n8oGS+UAhOrp2LRm0oVe1ay16pUFgk8nTUgSPm0lUj1iIzyYd9EuPa4oaW7O/uxtXujQiiMGBmoF+8a28jveHHjzrT91oc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=o+dcb4p/; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 7E51D2811C0;
	Sun, 11 Feb 2024 10:47:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1707644833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TTz5teFU3tBU//g8hEWHIhQLcenB+WG4jpSaCFoiEdo=;
	b=o+dcb4p/Y2Rnn2Fqc8lOAi2oB0stiyYPGXL+LKZwJ3tYF5OERYrXIksEngrvxBDV8k8fhI
	akPk6+wBt8/0l6pYcIEZXhRVPkOioI11HZOajoLZiaf7HXJa6G4y8VQrZikKnwGOiEZrjW
	t/jpCiv8yhhwzriOOigLaUACDLTLCIM=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 5C85C457E76;
	Sun, 11 Feb 2024 10:47:13 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH v2 5/6] input: add onkey driver for Marvell 88PM88X PMICs
Date: Sun, 11 Feb 2024 10:35:55 +0100
Message-ID: <20240211094609.2223-6-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240211094609.2223-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Marvell 88PM88X PMICs provide onkey among other things. Add client
driver to handle it. The driver currently only provides a basic support
omitting additional functions found in the vendor version, such as long
onkey and GPIO integration.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    RFC v2:
    - Address Dmitry's feedback:
      - Sort includes alphabetically.
      - Drop onkey->irq.
      - ret -> err in irq_handler and no initialization.
      - Break long lines and other formatting.
      - Do not clobber platform_get_irq error.
      - Do not set device parent manually.
      - Use input_set_capability.
      - Use the wakeup-source DT property.
      - Drop of_match_table.
      - Use more temporaries.
      - Use dev_err_probe.
    - Modify Kconfig description.

 drivers/input/misc/88pm88x-onkey.c | 95 ++++++++++++++++++++++++++++++
 drivers/input/misc/Kconfig         |  7 +++
 drivers/input/misc/Makefile        |  1 +
 3 files changed, 103 insertions(+)
 create mode 100644 drivers/input/misc/88pm88x-onkey.c

diff --git a/drivers/input/misc/88pm88x-onkey.c b/drivers/input/misc/88pm88x-onkey.c
new file mode 100644
index 000000000000..2a0bd63a63a7
--- /dev/null
+++ b/drivers/input/misc/88pm88x-onkey.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/88pm88x.h>
+
+struct pm88x_onkey {
+	struct input_dev *idev;
+	struct pm88x_chip *chip;
+};
+
+static irqreturn_t pm88x_onkey_irq_handler(int irq, void *data)
+{
+	struct pm88x_onkey *onkey = data;
+	struct regmap *regmap = onkey->chip->regmaps[PM88X_REGMAP_BASE];
+	struct input_dev *idev = onkey->idev;
+	struct device *parent = idev->dev.parent;
+	unsigned int val;
+	int err;
+
+	err = regmap_read(regmap, PM88X_REG_STATUS1, &val);
+	if (err) {
+		dev_err(parent, "Failed to read status: %d\n", err);
+		return IRQ_NONE;
+	}
+	val &= PM88X_ONKEY_STS1;
+
+	input_report_key(idev, KEY_POWER, val);
+	input_sync(idev);
+
+	return IRQ_HANDLED;
+}
+
+static int pm88x_onkey_probe(struct platform_device *pdev)
+{
+	struct pm88x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct pm88x_onkey *onkey;
+	struct input_dev *idev;
+	int irq, err;
+
+	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
+	if (!onkey)
+		return -ENOMEM;
+
+	onkey->chip = chip;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
+
+	idev = devm_input_allocate_device(dev);
+	if (!idev) {
+		dev_err(dev, "Failed to allocate input device\n");
+		return -ENOMEM;
+	}
+	onkey->idev = idev;
+
+	idev->name = "88pm88x-onkey";
+	idev->phys = "88pm88x-onkey/input0";
+	idev->id.bustype = BUS_I2C;
+
+	input_set_capability(idev, EV_KEY, KEY_POWER);
+
+	err = devm_request_threaded_irq(dev, irq, NULL, pm88x_onkey_irq_handler,
+					IRQF_ONESHOT | IRQF_NO_SUSPEND, "onkey",
+					onkey);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to request IRQ\n");
+
+	err = input_register_device(idev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register input device\n");
+
+	device_init_wakeup(dev, device_property_read_bool(dev, "wakeup-source"));
+
+	return 0;
+}
+
+static struct platform_driver pm88x_onkey_driver = {
+	.driver = {
+		.name = "88pm88x-onkey",
+	},
+	.probe = pm88x_onkey_probe,
+};
+module_platform_driver(pm88x_onkey_driver);
+
+MODULE_DESCRIPTION("Marvell 88PM88X onkey driver");
+MODULE_AUTHOR("Karel Balej <balejk@matfyz.cz>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 6ba984d7f0b1..97a1ff83e8df 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -33,6 +33,13 @@ config INPUT_88PM80X_ONKEY
 	  To compile this driver as a module, choose M here: the module
 	  will be called 88pm80x_onkey.
 
+config INPUT_88PM88X_ONKEY
+	tristate "Marvell 88PM88X onkey support"
+	depends on MFD_88PM88X_PMIC
+	help
+	  Support the onkey of Marvell 88PM88X PMICs as an input device
+	  reporting power button status.
+
 config INPUT_AB8500_PONKEY
 	tristate "AB8500 Pon (PowerOn) Key"
 	depends on AB8500_CORE
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 04296a4abe8e..eab7a364188c 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -7,6 +7,7 @@
 
 obj-$(CONFIG_INPUT_88PM860X_ONKEY)	+= 88pm860x_onkey.o
 obj-$(CONFIG_INPUT_88PM80X_ONKEY)	+= 88pm80x_onkey.o
+obj-$(CONFIG_INPUT_88PM88X_ONKEY)	+= 88pm88x-onkey.o
 obj-$(CONFIG_INPUT_AB8500_PONKEY)	+= ab8500-ponkey.o
 obj-$(CONFIG_INPUT_AD714X)		+= ad714x.o
 obj-$(CONFIG_INPUT_AD714X_I2C)		+= ad714x-i2c.o
-- 
2.43.0


