Return-Path: <linux-kernel+bounces-43598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE91841619
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4098B2321B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703153E29;
	Mon, 29 Jan 2024 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqO82PfC"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B553E22;
	Mon, 29 Jan 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569145; cv=none; b=GEInEdxamj9ydiMjSJtkm92Fs2pESE15VJHEapl3t3SZI7agXhJivoa3RQ28Yd5MH01enIz0nbY3xk4ApwUPDvhtLGEMaXTrkjHU6F+EnBpO0jgikbpJtoiUAFfNLbRRls1BV/aiND1fGGTThRYGOIs1ez6CUTtxM7TuMSTZ93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569145; c=relaxed/simple;
	bh=SbB6Ir+tRhwE7qM1itTfSXymFemKaVT+E3uwP7i+uxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQp5PI/Majy7J5uanuopuEjZkD8SZXnupv4GVb/5IZorllt+29K9Vc9zFd9vqxLhyKTIKjWbi3mzfZ+mwQ82Rl0velqVHEH7UsTEKk/PU6vSnzKQ+mVxIYFPqNmJMRokD0spr2ko0Ck1q+jl9sVAXF/iHIZTDJ0QxFsZm1SvSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqO82PfC; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c4fb9e7ccso8841666d6.3;
        Mon, 29 Jan 2024 14:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706569143; x=1707173943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tEO+0mGkRuORuTwiWO4NV6jguVwj913bFHO1jK0ZYD8=;
        b=MqO82PfCs4vVUmb/eL8X8bW8RO9cJleSmGnh3fKADepRRhIf/zAY+O6HLogMUMARAP
         qYjsglXgzvwaPIzFIE0u9mA7U2YOw6tjqBzUquISZoWx9Q/bc9L9Sn3G4sQrVOlDR2Ut
         avhCQGGndcdS5mXFcsYLLNuuKFGVzCKM+nZmACrsuryViq96QobeKJCcXIPXLPC7zix+
         zP/NYi1dgnr1vF8nCUa4g6r9inhzRQJLVYcYMEViZJ/18jLLaWYi0CIGpRj4gBlO0CI8
         pMyDpjh9JN1B4HNCjmkMb2FJC01u7Ry2p/ZRhg5kLDPB7FXV6RsGfYWMM4rLlN/SlBg6
         teDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706569143; x=1707173943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEO+0mGkRuORuTwiWO4NV6jguVwj913bFHO1jK0ZYD8=;
        b=X0dtt+EsHwdCdy8DsMLiZAwlXwh+Y8N/lLXxHSnaLraMVaZpRB0sCMWeMrWccZjRGH
         mQGjyEeMPqAvRGNIuW/B24QfvReTU4LmgX/UmbPQ6hCwpH4zH79owdjeePCfTYbd7iUe
         u54dSx1WJraIL9wVNvQ/RBQt2B9nkTR4LDuL6+hUwwngyA0TqgpzXXvzj3On3R2pzdHy
         KzrmoiNAnlr4qq+Y8mfWZWatdSWA++QaWZXiG35HYz+DS3aIsvOEXzg4fuUGvHLQ77Q7
         jXUfyklJ7YfW3xbgJDg1e0mWdm4fq8DxGMXB3MGDvhFfSe3ZkDpbuV3NdFvr1iy+GU6W
         JhsQ==
X-Gm-Message-State: AOJu0YxotWgrpAR7plqGxlkL5xWHQ9VrqNc2gMA7EkVMiEO62v0OsYnm
	K3Gn2KNir+Pffq6Sfz3v1EVqnCIYs1kqw1bMtGGAsXGM0+sj45WQ
