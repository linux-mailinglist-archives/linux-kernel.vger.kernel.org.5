Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1427B84A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243277AbjJDQLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243293AbjJDQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:11:15 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3396CDC;
        Wed,  4 Oct 2023 09:11:01 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1119FF80F;
        Wed,  4 Oct 2023 16:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696435859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqzy15VCSvW/RtLwBCM0xG7t72x6WJ6p8eSZ6Hb8QJ4=;
        b=YOK4/SsQpDAOUkZabmrqnKr7714pWZE5khgyIPF0MF9VwIqMpqabcQA/yyQu51H3+JdtOZ
        v+AKX9KZUZ7SCG1yVZfdKC8zeKYxZROFFCosnX9J8CjOBI1zw7BLfJPPGFIE0iCbBVONAz
        r2vr/X8VhkASzYAH54+Wa4rviUY5ebeBV3Cj32dQs/2kVuKl+FeSOkH5EcTHwDQVzS36p5
        lwvD0sHkUwn8i9jrioOYgHWVyKh4jtxvrAZYXkH4FRLYxcJcnWR5Bi/3PlFyXVtkGOXx5x
        GbWvLLieKumvHn4Ikl8PAUMlinZcyihJsopm935WxnJab+pZD2OZQYgzWgKt2w==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 08/11] MIPS: mobileye: Add EyeQ5 dtsi
Date:   Wed,  4 Oct 2023 18:10:35 +0200
Message-Id: <20231004161038.2818327-9-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004161038.2818327-1-gregory.clement@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree include file for the Mobileye EyeQ5 SoC.

Based on the work of Slava Samsonov <stanislav.samsonov@intel.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/mips/boot/dts/Makefile                   |   1 +
 arch/mips/boot/dts/mobileye/Makefile          |   4 +
 .../boot/dts/mobileye/eyeq5-fixed-clocks.dtsi | 315 ++++++++++++++++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi        | 138 ++++++++
 4 files changed, 458 insertions(+)
 create mode 100644 arch/mips/boot/dts/mobileye/Makefile
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5.dtsi

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 928f38a79dff..edb8e8dee758 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -8,6 +8,7 @@ subdir-$(CONFIG_LANTIQ)			+= lantiq
 subdir-$(CONFIG_MACH_LOONGSON64)	+= loongson
 subdir-$(CONFIG_SOC_VCOREIII)		+= mscc
 subdir-$(CONFIG_MIPS_MALTA)		+= mti
+subdir-$(CONFIG_SOC_EYEQ5)		+= mobileye
 subdir-$(CONFIG_LEGACY_BOARD_SEAD3)	+= mti
 subdir-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= ni
 subdir-$(CONFIG_MACH_PIC32)		+= pic32
