Return-Path: <linux-kernel+bounces-78359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ECD86125E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F47284A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB97EEEA;
	Fri, 23 Feb 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGYbyLuJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56E7F495;
	Fri, 23 Feb 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693983; cv=none; b=WDWksLqdHEv3MNPIw6l3u84CpT3lExK1D0Tz/I2Lqer6fiHQLOQeuVYQ2hQ/kSIrzKJZfgcW2099+Q4miYswkfMNh+R0V0zDETkLFvdlvZpgIlZW9UHLl9zJ7KPM73mpo8zZSVdtJgKj3NoCQ4BSdTUv0r+N3DOImV4oFTzoKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693983; c=relaxed/simple;
	bh=7MMdY/AqShvbBezEAI37o47xKqwsWMIXgoQhIliELQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUnxCKXDnGbMMDDbfz/56gi5hkEKSZtcWesEnv8RNHBqUYjvGe+w2sVXXxuFfhMQG8Dj/MggD3OI8FRUhGUXz1ISYXxmry1iKZXNrxv95gxvOFGm/rBer1dd7/3rUQeGNvrZF8SgsQi12BJ668CIFnuZ0LMQWhtRb7WHRK4xvT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGYbyLuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3A8C433F1;
	Fri, 23 Feb 2024 13:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708693983;
	bh=7MMdY/AqShvbBezEAI37o47xKqwsWMIXgoQhIliELQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JGYbyLuJYbTp4sugEtSzIl+JvPmSdLZl7N5NWMVJQipthfFMyfTj7SP4QscKT7mVM
	 3SpxXk4RxW+reWZnvzHbFId9p4KFZPYaYibQfgE8IIbMonpgZVEakRPEBEYc5jsakQ
	 3hpM2aDi5YBbazhgWWIIMF53pNLCqHI0Kyf2Qw5FLxwtVWMG2aFnLsLnSlDxWlHi9K
	 Z9ui+YauTmmvGXkl6a+kUeENoJbWOmTVxOCXH1mH+s0/cv8vrcG4KAbY/FH4SPauVK
	 yOIeYMEpbhZxr9YzDI59vAzAL1Vi+yphwNKolnH8jJttVToUrOjrZhW9StPJup1vU3
	 ivu8xmHYMRT2w==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 23 Feb 2024 15:12:40 +0200
Subject: [PATCH v5 3/4] arm64: dts: ti: k3-am62p: add the USB sub-system
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-3-4b5854d17d18@kernel.org>
References: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org>
In-Reply-To: <20240223-b4-for-v6-5-am62-usb-typec-dt-v5-0-4b5854d17d18@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5619; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=7MMdY/AqShvbBezEAI37o47xKqwsWMIXgoQhIliELQk=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl2JnQbmlQDDjuOLxFgbE8kMU9W3vZDXW0B9I1W
 V7GmcKg/NaJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdiZ0AAKCRDSWmvTvnYw
 k888EADEZo1hAzIazNKb8EFwPXTwn/D1wP4RpybRKj5uj/Nzxo18Cwz01Akd0oNcEokjYJ5qWqy
 igtbYu+VLDTYY3gYR042IJ+lhzXkzkWYnQn3PRZUFVqsyawMhifGjgKLlWtj8vG+6W7EL0m1VxP
 47h9Jc7P3/xJWVRSPG1uw+AvuG4q2oN2u1U4TrEBNswnF4AwZU7gFQic4trxIQ4TYx815uWkEz4
 IOUhyrxBBJvtxnc13OleMBkD70AxCeVq93nugMwItWKfj3bW1IlrCf3aFep5OZPGtv1fjww6Y3r
 OHVDjhZDa31SZhLYSlcz/j7hoxTlCA3CsNxofnKqFSLFimUdc/yHAQVoDd77FEOgQ05yYxr4jIu
 zfkoKxqMPvhO9s/slWivuG6ouY1R0Ngeu4Fkahn/Na1EZunkEO2SKEinM5PbbDjtfYZDw82kpuB
 I3PnZPbN5g3TWkMGpCoCG1Vyu6Q8KFY+W52Sjlb35tnb4R3yPNUIq1EE1BU1BIwise8zkjeKB2I
 evodkjOXqtVlrtoeIY/j+7WrqvcmFH5jTNBHDQlwDWnjRhiU2zMZQ5cZs11191QQexGw8W36apK
 3zutj6Kja/DUJjfixyy4bLWBwXQhzdrk6MsQacDdseNfh40PXpi9MGrFQKP5NgMlrO6v5neA8P6
 OzfFWxZDdK+8dvw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

There are two USB instances available on the am62p5 starter kit. Include
and enable them for use on the board.

