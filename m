Return-Path: <linux-kernel+bounces-98850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D70878040
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA6D1F220BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A053D0DF;
	Mon, 11 Mar 2024 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjUabZi5"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7483C478
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162232; cv=none; b=u52QkNIUCB8OUP7IVc1TnT5pB1WDIIB0RDv2BQtF1ZoTiEF9iRAM3ZcHYHSh9c3uM/fZFZKOxJ0aHcoKRVhYXRigUXGIGjFpH+dPbAUj6VZdstyS2VyjjO7mqx51DTAEW5AxTdbeNrJ5jEY8igZLs/ueaCj7UPpJKBfZ+Oj2J78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162232; c=relaxed/simple;
	bh=KPzThNqLU4dR9g6zlvqmlAfB7vhAf46VpkB9wLQ7nJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B7L+NkgKkd+tSzQYuJA2YFP79x+EkiYVY/Nfny0oGJcXSALNPsu+t0V7uLtKiS+dTD4KyCdEvIKCsbCrLlLvY6k98Quic0r3JV7yoGvMraTJ39E+PH9gxSCHVklDqySuCWRVxa+28G9zgWLZBif5m7zZ4EAXkP9EsklqpT8AIgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjUabZi5; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33e162b1b71so4125540f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710162227; x=1710767027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5uxpT0FtlzTG+ipC0C3GcR90MMItV0Ts5/pywOfSgo=;
        b=YjUabZi5BA56AZHU3x+UpsahtG+y48k0AoU0x0ynhPuCywY9wYKpUSRLFX9Y+faFrb
         uRkA8b5n/thDysJgmtyVXNYbCFcWJ+JhI9ZLlkPluiJM28HZNzqUTkoVFpzR+XLZdyJo
         ofH9Wisree8QI6iq9j8tlLSrz81gCT6QqYo4bbrJsD+a1D10koMoqAmIA/rzUoERwiMS
         gt+webU2tw5lop0/XKy2QdI8yMXC6JrX5A0945ZNnez3TNgBEUc7WoTex3uMUVw6akTB
         F7KwHGXtxrx0tfFmr9tgzz2rgn0JT72NaFEcgtiUU24KtPtwoiCeDH8KbtHpudWVZdWn
         wzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710162227; x=1710767027;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5uxpT0FtlzTG+ipC0C3GcR90MMItV0Ts5/pywOfSgo=;
        b=Jn/SDNmvEUBFSKsIo1UL4jLzW4m7igRyzohco4Ni4YgBtjop9SgU0maVoaqHCk0Fpf
         QsPb4EPM9WQHzSHz4Dk/SLnohqDuU0ys7+pH3Ok3HFmTc0cPV1LOvNNtatDwQ0GD5UF7
         VcItmOJHTFcQltqvJZAL4n6QwUzYzOkwTHm0vMDN9SaebEh27QDHGTXiFexn+IjJBBDw
         6gflS7d16p90XSH0ilsYGiY/SvVPXUuszE0diWdMCOAbQds8Yf1jT8zxkKKt5wfuvRof
         LMola4dgEfzr6C6SR091t251agyKukVqGm/xHf0GfNKMPjFGfnnjHgARMIPFqrWTbuon
         CWQA==
X-Gm-Message-State: AOJu0YyYb4O+/g6BgMGNbYyIZ1vquOK9WiPpjYOU8Df4EdnnMajsydJc
	dWA3FMSq5yCgF3IwuYIjs3u7mdZJoS1t7NLejDc7m21QlXYGgEab
X-Google-Smtp-Source: AGHT+IG1rLWZeFcKipxEtnII3YB464DE7qojdjFYx2dB6hlw18P6utXwSmuBdoPGS3hM5vSf2b1ipA==
X-Received: by 2002:adf:eccc:0:b0:33e:7e86:1ade with SMTP id s12-20020adfeccc000000b0033e7e861ademr4863134wro.10.1710162226665;
        Mon, 11 Mar 2024 06:03:46 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id ay16-20020a5d6f10000000b0033e45e4f22bsm6534544wrb.73.2024.03.11.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:03:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 11 Mar 2024 14:03:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/cleanups for v6.9
