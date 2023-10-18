Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B057CDBAF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjJRMbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjJRMas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:30:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDD898
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507962561adso8038675e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632241; x=1698237041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEUVAsPtwnmLvhw1Y51lsQbwAkx/EjllgFx3Z+rz+RI=;
        b=CU5LBsS8mbzbGCf3rVRlQDsOMjiTTutQ9EjAbquLPNzgMgUdZI90Pjok3nkCDg0qWE
         AwkYlblmOTQiGhZIMlNgZ9lg1iBMh/+V/ATxW+WQxDqq+JRIddkgyalj3WAEpjK9iUbO
         WZRhJEJeLENYgXQM/aKYBsuWccUGaB9PoZJWimR8um+QnSiUI2aF6zUeLsCiCnI9sCPt
         2rTNVwKvGuXcanyLLFwFXNpxTJLdNppg1ll6ccWvsfakqodQKTAZXgXEYVoKhKGd4DnS
         a/gJnh9AlJIITOaNyiMzVOiAt+EW3jqiQSrALR7p8B5KLau3vrQIJFy+05Wtvvs+ZltV
         dBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632241; x=1698237041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEUVAsPtwnmLvhw1Y51lsQbwAkx/EjllgFx3Z+rz+RI=;
        b=ubWaUX5LvZ08vWJ0U1PV+ibmJU8UqmgVPdrGQl+75yRwOHsX4YRd5AKyc4/gH8jBTY
         RBQ2cXnmZf18TypkvxDOzRHxDDT2FesJ7MtgRJjwEDbDqX1cCDh17Lqz8dvBPixTcHyA
         v8HKjRxDTd0yGp0+lHPK7iQ5V2feCbNjsfGS5fcMknLQVx3PHI2fQeTTPal7TW6sKUoT
         r9MYhiTG167Zog7THu2zhPh4fdn3IUXV+LCtK337RWegCtm6qvkZjaCD28qcV2U1NJf3
         tJaDJmC7GGc65NaUOoDv+iCj9sPE26dqqywqYAfP0vXUcJPMSX8uib7kvIb1bGoGyZa/
         6ZUQ==
X-Gm-Message-State: AOJu0YwavVrkXNgRxuVGofXU2ubRjxSKoYmS5nRTQt+P/P/OTLcQvjbE
        mtLdmFZFkta0zdGyGyvX6nQeKvmqwFs=
X-Google-Smtp-Source: AGHT+IEnTa1XTEyy3VnO7B/n5CEk08CXyRKtHDmlW6Oc/7nqE2sRbFWUHK+VnFDJ+uWFNTIuEo9tIw==
X-Received: by 2002:ac2:4c4b:0:b0:500:cb2b:8678 with SMTP id o11-20020ac24c4b000000b00500cb2b8678mr5006824lfk.40.1697632241271;
        Wed, 18 Oct 2023 05:30:41 -0700 (PDT)
Received: from debian.localdomain (mm-47-218-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.218.47])
        by smtp.googlemail.com with ESMTPSA id t8-20020ac243a8000000b005009b4d5c14sm679565lfl.265.2023.10.18.05.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:30:40 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 2/6] regulator: s2dos05: add Samsung s2dos05 driver
Date:   Wed, 18 Oct 2023 15:30:29 +0300
Message-Id: <20231018123033.301005-3-dsankouski@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018123033.301005-1-dsankouski@gmail.com>
References: <20231018123033.301005-1-dsankouski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for s2dos05 regulator.
The s2dos05 is a companion power management IC for the smart phones,
and provides LDOs[1~4] and BUCKs[1].

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---

 drivers/regulator/Kconfig         |   8 +
 drivers/regulator/Makefile        |   1 +
 drivers/regulator/s2dos05.c       | 601 ++++++++++++++++++++++++++++++
 include/linux/regulator/s2dos05.h | 173 +++++++++
 4 files changed, 783 insertions(+)
 create mode 100644 drivers/regulator/s2dos05.c
 create mode 100644 include/linux/regulator/s2dos05.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 823f8e6e4801..ec18439edc6a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1232,6 +1232,14 @@ config REGULATOR_RTQ6752
 	  synchronous boost converters for PAVDD, and one synchronous NAVDD
 	  buck-boost. This device is suitable for automotive TFT-LCD panel.
 
