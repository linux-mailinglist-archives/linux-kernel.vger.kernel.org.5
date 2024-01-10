Return-Path: <linux-kernel+bounces-21945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB58296FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB2D1C21B61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D83C41233;
	Wed, 10 Jan 2024 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FmBrsavJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F277aOi9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B53FB39;
	Wed, 10 Jan 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jan 2024 10:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QfUQzBLnVma/XOVZ8PBrb6MYamrM9cvnTDaM4lMSu4=;
	b=FmBrsavJXdVoCr0agzrjNZeo2BkNxsM3ZZivfP8lt/zNBFqqFMqxOHFsVPZxX//b8oQPQj
	ShvBt0LErfpd0Wd/N7PShU1x+Puvtt3K6AdUxDUfPvWCnHxk+G1nHtljOdlY/T7SJjbr5q
	tn6kKARouVI1EnEhv5A/Phjn1HsHdlO7RULqSmJuyo7ZgzfY13QXgAnsTor2qbZkMoBoAe
	ASW7zAt58YNeabe9QhZ6RfpEQgADas1Yx7mvsLtUHg5eXlb6ZcsoKywWUAZ67VW1UZb0/B
	koFhKet1yVcJkr7hycvY61GbDVahDpHDBc6x2LdSRihA6ysPrdxn17GkWgpVXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QfUQzBLnVma/XOVZ8PBrb6MYamrM9cvnTDaM4lMSu4=;
	b=F277aOi9FpU9kMzqbiTFCprvZJU91vRh+PkNMng+KWt+eWrEQMM5nl1WMFuT7f/J3g1lSW
	g1UhhQBNHKE6UlCQ==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Rename CONFIG_PAGE_TABLE_ISOLATION =>
 CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121160740.1249350-5-leitao@debian.org>
References: <20231121160740.1249350-5-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170488139284.398.10268086166782021307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     ea4654e0885348f0faa47f6d7b44a08d75ad16e9
Gitweb:        https://git.kernel.org/tip/ea4654e0885348f0faa47f6d7b44a08d75ad16e9
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Nov 2023 08:07:31 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Jan 2024 10:52:28 +01:00

x86/bugs: Rename CONFIG_PAGE_TABLE_ISOLATION => CONFIG_MITIGATION_PAGE_TABLE_ISOLATION

Step 4/10 of the namespace unification of CPU mitigations related Kconfig options.

[ mingo: Converted new uses that got added since the series was posted. ]

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231121160740.1249350-5-leitao@debian.org
---
 Documentation/arch/x86/pti.rst                 |  6 +++---
 arch/x86/Kconfig                               |  2 +-
 arch/x86/boot/compressed/ident_map_64.c        |  4 ++--
 arch/x86/entry/calling.h                       |  8 ++++----
 arch/x86/entry/entry_64.S                      |  6 +++---
 arch/x86/include/asm/disabled-features.h       |  2 +-
 arch/x86/include/asm/pgalloc.h                 |  2 +-
 arch/x86/include/asm/pgtable-3level.h          |  2 +-
 arch/x86/include/asm/pgtable.h                 | 18 ++++++++---------
 arch/x86/include/asm/pgtable_64.h              |  3 ++-
 arch/x86/include/asm/processor-flags.h         |  2 +-
 arch/x86/include/asm/pti.h                     |  2 +-
 arch/x86/kernel/dumpstack.c                    |  2 +-
 arch/x86/kernel/head_32.S                      |  4 ++--
 arch/x86/kernel/head_64.S                      |  2 +-
 arch/x86/kernel/ldt.c                          |  8 ++++----
 arch/x86/mm/Makefile                           |  2 +-
 arch/x86/mm/debug_pagetables.c                 |  4 ++--
 arch/x86/mm/dump_pagetables.c                  |  4 ++--
 arch/x86/mm/pgtable.c                          |  4 ++--
 arch/x86/mm/tlb.c                              | 10 ++++-----
 include/linux/pti.h                            |  2 +-
 tools/arch/x86/include/asm/disabled-features.h |  2 +-
 23 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/Documentation/arch/x86/pti.rst b/Documentation/arch/x86/pti.rst
index e08d351..57e8392 100644
--- a/Documentation/arch/x86/pti.rst
+++ b/Documentation/arch/x86/pti.rst
@@ -26,9 +26,9 @@ comments in pti.c).
 
 This approach helps to ensure that side-channel attacks leveraging
 the paging structures do not function when PTI is enabled.  It can be
