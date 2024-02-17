Return-Path: <linux-kernel+bounces-69645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F1858CBE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42DF2844AA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22491CF8C;
	Sat, 17 Feb 2024 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eky6hQco"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05291CAB8;
	Sat, 17 Feb 2024 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133289; cv=none; b=ekGITg09yM8beTdFxCg9T/CQqHyyr40dcoQtdewj5/C7yI42u4ZmuLQUe0J8bRqzqfZV9yt50Ub1cNl7/1SG93oSxffgEnbPb+DSGUxvfLczn/Hm2auwvYBn4s7WDIUIc+EhcSrQOo/LiWAedTqKvRzOjDkcYQQ4bFVMfPskTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133289; c=relaxed/simple;
	bh=Op/qg2WbQ4DaBSM3dzivfqtp+3FWxvhNMZYkDYGtYgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SilSHy8OamJrKyxuM+YDbNrxjYAN2bxrZmmZPDEvI4FxB1K3oNVHVzIKrtWoqSaiVrrqwevr89ym/MROLWjobhshR12Y1deIz2jU2fLuPK9xMyje22OVYWAnhSMotPj09JMI9ShVu1fEmGeJik/wDiRqoLBlLFRZa9qeH1El9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eky6hQco; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7873eaa0ce7so65050285a.1;
        Fri, 16 Feb 2024 17:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708133287; x=1708738087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VPm3Mqubx73iHgEJtMpZHgeN5M0pBWSh7mWOguIogNY=;
        b=Eky6hQcoitD3z6ylBouU9PDsoe+/dq6mV4Krtc8Kppe+rwvXcqV7HcZBdcfiCR0Ywx
         PTZVBq2UG1PGzyeNHN689UCnk/KKBwnmRc+TnDrvAnOs6xEAVVx7TIBhGs4dQ6I2WdtN
         im0Wcy0/s3djrJXfhkNHQvUN68v82osjbC7vj2r0AwHNBJeKb0O+2296gjcovl7ZZT45
         Jv/NvTY8YXt7ykiOPm2nWfHdsUPB5xkHxRAFl5J919ehbSIsu3atJFUrTFXWTLN6B5jE
         CBRvth1myy/eG8G5YSxTg5zuIDHY5zB0Oj1DFoIHlWPd4IwvFzbOlWXFRI2tHRNw0YIa
         ESUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708133287; x=1708738087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VPm3Mqubx73iHgEJtMpZHgeN5M0pBWSh7mWOguIogNY=;
        b=of/vfc4vDVlRD5SlVbDI518Qq3Eai6vtc7jQWENvq6kFGsKANXoiHMb83Xn1IqKayf
         1uoHFKDfLVHRYMhJCETe0aAfSRWD70HXez4ng7K6C/OM/BdbPtFFj6zKwBTxBpc0J4rO
         IdntNgcElVsdjRQ5+N8B1d9DHKi5ZmdW/Q3eDpysC2RuyKZaWj5kVFF+08IKRHQfqk/L
         nWMYqk330eRQ2GaGol8wV4XKTNG13Z4TAuNlBPjGJCWH5Y7WL1K+552KzHVB6iOVcO08
         55AVmN/5ZYHUIYAvIAyASgkx5fDOIR4urekkQT2+q1XXHAp2jzZ4C5l1i2LPeVg3kcQG
         WtsQ==
X-Forwarded-Encrypted: i=1; AJvYcCULE+jmnomnyUDauU+j/27mKOeMcxZVb9BGYl9qvhpMGl9o4xP/QcpXsa+VBrNtRiKx/2/WhuARY2TWGoW31Dut6KkL
X-Gm-Message-State: AOJu0YzSwiK/ios3eJBJglbqRDZeWUqD/qGv9lwzVUZKDvGwznHGLsPX
	s9UwR2SzAq9s4joQY61c2uohpIb8+dHXPTty2gD1t2hqZOlx6Qzt
