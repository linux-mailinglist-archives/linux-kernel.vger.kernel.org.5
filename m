Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356E17F1068
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjKTK3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjKTK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:28:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14410138;
        Mon, 20 Nov 2023 02:28:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AC2C433C9;
        Mon, 20 Nov 2023 10:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700476111;
        bh=1oI5JU/urJUhehbd9YKUM8nyCU0/fyB5nXLECr8GO5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSqkKiqANnXLUJiYq8lUsDSkNUduKktONnqxMO3yAYPn/44WjElwo+nFMpLGTNhDW
         iaI/Sn8K4L/7D28K4pdrSsqXXV0nfdhb/foHw8L8AGYP5l/PBFbmHGOlfNZ6EFscWm
         NGRb/IP7Y1azvS6Dos/6gCvD/j0NUofRM+x3XgmU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.139
Date:   Mon, 20 Nov 2023 11:28:14 +0100
Message-ID: <2023112014-wiring-eastbound-5b5b@gregkh>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <2023112014-ecosystem-triumph-adf0@gregkh>
References: <2023112014-ecosystem-triumph-adf0@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index f8534e335aba..2acf6ff74c95 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 138
+SUBLEVEL = 139
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index ad9b52d53ef9..982f3c392196 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -82,14 +82,12 @@ cxo_board {
 		};
 	};
 
-	regulators {
-		vsdcc_fixed: vsdcc-regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "SDCC Power";
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-			regulator-always-on;
-		};
+	vsdcc_fixed: vsdcc-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "SDCC Power";
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
+		regulator-always-on;
 	};
 
 	soc: soc {
diff --git a/arch/arm/boot/dts/r8a7792-blanche.dts b/arch/arm/boot/dts/r8a7792-blanche.dts
index 62aa9f61321b..089fef40c4c4 100644
--- a/arch/arm/boot/dts/r8a7792-blanche.dts
+++ b/arch/arm/boot/dts/r8a7792-blanche.dts
@@ -239,7 +239,7 @@ du1_pins: du1 {
 	};
 
 	keyboard_pins: keyboard {
-		pins = "GP_3_10", "GP_3_11", "GP_3_12", "GP_3_15", "GP_11_02";
+		pins = "GP_3_10", "GP_3_11", "GP_3_12", "GP_3_15", "GP_11_2";
 		bias-pull-up;
 	};
 
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 9817cb258c1a..0481b9bbbd00 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -17,6 +17,7 @@ ENTRY(__memset)
 ENTRY(mmioset)
 WEAK(memset)
 UNWIND( .fnstart         )
+	and	r1, r1, #255		@ cast to unsigned char
 	ands	r3, r0, #3		@ 1 unaligned?
 	mov	ip, r0			@ preserve r0 as return value
 	bne	6f			@ 1
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 7f1c106b746f..27277d6bbfa5 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -159,9 +159,6 @@ static int xen_starting_cpu(unsigned int cpu)
 	BUG_ON(err);
 	per_cpu(xen_vcpu, cpu) = vcpup;
 
-	if (!xen_kernel_unmapped_at_usr())
-		xen_setup_runstate_info(cpu);
-
 after_register_vcpu_info:
 	enable_percpu_irq(xen_events_irq, 0);
 	return 0;
@@ -394,9 +391,6 @@ static int __init xen_guest_init(void)
 		return -EINVAL;
 	}
 
-	if (!xen_kernel_unmapped_at_usr())
-		xen_time_setup_guest();
-
 	if (xen_initial_domain())
 		pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
 
@@ -406,7 +400,13 @@ static int __init xen_guest_init(void)
 }
 early_initcall(xen_guest_init);
 
-static int __init xen_pm_init(void)
+static int xen_starting_runstate_cpu(unsigned int cpu)
+{
+	xen_setup_runstate_info(cpu);
+	return 0;
+}
+
+static int __init xen_late_init(void)
 {
 	if (!xen_domain())
 		return -ENODEV;
@@ -419,9 +419,16 @@ static int __init xen_pm_init(void)
 		do_settimeofday64(&ts);
 	}
 
-	return 0;
+	if (xen_kernel_unmapped_at_usr())
+		return 0;
+
+	xen_time_setup_guest();
+
+	return cpuhp_setup_state(CPUHP_AP_ARM_XEN_RUNSTATE_STARTING,
+				 "arm/xen_runstate:starting",
+				 xen_starting_runstate_cpu, NULL);
 }
-late_initcall(xen_pm_init);
+late_initcall(xen_late_init);
 
 
 /* empty stubs */
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 2a67122c5624..86731850a6bd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -366,6 +366,7 @@ micfil: audio-controller@30080000 {
 						      "pll8k", "pll11k", "clkext3";
 					dmas = <&sdma2 24 25 0x80000000>;
 					dma-names = "rx";
+					#sound-dai-cells = <0>;
 					status = "disabled";
 				};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 16a5efba17f3..8f01848b7c6a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -340,6 +340,7 @@ micfil: audio-controller@30080000 {
 						      "pll8k", "pll11k", "clkext3";
 					dmas = <&sdma2 24 25 0x80000000>;
 					dma-names = "rx";
+					#sound-dai-cells = <0>;
 					status = "disabled";
 				};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi
index 7764b4146e0a..2bbdacb1313f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi
@@ -8,5 +8,5 @@ &jpegdec {
 };
 
 &jpegenc {
-	compatible = "nxp,imx8qm-jpgdec", "nxp,imx8qxp-jpgenc";
+	compatible = "nxp,imx8qm-jpgenc", "nxp,imx8qxp-jpgenc";
 };
diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
index 505ae69289f6..ce49702dc493 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
@@ -107,7 +107,7 @@ cp0_sdhci_pins: cp0-sdhi-pins-0 {
 				       "mpp59", "mpp60", "mpp61";
 			marvell,function = "sdio";
 		};