-enabled by setting CONFIG_PAGE_TABLE_ISOLATION=y at compile time.
-Once enabled at compile-time, it can be disabled at boot with the
-'nopti' or 'pti=' kernel parameters (see kernel-parameters.txt).
+enabled by setting CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=y at compile
+time.  Once enabled at compile-time, it can be disabled at boot with
+the 'nopti' or 'pti=' kernel parameters (see kernel-parameters.txt).
 
 Page Table Management
 =====================
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b4a703d..a1c0470 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2484,7 +2484,7 @@ menuconfig SPECULATION_MITIGATIONS
 
 if SPECULATION_MITIGATIONS
 
-config PAGE_TABLE_ISOLATION
+config MITIGATION_PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
 	default y
 	depends on (X86_64 || X86_PAE)
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index d040080..ff09ca6 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -8,8 +8,8 @@
  * Copyright (C)      2016  Kees Cook
  */
 
-/* No PAGE_TABLE_ISOLATION support needed either: */
-#undef CONFIG_PAGE_TABLE_ISOLATION
+/* No MITIGATION_PAGE_TABLE_ISOLATION support needed either: */
+#undef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 
 #include "error.h"
 #include "misc.h"
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9f1d947..7ac2d6f 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -142,10 +142,10 @@ For 32-bit we have the following conventions - kernel is built with
 	.endif
 .endm
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 
 /*
- * PAGE_TABLE_ISOLATION PGDs are 8k.  Flip bit 12 to switch between the two
+ * MITIGATION_PAGE_TABLE_ISOLATION PGDs are 8k.  Flip bit 12 to switch between the two
  * halves:
  */
 #define PTI_USER_PGTABLE_BIT		PAGE_SHIFT
@@ -160,7 +160,7 @@ For 32-bit we have the following conventions - kernel is built with
 
 .macro ADJUST_KERNEL_CR3 reg:req
 	ALTERNATIVE "", "SET_NOFLUSH_BIT \reg", X86_FEATURE_PCID
-	/* Clear PCID and "PAGE_TABLE_ISOLATION bit", point CR3 at kernel pagetables: */
+	/* Clear PCID and "MITIGATION_PAGE_TABLE_ISOLATION bit", point CR3 at kernel pagetables: */
 	andq    $(~PTI_USER_PGTABLE_AND_PCID_MASK), \reg
 .endm
 
@@ -275,7 +275,7 @@ For 32-bit we have the following conventions - kernel is built with
 .Lend_\@:
 .endm
 
-#else /* CONFIG_PAGE_TABLE_ISOLATION=n: */
+#else /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=n: */
 
 .macro SWITCH_TO_KERNEL_CR3 scratch_reg:req
 .endm
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c40f89a..d08cb38 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -562,7 +562,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 #ifdef CONFIG_XEN_PV
 	ALTERNATIVE "", "jmp xenpv_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 #endif
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	ALTERNATIVE "", "jmp .Lpti_restore_regs_and_return_to_usermode", X86_FEATURE_PTI
 #endif
 
@@ -578,7 +578,7 @@ SYM_INNER_LABEL(swapgs_restore_regs_and_return_to_usermode, SYM_L_GLOBAL)
 	jnz	.Lnative_iret
 	ud2
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 .Lpti_restore_regs_and_return_to_usermode:
 	POP_REGS pop_rdi=0
 
@@ -1096,7 +1096,7 @@ SYM_CODE_END(error_return)
  *
  * Registers:
  *	%r14: Used to save/restore the CR3 of the interrupted context
- *	      when PAGE_TABLE_ISOLATION is in use.  Do not clobber.
+ *	      when MITIGATION_PAGE_TABLE_ISOLATION is in use.  Do not clobber.
  */
 SYM_CODE_START(asm_exc_nmi)
 	UNWIND_HINT_IRET_ENTRY
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index c1d3a57..fb604ec 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -44,7 +44,7 @@
 # define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
 #endif
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 # define DISABLE_PTI		0
 #else
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c7ec5bb..dcd836b 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -34,7 +34,7 @@ static inline void paravirt_release_p4d(unsigned long pfn) {}
  */
 extern gfp_t __userpte_alloc_gfp;
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
  * Instead of one PGD, we acquire two PGDs.  Being order-1, it is
  * both 8k in size and 8k-aligned.  That lets us just flip bit 12
diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 9e7c0b7..dabafba 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -52,7 +52,7 @@ static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	pud.p4d.pgd = pti_set_user_pgtbl(&pudp->p4d.pgd, pud.p4d.pgd);
 #endif
 	pxx_xchg64(pud, pudp, native_pud_val(pud));
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 9d077bc..df0f7d4 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -909,7 +909,7 @@ static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
 pmd_t *populate_extra_pmd(unsigned long vaddr);
 pte_t *populate_extra_pte(unsigned long vaddr);
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
 
 /*
@@ -923,12 +923,12 @@ static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 		return pgd;
 	return __pti_set_user_pgtbl(pgdp, pgd);
 }
-#else   /* CONFIG_PAGE_TABLE_ISOLATION */
+#else   /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	return pgd;
 }
-#endif  /* CONFIG_PAGE_TABLE_ISOLATION */
+#endif  /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 
 #endif	/* __ASSEMBLY__ */
 
@@ -1131,7 +1131,7 @@ static inline int p4d_bad(p4d_t p4d)
 {
 	unsigned long ignore_flags = _KERNPG_TABLE | _PAGE_USER;
 
-	if (IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
+	if (IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION))
 		ignore_flags |= _PAGE_NX;
 
 	return (p4d_flags(p4d) & ~ignore_flags) != 0;
@@ -1177,7 +1177,7 @@ static inline int pgd_bad(pgd_t pgd)
 	if (!pgtable_l5_enabled())
 		return 0;
 
-	if (IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
+	if (IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION))
 		ignore_flags |= _PAGE_NX;
 
 	return (pgd_flags(pgd) & ~ignore_flags) != _KERNPG_TABLE;
@@ -1422,9 +1422,9 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 #define pgd_leaf	pgd_large
 static inline int pgd_large(pgd_t pgd) { return 0; }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
- * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
+ * All top-level MITIGATION_PAGE_TABLE_ISOLATION page tables are order-1 pages
  * (8k-aligned and 8k in size).  The kernel one is at the beginning 4k and
  * the user one is in the last 4k.  To switch between them, you
  * just need to flip the 12th bit in their addresses.
@@ -1469,7 +1469,7 @@ static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
 {
 	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
 }
-#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+#endif /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
@@ -1484,7 +1484,7 @@ static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
 static inline void clone_pgd_range(pgd_t *dst, pgd_t *src, int count)
 {
 	memcpy(dst, src, count * sizeof(pgd_t));
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
 	/* Clone the user space pgd as well */
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 24af25b..7e9db77 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -143,7 +143,8 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
 
-	if (pgtable_l5_enabled() || !IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION)) {
+	if (pgtable_l5_enabled() ||
+	    !IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)) {
 		WRITE_ONCE(*p4dp, p4d);
 		return;
 	}
diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index d8cccad..e5f204b 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -51,7 +51,7 @@
 #define CR3_NOFLUSH	0
 #endif
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 # define X86_CR3_PTI_PCID_USER_BIT	11
 #endif
 
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 07375b4..ab167c9 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -3,7 +3,7 @@
 #define _ASM_X86_PTI_H
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 extern void pti_init(void);
 extern void pti_check_boottime_disable(void);
 extern void pti_finalize(void);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index f18ca44..44a91ef 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -410,7 +410,7 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
-	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
+	       IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION) ?
 	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
 }
 NOKPROBE_SYMBOL(__die_header);
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 487ac57..b50f364 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -414,7 +414,7 @@ __REFDATA
 	.align 4
 SYM_DATA(initial_code,		.long i386_start_kernel)
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 #define	PGD_ALIGN	(2 * PAGE_SIZE)
 #define PTI_USER_PGD_FILL	1024
 #else
@@ -474,7 +474,7 @@ SYM_DATA_START(initial_page_table)
 # endif
 	.align PAGE_SIZE		/* needs to be page-sized too */
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	/*
 	 * PTI needs another page so sync_initial_pagetable() works correctly
 	 * and does not scribble over the data which is placed behind the
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d4918d0..cd54313 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -622,7 +622,7 @@ SYM_CODE_END(vc_no_ghcb)
 #define SYM_DATA_START_PAGE_ALIGNED(name)			\
 	SYM_START(name, SYM_L_GLOBAL, .balign PAGE_SIZE)
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
  * Each PGD needs to be 8k long and 8k aligned.  We do not
  * ever go out to userspace with these, so we do not
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 7a814b4..0f19ef3 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -184,7 +184,7 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 	return new_ldt;
 }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 
 static void do_sanity_check(struct mm_struct *mm,
 			    bool had_kernel_mapping,
@@ -377,7 +377,7 @@ static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, false);
 }
 
-#else /* !CONFIG_PAGE_TABLE_ISOLATION */
+#else /* !CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 
 static int
 map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
