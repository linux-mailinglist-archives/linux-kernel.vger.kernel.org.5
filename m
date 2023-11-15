Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161257EBF01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjKOJE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjKOJEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:04:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38384116;
        Wed, 15 Nov 2023 01:04:51 -0800 (PST)
Date:   Wed, 15 Nov 2023 09:04:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700039089;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CiagETb+EIhLnlRlKgxN+Qn60M9WIRvjphEzuDjgzB8=;
        b=2hJwdjws3Kr+gjDuD09s+jOlHs9Rp9CgB78iRIo0YqAXdNQ6ONvV9BjY7BT6dL2eGcVIQI
        NtBM6WYo34VXG9v5MerOuHd5qY13M4R/hD0Ui7/Mv40g+85S0pAMXef8Rd5qb3C334e8L4
        CVuvqQbRnxD6Hdc3pSwTkaXiGEalXx7mndov7ojGGh78hOEIwUZhfOd1MEbxrC8qhmRGWq
        Abd986crt8YtZ+mtMfbvxnpZa5VDI8vS0T4AqhXHmc1Uw8pjytbqR2Kk+Yq7KbDotsih3j
        EC7wo4a2FK8R2iboMydLfv37nELV4CXs/ZhbMJ9kcNP3SzmP1t/Z+mjZoK7m0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700039089;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CiagETb+EIhLnlRlKgxN+Qn60M9WIRvjphEzuDjgzB8=;
        b=L0A82ts+pJSxc8152bNLSc3s6kkwShfbTfhTmkwTDYRiHwmabTrMfFmMBfRGANbhj6dc5+
        nWZKeOEJv4gtfHDw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpuidle: Comment about timers requirements VS
 idle handler
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231114193840.4041-2-frederic@kernel.org>
References: <20231114193840.4041-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <170003908886.391.2109617605485917006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dd5403869a40595eb953f12e8cd2bb57bb88bb67
Gitweb:        https://git.kernel.org/tip/dd5403869a40595eb953f12e8cd2bb57bb88bb67
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 14 Nov 2023 14:38:39 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Nov 2023 09:57:51 +01:00

sched/cpuidle: Comment about timers requirements VS idle handler

Add missing explanation concerning IRQs re-enablement constraints in
the cpuidle path against timers.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lkml.kernel.org/r/20231114193840.4041-2-frederic@kernel.org
---
 kernel/sched/idle.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 565f837..3123192 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -258,6 +258,36 @@ static void do_idle(void)
 	while (!need_resched()) {
 		rmb();
 
+		/*
+		 * Interrupts shouldn't be re-enabled from that point on until
+		 * the CPU sleeping instruction is reached. Otherwise an interrupt
+		 * may fire and queue a timer that would be ignored until the CPU
+		 * wakes from the sleeping instruction. And testing need_resched()
+		 * doesn't tell about pending needed timer reprogram.
+		 *
+		 * Several cases to consider:
+		 *
+		 * - SLEEP-UNTIL-PENDING-INTERRUPT based instructions such as
+		 *   "wfi" or "mwait" are fine because they can be entered with
+		 *   interrupt disabled.
+		 *
+		 * - sti;mwait() couple is fine because the interrupts are
+		 *   re-enabled only upon the execution of mwait, leaving no gap
+		 *   in-between.
+		 *
+		 * - ROLLBACK based idle handlers with the sleeping instruction
+		 *   called with interrupts enabled are NOT fine. In this scheme
+		 *   when the interrupt detects it has interrupted an idle handler,
+		 *   it rolls back to its beginning which performs the
+		 *   need_resched() check before re-executing the sleeping
+		 *   instruction. This can leak a pending needed timer reprogram.
+		 *   If such a scheme is really mandatory due to the lack of an
+		 *   appropriate CPU sleeping instruction, then a FAST-FORWARD
+		 *   must instead be applied: when the interrupt detects it has
+		 *   interrupted an idle handler, it must resume to the end of
+		 *   this idle handler so that the generic idle loop is iterated
+		 *   again to reprogram the tick.
+		 */
 		local_irq_disable();
 
 		if (cpu_is_offline(cpu)) {
