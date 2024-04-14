Return-Path: <linux-kernel+bounces-144065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9378A4168
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C437B2105A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9CA225D4;
	Sun, 14 Apr 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbBiLoIi"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0E1426F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085706; cv=none; b=UJbCbbp6zrE/QtxLb+2XbHS4XTU/0mQVOxYf1qvIfx74ZE+p02D413og0IJRKmrX6faPNMaNK5+yfs9jyphDagS3iDF1igaaKVh/DjBws/XqAawQKnO0N6nNjy5tBaUQy0kqSzY77sJejPTgP9b9MEcftYg+XF1OdnC7QnFDji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085706; c=relaxed/simple;
	bh=F86xHF7sJ2r65XiHyKERLPZ0SoaHJRINYCmexsnIoBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CB0Kd8GVeJCh92gQdIvfcwiOvGYe1acfLEwZxPFjpTGIzkTJz4IBB9lYIQSLm2E4igl05UhNKPQW6rfuF87Ubw/g+l93DuzAFqtUrjL6GghecauFhwIHSTu0UOxissfmBbwVKrkThXsU5sB+Xy9WEIQsdnPiT2cOfA2odRxtwyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbBiLoIi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518e2283bd3so81501e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713085702; x=1713690502; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QpNFj5kzEAqqsORgcCAq7Y9MeTLdhbw1JImLw2VzXFs=;
        b=mbBiLoIile2eExjV9RWLgBjkgvO9Kjmc4UWEvZg7x6Zf54Rb0hemjOpjCioo22pnJu
         56W3d464VdWw61S6somkmbpWx3TrtZ/46PzIGYCCdAbYn6MljCBzcoKNvlBtCXQHUdXO
         3PERopR9p+mL7v5ELTMnuS8imOPTuoemwKFsfoqwOZLaTjQimmKI7nqmOLlbcAWKOQB2
         S6lXrjFkFl2rdSkoNxe8LE/tEkNAxGjEzo+kDo6C3ra3uCSy325KqnZ4TPh3dDCioMHj
         WenqThnSz+KS99GDfSvAWf+TvgEw8qHTjluwi5REKB98+XkP39VquEBiok4sO25bWd8p
         Le7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713085702; x=1713690502;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpNFj5kzEAqqsORgcCAq7Y9MeTLdhbw1JImLw2VzXFs=;
        b=DE4tiNDg2iigEypldkdA6HSMZtwj6MEnrjNk5bgl8tzt9JmYJIO8+vzySJmQc9ViDU
         XcP9qhetWtSfGXRRnwCzW63/xUB7c/N978S2mpzagaIaL+E+fL7U7svFC6VHVVrokCkJ
         XilzLSKvUAsSiF6o9ezuOLONAACFK4PpfOoHtkpxtcF+T1SFQq6Vy17Q9mGMy+RD4W7O
         v9oiwJnpzO8d0fqD+z/EsvjcEgLgLUSzJBmBuaBncCOInlIKHwb9883Tjc6NATYxh4HC
         SRFNZ/UTBj1/Eh+G9pIDH5MR+AAVruv1fsre4KmUAAjL8gNVsDMoP/Kq83eenmbWi5Ex
         WoIA==
X-Gm-Message-State: AOJu0Yxvc6+d/Uqc+VCGP4QNesQNLor4c/Sd7cch1oIcG3DpkS0jCS+l
	XM4FiqsFd1bTPomy5VHXdlp2n1XZZtQ6JTcqCIYEVLA3sd4SkbX8
X-Google-Smtp-Source: AGHT+IFyobbpc33lqflQCnaBqKGVqNIDu5ghkx8KyLTOvS+tHNmCGdwIzB2v6rQQo6aMWuI80b0byw==
X-Received: by 2002:a19:2d19:0:b0:516:d33c:b3f3 with SMTP id k25-20020a192d19000000b00516d33cb3f3mr4904886lfj.4.1713085701641;
        Sun, 14 Apr 2024 02:08:21 -0700 (PDT)