X-Google-Smtp-Source: AGHT+IHyM9DLNlLhIGCf01Zll0C7v4IMZMEJhOTERxX4ofXo/Mrn2sMljctSzMNaKPn6aqBg5yk7Eg==
X-Received: by 2002:ad4:4eaf:0:b0:68c:3df8:735e with SMTP id ed15-20020ad44eaf000000b0068c3df8735emr8532663qvb.63.1706569142811;
        Mon, 29 Jan 2024 14:59:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXybO1yZve6bAHu6Nzmekx/U5DUJdKbQM72p+GypJrlXDvopMirh8CejAnW22Ja69eklQCGTPUM9lzyUXcm3pCWfUxf3Q3wKiKwBWDDvSM+yerP6XosR4PdyuoiB/77Zqqs4VVY/hTkGvmRXFZdpEz+E9gL73zziMH4mE1bZzCmAUH6ubXroWEuQjaqC7YDeF7ib0LA57krBgDpiR4Rb+HJufc8+ZEwFaXs3beWS3UnFKDBwvucG3tactHmTf+9yuEPLn4jVxW4+kU7ABT2/JueJxA+QfT2064Wkne9ZOIsPLYF/OkgA+KyI4uh7wa2tJVfl8IxTfwp99I+5ADgw9yG3+iWMnyp5hfC8gUW9+U8fVTeg4BTXcTr7gU8fLm3ByU7+WcCNzNq+MTpzSW/SxYiflhqjogH3vtpn7B4gbNTfNQuWcNIXLxNMUx4tfXW71s28UU9bhFE+MHpmWjKhw/P6+i40ikuc8d0XE8HxYw1+MyXDDNn2GDgVhzJRVYusAE1IilQbb9/+HTA7nZ++aHrFsEA3un8IV31feZKFArR0Wrt/CGvDa0FhixdZWoW4BL5xuRP8T7Yo32wYIgP1/5dzptkFukSs/y6hKh+8HwItGT16aQ94Y+0cDEpabN3O2JrFN+UvST1314J9px/ISn+sI93bdT3R8n4xe8xzGeONDdjX9gtsgSUFvXDJuoi1IhtGHF2ILaW/sqNLdY4KPYqNlU1sDjHAbo5IEoVHyXicewSkc9F18tVM8U5NWiiZIJihTP2YkHDjfB/M5rnMm2NOANQ/J2hQu+qs37aL4twO2czL6unSvSyQHoGN6jgmGQXFWnBu4C0214Rb/RMXymQO2+7c7cCQPVXxqvLEa/D9ZaFGrFpe51dP6jKBaY/8pkfk+pJ0Vsgmgf++TlSQrYm6YibTNrV9Z+lK/HWUAvex1GKBGy+WlMWQNbVbRFDZVjMMB
 gHhm9Il7iGUDQVO8PQywWifNxRtNaSGUU8WvQ3Xk3xRpUkf286+2IDcyLgbppse35a2C4zieOgcrkedHLxacP8rg==
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id kf3-20020a056214524300b0068c37d5f209sm3398367qvb.75.2024.01.29.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:59:02 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 98D631200043;
	Mon, 29 Jan 2024 17:59:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Jan 2024 17:59:01 -0500
X-ME-Sender: <xms:tC24ZU0dz1TuuD8ee4z8eMU-XB-uQDvIPpm9Tgm08JmT4bRl33PCdg>
    <xme:tC24ZfHDdEGoSBKdM4lMYgBmLF5xd94OiBPEQ2VtH6dk0O-Fs_Wv5MpgUZZ29rx9n
    mkIXal8iXIXY-0s_Q>
X-ME-Received: <xmr:tC24Zc5LTl668salCCRpqw4JET-0FdUu4cv19AGAJmHiYbO5BvkSdVPa0V8GZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeu
    gfehieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:tC24Zd3GPEq19pmVUNj7DU9c7TI6tLjSSSxNMSQ-SSqurHu48PtFJA>
    <xmx:tC24ZXH-imws91D9OIuLVHWPZc_qxMyLWZub8uQBr2dP-xRZU2kA7g>
    <xmx:tC24ZW942iYT6DcwPOg_luLHvWoq5kbdGl6JFS2roe5JuOv_ZtbQ5A>
    <xmx:tS24ZZnQxorw8dkQ8uKXu3decXG2igNCPaASM-95qD7-YbPoRgCzQPT9iuI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 17:58:59 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,	Arnd Bergmann <arnd@arndb.de>,
	Oleg Nesterov <oleg@redhat.com>,	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 2/2] rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks
Date: Mon, 29 Jan 2024 14:57:27 -0800
Message-ID: <20240129225730.3168681-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129225730.3168681-1-boqun.feng@gmail.com>
References: <20240129225730.3168681-1-boqun.feng@gmail.com>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/sched.h |  2 +
 init/init_task.c      |  1 +
 kernel/fork.c         |  1 +
 kernel/rcu/tasks.h    | 89 ++++++++++++++++++++++++++++++-------------
 4 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cdb8ea53c365..4f0e9274da2d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -858,6 +858,8 @@ struct task_struct {
 	u8				rcu_tasks_idx;
 	int				rcu_tasks_idle_cpu;
 	struct list_head		rcu_tasks_holdout_list;
+	int				rcu_tasks_exit_cpu;
+	struct list_head		rcu_tasks_exit_list;
 #endif /* #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_TRACE_RCU
diff --git a/init/init_task.c b/init/init_task.c
index 7ecb458eb3da..4daee6d761c8 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -147,6 +147,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.rcu_tasks_holdout = false,
 	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
 	.rcu_tasks_idle_cpu = -1,
+	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
 #endif
 #ifdef CONFIG_TASKS_TRACE_RCU
 	.trc_reader_nesting = 0,
diff --git a/kernel/fork.c b/kernel/fork.c
index 47ff3b35352e..3eb86f30e664 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1975,6 +1975,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->rcu_tasks_holdout = false;
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
 	p->rcu_tasks_idle_cpu = -1;
+	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_TRACE_RCU
 	p->trc_reader_nesting = 0;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 732ad5b39946..bd4a51fd5b1f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -32,6 +32,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtp_irq_work: IRQ work queue for deferred wakeups.
  * @barrier_q_head: RCU callback for barrier operation.
  * @rtp_blkd_tasks: List of tasks blocked as readers.
+ * @rtp_exit_list: List of tasks in the latter portion of do_exit().
  * @cpu: CPU number corresponding to this entry.
  * @rtpp: Pointer to the rcu_tasks structure.
  */
@@ -46,6 +47,7 @@ struct rcu_tasks_percpu {
 	struct irq_work rtp_irq_work;
 	struct rcu_head barrier_q_head;
 	struct list_head rtp_blkd_tasks;
+	struct list_head rtp_exit_list;
 	int cpu;
 	struct rcu_tasks *rtpp;
 };
@@ -144,8 +146,6 @@ static struct rcu_tasks rt_name =							\
 }
 
 #ifdef CONFIG_TASKS_RCU