USB LPM feature is kept disabled as it is not supported.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Andrew Davis <afd@ti.com>
---
Changelog:
v5 - disabled USB LPM feature as it is not supported.
v4 - no change. Added Andrew's Reviewed-by
     https://lore.kernel.org/all/20240205135908.54656-4-rogerq@kernel.org/
v3 - no change
     https://lore.kernel.org/all/20240201120332.4811-3-rogerq@kernel.org/
v2:
- moved am62p changes to next patch
- use new compatible for USB PHY CTRL node
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 50 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 10 +++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts     | 67 +++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 7337a9e13535..46d35036d2d5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -635,6 +635,56 @@ sdhci2: mmc@fa20000 {
 		status = "disabled";
 	};
 
+	usbss0: usb@f900000 {
+		compatible = "ti,am62-usb";
+		reg = <0x00 0x0f900000 0x00 0x800>;
+		clocks = <&k3_clks 161 3>;
+		clock-names = "ref";
+		ti,syscon-phy-pll-refclk = <&usb0_phy_ctrl 0x0>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
+		ranges;
+		status = "disabled";
+
+		usb0: usb@31000000 {
+			compatible = "snps,dwc3";
+			reg = <0x00 0x31000000 0x00 0x50000>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
+			<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
+			interrupt-names = "host", "peripheral";
+			maximum-speed = "high-speed";
+			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
+		};
+	};
+
+	usbss1: usb@f910000 {
+		compatible = "ti,am62-usb";
+		reg = <0x00 0x0f910000 0x00 0x800>;
+		clocks = <&k3_clks 162 3>;
+		clock-names = "ref";
+		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
+		ranges;
+		status = "disabled";
+
+		usb1: usb@31100000 {
+			compatible = "snps,dwc3";
+			reg = <0x00 0x31100000 0x00 0x50000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
+			<GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
+			interrupt-names = "host", "peripheral";
+			maximum-speed = "high-speed";
+			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
+		};
+	};
+
 	fss: bus@fc00000 {
 		compatible = "simple-bus";
 		reg = <0x00 0x0fc00000 0x00 0x70000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
index a84756c336d0..c71d9624ea27 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
@@ -18,6 +18,16 @@ chipid: chipid@14 {
 			reg = <0x14 0x4>;
 			bootph-all;
 		};
+
+		usb0_phy_ctrl: syscon@4008 {
+			compatible = "ti,am62-usb-phy-ctrl", "syscon";
+			reg = <0x4008 0x4>;
+		};
+
+		usb1_phy_ctrl: syscon@4018 {
+			compatible = "ti,am62-usb-phy-ctrl", "syscon";
+			reg = <0x4018 0x4>;
+		};
 	};
 
 	wkup_uart0: serial@2b300000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index e86f34e835c1..b63888a4842d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -27,6 +27,8 @@ aliases {
 		spi0 = &ospi0;
 		ethernet0 = &cpsw_port1;
 		ethernet1 = &cpsw_port2;
+		usb0 = &usb0;
+		usb1 = &usb1;
 	};
 
 	chosen {
@@ -297,6 +299,12 @@ AM62PX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (G20) MCASP0_ACLKR.UART1_TXD */
 		bootph-all;
 	};
 
+	main_usb1_pins_default: main-usb1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0258, PIN_INPUT, 0) /* (G21) USB1_DRVVBUS */
+		>;
+	};
+
 	main_wlirq_pins_default: main-wlirq-default-pins {
 		pinctrl-single,pins = <
 			AM62PX_IOPAD(0x0128, PIN_INPUT, 7) /* (K25) MMC2_SDWP.GPIO0_72 */
@@ -340,6 +348,36 @@ AM62PX_IOPAD(0x0124, PIN_INPUT, 7) /* (J25) MMC2_SDCD.GPIO0_71 */
 	};
 };
 
+&main_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+
+	typec_pd0: usb-power-controller@3f {
+		compatible = "ti,tps6598x";
+		reg = <0x3f>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			self-powered;
+			data-role = "dual";
+			power-role = "sink";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					usb_con_hs: endpoint {
+						remote-endpoint = <&usb0_hs_ep>;
+					};
+				};
+			};
+		};
+	};
+};
+
 &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
@@ -463,6 +501,35 @@ cpsw3g_phy1: ethernet-phy@1 {
 	};
 };
 
+&usbss0 {
+	status = "okay";
+	ti,vbus-divider;
+};
+
+&usbss1 {
+	status = "okay";
+	ti,vbus-divider;
+};
+
+&usb0 {
+	usb-role-switch;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@0 {
+		reg = <0>;
+		usb0_hs_ep: endpoint {
+			remote-endpoint = <&usb_con_hs>;
+		};
+	};
+};
+
+&usb1 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_pins_default>;
+};
+
 &mcasp1 {
 	status = "okay";
 	#sound-dai-cells = <0>;

-- 
2.34.1


