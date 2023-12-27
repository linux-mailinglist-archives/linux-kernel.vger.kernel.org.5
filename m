Return-Path: <linux-kernel+bounces-12062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF0181EF90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987B51C21180
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13C45C0C;
	Wed, 27 Dec 2023 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmO4K4Ao"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8B945BF1
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-28c0df4b42eso2407449a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688590; x=1704293390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKo1wBDCqtIzP+GSKPuy7WewEJssgRVowRe//gyJUC0=;
        b=QmO4K4AoZMSeXOxYB1i8sOoWnDzdIQIICbyHdtJfuec/Zqvm2DvOSZDQ55pAkT5k/D
         7PFtr9TV7sN9dqRFxzq2Oj/sltQ5uRbe4qiQpGTdxrQeVPssJw2KG4TMCXV5yepKRpr6
         K+aQ7UOf7GzK+HOAHhpX7THuWHKXyQlh00TjqqFKrjYjtwQuAmRqkR1KJwvpalBDxNeG
         c5Wi4RIUP6wX6150fcZeY7q8oLI4kC0i8m/4yhjcbZne9MUZJgPCe2RbNQRRDO98DkAh
         DAnXwoimUF3bfpdPb3HAZvbHnMk0iqmIVZa6x4ozPY9j/X6mty21HJuzfzHckWmytiBK
         EuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688590; x=1704293390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKo1wBDCqtIzP+GSKPuy7WewEJssgRVowRe//gyJUC0=;
        b=nyqHqUwCFf+2dFEfmBNe+ElODDVJNgBFFVVt9qJyKEjjH0EPAEDbvlwFZYXAdCvkup
         w3o1Kf88xwNgAYc6tb7hlacgf33uOzGq/IfTt6hqYhovk7CuZqcHZyS4CQVRtI7ndA+z
         eSh2vr5L4Mtsus0/V7mLk/OHW1ZS4OF6N0t05dZrduzTT3pTsL6LRGIyjl53XfkPRlgG
         SFZc4c579mm4yD7ndATecxXurSd1QNc3dp+Yiipo/AsK0AX7eCxrChPggHOpFl0lfelG
         j0O0l9Ty1AThKFt6iIWkavJawef4EaW54NMQYskc8jcMiPyGtdexQnsg8zzDdgFENoK6
         NGgA==
X-Gm-Message-State: AOJu0YzWc9r3vAZN0czlygkU8aisde/seKm/VG8IL2eaRJxwf6kWU14m
	MgTBNP59gIH1BBT+9kVEJFQ2eHkRP7I=
X-Google-Smtp-Source: AGHT+IHeXSarFXe61pBQRVue6pVDu42IhdPayF6IIWlrCZTUR9pCiNTUAeUbWMdYixrsUEA1B/uLsQ==
X-Received: by 2002:a17:90a:b006:b0:28c:4527:ef9a with SMTP id x6-20020a17090ab00600b0028c4527ef9amr6353789pjq.40.1703688589589;
        Wed, 27 Dec 2023 06:49:49 -0800 (PST)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id li16-20020a17090b48d000b0028bf0b91f6bsm12423701pjb.21.2023.12.27.06.49.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2023 06:49:49 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Naohiro.Aota@wdc.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/7] workqueue: Share the same PWQ for the CPUs of a pod
Date: Wed, 27 Dec 2023 22:51:38 +0800
Message-Id: <20231227145143.2399-3-jiangshanlai@gmail.com>
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

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

PWQs with the same attrs shared the same pool. So just share the same
PWQ for all the CPUs of a pod instead of duplicating them.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 78 +++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e734625fc8ce..1f52685498f1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4360,15 +4360,29 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 		goto out_free;
 
 	for_each_possible_cpu(cpu) {
+		struct pool_workqueue *pwq;
+		int tcpu;
+
+		if (ctx->pwq_tbl[cpu])
+			continue;
 		wq_calc_pod_cpumask(new_attrs, cpu, -1);
 		if (cpumask_equal(new_attrs->cpumask, new_attrs->__pod_cpumask)) {
 			ctx->dfl_pwq->refcnt++;
 			ctx->pwq_tbl[cpu] = ctx->dfl_pwq;
 			continue;
 		}
-		ctx->pwq_tbl[cpu] = alloc_unbound_pwq(wq, new_attrs);
-		if (!ctx->pwq_tbl[cpu])
+		pwq = alloc_unbound_pwq(wq, new_attrs);
+		if (!pwq)
 			goto out_free;
+		/*
+		 * Reinitialize pwq->refcnt and prepare the new pwd for
+		 * all the CPU of the pod.
+		 */
+		pwq->refcnt = 0;
+		for_each_cpu(tcpu, new_attrs->__pod_cpumask) {
+			pwq->refcnt++;
+			ctx->pwq_tbl[tcpu] = pwq;
+		}
 	}
 
 	/* save the user configured attrs and sanitize it. */
