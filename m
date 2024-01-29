Return-Path: <linux-kernel+bounces-43621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BCA8416BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F991F23B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EBE15A4B7;
	Mon, 29 Jan 2024 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijKG9IBd"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B22159594;
	Mon, 29 Jan 2024 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570723; cv=none; b=i6BJ7QygwCeurEM71OVCmkuwrhg9qPO/4c+gpuoAbOpsxgv9O6YXVGW9+tw0YLEcW69sLH7QUUzm+mSZ69+aMt6l1pAn1m24F5i9l7LdkhOCye+5sXLXV6ijLU6HkDUAr7uDAIW9/kZDYMAgFGRVhqAcEkBRB5pyk0WCNbkeVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570723; c=relaxed/simple;
	bh=6NHANsKimEmeDczr5yWLAv9JpPQJ0N4prGmD0Ogf/zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwXquxYBhnQEdWlHyoO+zGFO7Do37fha7jZK8z6Ta9w7rR6NaXi8yQrAWGYxQMOq+2Mz49HvjF131d8sWEaPqUzDhPDEElk8zqwIcUr1J/9vDRKBihbxKYHcDszFURpOxpG2vNT+uUwB49rOu6hntnclJMPnskXCq5bsoIn34dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijKG9IBd; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc223f3dd5eso3525079276.2;
        Mon, 29 Jan 2024 15:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570721; x=1707175521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snjBKVpgcETM9dK5JtwaV9ltKohq1JoqryzBSSfrFXQ=;
        b=ijKG9IBdoRbwcxOzkqkIAinQZnlxM9cBRF8vDZ52ua6rDEtsg6EPihkrotdXN9HaAr
         HjNItJQ4lS7i61DB17N+9nOz/9gWdu5uz9WZSCLhcaEs+uQIgG9y4r0CXdToSUyuUy8C
         GqnYozrQ7VLCp4qKxv0OXXdD7NV2Xo8JwqMyWGIlw2hB42S5PymgOt3RNwgTUb4zK12r
         ftwCFULjLRUZoYcaaU96SwXw+W90xYqBa4wtKyI24YPEYH+CunOyW9vrpesJToTOcJN0
         RUEIaBGakTqSERBdhg8FUDUIeLFm0fYBJM1W+Bff3jKKewqTe6vC5F2gUWq6TUETLZ/1
         Uq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570721; x=1707175521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snjBKVpgcETM9dK5JtwaV9ltKohq1JoqryzBSSfrFXQ=;
        b=lseIv6seHkvthAOhTL46msueRWeLnyFUxz8wobrNgr3+Mt3XC9E9oyn0vReo0XXgvb
         2Unwr+118g9qpgTK1YLWi4dCb1mcBu35AGJl5+3SY0Oqr8moiqKwi6WE9EWsRIMCWOdF
         m0jbs9izZqc16Z/Nt0MsIatA1PGGBE+6xgyCyeyXloBlDl/pr4CPxJmh5eb3LADoR6HA
         oDF9F/NwpjOMHLFVIrV2ilHYTLIXAl2Z1ogjQPZD+m1fC+w0OmhPgXLC+XWboc2Snf6f
         k3p/BPEAp69Hdff0pwDQp1Jj8t08yY3U7jZqpBQuzEtvTkZuLRcdvZz5MbhHEItX6E+o
         JC8Q==
X-Gm-Message-State: AOJu0Yxy02VSEZwPFExl/ihiYMOtBiik+1EI+TYgNnhyy4WZ0quI45cK
	+49+OFh9MYEJ6F1avIJSKYojQJu9B/7QUmXWt80fmKfuvRMxT4yD
X-Google-Smtp-Source: AGHT+IFnbrM+OIMzWet6q+D1iR86P3xA9kflKL/exQuNes5CoRkrXU9A6R83sDdM0ivA6JZH08CnEQ==
X-Received: by 2002:a05:6902:2405:b0:dc6:48db:71a4 with SMTP id dr5-20020a056902240500b00dc648db71a4mr5657140ybb.97.1706570720862;
        Mon, 29 Jan 2024 15:25:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVX/hUiM20kbw+yXKniPPDmzc/LOFI1dcxKANxu8aDAVh/cza5RLHGPkF2/iHjQUKipIYcRtFmJiantyYLMB+RKyNpzwokCFvmJyjyOizC6HiBlwZ5Wv2nUGXjnkhG+FoHEK+RlRpG2MPgt2IHFulvEdessuCQULRr0ZrKnBwurgd1RzJWLMn5uJbYvfMXGRvAsHShhe1xc6tLhH2gNPCploxPUZ9uBj4N+R0juu/ZEc50tj4y39yLGUdEjgUx6/5O0cp7DBBJ3m/ERnnpMbqFQl4i6S+GHgJ/VSg1oR6S5/nB2Kcx5RIEq+Ni3m/kuGpxa7Wejs0ZG+LUI51eUYeSPxHAVhVQCz1kLTVmY1Lm5kUpU/daGUYZAbbh5wNI=
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id bs11-20020a05620a470b00b0078374b01a71sm3535537qkb.5.2024.01.29.15.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:25:20 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 23AAD27C005B;
	Mon, 29 Jan 2024 18:25:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Jan 2024 18:25:20 -0500
