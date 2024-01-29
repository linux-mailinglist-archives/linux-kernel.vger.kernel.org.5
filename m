Return-Path: <linux-kernel+bounces-43622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CF28416BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59683284BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F06815AAC1;
	Mon, 29 Jan 2024 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlxCMVSm"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134C15A4B2;
	Mon, 29 Jan 2024 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570726; cv=none; b=TeL6zO/4LPFfuFJscjeoY5FeV6jIzROYkAQMBGevFJIb/gnFNWkYixySohqdp4T055zHxOjXkm396msJrfHMZWrryeVL/OrZZbgVHGb/aUY4YlhNk55tVnFsF8m2Oid2GYO9do5QbvM4oJ8dCjhWwgc5gXGbyJpb0ZDA/VrghX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570726; c=relaxed/simple;
	bh=SoFpc/ELI3RyKBJRaznOw7s6VzoZYqIiQc5Hb+kLNvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxwVJsa301EtP5OkVm3SyDIsC+scMDoP/IWHhSsSlwDQVLXb/0RPeDVoyz28skiC6P8/6W99UWrfrQNIXDBU9Y1lWpoKfflKJl+CExfEXbL1k+gQL1iDp0Ln14y6fKaNfADvgtLyzbx5WPc79FURttFcWXjfjFw+KSEgry5HD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlxCMVSm; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42a9199cfd2so17861841cf.0;
        Mon, 29 Jan 2024 15:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570723; x=1707175523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wyo3gq0QuSUQokFParsBBGQO7fW0IZJ7sU9SyTB49hg=;
        b=nlxCMVSmZE1U41vlqY8d9k0AGppP3K6lwsBa+i2G3A2dl52RwcML2CZbVLd0tB2cIe
         M1lP3K61ivr+YMwz2LRa/ttHOkfjLipjge0EJxCv2qKNxjDb9k+XRA90frj6mdujKeoA
         XfG+kXeKECHUsfyZzrY6EHPO52efYsqoEXg1pqfEB92hFT4tj4F4YhFrVzUHEyKDFKp5
         Yqz2WHEiQpG+5s6x5d6JPaBvnk1BSTLfOLEXol74AleBRSq71RGK/IngES2UusP2Nj25
         WPsWb1yo7L5zJBvuSP96g3b6QcCqiALrj+QAA0ftxaMHdNPG+6xiitWz6hjTIE94AMOW
         V/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570723; x=1707175523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wyo3gq0QuSUQokFParsBBGQO7fW0IZJ7sU9SyTB49hg=;
        b=knbC9D1ki2fhV1hCOkCY6OenHJM/Aa5wyT3SHrjqJ9FxheEOWfL+Hc4ckaE3pH0RAI
         YThh6DqaWmB5jemIlA2A0nWs1M9veYiZIchyyUqYDJAc3AgCQPZi/FOubC/KBfqskMBF
         WejHYhx9tRv5BNi3OPdNQhdd5t8r1Lwe6OacKfnakC99CT7D1uKRFbh4bUR0efPQbTo5
         QtXUDKGQlBHl5FDiVYfl5HupzLqjAsEOX6vvMN2EXwIaxbvKVia9ll0b22QK+q1jJUO6
         i0A3IW00att5XuHWC03nF0fLSBmQ6HqUrur62Ond17gifnPAZJiFQxQZX7iIdifPlrR9
         eEbw==
X-Gm-Message-State: AOJu0YxwaFjxhlFcPIjidaSBbOklyS5ynhZd8JgcO8+S+Watt6cWeTnE
	vl/ugFGUs/E7N7PiTeg8kzJJKE0W4q0XbVAemTNYW88jvD/WycmA
X-Google-Smtp-Source: AGHT+IGmBec8dqFovCJq7HiFKdJz82ZcMd+zS8j4SiiNiBdshC4jhPxisP3HWJGB1QT2H2loSVXtIg==
X-Received: by 2002:ac8:5908:0:b0:42a:a582:912 with SMTP id 8-20020ac85908000000b0042aa5820912mr3422602qty.58.1706570723077;
        Mon, 29 Jan 2024 15:25:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUMX7BunnK/eoTe1QUXgKpbrxURfXkmhRr5Xr9kwe+wOgts6TIoiwO4kYVhZ8ShkvoS8VU38Z4970rwPCypBGh71OJL4w1k6ajH6BtKn5S9ei/2UIVpvJgJRZB7Kb3ko29nZPFZ4horsqvkBiQez2haV5k8X36M4wFvBFy27If+9Wjr1r3+GFEKMG4UNCAd7Q7l43eP7IIGLHBwcC29rVX7RKGu6Mzn4IJgx6emc1hEJiVD71FOr5jtc6CqbYO4dMlS0Y7C+TgMGIIWAOUiT7365AkrRTtYJ8G+GbFdXknjED5Nfst89ckECqq+IvdrkOUrTsgR5dEcSuTnGG+8g8YKSk5/kSOY7bpjupWiH041wqlgzZgbmu/sLxW/Xv8=
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id cr7-20020a05622a428700b0042a31bc98b9sm3989063qtb.24.2024.01.29.15.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:25:22 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2260C27C005B;
	Mon, 29 Jan 2024 18:25:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 29 Jan 2024 18:25:22 -0500
