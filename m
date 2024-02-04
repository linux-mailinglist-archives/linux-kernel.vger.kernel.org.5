Return-Path: <linux-kernel+bounces-51914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860628490AB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADA61C20D8D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504D2C698;
	Sun,  4 Feb 2024 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xjj9NGnc"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E828E09;
	Sun,  4 Feb 2024 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707082192; cv=none; b=DMGEg0wG2GRRS16yQ5l3od4ibXBNQhzW/Vn9fQ2kSlNjDP+Wgv7zZbJy8iW8OwwYtYzcWvpfDuhl+iZVldoLb4IhI1kCmkAJuGk9WEWDb2KHhhUpgQdl224SX/6J8wrfslPBjaqFdlO72cazbotlQN8Fu9W4dhK3XOFUo//65Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707082192; c=relaxed/simple;
	bh=oF7fYGBxZjKG4Gu9VTPZTeldSl+s9MOzCjB+i/lh/7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMBIFcZLzhIz9xuGc9p7uXpIrtAWwTXdkTEmlY75Ssz/6q+HADXHoJ95GY8xeH/dOpgvgZ4Q7pd+OMl8kIKWpl7o+dVPb44A0VrEz6tyWpnM9jxPCWqhApKclsx36m35B5SZS9GFcV4UnZixVbGFy7eSzILR1RKOAm1ZpwrzQD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xjj9NGnc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d958e0d73dso19319145ad.1;
        Sun, 04 Feb 2024 13:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707082188; x=1707686988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPjOKadg9acUPNQZyI4WPdtiAgz5ZGLxS464UUBL3CM=;
        b=Xjj9NGncGzGDD6pwqGWFz6AfrGCo2jms/Ia/7bx7he5QDBB0Oclsk4I8a8MPJ6etP9
         eGtAbVPjMWrksyGh0J+6TnqCr/k+P0d/EorOf+9mYJtj0j4oEdmujKB1ocdMSLvMfzIu
         ubUKVgwjDQ6eBXArp4CMSOniU137jSv0w4oJLZl64anjwZQRYlVcJRqI2SjMhYDRoabD
         JbjlzZe8p3lsIshsDjZ16WU7sgagRkXV8VnlXgD8Mdd+zFSWh2PIkl73p96v2uR5dIsr
         jXsvtUVN4vfEvFQ7onMmCPh2KP5PJiUpLg0xawEt5Vcrk4tbA5ek1zC0khF08tzh7Q5n
         h5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707082188; x=1707686988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPjOKadg9acUPNQZyI4WPdtiAgz5ZGLxS464UUBL3CM=;
        b=dPw92nfYmLzlaggSubNFfflxhvF/YYZOQxDuTPonBsHQaXodfLdwbVa6P21HkBYB3z
         +pZd5pRZOtpsIVGyMqPlksru8cEKUJNiJtJ4bl/AEVZF6gbTumMeTyaMfRlDv3p1UuaN
         XlohiWREAix0V8hPLhlCzGtvAUNVYcCWqdAXL2xetHrCuxIa4BjEp2UW4elaEpJFT1GW
         7AyYz358zL+7av53/3GdCBxLrbKBl/VJgGtS/c9npC/apmga4NGkt8QA5vwgu7WLgG+r
         ldCdM8B9Uo3VI4l3sJNHur69NuIYa080ViiFXzAtNG6hPzy16hwMXltgIP6pNZwhc7Yw
         z1xg==
X-Gm-Message-State: AOJu0YyYSphYz4gnIsLQIdTkaykkZVEefJyIgfucN+8m6+fistrwAQXZ
	OLfr1V+1QyuklW+gf7k+wQ+zbULJhioiMhSiGsjZWL0FpUNlqfz5
X-Google-Smtp-Source: AGHT+IErbVgPtlh29QyKxh0eAedWkgqMvnRwAlekbEc9OSW1R/AgrChetKaqMU5J0kKurG9XjQMOkw==
X-Received: by 2002:a17:902:e547:b0:1d9:5563:431 with SMTP id n7-20020a170902e54700b001d955630431mr7311044plf.7.1707082187885;
        Sun, 04 Feb 2024 13:29:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWyx13juv0/vNs1EymcfMw69zey46AbgIF7hihpEB+omofc6vaOkgHB3PcBC5kJwSbWKMpSdY/IWK1Y+o/Q46bcsF1ZmyXGne4lP+ZesPvfNbp48NgXsGXuY1Vx/zYCkidCD7UyTq18Uq3Q44tMS8ctGGaNZ+eCkMC5X+0qVkyANkXsjWLeNqtNJqospkyNoztscBmX81/0aMY6tJWqZ+6sV1WWf5IkjJ3uwyit8R7mY3SRgXtn2FqDzpQr2CGl+wvEGlt8nUd4dNfsQuOUyhHN9e7s91j2Bc5PgjBAYF1Qg63AT0FdbWH7SyUlVCnpk9UBO5pc/09J4HrK2YiVj1mxv+5JZIOP8WUA1k9Iu39pv4/2DAfQKAKfbPlT0QO53Mh7AdQfofrromCNZn7coxsNkue7mONut+KkRQnUduFvogeltkmF
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ky15-20020a170902f98f00b001d9b092bcd9sm766251plb.148.2024.02.04.13.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 13:29:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 4 Feb 2024 11:29:46 -1000
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org, mpatocka@redhat.com
Cc: linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v3 3/8] workqueue: Implement BH workqueues to eventually
 replace tasklets
