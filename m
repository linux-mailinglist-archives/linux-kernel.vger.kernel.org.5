Return-Path: <linux-kernel+bounces-25130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C782C853
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843982837BB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FD0139B;
	Sat, 13 Jan 2024 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA2e2a8T"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AB366
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d40eec5e12so59730415ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105756; x=1705710556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axKJ0i3ogoNGsDkLhBCodaoDDJvR3L1aScZ9kKcgSQ4=;
        b=JA2e2a8TJSgTqUahnefLMYZHPT1MBAt1+4xC4sGTzNYnRbMoOamk1OsAz9HHb6YDnT
         8whx4b53lZZ1OqdpecRDe3XNZgw29F8FACwSvlzTd1Z6YJ6hWwpwQ8a6f3SO8EQhRmNA
         6jPj/NPD2YsFX39Y2pkU/6N79xQt0nYq6k4QrsziIiVXUIZAt34bNjMnAbj5B3OO82d0
         TsTdRg9yuadD4hB4PJXFVEYvssZf90jUCLtFTRMKNXQbLGdomqdMcqpev5Tsb3DBp5CF
         /9UR/TAOxMzPFz6EkPP1pm9XBOoDdc7oZsT+8LUeQD7h1l+0E10A5FGlx+yK2mZR0Zsa
         YT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105756; x=1705710556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=axKJ0i3ogoNGsDkLhBCodaoDDJvR3L1aScZ9kKcgSQ4=;
        b=Wu/pJ1T/h6FYe8mDWE6fJHugIDR14tPcn8QUZI/HCvAkYXK7mlEUaSUwLIVH2ybSjB
         aIiNrCspzxZZCJZjk/WaAzJXdU7co6yj2BpUYEocFZUOYbIaC18xkWMD24b+nitsfbGu
         mamGnwW+7vQWRm3vrca+RrfrC3F18rNDMlunrpurglTMoZAv+Rnmha6UCN0NtvPX9YyR
         +IkPlrLcBuDtqhVrQm/7gAskcLj9387CFB6+L7oOScNWBTr+IimLzJxUr0a5a3FZfUYS
         1pjyrM7BDmsKkY22X0YVkjQTLnyDVyHNlhCOtVmC6KV71qbK6cjnX3xKp+/D2hZXv2HD
         kmcQ==
X-Gm-Message-State: AOJu0YwwPnJX7zgsXm1JPMHn+o6XfReRhPfadZnYvzzKT34Dl+U/5gem
	06rpEcgizxYLqtufH1WVK7E=
X-Google-Smtp-Source: AGHT+IHolF/V3AvKUbqP/e0/tf57Rc6RHw3J9blTMOWyaURreIovMl86TrdBoiCI6j5DHAHVxZF6gA==
X-Received: by 2002:a17:902:d4ce:b0:1d4:7f08:46db with SMTP id o14-20020a170902d4ce00b001d47f0846dbmr2613704plg.119.1705105756248;
        Fri, 12 Jan 2024 16:29:16 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id n17-20020a170903111100b001d3ffb7c4c7sm3745489plh.40.2024.01.12.16.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:29:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/9] workqueue: Move pwq->max_active to wq->max_active
Date: Fri, 12 Jan 2024 14:28:45 -1000
Message-ID: <20240113002911.406791-2-tj@kernel.org>
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

max_active is a workqueue-wide setting and the configured value is stored in
wq->saved_max_active; however, the effective value was stored in
pwq->max_active. While this is harmless, it makes max_active update process
more complicated and gets in the way of the planned max_active semantic
updates for unbound workqueues.

This patches moves pwq->max_active to wq->max_active. This simplifies the
code and makes freezing and noop max_active updates cheaper too. No
user-visible behavior change is intended.

As wq->max_active is updated while holding wq mutex but read without any
locking, it now uses WRITE/READ_ONCE(). A new locking locking rule WO is
added for it.

