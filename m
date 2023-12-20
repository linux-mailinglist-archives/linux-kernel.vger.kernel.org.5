Return-Path: <linux-kernel+bounces-6480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E8C819973
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856B81C2584B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D062136F;
	Wed, 20 Dec 2023 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3u7i5CH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F802110F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d3954833a5so3739885b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057165; x=1703661965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GD2Y0tHGeibrkPkligIe7zxx4QpQ0iJPeFN74TU+wQ=;
        b=c3u7i5CHHj6fgET20C+5ompzwUlGHpOCXwhkAOpRbfMMyj8AWnorodiJ7B9wA9GNyv
         mQ63boFiTnF/Yi3fVlTX+jgmRMXcpkBL5CeEgX8kg1S3da2mDfqyslf9c6xPvEpA+FFp
         npgs399JtRLO1xYr9TlrRwH/XXKxeQ6B4UwjPP/NeyGM/hSI6EMUrlJ6x3cPJZw8sZsg
         MQWM3Oz2fROK4D28aUTX92HQ5UWMwxWqlZngBCdI9r9TzkFqnn11M+LCT3TGafNylh6q
         GeeZNuyywUHYYm8u8iasvGfhTINdyzTBTF4O3RK/e+v6qqdpVnCCn1ySbQPaPNAGEWKI
         nAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057165; x=1703661965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GD2Y0tHGeibrkPkligIe7zxx4QpQ0iJPeFN74TU+wQ=;
        b=GVzcQEpW59Q4c5Lapd1etY4zsMlaFTf4DK/n9f+NkymZh7VuZcgA2qv2sPX1BpgYaV
         3LcB97OKo8D4A99J9F8woHbN+vEaG7Xszgot0eiyTbCrb/avQCcqxJR4+K1sTzDyOIeN
         ks/W0LipE+XWvfHwDOXT7GT/6nPgo7+LDr85cs1ZNhP4f8oaIsOj2w539qU+jYM4PDIe
         PmrqqFuJUQ75zomNj6vf+V6u0+/B0mUzp35aLe/dYqYzeq3WqVw0g/SiUr4M3dBm7zvg
         HbXcX8XhkN7o5BFj9I1ZaNOBgsxJN7XR+cw3GNR/8QV3YFVPALjtzHGxiGMSIwNa9Ez/
         W+yQ==
X-Gm-Message-State: AOJu0YzLsnoMH3Zx/0br28cP5IPvCzCJ3w05F7pkDHdANgx85XsbnLmt
	uZXn6JJuTN8nsAwK0IYfB3g=
X-Google-Smtp-Source: AGHT+IGBrpaIjNXCrDUUf7/GkePZtaXUUn67ZYSs19dZlZ0GA+DovjYXE6DETvBvS+AbzFBpGuVAaQ==
X-Received: by 2002:a05:6a00:1ad3:b0:6d8:b31e:ac7d with SMTP id f19-20020a056a001ad300b006d8b31eac7dmr4407931pfv.7.1703057164519;
        Tue, 19 Dec 2023 23:26:04 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id x15-20020aa784cf000000b006d3c3ad8070sm7336789pfn.143.2023.12.19.23.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:26:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/10] workqueue: Implement system-wide nr_active enforcement for unbound workqueues
