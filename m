Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB6812EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444018AbjLNLg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443988AbjLNLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:36:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D60E131;
        Thu, 14 Dec 2023 03:36:50 -0800 (PST)
Date:   Thu, 14 Dec 2023 11:36:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702553808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9JJ5IHsGtzu7Ov9swAOawGU2uKy2b6/e/AvUWDZtwc=;
        b=SWDWTqBMYrxdQKh7OJ4Ijs02sgLwgp8rwEkcyROKWpOxjYxaw9McWkFrvRDZtO6wZOp6dO
        X9Kyd7wFcBls0+16l+gxf40IrAcJPidwr3fms14P2KNYsWSGwQhqeF6WVgPCzmtVq6q4yS
        mkqVnKob2n8rf6J/x9Cx2CmlR+0FmAtcf1doiiR167RMpQTlgWQ3rDbTZUkstk+BC6stR+
        oSdMFMXvViBQNsM1/NzIqW7Fk1pskwYRMIgOTOhE0saTdopnFY5sXHRwgm/Gqe5ZH3bnBp
        fCv4AH/F6zCOZJDbv3OSAYExyxaRVn7lICWPMW2oY1UC/qpgbDtJkujsrtQ8JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702553808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9JJ5IHsGtzu7Ov9swAOawGU2uKy2b6/e/AvUWDZtwc=;
        b=cO1my/X6MSKYJ5WxdksaKOt/0b0zeCgrjtUMc3pwJIQHEYNnjGv3e4P9CvA/gRHiC2XJAx
        Jiit0rgii6fLZYDQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Remove no longer needed paravirt
 patching code
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231210062138.2417-6-jgross@suse.com>
References: <20231210062138.2417-6-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <170255380742.398.5480687189928914311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     f7af6977621a41661696d94c0c0a20c761404476
Gitweb:        https://git.kernel.org/tip/f7af6977621a41661696d94c0c0a20c761404476
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Sun, 10 Dec 2023 07:21:38 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 10 Dec 2023 23:34:37 +01:00

x86/paravirt: Remove no longer needed paravirt patching code

Now that paravirt is using the alternatives patching infrastructure,
remove the paravirt patching code.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231210062138.2417-6-jgross@suse.com
---
 arch/x86/include/asm/paravirt.h       | 13 +-----
 arch/x86/include/asm/paravirt_types.h | 38 +---------------
 arch/x86/include/asm/text-patching.h  | 12 +-----
 arch/x86/kernel/alternative.c         | 67 +--------------------------
 arch/x86/kernel/paravirt.c            | 30 +------------
 arch/x86/kernel/vmlinux.lds.S         | 13 +-----
 arch/x86/tools/relocs.c               |  2 +-
 7 files changed, 3 insertions(+), 172 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 973c2ac..8bcf758 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -725,23 +725,10 @@ void native_pv_lock_init(void) __init;
 
 #else  /* __ASSEMBLY__ */
 
-#define _PVSITE(ptype, ops)			\
-771:;						\
-	ops;					\
-772:;						\
-	.pushsection .parainstructions,"a";	\
-	 .long 771b-.;				\
-	 .byte ptype;				\
-	 .byte 772b-771b;			\
-	.popsection
-
-
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_PARAVIRT_XXL
 #ifdef CONFIG_DEBUG_ENTRY
 
-#define PARA_PATCH(off)		((off) / 8)
-#define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
 .macro PARA_IRQ_save_fl
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 9cad536..d8e85d2 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -2,15 +2,6 @@
 #ifndef _ASM_X86_PARAVIRT_TYPES_H
 #define _ASM_X86_PARAVIRT_TYPES_H
 
-#ifndef __ASSEMBLY__
-/* These all sit in the .parainstructions section to tell us what to patch. */
-struct paravirt_patch_site {
-	s32 instr_offset;	/* original instructions */
-	u8 type;		/* type of this instruction */
-	u8 len;			/* length of original instruction */
-} __packed;
-#endif
-
 #ifdef CONFIG_PARAVIRT
 
 #ifndef __ASSEMBLY__
