Return-Path: <linux-kernel+bounces-148236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A6E8A7FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB965283F91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9346135A63;
	Wed, 17 Apr 2024 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U/53EfrM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA511F516;
	Wed, 17 Apr 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346447; cv=none; b=g+PCeYw/8ySRNYFOivpcdPiSLxogTAEVQCuLWDyNYKCXzxcUmgoygp99GazQWVKcxCXjjpD07Eu7y92p7Ct87AUG/58UMtM2kVcR8zIdWVUxK9L0aBfw6TwukD7IAnD+2i4O299OsxH0DshZfpMAkZdeGxv6L/SV8ND6RRxM7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346447; c=relaxed/simple;
	bh=Ynpr4ofFZ/cTbcddo79EjNkOMRo5NrS4VVBqQ6dg/ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2JUr/aM73RMUZhOLBV8HFu/0Oyaqi94PMg9wjjYfP9SoP7fGlGE/s7qBR46Yw6QEwsD9N5AxErS4MVgBIAABl9u4zgSPjD2qAnOvAgRu3ii8VAHpqba4vwdFurps4gt5cyrbWLeBSBsi1saBpXA8fk4rWCaeihUlH4Ic0ebf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U/53EfrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F78C072AA;
	Wed, 17 Apr 2024 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713346446;
	bh=Ynpr4ofFZ/cTbcddo79EjNkOMRo5NrS4VVBqQ6dg/ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/53EfrMGYTGArRgUVsH7QDP1yDJv+3fmIXqxBgLNhAJvOaxiBpRDttPuw5qUjQCD
	 MXE/wIigztEaUwsz2FsFIYwJdxGY60jO341d6byA4ezS7ai8hpXqFWvq/gk0JmA1gC
	 Ll02nb5bES2aMUy4V1jD4E36uUAsjTy2MV0MEGAM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.156
Date: Wed, 17 Apr 2024 11:34:02 +0200
Message-ID: <2024041701-stream-evade-2e37@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024041700-skirmish-pajamas-e9a7@gregkh>
References: <2024041700-skirmish-pajamas-e9a7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index fda00aac0d72..b038410eccb6 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -439,12 +439,12 @@ The possible values in this file are:
    - System is protected by retpoline
  * - BHI: BHI_DIS_S
    - System is protected by BHI_DIS_S
- * - BHI: SW loop; KVM SW loop
+ * - BHI: SW loop, KVM SW loop
    - System is protected by software clearing sequence
- * - BHI: Syscall hardening
-   - Syscalls are hardened against BHI
- * - BHI: Syscall hardening; KVM: SW loop
-   - System is protected from userspace attacks by syscall hardening; KVM is protected by software clearing sequence
+ * - BHI: Vulnerable
+   - System is vulnerable to BHI
+ * - BHI: Vulnerable, KVM: SW loop
+   - System is vulnerable; KVM is protected by software clearing sequence
 
 Full mitigation might require a microcode update from the CPU
 vendor. When the necessary microcode is not available, the kernel will
@@ -711,18 +711,14 @@ For user space mitigation:
 	spectre_bhi=
 
 		[X86] Control mitigation of Branch History Injection
-		(BHI) vulnerability. Syscalls are hardened against BHI
-		regardless of this setting. This setting affects the deployment
+		(BHI) vulnerability.  This setting affects the deployment
 		of the HW BHI control and the SW BHB clearing sequence.
 
 		on
-			unconditionally enable.
+			(default) Enable the HW or SW mitigation as
+			needed.
 		off
-			unconditionally disable.
-		auto
-			enable if hardware mitigation
-			control(BHI_DIS_S) is available, otherwise
-			enable alternate mitigation in KVM.
+			Disable the mitigation.
 
 For spectre_v2_user see Documentation/admin-guide/kernel-parameters.txt
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7e9e655a715e..e61f0d038c6d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3093,6 +3093,7 @@
 					       reg_file_data_sampling=off [X86]
 					       retbleed=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
+					       spectre_bhi=off [X86]
 					       spectre_v2_user=off [X86]
 					       ssbd=force-off [ARM64]
 					       tsx_async_abort=off [X86]
@@ -5405,16 +5406,13 @@
 			See Documentation/admin-guide/laptops/sonypi.rst
 
 	spectre_bhi=	[X86] Control mitigation of Branch History Injection
-			(BHI) vulnerability. Syscalls are hardened against BHI
-			reglardless of this setting. This setting affects the
+			(BHI) vulnerability.  This setting affects the
 			deployment of the HW BHI control and the SW BHB
 			clearing sequence.
 
-			on   - unconditionally enable.
-			off  - unconditionally disable.
-			auto - (default) enable hardware mitigation
-			       (BHI_DIS_S) if available, otherwise enable
-			       alternate mitigation in KVM.
+			on   - (default) Enable the HW or SW mitigation
+			       as needed.
+			off  - Disable the mitigation.
 
 	spectre_v2=	[X86] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