Message-ID: <ZcABypwUML6Osiec@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130091300.2968534-4-tj@kernel.org>

From 4cb1ef64609f9b0254184b2947824f4b46ccab22 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sun, 4 Feb 2024 11:28:06 -1000

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws such as
the execution code accessing the tasklet item after the execution is
complete which can lead to subtle use-after-free in certain usage scenarios
and less-developed flush and cancel mechanisms.

This patch implements BH workqueues which share the same semantics and
features of regular workqueues but execute their work items in the softirq
context. As there is always only one BH execution context per CPU, none of
the concurrency management mechanisms applies and a BH workqueue can be
thought of as a convenience wrapper around softirq.

Except for the inability to sleep while executing and lack of max_active
adjustments, BH workqueues and work items should behave the same as regular
workqueues and work items.

Currently, the execution is hooked to tasklet[_hi]. However, the goal is to
convert all tasklet users over to BH workqueues. Once the conversion is
complete, tasklet can be removed and BH workqueues can directly take over
the tasklet softirqs.

system_bh[_highpri]_wq are added. As queue-wide flushing doesn't exist in
tasklet, all existing tasklet users should be able to use the system BH
workqueues without creating their own workqueues.

v3: - Add missing interrupt.h include.

v2: - Instead of using tasklets, hook directly into its softirq action
      functions - tasklet[_hi]_action(). This is slightly cheaper and closer
      to the eventual code structure we want to arrive at. Suggested by Lai.

    - Lai also pointed out several places which need NULL worker->task
      handling or can use clarification. Updated.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: http://lkml.kernel.org/r/CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com
Tested-by: Allen Pais <allen.lkml@gmail.com>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
---
 Documentation/core-api/workqueue.rst |  29 ++-
 include/linux/workqueue.h            |  11 +
 kernel/softirq.c                     |   3 +
 kernel/workqueue.c                   | 291 ++++++++++++++++++++++-----
 tools/workqueue/wq_dump.py           |  11 +-
 5 files changed, 285 insertions(+), 60 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 33c4539155d9..2d6af6c4665c 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -77,10 +77,12 @@ wants a function to be executed asynchronously it has to set up a work
 item pointing to that function and queue that work item on a
 workqueue.
 
-Special purpose threads, called worker threads, execute the functions
-off of the queue, one after the other.  If no work is queued, the
-worker threads become idle.  These worker threads are managed in so
-called worker-pools.
+A work item can be executed in either a thread or the BH (softirq) context.
+
+For threaded workqueues, special purpose threads, called [k]workers, execute
+the functions off of the queue, one after the other. If no work is queued,
+the worker threads become idle. These worker threads are managed in
+worker-pools.
 
 The cmwq design differentiates between the user-facing workqueues that
 subsystems and drivers queue work items on and the backend mechanism
@@ -91,6 +93,12 @@ for high priority ones, for each possible CPU and some extra
 worker-pools to serve work items queued on unbound workqueues - the
 number of these backing pools is dynamic.
 
+BH workqueues use the same framework. However, as there can only be one
+concurrent execution context, there's no need to worry about concurrency.
+Each per-CPU BH worker pool contains only one pseudo worker which represents
+the BH execution context. A BH workqueue can be considered a convenience
+interface to softirq.
+
 Subsystems and drivers can create and queue work items through special
 workqueue API functions as they see fit. They can influence some
 aspects of the way the work items are executed by setting flags on the
@@ -106,7 +114,7 @@ unless specifically overridden, a work item of a bound workqueue will
 be queued on the worklist of either normal or highpri worker-pool that
 is associated to the CPU the issuer is running on.
 
