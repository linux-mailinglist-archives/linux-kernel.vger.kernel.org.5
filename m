Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25897AC1E5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjIWMUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjIWMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:20:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F3719F;
        Sat, 23 Sep 2023 05:20:11 -0700 (PDT)
Date:   Sat, 23 Sep 2023 12:20:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695471609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixaPWLbBb/Ht01BTFWXyWT9jP7AiCF6GndUZ/uEuauM=;
        b=kkvkF90vSQN0/sFSrwtjfWy4W/t0XYBwVGJf+cBGhMRDL3vQJGpK6ReRvSXfEDetJIWK6I
        xJKp/e7+adZyin+tilHrJ+FTmFmCT1jm0rUqPoFDqObd8j9orNtyxd1E7dxPmefNH7yj3/
        PPFkb9nbUNeqsqbcZ1xICIxt04dkhCUiyROyJ5340oaX590MjU3YH44NtdfRE06GMLWUWY
        eipQnsEFivoJCFmqSydsKkAqNj6GWnl3ttmfLNpdJr6q2F7moqDFChz87K7mk5seU2ZRVr
        d60YOwDTzgkCJkHNnAuz8hAtnPUgWkDWEH+YeoNsLafme+wR0ZEI/2MNPshtDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695471609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixaPWLbBb/Ht01BTFWXyWT9jP7AiCF6GndUZ/uEuauM=;
        b=upTsvdy+Rn9U04WD7x4T2RyfK97pYGrAEzETbbAGIdE7Y+zuqp3mtXCOPdGbSexF8dLMl6
        Djq4qsiI8/npwrCw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Remove 'pred_cmd' label
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <bb20e8569cfa144def5e6f25e610804bc4974de2.1693889988.git.jpoimboe@kernel.org>
References: <bb20e8569cfa144def5e6f25e610804bc4974de2.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169547160930.27769.12655009892934110336.tip-bot2@tip-bot2>
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

Commit-ID:     e2ea4bea46ad9b71ab0c9617d8f4e09310973344
Gitweb:        https://git.kernel.org/tip/e2ea4bea46ad9b71ab0c9617d8f4e09310973344
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:57 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 23 Sep 2023 14:13:03 +02:00

x86/srso: Remove 'pred_cmd' label

SBPB is only enabled in two distinct cases:

1) when SRSO has been disabled with srso=off

2) when SRSO has been fixed (in future HW)

Simplify the control flow by getting rid of the 'pred_cmd' label and
moving the SBPB enablement check to the two corresponding code sites.
This makes it more clear when exactly SBPB gets enabled.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/bb20e8569cfa144def5e6f25e610804bc4974de2.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e45dd69..4f1ad23 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2410,13 +2410,21 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (!boot_cpu_has_bug(X86_BUG_SRSO) || cpu_mitigations_off())
-		goto pred_cmd;
+	if (cpu_mitigations_off())
+		return;
+
+	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
+		if (boot_cpu_has(X86_FEATURE_SBPB))
+			x86_pred_cmd = PRED_CMD_SBPB;
+		return;
+	}
 
 	if (has_microcode) {
 		/*
 		 * Zen1/2 with SMT off aren't vulnerable after the right
 		 * IBPB microcode has been applied.
+		 *
+		 * Zen1/2 don't have SBPB, no need to try to enable it here.
 		 */
 		if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
@@ -2439,7 +2447,9 @@ static void __init srso_select_mitigation(void)
 
 	switch (srso_cmd) {
 	case SRSO_CMD_OFF:
-		goto pred_cmd;
+		if (boot_cpu_has(X86_FEATURE_SBPB))
+			x86_pred_cmd = PRED_CMD_SBPB;
+		return;
 
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
@@ -2501,11 +2511,6 @@ static void __init srso_select_mitigation(void)
 
 out:
 	pr_info("%s\n", srso_strings[srso_mitigation]);
-
-pred_cmd:
-	if ((!boot_cpu_has_bug(X86_BUG_SRSO) || srso_cmd == SRSO_CMD_OFF) &&
-	     boot_cpu_has(X86_FEATURE_SBPB))
-		x86_pred_cmd = PRED_CMD_SBPB;
 }
 
 #undef pr_fmt
