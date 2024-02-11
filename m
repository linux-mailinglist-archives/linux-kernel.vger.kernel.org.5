Return-Path: <linux-kernel+bounces-60682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10764850863
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6BF283930
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5759B70;
	Sun, 11 Feb 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b="b67SIPMl"
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666E58231;
	Sun, 11 Feb 2024 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707644829; cv=none; b=E8tfapGK6k/TFtfu5d5lPs2kZdl43vc8rTZ5Zo0GWnOotQ0r61R/nduWocOgm6MTWDFfYy59Erw5qpR2f5G0hmhw717Cmv67Mg5U96/6SrKOcz2qxTYcrJH+MR9IN+P5oWtczVF7ehk2ukzny3ceCfY44szmTCVhMHj5eFwlkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707644829; c=relaxed/simple;
	bh=1CQmjhQn9JLY2KAoR/IFMTsdgT+t8QvF9oR+iHH/EEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/C1VS2UXlZ4pdYaisLrNi1TMtjGKYyrEqPHvA93qHIARlAosjkEyCkPihlzvHNGDLoXukk962eIRwns8vYfEusM3zEjv89NEZ5YSM2vnJrV49/2BRqWkqo9osHZSSznM3eQhH7CyO53HnwOJouRoGh2cWM9VIY4oMvfEfOrwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz; dkim=pass (1024-bit key) header.d=gimli.ms.mff.cuni.cz header.i=@gimli.ms.mff.cuni.cz header.b=b67SIPMl; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gimli.ms.mff.cuni.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gimli.ms.mff.cuni.cz
Received: from gimli.ms.mff.cuni.cz (gimli.ms.mff.cuni.cz [195.113.20.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTPS id C2BC22811F8;
	Sun, 11 Feb 2024 10:47:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gimli.ms.mff.cuni.cz;
	s=gen1; t=1707644823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PeHaJ8Kg9vJGbqcZiSSApdOdsNQExO5Qs5SyJ1e3dUk=;
	b=b67SIPMll5Xk9baMRyhlwjMEveX3MBtEXhB2y4UMzQKO2Aa2olS9X1Io6JmMa1is8+rMLD
	2NzLUh+3tmY1ACN35aIULJbLxB2WakAj2/4V5/oH/rLyV4NvLuSRQgGbAbU47FN5j4SHVo
	e3x5LPkhsWu0jM0LzHyVsR3sz+bPKNo=
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: karelb)
	by gimli.ms.mff.cuni.cz (Postfix) with ESMTPSA id 9DF60457D27;
	Sun, 11 Feb 2024 10:47:03 +0100 (CET)
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
Subject: [RFC PATCH v2 2/6] mfd: add driver for Marvell 88PM886 PMIC
Date: Sun, 11 Feb 2024 10:35:52 +0100
Message-ID: <20240211094609.2223-3-karelb@gimli.ms.mff.cuni.cz>
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

Marvell 88PM886 is a PMIC which provides various functions such as
onkey, battery, charger and regulators. It is found for instance in the
samsung,coreprimevelte smartphone with which this was tested.

Only implement basic support to allow for the use of regulators and
onkey omitting the currently unused register definitions and I2C
subclients which should thus be added with the subdevice drivers which
need them.

The register mapping and functions of 88PM886 are very similar to those
of 88PM880 and the downstream version of the driver handles both of
these devices. Possible future efforts to support 88PM880 should thus
make use of this driver.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---

Notes:
    RFC v2:
    - Remove some abstraction.
    - Sort includes alphabetically and add linux/of.h.
    - Depend on OF, remove of_match_ptr and add MODULE_DEVICE_TABLE.
    - Use more temporaries and break long lines.
    - Do not initialize ret in probe.
    - Use the wakeup-source DT property.
    - Rename ret to err.
    - Address Lee's comments:
      - Drop patched in presets for base regmap and related defines.
      - Use full sentences in comments.
      - Remove IRQ comment.
      - Define regmap_config member values.
      - Rename data to sys_off_data.
      - Add _PMIC suffix to Kconfig.
      - Use dev_err_probe.
      - Do not store irq_data.
      - s/WHOAMI/CHIP_ID
      - Drop LINUX part of include guard name.
      - Merge in the regulator series modifications in order to have more
        devices and modify the commit message accordingly. Changes with
        respect to the original regulator series patches:
        - ret -> err
        - Add temporary for dev in pm88x_initialize_subregmaps.
        - Drop of_compatible for the regulators.
        - Do not duplicate LDO regmap for bucks.
    - Rewrite commit message.

 drivers/mfd/88pm88x.c       | 211 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/Kconfig         |  12 ++
 drivers/mfd/Makefile        |   1 +
 include/linux/mfd/88pm88x.h |  46 ++++++++
 4 files changed, 270 insertions(+)
 create mode 100644 drivers/mfd/88pm88x.c
 create mode 100644 include/linux/mfd/88pm88x.h

diff --git a/drivers/mfd/88pm88x.c b/drivers/mfd/88pm88x.c
new file mode 100644
index 000000000000..301e3e8f26f4
--- /dev/null
+++ b/drivers/mfd/88pm88x.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/88pm88x.h>
+
+#define PM88X_REG_INT_STATUS1			0x05
+
+#define PM88X_REG_INT_ENA_1			0x0a
+#define PM88X_INT_ENA1_ONKEY			BIT(0)
+
+#define PM88X_REGMAP_CONF_REG_BITS		8
+#define PM88X_REGMAP_CONF_VAL_BITS		8
+#define PM88X_REGMAP_CONF_MAX_REG		0xfe
+
+enum pm88x_irq_number {
+	PM88X_IRQ_ONKEY,
+
+	PM88X_MAX_IRQ
+};
+
+static struct regmap_irq pm88x_regmap_irqs[] = {
+	REGMAP_IRQ_REG(PM88X_IRQ_ONKEY, 0, PM88X_INT_ENA1_ONKEY),
+};
+
+static struct regmap_irq_chip pm88x_regmap_irq_chip = {
+	.name = "88pm88x",
+	.irqs = pm88x_regmap_irqs,
+	.num_irqs = ARRAY_SIZE(pm88x_regmap_irqs),
+	.num_regs = 4,
+	.status_base = PM88X_REG_INT_STATUS1,
+	.ack_base = PM88X_REG_INT_STATUS1,
+	.unmask_base = PM88X_REG_INT_ENA_1,
+};
+
+static struct resource pm88x_onkey_resources[] = {
+	DEFINE_RES_IRQ_NAMED(PM88X_IRQ_ONKEY, "88pm88x-onkey"),
+};
+
+static struct mfd_cell pm886_devs[] = {
+	{
+		.name = "88pm88x-onkey",
+		.of_compatible = "marvell,88pm88x-onkey",
+		.num_resources = ARRAY_SIZE(pm88x_onkey_resources),
+		.resources = pm88x_onkey_resources,
+	},
+	{
+		.name = "88pm88x-regulator",
+		.id = PM88X_REGULATOR_ID_LDO2,
+	},
+	{
+		.name = "88pm88x-regulator",
+		.id = PM88X_REGULATOR_ID_LDO15,
+	},
+	{
+		.name = "88pm88x-regulator",
+		.id = PM886_REGULATOR_ID_BUCK2,
+	},
+};
+
+static const struct regmap_config pm88x_i2c_regmap = {
+	.reg_bits = PM88X_REGMAP_CONF_REG_BITS,
+	.val_bits = PM88X_REGMAP_CONF_VAL_BITS,
+	.max_register = PM88X_REGMAP_CONF_MAX_REG,
+};
+
+static int pm88x_power_off_handler(struct sys_off_data *sys_off_data)
+{
+	struct pm88x_chip *chip = sys_off_data->cb_data;
+	struct regmap *regmap = chip->regmaps[PM88X_REGMAP_BASE];
+	struct device *dev = &chip->client->dev;
+	int err;
+
+	err = regmap_update_bits(regmap, PM88X_REG_MISC_CONFIG1, PM88X_SW_PDOWN,
+				PM88X_SW_PDOWN);
+	if (err) {
+		dev_err(dev, "Failed to power off the device: %d\n", err);
+		return NOTIFY_BAD;
+	}
+	return NOTIFY_DONE;
+}
+
+static int pm88x_initialize_subregmaps(struct pm88x_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+	struct i2c_client *page;
+	struct regmap *regmap;
+	int err;
+
+	/* LDO page */
+	page = devm_i2c_new_dummy_device(dev, chip->client->adapter,
+				chip->client->addr + PM88X_PAGE_OFFSET_LDO);
+	if (IS_ERR(page)) {
+		err = PTR_ERR(page);
+		dev_err(dev, "Failed to initialize LDO client: %d\n", err);
+		return err;
+	}
+	regmap = devm_regmap_init_i2c(page, &pm88x_i2c_regmap);
+	if (IS_ERR(regmap)) {
+		err = PTR_ERR(regmap);
+		dev_err(dev, "Failed to initialize LDO regmap: %d\n", err);
+		return err;
+	}
+	chip->regmaps[PM88X_REGMAP_LDO] = regmap;
+
+	return 0;
+}
+
+static int pm88x_setup_irq(struct pm88x_chip *chip,
+		struct regmap_irq_chip_data **irq_data)
+{
+	struct regmap *regmap = chip->regmaps[PM88X_REGMAP_BASE];
+	struct device *dev = &chip->client->dev;
+	int err;
+
+	/* Set interrupt clearing mode to clear on write. */
+	err = regmap_update_bits(regmap, PM88X_REG_MISC_CONFIG2,
+			PM88X_INT_INV | PM88X_INT_CLEAR | PM88X_INT_MASK_MODE,
+			PM88X_INT_WC);
+	if (err) {
+		dev_err(dev, "Failed to set interrupt clearing mode: %d\n", err);
+		return err;
+	}
+
+	err = devm_regmap_add_irq_chip(dev, regmap, chip->client->irq,
+					IRQF_ONESHOT, -1, &pm88x_regmap_irq_chip,
+					irq_data);
+	if (err) {
+		dev_err(dev, "Failed to request IRQ: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int pm88x_probe(struct i2c_client *client)
+{
+	struct regmap_irq_chip_data *irq_data;
+	struct device *dev = &client->dev;
+	struct pm88x_chip *chip;
+	struct regmap *regmap;
+	unsigned int chip_id;
+	int err;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->client = client;
+	chip->whoami = (uintptr_t)device_get_match_data(dev);
+	i2c_set_clientdata(client, chip);
+
+	regmap = devm_regmap_init_i2c(client, &pm88x_i2c_regmap);
+	if (IS_ERR(regmap)) {
+		err = PTR_ERR(regmap);
+		return dev_err_probe(dev, err, "Failed to initialize regmap\n");
+	}
+	chip->regmaps[PM88X_REGMAP_BASE] = regmap;
+
+	err = regmap_read(regmap, PM88X_REG_ID, &chip_id);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to read chip ID\n");
+	if (chip->whoami != chip_id)
+		return dev_err_probe(dev, -EINVAL, "Device reported wrong chip ID: %u\n",
+					chip_id);
+
+	err = pm88x_initialize_subregmaps(chip);
+	if (err)
+		return err;
+
+	err = pm88x_setup_irq(chip, &irq_data);
+	if (err)
+		return err;
+
+	err = devm_mfd_add_devices(dev, 0, pm886_devs, ARRAY_SIZE(pm886_devs),
+				NULL, 0, regmap_irq_get_domain(irq_data));
+	if (err)
+		return dev_err_probe(dev, err, "Failed to add devices\n");
+
+	err = devm_register_power_off_handler(dev, pm88x_power_off_handler, chip);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to register power off handler\n");
+
+	device_init_wakeup(dev, device_property_read_bool(dev, "wakeup-source"));
+
+	return 0;
+}
+
+const struct of_device_id pm88x_of_match[] = {
+	{ .compatible = "marvell,88pm886-a1", .data = (void *)PM886_A1_CHIP_ID },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pm88x_of_match);
+
+static struct i2c_driver pm88x_i2c_driver = {
+	.driver = {
+		.name = "88pm88x",
+		.of_match_table = pm88x_of_match,
+	},
+	.probe = pm88x_probe,
+};
+module_i2c_driver(pm88x_i2c_driver);
+
+MODULE_DESCRIPTION("Marvell 88PM88X PMIC driver");
+MODULE_AUTHOR("Karel Balej <balejk@matfyz.cz>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e7a6e45b9fac..93ae5280fc3f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -794,6 +794,18 @@ config MFD_88PM860X
 	  select individual components like voltage regulators, RTC and
 	  battery-charger under the corresponding menus.
 
+config MFD_88PM88X_PMIC
+	bool "Marvell 88PM886 PMIC"
+	depends on I2C=y
+	depends on OF
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	select MFD_CORE
+	help
+	  This enables support for Marvell 88PM886 Power Management IC.
+	  This includes the I2C driver and the core APIs _only_, you have to
+	  select individual components like onkey under the corresponding menus.
+
 config MFD_MAX14577
 	tristate "Maxim Semiconductor MAX14577/77836 MUIC + Charger Support"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index c66f07edcd0e..c4f95a28f589 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
 obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
+obj-$(CONFIG_MFD_88PM88X_PMIC)	+= 88pm88x.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
diff --git a/include/linux/mfd/88pm88x.h b/include/linux/mfd/88pm88x.h
new file mode 100644
index 000000000000..f1eaaecc784e
--- /dev/null
+++ b/include/linux/mfd/88pm88x.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __MFD_88PM88X_H
+#define __MFD_88PM88X_H
+
+#include <linux/mfd/core.h>
+
+#define PM886_A1_CHIP_ID		0xa1
+
+#define PM88X_REG_ID			0x00
+
+#define PM88X_REG_STATUS1		0x01
+#define PM88X_ONKEY_STS1		BIT(0)
+
+#define PM88X_REG_MISC_CONFIG1		0x14
+#define PM88X_SW_PDOWN			BIT(5)
+
+#define PM88X_REG_MISC_CONFIG2		0x15
+#define PM88X_INT_INV			BIT(0)
+#define PM88X_INT_CLEAR			BIT(1)
+#define PM88X_INT_RC			0x00
+#define PM88X_INT_WC			BIT(1)
+#define PM88X_INT_MASK_MODE		BIT(2)
+
+#define PM88X_PAGE_OFFSET_LDO		1
+
+enum pm88x_regulator_id {
+	PM88X_REGULATOR_ID_LDO2,
+	PM88X_REGULATOR_ID_LDO15,
+	PM886_REGULATOR_ID_BUCK2,
+
+	PM88X_REGULATOR_ID_SENTINEL
+};
+
+enum pm88x_regmap_index {
+	PM88X_REGMAP_BASE,
+	PM88X_REGMAP_LDO,
+
+	PM88X_REGMAP_NR
+};
+
+struct pm88x_chip {
+	struct i2c_client *client;
+	unsigned int whoami;
+	struct regmap *regmaps[PM88X_REGMAP_NR];
+};
+#endif /* __MFD_88PM88X_H */
-- 
2.43.0


