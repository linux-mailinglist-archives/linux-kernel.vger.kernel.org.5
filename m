Return-Path: <linux-kernel+bounces-168058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7879F8BB332
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0650B1F224A7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1F31598FE;
	Fri,  3 May 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hYNnkDu/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h4PyCzf+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7872E157E6C;
	Fri,  3 May 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761012; cv=none; b=d0IsmYxi9fYvmyYRZToZ8QfjIcA7io7b0S14t/Nuca2tNjvRwJ5euatH0iyyE1KRFVbIhqZNhqCMBUl+QmrSvExLEMNTjWK8E/ipcTGrT4tdIwN87y/yyzkhdXOyHPrQeh9B+0wuCe53oucPwYHrUZHdCxeHkT0beDjfkhwIp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761012; c=relaxed/simple;
	bh=0ek9e1xkSu9ugJNGW/WQGFdfj6oRd6gAc/VlLaOX934=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLJV/s+adFwKlhYFN3kTZFwE31uarUHA7AquU12R017np2lETM6niw6jAmDhruEA0fquNhLnygCP+q5X3vL0NDt9KdGMXPkcYvNIImA1Z72k7f//sUECey/JQoNVwa8HYwVgA75hRwD/1gmBulQFErN1QV0BXGvinPERHSJl7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hYNnkDu/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h4PyCzf+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W12KgBST4nx2eve2nFTDwC2VpCtYmoeYSIe9gYf7jLU=;
	b=hYNnkDu/YEIkbMmlcXSrr3zUKVjI0lBbG6xwH8ZICrBAHKq2h9Y0QNnOvxQlhNvhwS7Cph
	lDweOre4LmCytwQLo0zojT6Bboy9yAl+try72DiqCSsZxTgat7elEodRt7Fp54b+qbaY8l
	TOWtuyBj5bLqis8pgaK0m4ZF4EXp9p3ra7V5nZOApqeP3V+wM/0/7r7nEN/GX5srHe7E6T
	u7jyg78ZGy4IOPNiJ5X2mqWZ1sYs57ZJk8cTMKGKymdxVrwt4Lem0YD9EBiznNQ6gREzHP
	c/6nY0QOXAXeoM4hrNCsQbLAED2yZHKUogV/kTnfguxeDEpqHxm8aByRMv9H+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W12KgBST4nx2eve2nFTDwC2VpCtYmoeYSIe9gYf7jLU=;
	b=h4PyCzf+pnGgWSsUNbwR4a3djIi273FCLgVuwKNb1yWnxRnZ4OU0CTPr6DranJvPH9o5cW
	WV4AeZ+T70BCCwCg==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH net-next 08/15] net: softnet_data: Make xmit.recursion per task.
Date: Fri,  3 May 2024 20:25:12 +0200
Message-ID: <20240503182957.1042122-9-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Softirq is preemptible on PREEMPT_RT. Without a per-CPU lock in
local_bh_disable() there is no guarantee that only one device is
transmitting at a time.
With preemption and multiple senders it is possible that the per-CPU
recursion counter gets incremented by different threads and exceeds
XMIT_RECURSION_LIMIT leading to a false positive recursion alert.

Instead of adding a lock to protect the per-CPU variable it is simpler
to make the counter per-task. Sending and receiving skbs happens always
in thread context anyway.

Having a lock to protected the per-CPU counter would block/ serialize two
sending threads needlessly. It would also require a recursive lock to
ensure that the owner can increment the counter further.

Make the recursion counter a task_struct member on PREEMPT_RT.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h | 11 +++++++++++
 include/linux/sched.h     |  4 +++-
 net/core/dev.h            | 20 ++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 41853424b41d7..c551ec235f9af 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3222,7 +3222,9 @@ struct softnet_data {
 #endif
 	/* written and read only by owning cpu: */
 	struct {
+#ifndef CONFIG_PREEMPT_RT
 		u16 recursion;
+#endif
 		u8  more;
 #ifdef CONFIG_NET_EGRESS
 		u8  skip_txqueue;
@@ -3255,10 +3257,19 @@ struct softnet_data {
=20
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
=20
+#ifdef CONFIG_PREEMPT_RT
+static inline int dev_recursion_level(void)
+{
+	return current->net_xmit_recursion;
+}
+
+#else
+
 static inline int dev_recursion_level(void)
 {
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
+#endif
=20
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b49..6779d3b8f2578 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -969,7 +969,9 @@ struct task_struct {
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
 #endif
-
+#ifdef CONFIG_PREEMPT_RT
+	u8				net_xmit_recursion;
+#endif
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
=20
 	struct restart_block		restart_block;
diff --git a/net/core/dev.h b/net/core/dev.h
index b7b518bc2be55..2f96d63053ad0 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -150,6 +150,25 @@ struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
=20
 #define XMIT_RECURSION_LIMIT	8
+
+#ifdef CONFIG_PREEMPT_RT
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(current->net_xmit_recursion > XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	current->net_xmit_recursion++;
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	current->net_xmit_recursion--;
+}
+
+#else
+
 static inline bool dev_xmit_recursion(void)
 {
 	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
@@ -165,5 +184,6 @@ static inline void dev_xmit_recursion_dec(void)
 {
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
+#endif
=20
 #endif
--=20
2.43.0


