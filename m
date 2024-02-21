Return-Path: <linux-kernel+bounces-74364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7A985D319
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4AA1C23100
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DB345976;
	Wed, 21 Feb 2024 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/ybSua0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ez2c8G4c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489E3E49B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506384; cv=none; b=h/0sWz0X7+Pex+1oQgxO3zZka3RdRHaNchWl+O6WIT/YyPIBJ+EOc4mFyvDthUi/ThfOIg9mGkKBZkEJybezNtYLle11q6dzotAGhYZ/OUMLL1RTS4Xj9Fb7Hf3diJ+TF48cBZ1D09+GdrHUzf06ZVmG7umVgdHBhTsn0p5ETVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506384; c=relaxed/simple;
	bh=lqzo/64LZxbO3BlWTISc+9iP7bdmS3XtmCo7nVHw3Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vgpqcr2eLQftqGgQhwh6AAsOslseCARGzYcsrvTRo4L2XvrfGJxh8siKLyo3SOuebTNQgqDU6qzX631CvYAGNsAYpasXOW+rMBnCoORNrlAqDhtr2U1MNu0hZlPPoWDSVOL26NCARlcFOVHkmlsuM1y2DigN0G5up0Xy71daZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/ybSua0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ez2c8G4c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfUPkbsUGavaFMAgteB30U/f1KDL95Bl2oCba8MYkuY=;
	b=h/ybSua0ryW5qplaASkFnIjwDLiYS4DLuYlT+Gw+pvmXJX4vCHw6KtrdZjVskhqP3xxY18
	cTBNQdWRiSPn04i9mLC1axFzhImsh6L3/jrDGb04qZebRVcnAVujlebxvbnNIdnXPoHSjF
	YHGqiahTiExD6G+urhPOThwrG21RBpjB00XDrGbCFIuLCT5wYceI9AxASRD0EYYZQ00I9e
	1On8NHkx7IA0R9DwbfIOPndbirxr2GP4IiaFKdN5nwrtct2NtWV3rN7BuHpfrhs2I/vjzc
	ThiXFrftqx13441HWBLy4ixGZPxVWDZGUhtQRc6yz7c/WHtAShu732AJmeSZgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfUPkbsUGavaFMAgteB30U/f1KDL95Bl2oCba8MYkuY=;
	b=ez2c8G4co/0Mq3cNqicCO5BHd/vN4zzIH0VhwLlrGV8saAmtkcV8lqyZHPZADLNdLKXaea
	Sn1ZtnnDv4hOesDA==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v11 19/20] timer_migration: Add tracepoints
Date: Wed, 21 Feb 2024 10:05:47 +0100
Message-Id: <20240221090548.36600-20-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timer pull logic needs proper debugging aids. Add tracepoints so the
hierarchical idle machinery can be diagnosed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v11: 's/numa_node/num_children/' when num_children value is assigned

v10: Make an entry in MAINTAINERS file

v9: Add tmigr_cpu_new_timer_idle tracepoint

v8: Add wakeup value to tracepoints
---
 MAINTAINERS                            |   1 +
 include/trace/events/timer_migration.h | 297 +++++++++++++++++++++++++
 kernel/time/timer_migration.c          |  26 +++
 3 files changed, 324 insertions(+)
 create mode 100644 include/trace/events/timer_migration.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..70c07ae6e584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17499,6 +17499,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	fs/timerfd.c
 F:	include/linux/time_namespace.h
 F:	include/linux/timer*