X-ME-Sender: <xms:4TO4ZXgTfVZAUXHqOqmKZ6GJa9Ltsxr6UoFJ_wX_0SucJrMPtFfM7Q>
    <xme:4TO4ZUA2VX13mZrLDe0H3PgpD7sOudbfdUaIFWU_UWRJVMAp_ItYbdStPON041aH-
    50tr6qeBCPfHvlNOw>
X-ME-Received: <xmr:4TO4ZXHxZWYjdQnfdMJlcQ4LmAtezYXegdMiH-vnpEBP_JTCnevFrFDaIcviqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4jO4ZUS_YgenWje6vmHp3wrXO_84JFdpU-3-fRCZVsV4tbSHQ8LcXg>
    <xmx:4jO4ZUxM1mPCOo2LoruQ0MhPgHP2NEdVuUlUBmzmpa04R_LH5DMDCg>
    <xmx:4jO4Za5gwckztlUoVaZGDwLuN5ICnJolAsoFH5lJJqrtVr5WLewrKw>
    <xmx:4jO4Ze76SAqYdR1ovkhXPPyPLkqntiAJHw1emAI76UC6Bg_V1AMEcg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:25:21 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 6/8] rcu/exp: Make parallel exp gp kworker per rcu node
Date: Mon, 29 Jan 2024 15:23:44 -0800
Message-ID: <20240129232349.3170819-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129232349.3170819-1-boqun.feng@gmail.com>
References: <20240129232349.3170819-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

When CONFIG_RCU_EXP_KTHREAD=n, the expedited grace period per node
initialization is performed in parallel via workqueues (one work per
node).

However in CONFIG_RCU_EXP_KTHREAD=y, this per node initialization is
performed by a single kworker serializing each node initialization (one
work for all nodes).

The second part is certainly less scalable and efficient beyond a single
leaf node.

To improve this, expand this single kworker into per-node kworkers. This
new layout is eventually intended to remove the workqueues based
implementation since it will essentially now become duplicate code.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h         |  1 -
 kernel/rcu/tree.c        | 61 +++++++++++++++++++++++++++-------------
 kernel/rcu/tree.h        |  3 ++
 kernel/rcu/tree_exp.h    | 10 +++----
 kernel/rcu/tree_plugin.h | 10 ++-----
 5 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index f94f65877f2b..6beaf70d629f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -625,7 +625,6 @@ void rcu_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
 #ifdef CONFIG_RCU_EXP_KTHREAD
 extern struct kthread_worker *rcu_exp_gp_kworker;
-extern struct kthread_worker *rcu_exp_par_gp_kworker;
 #else /* !CONFIG_RCU_EXP_KTHREAD */
 extern struct workqueue_struct *rcu_par_gp_wq;
 #endif /* CONFIG_RCU_EXP_KTHREAD */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 657ac12f9e27..398c099d45d9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4396,33 +4396,39 @@ rcu_boot_init_percpu_data(int cpu)
 
 #ifdef CONFIG_RCU_EXP_KTHREAD
 struct kthread_worker *rcu_exp_gp_kworker;
-struct kthread_worker *rcu_exp_par_gp_kworker;
 
-static void __init rcu_start_exp_gp_kworkers(void)
+static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
 {
-	const char *par_gp_kworker_name = "rcu_exp_par_gp_kthread_worker";
-	const char *gp_kworker_name = "rcu_exp_gp_kthread_worker";
+	struct kthread_worker *kworker;
+	const char *name = "rcu_exp_par_gp_kthread_worker/%d";
 	struct sched_param param = { .sched_priority = kthread_prio };
+	int rnp_index = rnp - rcu_get_root();
 
-	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
-	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
-		pr_err("Failed to create %s!\n", gp_kworker_name);
-		rcu_exp_gp_kworker = NULL;
+	if (rnp->exp_kworker)
+		return;
+
+	kworker = kthread_create_worker(0, name, rnp_index);
+	if (IS_ERR_OR_NULL(kworker)) {
+		pr_err("Failed to create par gp kworker on %d/%d\n",
+		       rnp->grplo, rnp->grphi);
 		return;
 	}
+	WRITE_ONCE(rnp->exp_kworker, kworker);
+	sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
+}
 
-	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
-	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
-		pr_err("Failed to create %s!\n", par_gp_kworker_name);
-		rcu_exp_par_gp_kworker = NULL;
-		kthread_destroy_worker(rcu_exp_gp_kworker);
+static void __init rcu_start_exp_gp_kworker(void)
+{
+	const char *name = "rcu_exp_gp_kthread_worker";
+	struct sched_param param = { .sched_priority = kthread_prio };
+
+	rcu_exp_gp_kworker = kthread_create_worker(0, name);
+	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
+		pr_err("Failed to create %s!\n", name);
 		rcu_exp_gp_kworker = NULL;
 		return;
 	}
-
 	sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
