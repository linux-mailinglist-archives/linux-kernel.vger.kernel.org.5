Return-Path: <linux-kernel+bounces-142620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0914F8A2DED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7FD1F21FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4419D56B89;
	Fri, 12 Apr 2024 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV5xh5sC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CB56750;
	Fri, 12 Apr 2024 12:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923333; cv=none; b=dZyCb+jnSCD2rTfg5YErHxufKd9Ggu2SF4EII3E1mwnTscPInB/eUXXfGIy+z2ZCk1ZZBsN+jlafN8nDt8d0f7fpOOCG/fb8rg8K+XqyylvOEvdOhydB0AA2hedhX86JLmHHsi3M9goVrEcslRy2HDpYnyiF+J+TpPBMp//VOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923333; c=relaxed/simple;
	bh=kO5nMsXBO83eu+1bHylB8+WAgyYY3ZCW/zZsQSoVYt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFF77662zLhfy4X/LgCTCDBAtTHirUch3XKaEQlYSO5Sj+RuhQmWPZonZ3SberFpjkrKLNor6gqTbHqfoP2Df7QTgP0T1gzHfQcwI5rX42wvlABHpbtzd/3enm5VRW8hvypXQhICI6MEhOlVyPEz0qiKbPsU1orzIutgwy94JAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV5xh5sC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F98C113CC;
	Fri, 12 Apr 2024 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712923333;
	bh=kO5nMsXBO83eu+1bHylB8+WAgyYY3ZCW/zZsQSoVYt0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nV5xh5sCKzD4QLygTuLVP1Mmt+oCc0d5Oz1KkSSdpch0HeiKw3PkKTR8Fj063O2D5
	 iR7/DfzMPmGvOJ9zLoWY0tY9zB1Wfcj4cULNZg71XZSLVCOSM4ZpxR2ACzsP6IXkr2
	 JtluuACIPf2oDjqQwC/qup8Cgz8Upe++AWvdDVLyTHTUiQCSMng8FdRX6Oycg+Kwnv
	 57/BhLf9j+xDpEoBuQwuChFJ1KNhc41e3e7eNoVENGc1diKfJv3ItTYnFZs/lCdIzZ
	 TXsCDJ2hK73RP66mjO0TBbIpShqnTa6gIvkKpzXAEETxqN1s2Imbaf1BskPyFjoDkj
	 rYMgdNsq/gFsQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 12 Apr 2024 15:01:59 +0300
Subject: [PATCH v7 2/3] arm64: dts: ti: k3-am62p: add the USB sub-system
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-for-v6-10-am62-usb-typec-dt-v7-2-93b827adf97e@kernel.org>
References: <20240412-for-v6-10-am62-usb-typec-dt-v7-0-93b827adf97e@kernel.org>
In-Reply-To: <20240412-for-v6-10-am62-usb-typec-dt-v7-0-93b827adf97e@kernel.org>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Andrew Davis <afd@ti.com>, b-liu@ti.com, srk@ti.com, 
 r-gunasekaran@ti.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5735; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=kO5nMsXBO83eu+1bHylB8+WAgyYY3ZCW/zZsQSoVYt0=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmGSK6UCKHwh5eGWDSQtygP0XlcI9PNcPQU/PFz
 +Zjy/EShp+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZhkiugAKCRDSWmvTvnYw
 kz4RD/0X1/ryGPqHinE7ygEa1vNKumgL3jwmSPUF6DEt9rzuhbr6CTuqyTgV0zM06THYbiPSbhR
 paJRg2Dwx5cMiA8D/LdNngosdnbMF0V091+AZfD9042CyybYVe+WjbJt+WQFWfVmrSkbiKZ9orA
 asvy6XbSBkaK0jSuMTnvDWZn6oPhKI3EU+IYxSiwISurFhpzfPhDTalxoS/Dax/+X7+Hym3ubIe
 5dt6F/w+ct/CK4C+dmFlCYeiJdD1cd+5tjya+ocG5wA0VzwePdX5DatjCH9GwsNgeyAV+6iLF+M
 gYjGsG/dUKdEZyyfErIm7elEDbyroYiMOiR/kbAttzPi4HO6wRi23IwXouBtcIfkHjhyH/7yZ95
 iNvHKU2jfSVCntunkKlOPkYLZCSrxwt4mWq+RWRvn6+DPnd7GwOnQZfdWGR7jpNiPXPolxuK+OQ
 eUYHt7P2eYwI1iv+rufCpvQcaDJdFajDL7I+sOa1LlDMXNcb0/o/wFRfsVY8YQWNllBJLsRS0p/
 3QTux1eiLpz5QIm1mbNEWr1jLhymea9rvQPRWlGT/hPmIqupCDxqm9z0wEhm2/FjQrdZYIVVDf0
 Q3bk5vZVQZE2lzzb+t2BjVy9KOJDZTHEEjrY0on7qOPGqJyIgByMTIGz+G2nEEAQkciQmllpdkR
 wPo4QGVQdCN3L1w==
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
v7 - Rebased to v6.9-rc1. Added USB PHY2 region for Errata i2409.
v6 - Rebased on next-20240226
v5 - disabled USB LPM feature as it is not supported.
v4 - no change. Added Andrew's Reviewed-by
v3 - no change
v2:
- moved am62p changes to next patch
- use new compatible for USB PHY CTRL node

merge: am62p add USB PHY2 region

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 52 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 10 +++++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts     | 67 +++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 88bc64111234..900d1f9530a2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -635,6 +635,58 @@ sdhci2: mmc@fa20000 {
 		status = "disabled";
 	};
 
+	usbss0: usb@f900000 {
+		compatible = "ti,am62-usb";
+		reg = <0x00 0x0f900000 0x00 0x800>,
+		      <0x00 0x0f908000 0x00 0x400>;
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
+		reg = <0x00 0x0f910000 0x00 0x800>,
+		      <0x00 0x0f918000 0x00 0x400>;
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
index 6a9c99c5fb2a..6e7234659111 100644
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
@@ -466,6 +504,35 @@ cpsw3g_phy1: ethernet-phy@1 {
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