+F:	include/trace/events/timer*
 F:	kernel/time/*timer*
 F:	kernel/time/namespace.c
 
diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
new file mode 100644
index 000000000000..3f6e9502c41e
--- /dev/null
+++ b/include/trace/events/timer_migration.h
@@ -0,0 +1,297 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM timer_migration
+
+#if !defined(_TRACE_TIMER_MIGRATION_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TIMER_MIGRATION_H
+
+#include <linux/tracepoint.h>
+
+/* Group events */
+TRACE_EVENT(tmigr_group_set,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void *,	group		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->lvl		= group->level;
+		__entry->numa_node	= group->numa_node;
+	),
+
+	TP_printk("group=%p lvl=%d numa=%d",
+		  __entry->group, __entry->lvl, __entry->numa_node)
+);
+
+TRACE_EVENT(tmigr_connect_child_parent,
+
+	TP_PROTO(struct tmigr_group *child),
+
+	TP_ARGS(child),
+
+	TP_STRUCT__entry(
+		__field( void *,	child		)
+		__field( void *,	parent		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( unsigned int,	num_children	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->child		= child;
+		__entry->parent		= child->parent;
+		__entry->lvl		= child->parent->level;
+		__entry->numa_node	= child->parent->numa_node;
+		__entry->num_children	= child->parent->num_children;
+		__entry->childmask	= child->childmask;
+	),
+
+	TP_printk("group=%p childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
+		  __entry->child,  __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_children)
+);
+
+TRACE_EVENT(tmigr_connect_cpu_parent,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent		)
+		__field( unsigned int,	cpu		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( unsigned int,	num_children	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->parent		= tmc->tmgroup;
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->lvl		= tmc->tmgroup->level;
+		__entry->numa_node	= tmc->tmgroup->numa_node;
+		__entry->num_children	= tmc->tmgroup->num_children;
+		__entry->childmask	= tmc->childmask;
+	),
+
+	TP_printk("cpu=%d childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
+		  __entry->cpu,	 __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_children)
+);
+
+DECLARE_EVENT_CLASS(tmigr_group_and_cpu,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask),
+
+	TP_STRUCT__entry(
+		__field( void *,	group		)
+		__field( void *,	parent		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( u8,		active		)
+		__field( u8,		migrator	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->parent		= group->parent;
+		__entry->lvl		= group->level;
+		__entry->numa_node	= group->numa_node;
+		__entry->active		= state.active;
+		__entry->migrator	= state.migrator;
+		__entry->childmask	= childmask;
+	),
+
+	TP_printk("group=%p lvl=%d numa=%d active=%0x migrator=%0x "
+		  "parent=%p childmask=%0x",
+		  __entry->group, __entry->lvl, __entry->numa_node,
+		  __entry->active, __entry->migrator,
+		  __entry->parent, __entry->childmask)
+);
+
+DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_inactive,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask)
+);
+
+DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_active,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask)
+);
+
+/* CPU events*/
+DECLARE_EVENT_CLASS(tmigr_cpugroup,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent)
+		__field( unsigned int,	cpu)
+		__field( u64,		wakeup)
+	),
+
+	TP_fast_assign(
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->parent		= tmc->tmgroup;
+		__entry->wakeup		= tmc->wakeup;
+	),
+
+	TP_printk("cpu=%d parent=%p wakeup=%llu", __entry->cpu, __entry->parent, __entry->wakeup)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_new_timer,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_active,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_online,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_offline,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_handle_remote_cpu,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DECLARE_EVENT_CLASS(tmigr_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent)
+		__field( unsigned int,	cpu)
+		__field( u64,		nextevt)
+		__field( u64,		wakeup)
+	),
+
+	TP_fast_assign(
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->parent		= tmc->tmgroup;
+		__entry->nextevt	= nextevt;
+		__entry->wakeup		= tmc->wakeup;
+	),
+
+	TP_printk("cpu=%d parent=%p nextevt=%llu wakeup=%llu",
+		  __entry->cpu, __entry->parent, __entry->nextevt, __entry->wakeup)
+);
+
+DEFINE_EVENT(tmigr_idle, tmigr_cpu_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt)
+);
+
+DEFINE_EVENT(tmigr_idle, tmigr_cpu_new_timer_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt)
+);
+
+TRACE_EVENT(tmigr_update_events,
+
+	TP_PROTO(struct tmigr_group *child, struct tmigr_group *group,
+		 union tmigr_state childstate,	union tmigr_state groupstate,
+		 u64 nextevt),
+
+	TP_ARGS(child, group, childstate, groupstate, nextevt),
+
+	TP_STRUCT__entry(
+		__field( void *,	child			)
+		__field( void *,	group			)
+		__field( u64,		nextevt			)
+		__field( u64,		group_next_expiry	)
+		__field( unsigned int,	group_lvl		)
+		__field( u8,		child_active		)
+		__field( u8,		group_active		)
+		__field( unsigned int,	child_evtcpu		)
+		__field( u64,		child_evt_expiry	)
+	),
+
+	TP_fast_assign(
+		__entry->child			= child;
+		__entry->group			= group;
+		__entry->nextevt		= nextevt;
+		__entry->group_next_expiry	= group->next_expiry;
+		__entry->group_lvl		= group->level;
+		__entry->child_active		= childstate.active;
+		__entry->group_active		= groupstate.active;
+		__entry->child_evtcpu		= child ? child->groupevt.cpu : 0;
+		__entry->child_evt_expiry	= child ? child->groupevt.nextevt.expires : 0;
+	),
+
+	TP_printk("child=%p group=%p group_lvl=%d child_active=%0x group_active=%0x "
+		  "nextevt=%llu next_expiry=%llu child_evt_expiry=%llu child_evtcpu=%d",
+		  __entry->child, __entry->group, __entry->group_lvl, __entry->child_active,
+		  __entry->group_active,
+		  __entry->nextevt, __entry->group_next_expiry, __entry->child_evt_expiry,
+		  __entry->child_evtcpu)
+);
+
+TRACE_EVENT(tmigr_handle_remote,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void * ,	group	)
+		__field( unsigned int ,	lvl	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->lvl		= group->level;
+	),
+
+	TP_printk("group=%p lvl=%d",
+		   __entry->group, __entry->lvl)
+);
+
+#endif /*  _TRACE_TIMER_MIGRATION_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 9d6d5e5def5b..291cfa2bc08d 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -14,6 +14,9 @@
 #include "timer_migration.h"
 #include "tick-internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/timer_migration.h>
