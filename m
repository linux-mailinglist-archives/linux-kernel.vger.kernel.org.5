Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A1E7884A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbjHYKT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244414AbjHYKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:19:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4472211E;
        Fri, 25 Aug 2023 03:19:29 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AS/NZLtGjOnSN7l1BI6KnBP7o6XtvU424G4ZBXw2FEA=;
        b=LY43jpWOMqWy/Ad0fHxbsaOLrCGFf3JQX54u7lts0fNuZHuE7ni57etLXYZcal33T+sFY4
        wjWsh5BzcTC38swIZXSQ7Vl1m6INilt/eh+NxIa/GKpHl4+3323lXMkxQelYVX6cN2EXNU
        1Y4yWtJK5G8LMTuc2EbbkeNpFjf3IVyWaD9qAN+pO+Hyr40me+fweCYzrNOCzsO4UQzX/p
        xWQqIfVYQyhWlL4bLqi7YWo1ynJc2FjIEDAgsKE5IazmNnBaOa24CBKXm9FCPCxr+oiCDs
        LjvPxU8K/JrnRW6U7BgQYNH9eX3xbKYSgh3i3wqPtAb3AqXLm4+aMupy6V5J2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AS/NZLtGjOnSN7l1BI6KnBP7o6XtvU424G4ZBXw2FEA=;
        b=Eas8DGv+ewU+ddsVB1pbAM9g08S8kGNR8ZkHXA7vX67LlPakwNO7krtcH/J4EQICVCTz9P
        ZA9K7ppK2CZSSDCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/calldepth: Rename __x86_return_skl() to
 call_depth_return_thunk()
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <c8a6f5e4e62300d30c829af28789a958e10277ba.1692919072.git.jpoimboe@kernel.org>
References: <c8a6f5e4e62300d30c829af28789a958e10277ba.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295876665.27769.9522370779816831169.tip-bot2@tip-bot2>
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

Commit-ID:     8e6dc5f993a23b40dac1f26abab6a980913c1d24
Gitweb:        https://git.kernel.org/tip/8e6dc5f993a23b40dac1f26abab6a980913c1d24
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:54 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:22:02 +02:00

x86/calldepth: Rename __x86_return_skl() to call_depth_return_thunk()

For consistency with the other return thunks, rename __x86_return_skl()
to call_depth_return_thunk().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/c8a6f5e4e62300d30c829af28789a958e10277ba.1692919072.git.jpoimboe@kernel.org
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
index 0ebdaa7..d538043 100644
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
 