-	sched_setscheduler_nocheck(rcu_exp_par_gp_kworker->task, SCHED_FIFO,
-				   &param);
 }
 
 static inline void rcu_alloc_par_gp_wq(void)
@@ -4431,7 +4437,11 @@ static inline void rcu_alloc_par_gp_wq(void)
 #else /* !CONFIG_RCU_EXP_KTHREAD */
 struct workqueue_struct *rcu_par_gp_wq;
 
-static void __init rcu_start_exp_gp_kworkers(void)
+static void rcu_spawn_exp_par_gp_kworker(struct rcu_node *rnp)
+{
+}
+
+static void __init rcu_start_exp_gp_kworker(void)
 {
 }
 
@@ -4442,6 +4452,17 @@ static inline void rcu_alloc_par_gp_wq(void)
 }
 #endif /* CONFIG_RCU_EXP_KTHREAD */
 
+static void rcu_spawn_rnp_kthreads(struct rcu_node *rnp)
+{
+	if ((IS_ENABLED(CONFIG_RCU_EXP_KTHREAD) ||
+	     IS_ENABLED(CONFIG_RCU_BOOST)) && rcu_scheduler_fully_active) {
+		mutex_lock(&rnp->kthread_mutex);
+		rcu_spawn_one_boost_kthread(rnp);
+		rcu_spawn_exp_par_gp_kworker(rnp);
+		mutex_unlock(&rnp->kthread_mutex);
+	}
+}
+
 /*
  * Invoked early in the CPU-online process, when pretty much all services
  * are available.  The incoming CPU is not present.
@@ -4490,7 +4511,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	rcu_spawn_one_boost_kthread(rnp);
+	rcu_spawn_rnp_kthreads(rnp);
 	rcu_spawn_cpu_nocb_kthread(cpu);
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
 
@@ -4812,10 +4833,10 @@ static int __init rcu_spawn_gp_kthread(void)
 	 * due to rcu_scheduler_fully_active.
 	 */
 	rcu_spawn_cpu_nocb_kthread(smp_processor_id());
-	rcu_spawn_one_boost_kthread(rdp->mynode);
+	rcu_spawn_rnp_kthreads(rdp->mynode);
 	rcu_spawn_core_kthreads();
 	/* Create kthread worker for expedited GPs */
-	rcu_start_exp_gp_kworkers();
+	rcu_start_exp_gp_kworker();
 	return 0;
 }
 early_initcall(rcu_spawn_gp_kthread);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 13e7b0d907ab..e173808f486f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -72,6 +72,9 @@ struct rcu_node {
 				/* Online CPUs for next expedited GP. */
 				/*  Any CPU that has ever been online will */
 				/*  have its bit set. */
+	struct kthread_worker *exp_kworker;
+				/* Workers performing per node expedited GP */
+				/* initialization. */
 	unsigned long cbovldmask;
 				/* CPUs experiencing callback overload. */
 	unsigned long ffmask;	/* Fully functional CPUs. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6123a60d9a4d..0318a8a062d5 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -432,9 +432,9 @@ static inline bool rcu_exp_worker_started(void)
 	return !!READ_ONCE(rcu_exp_gp_kworker);
 }
 
-static inline bool rcu_exp_par_worker_started(void)
+static inline bool rcu_exp_par_worker_started(struct rcu_node *rnp)
 {
-	return !!READ_ONCE(rcu_exp_par_gp_kworker);
+	return !!READ_ONCE(rnp->exp_kworker);
 }
 
 static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
@@ -445,7 +445,7 @@ static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
 	 * another work item on the same kthread worker can result in
 	 * deadlock.
 	 */
-	kthread_queue_work(rcu_exp_par_gp_kworker, &rnp->rew.rew_work);
+	kthread_queue_work(READ_ONCE(rnp->exp_kworker), &rnp->rew.rew_work);
 }
 
 static inline void sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
@@ -487,7 +487,7 @@ static inline bool rcu_exp_worker_started(void)
 	return !!READ_ONCE(rcu_gp_wq);
 }
 
-static inline bool rcu_exp_par_worker_started(void)
+static inline bool rcu_exp_par_worker_started(struct rcu_node *rnp)
 {
 	return !!READ_ONCE(rcu_par_gp_wq);
 }
@@ -550,7 +550,7 @@ static void sync_rcu_exp_select_cpus(void)
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
-		if (!rcu_exp_par_worker_started() ||
+		if (!rcu_exp_par_worker_started(rnp) ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
 		    rcu_is_last_leaf_node(rnp)) {
 			/* No worker started yet or last leaf, do direct call. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0d307674915c..09bdd36ca9ff 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1195,14 +1195,13 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	struct sched_param sp;
 	struct task_struct *t;
 
-	mutex_lock(&rnp->kthread_mutex);
-	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
-		goto out;
+	if (rnp->boost_kthread_task)
+		return;
 
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
 	if (WARN_ON_ONCE(IS_ERR(t)))
-		goto out;
+		return;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->boost_kthread_task = t;
@@ -1210,9 +1209,6 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	sp.sched_priority = kthread_prio;
 	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
-
- out:
-	mutex_unlock(&rnp->kthread_mutex);
 }
 
 /*
-- 
2.43.0


