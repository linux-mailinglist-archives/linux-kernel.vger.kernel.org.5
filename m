Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2427AC1DF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjIWMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjIWMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:20:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D5519E;
        Sat, 23 Sep 2023 05:20:11 -0700 (PDT)
Date:   Sat, 23 Sep 2023 12:20:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695471609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kh91L5ZDwFn9HB7mIljVlaeZY3ao0w8gMQ62BPYMZds=;
        b=fm+fE2VWPeqOyUplDOR7nCqCyzmLXcGxsGivyKoZSF2eHvYFQTKgrKAQvNrSQYG2inlxLw
        VQCs2tciUE2kUX2agGdCHu1jBu36zVcK3osK732leCQe/Pcw8mkGcO50DimhrF4hwFloWp
        IqbKBtuI0CN+ZTDAxivv1HZkVKkY8oxyCMzu3X591bgk2JuNdJ1Ohr2WezV91jnW3sx3ks
        wDeFJrKzaBBeXBGo/gNgHLkPiEs/h/nhUGv+lLSzjrq/A9eqGejlBYUQaLDhlcfKXCrRC+
        VaV/+4I+LhGBEbgmYx40xAGVXtmah1kD/NOxMQCabkoudjI+VYckeao8Er9OVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695471609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kh91L5ZDwFn9HB7mIljVlaeZY3ao0w8gMQ62BPYMZds=;
        b=p0+cG3TUBep8ycm2KRkcFcy2yJ4MIM+e/igO7ABMT/iNhOf7G879F9y7KF1HBlN9Dkh4PU
        gFlHBf9fVcLXc5Aw==
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
Message-ID: <169547160881.27769.4772445455882672034.tip-bot2@tip-bot2>
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

Commit-ID:     365d8a5f4fe4faa88a813b849ea8eac58645289b
Gitweb:        https://git.kernel.org/tip/365d8a5f4fe4faa88a813b849ea8eac58645289b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:58 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Sep 2023 14:13:03 +02:00

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
