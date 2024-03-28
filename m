Return-Path: <linux-kernel+bounces-122538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D1C88F925
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43701C25989
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B705FB99;
	Thu, 28 Mar 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+vPaUDi"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7305FB89;
	Thu, 28 Mar 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612281; cv=none; b=LqSxlIgXdPBVJ2hyWzTwBXHiO9hMZqOf1m0WHFfWYzx/csAPNqrajjPVMYq/MrWpPR+MByvuhcEWke/hhQw7BIOhOWhUOxF99YUh3ZtU2gGIi2VKTATlV18wfNPh+K/QtIe8mFEPY7Qr+LgfYjPKmAe3MF2Rz14vB1uKEzFepo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612281; c=relaxed/simple;
	bh=e2O4iV9sJsNP5W8dr/Q+G/8c4Lr9bkbWeoqiWsoecC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PhBXAgxynvfC4YR96B4Kk4qLg5QlYmBtbEuXdAFY9X9F2j46KZo7KtYn0tepT5m3pWHqSlGMxVkDx1r5APl7533//b3t4zQ9JEQ1fbzFxz8WcMH4Sc7muVJFvphOxyklu2fXRxGKIjbkKTCOhRTIPnrvoSIVP9WQfA0+b7WcBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+vPaUDi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6b5432439so633865b3a.1;
        Thu, 28 Mar 2024 00:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612279; x=1712217079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGirO6AjDMqe2sVAIHTJAIXsudaabgHkxaTMsIO4NV8=;
        b=c+vPaUDi+VTlvTWYMvruQJn+2q4IYplPBkTpJq4S+p0whW2vWO+kQ5r4lFhdfZ5Xf2
         59C1iuXy5ovTJ3O/HpnSNkAnrJhaLF1vmUaui4D5GbfJncoC9TggNPz7WaekzgWEu9U5
         OGnaLOLUri+/LFEzMkqNudTQ9szc53dMdwtgFsSGGP25iX+F2PBtJize5rKGw0cn0I3Z
         NmdmYAWyiZCVgr6/+cWAXzWAEGERgz/mREZvddfeAXb9lKDyjihgaH6SD0lFaa/XqaoO
         KQ9pyrj0yg+aGkwSNl1lIc1ZXFhP7Gx813RyuAp7ctw6ai95LGi47ybTN+KBBSfSSrBZ
         lGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612279; x=1712217079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGirO6AjDMqe2sVAIHTJAIXsudaabgHkxaTMsIO4NV8=;
        b=NDnDEwuy1has6ql6qjjmFT+uglQQWVI32oCQrZzH/2eh3xXGlEhnICtiMPZbJNUpyh
         5x6TSxThEBjvwFDGUJBHd1JDvn2IMd4+o4cbqRYBc2+6a55Gwfirsj5EhZ6aQVLpR+Zw
         x7wLGUmAm8TUbfSadhlwURut/YW/6E6E2QYhvvZP2SWL5k2fvWgkZkUmChqFDL02PBQt
         wZQeUNK7XUxQOvyjWgLv+go3WYh5IqA/AY/vUunHftwOaxjr6mEb5xLtZ2fgJd3/9cWT
         W/K+b5QC4HLIvyEkYS16DkwA1xDkpiFzGvghotxfBuQqK7LYeX2C0SA/XXUcvCXE7mzR
         95ow==
X-Gm-Message-State: AOJu0YwOSuGdFFG4HyqtN/O2vlm1zt/TED8EGlDgWPs8aOZgi7t2PuD9
	z4oxo6E9oL79aG95+RC4u1ITz2x1QifmA3Z5aLFi43EEkb20+LhsWtT5CqoW
X-Google-Smtp-Source: AGHT+IG1e0Su/WUp6fMVEFwpsiDpgQVWG/zovyoLs1TQAfdSlcIQWafNpLlbpYUzDm1mm7e7t5ivfg==
X-Received: by 2002:aa7:8889:0:b0:6e7:48ef:aeca with SMTP id z9-20020aa78889000000b006e748efaecamr2351976pfe.9.1711612279071;
        Thu, 28 Mar 2024 00:51:19 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id g18-20020a62e312000000b006eadf4c2b67sm71991pfh.92.2024.03.28.00.51.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:51:18 -0700 (PDT)
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
Subject: [PATCH 08/10] rcu: Implement PCPU_RCU_PREEMPT_COUNT framework
Date: Thu, 28 Mar 2024 15:53:16 +0800
Message-Id: <20240328075318.83039-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240328075318.83039-1-jiangshanlai@gmail.com>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

When the arch code provides HAVE_PCPU_RCU_PREEMPT_COUNT and the
corresponding functions, rcu_preempt core uses the functions to
implement rcu_read_[un]lock, rcu_preempt_depth(), special bits,
switching and so on.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 include/linux/rcupdate.h | 33 +++++++++++++++++++++++++++++++++
 kernel/rcu/Kconfig       |  8 ++++++++
 kernel/rcu/rcu.h         |  4 ++++
 kernel/rcu/tree_plugin.h |  8 ++++++++
 4 files changed, 53 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index cc77d76a870b..bf369741ef93 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -70,6 +70,8 @@ static inline bool same_state_synchronize_rcu(unsigned long oldstate1, unsigned
 
 void rcu_read_unlock_special(void);
 
+#ifndef CONFIG_PCPU_RCU_PREEMPT_COUNT
+
 void __rcu_read_lock(void);
 void __rcu_read_unlock(void);
 
@@ -81,6 +83,37 @@ void __rcu_read_unlock(void);
  */
 #define rcu_preempt_depth() READ_ONCE(current->rcu_read_lock_nesting)
 #define rcu_preempt_depth_set(val) WRITE_ONCE(current->rcu_read_lock_nesting, (val))
+#define pcpu_rcu_preempt_special_set() do { } while (0)
+#define pcpu_rcu_preempt_special_clear() do { } while (0)
+
+#else /* #ifndef CONFIG_PCPU_RCU_PREEMPT_COUNT */
+
+#include <asm/rcu_preempt.h>
+
+static __always_inline void __rcu_read_lock(void)
+{
+	pcpu_rcu_preempt_count_add(1);
+	barrier();
+}
+
+static __always_inline void __rcu_read_unlock(void)
+{
+	barrier();
+	if (unlikely(pcpu_rcu_preempt_count_dec_and_test()))
+		pcpu_rcu_read_unlock_special();
+}
+
+static inline int rcu_preempt_depth(void)
+{
+	return pcpu_rcu_preempt_count();
+}
+
+static inline void rcu_preempt_depth_set(int val)
+{
+	pcpu_rcu_preempt_count_set(val);
+}
+
+#endif /* #else #ifndef CONFIG_PCPU_RCU_PREEMPT_COUNT */
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index e7d2dd267593..5d91147bc9a3 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -345,4 +345,12 @@ config RCU_DOUBLE_CHECK_CB_TIME
 	  Say Y here if you need tighter callback-limit enforcement.
 	  Say N here if you are unsure.
 
+config HAVE_PCPU_RCU_PREEMPT_COUNT
+	bool
+
+config PCPU_RCU_PREEMPT_COUNT
+	def_bool y
+	depends on PREEMPT_RCU && HAVE_PCPU_RCU_PREEMPT_COUNT
+	depends on !PROVE_LOCKING && !RCU_STRICT_GRACE_PERIOD
+
 endmenu # "RCU Subsystem"
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index ea5ae957c687..2322b040c5cd 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -671,6 +671,10 @@ static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { re
 static inline void
 rcu_preempt_switch(struct task_struct *prev, struct task_struct *next)
 {
+#ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
+	prev->rcu_read_lock_nesting = rcu_preempt_depth();
+	pcpu_rcu_preempt_switch(next->rcu_read_lock_nesting, next->rcu_read_unlock_special.s);
+#endif // #ifdef CONFIG_PCPU_RCU_PREEMPT_COUNT
 }
 
 #endif /* __KERNEL_RCU_H */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 880b3fef1158..db68d0c1c1f2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -107,10 +107,13 @@ static bool sync_rcu_exp_done(struct rcu_node *rnp);
 
 #define set_rcu_preempt_special(reason)	do {				\
 	WRITE_ONCE(current->rcu_read_unlock_special.b.reason, true);	\
+	pcpu_rcu_preempt_special_set();					\
 	} while (0)
 
 #define clear_rcu_preempt_special(reason)	do {			\
 	WRITE_ONCE(current->rcu_read_unlock_special.b.reason, false);	\
+	if (!current->rcu_read_unlock_special.s)			\
+		pcpu_rcu_preempt_special_clear();			\
 	} while (0)
 
 /*
@@ -379,6 +382,8 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 	return READ_ONCE(rnp->gp_tasks) != NULL;
 }
 
+#ifndef CONFIG_PCPU_RCU_PREEMPT_COUNT
+
 /* limit value for ->rcu_read_lock_nesting. */
 #define RCU_NEST_PMAX (INT_MAX / 2)
 
@@ -436,6 +441,8 @@ void __rcu_read_unlock(void)
 }
 EXPORT_SYMBOL_GPL(__rcu_read_unlock);
 
+#endif /* #ifndef CONFIG_PCPU_RCU_PREEMPT_COUNT */
+
 /*
  * Advance a ->blkd_tasks-list pointer to the next entry, instead
  * returning NULL if at the end of the list.
@@ -489,6 +496,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		return;
 	}
 	t->rcu_read_unlock_special.s = 0;
+	pcpu_rcu_preempt_special_clear();
 	if (special.b.need_qs) {
 		if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)) {
 			rdp->cpu_no_qs.b.norm = false;
-- 
2.19.1.6.gb485710b


