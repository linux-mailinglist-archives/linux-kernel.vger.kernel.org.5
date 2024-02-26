Return-Path: <linux-kernel+bounces-81335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B20F867463
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B461F22DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8079960258;
	Mon, 26 Feb 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTE4rIy1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712560249;
	Mon, 26 Feb 2024 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949269; cv=none; b=SkjDZlT8nxT8bcJ2pF5MYs0qKhARsiBzZYoXq960pcAL1NizKgYVwS2Cw3unEnnXEo2EUVpdCpeFkkQaeOUFTZlc+dsDR5Njc83wgZ2oD+LtNTd/UNvha3GrCyQWElfXCgObE7UvACNMd3VFQ+devtMDZpjLwRqqWiMg5mvzuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949269; c=relaxed/simple;
	bh=gJ2QNx2DGKpGtAzqz+TCpW1MHq/nl3gC2WB9YE55srY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkWC4Mt5c4UcmB68kFKHL7Ed7oEulsfqgKZQGqqlxGS5mWSe7X9QPbzMMuW8Vu/dyzy+dLVj+udNEIEtcDk1MF+HfBAhVuSuCil9/jX4U1iO3N3Dvfv2A/F+9IhV5tByzd7ZZcRHZz9NiULeebW2vnuZlRGehSzxbsmMuGa9mYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTE4rIy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16231C433F1;
	Mon, 26 Feb 2024 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708949269;
	bh=gJ2QNx2DGKpGtAzqz+TCpW1MHq/nl3gC2WB9YE55srY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qTE4rIy1o5JNlwA0Dt8vO5547rbsudWoPv+L86MwWLPAW4wbHHSQ0B1tnpBDcda0t
	 D8QEyNfdHlwCYOUo8MlFreb+cA3250q5MiTnfoCZhG2++G0o3CZqDaOJIaXVSCMPa4
	 JjqS5mB6sS2MeB65koaG2FxvB1l17QQrrhsBXF7W6rL1fFy4Fy22ATk3fad7C0tJ/q
	 324zyD2GMlPrtxfZ780O/ArEVWqJ2FE/4S/5iUphevy7VYhndxU1PD4xDTHE2Sg8dt
	 OXxNnQYMeLmRsJhNhrpUCqmYlS+pkchSreQc66SJeH364qUzPxsECopTZwHg4vahRL
	 Ev6EbuSlO3ckA==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 26 Feb 2024 14:03:09 +0200
Subject: [PATCH v6 3/4] arm64: dts: ti: k3-am62p: add the USB sub-system
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-3-acf77fff4344@kernel.org>
References: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org>
In-Reply-To: <20240226-b4-for-v6-5-am62-usb-typec-dt-v6-0-acf77fff4344@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5499; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=gJ2QNx2DGKpGtAzqz+TCpW1MHq/nl3gC2WB9YE55srY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl3H8GWMdAJXBLkQLH3FMk9lxS6W8yK7J5/h0z0
 vlIec0V5rOJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZdx/BgAKCRDSWmvTvnYw
 kzXhD/9ObwY7FjDXav1p49iBn5c0h+vBLUYdtMcxPgfpuGFqljMVhyyL/zqwtPzxs7sj5vj6NAu
 5N3GabEBOJYVzqUK3GlAXEATVfZxT7+hEofmyizsa5RWW05PdzIXBaEbwc8qQ/+acdLQ7PPMr5G
 Fjj7o0fXYZiY7pz+IYuK6YV9i4b7bN+m0SSRVD8JKKboAcSjnE7QioiV6ABp8rBnOmisbpr0ht1
 2aeaxw/iyRXt2bBlXlnIWd3MHlJsiz9kb8QQsoPtTL7PT3zyPotRGSkHrtg1YKbJcbSdgqriWpT
 T2v/KEV6N+WhLxObudZodG+2EzBCwpvvcfSDb+WtK4BlD0sTqBKGWuxM91zQvhjVnm/QhhDFw0V
 cnkJh4yAXmha82c7ff2fAXs4tphqXk15KHHs1Tv3v2ZdFzJ8bnHQo8VJigOjncHUr5fHc4Sn7Nf
 cAWFyq3pOmbkUCq6I3sETdOBfJ4bcFtBT0TDk5dnzuDaX/Rbc8hB96kpgZLoKF3opHZdEazUspD
 6pamcpdqw5WjcMocjENcUNfA8KMuuYa55hhJsWjKpdZkqhniFhFHt+p/FC2Ogzj+UysBW9CuQ0Q
 XAFXNaT6sN/mBD4NDiGvBayMrw3D+Yufju03ZPfViNDV4w3VvL3QCFmzZEr62vkj8VyKkWuJOl0
 wJ5FCea7oEeZu4g==
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
v6 - Rebased on next-20240226
v5 - disabled USB LPM feature as it is not supported.
v4 - no change. Added Andrew's Reviewed-by
v3 - no change
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


