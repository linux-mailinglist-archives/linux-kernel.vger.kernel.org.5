Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D097E3819
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjKGJra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjKGJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:47:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682F412A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:47:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso3696413f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699350442; x=1699955242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlFOVM9fmHgxYdsR/iT5nCqkwntrJthVaR9AFbkgPJA=;
        b=PTrlZD5EJkdkxtZ6L1tNpg/bIu+s9K4qCpIqyfvRQy16ZFuM3+OIE4KcF2ckN2MOfl
         A3I4rObwmUMXb2AXjujUlT+fPK10D/lPy9VxxMcU1e0qshYEg5BKQdbbZcOupFAy342w
         I9Kb8TfoCSfRYGHLBMjmca2T33RWre/AxQfZ3oO0QTeBmqwvHMCfqbkUa4Z7R0So7ewH
         Oh8/2ZCyF5oQymlRgk7NxusHwX89zfhyyX4d4oFwqjw2BbLyrOzUPllo4+Rin7CyC1CA
         M3N6EhrxREOjD8T9/cPCZeZJEpWLU5YOFjkeaSbhjnXWqUO0GfJ2O4F6w3XEq0hUTXrN
         60ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350442; x=1699955242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlFOVM9fmHgxYdsR/iT5nCqkwntrJthVaR9AFbkgPJA=;
        b=Tna+hYxUCPM7oOEfjz1U3IKipUpEKj3T9/n57VnkgBIvwv3K0O2DJXvFOMouueTRRs
         +ZRRN5m544cke7Ws1SNmiDaSaEjV0werKOLbM32eyhqFR7B4VwOnos7/sKvKQUemamyd
         edBWzabHkENkyIwU44D5yflfyfIkG11CIujEk6UPpNue3kGEj+CuymQB24Vp5xeZFqqx
         DzYO37VXeiJassJ9dDDvE7mwgiVt/47W/dJSOX3kbrKUWSliLP/MJ5IJ0izBj5W6R/Oh
         GdgzHco3Pf8M+ZMFgM0vKFB6Qftdf0CHHAKGVgtDLMD3X5Y24k35LX8COl4XFjFlNdnJ
         sl9g==
X-Gm-Message-State: AOJu0Yw6Y3zqjoo2No5/bkrQIcIX4A1R2znGWK+kJP8mixsxId9Xwc3M
        dlQmKdZmF8cigeePKXXfbB+xSw==
X-Google-Smtp-Source: AGHT+IEls0DJ9OiROVEfjXT5c5kUsuqa2R/To5TjNSpC/MsgdyXJwwfmPwnsK+StfxCOzYusdQHLuA==
X-Received: by 2002:a05:6000:180e:b0:32d:b906:40a7 with SMTP id m14-20020a056000180e00b0032db90640a7mr23397402wrh.1.1699350441538;
        Tue, 07 Nov 2023 01:47:21 -0800 (PST)
Received: from localhost.localdomain (abordeaux-655-1-152-60.w90-5.abo.wanadoo.fr. [90.5.9.60])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d4bd2000000b0032fb46812c2sm1879723wrt.12.2023.11.07.01.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:47:21 -0800 (PST)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org
Cc:     andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, eblanc@baylibre.com, u-kumar1@ti.com
Subject: [PATCH v9] pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs
Date:   Tue,  7 Nov 2023 10:47:20 +0100
Message-Id: <20231107094720.2223541-1-eblanc@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI TPS6594 PMIC has 11 GPIOs which can be used
for different functions.

