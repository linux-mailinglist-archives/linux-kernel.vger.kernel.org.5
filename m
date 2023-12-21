Return-Path: <linux-kernel+bounces-8000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4625A81B06B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED995285A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A9A18B0B;
	Thu, 21 Dec 2023 08:36:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500CE18026;
	Thu, 21 Dec 2023 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 7D66B24E2A5;
	Thu, 21 Dec 2023 16:36:45 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:45 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 21 Dec
 2023 16:36:38 +0800
From: Alex Soo <yuklin.soo@starfivetech.com>
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Hal Feng <hal.feng@starfivetech.com>, "Ley
 Foon Tan" <leyfoon.tan@starfivetech.com>, Jianlong Huang
	<jianlong.huang@starfivetech.com>, Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"Drew Fustini" <drew@beagleboard.org>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alex Soo <yuklin.soo@starfivetech.com>
Subject: [RFC PATCH 2/6] pinctrl: starfive: jh8100: add pinctrl driver for sys_east domain
Date: Thu, 21 Dec 2023 16:36:18 +0800
Message-ID: <20231221083622.3445726-3-yuklin.soo@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add pinctrl driver for sys_east domain.

Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 drivers/pinctrl/starfive/Kconfig              |   21 +
 drivers/pinctrl/starfive/Makefile             |    3 +
 .../pinctrl-starfive-jh8100-sys-east.c        |  326 +++++
 .../starfive/pinctrl-starfive-jh8100.c        | 1090 +++++++++++++++++
 .../starfive/pinctrl-starfive-jh8100.h        |   79 ++
 5 files changed, 1519 insertions(+)
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-=
east.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
 create mode 100644 drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h

diff --git a/drivers/pinctrl/starfive/Kconfig b/drivers/pinctrl/starfive/=
Kconfig
index 8192ac2087fc..afcbf9d4dc8d 100644
--- a/drivers/pinctrl/starfive/Kconfig
+++ b/drivers/pinctrl/starfive/Kconfig
@@ -49,3 +49,24 @@ config PINCTRL_STARFIVE_JH7110_AON
 	  This also provides an interface to the GPIO pins not used by other
 	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
 	  and interrupts on input changes.
+
+config PINCTRL_STARFIVE_JH8100
+	bool
+	select GENERIC_PINCONF
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	select OF_GPIO
+
+config PINCTRL_STARFIVE_JH8100_SYS_EAST
+	tristate "StarFive JH8100 SoC System IOMUX-East pinctrl and GPIO driver=
"
+	depends on ARCH_STARFIVE  || COMPILE_TEST
+	depends on OF
+	select PINCTRL_STARFIVE_JH8100
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support system iomux-east pin control on the StarFive=
 JH8100 SoC.
+	  This also provides an interface to the GPIO pins not used by other
+	  peripherals supporting inputs, outputs, configuring pull-up/pull-down
+	  and interrupts on input changes.
diff --git a/drivers/pinctrl/starfive/Makefile b/drivers/pinctrl/starfive=
/Makefile
index ee0d32d085cb..45698c502b48 100644
--- a/drivers/pinctrl/starfive/Makefile
+++ b/drivers/pinctrl/starfive/Makefile
@@ -5,3 +5,6 @@ obj-$(CONFIG_PINCTRL_STARFIVE_JH7100)	+=3D pinctrl-starfi=
ve-jh7100.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH7110)		+=3D pinctrl-starfive-jh7110.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH7110_SYS)	+=3D pinctrl-starfive-jh7110-s=
ys.o
 obj-$(CONFIG_PINCTRL_STARFIVE_JH7110_AON)	+=3D pinctrl-starfive-jh7110-a=