-For any worker pool implementation, managing the concurrency level
+For any thread pool implementation, managing the concurrency level
 (how many execution contexts are active) is an important issue.  cmwq
 tries to keep the concurrency at a minimal but sufficient level.
 Minimal to save resources and sufficient in that the system is used at
@@ -164,6 +172,17 @@ resources, scheduled and executed.
 ``flags``
 ---------
 
+``WQ_BH``
+  BH workqueues can be considered a convenience interface to softirq. BH
+  workqueues are always per-CPU and all BH work items are executed in the
+  queueing CPU's softirq context in the queueing order.
+
+  All BH workqueues must have 0 ``max_active`` and ``WQ_HIGHPRI`` is the
+  only allowed additional flag.
+
+  BH work items cannot sleep. All other features such as delayed queueing,
+  flushing and canceling are supported.
+
 ``WQ_UNBOUND``
   Work items queued to an unbound wq are served by the special
   worker-pools which host workers which are not bound to any
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 232baea90a1d..283d7891b4c4 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -353,6 +353,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
  * Documentation/core-api/workqueue.rst.
  */
 enum wq_flags {
+	WQ_BH			= 1 << 0, /* execute in bottom half (softirq) context */
 	WQ_UNBOUND		= 1 << 1, /* not bound to any cpu */
 	WQ_FREEZABLE		= 1 << 2, /* freeze during suspend */
 	WQ_MEM_RECLAIM		= 1 << 3, /* may be used for memory reclaim */
@@ -392,6 +393,9 @@ enum wq_flags {
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
 	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
+
+	/* BH wq only allows the following flags */
+	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI,
 };
 
 enum wq_consts {
@@ -434,6 +438,9 @@ enum wq_consts {
  * they are same as their non-power-efficient counterparts - e.g.
  * system_power_efficient_wq is identical to system_wq if
  * 'wq_power_efficient' is disabled.  See WQ_POWER_EFFICIENT for more info.
+ *
+ * system_bh[_highpri]_wq are convenience interface to softirq. BH work items
+ * are executed in the queueing CPU's BH context in the queueing order.
  */
 extern struct workqueue_struct *system_wq;
 extern struct workqueue_struct *system_highpri_wq;
@@ -442,6 +449,10 @@ extern struct workqueue_struct *system_unbound_wq;
 extern struct workqueue_struct *system_freezable_wq;
 extern struct workqueue_struct *system_power_efficient_wq;
 extern struct workqueue_struct *system_freezable_power_efficient_wq;
+extern struct workqueue_struct *system_bh_wq;
+extern struct workqueue_struct *system_bh_highpri_wq;
+
+void workqueue_softirq_action(bool highpri);
 
 /**
  * alloc_workqueue - allocate a workqueue
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 210cf5f8d92c..547d282548a8 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -27,6 +27,7 @@
 #include <linux/tick.h>
 #include <linux/irq.h>
 #include <linux/wait_bit.h>
+#include <linux/workqueue.h>
 
 #include <asm/softirq_stack.h>
 
@@ -802,11 +803,13 @@ static void tasklet_action_common(struct softirq_action *a,
 
 static __latent_entropy void tasklet_action(struct softirq_action *a)
 {
+	workqueue_softirq_action(false);
 	tasklet_action_common(a, this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
 }
 
 static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
 {
+	workqueue_softirq_action(true);
 	tasklet_action_common(a, this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
 }
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 767971a29c7a..78b4b992e1a3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -29,6 +29,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/signal.h>
 #include <linux/completion.h>
 #include <linux/workqueue.h>
@@ -72,8 +73,12 @@ enum worker_pool_flags {
 	 * Note that DISASSOCIATED should be flipped only while holding
 	 * wq_pool_attach_mutex to avoid changing binding state while
 	 * worker_attach_to_pool() is in progress.
+	 *
+	 * As there can only be one concurrent BH execution context per CPU, a
+	 * BH pool is per-CPU and always DISASSOCIATED.
 	 */
-	POOL_MANAGER_ACTIVE	= 1 << 0,	/* being managed */
+	POOL_BH			= 1 << 0,	/* is a BH pool */
+	POOL_MANAGER_ACTIVE	= 1 << 1,	/* being managed */
 	POOL_DISASSOCIATED	= 1 << 2,	/* cpu can't serve workers */
 };
 
@@ -115,6 +120,14 @@ enum wq_internal_consts {
 	WQ_NAME_LEN		= 32,
 };
 
+/*
+ * We don't want to trap softirq for too long. See MAX_SOFTIRQ_TIME and
+ * MAX_SOFTIRQ_RESTART in kernel/softirq.c. These are macros because
+ * msecs_to_jiffies() can't be an initializer.
+ */
+#define BH_WORKER_JIFFIES	msecs_to_jiffies(2)
+#define BH_WORKER_RESTARTS	10
+
 /*
  * Structure fields follow one of the following exclusion rules.
  *
@@ -443,8 +456,13 @@ static bool wq_debug_force_rr_cpu = false;
 #endif
 module_param_named(debug_force_rr_cpu, wq_debug_force_rr_cpu, bool, 0644);
 
+/* the BH worker pools */
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
+				     bh_worker_pools);
+
 /* the per-cpu worker pools */
-static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS], cpu_worker_pools);
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct worker_pool [NR_STD_WORKER_POOLS],
+				     cpu_worker_pools);
 
 static DEFINE_IDR(worker_pool_idr);	/* PR: idr of all pools */
 
