Return-Path: <linux-kernel+bounces-148247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72E8A7FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25F61C2197C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA6613D26C;
	Wed, 17 Apr 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvZgSN86"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4459F13C821;
	Wed, 17 Apr 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346467; cv=none; b=r7W7bBu2pxMbi4vcWh3cN4sLrZxnEQtvXe+g8nhVo0/INJom5W4f3Md8pP5Zg/lUu15zI/owlhYLWR0zd9ioK2gpI/Ua5bs9yVwLa7kI66TX3KdMLgb2oe8gO/bQVG+/okqy4CcftkQGDuysiSABmGI/2d8oIpm2dSprZti0+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346467; c=relaxed/simple;
	bh=ThCel54N6Wua8NrtiQ1IeeIraoyKWO4EDzRvsUR+ido=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZImztBL58DQdmL6IA22urvq+3cEqCAyLC69w8NzhRwpJSIJBtSU1ZYUq0yFQ5ZPkVasy83hIuSerFrsPEWobMF6fRKBkC1LfvQw+tTySqN+a5JBYQmFw8E17V3zGFexoN+TjmUop/lg8mZ8dnAD8o+1160OpvXknmcLgi+DN9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvZgSN86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47882C4AF09;
	Wed, 17 Apr 2024 09:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713346466;
	bh=ThCel54N6Wua8NrtiQ1IeeIraoyKWO4EDzRvsUR+ido=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CvZgSN862SY1U7pbd+F2P3t0qkgQWLPz+4cPENvD5iTqG3A9Sz2GqYe0rrazeNmJv
	 TM2FmNLp7qiPM0Fg/BZIq/79FIkqOH1mUvOP0O0RAeN3RKY92BPvDReLf/psWAy3M6
	 8lV2GUrL8voZY5+Sj5oh3Mem10KbOJ73yWNIN2qk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.87
Date: Wed, 17 Apr 2024 11:34:13 +0200
Message-ID: <2024041712-curdle-bolster-3922@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024041711-acronym-grading-1a9c@gregkh>
References: <2024041711-acronym-grading-1a9c@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 9edb2860a3e1..e0a1be97fa75 100644
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
@@ -661,18 +661,14 @@ kernel command line.
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
index b2c7b2f012e9..aebbe2981241 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3283,6 +3283,7 @@
 					       reg_file_data_sampling=off [X86]
 					       retbleed=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
+					       spectre_bhi=off [X86]
 					       spectre_v2_user=off [X86]
 					       srbds=off [X86,INTEL]
 					       ssbd=force-off [ARM64]
