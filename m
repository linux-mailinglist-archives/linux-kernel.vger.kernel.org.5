Return-Path: <linux-kernel+bounces-105884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECB587E5E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEBB1F2188B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0962D054;
	Mon, 18 Mar 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6NJXgkW"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31462D022;
	Mon, 18 Mar 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754468; cv=none; b=DPoxfDtB/wS747PpmY/1ZDuX0XksWVEHee5N9V8LShCQNSySXZl3i7ZO5TNlpg2op1PnLTo//zITspyNbbsmqbw+6ir1qq30S701UJ+2Emp92+oMH8B5muA661/ZjDXfSVz7WtFRBCGmkw96iNNCt10l7BpVdvkEwsLjKhhkGXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754468; c=relaxed/simple;
	bh=8K76Y1nOykEYBbcDFrrf2xkZA+3pZpmn1GkZqUJHiJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QQwIYs8BEsdodd06bvfwI/bi0hNuV4qX2GZZfPF0AgveEIQBlKuPJzvJZX2ufcMwqZ4Axm6mKRPpElMugetrtnpQ7OFbGbFdwAT2JLhN0sp92isTvR08LXezPD5IudDEDUjgtQcH03XcPZg4aT4rgVLdFD/Sal90c5Cq8zZpE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6NJXgkW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so2854875a12.0;
        Mon, 18 Mar 2024 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710754466; x=1711359266; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ztj7Dl987XzwupqZJchiGlU7ZS3B4olQCny7lzSvlu8=;
        b=I6NJXgkWE4s63R+bHQCzv72yPdeqGFJROXLJZsYJjPQqSu+GNq9CsUDC2PMyQkjw39
         ssjiMua76W9vY4ri4n888pE8Ye1Rz/Cc0ejNYOBdQosSSxu7RvAhFWlMMX+CCI4PxCWm
         gK57fQBQpArKVHtM1pqxeTiSJrjM+TA3xUO7KZbySlMJWlaDGRIz+xdpYMz0xNe3bElP
         Sy0ohmOlMQyf9qrCWXEARE5wLPYtqmJeQbinsouQN2DzlU9Atl4CuS8kggVmJLQeE9Rh
         RuphEdyoOaP5+gsKoLQKSb3CXKiuyz4ldnMTuPCEWahDxPyQYvIOSOWGEicUCRxb3WBe
         Qpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710754466; x=1711359266;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ztj7Dl987XzwupqZJchiGlU7ZS3B4olQCny7lzSvlu8=;
        b=qhPepy9MQq2sVgWk34d1S8DxlDK2urFhOIMdYQOVhbO0ahqCVymJZzD90Hf13nMrz9
         muMbOcIZ/x427i3SUHY7TIGVH5ZvEvQhUJ6xqld9rIBNoCS0zcAwBLqccVdDs/2jIYTT
         Gw6hD3SB+GvBR6p2aD2jJDyiEaa0/2LmQXdcTRFwlMY8eSZaRIE5tJzqi/EI7IlgOUgR
         tOv7PHyOYlgN4Vns0FlRVfPJjaG83hAYIJQpFoX0nuNDE1NyMk8ML0lyi5m9U+yTz/z5
         Dr8TqcZ8AGT1g1vquARkeclNkd9+N74s2R8t02P2hPmsWRhtHwQk5+fNDsij5uaqa6xJ
         ve6w==
X-Forwarded-Encrypted: i=1; AJvYcCVajloYI1QWNR/ypQgtsgKIgNHdTW38RXfxQ2eGiOvTk121AJbdbsmGaXc8vppsXhICJH1/2PxUGREcncA7BclhKYxk54MC47ULNYfWdFZAjv6GidjChtbwVPsSRzyGPSV1
X-Gm-Message-State: AOJu0Yz/JPG7Af0UfVjfttMLgvTLcnzsgK6YaUOzMi91cbNWpZvvRCrc
	yEUCJvSi84pIpa0L9HXQgKFRF1Vx8DbZ5rZOh0D+cbRMSkHOxVv6
X-Google-Smtp-Source: AGHT+IHWonSTN3XZjhoTPZt6x55tUC8G0o6QtQrZ3yd8pw8AsRnolzZBsa18mIEBKs++pdoSftdZTw==
X-Received: by 2002:a05:6a20:1453:b0:1a3:5494:d5a8 with SMTP id a19-20020a056a20145300b001a35494d5a8mr5503142pzi.13.1710754465986;
        Mon, 18 Mar 2024 02:34:25 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001def777afc5sm5828025plg.77.2024.03.18.02.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:34:25 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] rcutorture: Make rcutorture support print rcu-tasks gp state
