Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593C877B881
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjHNMT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjHNMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:19:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF327107
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LK3mbjd5nWgwqe+uxKwpv04Jq+49BgYgVpVgFwn6JuQ=; b=TjcWH19Wbdlq1otV+nW5r+zJIS
        G+7p/8cl28HWJ+h1f8JjsYGpZbyPTXAujzq/PweWRTFLns2tF3kcOS2hpsWtvCMEm6mbWq/SVwjuw
        jX6Xnlke8QA1fAzRe5Bpq5CaMLjs3mwx/D/I/IeKmfCRVEQ92Oq9jgkacKYJsdMS07SXGxk1xC4Fg
        VDAlhf49lS1tqz7rAG6E9rxGsDKBiOJw/Lv2JQe1Ol80pY3h1fDsBBaSx6I+Ua/03eJwfJ/1ENTBO
        I3i670hFxZL7mgFMFOaPMyy9BmzFGsoxGAgFCGoq6vm//flo/uylreNSyRdnOQB1kHYg1QRR1kmjS
        U89TyJSQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVWXY-00AaKb-39;
        Mon, 14 Aug 2023 12:19:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E4FC6300F59;
        Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CB56721C1D1B6; Mon, 14 Aug 2023 14:19:19 +0200 (CEST)
Message-ID: <20230814121148.976236447@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 14 Aug 2023 13:44:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        David.Kaplan@amd.com, Andrew.Cooper3@citrix.com,
        jpoimboe@kernel.org, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: [PATCH v2 07/11] x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
References: <20230814114426.057251214@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a more consistent namespace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h |    6 +++---
 arch/x86/kernel/vmlinux.lds.S        |    8 ++++----
 arch/x86/lib/retpoline.S             |   22 +++++++++++-----------
 3 files changed, 18 insertions(+), 18 deletions(-)

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
 
@@ -349,7 +349,7 @@ extern void srso_alias_return_thunk(void
 
 extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
-extern void srso_untrain_ret_alias(void);
+extern void srso_alias_untrain_ret(void);
 
 extern void entry_ibpb(void);
 
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
 
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -133,49 +133,49 @@ SYM_CODE_END(__x86_indirect_jump_thunk_a
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
 


