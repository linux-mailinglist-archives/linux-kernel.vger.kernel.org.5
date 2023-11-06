Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599047E2D09
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjKFThp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjKFThD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:37:03 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D051FF5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:36:18 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b4128814ffso3549732a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699299377; x=1699904177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgovNar/cQhKvhzYglsfqyNmg5J3OOfZL8S11R87w8M=;
        b=oE7v8GeoPN5SX5Gv8Rb/pX4lv163Qipmo3GXhX6MplIOtNyAQ62nPWhkGPGT9pxBZ3
         JWPNjnl0QAWZCX8AdKVsHD8t48+dc0ShkFdmnawRaIKnaiwnf2VlIqb87EhKrQasxlqs
         Lw/XVjMtenb/mooG2qEeTy1lStncCTNIgWGUyNDOZkaM3F2z/rv96wbXRjBSC/6Z9VPD
         NDcawUSm8WIRDipmIZXz4JVA48z5BGtFb0RE34xg4yBBwTc6+NIPZwl+cOUWlPi6H4GX
         JnvqTN30m/yjLanLt99WPXlhQsENs/f21X00WktQUHX8LQATYq3OJIXURHqIg6W0TUUA
         0uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699299377; x=1699904177;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgovNar/cQhKvhzYglsfqyNmg5J3OOfZL8S11R87w8M=;
        b=CEWez4TjgRaRZpL6RCpt9htTshMoJ10mxnKILvUHdDXa7F/d9Wq1aLg1nkvUM+LTSO
         PmxeCIf+FV9IArPz4p7l2DBCEnbUcXdqEhzc99MmZV+VMZCSdfMo1QAQ1OeUVAdpfLOp
         43lTLLCFsGSty7iP143r+CUdXi03qXX9uAnp9yV+xUPaV8BumK7hAwImr4SCEGz8U5rE
         nooczCtjXbkFsh4RPGkPL0Ob2MYCNBwn8iSBbcO2LzWmbuSpyGLWd7i3w1Cvew/sXtPs
         vZUeHqQz8iHuLsDTklMXdIHG3mI9u44m/zY+/6voCdpzyPJ6xx3pC/VfDAjxp+2qaWsO
         z8gg==
X-Gm-Message-State: AOJu0YxAqNyPXTMAtBIXJckFTY46NnBx2hUEYWLRFcCu0l7sw1UwXt9t
        II3f2E/iwTIOnTs9D83LZJuB5mMj2ybmhdp5cxpEH+uXdQncHdQWhKASWXPqBSLAlGo2llYNRSm
        NG+rknyhb1qi8fb5/kSF/I2EYXsOafQ9ZRs+whyViZ0FlY3aXFSMPC4Q5CR85FPx0IiRC1jM=
X-Google-Smtp-Source: AGHT+IF6673xo7bBPe/sQtIZXqhLp4ljNUFfZCN2sFvtWlw4mL/daZHQt77afxNPWCUfvkGOaklemHoinRVQ
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:b25d:0:b0:5b9:293d:ea24 with SMTP id
 t29-20020a63b25d000000b005b9293dea24mr537704pgo.2.1699299375693; Mon, 06 Nov
 2023 11:36:15 -0800 (PST)
Date:   Mon,  6 Nov 2023 19:35:03 +0000
In-Reply-To: <20231106193524.866104-1-jstultz@google.com>
Mime-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106193524.866104-21-jstultz@google.com>
Subject: [PATCH v6 20/20] sched: Add deactivated (sleeping) owner handling to proxy()
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Adds a implementation of (sleeping) deactivated owner handling
where we queue the selected task on the deactivated owner task
and deactivate it as well, re-activating it later when the owner
is woken up.

NOTE: This has been particularly challenging to get working
properly, and some of the locking is particularly ackward. I'd
very much appreciate review and feedback for ways to simplify
this.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: This was broken out from the larger proxy() patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from larger proxy patch
v6:
* Major rework, replacing the single list head per task with
  per-task list head and nodes, creating a tree structure so
  we only wake up decendents of the task woken.
* Reworked the locking to take the task->pi_lock, so we can
  avoid mid-chain wakeup races from try_to_wake_up() called by
  the ww_mutex logic.