diff --git a/Makefile b/Makefile
index bc31596bd6b3..30680c037e1d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 155
+SUBLEVEL = 156
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 639220dbff00..685e9b83d42b 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -38,8 +38,8 @@ usdhc1: mmc@5b010000 {
 		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b010000 0x10000>;
 		clocks = <&sdhc0_lpcg IMX_LPCG_CLK_4>,
-			 <&sdhc0_lpcg IMX_LPCG_CLK_0>,
-			 <&sdhc0_lpcg IMX_LPCG_CLK_5>;
+			 <&sdhc0_lpcg IMX_LPCG_CLK_5>,
+			 <&sdhc0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "per";
 		power-domains = <&pd IMX_SC_R_SDHC_0>;
 		status = "disabled";
@@ -49,8 +49,8 @@ usdhc2: mmc@5b020000 {
 		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b020000 0x10000>;
 		clocks = <&sdhc1_lpcg IMX_LPCG_CLK_4>,
-			 <&sdhc1_lpcg IMX_LPCG_CLK_0>,
-			 <&sdhc1_lpcg IMX_LPCG_CLK_5>;
+			 <&sdhc1_lpcg IMX_LPCG_CLK_5>,
+			 <&sdhc1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "per";
 		power-domains = <&pd IMX_SC_R_SDHC_1>;
 		fsl,tuning-start-tap = <20>;
@@ -62,8 +62,8 @@ usdhc3: mmc@5b030000 {
 		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0x5b030000 0x10000>;
 		clocks = <&sdhc2_lpcg IMX_LPCG_CLK_4>,
-			 <&sdhc2_lpcg IMX_LPCG_CLK_0>,
-			 <&sdhc2_lpcg IMX_LPCG_CLK_5>;
+			 <&sdhc2_lpcg IMX_LPCG_CLK_5>,
+			 <&sdhc2_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "ahb", "per";
 		power-domains = <&pd IMX_SC_R_SDHC_2>;
 		status = "disabled";
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 591b0a7abfd2..c29b024b907c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2505,31 +2505,16 @@ config MITIGATION_RFDS
 	  stored in floating point, vector and integer registers.
 	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
 
-choice
-	prompt "Clear branch history"
+config MITIGATION_SPECTRE_BHI
+	bool "Mitigate Spectre-BHB (Branch History Injection)"
 	depends on CPU_SUP_INTEL
-	default SPECTRE_BHI_ON
+	default y
 	help
 	  Enable BHI mitigations. BHI attacks are a form of Spectre V2 attacks
 	  where the branch history buffer is poisoned to speculatively steer
 	  indirect branches.
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
-config SPECTRE_BHI_ON
-	bool "on"
-	help
-	  Equivalent to setting spectre_bhi=on command line parameter.
-config SPECTRE_BHI_OFF
-	bool "off"
-	help
-	  Equivalent to setting spectre_bhi=off command line parameter.
-config SPECTRE_BHI_AUTO
-	bool "auto"
-	help
-	  Equivalent to setting spectre_bhi=auto command line parameter.
-
-endchoice
-
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 81d5e0a1f48c..e55fc25da2da 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1649,6 +1649,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	while (++i < cpuc->n_events) {
 		cpuc->event_list[i-1] = cpuc->event_list[i];
 		cpuc->event_constraint[i-1] = cpuc->event_constraint[i];
+		cpuc->assign[i-1] = cpuc->assign[i];
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 48067af94678..d2db8f4fa179 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -12,6 +12,7 @@
 #include <asm/mpspec.h>
 #include <asm/msr.h>
 #include <asm/hardirq.h>
+#include <asm/io.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -111,7 +112,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 
 static inline u32 native_apic_mem_read(u32 reg)
 {
-	return *((volatile u32 *)(APIC_BASE + reg));
+	return readl((void __iomem *)(APIC_BASE + reg));
 }
 
 extern void native_apic_wait_icr_idle(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 50fdd6ca3b78..b30b32b288dd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -60,6 +60,8 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_current);
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
+static u64 __ro_after_init x86_arch_cap_msr;
+
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
 void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
@@ -143,6 +145,8 @@ void __init cpu_select_mitigations(void)
 		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
 	}
 
+	x86_arch_cap_msr = x86_read_arch_cap_msr();
+
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
@@ -307,8 +311,6 @@ static const char * const taa_strings[] = {
 
 static void __init taa_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_TAA)) {
 		taa_mitigation = TAA_MITIGATION_OFF;
 		return;
@@ -347,9 +349,8 @@ static void __init taa_select_mitigation(void)
 	 * On MDS_NO=1 CPUs if ARCH_CAP_TSX_CTRL_MSR is not set, microcode
 	 * update is required.
 	 */
-	ia32_cap = x86_read_arch_cap_msr();
-	if ( (ia32_cap & ARCH_CAP_MDS_NO) &&
-	    !(ia32_cap & ARCH_CAP_TSX_CTRL_MSR))
+	if ( (x86_arch_cap_msr & ARCH_CAP_MDS_NO) &&
+	    !(x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR))
 		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
 
 	/*
@@ -407,8 +408,6 @@ static const char * const mmio_strings[] = {
 
 static void __init mmio_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
 	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
 	     cpu_mitigations_off()) {
@@ -419,8 +418,6 @@ static void __init mmio_select_mitigation(void)
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
-	ia32_cap = x86_read_arch_cap_msr();
-
 	/*
 	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
 	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
@@ -443,7 +440,7 @@ static void __init mmio_select_mitigation(void)
 	 * be propagated to uncore buffers, clearing the Fill buffers on idle
 	 * is required irrespective of SMT state.
 	 */
-	if (!(ia32_cap & ARCH_CAP_FBSDP_NO))
+	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
 	/*
@@ -453,10 +450,10 @@ static void __init mmio_select_mitigation(void)
 	 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
 	 * affected systems.
 	 */
-	if ((ia32_cap & ARCH_CAP_FB_CLEAR) ||
+	if ((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
 	    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
 	     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
-	     !(ia32_cap & ARCH_CAP_MDS_NO)))
+	     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)))
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 	else
 		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
@@ -514,7 +511,7 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
-	if (x86_read_arch_cap_msr() & ARCH_CAP_RFDS_CLEAR)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
@@ -658,8 +655,6 @@ void update_srbds_msr(void)
 
 static void __init srbds_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
 		return;
 
@@ -668,8 +663,7 @@ static void __init srbds_select_mitigation(void)
 	 * are only exposed to SRBDS when TSX is enabled or when CPU is affected
 	 * by Processor MMIO Stale Data vulnerability.
 	 */
-	ia32_cap = x86_read_arch_cap_msr();
-	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
+	if ((x86_arch_cap_msr & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
 	    !boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;
 	else if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
@@ -812,7 +806,7 @@ static void __init gds_select_mitigation(void)
 	/* Will verify below that mitigation _can_ be disabled */
 
 	/* No microcode */
-	if (!(x86_read_arch_cap_msr() & ARCH_CAP_GDS_CTRL)) {
+	if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)) {
 		if (gds_mitigation == GDS_MITIGATION_FORCE) {
 			/*
 			 * This only needs to be done on the boot CPU so do it
@@ -1521,20 +1515,25 @@ static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
 	return SPECTRE_V2_RETPOLINE;
 }
 
+static bool __ro_after_init rrsba_disabled;
+
 /* Disable in-kernel use of non-RSB RET predictors */
 static void __init spec_ctrl_disable_kernel_rrsba(void)
 {
-	u64 ia32_cap;
+	if (rrsba_disabled)
+		return;
 
-	if (!boot_cpu_has(X86_FEATURE_RRSBA_CTRL))
+	if (!(x86_arch_cap_msr & ARCH_CAP_RRSBA)) {
+		rrsba_disabled = true;
 		return;
+	}
 
-	ia32_cap = x86_read_arch_cap_msr();
+	if (!boot_cpu_has(X86_FEATURE_RRSBA_CTRL))
+		return;
 
-	if (ia32_cap & ARCH_CAP_RRSBA) {
-		x86_spec_ctrl_base |= SPEC_CTRL_RRSBA_DIS_S;
-		update_spec_ctrl(x86_spec_ctrl_base);
-	}
+	x86_spec_ctrl_base |= SPEC_CTRL_RRSBA_DIS_S;
+	update_spec_ctrl(x86_spec_ctrl_base);
+	rrsba_disabled = true;
 }
 
 static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_mitigation mode)
@@ -1603,13 +1602,10 @@ static bool __init spec_ctrl_bhi_dis(void)
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
 	BHI_MITIGATION_ON,
-	BHI_MITIGATION_AUTO,
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_SPECTRE_BHI_ON)  ? BHI_MITIGATION_ON  :
-	IS_ENABLED(CONFIG_SPECTRE_BHI_OFF) ? BHI_MITIGATION_OFF :
-					     BHI_MITIGATION_AUTO;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {
@@ -1620,8 +1616,6 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 		bhi_mitigation = BHI_MITIGATION_OFF;
 	else if (!strcmp(str, "on"))
 		bhi_mitigation = BHI_MITIGATION_ON;
-	else if (!strcmp(str, "auto"))
-		bhi_mitigation = BHI_MITIGATION_AUTO;
 	else
 		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
 
@@ -1635,9 +1629,11 @@ static void __init bhi_select_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
-	    !(x86_read_arch_cap_msr() & ARCH_CAP_RRSBA))
-		return;
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		spec_ctrl_disable_kernel_rrsba();
+		if (rrsba_disabled)
+			return;
+	}
 
 	if (spec_ctrl_bhi_dis())
 		return;
@@ -1649,9 +1645,6 @@ static void __init bhi_select_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
 
-	if (bhi_mitigation == BHI_MITIGATION_AUTO)
-		return;
-
 	/* Mitigate syscalls when the mitigation is forced =on */
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
@@ -1884,8 +1877,6 @@ static void update_indir_branch_cond(void)
 /* Update the static key controlling the MDS CPU buffer clear in idle */
 static void update_mds_branch_idle(void)
 {
-	u64 ia32_cap = x86_read_arch_cap_msr();
-
 	/*
 	 * Enable the idle clearing if SMT is active on CPUs which are
 	 * affected only by MSBDS and not any other MDS variant.
@@ -1900,7 +1891,7 @@ static void update_mds_branch_idle(void)
 	if (sched_smt_active()) {
 		static_branch_enable(&mds_idle_clear);
 	} else if (mmio_mitigation == MMIO_MITIGATION_OFF ||
-		   (ia32_cap & ARCH_CAP_FBSDP_NO)) {
+		   (x86_arch_cap_msr & ARCH_CAP_FBSDP_NO)) {
 		static_branch_disable(&mds_idle_clear);
 	}
 }
@@ -2788,7 +2779,7 @@ static char *pbrsb_eibrs_state(void)
 	}
 }
 
-static const char * const spectre_bhi_state(void)
+static const char *spectre_bhi_state(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_BHI))
 		return "; BHI: Not affected";
@@ -2796,13 +2787,12 @@ static const char * const spectre_bhi_state(void)
 		return "; BHI: BHI_DIS_S";
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !(x86_read_arch_cap_msr() & ARCH_CAP_RRSBA))
+	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) && rrsba_disabled)
 		return "; BHI: Retpoline";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
-		return "; BHI: Syscall hardening, KVM: SW loop";
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
+		return "; BHI: Vulnerable, KVM: SW loop";
 
-	return "; BHI: Vulnerable (Syscall hardening enabled)";
+	return "; BHI: Vulnerable";
 }
 
 static ssize_t spectre_v2_show_state(char *buf)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 664562389665..809e12f130d8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1198,25 +1198,25 @@ static bool __init cpu_matches(const struct x86_cpu_id *table, unsigned long whi
 
 u64 x86_read_arch_cap_msr(void)
 {
-	u64 ia32_cap = 0;
+	u64 x86_arch_cap_msr = 0;
 
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, x86_arch_cap_msr);
 
-	return ia32_cap;
+	return x86_arch_cap_msr;
 }
 
-static bool arch_cap_mmio_immune(u64 ia32_cap)
+static bool arch_cap_mmio_immune(u64 x86_arch_cap_msr)
 {
-	return (ia32_cap & ARCH_CAP_FBSDP_NO &&
-		ia32_cap & ARCH_CAP_PSDP_NO &&
-		ia32_cap & ARCH_CAP_SBDR_SSDP_NO);
+	return (x86_arch_cap_msr & ARCH_CAP_FBSDP_NO &&
+		x86_arch_cap_msr & ARCH_CAP_PSDP_NO &&
+		x86_arch_cap_msr & ARCH_CAP_SBDR_SSDP_NO);
 }
 
-static bool __init vulnerable_to_rfds(u64 ia32_cap)
+static bool __init vulnerable_to_rfds(u64 x86_arch_cap_msr)
 {
 	/* The "immunity" bit trumps everything else: */
-	if (ia32_cap & ARCH_CAP_RFDS_NO)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_NO)
 		return false;
 
 	/*
@@ -1224,7 +1224,7 @@ static bool __init vulnerable_to_rfds(u64 ia32_cap)
 	 * indicate that mitigation is needed because guest is running on a
 	 * vulnerable hardware or may migrate to such hardware:
 	 */
-	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		return true;
 
 	/* Only consult the blacklist when there is no enumeration: */
@@ -1233,11 +1233,11 @@ static bool __init vulnerable_to_rfds(u64 ia32_cap)
 
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
-	u64 ia32_cap = x86_read_arch_cap_msr();
+	u64 x86_arch_cap_msr = x86_read_arch_cap_msr();
 
 	/* Set ITLB_MULTIHIT bug if cpu is not in the whitelist and not mitigated */
 	if (!cpu_matches(cpu_vuln_whitelist, NO_ITLB_MULTIHIT) &&
-	    !(ia32_cap & ARCH_CAP_PSCHANGE_MC_NO))
+	    !(x86_arch_cap_msr & ARCH_CAP_PSCHANGE_MC_NO))
 		setup_force_cpu_bug(X86_BUG_ITLB_MULTIHIT);
 
 	if (cpu_matches(cpu_vuln_whitelist, NO_SPECULATION))
@@ -1249,7 +1249,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_SSB) &&
-	    !(ia32_cap & ARCH_CAP_SSB_NO) &&
+	    !(x86_arch_cap_msr & ARCH_CAP_SSB_NO) &&
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
@@ -1257,15 +1257,15 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * AMD's AutoIBRS is equivalent to Intel's eIBRS - use the Intel feature
 	 * flag and protect from vendor-specific bugs via the whitelist.
 	 */
-	if ((ia32_cap & ARCH_CAP_IBRS_ALL) || cpu_has(c, X86_FEATURE_AUTOIBRS)) {
+	if ((x86_arch_cap_msr & ARCH_CAP_IBRS_ALL) || cpu_has(c, X86_FEATURE_AUTOIBRS)) {
 		setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
 		if (!cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
-		    !(ia32_cap & ARCH_CAP_PBRSB_NO))
+		    !(x86_arch_cap_msr & ARCH_CAP_PBRSB_NO))
 			setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
 	}
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_MDS) &&
-	    !(ia32_cap & ARCH_CAP_MDS_NO)) {
+	    !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)) {
 		setup_force_cpu_bug(X86_BUG_MDS);
 		if (cpu_matches(cpu_vuln_whitelist, MSBDS_ONLY))
 			setup_force_cpu_bug(X86_BUG_MSBDS_ONLY);
@@ -1284,9 +1284,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * TSX_CTRL check alone is not sufficient for cases when the microcode
 	 * update is not present or running as guest that don't get TSX_CTRL.
 	 */
-	if (!(ia32_cap & ARCH_CAP_TAA_NO) &&
+	if (!(x86_arch_cap_msr & ARCH_CAP_TAA_NO) &&
 	    (cpu_has(c, X86_FEATURE_RTM) ||
-	     (ia32_cap & ARCH_CAP_TSX_CTRL_MSR)))
+	     (x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR)))
 		setup_force_cpu_bug(X86_BUG_TAA);
 
 	/*
@@ -1312,7 +1312,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * Set X86_BUG_MMIO_UNKNOWN for CPUs that are neither in the blacklist,
 	 * nor in the whitelist and also don't enumerate MSR ARCH_CAP MMIO bits.
 	 */
-	if (!arch_cap_mmio_immune(ia32_cap)) {
+	if (!arch_cap_mmio_immune(x86_arch_cap_msr)) {
 		if (cpu_matches(cpu_vuln_blacklist, MMIO))
 			setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
 		else if (!cpu_matches(cpu_vuln_whitelist, NO_MMIO))
@@ -1320,7 +1320,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	}
 
 	if (!cpu_has(c, X86_FEATURE_BTC_NO)) {
-		if (cpu_matches(cpu_vuln_blacklist, RETBLEED) || (ia32_cap & ARCH_CAP_RSBA))
+		if (cpu_matches(cpu_vuln_blacklist, RETBLEED) || (x86_arch_cap_msr & ARCH_CAP_RSBA))
 			setup_force_cpu_bug(X86_BUG_RETBLEED);
 	}
 
@@ -1333,7 +1333,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * disabling AVX2. The only way to do this in HW is to clear XCR0[2],
 	 * which means that AVX will be disabled.
 	 */
-	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(ia32_cap & ARCH_CAP_GDS_NO) &&
+	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(x86_arch_cap_msr & ARCH_CAP_GDS_NO) &&
 	    boot_cpu_has(X86_FEATURE_AVX))
 		setup_force_cpu_bug(X86_BUG_GDS);
 
@@ -1342,11 +1342,11 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 			setup_force_cpu_bug(X86_BUG_SRSO);
 	}
 
-	if (vulnerable_to_rfds(ia32_cap))
+	if (vulnerable_to_rfds(x86_arch_cap_msr))
 		setup_force_cpu_bug(X86_BUG_RFDS);
 
 	/* When virtualized, eIBRS could be hidden, assume vulnerable */
-	if (!(ia32_cap & ARCH_CAP_BHI_NO) &&
+	if (!(x86_arch_cap_msr & ARCH_CAP_BHI_NO) &&
 	    !cpu_matches(cpu_vuln_whitelist, NO_BHI) &&
 	    (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) ||
 	     boot_cpu_has(X86_FEATURE_HYPERVISOR)))
@@ -1356,7 +1356,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 		return;
 
 	/* Rogue Data Cache Load? No! */
-	if (ia32_cap & ARCH_CAP_RDCL_NO)
+	if (x86_arch_cap_msr & ARCH_CAP_RDCL_NO)
 		return;
 
 	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 447ea279e691..957b6dd0751a 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -775,6 +775,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 	unsigned int total_modes_count = 0;
 	struct drm_client_offset *offsets;
 	unsigned int connector_count = 0;
+	/* points to modes protected by mode_config.mutex */
 	struct drm_display_mode **modes;
 	struct drm_crtc **crtcs;
 	int i, ret = 0;
@@ -843,7 +844,6 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 		drm_client_pick_crtcs(client, connectors, connector_count,
 				      crtcs, modes, 0, width, height);
 	}
-	mutex_unlock(&dev->mode_config.mutex);
 
 	drm_client_modeset_release(client);
 
@@ -873,6 +873,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 			modeset->y = offset->y;
 		}
 	}
+	mutex_unlock(&dev->mode_config.mutex);
 
 	mutex_unlock(&client->modeset_mutex);
 out:
diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index 745ffa7572e8..75defafb7901 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2000,7 +2000,7 @@ intel_set_cdclk_pre_plane_update(struct intel_atomic_state *state)
 				 &new_cdclk_state->actual))
 		return;
 
-	if (pipe == INVALID_PIPE ||
+	if (new_cdclk_state->disable_pipes ||
 	    old_cdclk_state->actual.cdclk <= new_cdclk_state->actual.cdclk) {
 		drm_WARN_ON(&dev_priv->drm, !new_cdclk_state->base.changed);
 
@@ -2029,7 +2029,7 @@ intel_set_cdclk_post_plane_update(struct intel_atomic_state *state)
 				 &new_cdclk_state->actual))
 		return;
 
-	if (pipe != INVALID_PIPE &&
+	if (!new_cdclk_state->disable_pipes &&
 	    old_cdclk_state->actual.cdclk > new_cdclk_state->actual.cdclk) {
 		drm_WARN_ON(&dev_priv->drm, !new_cdclk_state->base.changed);
 
@@ -2456,6 +2456,7 @@ static struct intel_global_state *intel_cdclk_duplicate_state(struct intel_globa
 		return NULL;
 
 	cdclk_state->pipe = INVALID_PIPE;
+	cdclk_state->disable_pipes = false;
 
 	return &cdclk_state->base;
 }
@@ -2575,6 +2576,8 @@ int intel_modeset_calc_cdclk(struct intel_atomic_state *state)
 		if (ret)
 			return ret;
 
+		new_cdclk_state->disable_pipes = true;
+
 		drm_dbg_kms(&dev_priv->drm,
 			    "Modeset required for cdclk change\n");
 	}
diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.h b/drivers/gpu/drm/i915/display/intel_cdclk.h
index b34eb00fb327..42376b5b3f53 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.h
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.h
@@ -52,6 +52,9 @@ struct intel_cdclk_state {
 
 	/* bitmask of active pipes */
 	u8 active_pipes;
+
+	/* update cdclk with pipes disabled */
+	bool disable_pipes;
 };
 
 int intel_crtc_compute_min_cdclk(const struct intel_crtc_state *crtc_state);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
index 4bf486b57101..cb05f7f48a98 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c
@@ -66,11 +66,16 @@ of_init(struct nvkm_bios *bios, const char *name)
 	return ERR_PTR(-EINVAL);
 }
 
