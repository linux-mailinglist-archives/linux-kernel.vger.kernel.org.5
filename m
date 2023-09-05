Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF399792BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbjIERDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354190AbjIEKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9511B6;
        Tue,  5 Sep 2023 03:09:35 -0700 (PDT)
Date:   Tue, 05 Sep 2023 10:09:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693908572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RiD3jPHUAhfhaZGuV15eskea6G0qSVllMRQspBhp6O0=;
        b=1pYnp23BbZK8f1DapZftoDTBWmvCgglSCy0by1YuwSbGYIZGQffY1DidHeUeBi0mlza034
        DyIBAtVigJQ8SiuH1iMnegtwNX0x0PlA53sDEc/Md4W41jkLUcRbSQVMoku9XxZnZUCqXq
        AqKj57/A6EzgPjmOcHYAYAfd3XEpOOMNsqVROI9hSdzRTXxWOXq203bNfI/XSX8COkwLEc
        Syh6frxgBJC5EPPNBqUYZQShQpQiPKhJLYpXYmUvEPj/8YySr+E1PNbf4neIivrY2dmEtB
        ibP/e4WWZl0G50SaKojQvPbzEmJ4JaODCt0ApP1B9WKAJJB+M/jIjWdaKr4i8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693908572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RiD3jPHUAhfhaZGuV15eskea6G0qSVllMRQspBhp6O0=;
        b=/xXlJ91RaYCtZEH1Rx0I6GPeuo3ty/di4Nxsv30pKyIuHyWBzY73YM5sEqemJxwVeuTtoA
        FjC2yOE89Ou8foBw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/calldepth: Rename __x86_return_skl() to
 call_depth_return_thunk()
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ae44e9f9976934e3b5b47a458d523ccb15867561.1693889988.git.jpoimboe@kernel.org>
References: <ae44e9f9976934e3b5b47a458d523ccb15867561.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169390857215.27769.13799941555720921118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     423a4484b9235af31b1fd60d6049b820586e57d2
Gitweb:        https://git.kernel.org/tip/423a4484b9235af31b1fd60d6049b820586e57d2
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:05:04 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 05 Sep 2023 12:05:08 +02:00

x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()

For consistency with the other return thunks, rename __x86_return_skl()
to call_depth_return_thunk().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/ae44e9f9976934e3b5b47a458d523ccb15867561.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/nospec-branch.h | 13 ++++---------
 arch/x86/kernel/cpu/bugs.c           |  3 ++-
 arch/x86/lib/retpoline.S             |  4 ++--
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index dcc7847..14cd3cd 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -358,12 +358,7 @@ extern void entry_ibpb(void);
 extern void (*x86_return_thunk)(void);
 
 #ifdef CONFIG_CALL_DEPTH_TRACKING
-extern void __x86_return_skl(void);
-
-static inline void x86_set_skl_return_thunk(void)
-{
-	x86_return_thunk = &__x86_return_skl;
-}
+extern void call_depth_return_thunk(void);
 
 #define CALL_DEPTH_ACCOUNT					\
 	ALTERNATIVE("",						\
@@ -376,12 +371,12 @@ DECLARE_PER_CPU(u64, __x86_ret_count);
 DECLARE_PER_CPU(u64, __x86_stuffs_count);
 DECLARE_PER_CPU(u64, __x86_ctxsw_count);
 #endif
-#else
-static inline void x86_set_skl_return_thunk(void) {}
+#else /* !CONFIG_CALL_DEPTH_TRACKING */
 
+static inline void call_depth_return_thunk(void) {}
 #define CALL_DEPTH_ACCOUNT ""
 
-#endif
+#endif /* CONFIG_CALL_DEPTH_TRACKING */
 
 #ifdef CONFIG_RETPOLINE
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9731e81..016a326 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1059,7 +1059,8 @@ do_cmd_auto:
 	case RETBLEED_MITIGATION_STUFF:
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_CALL_DEPTH);
-		x86_set_skl_return_thunk();
+
+		x86_return_thunk = call_depth_return_thunk;
 		break;
 
 	default:
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 49f2be7..6376d01 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -321,7 +321,7 @@ __EXPORT_THUNK(entry_untrain_ret)
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 
 	.align 64
-SYM_FUNC_START(__x86_return_skl)
+SYM_FUNC_START(call_depth_return_thunk)
 	ANNOTATE_NOENDBR
 	/*
 	 * Keep the hotpath in a 16byte I-fetch for the non-debug
@@ -348,7 +348,7 @@ SYM_FUNC_START(__x86_return_skl)
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(__x86_return_skl)
+SYM_FUNC_END(call_depth_return_thunk)
 
 #endif /* CONFIG_CALL_DEPTH_TRACKING */
 
