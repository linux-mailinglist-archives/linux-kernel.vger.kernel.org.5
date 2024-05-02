Return-Path: <linux-kernel+bounces-166570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB7E8B9C8D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB71F22015
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705BE153BE3;
	Thu,  2 May 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mk7PY2IG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C8153BC4;
	Thu,  2 May 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660699; cv=none; b=o42Mvb/h4gxXkCgRKnkJacrvyUu/ghNzVut9XwK8j02lqxRRk+IzFeDOaBAIBZsX7r94OeDuSh0zAo7J+3gT6KWCmvXeK63eCwvQ7fXWhodAEdaj1OE7Jgd5HLLB3wItTRb/jlDofRFkKxCiP6c94k64DJ+NIOJk8GhRwmjUlzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660699; c=relaxed/simple;
	bh=dR9l3MhGDfH0SJpc1xSgr2Jq6+cKoPvCDbv8gFx6KQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIQ07n7c8NQp1+11NwxSx448ILx/o639Dg/VWtzUNNaemjxB+FNWRVWvk2H3p9UU3fmb34qiyGJKLCl3QKKk7hWYDXn3TUf2Zjk0e1g2iUvsN8Pk98AYzwOBLyd3eEK9GDXWsWiJsghRIrVuB5LCztXVXTHwfKPsdIxtV4rJ2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mk7PY2IG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47502C4AF18;
	Thu,  2 May 2024 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714660699;
	bh=dR9l3MhGDfH0SJpc1xSgr2Jq6+cKoPvCDbv8gFx6KQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mk7PY2IG7Nc8F8VU/XTeX9UR/d7P+yG4pgXKHDVDGlSfwP4H63LU2zlsNwEqObEuk
	 lrT8nHCgn3yoUQmDb9UqbduM1TGOPH5k4TRFyp1uXafvJ5ynRtYARC+vxnroPk0Atl
	 zVSQrJH54uF3mcRnThvxAIyoMXexrOKEIbQ0qiCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.90
Date: Thu,  2 May 2024 16:38:07 +0200
Message-ID: <2024050207-mundane-delusion-b8d2@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024050207-fanning-blot-4ba4@gregkh>
References: <2024050207-fanning-blot-4ba4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 6394f5dc2303..e3894c928118 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -205,6 +205,11 @@ Will increase power usage.
 
 Default: 0 (off)
 
+mem_pcpu_rsv
+------------
+
+Per-cpu reserved forward alloc cache size in page units. Default 1MB per CPU.
+
 rmem_default
 ------------
 
diff --git a/Makefile b/Makefile
index a0472e1cf715..7ae5cf9ec9e5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 89
+SUBLEVEL = 90
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/Kconfig b/arch/Kconfig
index f99fd9a4ca77..e959abf969ec 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -9,6 +9,14 @@
 #
 source "arch/$(SRCARCH)/Kconfig"
 
+config ARCH_CONFIGURES_CPU_MITIGATIONS
+	bool
+
+if !ARCH_CONFIGURES_CPU_MITIGATIONS
+config CPU_MITIGATIONS
+	def_bool y
+endif
+
 menu "General architecture-dependent options"
 
 config CRASH_CORE
diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 6691f4255077..41b980df862b 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -205,7 +205,6 @@ dmac_cfg_clk: dmac-gpu-cfg-clk {
 		};
 
 		gmac: ethernet@8000 {
-			#interrupt-cells = <1>;
 			compatible = "snps,dwmac";
 			reg = <0x8000 0x2000>;
 			interrupts = <10>;
diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 4af8a1c96ed6..bede6e88ae11 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -293,7 +293,7 @@ vddcore: VDD_CORE {
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
-						regulator-suspend-voltage = <1150000>;
+						regulator-suspend-microvolt = <1150000>;
 						regulator-mode = <4>;
 					};
 
@@ -314,7 +314,7 @@ vddcpu: VDD_OTHER {
 
 					regulator-state-standby {
 						regulator-on-in-suspend;
-						regulator-suspend-voltage = <1050000>;
+						regulator-suspend-microvolt = <1050000>;
 						regulator-mode = <4>;
 					};
 
@@ -331,7 +331,7 @@ vldo1: LDO1 {
 					regulator-always-on;
 
 					regulator-state-standby {
-						regulator-suspend-voltage = <1800000>;
+						regulator-suspend-microvolt = <1800000>;
 						regulator-on-in-suspend;
 					};
 
@@ -346,7 +346,7 @@ vldo2: LDO2 {
 					regulator-max-microvolt = <3700000>;
 
 					regulator-state-standby {
-						regulator-suspend-voltage = <1800000>;
+						regulator-suspend-microvolt = <1800000>;
 						regulator-on-in-suspend;
 					};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index d31a194124c9..03fd9df16999 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -128,7 +128,7 @@ ethernet_phy0: ethernet-phy@5 {
 };
 
 &pio {
-	eth_default: eth_default {
+	eth_default: eth-default-pins {
 		tx_pins {
 			pinmux = <MT2712_PIN_71_GBE_TXD3__FUNC_GBE_TXD3>,
 				 <MT2712_PIN_72_GBE_TXD2__FUNC_GBE_TXD2>,
@@ -155,7 +155,7 @@ mdio_pins {
 		};
 	};
 
-	eth_sleep: eth_sleep {
+	eth_sleep: eth-sleep-pins {
 		tx_pins {
 			pinmux = <MT2712_PIN_71_GBE_TXD3__FUNC_GPIO71>,
 				 <MT2712_PIN_72_GBE_TXD2__FUNC_GPIO72>,
@@ -181,14 +181,14 @@ mdio_pins {
 		};
 	};
 
-	usb0_id_pins_float: usb0_iddig {
+	usb0_id_pins_float: usb0-iddig-pins {
 		pins_iddig {
 			pinmux = <MT2712_PIN_12_IDDIG_P0__FUNC_IDDIG_A>;
 			bias-pull-up;
 		};
 	};
 
-	usb1_id_pins_float: usb1_iddig {
+	usb1_id_pins_float: usb1-iddig-pins {
 		pins_iddig {
 			pinmux = <MT2712_PIN_14_IDDIG_P1__FUNC_IDDIG_B>;
 			bias-pull-up;
diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index 1ac0b2cf3d40..fde2b165f55d 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -249,10 +249,11 @@ topckgen: syscon@10000000 {
 		#clock-cells = <1>;
 	};
 
-	infracfg: syscon@10001000 {
+	infracfg: clock-controller@10001000 {
 		compatible = "mediatek,mt2712-infracfg", "syscon";
 		reg = <0 0x10001000 0 0x1000>;
 		#clock-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	pericfg: syscon@10003000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 7bb316922a3a..f8a32006885b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -251,7 +251,7 @@ scpsys: power-controller@10006000 {
 		clock-names = "hif_sel";
 	};
 
-	cir: cir@10009000 {
+	cir: ir-receiver@10009000 {
 		compatible = "mediatek,mt7622-cir";
 		reg = <0 0x10009000 0 0x1000>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>;
@@ -282,16 +282,14 @@ thermal_calibration: calib@198 {
 		};
 	};
 
-	apmixedsys: apmixedsys@10209000 {
-		compatible = "mediatek,mt7622-apmixedsys",
-			     "syscon";
+	apmixedsys: clock-controller@10209000 {
+		compatible = "mediatek,mt7622-apmixedsys";
 		reg = <0 0x10209000 0 0x1000>;
 		#clock-cells = <1>;
 	};
 
-	topckgen: topckgen@10210000 {
-		compatible = "mediatek,mt7622-topckgen",
-			     "syscon";
+	topckgen: clock-controller@10210000 {
+		compatible = "mediatek,mt7622-topckgen";
 		reg = <0 0x10210000 0 0x1000>;
 		#clock-cells = <1>;
 	};
@@ -514,7 +512,6 @@ thermal: thermal@1100b000 {
 			 <&pericfg CLK_PERI_AUXADC_PD>;
 		clock-names = "therm", "auxadc";
 		resets = <&pericfg MT7622_PERI_THERM_SW_RST>;
-		reset-names = "therm";
 		mediatek,auxadc = <&auxadc>;
 		mediatek,apmixedsys = <&apmixedsys>;
 		nvmem-cells = <&thermal_calibration>;
@@ -734,9 +731,8 @@ wmac: wmac@18000000 {
 		power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
 	};
 
-	ssusbsys: ssusbsys@1a000000 {
-		compatible = "mediatek,mt7622-ssusbsys",
-			     "syscon";
+	ssusbsys: clock-controller@1a000000 {
+		compatible = "mediatek,mt7622-ssusbsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -793,9 +789,8 @@ u2port1: usb-phy@1a0c5000 {
 		};
 	};
 
-	pciesys: pciesys@1a100800 {
-		compatible = "mediatek,mt7622-pciesys",
-			     "syscon";
+	pciesys: clock-controller@1a100800 {
+		compatible = "mediatek,mt7622-pciesys";
 		reg = <0 0x1a100800 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -921,12 +916,13 @@ sata_port: sata-phy@1a243000 {
 		};
 	};
 
-	hifsys: syscon@1af00000 {
-		compatible = "mediatek,mt7622-hifsys", "syscon";
+	hifsys: clock-controller@1af00000 {
+		compatible = "mediatek,mt7622-hifsys";
 		reg = <0 0x1af00000 0 0x70>;
+		#clock-cells = <1>;
 	};
 
-	ethsys: syscon@1b000000 {
+	ethsys: clock-controller@1b000000 {
 		compatible = "mediatek,mt7622-ethsys",
 			     "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
@@ -966,9 +962,7 @@ wed1: wed@1020b000 {
 	};
 
 	eth: ethernet@1b100000 {
-		compatible = "mediatek,mt7622-eth",
-			     "mediatek,mt2701-eth",
-			     "syscon";
+		compatible = "mediatek,mt7622-eth";
 		reg = <0 0x1b100000 0 0x20000>;
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 224 IRQ_TYPE_LEVEL_LOW>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index d5d9b954c449..2147e152683b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1554,6 +1554,7 @@ mfgcfg: syscon@13000000 {
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
 			#clock-cells = <1>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_MFG_ASYNC>;
 		};
 
 		gpu: gpu@13040000 {
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index c6080af1e4a3..0814ed6a7272 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -903,7 +903,7 @@ regulators {
 			mt6315_6_vbuck1: vbuck1 {
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
-				regulator-min-microvolt = <300000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-allowed-modes = <0 1 2>;
@@ -913,7 +913,7 @@ mt6315_6_vbuck1: vbuck1 {
 			mt6315_6_vbuck3: vbuck3 {
 				regulator-compatible = "vbuck3";
 				regulator-name = "Vlcpu";
-				regulator-min-microvolt = <300000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-allowed-modes = <0 1 2>;
@@ -930,7 +930,7 @@ regulators {
 			mt6315_7_vbuck1: vbuck1 {
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
-				regulator-min-microvolt = <606250>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <800000>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-allowed-modes = <0 1 2>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 4ed8a0f18758..7ecba8c7262d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1240,6 +1240,7 @@ mutex: mutex@14001000 {
 			reg = <0 0x14001000 0 0x1000>;
 			interrupts = <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&mmsys CLK_MM_DISP_MUTEX0>;
+			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x1000 0x1000>;
 			mediatek,gce-events = <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_0>,
 					      <CMDQ_EVENT_DISP_STREAM_DONE_ENG_EVENT_1>;
 			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 4b8a1c462906..9180a73db066 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -845,7 +845,7 @@ regulators {
 			mt6315_6_vbuck1: vbuck1 {
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
-				regulator-min-microvolt = <300000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-ramp-delay = <6250>;
@@ -863,7 +863,7 @@ regulators {
 			mt6315_7_vbuck1: vbuck1 {
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
-				regulator-min-microvolt = <625000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1193750>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-ramp-delay = <6250>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 414cbe345127..bdf002e9cece 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1492,6 +1492,7 @@ vppsys0: clock-controller@14000000 {
 			compatible = "mediatek,mt8195-vppsys0";
 			reg = <0 0x14000000 0 0x1000>;
 			#clock-cells = <1>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0 0x1000>;
 		};
 
 		smi_sub_common_vpp0_vpp1_2x1: smi@14010000 {
@@ -1597,6 +1598,7 @@ vppsys1: clock-controller@14f00000 {
 			compatible = "mediatek,mt8195-vppsys1";
 			reg = <0 0x14f00000 0 0x1000>;
 			#clock-cells = <1>;
+			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0 0x1000>;
 		};
 
 		larb5: larb@14f02000 {
@@ -1982,6 +1984,7 @@ vdosys0: syscon@1c01a000 {
 			reg = <0 0x1c01a000 0 0x1000>;
 			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
 			#clock-cells = <1>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0xa000 0x1000>;
 		};
 
 		larb20: larb@1b010000 {
@@ -2085,6 +2088,7 @@ mutex: mutex@1c016000 {
 			interrupts = <GIC_SPI 658 IRQ_TYPE_LEVEL_HIGH 0>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_MUTEX0>;
+			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0x6000 0x1000>;
 			mediatek,gce-events = <CMDQ_EVENT_VDO0_DISP_STREAM_DONE_0>;
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 194e48c755f6..a51e8d0493ca 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -789,7 +789,6 @@ &pcie_phy {
 };
 
 &pcie0 {
-	bus-scan-delay-ms = <1000>;
 	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index aa3e21bd6c8f..937a15005eb0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -401,16 +401,22 @@ &io_domains {
 	gpio1830-supply = <&vcc_1v8>;
 };
 
-&pmu_io_domains {
-	status = "okay";
-	pmu1830-supply = <&vcc_1v8>;
-};
-
-&pwm2 {
-	status = "okay";
+&pcie_clkreqn_cpm {
+	rockchip,pins =
+		<2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_up>;
 };
 
 &pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&q7_thermal_pin>;
+
+	gpios {
+		q7_thermal_pin: q7-thermal-pin {
+			rockchip,pins =
+				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
 	i2c8 {
 		i2c8_xfer_a: i2c8-xfer {
 			rockchip,pins =
@@ -443,11 +449,20 @@ vcc5v0_host_en: vcc5v0-host-en {
 	usb3 {
 		usb3_id: usb3-id {
 			rockchip,pins =
-			  <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+			  <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 };
 
+&pmu_io_domains {
+	status = "okay";
+	pmu1830-supply = <&vcc_1v8>;
+};
+
+&pwm2 {
+	status = "okay";
+};
+
 &sdhci {
 	/*
 	 * Signal integrity isn't great at 200MHz but 100MHz has proven stable
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index 26d7fda275ed..856fe4b66a0b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -412,6 +412,8 @@ regulator-state-mem {
 
 			vccio_sd: LDO_REG5 {
 				regulator-name = "vccio_sd";
+				regulator-always-on;
+				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 
@@ -521,9 +523,9 @@ &mdio0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 
-	switch@0 {
+	switch@1f {
 		compatible = "mediatek,mt7531";
-		reg = <0>;
+		reg = <0x1f>;
 
 		ports {
 			#address-cells = <1>;
diff --git a/arch/loongarch/include/asm/perf_event.h b/arch/loongarch/include/asm/perf_event.h
index 2a35a0bc2aaa..52b638059e40 100644
--- a/arch/loongarch/include/asm/perf_event.h
+++ b/arch/loongarch/include/asm/perf_event.h
@@ -7,6 +7,14 @@
 #ifndef __LOONGARCH_PERF_EVENT_H__
 #define __LOONGARCH_PERF_EVENT_H__
 
+#include <asm/ptrace.h>
+
 #define perf_arch_bpf_user_pt_regs(regs) (struct user_pt_regs *)regs
 
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+	(regs)->csr_era = (__ip); \
+	(regs)->regs[3] = current_stack_pointer; \
+	(regs)->regs[22] = (unsigned long) __builtin_frame_address(0); \
+}
+
 #endif /* __LOONGARCH_PERF_EVENT_H__ */
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index b829ab911a17..007718d51f09 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -193,10 +193,10 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-		if (!(vma->vm_flags & VM_READ) && address != exception_era(regs))
-			goto bad_area;
 		if (!(vma->vm_flags & VM_EXEC) && address == exception_era(regs))
 			goto bad_area;
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE)) && address != exception_era(regs))
+			goto bad_area;
 	}
 
 	/*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 63055c6ad2c2..2d9416a6a070 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -799,8 +799,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #define PAGE_SHARED		__pgprot(0)
 #define PAGE_KERNEL		__pgprot(0)
 #define swapper_pg_dir		NULL
-#define TASK_SIZE		0xffffffffUL
-#define VMALLOC_START		0
+#define TASK_SIZE		_AC(-1, UL)
+#define VMALLOC_START		_AC(0, UL)
 #define VMALLOC_END		TASK_SIZE
 
 #endif /* !CONFIG_MMU */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5f7a86f240db..49cea5b81649 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -61,6 +61,7 @@ config X86
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
+	select ARCH_CONFIGURES_CPU_MITIGATIONS
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64
@@ -2449,17 +2450,17 @@ config CC_HAS_SLS
 config CC_HAS_RETURN_THUNK
 	def_bool $(cc-option,-mfunction-return=thunk-extern)
 
-menuconfig SPECULATION_MITIGATIONS
-	bool "Mitigations for speculative execution vulnerabilities"
+menuconfig CPU_MITIGATIONS
+	bool "Mitigations for CPU vulnerabilities"
 	default y
 	help
-	  Say Y here to enable options which enable mitigations for
-	  speculative execution hardware vulnerabilities.
+	  Say Y here to enable options which enable mitigations for hardware
+	  vulnerabilities (usually related to speculative execution).
 
 	  If you say N, all mitigations will be disabled. You really
 	  should know what you are doing to say so.
 
-if SPECULATION_MITIGATIONS
+if CPU_MITIGATIONS
 
 config PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 1f97d00ad858..100a752c33bb 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -13,9 +13,10 @@ enum cc_vendor {
 };
 
 extern enum cc_vendor cc_vendor;
-extern u64 cc_mask;
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+extern u64 cc_mask;
+
 static inline void cc_set_mask(u64 mask)
 {
 	RIP_REL_REF(cc_mask) = mask;
@@ -25,6 +26,8 @@ u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
 void cc_random_init(void);
 #else
+static const u64 cc_mask = 0;
+
 static inline u64 cc_mkenc(u64 val)
 {
 	return val;
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index f6116b66f289..f0b9b37c4609 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -127,7 +127,7 @@
  */
 #define _COMMON_PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	       \
 				 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |\
-				 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC | \
+				 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_CC | \
 				 _PAGE_UFFD_WP)
 #define _PAGE_CHG_MASK	(_COMMON_PAGE_CHG_MASK | _PAGE_PAT)
 #define _HPAGE_CHG_MASK (_COMMON_PAGE_CHG_MASK | _PAGE_PSE | _PAGE_PAT_LARGE)
@@ -153,6 +153,7 @@ enum page_cache_mode {
 };
 #endif
 
+#define _PAGE_CC		(_AT(pteval_t, cc_mask))
 #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
 
 #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7f94dbbc397b..a0d3059bee3d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -137,7 +137,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 		       log_lvl, d3, d6, d7);
 	}
 
-	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
+	if (cr4 & X86_CR4_PKE)
 		printk("%sPKRU: %08x\n", log_lvl, read_pkru());
 }
 
diff --git a/crypto/algapi.c b/crypto/algapi.c
index c73d1359b9d4..5dc9ccdd5a51 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -290,7 +290,6 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 		}
 
 		if (!strcmp(q->cra_driver_name, alg->cra_name) ||
-		    !strcmp(q->cra_driver_name, alg->cra_driver_name) ||
 		    !strcmp(q->cra_name, alg->cra_driver_name))
 			goto err;
 	}
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 093675b1a1ff..49339f37d940 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -163,6 +163,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
+/* Check for valid access_width, otherwise, fallback to using bit_width */
+#define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
+
+/* Shift and apply the mask for CPC reads/writes */
+#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) & 			\
+					GENMASK(((reg)->bit_width) - 1, 0))
+
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -776,6 +783,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
 				if (gas_t->address) {
 					void __iomem *addr;
+					size_t access_width;
 
 					if (!osc_cpc_flexible_adr_space_confirmed) {
 						pr_debug("Flexible address space capability not supported\n");
@@ -783,7 +791,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 							goto out_free;
 					}
 
-					addr = ioremap(gas_t->address, gas_t->bit_width/8);
+					access_width = GET_BIT_WIDTH(gas_t) / 8;
+					addr = ioremap(gas_t->address, access_width);
 					if (!addr)
 						goto out_free;
 					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
@@ -979,6 +988,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 {
 	void __iomem *vaddr = NULL;
+	int size;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
@@ -988,14 +998,14 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 	}
 
 	*val = 0;
+	size = GET_BIT_WIDTH(reg);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = 8 << (reg->access_width - 1);
 		u32 val_u32;
 		acpi_status status;
 
 		status = acpi_os_read_port((acpi_io_address)reg->address,
-					   &val_u32, width);
+					   &val_u32, size);
 		if (ACPI_FAILURE(status)) {
 			pr_debug("Error: Failed to read SystemIO port %llx\n",
 				 reg->address);
@@ -1004,17 +1014,24 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 
 		*val = val_u32;
 		return 0;
-	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
+		/*
+		 * For registers in PCC space, the register size is determined
+		 * by the bit width field; the access size is used to indicate
+		 * the PCC subspace id.
+		 */
+		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
+	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
 	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
 		return cpc_read_ffh(cpu, reg, val);
 	else
 		return acpi_os_read_memory((acpi_physical_address)reg->address,
-				val, reg->bit_width);
+				val, size);
 
-	switch (reg->bit_width) {
+	switch (size) {
 	case 8:
 		*val = readb_relaxed(vaddr);
 		break;
@@ -1028,27 +1045,37 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 		*val = readq_relaxed(vaddr);
 		break;
 	default:
-		pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
-			 reg->bit_width, pcc_ss_id);
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_debug("Error: Cannot read %u bit width from system memory: 0x%llx\n",
+				size, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
+				size, pcc_ss_id);
+		}
 		return -EFAULT;
 	}
 
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		*val = MASK_VAL(reg, *val);
+
 	return 0;
 }
 
 static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 {
 	int ret_val = 0;
+	int size;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 
+	size = GET_BIT_WIDTH(reg);
+
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-		u32 width = 8 << (reg->access_width - 1);
 		acpi_status status;
 
 		status = acpi_os_write_port((acpi_io_address)reg->address,
-					    (u32)val, width);
+					    (u32)val, size);
 		if (ACPI_FAILURE(status)) {
 			pr_debug("Error: Failed to write SystemIO port %llx\n",
 				 reg->address);
@@ -1056,17 +1083,27 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		}
 
 		return 0;
-	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0)
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
+		/*
+		 * For registers in PCC space, the register size is determined
+		 * by the bit width field; the access size is used to indicate
+		 * the PCC subspace id.
+		 */
+		size = reg->bit_width;
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
+	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
 	else if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE)
 		return cpc_write_ffh(cpu, reg, val);
 	else
 		return acpi_os_write_memory((acpi_physical_address)reg->address,
-				val, reg->bit_width);
+				val, size);
+
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+		val = MASK_VAL(reg, val);
 
-	switch (reg->bit_width) {
+	switch (size) {
 	case 8:
 		writeb_relaxed(val, vaddr);
 		break;
@@ -1080,8 +1117,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		writeq_relaxed(val, vaddr);
 		break;
 	default:
-		pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
-			 reg->bit_width, pcc_ss_id);
+		if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_debug("Error: Cannot write %u bit width to system memory: 0x%llx\n",
+				size, reg->address);
+		} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
+				size, pcc_ss_id);
+		}
 		ret_val = -EFAULT;
 		break;
 	}
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 954f7f3b5cc3..6a772b955d69 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -535,6 +535,8 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Realtek 8852BE Bluetooth devices */
 	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0x4853), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0xb85b), .driver_info = BTUSB_REALTEK |
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 33956ddec933..179278b801eb 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1645,6 +1645,9 @@ static bool qca_wakeup(struct hci_dev *hdev)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	bool wakeup;
 
+	if (!hu->serdev)
+		return true;
+
 	/* BT SoC attached through the serial bus is handled by the serdev driver.
 	 * So we need to use the device handle of the serdev driver to get the
 	 * status of device may wakeup.
@@ -2257,16 +2260,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
-			power_ctrl_enabled = false;
+			return PTR_ERR(qcadev->bt_en);
 		}
 
+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
 		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
-		     data->soc_type == QCA_WCN7850))
-			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+		     data->soc_type == QCA_WCN7850)) {
+			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+			return PTR_ERR(qcadev->sw_ctrl);
+		}
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
@@ -2285,10 +2293,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR(qcadev->bt_en)) {
-			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
-			power_ctrl_enabled = false;
+			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
+			return PTR_ERR(qcadev->bt_en);
 		}
 
+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_warn(&serdev->dev, "failed to acquire clk\n");
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index f4c07ad3be15..af8777a1ec2e 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -167,6 +167,10 @@ static irqreturn_t idma64_irq(int irq, void *dev)
 	u32 status_err;
 	unsigned short i;
 
+	/* Since IRQ may be shared, check if DMA controller is powered on */
+	if (status == GENMASK(31, 0))
+		return IRQ_NONE;
+
 	dev_vdbg(idma64->dma.dev, "%s: status=%#x\n", __func__, status);
 
 	/* Check if we have any interrupt from the DMA controller */
diff --git a/drivers/dma/idxd/perfmon.c b/drivers/dma/idxd/perfmon.c
index d73004f47cf4..612ef13b7160 100644
--- a/drivers/dma/idxd/perfmon.c
+++ b/drivers/dma/idxd/perfmon.c
@@ -529,14 +529,11 @@ static int perf_event_cpu_offline(unsigned int cpu, struct hlist_node *node)
 		return 0;
 
 	target = cpumask_any_but(cpu_online_mask, cpu);
-
 	/* migrate events if there is a valid target */
-	if (target < nr_cpu_ids)
+	if (target < nr_cpu_ids) {
 		cpumask_set_cpu(target, &perfmon_dsa_cpu_mask);
-	else
-		target = -1;
-
-	perf_pmu_migrate_context(&idxd_pmu->pmu, cpu, target);
+		perf_pmu_migrate_context(&idxd_pmu->pmu, cpu, target);
+	}
 
 	return 0;
 }
diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index b6e0ac8314e5..0819f19c87cc 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -249,7 +249,7 @@ static void pchan_update(struct owl_dma_pchan *pchan, u32 reg,
 	else
 		regval &= ~val;
 
-	writel(val, pchan->base + reg);
+	writel(regval, pchan->base + reg);
 }
 
 static void pchan_writel(struct owl_dma_pchan *pchan, u32 reg, u32 data)
@@ -273,7 +273,7 @@ static void dma_update(struct owl_dma *od, u32 reg, u32 val, bool state)
 	else
 		regval &= ~val;
 
-	writel(val, od->base + reg);
+	writel(regval, od->base + reg);
 }
 
 static void dma_writel(struct owl_dma *od, u32 reg, u32 data)
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 75af3488a3ba..e70b7c41dcab 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -742,6 +742,9 @@ static int tegra_dma_get_residual(struct tegra_dma_channel *tdc)
 	bytes_xfer = dma_desc->bytes_xfer +
 		     sg_req[dma_desc->sg_idx].len - (wcount * 4);
 
+	if (dma_desc->bytes_req == bytes_xfer)
+		return 0;
+
 	residual = dma_desc->bytes_req - (bytes_xfer % dma_desc->bytes_req);
 
 	return residual;
diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index 84dc5240a807..93938ed80fc8 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -214,7 +214,8 @@ struct xilinx_dpdma_tx_desc {
  * @running: true if the channel is running
  * @first_frame: flag for the first frame of stream
  * @video_group: flag if multi-channel operation is needed for video channels
- * @lock: lock to access struct xilinx_dpdma_chan
+ * @lock: lock to access struct xilinx_dpdma_chan. Must be taken before
+ *        @vchan.lock, if both are to be held.
  * @desc_pool: descriptor allocation pool
  * @err_task: error IRQ bottom half handler
  * @desc: References to descriptors being processed
@@ -1097,12 +1098,14 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
 	 * Complete the active descriptor, if any, promote the pending
 	 * descriptor to active, and queue the next transfer, if any.
 	 */
+	spin_lock(&chan->vchan.lock);
 	if (chan->desc.active)
 		vchan_cookie_complete(&chan->desc.active->vdesc);
 	chan->desc.active = pending;
 	chan->desc.pending = NULL;
 
 	xilinx_dpdma_chan_queue_transfer(chan);
+	spin_unlock(&chan->vchan.lock);
 
 out:
 	spin_unlock_irqrestore(&chan->lock, flags);
@@ -1264,10 +1267,12 @@ static void xilinx_dpdma_issue_pending(struct dma_chan *dchan)
 	struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chan->vchan.lock, flags);
+	spin_lock_irqsave(&chan->lock, flags);
+	spin_lock(&chan->vchan.lock);
 	if (vchan_issue_pending(&chan->vchan))
 		xilinx_dpdma_chan_queue_transfer(chan);
-	spin_unlock_irqrestore(&chan->vchan.lock, flags);
+	spin_unlock(&chan->vchan.lock);
+	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
 static int xilinx_dpdma_config(struct dma_chan *dchan,
@@ -1495,7 +1500,9 @@ static void xilinx_dpdma_chan_err_task(struct tasklet_struct *t)
 		    XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id);
 
 	spin_lock_irqsave(&chan->lock, flags);
+	spin_lock(&chan->vchan.lock);
 	xilinx_dpdma_chan_queue_transfer(chan);
+	spin_unlock(&chan->vchan.lock);
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 260e6a3316db..7d5fbaaba72f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1779,6 +1779,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 err_bo_create:
 	amdgpu_amdkfd_unreserve_mem_limit(adev, aligned_size, flags);
 err_reserve_limit:
+	amdgpu_sync_free(&(*mem)->sync);
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
 		drm_gem_object_put(gobj);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 856db876af14..c7af36370b0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -345,17 +345,21 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask = 0;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
-
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
-			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
-			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
-	amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_done_offset(adev)) << 2);
-	amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_req_offset(adev)) << 2);
-	amdgpu_ring_write(ring, ref_and_mask); /* reference */
-	amdgpu_ring_write(ring, ref_and_mask); /* mask */
-	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
-			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10)); /* retry count, poll interval */
+	if (ring->me > 1) {
+		amdgpu_asic_flush_hdp(adev, ring);
+	} else {
+		ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
+
+		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+				  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
+				  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
+		amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_done_offset(adev)) << 2);
+		amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_req_offset(adev)) << 2);
+		amdgpu_ring_write(ring, ref_and_mask); /* reference */
+		amdgpu_ring_write(ring, ref_and_mask); /* mask */
+		amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
+				  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10)); /* retry count, poll interval */
+	}
 }
 
 /**
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 08768e5acced..57697605b2e2 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -965,9 +965,7 @@ static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
 		}
 		break;
 	case REPORT_TYPE_MOUSE:
-		workitem->reports_supported |= STD_MOUSE | HIDPP;
-		if (djrcv_dev->type == recvr_type_mouse_only)
-			workitem->reports_supported |= MULTIMEDIA;
+		workitem->reports_supported |= STD_MOUSE | HIDPP | MULTIMEDIA;
 		break;
 	}
 }
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 969f8eb086f0..0b05bb1e4410 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -61,7 +61,6 @@
 /* flags */
 #define I2C_HID_STARTED		0
 #define I2C_HID_RESET_PENDING	1
-#define I2C_HID_READ_PENDING	2
 
 #define I2C_HID_PWR_ON		0x00
 #define I2C_HID_PWR_SLEEP	0x01
@@ -193,15 +192,10 @@ static int i2c_hid_xfer(struct i2c_hid *ihid,
 		msgs[n].len = recv_len;
 		msgs[n].buf = recv_buf;
 		n++;
-
-		set_bit(I2C_HID_READ_PENDING, &ihid->flags);
 	}
 
 	ret = i2c_transfer(client->adapter, msgs, n);
 
-	if (recv_len)
-		clear_bit(I2C_HID_READ_PENDING, &ihid->flags);
-
 	if (ret != n)
 		return ret < 0 ? ret : -EIO;
 
@@ -569,9 +563,6 @@ static irqreturn_t i2c_hid_irq(int irq, void *dev_id)
 {
 	struct i2c_hid *ihid = dev_id;
 
-	if (test_bit(I2C_HID_READ_PENDING, &ihid->flags))
-		return IRQ_HANDLED;
-
 	i2c_hid_get_input(ihid);
 
 	return IRQ_HANDLED;
diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index a49c6affd7c4..dd5fc60874ba 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -948,6 +948,7 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
 	if (!dev)
 		return NULL;
 
+	dev->devc = &pdev->dev;
 	ishtp_device_init(dev);
 
 	init_waitqueue_head(&dev->wait_hw_ready);
@@ -983,7 +984,6 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
 	}
 
 	dev->ops = &ish_hw_ops;
-	dev->devc = &pdev->dev;
 	dev->mtu = IPC_PAYLOAD_SIZE - sizeof(struct ishtp_msg_hdr);
 	return dev;
 }
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 5e3976ba5265..1ebc95379914 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2075,13 +2075,18 @@ static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs,
  * Returns negative errno, else the number of messages executed.
  *
  * Adapter lock must be held when calling this function. No debug logging
- * takes place. adap->algo->master_xfer existence isn't checked.
+ * takes place.
  */
 int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	unsigned long orig_jiffies;
 	int ret, try;
 
+	if (!adap->algo->master_xfer) {
+		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (WARN_ON(!msgs || num < 1))
 		return -EINVAL;
 
@@ -2148,11 +2153,6 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	int ret;
 
-	if (!adap->algo->master_xfer) {
-		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
-		return -EOPNOTSUPP;
-	}
-
 	/* REVISIT the fault reporting model here is weak:
 	 *
 	 *  - When we get an error after receiving N bytes from a slave,
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 4d03fb3a8246..f9ab5cfc9b94 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4535,13 +4535,8 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		set_bit(i, bitmap);
 	}
 
-	if (err) {
-		if (i > 0)
-			its_vpe_irq_domain_free(domain, virq, i);
-
-		its_lpi_free(bitmap, base, nr_ids);
-		its_free_prop_table(vprop_page);
-	}
+	if (err)
+		its_vpe_irq_domain_free(domain, virq, i);
 
 	return err;
 }
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index a5ab2af3e520..e37fb25577c0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2831,6 +2831,11 @@ static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->runtime_suspended = true;
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	/* Drop the performance vote */
 	dev_pm_opp_set_rate(dev, 0);
@@ -2845,6 +2850,7 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	unsigned long flags;
 	int ret;
 
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
@@ -2863,7 +2869,15 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 
 	dev_pm_opp_set_rate(dev, msm_host->clk_rate);
 
-	return sdhci_msm_ice_resume(msm_host);
+	ret = sdhci_msm_ice_resume(msm_host);
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&host->lock, flags);
+	host->runtime_suspended = false;
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return ret;
 }
 
 static const struct dev_pm_ops sdhci_msm_pm_ops = {
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 5d2ddb037a9a..2068025d5639 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -53,7 +53,7 @@ static unsigned long doc_locations[] __initdata = {
 	0xe8000, 0xea000, 0xec000, 0xee000,
 #endif
 #endif
-	0xffffffff };
+};
 
 static struct mtd_info *doclist = NULL;
 
@@ -1552,7 +1552,7 @@ static int __init init_nanddoc(void)
 		if (ret < 0)
 			return ret;
 	} else {
-		for (i = 0; (doc_locations[i] != 0xffffffff); i++) {
+		for (i = 0; i < ARRAY_SIZE(doc_locations); i++) {
 			doc_probe(doc_locations[i]);
 		}
 	}
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 7f876721596c..5b6209f5a801 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2033,12 +2033,14 @@ static int b44_set_pauseparam(struct net_device *dev,
 		bp->flags |= B44_FLAG_TX_PAUSE;
 	else
 		bp->flags &= ~B44_FLAG_TX_PAUSE;
-	if (bp->flags & B44_FLAG_PAUSE_AUTO) {
-		b44_halt(bp);
-		b44_init_rings(bp);
-		b44_init_hw(bp, B44_FULL_RESET);
-	} else {
-		__b44_set_flow_ctrl(bp, bp->flags);
+	if (netif_running(dev)) {
+		if (bp->flags & B44_FLAG_PAUSE_AUTO) {
+			b44_halt(bp);
+			b44_init_rings(bp);
+			b44_init_hw(bp, B44_FULL_RESET);
+		} else {
+			__b44_set_flow_ctrl(bp, bp->flags);
+		}
 	}
 	spin_unlock_irq(&bp->lock);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0d0aad7141c1..77ea19bcdc6f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1697,7 +1697,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		skb = bnxt_copy_skb(bnapi, data_ptr, len, mapping);
 		if (!skb) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
-			cpr->sw_stats.rx.rx_oom_discards += 1;
+			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
 			return NULL;
 		}
 	} else {
@@ -1707,7 +1707,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		new_data = __bnxt_alloc_rx_frag(bp, &new_mapping, GFP_ATOMIC);
 		if (!new_data) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
-			cpr->sw_stats.rx.rx_oom_discards += 1;
+			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
 			return NULL;
 		}
 
@@ -1723,7 +1723,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		if (!skb) {
 			skb_free_frag(data);
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
-			cpr->sw_stats.rx.rx_oom_discards += 1;
+			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
 			return NULL;
 		}
 		skb_reserve(skb, bp->rx_offset);
@@ -1734,7 +1734,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, idx, agg_bufs, true);
 		if (!skb) {
 			/* Page reuse already handled by bnxt_rx_pages(). */
-			cpr->sw_stats.rx.rx_oom_discards += 1;
+			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
 			return NULL;
 		}
 	}
@@ -1950,11 +1950,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			u32 frag_len = bnxt_rx_agg_pages_xdp(bp, cpr, &xdp,
 							     cp_cons, agg_bufs,
 							     false);
-			if (!frag_len) {
-				cpr->sw_stats.rx.rx_oom_discards += 1;
-				rc = -ENOMEM;
-				goto next_rx;
-			}
+			if (!frag_len)
+				goto oom_next_rx;
 		}
 		xdp_active = true;
 	}
@@ -1977,9 +1974,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 				else
 					bnxt_xdp_buff_frags_free(rxr, &xdp);
 			}
-			cpr->sw_stats.rx.rx_oom_discards += 1;
-			rc = -ENOMEM;
-			goto next_rx;
+			goto oom_next_rx;
 		}
 	} else {
 		u32 payload;
@@ -1990,29 +1985,21 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			payload = 0;
 		skb = bp->rx_skb_func(bp, rxr, cons, data, data_ptr, dma_addr,
 				      payload | len);
-		if (!skb) {
-			cpr->sw_stats.rx.rx_oom_discards += 1;
-			rc = -ENOMEM;
-			goto next_rx;
-		}
+		if (!skb)
+			goto oom_next_rx;
 	}
 
 	if (agg_bufs) {
 		if (!xdp_active) {
 			skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, cp_cons, agg_bufs, false);
-			if (!skb) {
-				cpr->sw_stats.rx.rx_oom_discards += 1;
-				rc = -ENOMEM;
-				goto next_rx;
-			}
+			if (!skb)
+				goto oom_next_rx;
 		} else {
 			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr->page_pool, &xdp, rxcmp1);
 			if (!skb) {
 				/* we should be able to free the old skb here */
 				bnxt_xdp_buff_frags_free(rxr, &xdp);
-				cpr->sw_stats.rx.rx_oom_discards += 1;
-				rc = -ENOMEM;
-				goto next_rx;
+				goto oom_next_rx;
 			}
 		}
 	}
@@ -2090,6 +2077,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	*raw_cons = tmp_raw_cons;
 
 	return rc;
+
+oom_next_rx:
+	cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
+	rc = -ENOMEM;
+	goto next_rx;
 }
 
 /* In netpoll mode, if we are using a combined completion ring, we need to
@@ -2135,7 +2127,7 @@ static int bnxt_force_rx_discard(struct bnxt *bp,
 	}
 	rc = bnxt_rx_pkt(bp, cpr, raw_cons, event);
 	if (rc && rc != -EBUSY)
-		cpr->sw_stats.rx.rx_netpoll_discards += 1;
+		cpr->bnapi->cp_ring.sw_stats.rx.rx_netpoll_discards += 1;
 	return rc;
 }
 
@@ -11812,6 +11804,16 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 	bnxt_rtnl_unlock_sp(bp);
 }
 
+static void bnxt_fw_fatal_close(struct bnxt *bp)
+{
+	bnxt_tx_disable(bp);
+	bnxt_disable_napi(bp);
+	bnxt_disable_int_sync(bp);
+	bnxt_free_irq(bp);
+	bnxt_clear_int_mode(bp);
+	pci_disable_device(bp->pdev);
+}
+
 static void bnxt_fw_reset_close(struct bnxt *bp)
 {
 	bnxt_ulp_stop(bp);
@@ -11825,12 +11827,7 @@ static void bnxt_fw_reset_close(struct bnxt *bp)
 		pci_read_config_word(bp->pdev, PCI_SUBSYSTEM_ID, &val);
 		if (val == 0xffff)
 			bp->fw_reset_min_dsecs = 0;
-		bnxt_tx_disable(bp);
-		bnxt_disable_napi(bp);
-		bnxt_disable_int_sync(bp);
-		bnxt_free_irq(bp);
-		bnxt_clear_int_mode(bp);
-		pci_disable_device(bp->pdev);
+		bnxt_fw_fatal_close(bp);
 	}
 	__bnxt_close_nic(bp, true, false);
 	bnxt_vf_reps_free(bp);
@@ -13978,6 +13975,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct bnxt *bp = netdev_priv(netdev);
+	bool abort = false;
 
 	netdev_info(netdev, "PCI I/O error detected\n");
 
@@ -13986,16 +13984,27 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
 	bnxt_ulp_stop(bp);
 
-	if (state == pci_channel_io_perm_failure) {
+	if (test_and_set_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
+		netdev_err(bp->dev, "Firmware reset already in progress\n");
+		abort = true;
+	}
+
+	if (abort || state == pci_channel_io_perm_failure) {
 		rtnl_unlock();
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	if (state == pci_channel_io_frozen)
+	/* Link is not reliable anymore if state is pci_channel_io_frozen
+	 * so we disable bus master to prevent any potential bad DMAs before
+	 * freeing kernel memory.
+	 */
+	if (state == pci_channel_io_frozen) {
 		set_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state);
+		bnxt_fw_fatal_close(bp);
+	}
 
 	if (netif_running(netdev))
-		bnxt_close(netdev);
+		__bnxt_close_nic(bp, true, true);
 
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
@@ -14081,6 +14090,7 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 	}
 
 reset_exit:
+	clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state);
 	bnxt_clear_reservations(bp, true);
 	rtnl_unlock();
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a9db1ed74d3f..9efd4b962dce 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16173,8 +16173,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	val = (rd32(&pf->hw, I40E_PRTGL_SAH) &
 	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
 	if (val < MAX_FRAME_SIZE_DEFAULT)
-		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 pf->hw.port, val);
+		dev_warn(&pdev->dev, "MFS for port %x (%d) has been set below the default (%d)\n",
+			 pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
@@ -16716,7 +16716,7 @@ static int __init i40e_init_module(void)
 	 * since we need to be able to guarantee forward progress even under
 	 * memory pressure.
 	 */
-	i40e_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0, i40e_driver_name);
+	i40e_wq = alloc_workqueue("%s", 0, 0, i40e_driver_name);
 	if (!i40e_wq) {
 		pr_err("%s: Failed to create workqueue\n", i40e_driver_name);
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index b9c4b311cd62..53b9fe35d803 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3631,6 +3631,34 @@ static void iavf_del_all_cloud_filters(struct iavf_adapter *adapter)
 	spin_unlock_bh(&adapter->cloud_filter_list_lock);
 }
 
