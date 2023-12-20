Return-Path: <linux-kernel+bounces-6479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B027B819972
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EAE0B25C20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5E4210FD;
	Wed, 20 Dec 2023 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRnpgK0C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84520DD0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d099d316a8so4964031b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057161; x=1703661961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3JveP/DuiraZfXSsvqi99UWeKTbTpJgX1qaauvcXrs=;
        b=eRnpgK0CS3DI31Jmb7sAcjACMeXNft6WSsDy/QcluLyKBSls5auKaRcZyBHcIw7ouJ
         LMMMEBm2pT8W9YghgNZgF80uyUsPgwK1agTDeHE6rolT2RQvAoNFE49UIzgQi4MZ1IE+
         5A+YqqFAxMSz0Jr/vr6ZsBLnJbKf0dyVAdI6X3jaOX5aKpuDAx5jCWvArezeJnyc1IUE
         FzOLsMz0X2Otl0sP1Aoxkfwv3Mhl133jRPYqwETrLOeUYGRSVFtFpiQLrCY/kOtCR3OX
         EQiTKI3Z+mzgQ0JFc7+sLKTtgQUj1SfIffdb3VKR6tzZKK6LwLEPLA9hDhYHR1sDsAf2
         BPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057161; x=1703661961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3JveP/DuiraZfXSsvqi99UWeKTbTpJgX1qaauvcXrs=;
        b=vseJaTL14NriVT/UCIudikEhOn9x54U/mS2ATvBudEI+dJKI+6FP6Aa0xrBl5+AVF7
         mHZad7R3+hp8QIMdQ3Krk5tTDHfLUUL79zKcAiXvLickW7givXCoBq6LQvJVd+eVndnO
         xP+ld5Bravqy7+eeDLaPSdvuIoxglPMINYvS1wqJQf/MWy70Vrd5TNyxATrtogVqDE/l
         /Hx8RqX4al9CCaKS4S3x5E1na6gGxOQtWtzDIIDuwVxwZ+cqTSwl0vAmwHzbhl30qGTr
         7WbYASFVHogTGMJ/aoXgpdA+lsIBU1lCZXmTN+BIslFUyIwvvhNW8FIdCLXyc8c3Oc4l
         YQrA==
X-Gm-Message-State: AOJu0YzAWUehx4KMDwIwYapOLVkEA5bHrFQUhdbzRuWzinki34Y/PWwC
	pkfIkfhIkKcghL2xDI+D+ZCejWwc/8tD6w==
X-Google-Smtp-Source: AGHT+IFMC/FqS2P6CtsAk4PP2neCoOpXZH3uVSCGvVukub1fE2iwhThbadwbB6/Au9oKqDFpPNZMSg==
X-Received: by 2002:a05:6a00:1d84:b0:6d7:5e29:937a with SMTP id z4-20020a056a001d8400b006d75e29937amr5188113pfw.61.1703057161212;
        Tue, 19 Dec 2023 23:26:01 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id kq13-20020a056a004b0d00b006c3069547bfsm21221355pfb.79.2023.12.19.23.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:26:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/10] workqueue: Introduce struct wq_node_nr_active
Date: Wed, 20 Dec 2023 16:24:39 +0900
Message-ID: <20231220072529.1036099-9-tj@kernel.org>
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

Currently, for both percpu and unbound workqueues, max_active applies
per-cpu, which is a recent change for unbound workqueues. The change for
unbound workqueues was a significant departure from the previous behavior of
per-node application. It made some use cases create undesirable number of
concurrent work items and left no good way of fixing them. To address the
problem, workqueue is implementing a NUMA node segmented global nr_active
mechanism, which will be explained further in the next patch.

As a preparation, this patch introduces struct wq_node_nr_active. It's a
data structured allocated for each workqueue and NUMA node pair and
currently only tracks the workqueue's number of active work items on the
node. This is split out from the next patch to make it easier to understand
and review.

Note that there is an extra wq_node_nr_active allocated for the invalid node
nr_node_ids which is used to track nr_active for pools which don't have NUMA
node associated such as the default fallback system-wide pool.

This doesn't cause any behavior changes visible to userland yet. The next
patch will expand to implement the control mechanism on top.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 132 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9982c63470e5..6aa6f2eee94e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -278,6 +278,16 @@ struct wq_flusher {
 
 struct wq_device;
 
+/*
+ * Unlike in a per-cpu workqueue where max_active limits its concurrency level
+ * on each CPU, in an unbound workqueue, max_active applies to the whole system.
+ * As sharing a single nr_active across multiple sockets can be very expensive,
+ * the counting and enforcement is per NUMA node.
+ */
+struct wq_node_nr_active {
+	atomic_t		count;		/* per-node nr_active count */
+};
+
 /*
  * The externally visible workqueue.  It relays the issued work items to
  * the appropriate worker_pool through its pool_workqueues.
@@ -324,6 +334,7 @@ struct workqueue_struct {
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
 	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
+	struct wq_node_nr_active **node_nr_active; /* I: per-node nr_active */
 };
 
 static struct kmem_cache *pwq_cache;
@@ -1398,6 +1409,31 @@ work_func_t wq_worker_last_func(struct task_struct *task)
 	return worker->last_func;
 }
 
