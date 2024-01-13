Return-Path: <linux-kernel+bounces-25133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5AC82C856
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F031C21488
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A33A4C98;
	Sat, 13 Jan 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TenI6p3p"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5383217
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9344f30caso4811478b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105762; x=1705710562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHZTLdbBlT7efr/AkMY5cDjAIG20FkLrR0SFo9knAck=;
        b=TenI6p3pyVYDjVbPN7IzJ7gB7DjqpeGmy+uq8o4Fn0pECGXkVKU9mgQ+yQkhjIS6FG
         ywdi2HETE0Ju/Bfz3tF0U6HjvZsSUW8QdVebZZzbhVyU7cktZpkDbyhDUXdUFCUz4snt
         l+/e3q98lJEVC4e3ujMuFgGX80TzFNTeez7jRoT6/08KlL82E3ICULHkfSTc3J/bJuQL
         SRnBnRN5oyeX5M5pfRCw20OQSrB3SChk6AVSihtFaGCf+Qyvu0n3WAuOS/1lbf1b5bA8
         NPKLnmScc2GEFhg3XBscqEc+l0SBw8YivuQ+i9qKfHa2rJoomKaMJ8nYThdbaGjT4PJQ
         1I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105762; x=1705710562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dHZTLdbBlT7efr/AkMY5cDjAIG20FkLrR0SFo9knAck=;
        b=UGTZQ8EeNmCvQ8CpuXRgi964i4eXSZ4BjMP57WHD+eSBfqqYiO4zRxCXwxusqvKmDW
         TRxSoMA5+zbDjzxHKC7cTkYdkxl4UjkUHTJvu3n/Dgl2kTPNv2YcLKbZj1/zeYJT1qpN
         orJFNIv7LBqGkNlAjCf6aNE/rvObHhg6JFxqK4VS8Xy1bw5mht5YAZdAaAsO971heqkD
         TIB/Ia91cns0E+X6ilo83Ij5Pqd8Ju+NRB8R2BY2Z1WaUinDt5Vsfzhpdz6VqhAzWqT6
         NtanhAK+Z1nMmJHCB/5qOIwCMsaAUluq/NfVXU7O3B6MCuvOLfB6CE1xWOAS8mPgXqXA
         7I2Q==
X-Gm-Message-State: AOJu0YzgzAQHghjKzDDgceOqwT7tGcRdFkgq2TVGNjdeO39/bgEHGxrb
	KEUS9sGqkIplQPZZUhxmmMU=
X-Google-Smtp-Source: AGHT+IHDQg3ufrbIo1LNGdIMQiSXK1v9/NljzNAR0x2VHCCws1pjA8fEaKmcBoqthNDPJxDPcYgnCA==
X-Received: by 2002:a05:6a00:2341:b0:6d9:a074:659f with SMTP id j1-20020a056a00234100b006d9a074659fmr2965898pfj.13.1705105761633;
        Fri, 12 Jan 2024 16:29:21 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id a4-20020a62d404000000b006d98f584ad5sm3829454pfh.199.2024.01.12.16.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:29:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/9] workqueue: Move nr_active handling into helpers
Date: Fri, 12 Jan 2024 14:28:48 -1000
Message-ID: <20240113002911.406791-5-tj@kernel.org>
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

v2: wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 81 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2cd275b34df2..7eb1925087fd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1493,12 +1493,66 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
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
+	obtained = pwq->nr_active < READ_ONCE(wq->max_active);
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
@@ -1516,14 +1570,8 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 {
 	int color = get_work_color(work_data);
 
-	if (!(work_data & WORK_STRUCT_INACTIVE)) {
-		pwq->nr_active--;
-		if (!list_empty(&pwq->inactive_works)) {
-			/* one down, submit an inactive one */
-			if (pwq->nr_active < READ_ONCE(pwq->wq->max_active))
-				pwq_activate_first_inactive(pwq);
-		}
-	}
+	if (!(work_data & WORK_STRUCT_INACTIVE))
+		pwq_dec_nr_active(pwq);
 
 	pwq->nr_in_flight[color]--;
 
@@ -1825,13 +1873,11 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 * @work must also queue behind existing inactive work items to maintain
 	 * ordering when max_active changes. See wq_adjust_max_active().
 	 */
-	if (list_empty(&pwq->inactive_works) &&
-	    pwq->nr_active < READ_ONCE(pwq->wq->max_active)) {
+	if (list_empty(&pwq->inactive_works) && pwq_tryinc_nr_active(pwq)) {
 		if (list_empty(&pool->worklist))
 			pool->watchdog_ts = jiffies;
 
 		trace_workqueue_activate_work(work);
-		pwq->nr_active++;
 		insert_work(pwq, work, &pool->worklist, work_flags);
 		kick_pool(pool);
 	} else {
@@ -4680,9 +4726,8 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
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


