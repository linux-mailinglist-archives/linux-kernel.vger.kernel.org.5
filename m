Return-Path: <linux-kernel+bounces-6472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886CE81996B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B41EB25F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01101946F;
	Wed, 20 Dec 2023 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjdZvmac"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A83168DF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d66a0d10dcso1948925b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057141; x=1703661941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+zSdnxMkcjIOp2lIIfXJtU39c5cCHvIXwT5qcpnifw=;
        b=FjdZvmacKo00A8enfFnVzCxBqiwXvEQ4ClXPzr6cFVqP7JhlKU1tHPS1PhJY5TIoQu
         vMsM4G2ZUcCIrN2mLwlrkOQTpmMFQH3C0FHr29B6sThGuzoxCE+HkoJnyPIhDi73CmhM
         ATVm+BaB7nf56NmrB3BSL0BB0T3oxmYJfvvkKxX35iPQAukqrn5sboYwSHz9KOgLIN+7
         dGGAFlRtQH4rMquIc1gSvK5YCDfo7S+KYephLphWjlfT5dP+dS5JHwtSw/IZPAE+9B1u
         drgPHclobht3k4GmKmnH8wUH+GFUaahcAamywux2dxwEBkH07FXGdmTX3MpftYRJCY22
         1eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057141; x=1703661941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+zSdnxMkcjIOp2lIIfXJtU39c5cCHvIXwT5qcpnifw=;
        b=L+NBojYL0ynihPLrI7CkVwJhb2Y4gaLJkVaiVPoQS6ncOi1FxDT+HyeBTwCNRDZs4z
         WjdZP7flSwPD89s1RWxmMGBt3YmQLXIQSZJlUvuWSoIn4UoA/iDTQHx+7AhBXjoE3hVp
         rsDkrIQksgOCSYffPG266HtJHQ6lgyM81sgm96QdICbpLSahMi501qxlzrs28YUturww
         UWLFhlFSbJ1iCCLJBtGVEo8+UwEnYAYBp5xku8MBCJ5LS3llMyBl5Ua8Clw1H2WM0Km+
         y0F66xUrilQMQFRDDDs4HMIfjB1z/V84l+uvHhktLWnB8p51Cbm93qt33dbYQGAAkxJs
         iE0A==
X-Gm-Message-State: AOJu0YyL1YUb2IYaUhVkoygz7yQPfoyZ/6inwLgV36MG6fGXQISqEH7N
	yceT4PC7yaaWOXUjHp+Fb7I=
X-Google-Smtp-Source: AGHT+IH/DGZubxphRkiWwjZKZArampg2h6FCd+NVMHhMC3zA9BFjtY/cP/nCcruohglDVouudMdMLw==
X-Received: by 2002:a05:6a00:460f:b0:6ce:4866:f388 with SMTP id ko15-20020a056a00460f00b006ce4866f388mr12473875pfb.24.1703057140542;
        Tue, 19 Dec 2023 23:25:40 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id ka33-20020a056a0093a100b006ce7ad8c14esm5588717pfb.164.2023.12.19.23.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:25:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/10] workqueue: Move pwq->max_active to wq->max_active
Date: Wed, 20 Dec 2023 16:24:32 +0900
Message-ID: <20231220072529.1036099-2-tj@kernel.org>
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

max_active is a workqueue-wide setting and the configured value is stored in
wq->saved_max_active; however, the effective value was stored in
pwq->max_active. While this is harmless, it makes max_active update process
more complicated and gets in the way of the planned max_active semantic
updates for unbound workqueues.

