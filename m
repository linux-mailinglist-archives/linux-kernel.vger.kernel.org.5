Return-Path: <linux-kernel+bounces-6481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3939F819974
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60C2288858
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568A021379;
	Wed, 20 Dec 2023 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwIQZ5xX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB721356
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3cfb1568eso20304265ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057167; x=1703661967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCseRPzewW1o97/S4Qz0/c64KvHe1Vdk1cfpxPdjJkc=;
        b=iwIQZ5xXD8VwD3pdCVGf8iJtNQngnqQjL6TL5QnQodiJ2BxYAjwgQVE2DjMEAGBXFP
         h7fqFWq3VI2t2LCel/omdWxO5Mn4G9vbm9RPSoQkUFJtughe58q/C0fvy8CnPIIrMoSJ
         JGm578khOnyykPrR1n1hpK6Sf5qRsVq+QN9sWtZBs58NBDnmF1g2eLM7sAxCQSsFlZmE
         GcTNE7RaYWRA42bC/Ne+d1hcAdXMPFjxGjZfjERSfz6HeeGbiQ27VgmZ3AYdB3Hc8B0R
         F8kR1ZPgNaz0zNfLTJKYlhV1xjGE9k1kuHdfNI93epKU7yXmVA/INca8p3ntREpN1Yor
         7+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057167; x=1703661967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCseRPzewW1o97/S4Qz0/c64KvHe1Vdk1cfpxPdjJkc=;
        b=qaP5oh8TIc7f3ZwKNQuCP1v1+jSoIpNRdd+66lkqghBC56LWUWPUA92KdfjvD8a6bm
         XdlPXCjrBJliahulRLTU9/AeZuZKNZF5awmtezw6aEtvtVv6YDkyKQL/fqTiUxEA01KZ
         QU5JIwdtpLyR22V0DBz5WR9KZyzlkMKaNsBZmazGwvEsqa4eaRcWqw+vYd5augUzw+Wb
         BjOEH0xk93uKtrKUIJNtnPY/lxuw4OIKHabFRarjNcR7vliPh4jeFbJUc4QC+Xyrs+6W
         dIQHokvZnITg15N7wfu1e7UOi2mxNYdD8qP53VVg7qS6axdivGW94Q6SjAk4WAlpU282
         Rahw==
X-Gm-Message-State: AOJu0YxDuouV0E3GACwGDHgNhPFhjNEMfipYoEtuXxiYH5V/MszoztiK
	e7uFOvXoTNIuhE8GRx+x8CE=
X-Google-Smtp-Source: AGHT+IHtiFLm0r1Xj5jpfZ7Ugqyxz6I+GucNx34pRrJpZSk/3ZlS7P/2mmxI5IqwmSGyvnQ59kldEw==
X-Received: by 2002:a17:903:2cc:b0:1d3:488e:a4b7 with SMTP id s12-20020a17090302cc00b001d3488ea4b7mr18513987plk.128.1703057167155;
        Tue, 19 Dec 2023 23:26:07 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001d3563c87a6sm8127038plw.281.2023.12.19.23.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:26:06 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/10] workqueue: Reimplement ordered workqueue using shared nr_active
Date: Wed, 20 Dec 2023 16:24:41 +0900
Message-ID: <20231220072529.1036099-11-tj@kernel.org>
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

Because nr_active used to be tied to pwq, an ordered workqueue had to have a
single pwq to guarantee strict ordering. This led to several contortions to
avoid creating multiple pwqs.

Now that nr_active can be shared across multiple pwqs, we can simplify
ordered workqueue implementation. All that's necessary is ensuring that a
single wq_node_nr_active is shared across all pwqs, which is achieved by
making wq_node_nr_active() always return wq->node_nr_active[nr_node_ids] for
ordered workqueues.

The new implementation is simpler and allows ordered workqueues to share
locality aware worker_pools with other unbound workqueues which should
improve execution locality.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 44 ++++++--------------------------------------
 1 file changed, 6 insertions(+), 38 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0017e9094034..bae7ed9cd1b4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -441,9 +441,6 @@ static DEFINE_HASHTABLE(unbound_pool_hash, UNBOUND_POOL_HASH_ORDER);
 /* I: attributes used when instantiating standard unbound pools on demand */
 static struct workqueue_attrs *unbound_std_wq_attrs[NR_STD_WORKER_POOLS];
 