Message-ID: <Ze8BMARCnxKAt/VL@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

Please pull the latest x86/cleanups git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-2024-03-11

   # HEAD: 774a86f1c885460ade4334b901919fa1d8ae6ec6 x86/nmi: Drop unused declaration of proc_nmi_enabled()

Misc cleanups, including a large series from Thomas Gleixner to
cure Sparse warnings.

Heads-up for one of the commits which touches non-x86 architectures as 
well, to consolidate smp_prepare_boot_cpu() definitions:

   712610725c48 ("smp: Consolidate smp_prepare_boot_cpu()")

 Thanks,

	Ingo

------------------>
Kunwu Chan (1):
      x86/apm_32: Remove dead function apm_get_battery_status()

Randy Dunlap (1):
      x86/insn-eval: Fix function param name in get_eff_addr_sib()

Thomas Gleixner (9):
      perf/x86/amd/uncore: Fix __percpu annotation
      x86/msr: Prepare for including <linux/percpu.h> into <asm/msr.h>
      x86/msr: Add missing __percpu annotations
      smp: Consolidate smp_prepare_boot_cpu()
      x86/percpu: Cure per CPU madness on UP
      x86/uaccess: Add missing __force to casts in __access_ok() and valid_user_address()
      x86/cpu: Use EXPORT_PER_CPU_SYMBOL_GPL() for x86_spec_ctrl_current
      x86/cpu: Provide a declaration for itlb_multihit_kvm_mitigation
      x86/callthunks: Use EXPORT_PER_CPU_SYMBOL_GPL() for per CPU variables

Thomas Weiﬂschuh (1):
      x86/nmi: Drop unused declaration of proc_nmi_enabled()

Xin Li (Intel) (1):
      x86/nmi: Remove an unnecessary IS_ENABLED(CONFIG_SMP)


 arch/alpha/kernel/smp.c              |  5 -----
 arch/arc/kernel/smp.c                |  5 -----
 arch/csky/kernel/smp.c               |  4 ----
 arch/hexagon/kernel/smp.c            |  4 ----
 arch/openrisc/kernel/smp.c           |  4 ----
 arch/riscv/kernel/smpboot.c          |  4 ----
 arch/sparc/kernel/smp_64.c           |  4 ----
 arch/x86/events/amd/uncore.c         |  2 +-
 arch/x86/events/intel/core.c         |  1 +
 arch/x86/events/intel/ds.c           |  1 +
 arch/x86/include/asm/debugreg.h      | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/fsgsbase.h      |  2 +-
 arch/x86/include/asm/msr.h           | 26 ++++++++++++++------------
 arch/x86/include/asm/nmi.h           |  3 ---
 arch/x86/include/asm/processor.h     | 28 ----------------------------
 arch/x86/include/asm/smp.h           |  5 -----
 arch/x86/include/asm/spec-ctrl.h     |  2 ++
 arch/x86/include/asm/special_insns.h |  4 ++--
 arch/x86/include/asm/tsc.h           |  3 ++-
 arch/x86/include/asm/uaccess_64.h    |  7 ++++---
 arch/x86/kernel/apm_32.c             | 29 -----------------------------
 arch/x86/kernel/callthunks.c         |  4 ++--
 arch/x86/kernel/cpu/bugs.c           |  2 +-
 arch/x86/kernel/cpu/common.c         |  3 +++
 arch/x86/kernel/cpu/intel_pconfig.c  |  2 ++
 arch/x86/kernel/cpu/rdrand.c         |  1 +
 arch/x86/kernel/fpu/bugs.c           |  2 ++
 arch/x86/kernel/nmi.c                |  2 +-
 arch/x86/kernel/setup.c              | 10 ++++++++++
 arch/x86/kernel/smpboot.c            |  9 +++++----
 arch/x86/kernel/step.c               |  2 ++
 arch/x86/kvm/mmu/mmu.c               |  3 +--
 arch/x86/lib/insn-eval.c             |  6 +++---
 arch/x86/lib/msr-smp.c               | 12 +++++-------
 arch/x86/lib/msr.c                   |  6 +++---
 include/linux/smp.h                  | 13 ++++++-------
 init/main.c                          |  4 ++++
 37 files changed, 103 insertions(+), 145 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 7439b2377df5..8e9dd63b220c 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -467,11 +467,6 @@ smp_prepare_cpus(unsigned int max_cpus)
 	smp_num_cpus = smp_num_probed;
 }
 
