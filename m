Return-Path: <linux-kernel+bounces-16919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D0F82461B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F7B1C21EB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F3025560;
	Thu,  4 Jan 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azoFA/Wi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0747324B5E;
	Thu,  4 Jan 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso746984e87.1;
        Thu, 04 Jan 2024 08:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704385516; x=1704990316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwvcJwxDzv91yZ88lkQTn+Y5ddJXcrq/Xx7SY1QWYMU=;
        b=azoFA/WiRQeOBH4U02NMV/f0Ko2tIQjO5U+euysu6ovgDJaadpF53nPBoiLKNWulWa
         jQlcrm9caJKSvcSIHC1wlPSj0Nk4sCg89B7ugQhMvj7wgF6vjYYlDmbOM28dT1kFt8/t
         hvLk1EF1esR9bBmii2O2503cUTrVi626koiUdo42ZZkCGYo8nCoMD+8h8j4BkNM0DdlW
         3YHECVwlXUQfa8LPqlax15VYPChWAzoyjtoiaw4HtRrqUnnsPJ1gUTQJ6X8bjfxvZFu0
         JCBDuxQv/762gws0ucSGaV5ifgmWHW2EIWZOU2cKd31IXxVcv/tRSi7jWjNUTMz7H+0x
         0iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704385516; x=1704990316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwvcJwxDzv91yZ88lkQTn+Y5ddJXcrq/Xx7SY1QWYMU=;
        b=R3JOWETAezCxB8dWeqDvK8pqtB6PqOrbanX+dMggFmBz2yAoltpFSGaAIPwAIM/bR7
         Q+eV4h0LJZMbfsYlPcUnPVWE0MHT//AEDlp391nxqFumig/qw/cOLfcY1TUojEDbxDaK
         TX3SoRXZvnxM7PxdGM/0EYymEHEw42EVepEEv2wDBLUnc+bI3xcwqsocVyx6pwQ2Cphe
         Uow10TPWgvEQuQADlWXUdvhsF7jZdR+nj8OcGEedc6ShJMEWYTOrlUR87CV6hEYcgdfZ
         gG01VkO9AD4dkGMrz4zkLQEbL1V1r0oOB3ssQkfe/nQl+nMpUdJYFrJD+ET78x8RWj+H
         ntSA==
X-Gm-Message-State: AOJu0YwIH91Fowdmk++B731S9vWI4dUbMc/+Yz0YnI98cwHeG20c+8iU
	60z8UWjq1r1+jqiuM11qDUc=
X-Google-Smtp-Source: AGHT+IGWtCfUOW8peqAE0gIHkUdv/TQwOZlvYqC5zCX5SlGvjw9sCBe+/OqqWINSd+vii20OXPvw0A==
X-Received: by 2002:a05:6512:3da2:b0:50e:76a4:4e13 with SMTP id k34-20020a0565123da200b0050e76a44e13mr255906lfv.119.1704385516013;
        Thu, 04 Jan 2024 08:25:16 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id i5-20020a0565123e0500b0050e80d1e142sm2789252lfv.170.2024.01.04.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:25:15 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v4 3/4] rcu: Improve handling of synchronize_rcu() users
Date: Thu,  4 Jan 2024 17:25:09 +0100
Message-Id: <20240104162510.72773-4-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104162510.72773-1-urezki@gmail.com>
References: <20240104162510.72773-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

Currently, processing of the next batch of rcu_synchronize nodes
for the new grace period, requires doing a llist reversal operation
to find the tail element of the list. This can be a very costly
operation (high number of cache misses) for a long list.

To address this, this patch introduces a "dummy-wait-node" entity.
At every grace period init, a new wait node is added to the llist.
This wait node is used as wait tail for this new grace period.

