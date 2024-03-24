Return-Path: <linux-kernel+bounces-115645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B32889CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD311F363AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC12072D3;
	Mon, 25 Mar 2024 02:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnTO1eFQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843D206CA1;
	Sun, 24 Mar 2024 23:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321514; cv=none; b=UrBYmGz+cuX7geWbwXBb95XhOIAr/NK7WDMW1+1hESyv84xjrdiBxr5THNta875YFeCbGQQS/MA5MJqOERhVCTGcglgFQQxdHw4Gzhh1nqukLNc+98cPX8QRKmKogTI3f3R/ti9AN+xawj9Bhw7OI06KgblDs7+lE5hXgm0iMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321514; c=relaxed/simple;
	bh=ZtJfLYOSXuHe5OiZtQWIWaJ/AbWxKre5dF2XmAkXSBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc4P1p6Zf5UFlT7NdxKGcNZ30O5OPIYW4y+EV98z+KOOQeTdlSD+evFcJtUudqE47LdyCAbw6xUB8KVBkreFGH6ZsCgWw6oUbipGoYJfDZq2vrc27wAnYqNeIdhumWzJNoLiSkq6b6qIuOQdJo1+dTrstar++uTCaHQSCIQVreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnTO1eFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57029C43399;
	Sun, 24 Mar 2024 23:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321514;
	bh=ZtJfLYOSXuHe5OiZtQWIWaJ/AbWxKre5dF2XmAkXSBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnTO1eFQ2NGLAm+i1+R/FlI7xWWcqgWFimbTNMhi0xM9EjBbzp7TvzWl+5zdSa1pc
	 GAjMpngr83RzOH8njcotDhI4b56G78HgB7V4BSUYu3IBa/8Rkn1Qynpf5M/BVM1w4L
	 0PR3jG1G15cUWZCNr2Ai7yiSQYizxkir/bWUY7hdqOziJIjLzTGsFMzlL8oNFXWyVX
	 0z9BQs4SeLxgR3+yOk7L+IhvOcZoiZ1JavZpTBgjIvQrJ2D//HlAHsvRK6Fc4sk1H8
	 UxaohtsPKqAq4KDZ4PiaNGEazLdkuztmK/8Ric6wj1IRtSaf6pg/+qcuZjMdnXk6eY
	 teLnrYnSX6JjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 240/638] arm64: dts: ti: k3-am642-evm: Add boot phase tags marking
Date: Sun, 24 Mar 2024 18:54:37 -0400
Message-ID: <20240324230116.1348576-241-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nishanth Menon <nm@ti.com>

[ Upstream commit 33830e077797ce4d7317b83a145f03bfde06ad4c ]

bootph-all as phase tag was added to dt-schema
(dtschema/schemas/bootph.yaml) to describe various node usage during
boot phases with DT.

Describe the same for AM642-evm boot devices.

Signed-off-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20230911172902.1057417-3-nm@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Stable-dep-of: 379c7752bbd0 ("arm64: dts: ti: k3-am64-main: Fix ITAP/OTAP values for MMC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index b4a1f73d4fb17..d0e1191baecd6 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -35,6 +35,7 @@ aliases {
 	};
 
 	memory@80000000 {
+		bootph-all;
 		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
@@ -108,6 +109,7 @@ rtos_ipc_memory_region: ipc-memories@a5000000 {
 
 	evm_12v0: regulator-0 {
 		/* main DC jack */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "evm_12v0";
 		regulator-min-microvolt = <12000000>;
@@ -129,6 +131,7 @@ vsys_5v0: regulator-1 {
 
 	vsys_3v3: regulator-2 {
 		/* output of LM5140 */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vsys_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -140,6 +143,7 @@ vsys_3v3: regulator-2 {
 
 	vdd_mmc1: regulator-3 {
 		/* TPS2051BD */
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
 		regulator-min-microvolt = <3300000>;
@@ -161,6 +165,7 @@ vddb: regulator-4 {
 	};
 
 	vtt_supply: regulator-5 {
+		bootph-all;
 		compatible = "regulator-fixed";
 		regulator-name = "vtt";
 		pinctrl-names = "default";
@@ -251,6 +256,7 @@ AM64X_IOPAD(0x0244, PIN_OUTPUT, 0)		/* (E14) UART1_TXD */
 	};
 
 	main_uart0_pins_default: main-uart0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0238, PIN_INPUT, 0) /* (B16) UART0_CTSn */
 			AM64X_IOPAD(0x023c, PIN_OUTPUT, 0) /* (A16) UART0_RTSn */
@@ -269,6 +275,7 @@ AM64X_IOPAD(0x0218, PIN_INPUT, 0) /* (A14) SPI0_D1 */
 	};
 
 	main_i2c0_pins_default: main-i2c0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0260, PIN_INPUT_PULLUP, 0) /* (A18) I2C0_SCL */
 			AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
@@ -276,6 +283,7 @@ AM64X_IOPAD(0x0264, PIN_INPUT_PULLUP, 0) /* (B18) I2C0_SDA */
 	};
 
 	main_i2c1_pins_default: main-i2c1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT_PULLUP, 0) /* (C18) I2C1_SCL */
 			AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
@@ -283,6 +291,7 @@ AM64X_IOPAD(0x026c, PIN_INPUT_PULLUP, 0) /* (B19) I2C1_SDA */
 	};
 
 	mdio1_pins_default: mdio1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x01fc, PIN_OUTPUT, 4) /* (R2) PRG0_PRU1_GPO19.MDIO0_MDC */
 			AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
