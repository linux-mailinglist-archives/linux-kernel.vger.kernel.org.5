Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FD07BD878
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345709AbjJIK0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345615AbjJIK0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:26:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B886A9D;
        Mon,  9 Oct 2023 03:26:13 -0700 (PDT)
Date:   Mon, 09 Oct 2023 10:26:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696847172;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrLEqPl6gk4LRSSeKr3UyEVVQOqyZX8dfC8LmvBOxj4=;
        b=VFXDLDhZ+vmfeKMyUG0c975KoujXKrNya4d0lsIif4QmHl+YNIiw9IkB8oL0ICtyvkg1aG
        ZLPMRpsy8SZ5DXkRDs/p1lKnBNpAx+3erHgAkfbw9505+LF+VBoRS+cSPVoV/TEF9b+hG7
        GncqI2xSDB6FdnBnyg7lrPVLiT6KcyBxYYMM4HpG42pVg6eV6dO5aczL7eH7UhKIfdQnXy
        SMusEza9E2jAhcrsQSA5sWjP0YzPaI2WIRZxiTbkzGue7mlq1veLAcu28eU4cPNwl++M2C
        4bFR3tuqV6bj8b10ddiFQ2cHNNvk0m/a+fhfspcPIrRZ876AwS1lexg8TcrO7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696847172;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrLEqPl6gk4LRSSeKr3UyEVVQOqyZX8dfC8LmvBOxj4=;
        b=ORhAzzM7z79cy5CpYWAbJTP1U6JlBJzcRRn7/d2bZsn5nufg6DEXN7RPSPEKyWZlNI9YPc
        9q0I+s6AlHFHLZCw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/nohz: Update idle load-balancing (ILB) comments
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231006102518.2452758-2-mingo@kernel.org>
References: <20231006102518.2452758-2-mingo@kernel.org>
MIME-Version: 1.0
Message-ID: <169684717152.3135.18417702830973056064.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7ef7145a2b26b172ac6885c4cf3272a38bc0979a
Gitweb:        https://git.kernel.org/tip/7ef7145a2b26b172ac6885c4cf3272a38bc0979a
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 06 Oct 2023 12:25:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Oct 2023 12:21:23 +02:00

sched/nohz: Update idle load-balancing (ILB) comments

 - Fix incorrect/misleading comments,

 - clarify some others,

 - fix typos & grammar,

 - and use more consistent style throughout.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lore.kernel.org/r/20231006102518.2452758-2-mingo@kernel.org
---
 kernel/sched/fair.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52c498f..2b63a14 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11503,14 +11503,15 @@ static inline int on_null_domain(struct rq *rq)
 
 #ifdef CONFIG_NO_HZ_COMMON
 /*
- * idle load balancing details
- * - When one of the busy CPUs notice that there may be an idle rebalancing
+ * NOHZ idle load balancing (ILB) details:
+ *
+ * - When one of the busy CPUs notices that there may be an idle rebalancing
  *   needed, they will kick the idle load balancer, which then does idle
  *   load balancing for all the idle CPUs.
- * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED not set
+ *
+ * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is not set
  *   anywhere yet.
  */
-
 static inline int find_new_ilb(void)
 {
 	int ilb;
@@ -11531,8 +11532,10 @@ static inline int find_new_ilb(void)
 }
 
 /*
- * Kick a CPU to do the nohz balancing, if it is time for it. We pick any
- * idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
+ * Kick a CPU to do the NOHZ balancing, if it is time for it, via a cross-CPU
+ * SMP function call (IPI).
+ *
+ * We pick the first idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
  */
 static void kick_ilb(unsigned int flags)
 {
@@ -11560,7 +11563,7 @@ static void kick_ilb(unsigned int flags)
 
 	/*
 	 * This way we generate an IPI on the target CPU which
-	 * is idle. And the softirq performing nohz idle load balance
+	 * is idle, and the softirq performing NOHZ idle load balancing
 	 * will be run before returning from the IPI.
 	 */
 	smp_call_function_single_async(ilb_cpu, &cpu_rq(ilb_cpu)->nohz_csd);
@@ -11589,7 +11592,7 @@ static void nohz_balancer_kick(struct rq *rq)
 
 	/*
 	 * None are in tickless mode and hence no need for NOHZ idle load
-	 * balancing.
+	 * balancing:
 	 */
 	if (likely(!atomic_read(&nohz.nr_cpus)))
 		return;
@@ -11611,9 +11614,8 @@ static void nohz_balancer_kick(struct rq *rq)
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
 		/*
-		 * If there's a CFS task and the current CPU has reduced
-		 * capacity; kick the ILB to see if there's a better CPU to run
-		 * on.
+		 * If there's a runnable CFS task and the current CPU has reduced
+		 * capacity, kick the ILB to see if there's a better CPU to run on:
 		 */
 		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
@@ -11665,11 +11667,11 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (sds) {
 		/*
 		 * If there is an imbalance between LLC domains (IOW we could
-		 * increase the overall cache use), we need some less-loaded LLC
-		 * domain to pull some load. Likewise, we may need to spread
+		 * increase the overall cache utilization), we need a less-loaded LLC
+		 * domain to pull some load from. Likewise, we may need to spread
 		 * load within the current LLC domain (e.g. packed SMT cores but
 		 * other CPUs are idle). We can't really know from here how busy
-		 * the others are - so just get a nohz balance going if it looks
+		 * the others are - so just get a NOHZ balance going if it looks
 		 * like this LLC domain has tasks we could move.
 		 */
 		nr_busy = atomic_read(&sds->nr_busy_cpus);
