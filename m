Return-Path: <linux-kernel+bounces-134285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE089AFEC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC73CB216CD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB482381AC;
	Sun,  7 Apr 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3BOo+Gs"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6DF376E4;
	Sun,  7 Apr 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480650; cv=none; b=GP4whrBO2tvEo/wEhyfyADx38SQOmCkQPomc4aLxnhqiRGqD7rAThmGd0b/Nbs+qs94q+VRgp5KvUw79UZvZMLYhFuC+neT8FE3lmE25VsHRmL54SrlX6A8Zhx/dY3bQm1fKcrsBG+KH9BTRM7KZL3a8EEZNZcPFj4pmD1N7ykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480650; c=relaxed/simple;
	bh=SKi1Hw6pqGBhLR48UF2gLw2ljWBn/PhxuaBl95AwpXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9LFDxmv9djHLii7uImf8t6kscOqp3JSoYXqGJW8u4W09dYGXd9MYKPhSwOaIIN4Gr3Jtb7bvjwrCB0vJXOfyHXN8w9e4HpdrgvlujD3mDxlWwX3GRoue1KW2TgjpSfZJ4QKBUIYWaUpcZCFfbZxyth0pbE4tH7l2wAYE8fhuA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3BOo+Gs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e419d1f080so331525ad.1;
        Sun, 07 Apr 2024 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480647; x=1713085447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvmZr4F4KrE2SgRrk5vM9yP83Kb1iDKJQwNWlrc52tI=;
        b=V3BOo+Gs71UmD4/rCg29MqQgSf/Zh5ALCtL3yUh8JnWS17TaS8y3atqmhTLn+VjakX
         C2pPNwzVgMVKbhwOk7/JjNgxYnXBP6UKd7X+enZGZCv/qod0sESVNlJ9Cj0IxE3gUWmU
         xBg7NMyOhXLInOVjrS3HE1d0Sj+SAufDOjoNRe54sNYSkL87OFDYKGmyNQn4sOvrupTq
         zBSb75OVnjA8Xt80gG3WqoNjjYn7qHZ6oU27nwFK7eaI+/TeW9S1btUuwQ7e5P5QCjNJ
         uXhabc14UdXOJIqqFjdEj2lPrloiWm3YNX1nepIr+tcGW40ghmC4i55pxleg0DH0Ouk5
         Ui/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480647; x=1713085447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvmZr4F4KrE2SgRrk5vM9yP83Kb1iDKJQwNWlrc52tI=;
        b=e8nddDsO8sFu/nTv9uFZCIc+jgxDc24OBzUmLpIKZYDEekJR+fVL5pMR16eI3wqk+g
         qzW6lLTEsyYWlMXwV6KZeswRwij4O0cGjrgOm33ZZWN7+tduFeOECZw9NV4NsHJEKc+F
         8wAnauLXB1IeyNF1lfp8nuZwpvEOW9hMbygq9RSrWeswrCzdCKzcyzEqCIDvkBk3NlNL
         dIb+2fY3cwpKb/XR8khJTmiP/uuKW5ScHbegfKtatdO2lIK764/ubAZdD1XmSJZ6YUl/
         AeZXM2/dWsvEsQUJi1ilS+NWDEN1lgYEV5AbNtilgr0Tn8BbhJ5irp19NdnLO7IJPRbi
         9lJw==
X-Gm-Message-State: AOJu0YyH8IFt6Ah9mDnTGsLwf7C6cWcQteTtrVAbMr9keeF+L1P2qODH
	K5DZtx7dbUGb+u67eBHKCcZi6luBexRcciaOqCWjvez/xZWRVT9nKoXCxFzX
X-Google-Smtp-Source: AGHT+IGj1b4HAvBohPJYYhY/r/gbQG5Zn4YiBDo+LF5oMqonLV2JPcEw09TM6F1adDIHhvF8GCd35g==
X-Received: by 2002:a17:902:ce87:b0:1e2:c6ed:d1c with SMTP id f7-20020a170902ce8700b001e2c6ed0d1cmr5117315plg.42.1712480647622;
        Sun, 07 Apr 2024 02:04:07 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f54c00b001dd99fe365dsm4517205plf.42.2024.04.07.02.04.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:04:07 -0700 (PDT)
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
Subject: [PATCH V2 09/11] rcu: Implement PCPU_RCU_PREEMPT_COUNT framework
Date: Sun,  7 Apr 2024 17:05:56 +0800
Message-Id: <20240407090558.3395-10-jiangshanlai@gmail.com>
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

When the arch code provides HAVE_PCPU_RCU_PREEMPT_COUNT and the
corresponding functions, rcu core uses the functions to implement
rcu_preempt_depth(), special bits, switching and so on.

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
index 328667ae8086..e3e5ce44c7dc 100644
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


