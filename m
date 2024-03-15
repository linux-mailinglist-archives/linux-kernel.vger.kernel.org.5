Return-Path: <linux-kernel+bounces-104819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C667B87D428
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54308282B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C04F52F6F;
	Fri, 15 Mar 2024 18:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlVJoYRv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1052F8A;
	Fri, 15 Mar 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528792; cv=none; b=jY/LOAlqx6QApQjAecLAErsU/oeUf+7hz2oWbU5TxWNtwdSAF7M3MJTA9NPMd1KMFXWL9FOhDFUu/F0X09hg5otVRTpnBqqn/cWc5ISIST/uaDxL+K8QvPUuzjLm7UrxKtPqxtKcSGIn6seuX8LlyvTHxb/vCbKqVT9ZeaySK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528792; c=relaxed/simple;
	bh=mD74iYMyguvDrBh3G3Px/m2qwFqdCj7dkqXDbQ//R84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N44Uj/0IAoLE7gjo0o+/9pLEGT6xdE7WACLQrTlX2E0bL8LOrUy9zBHcxwJ3NF1OkAKVyjoWKEhuz+mHWlSCPopFGBOqNL28hhvG5AfSFe1wnQYB8F+Zwk793veETDhSms3uYkvAMAXvDjHFf9qmOGfDWxDGAalUAGUQSy3KieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlVJoYRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8599FC433C7;
	Fri, 15 Mar 2024 18:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710528791;
	bh=mD74iYMyguvDrBh3G3Px/m2qwFqdCj7dkqXDbQ//R84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlVJoYRvRZtPe56SW3YV5ezz+VTolr6VsWP55IJ+gC9aK1VMjqcQ8r53LoHktsaQT
	 oxb5waTVjCOstDrSA6TBrl+1Wa1s2eTupgD9hkR5Lfr5kWCAFqopSl/PZ/p/nDEHNp
	 VUHF/rn9GHsIEanYq4uYHoa6hqe6fDH94ZdTt89rUpYm0EpQB1CdQWZtJiZL61e2To
	 8CzPcezvClXySXeFKkuiQ6ghrK2WlN8fpGWjKerHGOvGVmMKIXLtNzqkankl/f7gij
	 w21y2p+BST7irR69cVFI6ImCvz86XI+F8xQGM+iAcuZumBLB5082dWGJJL2OUpyYby
	 SQ6cqFjkNT+jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 6.7.10
Date: Fri, 15 Mar 2024 14:53:07 -0400
Message-ID: <20240315185307.1841671-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315185307.1841671-1-sashal@kernel.org>
References: <20240315185307.1841671-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index a1db6db475055..710d47be11e04 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -516,6 +516,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/mds
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
 		/sys/devices/system/cpu/vulnerabilities/retbleed
 		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index de99caabf65a3..ff0b440ef2dc9 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -21,3 +21,4 @@ are configurable at compile, boot or run time.
    cross-thread-rsb
    srso
    gather_data_sampling
+   reg-file-data-sampling
diff --git a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
new file mode 100644
index 0000000000000..0585d02b9a6cb
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
@@ -0,0 +1,104 @@
+==================================
+Register File Data Sampling (RFDS)
+==================================
+
+Register File Data Sampling (RFDS) is a microarchitectural vulnerability that
+only affects Intel Atom parts(also branded as E-cores). RFDS may allow
+a malicious actor to infer data values previously used in floating point
+registers, vector registers, or integer registers. RFDS does not provide the
+ability to choose which data is inferred. CVE-2023-28746 is assigned to RFDS.
+
+Affected Processors
+===================
+Below is the list of affected Intel processors [#f1]_:
+
+   ===================  ============
+   Common name          Family_Model
+   ===================  ============
+   ATOM_GOLDMONT           06_5CH
+   ATOM_GOLDMONT_D         06_5FH
+   ATOM_GOLDMONT_PLUS      06_7AH
+   ATOM_TREMONT_D          06_86H
+   ATOM_TREMONT            06_96H
+   ALDERLAKE               06_97H
+   ALDERLAKE_L             06_9AH
+   ATOM_TREMONT_L          06_9CH
+   RAPTORLAKE              06_B7H
+   RAPTORLAKE_P            06_BAH
+   ATOM_GRACEMONT          06_BEH
+   RAPTORLAKE_S            06_BFH
+   ===================  ============
+
+As an exception to this table, Intel Xeon E family parts ALDERLAKE(06_97H) and
+RAPTORLAKE(06_B7H) codenamed Catlow are not affected. They are reported as
+vulnerable in Linux because they share the same family/model with an affected
+part. Unlike their affected counterparts, they do not enumerate RFDS_CLEAR or
+CPUID.HYBRID. This information could be used to distinguish between the
+affected and unaffected parts, but it is deemed not worth adding complexity as
+the reporting is fixed automatically when these parts enumerate RFDS_NO.
+
+Mitigation
+==========
+Intel released a microcode update that enables software to clear sensitive
+information using the VERW instruction. Like MDS, RFDS deploys the same
+mitigation strategy to force the CPU to clear the affected buffers before an
+attacker can extract the secrets. This is achieved by using the otherwise
+unused and obsolete VERW instruction in combination with a microcode update.
+The microcode clears the affected CPU buffers when the VERW instruction is
+executed.
+
+Mitigation points
+-----------------
+VERW is executed by the kernel before returning to user space, and by KVM
+before VMentry. None of the affected cores support SMT, so VERW is not required
+at C-state transitions.
+
+New bits in IA32_ARCH_CAPABILITIES
+----------------------------------
+Newer processors and microcode update on existing affected processors added new
+bits to IA32_ARCH_CAPABILITIES MSR. These bits can be used to enumerate
+vulnerability and mitigation capability:
+
+- Bit 27 - RFDS_NO - When set, processor is not affected by RFDS.
+- Bit 28 - RFDS_CLEAR - When set, processor is affected by RFDS, and has the
+  microcode that clears the affected buffers on VERW execution.
+
+Mitigation control on the kernel command line
+---------------------------------------------
+The kernel command line allows to control RFDS mitigation at boot time with the
+parameter "reg_file_data_sampling=". The valid arguments are:
+
+  ==========  =================================================================
+  on          If the CPU is vulnerable, enable mitigation; CPU buffer clearing
+              on exit to userspace and before entering a VM.
+  off         Disables mitigation.
+  ==========  =================================================================
+
+Mitigation default is selected by CONFIG_MITIGATION_RFDS.
+
+Mitigation status information
+-----------------------------
+The Linux kernel provides a sysfs interface to enumerate the current
+vulnerability status of the system: whether the system is vulnerable, and
+which mitigations are active. The relevant sysfs file is:
+
+	/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
+
+The possible values in this file are:
+
+  .. list-table::
+
+     * - 'Not affected'
+       - The processor is not vulnerable
+     * - 'Vulnerable'
+       - The processor is vulnerable, but no mitigation enabled
+     * - 'Vulnerable: No microcode'
+       - The processor is vulnerable but microcode is not updated.
+     * - 'Mitigation: Clear Register File'
+       - The processor is vulnerable and the CPU buffer clearing mitigation is
+	 enabled.
+
+References
+----------
+.. [#f1] Affected Processors
+   https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b72e2049c4876..40b89dd7c0bb3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1137,6 +1137,26 @@
 			The filter can be disabled or changed to another
 			driver later using sysfs.
 
+	reg_file_data_sampling=
+			[X86] Controls mitigation for Register File Data
+			Sampling (RFDS) vulnerability. RFDS is a CPU
+			vulnerability which may allow userspace to infer
+			kernel data values previously stored in floating point
+			registers, vector registers, or integer registers.
+			RFDS only affects Intel Atom processors.
+
+			on:	Turns ON the mitigation.
+			off:	Turns OFF the mitigation.
+
+			This parameter overrides the compile time default set
+			by CONFIG_MITIGATION_RFDS. Mitigation cannot be
+			disabled when other VERW based mitigations (like MDS)
+			are enabled. In order to disable RFDS mitigation all
+			VERW based mitigations need to be disabled.
+
+			For details see:
+			Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
+
 	driver_async_probe=  [KNL]
 			List of driver names to be probed asynchronously. *
 			matches with all driver names. If * is specified, the
@@ -3385,6 +3405,7 @@
 					       nospectre_bhb [ARM64]
 					       nospectre_v1 [X86,PPC]
 					       nospectre_v2 [X86,PPC,S390,ARM64]
+					       reg_file_data_sampling=off [X86]
 					       retbleed=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
 					       spectre_v2_user=off [X86]
diff --git a/Makefile b/Makefile
index f1a592b7c7bc8..00c159535dabe 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 7
-SUBLEVEL = 9
+SUBLEVEL = 10
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f8567e95f98be..8f47d6762ea4b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -35,6 +35,7 @@ config ARM
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
+	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index fef62e4a9edde..07565b593ed68 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -278,6 +278,37 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
+	if (!(flags & FAULT_FLAG_USER))
+		goto lock_mmap;
+
+	vma = lock_vma_under_rcu(mm, addr);
+	if (!vma)
+		goto lock_mmap;
+
+	if (!(vma->vm_flags & vm_flags)) {
+		vma_end_read(vma);
+		goto lock_mmap;
+	}
+	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
+	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
+		vma_end_read(vma);
+
+	if (!(fault & VM_FAULT_RETRY)) {
+		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
+		goto done;
+	}
+	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
+
+	/* Quick path to respond to signals */
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			goto no_context;
+		return 0;
+	}
+lock_mmap:
+
 retry:
 	vma = lock_mm_and_find_vma(mm, addr, regs);
 	if (unlikely(!vma)) {
@@ -316,6 +347,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	}
 
 	mmap_read_unlock(mm);
+done:
 
 	/*
 	 * Handle the "normal" case first - VM_FAULT_MAJOR
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1566748f16c42..d2003865b7cf6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2609,6 +2609,17 @@ config GDS_FORCE_MITIGATION
 
 	  If in doubt, say N.
 
+config MITIGATION_RFDS
+	bool "RFDS Mitigation"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Register File Data Sampling (RFDS) by default.
+	  RFDS is a hardware vulnerability which affects Intel Atom CPUs. It
+	  allows unprivileged speculative access to stale data previously
+	  stored in floating point, vector and integer registers.
+	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index caf4cf2e1036f..0e4f2da9f618a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -499,4 +499,5 @@
 /* BUG word 2 */
 #define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d51e1850ed03..857839df66dfb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -165,6 +165,14 @@
 						 * CPU is not vulnerable to Gather
 						 * Data Sampling (GDS).
 						 */
+#define ARCH_CAP_RFDS_NO		BIT(27)	/*
+						 * Not susceptible to Register
+						 * File Data Sampling.
+						 */
+#define ARCH_CAP_RFDS_CLEAR		BIT(28)	/*
+						 * VERW clears CPU Register
+						 * File.
+						 */
 
 #define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
 						 * IA32_XAPIC_DISABLE_STATUS MSR
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 48d049cd74e71..01ac18f56147f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -422,6 +422,13 @@ static void __init mmio_select_mitigation(void)
 	if (boot_cpu_has_bug(X86_BUG_MDS) || (boot_cpu_has_bug(X86_BUG_TAA) &&
 					      boot_cpu_has(X86_FEATURE_RTM)))
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+
+	/*
+	 * X86_FEATURE_CLEAR_CPU_BUF could be enabled by other VERW based
+	 * mitigations, disable KVM-only mitigation in that case.
+	 */
+	if (boot_cpu_has(X86_FEATURE_CLEAR_CPU_BUF))
+		static_branch_disable(&mmio_stale_data_clear);
 	else
 		static_branch_enable(&mmio_stale_data_clear);
 
@@ -473,6 +480,57 @@ static int __init mmio_stale_data_parse_cmdline(char *str)
 }
 early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"Register File Data Sampling: " fmt
