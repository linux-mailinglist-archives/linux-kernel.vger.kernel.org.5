Return-Path: <linux-kernel+bounces-16108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6559882390E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8561F2557B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD402200D6;
	Wed,  3 Jan 2024 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZacJLpO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C93F200C6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 23:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DDBC433C8;
	Wed,  3 Jan 2024 23:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704323779;
	bh=Gr90VWCG4SEvfPBl+lUpDKdA7y5+PFDPIALUlbQNMzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZacJLpOn2XOmpLX7LR9Y71UrV33x6V6CyvVS9O7iKXSYy0AZPqE3FL2frJhqw5Nw
	 JYnTNuUx3cXtpICUiifZty0kBy2YIoBfiQKk6GIPsBqgDH6ckEAxB3DfQ/VevScRHK
	 hVUXhCP6/TbwDGWh4ZNB4ie8UB/guE5Ywenf8uLO+wTFaQhOTPKpMQUn9uyN44GMjY
	 dVOVRPnRxjHYXo7vo7fUhto8AfePxvkD83gH9m6rkGReU7GnfRUNOhmjfPXmrvAkvB
	 UM8NQJ7xsJE2yk6DrkcUUaoMWlGr/Er5S0CCwJlJHodjlaT1t8W5v5pTomZb4BF+mR
	 T+OOY48t4Tefw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/8] arm64: Fix typos
Date: Wed,  3 Jan 2024 17:16:00 -0600
Message-Id: <20240103231605.1801364-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103231605.1801364-1-helgaas@kernel.org>
References: <20240103231605.1801364-1-helgaas@kernel.org>
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
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig                  | 2 +-
 arch/arm64/include/asm/assembler.h  | 4 ++--
 arch/arm64/include/asm/cpufeature.h | 4 ++--
 arch/arm64/include/asm/pgtable.h    | 2 +-
 arch/arm64/include/asm/suspend.h    | 2 +-
 arch/arm64/include/asm/traps.h      | 4 ++--
 arch/arm64/kernel/acpi.c            | 2 +-
 arch/arm64/kernel/cpufeature.c      | 6 +++---
 arch/arm64/kernel/entry-common.c    | 2 +-
 arch/arm64/kernel/entry-ftrace.S    | 2 +-
 arch/arm64/kernel/entry.S           | 2 +-
 arch/arm64/kernel/ftrace.c          | 2 +-
 arch/arm64/kernel/machine_kexec.c   | 2 +-
 arch/arm64/kernel/probes/uprobes.c  | 2 +-
 arch/arm64/kernel/sdei.c            | 2 +-
 arch/arm64/kernel/smp.c             | 2 +-
 arch/arm64/kernel/traps.c           | 2 +-
 17 files changed, 22 insertions(+), 22 deletions(-)

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
-- 
2.34.1


