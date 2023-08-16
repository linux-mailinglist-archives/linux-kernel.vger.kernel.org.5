Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F177EBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbjHPVUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346460AbjHPVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:20:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4650B2716;
        Wed, 16 Aug 2023 14:20:11 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:20:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692220809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7m0NXkTwpZQ/JFeZmG5x7TYwpdtpjAEcuT0CG8u53w=;
        b=mx2A4oIqE2sXi88IoPI3XAdTvwJ9DyGyf7tKfcXQe/t7/j3alLOXbD3rbdVIdGcKHIVUzd
        icGRr0hu6qZRW/3GK2TWNYlF4N5S9eyyKFFkvjR8GzzeXkEizaPaNJPcZpEQfrv3q8BDX+
        iMQrIWZxLfbbXzaqZLt/afyo6y4XEjm0u6GEYZZsGPwxm8vQoKdAoLuyb37iDyAiFO3N6b
        m2mYSMGvqwaWutuT6wLWN3QB+bvwDuuHStfC1kM4LOCmvwE0nVVvORZgHI/rxAZ9ecBLbd
        sAGh8ZaTTCsMNHd0Z/6kV714j3MVUFeTi7qWNo1I7Cz40Q/WXaOZ+BK4dSNq+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692220809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n7m0NXkTwpZQ/JFeZmG5x7TYwpdtpjAEcuT0CG8u53w=;
        b=pZEfpScU6CT9pid2QxVlD3VRAT+P3yyvr25ciggqTP/xpO5/W23AQ2NMAz3XUrPvDQjK6r
        t4MV27zlPWm7p4Dg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Rename original retbleed methods
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814121148.909378169@infradead.org>
References: <20230814121148.909378169@infradead.org>
MIME-Version: 1.0
Message-ID: <169222080931.27769.1400912932856561598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d025b7bac07a6e90b6b98b487f88854ad9247c39
Gitweb:        https://git.kernel.org/tip/d025b7bac07a6e90b6b98b487f88854ad9247c39
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Aug 2023 13:44:32 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 21:47:53 +02:00

x86/cpu: Rename original retbleed methods

Rename the original retbleed return thunk and untrain_ret to
retbleed_return_thunk() and retbleed_untrain_ret().

No functional changes.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.909378169@infradead.org
---
 arch/x86/include/asm/nospec-branch.h |  8 +++----
 arch/x86/kernel/cpu/bugs.c           |  2 +-
 arch/x86/kernel/vmlinux.lds.S        |  2 +-
 arch/x86/lib/retpoline.S             | 30 +++++++++++++--------------
 tools/objtool/arch/x86/decode.c      |  2 +-
 tools/objtool/check.c                |  2 +-
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5ed78ad..8a0d4c5 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -272,7 +272,7 @@
 .endm
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
-#define CALL_ZEN_UNTRAIN_RET	"call zen_untrain_ret"
+#define CALL_ZEN_UNTRAIN_RET	"call retbleed_untrain_ret"
 #else
 #define CALL_ZEN_UNTRAIN_RET	""
 #endif
@@ -282,7 +282,7 @@
  * return thunk isn't mapped into the userspace tables (then again, AMD
  * typically has NO_MELTDOWN).
  *
- * While zen_untrain_ret() doesn't clobber anything but requires stack,
+ * While retbleed_untrain_ret() doesn't clobber anything but requires stack,
  * entry_ibpb() will clobber AX, CX, DX.
  *
  * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
@@ -347,11 +347,11 @@ extern void __x86_return_thunk(void);
 static inline void __x86_return_thunk(void) {}
 #endif
 
-extern void zen_return_thunk(void);
+extern void retbleed_return_thunk(void);
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
 
-extern void zen_untrain_ret(void);
+extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
 extern void srso_untrain_ret_alias(void);
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 56cf250..bbbbda9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1043,7 +1043,7 @@ do_cmd_auto:
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
 		if (IS_ENABLED(CONFIG_RETHUNK))
-			x86_return_thunk = zen_return_thunk;
+			x86_return_thunk = retbleed_return_thunk;
 
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d3b02d6..7c0e2b4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -521,7 +521,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #ifdef CONFIG_RETHUNK
-. = ASSERT((zen_return_thunk & 0x3f) == 0, "zen_return_thunk not cacheline-aligned");
+. = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 #endif
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 7df8582..adabd07 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -188,32 +188,32 @@ SYM_CODE_END(srso_alias_return_thunk)
 
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
- * 1) The RET at zen_return_thunk must be on a 64 byte boundary, for
+ * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
  *    alignment within the BTB.