-/* I: attributes used when instantiating ordered pools on demand */
-static struct workqueue_attrs *ordered_wq_attrs[NR_STD_WORKER_POOLS];
-
 /*
  * I: kthread_worker to release pwq's. pwq release needs to be bounced to a
  * process context while holding a pool lock. Bounce to a dedicated kthread
@@ -1435,6 +1432,9 @@ work_func_t wq_worker_last_func(struct task_struct *task)
  *
  * - %NULL for per-cpu workqueues as they don't need to use shared nr_active.
  *
+ * - node_nr_active[nr_node_ids] if the associated workqueue is ordered so that
+ *   all pwq's are limited by the same nr_active.
+ *
  * - node_nr_active[nr_node_ids] if @node is %NUMA_NO_NODE.
  *
  * - Otherwise, node_nr_active[@node].
@@ -1445,7 +1445,7 @@ static struct wq_node_nr_active *wq_node_nr_active(struct workqueue_struct *wq,
 	if (!(wq->flags & WQ_UNBOUND))
 		return NULL;
 
-	if (node == NUMA_NO_NODE)
+	if ((wq->flags & __WQ_ORDERED) || node == NUMA_NO_NODE)
 		node = nr_node_ids;
 
 	return wq->node_nr_active[node];
@@ -4312,7 +4312,7 @@ static struct wq_node_nr_active **alloc_node_nr_active(void)
 		nna_ar[node] = nna;
 	}
 
-	/* [nr_node_ids] is used as the fallback */
+	/* [nr_node_ids] is used for ordered workqueues and as the fallback */
 	nna = kzalloc_node(sizeof(*nna), GFP_KERNEL, NUMA_NO_NODE);
 	if (!nna)
 		goto err_free;
@@ -4799,14 +4799,6 @@ static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
 	if (WARN_ON(!(wq->flags & WQ_UNBOUND)))
 		return -EINVAL;
 
-	/* creating multiple pwqs breaks ordering guarantee */
-	if (!list_empty(&wq->pwqs)) {
-		if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
-			return -EINVAL;
-
-		wq->flags &= ~__WQ_ORDERED;
-	}
-
 	ctx = apply_wqattrs_prepare(wq, attrs, wq_unbound_cpumask);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -4955,15 +4947,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	}
 
 	cpus_read_lock();
-	if (wq->flags & __WQ_ORDERED) {
-		ret = apply_workqueue_attrs(wq, ordered_wq_attrs[highpri]);
-		/* there should only be single pwq for ordering guarantee */
-		WARN(!ret && (wq->pwqs.next != &wq->dfl_pwq->pwqs_node ||
-			      wq->pwqs.prev != &wq->dfl_pwq->pwqs_node),
-		     "ordering guarantee broken for workqueue %s\n", wq->name);
-	} else {
-		ret = apply_workqueue_attrs(wq, unbound_std_wq_attrs[highpri]);
-	}
+	ret = apply_workqueue_attrs(wq, unbound_std_wq_attrs[highpri]);
 	cpus_read_unlock();
 
 	/* for unbound pwq, flush the pwq_release_worker ensures that the
@@ -6220,13 +6204,6 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 		if (!(wq->flags & WQ_UNBOUND))
 			continue;
 
-		/* creating multiple pwqs breaks ordering guarantee */
-		if (!list_empty(&wq->pwqs)) {
-			if (wq->flags & __WQ_ORDERED_EXPLICIT)
-				continue;
-			wq->flags &= ~__WQ_ORDERED;
-		}
-
 		ctx = apply_wqattrs_prepare(wq, wq->unbound_attrs, unbound_cpumask);
 		if (IS_ERR(ctx)) {
 			ret = PTR_ERR(ctx);
@@ -7023,15 +7000,6 @@ void __init workqueue_init_early(void)
 		BUG_ON(!(attrs = alloc_workqueue_attrs()));
 		attrs->nice = std_nice[i];
 		unbound_std_wq_attrs[i] = attrs;
-
-		/*
-		 * An ordered wq should have only one pwq as ordering is
-		 * guaranteed by max_active which is enforced by pwqs.
-		 */
-		BUG_ON(!(attrs = alloc_workqueue_attrs()));
-		attrs->nice = std_nice[i];
-		attrs->ordered = true;
-		ordered_wq_attrs[i] = attrs;
 	}
 
 	system_wq = alloc_workqueue("events", 0, 0);
-- 
2.43.0