X-Google-Smtp-Source: AGHT+IFl+gjGi2e78REhujMuhTn+7ZZMjU3eG4+mnFX8cuEsbx3isrAA9aOaAJUWD6SciDsCGlEQnQ==
X-Received: by 2002:a05:620a:1a0e:b0:785:d97d:a4ed with SMTP id bk14-20020a05620a1a0e00b00785d97da4edmr8335910qkb.37.1708133286872;
        Fri, 16 Feb 2024 17:28:06 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i9-20020ae9ee09000000b0078726073228sm440440qkg.26.2024.02.16.17.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 17:28:06 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 08EAB27C005B;
	Fri, 16 Feb 2024 20:28:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 16 Feb 2024 20:28:06 -0500
X-ME-Sender: <xms:pQvQZfa6iwHaGbm804kND4GpecMJ_Jeq_0keLOaiuTzpIgnORyHsDA>
    <xme:pQvQZea6NSnrezqpv0GazmyGZ8e0qW8ImsucKP3KLmQBqJf4jfuUgzPc8pOyVBiId
    L1NfU4BC-JX_n_Khw>
X-ME-Received: <xmr:pQvQZR-QM4lFMS9nux6eb5n-XhvKxbbAwgPVy5VKnMeNnkp8zeon5rgd-zU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefg
    heeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:pQvQZVqj58GGUfZoL-4WnVjki9kkxGtTJTy_O6bis2kLbh_eu-aDNQ>
    <xmx:pQvQZaotn4vGuPDytsmMwNH0FmuJG9-UcGYBvvjedsrW4uDjlzYM5g>
    <xmx:pQvQZbTJa3vO4ys54Bh_5WK5hPSaOV7agLVqY-Mp4pROXfnzL5MByg>
    <xmx:pgvQZVCRPcBr9iLps-05HnStOywFNWJJaOb9Kzl8Lyt9KNtTYYskgg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 20:28:05 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2 5/6] rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
Date: Fri, 16 Feb 2024 17:27:40 -0800
Message-ID: <20240217012745.3446231-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240217012745.3446231-1-boqun.feng@gmail.com>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Holding a mutex across synchronize_rcu_tasks() and acquiring
that same mutex in code called from do_exit() after its call to
exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
results in deadlock.  This is by design, because tasks that are far
enough into do_exit() are no longer present on the tasks list, making
it a bit difficult for RCU Tasks to find them, let alone wait on them
to do a voluntary context switch.  However, such deadlocks are becoming
more frequent.  In addition, lockdep currently does not detect such
deadlocks and they can be difficult to reproduce.

In addition, if a task voluntarily context switches during that time
(for example, if it blocks acquiring a mutex), then this task is in an
RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
just as well take advantage of that fact.

This commit therefore eliminates these deadlock by replacing the
SRCU-based wait for do_exit() completion with per-CPU lists of tasks
currently exiting.  A given task will be on one of these per-CPU lists for
the same period of time that this task would previously have been in the
previous SRCU read-side critical section.  These lists enable RCU Tasks
to find the tasks that have already been removed from the tasks list,
but that must nevertheless be waited upon.

The RCU Tasks grace period gathers any of these do_exit() tasks that it
must wait on, and adds them to the list of holdouts.  Per-CPU locking
and get_task_struct() are used to synchronize addition to and removal
from these lists.

Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/

Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reported-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yang Jihong <yangjihong1@huawei.com>
Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tasks.h | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 68a8adf7de8e..4dc355b2ac22 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -146,8 +146,6 @@ static struct rcu_tasks rt_name =							\
 }
 
 #ifdef CONFIG_TASKS_RCU