@@ -250,32 +241,6 @@ struct paravirt_patch_template {
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
 
-#define PARAVIRT_PATCH(x)					\
-	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
-
-#define paravirt_type(op)				\
-	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "m" (pv_ops.op)
-/*
- * Generate some code, and mark it as patchable by the
- * apply_paravirt() alternate instruction patcher.
- */
-#define _paravirt_alt(insn_string, type)		\
-	"771:\n\t" insn_string "\n" "772:\n"		\
-	".pushsection .parainstructions,\"a\"\n"	\
-	"  .long 771b-.\n"				\
-	"  .byte " type "\n"				\
-	"  .byte 772b-771b\n"				\
-	".popsection\n"
-
-/* Generate patchable code, with the default asm parameters. */
-#define paravirt_alt(insn_string)					\
-	_paravirt_alt(insn_string, "%c[paravirt_typenum]")
-
-/* Simple instruction patching code. */
-#define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
-
-unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr, unsigned int len);
 #define paravirt_ptr(op)	[paravirt_opptr] "m" (pv_ops.op)
 
 int paravirt_disable_iospace(void);
@@ -555,9 +520,6 @@ unsigned long pv_native_read_cr2(void);
 
 #define paravirt_nop	((void *)nop_func)
 
-extern struct paravirt_patch_site __parainstructions[],
-	__parainstructions_end[];
-
 #endif	/* __ASSEMBLY__ */
 
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 29832c3..0b70653 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -6,18 +6,6 @@
 #include <linux/stddef.h>
 #include <asm/ptrace.h>
 
-struct paravirt_patch_site;
-#ifdef CONFIG_PARAVIRT
-void apply_paravirt(struct paravirt_patch_site *start,
-		    struct paravirt_patch_site *end);
-#else
-static inline void apply_paravirt(struct paravirt_patch_site *start,
-				  struct paravirt_patch_site *end)
-{}
-#define __parainstructions	NULL
-#define __parainstructions_end	NULL
-#endif
-
 /*
  * Currently, the max observed size in the kernel code is
  * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 48938bc..f26983a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1472,48 +1472,6 @@ int alternatives_text_reserved(void *start, void *end)
 }
 #endif /* CONFIG_SMP */
 
-#ifdef CONFIG_PARAVIRT
-
-/* Use this to add nops to a buffer, then text_poke the whole buffer. */
-static void __init_or_module add_nops(void *insns, unsigned int len)
-{
-	while (len > 0) {
-		unsigned int noplen = len;
-		if (noplen > ASM_NOP_MAX)
-			noplen = ASM_NOP_MAX;
-		memcpy(insns, x86_nops[noplen], noplen);
-		insns += noplen;
-		len -= noplen;
-	}
-}
-
-void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
-				     struct paravirt_patch_site *end)
-{
-	struct paravirt_patch_site *p;
-	char insn_buff[MAX_PATCH_LEN];
-	u8 *instr;
-
-	for (p = start; p < end; p++) {
-		unsigned int used;
-
-		instr = (u8 *)&p->instr_offset + p->instr_offset;
-		BUG_ON(p->len > MAX_PATCH_LEN);
-		/* prep the buffer with the original instructions */
-		memcpy(insn_buff, instr, p->len);
-		used = paravirt_patch(p->type, insn_buff, (unsigned long)instr, p->len);
-
-		BUG_ON(used > p->len);
-
-		/* Pad the rest with nops */
-		add_nops(insn_buff + used, p->len - used);
-		text_poke_early(instr, insn_buff, p->len);
-	}
-}
-extern struct paravirt_patch_site __start_parainstructions[],
-	__stop_parainstructions[];
-#endif	/* CONFIG_PARAVIRT */
-
 /*
  * Self-test for the INT3 based CALL emulation code.
  *
@@ -1649,28 +1607,11 @@ void __init alternative_instructions(void)
 	 */
 
 	/*
-	 * Paravirt patching and alternative patching can be combined to
-	 * replace a function call with a short direct code sequence (e.g.
-	 * by setting a constant return value instead of doing that in an
-	 * external function).
-	 * In order to make this work the following sequence is required:
-	 * 1. set (artificial) features depending on used paravirt
-	 *    functions which can later influence alternative patching
-	 * 2. apply paravirt patching (generally replacing an indirect
-	 *    function call with a direct one)
-	 * 3. apply alternative patching (e.g. replacing a direct function
-	 *    call with a custom code sequence)
-	 * Doing paravirt patching after alternative patching would clobber
-	 * the optimization of the custom code with a function call again.
+	 * Make sure to set (artificial) features depending on used paravirt
+	 * functions which can later influence alternative patching.
 	 */
 	paravirt_set_cap();
 