@@ -478,6 +496,10 @@ struct workqueue_struct *system_power_efficient_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_power_efficient_wq);
 struct workqueue_struct *system_freezable_power_efficient_wq __ro_after_init;
 EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
+struct workqueue_struct *system_bh_wq;
+EXPORT_SYMBOL_GPL(system_bh_wq);
+struct workqueue_struct *system_bh_highpri_wq;
+EXPORT_SYMBOL_GPL(system_bh_highpri_wq);
 
 static int worker_thread(void *__worker);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
@@ -498,6 +520,11 @@ static void show_one_worker_pool(struct worker_pool *pool);
 			 !lockdep_is_held(&wq_pool_mutex),		\
 			 "RCU, wq->mutex or wq_pool_mutex should be held")
 
+#define for_each_bh_worker_pool(pool, cpu)				\
+	for ((pool) = &per_cpu(bh_worker_pools, cpu)[0];		\
+	     (pool) < &per_cpu(bh_worker_pools, cpu)[NR_STD_WORKER_POOLS]; \
+	     (pool)++)
+
 #define for_each_cpu_worker_pool(pool, cpu)				\
 	for ((pool) = &per_cpu(cpu_worker_pools, cpu)[0];		\
 	     (pool) < &per_cpu(cpu_worker_pools, cpu)[NR_STD_WORKER_POOLS]; \
@@ -1186,6 +1213,14 @@ static bool kick_pool(struct worker_pool *pool)
 	if (!need_more_worker(pool) || !worker)
 		return false;
 
+	if (pool->flags & POOL_BH) {
+		if (pool->attrs->nice == HIGHPRI_NICE_LEVEL)
+			raise_softirq_irqoff(HI_SOFTIRQ);
+		else
+			raise_softirq_irqoff(TASKLET_SOFTIRQ);
+		return true;
+	}
+
 	p = worker->task;
 
 #ifdef CONFIG_SMP
@@ -1668,7 +1703,7 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq, bool fill)
 	lockdep_assert_held(&pool->lock);
 
 	if (!nna) {
-		/* per-cpu workqueue, pwq->nr_active is sufficient */
+		/* BH or per-cpu workqueue, pwq->nr_active is sufficient */
 		obtained = pwq->nr_active < READ_ONCE(wq->max_active);
 		goto out;
 	}
