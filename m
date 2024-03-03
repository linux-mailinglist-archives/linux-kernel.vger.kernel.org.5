Return-Path: <linux-kernel+bounces-89700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3A886F455
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CAB2831CA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4FE1119E;
	Sun,  3 Mar 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="OsQvXuCQ"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C38ABE6F;
	Sun,  3 Mar 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709460939; cv=none; b=iJo0LRUy6a3trvemfM5R2T2QRoJNfTg9lzqTn8F8t96COwpQEplzvpEPaCZ619vA/8f1ecjs+LK8ihgXyXmNSdv0ukMu3AKut5KXbP65bZUQDRXlFz4Ws6V7u2Ifkbrv8dHGkQl1bZFsTn6w/cc473vCOJFltEZrp5mKSQkNaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709460939; c=relaxed/simple;
	bh=6bfIYuZJxXhbwIjqddIRiO/HE5MXRN1Wdqdl2bUC7ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jm1vY+r6rKM9qNz5OcjA6gqL5P/2ExydOsmks03lZ3YjW2q+W+Mh4DC+ynsz+9D83rM9ufV47aHBFM1IQ3cPzqFPAupOdaMB2/E9E9F1OZyU7hH1jH3HyEqJMx46kDm1ZmNPjFTrob9FUFBehrMu3+RLaVvbhGgEvC7I4IWqP2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=OsQvXuCQ; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id 65EDE284294;
	Sun,  3 Mar 2024 11:15:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1709460935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XQfPEk+YaTiJuYOg0PFgBeaAHtq/GQWV1cVMTq9Ae8U=;
	b=OsQvXuCQvo0e3HSCu4WiExRgqfitRz3YJfAlS41hgCGr9AmPDpswbGPKZLTx6aLRk8tOh7
	bP00O+Ps47w8TApT5NWxhMtlF4Z3FdfTOC5ry4eOxv1SKPze/tFdTWYXQYmEV3rR+w9fml
	2Zk5kYF+PIya0kv6kDgApIixRdfcDfk=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 4426C456F3E;
	Sun,  3 Mar 2024 11:15:35 +0100 (CET)
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
Subject: [RFC PATCH v3 4/5] input: add onkey driver for Marvell 88PM886 PMIC
Date: Sun,  3 Mar 2024 11:04:25 +0100
Message-ID: <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
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

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
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

 drivers/input/misc/88pm886-onkey.c | 92 ++++++++++++++++++++++++++++++
 drivers/input/misc/Kconfig         |  7 +++
 drivers/input/misc/Makefile        |  1 +
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/input/misc/88pm886-onkey.c

diff --git a/drivers/input/misc/88pm886-onkey.c b/drivers/input/misc/88pm886-onkey.c
new file mode 100644
index 000000000000..2e5df21cd11b
--- /dev/null
+++ b/drivers/input/misc/88pm886-onkey.c
@@ -0,0 +1,92 @@
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
+	struct regmap *regmap = onkey->chip->regmaps[PM886_REGMAP_BASE];
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
+static struct platform_driver pm886_onkey_driver = {
+	.driver = {
+		.name = "88pm886-onkey",
+	},
+	.probe = pm886_onkey_probe,
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


