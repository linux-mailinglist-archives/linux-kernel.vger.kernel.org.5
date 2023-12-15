Return-Path: <linux-kernel+bounces-1115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACEE814AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8D11F22C11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBDF3716A;
	Fri, 15 Dec 2023 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QUFaiYJz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB4358A8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A2F063F2C5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702651153;
	bh=IHuqmfxM1RFpCOZW24V35T5fbhzgoWm8g1Op0X+S1yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=QUFaiYJzkgcnzVGuP9e4gYxbuhxJh9WphRvQf5NLyxKH/hqZPPtt6816jVAHRP9kp
	 1T0O3bUeM2i0Iw2mAYmk89ncRbsvDvH17xfYKYU3vQT4STa5jpnIvKbUXsQCvfmxy3
	 MRsf3gg/NF1yApgn2daEgtbibmHlisjiOlPbl+wI0dT3VWG9+Hkiu1GeTH896ue09q
	 D9mLB0NW64cLTAjKsdkDdGunW+Wi40XjwlycKzjCm/nOeePcCrq8Sv/KYFmnBV//VV
	 Pw8C+VVasLch6WP3R1BkoLlJtfAIEDDCBAG6432/GGRzctO0Jd5jD3t8/peMweIplf
	 +nmoujergcxWw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9fd0a58549bso81171266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651153; x=1703255953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHuqmfxM1RFpCOZW24V35T5fbhzgoWm8g1Op0X+S1yg=;
        b=JHeTUxhs5BWdIKTQYTOM8MyjRV7TbHbwe2KpAaWjFGBZVIJto55Z65DqLL+RHl0DEC
         GjuqqDmrZ95u2U6urQ18F7ZUBXRIrP5yIZg0USu/ae5mRQ2ja8Z41pCpcmT8RvmzNCbP
         xoovRNFd1RMgW1n0UNF6MrCCrIYjjrW5B5Vhs1BsJZeNNxBZk+U7WMi+HHXWhRaUBlXP
         64g5Eztun2oHnvcIDu9ITnfGMcXB4R2W5lt9flzwIDUEDlcCP66UIVBn2BmoqOBv85dL
         SMrWmpt2YoBI9xOB2GR+lXefXPJZ+OGufTJdUZeHHo1iPSm4qzrBMu8mbiBQ/r14/ZS8
         EVDg==
X-Gm-Message-State: AOJu0Yz3ICrCcSxGree/KqBJrd7tVMRb60jVCI8kYS8rxQsgDtzzlP3f
	je8OCrBtdfqo+5lclNcphuKRknJ9E9oR0CgOOIDULsZMdN8klYXav20Ta/9R3elV1/c3QvDqijs
	0Hx3ltXXqEDdH++0YOJwm6/6A8ouT9wgX/Er9c93nmg==
X-Received: by 2002:a17:907:8d8:b0:a1c:7c86:8b79 with SMTP id zu24-20020a17090708d800b00a1c7c868b79mr10066231ejb.26.1702651152868;
        Fri, 15 Dec 2023 06:39:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3zTYDv+66M/LZryqCshtP3OrfgZ6oU5BL8s79PsMbVrdmlrszwnbKEB/UZm+iY7SbNJB2Hw==
X-Received: by 2002:a17:907:8d8:b0:a1c:7c86:8b79 with SMTP id zu24-20020a17090708d800b00a1c7c868b79mr10066211ejb.26.1702651152425;
        Fri, 15 Dec 2023 06:39:12 -0800 (PST)
Received: from stitch.. ([152.115.213.158])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm10789122ejc.73.2023.12.15.06.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:39:11 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v1 2/8] pinctrl: Add driver for the T-Head TH1520 SoC
Date: Fri, 15 Dec 2023 15:39:00 +0100
Message-Id: <20231215143906.3651122-3-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pinctrl driver for the T-Head TH1520 RISC-V SoC.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 MAINTAINERS                      |   1 +
 drivers/pinctrl/Kconfig          |   9 +
 drivers/pinctrl/Makefile         |   1 +
 drivers/pinctrl/pinctrl-th1520.c | 796 +++++++++++++++++++++++++++++++
 4 files changed, 807 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-th1520.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e2c6187a3ac8..7420914c2d77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18616,6 +18616,7 @@ M:	Fu Wei <wefu@redhat.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	arch/riscv/boot/dts/thead/
+F:	drivers/pinctrl/pinctrl-th1520.c
 
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 1de4e1edede0..44426fe0f848 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -469,6 +469,15 @@ config PINCTRL_TB10X
 	depends on OF && ARC_PLAT_TB10X
 	select GPIOLIB
 