-		cp0_spi0_pins: cp0-spi-pins-0 {
+		cp0_spi1_pins: cp0-spi-pins-1 {
 			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
 			marvell,function = "spi1";
 		};
@@ -149,7 +149,7 @@ &cp0_sdhci0 {
 
 &cp0_spi1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_spi0_pins>;
+	pinctrl-0 = <&cp0_spi1_pins>;
 	reg = <0x700680 0x50>,		/* control */
 	      <0x2000000 0x1000000>;	/* CS0 */
 	status = "okay";
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
index c00b69b88bd2..c53253f66840 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-db.dtsi
@@ -307,7 +307,7 @@ &cp0_sdhci0 {
 &cp0_spi1 {
 	status = "disabled";
 	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_spi0_pins>;
+	pinctrl-0 = <&cp0_spi1_pins>;
 	reg = <0x700680 0x50>;
 
 	spi-flash@0 {
@@ -371,7 +371,7 @@ cp0_sdhci_pins: cp0-sdhi-pins-0 {
 				       "mpp59", "mpp60", "mpp61";
 			marvell,function = "sdio";
 		};
-		cp0_spi0_pins: cp0-spi-pins-0 {
+		cp0_spi1_pins: cp0-spi-pins-1 {
 			marvell,pins = "mpp13", "mpp14", "mpp15", "mpp16";
 			marvell,function = "spi1";
 		};
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index ad4c2ccec63e..0153be6d2a2b 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -190,6 +190,9 @@ adv_bridge: bridge@39 {
 		pd-gpios = <&msmgpio 32 GPIO_ACTIVE_HIGH>;
 
 		avdd-supply = <&pm8916_l6>;
+		a2vdd-supply = <&pm8916_l6>;
+		dvdd-supply = <&pm8916_l6>;
+		pvdd-supply = <&pm8916_l6>;
 		v1p2-supply = <&pm8916_l6>;
 		v3p3-supply = <&pm8916_l17>;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index fcc9f757c9e1..668674059d48 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1233,7 +1233,7 @@ apps_iommu: iommu@1ef0000 {
 			#size-cells = <1>;
 			#iommu-cells = <1>;
 			compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
-			ranges = <0 0x01e20000 0x40000>;
+			ranges = <0 0x01e20000 0x20000>;
 			reg = <0x01ef0000 0x3000>;
 			clocks = <&gcc GCC_SMMU_CFG_CLK>,
 				 <&gcc GCC_APSS_TCU_CLK>;
diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index d08659c606b9..5433ae0c4590 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -99,11 +99,6 @@ rmtfs_mem: rmtfs@ca100000 {
 			qcom,client-id = <1>;
 		};
 
-		audio_mem: audio@cb400000 {
-			reg = <0 0xcb000000 0 0x400000>;
-			no-mem;
-		};
-
 		qseecom_mem: qseecom@cb400000 {
 			reg = <0 0xcb400000 0 0x1c00000>;
 			no-mem;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index fb6473a0aa4b..dc4aab258ff6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1851,6 +1851,14 @@ cpufreq_hw: cpufreq@18591000 {
 			reg = <0 0x18591000 0 0x1000>,
 			      <0 0x18592000 0 0x1000>,
 			      <0 0x18593000 0 0x1000>;
+
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0",
+					  "dcvsh-irq-1",
+					  "dcvsh-irq-2";
+
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 			#freq-domain-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 52dd7a858231..cf2fad5bcac1 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -572,6 +572,8 @@ &wifi {
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+
+	qcom,snoc-host-cap-8bit-quirk;
 };
 
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index 2d3153cfc0d7..acf61242e85b 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -69,9 +69,6 @@
 
 #define _PTE_NONE_MASK	0
 
-/* Until my rework is finished, 40x still needs atomic PTE updates */
-#define PTE_ATOMIC_UPDATES	1
-
 #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
 #define _PAGE_BASE	(_PAGE_BASE_NC)
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a08bb7cefdc5..fe912983ced9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1148,6 +1148,7 @@ static void emulate_single_step(struct pt_regs *regs)
 		__single_step_exception(regs);
 }
 
+#ifdef CONFIG_PPC_FPU_REGS
 static inline int __parse_fpscr(unsigned long fpscr)
 {
 	int ret = FPE_FLTUNK;
@@ -1174,6 +1175,7 @@ static inline int __parse_fpscr(unsigned long fpscr)
 
 	return ret;
 }
+#endif
 
 static void parse_fpe(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index b8a100b9736c..55a853edc3be 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -50,7 +50,7 @@ static int trace_imc_mem_size;
  * core and trace-imc
  */
 static struct imc_pmu_ref imc_global_refc = {
-	.lock = __SPIN_LOCK_INITIALIZER(imc_global_refc.lock),
+	.lock = __SPIN_LOCK_UNLOCKED(imc_global_refc.lock),
 	.id = 0,
 	.refc = 0,
 };
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index d133597a84ca..fce0237b0715 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -524,8 +524,10 @@ static ssize_t vcpudispatch_stats_write(struct file *file, const char __user *p,
 
 	if (cmd) {
 		rc = init_cpu_associativity();
-		if (rc)
+		if (rc) {
+			destroy_cpu_associativity();
 			goto out;
+		}
 
 		for_each_possible_cpu(cpu) {
 			disp = per_cpu_ptr(&vcpu_disp_data, cpu);
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 1aec282cd650..b6323bdecfa4 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -786,7 +786,7 @@ int xive_native_get_queue_info(u32 vp_id, u32 prio,
 	if (out_qpage)
 		*out_qpage = be64_to_cpu(qpage);
 	if (out_qsize)
-		*out_qsize = be32_to_cpu(qsize);
+		*out_qsize = be64_to_cpu(qsize);
 	if (out_qeoi_page)
 		*out_qeoi_page = be64_to_cpu(qeoi_page);
 	if (out_escalate_irq)
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index c449e7c1b20f..8bcd6c1431a9 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -22,6 +22,17 @@ config STACK_DEBUG
 	  every function call and will therefore incur a major
 	  performance hit. Most users should say N.
 
+config EARLY_PRINTK
+	bool "Early printk"
+	depends on SH_STANDARD_BIOS
+	help
+	  Say Y here to redirect kernel printk messages to the serial port
+	  used by the SH-IPL bootloader, starting very early in the boot
+	  process and ending when the kernel's serial console is initialised.
+	  This option is only useful while porting the kernel to a new machine,
+	  when the kernel may crash or hang before the serial console is
+	  initialised.  If unsure, say N.
+
 config 4KSTACKS
 	bool "Use 4Kb for kernel stacks instead of 8Kb"
 	depends on DEBUG_KERNEL && (MMU || BROKEN) && !PAGE_SIZE_64KB
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index d0295240c78a..a85d3138839c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1360,20 +1360,10 @@ static void pt_addr_filters_fini(struct perf_event *event)
 }
 
 #ifdef CONFIG_X86_64
-static u64 canonical_address(u64 vaddr, u8 vaddr_bits)
-{
-	return ((s64)vaddr << (64 - vaddr_bits)) >> (64 - vaddr_bits);
-}
-
-static u64 is_canonical_address(u64 vaddr, u8 vaddr_bits)
-{
-	return canonical_address(vaddr, vaddr_bits) == vaddr;
-}
-
 /* Clamp to a canonical address greater-than-or-equal-to the address given */
 static u64 clamp_to_ge_canonical_addr(u64 vaddr, u8 vaddr_bits)
 {
-	return is_canonical_address(vaddr, vaddr_bits) ?
+	return __is_canonical_address(vaddr, vaddr_bits) ?
 	       vaddr :
 	       -BIT_ULL(vaddr_bits - 1);
 }
@@ -1381,7 +1371,7 @@ static u64 clamp_to_ge_canonical_addr(u64 vaddr, u8 vaddr_bits)
 /* Clamp to a canonical address less-than-or-equal-to the address given */
 static u64 clamp_to_le_canonical_addr(u64 vaddr, u8 vaddr_bits)
 {
-	return is_canonical_address(vaddr, vaddr_bits) ?
+	return __is_canonical_address(vaddr, vaddr_bits) ?
 	       vaddr :
 	       BIT_ULL(vaddr_bits - 1) - 1;
 }
diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index 4d5810c8fab7..9cc82f305f4b 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -71,6 +71,16 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
 extern bool __virt_addr_valid(unsigned long kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
 
+static __always_inline u64 __canonical_address(u64 vaddr, u8 vaddr_bits)
+{
+	return ((s64)vaddr << (64 - vaddr_bits)) >> (64 - vaddr_bits);
+}
+
+static __always_inline u64 __is_canonical_address(u64 vaddr, u8 vaddr_bits)
+{
+	return __canonical_address(vaddr, vaddr_bits) == vaddr;
+}
+
 #endif	/* __ASSEMBLY__ */
 
 #include <asm-generic/memory_model.h>
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ab5e57737309..3616fd4ba395 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -543,7 +543,7 @@ copy_mc_to_kernel(void *to, const void *from, unsigned len);
 #define copy_mc_to_kernel copy_mc_to_kernel
 
 unsigned long __must_check
-copy_mc_to_user(void *to, const void *from, unsigned len);
+copy_mc_to_user(void __user *to, const void *from, unsigned len);
 #endif
 
 /*
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6322a08edbba..d1ba55ea46a7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2477,7 +2477,7 @@ static void __init srso_select_mitigation(void)
 	pr_info("%s%s\n", srso_strings[srso_mitigation], (has_microcode ? "" : ", no microcode"));
 
 pred_cmd:
-	if ((boot_cpu_has(X86_FEATURE_SRSO_NO) || srso_cmd == SRSO_CMD_OFF) &&
+	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
 	     boot_cpu_has(X86_FEATURE_SBPB))
 		x86_pred_cmd = PRED_CMD_SBPB;
 }
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 5036104d5470..2375f5f4f763 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -79,7 +79,7 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
  * while the kernel still uses a direct mapping.
  */
 static struct desc_ptr startup_gdt_descr = {
-	.size = sizeof(startup_gdt),
+	.size = sizeof(startup_gdt)-1,
 	.address = 0,
 };
 
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index cb96e4354f31..98b25a7af8ce 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -687,7 +687,7 @@ static inline u8 ctxt_virt_addr_bits(struct x86_emulate_ctxt *ctxt)
 static inline bool emul_is_noncanonical_address(u64 la,
 						struct x86_emulate_ctxt *ctxt)
 {
-	return get_canonical(la, ctxt_virt_addr_bits(ctxt)) != la;
+	return !__is_canonical_address(la, ctxt_virt_addr_bits(ctxt));
 }
 
 /*
@@ -737,7 +737,7 @@ static __always_inline int __linearize(struct x86_emulate_ctxt *ctxt,
 	case X86EMUL_MODE_PROT64:
 		*linear = la;
 		va_bits = ctxt_virt_addr_bits(ctxt);
-		if (get_canonical(la, va_bits) != la)
+		if (!__is_canonical_address(la, va_bits))
 			goto bad;
 
 		*max_size = min_t(u64, ~0u, (1ull << va_bits) - la);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a26200c3e82b..7e9b61565306 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1745,7 +1745,7 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
 		 * value, and that something deterministic happens if the guest
 		 * invokes 64-bit SYSENTER.
 		 */
-		data = get_canonical(data, vcpu_virt_addr_bits(vcpu));
+		data = __canonical_address(data, vcpu_virt_addr_bits(vcpu));
 		break;
 	case MSR_TSC_AUX:
 		if (!kvm_is_supported_user_return_msr(MSR_TSC_AUX))
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index cd0c93ec72fa..f7854e742e8c 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -211,14 +211,9 @@ static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
 	return kvm_read_cr4_bits(vcpu, X86_CR4_LA57) ? 57 : 48;
 }
 
-static inline u64 get_canonical(u64 la, u8 vaddr_bits)
-{
-	return ((int64_t)la << (64 - vaddr_bits)) >> (64 - vaddr_bits);
-}
-
 static inline bool is_noncanonical_address(u64 la, struct kvm_vcpu *vcpu)
 {
-	return get_canonical(la, vcpu_virt_addr_bits(vcpu)) != la;
+	return !__is_canonical_address(la, vcpu_virt_addr_bits(vcpu));
 }
 
 static inline void vcpu_cache_mmio_info(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 80efd45a7761..6e8b7e600def 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -70,23 +70,23 @@ unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigne
 }
 EXPORT_SYMBOL_GPL(copy_mc_to_kernel);
 
-unsigned long __must_check copy_mc_to_user(void *dst, const void *src, unsigned len)
+unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, unsigned len)
 {
 	unsigned long ret;
 
 	if (copy_mc_fragile_enabled) {
 		__uaccess_begin();
-		ret = copy_mc_fragile(dst, src, len);
+		ret = copy_mc_fragile((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
 	}
 
 	if (static_cpu_has(X86_FEATURE_ERMS)) {
 		__uaccess_begin();
-		ret = copy_mc_enhanced_fast_string(dst, src, len);
+		ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
 	}
 
-	return copy_user_generic(dst, src, len);
+	return copy_user_generic((__force void *)dst, src, len);
 }
diff --git a/arch/x86/mm/maccess.c b/arch/x86/mm/maccess.c
index 92ec176a7293..6993f026adec 100644
--- a/arch/x86/mm/maccess.c
+++ b/arch/x86/mm/maccess.c
@@ -4,22 +4,26 @@
 #include <linux/kernel.h>
 
 #ifdef CONFIG_X86_64
-static __always_inline u64 canonical_address(u64 vaddr, u8 vaddr_bits)
-{
-	return ((s64)vaddr << (64 - vaddr_bits)) >> (64 - vaddr_bits);
-}
-
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
 {
 	unsigned long vaddr = (unsigned long)unsafe_src;
 
 	/*
-	 * Range covering the highest possible canonical userspace address
-	 * as well as non-canonical address range. For the canonical range
-	 * we also need to include the userspace guard page.
+	 * Do not allow userspace addresses.  This disallows
+	 * normal userspace and the userspace guard page:
 	 */
-	return vaddr >= TASK_SIZE_MAX + PAGE_SIZE &&
-	       canonical_address(vaddr, boot_cpu_data.x86_virt_bits) == vaddr;
+	if (vaddr < TASK_SIZE_MAX + PAGE_SIZE)
+		return false;
+
+	/*
+	 * Allow everything during early boot before 'x86_virt_bits'
+	 * is initialized.  Needed for instruction decoding in early
+	 * exception handlers.
+	 */
+	if (!boot_cpu_data.x86_virt_bits)
+		return true;
+
+	return __is_canonical_address(vaddr, boot_cpu_data.x86_virt_bits);
 }
 #else
 bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size)
diff --git a/block/blk-core.c b/block/blk-core.c
index fbbd59e6d7e1..3c7d57afa5a3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -693,18 +693,15 @@ static inline bool should_fail_request(struct block_device *part,
 
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
-static inline bool bio_check_ro(struct bio *bio)
+static inline void bio_check_ro(struct bio *bio)
 {
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
-			return false;
-		pr_warn("Trying to write to read-only block-device %pg\n",
-			bio->bi_bdev);
+			return;
+		pr_warn_ratelimited("Trying to write to read-only block-device %pg\n",
+				    bio->bi_bdev);
 		/* Older lvm-tools actually trigger this */
-		return false;
 	}
-
-	return false;
 }
 
 static noinline int should_fail_bio(struct bio *bio)
@@ -810,8 +807,7 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 
 	if (should_fail_bio(bio))
 		goto end_io;
-	if (unlikely(bio_check_ro(bio)))
-		goto end_io;
+	bio_check_ro(bio);
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
 		if (unlikely(bio_check_eod(bio)))
 			goto end_io;
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 61271e61c307..da9cd11adfb5 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -157,8 +157,8 @@ static int create_pnp_modalias(struct acpi_device *acpi_dev, char *modalias,
 		return 0;
 
 	len = snprintf(modalias, size, "acpi:");
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
 
 	size -= len;
 
@@ -211,8 +211,10 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
 	len = snprintf(modalias, size, "of:N%sT", (char *)buf.pointer);
 	ACPI_FREE(buf.pointer);
 
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
+
+	size -= len;
 
 	of_compatible = acpi_dev->data.of_compatible;
 	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index ad684d37c2da..6caed4b55636 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -48,7 +48,7 @@ static ssize_t regmap_name_read_file(struct file *file,
 		name = map->dev->driver->name;
 
 	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);
-	if (ret < 0) {
+	if (ret >= PAGE_SIZE) {
 		kfree(buf);
 		return ret;
 	}
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 617d51a27849..7621b54975b5 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1683,17 +1683,19 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 	}
 
 	if (!map->cache_bypass && map->format.parse_val) {
-		unsigned int ival;
+		unsigned int ival, offset;
 		int val_bytes = map->format.val_bytes;
-		for (i = 0; i < val_len / val_bytes; i++) {
-			ival = map->format.parse_val(val + (i * val_bytes));
-			ret = regcache_write(map,
-					     reg + regmap_get_offset(map, i),
-					     ival);
+
+		/* Cache the last written value for noinc writes */
+		i = noinc ? val_len - val_bytes : 0;
+		for (; i < val_len; i += val_bytes) {
+			ival = map->format.parse_val(val + i);
+			offset = noinc ? 0 : regmap_get_offset(map, i / val_bytes);
+			ret = regcache_write(map, reg + offset, ival);
 			if (ret) {
 				dev_err(map->dev,
 					"Error in caching of register: %x ret: %d\n",
-					reg + regmap_get_offset(map, i), ret);
+					reg + offset, ret);
 				return ret;
 			}
 		}
diff --git a/drivers/char/hw_random/geode-rng.c b/drivers/char/hw_random/geode-rng.c
index 12fbe8091831..159baf00a867 100644
--- a/drivers/char/hw_random/geode-rng.c
+++ b/drivers/char/hw_random/geode-rng.c
@@ -58,7 +58,8 @@ struct amd_geode_priv {
 
 static int geode_rng_data_read(struct hwrng *rng, u32 *data)
 {
-	void __iomem *mem = (void __iomem *)rng->priv;
+	struct amd_geode_priv *priv = (struct amd_geode_priv *)rng->priv;
+	void __iomem *mem = priv->membase;
 
 	*data = readl(mem + GEODE_RNG_DATA_REG);
 
@@ -67,7 +68,8 @@ static int geode_rng_data_read(struct hwrng *rng, u32 *data)
 
 static int geode_rng_data_present(struct hwrng *rng, int wait)
 {
-	void __iomem *mem = (void __iomem *)rng->priv;
+	struct amd_geode_priv *priv = (struct amd_geode_priv *)rng->priv;
+	void __iomem *mem = priv->membase;
 	int data, i;
 
 	for (i = 0; i < 20; i++) {
diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index e677bb5a784b..c10f04f9070a 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -539,7 +539,7 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	return;
 
 npcm7xx_init_fail:
-	kfree(npcm7xx_clk_data->hws);
+	kfree(npcm7xx_clk_data);
 npcm7xx_init_np_err:
 	iounmap(clk_base);
 npcm7xx_init_error:
diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 1e357d364ca2..a26027597a0a 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -178,6 +178,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		sclk->info = scmi_proto_clk_ops->info_get(ph, idx);
 		if (!sclk->info) {
 			dev_dbg(dev, "invalid clock info for idx %d\n", idx);
+			devm_kfree(dev, sclk);
 			continue;
 		}
 
diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 47d9ec3abd2f..d3d730610cb4 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -96,5 +96,6 @@ config CLK_IMX8QXP
 	depends on (ARCH_MXC && ARM64) || COMPILE_TEST
 	depends on IMX_SCU && HAVE_ARM_SMCCC
 	select MXC_CLK_SCU
+	select MXC_CLK
 	help
 	  Build the driver for IMX8QXP SCU based clocks.
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 83cc2b1c3294..791f6bdd88b8 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -288,8 +288,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int err;
 
-	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
-					  IMX8MQ_CLK_END), GFP_KERNEL);
+	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MQ_CLK_END), GFP_KERNEL);
 	if (WARN_ON(!clk_hw_data))
 		return -ENOMEM;
 
@@ -306,10 +305,12 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MQ_CLK_EXT4] = imx_obtain_fixed_clk_hw(np, "clk_ext4");
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
-	base = of_iomap(np, 0);
+	base = devm_of_iomap(dev, np, 0, NULL);
 	of_node_put(np);
-	if (WARN_ON(!base))
-		return -ENOMEM;
+	if (WARN_ON(IS_ERR(base))) {
+		err = PTR_ERR(base);
+		goto unregister_hws;
+	}
 
 	hws[IMX8MQ_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	hws[IMX8MQ_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
@@ -395,8 +396,10 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 
 	np = dev->of_node;
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (WARN_ON(IS_ERR(base)))
-		return PTR_ERR(base);
+	if (WARN_ON(IS_ERR(base))) {
+		err = PTR_ERR(base);
+		goto unregister_hws;
+	}
 
 	/* CORE */
 	hws[IMX8MQ_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mq_a53_sels, base + 0x8000);
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 40a2efb1329b..32df47c56621 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -148,10 +148,10 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("adc0_clk",  IMX_SC_R_ADC_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("adc1_clk",  IMX_SC_R_ADC_1, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER);
+	imx_clk_scu("elcdif_pll", IMX_SC_R_ELCDIF_PLL, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu2("lcd_clk", lcd_sels, ARRAY_SIZE(lcd_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 	imx_clk_scu("lcd_pxl_bypass_div_clk", IMX_SC_R_LCD_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("elcdif_pll", IMX_SC_R_ELCDIF_PLL, IMX_SC_PM_CLK_PLL);
 
 	/* Audio SS */
 	imx_clk_scu("audio_pll0_clk", IMX_SC_R_AUDIO_PLL_0, IMX_SC_PM_CLK_PLL);
diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index ee5c72369334..6bbdd4705d71 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -281,12 +281,13 @@ static void __init of_pll_div_clk_init(struct device_node *node)
 
 	clk = clk_register_divider(NULL, clk_name, parent_name, 0, reg, shift,
 				 mask, 0, NULL);
-	if (clk) {
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	} else {
+	if (IS_ERR(clk)) {
 		pr_err("%s: error registering divider %s\n", __func__, clk_name);
 		iounmap(reg);
+		return;
 	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 CLK_OF_DECLARE(pll_divider_clock, "ti,keystone,pll-divider-clock", of_pll_div_clk_init);
 
@@ -328,10 +329,12 @@ static void __init of_pll_mux_clk_init(struct device_node *node)
 	clk = clk_register_mux(NULL, clk_name, (const char **)&parents,
 				ARRAY_SIZE(parents) , 0, reg, shift, mask,
 				0, NULL);
-	if (clk)
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	else
+	if (IS_ERR(clk)) {
 		pr_err("%s: error registering mux %s\n", __func__, clk_name);
+		return;
+	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 CLK_OF_DECLARE(pll_mux_clock, "ti,keystone,pll-mux-clock", of_pll_mux_clk_init);
 
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 695be0f77427..c67cd73aca17 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -675,6 +675,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 								clk_data);
@@ -742,6 +744,8 @@ static void __init mtk_infrasys_init_early(struct device_node *node)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return;
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
 			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
@@ -768,6 +772,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return -ENOMEM;
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
 			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
@@ -896,6 +902,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 						clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index d77ea5aff292..17352342b698 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -785,6 +785,8 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 	}
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
@@ -820,6 +822,8 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 	}
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks),
 				    clk_data);
@@ -860,6 +864,8 @@ static int clk_mt6765_ifr_probe(struct platform_device *pdev)
 	}
 
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 6e0d3a166729..cf720651fc53 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -1216,6 +1216,8 @@ static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
@@ -1236,6 +1238,8 @@ static int clk_mt6779_top_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 428eb24ffec5..98d456023f4e 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -391,6 +391,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_factors(top_fixed_divs, ARRAY_SIZE(top_fixed_divs),
 				 clk_data);
@@ -563,6 +565,8 @@ static void mtk_infrasys_init_early(struct device_node *node)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return;
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
 			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
@@ -587,6 +591,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return -ENOMEM;
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
 			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 88279d0ea1a7..3ab7b672f8c7 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -83,6 +83,8 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_ETH_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, eth_clks, CLK_ETH_NR_CLK, clk_data);
 
@@ -105,6 +107,8 @@ static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_SGMII_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, sgmii_clks[id++], CLK_SGMII_NR_CLK,
 			       clk_data);
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index a0ee079670c7..f791e53b812a 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -580,6 +580,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 				    clk_data);
@@ -603,6 +605,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	struct clk_onecell_data *clk_data;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			       clk_data);
@@ -626,6 +630,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 			       clk_data);
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 6ba86cffc413..4c8bb23ca730 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -127,6 +127,7 @@ config IPQ_APSS_6018
 	tristate "IPQ APSS Clock Controller"
 	select IPQ_APSS_PLL
 	depends on QCOM_APCS_IPC || COMPILE_TEST
+	depends on QCOM_SMEM
 	help
 	  Support for APSS clock controller on IPQ platforms. The
 	  APSS clock controller manages the Mux and enable block that feeds the
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index c3823cc32edc..f3c225ed5737 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -148,17 +148,11 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
 static unsigned long
 calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
 {
-	if (hid_div) {
-		rate *= 2;
-		rate /= hid_div + 1;
-	}
+	if (hid_div)
+		rate = mult_frac(rate, 2, hid_div + 1);
 
-	if (mode) {
-		u64 tmp = rate;
-		tmp *= m;
-		do_div(tmp, n);
-		rate = tmp;
-	}
+	if (mode)
+		rate = mult_frac(rate, m, n);
 
 	return rate;
 }
diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 245794485719..e9ed963f129d 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -792,7 +792,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index 467dadccde02..a68764cfb793 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2487,6 +2487,7 @@ static struct clk_branch fd_ahb_clk = {
 
 static struct clk_branch mnoc_ahb_clk = {
 	.halt_reg = 0x5024,
+	.halt_check = BRANCH_HALT_SKIP,
 	.clkr = {
 		.enable_reg = 0x5024,
 		.enable_mask = BIT(0),
@@ -2502,6 +2503,7 @@ static struct clk_branch mnoc_ahb_clk = {
 
 static struct clk_branch bimc_smmu_ahb_clk = {
 	.halt_reg = 0xe004,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0xe004,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -2519,6 +2521,7 @@ static struct clk_branch bimc_smmu_ahb_clk = {
 
 static struct clk_branch bimc_smmu_axi_clk = {
 	.halt_reg = 0xe008,
+	.halt_check = BRANCH_HALT_SKIP,
 	.hwcg_reg = 0xe008,
 	.hwcg_bit = 1,
 	.clkr = {
@@ -2659,11 +2662,13 @@ static struct gdsc camss_cpp_gdsc = {
 static struct gdsc bimc_smmu_gdsc = {
 	.gdscr = 0xe020,
 	.gds_hw_ctrl = 0xe024,
+	.cxcs = (unsigned int []){ 0xe008 },
+	.cxc_count = 1,
 	.pd = {
 		.name = "bimc_smmu",
 	},
 	.pwrsts = PWRSTS_OFF_ON,
-	.flags = HW_CTRL | ALWAYS_ON,
+	.flags = VOTABLE,
 };
 
 static struct clk_regmap *mmcc_msm8998_clocks[] = {
diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 1c92e73cd2b8..79e4e977b23b 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2015 Renesas Electronics Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
@@ -37,14 +38,13 @@
 #define WARN_DEBUG(x)	do { } while (0)
 #endif
 
-#define DIV_RSMASK(v, s, m)	((v >> s) & m)
 #define GET_SHIFT(val)		((val >> 12) & 0xff)
 #define GET_WIDTH(val)		((val >> 8) & 0xf)
 
-#define KDIV(val)		DIV_RSMASK(val, 16, 0xffff)
-#define MDIV(val)		DIV_RSMASK(val, 6, 0x3ff)
-#define PDIV(val)		DIV_RSMASK(val, 0, 0x3f)
-#define SDIV(val)		DIV_RSMASK(val, 0, 0x7)
+#define KDIV(val)		((s16)FIELD_GET(GENMASK(31, 16), val))
+#define MDIV(val)		FIELD_GET(GENMASK(15, 6), val)
+#define PDIV(val)		FIELD_GET(GENMASK(5, 0), val)
+#define SDIV(val)		FIELD_GET(GENMASK(2, 0), val)
 
 #define CLK_ON_R(reg)		(reg)
 #define CLK_MON_R(reg)		(0x180 + (reg))
@@ -146,18 +146,18 @@ static unsigned long rzg2l_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 	struct pll_clk *pll_clk = to_pll(hw);
 	struct rzg2l_cpg_priv *priv = pll_clk->priv;
 	unsigned int val1, val2;
-	unsigned int mult = 1;
-	unsigned int div = 1;
+	u64 rate;
 
 	if (pll_clk->type != CLK_TYPE_SAM_PLL)
 		return parent_rate;
 
 	val1 = readl(priv->base + GET_REG_SAMPLL_CLK1(pll_clk->conf));
 	val2 = readl(priv->base + GET_REG_SAMPLL_CLK2(pll_clk->conf));
-	mult = MDIV(val1) + KDIV(val1) / 65536;
-	div = PDIV(val1) * (1 << SDIV(val2));
 
-	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult, div);
+	rate = mul_u64_u32_shr(parent_rate, (MDIV(val1) << 16) + KDIV(val1),
+			       16 + SDIV(val2));
+
+	return DIV_ROUND_CLOSEST_ULL(rate, PDIV(val1));
 }
 
 static const struct clk_ops rzg2l_cpg_pll_ops = {
diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index ac5bc8857a51..f921c6812852 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -139,6 +139,7 @@ static void __init omap_clk_register_apll(void *user,
 	struct clk_hw *hw = user;
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *ad = clk_hw->dpll_data;
+	const char *name;
 	struct clk *clk;
 	const struct clk_init_data *init = clk_hw->hw.init;
 
@@ -166,7 +167,8 @@ static void __init omap_clk_register_apll(void *user,
 
 	ad->clk_bypass = __clk_get_hw(clk);
 
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, node->name);
+	name = ti_dt_clk_name(node);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(init->parent_names);
@@ -198,7 +200,7 @@ static void __init of_dra7_apll_setup(struct device_node *node)
 	clk_hw->dpll_data = ad;
 	clk_hw->hw.init = init;
 
-	init->name = node->name;
+	init->name = ti_dt_clk_name(node);
 	init->ops = &apll_ck_ops;
 
 	init->num_parents = of_clk_get_parent_count(node);
@@ -347,6 +349,7 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 	struct dpll_data *ad = NULL;
 	struct clk_hw_omap *clk_hw = NULL;
 	struct clk_init_data *init = NULL;
+	const char *name;
 	struct clk *clk;
 	const char *parent_name;
 	u32 val;
@@ -362,7 +365,8 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 	clk_hw->dpll_data = ad;
 	clk_hw->hw.init = init;
 	init->ops = &omap2_apll_ops;
-	init->name = node->name;
+	name = ti_dt_clk_name(node);
+	init->name = name;
 	clk_hw->ops = &omap2_apll_hwops;
 
 	init->num_parents = of_clk_get_parent_count(node);
@@ -403,7 +407,8 @@ static void __init of_omap2_apll_setup(struct device_node *node)
 	if (ret)
 		goto cleanup;
 
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, node->name);
+	name = ti_dt_clk_name(node);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		kfree(init);
diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index f6f8a409f148..d6e5f1511ace 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -205,7 +205,7 @@ int __init of_ti_clk_autoidle_setup(struct device_node *node)
 		return -ENOMEM;
 
 	clk->shift = shift;
-	clk->name = node->name;
+	clk->name = ti_dt_clk_name(node);
 	ret = ti_clk_get_reg_addr(node, 0, &clk->reg);
 	if (ret) {
 		kfree(clk);
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index e2e59d78c173..62508e74a47a 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -173,6 +173,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 	struct dra7_atl_desc *clk_hw = NULL;
 	struct clk_init_data init = { NULL };
 	const char **parent_names = NULL;
+	const char *name;
 	struct clk *clk;
 
 	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
@@ -183,7 +184,8 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 
 	clk_hw->hw.init = &init;
 	clk_hw->divider = 1;
-	init.name = node->name;
+	name = ti_dt_clk_name(node);
+	init.name = name;
 	init.ops = &atl_clk_ops;
 	init.flags = CLK_IGNORE_UNUSED;
 	init.num_parents = of_clk_get_parent_count(node);
@@ -203,7 +205,7 @@ static void __init of_dra7_atl_clock_setup(struct device_node *node)
 
 	init.parent_names = parent_names;
 
-	clk = ti_clk_register(NULL, &clk_hw->hw, node->name);
+	clk = of_ti_clk_register(node, &clk_hw->hw, name);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 29eafab4353e..6a39fb051b2e 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -402,6 +402,24 @@ static const struct of_device_id simple_clk_match_table[] __initconst = {
 	{ }
 };
 
+/**
+ * ti_dt_clk_name - init clock name from first output name or node name
+ * @np: device node
+ *
+ * Use the first clock-output-name for the clock name if found. Fall back
+ * to legacy naming based on node name.
+ */
+const char *ti_dt_clk_name(struct device_node *np)
+{
+	const char *name;
+
+	if (!of_property_read_string_index(np, "clock-output-names", 0,
+					   &name))
+		return name;
+
+	return np->name;
+}
+
 /**
  * ti_clk_add_aliases - setup clock aliases
  *
@@ -418,7 +436,7 @@ void __init ti_clk_add_aliases(void)
 		clkspec.np = np;
 		clk = of_clk_get_from_provider(&clkspec);
 
-		ti_clk_add_alias(NULL, clk, np->name);
+		ti_clk_add_alias(clk, ti_dt_clk_name(np));
 	}
 }
 
@@ -471,7 +489,6 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
 
 /**
  * ti_clk_add_alias - add a clock alias for a TI clock
- * @dev: device alias for this clock
  * @clk: clock handle to create alias for
  * @con: connection ID for this clock
  *
@@ -479,7 +496,7 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
  * and assigns the data to it. Returns 0 if successful, negative error
  * value otherwise.
  */
-int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
+int ti_clk_add_alias(struct clk *clk, const char *con)
 {
 	struct clk_lookup *cl;
 
@@ -493,8 +510,6 @@ int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
 	if (!cl)
 		return -ENOMEM;
 
-	if (dev)
-		cl->dev_id = dev_name(dev);
 	cl->con_id = con;
 	cl->clk = clk;
 
@@ -504,8 +519,8 @@ int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
 }
 
 /**
- * ti_clk_register - register a TI clock to the common clock framework
- * @dev: device for this clock
+ * of_ti_clk_register - register a TI clock to the common clock framework
+ * @node: device node for this clock
  * @hw: hardware clock handle
  * @con: connection ID for this clock
  *
@@ -513,17 +528,18 @@ int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
  * alias for it. Returns a handle to the registered clock if successful,
  * ERR_PTR value in failure.
  */
-struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
-			    const char *con)
+struct clk *of_ti_clk_register(struct device_node *node, struct clk_hw *hw,
+			       const char *con)
 {
 	struct clk *clk;
 	int ret;
 
-	clk = clk_register(dev, hw);
-	if (IS_ERR(clk))
-		return clk;
+	ret = of_clk_hw_register(node, hw);
+	if (ret)
+		return ERR_PTR(ret);
 
-	ret = ti_clk_add_alias(dev, clk, con);
+	clk = hw->clk;
+	ret = ti_clk_add_alias(clk, con);
 	if (ret) {
 		clk_unregister(clk);
 		return ERR_PTR(ret);
@@ -533,8 +549,8 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 }
 
 /**
- * ti_clk_register_omap_hw - register a clk_hw_omap to the clock framework
- * @dev: device for this clock
+ * of_ti_clk_register_omap_hw - register a clk_hw_omap to the clock framework
+ * @node: device node for this clock
  * @hw: hardware clock handle
  * @con: connection ID for this clock
  *
@@ -543,13 +559,13 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
  * Returns a handle to the registered clock if successful, ERR_PTR value
  * in failure.
  */
-struct clk *ti_clk_register_omap_hw(struct device *dev, struct clk_hw *hw,
-				    const char *con)
+struct clk *of_ti_clk_register_omap_hw(struct device_node *node,
+				       struct clk_hw *hw, const char *con)
 {
 	struct clk *clk;
 	struct clk_hw_omap *oclk;
 
-	clk = ti_clk_register(dev, hw, con);
+	clk = of_ti_clk_register(node, hw, con);
 	if (IS_ERR(clk))
 		return clk;
 
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 157abc46dcf4..1424b615a4cc 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -317,7 +317,7 @@ _ti_clkctrl_clk_register(struct omap_clkctrl_provider *provider,
 	init.ops = ops;
 	init.flags = 0;
 
-	clk = ti_clk_register(NULL, clk_hw, init.name);
+	clk = of_ti_clk_register(node, clk_hw, init.name);
 	if (IS_ERR_OR_NULL(clk)) {
 		ret = -EINVAL;
 		goto cleanup;
@@ -701,7 +701,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 		init.ops = &omap4_clkctrl_clk_ops;
 		hw->hw.init = &init;
 
-		clk = ti_clk_register_omap_hw(NULL, &hw->hw, init.name);
+		clk = of_ti_clk_register_omap_hw(node, &hw->hw, init.name);
 		if (IS_ERR_OR_NULL(clk))
 			goto cleanup;
 
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index f1dd62de2bfc..821f33ee330e 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -210,11 +210,12 @@ extern const struct omap_clkctrl_data dm816_clkctrl_data[];
 
 typedef void (*ti_of_clk_init_cb_t)(void *, struct device_node *);
 
-struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
-			    const char *con);
-struct clk *ti_clk_register_omap_hw(struct device *dev, struct clk_hw *hw,
-				    const char *con);
-int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con);
+struct clk *of_ti_clk_register(struct device_node *node, struct clk_hw *hw,
+			       const char *con);
+struct clk *of_ti_clk_register_omap_hw(struct device_node *node,
+				       struct clk_hw *hw, const char *con);
+const char *ti_dt_clk_name(struct device_node *np);
+int ti_clk_add_alias(struct clk *clk, const char *con);
 void ti_clk_add_aliases(void);
 
 void ti_clk_latch(struct clk_omap_reg *reg, s8 shift);
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 74831b2752b3..24179c907774 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -131,7 +131,7 @@ static void __init of_ti_clockdomain_setup(struct device_node *node)
 {
 	struct clk *clk;
 	struct clk_hw *clk_hw;
-	const char *clkdm_name = node->name;
+	const char *clkdm_name = ti_dt_clk_name(node);
 	int i;
 	unsigned int num_clks;
 
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index eaa43575cfa5..78d44158fb7d 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -125,6 +125,7 @@ static void __init _register_composite(void *user,
 	struct component_clk *comp;
 	int num_parents = 0;
 	const char **parent_names = NULL;
+	const char *name;
 	int i;
 	int ret;
 
@@ -172,7 +173,8 @@ static void __init _register_composite(void *user,
 		goto cleanup;
 	}
 
-	clk = clk_register_composite(NULL, node->name,
+	name = ti_dt_clk_name(node);
+	clk = clk_register_composite(NULL, name,
 				     parent_names, num_parents,
 				     _get_hw(cclk, CLK_COMPONENT_TYPE_MUX),
 				     &ti_clk_mux_ops,
@@ -182,7 +184,7 @@ static void __init _register_composite(void *user,
 				     &ti_composite_gate_ops, 0);
 
 	if (!IS_ERR(clk)) {
-		ret = ti_clk_add_alias(NULL, clk, node->name);
+		ret = ti_clk_add_alias(clk, name);
 		if (ret) {
 			clk_unregister(clk);
 			goto cleanup;
diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 28080df92f72..4cc0aaa6cb13 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -317,13 +317,14 @@ static struct clk *_register_divider(struct device_node *node,
 				     u32 flags,
 				     struct clk_omap_divider *div)
 {
-	struct clk *clk;
 	struct clk_init_data init;
 	const char *parent_name;
+	const char *name;
 
 	parent_name = of_clk_get_parent_name(node, 0);
 
-	init.name = node->name;
+	name = ti_dt_clk_name(node);
+	init.name = name;
 	init.ops = &ti_clk_divider_ops;
 	init.flags = flags;
 	init.parent_names = (parent_name ? &parent_name : NULL);
@@ -332,12 +333,7 @@ static struct clk *_register_divider(struct device_node *node,
 	div->hw.init = &init;
 
 	/* register the clock */
-	clk = ti_clk_register(NULL, &div->hw, node->name);
-
-	if (IS_ERR(clk))
-		kfree(div);
-
-	return clk;
+	return of_ti_clk_register(node, &div->hw, name);
 }
 
 int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index e9f9aee936ae..9ef7133f2f57 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -164,6 +164,7 @@ static void __init _register_dpll(void *user,
 	struct clk_hw *hw = user;
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *dd = clk_hw->dpll_data;
+	const char *name;
 	struct clk *clk;
 	const struct clk_init_data *init = hw->init;
 
@@ -193,7 +194,8 @@ static void __init _register_dpll(void *user,
 	dd->clk_bypass = __clk_get_hw(clk);
 
 	/* register the clock */
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, node->name);
+	name = ti_dt_clk_name(node);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
@@ -227,7 +229,7 @@ static void _register_dpll_x2(struct device_node *node,
 	struct clk *clk;
 	struct clk_init_data init = { NULL };
 	struct clk_hw_omap *clk_hw;
-	const char *name = node->name;
+	const char *name = ti_dt_clk_name(node);
 	const char *parent_name;
 
 	parent_name = of_clk_get_parent_name(node, 0);
@@ -265,7 +267,7 @@ static void _register_dpll_x2(struct device_node *node,
 #endif
 
 	/* register the clock */
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
@@ -304,7 +306,7 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	clk_hw->ops = &clkhwops_omap3_dpll;
 	clk_hw->hw.init = init;
 
-	init->name = node->name;
+	init->name = ti_dt_clk_name(node);
 	init->ops = ops;
 
 	init->num_parents = of_clk_get_parent_count(node);
diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 8024c6d2b9e9..749c6b73abff 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -19,6 +19,8 @@
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
 
+#include "clock.h"
+
 /* FAPLL Control Register PLL_CTRL */
 #define FAPLL_MAIN_MULT_N_SHIFT	16
 #define FAPLL_MAIN_DIV_P_SHIFT	8
@@ -542,6 +544,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 	struct clk_init_data *init = NULL;
 	const char *parent_name[2];
 	struct clk *pll_clk;
+	const char *name;
 	int i;
 
 	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
@@ -559,7 +562,8 @@ static void __init ti_fapll_setup(struct device_node *node)
 		goto free;
 
 	init->ops = &ti_fapll_ops;
-	init->name = node->name;
+	name = ti_dt_clk_name(node);
+	init->name = name;
 
 	init->num_parents = of_clk_get_parent_count(node);
 	if (init->num_parents != 2) {
@@ -591,7 +595,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 	if (fapll_is_ddr_pll(fd->base))
 		fd->bypass_bit_inverted = true;
 
-	fd->name = node->name;
+	fd->name = name;
 	fd->hw.init = init;
 
 	/* Register the parent PLL */
@@ -638,8 +642,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 				freq = NULL;
 		}
 		synth_clk = ti_fapll_synth_setup(fd, freq, div, output_instance,
-						 output_name, node->name,
-						 pll_clk);
+						 output_name, name, pll_clk);
 		if (IS_ERR(synth_clk))
 			continue;
 
diff --git a/drivers/clk/ti/fixed-factor.c b/drivers/clk/ti/fixed-factor.c
index 7cbe896db071..a4f9c1c15613 100644
--- a/drivers/clk/ti/fixed-factor.c
+++ b/drivers/clk/ti/fixed-factor.c
@@ -36,7 +36,7 @@
 static void __init of_ti_fixed_factor_clk_setup(struct device_node *node)
 {
 	struct clk *clk;
-	const char *clk_name = node->name;
+	const char *clk_name = ti_dt_clk_name(node);
 	const char *parent_name;
 	u32 div, mult;
 	u32 flags = 0;
@@ -62,7 +62,7 @@ static void __init of_ti_fixed_factor_clk_setup(struct device_node *node)
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		of_ti_clk_autoidle_setup(node);
-		ti_clk_add_alias(NULL, clk, clk_name);
+		ti_clk_add_alias(clk, clk_name);
 	}
 }
 CLK_OF_DECLARE(ti_fixed_factor_clk, "ti,fixed-factor-clock",
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index b1d0fdb40a75..b0d9d357861c 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -93,7 +93,7 @@ static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *hw)
 	return ret;
 }
 
-static struct clk *_register_gate(struct device *dev, const char *name,
+static struct clk *_register_gate(struct device_node *node, const char *name,
 				  const char *parent_name, unsigned long flags,
 				  struct clk_omap_reg *reg, u8 bit_idx,
 				  u8 clk_gate_flags, const struct clk_ops *ops,
@@ -123,7 +123,7 @@ static struct clk *_register_gate(struct device *dev, const char *name,
 
 	init.flags = flags;
 
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
@@ -138,6 +138,7 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 	struct clk *clk;
 	const char *parent_name;
 	struct clk_omap_reg reg;
+	const char *name;
 	u8 enable_bit = 0;
 	u32 val;
 	u32 flags = 0;
@@ -164,7 +165,8 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 	if (of_property_read_bool(node, "ti,set-bit-to-disable"))
 		clk_gate_flags |= INVERT_ENABLE;
 
-	clk = _register_gate(NULL, node->name, parent_name, flags, &reg,
+	name = ti_dt_clk_name(node);
+	clk = _register_gate(node, name, parent_name, flags, &reg,
 			     enable_bit, clk_gate_flags, ops, hw_ops);
 
 	if (!IS_ERR(clk))
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index 83e34429d3b1..1ccd5dbf2bb4 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -32,7 +32,8 @@ static const struct clk_ops ti_interface_clk_ops = {
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
 };
 
-static struct clk *_register_interface(struct device *dev, const char *name,
+static struct clk *_register_interface(struct device_node *node,
+				       const char *name,
 				       const char *parent_name,
 				       struct clk_omap_reg *reg, u8 bit_idx,
 				       const struct clk_hw_omap_ops *ops)
@@ -57,7 +58,7 @@ static struct clk *_register_interface(struct device *dev, const char *name,
 	init.num_parents = 1;
 	init.parent_names = &parent_name;
 
-	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, name);
+	clk = of_ti_clk_register_omap_hw(node, &clk_hw->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(clk_hw);
@@ -72,6 +73,7 @@ static void __init _of_ti_interface_clk_setup(struct device_node *node,
 	const char *parent_name;
 	struct clk_omap_reg reg;
 	u8 enable_bit = 0;
+	const char *name;
 	u32 val;
 
 	if (ti_clk_get_reg_addr(node, 0, &reg))
@@ -86,7 +88,8 @@ static void __init _of_ti_interface_clk_setup(struct device_node *node,
 		return;
 	}
 
-	clk = _register_interface(NULL, node->name, parent_name, &reg,
+	name = ti_dt_clk_name(node);
+	clk = _register_interface(node, name, parent_name, &reg,
 				  enable_bit, ops);
 
 	if (!IS_ERR(clk))
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 0069e7cf3ebc..4205ff4bad21 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -126,7 +126,7 @@ const struct clk_ops ti_clk_mux_ops = {
 	.restore_context = clk_mux_restore_context,
 };
 
-static struct clk *_register_mux(struct device *dev, const char *name,
+static struct clk *_register_mux(struct device_node *node, const char *name,
 				 const char * const *parent_names,
 				 u8 num_parents, unsigned long flags,
 				 struct clk_omap_reg *reg, u8 shift, u32 mask,
@@ -156,7 +156,7 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 	mux->table = table;
 	mux->hw.init = &init;
 
-	clk = ti_clk_register(dev, &mux->hw, name);
+	clk = of_ti_clk_register(node, &mux->hw, name);
 
 	if (IS_ERR(clk))
 		kfree(mux);
@@ -176,6 +176,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	struct clk_omap_reg reg;
 	unsigned int num_parents;
 	const char **parent_names;
+	const char *name;
 	u8 clk_mux_flags = 0;
 	u32 mask = 0;
 	u32 shift = 0;
@@ -213,7 +214,8 @@ static void of_mux_clk_setup(struct device_node *node)
 
 	mask = (1 << fls(mask)) - 1;
 
-	clk = _register_mux(NULL, node->name, parent_names, num_parents,
+	name = ti_dt_clk_name(node);
+	clk = _register_mux(node, name, parent_names, num_parents,
 			    flags, &reg, shift, mask, latch, clk_mux_flags,
 			    NULL);
 
diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index d3d8bb0a6990..e156238b4da9 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -566,7 +566,8 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 	if (keylen != CHACHA_KEY_SIZE + saltlen)
 		return -EINVAL;
 
-	ctx->cdata.key_virt = key;
+	memcpy(ctx->key, key, keylen);
+	ctx->cdata.key_virt = ctx->key;
 	ctx->cdata.keylen = keylen - saltlen;
 
 	return chachapoly_set_sh_desc(aead);
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 6753f0e6e55d..35c4e29033d5 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -639,7 +639,8 @@ static int chachapoly_setkey(struct crypto_aead *aead, const u8 *key,
 	if (keylen != CHACHA_KEY_SIZE + saltlen)
 		return -EINVAL;
 
-	ctx->cdata.key_virt = key;
+	memcpy(ctx->key, key, keylen);
+	ctx->cdata.key_virt = ctx->key;
 	ctx->cdata.keylen = keylen - saltlen;
 
 	return chachapoly_set_sh_desc(aead);
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index edc61e4105f3..08e56f1da365 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -854,7 +854,7 @@ static int hpre_cluster_debugfs_init(struct hisi_qm *qm)
 
 	for (i = 0; i < clusters_num; i++) {
 		ret = snprintf(buf, HPRE_DBGFS_VAL_MAX_LEN, "cluster%d", i);
-		if (ret < 0)
+		if (ret >= HPRE_DBGFS_VAL_MAX_LEN)
 			return -EINVAL;
 		tmp_d = debugfs_create_dir(buf, qm->debug.debug_root);
 
diff --git a/drivers/crypto/qat/qat_common/adf_accel_devices.h b/drivers/crypto/qat/qat_common/adf_accel_devices.h
index 580566cfcb04..3bb67b22edd6 100644
--- a/drivers/crypto/qat/qat_common/adf_accel_devices.h
+++ b/drivers/crypto/qat/qat_common/adf_accel_devices.h
@@ -24,7 +24,7 @@
 #define ADF_PCI_MAX_BARS 3
 #define ADF_DEVICE_NAME_LENGTH 32
 #define ADF_ETR_MAX_RINGS_PER_BANK 16
-#define ADF_MAX_MSIX_VECTOR_NAME 16
+#define ADF_MAX_MSIX_VECTOR_NAME 48
 #define ADF_DEVICE_NAME_PREFIX "qat_"
 
 enum adf_accel_capabilities {
diff --git a/drivers/crypto/qat/qat_common/adf_transport_debug.c b/drivers/crypto/qat/qat_common/adf_transport_debug.c
index e69e5907f595..006867f410bd 100644
--- a/drivers/crypto/qat/qat_common/adf_transport_debug.c
+++ b/drivers/crypto/qat/qat_common/adf_transport_debug.c
@@ -90,7 +90,7 @@ DEFINE_SEQ_ATTRIBUTE(adf_ring_debug);
 int adf_ring_debugfs_add(struct adf_etr_ring_data *ring, const char *name)
 {
 	struct adf_etr_ring_debug_entry *ring_debug;
-	char entry_name[8];
+	char entry_name[16];
 
 	ring_debug = kzalloc(sizeof(*ring_debug), GFP_KERNEL);
 	if (!ring_debug)
@@ -192,7 +192,7 @@ int adf_bank_debugfs_add(struct adf_etr_bank_data *bank)
 {
 	struct adf_accel_dev *accel_dev = bank->accel_dev;
 	struct dentry *parent = accel_dev->transport->debug;
-	char name[8];
+	char name[16];
 
 	snprintf(name, sizeof(name), "bank_%02d", bank->bank_number);
 	bank->bank_debug_dir = debugfs_create_dir(name, parent);
diff --git a/drivers/crypto/qat/qat_common/qat_algs_send.c b/drivers/crypto/qat/qat_common/qat_algs_send.c
index ff5b4347f783..607ed88f4b19 100644
--- a/drivers/crypto/qat/qat_common/qat_algs_send.c
+++ b/drivers/crypto/qat/qat_common/qat_algs_send.c
@@ -39,40 +39,44 @@ void qat_alg_send_backlog(struct qat_instance_backlog *backlog)
 	spin_unlock_bh(&backlog->lock);
 }
 
-static void qat_alg_backlog_req(struct qat_alg_req *req,
-				struct qat_instance_backlog *backlog)
-{
-	INIT_LIST_HEAD(&req->list);
-
-	spin_lock_bh(&backlog->lock);
-	list_add_tail(&req->list, &backlog->list);
-	spin_unlock_bh(&backlog->lock);
-}
-
-static int qat_alg_send_message_maybacklog(struct qat_alg_req *req)
+static bool qat_alg_try_enqueue(struct qat_alg_req *req)
 {
 	struct qat_instance_backlog *backlog = req->backlog;
 	struct adf_etr_ring_data *tx_ring = req->tx_ring;
 	u32 *fw_req = req->fw_req;
 
-	/* If any request is already backlogged, then add to backlog list */
+	/* Check if any request is already backlogged */
 	if (!list_empty(&backlog->list))
-		goto enqueue;
+		return false;
 
-	/* If ring is nearly full, then add to backlog list */
+	/* Check if ring is nearly full */
 	if (adf_ring_nearly_full(tx_ring))
-		goto enqueue;
+		return false;
 
-	/* If adding request to HW ring fails, then add to backlog list */
+	/* Try to enqueue to HW ring */
 	if (adf_send_message(tx_ring, fw_req))
-		goto enqueue;
+		return false;
 
-	return -EINPROGRESS;
+	return true;
+}
 
-enqueue:
-	qat_alg_backlog_req(req, backlog);
 
-	return -EBUSY;
+static int qat_alg_send_message_maybacklog(struct qat_alg_req *req)
+{
+	struct qat_instance_backlog *backlog = req->backlog;
+	int ret = -EINPROGRESS;
+
+	if (qat_alg_try_enqueue(req))
+		return ret;
+
+	spin_lock_bh(&backlog->lock);
+	if (!qat_alg_try_enqueue(req)) {
+		list_add_tail(&req->list, &backlog->list);
+		ret = -EBUSY;
+	}
+	spin_unlock_bh(&backlog->lock);
+
+	return ret;
 }
 
 int qat_alg_send_message(struct qat_alg_req *req)
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a9c317e32010..6673198870fe 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -139,10 +139,9 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	struct cdev *cdev = &cxlmd->cdev;
 	const struct cdevm_file_operations *cdevm_fops;
 
+	cdev_device_del(&cxlmd->cdev, dev);
 	cdevm_fops = container_of(cdev->ops, typeof(*cdevm_fops), fops);
 	cdevm_fops->shutdown(dev);
-
-	cdev_device_del(&cxlmd->cdev, dev);
 	put_device(dev);
 }
 
diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 9a88faaf8b27..4dafdf23197b 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -194,14 +194,15 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 		return PTR_ERR(data->clk);
 	}
 
-	/* try to find the optional reference to the pmu syscon */
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
-	if (node) {
-		data->regmap_pmu = syscon_node_to_regmap(node);
-		of_node_put(node);
-		if (IS_ERR(data->regmap_pmu))
-			return PTR_ERR(data->regmap_pmu);
-	}
+	if (!node)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Can't find pmu_grf registers\n");
+
+	data->regmap_pmu = syscon_node_to_regmap(node);
+	of_node_put(node);
+	if (IS_ERR(data->regmap_pmu))
+		return PTR_ERR(data->regmap_pmu);
+
 	data->dev = dev;
 
 	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);
diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index a1e9f2b3a37c..817ffa95a9b1 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,12 +1,12 @@
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=IDXD
 
+obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
+idxd_bus-y := bus.o
+
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
 idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o
 
 idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
 
-obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
-idxd_bus-y := bus.o
-
 obj-$(CONFIG_INTEL_IDXD_COMPAT) += idxd_compat.o
 idxd_compat-y := compat.o
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index e613ace79ea8..2731dc27f9d7 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -722,7 +722,6 @@ static void pxad_free_desc(struct virt_dma_desc *vd)
 	dma_addr_t dma;
 	struct pxad_desc_sw *sw_desc = to_pxad_sw_desc(vd);
 
-	BUG_ON(sw_desc->nb_desc == 0);
 	for (i = sw_desc->nb_desc - 1; i >= 0; i--) {
 		if (i > 0)
 			dma = sw_desc->hw_desc[i - 1]->ddadr;
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 35d81bd857f1..a1adc8d91fd8 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2459,7 +2459,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 0);
 
-	if (irq >= 0) {
+	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
@@ -2475,7 +2475,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 2);
 
-	if (irq >= 0) {
+	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index edef31c41312..f79ba6f733ba 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -192,6 +192,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id)
 	dev->release = ffa_release_device;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
+	ffa_dev->id = id;
 	ffa_dev->vm_id = vm_id;
 	uuid_copy(&ffa_dev->uuid, uuid);
 
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 235c7e7869aa..c2fafe49c2e8 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -190,19 +190,6 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
 	return 0;
 }
 
-/**
- * ti_sci_debugfs_destroy() - clean up log debug file
- * @pdev:	platform device pointer
- * @info:	Pointer to SCI entity information
- */
-static void ti_sci_debugfs_destroy(struct platform_device *pdev,
-				   struct ti_sci_info *info)
-{
-	if (IS_ERR(info->debug_region))
-		return;
-
-	debugfs_remove(info->d);
-}
 #else /* CONFIG_DEBUG_FS */
 static inline int ti_sci_debugfs_create(struct platform_device *dev,
 					struct ti_sci_info *info)
@@ -3435,43 +3422,12 @@ static int ti_sci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_sci_remove(struct platform_device *pdev)
-{
-	struct ti_sci_info *info;
-	struct device *dev = &pdev->dev;
-	int ret = 0;
-
-	of_platform_depopulate(dev);
-
-	info = platform_get_drvdata(pdev);
-
-	if (info->nb.notifier_call)
-		unregister_restart_handler(&info->nb);
-
-	mutex_lock(&ti_sci_list_mutex);
-	if (info->users)
-		ret = -EBUSY;
-	else
-		list_del(&info->node);
-	mutex_unlock(&ti_sci_list_mutex);
-
-	if (!ret) {
-		ti_sci_debugfs_destroy(pdev, info);
-
-		/* Safe to free channels since no more users */
-		mbox_free_channel(info->chan_tx);
-		mbox_free_channel(info->chan_rx);
-	}
-
-	return ret;
-}
-
 static struct platform_driver ti_sci_driver = {
 	.probe = ti_sci_probe,
-	.remove = ti_sci_remove,
 	.driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
+		   .suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(ti_sci_driver);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 22a70aaccf13..86135ca33e5b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -433,11 +433,11 @@ svm_range_validate_svm_bo(struct amdgpu_device *adev, struct svm_range *prange)
 
 	/* We need a new svm_bo. Spin-loop to wait for concurrent
 	 * svm_range_bo_release to finish removing this range from
-	 * its range list. After this, it is safe to reuse the
-	 * svm_bo pointer and svm_bo_list head.
+	 * its range list and set prange->svm_bo to null. After this,
+	 * it is safe to reuse the svm_bo pointer and svm_bo_list head.
 	 */
-	while (!list_empty_careful(&prange->svm_bo_list))
-		;
+	while (!list_empty_careful(&prange->svm_bo_list) || prange->svm_bo)
+		cond_resched();
 
 	return false;
 }
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index d3fd76a0a34a..6891863ed510 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -43,7 +43,6 @@ struct lt8912 {
 
 	u8 data_lanes;
 	bool is_power_on;
-	bool is_attached;
 };
 
 static int lt8912_write_init_config(struct lt8912 *lt)
@@ -481,11 +480,11 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 		return -EPROBE_DEFER;
 	}
 
-	dsi = mipi_dsi_device_register_full(host, &info);
+	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
 		ret = PTR_ERR(dsi);
 		dev_err(dev, "failed to create dsi device (%d)\n", ret);
-		goto err_dsi_device;
+		return ret;
 	}
 
 	lt->dsi = dsi;
@@ -497,24 +496,21 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 			  MIPI_DSI_MODE_LPM |
 			  MIPI_DSI_MODE_NO_EOT_PACKET;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "failed to attach dsi to host\n");
-		goto err_dsi_attach;
+		return ret;
 	}
 
 	return 0;
-
-err_dsi_attach:
-	mipi_dsi_device_unregister(dsi);
-err_dsi_device:
-	return ret;
 }
 
-static void lt8912_detach_dsi(struct lt8912 *lt)
+static void lt8912_bridge_hpd_cb(void *data, enum drm_connector_status status)
 {
-	mipi_dsi_detach(lt->dsi);
-	mipi_dsi_device_unregister(lt->dsi);
+	struct lt8912 *lt = data;
+
+	if (lt->bridge.dev)
+		drm_helper_hpd_irq_event(lt->bridge.dev);
 }
 
 static int lt8912_bridge_connector_init(struct drm_bridge *bridge)
@@ -523,8 +519,13 @@ static int lt8912_bridge_connector_init(struct drm_bridge *bridge)
 	struct lt8912 *lt = bridge_to_lt8912(bridge);
 	struct drm_connector *connector = &lt->connector;
 
-	connector->polled = DRM_CONNECTOR_POLL_CONNECT |
-			    DRM_CONNECTOR_POLL_DISCONNECT;
+	if (lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD) {
+		drm_bridge_hpd_enable(lt->hdmi_port, lt8912_bridge_hpd_cb, lt);
+		connector->polled = DRM_CONNECTOR_POLL_HPD;
+	} else {
+		connector->polled = DRM_CONNECTOR_POLL_CONNECT |
+				    DRM_CONNECTOR_POLL_DISCONNECT;
+	}
 
 	ret = drm_connector_init(bridge->dev, connector,
 				 &lt8912_connector_funcs,
@@ -547,6 +548,13 @@ static int lt8912_bridge_attach(struct drm_bridge *bridge,
 	struct lt8912 *lt = bridge_to_lt8912(bridge);
 	int ret;
 
+	ret = drm_bridge_attach(bridge->encoder, lt->hdmi_port, bridge,
+				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+	if (ret < 0) {
+		dev_err(lt->dev, "Failed to attach next bridge (%d)\n", ret);
+		return ret;
+	}
+
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
 		ret = lt8912_bridge_connector_init(bridge);
 		if (ret) {
@@ -563,12 +571,6 @@ static int lt8912_bridge_attach(struct drm_bridge *bridge,
 	if (ret)
 		goto error;
 
-	ret = lt8912_attach_dsi(lt);
-	if (ret)
-		goto error;
-
-	lt->is_attached = true;
-
 	return 0;
 
 error:
@@ -580,12 +582,10 @@ static void lt8912_bridge_detach(struct drm_bridge *bridge)
 {
 	struct lt8912 *lt = bridge_to_lt8912(bridge);
 
-	if (lt->is_attached) {
-		lt8912_detach_dsi(lt);
-		lt8912_hard_power_off(lt);
-		drm_connector_unregister(&lt->connector);
-		drm_connector_cleanup(&lt->connector);
-	}
+	lt8912_hard_power_off(lt);
+
+	if (lt->connector.dev && lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD)
+		drm_bridge_hpd_disable(lt->hdmi_port);
 }
 
 static enum drm_connector_status
@@ -726,8 +726,15 @@ static int lt8912_probe(struct i2c_client *client,
 
 	drm_bridge_add(&lt->bridge);
 
+	ret = lt8912_attach_dsi(lt);
+	if (ret)
+		goto err_attach;
+
 	return 0;
 
+err_attach:
+	drm_bridge_remove(&lt->bridge);
+	lt8912_free_i2c(lt);
 err_i2c:
 	lt8912_put_dt(lt);
 err_dt_parse:
@@ -738,7 +745,6 @@ static int lt8912_remove(struct i2c_client *client)
 {
 	struct lt8912 *lt = i2c_get_clientdata(client);
 
-	lt8912_bridge_detach(&lt->bridge);
 	drm_bridge_remove(&lt->bridge);
 	lt8912_free_i2c(lt);
 	lt8912_put_dt(lt);
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index c4454d0f6cad..2a848e14181b 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -258,17 +258,18 @@ static struct mipi_dsi_device *lt9611uxc_attach_dsi(struct lt9611uxc *lt9611uxc,
 	const struct mipi_dsi_device_info info = { "lt9611uxc", 0, NULL };
 	struct mipi_dsi_device *dsi;
 	struct mipi_dsi_host *host;
+	struct device *dev = lt9611uxc->dev;
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
 	if (!host) {
-		dev_err(lt9611uxc->dev, "failed to find dsi host\n");
+		dev_err(dev, "failed to find dsi host\n");
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	dsi = mipi_dsi_device_register_full(host, &info);
+	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
-		dev_err(lt9611uxc->dev, "failed to create dsi device\n");
+		dev_err(dev, "failed to create dsi device\n");
 		return dsi;
 	}
 
@@ -277,10 +278,9 @@ static struct mipi_dsi_device *lt9611uxc_attach_dsi(struct lt9611uxc *lt9611uxc,
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 			  MIPI_DSI_MODE_VIDEO_HSE;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
-		dev_err(lt9611uxc->dev, "failed to attach dsi to host\n");
-		mipi_dsi_device_unregister(dsi);
+		dev_err(dev, "failed to attach dsi to host\n");
 		return ERR_PTR(ret);
 	}
 
@@ -355,19 +355,6 @@ static int lt9611uxc_connector_init(struct drm_bridge *bridge, struct lt9611uxc
 	return drm_connector_attach_encoder(&lt9611uxc->connector, bridge->encoder);
 }
 
-static void lt9611uxc_bridge_detach(struct drm_bridge *bridge)
-{
-	struct lt9611uxc *lt9611uxc = bridge_to_lt9611uxc(bridge);
-
-	if (lt9611uxc->dsi1) {
-		mipi_dsi_detach(lt9611uxc->dsi1);
-		mipi_dsi_device_unregister(lt9611uxc->dsi1);
-	}
-
-	mipi_dsi_detach(lt9611uxc->dsi0);
-	mipi_dsi_device_unregister(lt9611uxc->dsi0);
-}
-
 static int lt9611uxc_bridge_attach(struct drm_bridge *bridge,
 				   enum drm_bridge_attach_flags flags)
 {
@@ -380,27 +367,7 @@ static int lt9611uxc_bridge_attach(struct drm_bridge *bridge,
 			return ret;
 	}
 
-	/* Attach primary DSI */
-	lt9611uxc->dsi0 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi0_node);
-	if (IS_ERR(lt9611uxc->dsi0))
-		return PTR_ERR(lt9611uxc->dsi0);
-
-	/* Attach secondary DSI, if specified */
-	if (lt9611uxc->dsi1_node) {
-		lt9611uxc->dsi1 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi1_node);
-		if (IS_ERR(lt9611uxc->dsi1)) {
-			ret = PTR_ERR(lt9611uxc->dsi1);
-			goto err_unregister_dsi0;
-		}
-	}
-
 	return 0;
-
-err_unregister_dsi0:
-	mipi_dsi_detach(lt9611uxc->dsi0);
-	mipi_dsi_device_unregister(lt9611uxc->dsi0);
-
-	return ret;
 }
 
 static enum drm_mode_status
@@ -544,7 +511,6 @@ static struct edid *lt9611uxc_bridge_get_edid(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs lt9611uxc_bridge_funcs = {
 	.attach = lt9611uxc_bridge_attach,
-	.detach = lt9611uxc_bridge_detach,
 	.mode_valid = lt9611uxc_bridge_mode_valid,
 	.mode_set = lt9611uxc_bridge_mode_set,
 	.detect = lt9611uxc_bridge_detect,
@@ -961,9 +927,9 @@ static int lt9611uxc_probe(struct i2c_client *client,
 	init_waitqueue_head(&lt9611uxc->wq);
 	INIT_WORK(&lt9611uxc->work, lt9611uxc_hpd_work);
 
-	ret = devm_request_threaded_irq(dev, client->irq, NULL,
-					lt9611uxc_irq_thread_handler,
-					IRQF_ONESHOT, "lt9611uxc", lt9611uxc);
+	ret = request_threaded_irq(client->irq, NULL,
+				   lt9611uxc_irq_thread_handler,
+				   IRQF_ONESHOT, "lt9611uxc", lt9611uxc);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
 		goto err_disable_regulators;
@@ -980,8 +946,29 @@ static int lt9611uxc_probe(struct i2c_client *client,
 
 	drm_bridge_add(&lt9611uxc->bridge);
 
+	/* Attach primary DSI */
+	lt9611uxc->dsi0 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi0_node);
+	if (IS_ERR(lt9611uxc->dsi0)) {
+		ret = PTR_ERR(lt9611uxc->dsi0);
+		goto err_remove_bridge;
+	}
+
+	/* Attach secondary DSI, if specified */
+	if (lt9611uxc->dsi1_node) {
+		lt9611uxc->dsi1 = lt9611uxc_attach_dsi(lt9611uxc, lt9611uxc->dsi1_node);
+		if (IS_ERR(lt9611uxc->dsi1)) {
+			ret = PTR_ERR(lt9611uxc->dsi1);
+			goto err_remove_bridge;
+		}
+	}
+
 	return lt9611uxc_audio_init(dev, lt9611uxc);
 
+err_remove_bridge:
+	free_irq(client->irq, lt9611uxc);
+	cancel_work_sync(&lt9611uxc->work);
+	drm_bridge_remove(&lt9611uxc->bridge);
+
 err_disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(lt9611uxc->supplies), lt9611uxc->supplies);
 
@@ -996,7 +983,7 @@ static int lt9611uxc_remove(struct i2c_client *client)
 {
 	struct lt9611uxc *lt9611uxc = i2c_get_clientdata(client);
 
-	disable_irq(client->irq);
+	free_irq(client->irq, lt9611uxc);
 	cancel_work_sync(&lt9611uxc->work);
 	lt9611uxc_audio_exit(lt9611uxc);
 	drm_bridge_remove(&lt9611uxc->bridge);
diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 8b1bdffc5005..d81c35a85330 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -217,6 +217,10 @@ static void tc358768_update_bits(struct tc358768_priv *priv, u32 reg, u32 mask,
 	u32 tmp, orig;
 
 	tc358768_read(priv, reg, &orig);
+
+	if (priv->error)
+		return;
+
 	tmp = orig & ~mask;
 	tmp |= val & mask;
 	if (tmp != orig)
@@ -633,6 +637,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 {
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
 	struct mipi_dsi_device *dsi_dev = priv->output.dev;
+	unsigned long mode_flags = dsi_dev->mode_flags;
 	u32 val, val2, lptxcnt, hact, data_type;
 	s32 raw_val;
 	const struct drm_display_mode *mode;
@@ -640,6 +645,11 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	u32 dsiclk, dsibclk;
 	int ret, i;
 
+	if (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
+		dev_warn_once(priv->dev, "Non-continuous mode unimplemented, falling back to continuous\n");
+		mode_flags &= ~MIPI_DSI_CLOCK_NON_CONTINUOUS;
+	}
+
 	tc358768_hw_enable(priv);
 
 	ret = tc358768_sw_reset(priv);
@@ -775,8 +785,8 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		val |= BIT(i + 1);
 	tc358768_write(priv, TC358768_HSTXVREGEN, val);
 
-	if (!(dsi_dev->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
-		tc358768_write(priv, TC358768_TXOPTIONCNTRL, 0x1);
+	tc358768_write(priv, TC358768_TXOPTIONCNTRL,
+		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
 
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
 	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
@@ -812,11 +822,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	tc358768_write(priv, TC358768_DSI_HACT, hact);
 
 	/* VSYNC polarity */
-	if (!(mode->flags & DRM_MODE_FLAG_NVSYNC))
-		tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5), BIT(5));
+	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5),
+			     (mode->flags & DRM_MODE_FLAG_PVSYNC) ? BIT(5) : 0);
+
 	/* HSYNC polarity */
-	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
-		tc358768_update_bits(priv, TC358768_PP_MISC, BIT(0), BIT(0));
+	tc358768_update_bits(priv, TC358768_PP_MISC, BIT(0),
+			     (mode->flags & DRM_MODE_FLAG_PHSYNC) ? BIT(0) : 0);
 
 	/* Start DSI Tx */
 	tc358768_write(priv, TC358768_DSI_START, 0x1);
@@ -832,7 +843,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	val |= TC358768_DSI_CONTROL_TXMD;
 
-	if (!(dsi_dev->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
+	if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
 		val |= TC358768_DSI_CONTROL_HSCKMD;
 
 	if (dsi_dev->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 0c806e99e869..d98b08c65db9 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -246,6 +246,52 @@ void mipi_dsi_device_unregister(struct mipi_dsi_device *dsi)
 }
 EXPORT_SYMBOL(mipi_dsi_device_unregister);
 
+static void devm_mipi_dsi_device_unregister(void *arg)
+{
+	struct mipi_dsi_device *dsi = arg;
+
+	mipi_dsi_device_unregister(dsi);
+}
+
+/**
+ * devm_mipi_dsi_device_register_full - create a managed MIPI DSI device
+ * @dev: device to tie the MIPI-DSI device lifetime to
+ * @host: DSI host to which this device is connected
+ * @info: pointer to template containing DSI device information
+ *
+ * Create a MIPI DSI device by using the device information provided by
+ * mipi_dsi_device_info template
+ *
+ * This is the managed version of mipi_dsi_device_register_full() which
+ * automatically calls mipi_dsi_device_unregister() when @dev is
+ * unbound.
+ *
+ * Returns:
+ * A pointer to the newly created MIPI DSI device, or, a pointer encoded
+ * with an error
+ */
+struct mipi_dsi_device *
+devm_mipi_dsi_device_register_full(struct device *dev,
+				   struct mipi_dsi_host *host,
+				   const struct mipi_dsi_device_info *info)
+{
+	struct mipi_dsi_device *dsi;
+	int ret;
+
+	dsi = mipi_dsi_device_register_full(host, info);
+	if (IS_ERR(dsi))
+		return dsi;
+
+	ret = devm_add_action_or_reset(dev,
+				       devm_mipi_dsi_device_unregister,
+				       dsi);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return dsi;
+}
+EXPORT_SYMBOL_GPL(devm_mipi_dsi_device_register_full);
+
 static DEFINE_MUTEX(host_lock);
 static LIST_HEAD(host_list);
 
@@ -346,6 +392,41 @@ int mipi_dsi_detach(struct mipi_dsi_device *dsi)
 }
 EXPORT_SYMBOL(mipi_dsi_detach);
 
+static void devm_mipi_dsi_detach(void *arg)
+{
+	struct mipi_dsi_device *dsi = arg;
+
+	mipi_dsi_detach(dsi);
+}
+
+/**
+ * devm_mipi_dsi_attach - Attach a MIPI-DSI device to its DSI Host
+ * @dev: device to tie the MIPI-DSI device attachment lifetime to
+ * @dsi: DSI peripheral
+ *
+ * This is the managed version of mipi_dsi_attach() which automatically
+ * calls mipi_dsi_detach() when @dev is unbound.
+ *
+ * Returns:
+ * 0 on success, a negative error code on failure.
+ */
+int devm_mipi_dsi_attach(struct device *dev,
+			 struct mipi_dsi_device *dsi)
+{
+	int ret;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, devm_mipi_dsi_detach, dsi);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_mipi_dsi_attach);
+
 static ssize_t mipi_dsi_device_transfer(struct mipi_dsi_device *dsi,
 					struct mipi_dsi_msg *msg)
 {
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 7e48dcd1bee4..c26f91699635 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -1056,7 +1056,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
 		fence = drm_syncobj_fence_get(syncobjs[i]);
 		if (!fence || dma_fence_chain_find_seqno(&fence, points[i])) {
 			dma_fence_put(fence);
-			if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT) {
+			if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
+				     DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE)) {
 				continue;
 			} else {
 				timeout = -EINVAL;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 0b93013061e6..f2264633be1b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -362,6 +362,9 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
 		unsigned int local_layer;
 
 		plane_state = to_mtk_plane_state(plane->state);
+
+		/* should not enable layer before crtc enabled */
+		plane_state->pending.enable = false;
 		comp = mtk_drm_ddp_comp_for_plane(crtc, plane, &local_layer);
 		if (comp)
 			mtk_ddp_comp_layer_config(comp, local_layer,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index 734a1fb052df..eda072a3bf9a 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -154,9 +154,9 @@ static void mtk_plane_atomic_async_update(struct drm_plane *plane,
 	plane->state->src_y = new_state->src_y;
 	plane->state->src_h = new_state->src_h;
 	plane->state->src_w = new_state->src_w;
-	swap(plane->state->fb, new_state->fb);
 
 	mtk_plane_update_new_state(new_state, new_plane_state);
+	swap(plane->state->fb, new_state->fb);
 	wmb(); /* Make sure the above parameters are set before update */
 	new_plane_state->pending.async_dirty = true;
 	mtk_drm_crtc_async_update(new_state->crtc, plane, state);
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 98b1204c9290..57eaf111b6a8 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -406,7 +406,7 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 	if (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
 		tmp_reg |= HSTX_CKLP_EN;
 
-	if (!(dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET))
+	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
 		tmp_reg |= DIS_EOT;
 
 	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
@@ -483,7 +483,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 			  timing->da_hs_zero + timing->da_hs_exit + 3;
 
 	delta = dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 : 12;
-	delta += dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET ? 2 : 0;
+	delta += dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET ? 0 : 2;
 
 	horizontal_frontporch_byte = vm->hfront_porch * dsi_tmp_buf_bpp;
 	horizontal_front_back_byte = horizontal_frontporch_byte + horizontal_backporch_byte;
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 85dec6167e0b..8d0612caf6c2 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -1154,8 +1154,7 @@ static void dsi_tx_buf_free(struct msm_dsi_host *msm_host)
 
 	priv = dev->dev_private;
 	if (msm_host->tx_gem_obj) {
-		msm_gem_unpin_iova(msm_host->tx_gem_obj, priv->kms->aspace);
-		drm_gem_object_put(msm_host->tx_gem_obj);
+		msm_gem_kernel_put(msm_host->tx_gem_obj, priv->kms->aspace);
 		msm_host->tx_gem_obj = NULL;
 	}
 
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index eeb590d2dec2..e84596bb98f7 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -4820,14 +4820,15 @@ int evergreen_irq_process(struct radeon_device *rdev)
 			break;
 		case 44: /* hdmi */
 			afmt_idx = src_data;
-			if (!(afmt_status[afmt_idx] & AFMT_AZ_FORMAT_WTRIG))
-				DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
-
 			if (afmt_idx > 5) {
 				DRM_ERROR("Unhandled interrupt: %d %d\n",
 					  src_id, src_data);
 				break;
 			}
+
+			if (!(afmt_status[afmt_idx] & AFMT_AZ_FORMAT_WTRIG))
+				DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
+
 			afmt_status[afmt_idx] &= ~AFMT_AZ_FORMAT_WTRIG;
 			queue_hdmi = true;
 			DRM_DEBUG("IH: HDMI%d\n", afmt_idx + 1);
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 20e63cadec8c..b9ef35a35c85 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1146,6 +1146,7 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	struct cdn_dp_device *dp;
 	struct extcon_dev *extcon;
 	struct phy *phy;
+	int ret;
 	int i;
 
 	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
@@ -1186,9 +1187,19 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	mutex_init(&dp->lock);
 	dev_set_drvdata(dev, dp);
 
-	cdn_dp_audio_codec_init(dp, dev);
+	ret = cdn_dp_audio_codec_init(dp, dev);
+	if (ret)
+		return ret;
+
+	ret = component_add(dev, &cdn_dp_component_ops);
+	if (ret)
+		goto err_audio_deinit;
 
-	return component_add(dev, &cdn_dp_component_ops);
+	return 0;
+
+err_audio_deinit:
+	platform_device_unregister(dp->audio_pdev);
+	return ret;
 }
 
 static int cdn_dp_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 3b18b6a7acd3..bde358d8309c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -39,7 +39,7 @@ static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
 
 	ret = iommu_map_sgtable(private->domain, rk_obj->dma_addr, rk_obj->sgt,
 				prot);
-	if (ret < rk_obj->base.size) {
+	if (ret < (ssize_t)rk_obj->base.size) {
 		DRM_ERROR("failed to map buffer: size=%zd request_size=%zd\n",
 			  ret, rk_obj->base.size);
 		ret = -ENOMEM;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index cfe13b203b89..e53b1ecbd7bc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1554,7 +1554,8 @@ static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
 	if (WARN_ON(!crtc->state))
 		return NULL;
 
-	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
+	rockchip_state = kmemdup(to_rockchip_crtc_state(crtc->state),
+				 sizeof(*rockchip_state), GFP_KERNEL);
 	if (!rockchip_state)
 		return NULL;
 
@@ -1579,7 +1580,10 @@ static void vop_crtc_reset(struct drm_crtc *crtc)
 	if (crtc->state)
 		vop_crtc_destroy_state(crtc, crtc->state);
 
-	__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
+	if (crtc_state)
+		__drm_atomic_helper_crtc_reset(crtc, &crtc_state->base);
+	else
+		__drm_atomic_helper_crtc_reset(crtc, NULL);
 }
 
 #ifdef CONFIG_DRM_ANALOGIX_DP
diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index d902fe43cb81..6a11b3a329ae 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1157,8 +1157,6 @@ static unsigned int cp2112_gpio_irq_startup(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cp2112_device *dev = gpiochip_get_data(gc);
 
-	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
-
 	if (!dev->gpio_poll) {
 		dev->gpio_poll = true;
 		schedule_delayed_work(&dev->gpio_poll_worker, 0);
@@ -1173,7 +1171,10 @@ static void cp2112_gpio_irq_shutdown(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cp2112_device *dev = gpiochip_get_data(gc);
 
-	cancel_delayed_work_sync(&dev->gpio_poll_worker);
+	if (!dev->irq_mask) {
+		dev->gpio_poll = false;
+		cancel_delayed_work_sync(&dev->gpio_poll_worker);
+	}
 }
 
 static int cp2112_gpio_irq_type(struct irq_data *d, unsigned int type)
@@ -1354,6 +1355,8 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	girq->handler = handle_simple_irq;
 	girq->threaded = true;
 
+	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
+
 	ret = gpiochip_add_data(&dev->gc, dev);
 	if (ret < 0) {
 		hid_err(hdev, "error registering gpio chip\n");
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 25fa23593488..fb287c4cbd5b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -31,11 +31,6 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
 MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
 
-static bool disable_raw_mode;
-module_param(disable_raw_mode, bool, 0644);
-MODULE_PARM_DESC(disable_raw_mode,
-	"Disable Raw mode reporting for touchpads and keep firmware gestures.");
-
 static bool disable_tap_to_click;
 module_param(disable_tap_to_click, bool, 0644);
 MODULE_PARM_DESC(disable_tap_to_click,
@@ -68,7 +63,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 /* bits 2..20 are reserved for classes */
 /* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
-#define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
+#define HIDPP_QUIRK_DELAYED_INIT		BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
 #define HIDPP_QUIRK_UNIFYING			BIT(25)
 #define HIDPP_QUIRK_HI_RES_SCROLL_1P0		BIT(26)
@@ -87,8 +82,6 @@ MODULE_PARM_DESC(disable_tap_to_click,
 					 HIDPP_QUIRK_HI_RES_SCROLL_X2120 | \
 					 HIDPP_QUIRK_HI_RES_SCROLL_X2121)
 
-#define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
-
 #define HIDPP_CAPABILITY_HIDPP10_BATTERY	BIT(0)
 #define HIDPP_CAPABILITY_HIDPP20_BATTERY	BIT(1)
 #define HIDPP_CAPABILITY_BATTERY_MILEAGE	BIT(2)
@@ -1760,15 +1753,14 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 /* -------------------------------------------------------------------------- */
 #define HIDPP_PAGE_WIRELESS_DEVICE_STATUS			0x1d4b
 
-static int hidpp_set_wireless_feature_index(struct hidpp_device *hidpp)
+static int hidpp_get_wireless_feature_index(struct hidpp_device *hidpp, u8 *feature_index)
 {
 	u8 feature_type;
 	int ret;
 
 	ret = hidpp_root_get_feature(hidpp,
 				     HIDPP_PAGE_WIRELESS_DEVICE_STATUS,
-				     &hidpp->wireless_feature_index,
-				     &feature_type);
+				     feature_index, &feature_type);
 
 	return ret;
 }
@@ -3957,6 +3949,13 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 		}
 	}
 
+	if (hidpp->protocol_major >= 2) {
+		u8 feature_index;
+
+		if (!hidpp_get_wireless_feature_index(hidpp, &feature_index))
+			hidpp->wireless_feature_index = feature_index;
+	}
+
 	if (hidpp->name == hdev->name && hidpp->protocol_major >= 2) {
 		name = hidpp_get_device_name(hidpp);
 		if (name) {
@@ -3993,7 +3992,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL)
 		hi_res_scroll_enable(hidpp);
 
-	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
+	if (!(hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
 		return;
 
@@ -4096,7 +4095,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	bool connected;
 	unsigned int connect_mask = HID_CONNECT_DEFAULT;
 	struct hidpp_ff_private_data data;
-	bool will_restart = false;
 
 	/* report_fixup needs drvdata to be set before we call hid_parse */
 	hidpp = devm_kzalloc(&hdev->dev, sizeof(*hidpp), GFP_KERNEL);
@@ -4137,11 +4135,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	    hidpp_application_equals(hdev, HID_GD_KEYBOARD))
 		hidpp->quirks |= HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS;
 
-	if (disable_raw_mode) {
-		hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
-		hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
-	}
-
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
 		ret = wtp_allocate(hdev, id);
 		if (ret)
@@ -4152,10 +4145,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			return ret;
 	}
 
-	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT ||
-	    hidpp->quirks & HIDPP_QUIRK_UNIFYING)
-		will_restart = true;
-
 	INIT_WORK(&hidpp->work, delayed_work_cb);
 	mutex_init(&hidpp->send_mutex);
 	init_waitqueue_head(&hidpp->wait);
@@ -4167,10 +4156,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			 hdev->name);
 
 	/*
-	 * Plain USB connections need to actually call start and open
-	 * on the transport driver to allow incoming data.
+	 * First call hid_hw_start(hdev, 0) to allow IO without connecting any
+	 * hid subdrivers (hid-input, hidraw). This allows retrieving the dev's
+	 * name and serial number and store these in hdev->name and hdev->uniq,
+	 * before the hid-input and hidraw drivers expose these to userspace.
 	 */
-	ret = hid_hw_start(hdev, will_restart ? 0 : connect_mask);
+	ret = hid_hw_start(hdev, 0);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
 		goto hid_hw_start_fail;
@@ -4203,15 +4194,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hidpp_overwrite_name(hdev);
 	}
 
-	if (connected && hidpp->protocol_major >= 2) {
-		ret = hidpp_set_wireless_feature_index(hidpp);
-		if (ret == -ENOENT)
-			hidpp->wireless_feature_index = 0;
-		else if (ret)
-			goto hid_hw_init_fail;
-		ret = 0;
-	}
-
 	if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
 		ret = wtp_get_config(hidpp);
 		if (ret)
@@ -4225,21 +4207,14 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	schedule_work(&hidpp->work);
 	flush_work(&hidpp->work);
 
-	if (will_restart) {
-		/* Reset the HID node state */
-		hid_device_io_stop(hdev);
-		hid_hw_close(hdev);
-		hid_hw_stop(hdev);
+	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
+		connect_mask &= ~HID_CONNECT_HIDINPUT;
 
-		if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
-			connect_mask &= ~HID_CONNECT_HIDINPUT;
-
-		/* Now export the actual inputs and hidraw nodes to the world */
-		ret = hid_hw_start(hdev, connect_mask);
-		if (ret) {
-			hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
-			goto hid_hw_start_fail;
-		}
+	/* Now export the actual inputs and hidraw nodes to the world */
+	ret = hid_connect(hdev, connect_mask);
+	if (ret) {
+		hid_err(hdev, "%s:hid_connect returned error %d\n", __func__, ret);
+		goto hid_hw_init_fail;
 	}
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
@@ -4250,6 +4225,11 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 				 ret);
 	}
 
+	/*
+	 * This relies on logi_dj_ll_close() being a no-op so that DJ connection
+	 * events will still be received.
+	 */
+	hid_hw_close(hdev);
 	return ret;
 
 hid_hw_init_fail:
diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
index d2092c17d993..7af18018a32f 100644
--- a/drivers/hwmon/axi-fan-control.c
+++ b/drivers/hwmon/axi-fan-control.c
@@ -508,6 +508,21 @@ static int axi_fan_control_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = axi_fan_control_init(ctl, pdev->dev.of_node);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to initialize device\n");
+		return ret;
+	}
+
+	ctl->hdev = devm_hwmon_device_register_with_info(&pdev->dev,
+							 name,
+							 ctl,
+							 &axi_chip_info,
+							 axi_fan_control_groups);
+
+	if (IS_ERR(ctl->hdev))
+		return PTR_ERR(ctl->hdev);
+
 	ctl->irq = platform_get_irq(pdev, 0);
 	if (ctl->irq < 0)
 		return ctl->irq;
@@ -521,19 +536,7 @@ static int axi_fan_control_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = axi_fan_control_init(ctl, pdev->dev.of_node);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to initialize device\n");
-		return ret;
-	}
-
-	ctl->hdev = devm_hwmon_device_register_with_info(&pdev->dev,
-							 name,
-							 ctl,
-							 &axi_chip_info,
-							 axi_fan_control_groups);
-
-	return PTR_ERR_OR_ZERO(ctl->hdev);
+	return 0;
 }
 
 static struct platform_driver axi_fan_control_driver = {
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index eaae5de2ab61..5b2057ce5a59 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -41,7 +41,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
-#define CORETEMP_NAME_LENGTH	19	/* String Length of attrs */
+#define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index ec6571b82fff..299dbcd4c829 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -326,26 +326,44 @@ static void bcm_iproc_i2c_slave_init(
 	iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val);
 }
 
-static void bcm_iproc_i2c_check_slave_status(
-	struct bcm_iproc_i2c_dev *iproc_i2c)
+static bool bcm_iproc_i2c_check_slave_status
+	(struct bcm_iproc_i2c_dev *iproc_i2c, u32 status)
 {
 	u32 val;
+	bool recover = false;
 
-	val = iproc_i2c_rd_reg(iproc_i2c, S_CMD_OFFSET);
-	/* status is valid only when START_BUSY is cleared after it was set */
-	if (val & BIT(S_CMD_START_BUSY_SHIFT))
-		return;
+	/* check slave transmit status only if slave is transmitting */
+	if (!iproc_i2c->slave_rx_only) {
+		val = iproc_i2c_rd_reg(iproc_i2c, S_CMD_OFFSET);
+		/* status is valid only when START_BUSY is cleared */
+		if (!(val & BIT(S_CMD_START_BUSY_SHIFT))) {
+			val = (val >> S_CMD_STATUS_SHIFT) & S_CMD_STATUS_MASK;
+			if (val == S_CMD_STATUS_TIMEOUT ||
+			    val == S_CMD_STATUS_MASTER_ABORT) {
+				dev_warn(iproc_i2c->device,
+					 (val == S_CMD_STATUS_TIMEOUT) ?
+					 "slave random stretch time timeout\n" :
+					 "Master aborted read transaction\n");
+				recover = true;
+			}
+		}
+	}
+
+	/* RX_EVENT is not valid when START_BUSY is set */
+	if ((status & BIT(IS_S_RX_EVENT_SHIFT)) &&
+	    (status & BIT(IS_S_START_BUSY_SHIFT))) {
+		dev_warn(iproc_i2c->device, "Slave aborted read transaction\n");
+		recover = true;
+	}
 
-	val = (val >> S_CMD_STATUS_SHIFT) & S_CMD_STATUS_MASK;
-	if (val == S_CMD_STATUS_TIMEOUT || val == S_CMD_STATUS_MASTER_ABORT) {
-		dev_err(iproc_i2c->device, (val == S_CMD_STATUS_TIMEOUT) ?
-			"slave random stretch time timeout\n" :
-			"Master aborted read transaction\n");
+	if (recover) {
 		/* re-initialize i2c for recovery */
 		bcm_iproc_i2c_enable_disable(iproc_i2c, false);
 		bcm_iproc_i2c_slave_init(iproc_i2c, true);
 		bcm_iproc_i2c_enable_disable(iproc_i2c, true);
 	}
+
+	return recover;
 }
 
 static void bcm_iproc_i2c_slave_read(struct bcm_iproc_i2c_dev *iproc_i2c)
@@ -430,48 +448,6 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 	u32 val;
 	u8 value;
 
-	/*
-	 * Slave events in case of master-write, master-write-read and,
-	 * master-read
-	 *
-	 * Master-write     : only IS_S_RX_EVENT_SHIFT event
-	 * Master-write-read: both IS_S_RX_EVENT_SHIFT and IS_S_RD_EVENT_SHIFT
-	 *                    events
-	 * Master-read      : both IS_S_RX_EVENT_SHIFT and IS_S_RD_EVENT_SHIFT
-	 *                    events or only IS_S_RD_EVENT_SHIFT
-	 *
-	 * iproc has a slave rx fifo size of 64 bytes. Rx fifo full interrupt
-	 * (IS_S_RX_FIFO_FULL_SHIFT) will be generated when RX fifo becomes
-	 * full. This can happen if Master issues write requests of more than
-	 * 64 bytes.
-	 */
-	if (status & BIT(IS_S_RX_EVENT_SHIFT) ||
-	    status & BIT(IS_S_RD_EVENT_SHIFT) ||
-	    status & BIT(IS_S_RX_FIFO_FULL_SHIFT)) {
-		/* disable slave interrupts */
-		val = iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
-		val &= ~iproc_i2c->slave_int_mask;
-		iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val);
-
-		if (status & BIT(IS_S_RD_EVENT_SHIFT))
-			/* Master-write-read request */
-			iproc_i2c->slave_rx_only = false;
-		else
-			/* Master-write request only */
-			iproc_i2c->slave_rx_only = true;
-
-		/* schedule tasklet to read data later */
-		tasklet_schedule(&iproc_i2c->slave_rx_tasklet);
-
-		/*
-		 * clear only IS_S_RX_EVENT_SHIFT and
-		 * IS_S_RX_FIFO_FULL_SHIFT interrupt.
-		 */
-		val = BIT(IS_S_RX_EVENT_SHIFT);
-		if (status & BIT(IS_S_RX_FIFO_FULL_SHIFT))
-			val |= BIT(IS_S_RX_FIFO_FULL_SHIFT);
-		iproc_i2c_wr_reg(iproc_i2c, IS_OFFSET, val);
-	}
 
 	if (status & BIT(IS_S_TX_UNDERRUN_SHIFT)) {
 		iproc_i2c->tx_underrun++;
@@ -503,8 +479,9 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 		 * less than PKT_LENGTH bytes were output on the SMBUS
 		 */
 		iproc_i2c->slave_int_mask &= ~BIT(IE_S_TX_UNDERRUN_SHIFT);
-		iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET,
-				 iproc_i2c->slave_int_mask);
+		val = iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
+		val &= ~BIT(IE_S_TX_UNDERRUN_SHIFT);
+		iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val);
 
 		/* End of SMBUS for Master Read */
 		val = BIT(S_TX_WR_STATUS_SHIFT);
@@ -525,9 +502,49 @@ static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
 				 BIT(IS_S_START_BUSY_SHIFT));
 	}
 
-	/* check slave transmit status only if slave is transmitting */
-	if (!iproc_i2c->slave_rx_only)
-		bcm_iproc_i2c_check_slave_status(iproc_i2c);
+	/* if the controller has been reset, immediately return from the ISR */
+	if (bcm_iproc_i2c_check_slave_status(iproc_i2c, status))
+		return true;
+
+	/*
+	 * Slave events in case of master-write, master-write-read and,
+	 * master-read
+	 *
+	 * Master-write     : only IS_S_RX_EVENT_SHIFT event
+	 * Master-write-read: both IS_S_RX_EVENT_SHIFT and IS_S_RD_EVENT_SHIFT
+	 *                    events
+	 * Master-read      : both IS_S_RX_EVENT_SHIFT and IS_S_RD_EVENT_SHIFT
+	 *                    events or only IS_S_RD_EVENT_SHIFT
+	 *
+	 * iproc has a slave rx fifo size of 64 bytes. Rx fifo full interrupt
+	 * (IS_S_RX_FIFO_FULL_SHIFT) will be generated when RX fifo becomes
+	 * full. This can happen if Master issues write requests of more than
+	 * 64 bytes.
+	 */
+	if (status & BIT(IS_S_RX_EVENT_SHIFT) ||
+	    status & BIT(IS_S_RD_EVENT_SHIFT) ||
+	    status & BIT(IS_S_RX_FIFO_FULL_SHIFT)) {
+		/* disable slave interrupts */
+		val = iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
+		val &= ~iproc_i2c->slave_int_mask;
+		iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val);
+
+		if (status & BIT(IS_S_RD_EVENT_SHIFT))
+			/* Master-write-read request */
+			iproc_i2c->slave_rx_only = false;
+		else
+			/* Master-write request only */
+			iproc_i2c->slave_rx_only = true;
+
+		/* schedule tasklet to read data later */
+		tasklet_schedule(&iproc_i2c->slave_rx_tasklet);
+
+		/* clear IS_S_RX_FIFO_FULL_SHIFT interrupt */
+		if (status & BIT(IS_S_RX_FIFO_FULL_SHIFT)) {
+			val = BIT(IS_S_RX_FIFO_FULL_SHIFT);
+			iproc_i2c_wr_reg(iproc_i2c, IS_OFFSET, val);
+		}
+	}
 
 	return true;
 }
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index dfe18dcd008d..b6abbb0acbbd 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1506,9 +1506,11 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 			desc->dev->dev.of_node = desc->boardinfo->of_node;
 
 		ret = device_register(&desc->dev->dev);
-		if (ret)
+		if (ret) {
 			dev_err(&master->dev,
 				"Failed to add I3C device (err = %d)\n", ret);
+			put_device(&desc->dev->dev);
+		}
 	}
 }
 
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ab2106a09f9c..2c2ac63b39c4 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -803,7 +803,7 @@ static int alloc_port_data(struct ib_device *device)
 	 * empty slots at the beginning.
 	 */
 	pdata_rcu = kzalloc(struct_size(pdata_rcu, pdata,
-					rdma_end_port(device) + 1),
+					size_add(rdma_end_port(device), 1)),
 			    GFP_KERNEL);
 	if (!pdata_rcu)
 		return -ENOMEM;
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index c00f8e28aab7..1557c71dd152 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -2132,7 +2132,9 @@ static int ib_sa_add_one(struct ib_device *device)
 	s = rdma_start_port(device);
 	e = rdma_end_port(device);
 
-	sa_dev = kzalloc(struct_size(sa_dev, port, e - s + 1), GFP_KERNEL);
+	sa_dev = kzalloc(struct_size(sa_dev, port,
+				     size_add(size_sub(e, s), 1)),
+			 GFP_KERNEL);
 	if (!sa_dev)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 253ccaf343f6..afc59048c40c 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -902,7 +902,7 @@ alloc_hw_stats_device(struct ib_device *ibdev)
 	 * Two extra attribue elements here, one for the lifespan entry and
 	 * one to NULL terminate the list for the sysfs core code
 	 */
-	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
+	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
 		       GFP_KERNEL);
 	if (!data)
 		goto err_free_stats;
@@ -1001,7 +1001,7 @@ alloc_hw_stats_port(struct ib_port *port, struct attribute_group *group)
 	 * Two extra attribue elements here, one for the lifespan entry and
 	 * one to NULL terminate the list for the sysfs core code
 	 */
-	data = kzalloc(struct_size(data, attrs, stats->num_counters + 1),
+	data = kzalloc(struct_size(data, attrs, size_add(stats->num_counters, 1)),
 		       GFP_KERNEL);
 	if (!data)
 		goto err_free_stats;
@@ -1125,7 +1125,7 @@ static int setup_gid_attrs(struct ib_port *port,
 	int ret;
 
 	gid_attr_group = kzalloc(struct_size(gid_attr_group, attrs_list,
-					     attr->gid_tbl_len * 2),
+					     size_mul(attr->gid_tbl_len, 2)),
 				 GFP_KERNEL);
 	if (!gid_attr_group)
 		return -ENOMEM;
@@ -1190,8 +1190,8 @@ static struct ib_port *setup_port(struct ib_core_device *coredev, int port_num,
 	int ret;
 
 	p = kvzalloc(struct_size(p, attrs_list,
-				attr->gid_tbl_len + attr->pkey_tbl_len),
-		    GFP_KERNEL);
+				size_add(attr->gid_tbl_len, attr->pkey_tbl_len)),
+		     GFP_KERNEL);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 	p->ibdev = device;
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index a61c9ede4338..5c284dfbe692 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1378,7 +1378,9 @@ static int ib_umad_add_one(struct ib_device *device)
 	s = rdma_start_port(device);
 	e = rdma_end_port(device);
 
-	umad_dev = kzalloc(struct_size(umad_dev, ports, e - s + 1), GFP_KERNEL);
+	umad_dev = kzalloc(struct_size(umad_dev, ports,
+				       size_add(size_sub(e, s), 1)),
+			   GFP_KERNEL);
 	if (!umad_dev)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/hfi1/efivar.c b/drivers/infiniband/hw/hfi1/efivar.c
index f275dd1abed8..7a3caf2cd907 100644
--- a/drivers/infiniband/hw/hfi1/efivar.c
+++ b/drivers/infiniband/hw/hfi1/efivar.c
@@ -110,7 +110,7 @@ int read_hfi1_efi_var(struct hfi1_devdata *dd, const char *kind,
 		      unsigned long *size, void **return_data)
 {
 	char prefix_name[64];
-	char name[64];
+	char name[128];
 	int result;
 	int i;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4554d3e78b37..f034021f3adc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -244,7 +244,7 @@ static bool check_inl_data_len(struct hns_roce_qp *qp, unsigned int len)
 	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
 	int mtu = ib_mtu_enum_to_int(qp->path_mtu);
 
-	if (len > qp->max_inline_data || len > mtu) {
+	if (mtu < 0 || len > qp->max_inline_data || len > mtu) {
 		ibdev_err(&hr_dev->ib_dev,
 			  "invalid length of data, data len = %u, max inline len = %u, path mtu = %d.\n",
 			  len, qp->max_inline_data, mtu);
@@ -4556,6 +4556,9 @@ static int check_cong_type(struct ib_qp *ibqp,
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
 
+	if (ibqp->qp_type == IB_QPT_UD)
+		hr_dev->caps.cong_type = CONG_TYPE_DCQCN;
+
 	/* different congestion types match different configurations */
 	switch (hr_dev->caps.cong_type) {
 	case CONG_TYPE_DCQCN:
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 00dade1cfff2..d085998b19c8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1049,7 +1049,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 {
 	struct hns_roce_ib_create_qp_resp resp = {};
 	struct ib_device *ibdev = &hr_dev->ib_dev;
-	struct hns_roce_ib_create_qp ucmd;
+	struct hns_roce_ib_create_qp ucmd = {};
 	int ret;
 
 	mutex_init(&hr_qp->mutex);
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 1080daf3a546..d4b5ce37c2cb 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3955,6 +3955,30 @@ static unsigned int get_tx_affinity(struct ib_qp *qp,
 	return tx_affinity;
 }
 
+static int __mlx5_ib_qp_set_raw_qp_counter(struct mlx5_ib_qp *qp, u32 set_id,
+					   struct mlx5_core_dev *mdev)
+{
+	struct mlx5_ib_raw_packet_qp *raw_packet_qp = &qp->raw_packet_qp;
+	struct mlx5_ib_rq *rq = &raw_packet_qp->rq;
+	u32 in[MLX5_ST_SZ_DW(modify_rq_in)] = {};
+	void *rqc;
+
+	if (!qp->rq.wqe_cnt)
+		return 0;
+
+	MLX5_SET(modify_rq_in, in, rq_state, rq->state);
+	MLX5_SET(modify_rq_in, in, uid, to_mpd(qp->ibqp.pd)->uid);
+
+	rqc = MLX5_ADDR_OF(modify_rq_in, in, ctx);
+	MLX5_SET(rqc, rqc, state, MLX5_RQC_STATE_RDY);
+
+	MLX5_SET64(modify_rq_in, in, modify_bitmask,
+		   MLX5_MODIFY_RQ_IN_MODIFY_BITMASK_RQ_COUNTER_SET_ID);
+	MLX5_SET(rqc, rqc, counter_set_id, set_id);
+
+	return mlx5_core_modify_rq(mdev, rq->base.mqp.qpn, in);
+}
+
 static int __mlx5_ib_qp_set_counter(struct ib_qp *qp,
 				    struct rdma_counter *counter)
 {
@@ -3970,6 +3994,9 @@ static int __mlx5_ib_qp_set_counter(struct ib_qp *qp,
 	else
 		set_id = mlx5_ib_get_counters_id(dev, mqp->port - 1);
 
+	if (mqp->type == IB_QPT_RAW_PACKET)
+		return __mlx5_ib_qp_set_raw_qp_counter(mqp, set_id, dev->mdev);
+
 	base = &mqp->trans_qp.base;
 	MLX5_SET(rts2rts_qp_in, in, opcode, MLX5_CMD_OP_RTS2RTS_QP);
 	MLX5_SET(rts2rts_qp_in, in, qpn, base->mqp.qpn);
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 24f31a5c0e04..014bb40e8423 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -276,11 +276,11 @@ void rmi_unregister_function(struct rmi_function *fn)
 
 	device_del(&fn->dev);
 	of_node_put(fn->dev.of_node);
-	put_device(&fn->dev);
 
 	for (i = 0; i < fn->num_of_irqs; i++)
 		irq_dispose_mapping(fn->irq[i]);
 
+	put_device(&fn->dev);
 }
 
 /**
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index cc892ecd5240..6d3e33e8b5f9 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -53,7 +53,7 @@ static int led_pwm_set(struct led_classdev *led_cdev,
 		duty = led_dat->pwmstate.period - duty;
 
 	led_dat->pwmstate.duty_cycle = duty;
-	led_dat->pwmstate.enabled = duty > 0;
+	led_dat->pwmstate.enabled = true;
 	return pwm_apply_state(led_dat->pwm, &led_dat->pwmstate);
 }
 
diff --git a/drivers/leds/leds-turris-omnia.c b/drivers/leds/leds-turris-omnia.c
index 1adfed1c0619..ebc6cf3ce3ca 100644
--- a/drivers/leds/leds-turris-omnia.c
+++ b/drivers/leds/leds-turris-omnia.c
@@ -2,7 +2,7 @@
 /*
  * CZ.NIC's Turris Omnia LEDs driver
  *
- * 2020 by Marek Behún <kabel@kernel.org>
+ * 2020, 2023 by Marek Behún <kabel@kernel.org>
  */
 
 #include <linux/i2c.h>
@@ -41,6 +41,37 @@ struct omnia_leds {
 	struct omnia_led leds[];
 };
 
+static int omnia_cmd_write_u8(const struct i2c_client *client, u8 cmd, u8 val)
+{
+	u8 buf[2] = { cmd, val };
+
+	return i2c_master_send(client, buf, sizeof(buf));
+}
+
+static int omnia_cmd_read_u8(const struct i2c_client *client, u8 cmd)
+{
+	struct i2c_msg msgs[2];
+	u8 reply;
+	int ret;
+
+	msgs[0].addr = client->addr;
+	msgs[0].flags = 0;
+	msgs[0].len = 1;
+	msgs[0].buf = &cmd;
+	msgs[1].addr = client->addr;
+	msgs[1].flags = I2C_M_RD;
+	msgs[1].len = 1;
+	msgs[1].buf = &reply;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (likely(ret == ARRAY_SIZE(msgs)))
+		return reply;
+	else if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
 static int omnia_led_brightness_set_blocking(struct led_classdev *cdev,
 					     enum led_brightness brightness)
 {
@@ -64,7 +95,7 @@ static int omnia_led_brightness_set_blocking(struct led_classdev *cdev,
 	if (buf[2] || buf[3] || buf[4])
 		state |= CMD_LED_STATE_ON;
 
-	ret = i2c_smbus_write_byte_data(leds->client, CMD_LED_STATE, state);
+	ret = omnia_cmd_write_u8(leds->client, CMD_LED_STATE, state);
 	if (ret >= 0 && (state & CMD_LED_STATE_ON))
 		ret = i2c_master_send(leds->client, buf, 5);
 
@@ -114,9 +145,9 @@ static int omnia_led_register(struct i2c_client *client, struct omnia_led *led,
 	cdev->brightness_set_blocking = omnia_led_brightness_set_blocking;
 
 	/* put the LED into software mode */
-	ret = i2c_smbus_write_byte_data(client, CMD_LED_MODE,
-					CMD_LED_MODE_LED(led->reg) |
-					CMD_LED_MODE_USER);
+	ret = omnia_cmd_write_u8(client, CMD_LED_MODE,
+				 CMD_LED_MODE_LED(led->reg) |
+				 CMD_LED_MODE_USER);
 	if (ret < 0) {
 		dev_err(dev, "Cannot set LED %pOF to software mode: %i\n", np,
 			ret);
@@ -124,8 +155,8 @@ static int omnia_led_register(struct i2c_client *client, struct omnia_led *led,
 	}
 
 	/* disable the LED */
-	ret = i2c_smbus_write_byte_data(client, CMD_LED_STATE,
-					CMD_LED_STATE_LED(led->reg));
+	ret = omnia_cmd_write_u8(client, CMD_LED_STATE,
+				 CMD_LED_STATE_LED(led->reg));
 	if (ret < 0) {
 		dev_err(dev, "Cannot set LED %pOF brightness: %i\n", np, ret);
 		return ret;
@@ -156,12 +187,9 @@ static ssize_t brightness_show(struct device *dev, struct device_attribute *a,
 			       char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct omnia_leds *leds = i2c_get_clientdata(client);
 	int ret;
 
-	mutex_lock(&leds->lock);
-	ret = i2c_smbus_read_byte_data(client, CMD_LED_GET_BRIGHTNESS);
-	mutex_unlock(&leds->lock);
+	ret = omnia_cmd_read_u8(client, CMD_LED_GET_BRIGHTNESS);
 
 	if (ret < 0)
 		return ret;
@@ -173,7 +201,6 @@ static ssize_t brightness_store(struct device *dev, struct device_attribute *a,
 				const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	struct omnia_leds *leds = i2c_get_clientdata(client);
 	unsigned long brightness;
 	int ret;
 
@@ -183,15 +210,9 @@ static ssize_t brightness_store(struct device *dev, struct device_attribute *a,
 	if (brightness > 100)
 		return -EINVAL;
 
-	mutex_lock(&leds->lock);
-	ret = i2c_smbus_write_byte_data(client, CMD_LED_SET_BRIGHTNESS,
-					(u8)brightness);
-	mutex_unlock(&leds->lock);
-
-	if (ret < 0)
-		return ret;
+	ret = omnia_cmd_write_u8(client, CMD_LED_SET_BRIGHTNESS, brightness);
 
-	return count;
+	return ret < 0 ? ret : count;
 }
 static DEVICE_ATTR_RW(brightness);
 
@@ -250,8 +271,8 @@ static int omnia_leds_remove(struct i2c_client *client)
 	u8 buf[5];
 
 	/* put all LEDs into default (HW triggered) mode */
-	i2c_smbus_write_byte_data(client, CMD_LED_MODE,
-				  CMD_LED_MODE_LED(OMNIA_BOARD_LEDS));
+	omnia_cmd_write_u8(client, CMD_LED_MODE,
+			   CMD_LED_MODE_LED(OMNIA_BOARD_LEDS));
 
 	/* set all LEDs color to [255, 255, 255] */
 	buf[0] = CMD_LED_COLOR;
diff --git a/drivers/leds/trigger/ledtrig-cpu.c b/drivers/leds/trigger/ledtrig-cpu.c
index 8af4f9bb9cde..05848a2fecff 100644
--- a/drivers/leds/trigger/ledtrig-cpu.c
+++ b/drivers/leds/trigger/ledtrig-cpu.c
@@ -130,7 +130,7 @@ static int ledtrig_prepare_down_cpu(unsigned int cpu)
 
 static int __init ledtrig_cpu_init(void)
 {
-	int cpu;
+	unsigned int cpu;
 	int ret;
 
 	/* Supports up to 9999 cpu cores */
@@ -152,7 +152,7 @@ static int __init ledtrig_cpu_init(void)
 		if (cpu >= 8)
 			continue;
 
-		snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
+		snprintf(trig->name, MAX_NAME_LEN, "cpu%u", cpu);
 
 		led_trigger_register_simple(trig->name, &trig->_trig);
 	}
diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index 404a03f48b97..1b9beaee6bea 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -1231,7 +1231,6 @@ static int max9286_parse_dt(struct max9286_priv *priv)
 
 		i2c_mux_mask |= BIT(id);
 	}
-	of_node_put(node);
 	of_node_put(i2c_mux);
 
 	/* Parse the endpoints */
@@ -1295,7 +1294,6 @@ static int max9286_parse_dt(struct max9286_priv *priv)
 		priv->source_mask |= BIT(ep.port);
 		priv->nsources++;
 	}
-	of_node_put(node);
 
 	/*
 	 * Parse the initial value of the reverse channel amplitude from
diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 661ebfa7bf3f..c4bf7b7109ce 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -4250,6 +4250,7 @@ static void bttv_remove(struct pci_dev *pci_dev)
 
 	/* free resources */
 	free_irq(btv->c.pci->irq,btv);
+	del_timer_sync(&btv->timeout);
 	iounmap(btv->bt848_mmio);
 	release_mem_region(pci_resource_start(btv->c.pci,0),
 			   pci_resource_len(btv->c.pci,0));
diff --git a/drivers/media/platform/s3c-camif/camif-capture.c b/drivers/media/platform/s3c-camif/camif-capture.c
index 140854ab4dd8..d6b7fbd49a5c 100644
--- a/drivers/media/platform/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/s3c-camif/camif-capture.c
@@ -1132,12 +1132,12 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 
 	ret = vb2_queue_init(q);
 	if (ret)
-		goto err_vd_rel;
+		return ret;
 
 	vp->pad.flags = MEDIA_PAD_FL_SINK;
 	ret = media_entity_pads_init(&vfd->entity, 1, &vp->pad);
 	if (ret)
-		goto err_vd_rel;
+		return ret;
 
 	video_set_drvdata(vfd, vp);
 
@@ -1170,8 +1170,6 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 	v4l2_ctrl_handler_free(&vp->ctrl_handler);
 err_me_cleanup:
 	media_entity_cleanup(&vfd->entity);
-err_vd_rel:
-	video_device_release(vfd);
 	return ret;
 }
 
diff --git a/drivers/media/test-drivers/vidtv/vidtv_mux.c b/drivers/media/test-drivers/vidtv/vidtv_mux.c
index b51e6a3b8cbe..f99878eff7ac 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_mux.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_mux.c
@@ -504,13 +504,16 @@ struct vidtv_mux *vidtv_mux_init(struct dvb_frontend *fe,
 	m->priv = args->priv;
 	m->network_id = args->network_id;
 	m->network_name = kstrdup(args->network_name, GFP_KERNEL);
+	if (!m->network_name)
+		goto free_mux_buf;
+
 	m->timing.current_jiffies = get_jiffies_64();
 
 	if (args->channels)
 		m->channels = args->channels;
 	else
 		if (vidtv_channels_init(m) < 0)
-			goto free_mux_buf;
+			goto free_mux_network_name;
 
 	/* will alloc data for pmt_sections after initializing pat */
 	if (vidtv_channel_si_init(m) < 0)
@@ -527,6 +530,8 @@ struct vidtv_mux *vidtv_mux_init(struct dvb_frontend *fe,
 	vidtv_channel_si_destroy(m);
 free_channels:
 	vidtv_channels_destroy(m);
+free_mux_network_name:
+	kfree(m->network_name);
 free_mux_buf:
 	vfree(m->mux_buf);
 free_mux:
diff --git a/drivers/media/test-drivers/vidtv/vidtv_psi.c b/drivers/media/test-drivers/vidtv/vidtv_psi.c
index c11ac8dca73d..988324587c4e 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_psi.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_psi.c
@@ -307,16 +307,29 @@ struct vidtv_psi_desc_service *vidtv_psi_service_desc_init(struct vidtv_psi_desc
 
 	desc->service_name_len = service_name_len;
 
-	if (service_name && service_name_len)
+	if (service_name && service_name_len) {
 		desc->service_name = kstrdup(service_name, GFP_KERNEL);
+		if (!desc->service_name)
+			goto free_desc;
+	}
 
 	desc->provider_name_len = provider_name_len;
 
-	if (provider_name && provider_name_len)
+	if (provider_name && provider_name_len) {
 		desc->provider_name = kstrdup(provider_name, GFP_KERNEL);
+		if (!desc->provider_name)
+			goto free_desc_service_name;
+	}
 
 	vidtv_psi_desc_chain(head, (struct vidtv_psi_desc *)desc);
 	return desc;
+
+free_desc_service_name:
+	if (service_name && service_name_len)
+		kfree(desc->service_name);
+free_desc:
+	kfree(desc);
+	return NULL;
 }
 
 struct vidtv_psi_desc_registration
@@ -361,8 +374,13 @@ struct vidtv_psi_desc_network_name
 
 	desc->length = network_name_len;
 
-	if (network_name && network_name_len)
+	if (network_name && network_name_len) {
 		desc->network_name = kstrdup(network_name, GFP_KERNEL);
+		if (!desc->network_name) {
+			kfree(desc);
+			return NULL;
+		}
+	}
 
 	vidtv_psi_desc_chain(head, (struct vidtv_psi_desc *)desc);
 	return desc;
@@ -448,15 +466,32 @@ struct vidtv_psi_desc_short_event
 		iso_language_code = "eng";
 
 	desc->iso_language_code = kstrdup(iso_language_code, GFP_KERNEL);
+	if (!desc->iso_language_code)
+		goto free_desc;
 
-	if (event_name && event_name_len)
+	if (event_name && event_name_len) {
 		desc->event_name = kstrdup(event_name, GFP_KERNEL);
+		if (!desc->event_name)
+			goto free_desc_language_code;
+	}
 
-	if (text && text_len)
+	if (text && text_len) {
 		desc->text = kstrdup(text, GFP_KERNEL);
+		if (!desc->text)
+			goto free_desc_event_name;
+	}
 
 	vidtv_psi_desc_chain(head, (struct vidtv_psi_desc *)desc);
 	return desc;
+
+free_desc_event_name:
+	if (event_name && event_name_len)
+		kfree(desc->event_name);
+free_desc_language_code:
+	kfree(desc->iso_language_code);
+free_desc:
+	kfree(desc);
+	return NULL;
 }
 
 struct vidtv_psi_desc *vidtv_psi_desc_clone(struct vidtv_psi_desc *desc)
diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 56bb507fca21..dabfe9b33222 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -323,8 +323,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
-			if (msg[0].len < 3 || msg[1].len < 1)
-				return -EOPNOTSUPP;
+			if (msg[0].len < 3 || msg[1].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto unlock;
+			}
 			/* demod access via firmware interface */
 			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -384,8 +386,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
-			if (msg[0].len < 3)
-				return -EOPNOTSUPP;
+			if (msg[0].len < 3) {
+				ret = -EOPNOTSUPP;
+				goto unlock;
+			}
 			/* demod access via firmware interface */
 			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -460,6 +464,7 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 		ret = -EOPNOTSUPP;
 	}
 
+unlock:
 	mutex_unlock(&d->i2c_mutex);
 
 	if (ret < 0)
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index aa1d6f94ae53..8d826b58732d 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -118,6 +118,9 @@ static int arizona_spi_acpi_probe(struct arizona *arizona)
 	arizona->pdata.micd_ranges = arizona_micd_aosp_ranges;
 	arizona->pdata.num_micd_ranges = ARRAY_SIZE(arizona_micd_aosp_ranges);
 
+	/* Use left headphone speaker for HP vs line-out detection */
+	arizona->pdata.hpdet_channel = ARIZONA_ACCDET_MODE_HPL;
+
 	return 0;
 }
 
diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index fc65f9e25fda..852129ea0766 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -836,7 +836,6 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
-	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 684a011a6396..53ea3fab66a4 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -159,6 +159,7 @@ static int mfd_add_device(struct device *parent, int id,
 	struct platform_device *pdev;
 	struct device_node *np = NULL;
 	struct mfd_of_node_entry *of_entry, *tmp;
+	bool disabled = false;
 	int ret = -ENOMEM;
 	int platform_id;
 	int r;
@@ -196,11 +197,10 @@ static int mfd_add_device(struct device *parent, int id,
 	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
-				/* Ignore 'disabled' devices error free */
+				/* Skip 'disabled' devices */
 				if (!of_device_is_available(np)) {
-					of_node_put(np);
-					ret = 0;
-					goto fail_alias;
+					disabled = true;
+					continue;
 				}
 
 				ret = mfd_match_of_node_to_dev(pdev, np, cell);
@@ -210,10 +210,17 @@ static int mfd_add_device(struct device *parent, int id,
 				if (ret)
 					goto fail_alias;
 
-				break;
+				goto match;
 			}
 		}
 
+		if (disabled) {
+			/* Ignore 'disabled' devices error free */
+			ret = 0;
+			goto fail_alias;
+		}
+
+match:
 		if (!pdev->dev.of_node)
 			pr_warn("%s: Failed to locate of_node [id: %d]\n",
 				cell->name, platform_id);
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 7f6976a9f508..48e0f8377e65 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -15,6 +15,7 @@
 #include <linux/skbuff.h>
 
 #include <linux/ti_wilink_st.h>
+#include <linux/netdevice.h>
 
 extern void st_kim_recv(void *, const unsigned char *, long);
 void st_int_recv(void *, const unsigned char *, long);
@@ -435,7 +436,7 @@ static void st_int_enqueue(struct st_data_s *st_gdata, struct sk_buff *skb)
 	case ST_LL_AWAKE_TO_ASLEEP:
 		pr_err("ST LL is illegal state(%ld),"
 			   "purging received skb.", st_ll_getstate(st_gdata));
-		kfree_skb(skb);
+		dev_kfree_skb_irq(skb);
 		break;
 	case ST_LL_ASLEEP:
 		skb_queue_tail(&st_gdata->tx_waitq, skb);
@@ -444,7 +445,7 @@ static void st_int_enqueue(struct st_data_s *st_gdata, struct sk_buff *skb)
 	default:
 		pr_err("ST LL is illegal state(%ld),"
 			   "purging received skb.", st_ll_getstate(st_gdata));
-		kfree_skb(skb);
+		dev_kfree_skb_irq(skb);
 		break;
 	}
 
@@ -498,7 +499,7 @@ void st_tx_wakeup(struct st_data_s *st_data)
 				spin_unlock_irqrestore(&st_data->lock, flags);
 				break;
 			}
-			kfree_skb(skb);
+			dev_kfree_skb_irq(skb);
 			spin_unlock_irqrestore(&st_data->lock, flags);
 		}
 		/* if wake-up is set in another context- restart sending */
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5074b3ce38ea..d805f8450719 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -96,7 +96,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index e3d840b81357..94916f2d24d4 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -141,7 +141,8 @@ static void can_restart(struct net_device *dev)
 	struct can_frame *cf;
 	int err;
 
-	BUG_ON(netif_carrier_ok(dev));
+	if (netif_carrier_ok(dev))
+		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
 
 	/* No synchronization needed because the device is bus-off and
 	 * no messages can come in or go out.
@@ -165,11 +166,12 @@ static void can_restart(struct net_device *dev)
 	priv->can_stats.restarts++;
 
 	/* Now restart the device */
-	err = priv->do_set_mode(dev, CAN_MODE_START);
-
 	netif_carrier_on(dev);
-	if (err)
+	err = priv->do_set_mode(dev, CAN_MODE_START);
+	if (err) {
 		netdev_err(dev, "Error %d during restart", err);
+		netif_carrier_off(dev);
+	}
 }
 
 static void can_restart_work(struct work_struct *work)
diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 61660248c69e..e59d5cbb644a 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -42,7 +42,11 @@ int can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
 {
 	struct can_priv *priv = netdev_priv(dev);
 
-	BUG_ON(idx >= priv->echo_skb_max);
+	if (idx >= priv->echo_skb_max) {
+		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
+			   __func__, idx, priv->echo_skb_max);
+		return -EINVAL;
+	}
 
 	/* check flag whether this packet has to be looped back */
 	if (!(dev->flags & IFF_ECHO) ||
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 70b1a855273e..2c41852a082b 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18088,7 +18088,8 @@ static void tg3_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
-	tg3_power_down(tp);
+	if (system_state == SYSTEM_POWER_OFF)
+		tg3_power_down(tp);
 
 	rtnl_unlock();
 
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index ddfe9208529a..65d4a39634be 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -2260,7 +2260,7 @@ static void chtls_rx_ack(struct sock *sk, struct sk_buff *skb)
 
 		if (tp->snd_una != snd_una) {
 			tp->snd_una = snd_una;
-			tp->rcv_tstamp = tcp_time_stamp(tp);
+			tp->rcv_tstamp = tcp_jiffies32;
 			if (tp->snd_una == tp->snd_nxt &&
 			    !csk_flag_nochk(csk, CSK_TX_FAILOVER))
 				csk_reset_flag(csk, CSK_TX_WAIT_IDLE);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index c0ea1b185e1b..4327d6687897 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -139,7 +139,7 @@ static int gve_alloc_stats_report(struct gve_priv *priv)
 	rx_stats_num = (GVE_RX_STATS_REPORT_NUM + NIC_RX_STATS_REPORT_NUM) *
 		       priv->rx_cfg.num_queues;
 	priv->stats_report_len = struct_size(priv->stats_report, stats,
-					     tx_stats_num + rx_stats_num);
+					     size_add(tx_stats_num, rx_stats_num));
 	priv->stats_report =
 		dma_alloc_coherent(&priv->pdev->dev, priv->stats_report_len,
 				   &priv->stats_report_bus, GFP_KERNEL);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 539bb69548f2..20e26aa5b81c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16258,11 +16258,15 @@ static void i40e_remove(struct pci_dev *pdev)
 			i40e_switch_branch_release(pf->veb[i]);
 	}
 
-	/* Now we can shutdown the PF's VSI, just before we kill
+	/* Now we can shutdown the PF's VSIs, just before we kill
 	 * adminq and hmc.
 	 */
-	if (pf->vsi[pf->lan_vsi])
-		i40e_vsi_release(pf->vsi[pf->lan_vsi]);
+	for (i = pf->num_alloc_vsi; i--;)
+		if (pf->vsi[i]) {
+			i40e_vsi_close(pf->vsi[i]);
+			i40e_vsi_release(pf->vsi[i]);
+			pf->vsi[i] = NULL;
+		}
 
 	i40e_cloud_filter_exit(pf);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 8fc4ecc4f714..a718d42daeb5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1180,31 +1180,32 @@ static char *nix_mnqerr_e_str[NIX_MNQERR_MAX] = {
 };
 
 static char *nix_snd_status_e_str[NIX_SND_STATUS_MAX] =  {
-	"NIX_SND_STATUS_GOOD",
-	"NIX_SND_STATUS_SQ_CTX_FAULT",
-	"NIX_SND_STATUS_SQ_CTX_POISON",
-	"NIX_SND_STATUS_SQB_FAULT",
-	"NIX_SND_STATUS_SQB_POISON",
-	"NIX_SND_STATUS_HDR_ERR",
-	"NIX_SND_STATUS_EXT_ERR",
-	"NIX_SND_STATUS_JUMP_FAULT",
-	"NIX_SND_STATUS_JUMP_POISON",
-	"NIX_SND_STATUS_CRC_ERR",
-	"NIX_SND_STATUS_IMM_ERR",
-	"NIX_SND_STATUS_SG_ERR",
-	"NIX_SND_STATUS_MEM_ERR",
-	"NIX_SND_STATUS_INVALID_SUBDC",
-	"NIX_SND_STATUS_SUBDC_ORDER_ERR",
-	"NIX_SND_STATUS_DATA_FAULT",
-	"NIX_SND_STATUS_DATA_POISON",
-	"NIX_SND_STATUS_NPC_DROP_ACTION",
-	"NIX_SND_STATUS_LOCK_VIOL",
-	"NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
-	"NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
-	"NIX_SND_STATUS_NPC_MCAST_ABORT",
-	"NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
-	"NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
-	"NIX_SND_STATUS_SEND_STATS_ERR",
+	[NIX_SND_STATUS_GOOD] = "NIX_SND_STATUS_GOOD",
+	[NIX_SND_STATUS_SQ_CTX_FAULT] = "NIX_SND_STATUS_SQ_CTX_FAULT",
+	[NIX_SND_STATUS_SQ_CTX_POISON] = "NIX_SND_STATUS_SQ_CTX_POISON",
+	[NIX_SND_STATUS_SQB_FAULT] = "NIX_SND_STATUS_SQB_FAULT",
+	[NIX_SND_STATUS_SQB_POISON] = "NIX_SND_STATUS_SQB_POISON",
+	[NIX_SND_STATUS_HDR_ERR] = "NIX_SND_STATUS_HDR_ERR",
+	[NIX_SND_STATUS_EXT_ERR] = "NIX_SND_STATUS_EXT_ERR",
+	[NIX_SND_STATUS_JUMP_FAULT] = "NIX_SND_STATUS_JUMP_FAULT",
+	[NIX_SND_STATUS_JUMP_POISON] = "NIX_SND_STATUS_JUMP_POISON",
+	[NIX_SND_STATUS_CRC_ERR] = "NIX_SND_STATUS_CRC_ERR",
+	[NIX_SND_STATUS_IMM_ERR] = "NIX_SND_STATUS_IMM_ERR",
+	[NIX_SND_STATUS_SG_ERR] = "NIX_SND_STATUS_SG_ERR",
+	[NIX_SND_STATUS_MEM_ERR] = "NIX_SND_STATUS_MEM_ERR",
+	[NIX_SND_STATUS_INVALID_SUBDC] = "NIX_SND_STATUS_INVALID_SUBDC",
+	[NIX_SND_STATUS_SUBDC_ORDER_ERR] = "NIX_SND_STATUS_SUBDC_ORDER_ERR",
+	[NIX_SND_STATUS_DATA_FAULT] = "NIX_SND_STATUS_DATA_FAULT",
+	[NIX_SND_STATUS_DATA_POISON] = "NIX_SND_STATUS_DATA_POISON",
+	[NIX_SND_STATUS_NPC_DROP_ACTION] = "NIX_SND_STATUS_NPC_DROP_ACTION",
+	[NIX_SND_STATUS_LOCK_VIOL] = "NIX_SND_STATUS_LOCK_VIOL",
+	[NIX_SND_STATUS_NPC_UCAST_CHAN_ERR] = "NIX_SND_STAT_NPC_UCAST_CHAN_ERR",
+	[NIX_SND_STATUS_NPC_MCAST_CHAN_ERR] = "NIX_SND_STAT_NPC_MCAST_CHAN_ERR",
+	[NIX_SND_STATUS_NPC_MCAST_ABORT] = "NIX_SND_STATUS_NPC_MCAST_ABORT",
+	[NIX_SND_STATUS_NPC_VTAG_PTR_ERR] = "NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
+	[NIX_SND_STATUS_NPC_VTAG_SIZE_ERR] = "NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
+	[NIX_SND_STATUS_SEND_MEM_FAULT] = "NIX_SND_STATUS_SEND_MEM_FAULT",
+	[NIX_SND_STATUS_SEND_STATS_ERR] = "NIX_SND_STATUS_SEND_STATS_ERR",
 };
 
 static irqreturn_t otx2_q_intr_handler(int irq, void *data)
@@ -1224,14 +1225,16 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 			continue;
 
 		if (val & BIT_ULL(42)) {
-			netdev_err(pf->netdev, "CQ%lld: error reading NIX_LF_CQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
+			netdev_err(pf->netdev,
+				   "CQ%lld: error reading NIX_LF_CQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
 				   qidx, otx2_read64(pf, NIX_LF_ERR_INT));
 		} else {
 			if (val & BIT_ULL(NIX_CQERRINT_DOOR_ERR))
 				netdev_err(pf->netdev, "CQ%lld: Doorbell error",
 					   qidx);
 			if (val & BIT_ULL(NIX_CQERRINT_CQE_FAULT))
-				netdev_err(pf->netdev, "CQ%lld: Memory fault on CQE write to LLC/DRAM",
+				netdev_err(pf->netdev,
+					   "CQ%lld: Memory fault on CQE write to LLC/DRAM",
 					   qidx);
 		}
 
@@ -1254,7 +1257,8 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 			     (val & NIX_SQINT_BITS));
 
 		if (val & BIT_ULL(42)) {
-			netdev_err(pf->netdev, "SQ%lld: error reading NIX_LF_SQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
+			netdev_err(pf->netdev,
+				   "SQ%lld: error reading NIX_LF_SQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
 				   qidx, otx2_read64(pf, NIX_LF_ERR_INT));
 			goto done;
 		}
@@ -1264,8 +1268,11 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 			goto chk_mnq_err_dbg;
 
 		sq_op_err_code = FIELD_GET(GENMASK(7, 0), sq_op_err_dbg);
-		netdev_err(pf->netdev, "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(%llx)  err=%s\n",
-			   qidx, sq_op_err_dbg, nix_sqoperr_e_str[sq_op_err_code]);
+		netdev_err(pf->netdev,
+			   "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(0x%llx)  err=%s(%#x)\n",
+			   qidx, sq_op_err_dbg,
+			   nix_sqoperr_e_str[sq_op_err_code],
+			   sq_op_err_code);
 
 		otx2_write64(pf, NIX_LF_SQ_OP_ERR_DBG, BIT_ULL(44));
 
@@ -1282,16 +1289,21 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
 			goto chk_snd_err_dbg;
 
 		mnq_err_code = FIELD_GET(GENMASK(7, 0), mnq_err_dbg);
-		netdev_err(pf->netdev, "SQ%lld: NIX_LF_MNQ_ERR_DBG(%llx)  err=%s\n",
-			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code]);
+		netdev_err(pf->netdev,
+			   "SQ%lld: NIX_LF_MNQ_ERR_DBG(0x%llx)  err=%s(%#x)\n",
+			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code],
+			   mnq_err_code);
 		otx2_write64(pf, NIX_LF_MNQ_ERR_DBG, BIT_ULL(44));
 
 chk_snd_err_dbg:
 		snd_err_dbg = otx2_read64(pf, NIX_LF_SEND_ERR_DBG);
 		if (snd_err_dbg & BIT(44)) {
 			snd_err_code = FIELD_GET(GENMASK(7, 0), snd_err_dbg);
-			netdev_err(pf->netdev, "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=%s\n",
-				   qidx, snd_err_dbg, nix_snd_status_e_str[snd_err_code]);
+			netdev_err(pf->netdev,
+				   "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=%s(%#x)\n",
+				   qidx, snd_err_dbg,
+				   nix_snd_status_e_str[snd_err_code],
+				   snd_err_code);
 			otx2_write64(pf, NIX_LF_SEND_ERR_DBG, BIT_ULL(44));
 		}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
index e5f30fd778fc..e7fd9d955d65 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
@@ -311,23 +311,23 @@ enum nix_snd_status_e {
 	NIX_SND_STATUS_EXT_ERR = 0x6,
 	NIX_SND_STATUS_JUMP_FAULT = 0x7,
 	NIX_SND_STATUS_JUMP_POISON = 0x8,
-	NIX_SND_STATUS_CRC_ERR = 0x9,
-	NIX_SND_STATUS_IMM_ERR = 0x10,
-	NIX_SND_STATUS_SG_ERR = 0x11,
-	NIX_SND_STATUS_MEM_ERR = 0x12,
-	NIX_SND_STATUS_INVALID_SUBDC = 0x13,
-	NIX_SND_STATUS_SUBDC_ORDER_ERR = 0x14,
-	NIX_SND_STATUS_DATA_FAULT = 0x15,
-	NIX_SND_STATUS_DATA_POISON = 0x16,
-	NIX_SND_STATUS_NPC_DROP_ACTION = 0x17,
-	NIX_SND_STATUS_LOCK_VIOL = 0x18,
-	NIX_SND_STATUS_NPC_UCAST_CHAN_ERR = 0x19,
-	NIX_SND_STATUS_NPC_MCAST_CHAN_ERR = 0x20,
-	NIX_SND_STATUS_NPC_MCAST_ABORT = 0x21,
-	NIX_SND_STATUS_NPC_VTAG_PTR_ERR = 0x22,
-	NIX_SND_STATUS_NPC_VTAG_SIZE_ERR = 0x23,
-	NIX_SND_STATUS_SEND_MEM_FAULT = 0x24,
-	NIX_SND_STATUS_SEND_STATS_ERR = 0x25,
+	NIX_SND_STATUS_CRC_ERR = 0x10,
+	NIX_SND_STATUS_IMM_ERR = 0x11,
+	NIX_SND_STATUS_SG_ERR = 0x12,
+	NIX_SND_STATUS_MEM_ERR = 0x13,
+	NIX_SND_STATUS_INVALID_SUBDC = 0x14,
+	NIX_SND_STATUS_SUBDC_ORDER_ERR = 0x15,
+	NIX_SND_STATUS_DATA_FAULT = 0x16,
+	NIX_SND_STATUS_DATA_POISON = 0x17,
+	NIX_SND_STATUS_NPC_DROP_ACTION = 0x20,
+	NIX_SND_STATUS_LOCK_VIOL = 0x21,
+	NIX_SND_STATUS_NPC_UCAST_CHAN_ERR = 0x22,
+	NIX_SND_STATUS_NPC_MCAST_CHAN_ERR = 0x23,
+	NIX_SND_STATUS_NPC_MCAST_ABORT = 0x24,
+	NIX_SND_STATUS_NPC_VTAG_PTR_ERR = 0x25,
+	NIX_SND_STATUS_NPC_VTAG_SIZE_ERR = 0x26,
+	NIX_SND_STATUS_SEND_MEM_FAULT = 0x27,
+	NIX_SND_STATUS_SEND_STATS_ERR = 0x28,
 	NIX_SND_STATUS_MAX,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index dbd3bebf11ec..2e8b17e3b935 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -251,7 +251,7 @@ mlxsw_sp_acl_bf_init(struct mlxsw_sp *mlxsw_sp, unsigned int num_erp_banks)
 	 * is 2^ACL_MAX_BF_LOG
 	 */
 	bf_bank_size = 1 << MLXSW_CORE_RES_GET(mlxsw_sp->core, ACL_MAX_BF_LOG);
-	bf = kzalloc(struct_size(bf, refcnt, bf_bank_size * num_erp_banks),
+	bf = kzalloc(struct_size(bf, refcnt, size_mul(bf_bank_size, num_erp_banks)),
 		     GFP_KERNEL);
 	if (!bf)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 1cd0928472c0..4cb2510f6fac 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2549,9 +2549,13 @@ static void rtl_set_rx_mode(struct net_device *dev)
 
 	if (dev->flags & IFF_PROMISC) {
 		rx_mode |= AcceptAllPhys;
+	} else if (!(dev->flags & IFF_MULTICAST)) {
+		rx_mode &= ~AcceptMulticast;
 	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
 		   dev->flags & IFF_ALLMULTI ||
-		   tp->mac_version == RTL_GIGA_MAC_VER_35) {
+		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_46 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_48) {
 		/* accept all multicasts */
 	} else if (netdev_mc_empty(dev)) {
 		rx_mode &= ~AcceptMulticast;
@@ -4656,12 +4660,17 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 static void r8169_phylink_handler(struct net_device *ndev)
 {
 	struct rtl8169_private *tp = netdev_priv(ndev);
+	struct device *d = tp_to_dev(tp);
 
 	if (netif_carrier_ok(ndev)) {
 		rtl_link_chg_patch(tp);
-		pm_request_resume(&tp->pci_dev->dev);
+		pm_request_resume(d);
+		netif_wake_queue(tp->dev);
 	} else {
-		pm_runtime_idle(&tp->pci_dev->dev);
+		/* In few cases rx is broken after link-down otherwise */
+		if (rtl_is_8125(tp))
+			rtl_reset_work(tp);
+		pm_runtime_idle(d);
 	}
 
 	if (net_ratelimit())
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 1913385df685..880a75bf2eb1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -222,7 +222,7 @@
 	((val) << XGMAC_PPS_MINIDX(x))
 #define XGMAC_PPSCMD_START		0x2
 #define XGMAC_PPSCMD_STOP		0x5
-#define XGMAC_PPSEN0			BIT(4)
+#define XGMAC_PPSENx(x)			BIT(4 + (x) * 8)
 #define XGMAC_PPSx_TARGET_TIME_SEC(x)	(0x00000d80 + (x) * 0x10)
 #define XGMAC_PPSx_TARGET_TIME_NSEC(x)	(0x00000d84 + (x) * 0x10)
 #define XGMAC_TRGTBUSY0			BIT(31)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index c4d78fa93663..54aa0fbd1bf6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1134,7 +1134,19 @@ static int dwxgmac2_flex_pps_config(void __iomem *ioaddr, int index,
 
 	val |= XGMAC_PPSCMDx(index, XGMAC_PPSCMD_START);
 	val |= XGMAC_TRGTMODSELx(index, XGMAC_PPSCMD_START);
-	val |= XGMAC_PPSEN0;
+
+	/* XGMAC Core has 4 PPS outputs at most.
+	 *
+	 * Prior XGMAC Core 3.20, Fixed mode or Flexible mode are selectable for
+	 * PPS0 only via PPSEN0. PPS{1,2,3} are in Flexible mode by default,
+	 * and can not be switched to Fixed mode, since PPSEN{1,2,3} are
+	 * read-only reserved to 0.
+	 * But we always set PPSEN{1,2,3} do not make things worse ;-)
+	 *
+	 * From XGMAC Core 3.20 and later, PPSEN{0,1,2,3} are writable and must
+	 * be set, or the PPS outputs stay in Fixed PPS mode by default.
+	 */
+	val |= XGMAC_PPSENx(index);
 
 	writel(cfg->start.tv_sec, ioaddr + XGMAC_PPSx_TARGET_TIME_SEC(index));
 
diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index 66d4e024d11e..f62fbb1087a9 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -2332,7 +2332,7 @@ spider_net_alloc_card(void)
 	struct spider_net_card *card;
 
 	netdev = alloc_etherdev(struct_size(card, darray,
-					    tx_descriptors + rx_descriptors));
+					    size_add(tx_descriptors, rx_descriptors)));
 	if (!netdev)
 		return NULL;
 
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index e10cb98b0f4f..905542df3b68 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -442,12 +442,12 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
 
 	err = ip_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out;
 err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out:
 	return ret;
@@ -483,12 +483,12 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 
 	err = ip6_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out;
 err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out:
 	return ret;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index c199f0b465cd..8660d452f642 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -324,6 +324,7 @@ static void ipvlan_get_stats64(struct net_device *dev,
 		s->rx_dropped = rx_errs;
 		s->tx_dropped = tx_drps;
 	}
+	s->tx_errors = DEV_STATS_READ(dev, tx_errors);
 }
 
 static int ipvlan_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 07c822c30118..ab134fe1fda6 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3681,9 +3681,9 @@ static void macsec_get_stats64(struct net_device *dev,
 
 	dev_fetch_sw_netstats(s, dev->tstats);
 
-	s->rx_dropped = atomic_long_read(&dev->stats.__rx_dropped);
-	s->tx_dropped = atomic_long_read(&dev->stats.__tx_dropped);
-	s->rx_errors = atomic_long_read(&dev->stats.__rx_errors);
+	s->rx_dropped = DEV_STATS_READ(dev, rx_dropped);
+	s->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
+	s->rx_errors = DEV_STATS_READ(dev, rx_errors);
 }
 
 static int macsec_get_iflink(const struct net_device *dev)
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 847b8e07f81c..a6999ca75377 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -3,6 +3,7 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2023 Intel Corporation
  *
  * Contact Information:
  *  Intel Linux Wireless <linuxwifi@intel.com>
@@ -1174,7 +1175,7 @@ void iwlagn_rx_reply_tx(struct iwl_priv *priv, struct iwl_rx_cmd_buffer *rxb)
 			iwlagn_check_ratid_empty(priv, sta_id, tid);
 		}
 
-		iwl_trans_reclaim(priv->trans, txq_id, ssn, &skbs);
+		iwl_trans_reclaim(priv->trans, txq_id, ssn, &skbs, false);
 
 		freed = 0;
 
@@ -1320,7 +1321,7 @@ void iwlagn_rx_reply_compressed_ba(struct iwl_priv *priv,
 	 * block-ack window (we assume that they've been successfully
 	 * transmitted ... if not, it's too late anyway). */
 	iwl_trans_reclaim(priv->trans, scd_flow, ba_resp_scd_ssn,
-			  &reclaimed_skbs);
+			  &reclaimed_skbs, false);
 
 	IWL_DEBUG_TX_REPLY(priv, "REPLY_COMPRESSED_BA [%d] Received from %pM, "
 			   "sta_id = %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 8f0ff540f439..a2919a32d708 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -539,7 +539,7 @@ struct iwl_trans_ops {
 	int (*tx)(struct iwl_trans *trans, struct sk_buff *skb,
 		  struct iwl_device_tx_cmd *dev_cmd, int queue);
 	void (*reclaim)(struct iwl_trans *trans, int queue, int ssn,
-			struct sk_buff_head *skbs);
+			struct sk_buff_head *skbs, bool is_flush);
 
 	void (*set_q_ptrs)(struct iwl_trans *trans, int queue, int ptr);
 
@@ -1122,14 +1122,15 @@ static inline int iwl_trans_tx(struct iwl_trans *trans, struct sk_buff *skb,
 }
 
 static inline void iwl_trans_reclaim(struct iwl_trans *trans, int queue,
-				     int ssn, struct sk_buff_head *skbs)
+				     int ssn, struct sk_buff_head *skbs,
+				     bool is_flush)
 {
 	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
 		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
 		return;
 	}
 
-	trans->ops->reclaim(trans, queue, ssn, skbs);
+	trans->ops->reclaim(trans, queue, ssn, skbs, is_flush);
 }
 
 static inline void iwl_trans_set_q_ptrs(struct iwl_trans *trans, int queue,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index b127e0b527ce..4375da00f7cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1432,7 +1432,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	seq_ctl = le16_to_cpu(tx_resp->seq_ctl);
 
 	/* we can free until ssn % q.n_bd not inclusive */
-	iwl_trans_reclaim(mvm->trans, txq_id, ssn, &skbs);
+	iwl_trans_reclaim(mvm->trans, txq_id, ssn, &skbs, false);
 
 	while (!skb_queue_empty(&skbs)) {
 		struct sk_buff *skb = __skb_dequeue(&skbs);
@@ -1777,7 +1777,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	 * block-ack window (we assume that they've been successfully
 	 * transmitted ... if not, it's too late anyway).
 	 */
-	iwl_trans_reclaim(mvm->trans, txq, index, &reclaimed_skbs);
+	iwl_trans_reclaim(mvm->trans, txq, index, &reclaimed_skbs, is_flush);
 
 	skb_queue_walk(&reclaimed_skbs, skb) {
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 6dce36d32693..74959de9d700 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2003-2015, 2018-2021 Intel Corporation
+ * Copyright (C) 2003-2015, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -103,6 +103,18 @@ struct iwl_rx_completion_desc {
 	u8 reserved2[25];
 } __packed;
 
+/**
+ * struct iwl_rx_completion_desc_bz - Bz completion descriptor
+ * @rbid: unique tag of the received buffer
+ * @flags: flags (0: fragmented, all others: reserved)
+ * @reserved: reserved
+ */
+struct iwl_rx_completion_desc_bz {
+	__le16 rbid;
+	u8 flags;
+	u8 reserved[1];
+} __packed;
+
 /**
  * struct iwl_rxq - Rx queue
  * @id: queue index
@@ -133,11 +145,7 @@ struct iwl_rxq {
 	int id;
 	void *bd;
 	dma_addr_t bd_dma;
-	union {
-		void *used_bd;
-		__le32 *bd_32;
-		struct iwl_rx_completion_desc *cd;
-	};
+	void *used_bd;
 	dma_addr_t used_bd_dma;
 	u32 read;
 	u32 write;
@@ -472,6 +480,7 @@ int iwl_pcie_rx_stop(struct iwl_trans *trans);
 void iwl_pcie_rx_free(struct iwl_trans *trans);
 void iwl_pcie_free_rbs_pool(struct iwl_trans *trans);
 void iwl_pcie_rx_init_rxb_lists(struct iwl_rxq *rxq);
+void iwl_pcie_rx_napi_sync(struct iwl_trans *trans);
 void iwl_pcie_rxq_alloc_rbs(struct iwl_trans *trans, gfp_t priority,
 			    struct iwl_rxq *rxq);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index f82fb1745016..df201d40f6c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -652,23 +652,30 @@ void iwl_pcie_rx_allocator_work(struct work_struct *data)
 	iwl_pcie_rx_allocator(trans_pcie->trans);
 }
 
-static int iwl_pcie_free_bd_size(struct iwl_trans *trans, bool use_rx_td)
+static int iwl_pcie_free_bd_size(struct iwl_trans *trans)
 {
-	struct iwl_rx_transfer_desc *rx_td;
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		return sizeof(struct iwl_rx_transfer_desc);
 
-	if (use_rx_td)
-		return sizeof(*rx_td);
-	else
-		return trans->trans_cfg->mq_rx_supported ? sizeof(__le64) :
-			sizeof(__le32);
+	return trans->trans_cfg->mq_rx_supported ?
+			sizeof(__le64) : sizeof(__le32);
+}
+
+static int iwl_pcie_used_bd_size(struct iwl_trans *trans)
+{
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		return sizeof(struct iwl_rx_completion_desc_bz);
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		return sizeof(struct iwl_rx_completion_desc);
+
+	return sizeof(__le32);
 }
 
 static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 				  struct iwl_rxq *rxq)
 {
-	bool use_rx_td = (trans->trans_cfg->device_family >=
-			  IWL_DEVICE_FAMILY_AX210);
-	int free_size = iwl_pcie_free_bd_size(trans, use_rx_td);
+	int free_size = iwl_pcie_free_bd_size(trans);
 
 	if (rxq->bd)
 		dma_free_coherent(trans->dev,
@@ -682,8 +689,8 @@ static void iwl_pcie_free_rxq_dma(struct iwl_trans *trans,
 
 	if (rxq->used_bd)
 		dma_free_coherent(trans->dev,
-				  (use_rx_td ? sizeof(*rxq->cd) :
-				   sizeof(__le32)) * rxq->queue_size,
+				  iwl_pcie_used_bd_size(trans) *
+					rxq->queue_size,
 				  rxq->used_bd, rxq->used_bd_dma);
 	rxq->used_bd_dma = 0;
 	rxq->used_bd = NULL;
@@ -707,7 +714,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 	else
 		rxq->queue_size = RX_QUEUE_SIZE;
 
-	free_size = iwl_pcie_free_bd_size(trans, use_rx_td);
+	free_size = iwl_pcie_free_bd_size(trans);
 
 	/*
 	 * Allocate the circular buffer of Read Buffer Descriptors
@@ -720,7 +727,8 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 
 	if (trans->trans_cfg->mq_rx_supported) {
 		rxq->used_bd = dma_alloc_coherent(dev,
-						  (use_rx_td ? sizeof(*rxq->cd) : sizeof(__le32)) * rxq->queue_size,
+						  iwl_pcie_used_bd_size(trans) *
+							rxq->queue_size,
 						  &rxq->used_bd_dma,
 						  GFP_KERNEL);
 		if (!rxq->used_bd)
@@ -1042,6 +1050,22 @@ static int iwl_pcie_napi_poll_msix(struct napi_struct *napi, int budget)
 	return ret;
 }
 
+void iwl_pcie_rx_napi_sync(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int i;
+
+	if (unlikely(!trans_pcie->rxq))
+		return;
+
+	for (i = 0; i < trans->num_rx_queues; i++) {
+		struct iwl_rxq *rxq = &trans_pcie->rxq[i];
+
+		if (rxq && rxq->napi.poll)
+			napi_synchronize(&rxq->napi);
+	}
+}
+
 static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -1419,6 +1443,7 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 	u16 vid;
 
 	BUILD_BUG_ON(sizeof(struct iwl_rx_completion_desc) != 32);
+	BUILD_BUG_ON(sizeof(struct iwl_rx_completion_desc_bz) != 4);
 
 	if (!trans->trans_cfg->mq_rx_supported) {
 		rxb = rxq->queue[i];
@@ -1426,11 +1451,20 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 		return rxb;
 	}
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		vid = le16_to_cpu(rxq->cd[i].rbid);
-		*join = rxq->cd[i].flags & IWL_RX_CD_FLAGS_FRAGMENTED;
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		struct iwl_rx_completion_desc_bz *cd = rxq->used_bd;
+
+		vid = le16_to_cpu(cd[i].rbid);
+		*join = cd[i].flags & IWL_RX_CD_FLAGS_FRAGMENTED;
+	} else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		struct iwl_rx_completion_desc *cd = rxq->used_bd;
+
+		vid = le16_to_cpu(cd[i].rbid);
+		*join = cd[i].flags & IWL_RX_CD_FLAGS_FRAGMENTED;
 	} else {
-		vid = le32_to_cpu(rxq->bd_32[i]) & 0x0FFF; /* 12-bit VID */
+		__le32 *cd = rxq->used_bd;
+
+		vid = le32_to_cpu(cd[i]) & 0x0FFF; /* 12-bit VID */
 	}
 
 	if (!vid || vid > RX_POOL_SIZE(trans_pcie->num_rx_bufs))
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index a9c19be29e92..1b25a6627e5c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -165,6 +165,8 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
+		iwl_pcie_synchronize_irqs(trans);
+		iwl_pcie_rx_napi_sync(trans);
 		iwl_txq_gen2_tx_free(trans);
 		iwl_pcie_rx_stop(trans);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 4456aef930cf..b7b2d28b3e43 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1197,6 +1197,8 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
+		iwl_pcie_synchronize_irqs(trans);
+		iwl_pcie_rx_napi_sync(trans);
 		iwl_pcie_tx_stop(trans);
 		iwl_pcie_rx_stop(trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 8522cdfc9e5d..cd852b95d812 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1520,7 +1520,7 @@ void iwl_txq_progress(struct iwl_txq *txq)
 
 /* Frees buffers until index _not_ inclusive */
 void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
-		     struct sk_buff_head *skbs)
+		     struct sk_buff_head *skbs, bool is_flush)
 {
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	int tfd_num = iwl_txq_get_cmd_index(txq, ssn);
@@ -1591,9 +1591,11 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	if (iwl_txq_space(trans, txq) > txq->low_mark &&
 	    test_bit(txq_id, trans->txqs.queue_stopped)) {
 		struct sk_buff_head overflow_skbs;
+		struct sk_buff *skb;
 
 		__skb_queue_head_init(&overflow_skbs);
-		skb_queue_splice_init(&txq->overflow_q, &overflow_skbs);
+		skb_queue_splice_init(&txq->overflow_q,
+				      is_flush ? skbs : &overflow_skbs);
 
 		/*
 		 * We are going to transmit from the overflow queue.
@@ -1613,8 +1615,7 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		 */
 		spin_unlock_bh(&txq->lock);
 
-		while (!skb_queue_empty(&overflow_skbs)) {
-			struct sk_buff *skb = __skb_dequeue(&overflow_skbs);
+		while ((skb = __skb_dequeue(&overflow_skbs))) {
 			struct iwl_device_tx_cmd *dev_cmd_ptr;
 
 			dev_cmd_ptr = *(void **)((u8 *)skb->cb +
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 19178c88bb22..f488fc9f6b83 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -174,7 +174,7 @@ void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 				      struct iwl_txq *txq, u16 byte_cnt,
 				      int num_tbs);
 void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
-		     struct sk_buff_head *skbs);
+		     struct sk_buff_head *skbs, bool is_flush);
 void iwl_txq_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
 void iwl_trans_txq_freeze_timer(struct iwl_trans *trans, unsigned long txqs,
 				bool freeze);
diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 69e0e68757f5..f225a34e2186 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -16,11 +16,11 @@ mt76_alloc_txwi(struct mt76_dev *dev)
 	int size;
 
 	size = L1_CACHE_ALIGN(dev->drv->txwi_size + sizeof(*t));
-	txwi = devm_kzalloc(dev->dev, size, GFP_ATOMIC);
+	txwi = kzalloc(size, GFP_ATOMIC);
 	if (!txwi)
 		return NULL;
 
-	addr = dma_map_single(dev->dev, txwi, dev->drv->txwi_size,
+	addr = dma_map_single(dev->dma_dev, txwi, dev->drv->txwi_size,
 			      DMA_TO_DEVICE);
 	t = (struct mt76_txwi_cache *)(txwi + dev->drv->txwi_size);
 	t->dma_addr = addr;
@@ -73,9 +73,11 @@ mt76_free_pending_txwi(struct mt76_dev *dev)
 	struct mt76_txwi_cache *t;
 
 	local_bh_disable();
-	while ((t = __mt76_get_txwi(dev)) != NULL)
-		dma_unmap_single(dev->dev, t->dma_addr, dev->drv->txwi_size,
+	while ((t = __mt76_get_txwi(dev)) != NULL) {
+		dma_unmap_single(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
 				 DMA_TO_DEVICE);
+		kfree(mt76_get_txwi_ptr(dev, t));
+	}
 	local_bh_enable();
 }
 
@@ -121,7 +123,7 @@ mt76_dma_alloc_queue(struct mt76_dev *dev, struct mt76_queue *q,
 	q->hw_idx = idx;
 
 	size = q->ndesc * sizeof(struct mt76_desc);
-	q->desc = dmam_alloc_coherent(dev->dev, size, &q->desc_dma, GFP_KERNEL);
+	q->desc = dmam_alloc_coherent(dev->dma_dev, size, &q->desc_dma, GFP_KERNEL);
 	if (!q->desc)
 		return -ENOMEM;
 
@@ -203,11 +205,11 @@ mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	struct mt76_queue_entry *e = &q->entry[idx];
 
 	if (!e->skip_buf0)
-		dma_unmap_single(dev->dev, e->dma_addr[0], e->dma_len[0],
+		dma_unmap_single(dev->dma_dev, e->dma_addr[0], e->dma_len[0],
 				 DMA_TO_DEVICE);
 
 	if (!e->skip_buf1)
-		dma_unmap_single(dev->dev, e->dma_addr[1], e->dma_len[1],
+		dma_unmap_single(dev->dma_dev, e->dma_addr[1], e->dma_len[1],
 				 DMA_TO_DEVICE);
 
 	if (e->txwi == DMA_DUMMY_DATA)
@@ -288,7 +290,7 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	if (info)
 		*info = le32_to_cpu(desc->info);
 
-	dma_unmap_single(dev->dev, buf_addr, buf_len, DMA_FROM_DEVICE);
+	dma_unmap_single(dev->dma_dev, buf_addr, buf_len, DMA_FROM_DEVICE);
 	e->buf = NULL;
 
 	return buf;
@@ -325,9 +327,9 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 	if (q->queued + 1 >= q->ndesc - 1)
 		goto error;
 
-	addr = dma_map_single(dev->dev, skb->data, skb->len,
+	addr = dma_map_single(dev->dma_dev, skb->data, skb->len,
 			      DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev->dev, addr)))
+	if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
 		goto error;
 
 	buf.addr = addr;
@@ -347,8 +349,8 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 
 static int
 mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
-		      struct sk_buff *skb, struct mt76_wcid *wcid,
-		      struct ieee80211_sta *sta)
+		      enum mt76_txq_id qid, struct sk_buff *skb,
+		      struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct ieee80211_tx_status status = {
 		.sta = sta,
@@ -374,8 +376,8 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		mt76_insert_hdr_pad(skb);
 
 	len = skb_headlen(skb);
-	addr = dma_map_single(dev->dev, skb->data, len, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev->dev, addr)))
+	addr = dma_map_single(dev->dma_dev, skb->data, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
 		goto free;
 
 	tx_info.buf[n].addr = t->dma_addr;
@@ -387,9 +389,9 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		if (n == ARRAY_SIZE(tx_info.buf))
 			goto unmap;
 
-		addr = dma_map_single(dev->dev, iter->data, iter->len,
+		addr = dma_map_single(dev->dma_dev, iter->data, iter->len,
 				      DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(dev->dev, addr)))
+		if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
 			goto unmap;
 
 		tx_info.buf[n].addr = addr;
@@ -402,10 +404,10 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		goto unmap;
 	}
 
-	dma_sync_single_for_cpu(dev->dev, t->dma_addr, dev->drv->txwi_size,
+	dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
 				DMA_TO_DEVICE);
-	ret = dev->drv->tx_prepare_skb(dev, txwi, q->qid, wcid, sta, &tx_info);
-	dma_sync_single_for_device(dev->dev, t->dma_addr, dev->drv->txwi_size,
+	ret = dev->drv->tx_prepare_skb(dev, txwi, qid, wcid, sta, &tx_info);
+	dma_sync_single_for_device(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
 				   DMA_TO_DEVICE);
 	if (ret < 0)
 		goto unmap;
@@ -415,7 +417,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 
 unmap:
 	for (n--; n > 0; n--)
-		dma_unmap_single(dev->dev, tx_info.buf[n].addr,
+		dma_unmap_single(dev->dma_dev, tx_info.buf[n].addr,
 				 tx_info.buf[n].len, DMA_TO_DEVICE);
 
 free:
@@ -459,8 +461,8 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_queue *q)
 		if (!buf)
 			break;
 
-		addr = dma_map_single(dev->dev, buf, len, DMA_FROM_DEVICE);
-		if (unlikely(dma_mapping_error(dev->dev, addr))) {
+		addr = dma_map_single(dev->dma_dev, buf, len, DMA_FROM_DEVICE);
+		if (unlikely(dma_mapping_error(dev->dma_dev, addr))) {
 			skb_free_frag(buf);
 			break;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 028519a739fd..3c7d5abe9cc2 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -428,6 +428,7 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	dev->hw = hw;
 	dev->dev = pdev;
 	dev->drv = drv_ops;
+	dev->dma_dev = pdev;
 
 	phy = &dev->phy;
 	phy->dev = dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index eb1fb955b777..27f04fb2796d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -195,8 +195,8 @@ struct mt76_queue_ops {
 		     u32 ring_base);
 
 	int (*tx_queue_skb)(struct mt76_dev *dev, struct mt76_queue *q,
-			    struct sk_buff *skb, struct mt76_wcid *wcid,
-			    struct ieee80211_sta *sta);
+			    enum mt76_txq_id qid, struct sk_buff *skb,
+			    struct mt76_wcid *wcid, struct ieee80211_sta *sta);
 
 	int (*tx_queue_skb_raw)(struct mt76_dev *dev, struct mt76_queue *q,
 				struct sk_buff *skb, u32 tx_info);
@@ -660,6 +660,7 @@ struct mt76_dev {
 	const struct mt76_driver_ops *drv;
 	const struct mt76_mcu_ops *mcu_ops;
 	struct device *dev;
+	struct device *dma_dev;
 
 	struct mt76_mcu mcu;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 5d4522f440b7..7fa6b0ed9d47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -9,6 +9,23 @@ struct beacon_bc_data {
 	int count[MT7603_MAX_INTERFACES];
 };
 
+static void
+mt7603_mac_stuck_beacon_recovery(struct mt7603_dev *dev)
+{
+	if (dev->beacon_check % 5 != 4)
+		return;
+
+	mt76_clear(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_TX_DMA_EN);
+	mt76_set(dev, MT_SCH_4, MT_SCH_4_RESET);
+	mt76_clear(dev, MT_SCH_4, MT_SCH_4_RESET);
+	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_TX_DMA_EN);
+
+	mt76_set(dev, MT_WF_CFG_OFF_WOCCR, MT_WF_CFG_OFF_WOCCR_TMAC_GC_DIS);
+	mt76_set(dev, MT_ARB_SCR, MT_ARB_SCR_TX_DISABLE);
+	mt76_clear(dev, MT_ARB_SCR, MT_ARB_SCR_TX_DISABLE);
+	mt76_clear(dev, MT_WF_CFG_OFF_WOCCR, MT_WF_CFG_OFF_WOCCR_TMAC_GC_DIS);
+}
+
 static void
 mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 {
@@ -16,6 +33,8 @@ mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
 	struct sk_buff *skb = NULL;
+	u32 om_idx = mvif->idx;
+	u32 val;
 
 	if (!(mdev->beacon_mask & BIT(mvif->idx)))
 		return;
@@ -24,20 +43,33 @@ mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!skb)
 		return;
 
-	mt76_tx_queue_skb(dev, dev->mphy.q_tx[MT_TXQ_BEACON], skb,
-			  &mvif->sta.wcid, NULL);
+	if (om_idx)
+		om_idx |= 0x10;
+	val = MT_DMA_FQCR0_BUSY | MT_DMA_FQCR0_MODE |
+		FIELD_PREP(MT_DMA_FQCR0_TARGET_BSS, om_idx) |
+		FIELD_PREP(MT_DMA_FQCR0_DEST_PORT_ID, 3) |
+		FIELD_PREP(MT_DMA_FQCR0_DEST_QUEUE_ID, 8);
 
 	spin_lock_bh(&dev->ps_lock);
-	mt76_wr(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY |
-		FIELD_PREP(MT_DMA_FQCR0_TARGET_WCID, mvif->sta.wcid.idx) |
-		FIELD_PREP(MT_DMA_FQCR0_TARGET_QID,
-			   dev->mphy.q_tx[MT_TXQ_CAB]->hw_idx) |
-		FIELD_PREP(MT_DMA_FQCR0_DEST_PORT_ID, 3) |
-		FIELD_PREP(MT_DMA_FQCR0_DEST_QUEUE_ID, 8));
 
-	if (!mt76_poll(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY, 0, 5000))
+	mt76_wr(dev, MT_DMA_FQCR0, val |
+		FIELD_PREP(MT_DMA_FQCR0_TARGET_QID, MT_TX_HW_QUEUE_BCN));
+	if (!mt76_poll(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY, 0, 5000)) {
 		dev->beacon_check = MT7603_WATCHDOG_TIMEOUT;
+		goto out;
+	}
+
+	mt76_wr(dev, MT_DMA_FQCR0, val |
+		FIELD_PREP(MT_DMA_FQCR0_TARGET_QID, MT_TX_HW_QUEUE_BMC));
+	if (!mt76_poll(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY, 0, 5000)) {
+		dev->beacon_check = MT7603_WATCHDOG_TIMEOUT;
+		goto out;
+	}
 
+	mt76_tx_queue_skb(dev, dev->mphy.q_tx[MT_TXQ_BEACON],
+			  MT_TXQ_BEACON, skb, &mvif->sta.wcid, NULL);
+
+out:
 	spin_unlock_bh(&dev->ps_lock);
 }
 
@@ -81,6 +113,18 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 	data.dev = dev;
 	__skb_queue_head_init(&data.q);
 
+	/* Flush all previous CAB queue packets and beacons */
+	mt76_wr(dev, MT_WF_ARB_CAB_FLUSH, GENMASK(30, 16) | BIT(0));
+
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_CAB], false);
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BEACON], false);
+
+	if (dev->mphy.q_tx[MT_TXQ_BEACON]->queued > 0)
+		dev->beacon_check++;
+	else
+		dev->beacon_check = 0;
+	mt7603_mac_stuck_beacon_recovery(dev);
+
 	q = dev->mphy.q_tx[MT_TXQ_BEACON];
 	spin_lock_bh(&q->lock);
 	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
@@ -89,14 +133,9 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 	mt76_queue_kick(dev, q);
 	spin_unlock_bh(&q->lock);
 
-	/* Flush all previous CAB queue packets */
-	mt76_wr(dev, MT_WF_ARB_CAB_FLUSH, GENMASK(30, 16) | BIT(0));
-
-	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_CAB], false);
-
 	mt76_csa_check(mdev);
 	if (mdev->csa_complete)
-		goto out;
+		return;
 
 	q = dev->mphy.q_tx[MT_TXQ_CAB];
 	do {
@@ -108,7 +147,7 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 		 skb_queue_len(&data.q) < 8);
 
 	if (skb_queue_empty(&data.q))
-		goto out;
+		return;
 
 	for (i = 0; i < ARRAY_SIZE(data.tail); i++) {
 		if (!data.tail[i])
@@ -123,7 +162,7 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 		struct ieee80211_vif *vif = info->control.vif;
 		struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
 
-		mt76_tx_queue_skb(dev, q, skb, &mvif->sta.wcid, NULL);
+		mt76_tx_queue_skb(dev, q, MT_TXQ_CAB, skb, &mvif->sta.wcid, NULL);
 	}
 	mt76_queue_kick(dev, q);
 	spin_unlock_bh(&q->lock);
@@ -136,11 +175,6 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 		MT_WF_ARB_CAB_START_BSSn(0) |
 		(MT_WF_ARB_CAB_START_BSS0n(1) *
 		 ((1 << (MT7603_MAX_INTERFACES - 1)) - 1)));
-
-out:
-	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BEACON], false);
-	if (dev->mphy.q_tx[MT_TXQ_BEACON]->queued > hweight8(mdev->beacon_mask))
-		dev->beacon_check++;
 }
 
 void mt7603_beacon_set_timer(struct mt7603_dev *dev, int idx, int intval)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/core.c b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
index 60a996b63c0c..915b8349146a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
@@ -42,11 +42,13 @@ irqreturn_t mt7603_irq_handler(int irq, void *dev_instance)
 	}
 
 	if (intr & MT_INT_RX_DONE(0)) {
+		dev->rx_pse_check = 0;
 		mt7603_irq_disable(dev, MT_INT_RX_DONE(0));
 		napi_schedule(&dev->mt76.napi[0]);
 	}
 
 	if (intr & MT_INT_RX_DONE(1)) {
+		dev->rx_pse_check = 0;
 		mt7603_irq_disable(dev, MT_INT_RX_DONE(1));
 		napi_schedule(&dev->mt76.napi[1]);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 3745512b1eb3..915a1043c869 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1561,20 +1561,29 @@ static bool mt7603_rx_pse_busy(struct mt7603_dev *dev)
 {
 	u32 addr, val;
 
-	if (mt76_rr(dev, MT_MCU_DEBUG_RESET) & MT_MCU_DEBUG_RESET_QUEUES)
-		return true;
-
 	if (mt7603_rx_fifo_busy(dev))
-		return false;
+		goto out;
 
 	addr = mt7603_reg_map(dev, MT_CLIENT_BASE_PHYS_ADDR + MT_CLIENT_STATUS);
 	mt76_wr(dev, addr, 3);
 	val = mt76_rr(dev, addr) >> 16;
 
-	if (is_mt7628(dev) && (val & 0x4001) == 0x4001)
-		return true;
+	if (!(val & BIT(0)))
+		return false;
+
+	if (is_mt7628(dev))
+		val &= 0xa000;
+	else
+		val &= 0x8000;
+	if (!val)
+		return false;
+
+out:
+	if (mt76_rr(dev, MT_INT_SOURCE_CSR) &
+	    (MT_INT_RX_DONE(0) | MT_INT_RX_DONE(1)))
+		return false;
 
-	return (val & 0x8001) == 0x8001 || (val & 0xe001) == 0xe001;
+	return true;
 }
 
 static bool
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
index 3b901090b29c..9b84db233ace 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
@@ -462,6 +462,11 @@ enum {
 #define MT_WF_SEC_BASE			0x21a00
 #define MT_WF_SEC(ofs)			(MT_WF_SEC_BASE + (ofs))
 
+#define MT_WF_CFG_OFF_BASE		0x21e00
+#define MT_WF_CFG_OFF(ofs)		(MT_WF_CFG_OFF_BASE + (ofs))
+#define MT_WF_CFG_OFF_WOCCR		MT_WF_CFG_OFF(0x004)
+#define MT_WF_CFG_OFF_WOCCR_TMAC_GC_DIS	BIT(4)
+
 #define MT_SEC_SCR			MT_WF_SEC(0x004)
 #define MT_SEC_SCR_MASK_ORDER		GENMASK(1, 0)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index b50084bbe83d..6ba3a7975e1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -59,7 +59,8 @@ static void mt76x02_pre_tbtt_tasklet(struct tasklet_struct *t)
 		struct ieee80211_vif *vif = info->control.vif;
 		struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 
-		mt76_tx_queue_skb(dev, q, skb, &mvif->group_wcid, NULL);
+		mt76_tx_queue_skb(dev, q, MT_TXQ_PSD, skb, &mvif->group_wcid,
+				  NULL);
 	}
 	spin_unlock_bh(&q->lock);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 9e639d0b9c63..4964f19558be 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -243,8 +243,8 @@ static void mt76s_tx_status_data(struct work_struct *work)
 
 static int
 mt76s_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
-		   struct sk_buff *skb, struct mt76_wcid *wcid,
-		   struct ieee80211_sta *sta)
+		   enum mt76_txq_id qid, struct sk_buff *skb,
+		   struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
@@ -256,7 +256,7 @@ mt76s_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		return -ENOSPC;
 
 	skb->prev = skb->next = NULL;
-	err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
+	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 0109433e8c2f..12b13946fba1 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -49,8 +49,8 @@ void mt76_testmode_tx_pending(struct mt76_phy *phy)
 	       q->queued < q->ndesc / 2) {
 		int ret;
 
-		ret = dev->queue_ops->tx_queue_skb(dev, q, skb_get(skb), wcid,
-						   NULL);
+		ret = dev->queue_ops->tx_queue_skb(dev, q, qid, skb_get(skb),
+						   wcid, NULL);
 		if (ret < 0)
 			break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 7d126634547f..134a735a0632 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -259,7 +259,7 @@ __mt76_tx_queue_skb(struct mt76_phy *phy, int qid, struct sk_buff *skb,
 	int idx;
 
 	non_aql = !info->tx_time_est;
-	idx = dev->queue_ops->tx_queue_skb(dev, q, skb, wcid, sta);
+	idx = dev->queue_ops->tx_queue_skb(dev, q, qid, skb, wcid, sta);
 	if (idx < 0 || !sta)
 		return idx;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index b47343e321b8..392632c3f1b1 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -901,8 +901,8 @@ mt76u_tx_setup_buffers(struct mt76_dev *dev, struct sk_buff *skb,
 
 static int
 mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
-		   struct sk_buff *skb, struct mt76_wcid *wcid,
-		   struct ieee80211_sta *sta)
+		   enum mt76_txq_id qid, struct sk_buff *skb,
+		   struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
@@ -914,7 +914,7 @@ mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		return -ENOSPC;
 
 	skb->prev = skb->next = NULL;
-	err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
+	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
index 6f61d6a10627..5a34894a533b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
@@ -799,7 +799,7 @@ static void rtl88e_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
index 0b6a15c2e5cc..d92aad60edfe 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
@@ -640,7 +640,7 @@ static void rtl92c_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
index 8ada31380efa..0ff8e355c23a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
@@ -466,7 +466,7 @@ static void rtl8723e_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index dfd52cff5d02..1cc2b7b94804 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -1061,9 +1061,9 @@ static struct rtw_debugfs_priv rtw_debug_priv_dm_cap = {
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
-		if (!debugfs_create_file(#name, mode,			\
+		if (IS_ERR(debugfs_create_file(#name, mode,		\
 					 parent, &rtw_debug_priv_ ##name,\
-					 &file_ops_ ##fopname))		\
+					 &file_ops_ ##fopname)))	\
 			pr_debug("Unable to initialize debugfs:%s\n",	\
 			       #name);					\
 	} while (0)
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 10dbdcdfb9ce..0243789ba914 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -30,7 +30,13 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
+	priv->bus_desc.provider_name = devm_kstrdup(&pdev->dev, pdev->name,
+							GFP_KERNEL);
+	if (!priv->bus_desc.provider_name) {
+		kfree(priv);
+		return -ENOMEM;
+	}
+
 	priv->bus_desc.module = THIS_MODULE;
 	priv->bus_desc.of_node = np;
 
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 70ad891a76ba..c2d3343b5596 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -966,7 +966,8 @@ unsigned int nd_region_acquire_lane(struct nd_region *nd_region)
 {
 	unsigned int cpu, lane;
 
-	cpu = get_cpu();
+	migrate_disable();
+	cpu = smp_processor_id();
 	if (nd_region->num_lanes < nr_cpu_ids) {
 		struct nd_percpu_lane *ndl_lock, *ndl_count;
 
@@ -985,16 +986,15 @@ EXPORT_SYMBOL(nd_region_acquire_lane);
 void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 {
 	if (nd_region->num_lanes < nr_cpu_ids) {
-		unsigned int cpu = get_cpu();
+		unsigned int cpu = smp_processor_id();
 		struct nd_percpu_lane *ndl_lock, *ndl_count;
 
 		ndl_count = per_cpu_ptr(nd_region->lane, cpu);
 		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
 		if (--ndl_count->count == 0)
 			spin_unlock(&ndl_lock->lock);
-		put_cpu();
 	}
-	put_cpu();
+	migrate_enable();
 }
 EXPORT_SYMBOL(nd_region_release_lane);
 
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index f70197154a36..820cce7c8b40 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -605,6 +605,7 @@ static int pccardd(void *__skt)
 		dev_warn(&skt->dev, "PCMCIA: unable to register socket\n");
 		skt->thread = NULL;
 		complete(&skt->thread_done);
+		put_device(&skt->dev);
 		return 0;
 	}
 	ret = pccard_sysfs_add_socket(&skt->dev);
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 5bd1b80424e7..f8baf178ef3c 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -513,9 +513,6 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 	/* by default don't allow DMA */
 	p_dev->dma_mask = 0;
 	p_dev->dev.dma_mask = &p_dev->dma_mask;
-	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
-	if (!dev_name(&p_dev->dev))
-		goto err_free;
 	p_dev->devname = kasprintf(GFP_KERNEL, "pcmcia%s", dev_name(&p_dev->dev));
 	if (!p_dev->devname)
 		goto err_free;
@@ -573,8 +570,15 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 
 	pcmcia_device_query(p_dev);
 
-	if (device_register(&p_dev->dev))
-		goto err_unreg;
+	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
+	if (device_register(&p_dev->dev)) {
+		mutex_lock(&s->ops_mutex);
+		list_del(&p_dev->socket_device_list);
+		s->device_count--;
+		mutex_unlock(&s->ops_mutex);
+		put_device(&p_dev->dev);
+		return NULL;
+	}
 
 	return p_dev;
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index 83264ec0a957..7b096f1dc9eb 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -434,8 +434,8 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
 	ret = perf_pmu_register(&pa_pmu->pmu, name, -1);
 	if (ret) {
 		dev_err(pa_pmu->dev, "PMU register failed, ret = %d\n", ret);
-		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_PA_ONLINE,
-					    &pa_pmu->node);
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_PA_ONLINE,
+						    &pa_pmu->node);
 		return ret;
 	}
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index 6aedc303ff56..f3cd00fc9bbe 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -463,8 +463,8 @@ static int hisi_sllc_pmu_probe(struct platform_device *pdev)
 	ret = perf_pmu_register(&sllc_pmu->pmu, name, -1);
 	if (ret) {
 		dev_err(sllc_pmu->dev, "PMU register failed, ret = %d\n", ret);
-		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_SLLC_ONLINE,
-					    &sllc_pmu->node);
+		cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_SLLC_ONLINE,
+						    &sllc_pmu->node);
 		return ret;
 	}
 
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7ce0408d3bfd..63265ab96424 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -188,7 +188,7 @@ static int get_subobj_info(acpi_handle handle, const char *pathname,
 
 static acpi_status wmi_method_enable(struct wmi_block *wblock, int enable)
 {
-	struct guid_block *block = NULL;
+	struct guid_block *block;
 	char method[5];
 	acpi_status status;
 	acpi_handle handle;
@@ -262,8 +262,8 @@ EXPORT_SYMBOL_GPL(wmi_evaluate_method);
 acpi_status wmidev_evaluate_method(struct wmi_device *wdev, u8 instance,
 	u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
 {
-	struct guid_block *block = NULL;
-	struct wmi_block *wblock = NULL;
+	struct guid_block *block;
+	struct wmi_block *wblock;
 	acpi_handle handle;
 	acpi_status status;
 	struct acpi_object_list input;
@@ -310,7 +310,7 @@ EXPORT_SYMBOL_GPL(wmidev_evaluate_method);
 static acpi_status __query_block(struct wmi_block *wblock, u8 instance,
 				 struct acpi_buffer *out)
 {
-	struct guid_block *block = NULL;
+	struct guid_block *block;
 	acpi_handle handle;
 	acpi_status status, wc_status = AE_ERROR;
 	struct acpi_object_list input;
@@ -423,8 +423,8 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
 acpi_status wmi_set_block(const char *guid_string, u8 instance,
 			  const struct acpi_buffer *in)
 {
-	struct guid_block *block = NULL;
 	struct wmi_block *wblock = NULL;
+	struct guid_block *block;
 	acpi_handle handle;
 	struct acpi_object_list input;
 	union acpi_object params[2];
@@ -827,21 +827,13 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 }
 static int wmi_char_open(struct inode *inode, struct file *filp)
 {
-	const char *driver_name = filp->f_path.dentry->d_iname;
-	struct wmi_block *wblock = NULL;
-	struct wmi_block *next = NULL;
-
-	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
-		if (!wblock->dev.dev.driver)
-			continue;
-		if (strcmp(driver_name, wblock->dev.dev.driver->name) == 0) {
-			filp->private_data = wblock;
-			break;
-		}
-	}
+	/*
+	 * The miscdevice already stores a pointer to itself
+	 * inside filp->private_data
+	 */
+	struct wmi_block *wblock = container_of(filp->private_data, struct wmi_block, char_dev);
 
-	if (!filp->private_data)
-		return -ENODEV;
+	filp->private_data = wblock;
 
 	return nonseekable_open(inode, filp);
 }
@@ -861,8 +853,8 @@ static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct wmi_ioctl_buffer __user *input =
 		(struct wmi_ioctl_buffer __user *) arg;
 	struct wmi_block *wblock = filp->private_data;
-	struct wmi_ioctl_buffer *buf = NULL;
-	struct wmi_driver *wdriver = NULL;
+	struct wmi_ioctl_buffer *buf;
+	struct wmi_driver *wdriver;
 	int ret;
 
 	if (_IOC_TYPE(cmd) != WMI_IOC)
@@ -1161,8 +1153,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 	struct wmi_block *wblock, *next;
 	union acpi_object *obj;
 	acpi_status status;
-	int retval = 0;
 	u32 i, total;
+	int retval;
 
 	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
 	if (ACPI_FAILURE(status))
@@ -1173,8 +1165,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		return -ENXIO;
 
 	if (obj->type != ACPI_TYPE_BUFFER) {
-		retval = -ENXIO;
-		goto out_free_pointer;
+		kfree(obj);
+		return -ENXIO;
 	}
 
 	gblock = (const struct guid_block *)obj->buffer.pointer;
@@ -1195,8 +1187,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
 		if (!wblock) {
-			retval = -ENOMEM;
-			break;
+			dev_err(wmi_bus_dev, "Failed to allocate %pUL\n", &gblock[i].guid);
+			continue;
 		}
 
 		wblock->acpi_device = device;
@@ -1235,9 +1227,9 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		}
 	}
 
-out_free_pointer:
-	kfree(out.pointer);
-	return retval;
+	kfree(obj);
+
+	return 0;
 }
 
 /*
diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 3b529f82b97c..202e2d013685 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -294,7 +294,7 @@ static int brcmstb_pwm_suspend(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_disable(p->clk);
+	clk_disable_unprepare(p->clk);
 
 	return 0;
 }
@@ -303,7 +303,7 @@ static int brcmstb_pwm_resume(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_enable(p->clk);
+	clk_prepare_enable(p->clk);
 
 	return 0;
 }
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index f491d56254d7..f8a3f30e54dd 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -79,6 +79,7 @@ struct sti_pwm_compat_data {
 	unsigned int cpt_num_devs;
 	unsigned int max_pwm_cnt;
 	unsigned int max_prescale;
+	struct sti_cpt_ddata *ddata;
 };
 
 struct sti_pwm_chip {
@@ -314,7 +315,7 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 	struct sti_pwm_compat_data *cdata = pc->cdata;
-	struct sti_cpt_ddata *ddata = pwm_get_chip_data(pwm);
+	struct sti_cpt_ddata *ddata = &cdata->ddata[pwm->hwpwm];
 	struct device *dev = pc->dev;
 	unsigned int effective_ticks;
 	unsigned long long high, low;
@@ -417,7 +418,7 @@ static irqreturn_t sti_pwm_interrupt(int irq, void *data)
 	while (cpt_int_stat) {
 		devicenum = ffs(cpt_int_stat) - 1;
 
-		ddata = pwm_get_chip_data(&pc->chip.pwms[devicenum]);
+		ddata = &pc->cdata->ddata[devicenum];
 
 		/*
 		 * Capture input:
@@ -615,30 +616,28 @@ static int sti_pwm_probe(struct platform_device *pdev)
 			dev_err(dev, "failed to prepare clock\n");
 			return ret;
 		}
+
+		cdata->ddata = devm_kzalloc(dev, cdata->cpt_num_devs * sizeof(*cdata->ddata), GFP_KERNEL);
+		if (!cdata->ddata)
+			return -ENOMEM;
 	}
 
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.npwm = pc->cdata->pwm_num_devs;
 
-	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
-		clk_unprepare(pc->pwm_clk);
-		clk_unprepare(pc->cpt_clk);
-		return ret;
-	}
-
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
-		struct sti_cpt_ddata *ddata;
-
-		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-		if (!ddata)
-			return -ENOMEM;
+		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
 
 		init_waitqueue_head(&ddata->wait);
 		mutex_init(&ddata->lock);
+	}
 
-		pwm_set_chip_data(&pc->chip.pwms[i], ddata);
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0) {
+		clk_unprepare(pc->pwm_clk);
+		clk_unprepare(pc->cpt_clk);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, pc);
diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index bb3e9ba75f6c..80e3839e1e86 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -403,7 +403,7 @@ static int pcf85363_probe(struct i2c_client *client,
 	if (client->irq > 0) {
 		regmap_write(pcf85363->regmap, CTRL_FLAGS, 0);
 		regmap_update_bits(pcf85363->regmap, CTRL_PIN_IO,
-				   PIN_IO_INTA_OUT, PIN_IO_INTAPM);
+				   PIN_IO_INTAPM, PIN_IO_INTA_OUT);
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, pcf85363_rtc_handle_irq,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 45ef78f388dc..d169ba772450 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -22,7 +22,6 @@
 #include <linux/bsg-lib.h>
 #include <asm/firmware.h>
 #include <asm/irq.h>
-#include <asm/rtas.h>
 #include <asm/vio.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -5802,7 +5801,7 @@ static int ibmvfc_register_scsi_channel(struct ibmvfc_host *vhost,
 irq_failed:
 	do {
 		rc = plpar_hcall_norets(H_FREE_SUB_CRQ, vdev->unit_address, scrq->cookie);
-	} while (rtas_busy_delay(rc));
+	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
 reg_failed:
 	LEAVE;
 	return rc;
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index f48036f09eab..e78461f66400 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3465,7 +3465,7 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
 		 */
 		ret = utf16s_to_utf8s(uc_str->uc,
 				      uc_str->len - QUERY_DESC_HDR_SIZE,
-				      UTF16_BIG_ENDIAN, str, ascii_len);
+				      UTF16_BIG_ENDIAN, str, ascii_len - 1);
 
 		/* replace non-printable or non-ASCII characters with spaces */
 		for (i = 0; i < ret; i++)
diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 47d41804fdf6..fabc5ce828af 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -537,6 +537,9 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 	u32 sz;
 	u32 version;
 
+	if (!IS_ERR(drv_data))
+		return -EBUSY;
+
 	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data) {
 		ret = -ENOMEM;
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4fc23236d3bd..123689e457d1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -976,6 +976,7 @@ config SPI_XTENSA_XTFPGA
 config SPI_ZYNQ_QSPI
 	tristate "Xilinx Zynq QSPI controller"
 	depends on ARCH_ZYNQ || COMPILE_TEST
+	depends on SPI_MEM
 	help
 	  This enables support for the Zynq Quad SPI controller
 	  in master mode.
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 23e4c30e6a60..45961249c976 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -708,7 +708,7 @@ static int nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
 		f->memmap_len = len > NXP_FSPI_MIN_IOMAP ?
 				len : NXP_FSPI_MIN_IOMAP;
 
-		f->ahb_addr = ioremap_wc(f->memmap_phy + f->memmap_start,
+		f->ahb_addr = ioremap(f->memmap_phy + f->memmap_start,
 					 f->memmap_len);
 
 		if (!f->ahb_addr) {
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index cf61bf302a05..c611fedda7de 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1087,6 +1087,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	reset_control_deassert(tspi->rst);
 
 	spi_irq = platform_get_irq(pdev, 0);
+	if (spi_irq < 0)
+		return spi_irq;
 	tspi->irq = spi_irq;
 	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
 				   tegra_slink_isr_thread, IRQF_ONESHOT,
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index e2f2ff609c7e..0904aea782b1 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -147,12 +147,12 @@ int cedrus_hw_suspend(struct device *device)
 {
 	struct cedrus_dev *dev = dev_get_drvdata(device);
 
-	reset_control_assert(dev->rstc);
-
 	clk_disable_unprepare(dev->ram_clk);
 	clk_disable_unprepare(dev->mod_clk);
 	clk_disable_unprepare(dev->ahb_clk);
 
+	reset_control_assert(dev->rstc);
+
 	return 0;
 }
 
@@ -161,11 +161,18 @@ int cedrus_hw_resume(struct device *device)
 	struct cedrus_dev *dev = dev_get_drvdata(device);
 	int ret;
 
+	ret = reset_control_reset(dev->rstc);
+	if (ret) {
+		dev_err(dev->dev, "Failed to apply reset\n");
+
+		return ret;
+	}
+
 	ret = clk_prepare_enable(dev->ahb_clk);
 	if (ret) {
 		dev_err(dev->dev, "Failed to enable AHB clock\n");
 
-		return ret;
+		goto err_rst;
 	}
 
 	ret = clk_prepare_enable(dev->mod_clk);
@@ -182,21 +189,14 @@ int cedrus_hw_resume(struct device *device)
 		goto err_mod_clk;
 	}
 
-	ret = reset_control_reset(dev->rstc);
-	if (ret) {
-		dev_err(dev->dev, "Failed to apply reset\n");
-
-		goto err_ram_clk;
-	}
-
 	return 0;
 
-err_ram_clk:
-	clk_disable_unprepare(dev->ram_clk);
 err_mod_clk:
 	clk_disable_unprepare(dev->mod_clk);
 err_ahb_clk:
 	clk_disable_unprepare(dev->ahb_clk);
+err_rst:
+	reset_control_assert(dev->rstc);
 
 	return ret;
 }
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 052e8e8fbb21..ce748e03e433 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -671,7 +671,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (result)
 		goto release_ida;
 
-	sprintf(dev->attr_name, "cdev%d_trip_point", dev->id);
+	snprintf(dev->attr_name, sizeof(dev->attr_name), "cdev%d_trip_point",
+		 dev->id);
 	sysfs_attr_init(&dev->attr.attr);
 	dev->attr.attr.name = dev->attr_name;
 	dev->attr.attr.mode = 0444;
@@ -680,7 +681,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (result)
 		goto remove_symbol_link;
 
-	sprintf(dev->weight_attr_name, "cdev%d_weight", dev->id);
+	snprintf(dev->weight_attr_name, sizeof(dev->weight_attr_name),
+		 "cdev%d_weight", dev->id);
 	sysfs_attr_init(&dev->weight_attr.attr);
 	dev->weight_attr.attr.name = dev->weight_attr_name;
 	dev->weight_attr.attr.mode = S_IWUSR | S_IRUGO;
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 80b86a7992b5..8ede78488c5b 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -300,12 +300,7 @@ void disassociate_ctty(int on_exit)
 		return;
 	}
 
-	spin_lock_irq(&current->sighand->siglock);
-	put_pid(current->signal->tty_old_pgrp);
-	current->signal->tty_old_pgrp = NULL;
-	tty = tty_kref_get(current->signal->tty);
-	spin_unlock_irq(&current->sighand->siglock);
-
+	tty = get_current_tty();
 	if (tty) {
 		unsigned long flags;
 
@@ -320,6 +315,16 @@ void disassociate_ctty(int on_exit)
 		tty_kref_put(tty);
 	}
 
+	/* If tty->ctrl.pgrp is not NULL, it may be assigned to
+	 * current->signal->tty_old_pgrp in a race condition, and
+	 * cause pid memleak. Release current->signal->tty_old_pgrp
+	 * after tty->ctrl.pgrp set to NULL.
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	put_pid(current->signal->tty_old_pgrp);
+	current->signal->tty_old_pgrp = NULL;
+	spin_unlock_irq(&current->sighand->siglock);
+
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
 	session_clear_tty(task_session(current));
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index bdc3885c0d49..786ddb3c3289 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -30,8 +30,7 @@ struct ehci_ci_priv {
 };
 
 struct ci_hdrc_dma_aligned_buffer {
-	void *kmalloc_ptr;
-	void *old_xfer_buffer;
+	void *original_buffer;
 	u8 data[];
 };
 
@@ -372,59 +371,52 @@ static int ci_ehci_bus_suspend(struct usb_hcd *hcd)
 	return 0;
 }
 
-static void ci_hdrc_free_dma_aligned_buffer(struct urb *urb)
+static void ci_hdrc_free_dma_aligned_buffer(struct urb *urb, bool copy_back)
 {
 	struct ci_hdrc_dma_aligned_buffer *temp;
-	size_t length;
 
 	if (!(urb->transfer_flags & URB_ALIGNED_TEMP_BUFFER))
 		return;
+	urb->transfer_flags &= ~URB_ALIGNED_TEMP_BUFFER;
 
 	temp = container_of(urb->transfer_buffer,
 			    struct ci_hdrc_dma_aligned_buffer, data);
+	urb->transfer_buffer = temp->original_buffer;
+
+	if (copy_back && usb_urb_dir_in(urb)) {
+		size_t length;
 
-	if (usb_urb_dir_in(urb)) {
 		if (usb_pipeisoc(urb->pipe))
 			length = urb->transfer_buffer_length;
 		else
 			length = urb->actual_length;
 
-		memcpy(temp->old_xfer_buffer, temp->data, length);
+		memcpy(temp->original_buffer, temp->data, length);
 	}
-	urb->transfer_buffer = temp->old_xfer_buffer;
-	kfree(temp->kmalloc_ptr);
 
-	urb->transfer_flags &= ~URB_ALIGNED_TEMP_BUFFER;
+	kfree(temp);
 }
 
 static int ci_hdrc_alloc_dma_aligned_buffer(struct urb *urb, gfp_t mem_flags)
 {
-	struct ci_hdrc_dma_aligned_buffer *temp, *kmalloc_ptr;
-	const unsigned int ci_hdrc_usb_dma_align = 32;
-	size_t kmalloc_size;
+	struct ci_hdrc_dma_aligned_buffer *temp;
 
-	if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0 ||
-	    !((uintptr_t)urb->transfer_buffer & (ci_hdrc_usb_dma_align - 1)))
+	if (urb->num_sgs || urb->sg || urb->transfer_buffer_length == 0)
+		return 0;
+	if (IS_ALIGNED((uintptr_t)urb->transfer_buffer, 4)
+	    && IS_ALIGNED(urb->transfer_buffer_length, 4))
 		return 0;
 
-	/* Allocate a buffer with enough padding for alignment */
-	kmalloc_size = urb->transfer_buffer_length +
-		       sizeof(struct ci_hdrc_dma_aligned_buffer) +
-		       ci_hdrc_usb_dma_align - 1;
-
-	kmalloc_ptr = kmalloc(kmalloc_size, mem_flags);
-	if (!kmalloc_ptr)
+	temp = kmalloc(sizeof(*temp) + ALIGN(urb->transfer_buffer_length, 4), mem_flags);
+	if (!temp)
 		return -ENOMEM;
 
-	/* Position our struct dma_aligned_buffer such that data is aligned */
-	temp = PTR_ALIGN(kmalloc_ptr + 1, ci_hdrc_usb_dma_align) - 1;
-	temp->kmalloc_ptr = kmalloc_ptr;
-	temp->old_xfer_buffer = urb->transfer_buffer;
 	if (usb_urb_dir_out(urb))
 		memcpy(temp->data, urb->transfer_buffer,
 		       urb->transfer_buffer_length);
-	urb->transfer_buffer = temp->data;
 
+	temp->original_buffer = urb->transfer_buffer;
+	urb->transfer_buffer = temp->data;
 	urb->transfer_flags |= URB_ALIGNED_TEMP_BUFFER;
 
 	return 0;
@@ -441,7 +433,7 @@ static int ci_hdrc_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 
 	ret = usb_hcd_map_urb_for_dma(hcd, urb, mem_flags);
 	if (ret)
-		ci_hdrc_free_dma_aligned_buffer(urb);
+		ci_hdrc_free_dma_aligned_buffer(urb, false);
 
 	return ret;
 }
@@ -449,7 +441,7 @@ static int ci_hdrc_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 static void ci_hdrc_unmap_urb_for_dma(struct usb_hcd *hcd, struct urb *urb)
 {
 	usb_hcd_unmap_urb_for_dma(hcd, urb);
-	ci_hdrc_free_dma_aligned_buffer(urb);
+	ci_hdrc_free_dma_aligned_buffer(urb, true);
 }
 
 int ci_hdrc_host_init(struct ci_hdrc *ci)
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 82322696b903..d17a1dd6d0d9 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4802,8 +4802,8 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	if (qh_allocated && qh->channel && qh->channel->qh == qh)
 		qh->channel->qh = NULL;
 fail2:
-	spin_unlock_irqrestore(&hsotg->lock, flags);
 	urb->hcpriv = NULL;
+	spin_unlock_irqrestore(&hsotg->lock, flags);
 	kfree(qtd);
 fail1:
 	if (qh_allocated) {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 29a442b62118..d0223facb92a 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -349,6 +349,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
+	else if (pdev->vendor == PCI_VENDOR_ID_AMD && xhci->hci_version >= 0x110)
+		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 972a44b2a7f1..e56a1fb9715a 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -466,23 +466,38 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
 	int ret;
 
 	if (!device_may_wakeup(dev) && (xhci->quirks & XHCI_SUSPEND_RESUME_CLKS)) {
-		clk_prepare_enable(xhci->clk);
-		clk_prepare_enable(xhci->reg_clk);
+		ret = clk_prepare_enable(xhci->clk);
+		if (ret)
+			return ret;
+
+		ret = clk_prepare_enable(xhci->reg_clk);
+		if (ret) {
+			clk_disable_unprepare(xhci->clk);
+			return ret;
+		}
 	}
 
 	ret = xhci_priv_resume_quirk(hcd);
 	if (ret)
-		return ret;
+		goto disable_clks;
 
 	ret = xhci_resume(xhci, 0);
 	if (ret)
-		return ret;
+		goto disable_clks;
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
 	return 0;
+
+disable_clks:
+	if (!device_may_wakeup(dev) && (xhci->quirks & XHCI_SUSPEND_RESUME_CLKS)) {
+		clk_disable_unprepare(xhci->clk);
+		clk_disable_unprepare(xhci->reg_clk);
+	}
+
+	return ret;
 }
 
 static int __maybe_unused xhci_plat_runtime_suspend(struct device *dev)
diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index 3c6d452e3bf4..4104eea03e80 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -462,8 +462,13 @@ static void stub_disconnect(struct usb_device *udev)
 	/* release port */
 	rc = usb_hub_release_port(udev->parent, udev->portnum,
 				  (struct usb_dev_state *) udev);
-	if (rc) {
-		dev_dbg(&udev->dev, "unable to release port\n");
+	/*
+	 * NOTE: If a HUB disconnect triggered disconnect of the down stream
+	 * device usb_hub_release_port will return -ENODEV so we can safely ignore
+	 * that error here.
+	 */
+	if (rc && (rc != -ENODEV)) {
+		dev_dbg(&udev->dev, "unable to release port (%i)\n", rc);
 		return;
 	}
 
diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index e332017c6af6..ce3c5b0b8f4e 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -490,7 +490,7 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_port(const char *s)
  * Workaround for failed writing desc register of planes.
  * Needed with MPC5121 DIU rev 2.0 silicon.
  */
-void wr_reg_wa(u32 *reg, u32 val)
+static void wr_reg_wa(u32 *reg, u32 val)
 {
 	do {
 		out_be32(reg, val);
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 1b2fb8ed7623..e559c844436b 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1489,8 +1489,8 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (!request_mem_region(addr, size, "imsttfb")) {
 		printk(KERN_ERR "imsttfb: Can't reserve memory region\n");
-		framebuffer_release(info);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto release_info;
 	}
 
 	switch (pdev->device) {
@@ -1507,34 +1507,39 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
 			ret = -ENODEV;
-			goto error;
+			goto release_mem_region;
 	}
 
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
 					    0x400000 : 0x800000);
 	if (!info->screen_base)
-		goto error;
+		goto release_mem_region;
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
 	if (!par->dc_regs)
-		goto error;
+		goto unmap_screen_base;
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	if (!par->cmap_regs)
-		goto error;
+		goto unmap_dc_regs;
 	info->pseudo_palette = par->palette;
 	ret = init_imstt(info);
-	if (!ret)
-		pci_set_drvdata(pdev, info);
-	return ret;
+	if (ret)
+		goto unmap_cmap_regs;
+
+	pci_set_drvdata(pdev, info);
+	return 0;
 
-error:
-	if (par->dc_regs)
-		iounmap(par->dc_regs);
-	if (info->screen_base)
-		iounmap(info->screen_base);
+unmap_cmap_regs:
+	iounmap(par->cmap_regs);
+unmap_dc_regs:
+	iounmap(par->dc_regs);
+unmap_screen_base:
+	iounmap(info->screen_base);
+release_mem_region:
 	release_mem_region(addr, size);
+release_info:
 	framebuffer_release(info);
 	return ret;
 }
diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
index 059de92aea7d..d47eee6c5143 100644
--- a/drivers/xen/xen-pciback/conf_space.c
+++ b/drivers/xen/xen-pciback/conf_space.c
@@ -288,12 +288,6 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
 	u16 val;
 	int ret = 0;
 
-	err = pci_read_config_word(dev, PCI_COMMAND, &val);
-	if (err)
-		return err;
-	if (!(val & PCI_COMMAND_INTX_DISABLE))
-		ret |= INTERRUPT_TYPE_INTX;
-
 	/*
 	 * Do not trust dev->msi(x)_enabled here, as enabling could be done
 	 * bypassing the pci_*msi* functions, by the qemu.
@@ -316,6 +310,19 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
 		if (val & PCI_MSIX_FLAGS_ENABLE)
 			ret |= INTERRUPT_TYPE_MSIX;
 	}
+
+	/*
+	 * PCIe spec says device cannot use INTx if MSI/MSI-X is enabled,
+	 * so check for INTx only when both are disabled.
+	 */
+	if (!ret) {
+		err = pci_read_config_word(dev, PCI_COMMAND, &val);
+		if (err)
+			return err;
+		if (!(val & PCI_COMMAND_INTX_DISABLE))
+			ret |= INTERRUPT_TYPE_INTX;
+	}
+
 	return ret ?: INTERRUPT_TYPE_NONE;
 }
 
diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index 097316a74126..1948a9700c8f 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -236,10 +236,16 @@ static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
 		return PCIBIOS_SET_FAILED;
 
 	if (new_value & field_config->enable_bit) {
-		/* don't allow enabling together with other interrupt types */
+		/*
+		 * Don't allow enabling together with other interrupt type, but do
+		 * allow enabling MSI(-X) while INTx is still active to please Linuxes
+		 * MSI(-X) startup sequence. It is safe to do, as according to PCI
+		 * spec, device with enabled MSI(-X) shouldn't use INTx.
+		 */
 		int int_type = xen_pcibk_get_interrupt_type(dev);
 
 		if (int_type == INTERRUPT_TYPE_NONE ||
+		    int_type == INTERRUPT_TYPE_INTX ||
 		    int_type == field_config->int_type)
 			goto write;
 		return PCIBIOS_SET_FAILED;
diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index ac45cdc38e85..fcaa050d692d 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -104,24 +104,9 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 		pci_clear_mwi(dev);
 	}
 
-	if (dev_data && dev_data->allow_interrupt_control) {
-		if ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE) {
-			if (value & PCI_COMMAND_INTX_DISABLE) {
-				pci_intx(dev, 0);
-			} else {
-				/* Do not allow enabling INTx together with MSI or MSI-X. */
-				switch (xen_pcibk_get_interrupt_type(dev)) {
-				case INTERRUPT_TYPE_NONE:
-					pci_intx(dev, 1);
-					break;
-				case INTERRUPT_TYPE_INTX:
-					break;
-				default:
-					return PCIBIOS_SET_FAILED;
-				}
-			}
-		}
-	}
+	if (dev_data && dev_data->allow_interrupt_control &&
+	    ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE))
+		pci_intx(dev, !(value & PCI_COMMAND_INTX_DISABLE));
 
 	cmd->val = value;
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dc9f4f80f90b..f93d15833f9d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2094,7 +2094,7 @@ static noinline int key_in_sk(struct btrfs_key *key,
 static noinline int copy_to_sk(struct btrfs_path *path,
 			       struct btrfs_key *key,
 			       struct btrfs_ioctl_search_key *sk,
-			       size_t *buf_size,
+			       u64 *buf_size,
 			       char __user *ubuf,
 			       unsigned long *sk_offset,
 			       int *num_found)
@@ -2226,7 +2226,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 
 static noinline int search_ioctl(struct inode *inode,
 				 struct btrfs_ioctl_search_key *sk,
-				 size_t *buf_size,
+				 u64 *buf_size,
 				 char __user *ubuf)
 {
 	struct btrfs_fs_info *info = btrfs_sb(inode->i_sb);
@@ -2295,7 +2295,7 @@ static noinline int btrfs_ioctl_tree_search(struct file *file,
 	struct btrfs_ioctl_search_key sk;
 	struct inode *inode;
 	int ret;
-	size_t buf_size;
+	u64 buf_size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -2329,8 +2329,8 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
 	struct btrfs_ioctl_search_args_v2 args;
 	struct inode *inode;
 	int ret;
-	size_t buf_size;
-	const size_t buf_limit = SZ_16M;
+	u64 buf_size;
+	const u64 buf_limit = SZ_16M;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 13497bd4e14b..592be39e3d51 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1004,6 +1004,11 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 		ix = curp->p_idx;
 	}
 
+	if (unlikely(ix > EXT_MAX_INDEX(curp->p_hdr))) {
+		EXT4_ERROR_INODE(inode, "ix > EXT_MAX_INDEX!");
+		return -EFSCORRUPTED;
+	}
+
 	len = EXT_LAST_INDEX(curp->p_hdr) - ix + 1;
 	BUG_ON(len < 0);
 	if (len > 0) {
@@ -1013,11 +1018,6 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 		memmove(ix + 1, ix, len * sizeof(struct ext4_extent_idx));
 	}
 
-	if (unlikely(ix > EXT_MAX_INDEX(curp->p_hdr))) {
-		EXT4_ERROR_INODE(inode, "ix > EXT_MAX_INDEX!");
-		return -EFSCORRUPTED;
-	}
-
 	ix->ei_block = cpu_to_le32(logical);
 	ext4_idx_store_pblock(ix, ptr);
 	le16_add_cpu(&curp->p_hdr->eh_entries, 1);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3956852ad1de..73a7906a49b1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2253,8 +2253,10 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		f2fs_wait_on_block_writeback(inode, blkaddr);
 
 		if (f2fs_load_compressed_page(sbi, page, blkaddr)) {
-			if (atomic_dec_and_test(&dic->remaining_pages))
+			if (atomic_dec_and_test(&dic->remaining_pages)) {
 				f2fs_decompress_cluster(dic);
+				break;
+			}
 			continue;
 		}
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e1131af0396b..58fd32db025d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3210,6 +3210,7 @@ int f2fs_precache_extents(struct inode *inode)
 		return -EOPNOTSUPP;
 
 	map.m_lblk = 0;
+	map.m_pblk = 0;
 	map.m_next_pgofs = NULL;
 	map.m_next_extent = &m_next_extent;
 	map.m_seg_type = NO_CHECK_TYPE;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5c0b2b300aa1..d4a76c2deb80 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -540,6 +540,29 @@ static int f2fs_set_test_dummy_encryption(struct super_block *sb,
 }
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
+static bool is_compress_extension_exist(struct f2fs_sb_info *sbi,
+					const char *new_ext, bool is_ext)
+{
+	unsigned char (*ext)[F2FS_EXTENSION_LEN];
+	int ext_cnt;
+	int i;
+
+	if (is_ext) {
+		ext = F2FS_OPTION(sbi).extensions;
+		ext_cnt = F2FS_OPTION(sbi).compress_ext_cnt;
+	} else {
+		ext = F2FS_OPTION(sbi).noextensions;
+		ext_cnt = F2FS_OPTION(sbi).nocompress_ext_cnt;
+	}
+
+	for (i = 0; i < ext_cnt; i++) {
+		if (!strcasecmp(new_ext, ext[i]))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * 1. The same extension name cannot not appear in both compress and non-compress extension
  * at the same time.
@@ -1154,6 +1177,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return -EINVAL;
 			}
 
+			if (is_compress_extension_exist(sbi, name, true)) {
+				kfree(name);
+				break;
+			}
+
 			strcpy(ext[ext_cnt], name);
 			F2FS_OPTION(sbi).compress_ext_cnt++;
 			kfree(name);
@@ -1178,6 +1206,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return -EINVAL;
 			}
 
+			if (is_compress_extension_exist(sbi, name, false)) {
+				kfree(name);
+				break;
+			}
+
 			strcpy(noext[noext_cnt], name);
 			F2FS_OPTION(sbi).nocompress_ext_cnt++;
 			kfree(name);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 5f0abea107e4..672d176524f5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -609,6 +609,24 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	kfree(isw);
 }
 
+static bool isw_prepare_wbs_switch(struct inode_switch_wbs_context *isw,
+				   struct list_head *list, int *nr)
+{
+	struct inode *inode;
+
+	list_for_each_entry(inode, list, i_io_list) {
+		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
+			continue;
+
+		isw->inodes[*nr] = inode;
+		(*nr)++;
+
+		if (*nr >= WB_MAX_INODES_PER_ISW - 1)
+			return true;
+	}
+	return false;
+}
+
 /**
  * cleanup_offline_cgwb - detach associated inodes
  * @wb: target wb
@@ -621,7 +639,6 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 {
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
-	struct inode *inode;
 	int nr;
 	bool restart = false;
 
@@ -643,17 +660,17 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	nr = 0;
 	spin_lock(&wb->list_lock);
-	list_for_each_entry(inode, &wb->b_attached, i_io_list) {
-		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
-			continue;
-
-		isw->inodes[nr++] = inode;
-
-		if (nr >= WB_MAX_INODES_PER_ISW - 1) {
-			restart = true;
-			break;
-		}
-	}
+	/*
+	 * In addition to the inodes that have completed writeback, also switch
+	 * cgwbs for those inodes only with dirty timestamps. Otherwise, those
+	 * inodes won't be written back for a long time when lazytime is
+	 * enabled, and thus pinning the dying cgwbs. It won't break the
+	 * bandwidth restrictions, as writeback of inode metadata is not
+	 * accounted for.
+	 */
+	restart = isw_prepare_wbs_switch(isw, &wb->b_attached, &nr);
+	if (!restart)
+		restart = isw_prepare_wbs_switch(isw, &wb->b_dirty_time, &nr);
 	spin_unlock(&wb->list_lock);
 
 	/* no attached inodes? bail out */
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index ad96ba97d8f9..3fc4739f82d8 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -561,6 +561,8 @@ static int pstore_write_user_compat(struct pstore_record *record,
  */
 int pstore_register(struct pstore_info *psi)
 {
+	char *new_backend;
+
 	if (backend && strcmp(backend, psi->name)) {
 		pr_warn("ignoring unexpected backend '%s'\n", psi->name);
 		return -EPERM;
@@ -580,11 +582,16 @@ int pstore_register(struct pstore_info *psi)
 		return -EINVAL;
 	}
 
+	new_backend = kstrdup(psi->name, GFP_KERNEL);
+	if (!new_backend)
+		return -ENOMEM;
+
 	mutex_lock(&psinfo_lock);
 	if (psinfo) {
 		pr_warn("backend '%s' already loaded: ignoring '%s'\n",
 			psinfo->name, psi->name);
 		mutex_unlock(&psinfo_lock);
+		kfree(new_backend);
 		return -EBUSY;
 	}
 
@@ -617,7 +624,7 @@ int pstore_register(struct pstore_info *psi)
 	 * Update the module parameter backend, so it is visible
 	 * through /sys/module/pstore/parameters/backend
 	 */
-	backend = kstrdup(psi->name, GFP_KERNEL);
+	backend = new_backend;
 
 	pr_info("Registered %s as persistent store backend\n", psi->name);
 
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 1d263eb0b2e1..d9af72024d66 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -227,9 +227,13 @@ struct mipi_dsi_device *
 mipi_dsi_device_register_full(struct mipi_dsi_host *host,
 			      const struct mipi_dsi_device_info *info);
 void mipi_dsi_device_unregister(struct mipi_dsi_device *dsi);
+struct mipi_dsi_device *
+devm_mipi_dsi_device_register_full(struct device *dev, struct mipi_dsi_host *host,
+				   const struct mipi_dsi_device_info *info);
 struct mipi_dsi_device *of_find_mipi_dsi_device_by_node(struct device_node *np);
 int mipi_dsi_attach(struct mipi_dsi_device *dsi);
 int mipi_dsi_detach(struct mipi_dsi_device *dsi);
+int devm_mipi_dsi_attach(struct device *dev, struct mipi_dsi_device *dsi);
 int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index dbca858ffa6d..c7156bb56e83 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -188,6 +188,7 @@ enum cpuhp_state {
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
+	CPUHP_AP_ARM_XEN_RUNSTATE_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
diff --git a/include/linux/idr.h b/include/linux/idr.h
index a0dce14090a9..da5f5fa4a3a6 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -200,7 +200,7 @@ static inline void idr_preload_end(void)
  */
 #define idr_for_each_entry_ul(idr, entry, tmp, id)			\
 	for (tmp = 0, id = 0;						\
-	     tmp <= id && ((entry) = idr_get_next_ul(idr, &(id))) != NULL; \
+	     ((entry) = tmp <= id ? idr_get_next_ul(idr, &(id)) : NULL) != NULL; \
 	     tmp = id, ++id)
 
 /**
@@ -224,10 +224,12 @@ static inline void idr_preload_end(void)
  * @id: Entry ID.
  *
  * Continue to iterate over entries, continuing after the current position.
+ * After normal termination @entry is left with the value NULL.  This
+ * is convenient for a "not found" value.
  */
 #define idr_for_each_entry_continue_ul(idr, entry, tmp, id)		\
 	for (tmp = id;							\
-	     tmp <= id && ((entry) = idr_get_next_ul(idr, &(id))) != NULL; \
+	     ((entry) = tmp <= id ? idr_get_next_ul(idr, &(id)) : NULL) != NULL; \
 	     tmp = id, ++id)
 
 /*
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 0bc7cba798a3..b449765b5cac 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -92,7 +92,7 @@ struct mfd_cell {
 	 * (above) when matching OF nodes with devices that have identical
 	 * compatible strings
 	 */
-	const u64 of_reg;
+	u64 of_reg;
 
 	/* Set to 'true' to use 'of_reg' (above) - allows for of_reg=0 */
 	bool use_of_reg;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 132f4344fee9..829ebde5d50d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5499,5 +5499,6 @@ extern struct net_device *blackhole_netdev;
 #define DEV_STATS_INC(DEV, FIELD) atomic_long_inc(&(DEV)->stats.__##FIELD)
 #define DEV_STATS_ADD(DEV, FIELD, VAL) 	\
 		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
+#define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FIELD)
 
 #endif	/* _LINUX_NETDEVICE_H */
diff --git a/include/net/flow.h b/include/net/flow.h
index e3f9d92460e7..776bacc96242 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -39,8 +39,8 @@ struct flowi_common {
 #define FLOWI_FLAG_SKIP_NH_OIF		0x04
 	__u32	flowic_secid;
 	kuid_t  flowic_uid;
-	struct flowi_tunnel flowic_tun_key;
 	__u32		flowic_multipath_hash;
+	struct flowi_tunnel flowic_tun_key;
 };
 
 union flowi_uli {
diff --git a/include/net/netfilter/nf_nat_redirect.h b/include/net/netfilter/nf_nat_redirect.h
index 2418653a66db..279380de904c 100644
--- a/include/net/netfilter/nf_nat_redirect.h
+++ b/include/net/netfilter/nf_nat_redirect.h
@@ -6,8 +6,7 @@
 #include <uapi/linux/netfilter/nf_nat.h>
 
 unsigned int
-nf_nat_redirect_ipv4(struct sk_buff *skb,
-		     const struct nf_nat_ipv4_multi_range_compat *mr,
+nf_nat_redirect_ipv4(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum);
 unsigned int
 nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3aee02ad0116..fe9fc568b288 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -786,7 +786,7 @@ static inline u32 tcp_time_stamp(const struct tcp_sock *tp)
 }
 
 /* Convert a nsec timestamp into TCP TSval timestamp (ms based currently) */
-static inline u32 tcp_ns_to_ts(u64 ns)
+static inline u64 tcp_ns_to_ts(u64 ns)
 {
 	return div_u64(ns, NSEC_PER_SEC / TCP_TS_HZ);
 }
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a711ffe23893..11e406ad16ae 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1118,13 +1118,6 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 		ret = -EBUSY;
 		goto out;
 	}
-	if (!atomic64_read(&map->usercnt)) {
-		/* maps with timers must be either held by user space
-		 * or pinned in bpffs.
-		 */
-		ret = -EPERM;
-		goto out;
-	}
 	/* allocate hrtimer via map_kmalloc to use memcg accounting */
 	t = bpf_map_kmalloc_node(map, sizeof(*t), GFP_ATOMIC, map->numa_node);
 	if (!t) {
@@ -1137,7 +1130,21 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	rcu_assign_pointer(t->callback_fn, NULL);
 	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 	t->timer.function = bpf_timer_cb;
-	timer->timer = t;
+	WRITE_ONCE(timer->timer, t);
+	/* Guarantee the order between timer->timer and map->usercnt. So
+	 * when there are concurrent uref release and bpf timer init, either
+	 * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
+	 * timer or atomic64_read() below returns a zero usercnt.
+	 */
+	smp_mb();
+	if (!atomic64_read(&map->usercnt)) {
+		/* maps with timers must be either held by user space
+		 * or pinned in bpffs.
+		 */
+		WRITE_ONCE(timer->timer, NULL);
+		kfree(t);
+		ret = -EPERM;
+	}
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	return ret;
@@ -1305,7 +1312,7 @@ void bpf_timer_cancel_and_free(void *val)
 	/* The subsequent bpf_timer_start/cancel() helpers won't be able to use
 	 * this timer, since it won't be initialized.
 	 */
-	timer->timer = NULL;
+	WRITE_ONCE(timer->timer, NULL);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	if (!t)
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 764e73622b38..d42245170a7a 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -570,7 +570,17 @@ static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 	 *        but access_ok() should be faster than find_vma()
 	 */
 	if (!fshared) {
-		key->private.mm = mm;
+		/*
+		 * On no-MMU, shared futexes are treated as private, therefore
+		 * we must not include the current process in the key. Since
+		 * there is only one address space, the address is a unique key
+		 * on its own.
+		 */
+		if (IS_ENABLED(CONFIG_MMU))
+			key->private.mm = mm;
+		else
+			key->private.mm = NULL;
+
 		key->private.address = address;
 		return 0;
 	}
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index bbfb26489aa1..f9467637eab6 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -466,16 +466,16 @@ unsigned int irq_matrix_reserved(struct irq_matrix *m)
 }
 
 /**
- * irq_matrix_allocated - Get the number of allocated irqs on the local cpu
+ * irq_matrix_allocated - Get the number of allocated non-managed irqs on the local CPU
  * @m:		Pointer to the matrix to search
  *
- * This returns number of allocated irqs
+ * This returns number of allocated non-managed interrupts.
  */
 unsigned int irq_matrix_allocated(struct irq_matrix *m)
 {
 	struct cpumap *cm = this_cpu_ptr(m->maps);
 
-	return cm->allocated;
+	return cm->allocated - cm->managed_allocated;
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index c0789383807b..147ed154ebc7 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -244,7 +244,7 @@ static int klp_resolve_symbols(Elf_Shdr *sechdrs, const char *strtab,
 		 * symbols are exported and normal relas can be used instead.
 		 */
 		if (!sec_vmlinux && sym_vmlinux) {
-			pr_err("invalid access to vmlinux symbol '%s' from module-specific livepatch relocation section",
+			pr_err("invalid access to vmlinux symbol '%s' from module-specific livepatch relocation section\n",
 			       sym_name);
 			return -EINVAL;
 		}
diff --git a/kernel/padata.c b/kernel/padata.c
index c17f772cc315..c6025a48fb49 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -1094,12 +1094,16 @@ EXPORT_SYMBOL(padata_alloc_shell);
  */
 void padata_free_shell(struct padata_shell *ps)
 {
+	struct parallel_data *pd;
+
 	if (!ps)
 		return;
 
 	mutex_lock(&ps->pinst->lock);
 	list_del(&ps->list);
-	padata_free_pd(rcu_dereference_protected(ps->pd, 1));
+	pd = rcu_dereference_protected(ps->pd, 1);
+	if (refcount_dec_and_test(&pd->refcnt))
+		padata_free_pd(pd);
 	mutex_unlock(&ps->pinst->lock);
 
 	kfree(ps);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2324b7055260..25b8ea91168e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2377,9 +2377,11 @@ static int migration_cpu_stop(void *data)
 		 * it.
 		 */
 		WARN_ON_ONCE(!pending->stop_pending);
+		preempt_disable();
 		task_rq_unlock(rq, p, &rf);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
+		preempt_enable();
 		return 0;
 	}
 out:
@@ -2660,12 +2662,13 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			complete = true;
 		}
 
+		preempt_disable();
 		task_rq_unlock(rq, p, rf);
-
 		if (push_task) {
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
 					    p, &rq->push_work);
 		}
+		preempt_enable();
 
 		if (complete)
 			complete_all(&pending->done);
@@ -2731,12 +2734,13 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
 
+		preempt_disable();
 		task_rq_unlock(rq, p, rf);
-
 		if (!stop_pending) {
 			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 					    &pending->arg, &pending->stop_work);
 		}
+		preempt_enable();
 
 		if (flags & SCA_MIGRATE_ENABLE)
 			return 0;
@@ -8961,9 +8965,11 @@ static void balance_push(struct rq *rq)
 	 * Temporarily drop rq->lock such that we can wake-up the stop task.
 	 * Both preemption and IRQs are still disabled.
 	 */
+	preempt_disable();
 	raw_spin_rq_unlock(rq);
 	stop_one_cpu_nowait(rq->cpu, __balance_push_cpu_stop, push_task,
 			    this_cpu_ptr(&push_work));
+	preempt_enable();
 	/*
 	 * At this point need_resched() is true and we'll take the loop in
 	 * schedule(). The next pick is obviously going to be the stop task
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index de45e4d2c61f..0a6d6899be5b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2308,9 +2308,11 @@ static void pull_dl_task(struct rq *this_rq)
 		double_unlock_balance(this_rq, src_rq);
 
 		if (push_task) {
+			preempt_disable();
 			raw_spin_rq_unlock(this_rq);
 			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
 					    push_task, &src_rq->push_work);
+			preempt_enable();
 			raw_spin_rq_lock(this_rq);
 		}
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 646a6ae4b250..fd8b5656641b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3987,22 +3987,6 @@ static inline unsigned long task_util_est(struct task_struct *p)
 	return max(task_util(p), _task_util_est(p));
 }
 
-#ifdef CONFIG_UCLAMP_TASK
-static inline unsigned long uclamp_task_util(struct task_struct *p,
-					     unsigned long uclamp_min,
-					     unsigned long uclamp_max)
-{
-	return clamp(task_util_est(p), uclamp_min, uclamp_max);
-}
-#else
-static inline unsigned long uclamp_task_util(struct task_struct *p,
-					     unsigned long uclamp_min,
-					     unsigned long uclamp_max)
-{
-	return task_util_est(p);
-}
-#endif
-
 static inline void util_est_enqueue(struct cfs_rq *cfs_rq,
 				    struct task_struct *p)
 {
@@ -7037,7 +7021,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!uclamp_task_util(p, p_util_min, p_util_max))
+	if (!task_util_est(p) && p_util_min == 0)
 		goto unlock;
 
 	for (; pd; pd = pd->next) {
@@ -10380,13 +10364,15 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			raw_spin_rq_unlock_irqrestore(busiest, flags);
 
+			preempt_disable();
+			raw_spin_rq_unlock_irqrestore(busiest, flags);
 			if (active_balance) {
 				stop_one_cpu_nowait(cpu_of(busiest),
 					active_load_balance_cpu_stop, busiest,
 					&busiest->active_balance_work);
 			}
+			preempt_enable();
 		}
 	} else {
 		sd->nr_balance_failed = 0;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b9281e6b1cc..7045595aacac 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1951,9 +1951,11 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 */
 		push_task = get_push_task(rq);
 		if (push_task) {
+			preempt_disable();
 			raw_spin_rq_unlock(rq);
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
 					    push_task, &rq->push_work);
+			preempt_enable();
 			raw_spin_rq_lock(rq);
 		}
 
@@ -2290,9 +2292,11 @@ static void pull_rt_task(struct rq *this_rq)
 		double_unlock_balance(this_rq, src_rq);
 
 		if (push_task) {
+			preempt_disable();
 			raw_spin_rq_unlock(this_rq);
 			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
 					    push_task, &src_rq->push_work);
+			preempt_enable();
 			raw_spin_rq_lock(this_rq);
 		}
 	}
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a015ed3f823b..0b3ee4eea51b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -942,9 +942,9 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
 /**
  * __kprobe_event_gen_cmd_start - Generate a kprobe event command from arg list
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
+ * @kretprobe: Is this a return probe?
  * @name: The name of the kprobe event
  * @loc: The location of the kprobe event
- * @kretprobe: Is this a return probe?
  * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
diff --git a/mm/readahead.c b/mm/readahead.c
index 41b75d76d36e..a8f7e4e550f4 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -627,7 +627,8 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 */
 	ret = -EINVAL;
 	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    !S_ISREG(file_inode(f.file)->i_mode))
+	    (!S_ISREG(file_inode(f.file)->i_mode) &&
+	    !S_ISBLK(file_inode(f.file)->i_mode)))
 		goto out;
 
 	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
diff --git a/net/9p/client.c b/net/9p/client.c
index c4c1e44cd7ca..9fdcaa956c00 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -520,12 +520,14 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		return 0;
 
 	if (!p9_is_proto_dotl(c)) {
-		char *ename;
+		char *ename = NULL;
 
 		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
-		if (err)
+		if (err) {
+			kfree(ename);
 			goto out_err;
+		}
 
 		if (p9_is_proto_dotu(c) && ecode < 512)
 			err = -ecode;
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index b44e46dc8e04..cab82344de9b 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -623,9 +623,6 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_parse_options(sk, dreq, skb))
 		goto drop_and_free;
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto drop_and_free;
-
 	ireq = inet_rsk(req);
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
@@ -633,6 +630,9 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	ireq->ireq_family = AF_INET;
 	ireq->ir_iif = sk->sk_bound_dev_if;
 
+	if (security_inet_conn_request(sk, skb, req))
+		goto drop_and_free;
+
 	/*
 	 * Step 3: Process LISTEN state
 	 *
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 0ddf64845a06..6f05e9d0d428 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -359,15 +359,15 @@ static int dccp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_parse_options(sk, dreq, skb))
 		goto drop_and_free;
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto drop_and_free;
-
 	ireq = inet_rsk(req);
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 	ireq->ireq_family = AF_INET6;
 	ireq->ir_mark = inet_request_mark(sk, skb);
 
+	if (security_inet_conn_request(sk, skb, req))
+		goto drop_and_free;
+
 	if (ipv6_opt_accepted(sk, skb, IP6CB(skb)) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
 	    np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 12ba43023d30..e31747d328e7 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -300,9 +300,7 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 	skb = skb_copy_expand(frame->skb_std, 0,
 			      skb_tailroom(frame->skb_std) + HSR_HLEN,
 			      GFP_ATOMIC);
-	prp_fill_rct(skb, frame, port);
-
-	return skb;
+	return prp_fill_rct(skb, frame, port);
 }
 
 static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 3aab914eb103..03b0505178f9 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -43,7 +43,6 @@ static siphash_key_t syncookie_secret[2] __read_mostly;
  * requested/supported by the syn/synack exchange.
  */
 #define TSBITS	6
-#define TSMASK	(((__u32)1 << TSBITS) - 1)
 
 static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
 		       u32 count, int c)
@@ -64,27 +63,22 @@ static u32 cookie_hash(__be32 saddr, __be32 daddr, __be16 sport, __be16 dport,
  */
 u64 cookie_init_timestamp(struct request_sock *req, u64 now)
 {
-	struct inet_request_sock *ireq;
-	u32 ts, ts_now = tcp_ns_to_ts(now);
+	const struct inet_request_sock *ireq = inet_rsk(req);
+	u64 ts, ts_now = tcp_ns_to_ts(now);
 	u32 options = 0;
 
-	ireq = inet_rsk(req);
-
 	options = ireq->wscale_ok ? ireq->snd_wscale : TS_OPT_WSCALE_MASK;
 	if (ireq->sack_ok)
 		options |= TS_OPT_SACK;
 	if (ireq->ecn_ok)
 		options |= TS_OPT_ECN;
 
-	ts = ts_now & ~TSMASK;
+	ts = (ts_now >> TSBITS) << TSBITS;
 	ts |= options;
-	if (ts > ts_now) {
-		ts >>= TSBITS;
-		ts--;
-		ts <<= TSBITS;
-		ts |= options;
-	}
-	return (u64)ts * (NSEC_PER_SEC / TCP_TS_HZ);
+	if (ts > ts_now)
+		ts -= (1UL << TSBITS);
+
+	return ts * (NSEC_PER_SEC / TCP_TS_HZ);
 }
 
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8e4b42d394be..a3453b4ac339 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6376,22 +6376,23 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 
 static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
 	struct request_sock *req;
 
 	/* If we are still handling the SYNACK RTO, see if timestamp ECR allows
 	 * undo. If peer SACKs triggered fast recovery, we can't undo here.
 	 */
-	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss)
-		tcp_try_undo_loss(sk, false);
+	if (inet_csk(sk)->icsk_ca_state == TCP_CA_Loss && !tp->packets_out)
+		tcp_try_undo_recovery(sk);
 
 	/* Reset rtx states to prevent spurious retransmits_timed_out() */
-	tcp_sk(sk)->retrans_stamp = 0;
+	tp->retrans_stamp = 0;
 	inet_csk(sk)->icsk_retransmits = 0;
 
 	/* Once we leave TCP_SYN_RECV or TCP_FIN_WAIT_1,
 	 * we no longer need req so release it.
 	 */
-	req = rcu_dereference_protected(tcp_sk(sk)->fastopen_rsk,
+	req = rcu_dereference_protected(tp->fastopen_rsk,
 					lockdep_sock_is_held(sk));
 	reqsk_fastopen_remove(sk, req, false);
 
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 5df97aaac252..def337f72c86 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -470,11 +470,15 @@ void tcp_init_metrics(struct sock *sk)
 	u32 val, crtt = 0; /* cached RTT scaled by 8 */
 
 	sk_dst_confirm(sk);
+	/* ssthresh may have been reduced unnecessarily during.
+	 * 3WHS. Restore it back to its initial default.
+	 */
+	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	if (!dst)
 		goto reset;
 
 	rcu_read_lock();
-	tm = tcp_get_metrics(sk, dst, true);
+	tm = tcp_get_metrics(sk, dst, false);
 	if (!tm) {
 		rcu_read_unlock();
 		goto reset;
@@ -489,11 +493,6 @@ void tcp_init_metrics(struct sock *sk)
 		tp->snd_ssthresh = val;
 		if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
 			tp->snd_ssthresh = tp->snd_cwnd_clamp;
-	} else {
-		/* ssthresh may have been reduced unnecessarily during.
-		 * 3WHS. Restore it back to its initial default.
-		 */
-		tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	}
 	val = tcp_metric_get(tm, TCP_METRIC_REORDERING);
 	if (val && tp->reordering != val)
@@ -908,7 +907,7 @@ static void tcp_metrics_flush_all(struct net *net)
 			match = net ? net_eq(tm_net(tm), net) :
 				!refcount_read(&tm_net(tm)->ns.count);
 			if (match) {
-				*pp = tm->tcpm_next;
+				rcu_assign_pointer(*pp, tm->tcpm_next);
 				kfree_rcu(tm, rcu_head);
 			} else {
 				pp = &tm->tcpm_next;
@@ -949,7 +948,7 @@ static int tcp_metrics_nl_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		if (addr_same(&tm->tcpm_daddr, &daddr) &&
 		    (!src || addr_same(&tm->tcpm_saddr, &saddr)) &&
 		    net_eq(tm_net(tm), net)) {
-			*pp = tm->tcpm_next;
+			rcu_assign_pointer(*pp, tm->tcpm_next);
 			kfree_rcu(tm, rcu_head);
 			found = true;
 		} else {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 198d8e07413d..c454daa78a2f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2711,10 +2711,12 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		case UDP_ENCAP_ESPINUDP_NON_IKE:
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == AF_INET6)
-				up->encap_rcv = ipv6_stub->xfrm6_udp_encap_rcv;
+				WRITE_ONCE(up->encap_rcv,
+					   ipv6_stub->xfrm6_udp_encap_rcv);
 			else
 #endif
-				up->encap_rcv = xfrm4_udp_encap_rcv;
+				WRITE_ONCE(up->encap_rcv,
+					   xfrm4_udp_encap_rcv);
 #endif
 			fallthrough;
 		case UDP_ENCAP_L2TPINUDP:
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 2207acd7108c..5045b479c2a9 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -159,7 +159,13 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 		int err;
 
 		skb_mark_not_on_list(segs);
-		err = ip6_fragment(net, sk, segs, ip6_finish_output2);
+		/* Last GSO segment can be smaller than gso_size (and MTU).
+		 * Adding a fragment header would produce an "atomic fragment",
+		 * which is considered harmful (RFC-8021). Avoid that.
+		 */
+		err = segs->len > mtu ?
+			ip6_fragment(net, sk, segs, ip6_finish_output2) :
+			ip6_finish_output2(net, sk, segs);
 		if (err && ret == 0)
 			ret = err;
 	}
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 12ae817aaf2e..c10a68bb85de 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -180,14 +180,15 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq = tcp_rsk(req);
 	treq->tfo_listener = false;
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto out_free;
-
 	req->mss = mss;
 	ireq->ir_rmt_port = th->source;
 	ireq->ir_num = ntohs(th->dest);
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
+
+	if (security_inet_conn_request(sk, skb, req))
+		goto out_free;
+
 	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
 	    np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 7cac441862e2..51bccfb00a9c 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -127,8 +127,14 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
 	if (skb->protocol == htons(ETH_P_802_2)) {
-		__be16 pdulen = eth_hdr(skb)->h_proto;
-		s32 data_size = ntohs(pdulen) - llc_len;
+		__be16 pdulen;
+		s32 data_size;
+
+		if (skb->mac_len < ETH_HLEN)
+			return 0;
+
+		pdulen = eth_hdr(skb)->h_proto;
+		data_size = ntohs(pdulen) - llc_len;
 
 		if (data_size < 0 ||
 		    !pskb_may_pull(skb, data_size))
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 79d1cef8f15a..06fb8e6944b0 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -153,6 +153,9 @@ int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
 	int rc = 1;
 	u32 data_size;
 
+	if (skb->mac_len < ETH_HLEN)
+		return 1;
+
 	llc_pdu_decode_sa(skb, mac_da);
 	llc_pdu_decode_da(skb, mac_sa);
 	llc_pdu_decode_ssap(skb, &dsap);
diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
index 05c6ae092053..f50654292510 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -76,6 +76,9 @@ static int llc_station_ac_send_test_r(struct sk_buff *skb)
 	u32 data_size;
 	struct sk_buff *nskb;
 
+	if (skb->mac_len < ETH_HLEN)
+		goto out;
+
 	/* The test request command is type U (llc_len = 3) */
 	data_size = ntohs(eth_hdr(skb)->h_proto) - 3;
 	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, data_size);
diff --git a/net/netfilter/nf_nat_redirect.c b/net/netfilter/nf_nat_redirect.c
index f91579c821e9..5b37487d9d11 100644
--- a/net/netfilter/nf_nat_redirect.c
+++ b/net/netfilter/nf_nat_redirect.c
@@ -10,6 +10,7 @@
 
 #include <linux/if.h>
 #include <linux/inetdevice.h>
+#include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
@@ -24,81 +25,104 @@
 #include <net/netfilter/nf_nat.h>
 #include <net/netfilter/nf_nat_redirect.h>
 
+static unsigned int
+nf_nat_redirect(struct sk_buff *skb, const struct nf_nat_range2 *range,
+		const union nf_inet_addr *newdst)
+{
+	struct nf_nat_range2 newrange;
+	enum ip_conntrack_info ctinfo;
+	struct nf_conn *ct;
+
+	ct = nf_ct_get(skb, &ctinfo);
+
+	memset(&newrange, 0, sizeof(newrange));
+
+	newrange.flags		= range->flags | NF_NAT_RANGE_MAP_IPS;
+	newrange.min_addr	= *newdst;
+	newrange.max_addr	= *newdst;
+	newrange.min_proto	= range->min_proto;
+	newrange.max_proto	= range->max_proto;
+
+	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+}
+
 unsigned int
-nf_nat_redirect_ipv4(struct sk_buff *skb,
-		     const struct nf_nat_ipv4_multi_range_compat *mr,
+nf_nat_redirect_ipv4(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum)
 {
-	struct nf_conn *ct;
-	enum ip_conntrack_info ctinfo;
-	__be32 newdst;
-	struct nf_nat_range2 newrange;
+	union nf_inet_addr newdst = {};
 
 	WARN_ON(hooknum != NF_INET_PRE_ROUTING &&
 		hooknum != NF_INET_LOCAL_OUT);
 
-	ct = nf_ct_get(skb, &ctinfo);
-	WARN_ON(!(ct && (ctinfo == IP_CT_NEW || ctinfo == IP_CT_RELATED)));
-
 	/* Local packets: make them go to loopback */
 	if (hooknum == NF_INET_LOCAL_OUT) {
-		newdst = htonl(0x7F000001);
+		newdst.ip = htonl(INADDR_LOOPBACK);
 	} else {
 		const struct in_device *indev;
 
-		newdst = 0;
-
 		indev = __in_dev_get_rcu(skb->dev);
 		if (indev) {
 			const struct in_ifaddr *ifa;
 
 			ifa = rcu_dereference(indev->ifa_list);
 			if (ifa)
-				newdst = ifa->ifa_local;
+				newdst.ip = ifa->ifa_local;
 		}
 
-		if (!newdst)
+		if (!newdst.ip)
 			return NF_DROP;
 	}
 
-	/* Transfer from original range. */
-	memset(&newrange.min_addr, 0, sizeof(newrange.min_addr));
-	memset(&newrange.max_addr, 0, sizeof(newrange.max_addr));
-	newrange.flags	     = mr->range[0].flags | NF_NAT_RANGE_MAP_IPS;
-	newrange.min_addr.ip = newdst;
-	newrange.max_addr.ip = newdst;
-	newrange.min_proto   = mr->range[0].min;
-	newrange.max_proto   = mr->range[0].max;
-
-	/* Hand modified range to generic setup. */
-	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+	return nf_nat_redirect(skb, range, &newdst);
 }
 EXPORT_SYMBOL_GPL(nf_nat_redirect_ipv4);
 
 static const struct in6_addr loopback_addr = IN6ADDR_LOOPBACK_INIT;
 
+static bool nf_nat_redirect_ipv6_usable(const struct inet6_ifaddr *ifa, unsigned int scope)
+{
+	unsigned int ifa_addr_type = ipv6_addr_type(&ifa->addr);
+
+	if (ifa_addr_type & IPV6_ADDR_MAPPED)
+		return false;
+
+	if ((ifa->flags & IFA_F_TENTATIVE) && (!(ifa->flags & IFA_F_OPTIMISTIC)))
+		return false;
+
+	if (scope) {
+		unsigned int ifa_scope = ifa_addr_type & IPV6_ADDR_SCOPE_MASK;
+
+		if (!(scope & ifa_scope))
+			return false;
+	}
+
+	return true;
+}
+
 unsigned int
 nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 		     unsigned int hooknum)
 {
-	struct nf_nat_range2 newrange;
-	struct in6_addr newdst;
-	enum ip_conntrack_info ctinfo;
-	struct nf_conn *ct;
+	union nf_inet_addr newdst = {};
 
-	ct = nf_ct_get(skb, &ctinfo);
 	if (hooknum == NF_INET_LOCAL_OUT) {
-		newdst = loopback_addr;
+		newdst.in6 = loopback_addr;
 	} else {
+		unsigned int scope = ipv6_addr_scope(&ipv6_hdr(skb)->daddr);
 		struct inet6_dev *idev;
-		struct inet6_ifaddr *ifa;
 		bool addr = false;
 
 		idev = __in6_dev_get(skb->dev);
 		if (idev != NULL) {
+			const struct inet6_ifaddr *ifa;
+
 			read_lock_bh(&idev->lock);
 			list_for_each_entry(ifa, &idev->addr_list, if_list) {
-				newdst = ifa->addr;
+				if (!nf_nat_redirect_ipv6_usable(ifa, scope))
+					continue;
+
+				newdst.in6 = ifa->addr;
 				addr = true;
 				break;
 			}
@@ -109,12 +133,6 @@ nf_nat_redirect_ipv6(struct sk_buff *skb, const struct nf_nat_range2 *range,
 			return NF_DROP;
 	}
 
-	newrange.flags		= range->flags | NF_NAT_RANGE_MAP_IPS;
-	newrange.min_addr.in6	= newdst;
-	newrange.max_addr.in6	= newdst;
-	newrange.min_proto	= range->min_proto;
-	newrange.max_proto	= range->max_proto;
-
-	return nf_nat_setup_info(ct, &newrange, NF_NAT_MANIP_DST);
+	return nf_nat_redirect(skb, range, &newdst);
 }
 EXPORT_SYMBOL_GPL(nf_nat_redirect_ipv6);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8a4cd1c16e0e..8f12e83280cb 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3184,10 +3184,6 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 			goto cont_skip;
 		if (*idx < s_idx)
 			goto cont;
-		if (*idx > s_idx) {
-			memset(&cb->args[1], 0,
-					sizeof(cb->args) - sizeof(cb->args[0]));
-		}
 		if (prule)
 			handle = prule->handle;
 		else
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index e64f531d66cf..677ce4218369 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -64,6 +64,8 @@ static int nft_redir_init(const struct nft_ctx *ctx,
 		} else {
 			priv->sreg_proto_max = priv->sreg_proto_min;
 		}
+
+		priv->flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
 	}
 
 	if (tb[NFTA_REDIR_FLAGS]) {
@@ -98,25 +100,37 @@ static int nft_redir_dump(struct sk_buff *skb, const struct nft_expr *expr)
 	return -1;
 }
 
-static void nft_redir_ipv4_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
+static void nft_redir_eval(const struct nft_expr *expr,
+			   struct nft_regs *regs,
+			   const struct nft_pktinfo *pkt)
 {
-	struct nft_redir *priv = nft_expr_priv(expr);
-	struct nf_nat_ipv4_multi_range_compat mr;
+	const struct nft_redir *priv = nft_expr_priv(expr);
+	struct nf_nat_range2 range;
 
-	memset(&mr, 0, sizeof(mr));
+	memset(&range, 0, sizeof(range));
+	range.flags = priv->flags;
 	if (priv->sreg_proto_min) {
-		mr.range[0].min.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_min]);
-		mr.range[0].max.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_max]);
-		mr.range[0].flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
+		range.min_proto.all = (__force __be16)
+			nft_reg_load16(&regs->data[priv->sreg_proto_min]);
+		range.max_proto.all = (__force __be16)
+			nft_reg_load16(&regs->data[priv->sreg_proto_max]);
 	}
 
-	mr.range[0].flags |= priv->flags;
-
-	regs->verdict.code = nf_nat_redirect_ipv4(pkt->skb, &mr, nft_hook(pkt));
+	switch (nft_pf(pkt)) {
+	case NFPROTO_IPV4:
+		regs->verdict.code = nf_nat_redirect_ipv4(pkt->skb, &range,
+							  nft_hook(pkt));
+		break;
+#ifdef CONFIG_NF_TABLES_IPV6
+	case NFPROTO_IPV6:
+		regs->verdict.code = nf_nat_redirect_ipv6(pkt->skb, &range,
+							  nft_hook(pkt));
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
 }
 
 static void
@@ -129,7 +143,7 @@ static struct nft_expr_type nft_redir_ipv4_type;
 static const struct nft_expr_ops nft_redir_ipv4_ops = {
 	.type		= &nft_redir_ipv4_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_ipv4_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_ipv4_destroy,
 	.dump		= nft_redir_dump,
@@ -146,28 +160,6 @@ static struct nft_expr_type nft_redir_ipv4_type __read_mostly = {
 };
 
 #ifdef CONFIG_NF_TABLES_IPV6
-static void nft_redir_ipv6_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
-{
-	struct nft_redir *priv = nft_expr_priv(expr);
-	struct nf_nat_range2 range;
-
-	memset(&range, 0, sizeof(range));
-	if (priv->sreg_proto_min) {
-		range.min_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_min]);
-		range.max_proto.all = (__force __be16)nft_reg_load16(
-			&regs->data[priv->sreg_proto_max]);
-		range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
-	}
-
-	range.flags |= priv->flags;
-
-	regs->verdict.code =
-		nf_nat_redirect_ipv6(pkt->skb, &range, nft_hook(pkt));
-}
-
 static void
 nft_redir_ipv6_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
@@ -178,7 +170,7 @@ static struct nft_expr_type nft_redir_ipv6_type;
 static const struct nft_expr_ops nft_redir_ipv6_ops = {
 	.type		= &nft_redir_ipv6_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_ipv6_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_ipv6_destroy,
 	.dump		= nft_redir_dump,
@@ -196,20 +188,6 @@ static struct nft_expr_type nft_redir_ipv6_type __read_mostly = {
 #endif
 
 #ifdef CONFIG_NF_TABLES_INET
-static void nft_redir_inet_eval(const struct nft_expr *expr,
-				struct nft_regs *regs,
-				const struct nft_pktinfo *pkt)
-{
-	switch (nft_pf(pkt)) {
-	case NFPROTO_IPV4:
-		return nft_redir_ipv4_eval(expr, regs, pkt);
-	case NFPROTO_IPV6:
-		return nft_redir_ipv6_eval(expr, regs, pkt);
-	}
-
-	WARN_ON_ONCE(1);
-}
-
 static void
 nft_redir_inet_destroy(const struct nft_ctx *ctx, const struct nft_expr *expr)
 {
@@ -220,7 +198,7 @@ static struct nft_expr_type nft_redir_inet_type;
 static const struct nft_expr_ops nft_redir_inet_ops = {
 	.type		= &nft_redir_inet_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_redir)),
-	.eval		= nft_redir_inet_eval,
+	.eval		= nft_redir_eval,
 	.init		= nft_redir_init,
 	.destroy	= nft_redir_inet_destroy,
 	.dump		= nft_redir_dump,
diff --git a/net/netfilter/xt_REDIRECT.c b/net/netfilter/xt_REDIRECT.c
index 353ca7801251..ff66b56a3f97 100644
--- a/net/netfilter/xt_REDIRECT.c
+++ b/net/netfilter/xt_REDIRECT.c
@@ -46,7 +46,6 @@ static void redirect_tg_destroy(const struct xt_tgdtor_param *par)
 	nf_ct_netns_put(par->net, par->family);
 }
 
-/* FIXME: Take multiple ranges --RR */
 static int redirect_tg4_check(const struct xt_tgchk_param *par)
 {
 	const struct nf_nat_ipv4_multi_range_compat *mr = par->targinfo;
@@ -65,7 +64,14 @@ static int redirect_tg4_check(const struct xt_tgchk_param *par)
 static unsigned int
 redirect_tg4(struct sk_buff *skb, const struct xt_action_param *par)
 {
-	return nf_nat_redirect_ipv4(skb, par->targinfo, xt_hooknum(par));
+	const struct nf_nat_ipv4_multi_range_compat *mr = par->targinfo;
+	struct nf_nat_range2 range = {
+		.flags       = mr->range[0].flags,
+		.min_proto   = mr->range[0].min,
+		.max_proto   = mr->range[0].max,
+	};
+
+	return nf_nat_redirect_ipv4(skb, &range, xt_hooknum(par));
 }
 
 static struct xt_target redirect_tg_reg[] __read_mostly = {
diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 0446307516cd..39937ff24527 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -561,7 +561,7 @@ recent_mt_proc_write(struct file *file, const char __user *input,
 {
 	struct recent_table *t = PDE_DATA(file_inode(file));
 	struct recent_entry *e;
-	char buf[sizeof("+b335:1d35:1e55:dead:c0de:1715:5afe:c0de")];
+	char buf[sizeof("+b335:1d35:1e55:dead:c0de:1715:255.255.255.255")];
 	const char *c = buf;
 	union nf_inet_addr addr = {};
 	u_int16_t family;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9cdb7df0801f..49cf523a783a 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -145,7 +145,7 @@ static int __smc_release(struct smc_sock *smc)
 
 	if (!smc->use_fallback) {
 		rc = smc_close_active(smc);
-		sock_set_flag(sk, SOCK_DEAD);
+		smc_sock_set_flag(sk, SOCK_DEAD);
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	} else {
 		if (sk->sk_state != SMC_CLOSED) {
@@ -1334,7 +1334,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 		if (new_clcsock)
 			sock_release(new_clcsock);
 		new_sk->sk_state = SMC_CLOSED;
-		sock_set_flag(new_sk, SOCK_DEAD);
+		smc_sock_set_flag(new_sk, SOCK_DEAD);
 		sock_put(new_sk); /* final */
 		*new_smc = NULL;
 		goto out;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index 930544f7b2e2..57e376756b91 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -315,4 +315,9 @@ static inline bool using_ipsec(struct smc_sock *smc)
 struct sock *smc_accept_dequeue(struct sock *parent, struct socket *new_sock);
 void smc_close_non_accepted(struct sock *sk);
 
+static inline void smc_sock_set_flag(struct sock *sk, enum sock_flags flag)
+{
+	set_bit(flag, &sk->sk_flags);
+}
+
 #endif	/* __SMC_H */
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 41b23f71c29a..1df755736267 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -28,13 +28,15 @@ static void smc_cdc_tx_handler(struct smc_wr_tx_pend_priv *pnd_snd,
 {
 	struct smc_cdc_tx_pend *cdcpend = (struct smc_cdc_tx_pend *)pnd_snd;
 	struct smc_connection *conn = cdcpend->conn;
+	struct smc_buf_desc *sndbuf_desc;
 	struct smc_sock *smc;
 	int diff;
 
+	sndbuf_desc = conn->sndbuf_desc;
 	smc = container_of(conn, struct smc_sock, conn);
 	bh_lock_sock(&smc->sk);
-	if (!wc_status) {
-		diff = smc_curs_diff(cdcpend->conn->sndbuf_desc->len,
+	if (!wc_status && sndbuf_desc) {
+		diff = smc_curs_diff(sndbuf_desc->len,
 				     &cdcpend->conn->tx_curs_fin,
 				     &cdcpend->cursor);
 		/* sndbuf_space is decreased in smc_sendmsg */
@@ -104,9 +106,6 @@ int smc_cdc_msg_send(struct smc_connection *conn,
 	union smc_host_cursor cfed;
 	int rc;
 
-	if (unlikely(!READ_ONCE(conn->sndbuf_desc)))
-		return -ENOBUFS;
-
 	smc_cdc_add_pending_send(conn, pend);
 
 	conn->tx_cdc_seq++;
@@ -370,7 +369,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		smc->sk.sk_shutdown |= RCV_SHUTDOWN;
 		if (smc->clcsock && smc->clcsock->sk)
 			smc->clcsock->sk->sk_shutdown |= RCV_SHUTDOWN;
-		sock_set_flag(&smc->sk, SOCK_DONE);
+		smc_sock_set_flag(&smc->sk, SOCK_DONE);
 		sock_hold(&smc->sk); /* sock_put in close_work */
 		if (!queue_work(smc_close_wq, &conn->close_work))
 			sock_put(&smc->sk);
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 149a59ecd299..bcd3ea894555 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -113,7 +113,8 @@ static void smc_close_cancel_work(struct smc_sock *smc)
 	struct sock *sk = &smc->sk;
 
 	release_sock(sk);
-	cancel_work_sync(&smc->conn.close_work);
+	if (cancel_work_sync(&smc->conn.close_work))
+		sock_put(sk);
 	cancel_delayed_work_sync(&smc->conn.tx_work);
 	lock_sock(sk);
 }
@@ -170,7 +171,7 @@ void smc_close_active_abort(struct smc_sock *smc)
 		break;
 	}
 
-	sock_set_flag(sk, SOCK_DEAD);
+	smc_sock_set_flag(sk, SOCK_DEAD);
 	sk->sk_state_change(sk);
 
 	if (release_clcsock) {
diff --git a/net/tipc/link.c b/net/tipc/link.c
index 655a2e1b6dfe..d13a85b9cdb2 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1445,7 +1445,7 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
 		p = (struct tipc_gap_ack_blks *)msg_data(hdr);
 		sz = ntohs(p->len);
 		/* Sanity check */
-		if (sz == struct_size(p, gacks, p->ugack_cnt + p->bgack_cnt)) {
+		if (sz == struct_size(p, gacks, size_add(p->ugack_cnt, p->bgack_cnt))) {
 			/* Good, check if the desired type exists */
 			if ((uc && p->ugack_cnt) || (!uc && p->bgack_cnt))
 				goto ok;
@@ -1532,7 +1532,7 @@ static u16 tipc_build_gap_ack_blks(struct tipc_link *l, struct tipc_msg *hdr)
 			__tipc_build_gap_ack_blks(ga, l, ga->bgack_cnt) : 0;
 
 	/* Total len */
-	len = struct_size(ga, gacks, ga->bgack_cnt + ga->ugack_cnt);
+	len = struct_size(ga, gacks, size_add(ga->bgack_cnt, ga->ugack_cnt));
 	ga->len = htons(len);
 	return len;
 }
diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index c447cb5f879e..f10ed873858f 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -88,7 +88,7 @@ const struct nla_policy tipc_nl_net_policy[TIPC_NLA_NET_MAX + 1] = {
 
 const struct nla_policy tipc_nl_link_policy[TIPC_NLA_LINK_MAX + 1] = {
 	[TIPC_NLA_LINK_UNSPEC]		= { .type = NLA_UNSPEC },
-	[TIPC_NLA_LINK_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_LINK_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_LINK_NAME },
 	[TIPC_NLA_LINK_MTU]		= { .type = NLA_U32 },
 	[TIPC_NLA_LINK_BROADCAST]	= { .type = NLA_FLAG },
@@ -125,7 +125,7 @@ const struct nla_policy tipc_nl_prop_policy[TIPC_NLA_PROP_MAX + 1] = {
 
 const struct nla_policy tipc_nl_bearer_policy[TIPC_NLA_BEARER_MAX + 1]	= {
 	[TIPC_NLA_BEARER_UNSPEC]	= { .type = NLA_UNSPEC },
-	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_BEARER_NAME },
 	[TIPC_NLA_BEARER_PROP]		= { .type = NLA_NESTED },
 	[TIPC_NLA_BEARER_DOMAIN]	= { .type = NLA_U32 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 05089ef5cc0e..23e7102abe0c 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1339,13 +1339,13 @@ static int do_typec_entry(const char *filename, void *symval, char *alias)
 /* Looks like: tee:uuid */
 static int do_tee_entry(const char *filename, void *symval, char *alias)
 {
-	DEF_FIELD(symval, tee_client_device_id, uuid);
+	DEF_FIELD_ADDR(symval, tee_client_device_id, uuid);
 
 	sprintf(alias, "tee:%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
-		uuid.b[0], uuid.b[1], uuid.b[2], uuid.b[3], uuid.b[4],
-		uuid.b[5], uuid.b[6], uuid.b[7], uuid.b[8], uuid.b[9],
-		uuid.b[10], uuid.b[11], uuid.b[12], uuid.b[13], uuid.b[14],
-		uuid.b[15]);
+		uuid->b[0], uuid->b[1], uuid->b[2], uuid->b[3], uuid->b[4],
+		uuid->b[5], uuid->b[6], uuid->b[7], uuid->b[8], uuid->b[9],
+		uuid->b[10], uuid->b[11], uuid->b[12], uuid->b[13], uuid->b[14],
+		uuid->b[15]);
 
 	add_wildcard(alias);
 	return 1;
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b07607a9ecea..0a7e2f8ca71a 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -870,18 +870,13 @@ static int hdmi_codec_set_jack(struct snd_soc_component *component,
 			       void *data)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
-	int ret = -ENOTSUPP;
 
 	if (hcp->hcd.ops->hook_plugged_cb) {
 		hcp->jack = jack;
-		ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
-						    hcp->hcd.data,
-						    plugged_cb,
-						    component->dev);
-		if (ret)
-			hcp->jack = NULL;
+		return 0;
 	}
-	return ret;
+
+	return -ENOTSUPP;
 }
 
 static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
@@ -965,6 +960,21 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
 	return ret;
 }
 
+static int hdmi_probe(struct snd_soc_component *component)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	if (hcp->hcd.ops->hook_plugged_cb) {
+		ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
+						    hcp->hcd.data,
+						    plugged_cb,
+						    component->dev);
+	}
+
+	return ret;
+}
+
 static void hdmi_remove(struct snd_soc_component *component)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
@@ -975,6 +985,7 @@ static void hdmi_remove(struct snd_soc_component *component)
 }
 
 static const struct snd_soc_component_driver hdmi_driver = {
+	.probe			= hdmi_probe,
 	.remove			= hdmi_remove,
 	.dapm_widgets		= hdmi_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index cf0e10d17dbe..c7ff48208d00 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1965,17 +1965,21 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 					      &fsl_easrc_dai, 1);
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = devm_snd_soc_register_component(dev, &fsl_asrc_component,
 					      NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ASoC platform\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static int fsl_easrc_remove(struct platform_device *pdev)
diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 901497810020..3f7ccae3f6b1 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -100,6 +100,9 @@ static irqreturn_t psc_dma_bcom_irq(int irq, void *_psc_dma_stream)
 
 /**
  * psc_dma_trigger: start and stop the DMA transfer.
+ * @component: triggered component
+ * @substream: triggered substream
+ * @cmd: triggered command
  *
  * This function is called by ALSA to start, stop, pause, and resume the DMA
  * transfer of data.
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 57ea815d3f04..b776c58dcf47 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -299,6 +299,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 		module->instance_id = devm_kzalloc(ctx->dev, size, GFP_KERNEL);
 		if (!module->instance_id) {
 			ret = -ENOMEM;
+			kfree(module);
 			goto free_uuid_list;
 		}
 
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index ecd24d412a9b..4537ef1b676f 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -303,7 +303,7 @@ static int cx81801_open(struct tty_struct *tty)
 static void cx81801_close(struct tty_struct *tty)
 {
 	struct snd_soc_component *component = tty->disc_data;
-	struct snd_soc_dapm_context *dapm = &component->card->dapm;
+	struct snd_soc_dapm_context *dapm;
 
 	del_timer_sync(&cx81801_timer);
 
@@ -315,6 +315,8 @@ static void cx81801_close(struct tty_struct *tty)
 
 	v253_ops.close(tty);
 
+	dapm = &component->card->dapm;
+
 	/* Revert back to default audio input/output constellation */
 	snd_soc_dapm_mutex_lock(dapm);
 
diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 44bbf80f0cfd..0d0a7a19d6f9 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -54,9 +54,12 @@ enum autochan {
 static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 {
 	unsigned int bytes = 0;
-	int i = 0;
+	int i = 0, max = 0;
+	unsigned int misalignment;
 
 	while (i < num_channels) {
+		if (channels[i].bytes > max)
+			max = channels[i].bytes;
 		if (bytes % channels[i].bytes == 0)
 			channels[i].location = bytes;
 		else
@@ -66,6 +69,14 @@ static unsigned int size_from_channelarray(struct iio_channel_info *channels, in
 		bytes = channels[i].location + channels[i].bytes;
 		i++;
 	}
+	/*
+	 * We want the data in next sample to also be properly aligned so
+	 * we'll add padding at the end if needed. Adding padding only
+	 * works for channel data which size is 2^n bytes.
+	 */
+	misalignment = bytes % max;
+	if (misalignment)
+		bytes += max - misalignment;
 
 	return bytes;
 }
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index b776465e04ef..e67935b1e306 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2635,8 +2635,6 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 
 	/* If we have branch cycles always annotate them. */
 	if (bs && bs->nr && entries[0].flags.cycles) {
-		int i;
-
 		bi = sample__resolve_bstack(sample, al);
 		if (bi) {
 			struct addr_map_symbol *prev = NULL;
@@ -2651,7 +2649,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			 * Note that perf stores branches reversed from
 			 * program order!
 			 */
-			for (i = bs->nr - 1; i >= 0; i--) {
+			for (int i = bs->nr - 1; i >= 0; i--) {
 				addr_map_symbol__account_cycles(&bi[i].from,
 					nonany_branch_mode ? NULL : prev,
 					bi[i].flags.cycles);
@@ -2660,6 +2658,12 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 				if (total_cycles)
 					*total_cycles += bi[i].flags.cycles;
 			}
+			for (unsigned int i = 0; i < bs->nr; i++) {
+				map__put(bi[i].to.ms.map);
+				maps__put(bi[i].to.ms.maps);
+				map__put(bi[i].from.ms.map);
+				maps__put(bi[i].from.ms.maps);
+			}
 			free(bi);
 		}
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 55a041329990..a0df9d24b2cb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2437,16 +2437,18 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
 		save_lbr_cursor_node(thread, cursor, i);
 	}
 
-	/* Add LBR ip from first entries.to */
-	ip = entries[0].to;
-	flags = &entries[0].flags;
-	*branch_from = entries[0].from;
-	err = add_callchain_ip(thread, cursor, parent,
-			       root_al, &cpumode, ip,
-			       true, flags, NULL,
-			       *branch_from);
-	if (err)
-		return err;
+	if (lbr_nr > 0) {
+		/* Add LBR ip from first entries.to */
+		ip = entries[0].to;
+		flags = &entries[0].flags;
+		*branch_from = entries[0].from;
+		err = add_callchain_ip(thread, cursor, parent,
+				root_al, &cpumode, ip,
+				true, flags, NULL,
+				*branch_from);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index b5940e6ca67c..28e30ad4a30e 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -272,11 +272,11 @@ static void test_tailcall_3(void)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	i = 0;
 	err = bpf_map_lookup_elem(data_fd, &i, &val);
@@ -334,11 +334,11 @@ static void test_tailcall_4(void)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
@@ -422,11 +422,11 @@ static void test_tailcall_5(void)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	for (i = 0; i < bpf_map__def(prog_array)->max_entries; i++) {
 		snprintf(prog_name, sizeof(prog_name), "classifier/%i", i);
@@ -610,11 +610,11 @@ static void test_tailcall_bpf2bpf_2(void)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	i = 0;
 	err = bpf_map_lookup_elem(data_fd, &i, &val);
@@ -783,11 +783,11 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 
 	data_map = bpf_object__find_map_by_name(obj, "tailcall.bss");
 	if (CHECK_FAIL(!data_map || !bpf_map__is_internal(data_map)))
-		return;
+		goto out;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
-		return;
+	if (CHECK_FAIL(data_fd < 0))
+		goto out;
 
 	i = 0;
 	val.noise = noise;
@@ -810,6 +810,59 @@ static void test_tailcall_bpf2bpf_4(bool noise)
 	bpf_object__close(obj);
 }
 
+#include "tailcall_bpf2bpf6.skel.h"
+
+/* Tail call counting works even when there is data on stack which is
+ * not aligned to 8 bytes.
+ */
+static void test_tailcall_bpf2bpf_6(void)
+{
+	struct tailcall_bpf2bpf6 *obj;
+	int err, map_fd, prog_fd, main_fd, data_fd, i, val;
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+
+	obj = tailcall_bpf2bpf6__open_and_load();
+	if (!ASSERT_OK_PTR(obj, "open and load"))
+		return;
+
+	main_fd = bpf_program__fd(obj->progs.entry);
+	if (!ASSERT_GE(main_fd, 0, "entry prog fd"))
+		goto out;
+
+	map_fd = bpf_map__fd(obj->maps.jmp_table);
+	if (!ASSERT_GE(map_fd, 0, "jmp_table map fd"))
+		goto out;
+
+	prog_fd = bpf_program__fd(obj->progs.classifier_0);
+	if (!ASSERT_GE(prog_fd, 0, "classifier_0 prog fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "jmp_table map update"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(main_fd, &topts);
+	ASSERT_OK(err, "entry prog test run");
+	ASSERT_EQ(topts.retval, 0, "tailcall retval");
+
+	data_fd = bpf_map__fd(obj->maps.bss);
+	if (!ASSERT_GE(data_fd, 0, "bss map fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "bss map lookup");
+	ASSERT_EQ(val, 1, "done flag is set");
+
+out:
+	tailcall_bpf2bpf6__destroy(obj);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -832,4 +885,6 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_4(false);
 	if (test__start_subtest("tailcall_bpf2bpf_5"))
 		test_tailcall_bpf2bpf_4(true);
+	if (test__start_subtest("tailcall_bpf2bpf_6"))
+		test_tailcall_bpf2bpf_6();
 }
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
new file mode 100644
index 000000000000..41ce83da78e8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#define __unused __attribute__((unused))
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+int done = 0;
+
+SEC("tc")
+int classifier_0(struct __sk_buff *skb __unused)
+{
+	done = 1;
+	return 0;
+}
+
+static __noinline
+int subprog_tail(struct __sk_buff *skb)
+{
+	/* Don't propagate the constant to the caller */
+	volatile int ret = 1;
+
+	bpf_tail_call_static(skb, &jmp_table, 0);
+	return ret;
+}
+
+SEC("tc")
+int entry(struct __sk_buff *skb)
+{
+	/* Have data on stack which size is not a multiple of 8 */
+	volatile char arr[1] = {};
+
+	return subprog_tail(skb);
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index da6ab300207c..0a9d482c5058 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1880,7 +1880,7 @@ run_test() {
 	case $ret in
 		0)
 			all_skipped=false
-			[ $exitcode=$ksft_skip ] && exitcode=0
+			[ $exitcode -eq $ksft_skip ] && exitcode=0
 		;;
 		$ksft_skip)
 			[ $all_skipped = true ] && exitcode=$ksft_skip
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index 3fd8e903118f..3bc46d6151f4 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -62,7 +62,7 @@ static void error_report(struct error *err, const char *test_name)
 		break;
 
 	case PIDFD_PASS:
-		ksft_test_result_pass("%s test: Passed\n");
+		ksft_test_result_pass("%s test: Passed\n", test_name);
 		break;
 
 	default:
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9a2d64901d59..79f543ad394c 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -380,13 +380,13 @@ static int test_pidfd_send_signal_syscall_support(void)
 
 static void *test_pidfd_poll_exec_thread(void *priv)
 {
-	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
+	ksft_print_msg("Child Thread: starting. pid %d tid %ld ; and sleeping\n",
 			getpid(), syscall(SYS_gettid));
 	ksft_print_msg("Child Thread: doing exec of sleep\n");
 
 	execl("/bin/sleep", "sleep", str(CHILD_THREAD_MIN_WAIT), (char *)NULL);
 
-	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n",
+	ksft_print_msg("Child Thread: DONE. pid %d tid %ld\n",
 			getpid(), syscall(SYS_gettid));
 	return NULL;
 }
@@ -426,7 +426,7 @@ static int child_poll_exec_test(void *args)
 {
 	pthread_t t1;
 
-	ksft_print_msg("Child (pidfd): starting. pid %d tid %d\n", getpid(),
+	ksft_print_msg("Child (pidfd): starting. pid %d tid %ld\n", getpid(),
 			syscall(SYS_gettid));
 	pthread_create(&t1, NULL, test_pidfd_poll_exec_thread, NULL);
 	/*
@@ -477,10 +477,10 @@ static void test_pidfd_poll_exec(int use_waitpid)
 
 static void *test_pidfd_poll_leader_exit_thread(void *priv)
 {
-	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
+	ksft_print_msg("Child Thread: starting. pid %d tid %ld ; and sleeping\n",
 			getpid(), syscall(SYS_gettid));
 	sleep(CHILD_THREAD_MIN_WAIT);
-	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+	ksft_print_msg("Child Thread: DONE. pid %d tid %ld\n", getpid(), syscall(SYS_gettid));
 	return NULL;
 }
 
@@ -489,7 +489,7 @@ static int child_poll_leader_exit_test(void *args)
 {
 	pthread_t t1, t2;
 
-	ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+	ksft_print_msg("Child: starting. pid %d tid %ld\n", getpid(), syscall(SYS_gettid));
 	pthread_create(&t1, NULL, test_pidfd_poll_leader_exit_thread, NULL);
 	pthread_create(&t2, NULL, test_pidfd_poll_leader_exit_thread, NULL);
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3e7cdf1125df..e9895ebd2a2d 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -224,9 +224,14 @@ int main(int argc, char **argv)
 		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
 
 	if (has_ben) {
+		if (argc - ben_ind >= BENCHMARK_ARGS)
+			ksft_exit_fail_msg("Too long benchmark command.\n");
+
 		/* Extract benchmark command from command line. */
 		for (i = ben_ind; i < argc; i++) {
 			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
+			if (strlen(argv[i]) >= BENCHMARK_ARG_SIZE)
+				ksft_exit_fail_msg("Too long benchmark command argument.\n");
 			sprintf(benchmark_cmd[i - ben_ind], "%s", argv[i]);
 		}
 		benchmark_cmd[ben_count] = NULL;