This allows lockless additions of new rcu_synchronize nodes in the
rcu_sr_normal_add_req(), while the cleanup work executes and does
the progress. The dummy nodes are removed on next round of cleanup
work execution.

Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 271 +++++++++++++++++++++++++++++++++++++++-------
 kernel/rcu/tree.h |  13 +++
 2 files changed, 244 insertions(+), 40 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7d2ed89efcb3..88a47a6a658e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1423,23 +1423,157 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 }
 
 /*
- * There are three lists for handling synchronize_rcu() users.
- * A first list corresponds to new coming users, second for users
- * which wait for a grace period and third is for which a grace
- * period is passed.
+ * There is a single llist, which is used for handling
+ * synchronize_rcu() users' enqueued rcu_synchronize nodes.
+ * Within this llist, there are two tail pointers:
+ *
+ * wait tail: Tracks the set of nodes, which need to
+ *            wait for the current GP to complete.
+ * done tail: Tracks the set of nodes, for which grace
+ *            period has elapsed. These nodes processing
+ *            will be done as part of the cleanup work
+ *            execution by a kworker.
+ *
+ * At every grace period init, a new wait node is added
+ * to the llist. This wait node is used as wait tail
+ * for this new grace period. Given that there are a fixed
+ * number of wait nodes, if all wait nodes are in use
+ * (which can happen when kworker callback processing
+ * is delayed) and additional grace period is requested.
+ * This means, a system is slow in processing callbacks.
+ *
+ * TODO: If a slow processing is detected, a first node
+ * in the llist should be used as a wait-tail for this
+ * grace period, therefore users which should wait due
+ * to a slow process are handled by _this_ grace period
+ * and not next.
+ *
+ * Below is an illustration of how the done and wait
+ * tail pointers move from one set of rcu_synchronize nodes
+ * to the other, as grace periods start and finish and
+ * nodes are processed by kworker.
+ *
+ *
+ * a. Initial llist callbacks list:
+ *
+ * +----------+           +--------+          +-------+
+ * |          |           |        |          |       |
+ * |   head   |---------> |   cb2  |--------->| cb1   |
+ * |          |           |        |          |       |
+ * +----------+           +--------+          +-------+
+ *
+ *
+ *
+ * b. New GP1 Start:
+ *
+ *                    WAIT TAIL
+ *                      |
+ *                      |
+ *                      v
+ * +----------+     +--------+      +--------+        +-------+
+ * |          |     |        |      |        |        |       |
+ * |   head   ------> wait   |------>   cb2  |------> |  cb1  |
+ * |          |     | head1  |      |        |        |       |
+ * +----------+     +--------+      +--------+        +-------+
+ *
+ *
+ *
+ * c. GP completion:
+ *
+ * WAIT_TAIL == DONE_TAIL
+ *
+ *                   DONE TAIL
+ *                     |
+ *                     |
+ *                     v
+ * +----------+     +--------+      +--------+        +-------+
+ * |          |     |        |      |        |        |       |
+ * |   head   ------> wait   |------>   cb2  |------> |  cb1  |
+ * |          |     | head1  |      |        |        |       |
+ * +----------+     +--------+      +--------+        +-------+
+ *
+ *
+ *
+ * d. New callbacks and GP2 start:
+ *
+ *                    WAIT TAIL                          DONE TAIL
+ *                      |                                 |
+ *                      |                                 |
+ *                      v                                 v
+ * +----------+     +------+    +------+    +------+    +-----+    +-----+    +-----+
+ * |          |     |      |    |      |    |      |    |     |    |     |    |     |
+ * |   head   ------> wait |--->|  cb4 |--->| cb3  |--->|wait |--->| cb2 |--->| cb1 |
+ * |          |     | head2|    |      |    |      |    |head1|    |     |    |     |
+ * +----------+     +------+    +------+    +------+    +-----+    +-----+    +-----+
+ *
+ *
+ *
+ * e. GP2 completion:
+ *
+ * WAIT_TAIL == DONE_TAIL
+ *                   DONE TAIL
+ *                      |
+ *                      |
+ *                      v
+ * +----------+     +------+    +------+    +------+    +-----+    +-----+    +-----+
+ * |          |     |      |    |      |    |      |    |     |    |     |    |     |
+ * |   head   ------> wait |--->|  cb4 |--->| cb3  |--->|wait |--->| cb2 |--->| cb1 |
+ * |          |     | head2|    |      |    |      |    |head1|    |     |    |     |
+ * +----------+     +------+    +------+    +------+    +-----+    +-----+    +-----+
+ *
+ *
+ * While the llist state transitions from d to e, a kworker
+ * can start executing rcu_sr_normal_gp_cleanup_work() and
+ * can observe either the old done tail (@c) or the new
+ * done tail (@e). So, done tail updates and reads need
+ * to use the rel-acq semantics. If the concurrent kworker
+ * observes the old done tail, the newly queued work
+ * execution will process the updated done tail. If the
+ * concurrent kworker observes the new done tail, then
+ * the newly queued work will skip processing the done
+ * tail, as workqueue semantics guarantees that the new
+ * work is executed only after the previous one completes.
+ *
+ * f. kworker callbacks processing complete:
+ *
+ *
+ *                   DONE TAIL
+ *                     |
+ *                     |
+ *                     v
+ * +----------+     +--------+
+ * |          |     |        |
+ * |   head   ------> wait   |
+ * |          |     | head2  |
+ * +----------+     +--------+
+ *
  */