-/* Track exiting tasks in order to allow them to be waited for. */
-DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
 /* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
 static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
@@ -855,10 +853,12 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 //	number of voluntary context switches, and add that task to the
 //	holdout list.
 // rcu_tasks_postscan():
-//	Invoke synchronize_srcu() to ensure that all tasks that were
-//	in the process of exiting (and which thus might not know to
-//	synchronize with this RCU Tasks grace period) have completed
-//	exiting.
+//	Gather per-CPU lists of tasks in do_exit() to ensure that all
+//	tasks that were in the process of exiting (and which thus might
+//	not know to synchronize with this RCU Tasks grace period) have
+//	completed exiting.  The synchronize_rcu() in rcu_tasks_postgp()
+//	will take care of any tasks stuck in the non-preemptible region
+//	of do_exit() following its call to exit_tasks_rcu_stop().
 // check_all_holdout_tasks(), repeatedly until holdout list is empty:
 //	Scans the holdout list, attempting to identify a quiescent state
 //	for each task on the list.  If there is a quiescent state, the
@@ -871,8 +871,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 //	with interrupts disabled.
 //
 // For each exiting task, the exit_tasks_rcu_start() and
-// exit_tasks_rcu_finish() functions begin and end, respectively, the SRCU
-// read-side critical sections waited for by rcu_tasks_postscan().
+// exit_tasks_rcu_finish() functions add and remove, respectively, the
+// current task to a per-CPU list of tasks that rcu_tasks_postscan() must
+// wait on.  This is necessary because rcu_tasks_postscan() must wait on
+// tasks that have already been removed from the global list of tasks.
 //
 // Pre-grace-period update-side code is ordered before the grace
 // via the raw_spin_lock.*rcu_node().  Pre-grace-period read-side code
@@ -936,9 +938,13 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 	}
 }
 
+void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
+
 /* Processing between scanning taskslist and draining the holdout list. */
 static void rcu_tasks_postscan(struct list_head *hop)
 {
+	int cpu;
 	int rtsi = READ_ONCE(rcu_task_stall_info);
 
 	if (!IS_ENABLED(CONFIG_TINY_RCU)) {
@@ -952,9 +958,9 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 * this, divide the fragile exit path part in two intersecting
 	 * read side critical sections:
 	 *
-	 * 1) An _SRCU_ read side starting before calling exit_notify(),
-	 *    which may remove the task from the tasklist, and ending after
-	 *    the final preempt_disable() call in do_exit().
+	 * 1) A task_struct list addition before calling exit_notify(),
+	 *    which may remove the task from the tasklist, with the
+	 *    removal after the final preempt_disable() call in do_exit().
 	 *
 	 * 2) An _RCU_ read side starting with the final preempt_disable()
 	 *    call in do_exit() and ending with the final call to schedule()
@@ -963,7 +969,17 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 * This handles the part 1). And postgp will handle part 2) with a
 	 * call to synchronize_rcu().
 	 */
-	synchronize_srcu(&tasks_rcu_exit_srcu);
+
+	for_each_possible_cpu(cpu) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
+		struct task_struct *t;
+
+		raw_spin_lock_irq_rcu_node(rtpcp);
+		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list)
+			if (list_empty(&t->rcu_tasks_holdout_list))
+				rcu_tasks_pertask(t, hop);
+		raw_spin_unlock_irq_rcu_node(rtpcp);
+	}
 
 	if (!IS_ENABLED(CONFIG_TINY_RCU))
 		del_timer_sync(&tasks_rcu_exit_srcu_stall_timer);
@@ -1031,7 +1047,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 	 *
 	 * In addition, this synchronize_rcu() waits for exiting tasks
 	 * to complete their final preempt_disable() region of execution,
-	 * cleaning up after synchronize_srcu(&tasks_rcu_exit_srcu),
 	 * enforcing the whole region before tasklist removal until
 	 * the final schedule() with TASK_DEAD state to be an RCU TASKS
 	 * read side critical section.
@@ -1039,9 +1054,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 	synchronize_rcu();
 }
 
-void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
-
 static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
 {
 #ifndef CONFIG_TINY_RCU
-- 
2.43.0