+config PINCTRL_TH1520
+	tristate "Pinctrl driver for the T-Head TH1520 SoC"
+	depends on ARCH_THEAD || COMPILE_TEST
+	select GENERIC_PINMUX_FUNCTIONS
+	select GENERIC_PINCONF
+	select PINMUX
+	help
+	  This selects the pinctrl driver for T-Head TH1520 RISC-V SoC.
+
 config PINCTRL_ZYNQ
 	bool "Pinctrl driver for Xilinx Zynq"
 	depends on ARCH_ZYNQ
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 37575deb7a69..74350d667add 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
 obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
+obj-$(CONFIG_PINCTRL_TH1520)	+= pinctrl-th1520.o
 obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 
diff --git a/drivers/pinctrl/pinctrl-th1520.c b/drivers/pinctrl/pinctrl-th1520.c
new file mode 100644
index 000000000000..1efb6ec268e6
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-th1520.c
@@ -0,0 +1,796 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl driver for the T-Head TH1520 SoC
+ *
+ * Copyright (C) 2023 Emil Renner Berthing <emil.renner.berthing@canonical.com>
+ */
+
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "core.h"
+#include "pinmux.h"
+#include "pinconf.h"
+
+#define TH1520_PADCFG_IE	BIT(9)
+#define TH1520_PADCFG_SL	BIT(8)
+#define TH1520_PADCFG_ST	BIT(7)
+#define TH1520_PADCFG_SPU	BIT(6)
+#define TH1520_PADCFG_PS	BIT(5)
+#define TH1520_PADCFG_PE	BIT(4)
+#define TH1520_PADCFG_DS	GENMASK(3, 0)
+
+#define TH1520_PULL_DOWN_OHM	44000 /* typ. 44kOhm */
+#define TH1520_PULL_UP_OHM	48000 /* typ. 48kOhm */
+#define TH1520_PULL_STRONG_OHM	 2100 /* typ. 2.1kOhm */
+
+#define TH1520_FLAG_NO_PADCFG	BIT(0)
+#define TH1520_FLAG_NO_MUXCFG	BIT(1)
+
+struct th1520_padgroup {
+	const char *name;
+	const struct pinctrl_pin_desc *pins;
+	unsigned int npins;
+};
+
+struct th1520_pinctrl {
+	struct pinctrl_desc desc;
+	struct mutex mutex;	/* serialize adding functions */
+	raw_spinlock_t lock;	/* serialize register access */
+	void __iomem *base;
+	struct pinctrl_dev *pctl;
+};
+
+static void __iomem *th1520_padcfg(struct th1520_pinctrl *thp,
+				   unsigned int pin)
+{
+	return thp->base + 4 * (pin / 2);
+}
+
+static unsigned int th1520_padcfg_shift(unsigned int pin)
+{
+	return 16 * (pin & 0x1U);
+}
+
+static void __iomem *th1520_muxcfg(struct th1520_pinctrl *thp,
+				   unsigned int pin)
+{
+	return thp->base + 0x400 + 4 * (pin / 8);
+}
+
+static unsigned int th1520_muxcfg_shift(unsigned int pin)
+{
+	return 4 * (pin & 0x7U);
+}
+
+static const struct pinctrl_pin_desc th1520_group1_pins[] = {
+	{ .number = 0, .name = "OSC_CLK_IN", /* TODO: handle special pad config */
+		.drv_data = (void *)(TH1520_FLAG_NO_PADCFG | TH1520_FLAG_NO_MUXCFG) },
+	{ .number = 1, .name = "OSC_CLK_OUT",
+		.drv_data = (void *)(TH1520_FLAG_NO_PADCFG | TH1520_FLAG_NO_MUXCFG) },
+	{ .number = 2, .name = "SYS_RST_N",
+		.drv_data = (void *)(TH1520_FLAG_NO_PADCFG | TH1520_FLAG_NO_MUXCFG) },
+	{ .number = 3, .name = "RTC_CLK_IN", /* TODO: handle special pad config */
+		.drv_data = (void *)(TH1520_FLAG_NO_PADCFG | TH1520_FLAG_NO_MUXCFG) },
+	{ .number = 4, .name = "RTC_CLK_OUT",
+		.drv_data = (void *)(TH1520_FLAG_NO_PADCFG | TH1520_FLAG_NO_MUXCFG) },
+	/*
+	 * skip number 5 so we can calculate register
+	 * offsets and shifts from the pin number
+	 */
+	{ .number = 6, .name = "TEST_MODE",
+		.drv_data = (void *)(TH1520_FLAG_NO_PADCFG | TH1520_FLAG_NO_MUXCFG) },
+	{ .number = 7, .name = "DEBUG_MODE",
+		.drv_data = (void *)TH1520_FLAG_NO_PADCFG },
+	{ .number = 8, .name = "POR_SEL",
+		.drv_data = (void *)(TH1520_FLAG_NO_PADCFG | TH1520_FLAG_NO_MUXCFG) },
+	PINCTRL_PIN(9,  "I2C_AON_SCL"),
+	PINCTRL_PIN(10, "I2C_AON_SDA"),
+	PINCTRL_PIN(11, "CPU_JTG_TCLK"),
+	PINCTRL_PIN(12, "CPU_JTG_TMS"),
+	PINCTRL_PIN(13, "CPU_JTG_TDI"),
+	PINCTRL_PIN(14, "CPU_JTG_TDO"),
+	PINCTRL_PIN(15, "CPU_JTG_TRST"),
+	PINCTRL_PIN(16, "AOGPIO_7"),
+	PINCTRL_PIN(17, "AOGPIO_8"),
+	PINCTRL_PIN(18, "AOGPIO_9"),
+	PINCTRL_PIN(19, "AOGPIO_10"),
+	PINCTRL_PIN(20, "AOGPIO_11"),
+	PINCTRL_PIN(21, "AOGPIO_12"),
+	PINCTRL_PIN(22, "AOGPIO_13"),
+	PINCTRL_PIN(23, "AOGPIO_14"),
+	PINCTRL_PIN(24, "AOGPIO_15"),
+	PINCTRL_PIN(25, "AUDIO_PA0"),
+	PINCTRL_PIN(26, "AUDIO_PA1"),
+	PINCTRL_PIN(27, "AUDIO_PA2"),
+	PINCTRL_PIN(28, "AUDIO_PA3"),
+	PINCTRL_PIN(29, "AUDIO_PA4"),
+	PINCTRL_PIN(30, "AUDIO_PA5"),
+	PINCTRL_PIN(31, "AUDIO_PA6"),
+	PINCTRL_PIN(32, "AUDIO_PA7"),
+	PINCTRL_PIN(33, "AUDIO_PA8"),
+	PINCTRL_PIN(34, "AUDIO_PA9"),
+	PINCTRL_PIN(35, "AUDIO_PA10"),
+	PINCTRL_PIN(36, "AUDIO_PA11"),
+	PINCTRL_PIN(37, "AUDIO_PA12"),
+	PINCTRL_PIN(38, "AUDIO_PA13"),
+	PINCTRL_PIN(39, "AUDIO_PA14"),
+	PINCTRL_PIN(40, "AUDIO_PA15"),
+	PINCTRL_PIN(41, "AUDIO_PA16"),
+	PINCTRL_PIN(42, "AUDIO_PA17"),
+	PINCTRL_PIN(43, "AUDIO_PA27"),
+	PINCTRL_PIN(44, "AUDIO_PA28"),
+	PINCTRL_PIN(45, "AUDIO_PA29"),
+	PINCTRL_PIN(46, "AUDIO_PA30"),
+};
+
+static const struct th1520_padgroup th1520_group1 = {
+	.name = "th1520-group1",
+	.pins = th1520_group1_pins,
+	.npins = ARRAY_SIZE(th1520_group1_pins),
+};
+
+static const struct pinctrl_pin_desc th1520_group2_pins[] = {
+	PINCTRL_PIN(0,  "QSPI1_SCLK"),
+	PINCTRL_PIN(1,  "QSPI1_CSN0"),
+	PINCTRL_PIN(2,  "QSPI1_D0_MOSI"),
+	PINCTRL_PIN(3,  "QSPI1_D1_MISO"),
+	PINCTRL_PIN(4,  "QSPI1_D2_WP"),
+	PINCTRL_PIN(5,  "QSPI1_D3_HOLD"),
+	PINCTRL_PIN(6,  "I2C0_SCL"),
+	PINCTRL_PIN(7,  "I2C0_SDA"),
+	PINCTRL_PIN(8,  "I2C1_SCL"),
+	PINCTRL_PIN(9,  "I2C1_SDA"),
+	PINCTRL_PIN(10, "UART1_TXD"),
+	PINCTRL_PIN(11, "UART1_RXD"),
+	PINCTRL_PIN(12, "UART4_TXD"),
+	PINCTRL_PIN(13, "UART4_RXD"),
+	PINCTRL_PIN(14, "UART4_CTSN"),
+	PINCTRL_PIN(15, "UART4_RTSN"),
+	PINCTRL_PIN(16, "UART3_TXD"),
+	PINCTRL_PIN(17, "UART3_RXD"),
+	PINCTRL_PIN(18, "GPIO0_18"),
+	PINCTRL_PIN(19, "GPIO0_19"),
+	PINCTRL_PIN(20, "GPIO0_20"),
+	PINCTRL_PIN(21, "GPIO0_21"),
+	PINCTRL_PIN(22, "GPIO0_22"),
+	PINCTRL_PIN(23, "GPIO0_23"),
+	PINCTRL_PIN(24, "GPIO0_24"),
+	PINCTRL_PIN(25, "GPIO0_25"),
+	PINCTRL_PIN(26, "GPIO0_26"),
+	PINCTRL_PIN(27, "GPIO0_27"),
+	PINCTRL_PIN(28, "GPIO0_28"),
+	PINCTRL_PIN(29, "GPIO0_29"),
+	PINCTRL_PIN(30, "GPIO0_30"),
+	PINCTRL_PIN(31, "GPIO0_31"),
+	PINCTRL_PIN(32, "GPIO1_0"),
+	PINCTRL_PIN(33, "GPIO1_1"),
+	PINCTRL_PIN(34, "GPIO1_2"),
+	PINCTRL_PIN(35, "GPIO1_3"),
+	PINCTRL_PIN(36, "GPIO1_4"),
+	PINCTRL_PIN(37, "GPIO1_5"),
+	PINCTRL_PIN(38, "GPIO1_6"),
+	PINCTRL_PIN(39, "GPIO1_7"),
+	PINCTRL_PIN(40, "GPIO1_8"),
+	PINCTRL_PIN(41, "GPIO1_9"),
+	PINCTRL_PIN(42, "GPIO1_10"),
+	PINCTRL_PIN(43, "GPIO1_11"),
+	PINCTRL_PIN(44, "GPIO1_12"),
+	PINCTRL_PIN(45, "GPIO1_13"),
+	PINCTRL_PIN(46, "GPIO1_14"),
+	PINCTRL_PIN(47, "GPIO1_15"),
+	PINCTRL_PIN(48, "GPIO1_16"),
+	PINCTRL_PIN(49, "CLK_OUT_0"),
+	PINCTRL_PIN(50, "CLK_OUT_1"),
+	PINCTRL_PIN(51, "CLK_OUT_2"),
+	PINCTRL_PIN(52, "CLK_OUT_3"),
+	PINCTRL_PIN(53, "GPIO1_21"),
+	PINCTRL_PIN(54, "GPIO1_22"),
+	PINCTRL_PIN(55, "GPIO1_23"),
+	PINCTRL_PIN(56, "GPIO1_24"),
+	PINCTRL_PIN(57, "GPIO1_25"),
+	PINCTRL_PIN(58, "GPIO1_26"),
+	PINCTRL_PIN(59, "GPIO1_27"),
+	PINCTRL_PIN(60, "GPIO1_28"),
+	PINCTRL_PIN(61, "GPIO1_29"),
+	PINCTRL_PIN(62, "GPIO1_30"),
+};
+
+static const struct th1520_padgroup th1520_group2 = {
+	.name = "th1520-group2",
+	.pins = th1520_group2_pins,
+	.npins = ARRAY_SIZE(th1520_group2_pins),
+};
+
+static const struct pinctrl_pin_desc th1520_group3_pins[] = {
+	PINCTRL_PIN(0,  "UART0_TXD"),
+	PINCTRL_PIN(1,  "UART0_RXD"),
+	PINCTRL_PIN(2,  "QSPI0_SCLK"),
+	PINCTRL_PIN(3,  "QSPI0_CSN0"),
+	PINCTRL_PIN(4,  "QSPI0_CSN1"),
+	PINCTRL_PIN(5,  "QSPI0_D0_MOSI"),
+	PINCTRL_PIN(6,  "QSPI0_D1_MISO"),
+	PINCTRL_PIN(7,  "QSPI0_D2_WP"),
+	PINCTRL_PIN(8,  "QSPI1_D3_HOLD"),
+	PINCTRL_PIN(9,  "I2C2_SCL"),
+	PINCTRL_PIN(10, "I2C2_SDA"),
+	PINCTRL_PIN(11, "I2C3_SCL"),
+	PINCTRL_PIN(12, "I2C3_SDA"),
+	PINCTRL_PIN(13, "GPIO2_13"),
+	PINCTRL_PIN(14, "SPI_SCLK"),
+	PINCTRL_PIN(15, "SPI_CSN"),
+	PINCTRL_PIN(16, "SPI_MOSI"),
+	PINCTRL_PIN(17, "SPI_MISO"),
+	PINCTRL_PIN(18, "GPIO2_18"),
+	PINCTRL_PIN(19, "GPIO2_19"),
+	PINCTRL_PIN(20, "GPIO2_20"),
+	PINCTRL_PIN(21, "GPIO2_21"),
+	PINCTRL_PIN(22, "GPIO2_22"),
+	PINCTRL_PIN(23, "GPIO2_23"),
+	PINCTRL_PIN(24, "GPIO2_24"),
+	PINCTRL_PIN(25, "GPIO2_25"),
+	PINCTRL_PIN(26, "SDIO0_WPRTN"),
+	PINCTRL_PIN(27, "SDIO0_DETN"),
+	PINCTRL_PIN(28, "SDIO1_WPRTN"),
+	PINCTRL_PIN(29, "SDIO1_DETN"),
+	PINCTRL_PIN(30, "GPIO2_30"),
+	PINCTRL_PIN(31, "GPIO2_31"),
+	PINCTRL_PIN(32, "GPIO3_0"),
+	PINCTRL_PIN(33, "GPIO3_1"),
+	PINCTRL_PIN(34, "GPIO3_2"),
+	PINCTRL_PIN(35, "GPIO3_3"),
+	PINCTRL_PIN(36, "HDMI_SCL"),
+	PINCTRL_PIN(37, "HDMI_SDA"),
+	PINCTRL_PIN(38, "HDMI_CEC"),
+	PINCTRL_PIN(39, "GMAC0_TX_CLK"),
+	PINCTRL_PIN(40, "GMAC0_RX_CLK"),
+	PINCTRL_PIN(41, "GMAC0_TXEN"),
+	PINCTRL_PIN(42, "GMAC0_TXD0"),
+	PINCTRL_PIN(43, "GMAC0_TXD1"),
+	PINCTRL_PIN(44, "GMAC0_TXD2"),
+	PINCTRL_PIN(45, "GMAC0_TXD3"),
+	PINCTRL_PIN(46, "GMAC0_RXDV"),
+	PINCTRL_PIN(47, "GMAC0_RXD0"),
+	PINCTRL_PIN(48, "GMAC0_RXD1"),
+	PINCTRL_PIN(49, "GMAC0_RXD2"),
+	PINCTRL_PIN(50, "GMAC0_RXD3"),
+	PINCTRL_PIN(51, "GMAC0_MDC"),
+	PINCTRL_PIN(52, "GMAC0_MDIO"),
+	PINCTRL_PIN(53, "GMAC0_COL"),
+	PINCTRL_PIN(54, "GMAC0_CRS"),
+};
+
+static const struct th1520_padgroup th1520_group3 = {
+	.name = "th1520-group3",
+	.pins = th1520_group3_pins,
+	.npins = ARRAY_SIZE(th1520_group3_pins),
+};
+
+static int th1520_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+
+	return thp->desc.npins;
+}
+
+static const char *th1520_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
+						 unsigned int gsel)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+
+	return thp->desc.pins[gsel].name;
+}
+
+static int th1520_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
+					 unsigned int gsel,
+					 const unsigned int **pins,
+					 unsigned int *npins)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = &thp->desc.pins[gsel].number;
+	*npins = 1;
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void th1520_pin_dbg_show(struct pinctrl_dev *pctldev,
+				struct seq_file *s, unsigned int pin)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+	void __iomem *padcfg = th1520_padcfg(thp, pin);
+	void __iomem *muxcfg = th1520_muxcfg(thp, pin);
+	unsigned long flags;
+	u32 pad;
+	u32 mux;
+
+	raw_spin_lock_irqsave(&thp->lock, flags);
+	pad = readl_relaxed(padcfg);
+	mux = readl_relaxed(muxcfg);
+	raw_spin_unlock_irqrestore(&thp->lock, flags);
+
+	seq_printf(s, "[PADCFG_%03u:0x%x=0x%07x MUXCFG_%03u:0x%x=0x%08x]",
+		   1 + pin / 2, 0x000 + 4 * (pin / 2), pad,
+		   1 + pin / 8, 0x400 + 4 * (pin / 8), mux);
+}
+#else
+#define th1520_pin_dbg_show NULL
+#endif
+
+static void th1520_pinctrl_dt_free_map(struct pinctrl_dev *pctldev,
+				       struct pinctrl_map *map, unsigned int nmaps)
+{
+	unsigned long *seen = NULL;
+	unsigned int i;
+
+	for (i = 0; i < nmaps; i++) {
+		if (map[i].type == PIN_MAP_TYPE_CONFIGS_PIN &&
+		    map[i].data.configs.configs != seen) {
+			seen = map[i].data.configs.configs;
+			kfree(seen);
+		}
+	}
+
+	kfree(map);
+}
+
+static int th1520_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
+					 struct device_node *np,
+					 struct pinctrl_map **maps,
+					 unsigned int *num_maps)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+	struct device_node *child;
+	struct pinctrl_map *map;
+	unsigned long *configs;
+	unsigned int nconfigs;
+	unsigned int nmaps;
+	int ret;
+
+	nmaps = 0;
+	for_each_available_child_of_node(np, child) {
+		int npins = of_property_count_strings(child, "pins");
+
+		if (npins <= 0) {
+			of_node_put(child);
+			return dev_err_probe(thp->pctl->dev, -EINVAL,
+					     "no pins selected for %pOFn.%pOFn\n",
+					     np, child);
+		}
+		nmaps += npins;
+		if (of_property_present(child, "function"))
+			nmaps += npins;
+	}
+
+	map = kcalloc(nmaps, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	nmaps = 0;
+	mutex_lock(&thp->mutex);
+	for_each_available_child_of_node(np, child) {
+		unsigned int rollback = nmaps;
+		struct property *prop;
+		const char *funcname;
+		const char **pgnames;
+		const char *pinname;
+		uintptr_t muxdata;
+		int npins;
+
+		ret = pinconf_generic_parse_dt_config(child, pctldev, &configs, &nconfigs);
+		if (ret) {
+			dev_err(thp->pctl->dev, "error parsing pin config of group %pOFn.%pOFn\n",
+				np, child);
+			goto put_child;
+		}
+
+		if (!of_property_read_string(child, "function", &funcname)) {
+			if (funcname[0] < '0' || funcname[0] > '5' || funcname[1]) {
+				ret = -EINVAL;
+				dev_err(thp->pctl->dev, "%pOFn.%pOFn: invalid function '%s'\n",
+					np, child, funcname);
+				goto free_configs;
+			}
+
+			muxdata = funcname[0] - '0';
+			funcname = devm_kasprintf(thp->pctl->dev, GFP_KERNEL, "%pOFn.%pOFn",
+						  np, child);
+			if (!funcname) {
+				ret = -ENOMEM;
+				goto free_configs;
+			}
+
+			npins = of_property_count_strings(child, "pins");
+			pgnames = devm_kcalloc(thp->pctl->dev, npins, sizeof(*pgnames), GFP_KERNEL);
+			if (!pgnames) {
+				ret = -ENOMEM;
+				goto free_configs;
+			}
+		} else {
+			funcname = NULL;
+		}
+
+		npins = 0;
+		of_property_for_each_string(child, "pins", prop, pinname) {
+			unsigned int i;
+
+			for (i = 0; i < thp->desc.npins; i++) {
+				if (!strcmp(pinname, thp->desc.pins[i].name))
+					break;
+			}
+			if (i == thp->desc.npins) {
+				nmaps = rollback;
+				dev_err(thp->pctl->dev, "%pOFn.%pOFn: unknown pin '%s'\n",
+					np, child, pinname);
+				goto free_configs;
+			}
+
+			if (nconfigs) {
+				map[nmaps].type = PIN_MAP_TYPE_CONFIGS_PIN;
+				map[nmaps].data.configs.group_or_pin = thp->desc.pins[i].name;
+				map[nmaps].data.configs.configs = configs;
+				map[nmaps].data.configs.num_configs = nconfigs;
+				nmaps += 1;
+			}
+			if (funcname) {
+				pgnames[npins++] = thp->desc.pins[i].name;
+				map[nmaps].type = PIN_MAP_TYPE_MUX_GROUP;
+				map[nmaps].data.mux.function = funcname;
+				map[nmaps].data.mux.group = thp->desc.pins[i].name;
+				nmaps += 1;
+			}
+		}
+
+		if (funcname) {
+			ret = pinmux_generic_add_function(pctldev, funcname, pgnames,
+							  npins, (void *)muxdata);
+			if (ret < 0) {
+				dev_err(thp->pctl->dev, "error adding function %s\n", funcname);
+				goto put_child;
+			}
+		}
+	}
+
+	*maps = map;
+	*num_maps = nmaps;
+	mutex_unlock(&thp->mutex);
+	return 0;
+
+free_configs:
+	kfree(configs);
+put_child:
+	of_node_put(child);
+	th1520_pinctrl_dt_free_map(pctldev, map, nmaps);
+	mutex_unlock(&thp->mutex);
+	return ret;
+}
+
+static const struct pinctrl_ops th1520_pinctrl_ops = {
+	.get_groups_count = th1520_pinctrl_get_groups_count,
+	.get_group_name = th1520_pinctrl_get_group_name,
+	.get_group_pins = th1520_pinctrl_get_group_pins,
+	.pin_dbg_show = th1520_pin_dbg_show,
+	.dt_node_to_map = th1520_pinctrl_dt_node_to_map,
+	.dt_free_map = th1520_pinctrl_dt_free_map,
+};
+
+static int th1520_pinmux_set_mux(struct pinctrl_dev *pctldev,
+				 unsigned int fsel, unsigned int gsel)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+	const struct function_desc *func = pinmux_generic_get_function(pctldev, fsel);
+	unsigned int pin = thp->desc.pins[gsel].number;
+	void __iomem *muxcfg = th1520_muxcfg(thp, pin);
+	unsigned int shift = th1520_muxcfg_shift(pin);
+	unsigned long flags;
+	u32 mask;
+	u32 value;
+
+	if (!func || (uintptr_t)thp->desc.pins[gsel].drv_data & TH1520_FLAG_NO_MUXCFG)
+		return -EINVAL;
+
+	mask = 0xfU << shift;
+	value = ((uintptr_t)func->data & 0xfU) << shift;
+
+	raw_spin_lock_irqsave(&thp->lock, flags);
+	value |= readl_relaxed(muxcfg) & ~mask;
+	writel_relaxed(value, muxcfg);
+	raw_spin_unlock_irqrestore(&thp->lock, flags);
+
+	return 0;
+}
+
+static const struct pinmux_ops th1520_pinmux_ops = {
+	.get_functions_count = pinmux_generic_get_function_count,
+	.get_function_name = pinmux_generic_get_function_name,
+	.get_function_groups = pinmux_generic_get_function_groups,
+	.set_mux = th1520_pinmux_set_mux,
+	.strict = true,
+};
+
+static const u8 th1520_drive_strength_in_mA[16] = {
+	1, 2, 3, 5, 7, 8, 10, 12, 13, 15, 16, 18, 20, 21, 23, 25,
+};
+
+static u16 th1520_drive_strength_from_mA(u32 arg)
+{
+	u16 v;
+
+	for (v = 0; v < ARRAY_SIZE(th1520_drive_strength_in_mA) - 1; v++) {
+		if (arg <= th1520_drive_strength_in_mA[v])
+			break;
+	}
+
+	return v;
+}
+
+static int th1520_padcfg_rmw(struct th1520_pinctrl *thp, unsigned int pin,
+			     u16 _mask, u16 _value)
+{
+	void __iomem *padcfg = th1520_padcfg(thp, pin);
+	unsigned int shift = th1520_padcfg_shift(pin);
+	u32 mask = (u32)_mask << shift;
+	u32 value = (u32)_value << shift;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&thp->lock, flags);
+	value |= readl_relaxed(padcfg) & ~mask;
+	writel_relaxed(value, padcfg);
+	raw_spin_unlock_irqrestore(&thp->lock, flags);
+	return 0;
+}
+
+#define PIN_CONFIG_THEAD_STRONG_PULL_UP	(PIN_CONFIG_END + 1)
+static const struct pinconf_generic_params th1520_pinconf_custom_params[] = {
+	{ "thead,strong-pull-up", PIN_CONFIG_THEAD_STRONG_PULL_UP, 1 },
+};
+
+#ifdef CONFIG_DEBUG_FS
+static const struct pin_config_item th1520_pinconf_custom_conf_items[] = {
+	PCONFDUMP(PIN_CONFIG_THEAD_STRONG_PULL_UP, "input bias strong pull-up", "ohms", true),
+};
+static_assert(ARRAY_SIZE(th1520_pinconf_custom_conf_items) ==
+	      ARRAY_SIZE(th1520_pinconf_custom_params));
+#else
+#define th1520_pinconf_custom_conf_items NULL
+#endif
+
+static int th1520_pinconf_get(struct pinctrl_dev *pctldev,
+			      unsigned int pin, unsigned long *config)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+	const struct pin_desc *desc = pin_desc_get(pctldev, pin);
+	bool enabled;
+	int param;
+	u32 value;
+	u32 arg;
+
+	if ((uintptr_t)desc->drv_data & TH1520_FLAG_NO_PADCFG)
+		return -ENOTSUPP;
+
+	value = readl_relaxed(th1520_padcfg(thp, pin));
+	value = (value >> th1520_padcfg_shift(pin)) & 0x3ffU;
+
+	param = pinconf_to_config_param(*config);
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		enabled = !(value & TH1520_PADCFG_PE);
+		arg = 0;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		enabled = (value & (TH1520_PADCFG_PE | TH1520_PADCFG_PS)) ==
+				    TH1520_PADCFG_PE;
+		arg = enabled ? TH1520_PULL_DOWN_OHM : 0;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		enabled = (value & (TH1520_PADCFG_PE | TH1520_PADCFG_PS)) ==
+				   (TH1520_PADCFG_PE | TH1520_PADCFG_PS);
+		arg = enabled ? TH1520_PULL_UP_OHM : 0;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		enabled = true;
+		arg = th1520_drive_strength_in_mA[value & TH1520_PADCFG_DS];
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		enabled = value & TH1520_PADCFG_IE;
+		arg = enabled;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		enabled = value & TH1520_PADCFG_ST;
+		arg = enabled;
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		enabled = value & TH1520_PADCFG_SL;
+		arg = enabled;
+		break;
+	case PIN_CONFIG_THEAD_STRONG_PULL_UP:
+		enabled = value & TH1520_PADCFG_SPU;
+		arg = enabled ? TH1520_PULL_STRONG_OHM : 0;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+	return enabled ? 0 : -EINVAL;
+}
+
+static int th1520_pinconf_group_get(struct pinctrl_dev *pctldev,
+				    unsigned int gsel, unsigned long *config)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int pin = thp->desc.pins[gsel].number;
+
+	return th1520_pinconf_get(pctldev, pin, config);
+}
+
+static int th1520_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
+			      unsigned long *configs, unsigned int num_configs)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int i;
+	u16 mask = 0;
+	u16 value = 0;
+
+	for (i = 0; i < num_configs; i++) {
+		int param = pinconf_to_config_param(configs[i]);
+		u32 arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			mask |= TH1520_PADCFG_PE;
+			value &= ~TH1520_PADCFG_PE;
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			if (arg == 0)
+				return -ENOTSUPP;
+			mask |= TH1520_PADCFG_PS;
+			value &= ~TH1520_PADCFG_PS;
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			if (arg == 0)
+				return -ENOTSUPP;
+			mask |= TH1520_PADCFG_PS;
+			value |= TH1520_PADCFG_PS;
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			mask |= TH1520_PADCFG_DS;
+			value = (value & ~TH1520_PADCFG_DS) |
+				th1520_drive_strength_from_mA(arg);
+			break;
+		case PIN_CONFIG_INPUT_ENABLE:
+			mask |= TH1520_PADCFG_IE;
+			if (arg)
+				value |= TH1520_PADCFG_IE;
+			else
+				value &= ~TH1520_PADCFG_IE;
+			break;
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			mask |= TH1520_PADCFG_ST;
+			if (arg)
+				value |= TH1520_PADCFG_ST;
+			else
+				value &= ~TH1520_PADCFG_ST;
+			break;
+		case PIN_CONFIG_SLEW_RATE:
+			mask |= TH1520_PADCFG_SL;
+			if (arg)
+				value |= TH1520_PADCFG_SL;
+			else
+				value &= ~TH1520_PADCFG_SL;
+			break;
+		case PIN_CONFIG_THEAD_STRONG_PULL_UP:
+			mask |= TH1520_PADCFG_SPU;
+			if (arg)
+				value |= TH1520_PADCFG_SPU;
+			else
+				value &= ~TH1520_PADCFG_SPU;
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+	}
+
+	return th1520_padcfg_rmw(thp, pin, mask, value);
+}
+
+static int th1520_pinconf_group_set(struct pinctrl_dev *pctldev,
+				    unsigned int gsel,
+				    unsigned long *configs,
+				    unsigned int num_configs)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int pin = thp->desc.pins[gsel].number;
+
+	return th1520_pinconf_set(pctldev, pin, configs, num_configs);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void th1520_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+				    struct seq_file *s, unsigned int pin)
+{
+	struct th1520_pinctrl *thp = pinctrl_dev_get_drvdata(pctldev);
+	u32 value = readl_relaxed(th1520_padcfg(thp, pin));
+
+	value = (value >> th1520_padcfg_shift(pin)) & 0x3ffU;
+
+	seq_printf(s, " [0x%03x]", value);
+}
+#else
+#define th1520_pinconf_dbg_show NULL
+#endif
+
+static const struct pinconf_ops th1520_pinconf_ops = {
+	.pin_config_get = th1520_pinconf_get,
+	.pin_config_group_get = th1520_pinconf_group_get,
+	.pin_config_set = th1520_pinconf_set,
+	.pin_config_group_set = th1520_pinconf_group_set,
+	.pin_config_dbg_show = th1520_pinconf_dbg_show,
+	.is_generic = true,
+};
+
+static int th1520_pinctrl_probe(struct platform_device *pdev)
+{
+	const struct th1520_padgroup *group = device_get_match_data(&pdev->dev);
+	struct th1520_pinctrl *thp;
+	int ret;
+
+	thp = devm_kzalloc(&pdev->dev, sizeof(*thp), GFP_KERNEL);
+	if (!thp)
+		return -ENOMEM;
+
+	thp->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(thp->base))
+		return PTR_ERR(thp->base);
+
+	thp->desc.name = group->name;
+	thp->desc.pins = group->pins;
+	thp->desc.npins = group->npins;
+	thp->desc.pctlops = &th1520_pinctrl_ops;
+	thp->desc.pmxops = &th1520_pinmux_ops;
+	thp->desc.confops = &th1520_pinconf_ops;
+	thp->desc.owner = THIS_MODULE;
+	thp->desc.num_custom_params = ARRAY_SIZE(th1520_pinconf_custom_params);
+	thp->desc.custom_params = th1520_pinconf_custom_params;
+	thp->desc.custom_conf_items = th1520_pinconf_custom_conf_items;
+	mutex_init(&thp->mutex);
+	raw_spin_lock_init(&thp->lock);
+
+	ret = devm_pinctrl_register_and_init(&pdev->dev, &thp->desc, thp, &thp->pctl);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "could not register pinctrl driver\n");
+
+	return pinctrl_enable(thp->pctl);
+}
+
+static const struct of_device_id th1520_pinctrl_of_match[] = {
+	{ .compatible = "thead,th1520-group1-pinctrl", .data = &th1520_group1 },
+	{ .compatible = "thead,th1520-group2-pinctrl", .data = &th1520_group2 },
+	{ .compatible = "thead,th1520-group3-pinctrl", .data = &th1520_group3 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, th1520_pinctrl_of_match);
+
+static struct platform_driver th1520_pinctrl_driver = {
+	.probe = th1520_pinctrl_probe,
+	.driver = {
+		.name = "pinctrl-th1520",
+		.of_match_table = th1520_pinctrl_of_match,
+	},
+};
+module_platform_driver(th1520_pinctrl_driver);
+
+MODULE_DESCRIPTION("Pinctrl driver for the T-Head TH1520 SoC");
+MODULE_AUTHOR("Emil Renner Berthing <emil.renner.berthing@canonical.com>");
+MODULE_LICENSE("GPL");
-- 
2.40.1