-static struct sr_normal_state {
-	struct llist_head srs_next;	/* request a GP users. */
-	struct llist_head srs_wait;	/* wait for GP users. */
-	struct llist_head srs_done;	/* ready for GP users. */
+static bool rcu_sr_is_wait_head(struct llist_node *node)
+{
+	return &(rcu_state.srs_wait_nodes)[0].node <= node &&
+		node <= &(rcu_state.srs_wait_nodes)[SR_NORMAL_GP_WAIT_HEAD_MAX - 1].node;
+}
 
-	/*
-	 * In order to add a batch of nodes to already
-	 * existing srs-done-list, a tail of srs-wait-list
-	 * is maintained.
-	 */
-	struct llist_node *srs_wait_tail;
-} sr;
+static struct llist_node *rcu_sr_get_wait_head(void)
+{
+	struct sr_wait_node *sr_wn;
+	int i;
+
+	for (i = 0; i < SR_NORMAL_GP_WAIT_HEAD_MAX; i++) {
+		sr_wn = &(rcu_state.srs_wait_nodes)[i];
+
+		if (!atomic_cmpxchg_acquire(&sr_wn->inuse, 0, 1))
+			return &sr_wn->node;
+	}
+
+	return NULL;
+}
+
+static void rcu_sr_put_wait_head(struct llist_node *node)
+{
+	struct sr_wait_node *sr_wn = container_of(node, struct sr_wait_node, node);
+	atomic_set_release(&sr_wn->inuse, 0);
+}
 
 /* Disabled by default. */
 static int rcu_normal_wake_from_gp;
@@ -1462,14 +1596,44 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 
 static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 {
-	struct llist_node *done, *rcu, *next;
+	struct llist_node *done, *rcu, *next, *head;
 
-	done = llist_del_all(&sr.srs_done);
+	/*
+	 * This work execution can potentially execute
+	 * while a new done tail is being updated by
+	 * grace period kthread in rcu_sr_normal_gp_cleanup().
+	 * So, read and updates of done tail need to
+	 * follow acq-rel semantics.
+	 *
+	 * Given that wq semantics guarantees that a single work
+	 * cannot execute concurrently by multiple kworkers,
+	 * the done tail list manipulations are protected here.
+	 */
+	done = smp_load_acquire(&rcu_state.srs_done_tail);
 	if (!done)
 		return;
 
-	llist_for_each_safe(rcu, next, done)
-		rcu_sr_normal_complete(rcu);
+	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
+	head = done->next;
+	done->next = NULL;
+
+	/*
+	 * The dummy node, which is pointed to by the
+	 * done tail which is acq-read above is not removed
+	 * here.  This allows lockless additions of new
+	 * rcu_synchronize nodes in rcu_sr_normal_add_req(),
+	 * while the cleanup work executes. The dummy
+	 * nodes is removed, in next round of cleanup
+	 * work execution.
+	 */
+	llist_for_each_safe(rcu, next, head) {
+		if (!rcu_sr_is_wait_head(rcu)) {
+			rcu_sr_normal_complete(rcu);
+			continue;
+		}
+
+		rcu_sr_put_wait_head(rcu);
+	}
 }
 static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
 
@@ -1478,48 +1642,61 @@ static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *head, *tail;
+	struct llist_node *wait_tail;
 
-	if (llist_empty(&sr.srs_wait))
+	wait_tail = rcu_state.srs_wait_tail;
+	if (wait_tail == NULL)
 		return;
 