Date: Wed, 20 Dec 2023 16:24:40 +0900
Message-ID: <20231220072529.1036099-10-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220072529.1036099-1-tj@kernel.org>
References: <20231220072529.1036099-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A pool_workqueue (pwq) represents the connection between a workqueue and a
worker_pool. One of the roles that a pwq plays is enforcement of the
max_active concurrency limit. Before 636b927eba5b ("workqueue: Make unbound
workqueues to use per-cpu pool_workqueues"), there was one pwq per each CPU
for per-cpu workqueues and per each NUMA node for unbound workqueues, which
was a natural result of per-cpu workqueues being served by per-cpu pools and
unbound by per-NUMA pools.

In terms of max_active enforcement, this was, while not perfect, workable.
For per-cpu workqueues, it was fine. For unbound, it wasn't great in that
NUMA machines would get max_active that's multiplied by the number of nodes
but didn't cause huge problems because NUMA machines are relatively rare and
the node count is usually pretty low.

However, cache layouts are more complex now and sharing a worker pool across
a whole node didn't really work well for unbound workqueues. Thus, a series
of commits culminating on 8639ecebc9b1 ("workqueue: Make unbound workqueues
to use per-cpu pool_workqueues") implemented more flexible affinity
mechanism for unbound workqueues which enables using e.g. last-level-cache
aligned pools. In the process, 636b927eba5b ("workqueue: Make unbound
workqueues to use per-cpu pool_workqueues") made unbound workqueues use
per-cpu pwqs like per-cpu workqueues.

While the change was necessary to enable more flexible affinity scopes, this
came with the side effect of blowing up the effective max_active for unbound
workqueues. Before, the effective max_active for unbound workqueues was
multiplied by the number of nodes. After, by the number of CPUs.

636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu
pool_workqueues") claims that this should generally be okay. It is okay for
users which self-regulates concurrency level which are the vast majority;
however, there are enough use cases which actually depend on max_active to
prevent the level of concurrency from going bonkers including several IO
handling workqueues that can issue a work item for each in-flight IO. With
targeted benchmarks, the misbehavior can easily be exposed as reported in
http://lkml.kernel.org/r/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3.

Unfortunately, there is no way to express what these use cases need using
per-cpu max_active. A CPU may issue most of in-flight IOs, so we don't want
to set max_active too low but as soon as we increase max_active a bit, we
can end up with unreasonable number of in-flight work items when many CPUs
issue IOs at the same time. ie. The acceptable lowest max_active is higher
than the acceptable highest max_active.

Ideally, max_active for an unbound workqueue should be system-wide so that
the users can regulate the total level of concurrency regardless of node and
cache layout. The reasons workqueue hasn't implemented that yet are:

- One max_active enforcement decouples from pool boundaires, chaining
  execution after a work item finishes requires inter-pool operations which
  would require lock dancing, which is nasty.

- Sharing a single nr_active count across the whole system can be pretty
  expensive on NUMA machines.

- Per-pwq enforcement had been more or less okay while we were using
  per-node pools.

It looks like we no longer can avoid decoupling max_active enforcement from
pool boundaries. This patch implements system-wide nr_active mechanism with
the following design characteristics:

- To avoid sharing a single counter across multiple nodes, the configured
  max_active is split across nodes according to the proportion of online
  CPUs per node. e.g. A node with twice more online CPUs will get twice
  higher portion of max_active.

- Workqueue used to be able to process a chain of interdependent work items
  which is as long as max_active. We can't do this anymore as max_active is
  distributed across the nodes. Instead, a new parameter min_active is
  introduced which determines the minimum level of concurrency within a node
  regardless of how max_active distribution comes out to be.

  It is set to the smaller of max_active and WQ_DFL_MIN_ACTIVE which is 8.
  This can lead to higher effective max_weight than configured and also
  deadlocks if a workqueue was depending on being able to handle chains of
  interdependent work items that are longer than 8.

  I believe these should be fine given that the number of CPUs in each NUMA
  node is usually higher than 8 and work item chain longer than 8 is pretty
  unlikely. However, if these assumptions turn out to be wrong, we'll need
  to add an interface to adjust min_active.

- Each unbound wq has an array of struct wq_node_nr_active which tracks
  per-node nr_active. When its pwq wants to run a work item, it has to
  obtain the matching node's nr_active. If over the node's max_active, the
  pwq is queued on wq_node_nr_active->pending_pwqs. As work items finish,
  the completion path round-robins the pending pwqs activating the first
  inactive work item of each, which involves some pool lock dancing and
  kicking other pools. It's not the simplest code but doesn't look too bad.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Naohiro Aota <Naohiro.Aota@wdc.com>
Link: http://lkml.kernel.org/r/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3
Fixes: 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu pool_workqueues")
---
 include/linux/workqueue.h |  35 ++++-
 kernel/workqueue.c        | 268 ++++++++++++++++++++++++++++++++++----
 2 files changed, 278 insertions(+), 25 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 24b1e5070f4d..ad97453e7c3a 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -405,6 +405,13 @@ enum {
 	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
 	WQ_UNBOUND_MAX_ACTIVE	= WQ_MAX_ACTIVE,
 	WQ_DFL_ACTIVE		= WQ_MAX_ACTIVE / 2,
+
+	/*
+	 * Per-node default cap on min_active. Unless explicitly set, min_active
+	 * is set to min(max_active, WQ_DFL_MIN_ACTIVE). For more details, see
+	 * workqueue_struct->min_active definition.
+	 */
+	WQ_DFL_MIN_ACTIVE	= 8,
 };
 
 /*
@@ -447,11 +454,33 @@ extern struct workqueue_struct *system_freezable_power_efficient_wq;
  * alloc_workqueue - allocate a workqueue
  * @fmt: printf format for the name of the workqueue
  * @flags: WQ_* flags
- * @max_active: max in-flight work items per CPU, 0 for default
+ * @max_active: max in-flight work items, 0 for default
  * remaining args: args for @fmt
  *
- * Allocate a workqueue with the specified parameters.  For detailed
- * information on WQ_* flags, please refer to
+ * For a per-cpu workqueue, @max_active limits the number of in-flight work
+ * items for each CPU. e.g. @max_active of 1 indicates that each CPU can be
+ * executing at most one work item for the workqueue.
+ *
+ * For unbound workqueues, @max_active limits the number of in-flight work items
+ * for the whole system. e.g. @max_active of 16 indicates that that there can be
+ * at most 16 work items executing for the workqueue in the whole system.
+ *
+ * As sharing the same active counter for an unbound workqueue across multiple
+ * NUMA nodes can be expensive, @max_active is distributed to each NUMA node
+ * according to the proportion of the number of online CPUs and enforced
+ * independently.
+ *
+ * Depending on online CPU distribution, a node may end up with per-node
+ * max_active which is significantly lower than @max_active, which can lead to
+ * deadlocks if the per-node concurrency limit is lower than the maximum number
+ * of interdependent work items for the workqueue.
+ *
+ * To guarantee forward progress regardless of online CPU distribution, the
+ * concurrency limit on every node is guaranteed to be equal to or greater than
+ * min_active which is set to min(@max_active, %WQ_DFL_MIN_ACTIVE). This means
+ * that the sum of per-node max_active's may be larger than @max_active.
+ *
+ * For detailed information on %WQ_* flags, please refer to
  * Documentation/core-api/workqueue.rst.
  *
  * RETURNS:
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6aa6f2eee94e..0017e9094034 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -123,6 +123,9 @@ enum {
  *
  * L: pool->lock protected.  Access with pool->lock held.
  *
+ * LN: pool->lock and wq_node_nr_active->lock protected for writes. Either for
+ *     reads.
+ *
  * K: Only modified by worker while holding pool->lock. Can be safely read by
  *    self, while holding pool->lock or from IRQ context if %current is the
  *    kworker.
@@ -241,17 +244,18 @@ struct pool_workqueue {
 	 * pwq->inactive_works instead of pool->worklist and marked with
 	 * WORK_STRUCT_INACTIVE.
 	 *
-	 * All work items marked with WORK_STRUCT_INACTIVE do not participate
-	 * in pwq->nr_active and all work items in pwq->inactive_works are
-	 * marked with WORK_STRUCT_INACTIVE.  But not all WORK_STRUCT_INACTIVE
-	 * work items are in pwq->inactive_works.  Some of them are ready to
-	 * run in pool->worklist or worker->scheduled.  Those work itmes are
-	 * only struct wq_barrier which is used for flush_work() and should
-	 * not participate in pwq->nr_active.  For non-barrier work item, it
-	 * is marked with WORK_STRUCT_INACTIVE iff it is in pwq->inactive_works.
+	 * All work items marked with WORK_STRUCT_INACTIVE do not participate in
+	 * nr_active and all work items in pwq->inactive_works are marked with
+	 * WORK_STRUCT_INACTIVE. But not all WORK_STRUCT_INACTIVE work items are
+	 * in pwq->inactive_works. Some of them are ready to run in
+	 * pool->worklist or worker->scheduled. Those work itmes are only struct
+	 * wq_barrier which is used for flush_work() and should not participate
+	 * in nr_active. For non-barrier work item, it is marked with
+	 * WORK_STRUCT_INACTIVE iff it is in pwq->inactive_works.
 	 */
 	int			nr_active;	/* L: nr of active works */
 	struct list_head	inactive_works;	/* L: inactive works */
+	struct list_head	pending_node;	/* LN: node on wq_node_nr_active->pending_pwqs */
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
 
@@ -283,9 +287,18 @@ struct wq_device;
  * on each CPU, in an unbound workqueue, max_active applies to the whole system.
  * As sharing a single nr_active across multiple sockets can be very expensive,
  * the counting and enforcement is per NUMA node.
+ *
+ * The following struct is used to enforce per-node max_active. When a pwq wants
+ * to start executing a work item, it should increment ->count using
+ * tryinc_node_nr_active(). If acquisition fails due to the count already being
+ * over wq_node_max_active(), the pwq is queued on ->pending_pwqs. As in-flight
+ * work items finish and decrement ->count, node_activate_pending_pwq()
+ * activates the pending pwqs in round-robin order.
  */
 struct wq_node_nr_active {
 	atomic_t		count;		/* per-node nr_active count */
+	raw_spinlock_t		lock;		/* nests inside pool locks */
+	struct list_head	pending_pwqs;	/* LN: pwqs with inactive works */
 };
 
 /*
@@ -308,8 +321,12 @@ struct workqueue_struct {
 	struct worker		*rescuer;	/* MD: rescue worker */
 
 	int			nr_drainers;	/* WQ: drain in progress */
+
+	/* See alloc_workqueue() function comment for info on min/max_active */
 	int			max_active;	/* WQ: max active works */
+	int			min_active;	/* WQ: min active works */
 	int			saved_max_active; /* WQ: saved max_active */
+	int			saved_min_active; /* WQ: saved min_active */
 
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
 	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
@@ -1434,6 +1451,31 @@ static struct wq_node_nr_active *wq_node_nr_active(struct workqueue_struct *wq,
 	return wq->node_nr_active[node];
 }
 
+/**
+ * wq_node_max_active - Determine max_active to use
+ * @wq: workqueue of interest
+ * @node: NUMA node, can be %NUMA_NO_NODE
+ *
+ * Determine the max_active @wq should use on @node. @wq must be unbound.
+ * max_active is distributed among nodes according to the proportions of numbers
+ * of online cpus. The result is always between @wq->min_active and max_active.
+ */
+static int wq_node_max_active(struct workqueue_struct *wq, int node)
+{
+	int node_max_active;
+
+	if (node == NUMA_NO_NODE)
+		return wq->min_active;
+
+	node_max_active = DIV_ROUND_UP(wq->max_active * node_nr_cpus[node],
+				       num_online_cpus());
+	/*
+	 * We aren't synchronizing against CPU hotplug operations and can get
+	 * stray numbers. Clamp between min and max.
+	 */
+	return clamp(node_max_active, wq->min_active, wq->max_active);
+}
+
 /**
  * get_pwq - get an extra reference on the specified pool_workqueue
  * @pwq: pool_workqueue to get
@@ -1528,19 +1570,35 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
 	return true;
 }
 
+static bool tryinc_node_nr_active(struct wq_node_nr_active *nna, int max)
+{
+	while (true) {
+		int old, tmp;
+
+		old = atomic_read(&nna->count);
+		if (old >= max)
+			return false;
+		tmp = atomic_cmpxchg_relaxed(&nna->count, old, old + 1);
+		if (tmp == old)
+			return true;
+	}
+}
+
 /**
  * pwq_tryinc_nr_active - Try to increment nr_active for a pwq
  * @pwq: pool_workqueue of interest
+ * @fill: max_active may have increased, try to increase concurrency level
  *
  * Try to increment nr_active for @pwq. Returns %true if an nr_active count is
  * successfully obtained. %false otherwise.
  */
-static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
+static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
 {
 	struct workqueue_struct *wq = pwq->wq;
 	struct worker_pool *pool = pwq->pool;
 	struct wq_node_nr_active *nna = wq_node_nr_active(wq, pool->node);
 	bool obtained = false;
+	int node_max_active;
 
 	lockdep_assert_held(&pool->lock);
 
@@ -1550,9 +1608,51 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
 		goto out;
 	}
 
-	atomic_inc(&nna->count);
-	obtained = true;
+	/*
+	 * Unbound workqueue uses per-node shared nr_active $nna. If @pwq is
+	 * already waiting on $nna, pwq_dec_nr_active() will maintain the
+	 * concurrency level. Don't jump the line.
+	 *
+	 * We need to ignore the pending test after max_active has increased as
+	 * pwq_dec_nr_active() can only maintain the concurrency level but not
+	 * increase it. This is indicated by @fill.
+	 */
+	if (!list_empty(&pwq->pending_node) && likely(!fill))
+		goto out;
+
+	node_max_active = wq_node_max_active(wq, pool->node);
+
+	obtained = tryinc_node_nr_active(nna, node_max_active);
+	if (obtained)
+		goto out;
+
+	/*
+	 * Lockless acquisition failed. Lock, add ourself to $nna->pending_pwqs
+	 * and try again. The smp_mb() is paired with the implied memory barrier
+	 * of atomic_dec_return() in pwq_dec_nr_active() to ensure that either
+	 * we see the decremented $nna->count or they see non-empty
+	 * $nna->pending_pwqs.
+	 */
+	raw_spin_lock(&nna->lock);
+
+	if (list_empty(&pwq->pending_node))
+		list_add_tail(&pwq->pending_node, &nna->pending_pwqs);
+	else if (likely(!fill))
+		goto out_unlock;
+
+	smp_mb();
+
+	obtained = tryinc_node_nr_active(nna, node_max_active);
 
+	/*
+	 * If @fill, @pwq might have already been pending. Being spuriously
+	 * pending in cold paths doesn't affect anything. Let's leave it be.
+	 */
+	if (obtained && likely(!fill))
+		list_del_init(&pwq->pending_node);
+
+out_unlock:
+	raw_spin_unlock(&nna->lock);
 out:
 	if (obtained)
 		pwq->nr_active++;
@@ -1562,6 +1662,7 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
 /**
  * pwq_activate_first_inactive - Activate the first inactive work item on a pwq
  * @pwq: pool_workqueue of interest
+ * @fill: max_active may have increased, try to increase concurrency level
  *
  * Activate the first inactive work item of @pwq if available and allowed by
  * max_active limit.
@@ -1569,13 +1670,13 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
  * Returns %true if an inactive work item has been activated. %false if no
  * inactive work item is found or max_active limit is reached.
  */
-static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
+static bool pwq_activate_first_inactive(struct pool_workqueue *pwq, bool fill)
 {
 	struct work_struct *work =
 		list_first_entry_or_null(&pwq->inactive_works,
 					 struct work_struct, entry);
 
-	if (work && pwq_tryinc_nr_active(pwq)) {
+	if (work && pwq_tryinc_nr_active(pwq, fill)) {
 		__pwq_activate_work(pwq, work);
 		return true;
 	} else {
@@ -1583,11 +1684,95 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
 	}
 }
 
+/**
+ * node_activate_pending_pwq - Activate a pending pwq on a wq_node_nr_active
+ * @nna: wq_node_nr_active to activate a pending pwq for
+ * @caller_pool: worker_pool the caller is locking
+ *
+ * Activate a pwq in @nna->pending_pwqs. Called with @caller_pool locked.
+ * @caller_pool may be unlocked and relocked to lock other worker_pools.
+ */
+static void node_activate_pending_pwq(struct wq_node_nr_active *nna,
+				      struct worker_pool *caller_pool)
+{
+	struct worker_pool *locked_pool = caller_pool;
+	struct pool_workqueue *pwq;
+	struct work_struct *work;
+	int node_max_active;
+
+	lockdep_assert_held(&caller_pool->lock);
+
+	raw_spin_lock(&nna->lock);
+retry:
+	pwq = list_first_entry_or_null(&nna->pending_pwqs,
+				       struct pool_workqueue, pending_node);
+	if (!pwq)
+		goto out_unlock;
+
+	/*
+	 * If @pwq is for a different pool than @locked_pool, we need to lock
+	 * @pwq->pool->lock. Let's trylock first. If unsuccessful, do the unlock
+	 * / lock dance. For that, we also need to release @nna->lock as it's
+	 * nested inside pool locks.
+	 */
+	if (pwq->pool != locked_pool) {
+		raw_spin_unlock(&locked_pool->lock);
+		locked_pool = pwq->pool;
+		if (!raw_spin_trylock(&locked_pool->lock)) {
+			raw_spin_unlock(&nna->lock);
+			raw_spin_lock(&locked_pool->lock);
+			raw_spin_lock(&nna->lock);
+			goto retry;
+		}
+	}
+
+	/*
+	 * $pwq may not have any inactive work items due to e.g. cancellations.
+	 * Drop it from pending_pwqs and see if there's another one.
+	 */
+	work = list_first_entry_or_null(&pwq->inactive_works,
+					struct work_struct, entry);
+	if (!work) {
+		list_del_init(&pwq->pending_node);
+		goto retry;
+	}
+
+	/*
+	 * Acquire an nr_active count and activate the inactive work item. If
+	 * $pwq still has inactive work items, rotate it to the end of the
+	 * pending_pwqs so that we round-robin through them. This means that
+	 * inactive work items are not activated in queueing order which is fine
+	 * given that there has never been any ordering across different pwqs.
+	 */
+	node_max_active = wq_node_max_active(pwq->wq, pwq->pool->node);
+	if (likely(tryinc_node_nr_active(nna, node_max_active))) {
+		pwq->nr_active++;
+		__pwq_activate_work(pwq, work);
+
+		if (list_empty(&pwq->inactive_works))
+			list_del_init(&pwq->pending_node);
+		else
+			list_move_tail(&pwq->pending_node, &nna->pending_pwqs);
+
+		/* if activating a foreign pool, make sure it's running */
+		if (pwq->pool != caller_pool)
+			kick_pool(pwq->pool);
+	}
+
+out_unlock:
+	raw_spin_unlock(&nna->lock);
+	if (locked_pool != caller_pool) {
+		raw_spin_unlock(&locked_pool->lock);
+		raw_spin_lock(&caller_pool->lock);
+	}
+}
+
 /**
  * pwq_dec_nr_active - Retire an active count
  * @pwq: pool_workqueue of interest
  *
  * Decrement @pwq's nr_active and try to activate the first inactive work item.
+ * For unbound workqueues, this function may temporarily drop @pwq->pool->lock.
  */
 static void pwq_dec_nr_active(struct pool_workqueue *pwq)
 {
@@ -1607,12 +1792,30 @@ static void pwq_dec_nr_active(struct pool_workqueue *pwq)
 	 * inactive work item on @pwq itself.
 	 */
 	if (!nna) {
-		pwq_activate_first_inactive(pwq);
+		pwq_activate_first_inactive(pwq, false);
 		return;
 	}
 
-	atomic_dec(&nna->count);
-	pwq_activate_first_inactive(pwq);
+	/*
+	 * If @pwq is for an unbound workqueue, it's more complicated because
+	 * multiple pwqs and pools may be sharing the nr_active count. When a
+	 * pwq needs to wait for an nr_active count, it puts itself on
+	 * $nna->pending_pwqs. The following atomic_dec_return()'s implied
+	 * memory barrier is paired with smp_mb() in pwq_tryinc_nr_active() to
+	 * guarantee that either we see non-empty pending_pwqs or they see
+	 * decremented $nna->count.
+	 *
+	 * wq_node_max_active() may change as CPUs come online/offline and
+	 * @pwq->wq's max_active gets updated. However, it is guaranteed to be
+	 * euqal to or larger than @pwq->wq->min_active which is above zero
+	 * unless freezing. This maintains the forward progress guarantee.
+	 */
+	if (atomic_dec_return(&nna->count) >=
+	    wq_node_max_active(pwq->wq, pool->node))
+		return;
+
+	if (!list_empty(&nna->pending_pwqs))
+		node_activate_pending_pwq(nna, pool);
 }
 
 /**
@@ -1935,7 +2138,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	pwq->nr_in_flight[pwq->work_color]++;
 	work_flags = work_color_to_flags(pwq->work_color);
 
-	if (pwq_tryinc_nr_active(pwq)) {
+	if (pwq_tryinc_nr_active(pwq, false)) {
 		if (list_empty(&pool->worklist))
 			pool->watchdog_ts = jiffies;
 
@@ -3170,7 +3373,7 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 
 	barr->task = current;
 
-	/* The barrier work item does not participate in pwq->nr_active. */
+	/* The barrier work item does not participate in nr_active. */
 	work_flags |= WORK_STRUCT_INACTIVE;
 
 	/*
@@ -4084,6 +4287,8 @@ static void free_node_nr_active(struct wq_node_nr_active **ptr_ar)
 static void init_node_nr_active(struct wq_node_nr_active *nna)
 {
 	atomic_set(&nna->count, 0);
+	raw_spin_lock_init(&nna->lock);
+	INIT_LIST_HEAD(&nna->pending_pwqs);
 }
 
 /*
@@ -4325,6 +4530,15 @@ static void pwq_release_workfn(struct kthread_work *work)
 		mutex_unlock(&wq_pool_mutex);
 	}
 
+	if (!list_empty(&pwq->pending_node)) {
+		struct wq_node_nr_active *nna =
+			wq_node_nr_active(pwq->wq, pwq->pool->node);
+
+		raw_spin_lock_irq(&nna->lock);
+		list_del_init(&pwq->pending_node);
+		raw_spin_unlock_irq(&nna->lock);
+	}
+
 	call_rcu(&pwq->rcu, rcu_free_pwq);
 
 	/*
@@ -4350,6 +4564,7 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 	pwq->flush_color = -1;
 	pwq->refcnt = 1;
 	INIT_LIST_HEAD(&pwq->inactive_works);
+	INIT_LIST_HEAD(&pwq->pending_node);
 	INIT_LIST_HEAD(&pwq->pwqs_node);
 	INIT_LIST_HEAD(&pwq->mayday_node);
 	kthread_init_work(&pwq->release_work, pwq_release_workfn);
@@ -4835,13 +5050,16 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 
 	if ((wq->flags & WQ_FREEZABLE) && workqueue_freezing) {
 		wq->max_active = 0;
+		wq->min_active = 0;
 		return;
 	}
 
-	if (wq->max_active == wq->saved_max_active)
+	if (wq->max_active == wq->saved_max_active &&
+	    wq->min_active == wq->saved_min_active)
 		return;
 
 	wq->max_active = wq->saved_max_active;
+	wq->min_active = wq->saved_min_active;
 
 	/*
 	 * Round-robin through pwq's activating the first inactive work item
@@ -4856,7 +5074,7 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 
 			/* can be called during early boot w/ irq disabled */
 			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq_activate_first_inactive(pwq)) {
+			if (pwq_activate_first_inactive(pwq, true)) {
 				activated = true;
 				kick_pool(pwq->pool);
 			}
@@ -4907,7 +5125,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	/* init wq */
 	wq->flags = flags;
 	wq->max_active = max_active;
-	wq->saved_max_active = max_active;
+	wq->min_active = min(max_active, WQ_DFL_MIN_ACTIVE);
+	wq->saved_max_active = wq->max_active;
+	wq->saved_min_active = wq->min_active;
 	mutex_init(&wq->mutex);
 	atomic_set(&wq->nr_pwqs_to_flush, 0);
 	INIT_LIST_HEAD(&wq->pwqs);
@@ -5074,7 +5294,8 @@ EXPORT_SYMBOL_GPL(destroy_workqueue);
  * @wq: target workqueue
  * @max_active: new max_active value.
  *
- * Set max_active of @wq to @max_active.
+ * Set max_active of @wq to @max_active. See the alloc_workqueue() function
+ * comment.
  *
  * CONTEXT:
  * Don't call from IRQ context.
@@ -5091,6 +5312,9 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 
 	wq->flags &= ~__WQ_ORDERED;
 	wq->saved_max_active = max_active;
+	if (wq->flags & WQ_UNBOUND)
+		wq->saved_min_active = min(wq->saved_min_active, max_active);
+
 	wq_adjust_max_active(wq);
 	mutex_unlock(&wq->mutex);
 }
-- 
2.43.0