v2: - wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

    - __queue_work() is updated to alwyas delay the work item if there
      already are inactive work items on the pwq. This prevents work item
      reordering inside the pwq when max_active is increased thus
      maintaining execution order for ordered workqueues. This issue was
      noticed by Lai.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 134 ++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 68 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 76e60faed892..8bf1d143e911 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -143,6 +143,9 @@ enum {
  *
  * WR: wq->mutex protected for writes.  RCU protected for reads.
  *
+ * WO: wq->mutex protected for writes. Updated with WRITE_ONCE() and can be read
+ *     with READ_ONCE() without locking.
+ *
  * MD: wq_mayday_lock protected.
  *
  * WD: Used internally by the watchdog.
@@ -250,7 +253,6 @@ struct pool_workqueue {
 	 * is marked with WORK_STRUCT_INACTIVE iff it is in pwq->inactive_works.
 	 */
 	int			nr_active;	/* L: nr of active works */
-	int			max_active;	/* L: max active works */
 	struct list_head	inactive_works;	/* L: inactive works */
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
@@ -298,7 +300,8 @@ struct workqueue_struct {
 	struct worker		*rescuer;	/* MD: rescue worker */
 
 	int			nr_drainers;	/* WQ: drain in progress */
-	int			saved_max_active; /* WQ: saved pwq max_active */
+	int			max_active;	/* WO: max active works */
+	int			saved_max_active; /* WQ: saved max_active */
 
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
 	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
@@ -1492,7 +1495,7 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 		pwq->nr_active--;
 		if (!list_empty(&pwq->inactive_works)) {
 			/* one down, submit an inactive one */
-			if (pwq->nr_active < pwq->max_active)
+			if (pwq->nr_active < READ_ONCE(pwq->wq->max_active))
 				pwq_activate_first_inactive(pwq);
 		}
 	}
@@ -1793,7 +1796,13 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	pwq->nr_in_flight[pwq->work_color]++;
 	work_flags = work_color_to_flags(pwq->work_color);
 
-	if (likely(pwq->nr_active < pwq->max_active)) {
+	/*
+	 * Limit the number of concurrently active work items to max_active.
+	 * @work must also queue behind existing inactive work items to maintain
+	 * ordering when max_active changes. See wq_adjust_max_active().
+	 */
+	if (list_empty(&pwq->inactive_works) &&
+	    pwq->nr_active < READ_ONCE(pwq->wq->max_active)) {
 		if (list_empty(&pool->worklist))
 			pool->watchdog_ts = jiffies;
 
@@ -4142,50 +4151,6 @@ static void pwq_release_workfn(struct kthread_work *work)
 	}
 }
 
-/**
- * pwq_adjust_max_active - update a pwq's max_active to the current setting
- * @pwq: target pool_workqueue
- *
- * If @pwq isn't freezing, set @pwq->max_active to the associated
- * workqueue's saved_max_active and activate inactive work items
- * accordingly.  If @pwq is freezing, clear @pwq->max_active to zero.
- */
-static void pwq_adjust_max_active(struct pool_workqueue *pwq)
-{
-	struct workqueue_struct *wq = pwq->wq;
-	bool freezable = wq->flags & WQ_FREEZABLE;
-	unsigned long flags;
-
-	/* for @wq->saved_max_active */
-	lockdep_assert_held(&wq->mutex);
-
-	/* fast exit for non-freezable wqs */
-	if (!freezable && pwq->max_active == wq->saved_max_active)
-		return;
-
-	/* this function can be called during early boot w/ irq disabled */
-	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-
-	/*
-	 * During [un]freezing, the caller is responsible for ensuring that
-	 * this function is called at least once after @workqueue_freezing
-	 * is updated and visible.
-	 */
-	if (!freezable || !workqueue_freezing) {
-		pwq->max_active = wq->saved_max_active;
-
-		while (!list_empty(&pwq->inactive_works) &&
-		       pwq->nr_active < pwq->max_active)
-			pwq_activate_first_inactive(pwq);
-
-		kick_pool(pwq->pool);
-	} else {
-		pwq->max_active = 0;
-	}
-
-	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
-}
-
 /* initialize newly allocated @pwq which is associated with @wq and @pool */
 static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 		     struct worker_pool *pool)
@@ -4218,9 +4183,6 @@ static void link_pwq(struct pool_workqueue *pwq)
 	/* set the matching work_color */
 	pwq->work_color = wq->work_color;
 
-	/* sync max_active to the current setting */
-	pwq_adjust_max_active(pwq);
-
 	/* link in @pwq */
 	list_add_rcu(&pwq->pwqs_node, &wq->pwqs);
 }
@@ -4658,6 +4620,52 @@ static int init_rescuer(struct workqueue_struct *wq)
 	return 0;
 }
 