@@ -5734,16 +5735,13 @@
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
index baddd8ed8186..e46a57006a34 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 86
+SUBLEVEL = 87
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index 10370d1a6c6d..dbb298b907c1 100644
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
index ba815ac474a1..5f7a86f240db 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2563,31 +2563,16 @@ config MITIGATION_RFDS
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
index 30fb4931d387..1394312b732a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1644,6 +1644,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	while (++i < cpuc->n_events) {
 		cpuc->event_list[i-1] = cpuc->event_list[i];
 		cpuc->event_constraint[i-1] = cpuc->event_constraint[i];
+		cpuc->assign[i-1] = cpuc->assign[i];
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 3216da7074ba..36ceecd40fd9 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -12,6 +12,7 @@
 #include <asm/mpspec.h>
 #include <asm/msr.h>
 #include <asm/hardirq.h>
+#include <asm/io.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -109,7 +110,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 
 static inline u32 native_apic_mem_read(u32 reg)
 {
-	return *((volatile u32 *)(APIC_BASE + reg));
+	return readl((void __iomem *)(APIC_BASE + reg));
 }
 
 extern void native_apic_wait_icr_idle(void);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 770557110051..e1672cc77c65 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1760,11 +1760,11 @@ static int x2apic_state;
 
 static bool x2apic_hw_locked(void)
 {
-	u64 ia32_cap;
+	u64 x86_arch_cap_msr;
 	u64 msr;
 
-	ia32_cap = x86_read_arch_cap_msr();
-	if (ia32_cap & ARCH_CAP_XAPIC_DISABLE) {
+	x86_arch_cap_msr = x86_read_arch_cap_msr();
+	if (x86_arch_cap_msr & ARCH_CAP_XAPIC_DISABLE) {
 		rdmsrl(MSR_IA32_XAPIC_DISABLE_STATUS, msr);
 		return (msr & LEGACY_XAPIC_DISABLED);
 	}
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 96bd3ee83a48..6d69123de366 100644
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
@@ -300,8 +304,6 @@ static const char * const taa_strings[] = {
 
 static void __init taa_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_TAA)) {
 		taa_mitigation = TAA_MITIGATION_OFF;
 		return;
@@ -340,9 +342,8 @@ static void __init taa_select_mitigation(void)
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
@@ -400,8 +401,6 @@ static const char * const mmio_strings[] = {
 
 static void __init mmio_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
 	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
 	     cpu_mitigations_off()) {
@@ -412,8 +411,6 @@ static void __init mmio_select_mitigation(void)
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
-	ia32_cap = x86_read_arch_cap_msr();
-
 	/*
 	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
 	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
@@ -436,7 +433,7 @@ static void __init mmio_select_mitigation(void)
 	 * be propagated to uncore buffers, clearing the Fill buffers on idle
 	 * is required irrespective of SMT state.
 	 */
-	if (!(ia32_cap & ARCH_CAP_FBSDP_NO))
+	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
 	/*
@@ -446,10 +443,10 @@ static void __init mmio_select_mitigation(void)
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
@@ -507,7 +504,7 @@ static void __init rfds_select_mitigation(void)
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
index 08fe77d2a3f9..f2bc651c0dcd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1308,25 +1308,25 @@ static bool __init cpu_matches(const struct x86_cpu_id *table, unsigned long whi
 
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
@@ -1334,7 +1334,7 @@ static bool __init vulnerable_to_rfds(u64 ia32_cap)
 	 * indicate that mitigation is needed because guest is running on a
 	 * vulnerable hardware or may migrate to such hardware:
 	 */
-	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		return true;
 
 	/* Only consult the blacklist when there is no enumeration: */
@@ -1343,11 +1343,11 @@ static bool __init vulnerable_to_rfds(u64 ia32_cap)
 
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
@@ -1359,7 +1359,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_SSB) &&
-	    !(ia32_cap & ARCH_CAP_SSB_NO) &&
+	    !(x86_arch_cap_msr & ARCH_CAP_SSB_NO) &&
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
@@ -1367,15 +1367,15 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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
@@ -1394,9 +1394,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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
@@ -1422,7 +1422,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * Set X86_BUG_MMIO_UNKNOWN for CPUs that are neither in the blacklist,
 	 * nor in the whitelist and also don't enumerate MSR ARCH_CAP MMIO bits.
 	 */
-	if (!arch_cap_mmio_immune(ia32_cap)) {
+	if (!arch_cap_mmio_immune(x86_arch_cap_msr)) {
 		if (cpu_matches(cpu_vuln_blacklist, MMIO))
 			setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
 		else if (!cpu_matches(cpu_vuln_whitelist, NO_MMIO))
@@ -1430,7 +1430,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	}
 
 	if (!cpu_has(c, X86_FEATURE_BTC_NO)) {
-		if (cpu_matches(cpu_vuln_blacklist, RETBLEED) || (ia32_cap & ARCH_CAP_RSBA))
+		if (cpu_matches(cpu_vuln_blacklist, RETBLEED) || (x86_arch_cap_msr & ARCH_CAP_RSBA))
 			setup_force_cpu_bug(X86_BUG_RETBLEED);
 	}
 
@@ -1443,7 +1443,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * disabling AVX2. The only way to do this in HW is to clear XCR0[2],
 	 * which means that AVX will be disabled.
 	 */
-	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(ia32_cap & ARCH_CAP_GDS_NO) &&
+	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(x86_arch_cap_msr & ARCH_CAP_GDS_NO) &&
 	    boot_cpu_has(X86_FEATURE_AVX))
 		setup_force_cpu_bug(X86_BUG_GDS);
 
@@ -1452,11 +1452,11 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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
@@ -1466,7 +1466,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 		return;
 
 	/* Rogue Data Cache Load? No! */
-	if (ia32_cap & ARCH_CAP_RDCL_NO)
+	if (x86_arch_cap_msr & ARCH_CAP_RDCL_NO)
 		return;
 
 	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a09548630fc8..65fde5717928 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4667,7 +4667,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			 * bail out.
 			 */
 			if (ap->pflags & ATA_PFLAG_SUSPENDED)
-				goto unlock;
+				goto unlock_ap;
 
 			if (!sdev)
 				continue;
@@ -4680,7 +4680,7 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			if (do_resume) {
 				ret = scsi_resume_device(sdev);
 				if (ret == -EWOULDBLOCK)
-					goto unlock;
+					goto unlock_scan;
 				dev->flags &= ~ATA_DFLAG_RESUMING;
 			}
 			ret = scsi_rescan_device(sdev);
@@ -4688,12 +4688,13 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			spin_lock_irqsave(ap->lock, flags);
 
 			if (ret)
-				goto unlock;
+				goto unlock_ap;
 		}
 	}
 
-unlock:
+unlock_ap:
 	spin_unlock_irqrestore(ap->lock, flags);
+unlock_scan:
 	mutex_unlock(&ap->scsi_scan_mutex);
 
 	/* Reschedule with a delay if scsi_rescan_device() returned an error */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 56af7b5abac1..56cc59629d96 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -460,10 +460,8 @@ static bool soc21_need_full_reset(struct amdgpu_device *adev)
 {
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
-		return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC);
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
-		return false;
 	default:
 		return true;
 	}
@@ -780,10 +778,35 @@ static int soc21_common_suspend(void *handle)
 	return soc21_common_hw_fini(adev);
 }
 
