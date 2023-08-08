Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BEF7735CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjHHBP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHHBPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:15:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0FC99
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 18:15:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686c06b806cso3388233b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691457323; x=1692062123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7gXsXCxVIW9TYpVsT+cxia2VA+uyZkdmJZ6lnk6iz4=;
        b=EcneuuVr2qHKUUd0vO59pO3ueM72/QTSMqPM1CgHsOi+tf3x4k52bYWggVrzPokDls
         TPTXPerRGVHiJ6Yp9v3onExBV9v7fZQ1QJNHxW+AofjczwkOovdWoIq5vG7sAnXloqJj
         rLSfLSbVnD3tyOcI+FudwsY6bbT456p8pg2zs4wOd+qrCepUkWH38JMi0c6wp2Z1tB9j
         Jseo6MleUGWitGLipV1nR6BQ29scOGpOlnHYsY4GlevUkUtLieqrzsKUP5gAOUr7JK/T
         mrqbBt+hhpborL2np8FD/UlUpfMaXPvmJLK7xPKhZSxiIfYcCE9QGUlax4gST8mNkoG9
         WLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691457323; x=1692062123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7gXsXCxVIW9TYpVsT+cxia2VA+uyZkdmJZ6lnk6iz4=;
        b=XbqT2wiREruUWWCXiRU51CU0FAoA7TdDUDFG31rPLZqcAce86vu/wR2/tvdlh66woB
         7SLTN9Ljf89gFN9YYmngy/q26f7bQC/vVSjjuuVQtbeCRZgf4CgWOg67/MNWkdivHhTQ
         3sTU/CjwD+plnEvHp5BbPCDDvsAGSs7quQgUXcxEegFtkSRHelidd7ddjRqsyCFDvk0V
         vjIF38UGSNzyPcV7jv+5rbTYuRIMU109vS97c7WtvkbNc+VKgZhHYjzkdkIhDaxL6Esk
         CGF8S4IrqY7NvHHVfPUrSXk/BBNurmn4a8R7dAF1EAblZv0EOsW2HVynhtPoYTAefYYN
         Aykw==
X-Gm-Message-State: AOJu0YxRac+S/tlHvqnUOS6mUy37bUWpwE5/pP7hmjH1n8mQf13W6eww
        tb/DpESOh0VA9qyIX49uvmo=
X-Google-Smtp-Source: AGHT+IE9lJ9JWTdpoAHOKTYiUc3jDBBqroi1/sNLE148cioZnO2wCqgUH6m/E+rDVz+wscamUWZ6cg==
X-Received: by 2002:a05:6a20:7354:b0:13e:aede:f37e with SMTP id v20-20020a056a20735400b0013eaedef37emr10424725pzc.41.1691457323385;
        Mon, 07 Aug 2023 18:15:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d5d])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7900d000000b006871859d9a1sm6756234pfo.7.2023.08.07.18.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 18:15:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 7 Aug 2023 15:15:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com
Subject: [PATCH v2 03/24] workqueue: Not all work insertion needs to wake up
 a worker
Message-ID: <ZNGXKdKfDfDfB5S1@slm.duckdns.org>
References: <20230519001709.2563-1-tj@kernel.org>
 <20230519001709.2563-4-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519001709.2563-4-tj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

insert_work() always tried to wake up a worker; however, the only time it
needs to try to wake up a worker is when a new active work item is queued.
When a work item goes on the inactive list or queueing a flush work item,
there's no reason to try to wake up a worker.

This patch moves the worker wakeup logic out of insert_work() and places it
in the active new work item queueing path in __queue_work().

While at it:

* __queue_work() is dereferencing pwq->pool repeatedly. Add local variable
  pool.

* Every caller of insert_work() calls debug_work_activate(). Consolidate the
  invocations into insert_work().

* In __queue_work() pool->watchdog_ts update is relocated slightly. This is
  to better accommodate future changes.

This makes wakeups more precise and will help the planned change to assign
work items to workers before waking them up. No behavior changes intended.

