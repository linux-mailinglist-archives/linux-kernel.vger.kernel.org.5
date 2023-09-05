Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701F77925CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbjIEQIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354194AbjIEKJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A521B4;
        Tue,  5 Sep 2023 03:09:37 -0700 (PDT)
Date:   Tue, 05 Sep 2023 10:09:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693908575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVFjMzZ0uVpVK9SuKtUwEP9lEvgFNF9zhwLG/IGFnMA=;
        b=dxk3WSY5p+wgGeBR/wrQs8vCj5NR1tDYt6CYjEd1LMQqqZmFfTfp+BDB2QQNrJp5ow3wle
        9AY5QlGSS5AvxNCwjObSZtmVjoFESicONBNNR0W9jb4nQSzekmgtIDDByPEP4kI1GY8B9R
        Lrx5/zqzvY6HIPzqKGkWz8NDH4MYSpcGpg9Lrk6kBqei3nvJtgGA0d6o518N8d+haa58qz
        OpFR2jVG4DGP8VzihO3YjSj+4vzMzoA6Jv/d4Zw3UcHugJ5nvX3jkAysoOmmUxa1aXQ7XH
        Y5X4/hezMhqHe9dyRFqpujBdsb3lA7NTmIjKPphEj04imh6QMqQPumEVNyQUyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693908575;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVFjMzZ0uVpVK9SuKtUwEP9lEvgFNF9zhwLG/IGFnMA=;
        b=gNF4A9tkq9SoJRj9XVRTpSAukGghEsrQHEdVLb7bc3q1j5Hp7eDocMW7Mc+9qpUKLIXxrt
        vNg94tIZUqXsEtCA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Remove default case for fully switched enums
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <fcf6feefab991b72e411c2aed688b18e65e06aed.1693889988.git.jpoimboe@kernel.org>
References: <fcf6feefab991b72e411c2aed688b18e65e06aed.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169390857513.27769.18186847409002472877.tip-bot2@tip-bot2>
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

Commit-ID:     3cd8bc46c3e4147551c89a38ca0ffc5ff7915e52
Gitweb:        https://git.kernel.org/tip/3cd8bc46c3e4147551c89a38ca0ffc5ff7915e52
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:58 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 05 Sep 2023 12:05:07 +02:00

x86/bugs: Remove default case for fully switched enums

For enum switch statements which handle all possible cases, remove the
default case so a compiler warning gets printed if one of the enums gets
accidentally omitted from the switch statement.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/fcf6feefab991b72e411c2aed688b18e65e06aed.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4f1ad23..941ac94 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1019,7 +1019,6 @@ static void __init retbleed_select_mitigation(void)
 
 do_cmd_auto:
 	case RETBLEED_CMD_AUTO:
-	default:
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
@@ -1290,6 +1289,8 @@ spectre_v2_user_select_mitigation(void)
 
 		spectre_v2_user_ibpb = mode;
 		switch (cmd) {
+		case SPECTRE_V2_USER_CMD_NONE:
+			break;
 		case SPECTRE_V2_USER_CMD_FORCE:
 		case SPECTRE_V2_USER_CMD_PRCTL_IBPB:
 		case SPECTRE_V2_USER_CMD_SECCOMP_IBPB:
@@ -1301,8 +1302,6 @@ spectre_v2_user_select_mitigation(void)
 		case SPECTRE_V2_USER_CMD_SECCOMP:
 			static_branch_enable(&switch_mm_cond_ibpb);
 			break;
-		default:
-			break;
 		}
 
 		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
@@ -2160,6 +2159,10 @@ static int l1d_flush_prctl_get(struct task_struct *task)
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
+	case SPEC_STORE_BYPASS_NONE:
+		if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
+			return PR_SPEC_ENABLE;
+		return PR_SPEC_NOT_AFFECTED;
 	case SPEC_STORE_BYPASS_DISABLE:
 		return PR_SPEC_DISABLE;
 	case SPEC_STORE_BYPASS_SECCOMP:
@@ -2171,11 +2174,8 @@ static int ssb_prctl_get(struct task_struct *task)
 		if (task_spec_ssb_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
-	default:
-		if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-			return PR_SPEC_ENABLE;
-		return PR_SPEC_NOT_AFFECTED;
 	}
+	BUG();
 }
 
 static int ib_prctl_get(struct task_struct *task)
@@ -2504,9 +2504,6 @@ static void __init srso_select_mitigation(void)
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
                 }
 		break;
-
-	default:
-		break;
 	}
 
 out:
