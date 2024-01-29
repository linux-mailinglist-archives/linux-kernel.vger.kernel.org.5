Return-Path: <linux-kernel+bounces-43619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABCA8416B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8309EB24033
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410551C38;
	Mon, 29 Jan 2024 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2BH1a++"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FB854679;
	Mon, 29 Jan 2024 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570720; cv=none; b=hKB3YjT5sVITpTVT833V7dv+YqSHeJID5P1sJD8PegeTHLkGuNxH5SckwmosNNgsCGtN432si7OOn6D2xS27kauU6VRZJOyPmNjX1M3lI+LX7KIzfrwtbZ20yQtoNRIHOxO2/4aQh8NOTVSYYL0egIpmEzM9sNZV3Mylzfx76IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570720; c=relaxed/simple;
	bh=tOPwwwAuI3o44t0gdJ5R9ub2RRxXX/bYOQUsMbxK9Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewXUcH6/uq+LkKvmX/g8PIUr1zVB8i3LFBjVrUCmt1TWqWITX2Rh0pwS44Z1VMsscNrLKT1oPnA+JfGCA+Hk6CqC5tsrL+QcVx3d7yt/tz7VsAp96LWZQFPiPJbhD2EPjPOQcTyRRtgyyojuKHvKPQrCY4QmiCqB1iOEhHEGTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2BH1a++; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a8be32041so26639841cf.1;
        Mon, 29 Jan 2024 15:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706570717; x=1707175517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NMdvE0HmwIDlVJwOttocbmozTihZY+Emgf8doJHmn8A=;
        b=V2BH1a++iAiJkf+eQl5HlLhRxRoNPgTCOqS3glBzUZvBBA3sVTFGR4p9/Cc1KX04Mm
         QrOATetJCNlhiwmRY39vp+bsHJG+DombU4h5b3WO3yIBEvqsL05HU15jNqyZh2K2/o0g
         0fZLixIcclqu46CVGvybJojOpHjleQzJwYih0UktkGr8vBqcQQYFQwu//PZaLnU4oVUK
         c1pVnF3kiW7a9i5rWbH9A2ZuiYrvKRWF3IKCL6wA8WZDK/er6r1MzFXxZ47Y8Nyt3ehU
         qlmP+YshWBY02oI8BgQPZTvswlx7tz3Kyf6N4ZSTHyIFf0BPdpvNLYxVuzOy50mhroTm
         JFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706570717; x=1707175517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NMdvE0HmwIDlVJwOttocbmozTihZY+Emgf8doJHmn8A=;
        b=PKuaLw9SJrG1SwJnJd3914SOheKx8qsZCINCfMAslR84rS6q9Ry+Y4xYb8ZSTj27nU
         gMnKZcktDgr4Nm+95ZUNAFtLMCTrYGw9ZgpLQffhpxUIijzKFExJHmfRK/Yn8T+xxVSm
         5wdwdmbYZ6LqDpFSZcl2VT5bY9Zr4uvauVbPpUcW3YUNF3PwrU2+EztSeTaDMlyWDjTZ
         N+JhB86T1/sT5te7f/O4j0JzKCTQfKP6Z2+Gayy/CaN/Wj0G7DQQOih92T+RxO3tBFLj
         oQayHvJ/kKSJDzNnlViuhzvd2LWBk3aD/yJ8qEuEQqgJy0B0X8kRraoqbHnObrSuJTTK
         j7Xg==
X-Gm-Message-State: AOJu0YyS8ryGJKVPJXloJqn6pvEEb38pM2tTpfZMoIICzHsofIcehSWv
	GBU0g01dTDgoVY86/4Ab0Gl53byyzhvOx/hPKIFZFvvKqHi656HA
X-Google-Smtp-Source: AGHT+IEoTzzZ11Snmk0w5e03CmWrdSYU5OewEBM5Kxnuipd4rpO3o/JfJiRy9wRzK/Ce5SpFa0fUwA==
X-Received: by 2002:ac8:5902:0:b0:42a:b108:2bfc with SMTP id 2-20020ac85902000000b0042ab1082bfcmr1410819qty.96.1706570717326;
        Mon, 29 Jan 2024 15:25:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWqhd/Xr8rRhpUqIY/vIhZLE8JGCZDnYQcetZlKsBAw+ZifdHNrrGHxz2cMivqKt+YsaUUr/aHbUSEcSFfFHdR6lnIxDatbtnrbLlBrnnbIj59WIY7cT1PLmpqCHeGK2LH6Z1oTMxzm+dRmJZaQLfW1tIi3X7oURYVxDciyv+BdnzGaPY8mWxBF1NwS9sHAHwpfYCjAdPzeNHMfcUpyJjm5+A1nVfVPOxBRiKRtEmNj8moaOySDJnDu8PPrzA6gb1iZHlSYO6MeFmeEKBEWZmwdNUP3DRLudEtVVMPeHL6h5lzdVXKfr/EAYtHlFW6TVymZH3vB+NMCqzZN1rIVR4Z+p8H9C7goSoS4nMQetpjFW6MLzBzAjZJDSKtFdsWWEPrtHmeEocAcQtCwTYlOHoDwDxdIugQ=
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j24-20020ac85518000000b0042a86e06fdfsm3376480qtq.37.2024.01.29.15.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:25:16 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 8CE7627C005B;
	Mon, 29 Jan 2024 18:25:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 18:25:16 -0500