Date: Mon, 18 Mar 2024 17:34:11 +0800
Message-Id: <20240318093412.17258-2-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240318093412.17258-1-qiang.zhang1211@gmail.com>
References: <20240318093412.17258-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This commit make rcu-tasks related rcutorture test support rcu-tasks
gp state printing when the writer stall occurs or the at the end of
rcutorture test, and generate rcu_ops->get_gp_data() operation to
simplify the acquisition of gp state for different types of rcutorture
tests.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcu.h        | 20 ++++++++++----------
 kernel/rcu/rcutorture.c | 26 ++++++++++++++++++--------
 kernel/rcu/srcutree.c   |  5 +----
 kernel/rcu/tasks.h      | 21 +++++++++++++++++++++
 kernel/rcu/tree.c       | 13 +++----------
 5 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 86fce206560e..38238e595a61 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -522,12 +522,18 @@ static inline void show_rcu_tasks_gp_kthreads(void) {}
 
 #ifdef CONFIG_TASKS_RCU
 struct task_struct *get_rcu_tasks_gp_kthread(void);
+void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq);
 #endif // # ifdef CONFIG_TASKS_RCU
 
 #ifdef CONFIG_TASKS_RUDE_RCU
 struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
+void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq);
 #endif // # ifdef CONFIG_TASKS_RUDE_RCU
 
+#ifdef CONFIG_TASKS_TRACE_RCU
+void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
+#endif
+
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void tasks_cblist_init_generic(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
@@ -557,8 +563,7 @@ static inline void rcu_set_jiffies_lazy_flush(unsigned long j) { }
 #endif
 
 #if defined(CONFIG_TREE_RCU)
-void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
-			    unsigned long *gp_seq);
+void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq);
 void do_trace_rcu_torture_read(const char *rcutorturename,
 			       struct rcu_head *rhp,
 			       unsigned long secs,
@@ -566,8 +571,7 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
 			       unsigned long c);
 void rcu_gp_set_torture_wait(int duration);
 #else
-static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
-					  int *flags, unsigned long *gp_seq)
+static inline void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
 	*flags = 0;
 	*gp_seq = 0;
@@ -587,20 +591,16 @@ static inline void rcu_gp_set_torture_wait(int duration) { }
 
 #ifdef CONFIG_TINY_SRCU
 
-static inline void srcutorture_get_gp_data(enum rcutorture_type test_type,
-					   struct srcu_struct *sp, int *flags,
+static inline void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 					   unsigned long *gp_seq)
 {
-	if (test_type != SRCU_FLAVOR)
-		return;
 	*flags = 0;
 	*gp_seq = sp->srcu_idx;
 }
 
 #elif defined(CONFIG_TREE_SRCU)
 
