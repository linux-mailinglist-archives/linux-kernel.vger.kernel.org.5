Return-Path: <linux-kernel+bounces-43620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333FC8416BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5318B1C2312A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48C9524BB;
	Mon, 29 Jan 2024 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDgN1dKR"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BF07603C;
	Mon, 29 Jan 2024 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570721; cv=none; b=qIBMu5HkFIXWN4hqaF+uKhI35hKIOt2KOFFKv17WRiKzrcvESxl/LCnpLFbxU2Cg8m8fATKoSVsMAMzA8FJsEQizLMRMhKfw0i+i/2+C1SAcxOtYVko1tdpYSVkLXvussa6V/MJKaUgydqOiAMCrGkZ8mRn7s0xWMO7USPmG1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570721; c=relaxed/simple;
	bh=6Fxu62jgWecOBzhuRlJqFy8cBWmtPCl5ok4CyaFOmZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxdkqcI0TBVjs2mstDtmQ2xbF/aEyNit7rRt5HVQPGGQZ/EK+DdnBhdSD9IScpY/kUZToL6SLn9NN0aoh+ZYrZk5cPg7geCwZtlH3NmWGPnMaEC2f5ndRe2vlq8WzYxcfFsdxf1ILwlbLqa+8SeCW2z0FR+Fe1FEHdAcp/jh+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDgN1dKR; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6868823be58so25072746d6.0;
        Mon, 29 Jan 2024 15:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570719; x=1707175519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wkmf0C6jjHSizsoyLESwTs8SZ7UOIs7D67BRQdDmsB4=;
        b=KDgN1dKR8lyIxScp5cmEEZkrHvEg1TPHMl8FM8N6LvIDW0IBLbiQ+mhRbkNlfPk30P
         1M4rOnbZgbdYPOM1yEg0yU1zJ1ip6ewCviXAJ2jeDRWgn+ZkdviZrSv4TjHx8pESZR00
         Jn65BqSBHKatJL9csred4uu2MWcY/SzzGFDkI4KO9wwJPcHf4AsNRyhWLbaP91wSIk2B
         X2EJZ/W3sBsiyJdT9nZO4rjgC7awhXWLT+qK0dlAPc5S5YmynWCLGuZItaFPf/8WYxLc
         jw8BYdiSAw3VYsZ4VhQV6kihJDxxOqoGhRkWwwei/AAp+aq/lGhiq5vt8VlHg/ICAm5K
         Hu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570719; x=1707175519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wkmf0C6jjHSizsoyLESwTs8SZ7UOIs7D67BRQdDmsB4=;
        b=M78nK4b5IXN6iZwIGY0c+/CFehWmb4gBhFFcYsX1glUnv1gEdoNSnoB5Zbepvjf3zn
         G/AZZDfwM42t6SZ/BUBQqcCvgO4z1bJZ+I51B/d+rp4obgzU1Hi/yEhpcu4xl/bNs4PG
         wJPRAUZLp6FF6e9X7X+BBqPf8od/Mi8eCJECJFi4cZFO3s56QIqSneMMUL4cD2mytLdo
         NMoF+RcgRkBIS6uMeeLWDJcc5LSaEWKyjLDCy3jQVoA7raX4vU8Nh6ej4iA5tTvJCmoF
         uvpyb1ElkYT/RXw7/+521eStgUp8dsA2qg0WqxEYjp5AwW6RdtznJOvBlCsa4BcBHsGl
         oiIA==
X-Gm-Message-State: AOJu0YxrpmdYACpPPGt7APU6/lcpGSnjZmplfRIVxgJk3mhy0GZJQu4R
	23njAb7hOERcew7zlOPD/L1I0fiDvuKeU92QCobsDDytplS5sgdN
X-Google-Smtp-Source: AGHT+IGCR+lvmMOtKqre0oEiCSPn6/0z6kzGljUU4tM7zowHCj/1YUko77lLEnK0OMHEa8Lv2dUGng==
X-Received: by 2002:a05:6214:2346:b0:686:9f2e:da2a with SMTP id hu6-20020a056214234600b006869f2eda2amr7838680qvb.37.1706570719277;
        Mon, 29 Jan 2024 15:25:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVs9NA+PHx80Po9OCOeTN9DA3FVCtJBFE4fVoVL6y6GacVR/OwCzFmxnocbT1QhDk8f9Ghf2gkiIDLMTY7LA9yf7NW8BWI8ye5Vjtc13omMYAUmkm2QuU6dGJOxEsjRkA/5G1W3zgscHOlYcrE8NGbgGEi1yQUibKIi+eubVgN8dgCev8IsAU3egTyvPdVMm8EtxggTe4GgrYeGRDDIjmO1DOhmHTDaxduH9NuN4lBcHr1vWfuXyER7P1OlG1Fq+FDpNWQnAsAPLPioNwtP2zL6Lajjcnqs76eiq+ZrdOV+0BzbJM1FFOCgfqmDTiVmqEG+wnRceL9bVX1N04tIwQh7noTjzSToS2+L0cYbDYM+2UlrPVYl7svFx2VX0N0=
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id di3-20020ad458e3000000b0068c4f1da09csm1430070qvb.120.2024.01.29.15.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:25:18 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 5DB3027C005B;
	Mon, 29 Jan 2024 18:25:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 18:25:18 -0500