+
+enum rfds_mitigations {
+	RFDS_MITIGATION_OFF,
+	RFDS_MITIGATION_VERW,
+	RFDS_MITIGATION_UCODE_NEEDED,
+};
+
+/* Default mitigation for Register File Data Sampling */
+static enum rfds_mitigations rfds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
+
+static const char * const rfds_strings[] = {
+	[RFDS_MITIGATION_OFF]			= "Vulnerable",
+	[RFDS_MITIGATION_VERW]			= "Mitigation: Clear Register File",
+	[RFDS_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
+};
+
+static void __init rfds_select_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+		return;
+	}
+	if (rfds_mitigation == RFDS_MITIGATION_OFF)
+		return;
+
+	if (x86_read_arch_cap_msr() & ARCH_CAP_RFDS_CLEAR)
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	else
+		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
+}
+
+static __init int rfds_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		return 0;
+
+	if (!strcmp(str, "off"))
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+	else if (!strcmp(str, "on"))
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
+	return 0;
+}
+early_param("reg_file_data_sampling", rfds_parse_cmdline);
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "" fmt
 
@@ -498,11 +556,19 @@ static void __init md_clear_update_mitigation(void)
 		taa_mitigation = TAA_MITIGATION_VERW;
 		taa_select_mitigation();
 	}
-	if (mmio_mitigation == MMIO_MITIGATION_OFF &&
-	    boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
+	/*
+	 * MMIO_MITIGATION_OFF is not checked here so that mmio_stale_data_clear
+	 * gets updated correctly as per X86_FEATURE_CLEAR_CPU_BUF state.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA)) {
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 		mmio_select_mitigation();
 	}
+	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
+	    boot_cpu_has_bug(X86_BUG_RFDS)) {
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+		rfds_select_mitigation();
+	}
 out:
 	if (boot_cpu_has_bug(X86_BUG_MDS))
 		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
@@ -512,6 +578,8 @@ static void __init md_clear_update_mitigation(void)
 		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
 	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
 		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
+	if (boot_cpu_has_bug(X86_BUG_RFDS))
+		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
 }
 
 static void __init md_clear_select_mitigation(void)
@@ -519,11 +587,12 @@ static void __init md_clear_select_mitigation(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
+	rfds_select_mitigation();
 
 	/*
-	 * As MDS, TAA and MMIO Stale Data mitigations are inter-related, update
-	 * and print their mitigation after MDS, TAA and MMIO Stale Data
-	 * mitigation selection is done.
+	 * As these mitigations are inter-related and rely on VERW instruction
+	 * to clear the microarchitural buffers, update and print their status
+	 * after mitigation selection is done for each of these vulnerabilities.
 	 */
 	md_clear_update_mitigation();
 }
@@ -2612,6 +2681,11 @@ static ssize_t mmio_stale_data_show_state(char *buf)
 			  sched_smt_active() ? "vulnerable" : "disabled");
 }
 
+static ssize_t rfds_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", rfds_strings[rfds_mitigation]);
+}
+
 static char *stibp_state(void)
 {
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
@@ -2771,6 +2845,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_GDS:
 		return gds_show_state(buf);
 
+	case X86_BUG_RFDS:
+		return rfds_show_state(buf);
+
 	default:
 		break;
 	}
@@ -2845,4 +2922,9 @@ ssize_t cpu_show_gds(struct device *dev, struct device_attribute *attr, char *bu
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_GDS);
 }
+
+ssize_t cpu_show_reg_file_data_sampling(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
+}
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 34cac9ea19171..97ea52a4e8a39 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1274,6 +1274,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define SRSO		BIT(5)
 /* CPU is affected by GDS */
 #define GDS		BIT(6)
+/* CPU is affected by Register File Data Sampling */
+#define RFDS		BIT(7)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1301,9 +1303,18 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS),
 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_P,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_S,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GRACEMONT,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT_D,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT_PLUS, X86_STEPPING_ANY,		RFDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
@@ -1337,6 +1348,24 @@ static bool arch_cap_mmio_immune(u64 ia32_cap)
 		ia32_cap & ARCH_CAP_SBDR_SSDP_NO);
 }
 
+static bool __init vulnerable_to_rfds(u64 ia32_cap)
+{
+	/* The "immunity" bit trumps everything else: */
+	if (ia32_cap & ARCH_CAP_RFDS_NO)
+		return false;
+
+	/*
+	 * VMMs set ARCH_CAP_RFDS_CLEAR for processors not in the blacklist to
+	 * indicate that mitigation is needed because guest is running on a
+	 * vulnerable hardware or may migrate to such hardware:
+	 */
+	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+		return true;
+
+	/* Only consult the blacklist when there is no enumeration: */
+	return cpu_matches(cpu_vuln_blacklist, RFDS);
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = x86_read_arch_cap_msr();
@@ -1448,6 +1477,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	    boot_cpu_has(X86_FEATURE_AVX))
 		setup_force_cpu_bug(X86_BUG_GDS);
 
+	if (vulnerable_to_rfds(ia32_cap))
+		setup_force_cpu_bug(X86_BUG_RFDS);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 468870450b8ba..8021c62b0e7b0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1620,7 +1620,8 @@ static bool kvm_is_immutable_feature_msr(u32 msr)
 	 ARCH_CAP_SKIP_VMENTRY_L1DFLUSH | ARCH_CAP_SSB_NO | ARCH_CAP_MDS_NO | \
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
-	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO)
+	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1652,6 +1653,8 @@ static u64 kvm_get_arch_capabilities(void)
 		data |= ARCH_CAP_SSB_NO;
 	if (!boot_cpu_has_bug(X86_BUG_MDS))
 		data |= ARCH_CAP_MDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		data |= ARCH_CAP_RFDS_NO;
 
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		/*
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 548491de818ef..ef427ee787a99 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -565,6 +565,7 @@ CPU_SHOW_VULN_FALLBACK(mmio_stale_data);
 CPU_SHOW_VULN_FALLBACK(retbleed);
 CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
 CPU_SHOW_VULN_FALLBACK(gds);
+CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -579,6 +580,7 @@ static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
+static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -594,6 +596,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_retbleed.attr,
 	&dev_attr_spec_rstack_overflow.attr,
 	&dev_attr_gather_data_sampling.attr,
+	&dev_attr_reg_file_data_sampling.attr,
 	NULL
 };
 
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index bb5221158a770..f5e216b157c75 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -30,8 +30,9 @@
 #define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
 #define EDMA_TCD_ATTR_SMOD(x)		(((x) & GENMASK(4, 0)) << 11)
 
-#define EDMA_TCD_CITER_CITER(x)		((x) & GENMASK(14, 0))
-#define EDMA_TCD_BITER_BITER(x)		((x) & GENMASK(14, 0))
+#define EDMA_TCD_ITER_MASK		GENMASK(14, 0)
+#define EDMA_TCD_CITER_CITER(x)		((x) & EDMA_TCD_ITER_MASK)
+#define EDMA_TCD_BITER_BITER(x)		((x) & EDMA_TCD_ITER_MASK)
 
 #define EDMA_TCD_CSR_START		BIT(0)
 #define EDMA_TCD_CSR_INT_MAJOR		BIT(1)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 75cae7ccae270..d36e28b9c767a 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -9,6 +9,8 @@
  * Vybrid and Layerscape SoCs.
  */
 