@@ -2523,19 +2558,21 @@ static cpumask_t *pool_allowed_cpus(struct worker_pool *pool)
  * cpu-[un]hotplugs.
  */
 static void worker_attach_to_pool(struct worker *worker,
-				   struct worker_pool *pool)
+				  struct worker_pool *pool)
 {
 	mutex_lock(&wq_pool_attach_mutex);
 
 	/*
-	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
-	 * stable across this function.  See the comments above the flag
-	 * definition for details.
+	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains stable
+	 * across this function. See the comments above the flag definition for
+	 * details. BH workers are, while per-CPU, always DISASSOCIATED.
 	 */
-	if (pool->flags & POOL_DISASSOCIATED)
+	if (pool->flags & POOL_DISASSOCIATED) {
 		worker->flags |= WORKER_UNBOUND;
-	else
+	} else {
+		WARN_ON_ONCE(pool->flags & POOL_BH);
 		kthread_set_per_cpu(worker->task, pool->cpu);
+	}
 
 	if (worker->rescue_wq)
 		set_cpus_allowed_ptr(worker->task, pool_allowed_cpus(pool));
@@ -2559,6 +2596,9 @@ static void worker_detach_from_pool(struct worker *worker)
 	struct worker_pool *pool = worker->pool;
 	struct completion *detach_completion = NULL;
 
+	/* there is one permanent BH worker per CPU which should never detach */
+	WARN_ON_ONCE(pool->flags & POOL_BH);
+
 	mutex_lock(&wq_pool_attach_mutex);
 
 	kthread_set_per_cpu(worker->task, -1);
@@ -2610,27 +2650,29 @@ static struct worker *create_worker(struct worker_pool *pool)
 
 	worker->id = id;
 
-	if (pool->cpu >= 0)
-		snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
-			 pool->attrs->nice < 0  ? "H" : "");
-	else
-		snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
-
-	worker->task = kthread_create_on_node(worker_thread, worker, pool->node,
-					      "kworker/%s", id_buf);
-	if (IS_ERR(worker->task)) {
-		if (PTR_ERR(worker->task) == -EINTR) {
-			pr_err("workqueue: Interrupted when creating a worker thread \"kworker/%s\"\n",
-			       id_buf);
-		} else {
-			pr_err_once("workqueue: Failed to create a worker thread: %pe",
-				    worker->task);
+	if (!(pool->flags & POOL_BH)) {
+		if (pool->cpu >= 0)
+			snprintf(id_buf, sizeof(id_buf), "%d:%d%s", pool->cpu, id,
+				 pool->attrs->nice < 0  ? "H" : "");
+		else
+			snprintf(id_buf, sizeof(id_buf), "u%d:%d", pool->id, id);
+
+		worker->task = kthread_create_on_node(worker_thread, worker,
+					pool->node, "kworker/%s", id_buf);
+		if (IS_ERR(worker->task)) {
+			if (PTR_ERR(worker->task) == -EINTR) {
+				pr_err("workqueue: Interrupted when creating a worker thread \"kworker/%s\"\n",
+				       id_buf);
+			} else {
+				pr_err_once("workqueue: Failed to create a worker thread: %pe",
+					    worker->task);
+			}
+			goto fail;
 		}
-		goto fail;
-	}
 
-	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
+		set_user_nice(worker->task, pool->attrs->nice);
+		kthread_bind_mask(worker->task, pool_allowed_cpus(pool));
+	}
 
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
@@ -2646,7 +2688,8 @@ static struct worker *create_worker(struct worker_pool *pool)
 	 * check if not woken up soon. As kick_pool() is noop if @pool is empty,
 	 * wake it up explicitly.
 	 */
-	wake_up_process(worker->task);
+	if (worker->task)
+		wake_up_process(worker->task);
 
 	raw_spin_unlock_irq(&pool->lock);
 
@@ -2988,7 +3031,8 @@ __acquires(&pool->lock)
 	worker->current_work = work;
 	worker->current_func = work->func;
 	worker->current_pwq = pwq;
-	worker->current_at = worker->task->se.sum_exec_runtime;
+	if (worker->task)
+		worker->current_at = worker->task->se.sum_exec_runtime;
 	work_data = *work_data_bits(work);
 	worker->current_color = get_work_color(work_data);
 
@@ -3086,7 +3130,8 @@ __acquires(&pool->lock)
 	 * stop_machine. At the same time, report a quiescent RCU state so
 	 * the same condition doesn't freeze RCU.
 	 */
-	cond_resched();
+	if (worker->task)
+		cond_resched();
 
 	raw_spin_lock_irq(&pool->lock);
 
@@ -3369,6 +3414,61 @@ static int rescuer_thread(void *__rescuer)
 	goto repeat;
 }
 
+static void bh_worker(struct worker *worker)
+{
+	struct worker_pool *pool = worker->pool;
+	int nr_restarts = BH_WORKER_RESTARTS;
+	unsigned long end = jiffies + BH_WORKER_JIFFIES;
+
+	raw_spin_lock_irq(&pool->lock);
+	worker_leave_idle(worker);
+
+	/*
+	 * This function follows the structure of worker_thread(). See there for
+	 * explanations on each step.
+	 */
+	if (!need_more_worker(pool))
+		goto done;
+
+	WARN_ON_ONCE(!list_empty(&worker->scheduled));
+	worker_clr_flags(worker, WORKER_PREP | WORKER_REBOUND);
+
+	do {
+		struct work_struct *work =
+			list_first_entry(&pool->worklist,
+					 struct work_struct, entry);
+
+		if (assign_work(work, worker, NULL))
+			process_scheduled_works(worker);
+	} while (keep_working(pool) &&
+		 --nr_restarts && time_before(jiffies, end));
+
+	worker_set_flags(worker, WORKER_PREP);
+done:
+	worker_enter_idle(worker);
+	kick_pool(pool);
+	raw_spin_unlock_irq(&pool->lock);
+}
+
+/*
+ * TODO: Convert all tasklet users to workqueue and use softirq directly.
+ *
+ * This is currently called from tasklet[_hi]action() and thus is also called
+ * whenever there are tasklets to run. Let's do an early exit if there's nothing
+ * queued. Once conversion from tasklet is complete, the need_more_worker() test
+ * can be dropped.
+ *
+ * After full conversion, we'll add worker->softirq_action, directly use the
+ * softirq action and obtain the worker pointer from the softirq_action pointer.
+ */
+void workqueue_softirq_action(bool highpri)
+{
+	struct worker_pool *pool =
+		&per_cpu(bh_worker_pools, smp_processor_id())[highpri];
+	if (need_more_worker(pool))
+		bh_worker(list_first_entry(&pool->workers, struct worker, node));
+}
+
 /**
  * check_flush_dependency - check for flush dependency sanity
  * @target_wq: workqueue being flushed
@@ -3441,6 +3541,7 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 			      struct wq_barrier *barr,
 			      struct work_struct *target, struct worker *worker)
 {
+	static __maybe_unused struct lock_class_key bh_key, thr_key;
 	unsigned int work_flags = 0;
 	unsigned int work_color;
 	struct list_head *head;
@@ -3450,8 +3551,13 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 	 * as we know for sure that this will not trigger any of the
 	 * checks and call back into the fixup functions where we
 	 * might deadlock.
+	 *
+	 * BH and threaded workqueues need separate lockdep keys to avoid
+	 * spuriously triggering "inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W}
+	 * usage".
 	 */