X-ME-Sender: <xms:3jO4ZW_zuzsHJlpLHeliORnK8yNacwmnyVqWA20VEy7nSwY-4LLdBw>
    <xme:3jO4ZWt8BkCoZfLjKTZ-kL2RhxXhpbdWlwxO88Ua23cMGNn8Uubz39LErQiXD8OwL
    tJ8IM9BehOD0ci5sg>
X-ME-Received: <xmr:3jO4ZcBzj4qtXaDi4D7X0fWBC_pPOU_KBNrab26jIhJC7gaTsEdZAS4iwsJtGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:3jO4Zec09lrGnGekUsxre3sE04JSupx3JSYDMsgtG5K6NKiJXv57aQ>
    <xmx:3jO4ZbPUk0HCF1pobjDauGqQ-lvGPgccAZ9ealNtQiA180-6ntxHSg>
    <xmx:3jO4ZYn-9Iw6mseMg8l8_mGsClAtZGJpQZX7_TfLLi_eubQyrZgVew>
    <xmx:3jO4ZYnF26gPD7-ruOsbkvE9tVYatJcis1APfubrs7D0fi15YFY7Zg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:25:17 -0500 (EST)
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
Subject: [PATCH 4/8] rcu: s/boost_kthread_mutex/kthread_mutex
Date: Mon, 29 Jan 2024 15:23:42 -0800
Message-ID: <20240129232349.3170819-5-boqun.feng@gmail.com>
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

This mutex is currently protecting per node boost kthreads creation and
affinity setting across CPU hotplug operations.

Since the expedited kworkers will soon be split per node as well, they
will be subject to the same concurrency constraints against hotplug.

Therefore their creation and affinity tuning operations will be grouped
with those of boost kthreads and then rely on the same mutex.

To prepare for that, generalize its name.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  2 +-
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f2c10d351b59..cdb80835c469 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4918,7 +4918,7 @@ static void __init rcu_init_one(void)
 			init_waitqueue_head(&rnp->exp_wq[2]);
 			init_waitqueue_head(&rnp->exp_wq[3]);
 			spin_lock_init(&rnp->exp_lock);
-			mutex_init(&rnp->boost_kthread_mutex);
+			mutex_init(&rnp->kthread_mutex);
 			raw_spin_lock_init(&rnp->exp_poll_lock);
 			rnp->exp_seq_poll_rq = RCU_GET_STATE_COMPLETED;
 			INIT_WORK(&rnp->exp_poll_wq, sync_rcu_do_polled_gp);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e9821a8422db..13e7b0d907ab 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -113,7 +113,7 @@ struct rcu_node {
 				/*  side effect, not as a lock. */
 	unsigned long boost_time;
 				/* When to start boosting (jiffies). */
-	struct mutex boost_kthread_mutex;
+	struct mutex kthread_mutex;
 				/* Exclusion for thread spawning and affinity */
 				/*  manipulation. */
 	struct task_struct *boost_kthread_task;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 41021080ad25..0d307674915c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1195,7 +1195,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	struct sched_param sp;
 	struct task_struct *t;
 
-	mutex_lock(&rnp->boost_kthread_mutex);
+	mutex_lock(&rnp->kthread_mutex);
 	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
 		goto out;
 
@@ -1212,7 +1212,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
 
  out:
-	mutex_unlock(&rnp->boost_kthread_mutex);
+	mutex_unlock(&rnp->kthread_mutex);
 }
 
 /*
@@ -1224,7 +1224,7 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
  * no outgoing CPU.  If there are no CPUs left in the affinity set,
  * this function allows the kthread to execute on any CPU.
  *
- * Any future concurrent calls are serialized via ->boost_kthread_mutex.
+ * Any future concurrent calls are serialized via ->kthread_mutex.
  */
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
@@ -1237,7 +1237,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		return;
 	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
 		return;
-	mutex_lock(&rnp->boost_kthread_mutex);
+	mutex_lock(&rnp->kthread_mutex);
 	mask = rcu_rnp_online_cpus(rnp);
 	for_each_leaf_node_possible_cpu(rnp, cpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
@@ -1250,7 +1250,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 			cpumask_clear_cpu(outgoingcpu, cm);
 	}
 	set_cpus_allowed_ptr(t, cm);
-	mutex_unlock(&rnp->boost_kthread_mutex);
+	mutex_unlock(&rnp->kthread_mutex);
 	free_cpumask_var(cm);
 }
 
-- 
2.43.0