+/**
+ * iavf_is_tc_config_same - Compare the mqprio TC config with the
+ * TC config already configured on this adapter.
+ * @adapter: board private structure
+ * @mqprio_qopt: TC config received from kernel.
+ *
+ * This function compares the TC config received from the kernel
+ * with the config already configured on the adapter.
+ *
+ * Return: True if configuration is same, false otherwise.
+ **/
+static bool iavf_is_tc_config_same(struct iavf_adapter *adapter,
+				   struct tc_mqprio_qopt *mqprio_qopt)
+{
+	struct virtchnl_channel_info *ch = &adapter->ch_config.ch_info[0];
+	int i;
+
+	if (adapter->num_tc != mqprio_qopt->num_tc)
+		return false;
+
+	for (i = 0; i < adapter->num_tc; i++) {
+		if (ch[i].count != mqprio_qopt->count[i] ||
+		    ch[i].offset != mqprio_qopt->offset[i])
+			return false;
+	}
+	return true;
+}
+
 /**
  * __iavf_setup_tc - configure multiple traffic classes
  * @netdev: network interface device structure
@@ -3688,7 +3716,7 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 		if (ret)
 			return ret;
 		/* Return if same TC config is requested */
-		if (adapter->num_tc == num_tc)
+		if (iavf_is_tc_config_same(adapter, &mqprio_qopt->qopt))
 			return 0;
 		adapter->num_tc = num_tc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index a7832a0180ee..48cf691842b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1703,6 +1703,7 @@ static const struct macsec_ops macsec_offload_ops = {
 	.mdo_add_secy = mlx5e_macsec_add_secy,
 	.mdo_upd_secy = mlx5e_macsec_upd_secy,
 	.mdo_del_secy = mlx5e_macsec_del_secy,
+	.rx_uses_md_dst = true,
 };
 
 bool mlx5e_macsec_handle_tx_skb(struct mlx5e_macsec *macsec, struct sk_buff *skb)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index e2a985ec2c76..f36a416ffcfe 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -792,7 +792,7 @@ static void mlxsw_emad_rx_listener_func(struct sk_buff *skb, u16 local_port,
 
 static const struct mlxsw_listener mlxsw_emad_rx_listener =
 	MLXSW_RXL(mlxsw_emad_rx_listener_func, ETHEMAD, TRAP_TO_CPU, false,
-		  EMAD, DISCARD);
+		  EMAD, FORWARD);
 
 static int mlxsw_emad_init(struct mlxsw_core *mlxsw_core)
 {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 41eac7dfb67e..685bcf8cbfa9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -780,7 +780,9 @@ static void mlxsw_sp_acl_tcam_vregion_rehash_work(struct work_struct *work)
 			     rehash.dw.work);
 	int credits = MLXSW_SP_ACL_TCAM_VREGION_REHASH_CREDITS;
 