on.o
+
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100)		+=3D pinctrl-starfive-jh8100.o
+obj-$(CONFIG_PINCTRL_STARFIVE_JH8100_SYS_EAST)	+=3D pinctrl-starfive-jh8=
100-sys-east.o
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-east.c =
b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-east.c
new file mode 100644
index 000000000000..a0585bd18fc8
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100-sys-east.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC sys east controller
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#include <linux/bits.h>
+#include <linux/gpio/driver.h>
+#include <linux/clk.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+#include "../core.h"
+#include "../pinctrl-utils.h"
+#include "../pinmux.h"
+#include "../pinconf.h"
+#include "pinctrl-starfive-jh8100.h"
+
+#define JH8100_SYS_E_NGPIO			48
+#define JH8100_SYS_E_GC_BASE			16
+
+/* registers */
+#define JH8100_SYS_E_DOEN			0x000
+#define JH8100_SYS_E_DOUT			0x030
+#define JH8100_SYS_E_GPI			0x060
+#define JH8100_SYS_E_GPIOIN			0x0f4
+
+#define JH8100_SYS_E_GPIOEN			0x0b8
+#define JH8100_SYS_E_GPIOIS0			0x0bc
+#define JH8100_SYS_E_GPIOIS1			0x0c0
+#define JH8100_SYS_E_GPIOIC0			0x0c4
+#define JH8100_SYS_E_GPIOIC1			0x0c8
+#define JH8100_SYS_E_GPIOIBE0			0x0cc
+#define JH8100_SYS_E_GPIOIBE1			0x0d0
+#define JH8100_SYS_E_GPIOIEV0			0x0d4
+#define JH8100_SYS_E_GPIOIEV1			0x0d8
+#define JH8100_SYS_E_GPIOIE0			0x0dc
+#define JH8100_SYS_E_GPIOIE1			0x0e0
+#define JH8100_SYS_E_GPIORIS0			0x0e4
+#define JH8100_SYS_E_GPIORIS1			0x0e8
+#define JH8100_SYS_E_GPIOMIS0			0x0ec
+#define JH8100_SYS_E_GPIOMIS1			0x0f0
+
+#define JH8100_SYS_E_GPO_PDA_00_47_CFG		0x114
+
+static const struct pinctrl_pin_desc jh8100_sys_e_pins[] =3D {
+	PINCTRL_PIN(PAD_GPIO0_E,	"SYS_E_GPIO0"),
+	PINCTRL_PIN(PAD_GPIO1_E,	"SYS_E_GPIO1"),
+	PINCTRL_PIN(PAD_GPIO2_E,	"SYS_E_GPIO2"),
+	PINCTRL_PIN(PAD_GPIO3_E,	"SYS_E_GPIO3"),
+	PINCTRL_PIN(PAD_GPIO4_E,	"SYS_E_GPIO4"),
+	PINCTRL_PIN(PAD_GPIO5_E,	"SYS_E_GPIO5"),
+	PINCTRL_PIN(PAD_GPIO6_E,	"SYS_E_GPIO6"),
+	PINCTRL_PIN(PAD_GPIO7_E,	"SYS_E_GPIO7"),
+	PINCTRL_PIN(PAD_GPIO8_E,	"SYS_E_GPIO8"),
+	PINCTRL_PIN(PAD_GPIO9_E,	"SYS_E_GPIO9"),
+	PINCTRL_PIN(PAD_GPIO10_E,	"SYS_E_GPIO10"),
+	PINCTRL_PIN(PAD_GPIO11_E,	"SYS_E_GPIO11"),
+	PINCTRL_PIN(PAD_GPIO12_E,	"SYS_E_GPIO12"),
+	PINCTRL_PIN(PAD_GPIO13_E,	"SYS_E_GPIO13"),
+	PINCTRL_PIN(PAD_GPIO14_E,	"SYS_E_GPIO14"),
+	PINCTRL_PIN(PAD_GPIO15_E,	"SYS_E_GPIO15"),
+	PINCTRL_PIN(PAD_GPIO16_E,	"SYS_E_GPIO16"),
+	PINCTRL_PIN(PAD_GPIO17_E,	"SYS_E_GPIO17"),
+	PINCTRL_PIN(PAD_GPIO18_E,	"SYS_E_GPIO18"),
+	PINCTRL_PIN(PAD_GPIO19_E,	"SYS_E_GPIO19"),
+	PINCTRL_PIN(PAD_GPIO20_E,	"SYS_E_GPIO20"),
+	PINCTRL_PIN(PAD_GPIO21_E,	"SYS_E_GPIO21"),
+	PINCTRL_PIN(PAD_GPIO22_E,	"SYS_E_GPIO22"),
+	PINCTRL_PIN(PAD_GPIO23_E,	"SYS_E_GPIO23"),
+	PINCTRL_PIN(PAD_GPIO24_E,	"SYS_E_GPIO24"),
+	PINCTRL_PIN(PAD_GPIO25_E,	"SYS_E_GPIO25"),
+	PINCTRL_PIN(PAD_GPIO26_E,	"SYS_E_GPIO26"),
+	PINCTRL_PIN(PAD_GPIO27_E,	"SYS_E_GPIO27"),
+	PINCTRL_PIN(PAD_GPIO28_E,	"SYS_E_GPIO28"),
+	PINCTRL_PIN(PAD_GPIO29_E,	"SYS_E_GPIO29"),
+	PINCTRL_PIN(PAD_GPIO30_E,	"SYS_E_GPIO30"),
+	PINCTRL_PIN(PAD_GPIO31_E,	"SYS_E_GPIO31"),
+	PINCTRL_PIN(PAD_GPIO32_E,	"SYS_E_GPIO32"),
+	PINCTRL_PIN(PAD_GPIO33_E,	"SYS_E_GPIO33"),
+	PINCTRL_PIN(PAD_GPIO34_E,	"SYS_E_GPIO34"),
+	PINCTRL_PIN(PAD_GPIO35_E,	"SYS_E_GPIO35"),
+	PINCTRL_PIN(PAD_GPIO36_E,	"SYS_E_GPIO36"),
+	PINCTRL_PIN(PAD_GPIO37_E,	"SYS_E_GPIO37"),
+	PINCTRL_PIN(PAD_GPIO38_E,	"SYS_E_GPIO38"),
+	PINCTRL_PIN(PAD_GPIO39_E,	"SYS_E_GPIO39"),
+	PINCTRL_PIN(PAD_GPIO40_E,	"SYS_E_GPIO40"),
+	PINCTRL_PIN(PAD_GPIO41_E,	"SYS_E_GPIO41"),
+	PINCTRL_PIN(PAD_GPIO42_E,	"SYS_E_GPIO42"),
+	PINCTRL_PIN(PAD_GPIO43_E,	"SYS_E_GPIO43"),
+	PINCTRL_PIN(PAD_GPIO44_E,	"SYS_E_GPIO44"),
+	PINCTRL_PIN(PAD_GPIO45_E,	"SYS_E_GPIO45"),
+	PINCTRL_PIN(PAD_GPIO46_E,	"SYS_E_GPIO46"),
+	PINCTRL_PIN(PAD_GPIO47_E,	"SYS_E_GPIO47"),
+};
+
+struct jh8100_sys_e_func_sel {
+	u16 offset;
+	u8 shift;
+	u8 max;
+};
+
+static const struct jh8100_sys_e_func_sel
+	jh8100_sys_e_func_sel[ARRAY_SIZE(jh8100_sys_e_pins)] =3D {
+	[PAD_GPIO20_E]    =3D { 0x1d4,  0, 2 },
+	[PAD_GPIO21_E]    =3D { 0x1d4,  2, 2 },
+	[PAD_GPIO22_E]    =3D { 0x1d4,  4, 2 },
+	[PAD_GPIO23_E]    =3D { 0x1d4,  6, 2 },
+	[PAD_GPIO24_E]    =3D { 0x1d4,  8, 2 },
+	[PAD_GPIO25_E]    =3D { 0x1d4, 10, 2 },
+	[PAD_GPIO26_E]    =3D { 0x1d4, 12, 2 },
+	[PAD_GPIO27_E]    =3D { 0x1d4, 14, 2 },
+	[PAD_GPIO28_E]    =3D { 0x1d4, 16, 2 },
+	[PAD_GPIO29_E]    =3D { 0x1d4, 18, 2 },
+	[PAD_GPIO30_E]    =3D { 0x1d4, 20, 2 },
+	[PAD_GPIO31_E]    =3D { 0x1d4, 22, 2 },
+	[PAD_GPIO32_E]    =3D { 0x1d4, 24, 2 },
+	[PAD_GPIO33_E]    =3D { 0x1d4, 26, 2 },
+	[PAD_GPIO34_E]    =3D { 0x1d4, 28, 2 },
+	[PAD_GPIO35_E]    =3D { 0x1d4, 30, 2 },
+
+	[PAD_GPIO36_E]    =3D { 0x1d8,  0, 2 },
+	[PAD_GPIO37_E]    =3D { 0x1d8,  2, 2 },
+	[PAD_GPIO38_E]    =3D { 0x1d8,  4, 2 },
+	[PAD_GPIO39_E]    =3D { 0x1d8,  6, 2 },
+	[PAD_GPIO40_E]    =3D { 0x1d8,  8, 2 },
+	[PAD_GPIO41_E]    =3D { 0x1d8, 10, 2 },
+	[PAD_GPIO42_E]    =3D { 0x1d8, 12, 2 },
+	[PAD_GPIO43_E]    =3D { 0x1d8, 14, 2 },
+	[PAD_GPIO44_E]    =3D { 0x1d8, 16, 2 },
+	[PAD_GPIO45_E]    =3D { 0x1d8, 18, 2 },
+	[PAD_GPIO46_E]    =3D { 0x1d8, 20, 2 },
+	[PAD_GPIO47_E]    =3D { 0x1d8, 22, 2 },
+};
+
+static void jh8100_sys_e_set_function(struct jh8100_pinctrl *sfp,
+				      unsigned int pin, u32 func)
+{
+	const struct jh8100_sys_e_func_sel *fs =3D &jh8100_sys_e_func_sel[pin];
+	unsigned long flags;
+	void __iomem *reg;
+	u32 mask;
+
+	if (!fs->offset)
+		return;
+
+	if (func > fs->max)
+		return;
+
+	reg =3D sfp->base + fs->offset;
+	func =3D func << fs->shift;
+	mask =3D 0x3U << fs->shift;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	func |=3D readl_relaxed(reg) & ~mask;
+	writel_relaxed(func, reg);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static int jh8100_sys_e_set_one_pin_mux(struct jh8100_pinctrl *sfp,
+					unsigned int pin,
+					unsigned int din, u32 dout,
+					u32 doen, u32 func)
+{
+	if (pin < sfp->gc.ngpio && func =3D=3D 0)
+		jh8100_set_gpiomux(sfp, pin, din, dout, doen);
+
+	if (pin < sfp->gc.ngpio && func =3D=3D 1)
+		jh8100_sys_e_set_function(sfp, pin, func);
+
+	return 0;
+}
+
+static int jh8100_sys_e_get_padcfg_base(struct jh8100_pinctrl *sfp,
+					unsigned int pin)
+{
+	if (pin <=3D PAD_GPIO47_E)
+		return JH8100_SYS_E_GPO_PDA_00_47_CFG;
+	else
+		return -1;
+}
+
+static void jh8100_sys_e_irq_handler(struct irq_desc *desc)
+{
+	struct jh8100_pinctrl *sfp =3D jh8100_from_irq_desc(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	unsigned long mis;
+	unsigned int pin;
+
+	chained_irq_enter(chip, desc);
+
+	mis =3D readl_relaxed(sfp->base + JH8100_SYS_E_GPIOMIS0);
+	for_each_set_bit(pin, &mis, 32)
+		generic_handle_domain_irq(sfp->gc.irq.domain, pin);
+
+	mis =3D readl_relaxed(sfp->base + JH8100_SYS_E_GPIOMIS1);
+	for_each_set_bit(pin, &mis, 16)
+		generic_handle_domain_irq(sfp->gc.irq.domain, pin + 32);
+
+	chained_irq_exit(chip, desc);
+}
+
+static int jh8100_sys_e_init_hw(struct gpio_chip *gc)
+{
+	struct jh8100_pinctrl *sfp =3D container_of(gc,
+			struct jh8100_pinctrl, gc);
+
+	/* mask all GPIO interrupts */
+	writel(0U, sfp->base + JH8100_SYS_E_GPIOIE0);
+	writel(0U, sfp->base + JH8100_SYS_E_GPIOIE1);
+	/* clear edge interrupt flags */
+	writel(0U, sfp->base + JH8100_SYS_E_GPIOIC0);
+	writel(~0U, sfp->base + JH8100_SYS_E_GPIOIC0);
+	writel(0U, sfp->base + JH8100_SYS_E_GPIOIC1);
+	writel(~0U, sfp->base + JH8100_SYS_E_GPIOIC1);
+	/* enable GPIO interrupts */
+	writel(1U, sfp->base + JH8100_SYS_E_GPIOEN);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int jh8100_sys_e_pinctrl_suspend(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp =3D dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i =3D 0; i < JH8100_SYS_EAST_REG_NUM; i++)
+		sfp->jh8100_sys_east_regs[i] =3D readl_relaxed(sfp->base + (i * 4));
+
+	return pinctrl_force_sleep(sfp->pctl);
+}
+
+static int jh8100_sys_e_pinctrl_resume(struct device *dev)
+{
+	struct jh8100_pinctrl *sfp;
+	int i;
+
+	sfp =3D dev_get_drvdata(dev);
+	if (!sfp)
+		return -EINVAL;
+
+	for (i =3D 0; i < JH8100_SYS_EAST_REG_NUM; i++)
+		writel_relaxed(sfp->jh8100_sys_east_regs[i], sfp->base + (i * 4));
+
+	return pinctrl_force_default(sfp->pctl);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(jh8100_sys_e_pinctrl_dev_pm_ops,
+			 jh8100_sys_e_pinctrl_suspend,
+			 jh8100_sys_e_pinctrl_resume);
+
+static const struct jh8100_gpio_irq_reg jh8100_sys_e_irq_reg =3D {
+	.is_reg_base	=3D JH8100_SYS_E_GPIOIS0,
+	.ic_reg_base	=3D JH8100_SYS_E_GPIOIC0,
+	.ibe_reg_base	=3D JH8100_SYS_E_GPIOIBE0,
+	.iev_reg_base	=3D JH8100_SYS_E_GPIOIEV0,
+	.ie_reg_base	=3D JH8100_SYS_E_GPIOIE0,
+	.ris_reg_base	=3D JH8100_SYS_E_GPIORIS0,
+	.mis_reg_base	=3D JH8100_SYS_E_GPIOMIS0,
+};
+
+static const struct jh8100_pinctrl_soc_info jh8100_sys_e_pinctrl_info =3D=
 {
+	.pins				=3D jh8100_sys_e_pins,
+	.npins				=3D ARRAY_SIZE(jh8100_sys_e_pins),
+	.ngpios				=3D JH8100_SYS_E_NGPIO,
+	.gc_base			=3D JH8100_SYS_E_GC_BASE,
+	.dout_reg_base			=3D JH8100_SYS_E_DOUT,
+	.dout_mask			=3D GENMASK(6, 0),
+	.doen_reg_base			=3D JH8100_SYS_E_DOEN,
+	.doen_mask			=3D GENMASK(5, 0),
+	.gpi_reg_base			=3D JH8100_SYS_E_GPI,
+	.gpi_mask			=3D GENMASK(5, 0),
+	.gpioin_reg_base		=3D JH8100_SYS_E_GPIOIN,
+	.irq_reg			=3D &jh8100_sys_e_irq_reg,
+	.jh8100_set_one_pin_mux		=3D jh8100_sys_e_set_one_pin_mux,
+	.jh8100_get_padcfg_base		=3D jh8100_sys_e_get_padcfg_base,
+	.jh8100_gpio_irq_handler	=3D jh8100_sys_e_irq_handler,
+	.jh8100_gpio_init_hw		=3D jh8100_sys_e_init_hw,
+};
+
+static const struct of_device_id jh8100_sys_e_pinctrl_of_match[] =3D {
+	{
+		.compatible =3D "starfive,jh8100-sys-pinctrl-east",
+		.data =3D &jh8100_sys_e_pinctrl_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh8100_sys_e_pinctrl_of_match);
+
+static struct platform_driver jh8100_sys_e_pinctrl_driver =3D {
+	.probe =3D jh8100_pinctrl_probe,
+	.driver =3D {
+		.name =3D "starfive-jh8100-sys-pinctrl-east",
+#ifdef CONFIG_PM_SLEEP
+		.pm =3D &jh8100_sys_e_pinctrl_dev_pm_ops,
+#endif
+		.of_match_table =3D jh8100_sys_e_pinctrl_of_match,
+	},
+};
+module_platform_driver(jh8100_sys_e_pinctrl_driver);
+
+MODULE_DESCRIPTION("Pinctrl driver for the StarFive JH8100 SoC sys east =
controller");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c b/drivers=
/pinctrl/starfive/pinctrl-starfive-jh8100.c
new file mode 100644
index 000000000000..65c2f0ba7315
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.c
@@ -0,0 +1,1090 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/reset.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include <dt-bindings/pinctrl/starfive,jh8100-pinctrl.h>
+
+#include "../core.h"
+#include "../pinctrl-utils.h"
+#include "../pinmux.h"
+#include "../pinconf.h"
+#include "pinctrl-starfive-jh8100.h"
+
+#define pin_to_hwirq(sfp) (((sfp)->wakeup_gpio) - ((sfp)->gc.base))
+
+/* pad control bits */
+#define JH8100_PADCFG_POS	BIT(7)
+#define JH8100_PADCFG_SMT	BIT(6)
+#define JH8100_PADCFG_SLEW	BIT(5)
+#define JH8100_PADCFG_PD	BIT(4)
+#define JH8100_PADCFG_PU	BIT(3)
+#define JH8100_PADCFG_BIAS	(JH8100_PADCFG_PD | JH8100_PADCFG_PU)
+#define JH8100_PADCFG_DS_MASK	GENMASK(2, 1)
+#define JH8100_PADCFG_DS_2MA	(0U << 1)
+#define JH8100_PADCFG_DS_4MA	BIT(1)
+#define JH8100_PADCFG_DS_8MA	(2U << 1)
+#define JH8100_PADCFG_DS_12MA	(3U << 1)
+#define JH8100_PADCFG_IE	BIT(0)
+
+/*
+ * The packed pinmux values from the device tree look like this:
+ *
+ *  | 31 - 24 | 23 - 16 | 15 - 10 |  9 - 8   | 7 - 0 |
+ *  |   din   |  dout   |  doen   | function |  pin  |
+ */
+static unsigned int jh8100_pinmux_din(u32 v)
+{
+	return (v & GENMASK(31, 24)) >> 24;
+}
+
+static u32 jh8100_pinmux_dout(u32 v)
+{
+	return (v & GENMASK(23, 16)) >> 16;
+}
+
+static u32 jh8100_pinmux_doen(u32 v)
+{
+	return (v & GENMASK(15, 10)) >> 10;
+}
+
+static u32 jh8100_pinmux_function(u32 v)
+{
+	return (v & GENMASK(9, 8)) >> 8;
+}
+
+static unsigned int jh8100_pinmux_pin(u32 v)
+{
+	return v & GENMASK(7, 0);
+}
+
+static struct jh8100_pinctrl *jh8100_from_irq_data(struct irq_data *d)
+{
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
+
+	return container_of(gc, struct jh8100_pinctrl, gc);
+}
+
+struct jh8100_pinctrl *jh8100_from_irq_desc(struct irq_desc *desc)
+{
+	struct gpio_chip *gc =3D irq_desc_get_handler_data(desc);
+
+	return container_of(gc, struct jh8100_pinctrl, gc);
+}
+EXPORT_SYMBOL_GPL(jh8100_from_irq_desc);
+
+#ifdef CONFIG_DEBUG_FS
+static void jh8100_pin_dbg_show(struct pinctrl_dev *pctldev,
+				struct seq_file *s, unsigned int pin)
+{
+	struct jh8100_pinctrl *sfp =3D pinctrl_dev_get_drvdata(pctldev);
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+
+	seq_printf(s, "%s", dev_name(pctldev->dev));
+
+	if (pin < sfp->gc.ngpio) {
+		unsigned int offset =3D 4 * (pin / 4);
+		unsigned int shift  =3D 8 * (pin % 4);
+		u32 dout =3D readl_relaxed(sfp->base + info->dout_reg_base + offset);
+		u32 doen =3D readl_relaxed(sfp->base + info->doen_reg_base + offset);
+		u32 gpi =3D readl_relaxed(sfp->base + info->gpi_reg_base + offset);
+
+		dout =3D (dout >> shift) & info->dout_mask;
+		doen =3D (doen >> shift) & info->doen_mask;
+		gpi =3D ((gpi >> shift) - 2) & info->gpi_mask;
+
+		seq_printf(s, " dout=3D%u doen=3D%u din=3D%u", dout, doen, gpi);
+	}
+}
+#else
+#define jh8100_pin_dbg_show NULL
+#endif
+
+static int jh8100_dt_node_to_map(struct pinctrl_dev *pctldev,
+				 struct device_node *np,
+				 struct pinctrl_map **maps,
+				 unsigned int *num_maps)
+{
+	struct jh8100_pinctrl *sfp =3D pinctrl_dev_get_drvdata(pctldev);
+	struct device *dev =3D sfp->gc.parent;
+	struct device_node *child;
+	struct pinctrl_map *map;
+	const char **pgnames;
+	const char *grpname;
+	int ngroups;
+	int nmaps;
+	int ret;
+
+	ngroups =3D 0;
+	for_each_child_of_node(np, child)
+		ngroups +=3D 1;
+	nmaps =3D 2 * ngroups;
+
+	pgnames =3D devm_kcalloc(dev, ngroups, sizeof(*pgnames), GFP_KERNEL);
+	if (!pgnames)
+		return -ENOMEM;
+
+	map =3D kcalloc(nmaps, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	nmaps =3D 0;
+	ngroups =3D 0;
+	mutex_lock(&sfp->mutex);
+	for_each_child_of_node(np, child) {
+		int npins =3D of_property_count_u32_elems(child, "pinmux");
+		int *pins;
+		u32 *pinmux;
+		int i;
+
+		if (npins < 1) {
+			dev_err(dev,
+				"invalid pinctrl group %pOFn.%pOFn: pinmux not set\n",
+				np, child);
+			ret =3D -EINVAL;
+			goto put_child;
+		}
+
+		grpname =3D devm_kasprintf(dev, GFP_KERNEL, "%pOFn.%pOFn", np, child);
+		if (!grpname) {
+			ret =3D -ENOMEM;
+			goto put_child;
+		}
+
+		pgnames[ngroups++] =3D grpname;
+
+		pins =3D devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
+		if (!pins) {
+			ret =3D -ENOMEM;
+			goto put_child;
+		}
+
+		pinmux =3D devm_kcalloc(dev, npins, sizeof(*pinmux), GFP_KERNEL);
+		if (!pinmux) {
+			ret =3D -ENOMEM;
+			goto put_child;
+		}
+
+		ret =3D of_property_read_u32_array(child, "pinmux", pinmux, npins);
+		if (ret)
+			goto put_child;
+
+		for (i =3D 0; i < npins; i++)
+			pins[i] =3D jh8100_pinmux_pin(pinmux[i]);
+
+		map[nmaps].type =3D PIN_MAP_TYPE_MUX_GROUP;
+		map[nmaps].data.mux.function =3D np->name;
+		map[nmaps].data.mux.group =3D grpname;
+		nmaps +=3D 1;
+
+		ret =3D pinctrl_generic_add_group(pctldev, grpname,
+						pins, npins, pinmux);
+		if (ret < 0) {
+			dev_err(dev, "error adding group %s: %d\n", grpname, ret);
+			goto put_child;
+		}
+
+		ret =3D pinconf_generic_parse_dt_config(child, pctldev,
+						      &map[nmaps].data.configs.configs,
+						      &map[nmaps].data.configs.num_configs);
+		if (ret) {
+			dev_err(dev, "error parsing pin config of group %s: %d\n",
+				grpname, ret);
+			goto put_child;
+		}
+
+		/* don't create a map if there are no pinconf settings */
+		if (map[nmaps].data.configs.num_configs =3D=3D 0)
+			continue;
+
+		map[nmaps].type =3D PIN_MAP_TYPE_CONFIGS_GROUP;
+		map[nmaps].data.configs.group_or_pin =3D grpname;
+		nmaps +=3D 1;
+	}
+
+	ret =3D pinmux_generic_add_function(pctldev, np->name,
+					  pgnames, ngroups, NULL);
+	if (ret < 0) {
+		dev_err(dev, "error adding function %s: %d\n", np->name, ret);
+		goto free_map;
+	}
+	mutex_unlock(&sfp->mutex);
+
+	*maps =3D map;
+	*num_maps =3D nmaps;
+	return 0;
+
+put_child:
+	of_node_put(child);
+free_map:
+	pinctrl_utils_free_map(pctldev, map, nmaps);
+	mutex_unlock(&sfp->mutex);
+	return ret;
+}
+
+static const struct pinctrl_ops jh8100_pinctrl_ops =3D {
+	.get_groups_count =3D pinctrl_generic_get_group_count,
+	.get_group_name	  =3D pinctrl_generic_get_group_name,
+	.get_group_pins   =3D pinctrl_generic_get_group_pins,
+	.pin_dbg_show	  =3D jh8100_pin_dbg_show,
+	.dt_node_to_map	  =3D jh8100_dt_node_to_map,
+	.dt_free_map	  =3D pinctrl_utils_free_map,
+};
+
+void jh8100_set_gpiomux(struct jh8100_pinctrl *sfp, unsigned int pin,
+			unsigned int din, u32 dout, u32 doen)
+{
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+
+	unsigned int offset =3D 4 * (pin / 4);
+	unsigned int shift  =3D 8 * (pin % 4);
+	u32 dout_mask =3D info->dout_mask << shift;
+	u32 doen_mask =3D info->doen_mask << shift;
+	u32 ival, imask;
+	u32 tmp;
+	void __iomem *reg_dout;
+	void __iomem *reg_doen;
+	void __iomem *reg_din;
+	unsigned long flags;
+
+	reg_dout =3D sfp->base + info->dout_reg_base + offset;
+	reg_doen =3D sfp->base + info->doen_reg_base + offset;
+	dout <<=3D shift;
+	doen <<=3D shift;
+	if (din !=3D GPI_NONE) {
+		unsigned int ioffset =3D 4 * (din / 4);
+		unsigned int ishift  =3D 8 * (din % 4);
+
+		reg_din =3D sfp->base + info->gpi_reg_base + ioffset;
+		ival =3D (pin + 2) << ishift;
+		imask =3D info->gpi_mask << ishift;
+	} else {
+		reg_din =3D NULL;
+	}
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	dout |=3D readl_relaxed(reg_dout) & ~dout_mask;
+	writel_relaxed(dout, reg_dout);
+	doen |=3D readl_relaxed(reg_doen) & ~doen_mask;
+	writel_relaxed(doen, reg_doen);
+	if (reg_din) {
+		tmp =3D readl_relaxed(reg_din) & ~imask;
+		writel_relaxed(tmp, reg_din);
+		ival |=3D readl_relaxed(reg_din) & ~imask;
+		writel_relaxed(ival, reg_din);
+	}
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+EXPORT_SYMBOL_GPL(jh8100_set_gpiomux);
+
+static int jh8100_set_mux(struct pinctrl_dev *pctldev,
+			  unsigned int fsel, unsigned int gsel)
+{
+	struct jh8100_pinctrl *sfp =3D pinctrl_dev_get_drvdata(pctldev);
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+	const struct group_desc *group;
+	const u32 *pinmux;
+	unsigned int i;
+
+	group =3D pinctrl_generic_get_group(pctldev, gsel);
+	if (!group)
+		return -EINVAL;
+
+	pinmux =3D group->data;
+	if (info->jh8100_set_one_pin_mux)
+		for (i =3D 0; i < group->num_pins; i++) {
+			u32 v =3D pinmux[i];
+
+			info->jh8100_set_one_pin_mux(sfp,
+					jh8100_pinmux_pin(v),
+					jh8100_pinmux_din(v),
+					jh8100_pinmux_dout(v),
+					jh8100_pinmux_doen(v),
+					jh8100_pinmux_function(v));
+		}
+
+	return 0;
+}
+
+static const struct pinmux_ops jh8100_pinmux_ops =3D {
+	.get_functions_count =3D pinmux_generic_get_function_count,
+	.get_function_name   =3D pinmux_generic_get_function_name,
+	.get_function_groups =3D pinmux_generic_get_function_groups,
+	.set_mux	     =3D jh8100_set_mux,
+	.strict		     =3D true,
+};
+
+static const u8 jh8100_drive_strength_mA[4] =3D { 2, 4, 8, 12 };
+
+static u32 jh8100_padcfg_ds_to_mA(u32 padcfg)
+{
+	return jh8100_drive_strength_mA[(padcfg >> 1) & 3U];
+}
+
+static u32 jh8100_padcfg_ds_from_mA(u32 v)
+{
+	int i;
+
+	for (i =3D 0; i < 3; i++) {
+		if (v <=3D jh8100_drive_strength_mA[i])
+			break;
+	}
+	return i << 1;
+}
+
+static void jh8100_padcfg_rmw(struct jh8100_pinctrl *sfp,
+			      unsigned int pin, u32 mask, u32 value)
+{
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+	void __iomem *reg;
+	unsigned long flags;
+	int padcfg_base;
+
+	if (!info->jh8100_get_padcfg_base)
+		return;
+
+	padcfg_base =3D info->jh8100_get_padcfg_base(sfp, pin);
+	if (padcfg_base < 0)
+		return;
+
+	reg =3D sfp->base + padcfg_base + 4 * pin;
+	value &=3D mask;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value |=3D readl_relaxed(reg) & ~mask;
+	writel_relaxed(value, reg);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static int jh8100_pinconf_get(struct pinctrl_dev *pctldev,
+			      unsigned int pin, unsigned long *config)
+{
+	struct jh8100_pinctrl *sfp =3D pinctrl_dev_get_drvdata(pctldev);
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+	int param =3D pinconf_to_config_param(*config);
+	u32 padcfg, arg;
+	bool enabled;
+	int padcfg_base;
+
+	if (!info->jh8100_get_padcfg_base)
+		return 0;
+
+	padcfg_base =3D info->jh8100_get_padcfg_base(sfp, pin);
+	if (padcfg_base < 0)
+		return 0;
+
+	padcfg =3D readl_relaxed(sfp->base + padcfg_base + 4 * pin);
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		enabled =3D !(padcfg & JH8100_PADCFG_BIAS);
+		arg =3D 0;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		enabled =3D padcfg & JH8100_PADCFG_PD;
+		arg =3D 1;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		enabled =3D padcfg & JH8100_PADCFG_PU;
+		arg =3D 1;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		enabled =3D true;
+		arg =3D jh8100_padcfg_ds_to_mA(padcfg);
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		enabled =3D padcfg & JH8100_PADCFG_IE;
+		arg =3D enabled;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		enabled =3D padcfg & JH8100_PADCFG_SMT;
+		arg =3D enabled;
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		enabled =3D true;
+		arg =3D !!(padcfg & JH8100_PADCFG_SLEW);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config =3D pinconf_to_config_packed(param, arg);
+	return enabled ? 0 : -EINVAL;
+}
+
+static int jh8100_pinconf_group_get(struct pinctrl_dev *pctldev,
+				    unsigned int gsel,
+				    unsigned long *config)
+{
+	const struct group_desc *group;
+
+	group =3D pinctrl_generic_get_group(pctldev, gsel);
+	if (!group)
+		return -EINVAL;
+
+	return jh8100_pinconf_get(pctldev, group->pins[0], config);
+}
+
+static int jh8100_pinconf_group_set(struct pinctrl_dev *pctldev,
+				    unsigned int gsel,
+				    unsigned long *configs,
+				    unsigned int num_configs)
+{
+	struct jh8100_pinctrl *sfp =3D pinctrl_dev_get_drvdata(pctldev);
+	const struct group_desc *group;
+	u16 mask, value;
+	int i;
+
+	group =3D pinctrl_generic_get_group(pctldev, gsel);
+	if (!group)
+		return -EINVAL;
+
+	mask =3D 0;
+	value =3D 0;
+	for (i =3D 0; i < num_configs; i++) {
+		int param =3D pinconf_to_config_param(configs[i]);
+		u32 arg =3D pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			mask |=3D JH8100_PADCFG_BIAS;
+			value &=3D ~JH8100_PADCFG_BIAS;
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			if (arg =3D=3D 0)
+				return -ENOTSUPP;
+			mask |=3D JH8100_PADCFG_BIAS;
+			value =3D (value & ~JH8100_PADCFG_BIAS) | JH8100_PADCFG_PD;
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			if (arg =3D=3D 0)
+				return -ENOTSUPP;
+			mask |=3D JH8100_PADCFG_BIAS;
+			value =3D (value & ~JH8100_PADCFG_BIAS) | JH8100_PADCFG_PU;
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			mask |=3D JH8100_PADCFG_DS_MASK;
+			value =3D (value & ~JH8100_PADCFG_DS_MASK) |
+				jh8100_padcfg_ds_from_mA(arg);
+			break;
+		case PIN_CONFIG_INPUT_ENABLE:
+			mask |=3D JH8100_PADCFG_IE;
+			if (arg)
+				value |=3D JH8100_PADCFG_IE;
+			else
+				value &=3D ~JH8100_PADCFG_IE;
+			break;
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			mask |=3D JH8100_PADCFG_SMT;
+			if (arg)
+				value |=3D JH8100_PADCFG_SMT;
+			else
+				value &=3D ~JH8100_PADCFG_SMT;
+			break;
+		case PIN_CONFIG_SLEW_RATE:
+			mask |=3D JH8100_PADCFG_SLEW;
+			if (arg)
+				value |=3D JH8100_PADCFG_SLEW;
+			else
+				value &=3D ~JH8100_PADCFG_SLEW;
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+	}
+
+	for (i =3D 0; i < group->num_pins; i++)
+		jh8100_padcfg_rmw(sfp, group->pins[i], mask, value);
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void jh8100_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+				    struct seq_file *s, unsigned int pin)
+{
+	struct jh8100_pinctrl *sfp =3D pinctrl_dev_get_drvdata(pctldev);
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+	u32 value;
+	int padcfg_base;
+
+	if (!info->jh8100_get_padcfg_base)
+		return;
+
+	padcfg_base =3D info->jh8100_get_padcfg_base(sfp, pin);
+	if (padcfg_base < 0)
+		return;
+
+	value =3D readl_relaxed(sfp->base + padcfg_base + 4 * pin);
+	seq_printf(s, " (0x%02x)", value);
+}
+#else
+#define jh8100_pinconf_dbg_show NULL
+#endif
+
+static const struct pinconf_ops jh8100_pinconf_ops =3D {
+	.pin_config_get		=3D jh8100_pinconf_get,
+	.pin_config_group_get	=3D jh8100_pinconf_group_get,
+	.pin_config_group_set	=3D jh8100_pinconf_group_set,
+	.pin_config_dbg_show	=3D jh8100_pinconf_dbg_show,
+	.is_generic		=3D true,
+};
+
+static int jh8100_gpio_request(struct gpio_chip *gc, unsigned int gpio)
+{
+	return pinctrl_gpio_request(gc, gpio);
+}
+
+static void jh8100_gpio_free(struct gpio_chip *gc, unsigned int gpio)
+{
+	pinctrl_gpio_free(gc, gpio);
+}
+
+static int jh8100_gpio_get_direction(struct gpio_chip *gc,
+				     unsigned int gpio)
+{
+	struct jh8100_pinctrl *sfp =3D container_of(gc,
+			struct jh8100_pinctrl, gc);
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+	unsigned int offset =3D 4 * (gpio / 4);
+	unsigned int shift  =3D 8 * (gpio % 4);
+	u32 doen =3D readl_relaxed(sfp->base + info->doen_reg_base + offset);
+
+	doen =3D (doen >> shift) & info->doen_mask;
+
+	return doen =3D=3D GPOEN_ENABLE ?
+		GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
+static int jh8100_gpio_direction_input(struct gpio_chip *gc,
+				       unsigned int gpio)
+{
+	struct jh8100_pinctrl *sfp =3D container_of(gc,
+			struct jh8100_pinctrl, gc);
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+
+	/* enable input and schmitt trigger */
+	jh8100_padcfg_rmw(sfp, gpio,
+			  JH8100_PADCFG_IE | JH8100_PADCFG_SMT,
+			  JH8100_PADCFG_IE | JH8100_PADCFG_SMT);
+
+	if (info->jh8100_set_one_pin_mux)
+		info->jh8100_set_one_pin_mux(sfp, gpio,
+				GPI_NONE, GPOUT_LOW, GPOEN_DISABLE, 0);
+
+	return 0;
+}
+
+static int jh8100_gpio_direction_output(struct gpio_chip *gc,
+					unsigned int gpio, int value)
+{
+	struct jh8100_pinctrl *sfp =3D container_of(gc,
+			struct jh8100_pinctrl, gc);
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+
+	if (info->jh8100_set_one_pin_mux)
+		info->jh8100_set_one_pin_mux(sfp, gpio,
+				GPI_NONE, value ? GPOUT_HIGH : GPOUT_LOW,
+				GPOEN_ENABLE, 0);
+
+	/* disable input, schmitt trigger and bias */
+	jh8100_padcfg_rmw(sfp, gpio,
+			  JH8100_PADCFG_IE | JH8100_PADCFG_SMT |
+			  JH8100_PADCFG_BIAS, 0);
+	return 0;
+}
+
+static int jh8100_gpio_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct jh8100_pinctrl *sfp =3D container_of(gc,
+			struct jh8100_pinctrl, gc);
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+	void __iomem *reg =3D sfp->base + info->gpioin_reg_base
+			+ 4 * (gpio / 32);
+
+	return !!(readl_relaxed(reg) & BIT(gpio % 32));
+}
+
+static void jh8100_gpio_set(struct gpio_chip *gc,
+			    unsigned int gpio, int value)
+{
+	struct jh8100_pinctrl *sfp =3D container_of(gc,
+			struct jh8100_pinctrl, gc);
+	const struct jh8100_pinctrl_soc_info *info =3D sfp->info;
+	unsigned int offset =3D 4 * (gpio / 4);
+	unsigned int shift  =3D 8 * (gpio % 4);
+	void __iomem *reg_dout =3D sfp->base + info->dout_reg_base + offset;
+	u32 dout =3D (value ? GPOUT_HIGH : GPOUT_LOW) << shift;
+	u32 mask =3D info->dout_mask << shift;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	dout |=3D readl_relaxed(reg_dout) & ~mask;
+	writel_relaxed(dout, reg_dout);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static int jh8100_gpio_set_config(struct gpio_chip *gc,
+				  unsigned int gpio, unsigned long config)
+{
+	struct jh8100_pinctrl *sfp =3D container_of(gc,
+			struct jh8100_pinctrl, gc);
+	u32 arg =3D pinconf_to_config_argument(config);
+	u32 value;
+	u32 mask;
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		mask  =3D JH8100_PADCFG_BIAS;
+		value =3D 0;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (arg =3D=3D 0)
+			return -ENOTSUPP;
+		mask  =3D JH8100_PADCFG_BIAS;
+		value =3D JH8100_PADCFG_PD;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		if (arg =3D=3D 0)
+			return -ENOTSUPP;
+		mask  =3D JH8100_PADCFG_BIAS;
+		value =3D JH8100_PADCFG_PU;
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		return 0;
+	case PIN_CONFIG_INPUT_ENABLE:
+		mask  =3D JH8100_PADCFG_IE;
+		value =3D arg ? JH8100_PADCFG_IE : 0;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		mask  =3D JH8100_PADCFG_SMT;
+		value =3D arg ? JH8100_PADCFG_SMT : 0;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	jh8100_padcfg_rmw(sfp, gpio, mask, value);
+	return 0;
+}
+
+static int jh8100_gpio_add_pin_ranges(struct gpio_chip *gc)
+{
+	struct jh8100_pinctrl *sfp =3D container_of(gc,
+			struct jh8100_pinctrl, gc);
+
+	sfp->gpios.name =3D sfp->gc.label;
+	sfp->gpios.base =3D sfp->gc.base;
+	sfp->gpios.pin_base =3D 0;
+	sfp->gpios.npins =3D sfp->gc.ngpio;
+	sfp->gpios.gc =3D &sfp->gc;
+	pinctrl_add_gpio_range(sfp->pctl, &sfp->gpios);
+	return 0;
+}
+
+static void jh8100_irq_ack(struct irq_data *d)
+{
+	struct jh8100_pinctrl *sfp =3D jh8100_from_irq_data(d);
+	const struct jh8100_gpio_irq_reg *irq_reg =3D sfp->info->irq_reg;
+	irq_hw_number_t gpio =3D irqd_to_hwirq(d);
+	void __iomem *ic =3D sfp->base + irq_reg->ic_reg_base
+		+ 4 * (gpio / 32);
+	u32 mask =3D BIT(gpio % 32);
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value =3D readl_relaxed(ic) & ~mask;
+	writel_relaxed(value, ic);
+	writel_relaxed(value | mask, ic);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh8100_irq_mask(struct irq_data *d)
+{
+	struct jh8100_pinctrl *sfp =3D jh8100_from_irq_data(d);
+	const struct jh8100_gpio_irq_reg *irq_reg =3D sfp->info->irq_reg;
+	irq_hw_number_t gpio =3D irqd_to_hwirq(d);
+	void __iomem *ie =3D sfp->base + irq_reg->ie_reg_base
+		+ 4 * (gpio / 32);
+	u32 mask =3D BIT(gpio % 32);
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value =3D readl_relaxed(ie) & ~mask;
+	writel_relaxed(value, ie);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+
+	gpiochip_disable_irq(&sfp->gc, d->hwirq);
+}
+
+static void jh8100_irq_mask_ack(struct irq_data *d)
+{
+	struct jh8100_pinctrl *sfp =3D jh8100_from_irq_data(d);
+	const struct jh8100_gpio_irq_reg *irq_reg =3D sfp->info->irq_reg;
+	irq_hw_number_t gpio =3D irqd_to_hwirq(d);
+	void __iomem *ie =3D sfp->base + irq_reg->ie_reg_base
+		+ 4 * (gpio / 32);
+	void __iomem *ic =3D sfp->base + irq_reg->ic_reg_base
+		+ 4 * (gpio / 32);
+	u32 mask =3D BIT(gpio % 32);
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value =3D readl_relaxed(ie) & ~mask;
+	writel_relaxed(value, ie);
+
+	value =3D readl_relaxed(ic) & ~mask;
+	writel_relaxed(value, ic);
+	writel_relaxed(value | mask, ic);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static void jh8100_irq_unmask(struct irq_data *d)
+{
+	struct jh8100_pinctrl *sfp =3D jh8100_from_irq_data(d);
+	const struct jh8100_gpio_irq_reg *irq_reg =3D sfp->info->irq_reg;
+	irq_hw_number_t gpio =3D irqd_to_hwirq(d);
+	void __iomem *ie =3D sfp->base + irq_reg->ie_reg_base
+		+ 4 * (gpio / 32);
+	u32 mask =3D BIT(gpio % 32);
+	unsigned long flags;
+	u32 value;
+
+	gpiochip_enable_irq(&sfp->gc, d->hwirq);
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	value =3D readl_relaxed(ie) | mask;
+	writel_relaxed(value, ie);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+}
+
+static int jh8100_irq_set_type(struct irq_data *d, unsigned int trigger)
+{
+	struct jh8100_pinctrl *sfp =3D jh8100_from_irq_data(d);
+	const struct jh8100_gpio_irq_reg *irq_reg =3D sfp->info->irq_reg;
+	irq_hw_number_t gpio =3D irqd_to_hwirq(d);
+	void __iomem *base =3D sfp->base + 4 * (gpio / 32);
+	u32 mask =3D BIT(gpio % 32);
+	u32 irq_type, edge_both, polarity;
+	unsigned long flags;
+
+	switch (trigger) {
+	case IRQ_TYPE_EDGE_RISING:
+		irq_type  =3D mask; /* 1: edge triggered */
+		edge_both =3D 0;    /* 0: single edge */
+		polarity  =3D mask; /* 1: rising edge */
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_type  =3D mask; /* 1: edge triggered */
+		edge_both =3D 0;    /* 0: single edge */
+		polarity  =3D 0;    /* 0: falling edge */
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		irq_type  =3D mask; /* 1: edge triggered */
+		edge_both =3D mask; /* 1: both edges */
+		polarity  =3D 0;    /* 0: ignored */
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_type  =3D 0;    /* 0: level triggered */
+		edge_both =3D 0;    /* 0: ignored */
+		polarity  =3D mask; /* 1: high level */
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_type  =3D 0;    /* 0: level triggered */
+		edge_both =3D 0;    /* 0: ignored */
+		polarity  =3D 0;    /* 0: low level */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (trigger & IRQ_TYPE_EDGE_BOTH)
+		irq_set_handler_locked(d, handle_edge_irq);
+	else
+		irq_set_handler_locked(d, handle_level_irq);
+
+	raw_spin_lock_irqsave(&sfp->lock, flags);
+	irq_type |=3D readl_relaxed(base + irq_reg->is_reg_base) & ~mask;
+	writel_relaxed(irq_type, base + irq_reg->is_reg_base);
+
+	edge_both |=3D readl_relaxed(base + irq_reg->ibe_reg_base) & ~mask;
+	writel_relaxed(edge_both, base + irq_reg->ibe_reg_base);
+
+	polarity |=3D readl_relaxed(base + irq_reg->iev_reg_base) & ~mask;
+	writel_relaxed(polarity, base + irq_reg->iev_reg_base);
+	raw_spin_unlock_irqrestore(&sfp->lock, flags);
+	return 0;
+}
+
+static irqreturn_t jh8100_gpio_wake_irq_handler(int irq, void *data)
+{
+	struct jh8100_pinctrl *sfp =3D data;
+
+	if (!sfp || irq !=3D sfp->wakeup_irq)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static int jh8100_irq_set_wake(struct irq_data *d, unsigned int enable)
+{
+	struct jh8100_pinctrl *sfp =3D jh8100_from_irq_data(d);
+	int ret =3D 0;
+
+	if (enable)
+		ret =3D enable_irq_wake(sfp->wakeup_irq);
+	else
+		ret =3D disable_irq_wake(sfp->wakeup_irq);
+	if (ret)
+		dev_err(sfp->dev, "failed to %s wake-up interrupt\n",
+			enable ? "enable" : "disable");
+
+	return ret;
+}
+
+static struct irq_chip jh8100_irq_chip =3D {
+	.irq_ack      =3D jh8100_irq_ack,
+	.irq_mask     =3D jh8100_irq_mask,
+	.irq_mask_ack =3D jh8100_irq_mask_ack,
+	.irq_unmask   =3D jh8100_irq_unmask,
+	.irq_set_type =3D jh8100_irq_set_type,
+	.irq_set_wake =3D jh8100_irq_set_wake,
+	.flags        =3D IRQCHIP_SET_TYPE_MASKED |
+			IRQCHIP_IMMUTABLE |
+			IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND |
+			IRQCHIP_MASK_ON_SUSPEND |
+			IRQCHIP_SKIP_SET_WAKE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static int jh8100_gpio_irq_setup(struct device *dev, struct jh8100_pinct=
rl *sfp)
+{
+	struct device_node *np =3D dev->of_node;
+	struct irq_desc *desc;
+	irq_hw_number_t hwirq;
+	int i, ret;
+
+	if (!sfp->gc.irq.domain) {
+		sfp->irq_domain =3D irq_domain_add_linear(np, sfp->gc.ngpio,
+							&irq_domain_simple_ops,
+							sfp);
+	} else {
+		sfp->irq_domain =3D sfp->gc.irq.domain;
+	}
+
+	if (!sfp->irq_domain) {
+		dev_err(dev, "Couldn't allocate IRQ domain\n");
+		return -ENXIO;
+	}
+
+	for (i =3D 0; i < sfp->gc.ngpio; i++) {
+		int virq =3D irq_create_mapping(sfp->irq_domain, i);
+
+		irq_set_chip_and_handler(virq, &jh8100_irq_chip,
+					 handle_edge_irq);
+		irq_set_chip_data(virq, &sfp->gc);
+	}
+
+	sfp->wakeup_gpio =3D of_get_named_gpio(np, "wakeup-gpios", 0);
+	hwirq =3D pin_to_hwirq(sfp);
+	sfp->wakeup_irq =3D irq_find_mapping(sfp->irq_domain, hwirq);
+	desc =3D irq_to_desc(sfp->wakeup_irq);
+
+	if (!(desc->status_use_accessors & IRQ_NOREQUEST)) {
+		device_init_wakeup(dev, 1);
+		ret =3D devm_request_threaded_irq(dev, sfp->wakeup_irq, NULL,
+						jh8100_gpio_wake_irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT |
+						IRQF_SHARED,
+						"wakeup-gpio", sfp);
+		if (ret) {
+			dev_err_probe(dev, ret, "unable to request wake IRQ %d\n",
+				      sfp->wakeup_irq);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void jh8100_disable_clock(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+int jh8100_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
+	const struct jh8100_pinctrl_soc_info *info;
+	struct jh8100_pinctrl *sfp;
+	struct pinctrl_desc *jh8100_pinctrl_desc;
+	struct reset_control *rst;
+	struct clk *clk;
+	int ret;
+
+	info =3D of_device_get_match_data(&pdev->dev);
+	if (!info)
+		return -ENODEV;
+
+	if (!info->pins || !info->npins) {
+		dev_err(dev, "wrong pinctrl info\n");
+		return -EINVAL;
+	}
+
+	sfp =3D devm_kzalloc(dev, sizeof(*sfp), GFP_KERNEL);
+	if (!sfp)
+		return -ENOMEM;
+
+	sfp->base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sfp->base))
+		return PTR_ERR(sfp->base);
+
+	clk =3D devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "could not get clock\n");
+
+	rst =3D devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "could not get reset control\n=
");
+
+	ret =3D clk_prepare_enable(clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not enable clock\n");
+
+	ret =3D devm_add_action_or_reset(dev, jh8100_disable_clock, clk);
+	if (ret)
+		return ret;
+
+	/*
+	 * we don't want to assert reset and risk undoing pin muxing for the
+	 * early boot serial console, but let's make sure the reset line is
+	 * deasserted in case someone runs a really minimal bootloader.
+	 */
+	ret =3D reset_control_deassert(rst);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not deassert reset\n");
+
+	jh8100_pinctrl_desc =3D devm_kzalloc(&pdev->dev,
+					   sizeof(*jh8100_pinctrl_desc),
+					   GFP_KERNEL);
+	if (!jh8100_pinctrl_desc)
+		return -ENOMEM;
+
+	jh8100_pinctrl_desc->name =3D dev_name(dev);
+	jh8100_pinctrl_desc->pins =3D info->pins;
+	jh8100_pinctrl_desc->npins =3D info->npins;
+	jh8100_pinctrl_desc->pctlops =3D &jh8100_pinctrl_ops;
+	jh8100_pinctrl_desc->pmxops =3D &jh8100_pinmux_ops;
+	jh8100_pinctrl_desc->confops =3D &jh8100_pinconf_ops;
+	jh8100_pinctrl_desc->owner =3D THIS_MODULE;
+
+	sfp->info =3D info;
+	sfp->dev =3D dev;
+	platform_set_drvdata(pdev, sfp);
+	sfp->gc.parent =3D dev;
+	raw_spin_lock_init(&sfp->lock);
+	mutex_init(&sfp->mutex);
+
+	ret =3D devm_pinctrl_register_and_init(dev,
+					     jh8100_pinctrl_desc,
+					     sfp, &sfp->pctl);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "could not register pinctrl driver\n");
+
+	sfp->gc.label =3D dev_name(dev);
+	sfp->gc.owner =3D THIS_MODULE;
+	sfp->gc.request =3D jh8100_gpio_request;
+	sfp->gc.free =3D jh8100_gpio_free;
+	sfp->gc.get_direction =3D jh8100_gpio_get_direction;
+	sfp->gc.direction_input =3D jh8100_gpio_direction_input;
+	sfp->gc.direction_output =3D jh8100_gpio_direction_output;
+	sfp->gc.get =3D jh8100_gpio_get;
+	sfp->gc.set =3D jh8100_gpio_set;
+	sfp->gc.set_config =3D jh8100_gpio_set_config;
+	sfp->gc.add_pin_ranges =3D jh8100_gpio_add_pin_ranges;
+	sfp->gc.base =3D info->gc_base;
+	sfp->gc.ngpio =3D info->ngpios;
+
+	if (info->irq_reg) {
+		jh8100_irq_chip.name =3D sfp->gc.label;
+		gpio_irq_chip_set_chip(&sfp->gc.irq, &jh8100_irq_chip);
+		sfp->gc.irq.parent_handler =3D info->jh8100_gpio_irq_handler;
+		sfp->gc.irq.num_parents =3D 1;
+		sfp->gc.irq.parents =3D devm_kcalloc(dev, sfp->gc.irq.num_parents,
+						   sizeof(*sfp->gc.irq.parents),
+						   GFP_KERNEL);
+		if (!sfp->gc.irq.parents)
+			return -ENOMEM;
+		sfp->gc.irq.default_type =3D IRQ_TYPE_NONE;
+		sfp->gc.irq.handler =3D handle_bad_irq;
+		sfp->gc.irq.init_hw =3D info->jh8100_gpio_init_hw;
+
+		ret =3D platform_get_irq(pdev, 0);
+		if (ret < 0)
+			return ret;
+		sfp->gc.irq.parents[0] =3D ret;
+	}
+
+	if (sfp->gc.ngpio > 0) {
+		ret =3D devm_gpiochip_add_data(dev, &sfp->gc, sfp);
+		if (ret)
+			return dev_err_probe(dev, ret, "could not register gpiochip\n");
+
+		dev_info(dev, "StarFive GPIO chip registered %d GPIOs\n", sfp->gc.ngpi=
o);
+	}
+
+	if (of_property_read_bool(np, "wakeup-source")) {
+		ret =3D jh8100_gpio_irq_setup(dev, sfp);
+		if (ret) {
+			return dev_err_probe(dev, ret,
+					     "failed to setup gpio irq wake\n");
+		}
+
+		ret =3D dev_pm_set_wake_irq(dev, sfp->wakeup_irq);
+		if (ret) {
+			return dev_err_probe(dev, ret,
+					     "failed to enable gpio irq wake\n");
+		}
+	}
+
+	return pinctrl_enable(sfp->pctl);
+}
+EXPORT_SYMBOL_GPL(jh8100_pinctrl_probe);
+
+MODULE_DESCRIPTION("Pinctrl driver for the StarFive JH8100 SoC");
+MODULE_AUTHOR("Alex Soo <yuklin.soo@starfivetech.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h b/drivers=
/pinctrl/starfive/pinctrl-starfive-jh8100.h
new file mode 100644
index 000000000000..d84b88c0568d
--- /dev/null
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh8100.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Pinctrl / GPIO driver for StarFive JH8100 SoC
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ * Author: Alex Soo <yuklin.soo@starfivetech.com>
+ *
+ */
+
+#ifndef __PINCTRL_STARFIVE_JH8100_H__
+#define __PINCTRL_STARFIVE_JH8100_H__
+
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinmux.h>
+
+#define JH8100_SYS_EAST_REG_NUM		116
+
+struct jh8100_pinctrl {
+	struct device *dev;
+	struct gpio_chip gc;
+	struct pinctrl_gpio_range gpios;
+	raw_spinlock_t lock;
+	void __iomem *base;
+	struct pinctrl_dev *pctl;
+	/* register read/write mutex */
+	struct mutex mutex;
+	const struct jh8100_pinctrl_soc_info *info;
+	unsigned int jh8100_sys_east_regs[JH8100_SYS_EAST_REG_NUM];
+	/* wakeup */
+	int wakeup_gpio;
+	int wakeup_irq;
+	struct irq_domain *irq_domain;
+};
+
+struct jh8100_gpio_irq_reg {
+	unsigned int is_reg_base;
+	unsigned int ic_reg_base;
+	unsigned int ibe_reg_base;
+	unsigned int iev_reg_base;
+	unsigned int ie_reg_base;
+	unsigned int ris_reg_base;
+	unsigned int mis_reg_base;
+};
+
+struct jh8100_pinctrl_soc_info {
+	const struct pinctrl_pin_desc *pins;
+	unsigned int npins;
+	unsigned int ngpios;
+	unsigned int gc_base;
+
+	/* gpio dout/doen/din/gpioinput register */
+	unsigned int dout_reg_base;
+	unsigned int dout_mask;
+	unsigned int doen_reg_base;
+	unsigned int doen_mask;
+	unsigned int gpi_reg_base;
+	unsigned int gpi_mask;
+	unsigned int gpioin_reg_base;
+
+	const struct jh8100_gpio_irq_reg *irq_reg;
+
+	/* generic pinmux */
+	int (*jh8100_set_one_pin_mux)(struct jh8100_pinctrl *sfp,
+				      unsigned int pin,
+				      unsigned int din, u32 dout,
+				      u32 doen, u32 func);
+	/* gpio chip */
+	int (*jh8100_get_padcfg_base)(struct jh8100_pinctrl *sfp,
+				      unsigned int pin);
+	void (*jh8100_gpio_irq_handler)(struct irq_desc *desc);
+	int (*jh8100_gpio_init_hw)(struct gpio_chip *gc);
+};
+
+void jh8100_set_gpiomux(struct jh8100_pinctrl *sfp, unsigned int pin,
+			unsigned int din, u32 dout, u32 doen);
+int jh8100_pinctrl_probe(struct platform_device *pdev);
+struct jh8100_pinctrl *jh8100_from_irq_desc(struct irq_desc *desc);
+
+#endif /* __PINCTRL_STARFIVE_JH8100_H__ */
--=20
2.25.1


