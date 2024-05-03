Return-Path: <linux-kernel+bounces-168061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE58BB335
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9981F220AB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D6315A483;
	Fri,  3 May 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b44alsuR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YeNEJOBT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B138158D9F;
	Fri,  3 May 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761013; cv=none; b=aNyzyNVA6ox3iW+J1UubStnm/VQjX2dyZxvv5WQNl+7H//kqTwP0mx5PR7qfHef1b8DWEOrhmUb+RVrsb4mQ+WH72qkF/pr8l0eEPFV6UtGWM3MrIjZLqMMBIxtITROVoFF2KTraNhO+xGsB21if2tiwJL1rsr8tsYbT1+hgNe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761013; c=relaxed/simple;
	bh=owGjXj1gRcQHvfXuD018vQxaCTN0J8efK7YMuWyF8As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4jySER6s4bXxOkHn9mfm4cGEdeNQAGwMlR/zch3slWJzSPTf9ij2pTHUYTLCNWKrI3VtMIEqnUfAveBrhyT5fhRXyN3PxdQ0O7QSV+TOhoh+tv9e7bRg6g0baQPjUvxn7cKAbLujsSDZ9MUihLlrq6AJ0of9/BRB4sS6FQaYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b44alsuR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YeNEJOBT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsXcW5uZG6cWaMVlyAXK8eicxATBh3uvSrRgqWotKdM=;
	b=b44alsuR2QcrVlf59gZX0/PyvBQ3IOqwVn1z1csODKySqTQ0CI5M251JLg46rxDWQyJTC0
	k0fAKLRn+wdULW7GKRDTEWPs8Dp3ms99AZXnkK9nTrrw9w1ZjOl8b8aHFj9JK3jfAHHTcC
	dKePv+zpQ23u8ntg/qV+kibZr6QYgBQZeEadjTOManbb4/1Lk5HBTR2+40P3aumaJYoqxW
	pEAvQWxS4yHQujjzCB8bfgPEhfr180KvF2EyV9BiMZiJkWTo6X0A5HhywlCadh85k+o4DS
	QQpa0A9owaUc6Ce/di1SpwDdGng9EfjFxBi5UlvlIzs2c9VGIa7wpYuHKr4G/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsXcW5uZG6cWaMVlyAXK8eicxATBh3uvSrRgqWotKdM=;
	b=YeNEJOBTMY+L6UBwB4PdTxNfxklNmtz+hgddyru9gz8MnCWeQkdHeZY3YfDE99OCC2sn+k
	ZCWDz75clMOBIoBg==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 10/15] dev: Use nested-BH locking for softnet_data.process_queue.
Date: Fri,  3 May 2024 20:25:14 +0200
Message-ID: <20240503182957.1042122-11-bigeasy@linutronix.de>
In-Reply-To: <20240503182957.1042122-1-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

softnet_data::process_queue is a per-CPU variable and relies on disabled
BH for its locking. Without per-CPU locking in local_bh_disable() on
PREEMPT_RT this data structure requires explicit locking.

softnet_data::input_queue_head can be updated lockless. This is fine
because this value is only update CPU local by the local backlog_napi
thread.

Add a local_lock_t to softnet_data and use local_lock_nested_bh() for locki=
ng
of process_queue. This change adds only lockdep coverage and does not
alter the functional behaviour for !PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c551ec235f9af..9d19e6ace7cb7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3199,6 +3199,7 @@ static inline bool dev_has_header(const struct net_de=
vice *dev)
 struct softnet_data {
 	struct list_head	poll_list;
 	struct sk_buff_head	process_queue;
+	local_lock_t		process_queue_bh_lock;
=20
 	/* stats */
 	unsigned int		processed;
diff --git a/net/core/dev.c b/net/core/dev.c
index cf7b452ce0d74..1503883ce15a4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -450,7 +450,9 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
  *	queue in the local softnet handler.
  */
=20
-DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
+DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data) =3D {
+	.process_queue_bh_lock =3D INIT_LOCAL_LOCK(process_queue_bh_lock),
+};
 EXPORT_PER_CPU_SYMBOL(softnet_data);
=20
 /* Page_pool has a lockless array/stack to alloc/recycle pages.
@@ -5935,6 +5937,7 @@ static void flush_backlog(struct work_struct *work)
 	}
 	backlog_unlock_irq_enable(sd);
=20
+	local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
@@ -5942,6 +5945,7 @@ static void flush_backlog(struct work_struct *work)
 			rps_input_queue_head_incr(sd);
 		}
 	}
+	local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 	local_bh_enable();
 }
=20
@@ -6063,7 +6067,9 @@ static int process_backlog(struct napi_struct *napi, =
int quota)
 	while (again) {
 		struct sk_buff *skb;
=20
+		local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 		while ((skb =3D __skb_dequeue(&sd->process_queue))) {
+			local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 			rcu_read_lock();
 			__netif_receive_skb(skb);
 			rcu_read_unlock();
@@ -6072,7 +6078,9 @@ static int process_backlog(struct napi_struct *napi, =
int quota)
 				return work;
 			}
=20
+			local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 		}
+		local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
=20
 		backlog_lock_irq_disable(sd);
 		if (skb_queue_empty(&sd->input_pkt_queue)) {
@@ -6087,8 +6095,10 @@ static int process_backlog(struct napi_struct *napi,=
 int quota)
 			napi->state &=3D NAPIF_STATE_THREADED;
 			again =3D false;
 		} else {
+			local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
 						   &sd->process_queue);
+			local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 		}
 		backlog_unlock_irq_enable(sd);
 	}
--=20
2.43.0