+	mutex_lock(&vregion->lock);
 	mlxsw_sp_acl_tcam_vregion_rehash(vregion->mlxsw_sp, vregion, &credits);
+	mutex_unlock(&vregion->lock);
 	if (credits < 0)
 		/* Rehash gone out of credits so it was interrupted.
 		 * Schedule the work as soon as possible to continue.
@@ -790,6 +792,17 @@ static void mlxsw_sp_acl_tcam_vregion_rehash_work(struct work_struct *work)
 		mlxsw_sp_acl_tcam_vregion_rehash_work_schedule(vregion);
 }
 
+static void
+mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(struct mlxsw_sp_acl_tcam_rehash_ctx *ctx)
+{
+	/* The entry markers are relative to the current chunk and therefore
+	 * needs to be reset together with the chunk marker.
+	 */
+	ctx->current_vchunk = NULL;
+	ctx->start_ventry = NULL;
+	ctx->stop_ventry = NULL;
+}
+
 static void
 mlxsw_sp_acl_tcam_rehash_ctx_vchunk_changed(struct mlxsw_sp_acl_tcam_vchunk *vchunk)
 {
@@ -812,7 +825,7 @@ mlxsw_sp_acl_tcam_rehash_ctx_vregion_changed(struct mlxsw_sp_acl_tcam_vregion *v
 	 * the current chunk pointer to make sure all chunks
 	 * are properly migrated.
 	 */
-	vregion->rehash.ctx.current_vchunk = NULL;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(&vregion->rehash.ctx);
 }
 
 static struct mlxsw_sp_acl_tcam_vregion *
@@ -885,10 +898,14 @@ mlxsw_sp_acl_tcam_vregion_destroy(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_acl_tcam *tcam = vregion->tcam;
 
 	if (vgroup->vregion_rehash_enabled && ops->region_rehash_hints_get) {
+		struct mlxsw_sp_acl_tcam_rehash_ctx *ctx = &vregion->rehash.ctx;
+
 		mutex_lock(&tcam->lock);
 		list_del(&vregion->tlist);
 		mutex_unlock(&tcam->lock);
-		cancel_delayed_work_sync(&vregion->rehash.dw);
+		if (cancel_delayed_work_sync(&vregion->rehash.dw) &&
+		    ctx->hints_priv)
+			ops->region_rehash_hints_put(ctx->hints_priv);
 	}
 	mlxsw_sp_acl_tcam_vgroup_vregion_detach(mlxsw_sp, vregion);
 	if (vregion->region2)
@@ -1254,8 +1271,14 @@ mlxsw_sp_acl_tcam_ventry_activity_get(struct mlxsw_sp *mlxsw_sp,
 				      struct mlxsw_sp_acl_tcam_ventry *ventry,
 				      bool *activity)
 {
-	return mlxsw_sp_acl_tcam_entry_activity_get(mlxsw_sp,
-						    ventry->entry, activity);
+	struct mlxsw_sp_acl_tcam_vregion *vregion = ventry->vchunk->vregion;
+	int err;
+
+	mutex_lock(&vregion->lock);
+	err = mlxsw_sp_acl_tcam_entry_activity_get(mlxsw_sp, ventry->entry,
+						   activity);
+	mutex_unlock(&vregion->lock);
+	return err;
 }
 
 static int
@@ -1289,6 +1312,8 @@ mlxsw_sp_acl_tcam_vchunk_migrate_start(struct mlxsw_sp *mlxsw_sp,
 {
 	struct mlxsw_sp_acl_tcam_chunk *new_chunk;
 
+	WARN_ON(vchunk->chunk2);
+
 	new_chunk = mlxsw_sp_acl_tcam_chunk_create(mlxsw_sp, vchunk, region);
 	if (IS_ERR(new_chunk))
 		return PTR_ERR(new_chunk);
@@ -1307,7 +1332,7 @@ mlxsw_sp_acl_tcam_vchunk_migrate_end(struct mlxsw_sp *mlxsw_sp,
 {
 	mlxsw_sp_acl_tcam_chunk_destroy(mlxsw_sp, vchunk->chunk2);
 	vchunk->chunk2 = NULL;
-	ctx->current_vchunk = NULL;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 }
 
 static int
@@ -1330,6 +1355,9 @@ mlxsw_sp_acl_tcam_vchunk_migrate_one(struct mlxsw_sp *mlxsw_sp,
 		return 0;
 	}
 
+	if (list_empty(&vchunk->ventry_list))
+		goto out;
+
 	/* If the migration got interrupted, we have the ventry to start from
 	 * stored in context.
 	 */
@@ -1339,6 +1367,8 @@ mlxsw_sp_acl_tcam_vchunk_migrate_one(struct mlxsw_sp *mlxsw_sp,
 		ventry = list_first_entry(&vchunk->ventry_list,
 					  typeof(*ventry), list);
 
+	WARN_ON(ventry->vchunk != vchunk);
+
 	list_for_each_entry_from(ventry, &vchunk->ventry_list, list) {
 		/* During rollback, once we reach the ventry that failed
 		 * to migrate, we are done.
@@ -1379,6 +1409,7 @@ mlxsw_sp_acl_tcam_vchunk_migrate_one(struct mlxsw_sp *mlxsw_sp,
 		}
 	}
 
+out:
 	mlxsw_sp_acl_tcam_vchunk_migrate_end(mlxsw_sp, vchunk, ctx);
 	return 0;
 }
@@ -1392,6 +1423,9 @@ mlxsw_sp_acl_tcam_vchunk_migrate_all(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_acl_tcam_vchunk *vchunk;
 	int err;
 
+	if (list_empty(&vregion->vchunk_list))
+		return 0;
+
 	/* If the migration got interrupted, we have the vchunk
 	 * we are working on stored in context.
 	 */
@@ -1420,16 +1454,17 @@ mlxsw_sp_acl_tcam_vregion_migrate(struct mlxsw_sp *mlxsw_sp,
 	int err, err2;
 
 	trace_mlxsw_sp_acl_tcam_vregion_migrate(mlxsw_sp, vregion);
-	mutex_lock(&vregion->lock);
 	err = mlxsw_sp_acl_tcam_vchunk_migrate_all(mlxsw_sp, vregion,
 						   ctx, credits);
 	if (err) {
+		if (ctx->this_is_rollback)
+			return err;
 		/* In case migration was not successful, we need to swap
 		 * so the original region pointer is assigned again
 		 * to vregion->region.
 		 */
 		swap(vregion->region, vregion->region2);
-		ctx->current_vchunk = NULL;
+		mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 		ctx->this_is_rollback = true;
 		err2 = mlxsw_sp_acl_tcam_vchunk_migrate_all(mlxsw_sp, vregion,
 							    ctx, credits);
@@ -1440,7 +1475,6 @@ mlxsw_sp_acl_tcam_vregion_migrate(struct mlxsw_sp *mlxsw_sp,
 			/* Let the rollback to be continued later on. */
 		}
 	}
-	mutex_unlock(&vregion->lock);
 	trace_mlxsw_sp_acl_tcam_vregion_migrate_end(mlxsw_sp, vregion);
 	return err;
 }
@@ -1489,6 +1523,7 @@ mlxsw_sp_acl_tcam_vregion_rehash_start(struct mlxsw_sp *mlxsw_sp,
 
 	ctx->hints_priv = hints_priv;
 	ctx->this_is_rollback = false;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 
 	return 0;
 
@@ -1541,7 +1576,8 @@ mlxsw_sp_acl_tcam_vregion_rehash(struct mlxsw_sp *mlxsw_sp,
 	err = mlxsw_sp_acl_tcam_vregion_migrate(mlxsw_sp, vregion,
 						ctx, credits);
 	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Failed to migrate vregion\n");
+		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Failed to migrate vregion\n");
+		return;
 	}
 
 	if (*credits >= 0)
diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index 9948ac14e68d..c1bdf045e981 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -649,6 +649,11 @@ static bool am65_cpts_match_tx_ts(struct am65_cpts *cpts,
 		struct am65_cpts_skb_cb_data *skb_cb =
 					(struct am65_cpts_skb_cb_data *)skb->cb;
 
+		if ((ptp_classify_raw(skb) & PTP_CLASS_V1) &&
+		    ((mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK) ==
+		     (skb_cb->skb_mtype_seqid & AM65_CPTS_EVENT_1_SEQUENCE_ID_MASK)))
+			mtype_seqid = skb_cb->skb_mtype_seqid;
+
 		if (mtype_seqid == skb_cb->skb_mtype_seqid) {
 			u64 ns = event->timestamp;
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 7086acfed5b9..05b5914d8358 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1110,11 +1110,12 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 static void gtp_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct gtp_dev *gtp = netdev_priv(dev);
+	struct hlist_node *next;
 	struct pdp_ctx *pctx;
 	int i;
 
 	for (i = 0; i < gtp->hash_size; i++)
-		hlist_for_each_entry_rcu(pctx, &gtp->tid_hash[i], hlist_tid)
+		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
 
 	list_del_rcu(&gtp->list);
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 209ee9f35275..8a8fd74110e2 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -1007,10 +1007,12 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 	struct metadata_dst *md_dst;
 	struct macsec_rxh_data *rxd;
 	struct macsec_dev *macsec;
+	bool is_macsec_md_dst;
 
 	rcu_read_lock();
 	rxd = macsec_data_rcu(skb->dev);
 	md_dst = skb_metadata_dst(skb);
+	is_macsec_md_dst = md_dst && md_dst->type == METADATA_MACSEC;
 
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct sk_buff *nskb;
@@ -1021,10 +1023,42 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 		 * the SecTAG, so we have to deduce which port to deliver to.
 		 */
 		if (macsec_is_offloaded(macsec) && netif_running(ndev)) {
-			if (md_dst && md_dst->type == METADATA_MACSEC &&
-			    (!find_rx_sc(&macsec->secy, md_dst->u.macsec_info.sci)))
+			const struct macsec_ops *ops;
+
+			ops = macsec_get_ops(macsec, NULL);
+
+			if (ops->rx_uses_md_dst && !is_macsec_md_dst)
 				continue;
 
+			if (is_macsec_md_dst) {
+				struct macsec_rx_sc *rx_sc;
+
+				/* All drivers that implement MACsec offload
+				 * support using skb metadata destinations must
+				 * indicate that they do so.
+				 */
+				DEBUG_NET_WARN_ON_ONCE(!ops->rx_uses_md_dst);
+				rx_sc = find_rx_sc(&macsec->secy,
+						   md_dst->u.macsec_info.sci);
+				if (!rx_sc)
+					continue;
+				/* device indicated macsec offload occurred */
+				skb->dev = ndev;
+				skb->pkt_type = PACKET_HOST;
+				eth_skb_pkt_type(skb, ndev);
+				ret = RX_HANDLER_ANOTHER;
+				goto out;
+			}
+
+			/* This datapath is insecure because it is unable to
+			 * enforce isolation of broadcast/multicast traffic and
+			 * unicast traffic with promiscuous mode on the macsec
+			 * netdev. Since the core stack has no mechanism to
+			 * check that the hardware did indeed receive MACsec
+			 * traffic, it is possible that the response handling
+			 * done by the MACsec port was to a plaintext packet.
+			 * This violates the MACsec protocol standard.
+			 */
 			if (ether_addr_equal_64bits(hdr->h_dest,
 						    ndev->dev_addr)) {
 				/* exact match, divert skb to this port */
@@ -1040,11 +1074,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 					break;
 
 				nskb->dev = ndev;
-				if (ether_addr_equal_64bits(hdr->h_dest,
-							    ndev->broadcast))
-					nskb->pkt_type = PACKET_BROADCAST;
-				else
-					nskb->pkt_type = PACKET_MULTICAST;
+				eth_skb_pkt_type(nskb, ndev);
 
 				__netif_rx(nskb);
 			}
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 3078511f7608..21b6c4d94a63 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1456,21 +1456,16 @@ static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			/* Skip IP alignment pseudo header */
 			skb_pull(skb, 2);
 
-			skb->truesize = SKB_TRUESIZE(pkt_len_plus_padd);
 			ax88179_rx_checksum(skb, pkt_hdr);
 			return 1;
 		}
 
-		ax_skb = skb_clone(skb, GFP_ATOMIC);
+		ax_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
 		if (!ax_skb)
 			return 0;
-		skb_trim(ax_skb, pkt_len);
+		skb_put(ax_skb, pkt_len);
+		memcpy(ax_skb->data, skb->data + 2, pkt_len);
 
-		/* Skip IP alignment pseudo header */
-		skb_pull(ax_skb, 2);
-
-		skb->truesize = pkt_len_plus_padd +
-				SKB_DATA_ALIGN(sizeof(struct sk_buff));
 		ax88179_rx_checksum(ax_skb, pkt_hdr);
 		usbnet_skb_return(dev, ax_skb);
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 45f1a871b7da..32cddb633793 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2948,19 +2948,35 @@ static int virtnet_get_rxfh(struct net_device *dev, u32 *indir, u8 *key, u8 *hfu
 static int virtnet_set_rxfh(struct net_device *dev, const u32 *indir, const u8 *key, const u8 hfunc)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
+	bool update = false;
 	int i;
 
 	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
 	if (indir) {
+		if (!vi->has_rss)
+			return -EOPNOTSUPP;
+
 		for (i = 0; i < vi->rss_indir_table_size; ++i)
 			vi->ctrl->rss.indirection_table[i] = indir[i];
+		update = true;
 	}
-	if (key)
+
+	if (key) {
+		/* If either _F_HASH_REPORT or _F_RSS are negotiated, the
+		 * device provides hash calculation capabilities, that is,
+		 * hash_key is configured.
+		 */
+		if (!vi->has_rss && !vi->has_rss_hash_report)
+			return -EOPNOTSUPP;
+
 		memcpy(vi->ctrl->rss.key, key, vi->rss_key_size);
+		update = true;
+	}
 
-	virtnet_commit_rss_command(vi);
+	if (update)
+		virtnet_commit_rss_command(vi);
 
 	return 0;
 }
@@ -3852,13 +3868,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT))
 		vi->has_rss_hash_report = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_RSS)) {
 		vi->has_rss = true;
 
-	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_indir_table_size =
 			virtio_cread16(vdev, offsetof(struct virtio_net_config,
 				rss_max_indirection_table_length));
+	}
+
+	if (vi->has_rss || vi->has_rss_hash_report) {
 		vi->rss_key_size =
 			virtio_cread8(vdev, offsetof(struct virtio_net_config, rss_max_key_size));
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 619dd71c9d75..fbd36dff9ec2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1662,6 +1662,10 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
 		return false;
 
+	/* Ignore packets from invalid src-address */
+	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
+		return false;
+
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
 		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 8c5b97fb1941..5b0b4bb2bb68 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -48,6 +48,8 @@ int iwl_mvm_ftm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (!pasn)
 		return -ENOBUFS;
 
+	iwl_mvm_ftm_remove_pasn_sta(mvm, addr);
+
 	pasn->cipher = iwl_mvm_cipher_to_location_cipher(cipher);
 
 	switch (pasn->cipher) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index acd8803dbcdd..b20d64dbba1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2650,7 +2650,8 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 		if (ver_handler->version != scan_ver)
 			continue;
 
-		return ver_handler->handler(mvm, vif, params, type, uid);
+		err = ver_handler->handler(mvm, vif, params, type, uid);
+		return err ? : uid;
 	}
 
 	err = iwl_mvm_scan_umac(mvm, vif, params, type, uid);
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 21d68664fe08..7968baa626d1 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -424,7 +424,8 @@ struct trf7970a {
 	enum trf7970a_state		state;
 	struct device			*dev;
 	struct spi_device		*spi;
-	struct regulator		*regulator;
+	struct regulator		*vin_regulator;
+	struct regulator		*vddio_regulator;
 	struct nfc_digital_dev		*ddev;
 	u32				quirks;
 	bool				is_initiator;
@@ -1883,7 +1884,7 @@ static int trf7970a_power_up(struct trf7970a *trf)
 	if (trf->state != TRF7970A_ST_PWR_OFF)
 		return 0;
 
-	ret = regulator_enable(trf->regulator);
+	ret = regulator_enable(trf->vin_regulator);
 	if (ret) {
 		dev_err(trf->dev, "%s - Can't enable VIN: %d\n", __func__, ret);
 		return ret;
@@ -1926,7 +1927,7 @@ static int trf7970a_power_down(struct trf7970a *trf)
 	if (trf->en2_gpiod && !(trf->quirks & TRF7970A_QUIRK_EN2_MUST_STAY_LOW))
 		gpiod_set_value_cansleep(trf->en2_gpiod, 0);
 
-	ret = regulator_disable(trf->regulator);
+	ret = regulator_disable(trf->vin_regulator);
 	if (ret)
 		dev_err(trf->dev, "%s - Can't disable VIN: %d\n", __func__,
 			ret);
@@ -2065,37 +2066,37 @@ static int trf7970a_probe(struct spi_device *spi)
 	mutex_init(&trf->lock);
 	INIT_DELAYED_WORK(&trf->timeout_work, trf7970a_timeout_work_handler);
 
-	trf->regulator = devm_regulator_get(&spi->dev, "vin");
-	if (IS_ERR(trf->regulator)) {
-		ret = PTR_ERR(trf->regulator);
+	trf->vin_regulator = devm_regulator_get(&spi->dev, "vin");
+	if (IS_ERR(trf->vin_regulator)) {
+		ret = PTR_ERR(trf->vin_regulator);
 		dev_err(trf->dev, "Can't get VIN regulator: %d\n", ret);
 		goto err_destroy_lock;
 	}
 
-	ret = regulator_enable(trf->regulator);
+	ret = regulator_enable(trf->vin_regulator);
 	if (ret) {
 		dev_err(trf->dev, "Can't enable VIN: %d\n", ret);
 		goto err_destroy_lock;
 	}
 
-	uvolts = regulator_get_voltage(trf->regulator);
+	uvolts = regulator_get_voltage(trf->vin_regulator);
 	if (uvolts > 4000000)
 		trf->chip_status_ctrl = TRF7970A_CHIP_STATUS_VRS5_3;
 
-	trf->regulator = devm_regulator_get(&spi->dev, "vdd-io");
-	if (IS_ERR(trf->regulator)) {
-		ret = PTR_ERR(trf->regulator);
+	trf->vddio_regulator = devm_regulator_get(&spi->dev, "vdd-io");
+	if (IS_ERR(trf->vddio_regulator)) {
+		ret = PTR_ERR(trf->vddio_regulator);
 		dev_err(trf->dev, "Can't get VDD_IO regulator: %d\n", ret);
-		goto err_destroy_lock;
+		goto err_disable_vin_regulator;
 	}
 
-	ret = regulator_enable(trf->regulator);
+	ret = regulator_enable(trf->vddio_regulator);
 	if (ret) {
 		dev_err(trf->dev, "Can't enable VDD_IO: %d\n", ret);
-		goto err_destroy_lock;
+		goto err_disable_vin_regulator;
 	}
 
-	if (regulator_get_voltage(trf->regulator) == 1800000) {
+	if (regulator_get_voltage(trf->vddio_regulator) == 1800000) {
 		trf->io_ctrl = TRF7970A_REG_IO_CTRL_IO_LOW;
 		dev_dbg(trf->dev, "trf7970a config vdd_io to 1.8V\n");
 	}
@@ -2108,7 +2109,7 @@ static int trf7970a_probe(struct spi_device *spi)
 	if (!trf->ddev) {
 		dev_err(trf->dev, "Can't allocate NFC digital device\n");
 		ret = -ENOMEM;
-		goto err_disable_regulator;
+		goto err_disable_vddio_regulator;
 	}
 
 	nfc_digital_set_parent_dev(trf->ddev, trf->dev);
@@ -2137,8 +2138,10 @@ static int trf7970a_probe(struct spi_device *spi)
 	trf7970a_shutdown(trf);
 err_free_ddev:
 	nfc_digital_free_device(trf->ddev);
-err_disable_regulator:
-	regulator_disable(trf->regulator);
+err_disable_vddio_regulator:
+	regulator_disable(trf->vddio_regulator);
+err_disable_vin_regulator:
+	regulator_disable(trf->vin_regulator);
 err_destroy_lock:
 	mutex_destroy(&trf->lock);
 	return ret;
@@ -2157,7 +2160,8 @@ static void trf7970a_remove(struct spi_device *spi)
 	nfc_digital_unregister_device(trf->ddev);
 	nfc_digital_free_device(trf->ddev);
 
-	regulator_disable(trf->regulator);
+	regulator_disable(trf->vddio_regulator);
+	regulator_disable(trf->vin_regulator);
 
 	mutex_destroy(&trf->lock);
 }
diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index c93286483b42..211ce84d980f 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -47,6 +48,15 @@
 #define IMX8MM_GPR_PCIE_SSC_EN		BIT(16)
 #define IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE	BIT(9)
 
+enum imx8_pcie_phy_type {
+	IMX8MM,
+};
+
+struct imx8_pcie_phy_drvdata {
+	const	char			*gpr;
+	enum	imx8_pcie_phy_type	variant;
+};
+
 struct imx8_pcie_phy {
 	void __iomem		*base;
 	struct clk		*clk;
@@ -57,6 +67,7 @@ struct imx8_pcie_phy {
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2;
 	bool			clkreq_unused;
+	const struct imx8_pcie_phy_drvdata	*drvdata;
 };
 
 static int imx8_pcie_phy_power_on(struct phy *phy)
@@ -68,31 +79,17 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 	reset_control_assert(imx8_phy->reset);
 
 	pad_mode = imx8_phy->refclk_pad_mode;
-	/* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't hooked */
-	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-			   IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE,
-			   imx8_phy->clkreq_unused ?
-			   0 : IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
-	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-			   IMX8MM_GPR_PCIE_AUX_EN,
-			   IMX8MM_GPR_PCIE_AUX_EN);
-	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-			   IMX8MM_GPR_PCIE_POWER_OFF, 0);
-	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-			   IMX8MM_GPR_PCIE_SSC_EN, 0);
-
-	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-			   IMX8MM_GPR_PCIE_REF_CLK_SEL,
-			   pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ?
-			   IMX8MM_GPR_PCIE_REF_CLK_EXT :
-			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
-	usleep_range(100, 200);
-
-	/* Do the PHY common block reset */
-	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
-			   IMX8MM_GPR_PCIE_CMN_RST,
-			   IMX8MM_GPR_PCIE_CMN_RST);
-	usleep_range(200, 500);
+	switch (imx8_phy->drvdata->variant) {
+	case IMX8MM:
+		/* Tune PHY de-emphasis setting to pass PCIe compliance. */
+		if (imx8_phy->tx_deemph_gen1)
+			writel(imx8_phy->tx_deemph_gen1,
+			       imx8_phy->base + PCIE_PHY_TRSV_REG5);
+		if (imx8_phy->tx_deemph_gen2)
+			writel(imx8_phy->tx_deemph_gen2,
+			       imx8_phy->base + PCIE_PHY_TRSV_REG6);
+		break;
+	}
 
 	if (pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ||
 	    pad_mode == IMX8_PCIE_REFCLK_PAD_UNUSED) {
@@ -111,8 +108,10 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 		/* Source clock from SoC internal PLL */
 		writel(ANA_PLL_CLK_OUT_TO_EXT_IO_SEL,
 		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG062);
-		writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
-		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
+		if (imx8_phy->drvdata->variant != IMX8MM) {
+			writel(AUX_PLL_REFCLK_SEL_SYS_PLL,
+			       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG063);
+		}
 		val = ANA_AUX_RX_TX_SEL_TX | ANA_AUX_TX_TERM;
 		writel(val | ANA_AUX_RX_TERM_GND_EN,
 		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG064);
@@ -120,15 +119,37 @@ static int imx8_pcie_phy_power_on(struct phy *phy)
 		       imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG065);
 	}
 
-	/* Tune PHY de-emphasis setting to pass PCIe compliance. */
-	if (imx8_phy->tx_deemph_gen1)
-		writel(imx8_phy->tx_deemph_gen1,
-		       imx8_phy->base + PCIE_PHY_TRSV_REG5);
-	if (imx8_phy->tx_deemph_gen2)
-		writel(imx8_phy->tx_deemph_gen2,
-		       imx8_phy->base + PCIE_PHY_TRSV_REG6);
+	/* Set AUX_EN_OVERRIDE 1'b0, when the CLKREQ# isn't hooked */
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
+			   IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE,
+			   imx8_phy->clkreq_unused ?
+			   0 : IMX8MM_GPR_PCIE_AUX_EN_OVERRIDE);
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
+			   IMX8MM_GPR_PCIE_AUX_EN,
+			   IMX8MM_GPR_PCIE_AUX_EN);
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
+			   IMX8MM_GPR_PCIE_POWER_OFF, 0);
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
+			   IMX8MM_GPR_PCIE_SSC_EN, 0);
 
-	reset_control_deassert(imx8_phy->reset);
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
+			   IMX8MM_GPR_PCIE_REF_CLK_SEL,
+			   pad_mode == IMX8_PCIE_REFCLK_PAD_INPUT ?
+			   IMX8MM_GPR_PCIE_REF_CLK_EXT :
+			   IMX8MM_GPR_PCIE_REF_CLK_PLL);
+	usleep_range(100, 200);
+
+	/* Do the PHY common block reset */
+	regmap_update_bits(imx8_phy->iomuxc_gpr, IOMUXC_GPR14,
+			   IMX8MM_GPR_PCIE_CMN_RST,
+			   IMX8MM_GPR_PCIE_CMN_RST);
+
+	switch (imx8_phy->drvdata->variant) {
+	case IMX8MM:
+		reset_control_deassert(imx8_phy->reset);
+		usleep_range(200, 500);
+		break;
+	}
 
 	/* Polling to check the phy is ready or not. */
 	ret = readl_poll_timeout(imx8_phy->base + IMX8MM_PCIE_PHY_CMN_REG75,
@@ -160,6 +181,17 @@ static const struct phy_ops imx8_pcie_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const struct imx8_pcie_phy_drvdata imx8mm_drvdata = {
+	.gpr = "fsl,imx8mm-iomuxc-gpr",
+	.variant = IMX8MM,
+};
+
+static const struct of_device_id imx8_pcie_phy_of_match[] = {
+	{.compatible = "fsl,imx8mm-pcie-phy", .data = &imx8mm_drvdata, },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx8_pcie_phy_of_match);
+
 static int imx8_pcie_phy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
@@ -172,6 +204,8 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 	if (!imx8_phy)
 		return -ENOMEM;
 
+	imx8_phy->drvdata = of_device_get_match_data(dev);
+
 	/* get PHY refclk pad mode */
 	of_property_read_u32(np, "fsl,refclk-pad-mode",
 			     &imx8_phy->refclk_pad_mode);
@@ -197,7 +231,7 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 
 	/* Grab GPR config register range */
 	imx8_phy->iomuxc_gpr =
-		 syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+		 syscon_regmap_lookup_by_compatible(imx8_phy->drvdata->gpr);
 	if (IS_ERR(imx8_phy->iomuxc_gpr)) {
 		dev_err(dev, "unable to find iomuxc registers\n");
 		return PTR_ERR(imx8_phy->iomuxc_gpr);
@@ -225,12 +259,6 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
-static const struct of_device_id imx8_pcie_phy_of_match[] = {
-	{.compatible = "fsl,imx8mm-pcie-phy",},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, imx8_pcie_phy_of_match);
-
 static struct platform_driver imx8_pcie_phy_driver = {
 	.probe	= imx8_pcie_phy_probe,
 	.driver = {
diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index d641b345afa3..251e1aedd4a6 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -602,7 +602,7 @@ static void comphy_gbe_phy_init(struct mvebu_a3700_comphy_lane *lane,
 	u16 val;
 
 	fix_idx = 0;
-	for (addr = 0; addr < 512; addr++) {
+	for (addr = 0; addr < ARRAY_SIZE(gbe_phy_init); addr++) {
 		/*
 		 * All PHY register values are defined in full for 3.125Gbps
 		 * SERDES speed. The values required for 1.25 Gbps are almost
@@ -610,11 +610,12 @@ static void comphy_gbe_phy_init(struct mvebu_a3700_comphy_lane *lane,
 		 * comparison to 3.125 Gbps values. These register values are
 		 * stored in "gbe_phy_init_fix" array.
 		 */
-		if (!is_1gbps && gbe_phy_init_fix[fix_idx].addr == addr) {
+		if (!is_1gbps &&
+		    fix_idx < ARRAY_SIZE(gbe_phy_init_fix) &&
+		    gbe_phy_init_fix[fix_idx].addr == addr) {
 			/* Use new value */
 			val = gbe_phy_init_fix[fix_idx].value;
-			if (fix_idx < ARRAY_SIZE(gbe_phy_init_fix))
-				fix_idx++;
+			fix_idx++;
 		} else {
 			val = gbe_phy_init[addr];
 		}
diff --git a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
index 1d355b32ba55..c6aa6bc69e90 100644
--- a/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
+++ b/drivers/phy/rockchip/phy-rockchip-snps-pcie3.c
@@ -39,6 +39,8 @@
 #define RK3588_BIFURCATION_LANE_0_1		BIT(0)
 #define RK3588_BIFURCATION_LANE_2_3		BIT(1)
 #define RK3588_LANE_AGGREGATION		BIT(2)
+#define RK3588_PCIE1LN_SEL_EN			(GENMASK(1, 0) << 16)
+#define RK3588_PCIE30_PHY_MODE_EN		(GENMASK(2, 0) << 16)
 
 struct rockchip_p3phy_ops;
 
@@ -131,7 +133,7 @@ static const struct rockchip_p3phy_ops rk3568_ops = {
 static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
 {
 	u32 reg = 0;
-	u8 mode = 0;
+	u8 mode = RK3588_LANE_AGGREGATION; /* default */
 	int ret;
 
 	/* Deassert PCIe PMA output clamp mode */
@@ -139,31 +141,24 @@ static int rockchip_p3phy_rk3588_init(struct rockchip_p3phy_priv *priv)
 
 	/* Set bifurcation if needed */
 	for (int i = 0; i < priv->num_lanes; i++) {
-		if (!priv->lanes[i])
-			mode |= (BIT(i) << 3);
-
 		if (priv->lanes[i] > 1)
-			mode |= (BIT(i) >> 1);
-	}
-
-	if (!mode)
-		reg = RK3588_LANE_AGGREGATION;
-	else {
-		if (mode & (BIT(0) | BIT(1)))
-			reg |= RK3588_BIFURCATION_LANE_0_1;
-
-		if (mode & (BIT(2) | BIT(3)))
-			reg |= RK3588_BIFURCATION_LANE_2_3;
+			mode &= ~RK3588_LANE_AGGREGATION;
+		if (priv->lanes[i] == 3)
+			mode |= RK3588_BIFURCATION_LANE_0_1;
+		if (priv->lanes[i] == 4)
+			mode |= RK3588_BIFURCATION_LANE_2_3;
 	}
 
-	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0, (0x7<<16) | reg);
+	reg = mode;
+	regmap_write(priv->phy_grf, RK3588_PCIE3PHY_GRF_CMN_CON0,
+		     RK3588_PCIE30_PHY_MODE_EN | reg);
 
 	/* Set pcie1ln_sel in PHP_GRF_PCIESEL_CON */
 	if (!IS_ERR(priv->pipe_grf)) {
-		reg = (mode & (BIT(6) | BIT(7))) >> 6;
+		reg = mode & (RK3588_BIFURCATION_LANE_0_1 | RK3588_BIFURCATION_LANE_2_3);
 		if (reg)
 			regmap_write(priv->pipe_grf, PHP_GRF_PCIESEL_CON,
-				     (reg << 16) | reg);
+				     RK3588_PCIE1LN_SEL_EN | reg);
 	}
 
 	reset_control_deassert(priv->p30phy);
diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index 669c13d6e402..bdd44ec3e809 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -64,7 +64,6 @@ struct tusb1210 {
 	struct delayed_work chg_det_work;
 	struct notifier_block psy_nb;
 	struct power_supply *psy;
-	struct power_supply *charger;
 #endif
 };
 
@@ -230,19 +229,24 @@ static const char * const tusb1210_chargers[] = {
 
 static bool tusb1210_get_online(struct tusb1210 *tusb)
 {
+	struct power_supply *charger = NULL;
 	union power_supply_propval val;
-	int i;
+	bool online = false;
+	int i, ret;
 
-	for (i = 0; i < ARRAY_SIZE(tusb1210_chargers) && !tusb->charger; i++)
-		tusb->charger = power_supply_get_by_name(tusb1210_chargers[i]);
+	for (i = 0; i < ARRAY_SIZE(tusb1210_chargers) && !charger; i++)
+		charger = power_supply_get_by_name(tusb1210_chargers[i]);
 
-	if (!tusb->charger)
+	if (!charger)
 		return false;
 
-	if (power_supply_get_property(tusb->charger, POWER_SUPPLY_PROP_ONLINE, &val))
-		return false;
+	ret = power_supply_get_property(charger, POWER_SUPPLY_PROP_ONLINE, &val);
+	if (ret == 0)
+		online = val.intval;
+
+	power_supply_put(charger);
 
-	return val.intval;
+	return online;
 }
 
 static void tusb1210_chg_det_work(struct work_struct *work)
@@ -466,9 +470,6 @@ static void tusb1210_remove_charger_detect(struct tusb1210 *tusb)
 		cancel_delayed_work_sync(&tusb->chg_det_work);
 		power_supply_unregister(tusb->psy);
 	}
-
-	if (tusb->charger)
-		power_supply_put(tusb->charger);
 }
 #else
 static void tusb1210_probe_charger_detect(struct tusb1210 *tusb) { }
diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 49883c8012e6..3b376345d4d4 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -200,7 +200,7 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
  */
 static vm_fault_t fb_deferred_io_page_mkwrite(struct fb_info *info, struct vm_fault *vmf)
 {
-	unsigned long offset = vmf->address - vmf->vma->vm_start;
+	unsigned long offset = vmf->pgoff << PAGE_SHIFT;
 	struct page *page = vmf->page;
 
 	file_update_time(vmf->vma->vm_file);
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 18cf801ab590..23d0372e8882 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2475,20 +2475,14 @@ struct btrfs_data_container *init_data_container(u32 total_bytes)
 	size_t alloc_bytes;
 
 	alloc_bytes = max_t(size_t, total_bytes, sizeof(*data));
-	data = kvmalloc(alloc_bytes, GFP_KERNEL);
+	data = kvzalloc(alloc_bytes, GFP_KERNEL);
 	if (!data)
 		return ERR_PTR(-ENOMEM);
 
-	if (total_bytes >= sizeof(*data)) {
+	if (total_bytes >= sizeof(*data))
 		data->bytes_left = total_bytes - sizeof(*data);
-		data->bytes_missing = 0;
-	} else {
+	else
 		data->bytes_missing = sizeof(*data) - total_bytes;
-		data->bytes_left = 0;
-	}
-
-	data->elem_cnt = 0;
-	data->elem_missed = 0;
 
 	return data;
 }
diff --git a/fs/smb/client/cifs_spnego.h b/fs/smb/client/cifs_spnego.h
index 7f102ffeb675..e4d751b0c812 100644
--- a/fs/smb/client/cifs_spnego.h
+++ b/fs/smb/client/cifs_spnego.h
@@ -24,7 +24,7 @@ struct cifs_spnego_msg {
 	uint32_t	flags;
 	uint32_t	sesskey_len;
 	uint32_t	secblob_len;
-	uint8_t		data[1];
+	uint8_t		data[];
 };
 
 #ifdef __KERNEL__
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 0a79771c8f33..f0a3336ffb6c 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -387,6 +387,7 @@ cifs_alloc_inode(struct super_block *sb)
 	 * server, can not assume caching of file data or metadata.
 	 */
 	cifs_set_oplock_level(cifs_inode, 0);
+	cifs_inode->lease_granted = false;
 	cifs_inode->flags = 0;
 	spin_lock_init(&cifs_inode->writers_lock);
 	cifs_inode->writers = 0;
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 97bb1838555b..9cb457706334 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -562,7 +562,7 @@ typedef union smb_com_session_setup_andx {
 		__u32 Reserved;
 		__le32 Capabilities;	/* see below */
 		__le16 ByteCount;
-		unsigned char SecurityBlob[1];	/* followed by */
+		unsigned char SecurityBlob[];	/* followed by */
 		/* STRING NativeOS */
 		/* STRING NativeLanMan */
 	} __attribute__((packed)) req;	/* NTLM request format (with
@@ -582,7 +582,7 @@ typedef union smb_com_session_setup_andx {
 		__u32 Reserved;	/* see below */
 		__le32 Capabilities;
 		__le16 ByteCount;
-		unsigned char CaseInsensitivePassword[1];     /* followed by: */
+		unsigned char CaseInsensitivePassword[];     /* followed by: */
 		/* unsigned char * CaseSensitivePassword; */
 		/* STRING AccountName */
 		/* STRING PrimaryDomain */
@@ -599,7 +599,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 Action;	/* see below */
 		__le16 SecurityBlobLength;
 		__u16 ByteCount;
-		unsigned char SecurityBlob[1];	/* followed by */
+		unsigned char SecurityBlob[];	/* followed by */
 /*      unsigned char  * NativeOS;      */
 /*	unsigned char  * NativeLanMan;  */
 /*      unsigned char  * PrimaryDomain; */
@@ -618,7 +618,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 PasswordLength;
 		__u32 Reserved; /* encrypt key len and offset */
 		__le16 ByteCount;
-		unsigned char AccountPassword[1];	/* followed by */
+		unsigned char AccountPassword[];	/* followed by */
 		/* STRING AccountName */
 		/* STRING PrimaryDomain */
 		/* STRING NativeOS */
@@ -632,7 +632,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 AndXOffset;
 		__le16 Action;	/* see below */
 		__u16 ByteCount;
-		unsigned char NativeOS[1];	/* followed by */
+		unsigned char NativeOS[];	/* followed by */
 /*	unsigned char * NativeLanMan; */
 /*      unsigned char * PrimaryDomain; */
 	} __attribute__((packed)) old_resp; /* pre-NTLM (LANMAN2.1) response */
@@ -693,7 +693,7 @@ typedef struct smb_com_tconx_req {
 	__le16 Flags;		/* see below */
 	__le16 PasswordLength;
 	__le16 ByteCount;
-	unsigned char Password[1];	/* followed by */
+	unsigned char Password[];	/* followed by */
 /* STRING Path    *//* \\server\share name */
 	/* STRING Service */
 } __attribute__((packed)) TCONX_REQ;
@@ -705,7 +705,7 @@ typedef struct smb_com_tconx_rsp {
 	__le16 AndXOffset;
 	__le16 OptionalSupport;	/* see below */
 	__u16 ByteCount;
-	unsigned char Service[1];	/* always ASCII, not Unicode */
+	unsigned char Service[];	/* always ASCII, not Unicode */
 	/* STRING NativeFileSystem */
 } __attribute__((packed)) TCONX_RSP;
 
@@ -718,7 +718,7 @@ typedef struct smb_com_tconx_rsp_ext {
 	__le32 MaximalShareAccessRights;
 	__le32 GuestMaximalShareAccessRights;
 	__u16 ByteCount;
-	unsigned char Service[1];	/* always ASCII, not Unicode */
+	unsigned char Service[];	/* always ASCII, not Unicode */
 	/* STRING NativeFileSystem */
 } __attribute__((packed)) TCONX_RSP_EXT;
 
@@ -755,14 +755,14 @@ typedef struct smb_com_echo_req {
 	struct	smb_hdr hdr;
 	__le16	EchoCount;
 	__le16	ByteCount;
-	char	Data[1];
+	char	Data[];
 } __attribute__((packed)) ECHO_REQ;
 
 typedef struct smb_com_echo_rsp {
 	struct	smb_hdr hdr;
 	__le16	SequenceNumber;
 	__le16	ByteCount;
-	char	Data[1];
+	char	Data[];
 } __attribute__((packed)) ECHO_RSP;
 
 typedef struct smb_com_logoff_andx_req {
@@ -862,7 +862,7 @@ typedef struct smb_com_open_req {	/* also handles create */
 	__le32 ImpersonationLevel;
 	__u8 SecurityFlags;
 	__le16 ByteCount;
-	char fileName[1];
+	char fileName[];
 } __attribute__((packed)) OPEN_REQ;
 
 /* open response: oplock levels */
@@ -882,7 +882,7 @@ typedef struct smb_com_open_rsp {
 	__u8 OplockLevel;
 	__u16 Fid;
 	__le32 CreateAction;
-	struct_group(common_attributes,
+	struct_group_attr(common_attributes, __packed,
 		__le64 CreationTime;
 		__le64 LastAccessTime;
 		__le64 LastWriteTime;
@@ -939,7 +939,7 @@ typedef struct smb_com_openx_req {
 	__le32 Timeout;
 	__le32 Reserved;
 	__le16  ByteCount;  /* file name follows */
-	char   fileName[1];
+	char   fileName[];
 } __attribute__((packed)) OPENX_REQ;
 
 typedef struct smb_com_openx_rsp {
@@ -1087,7 +1087,7 @@ typedef struct smb_com_lock_req {
 	__le16 NumberOfUnlocks;
 	__le16 NumberOfLocks;
 	__le16 ByteCount;
-	LOCKING_ANDX_RANGE Locks[1];
+	LOCKING_ANDX_RANGE Locks[];
 } __attribute__((packed)) LOCK_REQ;
 
 /* lock type */
@@ -1116,7 +1116,7 @@ typedef struct smb_com_rename_req {
 	__le16 SearchAttributes;	/* target file attributes */
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII or Unicode */
-	unsigned char OldFileName[1];
+	unsigned char OldFileName[];
 	/* followed by __u8 BufferFormat2 */
 	/* followed by NewFileName */
 } __attribute__((packed)) RENAME_REQ;
@@ -1136,7 +1136,7 @@ typedef struct smb_com_copy_req {
 	__le16 Flags;
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII or Unicode */
-	unsigned char OldFileName[1];
+	unsigned char OldFileName[];
 	/* followed by __u8 BufferFormat2 */
 	/* followed by NewFileName string */
 } __attribute__((packed)) COPY_REQ;
@@ -1146,7 +1146,7 @@ typedef struct smb_com_copy_rsp {
 	__le16 CopyCount;    /* number of files copied */
 	__u16 ByteCount;    /* may be zero */
 	__u8 BufferFormat;  /* 0x04 - only present if errored file follows */
-	unsigned char ErrorFileName[1]; /* only present if error in copy */
+	unsigned char ErrorFileName[]; /* only present if error in copy */
 } __attribute__((packed)) COPY_RSP;
 
 #define CREATE_HARD_LINK		0x103
@@ -1160,7 +1160,7 @@ typedef struct smb_com_nt_rename_req {	/* A5 - also used for create hardlink */
 	__le32 ClusterCount;
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII or Unicode */
-	unsigned char OldFileName[1];
+	unsigned char OldFileName[];
 	/* followed by __u8 BufferFormat2 */
 	/* followed by NewFileName */
 } __attribute__((packed)) NT_RENAME_REQ;
@@ -1175,7 +1175,7 @@ typedef struct smb_com_delete_file_req {
 	__le16 SearchAttributes;
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII */
-	unsigned char fileName[1];
+	unsigned char fileName[];
 } __attribute__((packed)) DELETE_FILE_REQ;
 
 typedef struct smb_com_delete_file_rsp {
@@ -1187,7 +1187,7 @@ typedef struct smb_com_delete_directory_req {
 	struct smb_hdr hdr;	/* wct = 0 */
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII */
-	unsigned char DirName[1];
+	unsigned char DirName[];
 } __attribute__((packed)) DELETE_DIRECTORY_REQ;
 
 typedef struct smb_com_delete_directory_rsp {
@@ -1199,7 +1199,7 @@ typedef struct smb_com_create_directory_req {
 	struct smb_hdr hdr;	/* wct = 0 */
 	__le16 ByteCount;
 	__u8 BufferFormat;	/* 4 = ASCII */
-	unsigned char DirName[1];
+	unsigned char DirName[];
 } __attribute__((packed)) CREATE_DIRECTORY_REQ;
 
 typedef struct smb_com_create_directory_rsp {
@@ -1211,7 +1211,7 @@ typedef struct smb_com_query_information_req {
 	struct smb_hdr hdr;     /* wct = 0 */
 	__le16 ByteCount;	/* 1 + namelen + 1 */
 	__u8 BufferFormat;      /* 4 = ASCII */
-	unsigned char FileName[1];
+	unsigned char FileName[];
 } __attribute__((packed)) QUERY_INFORMATION_REQ;
 
 typedef struct smb_com_query_information_rsp {
@@ -1231,7 +1231,7 @@ typedef struct smb_com_setattr_req {
 	__le16 reserved[5]; /* must be zero */
 	__u16  ByteCount;
 	__u8   BufferFormat; /* 4 = ASCII */
-	unsigned char fileName[1];
+	unsigned char fileName[];
 } __attribute__((packed)) SETATTR_REQ;
 
 typedef struct smb_com_setattr_rsp {
@@ -1313,7 +1313,7 @@ typedef struct smb_com_transaction_ioctl_req {
 	__u8 IsRootFlag; /* 1 = apply command to root of share (must be DFS) */
 	__le16 ByteCount;
 	__u8 Pad[3];
-	__u8 Data[1];
+	__u8 Data[];
 } __attribute__((packed)) TRANSACT_IOCTL_REQ;
 
 typedef struct smb_com_transaction_compr_ioctl_req {
@@ -1431,8 +1431,8 @@ typedef struct smb_com_transaction_change_notify_req {
 	__u8 WatchTree;  /* 1 = Monitor subdirectories */
 	__u8 Reserved2;
 	__le16 ByteCount;
-/* 	__u8 Pad[3];*/
-/*	__u8 Data[1];*/
+/*	__u8 Pad[3];*/
+/*	__u8 Data[];*/
 } __attribute__((packed)) TRANSACT_CHANGE_NOTIFY_REQ;
 
 /* BB eventually change to use generic ntransact rsp struct
@@ -1521,7 +1521,7 @@ struct cifs_quota_data {
 	__u64	space_used;
 	__u64	soft_limit;
 	__u64	hard_limit;
-	char	sid[1];  /* variable size? */
+	char	sid[];  /* variable size? */
 } __attribute__((packed));
 
 /* quota sub commands */
@@ -1673,7 +1673,7 @@ typedef struct smb_com_transaction2_qpi_req {
 	__u8 Pad;
 	__le16 InformationLevel;
 	__u32 Reserved4;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) TRANSACTION2_QPI_REQ;
 
 typedef struct smb_com_transaction2_qpi_rsp {
@@ -1706,7 +1706,7 @@ typedef struct smb_com_transaction2_spi_req {
 	__u16 Pad1;
 	__le16 InformationLevel;
 	__u32 Reserved4;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) TRANSACTION2_SPI_REQ;
 
 typedef struct smb_com_transaction2_spi_rsp {
@@ -1813,7 +1813,7 @@ typedef struct smb_com_transaction2_ffirst_req {
 	__le16 SearchFlags;
 	__le16 InformationLevel;
 	__le32 SearchStorageType;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) TRANSACTION2_FFIRST_REQ;
 
 typedef struct smb_com_transaction2_ffirst_rsp {
@@ -2024,7 +2024,7 @@ typedef struct smb_com_transaction2_get_dfs_refer_req {
 				   perhaps?) followed by one byte pad - doesn't
 				   seem to matter though */
 	__le16 MaxReferralLevel;
-	char RequestFileName[1];
+	char RequestFileName[];
 } __attribute__((packed)) TRANSACTION2_GET_DFS_REFER_REQ;
 
 #define DFS_VERSION cpu_to_le16(0x0003)
@@ -2053,7 +2053,7 @@ struct get_dfs_referral_rsp {
 	__le16 PathConsumed;
 	__le16 NumberOfReferrals;
 	__le32 DFSFlags;
-	REFERRAL3 referrals[1];	/* array of level 3 dfs_referral structures */
+	REFERRAL3 referrals[];	/* array of level 3 dfs_referral structures */
 	/* followed by the strings pointed to by the referral structures */
 } __packed;
 
@@ -2270,7 +2270,7 @@ typedef struct {
 /* QueryFileInfo/QueryPathinfo (also for SetPath/SetFile) data buffer formats */
 /******************************************************************************/
 typedef struct { /* data block encoding of response to level 263 QPathInfo */
-	struct_group(common_attributes,
+	struct_group_attr(common_attributes, __packed,
 		__le64 CreationTime;
 		__le64 LastAccessTime;
 		__le64 LastWriteTime;
@@ -2292,7 +2292,10 @@ typedef struct { /* data block encoding of response to level 263 QPathInfo */
 	__le32 Mode;
 	__le32 AlignmentRequirement;
 	__le32 FileNameLength;
-	char FileName[1];
+	union {
+		char __pad;
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __attribute__((packed)) FILE_ALL_INFO;	/* level 0x107 QPathInfo */
 
 typedef struct {
@@ -2330,7 +2333,7 @@ typedef struct {
 } __attribute__((packed)) FILE_UNIX_BASIC_INFO;	/* level 0x200 QPathInfo */
 
 typedef struct {
-	char LinkDest[1];
+	DECLARE_FLEX_ARRAY(char, LinkDest);
 } __attribute__((packed)) FILE_UNIX_LINK_INFO;	/* level 0x201 QPathInfo */
 
 /* The following three structures are needed only for
@@ -2380,7 +2383,7 @@ struct file_end_of_file_info {
 } __attribute__((packed)); /* size info, level 0x104 for set, 0x106 for query */
 
 struct file_alt_name_info {
-	__u8   alt_name[1];
+	DECLARE_FLEX_ARRAY(__u8, alt_name);
 } __attribute__((packed));      /* level 0x0108 */
 
 struct file_stream_info {
@@ -2490,7 +2493,10 @@ typedef struct {
 	__le32 NextEntryOffset;
 	__u32 ResumeKey; /* as with FileIndex - no need to convert */
 	FILE_UNIX_BASIC_INFO basic;
-	char FileName[1];
+	union {
+		char __pad;
+		DECLARE_FLEX_ARRAY(char, FileName);
+	};
 } __attribute__((packed)) FILE_UNIX_INFO; /* level 0x202 */
 
 typedef struct {
@@ -2504,7 +2510,7 @@ typedef struct {
 	__le64 AllocationSize;
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FILE_DIRECTORY_INFO;   /* level 0x101 FF resp data */
 
 typedef struct {
@@ -2519,7 +2525,7 @@ typedef struct {
 	__le32 ExtFileAttributes;
 	__le32 FileNameLength;
 	__le32 EaSize; /* length of the xattrs */
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FILE_FULL_DIRECTORY_INFO; /* level 0x102 rsp data */
 
 typedef struct {
@@ -2536,7 +2542,7 @@ typedef struct {
 	__le32 EaSize; /* EA size */
 	__le32 Reserved;
 	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit*/
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) SEARCH_ID_FULL_DIR_INFO; /* level 0x105 FF rsp data */
 
 typedef struct {
@@ -2554,7 +2560,7 @@ typedef struct {
 	__u8   ShortNameLength;
 	__u8   Reserved;
 	__u8   ShortName[24];
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FILE_BOTH_DIRECTORY_INFO; /* level 0x104 FFrsp data */
 
 typedef struct {
@@ -2569,7 +2575,7 @@ typedef struct {
 	__le32 AllocationSize;
 	__le16 Attributes; /* verify not u32 */
 	__u8   FileNameLength;
-	char FileName[1];
+	char FileName[];
 } __attribute__((packed)) FIND_FILE_STANDARD_INFO; /* level 0x1 FF resp data */
 
 
@@ -2579,16 +2585,6 @@ struct win_dev {
 	__le64 minor;
 } __attribute__((packed));
 
-struct gea {
-	unsigned char name_len;
-	char name[1];
-} __attribute__((packed));
-
-struct gealist {
-	unsigned long list_len;
-	struct gea list[1];
-} __attribute__((packed));
-
 struct fea {
 	unsigned char EA_flags;
 	__u8 name_len;
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 4d5302b58b53..ca39d01077cd 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -676,6 +676,16 @@ static int smb3_fs_context_validate(struct fs_context *fc)
 	/* set the port that we got earlier */
 	cifs_set_port((struct sockaddr *)&ctx->dstaddr, ctx->port);
 
+	if (ctx->uid_specified && !ctx->forceuid_specified) {
+		ctx->override_uid = 1;
+		pr_notice("enabling forceuid mount option implicitly because uid= option is specified\n");
+	}
+
+	if (ctx->gid_specified && !ctx->forcegid_specified) {
+		ctx->override_gid = 1;
+		pr_notice("enabling forcegid mount option implicitly because gid= option is specified\n");
+	}
+
 	if (ctx->override_uid && !ctx->uid_specified) {
 		ctx->override_uid = 0;
 		pr_notice("ignoring forceuid mount option specified with no uid= option\n");
@@ -923,12 +933,14 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			ctx->override_uid = 0;
 		else
 			ctx->override_uid = 1;
+		ctx->forceuid_specified = true;
 		break;
 	case Opt_forcegid:
 		if (result.negated)
 			ctx->override_gid = 0;
 		else
 			ctx->override_gid = 1;
+		ctx->forcegid_specified = true;
 		break;
 	case Opt_perm:
 		if (result.negated)
diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
index 26093f54d3e6..319a91b7f670 100644
--- a/fs/smb/client/fs_context.h
+++ b/fs/smb/client/fs_context.h
@@ -154,6 +154,8 @@ enum cifs_param {
 };
 
 struct smb3_fs_context {
+	bool forceuid_specified;
+	bool forcegid_specified;
 	bool uid_specified;
 	bool cruid_specified;
 	bool gid_specified;
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 5990bdbae598..9a1f1913fb59 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -497,7 +497,7 @@ static char *nxt_dir_entry(char *old_entry, char *end_of_smb, int level)
 		FIND_FILE_STANDARD_INFO *pfData;
 		pfData = (FIND_FILE_STANDARD_INFO *)pDirInfo;
 
-		new_entry = old_entry + sizeof(FIND_FILE_STANDARD_INFO) +
+		new_entry = old_entry + sizeof(FIND_FILE_STANDARD_INFO) + 1 +
 				pfData->FileNameLength;
 	} else {
 		u32 next_offset = le32_to_cpu(pDirInfo->NextEntryOffset);
@@ -515,9 +515,9 @@ static char *nxt_dir_entry(char *old_entry, char *end_of_smb, int level)
 			 new_entry, end_of_smb, old_entry);
 		return NULL;
 	} else if (((level == SMB_FIND_FILE_INFO_STANDARD) &&
-		    (new_entry + sizeof(FIND_FILE_STANDARD_INFO) > end_of_smb))
+		    (new_entry + sizeof(FIND_FILE_STANDARD_INFO) + 1 > end_of_smb))
 		  || ((level != SMB_FIND_FILE_INFO_STANDARD) &&
-		   (new_entry + sizeof(FILE_DIRECTORY_INFO) > end_of_smb)))  {
+		   (new_entry + sizeof(FILE_DIRECTORY_INFO) + 1 > end_of_smb)))  {
 		cifs_dbg(VFS, "search entry %p extends after end of SMB %p\n",
 			 new_entry, end_of_smb);
 		return NULL;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index cc425a616899..e15bf116c755 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -5073,10 +5073,10 @@ smb2_parse_query_directory(struct cifs_tcon *tcon,
 
 	switch (srch_inf->info_level) {
 	case SMB_FIND_FILE_DIRECTORY_INFO:
-		info_buf_size = sizeof(FILE_DIRECTORY_INFO) - 1;
+		info_buf_size = sizeof(FILE_DIRECTORY_INFO);
 		break;
 	case SMB_FIND_FILE_ID_FULL_DIR_INFO:
-		info_buf_size = sizeof(SEARCH_ID_FULL_DIR_INFO) - 1;
+		info_buf_size = sizeof(SEARCH_ID_FULL_DIR_INFO);
 		break;
 	case SMB_FIND_FILE_POSIX_INFO:
 		/* note that posix payload are variable size */
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index 8d011fedecd0..2823526b66f7 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -339,7 +339,7 @@ struct smb2_file_reparse_point_info {
 } __packed;
 
 struct smb2_file_network_open_info {
-	struct_group(network_open_info,
+	struct_group_attr(network_open_info, __packed,
 		__le64 CreationTime;
 		__le64 LastAccessTime;
 		__le64 LastWriteTime;
@@ -373,7 +373,7 @@ struct smb2_file_id_extd_directory_info {
 	__le32 EaSize; /* EA size */
 	__le32 ReparsePointTag; /* valid if FILE_ATTR_REPARSE_POINT set in FileAttributes */
 	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit */
-	char FileName[1];
+	char FileName[];
 } __packed; /* level 60 */
 
 extern char smb2_padding[7];
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index df44acaec9ae..338b34c99b2d 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -931,12 +931,15 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 			list_del_init(&mid->qhead);
 			mid->mid_flags |= MID_DELETED;
 		}
+		spin_unlock(&server->mid_lock);
 		cifs_server_dbg(VFS, "%s: invalid mid state mid=%llu state=%d\n",
 			 __func__, mid->mid, mid->mid_state);
 		rc = -EIO;
+		goto sync_mid_done;
 	}
 	spin_unlock(&server->mid_lock);
 
+sync_mid_done:
 	release_mid(mid);
 	return rc;
 }
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index a541f0c4f146..d7eef2158667 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -593,6 +593,31 @@ static inline void eth_hw_addr_gen(struct net_device *dev, const u8 *base_addr,
 	eth_hw_addr_set(dev, addr);
 }
 
+/**
+ * eth_skb_pkt_type - Assign packet type if destination address does not match
+ * @skb: Assigned a packet type if address does not match @dev address
+ * @dev: Network device used to compare packet address against
+ *
+ * If the destination MAC address of the packet does not match the network
+ * device address, assign an appropriate packet type.
+ */
+static inline void eth_skb_pkt_type(struct sk_buff *skb,
+				    const struct net_device *dev)
+{
+	const struct ethhdr *eth = eth_hdr(skb);
+
+	if (unlikely(!ether_addr_equal_64bits(eth->h_dest, dev->dev_addr))) {
+		if (unlikely(is_multicast_ether_addr_64bits(eth->h_dest))) {
+			if (ether_addr_equal_64bits(eth->h_dest, dev->broadcast))
+				skb->pkt_type = PACKET_BROADCAST;
+			else
+				skb->pkt_type = PACKET_MULTICAST;
+		} else {
+			skb->pkt_type = PACKET_OTHERHOST;
+		}
+	}
+}
+
 /**
  * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
  * @skb: Buffer to pad
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 16d6936baa2f..e7d71a516bd4 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -79,6 +79,9 @@ enum unix_socket_lock_class {
 	U_LOCK_NORMAL,
 	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
 	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
+	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
+			     * candidates to close a small race window.
+			     */
 };
 
 static inline void unix_state_lock_nested(struct sock *sk,
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 65c93959c2dc..dd578d193f9a 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -302,6 +302,7 @@ struct macsec_ops {
 	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
+	bool rx_uses_md_dst;
 };
 
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
diff --git a/include/net/sock.h b/include/net/sock.h
index 60577751ea9e..77298c74822a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1483,33 +1483,36 @@ sk_memory_allocated(const struct sock *sk)
 
 /* 1 MB per cpu, in page units */
 #define SK_MEMORY_PCPU_RESERVE (1 << (20 - PAGE_SHIFT))
+extern int sysctl_mem_pcpu_rsv;
+
+static inline void proto_memory_pcpu_drain(struct proto *proto)
+{
+	int val = this_cpu_xchg(*proto->per_cpu_fw_alloc, 0);
+
+	if (val)
+		atomic_long_add(val, proto->memory_allocated);
+}
 
 static inline void
-sk_memory_allocated_add(struct sock *sk, int amt)
+sk_memory_allocated_add(const struct sock *sk, int val)
 {
-	int local_reserve;
+	struct proto *proto = sk->sk_prot;
 
-	preempt_disable();
-	local_reserve = __this_cpu_add_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
-	if (local_reserve >= SK_MEMORY_PCPU_RESERVE) {
-		__this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserve);
-		atomic_long_add(local_reserve, sk->sk_prot->memory_allocated);
-	}
-	preempt_enable();
+	val = this_cpu_add_return(*proto->per_cpu_fw_alloc, val);
+
+	if (unlikely(val >= READ_ONCE(sysctl_mem_pcpu_rsv)))
+		proto_memory_pcpu_drain(proto);
 }
 
 static inline void
-sk_memory_allocated_sub(struct sock *sk, int amt)
+sk_memory_allocated_sub(const struct sock *sk, int val)
 {
-	int local_reserve;
+	struct proto *proto = sk->sk_prot;
 
-	preempt_disable();
-	local_reserve = __this_cpu_sub_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
-	if (local_reserve <= -SK_MEMORY_PCPU_RESERVE) {
-		__this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserve);
-		atomic_long_add(local_reserve, sk->sk_prot->memory_allocated);
-	}
-	preempt_enable();
+	val = this_cpu_sub_return(*proto->per_cpu_fw_alloc, val);
+
+	if (unlikely(val <= -READ_ONCE(sysctl_mem_pcpu_rsv)))
+		proto_memory_pcpu_drain(proto);
 }
 
 #define SK_ALLOC_PERCPU_COUNTER_BATCH 16
diff --git a/init/Kconfig b/init/Kconfig
index b63dce6706c5..537f01eba2e6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1920,11 +1920,11 @@ config RUST
 	bool "Rust support"
 	depends on HAVE_RUST
 	depends on RUST_IS_AVAILABLE
+	depends on !CFI_CLANG
 	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
-	select CONSTRUCTORS
 	help
 	  Enables Rust support in the kernel.
 
diff --git a/kernel/bounds.c b/kernel/bounds.c
index c5a9fcd2d622..29b2cd00df2c 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -19,7 +19,7 @@ int main(void)
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
 	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
 #ifdef CONFIG_SMP
-	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
+	DEFINE(NR_CPUS_BITS, order_base_2(CONFIG_NR_CPUS));
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 #ifdef CONFIG_LRU_GEN
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 2c44dd12a158..e0e09b700b43 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2788,8 +2788,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-						     CPU_MITIGATIONS_OFF;
+	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+					     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 85617928041c..7e9a5919299b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -662,6 +662,15 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
 		tmp->vm_flags &= ~(VM_LOCKED | VM_LOCKONFAULT);
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
 		file = tmp->vm_file;
 		if (file) {
 			struct address_space *mapping = file->f_mapping;
@@ -678,12 +687,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			i_mmap_unlock_write(mapping);
 		}
 
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
 		/* Link the vma into the MT */
 		mas.index = tmp->vm_start;
 		mas.last = tmp->vm_end - 1;
@@ -695,9 +698,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval = copy_page_range(tmp, mpnt);
 
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
 		if (retval)
 			goto loop_out;
 	}
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 79e894cf8406..77eb944b7a6b 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -466,10 +466,10 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
-		 * contexts and I/O.
+		 * contexts, I/O, nolockdep.
 		 */
 		alloc_flags &= ~GFP_ZONEMASK;
-		alloc_flags &= (GFP_ATOMIC | GFP_KERNEL);
+		alloc_flags &= (GFP_ATOMIC | GFP_KERNEL | __GFP_NOLOCKDEP);
 		alloc_flags |= __GFP_NOWARN;
 		page = alloc_pages(alloc_flags, STACK_ALLOC_ORDER);
 		if (page)
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 6b4c25a92377..0bffac238b61 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -103,7 +103,7 @@ static void ax25_kill_by_device(struct net_device *dev)
 			s->ax25_dev = NULL;
 			if (sk->sk_socket) {
 				netdev_put(ax25_dev->dev,
-					   &ax25_dev->dev_tracker);
+					   &s->dev_tracker);
 				ax25_dev_put(ax25_dev);
 			}
 			ax25_cb_del(s);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4198ca66fbe1..e3c7029ec8a6 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -457,7 +457,8 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct l2cap_options opts;
 	struct l2cap_conninfo cinfo;
-	int len, err = 0;
+	int err = 0;
+	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -504,7 +505,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 
 		BT_DBG("mode 0x%2.2x", chan->mode);
 
-		len = min_t(unsigned int, len, sizeof(opts));
+		len = min(len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
 			err = -EFAULT;
 
@@ -554,7 +555,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 		cinfo.hci_handle = chan->conn->hcon->handle;
 		memcpy(cinfo.dev_class, chan->conn->hcon->dev_class, 3);
 
-		len = min_t(unsigned int, len, sizeof(cinfo));
+		len = min(len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *) &cinfo, len))
 			err = -EFAULT;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 716f6dc4934b..76dac5a90aef 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2680,7 +2680,11 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto failed;
 	}
 
-	err = hci_cmd_sync_queue(hdev, add_uuid_sync, cmd, mgmt_class_complete);
+	/* MGMT_OP_ADD_UUID don't require adapter the UP/Running so use
+	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
+	 */
+	err = hci_cmd_sync_submit(hdev, add_uuid_sync, cmd,
+				  mgmt_class_complete);
 	if (err < 0) {
 		mgmt_pending_free(cmd);
 		goto failed;
@@ -2774,8 +2778,11 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	err = hci_cmd_sync_queue(hdev, remove_uuid_sync, cmd,
-				 mgmt_class_complete);
+	/* MGMT_OP_REMOVE_UUID don't require adapter the UP/Running so use
+	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
+	 */
+	err = hci_cmd_sync_submit(hdev, remove_uuid_sync, cmd,
+				  mgmt_class_complete);
 	if (err < 0)
 		mgmt_pending_free(cmd);
 
@@ -2841,8 +2848,11 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	err = hci_cmd_sync_queue(hdev, set_class_sync, cmd,
-				 mgmt_class_complete);
+	/* MGMT_OP_SET_DEV_CLASS don't require adapter the UP/Running so use
+	 * hci_cmd_sync_submit instead of hci_cmd_sync_queue.
+	 */
+	err = hci_cmd_sync_submit(hdev, set_class_sync, cmd,
+				  mgmt_class_complete);
 	if (err < 0)
 		mgmt_pending_free(cmd);
 
@@ -5530,8 +5540,8 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	err = hci_cmd_sync_queue(hdev, mgmt_remove_adv_monitor_sync, cmd,
-				 mgmt_remove_adv_monitor_complete);
+	err = hci_cmd_sync_submit(hdev, mgmt_remove_adv_monitor_sync, cmd,
+				  mgmt_remove_adv_monitor_complete);
 
 	if (err) {
 		mgmt_pending_remove(cmd);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 2e9137c539a4..4a6bf60f3e7a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -971,7 +971,8 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 	struct sock *sk = sock->sk;
 	struct sco_options opts;
 	struct sco_conninfo cinfo;
-	int len, err = 0;
+	int err = 0;
+	size_t len;
 
 	BT_DBG("sk %p", sk);
 
@@ -993,7 +994,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 
 		BT_DBG("mtu %u", opts.mtu);
 
-		len = min_t(unsigned int, len, sizeof(opts));
+		len = min(len, sizeof(opts));
 		if (copy_to_user(optval, (char *)&opts, len))
 			err = -EFAULT;
 
@@ -1011,7 +1012,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 		cinfo.hci_handle = sco_pi(sk)->conn->hcon->handle;
 		memcpy(cinfo.dev_class, sco_pi(sk)->conn->hcon->dev_class, 3);
 
-		len = min_t(unsigned int, len, sizeof(cinfo));
+		len = min(len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *)&cinfo, len))
 			err = -EFAULT;
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index d087fd4c784a..d38eff27767d 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -650,7 +650,7 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
 {
 	u32 filter = RTEXT_FILTER_BRVLAN_COMPRESSED;
 
-	return br_info_notify(event, br, port, filter);
+	br_info_notify(event, br, port, filter);
 }
 
 /*
diff --git a/net/core/sock.c b/net/core/sock.c
index c8803b95ea0d..550af616f535 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -279,6 +279,7 @@ __u32 sysctl_rmem_max __read_mostly = SK_RMEM_MAX;
 EXPORT_SYMBOL(sysctl_rmem_max);
 __u32 sysctl_wmem_default __read_mostly = SK_WMEM_MAX;
 __u32 sysctl_rmem_default __read_mostly = SK_RMEM_MAX;
+int sysctl_mem_pcpu_rsv __read_mostly = SK_MEMORY_PCPU_RESERVE;
 
 /* Maximal space eaten by iovec or ancillary data plus some space */
 int sysctl_optmem_max __read_mostly = sizeof(unsigned long)*(2*UIO_MAXIOV+512);
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5b1ce656baa1..d281d5343ff4 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -29,6 +29,7 @@ static int int_3600 = 3600;
 static int min_sndbuf = SOCK_MIN_SNDBUF;
 static int min_rcvbuf = SOCK_MIN_RCVBUF;
 static int max_skb_frags = MAX_SKB_FRAGS;
+static int min_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE;
 
 static int net_msg_warn;	/* Unused, but still a sysctl */
 
@@ -348,6 +349,14 @@ static struct ctl_table net_core_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &min_rcvbuf,
 	},
+	{
+		.procname	= "mem_pcpu_rsv",
+		.data		= &sysctl_mem_pcpu_rsv,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &min_mem_pcpu_rsv,
+	},
 	{
 		.procname	= "dev_weight",
 		.data		= &weight_p,
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index e02daa74e833..5ba7b460cbf7 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -164,17 +164,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	eth = (struct ethhdr *)skb->data;
 	skb_pull_inline(skb, ETH_HLEN);
 
-	if (unlikely(!ether_addr_equal_64bits(eth->h_dest,
-					      dev->dev_addr))) {
-		if (unlikely(is_multicast_ether_addr_64bits(eth->h_dest))) {
-			if (ether_addr_equal_64bits(eth->h_dest, dev->broadcast))
-				skb->pkt_type = PACKET_BROADCAST;
-			else
-				skb->pkt_type = PACKET_MULTICAST;
-		} else {
-			skb->pkt_type = PACKET_OTHERHOST;
-		}
-	}
+	eth_skb_pkt_type(skb, dev);
 
 	/*
 	 * Some variants of DSA tagging don't have an ethertype field
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 2b09ef70752f..31051b327e53 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -92,6 +92,7 @@
 #include <net/inet_common.h>
 #include <net/ip_fib.h>
 #include <net/l3mdev.h>
+#include <net/addrconf.h>
 
 /*
  *	Build xmit assembly blocks
@@ -1029,6 +1030,8 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 	struct icmp_ext_hdr *ext_hdr, _ext_hdr;
 	struct icmp_ext_echo_iio *iio, _iio;
 	struct net *net = dev_net(skb->dev);
+	struct inet6_dev *in6_dev;
+	struct in_device *in_dev;
 	struct net_device *dev;
 	char buff[IFNAMSIZ];
 	u16 ident_len;
@@ -1112,10 +1115,15 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 	/* Fill bits in reply message */
 	if (dev->flags & IFF_UP)
 		status |= ICMP_EXT_ECHOREPLY_ACTIVE;
-	if (__in_dev_get_rcu(dev) && __in_dev_get_rcu(dev)->ifa_list)
+
+	in_dev = __in_dev_get_rcu(dev);
+	if (in_dev && rcu_access_pointer(in_dev->ifa_list))
 		status |= ICMP_EXT_ECHOREPLY_IPV4;
-	if (!list_empty(&rcu_dereference(dev->ip6_ptr)->addr_list))
+
+	in6_dev = __in6_dev_get(dev);
+	if (in6_dev && !list_empty(&in6_dev->addr_list))
 		status |= ICMP_EXT_ECHOREPLY_IPV6;
+
 	dev_put(dev);
 	icmphdr->un.echo.sequence |= htons(status);
 	return true;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index a0c687ff2598..6c0f1e347b85 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2168,6 +2168,9 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	int err = -EINVAL;
 	u32 tag = 0;
 
+	if (!in_dev)
+		return -EINVAL;
+
 	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
 		goto martian_source;
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2a78c78186c3..39fae7581d35 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1141,16 +1141,17 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (msg->msg_controllen) {
 		err = udp_cmsg_send(sk, msg, &ipc.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip_cmsg_send(sk, msg, &ipc,
 					   sk->sk_family == AF_INET6);
+			connected = 0;
+		}
 		if (unlikely(err < 0)) {
 			kfree(ipc.opt);
 			return err;
 		}
 		if (ipc.opt)
 			free = 1;
-		connected = 0;
 	}
 	if (!ipc.opt) {
 		struct ip_options_rcu *inet_opt;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 1775e9b9b85a..504ea27d08fb 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1493,9 +1493,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		ipc6.opt = opt;
 
 		err = udp_cmsg_send(sk, msg, &ipc6.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip6_datagram_send_ctl(sock_net(sk), sk, msg, fl6,
 						    &ipc6);
+			connected = false;
+		}
 		if (err < 0) {
 			fl6_sock_release(flowlabel);
 			return err;
@@ -1507,7 +1509,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 		if (!(opt->opt_nflen|opt->opt_flen))
 			opt = NULL;
-		connected = false;
 	}
 	if (!opt) {
 		opt = txopt_get(np);
diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
index a0921adc31a9..1e689c714127 100644
--- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
@@ -126,7 +126,8 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	if (sctph->source != cp->vport || payload_csum ||
 	    skb->ip_summed == CHECKSUM_PARTIAL) {
 		sctph->source = cp->vport;
-		sctp_nat_csum(skb, sctph, sctphoff);
+		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
+			sctp_nat_csum(skb, sctph, sctphoff);
 	} else {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
@@ -174,7 +175,8 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	    (skb->ip_summed == CHECKSUM_PARTIAL &&
 	     !(skb_dst(skb)->dev->features & NETIF_F_SCTP_CRC))) {
 		sctph->dest = cp->dport;
-		sctp_nat_csum(skb, sctph, sctphoff);
+		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
+			sctp_nat_csum(skb, sctph, sctphoff);
 	} else if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	}
diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 274b6f7e6bb5..d170758a1eb5 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -338,7 +338,9 @@ static void nft_netdev_event(unsigned long event, struct net_device *dev,
 		return;
 
 	if (n > 1) {
-		nf_unregister_net_hook(ctx->net, &found->ops);
+		if (!(ctx->chain->table->flags & NFT_TABLE_F_DORMANT))
+			nf_unregister_net_hook(ctx->net, &found->ops);
+
 		list_del_rcu(&found->list);
 		kfree_rcu(found, rcu);
 		return;
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index e4ba86b84b9b..2302bae1e012 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1920,9 +1920,9 @@ static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
 	for (i = 0; i < CT_LIMIT_HASH_BUCKETS; ++i) {
 		struct hlist_head *head = &info->limits[i];
 		struct ovs_ct_limit *ct_limit;
+		struct hlist_node *next;
 
-		hlist_for_each_entry_rcu(ct_limit, head, hlist_node,
-					 lockdep_ovsl_is_held())
+		hlist_for_each_entry_safe(ct_limit, next, head, hlist_node)
 			kfree_rcu(ct_limit, rcu);
 	}
 	kfree(info->limits);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 85c6f05c0fa3..d2fc795394a5 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -260,7 +260,7 @@ void unix_gc(void)
 			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
 
 			if (sk->sk_state == TCP_LISTEN) {
-				unix_state_lock(sk);
+				unix_state_lock_nested(sk, U_LOCK_GC_LISTENER);
 				unix_state_unlock(sk);
 			}
 		}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 91764bfb1f89..f2efa86a747a 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -27,18 +27,6 @@ use proc_macro::TokenStream;
 ///     author: b"Rust for Linux Contributors",
 ///     description: b"My very own kernel module!",
 ///     license: b"GPL",
-///     params: {
-///        my_i32: i32 {
-///            default: 42,
-///            permissions: 0o000,
-///            description: b"Example of i32",
-///        },
-///        writeable_i32: i32 {
-///            default: 42,
-///            permissions: 0o644,
-///            description: b"Example of i32",
-///        },
-///    },
 /// }
 ///
 /// struct MyModule;

