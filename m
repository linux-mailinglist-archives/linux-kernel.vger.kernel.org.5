Return-Path: <linux-kernel+bounces-166568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E68B9C87
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E1D1F227C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E361534F5;
	Thu,  2 May 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ryV9wXun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F61B153813;
	Thu,  2 May 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660691; cv=none; b=iufgGXbA72rtd3y7IZ14IeJytTeIe7uxXNNBI9LtkE+0YYfDghdDnE0gSc8z2Sf7UjWtkCfPJ35I/aBgGIdMsTNJ5sl97Ml55O09NK0iC11mlOQgCZazqx/tDU5SBv7HZ7Hbzo1wCoCHkxSrGqdCU21h4ZhmhQbze9OiLBsS/nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660691; c=relaxed/simple;
	bh=jXp46eP2lBhxBlDCyUNQj9H/Pb7J34tlw13936VNpLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3jkGiI2bJkLyvh1q4+5qEGYDXtDnAb3MYrquSOVCiCAW2ag4qYfPCeOVmmVo98FXSoJP1UgLUxCu8PVF5pRPTeX54Z5xQPNPv8YzgvmEUnwjJCKX1Omk0irgMtu3nfl9wEvZ7izTUnf5hPT7iyeJ/MeBJg9uUeQBNC4xjCcpLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ryV9wXun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7F9C4AF14;
	Thu,  2 May 2024 14:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714660691;
	bh=jXp46eP2lBhxBlDCyUNQj9H/Pb7J34tlw13936VNpLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryV9wXunBo7R34dHRmPT4qWuAu/AUPPMQ0xo+ZdsCdVHQ3Z+aUtOYPMwGGppYBvji
	 z5av84Y5dU/ZxnyE4Cfu96fOUDZsz8v42zjQblam7Z70zi2GpLxTyIU6yLNwJvKIAl
	 ugx2s+jalxxCsxNFaMORUR3xQ6MUhzutPYK/HY6k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.158