@@ -4483,15 +4497,13 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 /**
  * wq_update_pod - update pod affinity of a wq for CPU hot[un]plug
  * @wq: the target workqueue
- * @cpu: the CPU to update pool association for
- * @hotplug_cpu: the CPU coming up or going down
+ * @cpu: the CPU coming up or going down
  * @online: whether @cpu is coming up or going down
  *
  * This function is to be called from %CPU_DOWN_PREPARE, %CPU_ONLINE and
  * %CPU_DOWN_FAILED.  @cpu is being hot[un]plugged, update pod affinity of
  * @wq accordingly.
  *
- *
  * If pod affinity can't be adjusted due to memory allocation failure, it falls
  * back to @wq->dfl_pwq which may not be optimal but is always correct.
  *
@@ -4502,11 +4514,11 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * CPU_DOWN. If a workqueue user wants strict affinity, it's the user's
  * responsibility to flush the work item from CPU_DOWN_PREPARE.
  */
-static void wq_update_pod(struct workqueue_struct *wq, int cpu,
-			  int hotplug_cpu, bool online)
+static void wq_update_pod(struct workqueue_struct *wq, int cpu, bool online)
 {
-	int off_cpu = online ? -1 : hotplug_cpu;
-	struct pool_workqueue *old_pwq = NULL, *pwq;
+	int off_cpu = online ? -1 : cpu;
+	int tcpu;
+	struct pool_workqueue *pwq;
 	struct workqueue_attrs *target_attrs;
 
 	lockdep_assert_held(&wq_pool_mutex);
@@ -4541,20 +4553,24 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu,
 		goto use_dfl_pwq;
 	}
 
-	/* Install the new pwq. */
+	/* Install the new pwq for all the cpus of the pod */
 	mutex_lock(&wq->mutex);
-	old_pwq = install_unbound_pwq(wq, cpu, pwq);
-	goto out_unlock;
+	/* reinitialize pwq->refcnt before installing */
+	pwq->refcnt = 0;
+	for_each_cpu(tcpu, target_attrs->__pod_cpumask)
+		pwq->refcnt++;
+	for_each_cpu(tcpu, target_attrs->__pod_cpumask)
+		put_pwq_unlocked(install_unbound_pwq(wq, tcpu, pwq));
+	mutex_unlock(&wq->mutex);
+	return;
 
 use_dfl_pwq:
 	mutex_lock(&wq->mutex);
 	raw_spin_lock_irq(&wq->dfl_pwq->pool->lock);
 	get_pwq(wq->dfl_pwq);
 	raw_spin_unlock_irq(&wq->dfl_pwq->pool->lock);
-	old_pwq = install_unbound_pwq(wq, cpu, wq->dfl_pwq);
-out_unlock:
+	put_pwq_unlocked(install_unbound_pwq(wq, cpu, wq->dfl_pwq));
 	mutex_unlock(&wq->mutex);
-	put_pwq_unlocked(old_pwq);
 }
 
 static int alloc_and_link_pwqs(struct workqueue_struct *wq)
@@ -5563,15 +5579,8 @@ int workqueue_online_cpu(unsigned int cpu)
 
 	/* update pod affinity of unbound workqueues */
 	list_for_each_entry(wq, &workqueues, list) {
-		struct workqueue_attrs *attrs = wq->unbound_attrs;
-
-		if (attrs) {
-			const struct wq_pod_type *pt = wqattrs_pod_type(attrs);
-			int tcpu;
-
-			for_each_cpu(tcpu, pt->pod_cpus[pt->cpu_pod[cpu]])
-				wq_update_pod(wq, tcpu, cpu, true);
-		}
+		if (wq->unbound_attrs)
+			wq_update_pod(wq, cpu, true);
 	}
 
 	mutex_unlock(&wq_pool_mutex);
@@ -5591,15 +5600,8 @@ int workqueue_offline_cpu(unsigned int cpu)
 	/* update pod affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
 	list_for_each_entry(wq, &workqueues, list) {
-		struct workqueue_attrs *attrs = wq->unbound_attrs;
-
-		if (attrs) {
-			const struct wq_pod_type *pt = wqattrs_pod_type(attrs);
-			int tcpu;
-
-			for_each_cpu(tcpu, pt->pod_cpus[pt->cpu_pod[cpu]])
-				wq_update_pod(wq, tcpu, cpu, false);
-		}
+		if (wq->unbound_attrs)
+			wq_update_pod(wq, cpu, false);
 	}
 	mutex_unlock(&wq_pool_mutex);
 
@@ -5891,9 +5893,8 @@ static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
 	wq_affn_dfl = affn;
 
 	list_for_each_entry(wq, &workqueues, list) {
-		for_each_online_cpu(cpu) {
-			wq_update_pod(wq, cpu, cpu, true);
-		}
+		for_each_online_cpu(cpu)
+			wq_update_pod(wq, cpu, true);
 	}
 
 	mutex_unlock(&wq_pool_mutex);
@@ -6803,9 +6804,8 @@ void __init workqueue_init_topology(void)
 	 * combinations to apply per-pod sharing.
 	 */
 	list_for_each_entry(wq, &workqueues, list) {
-		for_each_online_cpu(cpu) {
-			wq_update_pod(wq, cpu, cpu, true);
-		}
+		for_each_online_cpu(cpu)
+			wq_update_pod(wq, cpu, true);
 	}
 
 	mutex_unlock(&wq_pool_mutex);
-- 
2.19.1.6.gb485710b