X-ME-Sender: <xms:3DO4ZZn6VnMGOnQP6RjFiVGSLc2dt0FaiSjnc6IgC0Rk_3ibMHkoSA>
    <xme:3DO4ZU1FMDwOvUYXXrcAASDs-EfhuwbQmXqRCFlBGS_yi4WgqonomlMASkqh0V6XR
    NhFPipTiA5acBJSnw>
X-ME-Received: <xmr:3DO4ZfoHLZ-RoMPfZnJAyXEAv6uu12-R4cr59hywid-u37Abnh31KZqgywVMNw>
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
X-ME-Proxy: <xmx:3DO4ZZltsqZrd_H8Jh5cTFt4ym1dYvLVKj6VWXhIcbfvagPifm5B6w>
    <xmx:3DO4ZX3kvzsZBN4YRiskIM9CwEyGlS6fdoHBhik55EOyEtxnUHeyfw>
    <xmx:3DO4ZYszH2IYBE7P9YHta6F-8GcuoWaPx5Ax7e3xYSoc1iOxE7KJlg>
    <xmx:3DO4ZVM9LrYq3FC4IKRPNcKAoIYtqrUdwzUOS_eJZ2cbuYrAOResqQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:25:15 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 3/8] rcu/exp: Handle RCU expedited grace period kworker allocation failure
Date: Mon, 29 Jan 2024 15:23:41 -0800
Message-ID: <20240129232349.3170819-4-boqun.feng@gmail.com>
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

Just like is done for the kworker performing nodes initialization,
gracefully handle the possible allocation failure of the RCU expedited
grace period main kworker.

While at it perform a rename of the related checking functions to better
reflect the expedited specifics.

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>
Fixes: 9621fbee44df ("rcu: Move expedited grace period (GP) work to RT kthread_worker")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c     |  2 ++
 kernel/rcu/tree_exp.h | 25 +++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 38c86f2c040b..f2c10d351b59 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4743,6 +4743,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 	rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
 	if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
 		pr_err("Failed to create %s!\n", gp_kworker_name);
+		rcu_exp_gp_kworker = NULL;
 		return;
 	}
 
@@ -4751,6 +4752,7 @@ static void __init rcu_start_exp_gp_kworkers(void)
 		pr_err("Failed to create %s!\n", par_gp_kworker_name);
 		rcu_exp_par_gp_kworker = NULL;
 		kthread_destroy_worker(rcu_exp_gp_kworker);
+		rcu_exp_gp_kworker = NULL;
 		return;
 	}
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 014ddf672165..6123a60d9a4d 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -427,7 +427,12 @@ static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
 	__sync_rcu_exp_select_node_cpus(rewp);
 }
 
-static inline bool rcu_gp_par_worker_started(void)
+static inline bool rcu_exp_worker_started(void)
+{
+	return !!READ_ONCE(rcu_exp_gp_kworker);
+}
+
+static inline bool rcu_exp_par_worker_started(void)
 {
 	return !!READ_ONCE(rcu_exp_par_gp_kworker);
 }
@@ -477,7 +482,12 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	__sync_rcu_exp_select_node_cpus(rewp);
 }
 
-static inline bool rcu_gp_par_worker_started(void)
+static inline bool rcu_exp_worker_started(void)
+{
+	return !!READ_ONCE(rcu_gp_wq);
+}
+
+static inline bool rcu_exp_par_worker_started(void)
 {
 	return !!READ_ONCE(rcu_par_gp_wq);
 }
@@ -540,7 +550,7 @@ static void sync_rcu_exp_select_cpus(void)
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
-		if (!rcu_gp_par_worker_started() ||
+		if (!rcu_exp_par_worker_started() ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
 		    rcu_is_last_leaf_node(rnp)) {
 			/* No worker started yet or last leaf, do direct call. */
@@ -955,7 +965,7 @@ static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
  */
 void synchronize_rcu_expedited(void)
 {
-	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
+	bool use_worker;
 	unsigned long flags;
 	struct rcu_exp_work rew;
 	struct rcu_node *rnp;
@@ -966,6 +976,9 @@ void synchronize_rcu_expedited(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu_expedited() in RCU read-side critical section");
 
+	use_worker = (rcu_scheduler_active != RCU_SCHEDULER_INIT) &&
+		      rcu_exp_worker_started();
+
 	/* Is the state is such that the call is a grace period? */
 	if (rcu_blocking_is_gp()) {
 		// Note well that this code runs with !PREEMPT && !SMP.
@@ -995,7 +1008,7 @@ void synchronize_rcu_expedited(void)
 		return;  /* Someone else did our work for us. */
 
 	/* Ensure that load happens before action based on it. */
-	if (unlikely(boottime)) {
+	if (unlikely(!use_worker)) {
 		/* Direct call during scheduler init and early_initcalls(). */
 		rcu_exp_sel_wait_wake(s);
 	} else {
@@ -1013,7 +1026,7 @@ void synchronize_rcu_expedited(void)
 	/* Let the next expedited grace period start. */
 	mutex_unlock(&rcu_state.exp_mutex);
 
-	if (likely(!boottime))
+	if (likely(use_worker))
 		synchronize_rcu_expedited_destroy_work(&rew);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-- 
2.43.0