diff --git a/arch/mips/boot/dts/mobileye/Makefile b/arch/mips/boot/dts/mobileye/Makefile
new file mode 100644
index 000000000000..99c4124fd4c0
--- /dev/null
+++ b/arch/mips/boot/dts/mobileye/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright 2023 Mobileye Vision Technologies Ltd.
+
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi b/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
new file mode 100644
index 000000000000..a0066465ac8b
--- /dev/null
+++ b/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright 2023 Mobileye Vision Technologies Ltd.
+ */
+
+/ {
+	/* Fixed clock */
+	pll_cpu: pll_cpu {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1500000000>;
+	};
+
+	pll_vdi: pll_vdi {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1280000000>;
+	};
+
+	pll_per: pll_per {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2000000000>;
+	};
+
+	pll_ddr0: pll_ddr0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1857210000>;
+	};
+
+	pll_ddr1: pll_ddr1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1857210000>;
+	};
+
+/* PLL_CPU derivatives */
+	occ_cpu: occ_cpu {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_cpu>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "occ_cpu";
+	};
+	si_css0_ref_clk: si_css0_ref_clk { /* gate ClkRstGen_si_css0_ref */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_cpu>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "si_css0_ref_clk";
+	};
+	cpc_clk: cpc_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "cpc_clk";
+	};
+	core0_clk: core0_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "core0_clk";
+	};
+	core1_clk: core1_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "core1_clk";
+	};
+	core2_clk: core2_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "core2_clk";
+	};
+	core3_clk: core3_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "core3_clk";
+	};
+	cm_clk: cm_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "cm_clk";
+	};
+	mem_clk: mem_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "mem_clk";
+	};
+	occ_isram: occ_isram {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_cpu>;
+		#clock-cells = <0>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "occ_isram";
+	};
+	isram_clk: isram_clk { /* gate ClkRstGen_isram */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_isram>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "isram_clk";
+	};
+	occ_dbu: occ_dbu {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_cpu>;
+		#clock-cells = <0>;
+		clock-div = <10>;
+		clock-mult = <1>;
+		clock-output-names = "occ_dbu";
+	};
+	si_dbu_tp_pclk: si_dbu_tp_pclk { /* gate ClkRstGen_dbu */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_dbu>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "si_dbu_tp_pclk";
+	};
+/* PLL_VDI derivatives */
+	occ_vdi: occ_vdi {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_vdi>;
+		#clock-cells = <0>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "occ_vdi";
+	};
+	vdi_clk: vdi_clk { /* gate ClkRstGen_vdi */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_vdi>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "vdi_clk";
+	};
+	occ_can_ser: occ_can_ser {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_vdi>;
+		#clock-cells = <0>;
+		clock-div = <16>;
+		clock-mult = <1>;
+		clock-output-names = "occ_can_ser";
+	};
+	can_ser_clk: can_ser_clk { /* gate ClkRstGen_can_ser */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_can_ser>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "can_ser_clk";
+	};
+	i2c_ser_clk: i2c_ser_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_vdi>;
+		#clock-cells = <0>;
+		clock-div = <20>;
+		clock-mult = <1>;
+		clock-output-names = "i2c_ser_clk";
+	};
+/* PLL_PER derivatives */
+	occ_periph: occ_periph {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <16>;
+		clock-mult = <1>;
+		clock-output-names = "occ_periph";
+	};
+	periph_clk: periph_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "periph_clk";
+	};
+	can_clk: can_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "can_clk";
+	};
+	spi_clk: spi_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "spi_clk";
+	};
+	uart_clk: uart_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "uart_clk";
+	};
+	i2c_clk: i2c_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "i2c_clk";
+	};
+	timer_clk: timer_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "timer_clk";
+	};
+	gpio_clk: gpio_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "gpio_clk";
+	};
+	emmc_sys_clk: emmc_sys_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <10>;
+		clock-mult = <1>;
+		clock-output-names = "emmc_sys_clk";
+	};
+	ccf_ctrl_clk: ccf_ctrl_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <4>;
+		clock-mult = <1>;
+		clock-output-names = "ccf_ctrl_clk";
+	};
+	occ_mjpeg_core: occ_mjpeg_core {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "occ_mjpeg_core";
+	};
+	hsm_clk: hsm_clk { /* gate ClkRstGen_hsm */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_mjpeg_core>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "hsm_clk";
+	};
+	mjpeg_core_clk: mjpeg_core_clk { /* gate ClkRstGen_mjpeg_gen */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_mjpeg_core>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "mjpeg_core_clk";
+	};
+	fcmu_a_clk: fcmu_a_clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <20>;
+		clock-mult = <1>;
+		clock-output-names = "fcmu_a_clk";
+	};
+	occ_pci_sys: occ_pci_sys {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <8>;
+		clock-mult = <1>;
+		clock-output-names = "occ_pci_sys";
+	};
+	pclk: pclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <250000000>;  /* 250MHz */
+	};
+	tsu_clk: tsu_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;  /* 125MHz */
+	};
+};
diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
new file mode 100644
index 000000000000..0504c2fb3ad5
--- /dev/null
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Mobileye Vision Technologies Ltd.
+ */
+
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+#include <dt-bindings/soc/mobileye,eyeq5.h>
+
+/memreserve/ 0x40000000 0xc0000000; /* DDR32 */
+/memreserve/ 0x08000000 0x08000000; /* DDR_LOW */
+
+#include "eyeq5-fixed-clocks.dtsi"
+
+/* almost all GIC IRQs has the same characteristics. provide short form */
+#define GIC_IRQ(x) GIC_SHARED (x) IRQ_TYPE_LEVEL_HIGH
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "mti,i6500";
+			reg = <0>;
+			clocks = <&core0_clk>;
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+/* These reserved memory regions are also defined in bootmanager
+ * for configuring inbound translation for BARS, don't change
+ * these without syncing with bootmanager
+ */
+		shmem0_reserved: shmem@804000000 {
+			reg = <0x8 0x04000000 0x0 0x1000000>;
+		};
+		shmem1_reserved: shmem@805000000 {
+			reg = <0x8 0x05000000 0x0 0x1000000>;
+		};
+		pci0_msi_reserved: pci0_msi@806000000 {
+			reg = <0x8 0x06000000 0x0 0x100000>;
+		};
+		pci1_msi_reserved: pci1_msi@806100000 {
+			reg = <0x8 0x06100000 0x0 0x100000>;
+		};
+
+		mini_coredump0_reserved: mini_coredump0@806200000 {
+			reg = <0x8 0x06200000 0x0 0x100000>;
+		};
+		mhm_reserved_0: the_mhm_reserved_0@0 {
+			reg = <0x8 0x00000000 0x0 0x0000800>;
+		};
+	};
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	cpu_intc: interrupt-controller {
+		compatible = "mti,cpu-interrupt-controller";
+		interrupt-controller;
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+	};
+
+	gic: interrupt-controller@140000 {
+		compatible = "mti,gic";
+		reg = <0x0 0x140000 0x0 0x20000>;
+		interrupt-controller;
+		#interrupt-cells = <3>;
+
+		/*
+		 * Declare the interrupt-parent even though the mti,gic
+		 * binding doesn't require it, such that the kernel can
+		 * figure out that cpu_intc is the root interrupt
+		 * controller & should be probed first.
+		 */
+		interrupt-parent = <&cpu_intc>;
+
+		timer {
+			compatible = "mti,gic-timer";
+			interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+			clocks = <&core0_clk>;
+		};
+	};
+
+	soc: soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		compatible = "simple-bus";
+
+		uart0: serial@800000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0 0x800000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_IRQ(NUM_INT_UART)>;
+			clocks  = <&uart_clk>, <&occ_periph>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		uart1: serial@900000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0 0x900000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_IRQ(NUM_INT_UART)>;
+			clocks  = <&uart_clk>, <&occ_periph>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		uart2: serial@a00000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0 0xa00000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_IRQ(NUM_INT_UART)>;
+			clocks  = <&uart_clk>, <&occ_periph>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		olb: olb@e00000 {
+			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
+			reg = <0 0xe00000 0x0 0x400>;
+			reg-io-width = <4>;
+		};
+
+	};
+};
-- 
2.40.1

