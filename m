Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F173C7A5EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjISJxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjISJw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:52:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B39E;
        Tue, 19 Sep 2023 02:52:53 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:52:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695117171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cEFNR0Ukbl7IOypHbZewrDZRApycDVjloKVSyI5Hom4=;
        b=Vo4imZs04ubjsuMDrGCXarD3cQxO0w63RNPvvcY7qQo+BVxV7jiWWsa2F3ooJ8BmBJNQOG
        Q5Rlhx6v0aS2Dta1GkjY1h5pN6xGKqBBGPdWyI/pdcFIAwRVT2/VrS0P1ffpViXtHgstt0
        K7naZEPrsKnODRpqkREAGbMLED61kJf2bhkF6fdKTKkeZfughf531UbgMCCLQYAACfN3gg
        2EXVnrJ+E9Canlt8wt+qaSxyuXlI3yEypvTkNP3/TSLm5tN0ThCYwvkYrSEUSJFQvno6v4
        X2tf8xbZ863DW3gQsqzqXMfo65bE8aLBfMC881wfd88JFQ2hHntF8Un7Oq+oMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695117171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=cEFNR0Ukbl7IOypHbZewrDZRApycDVjloKVSyI5Hom4=;
        b=G+oVv1Fip/kh2ykCwlkxTglerDyC8SfHn0zbG4M8Hmyx58YykU5Mo7JtQdoBwyccJP5/Qj
        q+fuupET9Oze6RDQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename check_preempt_wakeup() to
 check_preempt_wakeup_fair()
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169511717117.27769.11799364824084021498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     82845683ca6a15fe8c7912c6264bb0e84ec6f5fb
Gitweb:        https://git.kernel.org/tip/82845683ca6a15fe8c7912c6264bb0e84ec6f5fb
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 19 Sep 2023 10:31:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Sep 2023 10:32:15 +02:00

sched/fair: Rename check_preempt_wakeup() to check_preempt_wakeup_fair()

Other scheduling classes already postfix their similar methods
with the class name.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d087787..aeaf31e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7994,7 +7994,7 @@ static void set_next_buddy(struct sched_entity *se)
 /*
  * Preempt the current task with a newly woken task if needed:
  */
-static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_flags)
+static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_entity *se = &curr->se, *pse = &p->se;
@@ -12830,7 +12830,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.yield_task		= yield_task_fair,
 	.yield_to_task		= yield_to_task_fair,
 
-	.check_preempt_curr	= check_preempt_wakeup,
+	.check_preempt_curr	= check_preempt_wakeup_fair,
 
 	.pick_next_task		= __pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