+static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
+{
+	u32 sol_reg1, sol_reg2;
+
+	/* Will reset for the following suspend abort cases.
+	 * 1) Only reset dGPU side.
+	 * 2) S3 suspend got aborted and TOS is active.
+	 */
+	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
+	    !adev->suspend_complete) {
+		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+		msleep(100);
+		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
+
+		return (sol_reg1 != sol_reg2);
+	}
+
+	return false;
+}
+
 static int soc21_common_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (soc21_need_reset_on_resume(adev)) {
+		dev_info(adev->dev, "S3 suspend aborted, resetting...");
+		soc21_asic_reset(adev);
+	}
+
 	return soc21_common_hw_init(adev);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0b87034d9dd5..1b7b29426480 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1805,6 +1805,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 		pr_err("HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
 		while (halt_if_hws_hang)
 			schedule();
+		kfd_hws_hang(dqm);
 		return -ETIME;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 187f5b27fdc8..29d2003fb712 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -112,20 +112,25 @@ static int dcn316_get_active_display_cnt_wa(
 	return display_count;
 }
 
-static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context, bool disable)
+static void dcn316_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *context,
+		bool safe_to_lower, bool disable)
 {
 	struct dc *dc = clk_mgr_base->ctx->dc;
 	int i;
 
 	for (i = 0; i < dc->res_pool->pipe_count; ++i) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = safe_to_lower
+			? &context->res_ctx.pipe_ctx[i]
+			: &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
-		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
-				     dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
+				     !pipe->stream->link_enc)) {
 			if (disable) {
-				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+				if (pipe->stream_res.tg && pipe->stream_res.tg->funcs->immediate_disable_crtc)
+					pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
+
 				reset_sync_context_for_pipe(dc, context, i);
 			} else
 				pipe->stream_res.tg->funcs->enable_crtc(pipe->stream_res.tg);
@@ -222,11 +227,11 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		dcn316_disable_otg_wa(clk_mgr_base, context, true);
+		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 		dcn316_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		dcn316_disable_otg_wa(clk_mgr_base, context, false);
+		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 6d9760eac16d..21b374d12181 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -222,8 +222,18 @@ static int smu_v13_0_4_system_features_control(struct smu_context *smu, bool en)
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
-	if (!en && !adev->in_s0ix)
+	if (!en && !adev->in_s0ix) {
+		/* Adds a GFX reset as workaround just before sending the
+		 * MP1_UNLOAD message to prevent GC/RLC/PMFW from entering
+		 * an invalid state.
+		 */
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
+						      SMU_RESET_MODE_2, NULL);
+		if (ret)
+			return ret;
+
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 56483860306b..a4a23b9623ad 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -190,6 +190,7 @@ void ast_dp_set_on_off(struct drm_device *dev, bool on)
 {
 	struct ast_private *ast = to_ast_private(dev);
 	u8 video_on_off = on;
+	u32 i = 0;
 
 	// Video On/Off
 	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE3, (u8) ~AST_DP_VIDEO_ENABLE, on);
@@ -202,6 +203,8 @@ void ast_dp_set_on_off(struct drm_device *dev, bool on)
 						ASTDP_MIRROR_VIDEO_ENABLE) != video_on_off) {
 			// wait 1 ms
 			mdelay(1);
+			if (++i > 200)
+				break;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 7847020de0a4..9a65806047b5 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -781,6 +781,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 	unsigned int total_modes_count = 0;
 	struct drm_client_offset *offsets;
 	unsigned int connector_count = 0;
+	/* points to modes protected by mode_config.mutex */
 	struct drm_display_mode **modes;
 	struct drm_crtc **crtcs;
 	int i, ret = 0;
@@ -849,7 +850,6 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 		drm_client_pick_crtcs(client, connectors, connector_count,
 				      crtcs, modes, 0, width, height);
 	}
-	mutex_unlock(&dev->mode_config.mutex);
 
 	drm_client_modeset_release(client);
 
@@ -879,6 +879,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 			modeset->y = offset->y;
 		}
 	}
+	mutex_unlock(&dev->mode_config.mutex);
 
 	mutex_unlock(&client->modeset_mutex);
 out:
diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index 25dcdde5feb6..5147718f38d6 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2152,7 +2152,7 @@ intel_set_cdclk_pre_plane_update(struct intel_atomic_state *state)
 				 &new_cdclk_state->actual))
 		return;
 
-	if (pipe == INVALID_PIPE ||
+	if (new_cdclk_state->disable_pipes ||
 	    old_cdclk_state->actual.cdclk <= new_cdclk_state->actual.cdclk) {
 		drm_WARN_ON(&dev_priv->drm, !new_cdclk_state->base.changed);
 
@@ -2181,7 +2181,7 @@ intel_set_cdclk_post_plane_update(struct intel_atomic_state *state)
 				 &new_cdclk_state->actual))
 		return;
 