@@ -388,11 +388,11 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
 {
 }
-#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+#endif /* CONFIG_MITIGATION_PAGE_TABLE_ISOLATION */
 
 static void free_ldt_pgtables(struct mm_struct *mm)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	struct mmu_gather tlb;
 	unsigned long start = LDT_BASE_ADDR;
 	unsigned long end = LDT_END_ADDR;
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc..031cd10 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
-obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
+obj-$(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION)	+= pti.o
 
 obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index b43301c..ae5c213 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -22,7 +22,7 @@ static int ptdump_curknl_show(struct seq_file *m, void *v)
 
 DEFINE_SHOW_ATTRIBUTE(ptdump_curknl);
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 static int ptdump_curusr_show(struct seq_file *m, void *v)
 {
 	if (current->mm->pgd)
@@ -54,7 +54,7 @@ static int __init pt_dump_debug_init(void)
 	debugfs_create_file("current_kernel", 0400, dir, NULL,
 			    &ptdump_curknl_fops);
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	debugfs_create_file("current_user", 0400, dir, NULL,
 			    &ptdump_curusr_fops);
 #endif
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e1b599e..b7b88c1 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -408,7 +408,7 @@ void ptdump_walk_pgd_level_debugfs(struct seq_file *m, struct mm_struct *mm,
 				   bool user)
 {
 	pgd_t *pgd = mm->pgd;
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	if (user && boot_cpu_has(X86_FEATURE_PTI))
 		pgd = kernel_to_user_pgdp(pgd);
 #endif
@@ -418,7 +418,7 @@ EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
 
 void ptdump_walk_user_pgd_level_checkwx(void)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	pgd_t *pgd = INIT_PGD;
 
 	if (!(__supported_pte_mask & _PAGE_NX) ||
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 0cbc1b8..cceb779 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -293,7 +293,7 @@ static void pgd_mop_up_pmds(struct mm_struct *mm, pgd_t *pgdp)
 	for (i = 0; i < PREALLOCATED_PMDS; i++)
 		mop_up_one_pmd(mm, &pgdp[i]);
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
@@ -325,7 +325,7 @@ static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
 	}
 }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
 				     pgd_t *k_pgd, pmd_t *pmds[])
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5768d38..4af9309 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -89,10 +89,10 @@
 #define CR3_HW_ASID_BITS		12
 
 /*
- * When enabled, PAGE_TABLE_ISOLATION consumes a single bit for
+ * When enabled, MITIGATION_PAGE_TABLE_ISOLATION consumes a single bit for
  * user/kernel switches
  */
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 # define PTI_CONSUMED_PCID_BITS	1
 #else
 # define PTI_CONSUMED_PCID_BITS	0
@@ -114,7 +114,7 @@ static inline u16 kern_pcid(u16 asid)
 {
 	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	/*
 	 * Make sure that the dynamic ASID space does not conflict with the
 	 * bit we are using to switch between user and kernel ASIDs.
@@ -149,7 +149,7 @@ static inline u16 kern_pcid(u16 asid)
 static inline u16 user_pcid(u16 asid)
 {
 	u16 ret = kern_pcid(asid);
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 	ret |= 1 << X86_CR3_PTI_PCID_USER_BIT;
 #endif
 	return ret;
@@ -262,7 +262,7 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 static inline void invalidate_user_asid(u16 asid)
 {
 	/* There is no user ASID if address space separation is off */
-	if (!IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION))
+	if (!IS_ENABLED(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION))
 		return;
 
 	/*
diff --git a/include/linux/pti.h b/include/linux/pti.h
index 1a941ef..1fbf9d6 100644
--- a/include/linux/pti.h
+++ b/include/linux/pti.h
@@ -2,7 +2,7 @@
 #ifndef _INCLUDE_PTI_H
 #define _INCLUDE_PTI_H
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 #include <asm/pti.h>
 #else
 static inline void pti_init(void) { }
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index c1d3a57..fb604ec 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -44,7 +44,7 @@
 # define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
 #endif
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 # define DISABLE_PTI		0
 #else
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))