Received: from gmail.com (2A00111001332BCD9129005EE765889E.mobile.pool.telekom.hu. [2a00:1110:133:2bcd:9129:5e:e765:889e])
        by smtp.gmail.com with ESMTPSA id dc11-20020a170906c7cb00b00a5195edf8e8sm3968163ejb.62.2024.04.14.02.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 02:08:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 14 Apr 2024 11:08:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZhudAcrqVdnwUjKN@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-04-14

   # HEAD: 7211274fe0ee352332255e41ab5e628b86e83994 x86/cpu/amd: Move TOPOEXT enablement into the topology parser

Misc x86 fixes:

 - Follow up fixes for the BHI mitigations code.

 - Fix !SPECULATION_MITIGATIONS bug not turning off
   mitigations as expected.

 - Work around an APIC emulation bug when the kernel is built with
   Clang and run as a SEV guest.

 - Follow up x86 topology fixes.

Note that there's minor cleanups included in the BHI fixes,
which we'd normally delay to the next merge window, but the
BHI mitigations code is new and will be backported widely,
so we thought it would be better to have a unified codebase
at this stage. (Let me know if that assumption is wrong and
I'll rebase it.)

Thanks,

	Ingo

------------------>
Adam Dunlap (1):
      x86/apic: Force native_apic_mem_read() to use the MOV instruction

Daniel Sneddon (1):
      x86/bugs: Fix return type of spectre_bhi_state()

Ingo Molnar (1):
      x86/bugs: Rename various 'ia32_cap' variables to 'x86_arch_cap_msr'

Josh Poimboeuf (6):
      x86/bugs: Fix BHI documentation
      x86/bugs: Cache the value of MSR_IA32_ARCH_CAPABILITIES
      x86/bugs: Fix BHI handling of RRSBA
      x86/bugs: Clarify that syscall hardening isn't a BHI mitigation
      x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto
      x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with CONFIG_MITIGATION_SPECTRE_BHI

Sean Christopherson (1):
      x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n

Thomas Gleixner (4):
      x86/topology: Don't update cpu_possible_map in topo_set_cpuids()
      x86/cpu/amd: Make the CPUID 0x80000008 parser correct
      x86/cpu/amd: Make the NODEID_MSR union actually work
      x86/cpu/amd: Move TOPOEXT enablement into the topology parser


 Documentation/admin-guide/hw-vuln/spectre.rst   | 22 +++----
 Documentation/admin-guide/kernel-parameters.txt | 12 ++--
 arch/x86/Kconfig                                | 22 +------
 arch/x86/include/asm/apic.h                     |  3 +-
 arch/x86/kernel/apic/apic.c                     |  6 +-
 arch/x86/kernel/cpu/amd.c                       | 15 -----
 arch/x86/kernel/cpu/bugs.c                      | 82 +++++++++++--------------
 arch/x86/kernel/cpu/common.c                    | 48 +++++++--------
 arch/x86/kernel/cpu/topology.c                  |  7 ++-
 arch/x86/kernel/cpu/topology_amd.c              | 51 ++++++++++++---
 kernel/cpu.c                                    |  3 +-
 11 files changed, 131 insertions(+), 140 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index b70b1d8bd8e6..25a04cda4c2c 100644
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
index 70046a019d42..902ecd92a29f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3444,6 +3444,7 @@
 					       retbleed=off [X86]
 					       spec_rstack_overflow=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
+					       spectre_bhi=off [X86]
 					       spectre_v2_user=off [X86]
 					       srbds=off [X86,INTEL]
 					       ssbd=force-off [ARM64]
@@ -6064,16 +6065,13 @@
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
 
 	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 10a6251f58f3..4474bf32d0a4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2633,32 +2633,16 @@ config MITIGATION_RFDS
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
-	depends on BROKEN
-	help
-	  Equivalent to setting spectre_bhi=auto command line parameter.
-
-endchoice
-
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 94ce0f7c9d3a..e6ab0cf15ed5 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -13,6 +13,7 @@
 #include <asm/mpspec.h>
 #include <asm/msr.h>
 #include <asm/hardirq.h>
+#include <asm/io.h>
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
@@ -98,7 +99,7 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 
 static inline u32 native_apic_mem_read(u32 reg)
 {
-	return *((volatile u32 *)(APIC_BASE + reg));
+	return readl((void __iomem *)(APIC_BASE + reg));
 }
 
 static inline void native_apic_mem_eoi(void)
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index a42d8a6f7149..c342c4aa9c68 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1687,11 +1687,11 @@ static int x2apic_state;
 
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
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 9bf17c9c29da..cb9eece55904 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -535,7 +535,6 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 
 static void early_init_amd(struct cpuinfo_x86 *c)
 {
-	u64 value;
 	u32 dummy;
 
 	if (c->x86 >= 0xf)
@@ -603,20 +602,6 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 
 	early_detect_mem_encrypt(c);
 
-	/* Re-enable TopologyExtensions if switched off by BIOS */
-	if (c->x86 == 0x15 &&
-	    (c->x86_model >= 0x10 && c->x86_model <= 0x6f) &&
-	    !cpu_has(c, X86_FEATURE_TOPOEXT)) {
-
-		if (msr_set_bit(0xc0011005, 54) > 0) {
-			rdmsrl(0xc0011005, value);
-			if (value & BIT_64(54)) {
-				set_cpu_cap(c, X86_FEATURE_TOPOEXT);
-				pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Support.\n");
-			}
-		}
-	}
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
 		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 295463707e68..ca295b0c1eee 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -61,6 +61,8 @@ EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
+static u64 __ro_after_init x86_arch_cap_msr;
+
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
 void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
@@ -144,6 +146,8 @@ void __init cpu_select_mitigations(void)
 		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
 	}
 
+	x86_arch_cap_msr = x86_read_arch_cap_msr();
+
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
@@ -301,8 +305,6 @@ static const char * const taa_strings[] = {
 
 static void __init taa_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_TAA)) {
 		taa_mitigation = TAA_MITIGATION_OFF;
 		return;
@@ -341,9 +343,8 @@ static void __init taa_select_mitigation(void)
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
@@ -401,8 +402,6 @@ static const char * const mmio_strings[] = {
 
 static void __init mmio_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
 	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
 	     cpu_mitigations_off()) {
@@ -413,8 +412,6 @@ static void __init mmio_select_mitigation(void)
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
-	ia32_cap = x86_read_arch_cap_msr();
-
 	/*
 	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
 	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
@@ -437,7 +434,7 @@ static void __init mmio_select_mitigation(void)
 	 * be propagated to uncore buffers, clearing the Fill buffers on idle
 	 * is required irrespective of SMT state.
 	 */
-	if (!(ia32_cap & ARCH_CAP_FBSDP_NO))
+	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
 	/*
@@ -447,10 +444,10 @@ static void __init mmio_select_mitigation(void)
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
@@ -508,7 +505,7 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
-	if (x86_read_arch_cap_msr() & ARCH_CAP_RFDS_CLEAR)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
@@ -659,8 +656,6 @@ void update_srbds_msr(void)
 
 static void __init srbds_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
 		return;
 
@@ -669,8 +664,7 @@ static void __init srbds_select_mitigation(void)
 	 * are only exposed to SRBDS when TSX is enabled or when CPU is affected
 	 * by Processor MMIO Stale Data vulnerability.
 	 */
-	ia32_cap = x86_read_arch_cap_msr();
-	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
+	if ((x86_arch_cap_msr & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
 	    !boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;
 	else if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
@@ -813,7 +807,7 @@ static void __init gds_select_mitigation(void)
 	/* Will verify below that mitigation _can_ be disabled */
 
 	/* No microcode */
-	if (!(x86_read_arch_cap_msr() & ARCH_CAP_GDS_CTRL)) {
+	if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)) {
 		if (gds_mitigation == GDS_MITIGATION_FORCE) {
 			/*
 			 * This only needs to be done on the boot CPU so do it
@@ -1544,20 +1538,25 @@ static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
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
+
+	if (!(x86_arch_cap_msr & ARCH_CAP_RRSBA)) {
+		rrsba_disabled = true;
+		return;
+	}
 
 	if (!boot_cpu_has(X86_FEATURE_RRSBA_CTRL))
 		return;
 
-	ia32_cap = x86_read_arch_cap_msr();
-
-	if (ia32_cap & ARCH_CAP_RRSBA) {
-		x86_spec_ctrl_base |= SPEC_CTRL_RRSBA_DIS_S;
-		update_spec_ctrl(x86_spec_ctrl_base);
-	}
+	x86_spec_ctrl_base |= SPEC_CTRL_RRSBA_DIS_S;
+	update_spec_ctrl(x86_spec_ctrl_base);
+	rrsba_disabled = true;
 }
 
 static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_mitigation mode)
@@ -1626,13 +1625,10 @@ static bool __init spec_ctrl_bhi_dis(void)
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
@@ -1643,8 +1639,6 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 		bhi_mitigation = BHI_MITIGATION_OFF;
 	else if (!strcmp(str, "on"))
 		bhi_mitigation = BHI_MITIGATION_ON;
-	else if (!strcmp(str, "auto"))
-		bhi_mitigation = BHI_MITIGATION_AUTO;
 	else
 		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
 
@@ -1658,9 +1652,11 @@ static void __init bhi_select_mitigation(void)
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
@@ -1672,9 +1668,6 @@ static void __init bhi_select_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
 
-	if (bhi_mitigation == BHI_MITIGATION_AUTO)
-		return;
-
 	/* Mitigate syscalls when the mitigation is forced =on */
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
@@ -1908,8 +1901,6 @@ static void update_indir_branch_cond(void)
 /* Update the static key controlling the MDS CPU buffer clear in idle */
 static void update_mds_branch_idle(void)
 {
-	u64 ia32_cap = x86_read_arch_cap_msr();
-
 	/*
 	 * Enable the idle clearing if SMT is active on CPUs which are
 	 * affected only by MSBDS and not any other MDS variant.
@@ -1924,7 +1915,7 @@ static void update_mds_branch_idle(void)
 	if (sched_smt_active()) {
 		static_branch_enable(&mds_idle_clear);
 	} else if (mmio_mitigation == MMIO_MITIGATION_OFF ||
-		   (ia32_cap & ARCH_CAP_FBSDP_NO)) {
+		   (x86_arch_cap_msr & ARCH_CAP_FBSDP_NO)) {
 		static_branch_disable(&mds_idle_clear);
 	}
 }
@@ -2809,7 +2800,7 @@ static char *pbrsb_eibrs_state(void)
 	}
 }
 
-static const char * const spectre_bhi_state(void)
+static const char *spectre_bhi_state(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_BHI))
 		return "; BHI: Not affected";
@@ -2817,13 +2808,12 @@ static const char * const spectre_bhi_state(void)
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
index 754d91857d63..605c26c009c8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1284,25 +1284,25 @@ static bool __init cpu_matches(const struct x86_cpu_id *table, unsigned long whi
 
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
@@ -1310,7 +1310,7 @@ static bool __init vulnerable_to_rfds(u64 ia32_cap)
 	 * indicate that mitigation is needed because guest is running on a
 	 * vulnerable hardware or may migrate to such hardware:
 	 */
-	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		return true;
 
 	/* Only consult the blacklist when there is no enumeration: */
@@ -1319,11 +1319,11 @@ static bool __init vulnerable_to_rfds(u64 ia32_cap)
 
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
@@ -1335,7 +1335,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_SSB) &&
-	    !(ia32_cap & ARCH_CAP_SSB_NO) &&
+	    !(x86_arch_cap_msr & ARCH_CAP_SSB_NO) &&
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
@@ -1346,17 +1346,17 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * Don't use AutoIBRS when SNP is enabled because it degrades host
 	 * userspace indirect branch performance.
 	 */
-	if ((ia32_cap & ARCH_CAP_IBRS_ALL) ||
+	if ((x86_arch_cap_msr & ARCH_CAP_IBRS_ALL) ||
 	    (cpu_has(c, X86_FEATURE_AUTOIBRS) &&
 	     !cpu_feature_enabled(X86_FEATURE_SEV_SNP))) {
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
@@ -1375,9 +1375,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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
@@ -1403,7 +1403,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * Set X86_BUG_MMIO_UNKNOWN for CPUs that are neither in the blacklist,
 	 * nor in the whitelist and also don't enumerate MSR ARCH_CAP MMIO bits.
 	 */
-	if (!arch_cap_mmio_immune(ia32_cap)) {
+	if (!arch_cap_mmio_immune(x86_arch_cap_msr)) {
 		if (cpu_matches(cpu_vuln_blacklist, MMIO))
 			setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
 		else if (!cpu_matches(cpu_vuln_whitelist, NO_MMIO))
@@ -1411,7 +1411,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	}
 
 	if (!cpu_has(c, X86_FEATURE_BTC_NO)) {
-		if (cpu_matches(cpu_vuln_blacklist, RETBLEED) || (ia32_cap & ARCH_CAP_RSBA))
+		if (cpu_matches(cpu_vuln_blacklist, RETBLEED) || (x86_arch_cap_msr & ARCH_CAP_RSBA))
 			setup_force_cpu_bug(X86_BUG_RETBLEED);
 	}
 
@@ -1429,15 +1429,15 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * disabling AVX2. The only way to do this in HW is to clear XCR0[2],
 	 * which means that AVX will be disabled.
 	 */
-	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(ia32_cap & ARCH_CAP_GDS_NO) &&
+	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(x86_arch_cap_msr & ARCH_CAP_GDS_NO) &&
 	    boot_cpu_has(X86_FEATURE_AVX))
 		setup_force_cpu_bug(X86_BUG_GDS);
 
-	if (vulnerable_to_rfds(ia32_cap))
+	if (vulnerable_to_rfds(x86_arch_cap_msr))
 		setup_force_cpu_bug(X86_BUG_RFDS);
 
 	/* When virtualized, eIBRS could be hidden, assume vulnerable */
-	if (!(ia32_cap & ARCH_CAP_BHI_NO) &&
+	if (!(x86_arch_cap_msr & ARCH_CAP_BHI_NO) &&
 	    !cpu_matches(cpu_vuln_whitelist, NO_BHI) &&
 	    (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) ||
 	     boot_cpu_has(X86_FEATURE_HYPERVISOR)))
@@ -1447,7 +1447,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 		return;
 
 	/* Rogue Data Cache Load? No! */
-	if (ia32_cap & ARCH_CAP_RDCL_NO)
+	if (x86_arch_cap_msr & ARCH_CAP_RDCL_NO)
 		return;
 
 	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index aaca8d235dc2..d17c9b71eb4a 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -123,7 +123,6 @@ static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
 	early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
 #endif
-	set_cpu_possible(cpu, true);
 	set_cpu_present(cpu, true);
 }
 
@@ -210,7 +209,11 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 		topo_info.nr_disabled_cpus++;
 	}
 
-	/* Register present and possible CPUs in the domain maps */
+	/*
+	 * Register present and possible CPUs in the domain
+	 * maps. cpu_possible_map will be updated in
+	 * topology_init_possible_cpus() after enumeration is done.
+	 */
 	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++)
 		set_bit(topo_apicid(apic_id, dom), apic_maps[dom].map);
 }
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 1a8b3ad493af..a7aa6eff4ae5 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -29,11 +29,21 @@ static bool parse_8000_0008(struct topo_scan *tscan)
 	if (!sft)
 		sft = get_count_order(ecx.cpu_nthreads + 1);
 
-	topology_set_dom(tscan, TOPO_SMT_DOMAIN, sft, ecx.cpu_nthreads + 1);
+	/*
+	 * cpu_nthreads describes the number of threads in the package
+	 * sft is the number of APIC ID bits per package
+	 *
+	 * As the number of actual threads per core is not described in
+	 * this leaf, just set the CORE domain shift and let the later
+	 * parsers set SMT shift. Assume one thread per core by default
+	 * which is correct if there are no other CPUID leafs to parse.
+	 */
+	topology_update_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, sft, ecx.cpu_nthreads + 1);
 	return true;
 }
 
-static void store_node(struct topo_scan *tscan, unsigned int nr_nodes, u16 node_id)
+static void store_node(struct topo_scan *tscan, u16 nr_nodes, u16 node_id)
 {
 	/*
 	 * Starting with Fam 17h the DIE domain could probably be used to
@@ -73,12 +83,14 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
 	tscan->c->topo.initial_apicid = leaf.ext_apic_id;
 
 	/*
-	 * If leaf 0xb is available, then SMT shift is set already. If not
-	 * take it from ecx.threads_per_core and use topo_update_dom() -
-	 * topology_set_dom() would propagate and overwrite the already
-	 * propagated CORE level.
+	 * If leaf 0xb is available, then the domain shifts are set
+	 * already and nothing to do here.
 	 */
 	if (!has_0xb) {
+		/*
+		 * Leaf 0x80000008 set the CORE domain shift already.
+		 * Update the SMT domain, but do not propagate it.
+		 */
 		unsigned int nthreads = leaf.core_nthreads + 1;
 
 		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
@@ -109,13 +121,13 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
 
 static bool parse_fam10h_node_id(struct topo_scan *tscan)
 {
-	struct {
-		union {
+	union {
+		struct {
 			u64	node_id		:  3,
 				nodes_per_pkg	:  3,
 				unused		: 58;
-			u64	msr;
 		};
+		u64		msr;
 	} nid;
 
 	if (!boot_cpu_has(X86_FEATURE_NODEID_MSR))
@@ -135,6 +147,26 @@ static void legacy_set_llc(struct topo_scan *tscan)
 	tscan->c->topo.llc_id = apicid >> tscan->dom_shifts[TOPO_CORE_DOMAIN];
 }
 
+static void topoext_fixup(struct topo_scan *tscan)
+{
+	struct cpuinfo_x86 *c = tscan->c;
+	u64 msrval;
+
+	/* Try to re-enable TopologyExtensions if switched off by BIOS */
+	if (cpu_has(c, X86_FEATURE_TOPOEXT) || c->x86_vendor != X86_VENDOR_AMD ||
+	    c->x86 != 0x15 || c->x86_model < 0x10 || c->x86_model > 0x6f)
+		return;
+
+	if (msr_set_bit(0xc0011005, 54) <= 0)
+		return;
+
+	rdmsrl(0xc0011005, msrval);
+	if (msrval & BIT_64(54)) {
+		set_cpu_cap(c, X86_FEATURE_TOPOEXT);
+		pr_info_once(FW_INFO "CPU: Re-enabling disabled Topology Extensions Support.\n");
+	}
+}
+
 static void parse_topology_amd(struct topo_scan *tscan)
 {
 	bool has_0xb = false;
@@ -164,6 +196,7 @@ static void parse_topology_amd(struct topo_scan *tscan)
 void cpu_parse_topology_amd(struct topo_scan *tscan)
 {
 	tscan->amd_nodes_per_pkg = 1;
+	topoext_fixup(tscan);
 	parse_topology_amd(tscan);
 
 	if (tscan->amd_nodes_per_pkg > 1)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8f6affd051f7..07ad53b7f119 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3207,7 +3207,8 @@ enum cpu_mitigations {
 };
 
 static enum cpu_mitigations cpu_mitigations __ro_after_init =
-	CPU_MITIGATIONS_AUTO;
+	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
+						     CPU_MITIGATIONS_OFF;
 
 static int __init mitigations_parse_cmdline(char *arg)
 {

