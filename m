Return-Path: <linux-kernel+bounces-6475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726E81996E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2212287A44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A11F615;
	Wed, 20 Dec 2023 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j48pcX3Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DE1DFF5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3e05abcaeso8129415ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703057149; x=1703661949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsYKlFCgCPMsFzKOi3xaG7vQok2jJBsQgs+2hZsZcZk=;
        b=j48pcX3Y+WGEW0Tos+piQr+SnRx0kk6NehpShrM89ouc3hTXoUq0kDhu5A0evWTux8
         I7d76++eyFH580c73gHBs1ckr8s7zV/syjJnllr1pTl3JNd55BQ1IBZzoVoRJ6ox3KnG
         ACccMWxSqjbZ2vY9EzaDeRC1LojuoKU92HdGby78FEVj0g/+7aKcxL/Jn7fhfm32PB9p
         9z/E7IKj+go/SczkTirtypDv6ngrPDP6MOnwtW2n8PomzdH32Acd8+LXKRLfUx/GNJnS
         ShaFmOXnlK55CT/EqAI1LH4mj35ewzP9olI0z8jjYRjRDJVDobVGBVGIZN9MgEJ6K6/y
         vPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703057149; x=1703661949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsYKlFCgCPMsFzKOi3xaG7vQok2jJBsQgs+2hZsZcZk=;
        b=Gn4sTHARGXhK5OMvxYumEEC+iuQ9D+2T1qYSEf+gsccBhhUw03Ka/xFWQH5gxywwt9
         iImvjcEDr+o0WMFEJqHbqQ7olN4llBtCJLKxPl7l2w5YW1Rr03ykP58DmPO052Bbzglv
         A21TGABNQjMeJYbEazdbfqMX5I7pcG42CYH6V1n07eSrYEeYpp9XQA8NCctGE4JnXSr4
         kyIS8sJ8AOGqSth8s9NhKndwse5eKkvLrgoCsJfgIdwrwPh46YwZPGQezlFAvy4ne72S
         iHix18X0UfEPrwlTAB/uMSNyN4x3dorrF8DiNql5vYtasif7D+wmHDpUXpSsCN1sf4vU
         g5WQ==
X-Gm-Message-State: AOJu0Yw0im//BGyldr3QTAx1nIv804YdWGYbTKEtmCG74ohJXRgqLCw3
	ccAYEL8aKhjnSeXw4tpbRL4=
X-Google-Smtp-Source: AGHT+IEaCuPIbvnl9O82X3ZRB7kjB7WYESgKBSxM5nXt0a7RKbdSqrwzI1KjuOySbP7dvFKmuIho2g==
X-Received: by 2002:a17:902:bb10:b0:1d3:eade:bdba with SMTP id im16-20020a170902bb1000b001d3eadebdbamr691365plb.101.1703057149389;
        Tue, 19 Dec 2023 23:25:49 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id ji6-20020a170903324600b001d3f285157dsm357683plb.124.2023.12.19.23.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 23:25:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/10] workqueue: Move nr_active handling into helpers
Date: Wed, 20 Dec 2023 16:24:35 +0900
Message-ID: <20231220072529.1036099-5-tj@kernel.org>
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

__queue_work(), pwq_dec_nr_in_flight() and wq_adjust_max_active() were
open-coding nr_active handling, which is fine given that the operations are
trivial. However, the planned unbound nr_active update will make them more
complicated, so let's move them into helpers.

- pwq_tryinc_nr_active() is added. It increments nr_active if under
  max_active limit and return a boolean indicating whether inc was
  successful. Note that the function is structured to accommodate future
  changes. __queue_work() is updated to use the new helper.

- pwq_activate_first_inactive() is updated to use pwq_tryinc_nr_active() and
  thus no longer assumes that nr_active is under max_active and returns a
  boolean to indicate whether a work item has been activated.

- wq_adjust_max_active() no longer tests directly whether a work item can be
  activated. Instead, it's updated to use the return value of
  pwq_activate_first_inactive() to tell whether a work item has been
  activated.

