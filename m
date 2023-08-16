Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5B77EB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346455AbjHPVUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346456AbjHPVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:20:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6622715;
        Wed, 16 Aug 2023 14:20:10 -0700 (PDT)
Date:   Wed, 16 Aug 2023 21:20:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692220809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGE/kgh8BtCh7ursXhnFPVlaxGJiyIvOybIQtDa4vvI=;
        b=vaSzEr56yC2HyJPxJP3fkc3STo1Bcauwy+gJ6+9/+gLwFzgWfvOQsCDtoTPrEYuOKUy7rF
        5p9tGdt4L5R+53McjotpA6iEBiR+35eWXIVbVTiwlE/V8bZtKKPn3s4U65TCF/PeSC97Re
        ppSufXikV/AtuQgvxwxg8RnpcPj4HcpNaZ0qAl7Z73ikguzMW0sMnI6p8BguAvBpZVUGfY
        0TXTfNIu1wrAmEXOVjCK7Pg45TehLEnzws8mB9X8YZDgPuRFhgSXeSc7wjcy0DEv/6wxwb
        cYNpe10QantFcy/gFJ0CW9Ifn6RAgoXXcIeXZVlCasVcqXJCxDKwElq6KrV+SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692220809;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pGE/kgh8BtCh7ursXhnFPVlaxGJiyIvOybIQtDa4vvI=;
        b=skx5/0FY6VyWuKBctNO6y9VtDw5waT192XCMYCV4Fp8Zd7dHUeoqnZjJ3oVqkfCUo6r2qD
        EpL2RYKwGbaQIbBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814121148.976236447@infradead.org>
References: <20230814121148.976236447@infradead.org>
MIME-Version: 1.0
Message-ID: <169222080876.27769.6692077997802179606.tip-bot2@tip-bot2>
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

Commit-ID:     42be649dd1f2eee6b1fb185f1a231b9494cf095f
Gitweb:        https://git.kernel.org/tip/42be649dd1f2eee6b1fb185f1a231b9494cf095f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Aug 2023 13:44:33 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Aug 2023 21:58:53 +02:00

x86/cpu: Rename srso_(.*)_alias to srso_alias_\1