+
 /*
  * The timer migration mechanism is built on a hierarchy of groups. The
  * lowest level group contains CPUs, the next level groups of CPU groups
@@ -658,6 +661,8 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 */
 	group->groupevt.ignore = true;
 
+	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+
 	return walk_done;
 }
 
@@ -667,6 +672,8 @@ static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
 
 	data.childmask = tmc->childmask;
 
+	trace_tmigr_cpu_active(tmc);
+
 	tmc->cpuevt.ignore = true;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
@@ -828,6 +835,9 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 		data->firstexp = tmigr_next_groupevt_expires(group);
 	}
 
+	trace_tmigr_update_events(child, group, childstate, groupstate,
+				  nextexp);
+
 unlock:
 	raw_spin_unlock(&group->lock);
 
@@ -862,6 +872,8 @@ static u64 tmigr_new_timer(struct tmigr_cpu *tmc, u64 nextexp)
 	if (tmc->remote)
 		return KTIME_MAX;
 
+	trace_tmigr_cpu_new_timer(tmc);
+
 	tmc->cpuevt.ignore = false;
 	data.remote = false;
 
@@ -903,6 +915,8 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 		return;
 	}
 
+	trace_tmigr_handle_remote_cpu(tmc);
+
 	tmc->remote = true;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
@@ -985,6 +999,7 @@ static bool tmigr_handle_remote_up(struct tmigr_group *group,
 
 	childmask = data->childmask;
 
+	trace_tmigr_handle_remote(group);
 again:
 	/*
 	 * Handle the group only if @childmask is the migrator or if the
@@ -1207,6 +1222,7 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 	 */
 	WRITE_ONCE(tmc->wakeup, ret);
 
+	trace_tmigr_cpu_new_timer_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;
 }
@@ -1285,6 +1301,8 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	 */
 	WARN_ON_ONCE(data->firstexp != KTIME_MAX && group->parent);
 
+	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
+
 	return walk_done;
 }
 
@@ -1337,6 +1355,7 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
 	 */
 	WRITE_ONCE(tmc->wakeup, ret);
 
+	trace_tmigr_cpu_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;
 }
@@ -1453,6 +1472,7 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
 
 	/* Setup successful. Add it to the hierarchy */
 	list_add(&group->list, &tmigr_level_list[lvl]);
+	trace_tmigr_group_set(group);
 	return group;
 }
 
@@ -1470,6 +1490,8 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);
 
+	trace_tmigr_connect_child_parent(child);
+
 	/*
 	 * To prevent inconsistent states, active children need to be active in
 	 * the new parent as well. Inactive children are already marked inactive
@@ -1561,6 +1583,8 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 			raw_spin_unlock_irq(&group->lock);
 
+			trace_tmigr_connect_cpu_parent(tmc);
+
 			/* There are no children that need to be connected */
 			continue;
 		} else {
@@ -1628,6 +1652,7 @@ static int tmigr_cpu_online(unsigned int cpu)
 		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 	}
 	raw_spin_lock_irq(&tmc->lock);
+	trace_tmigr_cpu_online(tmc);
 	tmc->idle = timer_base_is_idle();
 	if (!tmc->idle)
 		__tmigr_cpu_activate(tmc);
@@ -1667,6 +1692,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	 * offline; Therefore nextevt value is set to KTIME_MAX
 	 */
 	firstexp = __tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	trace_tmigr_cpu_offline(tmc);
 	raw_spin_unlock_irq(&tmc->lock);
 
 	if (firstexp != KTIME_MAX) {
-- 
2.39.2