-void
-smp_prepare_boot_cpu(void)
-{
-}
-
 int
 __cpu_up(unsigned int cpu, struct task_struct *tidle)
 {
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index 8d9b188caa27..b2f2c59279a6 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -39,11 +39,6 @@ struct plat_smp_ops  __weak plat_smp_ops;
 /* XXX: per cpu ? Only needed once in early secondary boot */
 struct task_struct *secondary_idle_tsk;
 
-/* Called from start_kernel */
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 static int __init arc_get_cpu_map(const char *name, struct cpumask *cpumask)
 {
 	unsigned long dt_root = of_get_flat_dt_root();
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 8e42352cbf12..92dbbf3e0205 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -152,10 +152,6 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 }
diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 608884bc3396..65e1fdf9fdb2 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -114,10 +114,6 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
 	local_irq_restore(flags);
 }
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 /*
  * interrupts should already be disabled from the VM
  * SP should already be correct; need to set THREADINFO_REG
diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 1c5a2d71d675..86da4bc5ee0b 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -57,10 +57,6 @@ static void boot_secondary(unsigned int cpu, struct task_struct *idle)
 	spin_unlock(&boot_lock);
 }
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_init_cpus(void)
 {
 	struct device_node *cpu;
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 519b6bd946e5..c4ed7d977f57 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -42,10 +42,6 @@
 
 static DECLARE_COMPLETION(cpu_running);
 
-void __init smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpuid;
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index f3969a3600db..a0cc9bb41a92 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1206,10 +1206,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 }
 
-void smp_prepare_boot_cpu(void)
-{
-}
-
 void __init smp_setup_processor_id(void)
 {
 	if (tlb_type == spitfire)
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 5bf03c575812..4ccb8fa483e6 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -71,7 +71,7 @@ union amd_uncore_info {
 };
 
 struct amd_uncore {
-	union amd_uncore_info * __percpu info;
+	union amd_uncore_info  __percpu *info;
 	struct amd_uncore_pmu *pmus;
 	unsigned int num_pmus;
 	bool init_done;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3804f21ab049..768d1414897f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -17,6 +17,7 @@
 #include <linux/kvm_host.h>
 
 #include <asm/cpufeature.h>
+#include <asm/debugreg.h>
 #include <asm/hardirq.h>
 #include <asm/intel-family.h>
 #include <asm/intel_pt.h>
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index d49d661ec0a7..2641ba620f12 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -5,6 +5,7 @@
 #include <linux/sched/clock.h>
 
 #include <asm/cpu_entry_area.h>
+#include <asm/debugreg.h>
 #include <asm/perf_event.h>
 #include <asm/tlbflush.h>
 #include <asm/insn.h>
diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 0cec92c430cc..fdbbbfec745a 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -5,7 +5,9 @@
 #include <linux/bug.h>
 #include <linux/percpu.h>
 #include <uapi/asm/debugreg.h>
+
 #include <asm/cpufeature.h>
+#include <asm/msr.h>
 
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
 
@@ -159,4 +161,26 @@ static inline unsigned long amd_get_dr_addr_mask(unsigned int dr)
 }
 #endif
 
+static inline unsigned long get_debugctlmsr(void)
+{
+	unsigned long debugctlmsr = 0;
+
+#ifndef CONFIG_X86_DEBUGCTLMSR
+	if (boot_cpu_data.x86 < 6)
+		return 0;
+#endif
+	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
+
+	return debugctlmsr;
+}
+
+static inline void update_debugctlmsr(unsigned long debugctlmsr)
+{
+#ifndef CONFIG_X86_DEBUGCTLMSR
+	if (boot_cpu_data.x86 < 6)
+		return;
+#endif
+	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
+}
+
 #endif /* _ASM_X86_DEBUGREG_H */
diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 35cff5f2becf..9e7e8ca8e299 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -6,7 +6,7 @@
 
 #ifdef CONFIG_X86_64
 
-#include <asm/msr-index.h>
+#include <asm/msr.h>
 
 /*
  * Read/write a task's FSBASE or GSBASE. This returns the value that
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 65ec1965cd28..4621e083af7b 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -12,11 +12,13 @@
 #include <uapi/asm/msr.h>
 #include <asm/shared/msr.h>
 
+#include <linux/percpu.h>
+
 struct msr_info {
-	u32 msr_no;
-	struct msr reg;
-	struct msr *msrs;
-	int err;
+	u32			msr_no;
+	struct msr		reg;
+	struct msr __percpu	*msrs;
+	int			err;
 };
 
 struct msr_regs_info {
@@ -305,8 +307,8 @@ static inline int wrmsrl_safe(u32 msr, u64 val)
 	return wrmsr_safe(msr, (u32)val,  (u32)(val >> 32));
 }
 
-struct msr *msrs_alloc(void);
-void msrs_free(struct msr *msrs);
+struct msr __percpu *msrs_alloc(void);
+void msrs_free(struct msr __percpu *msrs);
 int msr_set_bit(u32 msr, u8 bit);
 int msr_clear_bit(u32 msr, u8 bit);
 
@@ -315,8 +317,8 @@ int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
-void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
-void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
+void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
+void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
@@ -345,14 +347,14 @@ static inline int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 	return 0;
 }
 static inline void rdmsr_on_cpus(const struct cpumask *m, u32 msr_no,
-				struct msr *msrs)
+				struct msr __percpu *msrs)
 {
-	rdmsr_on_cpu(0, msr_no, &(msrs[0].l), &(msrs[0].h));
+	rdmsr_on_cpu(0, msr_no, raw_cpu_ptr(&msrs->l), raw_cpu_ptr(&msrs->h));
 }
 static inline void wrmsr_on_cpus(const struct cpumask *m, u32 msr_no,
-				struct msr *msrs)
+				struct msr __percpu *msrs)
 {
-	wrmsr_on_cpu(0, msr_no, msrs[0].l, msrs[0].h);
+	wrmsr_on_cpu(0, msr_no, raw_cpu_read(msrs->l), raw_cpu_read(msrs->h));
 }
 static inline int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no,
 				    u32 *l, u32 *h)
diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 5c5f1e56c404..41a0ebb699ec 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -14,9 +14,6 @@ extern void release_perfctr_nmi(unsigned int);
 extern int reserve_evntsel_nmi(unsigned int);
 extern void release_evntsel_nmi(unsigned int);
 
-struct ctl_table;
-extern int proc_nmi_enabled(struct ctl_table *, int ,
-			void __user *, size_t *, loff_t *);
 extern int unknown_nmi_panic;
 
 #endif /* CONFIG_X86_LOCAL_APIC */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 26620d7642a9..e2262aca6561 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -20,7 +20,6 @@ struct vm86;
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
-#include <asm/msr.h>
 #include <asm/desc_defs.h>
 #include <asm/nops.h>
 #include <asm/special_insns.h>
@@ -186,13 +185,8 @@ extern struct cpuinfo_x86	new_cpu_data;
 extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
 extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
 
