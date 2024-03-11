Return-Path: <linux-kernel+bounces-99177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8E6878482
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7D81C217DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0153395;
	Mon, 11 Mar 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="vKHzabd9"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDF50271;
	Mon, 11 Mar 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172923; cv=none; b=GOuCU0P7lAkd4nVtTR9f3nP8cyoqwET9my5QoJoRCjwbwYTqn8kKUFlngaETlcIHyaQH/fwb4wnEE6kYPQcPK2VKoM5ZG+FPzwMffkZ/9AtA1XVOl1LuqKDVEB24zIEVuMvLN6Ml8oy+0bUNofez9PxR0jGbRkuaIR3aSwuogrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172923; c=relaxed/simple;
	bh=dZadBTSX3ZiREaRtK+2CfMucz3EC9q7pJBt8RWcCZig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MG4sHtXus8euxfARfuQFMUsw2//hAB8jcgIZcOTVmjdAmyGHZpyEx0QZMZt7FUvlLnUs2695iiELZGtMdY9W2BnYSuOsvZOwVSWDuPHYujdWFjuCl0OkPDjbTGb/JHNiR0nSJRZGUjCWBRmiLSjqfcr/4SiQkldFfKW8c853+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=vKHzabd9; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 94BB728470E;
	Mon, 11 Mar 2024 17:01:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1710172919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJHoLEgdkSPTMqfi2K/z47Auw6QIbWF1VJyFverAsQk=;
	b=vKHzabd9arnWxttd2cSaRV94WJOgS2SzwarmBw/Y2cons4u2SJ9fCD3QMTh35gWZ/kggqD
	kp29GFVALES7nzym8Pnv1NMmJ7JO8PP/yc3mIhK/twmlanbehPkB5R9XOlOJIZCkMcrpTU
	Qef+bSoM/RV9zqW/aeHJgi5Gwjm53ag=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 66D0A44BC7D;
	Mon, 11 Mar 2024 17:01:59 +0100 (CET)
From: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
To: Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org
Subject: [RFC PATCH v4 4/5] input: add onkey driver for Marvell 88PM886 PMIC
Date: Mon, 11 Mar 2024 16:51:56 +0100
Message-ID: <20240311160110.32185-5-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240311160110.32185-1-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karel Balej <balejk@matfyz.cz>

Marvell 88PM886 PMIC provides onkey among other things. Add client
driver to handle it. The driver currently only provides a basic support
omitting additional functions found in the vendor version, such as long
onkey and GPIO integration.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    RFC v4:
    - Reflect MFD driver changes:
      - chip->regmaps[...] -> chip->regmap
    - Address Dmitry's feedback:
      - Add ID table.
      - Add Ack.
    RFC v3:
    - Drop wakeup-source.
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

 drivers/input/misc/88pm886-onkey.c | 99 ++++++++++++++++++++++++++++++
 drivers/input/misc/Kconfig         |  7 +++
 drivers/input/misc/Makefile        |  1 +
 3 files changed, 107 insertions(+)
 create mode 100644 drivers/input/misc/88pm886-onkey.c

diff --git a/drivers/input/misc/88pm886-onkey.c b/drivers/input/misc/88pm886-onkey.c
new file mode 100644
index 000000000000..b0bfbd57d826
--- /dev/null
+++ b/drivers/input/misc/88pm886-onkey.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/88pm886.h>
+
+struct pm886_onkey {
+	struct input_dev *idev;
+	struct pm886_chip *chip;
+};
+
+static irqreturn_t pm886_onkey_irq_handler(int irq, void *data)
+{
+	struct pm886_onkey *onkey = data;
+	struct regmap *regmap = onkey->chip->regmap;
+	struct input_dev *idev = onkey->idev;
+	struct device *parent = idev->dev.parent;
+	unsigned int val;
+	int err;
+
+	err = regmap_read(regmap, PM886_REG_STATUS1, &val);
+	if (err) {
+		dev_err(parent, "Failed to read status: %d\n", err);
+		return IRQ_NONE;
+	}
+	val &= PM886_ONKEY_STS1;
+
+	input_report_key(idev, KEY_POWER, val);
+	input_sync(idev);
+
+	return IRQ_HANDLED;
+}
+
+static int pm886_onkey_probe(struct platform_device *pdev)
+{
+	struct pm886_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct pm886_onkey *onkey;
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
+	idev->name = "88pm886-onkey";
+	idev->phys = "88pm886-onkey/input0";
+	idev->id.bustype = BUS_I2C;
+
+	input_set_capability(idev, EV_KEY, KEY_POWER);
+
+	err = devm_request_threaded_irq(dev, irq, NULL, pm886_onkey_irq_handler,
+					IRQF_ONESHOT | IRQF_NO_SUSPEND, "onkey",
+					onkey);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to request IRQ\n");
+
+	err = input_register_device(idev);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register input device\n");
+
+	return 0;
+}
+
+static const struct platform_device_id pm886_onkey_id_table[] = {
+	{ "88pm886-onkey", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, pm886_onkey_id_table);
+
+static struct platform_driver pm886_onkey_driver = {
+	.driver = {
+		.name = "88pm886-onkey",
+	},
+	.probe = pm886_onkey_probe,
+	.id_table = pm886_onkey_id_table,
+};
+module_platform_driver(pm886_onkey_driver);
+
+MODULE_DESCRIPTION("Marvell 88PM886 onkey driver");
+MODULE_AUTHOR("Karel Balej <balejk@matfyz.cz>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 6ba984d7f0b1..16a079d9f0f2 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -33,6 +33,13 @@ config INPUT_88PM80X_ONKEY
 	  To compile this driver as a module, choose M here: the module
 	  will be called 88pm80x_onkey.
 
+config INPUT_88PM886_ONKEY
+	tristate "Marvell 88PM886 onkey support"
+	depends on MFD_88PM886_PMIC
+	help
+	  Support the onkey of Marvell 88PM886 PMIC as an input device
+	  reporting power button status.
+
 config INPUT_AB8500_PONKEY
 	tristate "AB8500 Pon (PowerOn) Key"
 	depends on AB8500_CORE
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 04296a4abe8e..054a6dc1ac27 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -7,6 +7,7 @@
 
 obj-$(CONFIG_INPUT_88PM860X_ONKEY)	+= 88pm860x_onkey.o
 obj-$(CONFIG_INPUT_88PM80X_ONKEY)	+= 88pm80x_onkey.o
+obj-$(CONFIG_INPUT_88PM886_ONKEY)	+= 88pm886-onkey.o
 obj-$(CONFIG_INPUT_AB8500_PONKEY)	+= ab8500-ponkey.o
 obj-$(CONFIG_INPUT_AD714X)		+= ad714x.o
 obj-$(CONFIG_INPUT_AD714X_I2C)		+= ad714x-i2c.o
-- 
2.44.0