v2: WARN_ON_ONCE(pool != last_pool) added in __queue_work() to clarify as
    suggested by Lai.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c |   38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1539,7 +1539,7 @@ fail:
 static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 			struct list_head *head, unsigned int extra_flags)
 {
-	struct worker_pool *pool = pwq->pool;
+	debug_work_activate(work);
 
 	/* record the work call stack in order to print it in KASAN reports */
 	kasan_record_aux_stack_noalloc(work);
@@ -1548,9 +1548,6 @@ static void insert_work(struct pool_work
 	set_work_pwq(work, pwq, extra_flags);
 	list_add_tail(&work->entry, head);
 	get_pwq(pwq);
-
-	if (__need_more_worker(pool))
-		wake_up_worker(pool);
 }
 
 /*
@@ -1604,8 +1601,7 @@ static void __queue_work(int cpu, struct
 			 struct work_struct *work)
 {
 	struct pool_workqueue *pwq;
-	struct worker_pool *last_pool;
-	struct list_head *worklist;
+	struct worker_pool *last_pool, *pool;
 	unsigned int work_flags;
 	unsigned int req_cpu = cpu;
 
@@ -1639,13 +1635,15 @@ retry:
 		pwq = per_cpu_ptr(wq->cpu_pwqs, cpu);
 	}
 
+	pool = pwq->pool;
+
 	/*
 	 * If @work was previously on a different pool, it might still be
 	 * running there, in which case the work needs to be queued on that
 	 * pool to guarantee non-reentrancy.
 	 */
 	last_pool = get_work_pool(work);
-	if (last_pool && last_pool != pwq->pool) {
+	if (last_pool && last_pool != pool) {
 		struct worker *worker;
 
 		raw_spin_lock(&last_pool->lock);
@@ -1654,13 +1652,15 @@ retry:
 
 		if (worker && worker->current_pwq->wq == wq) {
 			pwq = worker->current_pwq;
+			pool = pwq->pool;
+			WARN_ON_ONCE(pool != last_pool);
 		} else {
 			/* meh... not running there, queue here */
 			raw_spin_unlock(&last_pool->lock);
-			raw_spin_lock(&pwq->pool->lock);
+			raw_spin_lock(&pool->lock);
 		}
 	} else {
-		raw_spin_lock(&pwq->pool->lock);
+		raw_spin_lock(&pool->lock);
 	}
 
 	/*
@@ -1673,7 +1673,7 @@ retry:
 	 */
 	if (unlikely(!pwq->refcnt)) {
 		if (wq->flags & WQ_UNBOUND) {
-			raw_spin_unlock(&pwq->pool->lock);
+			raw_spin_unlock(&pool->lock);
 			cpu_relax();
 			goto retry;
 		}
@@ -1692,21 +1692,22 @@ retry:
 	work_flags = work_color_to_flags(pwq->work_color);
 
 	if (likely(pwq->nr_active < pwq->max_active)) {
+		if (list_empty(&pool->worklist))
+			pool->watchdog_ts = jiffies;
+
 		trace_workqueue_activate_work(work);
 		pwq->nr_active++;
-		worklist = &pwq->pool->worklist;
-		if (list_empty(worklist))
-			pwq->pool->watchdog_ts = jiffies;
+		insert_work(pwq, work, &pool->worklist, work_flags);
+
+		if (__need_more_worker(pool))
+			wake_up_worker(pool);
 	} else {
 		work_flags |= WORK_STRUCT_INACTIVE;
-		worklist = &pwq->inactive_works;
+		insert_work(pwq, work, &pwq->inactive_works, work_flags);
 	}
 
-	debug_work_activate(work);
-	insert_work(pwq, work, worklist, work_flags);
-
 out:
-	raw_spin_unlock(&pwq->pool->lock);
+	raw_spin_unlock(&pool->lock);
 	rcu_read_unlock();
 }
 
@@ -3010,7 +3011,6 @@ static void insert_wq_barrier(struct poo
 	pwq->nr_in_flight[work_color]++;
 	work_flags |= work_color_to_flags(work_color);
 
-	debug_work_activate(&barr->work);
 	insert_work(pwq, &barr->work, head, work_flags);
 }
 