- nr_active decrement and activating the first inactive work item is
  factored into pwq_dec_nr_active().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 80 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index adec03e63d50..21bd4e4351f7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1484,12 +1484,66 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
 	return true;
 }
 
-static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
+/**
+ * pwq_tryinc_nr_active - Try to increment nr_active for a pwq
+ * @pwq: pool_workqueue of interest
+ *
+ * Try to increment nr_active for @pwq. Returns %true if an nr_active count is
+ * successfully obtained. %false otherwise.
+ */
+static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
 {
-	struct work_struct *work = list_first_entry(&pwq->inactive_works,
-						    struct work_struct, entry);
+	struct workqueue_struct *wq = pwq->wq;
+	struct worker_pool *pool = pwq->pool;
+	bool obtained;
 
-	pwq_activate_work(pwq, work);
+	lockdep_assert_held(&pool->lock);
+
+	obtained = pwq->nr_active < wq->max_active;
+
+	if (obtained)
+		pwq->nr_active++;
+	return obtained;
+}
+
+/**
+ * pwq_activate_first_inactive - Activate the first inactive work item on a pwq
+ * @pwq: pool_workqueue of interest
+ *
+ * Activate the first inactive work item of @pwq if available and allowed by
+ * max_active limit.
+ *
+ * Returns %true if an inactive work item has been activated. %false if no
+ * inactive work item is found or max_active limit is reached.
+ */
+static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
+{
+	struct work_struct *work =
+		list_first_entry_or_null(&pwq->inactive_works,
+					 struct work_struct, entry);
+
+	if (work && pwq_tryinc_nr_active(pwq)) {
+		__pwq_activate_work(pwq, work);
+		return true;
+	} else {
+		return false;
+	}
+}
+
+/**
+ * pwq_dec_nr_active - Retire an active count
+ * @pwq: pool_workqueue of interest
+ *
+ * Decrement @pwq's nr_active and try to activate the first inactive work item.
+ */
+static void pwq_dec_nr_active(struct pool_workqueue *pwq)
+{
+	struct worker_pool *pool = pwq->pool;
+
+	lockdep_assert_held(&pool->lock);
+
+	pwq->nr_active--;
+	pwq_activate_first_inactive(pwq);
 }
 
 /**
@@ -1507,14 +1561,8 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 {
 	int color = get_work_color(work_data);
 
-	if (!(work_data & WORK_STRUCT_INACTIVE)) {
-		pwq->nr_active--;
-		if (!list_empty(&pwq->inactive_works)) {
-			/* one down, submit an inactive one */
-			if (pwq->nr_active < pwq->wq->max_active)
-				pwq_activate_first_inactive(pwq);
-		}
-	}
+	if (!(work_data & WORK_STRUCT_INACTIVE))
+		pwq_dec_nr_active(pwq);
 
 	pwq->nr_in_flight[color]--;
 
@@ -1811,12 +1859,11 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	pwq->nr_in_flight[pwq->work_color]++;
 	work_flags = work_color_to_flags(pwq->work_color);
 
-	if (likely(pwq->nr_active < pwq->wq->max_active)) {
+	if (pwq_tryinc_nr_active(pwq)) {
 		if (list_empty(&pool->worklist))
 			pool->watchdog_ts = jiffies;
 
 		trace_workqueue_activate_work(work);
-		pwq->nr_active++;
 		insert_work(pwq, work, &pool->worklist, work_flags);
 		kick_pool(pool);
 	} else {
@@ -4672,9 +4719,8 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 		/* this function can be called during early boot w/ irq disabled */
 		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
 
-		while (!list_empty(&pwq->inactive_works) &&
-		       pwq->nr_active < wq->max_active)
-			pwq_activate_first_inactive(pwq);
+		while (pwq_activate_first_inactive(pwq))
+			;
 
 		kick_pool(pwq->pool);
 
-- 
2.43.0