---
 include/linux/sched.h |   3 +
 kernel/fork.c         |   4 +-
 kernel/sched/core.c   | 198 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 196 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9bff2f123207..c5aa0208104f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1148,6 +1148,9 @@ struct task_struct {
 	struct task_struct		*blocked_donor;	/* task that is boosting us */
 	struct mutex			*blocked_on;	/* lock we're blocked on */
 	bool				blocked_on_waking; /* blocked on, but waking */
+	struct list_head		blocked_head;  /* tasks blocked on us */
+	struct list_head		blocked_node;  /* our entry on someone elses blocked_head */
+	struct task_struct		*sleeping_owner; /* task our blocked_node is enqueued on */
 	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/kernel/fork.c b/kernel/fork.c
index 6604e0472da0..bbcf2697652f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2459,7 +2459,9 @@ __latent_entropy struct task_struct *copy_process(
 	p->blocked_donor = NULL; /* nobody is boosting us yet */
 	p->blocked_on = NULL; /* not blocked yet */
 	p->blocked_on_waking = false; /* not blocked yet */
-
+	INIT_LIST_HEAD(&p->blocked_head);
+	INIT_LIST_HEAD(&p->blocked_node);
+	p->sleeping_owner = NULL;
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6ac7a241dacc..8f87318784d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3804,6 +3804,119 @@ static inline void ttwu_do_wakeup(struct task_struct *p)
 	trace_sched_wakeup(p);
 }
 
+#ifdef CONFIG_PROXY_EXEC
+static void do_activate_task(struct rq *rq, struct task_struct *p, int en_flags)
+{
+	lockdep_assert_rq_held(rq);
+
+	if (!sched_proxy_exec()) {
+		activate_task(rq, p, en_flags);
+		return;
+	}
+
+	if (p->sleeping_owner) {
+		struct task_struct *owner = p->sleeping_owner;
+
+		raw_spin_lock(&owner->blocked_lock);
+		list_del_init(&p->blocked_node);
+		p->sleeping_owner = NULL;
+		raw_spin_unlock(&owner->blocked_lock);
+	}
+
+	/*
+	 * By calling activate_task with blocked_lock held, we order against
+	 * the proxy() blocked_task case such that no more blocked tasks will
+	 * be enqueued on p once we release p->blocked_lock.
+	 */
+	raw_spin_lock(&p->blocked_lock);
+	WARN_ON(task_cpu(p) != cpu_of(rq));
+	activate_task(rq, p, en_flags);
+	raw_spin_unlock(&p->blocked_lock);
+}
+
+static void activate_blocked_ents(struct rq *target_rq,
+				  struct task_struct *owner,
+				  int wake_flags)
+{
+	unsigned long flags;
+	struct rq_flags rf;
+	int target_cpu = cpu_of(target_rq);
+	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
+
+	if (wake_flags & WF_MIGRATED)
+		en_flags |= ENQUEUE_MIGRATED;
+	/*
+	 * A whole bunch of 'proxy' tasks back this blocked task, wake
+	 * them all up to give this task its 'fair' share.
+	 */
+	raw_spin_lock(&owner->blocked_lock);
+	while (!list_empty(&owner->blocked_head)) {
+		struct task_struct *pp;
+		unsigned int state;
+
+		pp = list_first_entry(&owner->blocked_head,
+				      struct task_struct,
+				      blocked_node);
+		BUG_ON(pp == owner);
+		list_del_init(&pp->blocked_node);
+		WARN_ON(!pp->sleeping_owner);
+		pp->sleeping_owner = NULL;
+		raw_spin_unlock(&owner->blocked_lock);
+
+		/* Nested as ttwu holds the owner's pi_lock */
+		/* XXX But how do we enforce ordering to avoid ABBA? */
+		raw_spin_lock_irqsave_nested(&pp->pi_lock, flags, SINGLE_DEPTH_NESTING);
+		smp_rmb();
+		state = READ_ONCE(pp->__state);
+		/* Avoid racing with ttwu */
+		if (state == TASK_WAKING) {
+			raw_spin_unlock_irqrestore(&pp->pi_lock, flags);
+			raw_spin_lock(&owner->blocked_lock);
+			continue;
+		}
+		if (READ_ONCE(pp->on_rq)) {
+			/*
+			 * We raced with a non mutex handoff activation of pp.
+			 * That activation will also take care of activating
+			 * all of the tasks after pp in the blocked_entry list,
+			 * so we're done here.
+			 */
+			raw_spin_unlock_irqrestore(&pp->pi_lock, flags);
+			raw_spin_lock(&owner->blocked_lock);
+			continue;
+		}
+
+		__set_task_cpu(pp, target_cpu);
+
+		rq_lock_irqsave(target_rq, &rf);
+		update_rq_clock(target_rq);
+		do_activate_task(target_rq, pp, en_flags);
+		resched_curr(target_rq);
+		rq_unlock_irqrestore(target_rq, &rf);
+		raw_spin_unlock_irqrestore(&pp->pi_lock, flags);
+
+		/* recurse */
+		activate_blocked_ents(target_rq, pp, wake_flags);
+
+		raw_spin_lock(&owner->blocked_lock);
+	}
+	raw_spin_unlock(&owner->blocked_lock);
+}
+
+#else
+static inline void do_activate_task(struct rq *rq, struct task_struct *p,
+				    int en_flags)
+{
+	activate_task(rq, p, en_flags);
+}
+
+static inline void activate_blocked_ents(struct rq *target_rq,
+					 struct task_struct *owner,
+					 int wake_flags)
+{
+}
+#endif
+
 static void
 ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		 struct rq_flags *rf)