+#include <dt-bindings/dma/fsl-edma.h>
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
@@ -21,12 +23,6 @@
 
 #include "fsl-edma-common.h"
 
-#define ARGS_RX                         BIT(0)
-#define ARGS_REMOTE                     BIT(1)
-#define ARGS_MULTI_FIFO                 BIT(2)
-#define ARGS_EVEN_CH                    BIT(3)
-#define ARGS_ODD_CH                     BIT(4)
-
 static void fsl_edma_synchronize(struct dma_chan *chan)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
@@ -155,14 +151,14 @@ static struct dma_chan *fsl_edma3_xlate(struct of_phandle_args *dma_spec,
 		i = fsl_chan - fsl_edma->chans;
 
 		fsl_chan->priority = dma_spec->args[1];
-		fsl_chan->is_rxchan = dma_spec->args[2] & ARGS_RX;
-		fsl_chan->is_remote = dma_spec->args[2] & ARGS_REMOTE;
-		fsl_chan->is_multi_fifo = dma_spec->args[2] & ARGS_MULTI_FIFO;
+		fsl_chan->is_rxchan = dma_spec->args[2] & FSL_EDMA_RX;
+		fsl_chan->is_remote = dma_spec->args[2] & FSL_EDMA_REMOTE;
+		fsl_chan->is_multi_fifo = dma_spec->args[2] & FSL_EDMA_MULTI_FIFO;
 
-		if ((dma_spec->args[2] & ARGS_EVEN_CH) && (i & 0x1))
+		if ((dma_spec->args[2] & FSL_EDMA_EVEN_CH) && (i & 0x1))
 			continue;
 
-		if ((dma_spec->args[2] & ARGS_ODD_CH) && !(i & 0x1))
+		if ((dma_spec->args[2] & FSL_EDMA_ODD_CH) && !(i & 0x1))
 			continue;
 
 		if (!b_chmux && i == dma_spec->args[0]) {
@@ -587,7 +583,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 					DMAENGINE_ALIGN_32_BYTES;
 
 	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
-	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
+	dma_set_max_seg_size(fsl_edma->dma_dev.dev,
+			     FIELD_GET(EDMA_TCD_ITER_MASK, EDMA_TCD_ITER_MASK));
 
 	fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 6cf7f364704e8..b094c48bebc30 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1811,7 +1811,7 @@ void bond_xdp_set_features(struct net_device *bond_dev)
 
 	ASSERT_RTNL();
 
-	if (!bond_xdp_check(bond)) {
+	if (!bond_xdp_check(bond) || !bond_has_slaves(bond)) {
 		xdp_clear_features_flag(bond_dev);
 		return;
 	}
diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 4bf4d67557dcf..9048d1f196110 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -49,9 +49,9 @@ static int ksz8_ind_write8(struct ksz_device *dev, u8 table, u16 addr, u8 data)
 	mutex_lock(&dev->alu_mutex);
 
 	ctrl_addr = IND_ACC_TABLE(table) | addr;
-	ret = ksz_write8(dev, regs[REG_IND_BYTE], data);
+	ret = ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
 	if (!ret)
-		ret = ksz_write16(dev, regs[REG_IND_CTRL_0], ctrl_addr);
+		ret = ksz_write8(dev, regs[REG_IND_BYTE], data);
 
 	mutex_unlock(&dev->alu_mutex);
 
diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 11c23a7f3172d..fd1a5149c0031 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -160,23 +160,19 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
 	if (err < 0) {
 		dev_warn(cf->dev, "auxiliary_device_init of %s failed: %pe\n",
 			 name, ERR_PTR(err));
-		goto err_out;
+		kfree(padev);
+		return ERR_PTR(err);
 	}
 
 	err = auxiliary_device_add(aux_dev);
 	if (err) {
 		dev_warn(cf->dev, "auxiliary_device_add of %s failed: %pe\n",
 			 name, ERR_PTR(err));
-		goto err_out_uninit;
+		auxiliary_device_uninit(aux_dev);
+		return ERR_PTR(err);
 	}
 
 	return padev;
-
-err_out_uninit:
-	auxiliary_device_uninit(aux_dev);
-err_out:
-	kfree(padev);
-	return ERR_PTR(err);
 }
 
 int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d9716bcec81bb..b0dc0fc6b1359 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13629,9 +13629,9 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
 		return err;
 
 	i40e_queue_pair_disable_irq(vsi, queue_pair);
+	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	err = i40e_queue_pair_toggle_rings(vsi, queue_pair, false /* off */);
 	i40e_clean_rx_ring(vsi->rx_rings[queue_pair]);
-	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	i40e_queue_pair_clean_rings(vsi, queue_pair);
 	i40e_queue_pair_reset_stats(vsi, queue_pair);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 2b657d43c769d..68b894bb68fe7 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2146,6 +2146,7 @@ void ice_dpll_init(struct ice_pf *pf)
 	struct ice_dplls *d = &pf->dplls;
 	int err = 0;
 
+	mutex_init(&d->lock);
 	err = ice_dpll_init_info(pf, cgu);
 	if (err)
 		goto err_exit;
@@ -2158,7 +2159,6 @@ void ice_dpll_init(struct ice_pf *pf)
 	err = ice_dpll_init_pins(pf, cgu);
 	if (err)
 		goto deinit_pps;
-	mutex_init(&d->lock);
 	if (cgu) {
 		err = ice_dpll_init_worker(pf);
 		if (err)
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index adfdea1e2805a..a9cca2d24120a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7800,6 +7800,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e1494f24f661d..cd61928700211 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -762,24 +762,6 @@ static void ice_sriov_clear_reset_trigger(struct ice_vf *vf)
 	ice_flush(hw);
 }
 
-/**
- * ice_sriov_create_vsi - Create a new VSI for a VF
- * @vf: VF to create the VSI for
- *
- * This is called by ice_vf_recreate_vsi to create the new VSI after the old
- * VSI has been released.
- */
-static int ice_sriov_create_vsi(struct ice_vf *vf)
-{
-	struct ice_vsi *vsi;
-
-	vsi = ice_vf_vsi_setup(vf);
-	if (!vsi)
-		return -ENOMEM;
-
-	return 0;
-}
-
 /**
  * ice_sriov_post_vsi_rebuild - tasks to do after the VF's VSI have been rebuilt
  * @vf: VF to perform tasks on
@@ -799,7 +781,6 @@ static const struct ice_vf_ops ice_sriov_vf_ops = {
 	.poll_reset_status = ice_sriov_poll_reset_status,
 	.clear_reset_trigger = ice_sriov_clear_reset_trigger,
 	.irq_close = NULL,
-	.create_vsi = ice_sriov_create_vsi,
 	.post_vsi_rebuild = ice_sriov_post_vsi_rebuild,
 };
 
@@ -1093,6 +1074,7 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	struct ice_pf *pf = pci_get_drvdata(pdev);
 	u16 prev_msix, prev_queues, queues;
 	bool needs_rebuild = false;
+	struct ice_vsi *vsi;
 	struct ice_vf *vf;
 	int id;
 
@@ -1127,6 +1109,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (!vf)
 		return -ENOENT;
 
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return -ENOENT;
+
 	prev_msix = vf->num_msix;
 	prev_queues = vf->num_vf_qs;
 
@@ -1147,8 +1133,7 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (vf->first_vector_idx < 0)
 		goto unroll;
 
-	ice_vf_vsi_release(vf);
-	if (vf->vf_ops->create_vsi(vf)) {
+	if (ice_vf_reconfig_vsi(vf) || ice_vf_init_host_cfg(vf, vsi)) {
 		/* Try to rebuild with previous values */
 		needs_rebuild = true;
 		goto unroll;
@@ -1174,8 +1159,10 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (vf->first_vector_idx < 0)
 		return -EINVAL;
 
-	if (needs_rebuild)
-		vf->vf_ops->create_vsi(vf);
+	if (needs_rebuild) {
+		ice_vf_reconfig_vsi(vf);
+		ice_vf_init_host_cfg(vf, vsi);
+	}
 
 	ice_ena_vf_mappings(vf);
 	ice_put_vf(vf);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index b7ae099521566..88e3cd09f8d0c 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -248,29 +248,44 @@ static void ice_vf_pre_vsi_rebuild(struct ice_vf *vf)
 }
 
 /**
- * ice_vf_recreate_vsi - Release and re-create the VF's VSI
- * @vf: VF to recreate the VSI for
+ * ice_vf_reconfig_vsi - Reconfigure a VF VSI with the device
+ * @vf: VF to reconfigure the VSI for
  *
- * This is only called when a single VF is being reset (i.e. VVF, VFLR, host
- * VF configuration change, etc)
+ * This is called when a single VF is being reset (i.e. VVF, VFLR, host VF
+ * configuration change, etc).
  *
- * It releases and then re-creates a new VSI.
+ * It brings the VSI down and then reconfigures it with the hardware.
  */
-static int ice_vf_recreate_vsi(struct ice_vf *vf)
+int ice_vf_reconfig_vsi(struct ice_vf *vf)
 {
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
+	struct ice_vsi_cfg_params params = {};
 	struct ice_pf *pf = vf->pf;
 	int err;
 
-	ice_vf_vsi_release(vf);
+	if (WARN_ON(!vsi))
+		return -EINVAL;
+
+	params = ice_vsi_to_params(vsi);
+	params.flags = ICE_VSI_FLAG_NO_INIT;
 
-	err = vf->vf_ops->create_vsi(vf);
+	ice_vsi_decfg(vsi);
+	ice_fltr_remove_all(vsi);
+
+	err = ice_vsi_cfg(vsi, &params);
 	if (err) {
 		dev_err(ice_pf_to_dev(pf),
-			"Failed to recreate the VF%u's VSI, error %d\n",
+			"Failed to reconfigure the VF%u's VSI, error %d\n",
 			vf->vf_id, err);
 		return err;
 	}
 
+	/* Update the lan_vsi_num field since it might have been changed. The
+	 * PF lan_vsi_idx number remains the same so we don't need to change
+	 * that.
+	 */
+	vf->lan_vsi_num = vsi->vsi_num;
+
 	return 0;
 }
 
@@ -929,7 +944,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 
 	ice_vf_pre_vsi_rebuild(vf);
 
-	if (ice_vf_recreate_vsi(vf)) {
+	if (ice_vf_reconfig_vsi(vf)) {
 		dev_err(dev, "Failed to release and setup the VF%u's VSI\n",
 			vf->vf_id);
 		err = -EFAULT;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 93c774f2f4376..6b41e0f3d37ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -62,7 +62,6 @@ struct ice_vf_ops {
 	bool (*poll_reset_status)(struct ice_vf *vf);
 	void (*clear_reset_trigger)(struct ice_vf *vf);
 	void (*irq_close)(struct ice_vf *vf);
-	int (*create_vsi)(struct ice_vf *vf);
 	void (*post_vsi_rebuild)(struct ice_vf *vf);
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
index 0c7e77c0a09fa..91ba7fe0eaee1 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
@@ -23,6 +23,7 @@
 #warning "Only include ice_vf_lib_private.h in CONFIG_PCI_IOV virtualization files"
 #endif
 
+int ice_vf_reconfig_vsi(struct ice_vf *vf);
 void ice_initialize_vf_entry(struct ice_vf *vf);
 void ice_dis_vf_qs(struct ice_vf *vf);
 int ice_check_vf_init(struct ice_vf *vf);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 8872f7a4f4320..d6348f20822e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -440,7 +440,6 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 		vf->driver_caps = *(u32 *)msg;
 	else
 		vf->driver_caps = VIRTCHNL_VF_OFFLOAD_L2 |
-				  VIRTCHNL_VF_OFFLOAD_RSS_REG |
 				  VIRTCHNL_VF_OFFLOAD_VLAN;
 
 	vfres->vf_cap_flags = VIRTCHNL_VF_OFFLOAD_L2;
@@ -453,14 +452,8 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	vfres->vf_cap_flags |= ice_vc_get_vlan_caps(hw, vf, vsi,
 						    vf->driver_caps);
 
-	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
+	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_PF)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_PF;
-	} else {
-		if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RSS_AQ)
-			vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_AQ;
-		else
-			vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RSS_REG;
-	}
 
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
index 7d547fa616fa6..588b77f1a4bf6 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
@@ -13,8 +13,6 @@
  * - opcodes needed by VF when caps are activated
  *
  * Caps that don't use new opcodes (no opcodes should be allowed):
- * - VIRTCHNL_VF_OFFLOAD_RSS_AQ
- * - VIRTCHNL_VF_OFFLOAD_RSS_REG
  * - VIRTCHNL_VF_OFFLOAD_WB_ON_ITR
  * - VIRTCHNL_VF_OFFLOAD_CRC
  * - VIRTCHNL_VF_OFFLOAD_RX_POLLING
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index f3663b3f6390e..0fd5551b108ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -179,6 +179,10 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 			return -EBUSY;
 		usleep_range(1000, 2000);
 	}