-	/*
-	 * First patch paravirt functions, such that we overwrite the indirect
-	 * call with the direct call.
-	 */
-	apply_paravirt(__parainstructions, __parainstructions_end);
-
 	__apply_fineibt(__retpoline_sites, __retpoline_sites_end,
 			__cfi_sites, __cfi_sites_end, true);
 
@@ -1681,10 +1622,6 @@ void __init alternative_instructions(void)
 	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
 	apply_returns(__return_sites, __return_sites_end);
 
-	/*
-	 * Then patch alternatives, such that those paravirt calls that are in
-	 * alternatives can be overwritten by their immediate fragments.
-	 */
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
 	/*
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index acc5b10..5358d43 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -43,14 +43,6 @@ void __init default_banner(void)
 	       pv_info.name);
 }
 
-static unsigned paravirt_patch_call(void *insn_buff, const void *target,
-				    unsigned long addr, unsigned len)
-{
-	__text_gen_insn(insn_buff, CALL_INSN_OPCODE,
-			(void *)addr, target, CALL_INSN_SIZE);
-	return CALL_INSN_SIZE;
-}
-
 #ifdef CONFIG_PARAVIRT_XXL
 DEFINE_ASM_FUNC(_paravirt_ident_64, "mov %rdi, %rax", .text);
 DEFINE_ASM_FUNC(pv_native_save_fl, "pushf; pop %rax", .noinstr.text);
@@ -73,28 +65,6 @@ static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
 	tlb_remove_page(tlb, table);
 }
 
-unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr,
-			    unsigned int len)
-{
-	/*
-	 * Neat trick to map patch type back to the call within the
-	 * corresponding structure.
-	 */
-	void *opfunc = *((void **)&pv_ops + type);
-	unsigned ret;
-
-	if (opfunc == NULL)
-		/* If there's no function, patch it with BUG_func() */
-		ret = paravirt_patch_call(insn_buff, BUG_func, addr, len);
-	else if (opfunc == nop_func)
-		ret = 0;
-	else
-		/* Otherwise call the function. */
-		ret = paravirt_patch_call(insn_buff, opfunc, addr, len);
-
-	return ret;
-}
-
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 54a5596..a349dbf 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -267,19 +267,6 @@ SECTIONS
 	}
 #endif
 
-	/*
-	 * start address and size of operations which during runtime
-	 * can be patched with virtualization friendly instructions or
-	 * baremetal native ones. Think page table operations.
-	 * Details in paravirt_types.h
-	 */
-	. = ALIGN(8);
-	.parainstructions : AT(ADDR(.parainstructions) - LOAD_OFFSET) {
-		__parainstructions = .;
-		*(.parainstructions)
-		__parainstructions_end = .;
-	}
-
 #ifdef CONFIG_RETPOLINE
 	/*
 	 * List of instructions that call/jmp/jcc to retpoline thunks
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index d30949e..a3bae2b 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -66,7 +66,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	[S_REL] =
 	"^(__init_(begin|end)|"
 	"__x86_cpu_dev_(start|end)|"
-	"(__parainstructions|__alt_instructions)(_end)?|"
+	"__alt_instructions(_end)?|"
 	"(__iommu_table|__apicdrivers|__smp_locks)(_end)?|"
 	"__(start|end)_pci_.*|"
 #if CONFIG_FW_LOADER
