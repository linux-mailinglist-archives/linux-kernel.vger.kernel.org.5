Return-Path: <linux-kernel+bounces-15006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEA082260C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1689284856
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7634A1C;
	Wed,  3 Jan 2024 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikTCAs+K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B74A0D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 00:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBDEC433C8;
	Wed,  3 Jan 2024 00:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704242462;
	bh=fvoToDeojnZ555ZZEDS8PGxrX6dQW8pggzLO2bAkyyw=;
	h=From:To:Cc:Subject:Date:From;
	b=ikTCAs+KV7J1zTFtaXPm8HqV3D71ZfQaI3nGukLqUuZXSKsJTniO/ZqU9JgMJgPaZ
	 lFOD9hx1RMiIboKY0s0Aj8k3PSaScZtGmhkIN2bUgnjLFFpXOcGI4MXiZzgVs6qH8D
	 QqV7Do7CmRJ4iVll63ATbaTVL3B1tjUDEUw3LqewJxfAOp+47+ZQfP9o2mTd4cbK5m
	 ZeZZPFzzT14H+VEPkHYq5sCFM3a2qFiXYRSRJhrNf3qYKCSJvn3+Gw9bTal1NZxXYG
	 hurjAlP0Jl7ZEV7LmtfxjluixaE3gyN+eJEhyxuu39PObdTsnKKiNAZ9i4G5nCRonW
	 ohoth1wwEnEZg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] arch/arm64: Fix typos
Date: Tue,  2 Jan 2024 18:40:59 -0600
Message-Id: <20240103004059.1758712-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos, most reported by "codespell arch/arm64".  Only touches comments,
no code changes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/Kconfig                                         | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts | 2 +-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi                 | 2 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi                     | 2 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi                    | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi             | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts        | 2 +-
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi           | 2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi                      | 4 ++--
 arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sa8155p.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                 | 4 ++--
 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts           | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi      | 2 +-
 arch/arm64/boot/dts/renesas/draak.dtsi                     | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts        | 2 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                 | 2 +-
 arch/arm64/include/asm/assembler.h                         | 4 ++--
 arch/arm64/include/asm/cpufeature.h                        | 4 ++--
 arch/arm64/include/asm/kvm_hyp.h                           | 2 +-
 arch/arm64/include/asm/pgtable.h                           | 2 +-
 arch/arm64/include/asm/suspend.h                           | 2 +-
 arch/arm64/include/asm/traps.h                             | 4 ++--
 arch/arm64/kernel/acpi.c                                   | 2 +-
 arch/arm64/kernel/cpufeature.c                             | 6 +++---
 arch/arm64/kernel/entry-common.c                           | 2 +-
 arch/arm64/kernel/entry-ftrace.S                           | 2 +-
 arch/arm64/kernel/entry.S                                  | 2 +-
 arch/arm64/kernel/ftrace.c                                 | 2 +-
 arch/arm64/kernel/machine_kexec.c                          | 2 +-
 arch/arm64/kernel/probes/uprobes.c                         | 2 +-
 arch/arm64/kernel/sdei.c                                   | 2 +-
 arch/arm64/kernel/smp.c                                    | 2 +-
 arch/arm64/kernel/traps.c                                  | 2 +-
 arch/arm64/kvm/arch_timer.c                                | 2 +-
 arch/arm64/kvm/fpsimd.c                                    | 2 +-
 arch/arm64/kvm/hyp/nvhe/host.S                             | 2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c                               | 4 ++--
 arch/arm64/kvm/inject_fault.c                              | 2 +-
 arch/arm64/kvm/vgic/vgic-init.c                            | 2 +-
 arch/arm64/kvm/vgic/vgic-its.c                             | 4 ++--
 41 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..1954035737cf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2227,7 +2227,7 @@ config CMDLINE
 	default ""
 	help
 	  Provide a set of default command-line options at build time by
