Return-Path: <linux-kernel+bounces-44860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1331842839
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E39A1F27CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B686AF6;
	Tue, 30 Jan 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNjLsm/s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7C82D99;
	Tue, 30 Jan 2024 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629262; cv=none; b=bk2H48IvrvJor5m3Qs4SLtKcpZ/nIMJleOcqAMwMnAMw94kPFlSvEn1U/92wLO31TGz4akvqvRA2cGd7K5Sa27+33xJ5xWx0hlwEus6wF877UbIP6IhjNKwBlYWieK3uYdfJQxtjKAvlP2yBmQ54paAmta6YHlpHjfxcQv4lyfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629262; c=relaxed/simple;
	bh=ECHEowaol8e/oEy89OA54f0TFxnBzEohQY0MKdVwJU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJQV7NS8SarZtwZSxHUFHowNXuzqxHeKKLpHAv1Ctgc7+ykq1JaueAkUqSEdGvQ5UITvJIncXgV3bGVR7Pl7ssUKpc+hkmNjcakd8dHXHnUOXgmMN+szUWWQpBoLfnwgQG1U8RtmrPh/DoJxEOBaMznqd6tBdN0hsSRyxcZ+sGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNjLsm/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B229C433A6;
	Tue, 30 Jan 2024 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629262;
	bh=ECHEowaol8e/oEy89OA54f0TFxnBzEohQY0MKdVwJU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNjLsm/s1DL6uEw0f+crauj4nscywOYpXaoQDmOXEoDlBef/agEVFUdWVyUq6clvD
	 /dfJZIUf0gznuZd7uUwTWSan8wiSbwlAfZ2guMH6P0AsI7kWhGQOo+cDoZWlsaM5bm
	 Brvxmg5lzurGjw2oVQPIHLnvsZCeFzPm9qdsuTPP49iRR7pez55BAg61GoTAg/QzDr
	 OsgBxtmH1/pP/aplJYrZIJF7kNqFeJ9O0QMuNMIEeeYLETtSEKMJoYoGQi4nKbnOey
	 w7TZTodSZk0xYCyDgzOTfkogJjg7dHdNOZ1LI2VWqI8p5VwZjSiOMGDg0qQyWiwA16
	 4CZufpHcefpag==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com,
	lee@kernel.org
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 3/3] arm64: dts: ti: k3-am62p: add the USB sub-system
Date: Tue, 30 Jan 2024 17:40:35 +0200
Message-Id: <20240130154035.6901-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130154035.6901-1-rogerq@kernel.org>
References: <20240130154035.6901-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two USB instances available on the am62p5 starter kit. Include
and enable them for use on the board.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    Changelog:
    
    v2:
    - added USB PHY CTRL node changes here
    - changed USB wrapper node names to usb@
    - changed Type-C chip node name to usb-power-control@

 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 46 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 10 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts     | 67 +++++++++++++++++++++
 3 files changed, 123 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 4c51bae06b57..17d28390d587 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -560,6 +560,52 @@ sdhci2: mmc@fa20000 {
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
+		};
+	};
+
 	fss: bus@fc00000 {
 		compatible = "simple-bus";
 		reg = <0x00 0x0fc00000 0x00 0x70000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
index 19f42b39394e..00dd38b02a52 100644
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
index 1773c05f752c..80be56c0a4e0 100644
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
@@ -460,6 +498,35 @@ cpsw3g_phy1: ethernet-phy@1 {
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