@@ -3825,7 +3938,8 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		atomic_dec(&task_rq(p)->nr_iowait);
 	}
 
-	activate_task(rq, p, en_flags);
+	do_activate_task(rq, p, en_flags);
+
 	check_preempt_curr(rq, p, wake_flags);
 
 	ttwu_do_wakeup(p);
@@ -3922,13 +4036,19 @@ void sched_ttwu_pending(void *arg)
 	update_rq_clock(rq);
 
 	llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
+		int wake_flags;
 		if (WARN_ON_ONCE(p->on_cpu))
 			smp_cond_load_acquire(&p->on_cpu, !VAL);
 
 		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
 			set_task_cpu(p, cpu_of(rq));
 
-		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
+		wake_flags = p->sched_remote_wakeup ? WF_MIGRATED : 0;
+		ttwu_do_activate(rq, p, wake_flags, &rf);
+		rq_unlock(rq, &rf);
+		activate_blocked_ents(rq, p, wake_flags);
+		rq_lock(rq, &rf);
+		update_rq_clock(rq);
 	}
 
 	/*
@@ -4069,6 +4189,15 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 	update_rq_clock(rq);
 	ttwu_do_activate(rq, p, wake_flags, &rf);
 	rq_unlock(rq, &rf);
+
+	/*
+	 * When activating blocked ents, we will take the entities
+	 * pi_lock, so drop the owners. Would love suggestions for
+	 * a better approach.
+	 */
+	raw_spin_unlock(&p->pi_lock);
+	activate_blocked_ents(rq, p, wake_flags);
+	raw_spin_lock(&p->pi_lock);
 }
 
 /*
@@ -6778,6 +6907,31 @@ static inline bool proxy_return_migration(struct rq *rq, struct rq_flags *rf,
 	return false;
 }
 
+static void proxy_enqueue_on_owner(struct rq *rq, struct task_struct *owner,
+				   struct task_struct *next)
+{
+	/*
+	 * ttwu_activate() will pick them up and place them on whatever rq
+	 * @owner will run next.
+	 */
+	if (!owner->on_rq) {
+		BUG_ON(!next->on_rq);
+		deactivate_task(rq, next, DEQUEUE_SLEEP);
+		if (task_current_selected(rq, next)) {
+			put_prev_task(rq, next);
+			rq_set_selected(rq, rq->idle);
+		}
+		/*
+		 * ttwu_do_activate must not have a chance to activate p
+		 * elsewhere before it's fully extricated from its old rq.
+		 */
+		WARN_ON(next->sleeping_owner);
+		next->sleeping_owner = owner;
+		smp_mb();
+		list_add(&next->blocked_node, &owner->blocked_head);
+	}
+}
+
 /*
  * Find who @next (currently blocked on a mutex) can proxy for.
  *
@@ -6807,7 +6961,6 @@ static inline bool proxy_return_migration(struct rq *rq, struct rq_flags *rf,
 static struct task_struct *
 proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 {
-	struct task_struct *ret = NULL;
 	struct task_struct *p = next;
 	struct task_struct *owner = NULL;
 	bool curr_in_chain = false;
@@ -6886,12 +7039,41 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		}
 
 		if (!owner->on_rq) {
-			/* XXX Don't handle blocked owners yet */
-			if (!proxy_deactivate(rq, next))
-				ret = next;
-			raw_spin_unlock(&p->blocked_lock);
+			/*
+			 * rq->curr must not be added to the blocked_head list or else
+			 * ttwu_do_activate could enqueue it elsewhere before it switches
+			 * out here. The approach to avoiding this is the same as in the
+			 * migrate_task case.
+			 */
+			if (curr_in_chain) {
+				raw_spin_unlock(&p->blocked_lock);
+				raw_spin_unlock(&mutex->wait_lock);
+				return proxy_resched_idle(rq, next);
+			}
+
+			/*
+			 * If !@owner->on_rq, holding @rq->lock will not pin the task,
+			 * so we cannot drop @mutex->wait_lock until we're sure its a blocked
+			 * task on this rq.
+			 *
+			 * We use @owner->blocked_lock to serialize against ttwu_activate().
+			 * Either we see its new owner->on_rq or it will see our list_add().
+			 */
+			if (owner != p) {
+				raw_spin_unlock(&p->blocked_lock);
+				raw_spin_lock(&owner->blocked_lock);
+			}
+
+			proxy_enqueue_on_owner(rq, owner, next);
+
+			if (task_current_selected(rq, next)) {
+				put_prev_task(rq, next);
+				rq_set_selected(rq, rq->idle);
+			}
+			raw_spin_unlock(&owner->blocked_lock);
 			raw_spin_unlock(&mutex->wait_lock);
-			return ret;
+
+			return NULL; /* retry task selection */
 		}
 
 		if (owner == p) {
-- 
2.42.0.869.gea05f2083d-goog