-	tail = READ_ONCE(sr.srs_wait_tail);
-	head = __llist_del_all(&sr.srs_wait);
+	rcu_state.srs_wait_tail = NULL;
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
 
-	if (head) {
-		/* Can be not empty. */
-		llist_add_batch(head, tail, &sr.srs_done);
+	// concurrent sr_normal_gp_cleanup work might observe this update.
+	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
+
+	if (wait_tail)
 		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
-	}
 }
 
 /*
  * Helper function for rcu_gp_init().
  */
-static void rcu_sr_normal_gp_init(void)
+static bool rcu_sr_normal_gp_init(void)
 {
-	struct llist_node *head, *tail;
+	struct llist_node *first;
+	struct llist_node *wait_head;
+	bool start_new_poll = false;
 
-	if (llist_empty(&sr.srs_next))
-		return;
+	first = READ_ONCE(rcu_state.srs_next.first);
+	if (!first || rcu_sr_is_wait_head(first))
+		return start_new_poll;
+
+	wait_head = rcu_sr_get_wait_head();
+	if (!wait_head) {
+		// Kick another GP to retry.
+		start_new_poll = true;
+		return start_new_poll;
+	}
 
-	tail = llist_del_all(&sr.srs_next);
-	head = llist_reverse_order(tail);
+	/* Inject a wait-dummy-node. */
+	llist_add(wait_head, &rcu_state.srs_next);
 
 	/*
-	 * A waiting list of GP should be empty on this step,
-	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
+	 * A waiting list of rcu_synchronize nodes should be empty on
+	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
 	 * rolls it over. If not, it is a BUG, warn a user.
 	 */
-	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
+	WARN_ON_ONCE(rcu_state.srs_wait_tail != NULL);
+	rcu_state.srs_wait_tail = wait_head;
+	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
 
-	WRITE_ONCE(sr.srs_wait_tail, tail);
-	__llist_add_batch(head, tail, &sr.srs_wait);
+	return start_new_poll;
 }
 
 static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
 {
-	llist_add((struct llist_node *) &rs->head, &sr.srs_next);
+	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
 }
 
 /*
@@ -1532,6 +1709,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	unsigned long mask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root();
+	bool start_new_poll;
 
 	WRITE_ONCE(rcu_state.gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
@@ -1556,11 +1734,24 @@ static noinline_for_stack bool rcu_gp_init(void)
 	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
-	rcu_sr_normal_gp_init();
+	start_new_poll = rcu_sr_normal_gp_init();
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
 	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
 
+	/*
+	 * The "start_new_poll" is set to true, only when this GP is not able
+	 * to handle anything and there are outstanding users. It happens when
+	 * the rcu_sr_normal_gp_init() function was not able to insert a dummy
+	 * separator to the llist, because there were no left any dummy-nodes.
+	 *
+	 * Number of dummy-nodes is fixed, it could be that we are run out of
+	 * them, if so we start a new pool request to repeat a try. It is rare
+	 * and it means that a system is doing a slow processing of callbacks.
+	 */
+	if (start_new_poll)
+		(void) start_poll_synchronize_rcu();
+
 	/*
 	 * Apply per-leaf buffered online and offline operations to
 	 * the rcu_node tree. Note that this new grace period need not
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e9821a8422db..4c35d7d37647 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -316,6 +316,13 @@ do {									\
 	__set_current_state(TASK_RUNNING);				\
 } while (0)
 
+#define SR_NORMAL_GP_WAIT_HEAD_MAX 5
+
+struct sr_wait_node {
+	atomic_t inuse;
+	struct llist_node node;
+};
+
 /*
  * RCU global state, including node hierarchy.  This hierarchy is
  * represented in "heap" form in a dense array.  The root (first level)
@@ -401,6 +408,12 @@ struct rcu_state {
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
 	int nocb_is_setup;			/* nocb is setup from boot */
+
+	/* synchronize_rcu() part. */
+	struct llist_head srs_next;	/* request a GP users. */
+	struct llist_node *srs_wait_tail; /* wait for GP users. */
+	struct llist_node *srs_done_tail; /* ready for GP users. */
+	struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
 };
 
 /* Values for rcu_state structure's gp_flags field. */
-- 
2.39.2