-	INIT_WORK_ONSTACK(&barr->work, wq_barrier_func);
+	INIT_WORK_ONSTACK_KEY(&barr->work, wq_barrier_func,
+			      (pwq->wq->flags & WQ_BH) ? &bh_key : &thr_key);
 	__set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&barr->work));
 
 	init_completion_map(&barr->done, &target->lockdep_map);
@@ -3557,15 +3663,31 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 
 static void touch_wq_lockdep_map(struct workqueue_struct *wq)
 {
+#ifdef CONFIG_LOCKDEP
+	if (wq->flags & WQ_BH)
+		local_bh_disable();
+
 	lock_map_acquire(&wq->lockdep_map);
 	lock_map_release(&wq->lockdep_map);
+
+	if (wq->flags & WQ_BH)
+		local_bh_enable();
+#endif
 }
 
 static void touch_work_lockdep_map(struct work_struct *work,
 				   struct workqueue_struct *wq)
 {
+#ifdef CONFIG_LOCKDEP
+	if (wq->flags & WQ_BH)
+		local_bh_disable();
+
 	lock_map_acquire(&work->lockdep_map);
 	lock_map_release(&work->lockdep_map);
+
+	if (wq->flags & WQ_BH)
+		local_bh_enable();
+#endif
 }
 
 /**
@@ -5019,10 +5141,17 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 
 	if (!(wq->flags & WQ_UNBOUND)) {
 		for_each_possible_cpu(cpu) {
-			struct pool_workqueue **pwq_p =
-				per_cpu_ptr(wq->cpu_pwq, cpu);
-			struct worker_pool *pool =
-				&(per_cpu_ptr(cpu_worker_pools, cpu)[highpri]);
+			struct pool_workqueue **pwq_p;
+			struct worker_pool __percpu *pools;
+			struct worker_pool *pool;
+
+			if (wq->flags & WQ_BH)
+				pools = bh_worker_pools;
+			else
+				pools = cpu_worker_pools;
+
+			pool = &(per_cpu_ptr(pools, cpu)[highpri]);
+			pwq_p = per_cpu_ptr(wq->cpu_pwq, cpu);
 
 			*pwq_p = kmem_cache_alloc_node(pwq_cache, GFP_KERNEL,
 						       pool->node);
@@ -5197,6 +5326,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	size_t wq_size;
 	int name_len;
 
+	if (flags & WQ_BH) {
+		if (WARN_ON_ONCE(flags & ~__WQ_BH_ALLOWS))
+			return NULL;
+		if (WARN_ON_ONCE(max_active))
+			return NULL;
+	}
+
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
 	 * the case on many machines due to per-pod pools. While
@@ -5234,8 +5370,16 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
 			     wq->name);
 
-	max_active = max_active ?: WQ_DFL_ACTIVE;
-	max_active = wq_clamp_max_active(max_active, flags, wq->name);
+	if (flags & WQ_BH) {
+		/*
+		 * BH workqueues always share a single execution context per CPU
+		 * and don't impose any max_active limit.
+		 */
+		max_active = INT_MAX;
+	} else {
+		max_active = max_active ?: WQ_DFL_ACTIVE;
+		max_active = wq_clamp_max_active(max_active, flags, wq->name);
+	}
 
 	/* init wq */
 	wq->flags = flags;
