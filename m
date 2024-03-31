Return-Path: <linux-kernel+bounces-126044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30FC893156
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AF3281FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC0D144312;
	Sun, 31 Mar 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="N55sSFwU"
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181665B217;
	Sun, 31 Mar 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711882726; cv=none; b=qEr6F/J5zlYl7fd8UtjjjJqBcPTkdjO1GPihtNe/IaTfZHHqCuWY9T3Xi3ZTDh5MdIcJmcC3RwH84hMEf9HyT948hxFTi0qLU7ZBbfjMBbBxVl0hqMjPSKIWx6MArxsm23L56cKJ6bTYmdIsRSWtIW8gIYM583YlLh/BskjSpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711882726; c=relaxed/simple;
	bh=lZB2O/GTTPvCiLX0VaQGBhydvS7DwDr0NnUY8AJiid4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ap3I0OiII5S/BMy+U+agGfcaKjz8tsnxMLumSzetC9k5GZ9Pg7OOkwDW88C0dhEe+xsTglPOC8fmPN+76UbaaEWvxR8U8VKHwo2SgZ1PA/QNMJgxShN7Ni3XFVThiFZ8uNfjnlJIcZQ+Gpw8dLmi0o/vCBoTBSrqQrTX6ro8zJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=N55sSFwU; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1711882704; x=1713182704;
	bh=Ol2Cwm/F+G7Bhqs1SRgd02eX++Fq8X5sza0GaZ191u4=;
	h=From:MIME-Version;
	b=N55sSFwUY1gtBlpHlDHgK6PtForDmjZ06OpTdqFwB4seqN4K+cAB2z6lPmgytomG3
	 tpMeQGB7ELV/y+jRP7xhWBW2nlNEHkpIvnRcliOY++kcnZrRB5RphmZteptgvqhWL1
	 or80/JZObbcngvZZRaaKQKtwwwfksxGTsJffCGGC1oAlYYw/+ZXrB5vvxUUa0DnQpr
	 Kw/WFKe2nKZpJVlOkVoSSfZfgnUGgAyP+B+GJwTJ1JOGRj+i6vhkC8PucLSDP+Idvz
	 kcfEVqE+TUga9Artw5WVLxFSGO6rUKdB1WyHsqItVz9sGi5b0QnrhcIK72dT/OLs2s
	 eVmPtiPk6vp2w==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42VAwNOt095413
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 31 Mar 2024 12:58:24 +0200 (CEST)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH 4/5] input: add onkey driver for Marvell 88PM886 PMIC
Date: Sun, 31 Mar 2024 12:46:57 +0200
Message-ID: <20240331105608.7338-6-balejk@matfyz.cz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240331105608.7338-2-balejk@matfyz.cz>
References: <20240331105608.7338-2-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Marvell 88PM886 PMIC provides onkey among other things. Add client
driver to handle it. The driver currently only provides a basic support
omitting additional functions found in the vendor version, such as long
onkey and GPIO integration.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    v1:
    - Remove kernel.h include.
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

 drivers/input/misc/88pm886-onkey.c | 98 ++++++++++++++++++++++++++++++
 drivers/input/misc/Kconfig         |  7 +++
 drivers/input/misc/Makefile        |  1 +
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/input/misc/88pm886-onkey.c

diff --git a/drivers/input/misc/88pm886-onkey.c b/drivers/input/misc/88pm886-onkey.c
new file mode 100644
index 000000000000..284ff5190b6e
--- /dev/null
+++ b/drivers/input/misc/88pm886-onkey.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
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