This patches moves pwq->max_active to wq->max_active. This simplifies the
code and makes freezing and noop max_active updates cheaper too. No
user-visible behavior change is intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 119 +++++++++++++++++++--------------------------
 1 file changed, 51 insertions(+), 68 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..0e5dbeeb5778 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -250,7 +250,6 @@ struct pool_workqueue {
 	 * is marked with WORK_STRUCT_INACTIVE iff it is in pwq->inactive_works.
 	 */
 	int			nr_active;	/* L: nr of active works */
-	int			max_active;	/* L: max active works */
 	struct list_head	inactive_works;	/* L: inactive works */
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
@@ -298,7 +297,8 @@ struct workqueue_struct {
 	struct worker		*rescuer;	/* MD: rescue worker */
 
 	int			nr_drainers;	/* WQ: drain in progress */
-	int			saved_max_active; /* WQ: saved pwq max_active */
+	int			max_active;	/* WQ: max active works */
+	int			saved_max_active; /* WQ: saved max_active */
 
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
 	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
@@ -1486,7 +1486,7 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 		pwq->nr_active--;
 		if (!list_empty(&pwq->inactive_works)) {
 			/* one down, submit an inactive one */
-			if (pwq->nr_active < pwq->max_active)
+			if (pwq->nr_active < pwq->wq->max_active)
 				pwq_activate_first_inactive(pwq);
 		}
 	}
@@ -1787,7 +1787,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	pwq->nr_in_flight[pwq->work_color]++;
 	work_flags = work_color_to_flags(pwq->work_color);
 
-	if (likely(pwq->nr_active < pwq->max_active)) {
+	if (likely(pwq->nr_active < pwq->wq->max_active)) {
 		if (list_empty(&pool->worklist))
 			pool->watchdog_ts = jiffies;
 
@@ -4136,50 +4136,6 @@ static void pwq_release_workfn(struct kthread_work *work)
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
@@ -4212,9 +4168,6 @@ static void link_pwq(struct pool_workqueue *pwq)
 	/* set the matching work_color */
 	pwq->work_color = wq->work_color;
 
-	/* sync max_active to the current setting */
-	pwq_adjust_max_active(pwq);
-
 	/* link in @pwq */
 	list_add_rcu(&pwq->pwqs_node, &wq->pwqs);
 }
@@ -4665,6 +4618,46 @@ static int init_rescuer(struct workqueue_struct *wq)
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
+		wq->max_active = 0;
+		return;
+	}
+
+	if (wq->max_active == wq->saved_max_active)
+		return;
+
+	wq->max_active = wq->saved_max_active;
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
@@ -4672,7 +4665,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 {
 	va_list args;
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	/*
 	 * Unbound && max_active == 1 used to imply ordered, which is no longer
@@ -4707,6 +4699,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	/* init wq */
 	wq->flags = flags;
+	wq->max_active = max_active;
 	wq->saved_max_active = max_active;
 	mutex_init(&wq->mutex);
 	atomic_set(&wq->nr_pwqs_to_flush, 0);
@@ -4735,8 +4728,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	mutex_lock(&wq_pool_mutex);
 
 	mutex_lock(&wq->mutex);
-	for_each_pwq(pwq, wq)
-		pwq_adjust_max_active(pwq);
+	wq_adjust_max_active(wq);
 	mutex_unlock(&wq->mutex);
 
 	list_add_tail_rcu(&wq->list, &workqueues);
@@ -4874,8 +4866,6 @@ EXPORT_SYMBOL_GPL(destroy_workqueue);
  */
 void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 {
-	struct pool_workqueue *pwq;
-
 	/* disallow meddling with max_active for ordered workqueues */
 	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
 		return;
@@ -4886,10 +4876,7 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 
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
@@ -5135,8 +5122,8 @@ static void show_pwq(struct pool_workqueue *pwq)
 	pr_info("  pwq %d:", pool->id);
 	pr_cont_pool_info(pool);
 
-	pr_cont(" active=%d/%d refcnt=%d%s\n",
-		pwq->nr_active, pwq->max_active, pwq->refcnt,
+	pr_cont(" active=%d refcnt=%d%s\n",
+		pwq->nr_active, pwq->refcnt,
 		!list_empty(&pwq->mayday_node) ? " MAYDAY" : "");
 
 	hash_for_each(pool->busy_hash, bkt, worker, hentry) {
@@ -5684,7 +5671,6 @@ EXPORT_SYMBOL_GPL(work_on_cpu_safe_key);
 void freeze_workqueues_begin(void)
 {
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	mutex_lock(&wq_pool_mutex);
 
@@ -5693,8 +5679,7 @@ void freeze_workqueues_begin(void)
 
 	list_for_each_entry(wq, &workqueues, list) {
 		mutex_lock(&wq->mutex);
-		for_each_pwq(pwq, wq)
-			pwq_adjust_max_active(pwq);
+		wq_adjust_max_active(wq);
 		mutex_unlock(&wq->mutex);
 	}
 
@@ -5759,7 +5744,6 @@ bool freeze_workqueues_busy(void)
 void thaw_workqueues(void)
 {
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	mutex_lock(&wq_pool_mutex);
 
@@ -5771,8 +5755,7 @@ void thaw_workqueues(void)
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