-/* Track exiting tasks in order to allow them to be waited for. */
-DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
 /* Report delay in synchronize_srcu() completion in rcu_tasks_postscan(). */
 static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
@@ -275,6 +275,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		rtpcp->rtpp = rtp;
 		if (!rtpcp->rtp_blkd_tasks.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
+		if (!rtpcp->rtp_exit_list.next)
+			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
 	}
 
 	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
@@ -851,10 +853,12 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
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
@@ -867,8 +871,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
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
@@ -932,9 +938,13 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
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
@@ -948,9 +958,9 @@ static void rcu_tasks_postscan(struct list_head *hop)
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
@@ -959,7 +969,18 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 * This handles the part 1). And postgp will handle part 2) with a
 	 * call to synchronize_rcu().
 	 */
-	synchronize_srcu(&tasks_rcu_exit_srcu);
+
+	for_each_possible_cpu(cpu) {
+		unsigned long flags;
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
+		struct task_struct *t;
+
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list)
+			if (list_empty(&t->rcu_tasks_holdout_list))
+				rcu_tasks_pertask(t, hop);
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	}
 
 	if (!IS_ENABLED(CONFIG_TINY_RCU))
 		del_timer_sync(&tasks_rcu_exit_srcu_stall_timer);
@@ -1027,7 +1048,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 	 *
 	 * In addition, this synchronize_rcu() waits for exiting tasks
 	 * to complete their final preempt_disable() region of execution,
-	 * cleaning up after synchronize_srcu(&tasks_rcu_exit_srcu),
 	 * enforcing the whole region before tasklist removal until
 	 * the final schedule() with TASK_DEAD state to be an RCU TASKS
 	 * read side critical section.
@@ -1035,9 +1055,6 @@ static void rcu_tasks_postgp(struct rcu_tasks *rtp)
 	synchronize_rcu();
 }
 
-void call_rcu_tasks(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
-
 static void tasks_rcu_exit_srcu_stall(struct timer_list *unused)
 {
 #ifndef CONFIG_TINY_RCU
@@ -1147,25 +1164,45 @@ struct task_struct *get_rcu_tasks_gp_kthread(void)
 EXPORT_SYMBOL_GPL(get_rcu_tasks_gp_kthread);
 
 /*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
+ * Protect against tasklist scan blind spot while the task is exiting and
+ * may be removed from the tasklist.  Do this by adding the task to yet
+ * another list.
  */
-void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
+void exit_tasks_rcu_start(void)
 {
-	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
+	unsigned long flags;
+	struct rcu_tasks_percpu *rtpcp;
+	struct task_struct *t = current;
+
+	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
+	get_task_struct(t);
+	preempt_disable();
+	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
+	t->rcu_tasks_exit_cpu = smp_processor_id();
+	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+	if (!rtpcp->rtp_exit_list.next)
+		INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
+	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	preempt_enable();
 }
 
 /*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
+ * Remove the task from the "yet another list" because do_exit() is now
+ * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
  */
-void exit_tasks_rcu_stop(void) __releases(&tasks_rcu_exit_srcu)
+void exit_tasks_rcu_stop(void)
 {
+	unsigned long flags;
+	struct rcu_tasks_percpu *rtpcp;
 	struct task_struct *t = current;
 
-	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
+	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
+	rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, t->rcu_tasks_exit_cpu);
+	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+	list_del_init(&t->rcu_tasks_exit_list);
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	put_task_struct(t);
 }
 
 /*
-- 
2.43.0