-#ifdef CONFIG_SMP
 DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 #define cpu_data(cpu)		per_cpu(cpu_info, cpu)
-#else
-#define cpu_info		boot_cpu_data
-#define cpu_data(cpu)		boot_cpu_data
-#endif
 
 extern const struct seq_operations cpuinfo_op;
 
@@ -576,28 +570,6 @@ extern void cpu_init(void);
 extern void cpu_init_exception_handling(void);
 extern void cr4_init(void);
 
-static inline unsigned long get_debugctlmsr(void)
-{
-	unsigned long debugctlmsr = 0;
-
-#ifndef CONFIG_X86_DEBUGCTLMSR
-	if (boot_cpu_data.x86 < 6)
-		return 0;
-#endif
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
-
-	return debugctlmsr;
-}
-
-static inline void update_debugctlmsr(unsigned long debugctlmsr)
-{
-#ifndef CONFIG_X86_DEBUGCTLMSR
-	if (boot_cpu_data.x86 < 6)
-		return;
-#endif
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctlmsr);
-}
-
 extern void set_task_blockstep(struct task_struct *task, bool on);
 
 /* Boot loader type from the setup header: */
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed454f3..31edeab5ee88 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -59,11 +59,6 @@ static inline void stop_other_cpus(void)
 	smp_ops.stop_other_cpus(1);
 }
 
-static inline void smp_prepare_boot_cpu(void)
-{
-	smp_ops.smp_prepare_boot_cpu();
-}
-
 static inline void smp_prepare_cpus(unsigned int max_cpus)
 {
 	smp_ops.smp_prepare_cpus(max_cpus);
diff --git a/arch/x86/include/asm/spec-ctrl.h b/arch/x86/include/asm/spec-ctrl.h
index c648502e4535..658b690b2ccb 100644
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -96,4 +96,6 @@ static inline void speculative_store_bypass_ht_init(void) { }
 extern void speculation_ctrl_update(unsigned long tif);
 extern void speculation_ctrl_update_current(void);
 
+extern bool itlb_multihit_kvm_mitigation;
+
 #endif
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 48f8dd47cf68..f13df37c0060 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -2,11 +2,11 @@
 #ifndef _ASM_X86_SPECIAL_INSNS_H
 #define _ASM_X86_SPECIAL_INSNS_H
 
-
 #ifdef __KERNEL__
-
 #include <asm/nops.h>
 #include <asm/processor-flags.h>
+
+#include <linux/errno.h>
 #include <linux/irqflags.h>
 #include <linux/jump_label.h>
 
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 594fce0ca744..405efb3e4996 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -5,8 +5,9 @@
 #ifndef _ASM_X86_TSC_H
 #define _ASM_X86_TSC_H
 
-#include <asm/processor.h>
 #include <asm/cpufeature.h>
+#include <asm/processor.h>
+#include <asm/msr.h>
 
 /*
  * Standard way to access the cycle counter.
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index f2c02e4469cc..d2a0c2aa972c 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -54,7 +54,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
  * half and a user half.  When cast to a signed type, user pointers
  * are positive and kernel pointers are negative.
  */
-#define valid_user_address(x) ((long)(x) >= 0)
+#define valid_user_address(x) ((__force long)(x) >= 0)
 
 /*
  * User pointers can have tag bits on x86-64.  This scheme tolerates
@@ -87,8 +87,9 @@ static inline bool __access_ok(const void __user *ptr, unsigned long size)
 	if (__builtin_constant_p(size <= PAGE_SIZE) && size <= PAGE_SIZE) {
 		return valid_user_address(ptr);
 	} else {
-		unsigned long sum = size + (unsigned long)ptr;
-		return valid_user_address(sum) && sum >= (unsigned long)ptr;
+		unsigned long sum = size + (__force unsigned long)ptr;
+
+		return valid_user_address(sum) && sum >= (__force unsigned long)ptr;
 	}
 }
 #define __access_ok __access_ok
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 76a5ced278c2..b37ab1095707 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1055,35 +1055,6 @@ static int apm_get_power_status(u_short *status, u_short *bat, u_short *life)
 	return APM_SUCCESS;
 }
 
-#if 0
-static int apm_get_battery_status(u_short which, u_short *status,
-				  u_short *bat, u_short *life, u_short *nbat)
-{
-	u32 eax;
-	u32 ebx;
-	u32 ecx;
-	u32 edx;
-	u32 esi;
-
-	if (apm_info.connection_version < 0x0102) {
-		/* pretend we only have one battery. */
-		if (which != 1)
-			return APM_BAD_DEVICE;
-		*nbat = 1;
-		return apm_get_power_status(status, bat, life);
-	}
-
-	if (apm_bios_call(APM_FUNC_GET_STATUS, (0x8000 | (which)), 0, &eax,
-			  &ebx, &ecx, &edx, &esi))
-		return (eax >> 8) & 0xff;
-	*status = ebx;
-	*bat = ecx;
-	*life = edx;
-	*nbat = esi;
-	return APM_SUCCESS;
-}
-#endif
-
 /**
  *	apm_engage_power_management	-	enable PM on a device
  *	@device: identity of device
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 64ad2ddea121..aeccea2da91b 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -42,8 +42,8 @@ DEFINE_PER_CPU(u64, __x86_call_count);
 DEFINE_PER_CPU(u64, __x86_ret_count);
 DEFINE_PER_CPU(u64, __x86_stuffs_count);
 DEFINE_PER_CPU(u64, __x86_ctxsw_count);
-EXPORT_SYMBOL_GPL(__x86_ctxsw_count);
-EXPORT_SYMBOL_GPL(__x86_call_count);
+EXPORT_PER_CPU_SYMBOL_GPL(__x86_ctxsw_count);
+EXPORT_PER_CPU_SYMBOL_GPL(__x86_call_count);
 #endif
 
 extern s32 __call_sites[], __call_sites_end[];
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 48d049cd74e7..0767ab63ca63 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
 
 /* The current value of the SPEC_CTRL MSR with task-specific bits set */
 DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_current);
+EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 EXPORT_SYMBOL_GPL(x86_pred_cmd);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fbc4e60d027c..6057a9ecac93 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -70,6 +70,9 @@
 
 #include "cpu.h"
 
+DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
+EXPORT_PER_CPU_SYMBOL(cpu_info);
+
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
diff --git a/arch/x86/kernel/cpu/intel_pconfig.c b/arch/x86/kernel/cpu/intel_pconfig.c
index 0771a905b286..5be2b1790282 100644
--- a/arch/x86/kernel/cpu/intel_pconfig.c
+++ b/arch/x86/kernel/cpu/intel_pconfig.c
@@ -7,6 +7,8 @@
  * Author:
  *	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
  */
+#include <linux/bug.h>
+#include <linux/limits.h>
 
 #include <asm/cpufeature.h>
 #include <asm/intel_pconfig.h>
diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
index 26a427fa84ea..eeac00d20926 100644
--- a/arch/x86/kernel/cpu/rdrand.c
+++ b/arch/x86/kernel/cpu/rdrand.c
@@ -6,6 +6,7 @@
  * Authors: Fenghua Yu <fenghua.yu@intel.com>,
  *          H. Peter Anvin <hpa@linux.intel.com>
  */
+#include <linux/printk.h>
 
 #include <asm/processor.h>
 #include <asm/archrandom.h>
diff --git a/arch/x86/kernel/fpu/bugs.c b/arch/x86/kernel/fpu/bugs.c
index a06b876bbf2d..edbafc5940e3 100644
--- a/arch/x86/kernel/fpu/bugs.c
+++ b/arch/x86/kernel/fpu/bugs.c
@@ -2,6 +2,8 @@
 /*
  * x86 FPU bug checks:
  */