+config REGULATOR_S2DOS05
+	tristate "SLSI S2DOS05 regulator"
+	depends on I2C
+	help
+	  This driver provides support for the voltage regulators of the S2DOS05.
+	  The S2DOS05 is a companion power management IC for the smart phones.
+	  The S2DOS05 handles LDO and BUCK control
+
 config REGULATOR_S2MPA01
 	tristate "Samsung S2MPA01 voltage regulator"
 	depends on MFD_SEC_CORE || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 15e0d614ff66..b59f729b7af7 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -145,6 +145,7 @@ obj-$(CONFIG_REGULATOR_RT6245)	+= rt6245-regulator.o
 obj-$(CONFIG_REGULATOR_RTMV20)	+= rtmv20-regulator.o
 obj-$(CONFIG_REGULATOR_RTQ2134) += rtq2134-regulator.o
 obj-$(CONFIG_REGULATOR_RTQ6752)	+= rtq6752-regulator.o
+obj-$(CONFIG_REGULATOR_S2DOS05) += s2dos05.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
diff --git a/drivers/regulator/s2dos05.c b/drivers/regulator/s2dos05.c
new file mode 100644
index 000000000000..01b8b9834289
--- /dev/null
+++ b/drivers/regulator/s2dos05.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * s2dos05.c - Regulator driver for the Samsung s2dos05
+ *
+ * Copyright (C) 2016 Samsung Electronics
+ * Copyright (C) 2023 Dzmitry Sankouski <dsankouski@gmail.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/bug.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/of_gpio.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/s2dos05.h>
+#include <linux/i2c.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/debugfs.h>
+
+struct s2dos05_data {
+	struct s2dos05_dev *iodev;
+	int num_regulators;
+	struct regulator_dev *rdev[S2DOS05_REGULATOR_MAX];
+	int opmode[S2DOS05_REGULATOR_MAX];
+};
+
+int s2dos05_read_reg(struct i2c_client *i2c, u8 reg, u8 *dest)
+{
+	struct s2dos05_dev *s2dos05 = i2c_get_clientdata(i2c);
+	int ret;
+
+	mutex_lock(&s2dos05->i2c_lock);
+	ret = i2c_smbus_read_byte_data(i2c, reg);
+	mutex_unlock(&s2dos05->i2c_lock);
+	if (ret < 0) {
+		pr_info("%s:%s reg(0x%x), ret(%d)\n",
+			 MFD_DEV_NAME, __func__, reg, ret);
+		return ret;
+	}
+
+	ret &= 0xff;
+	*dest = ret;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(s2dos05_read_reg);
+
+int s2dos05_write_reg(struct i2c_client *i2c, u8 reg, u8 value)
+{
+	struct s2dos05_dev *s2dos05 = i2c_get_clientdata(i2c);
+	int ret;
+
+	mutex_lock(&s2dos05->i2c_lock);
+	ret = i2c_smbus_write_byte_data(i2c, reg, value);
+	mutex_unlock(&s2dos05->i2c_lock);
+	if (ret < 0)
+		pr_info("%s:%s reg(0x%x), ret(%d)\n",
+				MFD_DEV_NAME, __func__, reg, ret);
+
+	return ret;
+}
+
+int s2dos05_update_reg(struct i2c_client *i2c, u8 reg, u8 val, u8 mask)
+{
+	struct s2dos05_dev *s2dos05 = i2c_get_clientdata(i2c);
+	int ret;
+	u8 old_val, new_val;
+
+	mutex_lock(&s2dos05->i2c_lock);
+	ret = i2c_smbus_read_byte_data(i2c, reg);
+	if (ret >= 0) {
+		old_val = ret & 0xff;
+		new_val = (val & mask) | (old_val & (~mask));
+		ret = i2c_smbus_write_byte_data(i2c, reg, new_val);
+	}
+	mutex_unlock(&s2dos05->i2c_lock);
+	return ret;
+}
+
+int s2dos05_bulk_read(struct i2c_client *i2c, u8 reg, int count, u8 *buf)
+{
+	struct s2dos05_dev *s2dos05 = i2c_get_clientdata(i2c);
+	int ret;
+
+	mutex_lock(&s2dos05->i2c_lock);
+	ret = i2c_smbus_read_i2c_block_data(i2c, reg, count, buf);
+	mutex_unlock(&s2dos05->i2c_lock);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+int s2dos05_read_word(struct i2c_client *i2c, u8 reg)
+{
+	struct s2dos05_dev *s2dos05 = i2c_get_clientdata(i2c);
+	int ret;
+
+	mutex_lock(&s2dos05->i2c_lock);
+	ret = i2c_smbus_read_word_data(i2c, reg);
+	mutex_unlock(&s2dos05->i2c_lock);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+int s2dos05_bulk_write(struct i2c_client *i2c, u8 reg, int count, u8 *buf)
+{
+	struct s2dos05_dev *s2dos05 = i2c_get_clientdata(i2c);
+	int ret;
+
+	mutex_lock(&s2dos05->i2c_lock);
+	ret = i2c_smbus_write_i2c_block_data(i2c, reg, count, buf);
+	mutex_unlock(&s2dos05->i2c_lock);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int s2dos05_regdump_show(struct seq_file *s, void *unused)
+{
+	struct s2dos05_dev *s2dos05_dev = s->private;
+	u8 i, val = 0;
+
+	for (i = S2DOS05_REG_STAT; i <= S2DOS05_REG_IRQ; i++) {
+		s2dos05_read_reg(s2dos05_dev->i2c, i, &val);
+		seq_printf(s, "0x%x: 0x%x\n", i, val);
+	}
+
+	return 0;
+}
+
+static int s2dos05_regdump_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, s2dos05_regdump_show, inode->i_private);
+}
+
+static const struct file_operations s2dos05_regdump_operations = {
+	.open           = s2dos05_regdump_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+static void s2dos05_debugfs_init(struct s2dos05_dev *s2dos05)
+{
+	debugfs_create_file("s2dos05_regdump", 0440,
+			NULL, s2dos05, &s2dos05_regdump_operations);
+}
+#endif
+
+static int s2m_enable(struct regulator_dev *rdev)
+{
+	struct s2dos05_data *info = rdev_get_drvdata(rdev);
+	struct i2c_client *i2c = info->iodev->i2c;
+
+	return s2dos05_update_reg(i2c, rdev->desc->enable_reg,
+				  info->opmode[rdev_get_id(rdev)],
+					rdev->desc->enable_mask);
+}
+
+static int s2m_disable_regmap(struct regulator_dev *rdev)
+{
+	struct s2dos05_data *info = rdev_get_drvdata(rdev);
+	struct i2c_client *i2c = info->iodev->i2c;
+	u8 val;
+
+	if (rdev->desc->enable_is_inverted)
+		val = rdev->desc->enable_mask;
+	else
+		val = 0;
+
+	return s2dos05_update_reg(i2c, rdev->desc->enable_reg,
+				   val, rdev->desc->enable_mask);
+}
+
+static int s2m_is_enabled_regmap(struct regulator_dev *rdev)
+{
+	struct s2dos05_data *info = rdev_get_drvdata(rdev);
+	struct i2c_client *i2c = info->iodev->i2c;
+	int ret;
+	u8 val;
+
+	ret = s2dos05_read_reg(i2c, rdev->desc->enable_reg, &val);
+	if (ret < 0)
+		return ret;
+
+	if (rdev->desc->enable_is_inverted)
+		return (val & rdev->desc->enable_mask) == 0;
+	else
+		return (val & rdev->desc->enable_mask) != 0;
+}
+
+static int s2m_get_voltage_sel_regmap(struct regulator_dev *rdev)
+{
+	struct s2dos05_data *info = rdev_get_drvdata(rdev);
+	struct i2c_client *i2c = info->iodev->i2c;
+	int ret;
+	u8 val;
+
+	ret = s2dos05_read_reg(i2c, rdev->desc->vsel_reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= rdev->desc->vsel_mask;
+
+	return val;
+}
+
+static int s2m_set_voltage_sel_regmap(struct regulator_dev *rdev,
+					unsigned int sel)
+{
+	struct s2dos05_data *info = rdev_get_drvdata(rdev);
+	struct i2c_client *i2c = info->iodev->i2c;
+	int ret;
+
+	ret = s2dos05_update_reg(i2c, rdev->desc->vsel_reg,
+				sel, rdev->desc->vsel_mask);
+	if (ret < 0)
+		goto out;
+
+	if (rdev->desc->apply_bit)
+		ret = s2dos05_update_reg(i2c, rdev->desc->apply_reg,
+					 rdev->desc->apply_bit,
+					 rdev->desc->apply_bit);
+	return ret;
+out:
+	pr_warn("%s: failed to set voltage_sel_regmap\n", rdev->desc->name);
+	return ret;
+}
+
+static int s2m_set_voltage_sel_regmap_buck(struct regulator_dev *rdev,
+					unsigned int sel)
+{
+	struct s2dos05_data *info = rdev_get_drvdata(rdev);
+	struct i2c_client *i2c = info->iodev->i2c;
+	int ret;
+
+	ret = s2dos05_write_reg(i2c, rdev->desc->vsel_reg, sel);
+	if (ret < 0)
+		goto out;
+
+	if (rdev->desc->apply_bit)
+		ret = s2dos05_update_reg(i2c, rdev->desc->apply_reg,
+					 rdev->desc->apply_bit,
+					 rdev->desc->apply_bit);
+	return ret;
+out:
+	pr_warn("%s: failed to set voltage_sel_regmap\n", rdev->desc->name);
+	return ret;
+}
+
+static int s2m_set_voltage_time_sel(struct regulator_dev *rdev,
+				   unsigned int old_selector,
+				   unsigned int new_selector)
+{
+	int old_volt, new_volt;
+
+	/* sanity check */
+	if (!rdev->desc->ops->list_voltage)
+		return -EINVAL;
+
+	old_volt = rdev->desc->ops->list_voltage(rdev, old_selector);
+	new_volt = rdev->desc->ops->list_voltage(rdev, new_selector);
+
+	if (old_selector < new_selector)
+		return DIV_ROUND_UP(new_volt - old_volt, S2DOS05_RAMP_DELAY);
+
+	return 0;
+}
+
+static int s2m_set_active_discharge(struct regulator_dev *rdev,
+					bool enable)
+{
+	struct s2dos05_data *info = rdev_get_drvdata(rdev);
+	struct i2c_client *i2c = info->iodev->i2c;
+	int ret;
+	u8 val;
+
+	if (enable)
+		val = rdev->desc->active_discharge_on;
+	else
+		val = rdev->desc->active_discharge_off;
+
+	ret = s2dos05_update_reg(i2c, rdev->desc->active_discharge_reg,
+				val, rdev->desc->active_discharge_mask);
+	return ret;
+}
+
+static const struct regulator_ops s2dos05_ldo_ops = {
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.is_enabled		= s2m_is_enabled_regmap,
+	.enable			= s2m_enable,
+	.disable		= s2m_disable_regmap,
+	.get_voltage_sel	= s2m_get_voltage_sel_regmap,
+	.set_voltage_sel	= s2m_set_voltage_sel_regmap,
+	.set_voltage_time_sel	= s2m_set_voltage_time_sel,
+	.set_active_discharge	= s2m_set_active_discharge,
+};
+
+static const struct regulator_ops s2dos05_buck_ops = {
+	.list_voltage		= regulator_list_voltage_linear,
+	.map_voltage		= regulator_map_voltage_linear,
+	.is_enabled		= s2m_is_enabled_regmap,
+	.enable			= s2m_enable,
+	.disable		= s2m_disable_regmap,
+	.get_voltage_sel	= s2m_get_voltage_sel_regmap,
+	.set_voltage_sel	= s2m_set_voltage_sel_regmap_buck,
+	.set_voltage_time_sel	= s2m_set_voltage_time_sel,
+	.set_active_discharge	= s2m_set_active_discharge,
+};
+
+#define _BUCK(macro)	S2DOS05_BUCK##macro
+#define _buck_ops(num)	s2dos05_buck_ops##num
+
+#define _LDO(macro)	S2DOS05_LDO##macro
+#define _REG(ctrl)	S2DOS05_REG##ctrl
+#define _ldo_ops(num)	s2dos05_ldo_ops##num
+#define _MASK(macro)	S2DOS05_ENABLE_MASK##macro
+#define _TIME(macro)	S2DOS05_ENABLE_TIME##macro
+
+#define BUCK_DESC(_name, _id, _ops, m, s, v, e, em, t, a) {	\
+	.name		= _name,				\
+	.id		= _id,					\
+	.ops		= _ops,					\
+	.type		= REGULATOR_VOLTAGE,			\
+	.owner		= THIS_MODULE,				\
+	.min_uV		= m,					\
+	.uV_step	= s,					\
+	.n_voltages	= S2DOS05_BUCK_N_VOLTAGES,		\
+	.vsel_reg	= v,					\
+	.vsel_mask	= S2DOS05_BUCK_VSEL_MASK,		\
+	.enable_reg	= e,					\
+	.enable_mask	= em,					\
+	.enable_time	= t,					\
+	.active_discharge_off = 0,				\
+	.active_discharge_on = S2DOS05_BUCK_FD_MASK,		\
+	.active_discharge_reg	= a,				\
+	.active_discharge_mask	= S2DOS05_BUCK_FD_MASK		\
+}
+
+#define LDO_DESC(_name, _id, _ops, m, s, v, e, em, t, a) {	\
+	.name		= _name,				\
+	.id		= _id,					\
+	.ops		= _ops,					\
+	.type		= REGULATOR_VOLTAGE,			\
+	.owner		= THIS_MODULE,				\
+	.min_uV		= m,					\
+	.uV_step	= s,					\
+	.n_voltages	= S2DOS05_LDO_N_VOLTAGES,		\
+	.vsel_reg	= v,					\
+	.vsel_mask	= S2DOS05_LDO_VSEL_MASK,		\
+	.enable_reg	= e,					\
+	.enable_mask	= em,					\
+	.enable_time	= t,					\
+	.active_discharge_off = 0,				\
+	.active_discharge_on = S2DOS05_LDO_FD_MASK,		\
+	.active_discharge_reg	= a,				\
+	.active_discharge_mask	= S2DOS05_LDO_FD_MASK		\
+}
+
+static struct regulator_desc regulators[S2DOS05_REGULATOR_MAX] = {
+		/* name, id, ops, min_uv, uV_step, vsel_reg, enable_reg */
+		LDO_DESC("s2dos05-ldo1", _LDO(1), &_ldo_ops(), _LDO(_MIN1),
+			_LDO(_STEP1), _REG(_LDO1_CFG),
+			_REG(_EN), _MASK(_L1), _TIME(_LDO), _REG(_LDO1_CFG)),
+		LDO_DESC("s2dos05-ldo2", _LDO(2), &_ldo_ops(), _LDO(_MIN1),
+			_LDO(_STEP1), _REG(_LDO2_CFG),
+			_REG(_EN), _MASK(_L2), _TIME(_LDO), _REG(_LDO2_CFG)),
+		LDO_DESC("s2dos05-ldo3", _LDO(3), &_ldo_ops(), _LDO(_MIN2),
+			_LDO(_STEP1), _REG(_LDO3_CFG),
+			_REG(_EN), _MASK(_L3), _TIME(_LDO), _REG(_LDO3_CFG)),
+		LDO_DESC("s2dos05-ldo4", _LDO(4), &_ldo_ops(), _LDO(_MIN2),
+			_LDO(_STEP1), _REG(_LDO4_CFG),
+			_REG(_EN), _MASK(_L4), _TIME(_LDO), _REG(_LDO4_CFG)),
+		BUCK_DESC("s2dos05-buck1", _BUCK(1), &_buck_ops(), _BUCK(_MIN1),
+			_BUCK(_STEP1), _REG(_BUCK_VOUT),
+			_REG(_EN), _MASK(_B1), _TIME(_BUCK), _REG(_BUCK_CFG)),
+};
+
+#ifdef CONFIG_OF
+static int s2dos05_pmic_dt_parse_pdata(struct device *dev,
+					struct s2dos05_platform_data *pdata)
+{
+	struct device_node *pmic_np, *regulators_np, *reg_np;
+	struct s2dos05_regulator_data *rdata;
+	unsigned int i;
+
+	pmic_np = dev->of_node;
+	if (!pmic_np) {
+		dev_err(dev, "could not find pmic sub-node\n");
+		return -ENODEV;
+	}
+
+	pdata->dp_irq = of_get_named_gpio(pmic_np, "s2dos05,s2dos05_int", 0);
+	if (pdata->dp_irq < 0)
+		pr_err("%s error reading s2dos05_irq = %d\n",
+			__func__, pdata->dp_irq);
+
+	pdata->wakeup = of_property_read_bool(pmic_np, "s2dos05,wakeup");
+
+	regulators_np = of_find_node_by_name(pmic_np, "regulators");
+	if (!regulators_np) {
+		dev_err(dev, "could not find regulators sub-node\n");
+		return -EINVAL;
+	}
+
+	/* count the number of regulators to be supported in pmic */
+	pdata->num_regulators = 0;
+	for_each_child_of_node(regulators_np, reg_np) {
+		pdata->num_regulators++;
+	}
+
+	rdata = devm_kzalloc(dev, sizeof(*rdata) *
+				pdata->num_regulators, GFP_KERNEL);
+	if (!rdata)
+		return -ENOMEM;
+
+	pdata->regulators = rdata;
+	for_each_child_of_node(regulators_np, reg_np) {
+		for (i = 0; i < ARRAY_SIZE(regulators); i++)
+			if (!of_node_cmp(reg_np->name,
+					regulators[i].name))
+				break;
+
+		if (i == ARRAY_SIZE(regulators)) {
+			dev_warn(dev,
+			"don't know how to configure regulator %s\n",
+			reg_np->name);
+			continue;
+		}
+
+		rdata->id = i;
+		rdata->initdata = of_get_regulator_init_data(
+						dev, reg_np,
+						&regulators[i]);
+		rdata->reg_node = reg_np;
+		rdata++;
+	}
+	of_node_put(regulators_np);
+
+	return 0;
+}
+#else
+static int s2dos05_pmic_dt_parse_pdata(struct s2dos05_dev *iodev,
+					struct s2dos05_platform_data *pdata)
+{
+	return 0;
+}
+#endif /* CONFIG_OF */
+
+static int s2dos05_pmic_probe(struct i2c_client *i2c)
+{
+	struct s2dos05_dev *iodev;
+	struct device *dev = &i2c->dev;
+	struct s2dos05_platform_data *pdata = i2c->dev.platform_data;
+	struct regulator_config config = { };
+	struct s2dos05_data *s2dos05;
+	int i;
+	int ret = 0;
+
+	pr_info("%s:%s\n", MFD_DEV_NAME, __func__);
+
+	iodev = kzalloc(sizeof(struct s2dos05_dev), GFP_KERNEL);
+	if (!iodev)
+		return -ENOMEM;
+
+	if (i2c->dev.of_node) {
+		pdata = devm_kzalloc(&i2c->dev,
+			sizeof(struct s2dos05_platform_data), GFP_KERNEL);
+		if (!pdata) {
+			ret = -ENOMEM;
+			goto err_pdata;
+		}
+		ret = s2dos05_pmic_dt_parse_pdata(&i2c->dev, pdata);
+		if (ret < 0) {
+			dev_err(&i2c->dev, "Failed to get device of_node\n");
+			goto err_dt;
+		}
+
+		i2c->dev.platform_data = pdata;
+	} else
+		pdata = i2c->dev.platform_data;
+
+	iodev->dev = &i2c->dev;
+	iodev->i2c = i2c;
+
+	if (pdata) {
+		iodev->pdata = pdata;
+		iodev->wakeup = pdata->wakeup;
+	} else {
+		ret = -EINVAL;
+		goto err_dt;
+	}
+	mutex_init(&iodev->i2c_lock);
+	i2c_set_clientdata(i2c, iodev);
+
+	s2dos05 = devm_kzalloc(&i2c->dev, sizeof(struct s2dos05_data),
+				GFP_KERNEL);
+	if (!s2dos05) {
+		ret = -EINVAL;
+		goto err_data;
+	}
+
+	s2dos05->iodev = iodev;
+	s2dos05->num_regulators = pdata->num_regulators;
+
+	for (i = 0; i < pdata->num_regulators; i++) {
+		int id = pdata->regulators[i].id;
+
+		config.dev = &i2c->dev;
+		config.init_data = pdata->regulators[i].initdata;
+		config.driver_data = s2dos05;
+		config.of_node = pdata->regulators[i].reg_node;
+		s2dos05->opmode[id] = regulators[id].enable_mask;
+		s2dos05->rdev[i] = regulator_register(dev, &regulators[id], &config);
+		if (IS_ERR(s2dos05->rdev[i])) {
+			ret = PTR_ERR(s2dos05->rdev[i]);
+			dev_err(&i2c->dev, "regulator init failed for %d\n",
+				id);
+			s2dos05->rdev[i] = NULL;
+			goto err_rdata;
+		}
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	s2dos05_debugfs_init(iodev);
+#endif
+
+	return ret;
+
+err_rdata:
+	pr_info("[%s:%d] err:\n", __FILE__, __LINE__);
+	for (i = 0; i < s2dos05->num_regulators; i++)
+		if (s2dos05->rdev[i])
+			regulator_unregister(s2dos05->rdev[i]);
+err_data:
+	mutex_destroy(&iodev->i2c_lock);
+	devm_kfree(&i2c->dev, (void *)s2dos05);
+err_dt:
+	devm_kfree(&i2c->dev, (void *)pdata);
+err_pdata:
+	kfree(iodev);
+
+	return ret;
+}
+
+static void s2dos05_pmic_remove(struct i2c_client *i2c)
+{
+	struct s2dos05_data *s2dos05 = i2c_get_clientdata(i2c);
+	int i;
+
+	for (i = 0; i < s2dos05->num_regulators; i++)
+		if (s2dos05->rdev[i])
+			regulator_unregister(s2dos05->rdev[i]);
+}
+
+#if defined(CONFIG_OF)
+static const struct of_device_id s2dos05_i2c_dt_ids[] = {
+	{ .compatible = "samsung,s2dos05" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, s2dos05_i2c_dt_ids);
+#endif /* CONFIG_OF */
+
+#if defined(CONFIG_OF)
+static const struct i2c_device_id s2dos05_pmic_id[] = {
+	{"s2dos05", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, s2dos05_pmic_id);
+#endif /* CONFIG_OF */
+
+static struct i2c_driver s2dos05_i2c_driver = {
+	.driver = {
+		.name = "s2dos05",
+#if defined(CONFIG_OF)
+		.of_match_table	= s2dos05_i2c_dt_ids,
+#endif /* CONFIG_OF */
+		.suppress_bind_attrs = true,
+	},
+	.probe = s2dos05_pmic_probe,
+	.remove = s2dos05_pmic_remove,
+	.id_table = s2dos05_pmic_id,
+};
+module_i2c_driver(s2dos05_i2c_driver);
+
+MODULE_DESCRIPTION("SAMSUNG s2dos05 Regulator Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/s2dos05.h b/include/linux/regulator/s2dos05.h
new file mode 100644
index 000000000000..e33e86257589
--- /dev/null
+++ b/include/linux/regulator/s2dos05.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ * s2dos05.h
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd
+ *              http://www.samsung.com
+ *
+ */
+
+#ifndef __LINUX_MFD_S2DOS05_H
+#define __LINUX_MFD_S2DOS05_H
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MFD_DEV_NAME "s2dos05"
+
+/**
+ * sec_regulator_data - regulator data
+ * @id: regulator id
+ * @initdata: regulator init data (constraints, supplies, ...)
+ */
+
+struct s2dos05_dev {
+	struct device *dev;
+	struct i2c_client *i2c; /* 0xB2; PMIC, Flash LED */
+	struct mutex i2c_lock;
+
+	int type;
+	u8 rev_num; /* pmic Rev */
+	bool wakeup;
+	int dp_irq;
+	int adc_mode;
+	int adc_sync_mode;
+	u8 adc_en_val;
+
+	struct s2dos05_platform_data *pdata;
+};
+
+struct s2dos05_regulator_data {
+	int id;
+	struct regulator_init_data *initdata;
+	struct device_node *reg_node;
+};
+
+struct s2dos05_platform_data {
+	bool wakeup;
+	int num_regulators;
+	struct	s2dos05_regulator_data *regulators;
+	int	device_type;
+	int dp_irq;
+
+	/* adc_mode
+	 * 0 : not use
+	 * 1 : current meter
+	 * 2 : power meter
+	 */
+	int adc_mode;
+	/* 1 : sync mode, 2 : async mode  */
+	int adc_sync_mode;
+};
+
+struct s2dos05 {
+	struct regmap *regmap;
+};
+
+/* S2DOS05 registers */
+/* Slave Addr : 0xC0 */
+enum S2DOS05_reg {
+	S2DOS05_REG_DEV_ID,
+	S2DOS05_REG_TOPSYS_STAT,
+	S2DOS05_REG_STAT,
+	S2DOS05_REG_EN,
+	S2DOS05_REG_LDO1_CFG,
+	S2DOS05_REG_LDO2_CFG,
+	S2DOS05_REG_LDO3_CFG,
+	S2DOS05_REG_LDO4_CFG,
+	S2DOS05_REG_BUCK_CFG,
+	S2DOS05_REG_BUCK_VOUT,
+	S2DOS05_REG_IRQ_MASK = 0x0D,
+	S2DOS05_REG_SSD_TSD = 0x0E,
+	S2DOS05_REG_OCL = 0x10,
+	S2DOS05_REG_IRQ = 0x11
+};
+
+/* S2DOS05 regulator ids */
+enum S2DOS05_regulators {
+	S2DOS05_LDO1,
+	S2DOS05_LDO2,
+	S2DOS05_LDO3,
+	S2DOS05_LDO4,
+	S2DOS05_BUCK1,
+	S2DOS05_REG_MAX,
+};
+
+#define S2DOS05_IRQ_PWRMT_MASK	(1 << 5)
+#define S2DOS05_IRQ_TSD_MASK	(1 << 4)
+#define S2DOS05_IRQ_SSD_MASK	(1 << 3)
+#define S2DOS05_IRQ_SCP_MASK	(1 << 2)
+#define S2DOS05_IRQ_UVLO_MASK	(1 << 1)
+#define S2DOS05_IRQ_OCD_MASK	(1 << 0)
+
+#define S2DOS05_BUCK_MIN1	506250
+#define S2DOS05_LDO_MIN1	1500000
+#define S2DOS05_LDO_MIN2	2700000
+#define S2DOS05_BUCK_STEP1	6250
+#define S2DOS05_LDO_STEP1	25000
+#define S2DOS05_LDO_VSEL_MASK	0x7F
+#define S2DOS05_LDO_FD_MASK	0x80
+#define S2DOS05_BUCK_VSEL_MASK	0xFF
+#define S2DOS05_BUCK_FD_MASK	0x08
+
+#define S2DOS05_ENABLE_MASK_L1	(1 << 0)
+#define S2DOS05_ENABLE_MASK_L2	(1 << 1)
+#define S2DOS05_ENABLE_MASK_L3	(1 << 2)
+#define S2DOS05_ENABLE_MASK_L4	(1 << 3)
+#define S2DOS05_ENABLE_MASK_B1	(1 << 4)
+
+#define S2DOS05_RAMP_DELAY	12000
+
+#define S2DOS05_ENABLE_TIME_LDO		50
+#define S2DOS05_ENABLE_TIME_BUCK	350
+
+#define S2DOS05_ENABLE_SHIFT	0x06
+#define S2DOS05_LDO_N_VOLTAGES	(S2DOS05_LDO_VSEL_MASK + 1)
+#define S2DOS05_BUCK_N_VOLTAGES (S2DOS05_BUCK_VSEL_MASK + 1)
+
+#define S2DOS05_PMIC_EN_SHIFT	6
+#define S2DOS05_REGULATOR_MAX (S2DOS05_REG_MAX)
+
+/* ----------power meter ----------*/
+#define S2DOS05_REG_PWRMT_CTRL1		0x0A
+#define S2DOS05_REG_PWRMT_CTRL2		0x0B
+#define S2DOS05_REG_PWRMT_DATA	0x0C
+#define S2DOS05_REG_IRQ_MASK	0x0D
+
+#define CURRENT_ELVDD			2450
+#define CURRENT_ELVSS			2450
+#define CURRENT_AVDD		612
+#define CURRENT_BUCK			1220
+#define CURRENT_L1			2000
+#define CURRENT_L2			2000
+#define CURRENT_L3			2000
+#define CURRENT_L4			2000
+
+#define POWER_ELVDD			24500
+#define POWER_ELVSS			24500
+#define POWER_AVDD			3060
+#define POWER_BUCK			1525
+#define POWER_L1			5000
+#define POWER_L2			5000
+#define POWER_L3			5000
+#define POWER_L4			5000
+
+#define ADC_EN_MASK			0x80
+#define ADC_ASYNCRD_MASK		0x80
+#define ADC_PTR_MASK			0x0F
+#define ADC_PGEN_MASK			0x30
+#define CURRENT_MODE			0x00
+#define POWER_MODE			0x10
+#define RAWCURRENT_MODE			0x20
+#define SMPNUM_MASK			0x0F
+
+#define S2DOS05_MAX_ADC_CHANNEL		8
+
+void s2dos05_powermeter_init(struct s2dos05_dev *s2dos05);
+void s2dos05_powermeter_deinit(struct s2dos05_dev *s2dos05);
+
+/* S2DOS05 shared i2c API function */
+int s2dos05_read_reg(struct i2c_client *i2c, u8 reg, u8 *dest);
+int s2dos05_write_reg(struct i2c_client *i2c, u8 reg, u8 value);
+int s2dos05_update_reg(struct i2c_client *i2c, u8 reg, u8 val, u8 mask);
+
+
+#endif /*  __LINUX_MFD_S2DOS05_H */
-- 
2.39.2