+/**
+ * wq_adjust_max_active - update a wq's max_active to the current setting
+ * @wq: target workqueue
+ *
+ * If @wq isn't freezing, set @wq->max_active to the saved_max_active and
+ * activate inactive work items accordingly. If @wq is freezing, clear
+ * @wq->max_active to zero.
+ */
+static void wq_adjust_max_active(struct workqueue_struct *wq)
+{
+	struct pool_workqueue *pwq;
+
+	lockdep_assert_held(&wq->mutex);
+
+	if ((wq->flags & WQ_FREEZABLE) && workqueue_freezing) {
+		WRITE_ONCE(wq->max_active, 0);
+		return;
+	}
+
+	if (wq->max_active == wq->saved_max_active)
+		return;
+
+	/*
+	 * Update @wq->max_active and then kick inactive work items if more
+	 * active work items are allowed. This doesn't break work item ordering
+	 * because new work items are always queued behind existing inactive
+	 * work items if there are any.
+	 */
+	WRITE_ONCE(wq->max_active, wq->saved_max_active);
+
+	for_each_pwq(pwq, wq) {
+		unsigned long flags;
+
+		/* this function can be called during early boot w/ irq disabled */
+		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+
+		while (!list_empty(&pwq->inactive_works) &&
+		       pwq->nr_active < wq->max_active)
+			pwq_activate_first_inactive(pwq);
+
+		kick_pool(pwq->pool);
+
+		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+	}
+}
+
 __printf(1, 4)
 struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
@@ -4665,7 +4673,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 {
 	va_list args;
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4700,6 +4707,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	/* init wq */
 	wq->flags = flags;
+	wq->max_active = max_active;
 	wq->saved_max_active = max_active;
 	mutex_init(&wq->mutex);
 	atomic_set(&wq->nr_pwqs_to_flush, 0);
@@ -4728,8 +4736,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	mutex_lock(&wq_pool_mutex);
 
 	mutex_lock(&wq->mutex);
-	for_each_pwq(pwq, wq)
-		pwq_adjust_max_active(pwq);
+	wq_adjust_max_active(wq);
 	mutex_unlock(&wq->mutex);
 
 	list_add_tail_rcu(&wq->list, &workqueues);
@@ -4867,8 +4874,6 @@ EXPORT_SYMBOL_GPL(destroy_workqueue);
  */
 void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 {
-	struct pool_workqueue *pwq;
-
 	/* disallow meddling with max_active for ordered workqueues */
 	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
 		return;
@@ -4879,10 +4884,7 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 
 	wq->flags &= ~__WQ_ORDERED;
 	wq->saved_max_active = max_active;
-
-	for_each_pwq(pwq, wq)
-		pwq_adjust_max_active(pwq);
-
+	wq_adjust_max_active(wq);
 	mutex_unlock(&wq->mutex);
 }
 EXPORT_SYMBOL_GPL(workqueue_set_max_active);
@@ -5128,8 +5130,8 @@ static void show_pwq(struct pool_workqueue *pwq)
 	pr_info("  pwq %d:", pool->id);
 	pr_cont_pool_info(pool);
 
-	pr_cont(" active=%d/%d refcnt=%d%s\n",
-		pwq->nr_active, pwq->max_active, pwq->refcnt,
+	pr_cont(" active=%d refcnt=%d%s\n",
+		pwq->nr_active, pwq->refcnt,
 		!list_empty(&pwq->mayday_node) ? " MAYDAY" : "");
 
 	hash_for_each(pool->busy_hash, bkt, worker, hentry) {
@@ -5677,7 +5679,6 @@ EXPORT_SYMBOL_GPL(work_on_cpu_safe_key);
 void freeze_workqueues_begin(void)
 {
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	mutex_lock(&wq_pool_mutex);
 
@@ -5686,8 +5687,7 @@ void freeze_workqueues_begin(void)
 
 	list_for_each_entry(wq, &workqueues, list) {
 		mutex_lock(&wq->mutex);
-		for_each_pwq(pwq, wq)
-			pwq_adjust_max_active(pwq);
+		wq_adjust_max_active(wq);
 		mutex_unlock(&wq->mutex);
 	}
 
@@ -5752,7 +5752,6 @@ bool freeze_workqueues_busy(void)
 void thaw_workqueues(void)
 {
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	mutex_lock(&wq_pool_mutex);
 
@@ -5764,8 +5763,7 @@ void thaw_workqueues(void)
 	/* restore max_active and repopulate worklist */
 	list_for_each_entry(wq, &workqueues, list) {
 		mutex_lock(&wq->mutex);
-		for_each_pwq(pwq, wq)
-			pwq_adjust_max_active(pwq);
+		wq_adjust_max_active(wq);
 		mutex_unlock(&wq->mutex);
 	}
 
-- 
2.43.0