+#include <linux/printk.h>
+
 #include <asm/cpufeature.h>
 #include <asm/fpu/api.h>
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 3082cf24b69e..3de0772c65e3 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -502,7 +502,7 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU))
 		raw_atomic_long_inc(&nsp->idt_calls);
 
-	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id())) {
+	if (arch_cpu_is_offline(smp_processor_id())) {
 		if (microcode_nmi_handler_enabled())
 			microcode_offline_nmi_handler();
 		return;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 84201071dfac..8f669d3be445 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1211,6 +1211,16 @@ void __init i386_reserve_resources(void)
 
 #endif /* CONFIG_X86_32 */
 
+#ifndef CONFIG_SMP
+void __init smp_prepare_boot_cpu(void)
+{
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	*c = boot_cpu_data;
+	c->initialized = true;
+}
+#endif
+
 static struct notifier_block kernel_offset_notifier = {
 	.notifier_call = dump_kernel_offset
 };
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f57ce68a3f1..37ea8c872e4a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,10 +101,6 @@ EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 
-/* Per CPU bogomips and other parameters */
-DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
-EXPORT_PER_CPU_SYMBOL(cpu_info);
-
 /* CPUs which are the primary SMT threads */
 struct cpumask __cpu_primary_thread_mask __read_mostly;
 
@@ -1187,6 +1183,11 @@ void __init smp_prepare_cpus_common(void)
 	set_cpu_sibling_map(0);
 }
 
+void __init smp_prepare_boot_cpu(void)
+{
+	smp_ops.smp_prepare_boot_cpu();
+}
+
 #ifdef CONFIG_X86_64
 /* Establish whether parallel bringup can be supported. */
 bool __init arch_cpuhp_init_parallel_bringup(void)
diff --git a/arch/x86/kernel/step.c b/arch/x86/kernel/step.c
index 8e2b2552b5ee..3e2952679b88 100644
--- a/arch/x86/kernel/step.c
+++ b/arch/x86/kernel/step.c
@@ -6,7 +6,9 @@
 #include <linux/sched/task_stack.h>
 #include <linux/mm.h>
 #include <linux/ptrace.h>
+
 #include <asm/desc.h>
+#include <asm/debugreg.h>
 #include <asm/mmu_context.h>
 
 unsigned long convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2d6cdeab1f8a..3c89d3ebaa3a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -53,12 +53,11 @@
 #include <asm/cmpxchg.h>
 #include <asm/io.h>
 #include <asm/set_memory.h>
+#include <asm/spec-ctrl.h>
 #include <asm/vmx.h>
 
 #include "trace.h"
 
-extern bool itlb_multihit_kvm_mitigation;
-
 static bool nx_hugepage_mitigation_hard_disabled;
 
 int __read_mostly nx_huge_pages = -1;
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 558a605929db..98631c0e7a11 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1129,15 +1129,15 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
  * get_eff_addr_sib() - Obtain referenced effective address via SIB
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Obtained operand offset, in pt_regs, associated with segment
+ * @base_offset: Obtained operand offset, in pt_regs, associated with segment
  * @eff_addr:	Obtained effective address
  *
  * Obtain the effective address referenced by the SIB byte of @insn. After
  * identifying the registers involved in the indexed, register-indirect memory
  * reference, its value is obtained from the operands in @regs. The computed
  * address is stored @eff_addr. Also, the register operand that indicates the
- * associated segment is stored in @regoff, this parameter can later be used to
- * determine such segment.
+ * associated segment is stored in @base_offset; this parameter can later be
+ * used to determine such segment.
  *
  * Returns:
  *
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 40bbe56bde32..acd463d887e1 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -9,10 +9,9 @@ static void __rdmsr_on_cpu(void *info)
 {
 	struct msr_info *rv = info;
 	struct msr *reg;
-	int this_cpu = raw_smp_processor_id();
 
 	if (rv->msrs)
-		reg = per_cpu_ptr(rv->msrs, this_cpu);
+		reg = this_cpu_ptr(rv->msrs);
 	else
 		reg = &rv->reg;
 
@@ -23,10 +22,9 @@ static void __wrmsr_on_cpu(void *info)
 {
 	struct msr_info *rv = info;
 	struct msr *reg;
-	int this_cpu = raw_smp_processor_id();
 
 	if (rv->msrs)
-		reg = per_cpu_ptr(rv->msrs, this_cpu);
+		reg = this_cpu_ptr(rv->msrs);
 	else
 		reg = &rv->reg;
 
@@ -97,7 +95,7 @@ int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 EXPORT_SYMBOL(wrmsrl_on_cpu);
 
 static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
-			    struct msr *msrs,
+			    struct msr __percpu *msrs,
 			    void (*msr_func) (void *info))
 {
 	struct msr_info rv;
@@ -124,7 +122,7 @@ static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
  * @msrs:       array of MSR values
  *
  */
-void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
+void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs)
 {
 	__rwmsr_on_cpus(mask, msr_no, msrs, __rdmsr_on_cpu);
 }
@@ -138,7 +136,7 @@ EXPORT_SYMBOL(rdmsr_on_cpus);
  * @msrs:       array of MSR values
  *
  */
-void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
+void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs)
 {
 	__rwmsr_on_cpus(mask, msr_no, msrs, __wrmsr_on_cpu);
 }
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 47fd9bd6b91d..4bf4fad5b148 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -6,9 +6,9 @@
 #define CREATE_TRACE_POINTS
 #include <asm/msr-trace.h>
 
-struct msr *msrs_alloc(void)
+struct msr __percpu *msrs_alloc(void)
 {
-	struct msr *msrs = NULL;
+	struct msr __percpu *msrs = NULL;
 
 	msrs = alloc_percpu(struct msr);
 	if (!msrs) {
@@ -20,7 +20,7 @@ struct msr *msrs_alloc(void)
 }
 EXPORT_SYMBOL(msrs_alloc);
 
-void msrs_free(struct msr *msrs)
+void msrs_free(struct msr __percpu *msrs)
 {
 	free_percpu(msrs);
 }
diff --git a/include/linux/smp.h b/include/linux/smp.h
index e87520dc2959..b84592950149 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -105,6 +105,12 @@ static inline void on_each_cpu_cond(smp_cond_func_t cond_func,
 	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
 }
 
+/*
+ * Architecture specific boot CPU setup.  Defined as empty weak function in
+ * init/main.c. Architectures can override it.
+ */
+void smp_prepare_boot_cpu(void);
+
 #ifdef CONFIG_SMP
 
 #include <linux/preempt.h>
@@ -171,12 +177,6 @@ void generic_smp_call_function_single_interrupt(void);
 #define generic_smp_call_function_interrupt \
 	generic_smp_call_function_single_interrupt
 
-/*
- * Mark the boot cpu "online" so that it can call console drivers in
- * printk() and can access its per-cpu storage.
- */
-void smp_prepare_boot_cpu(void);
-
 extern unsigned int setup_max_cpus;
 extern void __init setup_nr_cpu_ids(void);
 extern void __init smp_init(void);
@@ -203,7 +203,6 @@ static inline void up_smp_call_function(smp_call_func_t func, void *info)
 			(up_smp_call_function(func, info))
 
 static inline void smp_send_reschedule(int cpu) { }
-#define smp_prepare_boot_cpu()			do {} while (0)
 #define smp_call_function_many(mask, func, info, wait) \
 			(up_smp_call_function(func, info))
 static inline void call_function_init(void) { }
diff --git a/init/main.c b/init/main.c
index e24b0780fdff..d60bc4b23dd4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -776,6 +776,10 @@ void __init __weak smp_setup_processor_id(void)
 {
 }
 
+void __init __weak smp_prepare_boot_cpu(void)
+{
+}
+
 # if THREAD_SIZE >= PAGE_SIZE
 void __init __weak thread_stack_cache_init(void)
 {

