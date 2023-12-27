Return-Path: <linux-kernel+bounces-12066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2048C81EF94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49531B21376
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F2E47A4E;
	Wed, 27 Dec 2023 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssqk1lF/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34F47777
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d98f6e8de1so1241294b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688608; x=1704293408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StLDtPNe1T869+urW8aS/ebeNeq1NbYI1cn0RgdFPCE=;
        b=Ssqk1lF/16qoiO+qRT2oRHmn6TdXNs0jB0PBOGGticxkHdOWWcNCOIIvTK1AuDJmnY
         Vdnfc+Hg03BfCey6ODBtG0kxuVXjlnsS4t/OI1Oi7XU/fj0haFFDEFsfM2ZfY3dFvgnk
         qVRTWEWuPD+gu1hdWux5209mlUbd5XLMFmiJ69e7U7SZ0IYkV3M9NWFJR4pWWSTlN1sn
         FSuIMJ1fU5PEmqtREw02sz/kZFBVJ69K+wzyS62SMbZ6JGAnzShUlxhtmXroXdUz2wf0
         uSRCXARwo4icgM3JIR7u6MJVJqcOVaiaCxHpAkiKhttFgb/ktpdv64olkXmIpjDSIQb3
         abcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688608; x=1704293408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=StLDtPNe1T869+urW8aS/ebeNeq1NbYI1cn0RgdFPCE=;
        b=lWveV/LQffALVziaUkBXyLpxwUxNvO/BGUjpx/QSpMp564QW2vI6VhbWV3/G6eJ6z+
         5IkDF8gQ/blhERDITN4cJDJVUBRcLTmHb3N9QYrIoZJIvsEVXuR8Sw6QeUQ2jlX0GxIS
         yzN//8b9WU0WGKxcbL1Xsz3lkftkdo38oL9KlKup/mFs/20ZGnlmb0zlkuXEB3nLXvbI
         aWV+sRifcPOqRuPjuANbDlRq/OvzqtBuYUBBBmG7WpCqNYQpSug6X7zKvwW8GTYu5tVc
         l7ifdkoEokw3HJXhihci9exROEz/4eBMtFgTL0CxZ3SdGZCf4fzcqwPUX7dPNJ3fzdph
         RZ5g==
X-Gm-Message-State: AOJu0YyguvL9bVpn5j/DiUfu3LWuaCYbErMdjrthp9efZUjcxnXzqQ8v
	AlwDT92Fzhkwr8JRiujj0LE3tlZHB0s=
X-Google-Smtp-Source: AGHT+IHgr1p6PzXqZZTbMHVJqj/3u94YgJU5urmTIOrK4Fr1tJ7RrU8OUX1lUsUHQOBbLZvM1+8hqQ==
X-Received: by 2002:a05:6a20:38a5:b0:187:67b0:73e with SMTP id n37-20020a056a2038a500b0018767b0073emr3304953pzf.14.1703688607725;
        Wed, 27 Dec 2023 06:50:07 -0800 (PST)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902aa8e00b001bf52834696sm11989663plr.207.2023.12.27.06.50.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2023 06:50:06 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Naohiro.Aota@wdc.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH 6/7] workqueue: Implement system-wide max_active enforcement for unbound workqueues
Date: Wed, 27 Dec 2023 22:51:42 +0800
Message-Id: <20231227145143.2399-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20231227145143.2399-1-jiangshanlai@gmail.com>
References: <20231227145143.2399-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

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

However, cache layouts are more complex now and sharing a PWQ across
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

Instead of forcing max_active enforcement system-wide and PWQ-across, this
patch distributes max_active among pods based on a previous patch that
changes per-cpu PWQ to per-pod PWQ.

With per-pod PWQ, max_active is distributed into each PWQ based on the
proportion of online CPUs in a PWQ to the total system's online CPU count.

- Using per-pod PWQ max_active enforcement can avoid sharing a single counter
  across multiple worker_pools and avoid complicating locking mechanism.

- Workqueue used to be able to process a chain of interdependent work items
  which is as long as max_active. We can't do this anymore as max_active is
  distributed across the pods. Instead, a new parameter min_active is
  introduced which determines the minimum level of concurrency within a pod
  regardless of how max_active distribution comes out to be.

  It is set to the smaller of max_active and WQ_DFL_MIN_ACTIVE which is 8.
  This can lead to higher effective max_active than configured and also
  deadlocks if a workqueue was depending on being able to handle chains of
  interdependent work items that are longer than 8. If either case happens,
  we'll need to add an interface to adjust min_active and users are required
  to adjust affinity manually.

higher effective max_active can happens when:
- uninstalled PWQs.
  They will be gone when they finished all their pending works.
- default PWQ.
  It is normally dormant unless it is the solo active PWQ.
- div round up
  It can cause the effective max_active more than configured by nr_pods-1 at most.
- clamp up to min_active
  It can cause the effective max_active at least to be min_active*nr_pods.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Naohiro Aota <Naohiro.Aota@wdc.com>