For a more consistent namespace.

  [ bp: Fixup names in the doc too. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230814121148.976236447@infradead.org
---
 Documentation/admin-guide/hw-vuln/srso.rst |  4 +--
 arch/x86/include/asm/nospec-branch.h       |  6 ++---
 arch/x86/kernel/vmlinux.lds.S              |  8 +++---
 arch/x86/lib/retpoline.S                   | 26 ++++++++++-----------
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/srso.rst b/Documentation/admin-guide/hw-vuln/srso.rst
index af59a93..b6cfb51 100644
--- a/Documentation/admin-guide/hw-vuln/srso.rst
+++ b/Documentation/admin-guide/hw-vuln/srso.rst
@@ -141,8 +141,8 @@ sequence.
 To ensure the safety of this mitigation, the kernel must ensure that the
 safe return sequence is itself free from attacker interference.  In Zen3
 and Zen4, this is accomplished by creating a BTB alias between the
-untraining function srso_untrain_ret_alias() and the safe return
-function srso_safe_ret_alias() which results in evicting a potentially
+untraining function srso_alias_untrain_ret() and the safe return
+function srso_alias_safe_ret() which results in evicting a potentially
 poisoned BTB entry and using that safe one for all function returns.
 
 In older Zen1 and Zen2, this is accomplished using a reinterpretation
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 8a0d4c5..f7c3375 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -300,7 +300,7 @@
 
 #ifdef CONFIG_CPU_SRSO
 	ALTERNATIVE_2 "", "call srso_untrain_ret", X86_FEATURE_SRSO, \
-			  "call srso_untrain_ret_alias", X86_FEATURE_SRSO_ALIAS
+			  "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
 #endif
 .endm
 
@@ -316,7 +316,7 @@
 
 #ifdef CONFIG_CPU_SRSO
 	ALTERNATIVE_2 "", "call srso_untrain_ret", X86_FEATURE_SRSO, \
-			  "call srso_untrain_ret_alias", X86_FEATURE_SRSO_ALIAS
+			  "call srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
 #endif
 .endm
 
@@ -353,7 +353,7 @@ extern void srso_alias_return_thunk(void);
 
 extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
-extern void srso_untrain_ret_alias(void);
+extern void srso_alias_untrain_ret(void);
 
 extern void entry_ibpb(void);
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 7c0e2b4..83d41c2 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -147,10 +147,10 @@ SECTIONS
 
 #ifdef CONFIG_CPU_SRSO
 		/*
-		 * See the comment above srso_untrain_ret_alias()'s
+		 * See the comment above srso_alias_untrain_ret()'s
 		 * definition.
 		 */
-		. = srso_untrain_ret_alias | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
+		. = srso_alias_untrain_ret | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
 		*(.text..__x86.rethunk_safe)
 #endif
 		ALIGN_ENTRY_TEXT_END
@@ -536,8 +536,8 @@ INIT_PER_CPU(irq_stack_backing_store);
  * Instead do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
  */
-. = ASSERT(((ABSOLUTE(srso_untrain_ret_alias) | srso_safe_ret_alias) -
-		(ABSOLUTE(srso_untrain_ret_alias) & srso_safe_ret_alias)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+. = ASSERT(((ABSOLUTE(srso_alias_untrain_ret) | srso_alias_safe_ret) -
+		(ABSOLUTE(srso_alias_untrain_ret) & srso_alias_safe_ret)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
 		"SRSO function pair won't alias");
 #endif
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index adabd07..d37e5ab 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -133,56 +133,56 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 #ifdef CONFIG_RETHUNK
 
 /*
- * srso_untrain_ret_alias() and srso_safe_ret_alias() are placed at
+ * srso_alias_untrain_ret() and srso_alias_safe_ret() are placed at
  * special addresses:
  *
- * - srso_untrain_ret_alias() is 2M aligned
- * - srso_safe_ret_alias() is also in the same 2M page but bits 2, 8, 14
+ * - srso_alias_untrain_ret() is 2M aligned
+ * - srso_alias_safe_ret() is also in the same 2M page but bits 2, 8, 14
  * and 20 in its virtual address are set (while those bits in the
- * srso_untrain_ret_alias() function are cleared).
+ * srso_alias_untrain_ret() function are cleared).
  *
  * This guarantees that those two addresses will alias in the branch
  * target buffer of Zen3/4 generations, leading to any potential
  * poisoned entries at that BTB slot to get evicted.
  *
- * As a result, srso_safe_ret_alias() becomes a safe return.
+ * As a result, srso_alias_safe_ret() becomes a safe return.
  */
 #ifdef CONFIG_CPU_SRSO
 	.section .text..__x86.rethunk_untrain
 
-SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ASM_NOP2
 	lfence
 	jmp srso_alias_return_thunk
-SYM_FUNC_END(srso_untrain_ret_alias)
-__EXPORT_THUNK(srso_untrain_ret_alias)
+SYM_FUNC_END(srso_alias_untrain_ret)
+__EXPORT_THUNK(srso_alias_untrain_ret)
 
 	.section .text..__x86.rethunk_safe
 #else
 /* dummy definition for alternatives */
-SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(srso_untrain_ret_alias)
+SYM_FUNC_END(srso_alias_untrain_ret)
 #endif
 
-SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(srso_safe_ret_alias)
+SYM_FUNC_END(srso_alias_safe_ret)
 
 	.section .text..__x86.return_thunk
 
 SYM_CODE_START(srso_alias_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	call srso_safe_ret_alias
+	call srso_alias_safe_ret
 	ud2
 SYM_CODE_END(srso_alias_return_thunk)
 