-	  entering them here. As a minimum, you should specify the the
+	  entering them here. As a minimum, you should specify the
 	  root device (e.g. root=/dev/nfs).
 
 choice
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
index 723af64a9cee..bac2a1ecfb9e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
@@ -16,7 +16,7 @@ &backlight {
 	 * PWM backlight circuit on this PinePhone revision was changed since
 	 * 1.0, and the lowest PWM duty cycle that doesn't lead to backlight
 	 * being off is around 20%. Duty cycle for the lowest brightness level
-	 * also varries quite a bit between individual boards, so the lowest
+	 * also varies quite a bit between individual boards, so the lowest
 	 * value here was chosen as a safe default.
 	 */
 	brightness-levels = <
diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index 65ebac3082e2..8891a6c17347 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -123,7 +123,7 @@ gic: interrupt-controller@78090000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		interrupt-controller;
-		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
+		interrupts = <1 9 0xf04>;	/* GIC Maintenance IRQ */
 		ranges = <0 0 0 0x79000000 0x0 0x800000>; /* MSI Range */
 		reg = <0x0 0x78090000 0x0 0x10000>,	/* GIC Dist */
 		      <0x0 0x780a0000 0x0 0x20000>,	/* GIC CPU */
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 988928c60f15..ee1303a68d50 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -109,7 +109,7 @@ gic: interrupt-controller@78010000 {
 		      <0x0 0x78020000 0x0 0x1000>,	/* GIC CPU */
 		      <0x0 0x78040000 0x0 0x2000>,	/* GIC VCPU Control */
 		      <0x0 0x78060000 0x0 0x2000>;	/* GIC VCPU */
-		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
+		interrupts = <1 9 0xf04>;	/* GIC Maintenance IRQ */
 	};
 
 	timer {
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 6ed80ddf3369..6e83d288de53 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -645,7 +645,7 @@ tmuctrl_0: tmu@10060000 {
 		ufs: ufs@15570000 {
 			compatible = "samsung,exynos7-ufs";
 			reg = <0x15570000 0x100>,  /* 0: HCI standard */
-				<0x15570100 0x100>,  /* 1: Vendor specificed */
+				<0x15570100 0x100>,  /* 1: Vendor specified */
 				<0x15571000 0x200>,  /* 2: UNIPRO */
 				<0x15572000 0x300>;  /* 3: UFS protector */
 			reg-names = "hci", "vs_hci", "unipro", "ufsp";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index eefe3577d94e..459e43785c83 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -150,7 +150,7 @@ gic: interrupt-controller@6000000 {
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
-			reg = <0x0 0x06020000 0 0x20000>;/* GIC Translater */
+			reg = <0x0 0x06020000 0 0x20000>;/* GIC Translator */
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index d4867d6cf47c..7436d041cca4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Device Tree file for Travese Ten64 (LS1088) board
+ * Device Tree file for Traverse Ten64 (LS1088) board
  * Based on fsl-ls1088a-rdb.dts
  * Copyright 2017-2020 NXP
  * Copyright 2019-2021 Traverse Technologies
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 49d105eb4769..2b41fbdf136e 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -504,7 +504,7 @@ pinctrl_hog2: hog2grp {
 
 	/*
 	 * This pin is used in the SCFW as a UART. Using it from
-	 * Linux would require rewritting the SCFW board file.
+	 * Linux would require rewriting the SCFW board file.
 	 */
 	pinctrl_hog_scfw: hogscfwgrp {
 		fsl,pins = <IMX8QXP_SCU_GPIO0_00_LSIO_GPIO2_IO03		0x20>;		/* SODIMM 144 */
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 4f799b536a92..34fa2843fdc7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -666,12 +666,12 @@ in-ports {
 
 				/*
 				 * Not described input ports:
-				 * 0 - connected to Resource and Power Manger CPU ETM
+				 * 0 - connected to Resource and Power Manager CPU ETM
 				 * 1 - not-connected
 				 * 2 - connected to Modem CPU ETM
 				 * 3 - not-connected
 				 * 5 - not-connected
-				 * 6 - connected trought funnel to Wireless CPU ETM
+				 * 6 - connected through funnel to Wireless CPU ETM
 				 * 7 - connected to STM component
 				 */
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index cbc84459a5ae..4e0e7dfe1b4a 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -857,7 +857,7 @@ &sdhc1 {
 	status = "okay";
 
 	/*
-	 * This device is shipped with HS400 capabable eMMCs
+	 * This device is shipped with HS400 capable eMMCs
 	 * However various brands have been used in various product batches,
 	 * including a Samsung eMMC (BGND3R) which features a quirk with HS400.
 	 * Set the speed to HS200 as a safety measure.
diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
index ffb7ab695213..1bc86a8529e1 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
@@ -4,7 +4,7 @@
  *
  * SA8155P is an automotive variant of SM8150, with some minor changes.
  * Most notably, the RPMhPD setup differs: MMCX and LCX/LMX rails are gone,
- * though the cmd-db doesn't reflect that and access attemps result in a bite.
+ * though the cmd-db doesn't reflect that and access attempts result in a bite.
  */
 
 #include "sm8150.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index f9b96bd2477e..9dae5931dead 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -563,8 +563,8 @@ &sdc1_rclk {
  *
  * This has entries that are defined by Qcard even if they go to the main
  * board. In cases where the pulls may be board dependent we defer those
- * settings to the board device tree. Drive strengths tend to be assinged here
- * but could conceivably be overwridden by board device trees.
+ * settings to the board device tree. Drive strengths tend to be assigned here
+ * but could conceivably be overridden by board device trees.
  */
 
 &pm8350c_gpios {
diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
index 32a7bd59e1ec..8f89352aeb73 100644
--- a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
@@ -168,7 +168,7 @@ vph_pwr: vph-pwr-regulator {
 	 * Supply map from xiaomi-lavender specifies this as the supply for
 	 * ldob1, ldob9, ldob10, ldoa2, and ldoa3, while downstream specifies
 	 * this as a power domain. Set this as a fixed regulator with the same
-	 * voltage as lavender until display is needed to avoid unneccessarily
+	 * voltage as lavender until display is needed to avoid unnecessarily
 	 * using a deprecated binding (regulator-fixed-domain).
 	 */
 	vreg_s2b_1p05: vreg-s2b-regulator {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index b02a1dc5fecd..a4be5c6ebb47 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -305,7 +305,7 @@ vreg_l19a_2p7: ldo19 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 
 			/*
-			 * The driver *really* doesn't want this regualtor to exist,
+			 * The driver *really* doesn't want this regulator to exist,
 			 * saying that it could not get the current voltage (-ENOTRECOVERABLE)
 			 * even though it surely is used on these devices (as a voltage
 			 * source for camera autofocus)
diff --git a/arch/arm64/boot/dts/renesas/draak.dtsi b/arch/arm64/boot/dts/renesas/draak.dtsi
index ef3bb835d5c0..67c36f71f4cb 100644
--- a/arch/arm64/boot/dts/renesas/draak.dtsi
+++ b/arch/arm64/boot/dts/renesas/draak.dtsi
@@ -226,7 +226,7 @@ &audio_clk_b {
 	/*
 	 * X11 is connected to VI4_FIELD/SCIF_CLK/AUDIO_CLKB,
 	 * and R-Car Sound uses AUDIO_CLKB.
-	 * Note is that schematic indicates VI4_FIELD conection only
+	 * Note is that schematic indicates VI4_FIELD connection only
 	 * not AUDIO_CLKB at SoC page.
 	 * And this VI4_FIELD/SCIF_CLK/AUDIO_CLKB is connected to SW60.
 	 * SW60 should be 1-2.
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
index 7ba1c28f70a9..ce55f82268b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
@@ -9,7 +9,7 @@
 /*
  * Notice:
  * 1. rk3399-roc-pc-plus is powered by dc_12v directly.
- * 2. rk3399-roc-pc-plus has only vcc_bus_typec0 in schematic, which is coresponding
+ * 2. rk3399-roc-pc-plus has only vcc_bus_typec0 in schematic, which is corresponding
  *    to vcc_vbus_typec1 in rk3399-roc-pc.
  *    For simplicity, reserve the node name of vcc_vbus_typec1.
  * 3. vcc5v0_host is actually 2 regulators (host0, 1) controlled by the same gpio.
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 5db52f237253..e99e69027125 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1415,7 +1415,7 @@ &usbss0 {
 	status = "disabled";
 };
 
-/* TODO: role swich using ID pin */
+/* TODO: role switch using ID pin */
 &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb0_id>;
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 376a980f2bad..0b2e67fa9a11 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -390,7 +390,7 @@ alternative_endif
  * [start, end) with dcache line size explicitly provided.
  *
  * 	op:		operation passed to dc instruction
- * 	domain:		domain used in dsb instruciton
+ * 	domain:		domain used in dsb instruction
  * 	start:          starting virtual address of the region
  * 	end:            end virtual address of the region
  *	linesz:		dcache line size
@@ -431,7 +431,7 @@ alternative_endif
  * [start, end)
  *
  * 	op:		operation passed to dc instruction
- * 	domain:		domain used in dsb instruciton
+ * 	domain:		domain used in dsb instruction
  * 	start:          starting virtual address of the region
  * 	end:            end virtual address of the region
  * 	fixup:		optional label to branch to on user fault
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f6d416fe49b0..a0f4010c1e85 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -198,7 +198,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  *    registers (e.g, SCTLR, TCR etc.) or patching the kernel via
  *    alternatives. The kernel patching is batched and performed at later
  *    point. The actions are always initiated only after the capability
- *    is finalised. This is usally denoted by "enabling" the capability.
+ *    is finalised. This is usually denoted by "enabling" the capability.
  *    The actions are initiated as follows :
  *	a) Action is triggered on all online CPUs, after the capability is
  *	finalised, invoked within the stop_machine() context from
@@ -250,7 +250,7 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 #define ARM64_CPUCAP_SCOPE_LOCAL_CPU		((u16)BIT(0))
 #define ARM64_CPUCAP_SCOPE_SYSTEM		((u16)BIT(1))
 /*
- * The capabilitiy is detected on the Boot CPU and is used by kernel
+ * The capability is detected on the Boot CPU and is used by kernel
  * during early boot. i.e, the capability should be "detected" and
  * "enabled" as early as possibly on all booting CPUs.
  */
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 145ce73fc16c..3e2a1ac0c9bb 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -70,7 +70,7 @@ DECLARE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 /*
  * Without an __arch_swab32(), we fall back to ___constant_swab32(), but the
  * static inline can allow the compiler to out-of-line this. KVM always wants
- * the macro version as its always inlined.
+ * the macro version as it's always inlined.
  */
 #define __kvm_swab32(x)	___constant_swab32(x)
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b19a8aee684c..25bf7d15a115 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -288,7 +288,7 @@ bool pgattr_change_is_safe(u64 old, u64 new);
  *   1      0      |   1           0          1
  *   1      1      |   0           1          x
  *
- * When hardware DBM is not present, the sofware PTE_DIRTY bit is updated via
+ * When hardware DBM is not present, the software PTE_DIRTY bit is updated via
  * the page fault mechanism. Checking the dirty status of a pte becomes:
  *
  *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 0cde2f473971..e65f33edf9d6 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -23,7 +23,7 @@ struct cpu_suspend_ctx {
  * __cpu_suspend_enter()'s caller, and populated by __cpu_suspend_enter().
  * This data must survive until cpu_resume() is called.
  *
- * This struct desribes the size and the layout of the saved cpu state.
+ * This struct describes the size and the layout of the saved cpu state.
  * The layout of the callee_saved_regs is defined by the implementation
  * of __cpu_suspend_enter(), and cpu_resume(). This struct must be passed
  * in by the caller as __cpu_suspend_enter()'s stack-frame is gone once it
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index eefe766d6161..03084ed290ac 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -52,8 +52,8 @@ static inline int in_entry_text(unsigned long ptr)
  * CPUs with the RAS extensions have an Implementation-Defined-Syndrome bit
  * to indicate whether this ESR has a RAS encoding. CPUs without this feature
  * have a ISS-Valid bit in the same position.
- * If this bit is set, we know its not a RAS SError.
- * If its clear, we need to know if the CPU supports RAS. Uncategorized RAS
+ * If this bit is set, we know it's not a RAS SError.
+ * If it's clear, we need to know if the CPU supports RAS. Uncategorized RAS
  * errors share the same encoding as an all-zeros encoding from a CPU that
  * doesn't support RAS.
  */
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index dba8fcec7f33..7eca4273b415 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -128,7 +128,7 @@ static int __init acpi_fadt_sanity_check(void)
 
 	/*
 	 * FADT is required on arm64; retrieve it to check its presence
-	 * and carry out revision and ACPI HW reduced compliancy tests
+	 * and carry out revision and ACPI HW reduced compliance tests
 	 */
 	status = acpi_get_table(ACPI_SIG_FADT, 0, &table);
 	if (ACPI_FAILURE(status)) {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 646591c67e7a..3089526900a8 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -748,7 +748,7 @@ static int search_cmp_ftr_reg(const void *id, const void *regp)
  * entry.
  *
  * returns - Upon success,  matching ftr_reg entry for id.
- *         - NULL on failure. It is upto the caller to decide
+ *         - NULL on failure. It is up to the caller to decide
  *	     the impact of a failure.
  */
 static struct arm64_ftr_reg *get_arm64_ftr_reg_nowarn(u32 sys_id)
@@ -874,7 +874,7 @@ static void __init sort_ftr_regs(void)
 
 /*
  * Initialise the CPU feature register from Boot CPU values.
- * Also initiliases the strict_mask for the register.
+ * Also initialises the strict_mask for the register.
  * Any bits that are not covered by an arm64_ftr_bits entry are considered
  * RES0 for the system-wide value, and must strictly match.
  */
@@ -3108,7 +3108,7 @@ static void verify_local_cpu_caps(u16 scope_mask)
 			/*
 			 * We have to issue cpu_enable() irrespective of
 			 * whether the CPU has it or not, as it is enabeld
-			 * system wide. It is upto the call back to take
+			 * system wide. It is up to the call back to take
 			 * appropriate action on this CPU.
 			 */
 			if (caps->cpu_enable)
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 0fc94207e69a..80b5268578a8 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -660,7 +660,7 @@ static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
 
 static void noinstr el0_dbg(struct pt_regs *regs, unsigned long esr)
 {
-	/* Only watchpoints write FAR_EL1, otherwise its UNKNOWN */
+	/* Only watchpoints write FAR_EL1, otherwise it's UNKNOWN */
 	unsigned long far = read_sysreg(far_el1);
 
 	enter_from_user_mode(regs);
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index f0c16640ef21..e24e7d8f8b61 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -94,7 +94,7 @@ SYM_CODE_START(ftrace_caller)
 	stp	x29, x30, [sp, #FREGS_SIZE]
 	add	x29, sp, #FREGS_SIZE
 
-	/* Prepare arguments for the the tracer func */
+	/* Prepare arguments for the tracer func */
 	sub	x0, x30, #AARCH64_INSN_SIZE		// ip (callsite's BL insn)
 	mov	x1, x9					// parent_ip (callsite's LR)
 	mov	x3, sp					// regs
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a6030913cd58..00bdd1fa8151 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -547,7 +547,7 @@ SYM_CODE_START_LOCAL(__bad_stack)
 	mrs	x0, tpidrro_el0
 
 	/*
-	 * Store the original GPRs to the new stack. The orginal SP (minus
+	 * Store the original GPRs to the new stack. The original SP (minus
 	 * PT_REGS_SIZE) was stashed in tpidr_el0 by kernel_ventry.
 	 */
 	sub	sp, sp, #PT_REGS_SIZE
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index a650f5e11fc5..6e00b39059ff 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -423,7 +423,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		return ret;
 
 	/*
-	 * When using mcount, callsites in modules may have been initalized to
+	 * When using mcount, callsites in modules may have been initialized to
 	 * call an arbitrary module PLT (which redirects to the _mcount stub)
 	 * rather than the ftrace PLT we'll use at runtime (which redirects to
 	 * the ftrace trampoline). We can ignore the old PLT when initializing
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 078910db77a4..36721a7e7855 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -296,7 +296,7 @@ void crash_post_resume(void)
  * marked as Reserved as memory was allocated via memblock_reserve().
  *
  * In hibernation, the pages which are Reserved and yet "nosave" are excluded
- * from the hibernation iamge. crash_is_nosave() does thich check for crash
+ * from the hibernation image. crash_is_nosave() does this check for crash
  * dump kernel and will reduce the total size of hibernation image.
  */
 
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2657cd..5016f7f681c0 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -122,7 +122,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 	struct uprobe_task *utask = current->utask;
 
 	/*
-	 * Task has received a fatal signal, so reset back to probbed
+	 * Task has received a fatal signal, so reset back to probed
 	 * address.
 	 */
 	instruction_pointer_set(regs, utask->vaddr);
diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
index 255d12f881c2..931f317a9ffa 100644
--- a/arch/arm64/kernel/sdei.c
+++ b/arch/arm64/kernel/sdei.c
@@ -206,7 +206,7 @@ unsigned long sdei_arch_get_entry_point(int conduit)
 /*
  * do_sdei_event() returns one of:
  *  SDEI_EV_HANDLED -  success, return to the interrupted context.
- *  SDEI_EV_FAILED  -  failure, return this error code to firmare.
+ *  SDEI_EV_FAILED  -  failure, return this error code to firmware.
  *  virtual-address -  success, return to this address.
  */
 unsigned long __kprobes do_sdei_event(struct pt_regs *regs,
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index defbab84e9e5..8b8e1320033b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -351,7 +351,7 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 
 	/*
 	 * Now that the dying CPU is beyond the point of no return w.r.t.
-	 * in-kernel synchronisation, try to get the firwmare to help us to
+	 * in-kernel synchronisation, try to get the firmware to help us to
 	 * verify that it has really left the kernel before we consider
 	 * clobbering anything it might still be using.
 	 */
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 215e6d7f2df8..e76c71c54c8c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -897,7 +897,7 @@ void __noreturn panic_bad_stack(struct pt_regs *regs, unsigned long esr, unsigne
 	__show_regs(regs);
 
 	/*
-	 * We use nmi_panic to limit the potential for recusive overflows, and
+	 * We use nmi_panic to limit the potential for recursive overflows, and
 	 * to get a better stack trace.
 	 */
 	nmi_panic(NULL, "kernel stack overflow");
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 13ba691b848f..ded8063b8813 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -746,7 +746,7 @@ static void kvm_timer_vcpu_load_nested_switch(struct kvm_vcpu *vcpu,
 		WARN_ON_ONCE(ret);
 
 		/*
-		 * The virtual offset behaviour is "interresting", as it
+		 * The virtual offset behaviour is "interesting", as it
 		 * always applies when HCR_EL2.E2H==0, but only when
 		 * accessed from EL1 when HCR_EL2.E2H==1. So make sure we
 		 * track E2H when putting the HV timer in "direct" mode.
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 8c1d0d4853df..571cf6eef1e1 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -117,7 +117,7 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 }
 
 /*
- * Called just before entering the guest once we are no longer preemptable
+ * Called just before entering the guest once we are no longer preemptible
  * and interrupts are disabled. If we have managed to run anything using
  * FP while we were preemptible (such as off the back of an interrupt),
  * then neither the host nor the guest own the FP hardware (and it was the
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 7693a6757cd7..135cfb294ee5 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -110,7 +110,7 @@ SYM_FUNC_END(__host_enter)
  * 				  u64 elr, u64 par);
  */
 SYM_FUNC_START(__hyp_do_panic)
-	/* Prepare and exit to the host's panic funciton. */
+	/* Prepare and exit to the host's panic function. */
 	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
 		      PSR_MODE_EL1h)
 	msr	spsr_el2, lr
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 65a7a186d7b2..daf91a7989d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -155,7 +155,7 @@ int hyp_back_vmemmap(phys_addr_t back)
 		start = hyp_memory[i].base;
 		start = ALIGN_DOWN((u64)hyp_phys_to_page(start), PAGE_SIZE);
 		/*
-		 * The begining of the hyp_vmemmap region for the current
+		 * The beginning of the hyp_vmemmap region for the current
 		 * memblock may already be backed by the page backing the end
 		 * the previous region, so avoid mapping it twice.
 		 */
@@ -408,7 +408,7 @@ static void *admit_host_page(void *arg)
 	return pop_hyp_memcache(host_mc, hyp_phys_to_virt);
 }
 
-/* Refill our local memcache by poping pages from the one provided by the host. */
+/* Refill our local memcache by popping pages from the one provided by the host. */
 int refill_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages,
 		    struct kvm_hyp_memcache *host_mc)
 {
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index 0bd93a5f21ce..a640e839848e 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -134,7 +134,7 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
 	if (vcpu_read_sys_reg(vcpu, TCR_EL1) & TTBCR_EAE) {
 		fsr = DFSR_LPAE | DFSR_FSC_EXTABT_LPAE;
 	} else {
-		/* no need to shuffle FS[4] into DFSR[10] as its 0 */
+		/* no need to shuffle FS[4] into DFSR[10] as it's 0 */
 		fsr = DFSR_FSC_EXTABT_nLPAE;
 	}
 
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index c8c3cb812783..a0a9badaa91c 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -309,7 +309,7 @@ int vgic_init(struct kvm *kvm)
 		vgic_lpi_translation_cache_init(kvm);
 
 	/*
-	 * If we have GICv4.1 enabled, unconditionnaly request enable the
+	 * If we have GICv4.1 enabled, unconditionally request enable the
 	 * v4 support so that we get HW-accelerated vSGIs. Otherwise, only
 	 * enable it if we present a virtual ITS to the guest.
 	 */
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 2dad2d095160..39d8c15202e7 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1337,8 +1337,8 @@ static int vgic_its_cmd_handle_inv(struct kvm *kvm, struct vgic_its *its,
 }
 
 /**
- * vgic_its_invall - invalidate all LPIs targetting a given vcpu
- * @vcpu: the vcpu for which the RD is targetted by an invalidation
+ * vgic_its_invall - invalidate all LPIs targeting a given vcpu
+ * @vcpu: the vcpu for which the RD is targeted by an invalidation
  *
  * Contrary to the INVALL command, this targets a RD instead of a
  * collection, and we don't need to hold the its_lock, since no ITS is
-- 
2.34.1


