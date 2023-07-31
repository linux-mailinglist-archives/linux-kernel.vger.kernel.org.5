Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42971768986
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjGaBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjGaBS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:18:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 980921A2;
        Sun, 30 Jul 2023 18:18:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA00D1692;
        Sun, 30 Jul 2023 18:19:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AACFC3F5A1;
        Sun, 30 Jul 2023 18:18:25 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: allwinner: h616: Add OrangePi Zero 3 board support
Date:   Mon, 31 Jul 2023 02:17:25 +0100
Message-Id: <20230731011725.7228-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20230731011725.7228-1-andre.przywara@arm.com>
References: <20230731011725.7228-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OrangePi Zero 3 is a development board based on the Allwinner H618 SoC,
which seems to be just an H616 with more L2 cache. The board itself is a
slightly updated version of the Orange Pi Zero 2. It features:
- Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
- 1/1.5/2/4 GiB LPDDR4 DRAM SKUs (only up to 1GB on the Zero2)
- AXP313a PMIC (more capable AXP305 on the Zero2)
- Raspberry-Pi-1 compatible GPIO header
- extra 13 pin expansion header, exposing pins for 2x USB 2.0 ports
- 1 USB 2.0 host port
- 1 USB 2.0 type C port (power supply + OTG)
- MicroSD slot
- on-board 16MiB bootable SPI NOR flash (only 2MB on the Zero2)
- 1Gbps Ethernet port (via Motorcomm YT8531 PHY) (RTL8211 on the Zero2)
- micro-HDMI port
- (yet) unsupported Allwinner WiFi/BT chip

Add the devicetree file describing the currently supported features,
namely LEDs, SD card, PMIC, SPI flash, Ethernet, USB.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-h618-orangepi-zero3.dts  | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 6a96494a2e0a3..3b0ad54062381 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -40,3 +40,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6-mini.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h618-orangepi-zero3.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
new file mode 100644
index 0000000000000..1964e27b7b187
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (C) 2023 Arm Ltd.
+ */
+
+/dts-v1/;
+
+#include "sun50i-h616-orangepi-zerox.dtsi"
+
+/ {
+	model = "OrangePi Zero3";
+	compatible = "xunlong,orangepi-zero3", "allwinner,sun50i-h618";
+};
+
+&emac0 {
+	phy-supply = <&reg_dldo1>;
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dldo1>;
+	broken-cd;
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp313: pmic@36 {
+		compatible = "x-powers,axp313a";
+		interrupt-parent = <&pio>;
+		interrupts = <2 9 IRQ_TYPE_LEVEL_LOW>;	/* PC9 */
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x36>;
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+
+		regulators {
+			/* Supplies VCC-PLL, so needs to be always on. */
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc1v8";
+			};
+
+			/* Supplies VCC-IO, so needs to be always on. */
+			reg_dldo1: dldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc3v3";
+			};
+
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-dram";
+			};
+		};
+	};
+};
+
+&pio {
+	vcc-pc-supply = <&reg_dldo1>;
+	vcc-pf-supply = <&reg_dldo1>;
+	vcc-pg-supply = <&reg_aldo1>;
+	vcc-ph-supply = <&reg_dldo1>;
+	vcc-pi-supply = <&reg_dldo1>;
+};
-- 
2.35.8

