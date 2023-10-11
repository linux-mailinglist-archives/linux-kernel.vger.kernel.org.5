Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BD27C60BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjJKW6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjJKW6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:58:31 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87159D;
        Wed, 11 Oct 2023 15:58:28 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a2a9e5451bso17901239f.1;
        Wed, 11 Oct 2023 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697065108; x=1697669908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1CpKr2bsrERweoUCSe55PQuM6VVwGF/RSfDpmeT0qs=;
        b=DXASdReotdVLjSGB9HWYH2KOqOWOU6+SAxoiwn68qECrAUHPSGqlSv0nJSND2sVy9a
         xO1sqpmxXFFuJXoAZZiQ0j8x6yPzM1vRqNj11yM0+oFMhfEozIcNHegd9wgawmjKXavF
         aZo+iKd3VUOBgsjZ/BQ5tnNrJ6K/k+/Jty37uG276SsqCAVryZM9jqazGv8OGOxCx/CW
         BmSswrE/7Gw6kNUfTYeD3Vn4fjjpt0xKkaRBQFwr9O0WQ1B/GDuiw3EdFY+5QAh8Y0q8
         s3a87AF6Chs5YcgGi4QyKT0LpZoK897hYODhz4VmvlLy5vaXaNUqVYUGzkKAwKcefHfS
         U8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697065108; x=1697669908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1CpKr2bsrERweoUCSe55PQuM6VVwGF/RSfDpmeT0qs=;
        b=R95XRJV1oJnHYk+XidW3YpsLAsW0R5Fn8yh70Lwn5g5+YR/hUSih1TRgiqAhk+wXV3
         QXSfGOlOllxyKFXvo0NpXWCifeyXO6o4NeDDIiIPyz7vGp85hwh1wsv1z2XFg3IC/W6l
         bLeHoi+FwvxAnUIHKrk18gIlgT7hBOd8B2myQ4kgBWURvMivdeJn4txkCzRWXsnHDfpM
         GFW/rX0PVz6Z20nNZdiXGnVNrzvDfZ0pfQoyi1wpWuyQ+IjDtAzkKKT0RNyi2VDE7FZF
         2IdI8V8IjX6NwbebFcc5qAPqHLqVUZHgQiuMBugnHWpNGa1lnRE0vsw51K0zbJ6HeYuj
         KDFg==
X-Gm-Message-State: AOJu0YwRHrlENgtk2RX4XaL3tw8ks+DIoE+yVcDa4QzBhrXqGpIK98Yt
        wPZMrtwnQGxgqOsUh8/rdMdFjK0ZS245EA==
X-Google-Smtp-Source: AGHT+IFT62df4T8Cq750MtLdUi3wfIFbcwtGGHTnfebBgA6ux7LAANMHVM4ECg00YpfHzpjNkqKBfA==
X-Received: by 2002:a05:6602:228a:b0:79f:a25b:51c with SMTP id d10-20020a056602228a00b0079fa25b051cmr24155042iod.11.1697065108076;
        Wed, 11 Oct 2023 15:58:28 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:fcdc:5119:7b2f:72b3])
        by smtp.gmail.com with ESMTPSA id dq15-20020a0566384d0f00b0043a1f6dc8d4sm3632691jab.4.2023.10.11.15.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:58:27 -0700 (PDT)
From:   Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
        Sven Rademakers <sven.rademakers@gmail.com>,
        Lokesh Poovaragan <loki@gimmeapis.com>,
        Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Add Turing RK1 SoM support
Date:   Wed, 11 Oct 2023 16:58:23 -0600
Message-ID: <20231011225823.2542262-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011225823.2542262-1-CFSworks@gmail.com>
References: <20231011225823.2542262-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Turing RK1 is an upcoming RK3588-based SoM from Turing Machines,
designed on the Jetson SO-DIMM form factor and meant to be compatible
with most Jetson carrier boards (but especially the Turing Pi 2 cluster
board from the same vendor). It has the typical I/O you'd expect from
a Jetson board, including:

- Two UARTs (UART9 for console, UART2 is auxiliary)
- PCI Express (2.0 x1 + 3.0 x4)
- Gigabit Ethernet
- On-board eMMC
- PWM fan w/ tach
- USB-OTG [1]
- HDMI and MIPI DSI [1]
- Miscellaneous external GPIO, I²C, SPI lines [1]

Beyond that, it is pretty similar to the RK3588 EVB (in terms of PMICs,
RTC, etc).

While this is absolutely a SoM, it is a little bit special in that it's
marketed directly to users as a compute node, while most SoMs are
intended to be a part/module incorporated into a larger system. Because
of this, a majority of the users will be treating the RK1 less like a
SoM and more like a miniature "blade server."

This patch introduces a dtsi to enable most[1] of the SoM I/O, as well
as a dts catered more directly to the "compute node" use case.

[1] These peripherals are not addressed with this patch.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-turing-rk1.dts   |  21 +
 .../boot/dts/rockchip/rk3588-turing-rk1.dtsi  | 623 ++++++++++++++++++
 3 files changed, 645 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index e7728007fd1b..bedca9f68b8d 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -102,6 +102,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6b-io.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-turing-rk1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-indiedroid-nova.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-khadas-edge2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dts b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dts
new file mode 100644
index 000000000000..7bcad28d73b8
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * This device tree covers the common case where the RK1 is used as a
+ * "compute node" system, where the carrier board is functioning more like a
+ * generic backplane (with no non-autoenumerable peripherals of its own) than
+ * like a device that the SoM is meant to enable.
+ *
+ * Copyright (c) 2023 Sam Edwards <CFSworks@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3588-turing-rk1.dtsi"
+
+/ {
+	model = "Turing Machines RK1";
+	compatible = "turing,rk1", "rockchip,rk3588";
+
+	chosen {
+		stdout-path = "serial9:115200n8";
+	};
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
new file mode 100644
index 000000000000..7bf97fe66d12
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device tree definitions for the Turing RK1 SoM.
+ *
+ * Copyright (c) 2023 Sam Edwards <CFSworks@gmail.com>
+ *
+ * Based on RK3588-EVB1 devicetree
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include "rk3588.dtsi"
+
+/ {
+	compatible = "turing,rk1", "rockchip,rk3588";
+
+	aliases {
+		ethernet0 = &gmac1;
+		mmc0 = &sdhci;
+		serial2 = &uart2;
+		serial9 = &uart9;
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 25 95 145 195 255>;
+		fan-supply = <&vcc5v0_sys>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm0m2_pins &fan_int>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA4 IRQ_TYPE_EDGE_FALLING>;
+		pwms = <&pwm0 0 50000 0>;
+		#cooling-cells = <2>;
+	};
+
+	vcc3v3_pcie30: vcc3v3-pcie30-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_pcie30";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpios = <&gpio2 RK_PC5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc3v3_pcie30_en>;
+		startup-delay-us = <5000>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v1_nldo_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&combphy2_psu {
+	status = "okay";
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+	mem-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+	mem-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+	mem-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+	mem-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+	mem-supply = <&vdd_cpu_lit_mem_s0>;
+};
+
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii-rxid";
+	pinctrl-0 = <&gmac1_miim
+		     &gmac1_tx_bus2
+		     &gmac1_rx_bus2
+		     &gmac1_rgmii_clk
+		     &gmac1_rgmii_bus>;
+	pinctrl-names = "default";
+
+	rx_delay = <0x00>;
+	tx_delay = <0x43>;
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0m2_xfer>;
+	status = "okay";
+
+	vdd_cpu_big0_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big0_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_cpu_big1_s0: regulator@43 {
+		compatible = "rockchip,rk8603", "rockchip,rk8602";
+		reg = <0x43>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big1_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1m2_xfer>;
+	status = "okay";
+
+	vdd_npu_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_npu_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <950000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		clock-output-names = "hym8563";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hym8563_int>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB0 IRQ_TYPE_LEVEL_LOW>;
+		wakeup-source;
+	};
+};
+
+&mdio1 {
+	rgmii_phy: ethernet-phy@1 {
+		/* RTL8211F */
+		compatible = "ethernet-phy-id001c.c916",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtl8211f_rst>;
+		reset-assert-us = <15000>;
+		reset-deassert-us = <50000>;
+		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pcie2x1l1 {
+	linux,pci-domain = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_reset>;
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pcie30phy {
+	status = "okay";
+};
+
+&pcie3x4 {
+	linux,pci-domain = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3_reset>;
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
+	status = "okay";
+};
+
+&pinctrl {
+	hym8563 {
+		hym8563_int: hym8563-int {
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	fan {
+		fan_int: fan-int {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie2 {
+		pcie2_reset: pcie2-reset {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie3 {
+		pcie3_reset: pcie3-reset {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vcc3v3_pcie30_en: pcie3-reg {
+			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	rtl8211f {
+		rtl8211f_rst: rtl8211f-rst {
+			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm0 {
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	status = "okay";
+};
+
+&spi2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
+	num-cs = <1>;
+
+	pmic@0 {
+		compatible = "rockchip,rk806";
+		spi-max-frequency = <1000000>;
+		reg = <0x0>;
+
+		interrupt-parent = <&gpio0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
+			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
+
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc5v0_sys>;
+		vcc6-supply = <&vcc5v0_sys>;
+		vcc7-supply = <&vcc5v0_sys>;
+		vcc8-supply = <&vcc5v0_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+		vcc10-supply = <&vcc5v0_sys>;
+		vcc11-supply = <&vcc_2v0_pldo_s3>;
+		vcc12-supply = <&vcc5v0_sys>;
+		vcc13-supply = <&vcc_1v1_nldo_s3>;
+		vcc14-supply = <&vcc_1v1_nldo_s3>;
+		vcca-supply = <&vcc5v0_sys>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		rk806_dvs1_null: dvs1-null-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs2_null: dvs2-null-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs3_null: dvs3-null-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun0";
+		};
+
+		regulators {
+			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_gpu_s0";
+				regulator-enable-ramp-delay = <400>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_lit_s0: vdd_cpu_lit_mem_s0: dcdc-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_cpu_lit_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_log_s0: dcdc-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <675000>;
+				regulator-max-microvolt = <750000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_log_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdd_vdenc_s0: vdd_vdenc_mem_s0: dcdc-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_vdenc_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_ddr_s0: dcdc-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <675000>;
+				regulator-max-microvolt = <900000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_ddr_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			vdd2_ddr_s3: dcdc-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vdd2_ddr_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_2v0_pldo_s3: dcdc-reg7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_2v0_pldo_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <2000000>;
+				};
+			};
+
+			vcc_3v3_s3: dcdc-reg8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_3v3_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vddq_ddr_s0: dcdc-reg9 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vddq_ddr_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s3: dcdc-reg10 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			avcc_1v8_s0: pldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "avcc_1v8_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s0: pldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_1v8_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			avdd_1v2_s0: pldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "avdd_1v2_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_3v3_s0: pldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vcc_3v3_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd_s0: pldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vccio_sd_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			pldo6_s3: pldo-reg6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "pldo6_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_0v75_s3: nldo-reg1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "vdd_0v75_s3";
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdd_ddr_pll_s0: nldo-reg2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-name = "vdd_ddr_pll_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			avdd_0v75_s0: nldo-reg3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "avdd_0v75_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_0v85_s0: nldo-reg4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-name = "vdd_0v85_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_0v75_s0: nldo-reg5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+				regulator-name = "vdd_0v75_s0";
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
+	status = "okay";
+};
+
+&uart9 {
+	pinctrl-0 = <&uart9m0_xfer>;
+	status = "okay";
+};
-- 
2.41.0

