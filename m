Return-Path: <linux-kernel+bounces-25137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3477982C85A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6511C214C4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618CD15EA6;
	Sat, 13 Jan 2024 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv+QOBof"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7F107A8
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d4a980fdedso63037825ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105768; x=1705710568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MAUWYR37XI3Wftfiw189yoBRG5IjIAuaL92kbTlRss=;
        b=Nv+QOBofIWa4y88S3lfss4tc2pcVNWVDbACKWSZr9TyIUQn2VUsnJDU0+OhNxF4k4N
         okyrYFKyBfnDP/aQssDtcrsLUNybbg1PfkNjWOI5WmhIllMZkhPfp+0+3YJX6FxpZEaO
         wv/TCwt15XSqLY+LcpirdJWINdoFvKEje/NXCXqhL3e4woNVjt90SymggsQkszOaPjhi
         8AvA9MB/y9B2MSnUivqqIt4fm0Q1J9TaGmwZU9KJWHN9njl9JQ1G2bynQHGkCr3/V+9F
         ThikfSOwBoEovUdzNp4iPdGJH2icAclw/D9hU5W8WJIME7LM7NQ+ZwIuw/bOgOLHJnjU
         ARaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105768; x=1705710568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MAUWYR37XI3Wftfiw189yoBRG5IjIAuaL92kbTlRss=;
        b=i+MWq389JBCLv6iV3D9qn7/QiLvYggfAm4AyTsnCk1zJzo8h/NuD2/W/L86Av8Ujsj
         iavkelKDwOBvqjap6zA01cwpLMMHljxCw5BtmLwJJrC6UKstyxKhBxoI4pkltOws4BG9
         so9TP1eRzXhyPZ1RAof+W5O1ecdVDwWh96QJu1GhlqyXa3p20N4Kty/1n9p0tWbnB52E
         8fKJ2Ktfp4Rlchv/Wp8e3zW0JqC2zpcFz0wV1ZhijeF9FDC0v0PKaYTZ4kfBNFimJcV2
         ShzQ+olYj5RZLww7vOH61DByIvznzmTCujn8XgluLJbDmUaWkN2l1/cq1y0X1uGtJJpZ
         EH6Q==
X-Gm-Message-State: AOJu0Yz7qQmeEA1+8HNbhMySbDMsS3lR/TNI1WlWr1FKhIwoS/1wgHZU
	m6kVTgwy9NadMQo9ujUSLDs=
X-Google-Smtp-Source: AGHT+IEqBUiaa5u/cgs9r3EkdedxLyYB8zbqHvLPYzbOukTUF1vyB14PDkj9LpG6aubORP3Z9CaO4g==
X-Received: by 2002:a17:902:6849:b0:1d4:9c06:17ef with SMTP id f9-20020a170902684900b001d49c0617efmr1727575pln.67.1705105768370;
        Fri, 12 Jan 2024 16:29:28 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001d3c0074f33sm3757355plg.170.2024.01.12.16.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:29:28 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 8/9] workqueue: Introduce struct wq_node_nr_active
Date: Fri, 12 Jan 2024 14:28:52 -1000
Message-ID: <20240113002911.406791-9-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113002911.406791-1-tj@kernel.org>
References: <20240113002911.406791-1-tj@kernel.org>
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

v2: - wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

    - Lai pointed out that pwq_tryinc_nr_active() incorrectly dropped
      pwq->max_active check. Restored. As the next patch replaces the
      max_active enforcement mechanism, this doesn't change the end result.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 125 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 522ef63088de..71ac3a3633ac 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -281,6 +281,16 @@ struct wq_flusher {
 
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
@@ -327,6 +337,7 @@ struct workqueue_struct {
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
 	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
+	struct wq_node_nr_active **node_nr_active; /* I: per-node nr_active */
 };
 
 static struct kmem_cache *pwq_cache;
@@ -1407,6 +1418,31 @@ work_func_t wq_worker_last_func(struct task_struct *task)
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
@@ -1485,12 +1521,17 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
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
@@ -1507,14 +1548,18 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
 {
 	struct workqueue_struct *wq = pwq->wq;
 	struct worker_pool *pool = pwq->pool;
+	struct wq_node_nr_active *nna = wq_node_nr_active(wq, pool->node);
 	bool obtained;
 
 	lockdep_assert_held(&pool->lock);
 
 	obtained = pwq->nr_active < READ_ONCE(wq->max_active);
 
-	if (obtained)
+	if (obtained) {
 		pwq->nr_active++;
+		if (nna)
+			atomic_inc(&nna->count);
+	}
 	return obtained;
 }
 
@@ -1551,10 +1596,26 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
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
 
@@ -4018,12 +4079,64 @@ static void wq_free_lockdep(struct workqueue_struct *wq)
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
@@ -4807,8 +4920,14 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
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
@@ -4833,6 +4952,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
+err_free_node_nr_active:
+	free_node_nr_active(wq->node_nr_active);
 err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
-- 
2.43.0