-	if (pipe != INVALID_PIPE &&
+	if (!new_cdclk_state->disable_pipes &&
 	    old_cdclk_state->actual.cdclk > new_cdclk_state->actual.cdclk) {
 		drm_WARN_ON(&dev_priv->drm, !new_cdclk_state->base.changed);
 
@@ -2634,6 +2634,7 @@ static struct intel_global_state *intel_cdclk_duplicate_state(struct intel_globa
 		return NULL;
 
 	cdclk_state->pipe = INVALID_PIPE;
+	cdclk_state->disable_pipes = false;
 
 	return &cdclk_state->base;
 }
@@ -2793,6 +2794,8 @@ int intel_modeset_calc_cdclk(struct intel_atomic_state *state)
 		if (ret)
 			return ret;
 
+		new_cdclk_state->disable_pipes = true;
+
 		drm_dbg_kms(&dev_priv->drm,
 			    "Modeset required for cdclk change\n");
 	}
diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.h b/drivers/gpu/drm/i915/display/intel_cdclk.h
index c674879a84a5..c4b3e5938bb3 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.h
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.h
@@ -51,6 +51,9 @@ struct intel_cdclk_state {
 
 	/* bitmask of active pipes */
 	u8 active_pipes;
+
+	/* update cdclk with pipes disabled */
+	bool disable_pipes;
 };
 
 int intel_crtc_compute_min_cdclk(const struct intel_crtc_state *crtc_state);
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 706e2d956801..76277eb3eb25 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3683,7 +3683,12 @@ static bool m_n_equal(const struct intel_link_m_n *m_n_1,
 static bool crtcs_port_sync_compatible(const struct intel_crtc_state *crtc_state1,
 				       const struct intel_crtc_state *crtc_state2)
 {
+	/*
+	 * FIXME the modeset sequence is currently wrong and
+	 * can't deal with bigjoiner + port sync at the same time.
+	 */
 	return crtc_state1->hw.active && crtc_state2->hw.active &&
+		!crtc_state1->bigjoiner_pipes && !crtc_state2->bigjoiner_pipes &&
 		crtc_state1->output_types == crtc_state2->output_types &&
 		crtc_state1->output_format == crtc_state2->output_format &&
 		crtc_state1->lane_count == crtc_state2->lane_count &&
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 5eac99021875..6615e4153f37 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -110,6 +110,13 @@ intel_vrr_compute_config(struct intel_crtc_state *crtc_state,
 	if (!intel_vrr_is_capable(connector))
 		return;
 
+	/*
+	 * FIXME all joined pipes share the same transcoder.
+	 * Need to account for that during VRR toggle/push/etc.
+	 */
+	if (crtc_state->bigjoiner_pipes)
+		return;
+
 	if (adjusted_mode->flags & DRM_MODE_FLAG_INTERLACE)
 		return;
 
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
index 368d26da0d6a..9febc8b73f09 100644
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
index 03b25358946c..cb862ab96873 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -71,7 +71,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	struct page *pages;
 	int irq, ret;
 
-	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
+	pages = alloc_pages_node(iommu->node, GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
 	if (!pages) {
 		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
 			iommu->name);
diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 4bc2a705029e..c761ac35e120 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1121,20 +1121,6 @@ void cec_received_msg_ts(struct cec_adapter *adap,
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
index 07065c1af55e..d4515c19a5f3 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -998,20 +998,173 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
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
@@ -1019,35 +1172,43 @@ mt753x_trap_frames(struct mt7530_priv *priv)
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
index fa2afa67ceb0..2d1ea390f05a 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -63,6 +63,7 @@ enum mt753x_id {
 
 /* Registers for BPDU and PAE frame control*/
 #define MT753X_BPC			0x24
+#define  MT753X_PAE_BPDU_FR		BIT(25)
 #define  MT753X_PAE_EG_TAG_MASK		GENMASK(24, 22)
 #define  MT753X_PAE_EG_TAG(x)		FIELD_PREP(MT753X_PAE_EG_TAG_MASK, x)
 #define  MT753X_PAE_PORT_FW_MASK	GENMASK(18, 16)
@@ -73,20 +74,24 @@ enum mt753x_id {
 
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
index 633b321d7fdd..4db689372980 100644
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
index 9e82e7b9c3b7..5e37b18ac3ad 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1203,8 +1203,11 @@ static void ena_unmap_tx_buff(struct ena_ring *tx_ring,
 static void ena_free_tx_bufs(struct ena_ring *tx_ring)
 {
 	bool print_once = true;
+	bool is_xdp_ring;
 	u32 i;
 
+	is_xdp_ring = ENA_IS_XDP_INDEX(tx_ring->adapter, tx_ring->qid);
+
 	for (i = 0; i < tx_ring->ring_size; i++) {
 		struct ena_tx_buffer *tx_info = &tx_ring->tx_buffer_info[i];
 
@@ -1224,10 +1227,15 @@ static void ena_free_tx_bufs(struct ena_ring *tx_ring)
 
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
@@ -3797,10 +3805,11 @@ static void check_for_missing_completions(struct ena_adapter *adapter)
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
 
@@ -3813,27 +3822,29 @@ static void check_for_missing_completions(struct ena_adapter *adapter)
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
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f810b5dc25f0..0d0aad7141c1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10564,6 +10564,8 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	/* VF-reps may need to be re-opened after the PF is re-opened */
 	if (BNXT_PF(bp))
 		bnxt_vf_reps_open(bp);
+	if (bp->ptp_cfg)
+		atomic_set(&bp->ptp_cfg->tx_avail, BNXT_MAX_TX_TS);
 	bnxt_ptp_init_rtc(bp, true);
 	bnxt_ptp_cfg_tstamp_filters(bp);
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index bb99302eab67..67080d5053e0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4237,18 +4237,18 @@ static int rvu_nix_block_init(struct rvu *rvu, struct nix_hw *nix_hw)
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index 2842195ee548..1e887d640cff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -82,24 +82,25 @@ int mlx5e_open_qos_sq(struct mlx5e_priv *priv, struct mlx5e_channels *chs,
 
 	txq_ix = mlx5e_qid_from_qos(chs, node_qid);
 
-	WARN_ON(node_qid > priv->htb_max_qos_sqs);
-	if (node_qid == priv->htb_max_qos_sqs) {
-		struct mlx5e_sq_stats *stats, **stats_list = NULL;
-
-		if (priv->htb_max_qos_sqs == 0) {
-			stats_list = kvcalloc(mlx5e_qos_max_leaf_nodes(priv->mdev),
-					      sizeof(*stats_list),
-					      GFP_KERNEL);
-			if (!stats_list)
-				return -ENOMEM;
-		}
+	WARN_ON(node_qid >= mlx5e_htb_cur_leaf_nodes(priv->htb));
+	if (!priv->htb_qos_sq_stats) {
+		struct mlx5e_sq_stats **stats_list;
+
+		stats_list = kvcalloc(mlx5e_qos_max_leaf_nodes(priv->mdev),
+				      sizeof(*stats_list), GFP_KERNEL);
+		if (!stats_list)
+			return -ENOMEM;
+
+		WRITE_ONCE(priv->htb_qos_sq_stats, stats_list);
+	}
+
+	if (!priv->htb_qos_sq_stats[node_qid]) {
+		struct mlx5e_sq_stats *stats;
+
 		stats = kzalloc(sizeof(*stats), GFP_KERNEL);
-		if (!stats) {
-			kvfree(stats_list);
+		if (!stats)
 			return -ENOMEM;
-		}
-		if (stats_list)
-			WRITE_ONCE(priv->htb_qos_sq_stats, stats_list);
+
 		WRITE_ONCE(priv->htb_qos_sq_stats[node_qid], stats);
 		/* Order htb_max_qos_sqs increment after writing the array pointer.
 		 * Pairs with smp_load_acquire in en_stats.c.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c b/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c
index f675b1926340..f66bbc846464 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/selq.c
@@ -57,6 +57,7 @@ int mlx5e_selq_init(struct mlx5e_selq *selq, struct mutex *state_lock)
 
 void mlx5e_selq_cleanup(struct mlx5e_selq *selq)
 {
+	mutex_lock(selq->state_lock);
 	WARN_ON_ONCE(selq->is_prepared);
 
 	kvfree(selq->standby);
@@ -67,6 +68,7 @@ void mlx5e_selq_cleanup(struct mlx5e_selq *selq)
 
 	kvfree(selq->standby);
 	selq->standby = NULL;
+	mutex_unlock(selq->state_lock);
 }
 
 void mlx5e_selq_prepare_params(struct mlx5e_selq *selq, struct mlx5e_params *params)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9910a0480f58..e7d396434da3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5578,9 +5578,7 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 	kfree(priv->tx_rates);
 	kfree(priv->txq2sq);
 	destroy_workqueue(priv->wq);
-	mutex_lock(&priv->state_lock);
 	mlx5e_selq_cleanup(&priv->selq);
-	mutex_unlock(&priv->state_lock);
 	free_cpumask_var(priv->scratchpad.cpumask);
 
 	for (i = 0; i < priv->htb_max_qos_sqs; i++)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index e6674118bc42..164e10b5f9b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1752,8 +1752,9 @@ static struct mlx5_flow_handle *add_rule_fg(struct mlx5_flow_group *fg,
 	}
 	trace_mlx5_fs_set_fte(fte, false);
 
+	/* Link newly added rules into the tree. */
 	for (i = 0; i < handle->num_rules; i++) {
-		if (refcount_read(&handle->rule[i]->node.refcount) == 1) {
+		if (!handle->rule[i]->node.parent) {
 			tree_add_node(&handle->rule[i]->node, &fte->node);
 			trace_mlx5_fs_add_rule(handle->rule[i]);
 		}
diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/micrel/ks8851.h
index e5ec0a363aff..31f75b4a67fd 100644
--- a/drivers/net/ethernet/micrel/ks8851.h
+++ b/drivers/net/ethernet/micrel/ks8851.h
@@ -368,7 +368,6 @@ union ks8851_tx_hdr {
  * @rdfifo: FIFO read callback
  * @wrfifo: FIFO write callback
  * @start_xmit: start_xmit() implementation callback
- * @rx_skb: rx_skb() implementation callback
  * @flush_tx_work: flush_tx_work() implementation callback
  *
  * The @statelock is used to protect information in the structure which may
@@ -423,8 +422,6 @@ struct ks8851_net {
 					  struct sk_buff *txp, bool irq);
 	netdev_tx_t		(*start_xmit)(struct sk_buff *skb,
 					      struct net_device *dev);
-	void			(*rx_skb)(struct ks8851_net *ks,
-					  struct sk_buff *skb);
 	void			(*flush_tx_work)(struct ks8851_net *ks);
 };
 
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 0bf13b38b8f5..d4cdf3d4f552 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -231,16 +231,6 @@ static void ks8851_dbg_dumpkkt(struct ks8851_net *ks, u8 *rxpkt)
 		   rxpkt[12], rxpkt[13], rxpkt[14], rxpkt[15]);
 }
 
-/**
- * ks8851_rx_skb - receive skbuff
- * @ks: The device state.
- * @skb: The skbuff
- */
-static void ks8851_rx_skb(struct ks8851_net *ks, struct sk_buff *skb)
-{
-	ks->rx_skb(ks, skb);
-}
-
 /**
  * ks8851_rx_pkts - receive packets from the host
  * @ks: The device information.
@@ -309,7 +299,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
 					ks8851_dbg_dumpkkt(ks, rxpkt);
 
 				skb->protocol = eth_type_trans(skb, ks->netdev);
-				ks8851_rx_skb(ks, skb);
+				__netif_rx(skb);
 
 				ks->netdev->stats.rx_packets++;
 				ks->netdev->stats.rx_bytes += rxlen;
@@ -340,6 +330,8 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	unsigned long flags;
 	unsigned int status;
 
+	local_bh_disable();
+
 	ks8851_lock(ks, &flags);
 
 	status = ks8851_rdreg16(ks, KS_ISR);
@@ -416,6 +408,8 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
 	if (status & IRQ_LCI)
 		mii_check_link(&ks->mii);
 
+	local_bh_enable();
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/net/ethernet/micrel/ks8851_par.c b/drivers/net/ethernet/micrel/ks8851_par.c
index 7f49042484bd..96fb0ffcedb9 100644
--- a/drivers/net/ethernet/micrel/ks8851_par.c
+++ b/drivers/net/ethernet/micrel/ks8851_par.c
@@ -210,16 +210,6 @@ static void ks8851_wrfifo_par(struct ks8851_net *ks, struct sk_buff *txp,
 	iowrite16_rep(ksp->hw_addr, txp->data, len / 2);
 }
 
-/**
- * ks8851_rx_skb_par - receive skbuff
- * @ks: The device state.
- * @skb: The skbuff
- */
-static void ks8851_rx_skb_par(struct ks8851_net *ks, struct sk_buff *skb)
-{
-	netif_rx(skb);
-}
-
 static unsigned int ks8851_rdreg16_par_txqcr(struct ks8851_net *ks)
 {
 	return ks8851_rdreg16_par(ks, KS_TXQCR);
@@ -298,7 +288,6 @@ static int ks8851_probe_par(struct platform_device *pdev)
 	ks->rdfifo = ks8851_rdfifo_par;
 	ks->wrfifo = ks8851_wrfifo_par;
 	ks->start_xmit = ks8851_start_xmit_par;
-	ks->rx_skb = ks8851_rx_skb_par;
 
 #define STD_IRQ (IRQ_LCI |	/* Link Change */	\
 		 IRQ_RXI |	/* RX done */		\
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 88e26c120b48..4dcbff789b19 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -298,16 +298,6 @@ static unsigned int calc_txlen(unsigned int len)
 	return ALIGN(len + 4, 4);
 }
 
-/**
- * ks8851_rx_skb_spi - receive skbuff
- * @ks: The device state
- * @skb: The skbuff
- */
-static void ks8851_rx_skb_spi(struct ks8851_net *ks, struct sk_buff *skb)
-{
-	netif_rx(skb);
-}
-
 /**
  * ks8851_tx_work - process tx packet(s)
  * @work: The work strucutre what was scheduled.
@@ -435,7 +425,6 @@ static int ks8851_probe_spi(struct spi_device *spi)
 	ks->rdfifo = ks8851_rdfifo_spi;
 	ks->wrfifo = ks8851_wrfifo_spi;
 	ks->start_xmit = ks8851_start_xmit_spi;
-	ks->rx_skb = ks8851_rx_skb_spi;
 	ks->flush_tx_work = ks8851_flush_tx_work_spi;
 
 #define STD_IRQ (IRQ_LCI |	/* Link Change */	\
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 32709d21ab2f..212bf6f4ed72 100644
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
index 3f8da6f0b25c..488ca1c85496 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -930,7 +930,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!pskb_inet_may_pull(skb))
+	if (!skb_vlan_inet_prepare(skb))
 		return -EINVAL;
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
@@ -1028,7 +1028,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!pskb_inet_may_pull(skb))
+	if (!skb_vlan_inet_prepare(skb))
 		return -EINVAL;
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 450a8578157c..2116f5ee36e2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1715,7 +1715,7 @@ static int hisi_sas_debug_I_T_nexus_reset(struct domain_device *device)
 	if (dev_is_sata(device)) {
 		struct ata_link *link = &device->sata_dev.ap->link;
 
-		rc = ata_wait_after_reset(link, HISI_SAS_WAIT_PHYUP_TIMEOUT,
+		rc = ata_wait_after_reset(link, jiffies + HISI_SAS_WAIT_PHYUP_TIMEOUT,
 					  smp_ata_check_ready_type);
 	} else {
 		msleep(2000);
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 7aee4d093969..969008071dec 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -1058,7 +1058,7 @@ qla_edif_app_getstats(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 
 		list_for_each_entry_safe(fcport, tf, &vha->vp_fcports, list) {
 			if (fcport->edif.enable) {
-				if (pcnt > app_req.num_ports)
+				if (pcnt >= app_req.num_ports)
 					break;
 
 				app_reply->elem[pcnt].rekey_count =
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 61c72e62abd4..1b00ed5ef1cf 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2523,9 +2523,19 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
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
 
@@ -2562,9 +2572,19 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 		       &vq->avail->idx, r);
 		return false;
 	}
+
 	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
+	if (vq->avail_idx != vq->last_avail_idx) {
+		/* Since we have updated avail_idx, the following
+		 * call to vhost_get_vq_desc() will read available
+		 * ring entries. Make sure that read happens after
+		 * the avail_idx read.
+		 */
+		smp_rmb();
+		return true;
+	}
 
-	return vq->avail_idx != vq->last_avail_idx;
+	return false;
 }
 EXPORT_SYMBOL_GPL(vhost_enable_notify);
 
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index c6426080cf0a..1494ce990d29 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1115,6 +1115,9 @@ __btrfs_commit_inode_delayed_items(struct btrfs_trans_handle *trans,
 	if (ret)
 		return ret;
 
+	ret = btrfs_record_root_in_trans(trans, node->root);
+	if (ret)
+		return ret;
 	ret = btrfs_update_delayed_inode(trans, node->root, path, node);
 	return ret;
 }
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c14d4f70e84b..80ca7b435b0d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4154,6 +4154,8 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 				      BTRFS_QGROUP_RSV_META_PREALLOC);
 	trace_qgroup_meta_convert(root, num_bytes);
 	qgroup_convert_meta(fs_info, root->root_key.objectid, num_bytes);
+	if (!sb_rdonly(fs_info->sb))
+		add_root_meta_rsv(root, num_bytes, BTRFS_QGROUP_RSV_META_PERTRANS);
 }
 
 /*
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index b172091f4261..5549c843f0d3 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -700,14 +700,6 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		h->reloc_reserved = reloc_reserved;
 	}
 
-	/*
-	 * Now that we have found a transaction to be a part of, convert the
-	 * qgroup reservation from prealloc to pertrans. A different transaction
-	 * can't race in and free our pertrans out from under us.
-	 */
-	if (qgroup_reserved)
-		btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
-
 got_it:
 	if (!current->journal_info)
 		current->journal_info = h;
@@ -741,8 +733,15 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		 * not just freed.
 		 */
 		btrfs_end_transaction(h);
-		return ERR_PTR(ret);
+		goto reserve_fail;
 	}
+	/*
+	 * Now that we have found a transaction to be a part of, convert the
+	 * qgroup reservation from prealloc to pertrans. A different transaction
+	 * can't race in and free our pertrans out from under us.
+	 */
+	if (qgroup_reserved)
+		btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
 
 	return h;
 
diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index f4ad343b06c1..2ca1881919c7 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -386,8 +386,8 @@ smb2_close_cached_fid(struct kref *ref)
 	if (cfid->is_open) {
 		rc = SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
 			   cfid->fid.volatile_fid);
-		if (rc != -EBUSY && rc != -EAGAIN)
-			atomic_dec(&cfid->tcon->num_remote_opens);
+		if (rc) /* should we retry on -EBUSY or -EAGAIN? */
+			cifs_dbg(VFS, "close cached dir rc %d\n", rc);
 	}
 
 	free_cached_dir(cfid);
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index b79097b9070b..5d6a5f3097cd 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -659,4 +659,11 @@ static inline bool dma_fence_is_container(struct dma_fence *fence)
 	return dma_fence_is_array(fence) || dma_fence_is_chain(fence);
 }
 
+#define DMA_FENCE_WARN(f, fmt, args...) \
+	do {								\
+		struct dma_fence *__ff = (f);				\
+		pr_warn("f %llu#%llu: " fmt, __ff->context, __ff->seqno,\
+			 ##args);					\
+	} while (0)
+
 #endif /* __LINUX_DMA_FENCE_H */
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 2b665c32f5fe..2e09c269bf9d 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -126,7 +126,7 @@ do {						\
 # define lockdep_softirq_enter()		do { } while (0)
 # define lockdep_softirq_exit()			do { } while (0)
 # define lockdep_hrtimer_enter(__hrtimer)	false
-# define lockdep_hrtimer_exit(__context)	do { } while (0)
+# define lockdep_hrtimer_exit(__context)	do { (void)(__context); } while (0)
 # define lockdep_posixtimer_enter()		do { } while (0)
 # define lockdep_posixtimer_exit()		do { } while (0)
 # define lockdep_irq_work_enter(__work)		do { } while (0)
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 46040d66334a..79c3bbaa7e13 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -135,10 +135,11 @@ static inline void u64_stats_inc(u64_stats_t *p)
 	p->v++;
 }
 
-static inline void u64_stats_init(struct u64_stats_sync *syncp)
-{
-	seqcount_init(&syncp->seq);
-}
+#define u64_stats_init(syncp)				\
+	do {						\
+		struct u64_stats_sync *__s = (syncp);	\
+		seqcount_init(&__s->seq);		\
+	} while (0)
 
 static inline void __u64_stats_update_begin(struct u64_stats_sync *syncp)
 {
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 86eb2aba1479..5bcc63eade03 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -437,6 +437,10 @@ static inline void in6_ifa_hold(struct inet6_ifaddr *ifp)
 	refcount_inc(&ifp->refcnt);
 }
 
+static inline bool in6_ifa_hold_safe(struct inet6_ifaddr *ifp)
+{
+	return refcount_inc_not_zero(&ifp->refcnt);
+}
 
 /*
  *	compute link-local solicited-node multicast address
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 0920b669b9b3..16d6936baa2f 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -54,7 +54,7 @@ struct unix_sock {
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
 	struct list_head	link;
-	atomic_long_t		inflight;
+	unsigned long		inflight;
 	spinlock_t		lock;
 	unsigned long		gc_flags;
 #define UNIX_GC_CANDIDATE	0
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bcc5a4cd2c17..5aaf7d7f3c6f 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -565,6 +565,15 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
 	return skb;
 }
 
+static inline int bt_copy_from_sockptr(void *dst, size_t dst_size,
+				       sockptr_t src, size_t src_size)
+{
+	if (dst_size > src_size)
+		return -EINVAL;
+
+	return copy_from_sockptr(dst, src, dst_size);
+}
+
 int bt_to_errno(u16 code);
 __u8 bt_status(int err);
 
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index bca80522f95c..f9906b73e7ff 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -351,6 +351,39 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
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
diff --git a/io_uring/net.c b/io_uring/net.c
index b1b564c04d1e..48404bd33001 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1229,6 +1229,7 @@ int io_sendmsg_zc(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (req_has_async_data(req)) {
 		kmsg = req->async_data;
+		kmsg->msg.msg_control_user = sr->msg_control;
 	} else {
 		ret = io_sendmsg_copy_hdr(req, &iomsg);
 		if (ret)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6f0101941ed..2c44dd12a158 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2788,7 +2788,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	CPU_MITIGATIONS_AUTO;
+	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+						     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dbfddfa86c14..5b5ee060a2db 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1567,10 +1567,17 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	jump_label_lock();
 	preempt_disable();
 
-	/* Ensure it is not in reserved area nor out of text */
-	if (!(core_kernel_text((unsigned long) p->addr) ||
-	    is_module_text_address((unsigned long) p->addr)) ||
-	    in_gate_area_no_mm((unsigned long) p->addr) ||
+	/* Ensure the address is in a text area, and find a module if exists. */
+	*probed_mod = NULL;
+	if (!core_kernel_text((unsigned long) p->addr)) {
+		*probed_mod = __module_text_address((unsigned long) p->addr);
+		if (!(*probed_mod)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	/* Ensure it is not in reserved area. */
+	if (in_gate_area_no_mm((unsigned long) p->addr) ||
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
@@ -1580,8 +1587,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		goto out;
 	}
 
-	/* Check if 'p' is probing a module. */
-	*probed_mod = __module_text_address((unsigned long) p->addr);
+	/* Get module refcount and reject __init functions for loaded modules. */
 	if (*probed_mod) {
 		/*
 		 * We must hold a refcount of the probed module while updating
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index a718067deece..3aae526cc4aa 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -106,6 +106,12 @@ static void s2idle_enter(void)
 	swait_event_exclusive(s2idle_wait_head,
 		    s2idle_state == S2IDLE_STATE_WAKE);
 
+	/*
+	 * Kick all CPUs to ensure that they resume their timers and restore
+	 * consistent system state.
+	 */
+	wake_up_all_idle_cpus();
+
 	cpus_read_unlock();
 
 	raw_spin_lock_irq(&s2idle_lock);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d2947de3021a..337162e0c3d5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1543,7 +1543,6 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	old_write = local_add_return(RB_WRITE_INTCNT, &next_page->write);
 	old_entries = local_add_return(RB_WRITE_INTCNT, &next_page->entries);
 
-	local_inc(&cpu_buffer->pages_touched);
 	/*
 	 * Just make sure we have seen our old_write and synchronize
 	 * with any interrupts that come in.
@@ -1580,8 +1579,9 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
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
index a6d2f99f847d..24859d964505 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1669,6 +1669,7 @@ static int trace_format_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#ifdef CONFIG_PERF_EVENTS
 static ssize_t
 event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -1683,6 +1684,7 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
 }
+#endif
 
 static ssize_t
 event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
@@ -2127,10 +2129,12 @@ static const struct file_operations ftrace_event_format_fops = {
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
index 5d8cee74772f..4fc66cd95dc4 100644
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
index 4468647df672..cf69e973b724 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -105,8 +105,10 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
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
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 947ca580bb9a..4198ca66fbe1 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -745,7 +745,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct l2cap_options opts;
-	int len, err = 0;
+	int err = 0;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
@@ -772,11 +772,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		opts.max_tx   = chan->max_tx;
 		opts.txwin_size = chan->tx_win;
 
-		len = min_t(unsigned int, sizeof(opts), optlen);
-		if (copy_from_sockptr(&opts, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opts, sizeof(opts), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opts.txwin_size > L2CAP_DEFAULT_EXT_WINDOW) {
 			err = -EINVAL;
@@ -819,10 +817,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		break;
 
 	case L2CAP_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt & L2CAP_LM_FIPS) {
 			err = -EINVAL;
@@ -903,7 +900,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	struct bt_security sec;
 	struct bt_power pwr;
 	struct l2cap_conn *conn;
-	int len, err = 0;
+	int err = 0;
 	u32 opt;
 	u16 mtu;
 	u8 mode;
@@ -929,11 +926,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		sec.level = BT_SECURITY_LOW;
 
-		len = min_t(unsigned int, sizeof(sec), optlen);
-		if (copy_from_sockptr(&sec, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&sec, sizeof(sec), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (sec.level < BT_SECURITY_LOW ||
 		    sec.level > BT_SECURITY_FIPS) {
@@ -978,10 +973,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt) {
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
@@ -993,10 +987,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_FLUSHABLE:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > BT_FLUSHABLE_ON) {
 			err = -EINVAL;
@@ -1028,11 +1021,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		pwr.force_active = BT_POWER_FORCE_ACTIVE_ON;
 
-		len = min_t(unsigned int, sizeof(pwr), optlen);
-		if (copy_from_sockptr(&pwr, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&pwr, sizeof(pwr), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (pwr.force_active)
 			set_bit(FLAG_FORCE_ACTIVE, &chan->flags);
@@ -1041,10 +1032,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_CHANNEL_POLICY:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > BT_CHANNEL_POLICY_AMP_PREFERRED) {
 			err = -EINVAL;
@@ -1089,10 +1079,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&mtu, optval, sizeof(u16))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&mtu, sizeof(mtu), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (chan->mode == L2CAP_MODE_EXT_FLOWCTL &&
 		    sk->sk_state == BT_CONNECTED)
@@ -1120,10 +1109,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&mode, optval, sizeof(u8))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&mode, sizeof(mode), optval, optlen);
+		if (err)
 			break;
-		}
 
 		BT_DBG("mode %u", mode);
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 6d4168cfeb56..2e9137c539a4 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -831,7 +831,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int err = 0;
 	struct bt_voice voice;
 	u32 opt;
 	struct bt_codecs *codecs;
@@ -850,10 +850,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
@@ -870,11 +869,10 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		voice.setting = sco_pi(sk)->setting;
 
-		len = min_t(unsigned int, sizeof(voice), optlen);
-		if (copy_from_sockptr(&voice, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&voice, sizeof(voice), optval,
+					   optlen);
+		if (err)
 			break;
-		}
 
 		/* Explicitly check for these values */
 		if (voice.setting != BT_VOICE_TRANSPARENT &&
@@ -897,10 +895,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			sco_pi(sk)->cmsg_mask |= SCO_CMSG_PKT_STATUS;
@@ -941,9 +938,9 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(buffer, optval, optlen)) {
+		err = bt_copy_from_sockptr(buffer, optlen, optval, optlen);
+		if (err) {
 			hci_dev_put(hdev);
-			err = -EFAULT;
 			break;
 		}
 
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index b150c9929b12..14365b20f1c5 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -966,6 +966,8 @@ static int do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
@@ -1266,6 +1268,8 @@ static int compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 1f365e28e316..a6208efcfccf 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1120,6 +1120,8 @@ do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
@@ -1506,6 +1508,8 @@ compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 		return -ENOMEM;
 	if (tmp.num_counters == 0)
 		return -EINVAL;
+	if ((u64)len < (u64)tmp.size + sizeof(tmp))
+		return -EINVAL;
 
 	tmp.name[sizeof(tmp.name)-1] = 0;
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 474f391fab35..a0c687ff2598 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -926,13 +926,11 @@ void ip_rt_send_redirect(struct sk_buff *skb)
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
index 1648373692a9..3866deaadbb6 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2050,9 +2050,10 @@ struct inet6_ifaddr *ipv6_get_ifaddr(struct net *net, const struct in6_addr *add
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
index e606374854ce..8213626434b9 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1376,7 +1376,10 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
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
@@ -1400,9 +1403,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 		goto out;
 	}
 
+#ifdef CONFIG_IPV6_SUBTREES
 	pn = fn;
 
-#ifdef CONFIG_IPV6_SUBTREES
 	if (rt->fib6_src.plen) {
 		struct fib6_node *sn;
 
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 37a2b3301e42..b844e519da1b 100644
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
index 0591cfb289d5..e4ba86b84b9b 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1711,8 +1711,9 @@ int ovs_ct_copy_action(struct net *net, const struct nlattr *attr,
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
index e1af94393789..0a75d76535f7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -968,11 +968,11 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
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
@@ -2677,7 +2677,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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
index 5c8e02d56fd4..e3bdfc517424 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1127,6 +1127,8 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
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