+/**
+ * wq_node_nr_active - Determine wq_node_nr_active to use
+ * @wq: workqueue of interest
+ * @node: NUMA node, can be %NUMA_NO_NODE
+ *
+ * Determine wq_node_nr_active to use for @wq on @node. Returns:
+ *
+ * - %NULL for per-cpu workqueues as they don't need to use shared nr_active.
+ *
+ * - node_nr_active[nr_node_ids] if @node is %NUMA_NO_NODE.
+ *
+ * - Otherwise, node_nr_active[@node].
+ */
+static struct wq_node_nr_active *wq_node_nr_active(struct workqueue_struct *wq,
+						   int node)
+{
+	if (!(wq->flags & WQ_UNBOUND))
+		return NULL;
+
+	if (node == NUMA_NO_NODE)
+		node = nr_node_ids;
+
+	return wq->node_nr_active[node];
+}
+
 /**
  * get_pwq - get an extra reference on the specified pool_workqueue
  * @pwq: pool_workqueue to get
@@ -1476,12 +1512,17 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
 			      struct work_struct *work)
 {
 	struct worker_pool *pool = pwq->pool;
+	struct wq_node_nr_active *nna;
 
 	lockdep_assert_held(&pool->lock);
 
 	if (!(*work_data_bits(work) & WORK_STRUCT_INACTIVE))
 		return false;
 
+	nna = wq_node_nr_active(pwq->wq, pool->node);
+	if (nna)
+		atomic_inc(&nna->count);
+
 	pwq->nr_active++;
 	__pwq_activate_work(pwq, work);
 	return true;
@@ -1498,12 +1539,21 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
 {
 	struct workqueue_struct *wq = pwq->wq;
 	struct worker_pool *pool = pwq->pool;
-	bool obtained;
+	struct wq_node_nr_active *nna = wq_node_nr_active(wq, pool->node);
+	bool obtained = false;
 
 	lockdep_assert_held(&pool->lock);
 
-	obtained = pwq->nr_active < wq->max_active;
+	if (!nna) {
+		/* per-cpu workqueue, pwq->nr_active is sufficient */
+		obtained = pwq->nr_active < wq->max_active;
+		goto out;
+	}
+
+	atomic_inc(&nna->count);
+	obtained = true;
 
+out:
 	if (obtained)
 		pwq->nr_active++;
 	return obtained;
@@ -1542,10 +1592,26 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
 static void pwq_dec_nr_active(struct pool_workqueue *pwq)
 {
 	struct worker_pool *pool = pwq->pool;
+	struct wq_node_nr_active *nna = wq_node_nr_active(pwq->wq, pool->node);
 
 	lockdep_assert_held(&pool->lock);
 
+	/*
+	 * @pwq->nr_active should be decremented for both percpu and unbound
+	 * workqueues.
+	 */
 	pwq->nr_active--;
+
+	/*
+	 * For a percpu workqueue, it's simple. Just need to kick the first
+	 * inactive work item on @pwq itself.
+	 */
+	if (!nna) {
+		pwq_activate_first_inactive(pwq);
+		return;
+	}
+
+	atomic_dec(&nna->count);
 	pwq_activate_first_inactive(pwq);
 }
 
@@ -4004,12 +4070,64 @@ static void wq_free_lockdep(struct workqueue_struct *wq)
 }
 #endif
 
+static void free_node_nr_active(struct wq_node_nr_active **ptr_ar)
+{
+	int i;
+
+	if (!ptr_ar)
+		return;
+	for (i = 0; i < nr_node_ids + 1; i++)
+		kfree(ptr_ar[i]);
+	kfree(ptr_ar);
+}
+
+static void init_node_nr_active(struct wq_node_nr_active *nna)
+{
+	atomic_set(&nna->count, 0);
+}
+
+/*
+ * Each node's nr_active counter will be accessed mostly from its own node and
+ * should be allocated in the node.
+ */
+static struct wq_node_nr_active **alloc_node_nr_active(void)
+{
+	struct wq_node_nr_active **nna_ar, *nna;
+	int node;
+
+	nna_ar = kcalloc(nr_node_ids + 1, sizeof(*nna_ar), GFP_KERNEL);
+	if (!nna_ar)
+		return NULL;
+
+	for_each_node(node) {
+		nna = kzalloc_node(sizeof(*nna), GFP_KERNEL, node);
+		if (!nna)
+			goto err_free;
+		init_node_nr_active(nna);
+		nna_ar[node] = nna;
+	}
+
+	/* [nr_node_ids] is used as the fallback */
+	nna = kzalloc_node(sizeof(*nna), GFP_KERNEL, NUMA_NO_NODE);
+	if (!nna)
+		goto err_free;
+	init_node_nr_active(nna);
+	nna_ar[nr_node_ids] = nna;
+
+	return nna_ar;
+
+err_free:
+	free_node_nr_active(nna_ar);
+	return NULL;
+}
+
 static void rcu_free_wq(struct rcu_head *rcu)
 {
 	struct workqueue_struct *wq =
 		container_of(rcu, struct workqueue_struct, rcu);
 
 	wq_free_lockdep(wq);
+	free_node_nr_active(wq->node_nr_active);
 	free_percpu(wq->cpu_pwq);
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
@@ -4800,8 +4918,14 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	wq_init_lockdep(wq);
 	INIT_LIST_HEAD(&wq->list);
 
+	if (flags & WQ_UNBOUND) {
+		wq->node_nr_active = alloc_node_nr_active();
+		if (!wq->node_nr_active)
+			goto err_unreg_lockdep;
+	}
+
 	if (alloc_and_link_pwqs(wq) < 0)
-		goto err_unreg_lockdep;
+		goto err_free_node_nr_active;
 
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
@@ -4826,6 +4950,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
+err_free_node_nr_active:
+	free_node_nr_active(wq->node_nr_active);
 err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
-- 
2.43.0


