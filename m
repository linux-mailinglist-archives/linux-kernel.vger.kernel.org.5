Return-Path: <linux-kernel+bounces-128786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A889895F85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BEF284456
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC4016A9BA;
	Tue,  2 Apr 2024 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dO5zg+CI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJQ7G1rI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791916A1E0;
	Tue,  2 Apr 2024 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095913; cv=none; b=ufCH7A+SAi81/QoI9XfXkwXq+mKWhT1W0JL4hH6AnZ3NDHP4GkNMX18YPN5sOj/P/kE/x//zhdQgrtDtQDYIg4iRrpTzTJDTe+QSDpUMTGbmsC+81QNjpokRSpg0QnqahWaN3nTvdvgKZwKzg82y3ISKDrtEboeWT7FK6/vcpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095913; c=relaxed/simple;
	bh=j2Ps0sUvXa5FFGYYiI49hHUu4c3C8/680t0hKerAtnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lxD9CEzr2fW3C3irAi7nkVfYJCApzIOoD2EL4x4nKfL2hkovSqTmiLrxum6avcbM2XPc/MH5YrGrtV2dmp/PE8u5Zq7Huge5j0ezS2hxGP0VloA6ftNZBVJXRcpBcMtNNQIc+zCpTfWUOCe88OWYxuF72ykgOvST3tJLt7snURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dO5zg+CI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tJQ7G1rI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712095909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oz8b+gVj+4FTYt+4Ek3fAB/5aQD+Yo6GKug3uRyPfAM=;
	b=dO5zg+CIEKrGHq6Dupt6+7LhUYJm8SL8mpx+fM39W+ss2I4gf69o4rlCBRIb1DlGbLdVt7
	zRuxtuyTf7992BY+eL2tf6+sihsQOD3mGXtFtS7TtRQu1Waz5+MAgIZKSvqSjVWz93j44M
	8x+4q2/6NhaJ8z4fw0r9JlQVgFea5lW0E3t4nht/eirqYEYziaD2uxF//KlKBoWZKiz5Eh
	rYq0dkzhDtx4yoTwZj57jOp/mlOHqDQT1NPhY+CDRf6n+hzUec95YRcOGbFj8UlAbv3Vqj
	dt7S04iw10YX/sIekI3Z7fmoCvJHrVXrOkl6+vgY5XF2eKmMy//bxFTnf9eXvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712095909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oz8b+gVj+4FTYt+4Ek3fAB/5aQD+Yo6GKug3uRyPfAM=;
	b=tJQ7G1rIEdNc01IoZPTdXpUmpC/eTVUsUntyOQgUHvlfBkOFe1UroCGIagflpVGvGuEmWR
	JijfC4O3+oaJ4VBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu@vger.kernel.org
Subject: [PATCH printk v4 26/27] rcu: Mark emergency section in rcu stalls
Date: Wed,  3 Apr 2024 00:17:28 +0206
Message-Id: <20240402221129.2613843-27-john.ogness@linutronix.de>
In-Reply-To: <20240402221129.2613843-1-john.ogness@linutronix.de>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark emergency sections wherever multiple lines of
rcu stall information are generated. In an emergency
section the CPU will not perform console output for the
printk() calls. Instead, a flushing of the console
output is triggered when exiting the emergency section.
This allows the full message block to be stored as
quickly as possible in the ringbuffer.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/rcu/tree_exp.h   | 7 +++++++
 kernel/rcu/tree_stall.h | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6b83537480b1..0a135e94da08 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -7,6 +7,7 @@
  * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/lockdep.h>
 
 static void rcu_exp_handler(void *unused);
@@ -571,6 +572,9 @@ static void synchronize_rcu_expedited_wait(void)
 			return;
 		if (rcu_stall_is_suppressed())
 			continue;
+
+		nbcon_cpu_emergency_enter();
+
 		j = jiffies;
 		rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_EXP, (void *)(j - jiffies_start));
 		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
@@ -624,6 +628,9 @@ static void synchronize_rcu_expedited_wait(void)
 			rcu_exp_print_detail_task_stall_rnp(rnp);
 		}
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
+
+		nbcon_cpu_emergency_exit();
+
 		panic_on_rcu_stall();
 	}
 }
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5d666428546b..f4d73ca20c76 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,6 +7,7 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
 
@@ -604,6 +605,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -655,6 +658,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	rcu_force_quiescent_state();  /* Kick them all. */
@@ -675,6 +680,8 @@ static void print_cpu_stall(unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on ourselves...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -703,6 +710,8 @@ static void print_cpu_stall(unsigned long gps)
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	/*
-- 
2.39.2