Link: http://lkml.kernel.org/r/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3
Fixes: 636b927eba5b ("workqueue: Make unbound workqueues to use per-cpu pool_workqueues")
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 include/linux/workqueue.h | 34 +++++++++++++++++++++++++++++++---
 kernel/workqueue.c        | 28 ++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 24b1e5070f4d..4ba2554f71a2 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -405,6 +405,13 @@ enum {
 	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
 	WQ_UNBOUND_MAX_ACTIVE	= WQ_MAX_ACTIVE,
 	WQ_DFL_ACTIVE		= WQ_MAX_ACTIVE / 2,
+
+	/*
+	 * Per-PWQ default cap on min_active. Unless explicitly set, min_active
+	 * is set to min(max_active, WQ_DFL_MIN_ACTIVE). For more details, see
+	 * workqueue_struct->min_active definition.
+	 */
+	WQ_DFL_MIN_ACTIVE	= 8,
 };
 
 /*
@@ -447,11 +454,32 @@ extern struct workqueue_struct *system_freezable_power_efficient_wq;
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
+ * PWQs can be expensive, @max_active is distributed to each PWQ according
+ * to the proportion of the number of online CPUs and enforced independently.
+ *
+ * Depending on online CPU distribution, a PWQ may end up with assigned
+ * max_active which is significantly lower than @max_active, which can lead to
+ * deadlocks if the concurrency limit is lower than the maximum number
+ * of interdependent work items for the workqueue.
+ *
+ * To guarantee forward progress regardless of online CPU distribution, the
+ * concurrency limit on every PWQ is guaranteed to be equal to or greater than
+ * min_active which is set to min(@max_active, %WQ_DFL_MIN_ACTIVE). This means
+ * that the sum of per-PWQ max_active's may be larger than @max_active.
+ *
+ * For detailed information on %WQ_* flags, please refer to
  * Documentation/core-api/workqueue.rst.
  *
  * RETURNS:
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d1c671597289..382c53f89cb4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -298,7 +298,8 @@ struct workqueue_struct {
 	struct worker		*rescuer;	/* MD: rescue worker */
 
 	int			nr_drainers;	/* WQ: drain in progress */
-	int			saved_max_active; /* WQ: saved pwq max_active */
+	int			saved_max_active; /* WQ: saved max_active */
+	int			min_active;	/* WQ: pwq min_active */
 
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
 	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
@@ -4140,10 +4141,15 @@ static void pwq_release_workfn(struct kthread_work *work)
  * pwq_calculate_max_active - Determine max_active to use
  * @pwq: pool_workqueue of interest
  *
- * Determine the max_active @pwq should use.
+ * Determine the max_active @pwq should use based on the proportion of
+ * online CPUs in the @pwq to the total system's online CPU count if
+ * @pwq->wq is unbound.
  */
 static int pwq_calculate_max_active(struct pool_workqueue *pwq)
 {
+	int pwq_nr_online_cpus;
+	int max_active;
+
 	/*
 	 * During [un]freezing, the caller is responsible for ensuring
 	 * that pwq_adjust_max_active() is called at least once after
@@ -4152,7 +4158,18 @@ static int pwq_calculate_max_active(struct pool_workqueue *pwq)
 	if ((pwq->wq->flags & WQ_FREEZABLE) && workqueue_freezing)
 		return 0;
 
-	return pwq->wq->saved_max_active;
+	if (!(pwq->wq->flags & WQ_UNBOUND))
+		return pwq->wq->saved_max_active;
+
+	pwq_nr_online_cpus = cpumask_weight_and(pwq->pool->attrs->__pod_cpumask, cpu_online_mask);
+	max_active = DIV_ROUND_UP(pwq->wq->saved_max_active * pwq_nr_online_cpus, num_online_cpus());
+
+	/*
+	 * To guarantee forward progress regardless of online CPU distribution,
+	 * the concurrency limit on every pwq is guaranteed to be equal to or
+	 * greater than wq->min_active.
+	 */
+	return clamp(max_active, pwq->wq->min_active, pwq->wq->saved_max_active);
 }
 
 /**
@@ -4745,6 +4762,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	/* init wq */
 	wq->flags = flags;
 	wq->saved_max_active = max_active;
+	wq->min_active = min(max_active, WQ_DFL_MIN_ACTIVE);
 	mutex_init(&wq->mutex);
 	atomic_set(&wq->nr_pwqs_to_flush, 0);
 	INIT_LIST_HEAD(&wq->pwqs);
@@ -4898,7 +4916,8 @@ EXPORT_SYMBOL_GPL(destroy_workqueue);
  * @wq: target workqueue
  * @max_active: new max_active value.
  *
- * Set max_active of @wq to @max_active.
+ * Set max_active of @wq to @max_active. See the alloc_workqueue() function
+ * comment.
  *
  * CONTEXT:
  * Don't call from IRQ context.
@@ -4917,6 +4936,7 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 
 	wq->flags &= ~__WQ_ORDERED;
 	wq->saved_max_active = max_active;
+	wq->min_active = min(wq->min_active, max_active);
 
 	for_each_pwq(pwq, wq)
 		pwq_adjust_max_active(pwq);
-- 
2.19.1.6.gb485710b