This patch adds a pinctrl and GPIO drivers in
order to use those functions.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Notes:
    This patch was picked in V7 from a series since there is no dependency between
    the two patches.
    
    Changes since v8:
    https://lore.kernel.org/lkml/20231102101357.977886-1-eblanc@baylibre.com/
    - Add missing GENERIC_PINCONF Kconfig dependency.
    - Drop MODULE_ALIAS in favoir of ID table as requested by Krzysztof Kozlowski.
    The 2 Reviewed-by tags were kept as this new version does not change the
    driver inner working.
    
    Changes since v7:
    https://lore.kernel.org/lkml/20230628133021.500477-1-eblanc@baylibre.com/
    - Fix indentation of a macro
    - Remove useless return after a switch case
    
    Here is the old cover-letter:
    TPS6594 is a Power Management IC which provides regulators and others
    features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
    PFSM (Pre-configurable Finite State Machine). The SoC and the PMIC can
    communicate through the I2C or SPI interfaces.
    TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
    
    This series adds support to TI TPS6594 PMIC and its derivatives.
    
    This should be applied on top of other patch series:
    - https://lore.kernel.org/all/20230511095126.105104-1-jpanis@baylibre.com/
      For core MFD driver. The necessary part of this patch series is already
      applied in linux-next.
    
    The features implemented in this series are:
    - RTC (child device)
    - Pinmux/GPIO (child device)
    - Regulator (child device)
    
    RTC description:
    The TPS6594 family has an RTC built-in, except for LP8764.
    It provides time and an alarm.
    
    Pinmux/GPIO:
    TPS6594 family has 11 GPIOs. Those GPIO can also serve different
    functions such as I2C or SPI interface, watchdog disable functions.
    The driver provides both pinmuxing for the functions and GPIO capability.
    
    Regulator:
    TPS6594/TPS6593: 5 BUCKs and 4LDOs
    LP8764: 4 BUCKs and no LDO
    Bucks can be used in multipahse mode.
    
    Regulators were applied to linux-next by Mark Brown on 06/06/2023 so this
    patch has been dropped from the patch series.
    There were some pending comments from Andy Shevchenko so a follow up patch will
    be sent later.
    
    Changes since v1:
    https://lore.kernel.org/all/20230224133129.887203-1-eblanc@baylibre.com/
    Rtc:
    - Removed struct tps6594_rtc.
    - Removed some dev_err messages.
    - Removed some comments.
    - Remove some whitespaces in comments and error messages.
    - Check if RTC is running before reading a timestamp in read_rtc.
    - Stop RTC at the end of probe to wait for a timestamp to be set.
    - Add default MFD_TPS6594 to Kconfig.
    
    Pinctrl:
    - Removed #define DEBUG.
    - Add default MFD_TPS6594 to Kconfig.
    - Fix typo and reword help message of Kconfig.
    
    Regulators:
    Further to Mark Brown review:
    - File header whole block C++ style.
    - Configuring modes not supported: omit all mode operations
    - Log the error before notifying.
    - Request the interrupts while registering the regulators (then remove
      the lookup function).
    Further to Matti review:
    - Postponed: devm_regulator_irq_helper() and
      regulator_irq_map_event_simple() can probably be used but code.
      refactoring is not so trivial. This can be done later as an enhancement
      after this patch list is merged.
    Buck Multi phase management:
    - Multiphase property can take an array when 2 multi phase buck, buck12
      and buck34.
    - Configuration multi phase buck34 without multiphase buck12 is not
      supported (when only one multiphase, must be buck12). Not clear from the
      spec but confirmed by TI.
    - Supported multiphase conficurations: buck12, buck123, buck1234,
      buck12 + buck34.
    - All interrupts are attached to the multiphase buck (ie: for regulator
      buck12, buck1 & buck2 interrupts are registered).
    
    Changes since v2:
    https://lore.kernel.org/all/20230328091448.648452-1-eblanc@baylibre.com/
    Rtc:
    - Add logic to avoid reinitializing a working clock.
    - Fix some multiline comments format.
    
    Regulators:
    Further to Mark Brown review:
    - Log the error before notifying.
    - Request the interrupts while registering the regulators.
    Further to Krzysztof Kozlowski:
    https://lore.kernel.org/all/75f0a18d-aed9-8610-2925-4e604b4b0241@baylibre.com/
    - Remove ti, multi-phase-id property which is redundant with buck dts naming
      rules.
    
    Changes since v3:
    https://lore.kernel.org/lkml/20230414101217.1342891-1-eblanc@baylibre.com/
    RTC:
    - Add wakeup source
    
    Pinctrl:
    - Switch to GPIO_REGMAP framework
    
    Change since v4:
    https://lore.kernel.org/lkml/20230512141755.1712358-1-eblanc@baylibre.com/
    Update Copyright notice date
    Reorder includes
    
    RTC:
    - Rework some comments, fixing punctuation and style
    - Use NANO macro from units.h for PPB_MULT
    - Rework to use bitwise types
    - Remove unnecessary casts
    - Add SAFETY comments
    - Use `dev_err_probe(...)` instead of print then return
    
    Pinctrl:
    - Reword help message and add module name in Kconfig
    - Rework code to use struct pinfunction and PINCTRL_PINFUNCTION() macro
    - Remove unnecessary casts
    - Use `dev_err_probe(...)` instead of print then return
    - Replace TPS6594_REG_GPIO1_CONF with a comment for TPS6594_REG_GPIOX_CONF
    
    Regulators:
    - nits: Add missing tabs, standard spaces, group "buck_multi".
    - Use OF dedicated of_node_cmp API instead of standard strcmp.
    - Use devm_kmalloc_array(...) API instead of devm_kmalloc(...) wherever
      possible.
    - return dev_err_probe(...) wherever possible.
    
    Changes since v5:
    https://lore.kernel.org/lkml/20230522163115.2592883-1-eblanc@baylibre.com/
    
    Pinctrl:
    - Rework code for clarity
    - Rework macro to fix checkpatch macro argument reuse
    - Coding style fixes
    - Reword some comments
    
    Rtc:
    - Grammar fixes
    - Removed unused macros
    - Use type MIN/MAX macro instead of magic numbers
    - Fix return code in calibration
    - Use cpu_to_le16 and le16_to_cpu APIs instead of casting.
    - Reintroduce mdelay before reading BIT_RUN as otherwise both AM62 and J784S4
      will report a -ENODEV on a working RTC.
    
    Changes since v6:
    https://lore.kernel.org/all/20230612125248.1235581-1-eblanc@baylibre.com/
    
    Pinctrl:
    - Remove a comment

 drivers/pinctrl/Kconfig           |  16 ++
 drivers/pinctrl/Makefile          |   1 +
 drivers/pinctrl/pinctrl-tps6594.c | 373 ++++++++++++++++++++++++++++++
 3 files changed, 390 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 7dfb7190580e..8ca997f2a2f9 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -469,6 +469,22 @@ config PINCTRL_TB10X
 	depends on OF && ARC_PLAT_TB10X
 	select GPIOLIB
 
