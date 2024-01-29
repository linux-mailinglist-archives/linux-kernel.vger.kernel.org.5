Return-Path: <linux-kernel+bounces-43293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2A28411D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BE1287F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923FD4CB54;
	Mon, 29 Jan 2024 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/b+eVxw"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405B3F9E3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552053; cv=none; b=C2wut2OP0nvV0423XtqO8E/FwJmRI6oS7r0MT1SZXlMLvCkiKcccuBBi8qG9k0542FGxHBjZ3r/7Yali9pD/nx2mEJ0Xi9iMBKbpWSHUf+2h87P6yuANlf/stk3aGHywT72NJ8qZNvNWCPO7QiZr8nk0SVezUAhGrkalwiKhWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552053; c=relaxed/simple;
	bh=HfPH3ezzyKIyWURp5pvT29jOAnHgxZyfpHgFkvQf6JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFmDqbS1cAuurXMpMNWC2pQnltSjFg1FqDgHWClh3wjILRLHoey1wNrPNETJThPWKCKrxrUY2aMDYXxV774YlAvZV1deFEwB0Meh3Fwq+JaIp0g7m6vadRvpOfbyqKRUAoKbCLigOFd+FpCv+9wPLxvIJw8DToZD81tgVOYa2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/b+eVxw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1538923a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706552051; x=1707156851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OuQPVye+5UE3bVsg3g3UyK/12jVYAiO4vegqKPk0ckY=;
        b=O/b+eVxwWFQkLrqO4B53XLoe3rBM4ncZ+WapIehz1MqBnjXBoCJPcGkU2EyMkeYjgf
         37FRC1YMd6LQIEmOCeWRUwZJLXDwAIMxsjPRWht3aQIx6FWD9edFpySoysmj7F5V54wA
         TgSwoRsmkcKZzpp91zv57WW2gXnLBEv4SjybOiEUbOWVku5l3MIhugyKF8o+3yaKXKKE
         m/pHftqPG3BKOCILeiWcD7xtMGEIrEEuZxOOrSDDaxZuA/WHlAUCXoX8Otz/4ThYnmyM
         ykiUntVzfo6t1FMrUaAlKV9fUp0l6pJH+Fl5t/B0qFGH41jZNbkWjEctvbXRiwrKVnak
         aE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706552051; x=1707156851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuQPVye+5UE3bVsg3g3UyK/12jVYAiO4vegqKPk0ckY=;
        b=P//nqQXYYJ4ysFhDuRC/eXgYXRTRDMrO0rKmybPZfTeQephi9bL4ycE3t6PFqLtJLR
         qRuAZsy0SMQPYD7poBQCb5uYcBrsb8QCD7T41Xw0UBpzcuO+30rrwAhmOHraX/mIxWlx
         m65m/RaZUfWQFbYST8ggzIXwLMmIqvjChFRcc/qJXyWMetFIH3RUcwVUDkht83bt072Z
         MoxXaYei/yAYi0yWJIbQ4lNtrPucWLBDEQhx2YYX0a2JpnnBJjMO1vkwS8wLu/RyXWF2
         Rs5XK1jOOokhKEwTGt+h/XWv1Xziq5Nbkoi76K7z2uUHEWlQdtcoO2Z93Z3hDCLX+GPC
         tQzw==
X-Gm-Message-State: AOJu0YzkkKjP37JRu3QGdkPqzRmuN7dXSY145YDDw+1tNMI8H/vHPk/6
	SMijc5kszQdfvpHJxRnKMNLGsyTIp9AXuadYJxK1P58+JaRb6kZK68js4JaH
X-Google-Smtp-Source: AGHT+IGc8R08whIe3hsxDKNTs9mncntduYtLGoAFTlloI9o4vzf1ddLfbIPgWINvdV65K3sBa19Ahg==
X-Received: by 2002:a05:6a20:6d91:b0:19c:7e49:495a with SMTP id gl17-20020a056a206d9100b0019c7e49495amr2434872pzb.57.1706552050956;
        Mon, 29 Jan 2024 10:14:10 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id r18-20020a170902c61200b001d8f0e4bc32sm1489028plr.144.2024.01.29.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:14:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Jan 2024 08:14:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: [PATCH v4 08/10] workqueue: Introduce struct wq_node_nr_active
Message-ID: <Zbfq8egWUfYgkOsa@slm.duckdns.org>
References: <20240125170628.2017784-1-tj@kernel.org>
 <20240125170628.2017784-9-tj@kernel.org>
 <CAJhGHyA=uO4P4skas0-DZCE+cS453V+PrJMOFj2G2DAc1tE0jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyA=uO4P4skas0-DZCE+cS453V+PrJMOFj2G2DAc1tE0jA@mail.gmail.com>

From 91ccc6e7233bb10a9c176aa4cc70d6f432a441a5 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 29 Jan 2024 08:11:24 -1000

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

v4: - Fixed out-of-bound access when freeing per-cpu workqueues.

v3: - Use flexible array for wq->node_nr_active as suggested by Lai.

v2: - wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

    - Lai pointed out that pwq_tryinc_nr_active() incorrectly dropped
      pwq->max_active check. Restored. As the next patch replaces the
      max_active enforcement mechanism, this doesn't change the end result.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 142 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 135 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b5aba0e5a699..8d465478adb9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -284,6 +284,16 @@ struct wq_flusher {
 
 struct wq_device;
 
