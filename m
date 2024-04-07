Return-Path: <linux-kernel+bounces-134279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B2C89AFE4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9996128350E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B87288DF;
	Sun,  7 Apr 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhGNgTCr"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B72D25622;
	Sun,  7 Apr 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480627; cv=none; b=TDnjuH02AUdFC5tKYlTYJYa0urBsEo2mXVcKPTo4uk+mO8GGMbKoZPQp9n/VZgNGJgakBCMZH1Ncxq1p9ad86RwkVXz/y9dbgFpshNlMbilBG0xNxMQOQzxQqtKu3CR7qdaVHjizt6CT+XyexnMjywCMkX1UHJMea44IZUEgKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480627; c=relaxed/simple;
	bh=dyDjW0emqk3ra0mcQ2J2Pyvf/leGXIhR8J75jqjVAuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RYpxy59x7vnRh12VRko9ZRi3DtasRv1xzErjcvdyfkdTjfyqv4cMqS29FWokC4LmwErjdlskf1vz7WlKF6rxGWwIc67G/LrKoq6RIULSTIUchNjEb+sd9No/T+DQjmI9+ANZ5e2+hS0wPxzNPl6UdQtOH0B16pE6RM6ePnw1xcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhGNgTCr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e2bbc2048eso28539385ad.3;
        Sun, 07 Apr 2024 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480624; x=1713085424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvoBd6HF4JbE2BHoe97A/COYGhUtV93EmRmWHbLWiDc=;
        b=NhGNgTCrnINYBIH9NlRJR8YRRDYyek45I4AfQ7DClp/s/RrBv18TJP9YfyVC0ClX4v
         gs+cXXzubLLRdR5dbZl+nbQbhyV//Ai9RgujZAoSSFnwZavCjfdP41KOYWrPkmY5zEkN
         pMsK4oA7AaNa4A+pNcGWhz0YXj1PcAIuaE7uYBlisATUPqtkBQI6JBVZQwdLx16/9vGG
         4yTcezCaTy6LXX8QMnpyjJS/T14V02iof9KMGo5/p/N0zMWd5vjdsP6L56C5JS9iJ+PB
         QPzH2vrbEARyMmYnDOdI+9rgq69/Y5D6bm8ANZk3qHTi781XuyRbVcs8aJk/5QC9UtiZ
         I6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480624; x=1713085424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvoBd6HF4JbE2BHoe97A/COYGhUtV93EmRmWHbLWiDc=;
        b=YYveQfB4+3zC6bz7iraBzIYJKF1VeCew5tVzaCZDOfHAP0RU8Ak0/lRGv0YVPfV8TA
         cod14T0kfJeh8dSWuIvvTQpVvZ0/XWlErQPISOFXSCu+w1kByeBQPr3lIqy8d/8bnZGa
         Ocwf2KgmI5sIYC4FkEDZMCXavOQxhTxTqKoZBgicWSZz+/eJZRvcMyePYeRk2eZxp5SO
         0RAz0+nrpDziXqWa5voY+HFgD1Chl81rG/zjRWsmQCSR3VvTBRQeP0gKYHmQViJ1sop4
         63Yx9p6R/PWxeetJvMY+RkQE2dXyrU1RsyTSFDzca4TN98PTzebhkCMu1bzoFluffQrV
         ypRA==
X-Gm-Message-State: AOJu0YzVR3rn/EKNdyc6ICViBuMarVsDj94PoMQ0/oNtSqtWbAT0Ano7
	e62kFlWqE5sXEdmoQJNngu7ckl25XTPIT8xyMeh0PufUO3inXtk3XHcxmwJH
X-Google-Smtp-Source: AGHT+IHm+MSwmnlLu34S3eEMB6KiFa2TY5nq3L1NGeIEDXeLzqfKCXuvVHVNTMQDGC2xidm4Is6oaw==
X-Received: by 2002:a17:902:ac86:b0:1e2:aa07:37d7 with SMTP id h6-20020a170902ac8600b001e2aa0737d7mr5210462plr.22.1712480624566;
        Sun, 07 Apr 2024 02:03:44 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170903138300b001d9a91af8a4sm4565578plb.28.2024.04.07.02.03.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:03:44 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH V2 04/11] rcu: Add macros set_rcu_preempt_special() and clear_rcu_preempt_special()
Date: Sun,  7 Apr 2024 17:05:51 +0800
Message-Id: <20240407090558.3395-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240407090558.3395-1-jiangshanlai@gmail.com>
References: <20240407090558.3395-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Add wrappers accessing to t->rcu_read_unlock_special.b so that the
wrappers can be adapted for synching the value with the later-introduced
per-cpu rcu_preempt_count.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/rcu/tree_exp.h    |  2 +-
 kernel/rcu/tree_plugin.h | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6b83537480b1..4e91414552e6 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -725,7 +725,7 @@ static void rcu_exp_handler(void *unused)
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
 			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
-			t->rcu_read_unlock_special.b.exp_hint = true;
+			set_rcu_preempt_special(exp_hint);
 		}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d899b4afc21c..3dbd5609185e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -106,6 +106,14 @@ static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
 static bool sync_rcu_exp_done(struct rcu_node *rnp);
 static void rcu_read_unlock_special(struct task_struct *t);
 
+#define set_rcu_preempt_special(reason)	do {				\
+	WRITE_ONCE(current->rcu_read_unlock_special.b.reason, true);	\
+	} while (0)
+
+#define clear_rcu_preempt_special(reason)	do {			\
+	WRITE_ONCE(current->rcu_read_unlock_special.b.reason, false);	\
+	} while (0)
+
 /*
  * Tell them what RCU they are running.
  */
@@ -293,7 +301,7 @@ static void rcu_qs(void)
 				       TPS("cpuqs"));
 		__this_cpu_write(rcu_data.cpu_no_qs.b.norm, false);
 		barrier(); /* Coordinate with rcu_flavor_sched_clock_irq(). */
-		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, false);
+		clear_rcu_preempt_special(need_qs);
 	}
 }
 
@@ -325,7 +333,7 @@ void rcu_note_context_switch(bool preempt)
 		/* Possibly blocking in an RCU read-side critical section. */
 		rnp = rdp->mynode;
 		raw_spin_lock_rcu_node(rnp);
-		t->rcu_read_unlock_special.b.blocked = true;
+		set_rcu_preempt_special(blocked);
 		t->rcu_blocked_node = rnp;
 
 		/*
@@ -399,7 +407,7 @@ void __rcu_read_lock(void)
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 		WARN_ON_ONCE(rcu_preempt_depth() > RCU_NEST_PMAX);
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) && rcu_state.gp_kthread)
-		WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
+		set_rcu_preempt_special(need_qs);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
@@ -738,7 +746,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.norm) &&
 	    !t->rcu_read_unlock_special.b.need_qs &&
 	    time_after(jiffies, rcu_state.gp_start + HZ))
-		t->rcu_read_unlock_special.b.need_qs = true;
+		set_rcu_preempt_special(need_qs);
 }
 
 /*
@@ -751,12 +759,10 @@ static void rcu_flavor_sched_clock_irq(int user)
  */
 void exit_rcu(void)
 {
-	struct task_struct *t = current;
-
 	if (unlikely(!list_empty(&current->rcu_node_entry))) {
 		rcu_preempt_depth_set(1);
 		barrier();
-		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);
+		set_rcu_preempt_special(blocked);
 	} else if (unlikely(rcu_preempt_depth())) {
 		rcu_preempt_depth_set(1);
 	} else {
-- 
2.19.1.6.gb485710b


