Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07138009C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378642AbjLALQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378557AbjLALPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:15:35 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C46172E;
        Fri,  1 Dec 2023 03:15:38 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6CB6C0005;
        Fri,  1 Dec 2023 11:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701429337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfmmkPLG/ll5NZfOYiII8ssFiuAZWR9wcDBKqL8DiFA=;
        b=NgAC1hbssQvGiMleU6khv7x9is8lLk2w2nANQQDjBucsMRlO3lc7QBYT0T9/pJl+gaDEkm
        mpigiBKeDwgL6dOyz6gFUkRRYuU8yjDVOehpP9mh30aTc6j6yBQ9yY2OFTL7OBtxWvlFza
        CD22Whua+dd3nO+wP0+z+R8S/BSvFCHFtKChrOvcy8CiQsng+hajFW9AVvT+2BlTtayqfQ
        Yt1LXgjfYQIIoqT0WE6TSmxIiRRgBeulSkWDlS1t7CCVH9KSZBO1m+eo8u66O7ZAAPz3k5
        0wX03c3DFD9sxnGNQdhY0caXyBCj/b6NhkfYFvdNZTvN2ES+4XtjpiWEmXZwcw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v3 19/22] MIPS: mobileye: Add EyeQ5 dtsi
Date:   Fri,  1 Dec 2023 12:15:02 +0100
Message-ID: <20231201111512.803120-20-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201111512.803120-1-gregory.clement@bootlin.com>
References: <20231201111512.803120-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../boot/dts/mobileye/eyeq5-fixed-clocks.dtsi | 292 ++++++++++++++++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi        | 134 ++++++++
 3 files changed, 427 insertions(+)
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5.dtsi

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 928f38a79dff9..edb8e8dee7583 100644
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
diff --git a/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi b/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
new file mode 100644
index 0000000000000..78f5533a95c67
--- /dev/null
+++ b/arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright 2023 Mobileye Vision Technologies Ltd.
+ */
+
+/ {
+	/* Fixed clock */
+	pll_cpu: pll-cpu {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1500000000>;
+	};
+
+	pll_vdi: pll-vdi {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1280000000>;
+	};
+
+	pll_per: pll-per {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <2000000000>;
+	};
+
+	pll_ddr0: pll-ddr0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1857210000>;
+	};
+
+	pll_ddr1: pll-ddr1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1857210000>;
+	};
+
+/* PLL_CPU derivatives */
+	occ_cpu: occ-cpu {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_cpu>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	si_css0_ref_clk: si-css0-ref-clk { /* gate ClkRstGen_si_css0_ref */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_cpu>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	cpc_clk: cpc-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	core0_clk: core0-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	core1_clk: core1-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	core2_clk: core2-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	core3_clk: core3-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	cm_clk: cm-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	mem_clk: mem-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&si_css0_ref_clk>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	occ_isram: occ-isram {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_cpu>;
+		#clock-cells = <0>;
+		clock-div = <2>;
+		clock-mult = <1>;
+	};
+	isram_clk: isram-clk { /* gate ClkRstGen_isram */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_isram>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	occ_dbu: occ-dbu {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_cpu>;
+		#clock-cells = <0>;
+		clock-div = <10>;
+		clock-mult = <1>;
+	};
+	si_dbu_tp_pclk: si-dbu-tp-pclk { /* gate ClkRstGen_dbu */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_dbu>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+/* PLL_VDI derivatives */
+	occ_vdi: occ-vdi {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_vdi>;
+		#clock-cells = <0>;
+		clock-div = <2>;
+		clock-mult = <1>;
+	};
+	vdi_clk: vdi-clk { /* gate ClkRstGen_vdi */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_vdi>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	occ_can_ser: occ-can-ser {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_vdi>;
+		#clock-cells = <0>;
+		clock-div = <16>;
+		clock-mult = <1>;
+	};
+	can_ser_clk: can-ser-clk { /* gate ClkRstGen_can_ser */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_can_ser>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	i2c_ser_clk: i2c-ser-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_vdi>;
+		#clock-cells = <0>;
+		clock-div = <20>;
+		clock-mult = <1>;
+	};
+/* PLL_PER derivatives */
+	occ_periph: occ-periph {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <16>;
+		clock-mult = <1>;
+	};
+	periph_clk: periph-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	can_clk: can-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	spi_clk: spi-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	uart_clk: uart-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+	};
+	i2c_clk: i2c-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "i2c_clk";
+	};
+	timer_clk: timer-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "timer_clk";
+	};
+	gpio_clk: gpio-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_periph>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "gpio_clk";
+	};
+	emmc_sys_clk: emmc-sys-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <10>;
+		clock-mult = <1>;
+		clock-output-names = "emmc_sys_clk";
+	};
+	ccf_ctrl_clk: ccf-ctrl-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <4>;
+		clock-mult = <1>;
+		clock-output-names = "ccf_ctrl_clk";
+	};
+	occ_mjpeg_core: occ-mjpeg-core {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <2>;
+		clock-mult = <1>;
+		clock-output-names = "occ_mjpeg_core";
+	};
+	hsm_clk: hsm-clk { /* gate ClkRstGen_hsm */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_mjpeg_core>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "hsm_clk";
+	};
+	mjpeg_core_clk: mjpeg-core-clk { /* gate ClkRstGen_mjpeg_gen */
+		compatible = "fixed-factor-clock";
+		clocks = <&occ_mjpeg_core>;
+		#clock-cells = <0>;
+		clock-div = <1>;
+		clock-mult = <1>;
+		clock-output-names = "mjpeg_core_clk";
+	};
+	fcmu_a_clk: fcmu-a-clk {
+		compatible = "fixed-factor-clock";
+		clocks = <&pll_per>;
+		#clock-cells = <0>;
+		clock-div = <20>;
+		clock-mult = <1>;
+		clock-output-names = "fcmu_a_clk";
+	};
+	occ_pci_sys: occ-pci-sys {
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
+	tsu_clk: tsu-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;  /* 125MHz */
+	};
+};
diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
new file mode 100644
index 0000000000000..2968c467a0552
--- /dev/null
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+* Copyright 2023 Mobileye Vision Technologies Ltd.
+*/
+
+#include <dt-bindings/interrupt-controller/mips-gic.h>
+
+/memreserve/ 0x40000000 0xc0000000; /* DDR32 */
+/memreserve/ 0x08000000 0x08000000; /* DDR_LOW */
+
+#include "eyeq5-fixed-clocks.dtsi"
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "img,i6500";
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
+		/* These reserved memory regions are also defined in bootmanager
+		* for configuring inbound translation for BARS, don't change
+		* these without syncing with bootmanager
+		*/
+		shmem0_reserved: shmem@804000000 {
+			reg = <0x8 0x04000000 0x0 0x1000000>;
+		};
+		shmem1_reserved: shmem@805000000 {
+			reg = <0x8 0x05000000 0x0 0x1000000>;
+		};
+		pci0_msi_reserved: pci0-msi@806000000 {
+			reg = <0x8 0x06000000 0x0 0x100000>;
+		};
+		pci1_msi_reserved: pci1-msi@806100000 {
+			reg = <0x8 0x06100000 0x0 0x100000>;
+		};
+
+		mini_coredump0_reserved: mini-coredump0@806200000 {
+			reg = <0x8 0x06200000 0x0 0x100000>;
+		};
+		mhm_reserved_0: the-mhm-reserved-0@0 {
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
+			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks  = <&uart_clk>, <&occ_periph>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		uart1: serial@900000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0 0x900000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks  = <&uart_clk>, <&occ_periph>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		uart2: serial@a00000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0 0xa00000 0x0 0x1000>;
+			reg-io-width = <4>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SHARED 6 IRQ_TYPE_LEVEL_HIGH>;
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
+		gic: interrupt-controller@140000 {
+			compatible = "mti,gic";
+			reg = <0x0 0x140000 0x0 0x20000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			/*
+			* Declare the interrupt-parent even though the mti,gic
+			* binding doesn't require it, such that the kernel can
+			* figure out that cpu_intc is the root interrupt
+			* controller & should be probed first.
+			*/
+			interrupt-parent = <&cpu_intc>;
+
+			timer {
+				compatible = "mti,gic-timer";
+				interrupts = <GIC_LOCAL 1 IRQ_TYPE_NONE>;
+				clocks = <&core0_clk>;
+			};
+		};
+	};
+};
+
-- 
2.42.0