+/*
+ * Unlike in a per-cpu workqueue where max_active limits its concurrency level
+ * on each CPU, in an unbound workqueue, max_active applies to the whole system.
+ * As sharing a single nr_active across multiple sockets can be very expensive,
+ * the counting and enforcement is per NUMA node.
+ */
+struct wq_node_nr_active {
+	atomic_t		nr;		/* per-node nr_active count */
+};
+
 /*
  * The externally visible workqueue.  It relays the issued work items to
  * the appropriate worker_pool through its pool_workqueues.
@@ -330,6 +340,7 @@ struct workqueue_struct {
 	/* hot fields used during command issue, aligned to cacheline */
 	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
 	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
+	struct wq_node_nr_active *node_nr_active[]; /* I: per-node nr_active */
 };
 
 static struct kmem_cache *pwq_cache;
@@ -1425,6 +1436,31 @@ work_func_t wq_worker_last_func(struct task_struct *task)
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
@@ -1506,12 +1542,17 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
 			      struct work_struct *work)
 {
 	struct worker_pool *pool = pwq->pool;
+	struct wq_node_nr_active *nna;
 
 	lockdep_assert_held(&pool->lock);
 
 	if (!(*work_data_bits(work) & WORK_STRUCT_INACTIVE))
 		return false;
 
+	nna = wq_node_nr_active(pwq->wq, pool->node);
+	if (nna)
+		atomic_inc(&nna->nr);
+
 	pwq->nr_active++;
 	__pwq_activate_work(pwq, work);
 	return true;
@@ -1528,14 +1569,18 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
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
+			atomic_inc(&nna->nr);
+	}
 	return obtained;
 }
 
@@ -1572,10 +1617,26 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
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
+	atomic_dec(&nna->nr);
 	pwq_activate_first_inactive(pwq);
 }
 
@@ -4039,11 +4100,63 @@ static void wq_free_lockdep(struct workqueue_struct *wq)
 }
 #endif
 
+static void free_node_nr_active(struct wq_node_nr_active **nna_ar)
+{
+	int node;
+
+	for_each_node(node) {
+		kfree(nna_ar[node]);
+		nna_ar[node] = NULL;
+	}
+
+	kfree(nna_ar[nr_node_ids]);
+	nna_ar[nr_node_ids] = NULL;
+}
+
+static void init_node_nr_active(struct wq_node_nr_active *nna)
+{
+	atomic_set(&nna->nr, 0);
+}
+
+/*
+ * Each node's nr_active counter will be accessed mostly from its own node and
+ * should be allocated in the node.
+ */
+static int alloc_node_nr_active(struct wq_node_nr_active **nna_ar)
+{
+	struct wq_node_nr_active *nna;
+	int node;
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
+	return 0;
+
+err_free:
+	free_node_nr_active(nna_ar);
+	return -ENOMEM;
+}
+
 static void rcu_free_wq(struct rcu_head *rcu)
 {
 	struct workqueue_struct *wq =
 		container_of(rcu, struct workqueue_struct, rcu);
 
+	if (wq->flags & WQ_UNBOUND)
+		free_node_nr_active(wq->node_nr_active);
+
 	wq_free_lockdep(wq);
 	free_percpu(wq->cpu_pwq);
 	free_workqueue_attrs(wq->unbound_attrs);
@@ -4785,7 +4898,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 {
 	va_list args;
 	struct workqueue_struct *wq;
-	int len;
+	size_t wq_size;
+	int name_len;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4801,7 +4915,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 		flags |= WQ_UNBOUND;
 
 	/* allocate wq and format name */
-	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
+	if (flags & WQ_UNBOUND)
+		wq_size = struct_size(wq, node_nr_active, nr_node_ids + 1);
+	else
+		wq_size = sizeof(*wq);
+
+	wq = kzalloc(wq_size, GFP_KERNEL);
 	if (!wq)
 		return NULL;
 
@@ -4812,11 +4931,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	}
 
 	va_start(args, max_active);
-	len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
+	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
 	va_end(args);
 
-	if (len >= WQ_NAME_LEN)
-		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n", wq->name);
+	if (name_len >= WQ_NAME_LEN)
+		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
+			     wq->name);
 
 	max_active = max_active ?: WQ_DFL_ACTIVE;
 	max_active = wq_clamp_max_active(max_active, flags, wq->name);
@@ -4835,8 +4955,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	wq_init_lockdep(wq);
 	INIT_LIST_HEAD(&wq->list);
 
+	if (flags & WQ_UNBOUND) {
+		if (alloc_node_nr_active(wq->node_nr_active) < 0)
+			goto err_unreg_lockdep;
+	}
+
 	if (alloc_and_link_pwqs(wq) < 0)
-		goto err_unreg_lockdep;
+		goto err_free_node_nr_active;
 
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
@@ -4861,6 +4986,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	return wq;
 
+err_free_node_nr_active:
+	if (wq->flags & WQ_UNBOUND)
+		free_node_nr_active(wq->node_nr_active);
 err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
-- 
2.43.0