+
+	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
+	ice_qvec_toggle_napi(vsi, q_vector, false);
+
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
@@ -195,13 +199,10 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
-
 	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
 	if (err)
 		return err;
 
-	ice_qvec_toggle_napi(vsi, q_vector, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
@@ -259,11 +260,11 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	if (err)
 		return err;
 
-	clear_bit(ICE_CFG_BUSY, vsi->state);
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
 
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 2c1b051fdc0d4..b0c52f17848f6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2087,8 +2087,10 @@ int idpf_send_disable_queues_msg(struct idpf_vport *vport)
 		set_bit(__IDPF_Q_POLL_MODE, vport->txqs[i]->flags);
 
 	/* schedule the napi to receive all the marker packets */
+	local_bh_disable();
 	for (i = 0; i < vport->num_q_vectors; i++)
 		napi_schedule(&vport->q_vectors[i].napi);
+	local_bh_enable();
 
 	return idpf_wait_for_marker_event(vport);
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index e9bb403bbacf9..58ffddc6419ad 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6489,7 +6489,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	int cpu = smp_processor_id();
 	struct netdev_queue *nq;
 	struct igc_ring *ring;
-	int i, drops;
+	int i, nxmit;
 
 	if (unlikely(!netif_carrier_ok(dev)))
 		return -ENETDOWN;
@@ -6505,16 +6505,15 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	/* Avoid transmit queue timeout since we share it with the slow path */
 	txq_trans_cond_update(nq);
 
-	drops = 0;
+	nxmit = 0;
 	for (i = 0; i < num_frames; i++) {
 		int err;
 		struct xdp_frame *xdpf = frames[i];
 
 		err = igc_xdp_init_tx_descriptor(ring, xdpf);
-		if (err) {
-			xdp_return_frame_rx_napi(xdpf);
-			drops++;
-		}
+		if (err)
+			break;
+		nxmit++;
 	}
 
 	if (flags & XDP_XMIT_FLUSH)
@@ -6522,7 +6521,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 
 	__netif_tx_unlock(nq);
 
-	return num_frames - drops;
+	return nxmit;
 }
 
 static void igc_trigger_rxtxq_interrupt(struct igc_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 6a3f633406c4b..ce234e76ea236 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2939,8 +2939,8 @@ static void ixgbe_check_lsc(struct ixgbe_adapter *adapter)
 static inline void ixgbe_irq_enable_queues(struct ixgbe_adapter *adapter,
 					   u64 qmask)
 {
-	u32 mask;
 	struct ixgbe_hw *hw = &adapter->hw;
+	u32 mask;
 
 	switch (hw->mac.type) {
 	case ixgbe_mac_82598EB:
@@ -10524,6 +10524,44 @@ static void ixgbe_reset_rxr_stats(struct ixgbe_ring *rx_ring)
 	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
 }
 
+/**
+ * ixgbe_irq_disable_single - Disable single IRQ vector
+ * @adapter: adapter structure
+ * @ring: ring index
+ **/
+static void ixgbe_irq_disable_single(struct ixgbe_adapter *adapter, u32 ring)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u64 qmask = BIT_ULL(ring);
+	u32 mask;
+
+	switch (adapter->hw.mac.type) {
+	case ixgbe_mac_82598EB:
+		mask = qmask & IXGBE_EIMC_RTX_QUEUE;
+		IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIMC, mask);
+		break;
+	case ixgbe_mac_82599EB:
+	case ixgbe_mac_X540:
+	case ixgbe_mac_X550:
+	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
+		mask = (qmask & 0xFFFFFFFF);
+		if (mask)
+			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(0), mask);
+		mask = (qmask >> 32);
+		if (mask)
+			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(1), mask);
+		break;
+	default:
+		break;
+	}
+	IXGBE_WRITE_FLUSH(&adapter->hw);
+	if (adapter->flags & IXGBE_FLAG_MSIX_ENABLED)
+		synchronize_irq(adapter->msix_entries[ring].vector);
+	else
+		synchronize_irq(adapter->pdev->irq);
+}
+
 /**
  * ixgbe_txrx_ring_disable - Disable Rx/Tx/XDP Tx rings
  * @adapter: adapter structure
@@ -10540,6 +10578,11 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
+	ixgbe_irq_disable_single(adapter, ring);
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_disable(&rx_ring->q_vector->napi);
+
 	ixgbe_disable_txr(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_disable_txr(adapter, xdp_ring);
@@ -10548,9 +10591,6 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	if (xdp_ring)
 		synchronize_rcu();
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_disable(&rx_ring->q_vector->napi);
-
 	ixgbe_clean_tx_ring(tx_ring);
 	if (xdp_ring)
 		ixgbe_clean_tx_ring(xdp_ring);
@@ -10578,9 +10618,6 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_enable(&rx_ring->q_vector->napi);
-
 	ixgbe_configure_tx_ring(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_configure_tx_ring(adapter, xdp_ring);
@@ -10589,6 +10626,11 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	clear_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
 	if (xdp_ring)
 		clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_enable(&rx_ring->q_vector->napi);
+	ixgbe_irq_enable_queues(adapter, BIT_ULL(ring));
+	IXGBE_WRITE_FLUSH(&adapter->hw);
 }
 
 /**
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3e064234f6fe9..98d4306929f3e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -157,6 +157,12 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 		return -EOPNOTSUPP;
 	}
 
+	if (action == DEVLINK_RELOAD_ACTION_FW_ACTIVATE &&
+	    !dev->priv.fw_reset) {
+		NL_SET_ERR_MSG_MOD(extack, "FW activate is unsupported for this function");
+		return -EOPNOTSUPP;
+	}
+
 	if (mlx5_core_is_pf(dev) && pci_num_vf(pdev))
 		NL_SET_ERR_MSG_MOD(extack, "reload while VFs are present is unfavorable");
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 803035d4e5976..15d97c685ad33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -42,9 +42,9 @@ mlx5e_ptp_port_ts_cqe_list_add(struct mlx5e_ptp_port_ts_cqe_list *list, u8 metad
 
 	WARN_ON_ONCE(tracker->inuse);
 	tracker->inuse = true;
-	spin_lock(&list->tracker_list_lock);
+	spin_lock_bh(&list->tracker_list_lock);
 	list_add_tail(&tracker->entry, &list->tracker_list_head);
-	spin_unlock(&list->tracker_list_lock);
+	spin_unlock_bh(&list->tracker_list_lock);
 }
 
 static void
@@ -54,9 +54,9 @@ mlx5e_ptp_port_ts_cqe_list_remove(struct mlx5e_ptp_port_ts_cqe_list *list, u8 me
 
 	WARN_ON_ONCE(!tracker->inuse);
 	tracker->inuse = false;
-	spin_lock(&list->tracker_list_lock);
+	spin_lock_bh(&list->tracker_list_lock);
 	list_del(&tracker->entry);
-	spin_unlock(&list->tracker_list_lock);
+	spin_unlock_bh(&list->tracker_list_lock);
 }
 
 void mlx5e_ptpsq_track_metadata(struct mlx5e_ptpsq *ptpsq, u8 metadata)
@@ -155,7 +155,7 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 	struct mlx5e_ptp_metadata_map *metadata_map = &ptpsq->metadata_map;
 	struct mlx5e_ptp_port_ts_cqe_tracker *pos, *n;
 
-	spin_lock(&cqe_list->tracker_list_lock);
+	spin_lock_bh(&cqe_list->tracker_list_lock);
 	list_for_each_entry_safe(pos, n, &cqe_list->tracker_list_head, entry) {
 		struct sk_buff *skb =
 			mlx5e_ptp_metadata_map_lookup(metadata_map, pos->metadata_id);
@@ -170,7 +170,7 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 		pos->inuse = false;
 		list_del(&pos->entry);
 	}
-	spin_unlock(&cqe_list->tracker_list_lock);
+	spin_unlock_bh(&cqe_list->tracker_list_lock);
 }
 
 #define PTP_WQE_CTR2IDX(val) ((val) & ptpsq->ts_cqe_ctr_mask)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
index 86bf007fd05b7..b500cc2c9689d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
@@ -37,7 +37,7 @@ mlx5e_tc_post_act_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 
 	if (!MLX5_CAP_FLOWTABLE_TYPE(priv->mdev, ignore_flow_level, table_type)) {
 		if (priv->mdev->coredev_type == MLX5_COREDEV_PF)
-			mlx5_core_warn(priv->mdev, "firmware level support is missing\n");
+			mlx5_core_dbg(priv->mdev, "firmware flow level support is missing\n");
 		err = -EOPNOTSUPP;
 		goto err_check;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index d4ebd87431145..b2cabd6ab86cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -310,9 +310,9 @@ static void mlx5e_macsec_destroy_object(struct mlx5_core_dev *mdev, u32 macsec_o
 	mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
 }
 
-static void mlx5e_macsec_cleanup_sa(struct mlx5e_macsec *macsec,
-				    struct mlx5e_macsec_sa *sa,
-				    bool is_tx, struct net_device *netdev, u32 fs_id)
+static void mlx5e_macsec_cleanup_sa_fs(struct mlx5e_macsec *macsec,
+				       struct mlx5e_macsec_sa *sa, bool is_tx,
+				       struct net_device *netdev, u32 fs_id)
 {
 	int action =  (is_tx) ?  MLX5_ACCEL_MACSEC_ACTION_ENCRYPT :
 				 MLX5_ACCEL_MACSEC_ACTION_DECRYPT;
@@ -322,20 +322,49 @@ static void mlx5e_macsec_cleanup_sa(struct mlx5e_macsec *macsec,
 
 	mlx5_macsec_fs_del_rule(macsec->mdev->macsec_fs, sa->macsec_rule, action, netdev,
 				fs_id);
-	mlx5e_macsec_destroy_object(macsec->mdev, sa->macsec_obj_id);
 	sa->macsec_rule = NULL;
 }
 
+static void mlx5e_macsec_cleanup_sa(struct mlx5e_macsec *macsec,
+				    struct mlx5e_macsec_sa *sa, bool is_tx,
+				    struct net_device *netdev, u32 fs_id)
+{
+	mlx5e_macsec_cleanup_sa_fs(macsec, sa, is_tx, netdev, fs_id);
+	mlx5e_macsec_destroy_object(macsec->mdev, sa->macsec_obj_id);
+}
+
+static int mlx5e_macsec_init_sa_fs(struct macsec_context *ctx,
+				   struct mlx5e_macsec_sa *sa, bool encrypt,
+				   bool is_tx, u32 *fs_id)
+{
+	struct mlx5e_priv *priv = macsec_netdev_priv(ctx->netdev);
+	struct mlx5_macsec_fs *macsec_fs = priv->mdev->macsec_fs;
+	struct mlx5_macsec_rule_attrs rule_attrs;
+	union mlx5_macsec_rule *macsec_rule;
+
+	rule_attrs.macsec_obj_id = sa->macsec_obj_id;
+	rule_attrs.sci = sa->sci;
+	rule_attrs.assoc_num = sa->assoc_num;
+	rule_attrs.action = (is_tx) ? MLX5_ACCEL_MACSEC_ACTION_ENCRYPT :
+				      MLX5_ACCEL_MACSEC_ACTION_DECRYPT;
+
+	macsec_rule = mlx5_macsec_fs_add_rule(macsec_fs, ctx, &rule_attrs, fs_id);
+	if (!macsec_rule)
+		return -ENOMEM;
+
+	sa->macsec_rule = macsec_rule;
+
+	return 0;
+}
+
 static int mlx5e_macsec_init_sa(struct macsec_context *ctx,
 				struct mlx5e_macsec_sa *sa,
 				bool encrypt, bool is_tx, u32 *fs_id)
 {
 	struct mlx5e_priv *priv = macsec_netdev_priv(ctx->netdev);
 	struct mlx5e_macsec *macsec = priv->macsec;
-	struct mlx5_macsec_rule_attrs rule_attrs;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5_macsec_obj_attrs obj_attrs;
-	union mlx5_macsec_rule *macsec_rule;
 	int err;
 
 	obj_attrs.next_pn = sa->next_pn;
@@ -357,20 +386,12 @@ static int mlx5e_macsec_init_sa(struct macsec_context *ctx,
 	if (err)
 		return err;
 
-	rule_attrs.macsec_obj_id = sa->macsec_obj_id;
-	rule_attrs.sci = sa->sci;
-	rule_attrs.assoc_num = sa->assoc_num;
-	rule_attrs.action = (is_tx) ? MLX5_ACCEL_MACSEC_ACTION_ENCRYPT :
-				      MLX5_ACCEL_MACSEC_ACTION_DECRYPT;
-
-	macsec_rule = mlx5_macsec_fs_add_rule(mdev->macsec_fs, ctx, &rule_attrs, fs_id);
-	if (!macsec_rule) {
-		err = -ENOMEM;
-		goto destroy_macsec_object;
+	if (sa->active) {
+		err = mlx5e_macsec_init_sa_fs(ctx, sa, encrypt, is_tx, fs_id);
+		if (err)
+			goto destroy_macsec_object;
 	}
 
-	sa->macsec_rule = macsec_rule;
-
 	return 0;
 
 destroy_macsec_object:
@@ -526,9 +547,7 @@ static int mlx5e_macsec_add_txsa(struct macsec_context *ctx)
 		goto destroy_sa;
 
 	macsec_device->tx_sa[assoc_num] = tx_sa;
-	if (!secy->operational ||
-	    assoc_num != tx_sc->encoding_sa ||
-	    !tx_sa->active)
+	if (!secy->operational)
 		goto out;
 
 	err = mlx5e_macsec_init_sa(ctx, tx_sa, tx_sc->encrypt, true, NULL);
@@ -595,7 +614,7 @@ static int mlx5e_macsec_upd_txsa(struct macsec_context *ctx)
 		goto out;
 
 	if (ctx_tx_sa->active) {
-		err = mlx5e_macsec_init_sa(ctx, tx_sa, tx_sc->encrypt, true, NULL);
+		err = mlx5e_macsec_init_sa_fs(ctx, tx_sa, tx_sc->encrypt, true, NULL);
 		if (err)
 			goto out;
 	} else {
@@ -604,7 +623,7 @@ static int mlx5e_macsec_upd_txsa(struct macsec_context *ctx)
 			goto out;
 		}
 
-		mlx5e_macsec_cleanup_sa(macsec, tx_sa, true, ctx->secy->netdev, 0);
+		mlx5e_macsec_cleanup_sa_fs(macsec, tx_sa, true, ctx->secy->netdev, 0);
 	}
 out:
 	mutex_unlock(&macsec->lock);
@@ -1030,8 +1049,9 @@ static int mlx5e_macsec_del_rxsa(struct macsec_context *ctx)
 		goto out;
 	}
 
-	mlx5e_macsec_cleanup_sa(macsec, rx_sa, false, ctx->secy->netdev,
-				rx_sc->sc_xarray_element->fs_id);
+	if (rx_sa->active)
+		mlx5e_macsec_cleanup_sa(macsec, rx_sa, false, ctx->secy->netdev,
+					rx_sc->sc_xarray_element->fs_id);
 	mlx5_destroy_encryption_key(macsec->mdev, rx_sa->enc_key_id);
 	kfree(rx_sa);
 	rx_sc->rx_sa[assoc_num] = NULL;
@@ -1112,8 +1132,8 @@ static int macsec_upd_secy_hw_address(struct macsec_context *ctx,
 			if (!rx_sa || !rx_sa->macsec_rule)
 				continue;
 
-			mlx5e_macsec_cleanup_sa(macsec, rx_sa, false, ctx->secy->netdev,
-						rx_sc->sc_xarray_element->fs_id);
+			mlx5e_macsec_cleanup_sa_fs(macsec, rx_sa, false, ctx->secy->netdev,
+						   rx_sc->sc_xarray_element->fs_id);
 		}
 	}
 
@@ -1124,8 +1144,8 @@ static int macsec_upd_secy_hw_address(struct macsec_context *ctx,
 				continue;
 
 			if (rx_sa->active) {
-				err = mlx5e_macsec_init_sa(ctx, rx_sa, true, false,
-							   &rx_sc->sc_xarray_element->fs_id);
+				err = mlx5e_macsec_init_sa_fs(ctx, rx_sa, true, false,
+							      &rx_sc->sc_xarray_element->fs_id);
 				if (err)
 					goto out;
 			}
@@ -1178,7 +1198,7 @@ static int mlx5e_macsec_upd_secy(struct macsec_context *ctx)
 		if (!tx_sa)
 			continue;
 
-		mlx5e_macsec_cleanup_sa(macsec, tx_sa, true, ctx->secy->netdev, 0);
+		mlx5e_macsec_cleanup_sa_fs(macsec, tx_sa, true, ctx->secy->netdev, 0);
 	}
 
 	for (i = 0; i < MACSEC_NUM_AN; ++i) {
@@ -1187,7 +1207,7 @@ static int mlx5e_macsec_upd_secy(struct macsec_context *ctx)
 			continue;
 
 		if (tx_sa->assoc_num == tx_sc->encoding_sa && tx_sa->active) {
-			err = mlx5e_macsec_init_sa(ctx, tx_sa, tx_sc->encrypt, true, NULL);
+			err = mlx5e_macsec_init_sa_fs(ctx, tx_sa, tx_sc->encrypt, true, NULL);
 			if (err)
 				goto out;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index f0b506e562df3..1ead69c5f5fa3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -401,6 +401,8 @@ mlx5e_txwqe_complete(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		mlx5e_skb_cb_hwtstamp_init(skb);
 		mlx5e_ptp_metadata_map_put(&sq->ptpsq->metadata_map, skb,
 					   metadata_index);
+		/* ensure skb is put on metadata_map before tracking the index */
+		wmb();
 		mlx5e_ptpsq_track_metadata(sq->ptpsq, metadata_index);
 		if (!netif_tx_queue_stopped(sq->txq) &&
 		    mlx5e_ptpsq_metadata_freelist_empty(sq->ptpsq)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 190f10aba1702..5a0047bdcb510 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -152,7 +152,7 @@ void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
 
 	xa_for_each(&esw->offloads.vport_reps, i, rep) {
 		rpriv = rep->rep_data[REP_ETH].priv;
-		if (!rpriv || !rpriv->netdev || !atomic_read(&rpriv->tc_ht.nelems))
+		if (!rpriv || !rpriv->netdev)
 			continue;
 
 		rhashtable_walk_enter(&rpriv->tc_ht, &iter);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b0455134c98ef..baaae628b0a0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -535,21 +535,26 @@ esw_src_port_rewrite_supported(struct mlx5_eswitch *esw)
 }
 
 static bool
-esw_dests_to_vf_pf_vports(struct mlx5_flow_destination *dests, int max_dest)
+esw_dests_to_int_external(struct mlx5_flow_destination *dests, int max_dest)
 {
-	bool vf_dest = false, pf_dest = false;
+	bool internal_dest = false, external_dest = false;
 	int i;
 
 	for (i = 0; i < max_dest; i++) {
-		if (dests[i].type != MLX5_FLOW_DESTINATION_TYPE_VPORT)
+		if (dests[i].type != MLX5_FLOW_DESTINATION_TYPE_VPORT &&
+		    dests[i].type != MLX5_FLOW_DESTINATION_TYPE_UPLINK)
 			continue;
 
-		if (dests[i].vport.num == MLX5_VPORT_UPLINK)
-			pf_dest = true;
+		/* Uplink dest is external, but considered as internal
+		 * if there is reformat because firmware uses LB+hairpin to support it.
+		 */
+		if (dests[i].vport.num == MLX5_VPORT_UPLINK &&
+		    !(dests[i].vport.flags & MLX5_FLOW_DEST_VPORT_REFORMAT_ID))
+			external_dest = true;
 		else
-			vf_dest = true;
+			internal_dest = true;
 
-		if (vf_dest && pf_dest)
+		if (internal_dest && external_dest)
 			return true;
 	}
 
@@ -695,9 +700,9 @@ mlx5_eswitch_add_offloaded_rule(struct mlx5_eswitch *esw,
 
 		/* Header rewrite with combined wire+loopback in FDB is not allowed */
 		if ((flow_act.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) &&
-		    esw_dests_to_vf_pf_vports(dest, i)) {
+		    esw_dests_to_int_external(dest, i)) {
 			esw_warn(esw->dev,
-				 "FDB: Header rewrite with forwarding to both PF and VF is not allowed\n");
+				 "FDB: Header rewrite with forwarding to both internal and external dests is not allowed\n");
 			rule = ERR_PTR(-EINVAL);
 			goto err_esw_get;
 		}
@@ -3658,22 +3663,6 @@ static int esw_inline_mode_to_devlink(u8 mlx5_mode, u8 *mode)
 	return 0;
 }
 
-static bool esw_offloads_devlink_ns_eq_netdev_ns(struct devlink *devlink)
-{
-	struct mlx5_core_dev *dev = devlink_priv(devlink);
-	struct net *devl_net, *netdev_net;
-	bool ret = false;
-
-	mutex_lock(&dev->mlx5e_res.uplink_netdev_lock);
-	if (dev->mlx5e_res.uplink_netdev) {
-		netdev_net = dev_net(dev->mlx5e_res.uplink_netdev);
-		devl_net = devlink_net(devlink);
-		ret = net_eq(devl_net, netdev_net);
-	}
-	mutex_unlock(&dev->mlx5e_res.uplink_netdev_lock);
-	return ret;
-}
-
 int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
@@ -3718,13 +3707,6 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
-	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV &&
-	    !esw_offloads_devlink_ns_eq_netdev_ns(devlink)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't change E-Switch mode to switchdev when netdev net namespace has diverged from the devlink's.");
-		return -EPERM;
-	}
-
 	mlx5_lag_disable_change(esw->dev);
 	err = mlx5_esw_try_lock(esw);
 	if (err < 0) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index c4e19d627da21..3a9cdf79403ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -679,19 +679,30 @@ void mlx5_fw_reset_events_start(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 
+	if (!fw_reset)
+		return;
+
 	MLX5_NB_INIT(&fw_reset->nb, fw_reset_event_notifier, GENERAL_EVENT);
 	mlx5_eq_notifier_register(dev, &fw_reset->nb);
 }
 
 void mlx5_fw_reset_events_stop(struct mlx5_core_dev *dev)
 {
-	mlx5_eq_notifier_unregister(dev, &dev->priv.fw_reset->nb);
+	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
+
+	if (!fw_reset)
+		return;
+
+	mlx5_eq_notifier_unregister(dev, &fw_reset->nb);
 }
 
 void mlx5_drain_fw_reset(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 
+	if (!fw_reset)
+		return;
+
 	set_bit(MLX5_FW_RESET_FLAGS_DROP_NEW_REQUESTS, &fw_reset->reset_flags);
 	cancel_work_sync(&fw_reset->fw_live_patch_work);
 	cancel_work_sync(&fw_reset->reset_request_work);
@@ -709,9 +720,13 @@ static const struct devlink_param mlx5_fw_reset_devlink_params[] = {
 
 int mlx5_fw_reset_init(struct mlx5_core_dev *dev)
 {
-	struct mlx5_fw_reset *fw_reset = kzalloc(sizeof(*fw_reset), GFP_KERNEL);
+	struct mlx5_fw_reset *fw_reset;
 	int err;
 
+	if (!MLX5_CAP_MCAM_REG(dev, mfrl))
+		return 0;
+
+	fw_reset = kzalloc(sizeof(*fw_reset), GFP_KERNEL);
 	if (!fw_reset)
 		return -ENOMEM;
 	fw_reset->wq = create_singlethread_workqueue("mlx5_fw_reset_events");
@@ -747,6 +762,9 @@ void mlx5_fw_reset_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 
+	if (!fw_reset)
+		return;
+
 	devl_params_unregister(priv_to_devlink(dev),
 			       mlx5_fw_reset_devlink_params,
 			       ARRAY_SIZE(mlx5_fw_reset_devlink_params));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 8ff6dc9bc8033..b5c709bba1553 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -452,10 +452,10 @@ mlx5_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
 	struct health_buffer __iomem *h = health->health;
 	u8 synd = ioread8(&h->synd);
 
+	devlink_fmsg_u8_pair_put(fmsg, "Syndrome", synd);
 	if (!synd)
 		return 0;
 
-	devlink_fmsg_u8_pair_put(fmsg, "Syndrome", synd);
 	devlink_fmsg_string_pair_put(fmsg, "Description", hsynd_str(synd));
 
 	return 0;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
index 4af285918ea2a..75868b3f548ec 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -347,10 +347,10 @@ int sparx5_del_mact_entry(struct sparx5 *sparx5,
 				 list) {
 		if ((vid == 0 || mact_entry->vid == vid) &&
 		    ether_addr_equal(addr, mact_entry->mac)) {
+			sparx5_mact_forget(sparx5, addr, mact_entry->vid);
+
 			list_del(&mact_entry->list);
 			devm_kfree(sparx5->dev, mact_entry);
-
-			sparx5_mact_forget(sparx5, addr, mact_entry->vid);
 		}
 	}
 	mutex_unlock(&sparx5->mact_lock);
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index acd9c615d1f4f..356da958ee81b 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -221,7 +221,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 	struct genevehdr *gnvh = geneve_hdr(skb);
 	struct metadata_dst *tun_dst = NULL;
 	unsigned int len;
-	int err = 0;
+	int nh, err = 0;
 	void *oiph;
 
 	if (ip_tunnel_collect_metadata() || gs->collect_md) {
@@ -272,9 +272,23 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 		skb->pkt_type = PACKET_HOST;
 	}
 
-	oiph = skb_network_header(skb);
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
 
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(geneve->dev, rx_length_errors);
+		DEV_STATS_INC(geneve->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	oiph = skb->head + nh;
+
 	if (geneve_get_sk_family(gs) == AF_INET)
 		err = IP_ECN_decapsulate(oiph, skb);
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index a2dde84499fdd..f0fb9cd1ff56c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3137,7 +3137,8 @@ static int lan78xx_open(struct net_device *net)
 done:
 	mutex_unlock(&dev->dev_mutex);
 
-	usb_autopm_put_interface(dev->intf);
+	if (ret < 0)
+		usb_autopm_put_interface(dev->intf);
 
 	return ret;
 }
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index c98aeda8abb21..3d9721b3faa81 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -447,5 +447,6 @@ const struct file_operations erofs_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= erofs_file_read_iter,
 	.mmap		= erofs_file_mmap,
+	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 };
diff --git a/include/dt-bindings/dma/fsl-edma.h b/include/dt-bindings/dma/fsl-edma.h
new file mode 100644
index 0000000000000..fd11478cfe9cc
--- /dev/null
+++ b/include/dt-bindings/dma/fsl-edma.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+
+#ifndef _FSL_EDMA_DT_BINDING_H_
+#define _FSL_EDMA_DT_BINDING_H_
+
+/* Receive Channel */
+#define FSL_EDMA_RX		0x1
+
+/* iMX8 audio remote DMA */
+#define FSL_EDMA_REMOTE		0x2
+
+/* FIFO is continue memory region */
+#define FSL_EDMA_MULTI_FIFO	0x4
+
+/* Channel need stick to even channel */
+#define FSL_EDMA_EVEN_CH	0x8
+
+/* Channel need stick to odd channel */
+#define FSL_EDMA_ODD_CH		0x10
+
+#endif
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index fc8094419084f..e990c180282e7 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -75,6 +75,8 @@ extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
 					     struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
+					       struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 77cd2e13724e7..bfc8320fb46cb 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10215,7 +10215,9 @@ struct mlx5_ifc_mcam_access_reg_bits {
 
 	u8         regs_63_to_46[0x12];
 	u8         mrtc[0x1];
-	u8         regs_44_to_32[0xd];
+	u8         regs_44_to_41[0x4];
+	u8         mfrl[0x1];
+	u8         regs_39_to_32[0x8];
 
 	u8         regs_31_to_10[0x16];
 	u8         mtmp[0x1];
diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
index a3995925cb057..1f4258308b967 100644
--- a/include/trace/events/qdisc.h
+++ b/include/trace/events/qdisc.h
@@ -81,14 +81,14 @@ TRACE_EVENT(qdisc_reset,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)	)
-		__string(	kind,		q->ops->id	)
-		__field(	u32,		parent		)
-		__field(	u32,		handle		)
+		__string(	dev,		qdisc_dev(q)->name	)
+		__string(	kind,		q->ops->id		)
+		__field(	u32,		parent			)
+		__field(	u32,		handle			)
 	),
 
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q));
+		__assign_str(dev, qdisc_dev(q)->name);
 		__assign_str(kind, q->ops->id);
 		__entry->parent = q->parent;
 		__entry->handle = q->handle;