@@ -5416,6 +5560,9 @@ EXPORT_SYMBOL_GPL(destroy_workqueue);
  */
 void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 {
+	/* max_active doesn't mean anything for BH workqueues */
+	if (WARN_ON(wq->flags & WQ_BH))
+		return;
 	/* disallow meddling with max_active for ordered workqueues */
 	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
 		return;
@@ -5617,7 +5764,24 @@ static void pr_cont_pool_info(struct worker_pool *pool)
 	pr_cont(" cpus=%*pbl", nr_cpumask_bits, pool->attrs->cpumask);
 	if (pool->node != NUMA_NO_NODE)
 		pr_cont(" node=%d", pool->node);
-	pr_cont(" flags=0x%x nice=%d", pool->flags, pool->attrs->nice);
+	pr_cont(" flags=0x%x", pool->flags);
+	if (pool->flags & POOL_BH)
+		pr_cont(" bh%s",
+			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
+	else
+		pr_cont(" nice=%d", pool->attrs->nice);
+}
+
+static void pr_cont_worker_id(struct worker *worker)
+{
+	struct worker_pool *pool = worker->pool;
+
+	if (pool->flags & WQ_BH)
+		pr_cont("bh%s",
+			pool->attrs->nice == HIGHPRI_NICE_LEVEL ? "-hi" : "");
+	else
+		pr_cont("%d%s", task_pid_nr(worker->task),
+			worker->rescue_wq ? "(RESCUER)" : "");
 }
 
 struct pr_cont_work_struct {
@@ -5694,10 +5858,9 @@ static void show_pwq(struct pool_workqueue *pwq)
 			if (worker->current_pwq != pwq)
 				continue;
 
-			pr_cont("%s %d%s:%ps", comma ? "," : "",
-				task_pid_nr(worker->task),
-				worker->rescue_wq ? "(RESCUER)" : "",
-				worker->current_func);
+			pr_cont(" %s", comma ? "," : "");
+			pr_cont_worker_id(worker);
+			pr_cont(":%ps", worker->current_func);
 			list_for_each_entry(work, &worker->scheduled, entry)
 				pr_cont_work(false, work, &pcws);
 			pr_cont_work_flush(comma, (work_func_t)-1L, &pcws);
@@ -5816,8 +5979,8 @@ static void show_one_worker_pool(struct worker_pool *pool)
 		pr_cont(" manager: %d",
 			task_pid_nr(pool->manager->task));
 	list_for_each_entry(worker, &pool->idle_list, entry) {
-		pr_cont(" %s%d", first ? "idle: " : "",
-			task_pid_nr(worker->task));
+		pr_cont(" %s", first ? "idle: " : "");
+		pr_cont_worker_id(worker);
 		first = false;
 	}
 	pr_cont("\n");
@@ -6090,13 +6253,15 @@ int workqueue_online_cpu(unsigned int cpu)
 	mutex_lock(&wq_pool_mutex);
 
 	for_each_pool(pool, pi) {
-		mutex_lock(&wq_pool_attach_mutex);
+		/* BH pools aren't affected by hotplug */
+		if (pool->flags & POOL_BH)
+			continue;
 
+		mutex_lock(&wq_pool_attach_mutex);
 		if (pool->cpu == cpu)
 			rebind_workers(pool);
 		else if (pool->cpu < 0)
 			restore_unbound_workers_cpumask(pool, cpu);
-
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
 
@@ -7053,7 +7218,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 		/* did we stall? */
 		if (time_after(now, ts + thresh)) {
 			lockup_detected = true;
-			if (pool->cpu >= 0) {
+			if (pool->cpu >= 0 && !(pool->flags & POOL_BH)) {
 				pool->cpu_stall = true;
 				cpu_pool_stall = true;
 			}
@@ -7218,10 +7383,16 @@ void __init workqueue_init_early(void)
 	pt->pod_node[0] = NUMA_NO_NODE;
 	pt->cpu_pod[0] = 0;
 
-	/* initialize CPU pools */
+	/* initialize BH and CPU pools */
 	for_each_possible_cpu(cpu) {
 		struct worker_pool *pool;
 
+		i = 0;
+		for_each_bh_worker_pool(pool, cpu) {
+			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
+			pool->flags |= POOL_BH;
+		}
+
 		i = 0;
 		for_each_cpu_worker_pool(pool, cpu)
 			init_cpu_worker_pool(pool, cpu, std_nice[i++]);
@@ -7257,10 +7428,14 @@ void __init workqueue_init_early(void)
 	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_pwr_efficient",
 					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
 					      0);
+	system_bh_wq = alloc_workqueue("events_bh", WQ_BH, 0);
+	system_bh_highpri_wq = alloc_workqueue("events_bh_highpri",
+					       WQ_BH | WQ_HIGHPRI, 0);
 	BUG_ON(!system_wq || !system_highpri_wq || !system_long_wq ||
 	       !system_unbound_wq || !system_freezable_wq ||
 	       !system_power_efficient_wq ||
-	       !system_freezable_power_efficient_wq);
+	       !system_freezable_power_efficient_wq ||
+	       !system_bh_wq || !system_bh_highpri_wq);
 }
 
 static void __init wq_cpu_intensive_thresh_init(void)
@@ -7326,9 +7501,10 @@ void __init workqueue_init(void)
 	 * up. Also, create a rescuer for workqueues that requested it.
 	 */
 	for_each_possible_cpu(cpu) {
-		for_each_cpu_worker_pool(pool, cpu) {
+		for_each_bh_worker_pool(pool, cpu)
+			pool->node = cpu_to_node(cpu);
+		for_each_cpu_worker_pool(pool, cpu)
 			pool->node = cpu_to_node(cpu);
-		}
 	}
 
 	list_for_each_entry(wq, &workqueues, list) {
@@ -7339,7 +7515,16 @@ void __init workqueue_init(void)
 
 	mutex_unlock(&wq_pool_mutex);
 
-	/* create the initial workers */
+	/*
+	 * Create the initial workers. A BH pool has one pseudo worker that
+	 * represents the shared BH execution context and thus doesn't get
+	 * affected by hotplug events. Create the BH pseudo workers for all
+	 * possible CPUs here.
+	 */
+	for_each_possible_cpu(cpu)
+		for_each_bh_worker_pool(pool, cpu)
+			BUG_ON(!create_worker(pool));
+
 	for_each_online_cpu(cpu) {
 		for_each_cpu_worker_pool(pool, cpu) {
 			pool->flags &= ~POOL_DISASSOCIATED;
diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index bd381511bd9a..d29b918306b4 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -79,7 +79,9 @@ args = parser.parse_args()
 wq_type_len = 9
 
 def wq_type_str(wq):
-    if wq.flags & WQ_UNBOUND:
+    if wq.flags & WQ_BH:
+        return f'{"bh":{wq_type_len}}'
+    elif wq.flags & WQ_UNBOUND:
         if wq.flags & WQ_ORDERED:
             return f'{"ordered":{wq_type_len}}'
         else:
@@ -97,6 +99,7 @@ wq_pod_types            = prog['wq_pod_types']
 wq_affn_dfl             = prog['wq_affn_dfl']
 wq_affn_names           = prog['wq_affn_names']
 
+WQ_BH                   = prog['WQ_BH']
 WQ_UNBOUND              = prog['WQ_UNBOUND']
 WQ_ORDERED              = prog['__WQ_ORDERED']
 WQ_MEM_RECLAIM          = prog['WQ_MEM_RECLAIM']
@@ -107,6 +110,8 @@ WQ_AFFN_CACHE           = prog['WQ_AFFN_CACHE']
 WQ_AFFN_NUMA            = prog['WQ_AFFN_NUMA']
 WQ_AFFN_SYSTEM          = prog['WQ_AFFN_SYSTEM']
 
+POOL_BH                 = prog['POOL_BH']
+
 WQ_NAME_LEN             = prog['WQ_NAME_LEN'].value_()
 cpumask_str_len         = len(cpumask_str(wq_unbound_cpumask))
 
@@ -151,10 +156,12 @@ max_ref_len = 0
 
 for pi, pool in idr_for_each(worker_pool_idr):
     pool = drgn.Object(prog, 'struct worker_pool', address=pool)
-    print(f'pool[{pi:0{max_pool_id_len}}] ref={pool.refcnt.value_():{max_ref_len}} nice={pool.attrs.nice.value_():3} ', end='')
+    print(f'pool[{pi:0{max_pool_id_len}}] flags=0x{pool.flags.value_():02x} ref={pool.refcnt.value_():{max_ref_len}} nice={pool.attrs.nice.value_():3} ', end='')
     print(f'idle/workers={pool.nr_idle.value_():3}/{pool.nr_workers.value_():3} ', end='')
     if pool.cpu >= 0:
         print(f'cpu={pool.cpu.value_():3}', end='')
+        if pool.flags & POOL_BH:
+            print(' bh', end='')
     else:
         print(f'cpus={cpumask_str(pool.attrs.cpumask)}', end='')
         print(f' pod_cpus={cpumask_str(pool.attrs.__pod_cpumask)}', end='')
-- 
2.43.0