+config PINCTRL_TPS6594
+	tristate "Pinctrl and GPIO driver for TI TPS6594 PMIC"
+	depends on MFD_TPS6594
+	default MFD_TPS6594
+	select PINMUX
+	select GPIOLIB
+	select REGMAP
+	select GPIO_REGMAP
+	select GENERIC_PINCONF
+	help
+	  Say Y to select the pinmuxing and GPIOs driver for the TPS6594
+	  PMICs chip family.
+
+	  This driver can also be built as a module
+	  called tps6594-pinctrl.
+
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
 	depends on ARCH_ZYNQ
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index dd6cda270294..4d37be622b85 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
+obj-$(CONFIG_PINCTRL_TPS6594)	+= pinctrl-tps6594.o
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-tps6594.c
new file mode 100644
index 000000000000..66985e54b74a
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-tps6594.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinmux and GPIO driver for tps6594 PMIC
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/module.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+
+#include <linux/mfd/tps6594.h>
+
+#define TPS6594_PINCTRL_PINS_NB 11
+
+#define TPS6594_PINCTRL_GPIO_FUNCTION 0
+#define TPS6594_PINCTRL_SCL_I2C2_CS_SPI_FUNCTION 1
+#define TPS6594_PINCTRL_TRIG_WDOG_FUNCTION 1
+#define TPS6594_PINCTRL_CLK32KOUT_FUNCTION 1
+#define TPS6594_PINCTRL_SCLK_SPMI_FUNCTION 1
+#define TPS6594_PINCTRL_SDATA_SPMI_FUNCTION 1
+#define TPS6594_PINCTRL_NERR_MCU_FUNCTION 1
+#define TPS6594_PINCTRL_PDOG_FUNCTION 1
+#define TPS6594_PINCTRL_SYNCCLKIN_FUNCTION 1
+#define TPS6594_PINCTRL_NRSTOUT_SOC_FUNCTION 2
+#define TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION 2
+#define TPS6594_PINCTRL_SDA_I2C2_SDO_SPI_FUNCTION 2
+#define TPS6594_PINCTRL_NERR_SOC_FUNCTION 2
+#define TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION 3
+#define TPS6594_PINCTRL_NSLEEP1_FUNCTION 4
+#define TPS6594_PINCTRL_NSLEEP2_FUNCTION 5
+#define TPS6594_PINCTRL_WKUP1_FUNCTION 6
+#define TPS6594_PINCTRL_WKUP2_FUNCTION 7
+
+/* Special muxval for recalcitrant pins */
+#define TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION_GPIO8 2
+#define TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION_GPIO8 3
+#define TPS6594_PINCTRL_CLK32KOUT_FUNCTION_GPIO9 3
+
+#define TPS6594_OFFSET_GPIO_SEL 5
+
+#define FUNCTION(fname, v)									\
+{											\
+	.pinfunction = PINCTRL_PINFUNCTION(#fname,					\
+					tps6594_##fname##_func_group_names,		\
+					ARRAY_SIZE(tps6594_##fname##_func_group_names)),\
+	.muxval = v,									\
+}
+
+static const struct pinctrl_pin_desc tps6594_pins[TPS6594_PINCTRL_PINS_NB] = {
+	PINCTRL_PIN(0, "GPIO0"),   PINCTRL_PIN(1, "GPIO1"),
+	PINCTRL_PIN(2, "GPIO2"),   PINCTRL_PIN(3, "GPIO3"),
+	PINCTRL_PIN(4, "GPIO4"),   PINCTRL_PIN(5, "GPIO5"),
+	PINCTRL_PIN(6, "GPIO6"),   PINCTRL_PIN(7, "GPIO7"),
+	PINCTRL_PIN(8, "GPIO8"),   PINCTRL_PIN(9, "GPIO9"),
+	PINCTRL_PIN(10, "GPIO10"),
+};
+
+static const char *const tps6594_gpio_func_group_names[] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
+};
+
+static const char *const tps6594_nsleep1_func_group_names[] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
+};
+
+static const char *const tps6594_nsleep2_func_group_names[] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
+};
+
+static const char *const tps6594_wkup1_func_group_names[] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
+};
+
+static const char *const tps6594_wkup2_func_group_names[] = {
+	"GPIO0", "GPIO1", "GPIO2", "GPIO3", "GPIO4", "GPIO5",
+	"GPIO6", "GPIO7", "GPIO8", "GPIO9", "GPIO10",
+};
+
+static const char *const tps6594_scl_i2c2_cs_spi_func_group_names[] = {
+	"GPIO0",
+	"GPIO1",
+};
+
+static const char *const tps6594_nrstout_soc_func_group_names[] = {
+	"GPIO0",
+	"GPIO10",
+};
+
+static const char *const tps6594_trig_wdog_func_group_names[] = {
+	"GPIO1",
+	"GPIO10",
+};
+
+static const char *const tps6594_sda_i2c2_sdo_spi_func_group_names[] = {
+	"GPIO1",
+};
+
+static const char *const tps6594_clk32kout_func_group_names[] = {
+	"GPIO2",
+	"GPIO3",
+	"GPIO7",
+};
+
+static const char *const tps6594_nerr_soc_func_group_names[] = {
+	"GPIO2",
+};
+
+static const char *const tps6594_sclk_spmi_func_group_names[] = {
+	"GPIO4",
+};
+
+static const char *const tps6594_sdata_spmi_func_group_names[] = {
+	"GPIO5",
+};
+
+static const char *const tps6594_nerr_mcu_func_group_names[] = {
+	"GPIO6",
+};
+
+static const char *const tps6594_syncclkout_func_group_names[] = {
+	"GPIO7",
+	"GPIO9",
+};
+
+static const char *const tps6594_disable_wdog_func_group_names[] = {
+	"GPIO7",
+	"GPIO8",
+};
+
+static const char *const tps6594_pdog_func_group_names[] = {
+	"GPIO8",
+};
+
+static const char *const tps6594_syncclkin_func_group_names[] = {
+	"GPIO9",
+};
+
+struct tps6594_pinctrl_function {
+	struct pinfunction pinfunction;
+	u8 muxval;
+};
+
+static const struct tps6594_pinctrl_function pinctrl_functions[] = {
+	FUNCTION(gpio, TPS6594_PINCTRL_GPIO_FUNCTION),
+	FUNCTION(nsleep1, TPS6594_PINCTRL_NSLEEP1_FUNCTION),
+	FUNCTION(nsleep2, TPS6594_PINCTRL_NSLEEP2_FUNCTION),
+	FUNCTION(wkup1, TPS6594_PINCTRL_WKUP1_FUNCTION),
+	FUNCTION(wkup2, TPS6594_PINCTRL_WKUP2_FUNCTION),
+	FUNCTION(scl_i2c2_cs_spi, TPS6594_PINCTRL_SCL_I2C2_CS_SPI_FUNCTION),
+	FUNCTION(nrstout_soc, TPS6594_PINCTRL_NRSTOUT_SOC_FUNCTION),
+	FUNCTION(trig_wdog, TPS6594_PINCTRL_TRIG_WDOG_FUNCTION),
+	FUNCTION(sda_i2c2_sdo_spi, TPS6594_PINCTRL_SDA_I2C2_SDO_SPI_FUNCTION),
+	FUNCTION(clk32kout, TPS6594_PINCTRL_CLK32KOUT_FUNCTION),
+	FUNCTION(nerr_soc, TPS6594_PINCTRL_NERR_SOC_FUNCTION),
+	FUNCTION(sclk_spmi, TPS6594_PINCTRL_SCLK_SPMI_FUNCTION),
+	FUNCTION(sdata_spmi, TPS6594_PINCTRL_SDATA_SPMI_FUNCTION),
+	FUNCTION(nerr_mcu, TPS6594_PINCTRL_NERR_MCU_FUNCTION),
+	FUNCTION(syncclkout, TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION),
+	FUNCTION(disable_wdog, TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION),
+	FUNCTION(pdog, TPS6594_PINCTRL_PDOG_FUNCTION),
+	FUNCTION(syncclkin, TPS6594_PINCTRL_SYNCCLKIN_FUNCTION),
+};
+
+struct tps6594_pinctrl {
+	struct tps6594 *tps;
+	struct gpio_regmap *gpio_regmap;
+	struct pinctrl_dev *pctl_dev;
+	const struct tps6594_pinctrl_function *funcs;
+	const struct pinctrl_pin_desc *pins;
+};
+
+static int tps6594_gpio_regmap_xlate(struct gpio_regmap *gpio,
+				     unsigned int base, unsigned int offset,
+				     unsigned int *reg, unsigned int *mask)
+{
+	unsigned int line = offset % 8;
+	unsigned int stride = offset / 8;
+
+	switch (base) {
+	case TPS6594_REG_GPIOX_CONF(0):
+		*reg = TPS6594_REG_GPIOX_CONF(offset);
+		*mask = TPS6594_BIT_GPIO_DIR;
+		return 0;
+	case TPS6594_REG_GPIO_IN_1:
+	case TPS6594_REG_GPIO_OUT_1:
+		*reg = base + stride;
+		*mask = BIT(line);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tps6594_pmx_func_cnt(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(pinctrl_functions);
+}
+
+static const char *tps6594_pmx_func_name(struct pinctrl_dev *pctldev,
+					 unsigned int selector)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl->funcs[selector].pinfunction.name;
+}
+
+static int tps6594_pmx_func_groups(struct pinctrl_dev *pctldev,
+				   unsigned int selector,
+				   const char *const **groups,
+				   unsigned int *num_groups)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pinctrl->funcs[selector].pinfunction.groups;
+	*num_groups = pinctrl->funcs[selector].pinfunction.ngroups;
+
+	return 0;
+}
+
+static int tps6594_pmx_set(struct tps6594_pinctrl *pinctrl, unsigned int pin,
+			   u8 muxval)
+{
+	u8 mux_sel_val = muxval << TPS6594_OFFSET_GPIO_SEL;
+
+	return regmap_update_bits(pinctrl->tps->regmap,
+				  TPS6594_REG_GPIOX_CONF(pin),
+				  TPS6594_MASK_GPIO_SEL, mux_sel_val);
+}
+
+static int tps6594_pmx_set_mux(struct pinctrl_dev *pctldev,
+			       unsigned int function, unsigned int group)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+	u8 muxval = pinctrl->funcs[function].muxval;
+
+	/* Some pins don't have the same muxval for the same function... */
+	if (group == 8) {
+		if (muxval == TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION)
+			muxval = TPS6594_PINCTRL_DISABLE_WDOG_FUNCTION_GPIO8;
+		else if (muxval == TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION)
+			muxval = TPS6594_PINCTRL_SYNCCLKOUT_FUNCTION_GPIO8;
+	} else if (group == 9) {
+		if (muxval == TPS6594_PINCTRL_CLK32KOUT_FUNCTION)
+			muxval = TPS6594_PINCTRL_CLK32KOUT_FUNCTION_GPIO9;
+	}
+
+	return tps6594_pmx_set(pinctrl, group, muxval);
+}
+
+static int tps6594_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+					  struct pinctrl_gpio_range *range,
+					  unsigned int offset, bool input)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+	u8 muxval = pinctrl->funcs[TPS6594_PINCTRL_GPIO_FUNCTION].muxval;
+
+	return tps6594_pmx_set(pinctrl, offset, muxval);
+}
+
+static const struct pinmux_ops tps6594_pmx_ops = {
+	.get_functions_count = tps6594_pmx_func_cnt,
+	.get_function_name = tps6594_pmx_func_name,
+	.get_function_groups = tps6594_pmx_func_groups,
+	.set_mux = tps6594_pmx_set_mux,
+	.gpio_set_direction = tps6594_pmx_gpio_set_direction,
+	.strict = true,
+};
+
+static int tps6594_groups_cnt(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(tps6594_pins);
+}
+
+static int tps6594_group_pins(struct pinctrl_dev *pctldev,
+			      unsigned int selector, const unsigned int **pins,
+			      unsigned int *num_pins)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = &pinctrl->pins[selector].number;
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const char *tps6594_group_name(struct pinctrl_dev *pctldev,
+				      unsigned int selector)
+{
+	struct tps6594_pinctrl *pinctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pinctrl->pins[selector].name;
+}
+
+static const struct pinctrl_ops tps6594_pctrl_ops = {
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_group,
+	.dt_free_map = pinconf_generic_dt_free_map,
+	.get_groups_count = tps6594_groups_cnt,
+	.get_group_name = tps6594_group_name,
+	.get_group_pins = tps6594_group_pins,
+};
+
+static int tps6594_pinctrl_probe(struct platform_device *pdev)
+{
+	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct tps6594_pinctrl *pinctrl;
+	struct pinctrl_desc *pctrl_desc;
+	struct gpio_regmap_config config = {};
+
+	pctrl_desc = devm_kzalloc(dev, sizeof(*pctrl_desc), GFP_KERNEL);
+	if (!pctrl_desc)
+		return -ENOMEM;
+	pctrl_desc->name = dev_name(dev);
+	pctrl_desc->owner = THIS_MODULE;
+	pctrl_desc->pins = tps6594_pins;
+	pctrl_desc->npins = ARRAY_SIZE(tps6594_pins);
+	pctrl_desc->pctlops = &tps6594_pctrl_ops;
+	pctrl_desc->pmxops = &tps6594_pmx_ops;
+
+	pinctrl = devm_kzalloc(dev, sizeof(*pinctrl), GFP_KERNEL);
+	if (!pinctrl)
+		return -ENOMEM;
+	pinctrl->tps = dev_get_drvdata(dev->parent);
+	pinctrl->funcs = pinctrl_functions;
+	pinctrl->pins = tps6594_pins;
+	pinctrl->pctl_dev = devm_pinctrl_register(dev, pctrl_desc, pinctrl);
+	if (IS_ERR(pinctrl->pctl_dev))
+		return dev_err_probe(dev, PTR_ERR(pinctrl->pctl_dev),
+				     "Couldn't register pinctrl driver\n");
+
+	config.parent = tps->dev;
+	config.regmap = tps->regmap;
+	config.ngpio = TPS6594_PINCTRL_PINS_NB;
+	config.ngpio_per_reg = 8;
+	config.reg_dat_base = TPS6594_REG_GPIO_IN_1;
+	config.reg_set_base = TPS6594_REG_GPIO_OUT_1;
+	config.reg_dir_out_base = TPS6594_REG_GPIOX_CONF(0);
+	config.reg_mask_xlate = tps6594_gpio_regmap_xlate;
+
+	pinctrl->gpio_regmap = devm_gpio_regmap_register(dev, &config);
+	if (IS_ERR(pinctrl->gpio_regmap))
+		return dev_err_probe(dev, PTR_ERR(pinctrl->gpio_regmap),
+				     "Couldn't register gpio_regmap driver\n");
+
+	return 0;
+}
+
+static const struct platform_device_id tps6594_pinctrl_id_table[] = {
+	{ "tps6594-pinctrl", },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, tps6594_pinctrl_id_table);
+
+static struct platform_driver tps6594_pinctrl_driver = {
+	.probe = tps6594_pinctrl_probe,
+	.driver = {
+		.name = "tps6594-pinctrl",
+	},
+	.id_table = tps6594_pinctrl_id_table,
+};
+module_platform_driver(tps6594_pinctrl_driver);
+
+MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 pinctrl and GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.40.1