@@ -106,14 +106,14 @@ TRACE_EVENT(qdisc_destroy,
 	TP_ARGS(q),
 
 	TP_STRUCT__entry(
-		__string(	dev,		qdisc_dev(q)	)
-		__string(	kind,		q->ops->id	)
-		__field(	u32,		parent		)
-		__field(	u32,		handle		)
+		__string(	dev,		qdisc_dev(q)->name	)
+		__string(	kind,		q->ops->id		)
+		__field(	u32,		parent			)
+		__field(	u32,		handle			)
 	),
 
 	TP_fast_assign(
-		__assign_str(dev, qdisc_dev(q));
+		__assign_str(dev, qdisc_dev(q)->name);
 		__assign_str(kind, q->ops->id);
 		__entry->parent = q->parent;
 		__entry->handle = q->handle;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 8a0bb80fe48a3..ef82ffc90cbe9 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -178,7 +178,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 				    void **frames, int n,
 				    struct xdp_cpumap_stats *stats)
 {
-	struct xdp_rxq_info rxq;
+	struct xdp_rxq_info rxq = {};
 	struct xdp_buff xdp;
 	int i, nframes = 0;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e215413c79a52..9698e93d48c6e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16686,6 +16686,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 {
 	int i;
 
+	if (old->callback_depth > cur->callback_depth)
+		return false;
+
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (!regsafe(env, &old->regs[i], &cur->regs[i],
 			     &env->idmap_scratch, exact))
diff --git a/mm/readahead.c b/mm/readahead.c
index 6925e6959fd3f..1d1a84deb5bc5 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -469,7 +469,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 
 	if (!folio)
 		return -ENOMEM;
-	mark = round_up(mark, 1UL << order);
+	mark = round_down(mark, 1UL << order);
 	if (index == mark)
 		folio_set_readahead(folio);
 	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
@@ -577,7 +577,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * It's the expected callback index, assume sequential access.
 	 * Ramp up sizes, and push forward the readahead window.
 	 */
-	expected = round_up(ra->start + ra->size - ra->async_size,
+	expected = round_down(ra->start + ra->size - ra->async_size,
 			1UL << order);
 	if (index == expected || index == (ra->start + ra->size)) {
 		ra->start += ra->size;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ea1dec8448fce..ef815ba583a8f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5332,19 +5332,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	err_nh = NULL;
 	list_for_each_entry(nh, &rt6_nh_list, next) {
 		err = __ip6_ins_rt(nh->fib6_info, info, extack);
-		fib6_info_release(nh->fib6_info);
-
-		if (!err) {
-			/* save reference to last route successfully inserted */
-			rt_last = nh->fib6_info;
-
-			/* save reference to first route for notification */
-			if (!rt_notif)
-				rt_notif = nh->fib6_info;
-		}
 
-		/* nh->fib6_info is used or freed at this point, reset to NULL*/
-		nh->fib6_info = NULL;
 		if (err) {
 			if (replace && nhn)
 				NL_SET_ERR_MSG_MOD(extack,
@@ -5352,6 +5340,12 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 			err_nh = nh;
 			goto add_errout;
 		}
+		/* save reference to last route successfully inserted */
+		rt_last = nh->fib6_info;
+
+		/* save reference to first route for notification */
+		if (!rt_notif)
+			rt_notif = nh->fib6_info;
 
 		/* Because each route is added like a single route we remove
 		 * these flags after the first nexthop: if there is a collision,
@@ -5412,8 +5406,7 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
 cleanup:
 	list_for_each_entry_safe(nh, nh_safe, &rt6_nh_list, next) {
-		if (nh->fib6_info)
-			fib6_info_release(nh->fib6_info);
+		fib6_info_release(nh->fib6_info);
 		list_del(&nh->next);
 		kfree(nh);
 	}
diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index e697a824b0018..540d97715bd23 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -533,6 +533,8 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	/* Get fields bitmap */
 	if (nf_h323_error_boundary(bs, 0, f->sz))
 		return H323_ERROR_BOUND;
+	if (f->sz > 32)
+		return H323_ERROR_RANGE;
 	bmp = get_bitmap(bs, f->sz);
 	if (base)
 		*(unsigned int *)base = bmp;
@@ -589,6 +591,8 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	bmp2_len = get_bits(bs, 7) + 1;
 	if (nf_h323_error_boundary(bs, 0, bmp2_len))
 		return H323_ERROR_BOUND;
+	if (bmp2_len > 32)
+		return H323_ERROR_RANGE;
 	bmp2 = get_bitmap(bs, bmp2_len);
 	bmp |= bmp2 >> f->sz;
 	if (base)
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index bfd3e5a14dab6..255640013ab84 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -1256,14 +1256,13 @@ static int nft_ct_expect_obj_init(const struct nft_ctx *ctx,
 	switch (priv->l3num) {
 	case NFPROTO_IPV4:
 	case NFPROTO_IPV6:
-		if (priv->l3num != ctx->family)
-			return -EINVAL;
+		if (priv->l3num == ctx->family || ctx->family == NFPROTO_INET)
+			break;
 
-		fallthrough;
-	case NFPROTO_INET:
-		break;
+		return -EINVAL;
+	case NFPROTO_INET: /* tuple.src.l3num supports NFPROTO_IPV4/6 only */
 	default:
-		return -EOPNOTSUPP;
+		return -EAFNOSUPPORT;
 	}
 
 	priv->l4proto = nla_get_u8(tb[NFTA_CT_EXPECT_L4PROTO]);
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 0eed00184adf4..104a80b75477f 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -453,16 +453,16 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr_init_timers(sk);
 
 	nr->t1     =
-		msecs_to_jiffies(sysctl_netrom_transport_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
-		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_acknowledge_delay));
 	nr->n2     =
-		msecs_to_jiffies(sysctl_netrom_transport_maximum_tries);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-		msecs_to_jiffies(sysctl_netrom_transport_busy_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
-		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
-	nr->window = sysctl_netrom_transport_requested_window_size;
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_no_activity_timeout));
+	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
 	nr->state  = NR_STATE_0;
@@ -954,7 +954,7 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		 * G8PZT's Xrouter which is sending packets with command type 7
 		 * as an extension of the protocol.
 		 */
-		if (sysctl_netrom_reset_circuit &&
+		if (READ_ONCE(sysctl_netrom_reset_circuit) &&
 		    (frametype != NR_RESET || flags != 0))
 			nr_transmit_reset(skb, 1);
 
diff --git a/net/netrom/nr_dev.c b/net/netrom/nr_dev.c
index 3aaac4a22b387..2c34389c3ce6f 100644
--- a/net/netrom/nr_dev.c
+++ b/net/netrom/nr_dev.c
@@ -81,7 +81,7 @@ static int nr_header(struct sk_buff *skb, struct net_device *dev,
 	buff[6] |= AX25_SSSID_SPARE;
 	buff    += AX25_ADDR_LEN;
 
-	*buff++ = sysctl_netrom_network_ttl_initialiser;
+	*buff++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	*buff++ = NR_PROTO_IP;
 	*buff++ = NR_PROTO_IP;
diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
index 2f084b6f69d7e..97944db6b5ac6 100644
--- a/net/netrom/nr_in.c
+++ b/net/netrom/nr_in.c
@@ -97,7 +97,7 @@ static int nr_state1_machine(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -128,7 +128,7 @@ static int nr_state2_machine(struct sock *sk, struct sk_buff *skb,
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -262,7 +262,7 @@ static int nr_state3_machine(struct sock *sk, struct sk_buff *skb, int frametype
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit)
+		if (READ_ONCE(sysctl_netrom_reset_circuit))
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
diff --git a/net/netrom/nr_out.c b/net/netrom/nr_out.c
index 44929657f5b71..5e531394a724b 100644
--- a/net/netrom/nr_out.c
+++ b/net/netrom/nr_out.c
@@ -204,7 +204,7 @@ void nr_transmit_buffer(struct sock *sk, struct sk_buff *skb)
 	dptr[6] |= AX25_SSSID_SPARE;
 	dptr += AX25_ADDR_LEN;
 
-	*dptr++ = sysctl_netrom_network_ttl_initialiser;
+	*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	if (!nr_route_frame(skb, NULL)) {
 		kfree_skb(skb);
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index baea3cbd76ca5..70480869ad1c5 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -153,7 +153,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh->digipeat = NULL;
 		nr_neigh->ax25     = NULL;
 		nr_neigh->dev      = dev;
-		nr_neigh->quality  = sysctl_netrom_default_path_quality;
+		nr_neigh->quality  = READ_ONCE(sysctl_netrom_default_path_quality);
 		nr_neigh->locked   = 0;
 		nr_neigh->count    = 0;
 		nr_neigh->number   = nr_neigh_no++;
@@ -728,7 +728,7 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < sysctl_netrom_link_fails_count) {
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
 		nr_neigh_put(nr_neigh);
 		return;
 	}
@@ -766,7 +766,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	if (ax25 != NULL) {
 		ret = nr_add_node(nr_src, "", &ax25->dest_addr, ax25->digipeat,
 				  ax25->ax25_dev->dev, 0,
-				  sysctl_netrom_obsolescence_count_initialiser);
+				  READ_ONCE(sysctl_netrom_obsolescence_count_initialiser));
 		if (ret)
 			return ret;
 	}
@@ -780,7 +780,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		return ret;
 	}
 
-	if (!sysctl_netrom_routing_control && ax25 != NULL)
+	if (!READ_ONCE(sysctl_netrom_routing_control) && ax25 != NULL)
 		return 0;
 
 	/* Its Time-To-Live has expired */
diff --git a/net/netrom/nr_subr.c b/net/netrom/nr_subr.c
index e2d2af924cff4..c3bbd5880850b 100644
--- a/net/netrom/nr_subr.c
+++ b/net/netrom/nr_subr.c
@@ -182,7 +182,8 @@ void nr_write_internal(struct sock *sk, int frametype)
 		*dptr++ = nr->my_id;
 		*dptr++ = frametype;
 		*dptr++ = nr->window;
-		if (nr->bpqext) *dptr++ = sysctl_netrom_network_ttl_initialiser;
+		if (nr->bpqext)
+			*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 		break;
 
 	case NR_DISCREQ:
@@ -236,7 +237,7 @@ void __nr_transmit_reply(struct sk_buff *skb, int mine, unsigned char cmdflags)
 	dptr[6] |= AX25_SSSID_SPARE;
 	dptr += AX25_ADDR_LEN;
 
-	*dptr++ = sysctl_netrom_network_ttl_initialiser;
+	*dptr++ = READ_ONCE(sysctl_netrom_network_ttl_initialiser);
 
 	if (mine) {
 		*dptr++ = 0;
diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index fba82d36593ad..a4e3c5de998be 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -301,6 +301,9 @@ static int __rds_rdma_map(struct rds_sock *rs, struct rds_get_mr_args *args,
 			kfree(sg);
 		}
 		ret = PTR_ERR(trans_private);
+		/* Trigger connection so that its ready for the next retry */
+		if (ret == -ENODEV)
+			rds_conn_connect_if_down(cp->cp_conn);
 		goto out;
 	}
 
diff --git a/net/rds/send.c b/net/rds/send.c
index 5e57a1581dc60..2899def23865f 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1313,12 +1313,8 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 
 	/* Parse any control messages the user may have included. */
 	ret = rds_cmsg_send(rs, rm, msg, &allocated_mr, &vct);
-	if (ret) {
-		/* Trigger connection so that its ready for the next retry */
-		if (ret ==  -EAGAIN)
-			rds_conn_connect_if_down(conn);
+	if (ret)
 		goto out;
-	}
 
 	if (rm->rdma.op_active && !conn->c_trans->xmit_rdma) {
 		printk_ratelimited(KERN_NOTICE "rdma_op %p conn xmit_rdma %p\n",
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 3784534c91855..653e51ae39648 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
 
-	if (!x->type_offload || x->encap)
+	if (!x->type_offload)
 		return false;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c13dc3ef79107..e69d588caa0c6 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3416,7 +3416,7 @@ decode_session4(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 	}
 
 	fl4->flowi4_proto = flkeys->basic.ip_proto;
-	fl4->flowi4_tos = flkeys->ip.tos;
+	fl4->flowi4_tos = flkeys->ip.tos & ~INET_ECN_MASK;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index c3b45745cbccd..6d8b54124cb35 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -511,7 +511,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	if (!ASSERT_OK(err, "bond bpf_xdp_query"))
 		goto out;
 
-	if (!ASSERT_EQ(query_opts.feature_flags, NETDEV_XDP_ACT_MASK,
+	if (!ASSERT_EQ(query_opts.feature_flags, 0,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
@@ -601,7 +601,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	if (!ASSERT_OK(err, "bond bpf_xdp_query"))
 		goto out;
 
-	ASSERT_EQ(query_opts.feature_flags, NETDEV_XDP_ACT_MASK,
+	ASSERT_EQ(query_opts.feature_flags, 0,
 		  "bond query_opts.feature_flags");
 out:
 	bpf_link__destroy(link);
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 9096bf5794888..25693b37f820d 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -302,12 +302,12 @@ done
 
 setup
 run_test 10 10 0 0 "balanced bwidth"
-run_test 10 10 1 50 "balanced bwidth with unbalanced delay"
+run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 30 10 0 0 "unbalanced bwidth"
-run_test 30 10 1 50 "unbalanced bwidth with unbalanced delay"
-run_test 30 10 50 1 "unbalanced bwidth with opposed, unbalanced delay"
+run_test 10 3 0 0 "unbalanced bwidth"
+run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
+run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 
 mptcp_lib_result_print_all_tap
 exit $ret