+static void of_fini(void *p)
+{
+	kfree(p);
+}
+
 const struct nvbios_source
 nvbios_of = {
 	.name = "OpenFirmware",
 	.init = of_init,
-	.fini = (void(*)(void *))kfree,
+	.fini = of_fini,
 	.read = of_read,
 	.size = of_size,
 	.rw = false,
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index b19f2f00b215..d4f26075383d 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -58,16 +58,56 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 			   signed long timeout)
 {
 	struct qxl_device *qdev;
+	struct qxl_release *release;
+	int count = 0, sc = 0;
+	bool have_drawable_releases;
 	unsigned long cur, end = jiffies + timeout;
 
 	qdev = container_of(fence->lock, struct qxl_device, release_lock);
+	release = container_of(fence, struct qxl_release, base);
+	have_drawable_releases = release->type == QXL_RELEASE_DRAWABLE;
 
-	if (!wait_event_timeout(qdev->release_event,
-				(dma_fence_is_signaled(fence) ||
-				 (qxl_io_notify_oom(qdev), 0)),
-				timeout))
-		return 0;
+retry:
+	sc++;
+
+	if (dma_fence_is_signaled(fence))
+		goto signaled;
+
+	qxl_io_notify_oom(qdev);
+
+	for (count = 0; count < 11; count++) {
+		if (!qxl_queue_garbage_collect(qdev, true))
+			break;
+
+		if (dma_fence_is_signaled(fence))
+			goto signaled;
+	}
+
+	if (dma_fence_is_signaled(fence))
+		goto signaled;
+
+	if (have_drawable_releases || sc < 4) {
+		if (sc > 2)
+			/* back off */
+			usleep_range(500, 1000);
+
+		if (time_after(jiffies, end))
+			return 0;
+
+		if (have_drawable_releases && sc > 300) {
+			DMA_FENCE_WARN(fence,
+				       "failed to wait on release %llu after spincount %d\n",
+				       fence->context & ~0xf0000000, sc);
+			goto signaled;
+		}
+		goto retry;
+	}
+	/*
+	 * yeah, original sync_obj_wait gave up after 3 spins when
+	 * have_drawable_releases is not set.
+	 */
 
+signaled:
 	cur = jiffies;
 	if (time_after(cur, end))
 		return 0;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 3a9468b1d2c3..a96c9a15c9fe 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -88,7 +88,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	struct page *pages;
 	int irq, ret;
 
-	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
+	pages = alloc_pages_node(iommu->node, GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
 	if (!pages) {
 		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
 			iommu->name);
diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 99ede1417d72..01ff1329e01c 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1117,20 +1117,6 @@ void cec_received_msg_ts(struct cec_adapter *adap,
 	if (valid_la && min_len) {
 		/* These messages have special length requirements */
 		switch (cmd) {
-		case CEC_MSG_TIMER_STATUS:
-			if (msg->msg[2] & 0x10) {
-				switch (msg->msg[2] & 0xf) {
-				case CEC_OP_PROG_INFO_NOT_ENOUGH_SPACE:
-				case CEC_OP_PROG_INFO_MIGHT_NOT_BE_ENOUGH_SPACE:
-					if (msg->len < 5)
-						valid_la = false;
-					break;
-				}
-			} else if ((msg->msg[2] & 0xf) == CEC_OP_PROG_ERROR_DUPLICATE) {
-				if (msg->len < 5)
-					valid_la = false;
-			}
-			break;
 		case CEC_MSG_RECORD_ON:
 			switch (msg->msg[2]) {
 			case CEC_OP_RECORD_SRC_OWN:
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 14c47e614d33..f291d1e70f80 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -994,20 +994,173 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	mutex_unlock(&priv->reg_mutex);
 }
 
-/* On page 205, section "8.6.3 Frame filtering" of the active standard, IEEE Std
- * 802.1Q™-2022, it is stated that frames with 01:80:C2:00:00:00-0F as MAC DA
- * must only be propagated to C-VLAN and MAC Bridge components. That means
- * VLAN-aware and VLAN-unaware bridges. On the switch designs with CPU ports,
- * these frames are supposed to be processed by the CPU (software). So we make
- * the switch only forward them to the CPU port. And if received from a CPU
- * port, forward to a single port. The software is responsible of making the
- * switch conform to the latter by setting a single port as destination port on
- * the special tag.
+/* In Clause 5 of IEEE Std 802-2014, two sublayers of the data link layer (DLL)
+ * of the Open Systems Interconnection basic reference model (OSI/RM) are
+ * described; the medium access control (MAC) and logical link control (LLC)
+ * sublayers. The MAC sublayer is the one facing the physical layer.
  *
- * This switch intellectual property cannot conform to this part of the standard
- * fully. Whilst the REV_UN frame tag covers the remaining :04-0D and :0F MAC
- * DAs, it also includes :22-FF which the scope of propagation is not supposed
- * to be restricted for these MAC DAs.
+ * In 8.2 of IEEE Std 802.1Q-2022, the Bridge architecture is described. A
+ * Bridge component comprises a MAC Relay Entity for interconnecting the Ports
+ * of the Bridge, at least two Ports, and higher layer entities with at least a
+ * Spanning Tree Protocol Entity included.
+ *
+ * Each Bridge Port also functions as an end station and shall provide the MAC
+ * Service to an LLC Entity. Each instance of the MAC Service is provided to a
+ * distinct LLC Entity that supports protocol identification, multiplexing, and
+ * demultiplexing, for protocol data unit (PDU) transmission and reception by
+ * one or more higher layer entities.
+ *
+ * It is described in 8.13.9 of IEEE Std 802.1Q-2022 that in a Bridge, the LLC
+ * Entity associated with each Bridge Port is modeled as being directly
+ * connected to the attached Local Area Network (LAN).
+ *
+ * On the switch with CPU port architecture, CPU port functions as Management
+ * Port, and the Management Port functionality is provided by software which
+ * functions as an end station. Software is connected to an IEEE 802 LAN that is
+ * wholly contained within the system that incorporates the Bridge. Software
+ * provides access to the LLC Entity associated with each Bridge Port by the
+ * value of the source port field on the special tag on the frame received by
+ * software.
+ *
+ * We call frames that carry control information to determine the active
+ * topology and current extent of each Virtual Local Area Network (VLAN), i.e.,
+ * spanning tree or Shortest Path Bridging (SPB) and Multiple VLAN Registration
+ * Protocol Data Units (MVRPDUs), and frames from other link constrained
+ * protocols, such as Extensible Authentication Protocol over LAN (EAPOL) and
+ * Link Layer Discovery Protocol (LLDP), link-local frames. They are not
+ * forwarded by a Bridge. Permanently configured entries in the filtering
+ * database (FDB) ensure that such frames are discarded by the Forwarding
+ * Process. In 8.6.3 of IEEE Std 802.1Q-2022, this is described in detail:
+ *
+ * Each of the reserved MAC addresses specified in Table 8-1
+ * (01-80-C2-00-00-[00,01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F]) shall be
+ * permanently configured in the FDB in C-VLAN components and ERs.
+ *
+ * Each of the reserved MAC addresses specified in Table 8-2
+ * (01-80-C2-00-00-[01,02,03,04,05,06,07,08,09,0A,0E]) shall be permanently
+ * configured in the FDB in S-VLAN components.
+ *
+ * Each of the reserved MAC addresses specified in Table 8-3
+ * (01-80-C2-00-00-[01,02,04,0E]) shall be permanently configured in the FDB in
+ * TPMR components.
+ *
+ * The FDB entries for reserved MAC addresses shall specify filtering for all
+ * Bridge Ports and all VIDs. Management shall not provide the capability to
+ * modify or remove entries for reserved MAC addresses.
+ *
+ * The addresses in Table 8-1, Table 8-2, and Table 8-3 determine the scope of
+ * propagation of PDUs within a Bridged Network, as follows:
+ *
+ *   The Nearest Bridge group address (01-80-C2-00-00-0E) is an address that no
+ *   conformant Two-Port MAC Relay (TPMR) component, Service VLAN (S-VLAN)
+ *   component, Customer VLAN (C-VLAN) component, or MAC Bridge can forward.
+ *   PDUs transmitted using this destination address, or any other addresses
+ *   that appear in Table 8-1, Table 8-2, and Table 8-3
+ *   (01-80-C2-00-00-[00,01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,0F]), can
+ *   therefore travel no further than those stations that can be reached via a
+ *   single individual LAN from the originating station.
+ *
+ *   The Nearest non-TPMR Bridge group address (01-80-C2-00-00-03), is an
+ *   address that no conformant S-VLAN component, C-VLAN component, or MAC
+ *   Bridge can forward; however, this address is relayed by a TPMR component.
+ *   PDUs using this destination address, or any of the other addresses that
+ *   appear in both Table 8-1 and Table 8-2 but not in Table 8-3
+ *   (01-80-C2-00-00-[00,03,05,06,07,08,09,0A,0B,0C,0D,0F]), will be relayed by
+ *   any TPMRs but will propagate no further than the nearest S-VLAN component,
+ *   C-VLAN component, or MAC Bridge.
+ *
+ *   The Nearest Customer Bridge group address (01-80-C2-00-00-00) is an address
+ *   that no conformant C-VLAN component, MAC Bridge can forward; however, it is
+ *   relayed by TPMR components and S-VLAN components. PDUs using this
+ *   destination address, or any of the other addresses that appear in Table 8-1
+ *   but not in either Table 8-2 or Table 8-3 (01-80-C2-00-00-[00,0B,0C,0D,0F]),
+ *   will be relayed by TPMR components and S-VLAN components but will propagate
+ *   no further than the nearest C-VLAN component or MAC Bridge.
+ *
+ * Because the LLC Entity associated with each Bridge Port is provided via CPU
+ * port, we must not filter these frames but forward them to CPU port.
+ *
+ * In a Bridge, the transmission Port is majorly decided by ingress and egress
+ * rules, FDB, and spanning tree Port State functions of the Forwarding Process.
+ * For link-local frames, only CPU port should be designated as destination port
+ * in the FDB, and the other functions of the Forwarding Process must not
+ * interfere with the decision of the transmission Port. We call this process
+ * trapping frames to CPU port.
+ *
+ * Therefore, on the switch with CPU port architecture, link-local frames must
+ * be trapped to CPU port, and certain link-local frames received by a Port of a
+ * Bridge comprising a TPMR component or an S-VLAN component must be excluded
+ * from it.
+ *
+ * A Bridge of the switch with CPU port architecture cannot comprise a Two-Port
+ * MAC Relay (TPMR) component as a TPMR component supports only a subset of the
+ * functionality of a MAC Bridge. A Bridge comprising two Ports (Management Port
+ * doesn't count) of this architecture will either function as a standard MAC
+ * Bridge or a standard VLAN Bridge.
+ *
+ * Therefore, a Bridge of this architecture can only comprise S-VLAN components,
+ * C-VLAN components, or MAC Bridge components. Since there's no TPMR component,
+ * we don't need to relay PDUs using the destination addresses specified on the
+ * Nearest non-TPMR section, and the proportion of the Nearest Customer Bridge
+ * section where they must be relayed by TPMR components.
+ *
+ * One option to trap link-local frames to CPU port is to add static FDB entries
+ * with CPU port designated as destination port. However, because that
+ * Independent VLAN Learning (IVL) is being used on every VID, each entry only
+ * applies to a single VLAN Identifier (VID). For a Bridge comprising a MAC
+ * Bridge component or a C-VLAN component, there would have to be 16 times 4096
+ * entries. This switch intellectual property can only hold a maximum of 2048
+ * entries. Using this option, there also isn't a mechanism to prevent
+ * link-local frames from being discarded when the spanning tree Port State of
+ * the reception Port is discarding.
+ *
+ * The remaining option is to utilise the BPC, RGAC1, RGAC2, RGAC3, and RGAC4
+ * registers. Whilst this applies to every VID, it doesn't contain all of the
+ * reserved MAC addresses without affecting the remaining Standard Group MAC
+ * Addresses. The REV_UN frame tag utilised using the RGAC4 register covers the
+ * remaining 01-80-C2-00-00-[04,05,06,07,08,09,0A,0B,0C,0D,0F] destination
+ * addresses. It also includes the 01-80-C2-00-00-22 to 01-80-C2-00-00-FF
+ * destination addresses which may be relayed by MAC Bridges or VLAN Bridges.
+ * The latter option provides better but not complete conformance.
+ *
+ * This switch intellectual property also does not provide a mechanism to trap
+ * link-local frames with specific destination addresses to CPU port by Bridge,
+ * to conform to the filtering rules for the distinct Bridge components.
+ *
+ * Therefore, regardless of the type of the Bridge component, link-local frames
+ * with these destination addresses will be trapped to CPU port:
+ *
+ * 01-80-C2-00-00-[00,01,02,03,0E]
+ *
+ * In a Bridge comprising a MAC Bridge component or a C-VLAN component:
+ *
+ *   Link-local frames with these destination addresses won't be trapped to CPU
+ *   port which won't conform to IEEE Std 802.1Q-2022:
+ *
+ *   01-80-C2-00-00-[04,05,06,07,08,09,0A,0B,0C,0D,0F]
+ *
+ * In a Bridge comprising an S-VLAN component:
+ *
+ *   Link-local frames with these destination addresses will be trapped to CPU
+ *   port which won't conform to IEEE Std 802.1Q-2022:
+ *
+ *   01-80-C2-00-00-00
+ *
+ *   Link-local frames with these destination addresses won't be trapped to CPU
+ *   port which won't conform to IEEE Std 802.1Q-2022:
+ *
+ *   01-80-C2-00-00-[04,05,06,07,08,09,0A]
+ *
+ * To trap link-local frames to CPU port as conformant as this switch
+ * intellectual property can allow, link-local frames are made to be regarded as
+ * Bridge Protocol Data Units (BPDUs). This is because this switch intellectual
+ * property only lets the frames regarded as BPDUs bypass the spanning tree Port
+ * State function of the Forwarding Process.
+ *
+ * The only remaining interference is the ingress rules. When the reception Port
+ * has no PVID assigned on software, VLAN-untagged frames won't be allowed in.
+ * There doesn't seem to be a mechanism on the switch intellectual property to
+ * have link-local frames bypass this function of the Forwarding Process.
  */
 static void
 mt753x_trap_frames(struct mt7530_priv *priv)
@@ -1015,35 +1168,43 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 	/* Trap 802.1X PAE frames and BPDUs to the CPU port(s) and egress them
 	 * VLAN-untagged.
 	 */
-	mt7530_rmw(priv, MT753X_BPC, MT753X_PAE_EG_TAG_MASK |
-		   MT753X_PAE_PORT_FW_MASK | MT753X_BPDU_EG_TAG_MASK |
-		   MT753X_BPDU_PORT_FW_MASK,
-		   MT753X_PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY) |
-		   MT753X_BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_BPDU_CPU_ONLY);
+	mt7530_rmw(priv, MT753X_BPC,
+		   MT753X_PAE_BPDU_FR | MT753X_PAE_EG_TAG_MASK |
+			   MT753X_PAE_PORT_FW_MASK | MT753X_BPDU_EG_TAG_MASK |
+			   MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_PAE_BPDU_FR |
+			   MT753X_PAE_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+			   MT753X_BPDU_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_BPDU_CPU_ONLY);
 
 	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and egress
 	 * them VLAN-untagged.
 	 */
-	mt7530_rmw(priv, MT753X_RGAC1, MT753X_R02_EG_TAG_MASK |
-		   MT753X_R02_PORT_FW_MASK | MT753X_R01_EG_TAG_MASK |
-		   MT753X_R01_PORT_FW_MASK,
-		   MT753X_R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_R02_PORT_FW(MT753X_BPDU_CPU_ONLY) |
-		   MT753X_R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_BPDU_CPU_ONLY);
+	mt7530_rmw(priv, MT753X_RGAC1,
+		   MT753X_R02_BPDU_FR | MT753X_R02_EG_TAG_MASK |
+			   MT753X_R02_PORT_FW_MASK | MT753X_R01_BPDU_FR |
+			   MT753X_R01_EG_TAG_MASK | MT753X_R01_PORT_FW_MASK,
+		   MT753X_R02_BPDU_FR |
+			   MT753X_R02_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_R02_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+			   MT753X_R01_BPDU_FR |
+			   MT753X_R01_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_BPDU_CPU_ONLY);
 
 	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and egress
 	 * them VLAN-untagged.
 	 */
-	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_EG_TAG_MASK |
-		   MT753X_R0E_PORT_FW_MASK | MT753X_R03_EG_TAG_MASK |
-		   MT753X_R03_PORT_FW_MASK,
-		   MT753X_R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY) |
-		   MT753X_R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
-		   MT753X_BPDU_CPU_ONLY);
+	mt7530_rmw(priv, MT753X_RGAC2,
+		   MT753X_R0E_BPDU_FR | MT753X_R0E_EG_TAG_MASK |
+			   MT753X_R0E_PORT_FW_MASK | MT753X_R03_BPDU_FR |
+			   MT753X_R03_EG_TAG_MASK | MT753X_R03_PORT_FW_MASK,
+		   MT753X_R0E_BPDU_FR |
+			   MT753X_R0E_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY) |
+			   MT753X_R03_BPDU_FR |
+			   MT753X_R03_EG_TAG(MT7530_VLAN_EG_UNTAGGED) |
+			   MT753X_BPDU_CPU_ONLY);
 }
 
 static int
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 03598f9ae288..299a26ad5809 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -64,6 +64,7 @@ enum mt753x_id {
 
 /* Registers for BPDU and PAE frame control*/
 #define MT753X_BPC			0x24
+#define  MT753X_PAE_BPDU_FR		BIT(25)
 #define  MT753X_PAE_EG_TAG_MASK		GENMASK(24, 22)
 #define  MT753X_PAE_EG_TAG(x)		FIELD_PREP(MT753X_PAE_EG_TAG_MASK, x)
 #define  MT753X_PAE_PORT_FW_MASK	GENMASK(18, 16)
@@ -74,20 +75,24 @@ enum mt753x_id {
 
 /* Register for :01 and :02 MAC DA frame control */
 #define MT753X_RGAC1			0x28
+#define  MT753X_R02_BPDU_FR		BIT(25)
 #define  MT753X_R02_EG_TAG_MASK		GENMASK(24, 22)
 #define  MT753X_R02_EG_TAG(x)		FIELD_PREP(MT753X_R02_EG_TAG_MASK, x)
 #define  MT753X_R02_PORT_FW_MASK	GENMASK(18, 16)
 #define  MT753X_R02_PORT_FW(x)		FIELD_PREP(MT753X_R02_PORT_FW_MASK, x)
+#define  MT753X_R01_BPDU_FR		BIT(9)
 #define  MT753X_R01_EG_TAG_MASK		GENMASK(8, 6)
 #define  MT753X_R01_EG_TAG(x)		FIELD_PREP(MT753X_R01_EG_TAG_MASK, x)
 #define  MT753X_R01_PORT_FW_MASK	GENMASK(2, 0)
 
 /* Register for :03 and :0E MAC DA frame control */
 #define MT753X_RGAC2			0x2c
+#define  MT753X_R0E_BPDU_FR		BIT(25)
 #define  MT753X_R0E_EG_TAG_MASK		GENMASK(24, 22)
 #define  MT753X_R0E_EG_TAG(x)		FIELD_PREP(MT753X_R0E_EG_TAG_MASK, x)
 #define  MT753X_R0E_PORT_FW_MASK	GENMASK(18, 16)
 #define  MT753X_R0E_PORT_FW(x)		FIELD_PREP(MT753X_R0E_PORT_FW_MASK, x)
+#define  MT753X_R03_BPDU_FR		BIT(9)
 #define  MT753X_R03_EG_TAG_MASK		GENMASK(8, 6)
 #define  MT753X_R03_EG_TAG(x)		FIELD_PREP(MT753X_R03_EG_TAG_MASK, x)
 #define  MT753X_R03_PORT_FW_MASK	GENMASK(2, 0)
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 7979b1019242..e37c82eb6232 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -362,7 +362,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 			ENA_COM_BOUNCE_BUFFER_CNTRL_CNT;
 		io_sq->bounce_buf_ctrl.next_to_use = 0;
 
-		size = io_sq->bounce_buf_ctrl.buffer_size *
+		size = (size_t)io_sq->bounce_buf_ctrl.buffer_size *
 			io_sq->bounce_buf_ctrl.buffers_num;
 
 		dev_node = dev_to_node(ena_dev->dmadev);
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 43c099141e21..3ea449be7bdc 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1205,8 +1205,11 @@ static void ena_unmap_tx_buff(struct ena_ring *tx_ring,
 static void ena_free_tx_bufs(struct ena_ring *tx_ring)
 {
 	bool print_once = true;
+	bool is_xdp_ring;
 	u32 i;
 
+	is_xdp_ring = ENA_IS_XDP_INDEX(tx_ring->adapter, tx_ring->qid);
+
 	for (i = 0; i < tx_ring->ring_size; i++) {
 		struct ena_tx_buffer *tx_info = &tx_ring->tx_buffer_info[i];
 
@@ -1226,10 +1229,15 @@ static void ena_free_tx_bufs(struct ena_ring *tx_ring)
 
 		ena_unmap_tx_buff(tx_ring, tx_info);
 
-		dev_kfree_skb_any(tx_info->skb);
+		if (is_xdp_ring)
+			xdp_return_frame(tx_info->xdpf);
+		else
+			dev_kfree_skb_any(tx_info->skb);
 	}
-	netdev_tx_reset_queue(netdev_get_tx_queue(tx_ring->netdev,
-						  tx_ring->qid));
+
+	if (!is_xdp_ring)
+		netdev_tx_reset_queue(netdev_get_tx_queue(tx_ring->netdev,
+							  tx_ring->qid));
 }
 
 static void ena_free_all_tx_bufs(struct ena_adapter *adapter)
@@ -3815,10 +3823,11 @@ static void check_for_missing_completions(struct ena_adapter *adapter)
 {
 	struct ena_ring *tx_ring;
 	struct ena_ring *rx_ring;
-	int i, budget, rc;
+	int qid, budget, rc;
 	int io_queue_count;
 
 	io_queue_count = adapter->xdp_num_queues + adapter->num_io_queues;
+
 	/* Make sure the driver doesn't turn the device in other process */
 	smp_rmb();
 
@@ -3831,27 +3840,29 @@ static void check_for_missing_completions(struct ena_adapter *adapter)
 	if (adapter->missing_tx_completion_to == ENA_HW_HINTS_NO_TIMEOUT)
 		return;
 
-	budget = ENA_MONITORED_TX_QUEUES;
+	budget = min_t(u32, io_queue_count, ENA_MONITORED_TX_QUEUES);
 
-	for (i = adapter->last_monitored_tx_qid; i < io_queue_count; i++) {
-		tx_ring = &adapter->tx_ring[i];
-		rx_ring = &adapter->rx_ring[i];
+	qid = adapter->last_monitored_tx_qid;
+
+	while (budget) {
+		qid = (qid + 1) % io_queue_count;
+
+		tx_ring = &adapter->tx_ring[qid];
+		rx_ring = &adapter->rx_ring[qid];
 
 		rc = check_missing_comp_in_tx_queue(adapter, tx_ring);
 		if (unlikely(rc))
 			return;
 
-		rc =  !ENA_IS_XDP_INDEX(adapter, i) ?
+		rc =  !ENA_IS_XDP_INDEX(adapter, qid) ?
 			check_for_rx_interrupt_queue(adapter, rx_ring) : 0;
 		if (unlikely(rc))
 			return;
 
 		budget--;
-		if (!budget)
-			break;
 	}
 
-	adapter->last_monitored_tx_qid = i % io_queue_count;
+	adapter->last_monitored_tx_qid = qid;
 }
 
 /* trigger napi schedule after 2 consecutive detections */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index bda93e550b08..34a9a9164f3c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4184,18 +4184,18 @@ static int rvu_nix_block_init(struct rvu *rvu, struct nix_hw *nix_hw)
 		 */
 		rvu_write64(rvu, blkaddr, NIX_AF_CFG,
 			    rvu_read64(rvu, blkaddr, NIX_AF_CFG) | 0x40ULL);
+	}
 
-		/* Set chan/link to backpressure TL3 instead of TL2 */
-		rvu_write64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL, 0x01);
+	/* Set chan/link to backpressure TL3 instead of TL2 */
+	rvu_write64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL, 0x01);
 
-		/* Disable SQ manager's sticky mode operation (set TM6 = 0)
-		 * This sticky mode is known to cause SQ stalls when multiple
-		 * SQs are mapped to same SMQ and transmitting pkts at a time.
-		 */
-		cfg = rvu_read64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS);
-		cfg &= ~BIT_ULL(15);
-		rvu_write64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS, cfg);
-	}
+	/* Disable SQ manager's sticky mode operation (set TM6 = 0)
+	 * This sticky mode is known to cause SQ stalls when multiple
+	 * SQs are mapped to same SMQ and transmitting pkts at a time.
+	 */
+	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS);
+	cfg &= ~BIT_ULL(15);
+	rvu_write64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS, cfg);
 
 	ltdefs = rvu->kpu.lt_def;
 	/* Calibrate X2P bus to check if CGX/LBK links are fine */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 161ad2ae4019..a55cacb988ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1682,8 +1682,9 @@ static struct mlx5_flow_handle *add_rule_fg(struct mlx5_flow_group *fg,
 	}
 	trace_mlx5_fs_set_fte(fte, false);
 
+	/* Link newly added rules into the tree. */
 	for (i = 0; i < handle->num_rules; i++) {
-		if (refcount_read(&handle->rule[i]->node.refcount) == 1) {
+		if (!handle->rule[i]->node.parent) {
 			tree_add_node(&handle->rule[i]->node, &fte->node);
 			trace_mlx5_fs_add_rule(handle->rule[i]);
 		}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 189a6a0a2e08..8561a7bf53e1 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -730,7 +730,7 @@ static int sparx5_port_pcs_low_set(struct sparx5 *sparx5,
 	bool sgmii = false, inband_aneg = false;
 	int err;
 
-	if (port->conf.inband) {
+	if (conf->inband) {
 		if (conf->portmode == PHY_INTERFACE_MODE_SGMII ||
 		    conf->portmode == PHY_INTERFACE_MODE_QSGMII)
 			inband_aneg = true; /* Cisco-SGMII in-band-aneg */
@@ -947,7 +947,7 @@ int sparx5_port_pcs_set(struct sparx5 *sparx5,
 	if (err)
 		return -EINVAL;
 
-	if (port->conf.inband) {
+	if (conf->inband) {
 		/* Enable/disable 1G counters in ASM */
 		spx5_rmw(ASM_PORT_CFG_CSC_STAT_DIS_SET(high_speed_dev),
 			 ASM_PORT_CFG_CSC_STAT_DIS,
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 9569b5cc595e..0e4ea3c0fe82 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -909,7 +909,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!pskb_inet_may_pull(skb))
+	if (!skb_vlan_inet_prepare(skb))
 		return -EINVAL;
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
@@ -1006,7 +1006,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!pskb_inet_may_pull(skb))
+	if (!skb_vlan_inet_prepare(skb))
 		return -EINVAL;
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 40a03f9c2d21..ac702f74dd98 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -1012,7 +1012,7 @@ qla_edif_app_getstats(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 
 		list_for_each_entry_safe(fcport, tf, &vha->vp_fcports, list) {
 			if (fcport->edif.enable) {
-				if (pcnt > app_req.num_ports)
+				if (pcnt >= app_req.num_ports)
 					break;
 
 				app_reply->elem[pcnt].rekey_count =
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 99cdd59f4e0c..061af5dc92e6 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2518,9 +2518,19 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	r = vhost_get_avail_idx(vq, &avail_idx);
 	if (unlikely(r))
 		return false;
+
 	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
+	if (vq->avail_idx != vq->last_avail_idx) {
+		/* Since we have updated avail_idx, the following
+		 * call to vhost_get_vq_desc() will read available
+		 * ring entries. Make sure that read happens after
+		 * the avail_idx read.
+		 */
+		smp_rmb();
+		return false;
+	}
 
-	return vq->avail_idx == vq->last_avail_idx;
+	return true;
 }
 EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 34278cb5f964..c50cabf69415 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4080,6 +4080,8 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 				      BTRFS_QGROUP_RSV_META_PREALLOC);
 	trace_qgroup_meta_convert(root, num_bytes);
 	qgroup_convert_meta(fs_info, root->root_key.objectid, num_bytes);
+	if (!sb_rdonly(fs_info->sb))
+		add_root_meta_rsv(root, num_bytes, BTRFS_QGROUP_RSV_META_PERTRANS);
 }
 
 /*
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index 9d276655cc25..6659d0369ec5 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -631,4 +631,11 @@ u64 dma_fence_context_alloc(unsigned num);
 			##args);					\
 	} while (0)
 
+#define DMA_FENCE_WARN(f, fmt, args...) \
+	do {								\
+		struct dma_fence *__ff = (f);				\
+		pr_warn("f %llu#%llu: " fmt, __ff->context, __ff->seqno,\
+			 ##args);					\
+	} while (0)
+
 #endif /* __LINUX_DMA_FENCE_H */
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 747f40e0c326..37738ec87de3 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -133,7 +133,7 @@ do {						\
 # define lockdep_softirq_enter()		do { } while (0)
 # define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
-# define lockdep_hrtimer_exit(__context)	do { } while (0)
+# define lockdep_hrtimer_exit(__context)	do { (void)(__context); } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
 # define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index e81856c0ba13..6a0f2097d370 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -66,7 +66,7 @@
 #include <linux/seqlock.h>
 
 struct u64_stats_sync {
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 	seqcount_t	seq;
 #endif
 };
@@ -115,7 +115,7 @@ static inline void u64_stats_inc(u64_stats_t *p)
 }
 #endif
 
-#if BITS_PER_LONG == 32 && defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 #define u64_stats_init(syncp)	seqcount_init(&(syncp)->seq)
 #else
 static inline void u64_stats_init(struct u64_stats_sync *syncp)
@@ -125,15 +125,19 @@ static inline void u64_stats_init(struct u64_stats_sync *syncp)
 
 static inline void u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	write_seqcount_begin(&syncp->seq);
 #endif
 }
 
 static inline void u64_stats_update_end(struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 	write_seqcount_end(&syncp->seq);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 #endif
 }
 
@@ -142,8 +146,11 @@ u64_stats_update_begin_irqsave(struct u64_stats_sync *syncp)
 {
 	unsigned long flags = 0;
 
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
-	local_irq_save(flags);
+#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+	else
+		local_irq_save(flags);
 	write_seqcount_begin(&syncp->seq);
 #endif
 	return flags;
@@ -153,15 +160,18 @@ static inline void
 u64_stats_update_end_irqrestore(struct u64_stats_sync *syncp,
 				unsigned long flags)
 {
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 	write_seqcount_end(&syncp->seq);
-	local_irq_restore(flags);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	else
+		local_irq_restore(flags);
 #endif
 }
 
 static inline unsigned int __u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 	return read_seqcount_begin(&syncp->seq);
 #else
 	return 0;
@@ -170,7 +180,7 @@ static inline unsigned int __u64_stats_fetch_begin(const struct u64_stats_sync *
 
 static inline unsigned int u64_stats_fetch_begin(const struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG==32 && !defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && (!defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT))
 	preempt_disable();
 #endif
 	return __u64_stats_fetch_begin(syncp);
@@ -179,7 +189,7 @@ static inline unsigned int u64_stats_fetch_begin(const struct u64_stats_sync *sy
 static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 					 unsigned int start)
 {
-#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && (defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT))
 	return read_seqcount_retry(&syncp->seq, start);
 #else
 	return false;
@@ -189,7 +199,7 @@ static inline bool __u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 static inline bool u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
 					 unsigned int start)
 {
-#if BITS_PER_LONG==32 && !defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && (!defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT))
 	preempt_enable();
 #endif
 	return __u64_stats_fetch_retry(syncp, start);
@@ -203,7 +213,9 @@ static inline bool u64_stats_fetch_retry(const struct u64_stats_sync *syncp,
  */
 static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_stats_sync *syncp)
 {
-#if BITS_PER_LONG==32 && !defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && defined(CONFIG_PREEMPT_RT)
+	preempt_disable();
+#elif BITS_PER_LONG == 32 && !defined(CONFIG_SMP)
 	local_irq_disable();
 #endif
 	return __u64_stats_fetch_begin(syncp);
@@ -212,7 +224,9 @@ static inline unsigned int u64_stats_fetch_begin_irq(const struct u64_stats_sync
 static inline bool u64_stats_fetch_retry_irq(const struct u64_stats_sync *syncp,
 					     unsigned int start)
 {
-#if BITS_PER_LONG==32 && !defined(CONFIG_SMP)
+#if BITS_PER_LONG == 32 && defined(CONFIG_PREEMPT_RT)
+	preempt_enable();
+#elif BITS_PER_LONG == 32 && !defined(CONFIG_SMP)
 	local_irq_enable();
 #endif
 	return __u64_stats_fetch_retry(syncp, start);
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 700a19e0455e..5cf1a7377407 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -435,6 +435,10 @@ static inline void in6_ifa_hold(struct inet6_ifaddr *ifp)
 	refcount_inc(&ifp->refcnt);
 }
 
+static inline bool in6_ifa_hold_safe(struct inet6_ifaddr *ifp)
+{
+	return refcount_inc_not_zero(&ifp->refcnt);
+}
 
 /*
  *	compute link-local solicited-node multicast address
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 32d21983c696..094afdf7dea1 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -56,7 +56,7 @@ struct unix_sock {
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
 	struct list_head	link;
-	atomic_long_t		inflight;
+	unsigned long		inflight;
 	spinlock_t		lock;
 	unsigned long		gc_flags;
 #define UNIX_GC_CANDIDATE	0
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 17ec652e8f12..eca36edb8557 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -332,6 +332,39 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 	return pskb_network_may_pull(skb, nhlen);
 }
 
+/* Variant of pskb_inet_may_pull().
+ */
+static inline bool skb_vlan_inet_prepare(struct sk_buff *skb)
+{
+	int nhlen = 0, maclen = ETH_HLEN;
+	__be16 type = skb->protocol;
+
+	/* Essentially this is skb_protocol(skb, true)
+	 * And we get MAC len.
+	 */
+	if (eth_type_vlan(type))
+		type = __vlan_get_protocol(skb, type, &maclen);
+
+	switch (type) {
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		nhlen = sizeof(struct ipv6hdr);
+		break;
+#endif
+	case htons(ETH_P_IP):
+		nhlen = sizeof(struct iphdr);
+		break;
+	}
+	/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
+	 * a base network header in skb->head.
+	 */
+	if (!pskb_may_pull(skb, maclen + nhlen))
+		return false;
+
+	skb_set_network_header(skb, maclen);
+	return true;
+}
+
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
 {
 	const struct ip_tunnel_encap_ops *ops;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0e786de993e0..297579dda40a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2722,7 +2722,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	CPU_MITIGATIONS_AUTO;
+	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+						     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c6bcb80785d8..2ec1473146ca 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1509,7 +1509,6 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	old_write = local_add_return(RB_WRITE_INTCNT, &next_page->write);
 	old_entries = local_add_return(RB_WRITE_INTCNT, &next_page->entries);
 
-	local_inc(&cpu_buffer->pages_touched);
 	/*
 	 * Just make sure we have seen our old_write and synchronize
 	 * with any interrupts that come in.
@@ -1546,8 +1545,9 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 		 */
 		local_set(&next_page->page->commit, 0);
 
-		/* Again, either we update tail_page or an interrupt does */
-		(void)cmpxchg(&cpu_buffer->tail_page, tail_page, next_page);
+		/* Either we update tail_page or an interrupt does */
+		if (try_cmpxchg(&cpu_buffer->tail_page, &tail_page, next_page))
+			local_inc(&cpu_buffer->pages_touched);
 	}
 }
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0a7348b90ba5..1f4f3096b9ac 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1645,6 +1645,7 @@ static int trace_format_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#ifdef CONFIG_PERF_EVENTS
 static ssize_t
 event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -1659,6 +1660,7 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
 }
+#endif
 
 static ssize_t
 event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
@@ -2104,10 +2106,12 @@ static const struct file_operations ftrace_event_format_fops = {
 	.release = seq_release,
 };
 
+#ifdef CONFIG_PERF_EVENTS
 static const struct file_operations ftrace_event_id_fops = {
 	.read = event_id_read,
 	.llseek = default_llseek,
 };
+#endif
 
 static const struct file_operations ftrace_event_filter_fops = {
 	.open = tracing_open_file_tr,
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1e1cf0e8a142..660a5594a647 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3948,7 +3948,7 @@ void batadv_tt_local_resize_to_mtu(struct net_device *soft_iface)
 
 	spin_lock_bh(&bat_priv->tt.commit_lock);
 
-	while (true) {
+	while (timeout) {
 		table_size = batadv_tt_local_table_transmit_size(bat_priv);
 		if (packet_size_max >= table_size)
 			break;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index c2db60ad0f1d..90392c8fe5dd 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -108,8 +108,10 @@ static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
-		if (skb)
+		if (skb) {
+			kfree_skb(hdev->req_skb);
 			hdev->req_skb = skb_get(skb);
+		}
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
 }
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 07ecb16231cd..a9d5a1973224 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -965,6 +965,8 @@ static int do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
@@ -1265,6 +1267,8 @@ static int compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 1e1e7488d6bf..aee7cd584c92 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1119,6 +1119,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
@@ -1505,6 +1507,8 @@ compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 12c59d700942..4ff94596f8cd 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -933,13 +933,11 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST, gw);
 		peer->rate_last = jiffies;
 		++peer->n_redirects;
-#ifdef CONFIG_IP_ROUTE_VERBOSE
-		if (log_martians &&
+		if (IS_ENABLED(CONFIG_IP_ROUTE_VERBOSE) && log_martians &&
 		    peer->n_redirects == ip_rt_redirect_number)
 			net_warn_ratelimited("host %pI4/if%d ignores redirects for %pI4 to %pI4\n",
 					     &ip_hdr(skb)->saddr, inet_iif(skb),
 					     &ip_hdr(skb)->daddr, &gw);
-#endif
 	}
 out_put_peer:
 	inet_putpeer(peer);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 968ca078191c..a17e1d744b2d 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2054,9 +2054,10 @@ struct inet6_ifaddr *ipv6_get_ifaddr(struct net *net, const struct in6_addr *add
 		if (ipv6_addr_equal(&ifp->addr, addr)) {
 			if (!dev || ifp->idev->dev == dev ||
 			    !(ifp->scope&(IFA_LINK|IFA_HOST) || strict)) {
-				result = ifp;
-				in6_ifa_hold(ifp);
-				break;
+				if (in6_ifa_hold_safe(ifp)) {
+					result = ifp;
+					break;
+				}
 			}
 		}
 	}
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index bbb9ed6d1ae6..c0ff5ee490e7 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1375,7 +1375,10 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 	     struct nl_info *info, struct netlink_ext_ack *extack)
 {
 	struct fib6_table *table = rt->fib6_table;
-	struct fib6_node *fn, *pn = NULL;
+	struct fib6_node *fn;
+#ifdef CONFIG_IPV6_SUBTREES
+	struct fib6_node *pn = NULL;
+#endif
 	int err = -ENOMEM;
 	int allow_create = 1;
 	int replace_required = 0;
@@ -1399,9 +1402,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 		goto out;
 	}
 
+#ifdef CONFIG_IPV6_SUBTREES
 	pn = fn;
 
-#ifdef CONFIG_IPV6_SUBTREES
 	if (rt->fib6_src.plen) {
 		struct fib6_node *sn;
 
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index b17990d514ee..afd22ea9f555 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1137,6 +1137,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
@@ -1515,6 +1517,8 @@ compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 7106ce231a2d..60dd6f32d520 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1704,8 +1704,9 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
 	if (ct_info.timeout[0]) {
 		if (nf_ct_set_timeout(net, ct_info.ct, family, key->ip.proto,
 				      ct_info.timeout))
-			pr_info_ratelimited("Failed to associated timeout "
-					    "policy `%s'\n", ct_info.timeout);
+			OVS_NLERR(log,
+				  "Failed to associated timeout policy '%s'",
+				  ct_info.timeout);
 		else
 			ct_info.nf_ct_timeout = rcu_dereference(
 				nf_ct_timeout_find(ct_info.ct)->timeout);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 265dc665c92a..628d97c195a7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -877,11 +877,11 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_write_space	= unix_write_space;
 	sk->sk_max_ack_backlog	= net->unx.sysctl_max_dgram_qlen;
 	sk->sk_destruct		= unix_sock_destructor;
-	u	  = unix_sk(sk);
+	u = unix_sk(sk);
+	u->inflight = 0;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
-	atomic_long_set(&u->inflight, 0);
 	INIT_LIST_HEAD(&u->link);
 	mutex_init(&u->iolock); /* single task reading lock */
 	mutex_init(&u->bindlock); /* single task binding lock */
@@ -2567,7 +2567,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 				}
 			} else if (!(flags & MSG_PEEK)) {
 				skb_unlink(skb, &sk->sk_receive_queue);
-				consume_skb(skb);
+				WRITE_ONCE(u->oob_skb, NULL);
+				if (!WARN_ON_ONCE(skb_unref(skb)))
+					kfree_skb(skb);
 				skb = skb_peek(&sk->sk_receive_queue);
 			}
 		}
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 9bfffe2a7f02..85c6f05c0fa3 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -166,17 +166,18 @@ static void scan_children(struct sock *x, void (*func)(struct unix_sock *),
 
 static void dec_inflight(struct unix_sock *usk)
 {
-	atomic_long_dec(&usk->inflight);
+	usk->inflight--;
 }
 
 static void inc_inflight(struct unix_sock *usk)
 {
-	atomic_long_inc(&usk->inflight);
+	usk->inflight++;
 }
 
 static void inc_inflight_move_tail(struct unix_sock *u)
 {
-	atomic_long_inc(&u->inflight);
+	u->inflight++;
+
 	/* If this still might be part of a cycle, move it to the end
 	 * of the list, so that it's checked even if it was already
 	 * passed over
@@ -234,20 +235,34 @@ void unix_gc(void)
 	 * receive queues.  Other, non candidate sockets _can_ be
 	 * added to queue, so we must make sure only to touch
 	 * candidates.
+	 *
+	 * Embryos, though never candidates themselves, affect which
+	 * candidates are reachable by the garbage collector.  Before
+	 * being added to a listener's queue, an embryo may already
+	 * receive data carrying SCM_RIGHTS, potentially making the
+	 * passed socket a candidate that is not yet reachable by the
+	 * collector.  It becomes reachable once the embryo is
+	 * enqueued.  Therefore, we must ensure that no SCM-laden
+	 * embryo appears in a (candidate) listener's queue between
+	 * consecutive scan_children() calls.
 	 */
 	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {
+		struct sock *sk = &u->sk;
 		long total_refs;
-		long inflight_refs;
 
-		total_refs = file_count(u->sk.sk_socket->file);
-		inflight_refs = atomic_long_read(&u->inflight);
+		total_refs = file_count(sk->sk_socket->file);
 
-		BUG_ON(inflight_refs < 1);
-		BUG_ON(total_refs < inflight_refs);
-		if (total_refs == inflight_refs) {
+		BUG_ON(!u->inflight);
+		BUG_ON(total_refs < u->inflight);
+		if (total_refs == u->inflight) {
 			list_move_tail(&u->link, &gc_candidates);
 			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
 			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
+
+			if (sk->sk_state == TCP_LISTEN) {
+				unix_state_lock(sk);
+				unix_state_unlock(sk);
+			}
 		}
 	}
 
@@ -271,7 +286,7 @@ void unix_gc(void)
 		/* Move cursor to after the current position. */
 		list_move(&cursor, &u->link);
 
-		if (atomic_long_read(&u->inflight) > 0) {
+		if (u->inflight) {
 			list_move_tail(&u->link, &not_cycle_list);
 			__clear_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
 			scan_children(&u->sk, inc_inflight_move_tail, NULL);
diff --git a/net/unix/scm.c b/net/unix/scm.c
index d1048b4c2baa..4eff7da9f6f9 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -52,12 +52,13 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 	if (s) {
 		struct unix_sock *u = unix_sk(s);
 
-		if (atomic_long_inc_return(&u->inflight) == 1) {
+		if (!u->inflight) {
 			BUG_ON(!list_empty(&u->link));
 			list_add_tail(&u->link, &gc_inflight_list);
 		} else {
 			BUG_ON(list_empty(&u->link));
 		}
+		u->inflight++;
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
 	}
@@ -74,10 +75,11 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
 	if (s) {
 		struct unix_sock *u = unix_sk(s);
 
-		BUG_ON(!atomic_long_read(&u->inflight));
+		BUG_ON(!u->inflight);
 		BUG_ON(list_empty(&u->link));
 
-		if (atomic_long_dec_and_test(&u->inflight))
+		u->inflight--;
+		if (!u->inflight)
 			list_del_init(&u->link);
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
 		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e5eb5616be0c..1f61d15b3d1d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1135,6 +1135,8 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
 		struct xsk_queue **q;
 		int entries;
 
+		if (optlen < sizeof(entries))
+			return -EINVAL;
 		if (copy_from_sockptr(&entries, optval, sizeof(entries)))
 			return -EFAULT;
 
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 0ba500056e63..193a984f512c 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -66,7 +66,7 @@ static int check_diff(struct timeval start, struct timeval end)
 	diff = end.tv_usec - start.tv_usec;
 	diff += (end.tv_sec - start.tv_sec) * USECS_PER_SEC;
 
-	if (abs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
+	if (llabs(diff - DELAY * USECS_PER_SEC) > USECS_PER_SEC / 2) {
 		printf("Diff too high: %lld..", diff);
 		return -1;
 	}