X-ME-Sender: <xms:3zO4ZfhACNIKQXZ4u-XK58Kjyn321Y51JqvYB5grmj1vEQ7rgD-tVA>
    <xme:3zO4ZcCVeBTZE8VD9MZOhfiw-XvNSCSkOlboHeAYPkcDLm78tQ_rj5PxNfjSEBSyA
    oFDwD-4IN69TQou0A>
X-ME-Received: <xmr:3zO4ZfGaQpLcxe3uaPhGdEkFmkKCRuZJWjpvtlt0tNejT2KepaDbBpT3gvutrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4DO4ZcTqnzagwoK4J4zMzYrpsVrPZRaOo56_nsWM9RKe42fFT3A-nQ>
    <xmx:4DO4ZczR9o8Uu2QzikiSWAcdSzdNVCB6iFTygkJsvSYtyEp-sWIdIw>
    <xmx:4DO4ZS44i90dWEicTMk4fuxKAAylhwmxgTXxarB-iKB-LgNTgiTzNw>
    <xmx:4DO4ZW6yN0qLc1al6fOtucBcabweBHMVwQPaYBwlvS1zuElOSptUPQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:25:19 -0500 (EST)
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
Subject: [PATCH 5/8] rcu/exp: Move expedited kthread worker creation functions above rcutree_prepare_cpu()
Date: Mon, 29 Jan 2024 15:23:43 -0800
Message-ID: <20240129232349.3170819-6-boqun.feng@gmail.com>
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

The expedited kthread worker performing the per node initialization is
going to be split into per node kthreads. As such, the future per node
kthread creation will need to be called from CPU hotplug callbacks
instead of an initcall, right beside the per node boost kthread
creation.

To prepare for that, move the kthread worker creation above
rcutree_prepare_cpu() as a first step to make the review smoother for
the upcoming modifications.

No intended functional change.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 96 +++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cdb80835c469..657ac12f9e27 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4394,6 +4394,54 @@ rcu_boot_init_percpu_data(int cpu)
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
+#ifdef CONFIG_RCU_EXP_KTHREAD
+struct kthread_worker *rcu_exp_gp_kworker;
+struct kthread_worker *rcu_exp_par_gp_kworker;
+
+static void __init rcu_start_exp_gp_kworkers(void)
+{
+	const char *par_gp_kworker_name = "rcu_exp_par_gp_kthread_worker";
+	const char *gp_kworker_name = "rcu_exp_gp_kthread_worker";
+	struct sched_param param = { .sched_priority = kthread_prio };
+
+	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
+	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
+		pr_err("Failed to create %s!\n", gp_kworker_name);
+		rcu_exp_gp_kworker = NULL;
+		return;
+	}
+
+	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
+	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
+		pr_err("Failed to create %s!\n", par_gp_kworker_name);
+		rcu_exp_par_gp_kworker = NULL;
+		kthread_destroy_worker(rcu_exp_gp_kworker);
+		rcu_exp_gp_kworker = NULL;
+		return;
+	}
+
+	sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
+	sched_setscheduler_nocheck(rcu_exp_par_gp_kworker->task, SCHED_FIFO,
+				   &param);
+}
+
+static inline void rcu_alloc_par_gp_wq(void)
+{
+}
+#else /* !CONFIG_RCU_EXP_KTHREAD */
+struct workqueue_struct *rcu_par_gp_wq;
+
+static void __init rcu_start_exp_gp_kworkers(void)
+{
+}
+
+static inline void rcu_alloc_par_gp_wq(void)
+{
+	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
+	WARN_ON(!rcu_par_gp_wq);
+}
+#endif /* CONFIG_RCU_EXP_KTHREAD */
+
 /*
  * Invoked early in the CPU-online process, when pretty much all services
  * are available.  The incoming CPU is not present.
@@ -4730,54 +4778,6 @@ static int rcu_pm_notify(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-#ifdef CONFIG_RCU_EXP_KTHREAD
-struct kthread_worker *rcu_exp_gp_kworker;
-struct kthread_worker *rcu_exp_par_gp_kworker;
-
-static void __init rcu_start_exp_gp_kworkers(void)
-{
-	const char *par_gp_kworker_name = "rcu_exp_par_gp_kthread_worker";
-	const char *gp_kworker_name = "rcu_exp_gp_kthread_worker";
-	struct sched_param param = { .sched_priority = kthread_prio };
-
-	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
-	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
-		pr_err("Failed to create %s!\n", gp_kworker_name);
-		rcu_exp_gp_kworker = NULL;
-		return;
-	}
-
-	rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
-	if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
-		pr_err("Failed to create %s!\n", par_gp_kworker_name);
-		rcu_exp_par_gp_kworker = NULL;
-		kthread_destroy_worker(rcu_exp_gp_kworker);
-		rcu_exp_gp_kworker = NULL;
-		return;
-	}
-
-	sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
-	sched_setscheduler_nocheck(rcu_exp_par_gp_kworker->task, SCHED_FIFO,
-				   &param);
-}
-
-static inline void rcu_alloc_par_gp_wq(void)
-{
-}
-#else /* !CONFIG_RCU_EXP_KTHREAD */
-struct workqueue_struct *rcu_par_gp_wq;
-
-static void __init rcu_start_exp_gp_kworkers(void)
-{
-}
-
-static inline void rcu_alloc_par_gp_wq(void)
-{
-	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
-	WARN_ON(!rcu_par_gp_wq);
-}
-#endif /* CONFIG_RCU_EXP_KTHREAD */
-
 /*
  * Spawn the kthreads that handle RCU's grace periods.
  */
-- 
2.43.0