@@ -290,6 +299,7 @@ AM64X_IOPAD(0x01f8, PIN_INPUT, 4) /* (P5) PRG0_PRU1_GPO18.MDIO0_MDIO */
 	};
 
 	rgmii1_pins_default: rgmii1-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x01cc, PIN_INPUT, 4) /* (W5) PRG0_PRU1_GPO7.RGMII1_RD0 */
 			AM64X_IOPAD(0x01d4, PIN_INPUT, 4) /* (Y5) PRG0_PRU1_GPO9.RGMII1_RD1 */
@@ -307,6 +317,7 @@ AM64X_IOPAD(0x00dc, PIN_OUTPUT, 4) /* (U15) PRG1_PRU0_GPO9.RGMII1_TX_CTL */
 	};
 
        rgmii2_pins_default: rgmii2-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0108, PIN_INPUT, 4) /* (W11) PRG1_PRU1_GPO0.RGMII2_RD0 */
 			AM64X_IOPAD(0x010c, PIN_INPUT, 4) /* (V11) PRG1_PRU1_GPO1.RGMII2_RD1 */
@@ -324,6 +335,7 @@ AM64X_IOPAD(0x0144, PIN_OUTPUT, 4) /* (Y11) PRG1_PRU1_GPO15.RGMII2_TX_CTL */
 	};
 
 	main_usb0_pins_default: main-usb0-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x02a8, PIN_OUTPUT, 0) /* (E19) USB0_DRVVBUS */
 		>;
@@ -366,6 +378,7 @@ AM64X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (C17) MCAN1_TX */
 	};
 
 	ddr_vtt_pins_default: ddr-vtt-default-pins {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
 		>;
@@ -373,6 +386,7 @@ AM64X_IOPAD(0x0030, PIN_OUTPUT_PULLUP, 7) /* (L18) OSPI0_CSN1.GPIO0_12 */
 };
 
 &main_uart0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
@@ -387,6 +401,7 @@ &main_uart1 {
 };
 
 &main_i2c0 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
@@ -400,12 +415,14 @@ eeprom@50 {
 };
 
 &main_i2c1 {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 
 	exp1: gpio@22 {
+		bootph-all;
 		compatible = "ti,tca6424";
 		reg = <0x22>;
 		gpio-controller;
@@ -438,6 +455,10 @@ display@3c {
 	};
 };
 
+&main_gpio0 {
+	bootph-all;
+};
+
 /* mcu_gpio0 is reserved for mcu firmware usage */
 &mcu_gpio0 {
 	status = "reserved";
@@ -467,6 +488,7 @@ &sdhci0 {
 
 &sdhci1 {
 	/* SD/MMC */
+	bootph-all;
 	vmmc-supply = <&vdd_mmc1>;
 	pinctrl-names = "default";
 	bus-width = <4>;
@@ -476,11 +498,13 @@ &sdhci1 {
 };
 
 &usbss0 {
+	bootph-all;
 	ti,vbus-divider;
 	ti,usb2-only;
 };
 
 &usb0 {
+	bootph-all;
 	dr_mode = "otg";
 	maximum-speed = "high-speed";
 	pinctrl-names = "default";
@@ -488,11 +512,13 @@ &usb0 {
 };
 
 &cpsw3g {
+	bootph-all;
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii1_pins_default>, <&rgmii2_pins_default>;
 };
 
 &cpsw_port1 {
+	bootph-all;
 	phy-mode = "rgmii-rxid";
 	phy-handle = <&cpsw3g_phy0>;
 };
@@ -503,11 +529,13 @@ &cpsw_port2 {
 };
 
 &cpsw3g_mdio {
+	bootph-all;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio1_pins_default>;
 
 	cpsw3g_phy0: ethernet-phy@0 {
+		bootph-all;
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-- 
2.43.0