- * 2) The instruction at zen_untrain_ret must contain, and not
+ * 2) The instruction at retbleed_untrain_ret must contain, and not
  *    end with, the 0xc3 byte of the RET.
  * 3) STIBP must be enabled, or SMT disabled, to prevent the sibling thread
  *    from re-poisioning the BTB prediction.
  */
 	.align 64
-	.skip 64 - (zen_return_thunk - zen_untrain_ret), 0xcc
-SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	.skip 64 - (retbleed_return_thunk - retbleed_untrain_ret), 0xcc
+SYM_START(retbleed_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	/*
-	 * As executed from zen_untrain_ret, this is:
+	 * As executed from retbleed_untrain_ret, this is:
 	 *
 	 *   TEST $0xcc, %bl
 	 *   LFENCE
-	 *   JMP zen_return_thunk
+	 *   JMP retbleed_return_thunk
 	 *
 	 * Executing the TEST instruction has a side effect of evicting any BTB
 	 * prediction (potentially attacker controlled) attached to the RET, as
-	 * zen_return_thunk + 1 isn't an instruction boundary at the moment.
+	 * retbleed_return_thunk + 1 isn't an instruction boundary at the moment.
 	 */
 	.byte	0xf6
 
 	/*
-	 * As executed from zen_return_thunk, this is a plain RET.
+	 * As executed from retbleed_return_thunk, this is a plain RET.
 	 *
 	 * As part of the TEST above, RET is the ModRM byte, and INT3 the imm8.
 	 *
@@ -225,13 +225,13 @@ SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	 * With SMT enabled and STIBP active, a sibling thread cannot poison
 	 * RET's prediction to a type of its choice, but can evict the
 	 * prediction due to competitive sharing. If the prediction is
-	 * evicted, zen_return_thunk will suffer Straight Line Speculation
+	 * evicted, retbleed_return_thunk will suffer Straight Line Speculation
 	 * which will be contained safely by the INT3.
 	 */
-SYM_INNER_LABEL(zen_return_thunk, SYM_L_GLOBAL)
+SYM_INNER_LABEL(retbleed_return_thunk, SYM_L_GLOBAL)
 	ret
 	int3
-SYM_CODE_END(zen_return_thunk)
+SYM_CODE_END(retbleed_return_thunk)
 
 	/*
 	 * Ensure the TEST decoding / BTB invalidation is complete.
@@ -242,13 +242,13 @@ SYM_CODE_END(zen_return_thunk)
 	 * Jump back and execute the RET in the middle of the TEST instruction.
 	 * INT3 is for SLS protection.
 	 */
-	jmp zen_return_thunk
+	jmp retbleed_return_thunk
 	int3
-SYM_FUNC_END(zen_untrain_ret)
-__EXPORT_THUNK(zen_untrain_ret)
+SYM_FUNC_END(retbleed_untrain_ret)
+__EXPORT_THUNK(retbleed_untrain_ret)
 
 /*
- * SRSO untraining sequence for Zen1/2, similar to zen_untrain_ret()
+ * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
  * above. On kernel entry, srso_untrain_ret() is executed which is a
  *
  * movabs $0xccccc30824648d48,%rax
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index c55f3bb..c0f25d0 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -829,6 +829,6 @@ bool arch_is_rethunk(struct symbol *sym)
 
 bool arch_is_embedded_insn(struct symbol *sym)
 {
-	return !strcmp(sym->name, "zen_return_thunk") ||
+	return !strcmp(sym->name, "retbleed_return_thunk") ||
 	       !strcmp(sym->name, "srso_safe_ret");
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 191656e..7a9aaf4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1593,7 +1593,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			struct symbol *sym = find_symbol_by_offset(dest_sec, dest_off);
 
 			/*
-			 * This is a special case for zen_untrain_ret().
+			 * This is a special case for retbleed_untrain_ret().
 			 * It jumps to __x86_return_thunk(), but objtool
 			 * can't find the thunk's starting RET
 			 * instruction, because the RET is also in the