Date: Thu,  2 May 2024 16:37:59 +0200
Message-ID: <2024050259-liberty-trespass-d207@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024050259-slapping-joyride-535e@gregkh>
References: <2024050259-slapping-joyride-535e@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 013b68ef0c3f..04e9de5b174d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 157
+SUBLEVEL = 158
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/Kconfig b/arch/Kconfig
index a541ce263865..69e374320633 100644
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
index dcaa44e408ac..27f4194b376b 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -205,7 +205,6 @@ dmac_cfg_clk: dmac-gpu-cfg-clk {
 		};
 
 		gmac: ethernet@8000 {
-			#interrupt-cells = <1>;
 			compatible = "snps,dwmac";
 			reg = <0x8000 0x2000>;
 			interrupts = <10>;
diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 9d20cabf4f69..99515c13da3c 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -127,7 +127,7 @@ ethernet_phy0: ethernet-phy@5 {
 };
 
 &pio {
-	eth_default: eth_default {
+	eth_default: eth-default-pins {
 		tx_pins {
 			pinmux = <MT2712_PIN_71_GBE_TXD3__FUNC_GBE_TXD3>,
 				 <MT2712_PIN_72_GBE_TXD2__FUNC_GBE_TXD2>,
@@ -154,7 +154,7 @@ mdio_pins {
 		};
 	};
 
-	eth_sleep: eth_sleep {
+	eth_sleep: eth-sleep-pins {
 		tx_pins {
 			pinmux = <MT2712_PIN_71_GBE_TXD3__FUNC_GPIO71>,
 				 <MT2712_PIN_72_GBE_TXD2__FUNC_GPIO72>,
@@ -180,14 +180,14 @@ mdio_pins {
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
index 993a03d7fff1..57e9c39fabea 100644
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
index a4c48b2abd20..5f21f1e95d09 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -244,7 +244,7 @@ scpsys: power-controller@10006000 {
 		clock-names = "hif_sel";
 	};
 
-	cir: cir@10009000 {
+	cir: ir-receiver@10009000 {
 		compatible = "mediatek,mt7622-cir";
 		reg = <0 0x10009000 0 0x1000>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>;
@@ -275,16 +275,14 @@ thermal_calibration: calib@198 {
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
@@ -357,7 +355,7 @@ cci_control1: slave-if@4000 {
 		};
 
 		cci_control2: slave-if@5000 {
-			compatible = "arm,cci-400-ctrl-if";
+			compatible = "arm,cci-400-ctrl-if", "syscon";
 			interface-type = "ace";
 			reg = <0x5000 0x1000>;
 		};
@@ -507,7 +505,6 @@ thermal: thermal@1100b000 {
 			 <&pericfg CLK_PERI_AUXADC_PD>;
 		clock-names = "therm", "auxadc";
 		resets = <&pericfg MT7622_PERI_THERM_SW_RST>;
-		reset-names = "therm";
 		mediatek,auxadc = <&auxadc>;
 		mediatek,apmixedsys = <&apmixedsys>;
 		nvmem-cells = <&thermal_calibration>;
@@ -715,9 +712,8 @@ wmac: wmac@18000000 {
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
@@ -774,9 +770,8 @@ u2port1: usb-phy@1a0c5000 {
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
@@ -894,7 +889,13 @@ sata_port: sata-phy@1a243000 {
 		};
 	};
 
-	ethsys: syscon@1b000000 {
+	hifsys: clock-controller@1af00000 {
+		compatible = "mediatek,mt7622-hifsys";
+		reg = <0 0x1af00000 0 0x70>;
+		#clock-cells = <1>;
+	};
+
+	ethsys: clock-controller@1b000000 {
 		compatible = "mediatek,mt7622-ethsys",
 			     "syscon";
 		reg = <0 0x1b000000 0 0x1000>;
@@ -912,10 +913,28 @@ hsdma: dma-controller@1b007000 {
 		#dma-cells = <1>;
 	};
 
-	eth: ethernet@1b100000 {
-		compatible = "mediatek,mt7622-eth",
-			     "mediatek,mt2701-eth",
+	pcie_mirror: pcie-mirror@10000400 {
+		compatible = "mediatek,mt7622-pcie-mirror",
 			     "syscon";
+		reg = <0 0x10000400 0 0x10>;
+	};
+
+	wed0: wed@1020a000 {
+		compatible = "mediatek,mt7622-wed",
+			     "syscon";
+		reg = <0 0x1020a000 0 0x1000>;
+		interrupts = <GIC_SPI 214 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	wed1: wed@1020b000 {
+		compatible = "mediatek,mt7622-wed",
+			     "syscon";
+		reg = <0 0x1020b000 0 0x1000>;
+		interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	eth: ethernet@1b100000 {
+		compatible = "mediatek,mt7622-eth";
 		reg = <0 0x1b100000 0 0x20000>;
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 224 IRQ_TYPE_LEVEL_LOW>,
@@ -938,6 +957,11 @@ eth: ethernet@1b100000 {
 		power-domains = <&scpsys MT7622_POWER_DOMAIN_ETHSYS>;
 		mediatek,ethsys = <&ethsys>;
 		mediatek,sgmiisys = <&sgmiisys>;
+		mediatek,cci-control = <&cci_control2>;
+		mediatek,wed = <&wed0>, <&wed1>;
+		mediatek,pcie-mirror = <&pcie_mirror>;
+		mediatek,hifsys = <&hifsys>;
+		dma-coherent;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 2d33f4a583b4..712ac1826d68 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1088,6 +1088,7 @@ mfgcfg: syscon@13000000 {
 			compatible = "mediatek,mt8183-mfgcfg", "syscon";
 			reg = <0 0x13000000 0 0x1000>;
 			#clock-cells = <1>;
+			power-domains = <&spm MT8183_POWER_DOMAIN_MFG_ASYNC>;
 		};
 
 		gpu: gpu@13040000 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 9e5d07f5712e..e5d057ef8160 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -790,7 +790,6 @@ &pcie_phy {
 };
 
 &pcie0 {
-	bus-scan-delay-ms = <1000>;
 	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 7b27079fd611..b34081d39da1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -390,16 +390,22 @@ &io_domains {
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
@@ -432,11 +438,20 @@ vcc5v0_host_en: vcc5v0-host-en {
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
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9a3d9b68f2ff..776528fd6405 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -675,8 +675,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
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
index c29b024b907c..2f6312e7ce81 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -61,6 +61,7 @@ config X86
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
+	select ARCH_CONFIGURES_CPU_MITIGATIONS
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if X86_64 && HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if X86_64 || (X86_32 && HIGHMEM)
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
@@ -2394,17 +2395,17 @@ config CC_HAS_SLS
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
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index b8fe38cd121d..d69d9d81d2a3 100644
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
index 565f591c4b81..c390a79c5a66 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -258,7 +258,6 @@ static struct crypto_larval *__crypto_register_alg(struct crypto_alg *alg)
 		}
 
 		if (!strcmp(q->cra_driver_name, alg->cra_name) ||
-		    !strcmp(q->cra_driver_name, alg->cra_driver_name) ||
 		    !strcmp(q->cra_name, alg->cra_driver_name))
 			goto err;
 	}
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a862f859f7a5..8c3db223d634 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -439,6 +439,8 @@ static const struct usb_device_id blacklist_table[] = {
 	/* Realtek 8852BE Bluetooth devices */
 	{ USB_DEVICE(0x0cb8, 0xc559), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0bda, 0x4853), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x887b), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0xb85b), .driver_info = BTUSB_REALTEK |
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d5f408851a00..fb71caa31daa 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1590,6 +1590,9 @@ static bool qca_prevent_wake(struct hci_dev *hdev)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	bool wakeup;
 
+	if (!hu->serdev)
+		return true;
+
 	/* BT SoC attached through the serial bus is handled by the serdev driver.
 	 * So we need to use the device handle of the serdev driver to get the
 	 * status of device may wakeup.
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
index 1f0bbaed4643..9739c6c62123 100644
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
diff --git a/drivers/dma/xilinx/xilinx_dpdma.c b/drivers/dma/xilinx/xilinx_dpdma.c
index ce5c66e6897d..6eb68d986a72 100644
--- a/drivers/dma/xilinx/xilinx_dpdma.c
+++ b/drivers/dma/xilinx/xilinx_dpdma.c
@@ -213,7 +213,8 @@ struct xilinx_dpdma_tx_desc {
  * @running: true if the channel is running
  * @first_frame: flag for the first frame of stream
  * @video_group: flag if multi-channel operation is needed for video channels
- * @lock: lock to access struct xilinx_dpdma_chan
+ * @lock: lock to access struct xilinx_dpdma_chan. Must be taken before
+ *        @vchan.lock, if both are to be held.
  * @desc_pool: descriptor allocation pool
  * @err_task: error IRQ bottom half handler
  * @desc: References to descriptors being processed
@@ -1096,12 +1097,14 @@ static void xilinx_dpdma_chan_vsync_irq(struct  xilinx_dpdma_chan *chan)
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
@@ -1263,10 +1266,12 @@ static void xilinx_dpdma_issue_pending(struct dma_chan *dchan)
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
@@ -1490,7 +1495,9 @@ static void xilinx_dpdma_chan_err_task(struct tasklet_struct *t)
 		    XILINX_DPDMA_EINTR_CHAN_ERR_MASK << chan->id);
 
 	spin_lock_irqsave(&chan->lock, flags);
+	spin_lock(&chan->vchan.lock);
 	xilinx_dpdma_chan_queue_transfer(chan);
+	spin_unlock(&chan->vchan.lock);
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 00a8aef48a69..1fae36e33411 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1502,6 +1502,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 err_bo_create:
 	unreserve_mem_limit(adev, size, alloc_domain, !!sg);
 err_reserve_limit:
+	amdgpu_sync_free(&(*mem)->sync);
 	mutex_destroy(&(*mem)->lock);
 	if (gobj)
 		drm_gem_object_put(gobj);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 3ffbd3018074..3ed9e8ed3518 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -404,17 +404,21 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
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
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 01d5a01af259..e2a52b5de173 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -537,6 +537,7 @@ int vmw_du_cursor_plane_atomic_check(struct drm_plane *plane,
 int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 			     struct drm_atomic_state *state)
 {
+	struct vmw_private *vmw = vmw_priv(crtc->dev);
 	struct drm_crtc_state *new_state = drm_atomic_get_new_crtc_state(state,
 									 crtc);
 	struct vmw_display_unit *du = vmw_crtc_to_du(new_state->crtc);
@@ -544,9 +545,13 @@ int vmw_du_crtc_atomic_check(struct drm_crtc *crtc,
 	bool has_primary = new_state->plane_mask &
 			   drm_plane_mask(crtc->primary);
 
-	/* We always want to have an active plane with an active CRTC */
-	if (has_primary != new_state->enable)
-		return -EINVAL;
+	/*
+	 * This is fine in general, but broken userspace might expect
+	 * some actual rendering so give a clue as why it's blank.
+	 */
+	if (new_state->enable && !has_primary)
+		drm_dbg_driver(&vmw->drm,
+			       "CRTC without a primary plane will be blank.\n");
 
 
 	if (new_state->connector_mask != connector_mask &&
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
index 7c61bb9291e4..f8c56810d260 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -51,7 +51,6 @@
 /* flags */
 #define I2C_HID_STARTED		0
 #define I2C_HID_RESET_PENDING	1
-#define I2C_HID_READ_PENDING	2
 
 #define I2C_HID_PWR_ON		0x00
 #define I2C_HID_PWR_SLEEP	0x01
@@ -251,7 +250,6 @@ static int __i2c_hid_command(struct i2c_client *client,
 		msg[1].len = data_len;
 		msg[1].buf = buf_recv;
 		msg_num = 2;
-		set_bit(I2C_HID_READ_PENDING, &ihid->flags);
 	}
 
 	if (wait)
@@ -259,9 +257,6 @@ static int __i2c_hid_command(struct i2c_client *client,
 
 	ret = i2c_transfer(client->adapter, msg, msg_num);
 
-	if (data_len > 0)
-		clear_bit(I2C_HID_READ_PENDING, &ihid->flags);
-
 	if (ret != msg_num)
 		return ret < 0 ? ret : -EIO;
 
@@ -533,9 +528,6 @@ static irqreturn_t i2c_hid_irq(int irq, void *dev_id)
 {
 	struct i2c_hid *ihid = dev_id;
 
-	if (test_bit(I2C_HID_READ_PENDING, &ihid->flags))
-		return IRQ_HANDLED;
-
 	i2c_hid_get_input(ihid);
 
 	return IRQ_HANDLED;
diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 6c942dd1abca..ba45605fc6b5 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -944,6 +944,7 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
 	if (!dev)
 		return NULL;
 
+	dev->devc = &pdev->dev;
 	ishtp_device_init(dev);
 
 	init_waitqueue_head(&dev->wait_hw_ready);
@@ -979,7 +980,6 @@ struct ishtp_device *ish_dev_init(struct pci_dev *pdev)
 	}
 
 	dev->ops = &ish_hw_ops;
-	dev->devc = &pdev->dev;
 	dev->mtu = IPC_PAYLOAD_SIZE - sizeof(struct ishtp_msg_hdr);
 	return dev;
 }
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 8fb065caf30b..1810a994c07c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2072,13 +2072,18 @@ static int i2c_check_for_quirks(struct i2c_adapter *adap, struct i2c_msg *msgs,
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
 
@@ -2145,11 +2150,6 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
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
index 78eeb382c27e..fa89e590c133 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4530,13 +4530,8 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
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
index 6537a845266d..943fc7b7f4fb 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2827,6 +2827,11 @@ static __maybe_unused int sdhci_msm_runtime_suspend(struct device *dev)
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
@@ -2841,6 +2846,7 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	unsigned long flags;
 	int ret;
 
 	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
@@ -2859,7 +2865,15 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
 
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
index 485d32dda56f..ce370ef641f0 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -2029,12 +2029,14 @@ static int b44_set_pauseparam(struct net_device *dev,
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
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 676ea7d4192f..991321b04084 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16147,8 +16147,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	val = (rd32(&pf->hw, I40E_PRTGL_SAH) &
 	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
 	if (val < MAX_FRAME_SIZE_DEFAULT)
-		dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n",
-			 pf->hw.port, val);
+		dev_warn(&pdev->dev, "MFS for port %x (%d) has been set below the default (%d)\n",
+			 pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
@@ -16690,7 +16690,7 @@ static int __init i40e_init_module(void)
 	 * since we need to be able to guarantee forward progress even under
 	 * memory pressure.
 	 */
-	i40e_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0, i40e_driver_name);
+	i40e_wq = alloc_workqueue("%s", 0, 0, i40e_driver_name);
 	if (!i40e_wq) {
 		pr_err("%s: Failed to create workqueue\n", i40e_driver_name);
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 41b8ff0d4df5..6073dcc414d6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2901,6 +2901,34 @@ static void iavf_del_all_cloud_filters(struct iavf_adapter *adapter)
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
@@ -2958,7 +2986,7 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
 		if (ret)
 			return ret;
 		/* Return if same TC config is requested */
-		if (adapter->num_tc == num_tc)
+		if (iavf_is_tc_config_same(adapter, &mqprio_qopt->qopt))
 			return 0;
 		adapter->num_tc = num_tc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 41c15a65fb45..8d5dd8aba8cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -114,15 +114,18 @@ static u8 alloc_token(struct mlx5_cmd *cmd)
 	return token;
 }
 
-static int cmd_alloc_index(struct mlx5_cmd *cmd)
+static int cmd_alloc_index(struct mlx5_cmd *cmd, struct mlx5_cmd_work_ent *ent)
 {
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&cmd->alloc_lock, flags);
 	ret = find_first_bit(&cmd->bitmask, cmd->max_reg_cmds);
-	if (ret < cmd->max_reg_cmds)
+	if (ret < cmd->max_reg_cmds) {
 		clear_bit(ret, &cmd->bitmask);
+		ent->idx = ret;
+		cmd->ent_arr[ent->idx] = ent;
+	}
 	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 
 	return ret < cmd->max_reg_cmds ? ret : -ENOMEM;
@@ -924,7 +927,7 @@ static void cmd_work_handler(struct work_struct *work)
 	sem = ent->page_queue ? &cmd->pages_sem : &cmd->sem;
 	down(sem);
 	if (!ent->page_queue) {
-		alloc_ret = cmd_alloc_index(cmd);
+		alloc_ret = cmd_alloc_index(cmd, ent);
 		if (alloc_ret < 0) {
 			mlx5_core_err_rl(dev, "failed to allocate command entry\n");
 			if (ent->callback) {
@@ -939,15 +942,14 @@ static void cmd_work_handler(struct work_struct *work)
 			up(sem);
 			return;
 		}
-		ent->idx = alloc_ret;
 	} else {
 		ent->idx = cmd->max_reg_cmds;
 		spin_lock_irqsave(&cmd->alloc_lock, flags);
 		clear_bit(ent->idx, &cmd->bitmask);
+		cmd->ent_arr[ent->idx] = ent;
 		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 	}
 
-	cmd->ent_arr[ent->idx] = ent;
 	lay = get_inst(cmd, ent->idx);
 	ent->lay = lay;
 	memset(lay, 0, sizeof(*lay));
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index f080fab3de2b..d1102d5613df 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -746,7 +746,7 @@ static void mlxsw_emad_rx_listener_func(struct sk_buff *skb, u8 local_port,
 
 static const struct mlxsw_listener mlxsw_emad_rx_listener =
 	MLXSW_RXL(mlxsw_emad_rx_listener_func, ETHEMAD, TRAP_TO_CPU, false,
-		  EMAD, DISCARD);
+		  EMAD, FORWARD);
 
 static int mlxsw_emad_init(struct mlxsw_core *mlxsw_core)
 {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 483c8b75bebb..46b1120a8151 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -713,7 +713,9 @@ static void mlxsw_sp_acl_tcam_vregion_rehash_work(struct work_struct *work)
 			     rehash.dw.work);
 	int credits = MLXSW_SP_ACL_TCAM_VREGION_REHASH_CREDITS;
 
+	mutex_lock(&vregion->lock);
 	mlxsw_sp_acl_tcam_vregion_rehash(vregion->mlxsw_sp, vregion, &credits);
+	mutex_unlock(&vregion->lock);
 	if (credits < 0)
 		/* Rehash gone out of credits so it was interrupted.
 		 * Schedule the work as soon as possible to continue.
@@ -723,6 +725,17 @@ static void mlxsw_sp_acl_tcam_vregion_rehash_work(struct work_struct *work)
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
@@ -745,7 +758,7 @@ mlxsw_sp_acl_tcam_rehash_ctx_vregion_changed(struct mlxsw_sp_acl_tcam_vregion *v
 	 * the current chunk pointer to make sure all chunks
 	 * are properly migrated.
 	 */
-	vregion->rehash.ctx.current_vchunk = NULL;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(&vregion->rehash.ctx);
 }
 
 static struct mlxsw_sp_acl_tcam_vregion *
@@ -818,10 +831,14 @@ mlxsw_sp_acl_tcam_vregion_destroy(struct mlxsw_sp *mlxsw_sp,
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
@@ -1187,8 +1204,14 @@ mlxsw_sp_acl_tcam_ventry_activity_get(struct mlxsw_sp *mlxsw_sp,
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
@@ -1222,6 +1245,8 @@ mlxsw_sp_acl_tcam_vchunk_migrate_start(struct mlxsw_sp *mlxsw_sp,
 {
 	struct mlxsw_sp_acl_tcam_chunk *new_chunk;
 
+	WARN_ON(vchunk->chunk2);
+
 	new_chunk = mlxsw_sp_acl_tcam_chunk_create(mlxsw_sp, vchunk, region);
 	if (IS_ERR(new_chunk))
 		return PTR_ERR(new_chunk);
@@ -1240,7 +1265,7 @@ mlxsw_sp_acl_tcam_vchunk_migrate_end(struct mlxsw_sp *mlxsw_sp,
 {
 	mlxsw_sp_acl_tcam_chunk_destroy(mlxsw_sp, vchunk->chunk2);
 	vchunk->chunk2 = NULL;
-	ctx->current_vchunk = NULL;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 }
 
 static int
@@ -1263,6 +1288,9 @@ mlxsw_sp_acl_tcam_vchunk_migrate_one(struct mlxsw_sp *mlxsw_sp,
 		return 0;
 	}
 
+	if (list_empty(&vchunk->ventry_list))
+		goto out;
+
 	/* If the migration got interrupted, we have the ventry to start from
 	 * stored in context.
 	 */
@@ -1272,6 +1300,8 @@ mlxsw_sp_acl_tcam_vchunk_migrate_one(struct mlxsw_sp *mlxsw_sp,
 		ventry = list_first_entry(&vchunk->ventry_list,
 					  typeof(*ventry), list);
 
+	WARN_ON(ventry->vchunk != vchunk);
+
 	list_for_each_entry_from(ventry, &vchunk->ventry_list, list) {
 		/* During rollback, once we reach the ventry that failed
 		 * to migrate, we are done.
@@ -1312,6 +1342,7 @@ mlxsw_sp_acl_tcam_vchunk_migrate_one(struct mlxsw_sp *mlxsw_sp,
 		}
 	}
 
+out:
 	mlxsw_sp_acl_tcam_vchunk_migrate_end(mlxsw_sp, vchunk, ctx);
 	return 0;
 }
@@ -1325,6 +1356,9 @@ mlxsw_sp_acl_tcam_vchunk_migrate_all(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_acl_tcam_vchunk *vchunk;
 	int err;
 
+	if (list_empty(&vregion->vchunk_list))
+		return 0;
+
 	/* If the migration got interrupted, we have the vchunk
 	 * we are working on stored in context.
 	 */
@@ -1353,16 +1387,17 @@ mlxsw_sp_acl_tcam_vregion_migrate(struct mlxsw_sp *mlxsw_sp,
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
@@ -1373,7 +1408,6 @@ mlxsw_sp_acl_tcam_vregion_migrate(struct mlxsw_sp *mlxsw_sp,
 			/* Let the rollback to be continued later on. */
 		}
 	}
-	mutex_unlock(&vregion->lock);
 	trace_mlxsw_sp_acl_tcam_vregion_migrate_end(mlxsw_sp, vregion);
 	return err;
 }
@@ -1422,6 +1456,7 @@ mlxsw_sp_acl_tcam_vregion_rehash_start(struct mlxsw_sp *mlxsw_sp,
 
 	ctx->hints_priv = hints_priv;
 	ctx->this_is_rollback = false;
+	mlxsw_sp_acl_tcam_rehash_ctx_vchunk_reset(ctx);
 
 	return 0;
 
@@ -1474,7 +1509,8 @@ mlxsw_sp_acl_tcam_vregion_rehash(struct mlxsw_sp *mlxsw_sp,
 	err = mlxsw_sp_acl_tcam_vregion_migrate(mlxsw_sp, vregion,
 						ctx, credits);
 	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Failed to migrate vregion\n");
+		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Failed to migrate vregion\n");
+		return;
 	}
 
 	if (*credits >= 0)
diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index c30a6e510aa3..1552dfee4e62 100644
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
index ce93316f5f11..3271428e64b8 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -713,11 +713,12 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
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
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index f11748cc5b22..868fad2f8c78 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1478,21 +1478,16 @@ static int ax88179_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
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
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 41b1b23fdd3e..2e61041a1113 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1779,6 +1779,10 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
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
index bb5fff817443..2dcf5a827b36 100644
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
index e4fd58f043ce..c0ffa26bc5aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2571,7 +2571,8 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 		if (ver_handler->version != scan_ver)
 			continue;
 
-		return ver_handler->handler(mvm, vif, params, type, uid);
+		err = ver_handler->handler(mvm, vif, params, type, uid);
+		return err ? : uid;
 	}
 
 	err = iwl_mvm_scan_umac(mvm, vif, params, type, uid);
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 8890fcd59c39..cfc2a7e65271 100644
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
@@ -2157,7 +2160,8 @@ static int trf7970a_remove(struct spi_device *spi)
 	nfc_digital_unregister_device(trf->ddev);
 	nfc_digital_free_device(trf->ddev);
 
-	regulator_disable(trf->regulator);
+	regulator_disable(trf->vddio_regulator);
+	regulator_disable(trf->vin_regulator);
 
 	mutex_destroy(&trf->lock);
 
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ac45f3386e97..dfedd3f1130e 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1094,11 +1094,13 @@ static void mxs_auart_set_ldisc(struct uart_port *port,
 
 static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 {
-	u32 istat;
+	u32 istat, stat;
 	struct mxs_auart_port *s = context;
 	u32 mctrl_temp = s->mctrl_prev;
-	u32 stat = mxs_read(s, REG_STAT);
 
+	uart_port_lock(&s->port);
+
+	stat = mxs_read(s, REG_STAT);
 	istat = mxs_read(s, REG_INTR);
 
 	/* ack irq */
@@ -1134,6 +1136,8 @@ static irqreturn_t mxs_auart_irq_handle(int irq, void *context)
 		istat &= ~AUART_INTR_TXIS;
 	}
 
+	uart_port_unlock(&s->port);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 1f12c2043603..c2a0a936d5fb 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -149,7 +149,7 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	unsigned long offset;
 	vm_fault_t ret;
 
-	offset = (vmf->address - vmf->vma->vm_start);
+	offset = vmf->pgoff << PAGE_SHIFT;
 
 	/* this is a callback we get when userspace first tries to
 	write to the page. we schedule a workqueue. that workqueue
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index cd9202867d98..77676716c7cc 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2315,20 +2315,14 @@ struct btrfs_data_container *init_data_container(u32 total_bytes)
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
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 9bbead15a028..d3adcb9e70a6 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -374,6 +374,7 @@ cifs_alloc_inode(struct super_block *sb)
 	 * server, can not assume caching of file data or metadata.
 	 */
 	cifs_set_oplock_level(cifs_inode, 0);
+	cifs_inode->lease_granted = false;
 	cifs_inode->flags = 0;
 	spin_lock_init(&cifs_inode->writers_lock);
 	cifs_inode->writers = 0;
diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 6347e759b5cc..fb3651513f83 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -672,6 +672,16 @@ static int smb3_fs_context_validate(struct fs_context *fc)
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
@@ -903,12 +913,14 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
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
diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
index 3cf8d6235162..74bb19ec7c83 100644
--- a/fs/cifs/fs_context.h
+++ b/fs/cifs/fs_context.h
@@ -152,6 +152,8 @@ enum cifs_param {
 };
 
 struct smb3_fs_context {
+	bool forceuid_specified;
+	bool forcegid_specified;
 	bool uid_specified;
 	bool cruid_specified;
 	bool gid_specified;
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 15a089a87c22..f7ece14b1022 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -444,7 +444,7 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 #define drm_dbg_core(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_CORE, fmt, ##__VA_ARGS__)
-#define drm_dbg(drm, fmt, ...)						\
+#define drm_dbg_driver(drm, fmt, ...)						\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
 #define drm_dbg_kms(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_KMS, fmt, ##__VA_ARGS__)
@@ -463,6 +463,7 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 #define drm_dbg_drmres(drm, fmt, ...)					\
 	drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRMRES, fmt, ##__VA_ARGS__)
 
+#define drm_dbg(drm, fmt, ...)	drm_dbg_driver(drm, fmt, ##__VA_ARGS__)
 
 /*
  * printk based logging
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index ca0e26a858be..c31dce9c71d3 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -542,6 +542,31 @@ static inline unsigned long compare_ether_header(const void *a, const void *b)
 #endif
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
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d5b6b1550d59..4d3ce67e8552 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -260,6 +260,85 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+/**
+ * uart_port_lock - Lock the UART port
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_lock(struct uart_port *up)
+{
+	spin_lock(&up->lock);
+}
+
+/**
+ * uart_port_lock_irq - Lock the UART port and disable interrupts
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_lock_irq(struct uart_port *up)
+{
+	spin_lock_irq(&up->lock);
+}
+
+/**
+ * uart_port_lock_irqsave - Lock the UART port, save and disable interrupts
+ * @up:		Pointer to UART port structure
+ * @flags:	Pointer to interrupt flags storage
+ */
+static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	spin_lock_irqsave(&up->lock, *flags);
+}
+
+/**
+ * uart_port_trylock - Try to lock the UART port
+ * @up:		Pointer to UART port structure
+ *
+ * Returns: True if lock was acquired, false otherwise
+ */
+static inline bool uart_port_trylock(struct uart_port *up)
+{
+	return spin_trylock(&up->lock);
+}
+
+/**
+ * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
+ * @up:		Pointer to UART port structure
+ * @flags:	Pointer to interrupt flags storage
+ *
+ * Returns: True if lock was acquired, false otherwise
+ */
+static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	return spin_trylock_irqsave(&up->lock, *flags);
+}
+
+/**
+ * uart_port_unlock - Unlock the UART port
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_unlock(struct uart_port *up)
+{
+	spin_unlock(&up->lock);
+}
+
+/**
+ * uart_port_unlock_irq - Unlock the UART port and re-enable interrupts
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_unlock_irq(struct uart_port *up)
+{
+	spin_unlock_irq(&up->lock);
+}
+
+/**
+ * uart_port_unlock_irqrestore - Unlock the UART port, restore interrupts
+ * @up:		Pointer to UART port structure
+ * @flags:	The saved interrupt flags for restore
+ */
+static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
+{
+	spin_unlock_irqrestore(&up->lock, flags);
+}
+
 static inline int serial_port_in(struct uart_port *up, int offset)
 {
 	return up->serial_in(up, offset);
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index d3cbe4bf4fab..17575aa2a53c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -676,7 +676,7 @@ struct trace_event_file {
 	}								\
 	early_initcall(trace_init_perf_perm_##name);
 
-#define PERF_MAX_TRACE_SIZE	2048
+#define PERF_MAX_TRACE_SIZE	8192
 
 #define MAX_FILTER_STR_VAL	256U	/* Should handle KSYM_SYMBOL_LEN */
 
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 094afdf7dea1..b2c79f18f683 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -80,6 +80,9 @@ enum unix_socket_lock_class {
 	U_LOCK_NORMAL,
 	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
 	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
+	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
+			     * candidates to close a small race window.
+			     */
 };
 
 static inline void unix_state_lock_nested(struct sock *sk,
diff --git a/kernel/bounds.c b/kernel/bounds.c
index a94e3769347e..a3e1d3dfad31 100644
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
 	/* End of constants */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 297579dda40a..1c370f87d86f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2722,8 +2722,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
-						     CPU_MITIGATIONS_OFF;
+	IS_ENABLED(CONFIG_CPU_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+					     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 083f648e3265..61e3a2620fa3 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -401,7 +401,8 @@ void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp)
 	BUILD_BUG_ON(PERF_MAX_TRACE_SIZE % sizeof(unsigned long));
 
 	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE,
-		      "perf buffer not large enough"))
+		      "perf buffer not large enough, wanted %d, have %d",
+		      size, PERF_MAX_TRACE_SIZE))
 		return NULL;
 
 	*rctxp = rctx = perf_swevent_get_recursion_context();
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index e90f0f19e77f..d31f23570a86 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -294,10 +294,10 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
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
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 756523e5402a..3a2be1b4a574 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -456,7 +456,8 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct l2cap_options opts;
 	struct l2cap_conninfo cinfo;
-	int len, err = 0;
+	int err = 0;
+	size_t len;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -503,7 +504,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 
 		BT_DBG("mode 0x%2.2x", chan->mode);
 
-		len = min_t(unsigned int, len, sizeof(opts));
+		len = min(len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
 			err = -EFAULT;
 
@@ -553,7 +554,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname,
 		cinfo.hci_handle = chan->conn->hcon->handle;
 		memcpy(cinfo.dev_class, chan->conn->hcon->dev_class, 3);
 
-		len = min_t(unsigned int, len, sizeof(cinfo));
+		len = min(len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *) &cinfo, len))
 			err = -EFAULT;
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 9a8814d4565a..57c6a4f845a3 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -904,7 +904,8 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 	struct sock *sk = sock->sk;
 	struct sco_options opts;
 	struct sco_conninfo cinfo;
-	int len, err = 0;
+	int err = 0;
+	size_t len;
 
 	BT_DBG("sk %p", sk);
 
@@ -926,7 +927,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 
 		BT_DBG("mtu %u", opts.mtu);
 
-		len = min_t(unsigned int, len, sizeof(opts));
+		len = min(len, sizeof(opts));
 		if (copy_to_user(optval, (char *)&opts, len))
 			err = -EFAULT;
 
@@ -944,7 +945,7 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname,
 		cinfo.hci_handle = sco_pi(sk)->conn->hcon->handle;
 		memcpy(cinfo.dev_class, sco_pi(sk)->conn->hcon->dev_class, 3);
 
-		len = min_t(unsigned int, len, sizeof(cinfo));
+		len = min(len, sizeof(cinfo));
 		if (copy_to_user(optval, (char *)&cinfo, len))
 			err = -EFAULT;
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index e365cf82f061..a1a703b7d523 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -619,7 +619,7 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
 {
 	u32 filter = RTEXT_FILTER_BRVLAN_COMPRESSED;
 
-	return br_info_notify(event, br, port, filter);
+	br_info_notify(event, br, port, filter);
 }
 
 /*
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 73fce9467467..9ad4a15232af 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -163,17 +163,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
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
index 7b749a98327c..38b30f679029 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -92,6 +92,7 @@
 #include <net/inet_common.h>
 #include <net/ip_fib.h>
 #include <net/l3mdev.h>
+#include <net/addrconf.h>
 
 /*
  *	Build xmit assembly blocks
@@ -1035,6 +1036,8 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
 	struct icmp_ext_hdr *ext_hdr, _ext_hdr;
 	struct icmp_ext_echo_iio *iio, _iio;
 	struct net *net = dev_net(skb->dev);
+	struct inet6_dev *in6_dev;
+	struct in_device *in_dev;
 	struct net_device *dev;
 	char buff[IFNAMSIZ];
 	u16 ident_len;
@@ -1118,10 +1121,15 @@ bool icmp_build_probe(struct sk_buff *skb, struct icmphdr *icmphdr)
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
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 437afe392e66..25809e06f111 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -254,12 +254,12 @@ void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo, bool rearm)
 }
 EXPORT_SYMBOL_GPL(__inet_twsk_schedule);
 
+/* Remove all non full sockets (TIME_WAIT and NEW_SYN_RECV) for dead netns */
 void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 {
-	struct inet_timewait_sock *tw;
-	struct sock *sk;
 	struct hlist_nulls_node *node;
 	unsigned int slot;
+	struct sock *sk;
 
 	for (slot = 0; slot <= hashinfo->ehash_mask; slot++) {
 		struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
@@ -268,25 +268,35 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 		rcu_read_lock();
 restart:
 		sk_nulls_for_each_rcu(sk, node, &head->chain) {
-			if (sk->sk_state != TCP_TIME_WAIT)
+			int state = inet_sk_state_load(sk);
+
+			if ((1 << state) & ~(TCPF_TIME_WAIT |
+					     TCPF_NEW_SYN_RECV))
 				continue;
-			tw = inet_twsk(sk);
-			if ((tw->tw_family != family) ||
-				refcount_read(&twsk_net(tw)->ns.count))
+
+			if (sk->sk_family != family ||
+			    refcount_read(&sock_net(sk)->ns.count))
 				continue;
 
-			if (unlikely(!refcount_inc_not_zero(&tw->tw_refcnt)))
+			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 				continue;
 
-			if (unlikely((tw->tw_family != family) ||
-				     refcount_read(&twsk_net(tw)->ns.count))) {
-				inet_twsk_put(tw);
+			if (unlikely(sk->sk_family != family ||
+				     refcount_read(&sock_net(sk)->ns.count))) {
+				sock_gen_put(sk);
 				goto restart;
 			}
 
 			rcu_read_unlock();
 			local_bh_disable();
-			inet_twsk_deschedule_put(tw);
+			if (state == TCP_TIME_WAIT) {
+				inet_twsk_deschedule_put(inet_twsk(sk));
+			} else {
+				struct request_sock *req = inet_reqsk(sk);
+
+				inet_csk_reqsk_queue_drop_and_put(req->rsk_listener,
+								  req);
+			}
 			local_bh_enable();
 			goto restart_rcu;
 		}
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 4ff94596f8cd..895754439393 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2173,6 +2173,9 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	int err = -EINVAL;
 	u32 tag = 0;
 
+	if (!in_dev)
+		return -EINVAL;
+
 	if (ipv4_is_multicast(saddr) || ipv4_is_lbcast(saddr))
 		goto martian_source;
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c02f6329c106..d0387e5eee5b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1139,16 +1139,17 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
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
index 5a2abd179e08..256de135191f 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1479,9 +1479,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		ipc6.opt = opt;
 
 		err = udp_cmsg_send(sk, msg, &ipc6.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip6_datagram_send_ctl(sock_net(sk), sk, msg, &fl6,
 						    &ipc6);
+			connected = false;
+		}
 		if (err < 0) {
 			fl6_sock_release(flowlabel);
 			return err;
@@ -1493,7 +1495,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
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
index 35aa4ea94205..8c76ca4d86a8 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -336,7 +336,9 @@ static void nft_netdev_event(unsigned long event, struct net_device *dev,
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
index 60dd6f32d520..85a338b68178 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1913,9 +1913,9 @@ static void ovs_ct_limit_exit(struct net *net, struct ovs_net *ovs_net)
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

