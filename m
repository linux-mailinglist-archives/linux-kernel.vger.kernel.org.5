Return-Path: <linux-kernel+bounces-166980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CABF8BA28D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E851028D6EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24FB21C165;
	Thu,  2 May 2024 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eyyIpJRj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BAAF8PCP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CAC201246;
	Thu,  2 May 2024 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685939; cv=none; b=atZWS6ZYjSzLnuCzuciMe9lXrqdw17NPVMFHZXz5fl4Ri5G6Kl9khzxeZYp9DBLrSOj85AvQ+B1o/emdqrL90dcIwsyrI60eNRy430/nbxripwzp9mg77ln8z02KGGq0usdW/4S/OuPeXLbok7t6GKLctpPiii4ZqLeQNJynU3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685939; c=relaxed/simple;
	bh=X5bm+DVovRz/4U93EleiMnGhMnScrQBwEa6gswrUflI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NvXz91pToiFiHBbLE72hLwGPPOxNhKvMWrB4Kvvcd8EcLwUSrhIhYwe9cv46ncHmCgeEvkugP/bMntzDw7Vr6aX1pxAM5ApIWaloSDk4ltutUqNaTK/TXKNE3LA9FRYfwslQD/p9nxzDL3plsZnB9ZMVns52GqtBZku2T/CV1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eyyIpJRj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BAAF8PCP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714685936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rswmw9AW06GyxQ8xxVykW80fBxNBsbL6ay1ZU2arScE=;
	b=eyyIpJRj2k6OAGQqPcWE8HWpj/l1btrxft8GjvD+u49PYf5YL2YpTLqXRpCoP33oV3xbrl
	P2ME7Yp4dVMNMJ3Dw+0qr8I88OqovOICdVjaLTNRdyHS7fYOyxHY4b7h1H9EVQTDzNWQcw
	wXll31IMZPoFW5zm22FM2bLiFsPl6fLGWMqrV/2EHYDmkIy5NEKIC9JXu4Zo7KwUpUM0eq
	OGLZPfymO47btdbsjmOR2A8XY+bxfIO+GOOxCu/1LV832ulzTInoNAw2hN0yMIcEhzAEwT
	P4yzQ/VE/4BxrNj4QSqcxX+QZiCxAwynugN/EWqaASX5SvTIvJXcooozOhYvfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714685936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rswmw9AW06GyxQ8xxVykW80fBxNBsbL6ay1ZU2arScE=;
	b=BAAF8PCP1oOMbgV0y8jJcZTIoszqspZ0lj8a5Usa0cvneO62fhXLTQVyzKBzdKLDaayBwb
	RH9kzRHrvA0b3MAg==
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
Subject: [PATCH printk v5 29/30] rcu: Mark emergency sections in rcu stalls
Date: Thu,  2 May 2024 23:44:38 +0206
Message-Id: <20240502213839.376636-30-john.ogness@linutronix.de>
In-Reply-To: <20240502213839.376636-1-john.ogness@linutronix.de>
References: <20240502213839.376636-1-john.ogness@linutronix.de>
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
 kernel/rcu/tree_exp.h   |  9 +++++++++
 kernel/rcu/tree_stall.h | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6b83537480b1..bc1d8733c08f 100644
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
@@ -612,6 +616,7 @@ static void synchronize_rcu_expedited_wait(void)
 			}
 			pr_cont("\n");
 		}
+		nbcon_cpu_emergency_flush();
 		rcu_for_each_leaf_node(rnp) {
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				mask = leaf_node_cpu_bit(rnp, cpu);
@@ -624,6 +629,9 @@ static void synchronize_rcu_expedited_wait(void)
 			rcu_exp_print_detail_task_stall_rnp(rnp);
 		}
 		jiffies_stall = 3 * rcu_exp_jiffies_till_stall_check() + 3;
+
+		nbcon_cpu_emergency_exit();
+
 		panic_on_rcu_stall();
 	}
 }
@@ -792,6 +800,7 @@ static void rcu_exp_print_detail_task_stall_rnp(struct rcu_node *rnp)
 		 */
 		touch_nmi_watchdog();
 		sched_show_task(t);
+		nbcon_cpu_emergency_flush();
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5d666428546b..1ca0826545c1 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,6 +7,7 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/console.h>
 #include <linux/kvm_para.h>
 #include <linux/rcu_notifier.h>
 
@@ -260,6 +261,7 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 		 */
 		touch_nmi_watchdog();
 		sched_show_task(t);
+		nbcon_cpu_emergency_flush();
 	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
@@ -522,6 +524,7 @@ static void print_cpu_stall_info(int cpu)
 	       falsepositive ? " (false positive?)" : "");
 
 	print_cpu_stat_info(cpu);
+	nbcon_cpu_emergency_flush();
 }
 
 /* Complain about starvation of grace-period kthread.  */
@@ -604,6 +607,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on our buddy...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -655,6 +660,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	rcu_force_quiescent_state();  /* Kick them all. */
@@ -675,6 +682,8 @@ static void print_cpu_stall(unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
+	nbcon_cpu_emergency_enter();
+
 	/*
 	 * OK, time to rat on ourselves...
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
@@ -703,6 +712,8 @@ static void print_cpu_stall(unsigned long gps)
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
+	nbcon_cpu_emergency_exit();
+
 	panic_on_rcu_stall();
 
 	/*
-- 
2.39.2