-void srcutorture_get_gp_data(enum rcutorture_type test_type,
-			     struct srcu_struct *sp, int *flags,
+void srcutorture_get_gp_data(struct srcu_struct *sp, int *flags,
 			     unsigned long *gp_seq);
 
 #endif
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2f43d31fb7a5..85ff8a32f75a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -381,6 +381,7 @@ struct rcu_torture_ops {
 	void (*gp_kthread_dbg)(void);
 	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
 	int (*stall_dur)(void);
+	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
 	long cbflood_max;
 	int irq_capable;
 	int can_boost;
@@ -569,6 +570,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.gp_kthread_dbg		= show_rcu_gp_kthreads,
 	.check_boost_failed	= rcu_check_boost_fail,
 	.stall_dur		= rcu_jiffies_till_stall_check,
+	.get_gp_data		= rcutorture_get_gp_data,
 	.irq_capable		= 1,
 	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
 	.extendables		= RCUTORTURE_MAX_EXTEND,
@@ -628,6 +630,11 @@ static struct srcu_struct srcu_ctld;
 static struct srcu_struct *srcu_ctlp = &srcu_ctl;
 static struct rcu_torture_ops srcud_ops;
 
+static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	srcutorture_get_gp_data(srcu_ctlp, flags, gp_seq);
+}
+
 static int srcu_torture_read_lock(void)
 {
 	if (cur_ops == &srcud_ops)
@@ -736,6 +743,7 @@ static struct rcu_torture_ops srcu_ops = {
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
+	.get_gp_data	= srcu_get_gp_data,
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
@@ -774,6 +782,7 @@ static struct rcu_torture_ops srcud_ops = {
 	.call		= srcu_torture_call,
 	.cb_barrier	= srcu_torture_barrier,
 	.stats		= srcu_torture_stats,
+	.get_gp_data	= srcu_get_gp_data,
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.no_pi_lock	= IS_ENABLED(CONFIG_TINY_SRCU),
@@ -882,6 +891,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.call		= call_rcu_tasks,
 	.cb_barrier	= rcu_barrier_tasks,
 	.gp_kthread_dbg	= show_rcu_tasks_classic_gp_kthread,
+	.get_gp_data	= rcu_tasks_get_gp_data,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -922,6 +932,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.call		= call_rcu_tasks_rude,
 	.cb_barrier	= rcu_barrier_tasks_rude,
 	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
+	.get_gp_data	= rcu_tasks_rude_get_gp_data,
 	.cbflood_max	= 50000,
 	.fqs		= NULL,
 	.stats		= NULL,
@@ -974,6 +985,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
 	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
+	.get_gp_data    = rcu_tasks_trace_get_gp_data,
 	.cbflood_max	= 50000,
 	.fqs		= NULL,
 	.stats		= NULL,
@@ -2264,10 +2276,8 @@ rcu_torture_stats_print(void)
 		int __maybe_unused flags = 0;
 		unsigned long __maybe_unused gp_seq = 0;
 
-		rcutorture_get_gp_data(cur_ops->ttype,
-				       &flags, &gp_seq);
-		srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
-					&flags, &gp_seq);
+		if (cur_ops->get_gp_data)
+			cur_ops->get_gp_data(&flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
 		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
 			 rcu_torture_writer_state_getname(),
@@ -3390,8 +3400,8 @@ rcu_torture_cleanup(void)
 		fakewriter_tasks = NULL;
 	}
 
-	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
-	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	if (cur_ops->get_gp_data)
+		cur_ops->get_gp_data(&flags, &gp_seq);
 	pr_alert("%s:  End-test grace-period state: g%ld f%#x total-gps=%ld\n",
 		 cur_ops->name, (long)gp_seq, flags,
 		 rcutorture_seq_diff(gp_seq, start_gp_seq));
@@ -3762,8 +3772,8 @@ rcu_torture_init(void)
 			nrealreaders = 1;
 	}
 	rcu_torture_print_module_parms(cur_ops, "Start of test");
-	rcutorture_get_gp_data(cur_ops->ttype, &flags, &gp_seq);
-	srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp, &flags, &gp_seq);
+	if (cur_ops->get_gp_data)
+		cur_ops->get_gp_data(&flags, &gp_seq);
 	start_gp_seq = gp_seq;
 	pr_alert("%s:  Start-test grace-period state: g%ld f%#x\n",
 		 cur_ops->name, (long)gp_seq, flags);
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d19326486edd..98f79ba01b0a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1828,12 +1828,9 @@ static void process_srcu(struct work_struct *work)
 	srcu_reschedule(ssp, curdelay);
 }
 
-void srcutorture_get_gp_data(enum rcutorture_type test_type,
-			     struct srcu_struct *ssp, int *flags,
+void srcutorture_get_gp_data(struct srcu_struct *ssp, int *flags,
 			     unsigned long *gp_seq)
 {
-	if (test_type != SRCU_FLAVOR)
-		return;
 	*flags = 0;
 	*gp_seq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
 }
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e83adcdb49b5..e7ac9138a4fd 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1182,6 +1182,13 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
 
+void rcu_tasks_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	*flags = 0;
+	*gp_seq = rcu_seq_current(&rcu_tasks.tasks_gp_seq);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_get_gp_data);
+
 /*
  * Protect against tasklist scan blind spot while the task is exiting and
  * may be removed from the tasklist.  Do this by adding the task to yet
@@ -1361,6 +1368,13 @@ struct task_struct *get_rcu_tasks_rude_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_rude_gp_kthread);
 
+void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	*flags = 0;
+	*gp_seq = rcu_seq_current(&rcu_tasks_rude.tasks_gp_seq);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
+
 #endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
@@ -2020,6 +2034,13 @@ struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
 
+void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq)
+{
+	*flags = 0;
+	*gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
+}
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_get_gp_data);
+
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9fbb5ab57c84..e229a12afe31 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -539,17 +539,10 @@ static struct rcu_node *rcu_get_root(void)
 /*
  * Send along grace-period-related data for rcutorture diagnostics.
  */
-void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
-			    unsigned long *gp_seq)
+void rcutorture_get_gp_data(int *flags, unsigned long *gp_seq)
 {
-	switch (test_type) {
-	case RCU_FLAVOR:
-		*flags = READ_ONCE(rcu_state.gp_flags);
-		*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
-		break;
-	default:
-		break;
-	}
+	*flags = READ_ONCE(rcu_state.gp_flags);
+	*gp_seq = rcu_seq_current(&rcu_state.gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 
-- 
2.17.1


