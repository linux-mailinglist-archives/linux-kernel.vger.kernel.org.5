Return-Path: <linux-kernel+bounces-6153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99969819524
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085D41F25F92
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478A20B26;
	Wed, 20 Dec 2023 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umVrC99g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95372200D5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e73bd9079eso32578577b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703031572; x=1703636372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIfyyqU8vvkBxzT4xph+dm2KvcH+GhhY/2ZmCVqXntI=;
        b=umVrC99gRoJhtjuT9Sr4qw/c6e1DLGzxutQKK5qOnxrXllsSXpXpOoA2UTVmAlqguj
         gyaNfHIrmyHWLONVtHRsNQKDJXulTbLVt7RHDCv3YSY+OgPu+4UeGXXM5alTZtsYp5xC
         WkuxSh6Vl6D+IkGLzG1m1yTHKs0AoEyQR94zrvJFIShEXdQ08bWpQg/wMQP87Ngru5vt
         QPJ/dGfucl8QV+1ThB4XHceWwhAUZ+CSHtQpJ7mbGCaw939xvSQ4/n2lWSxxNKzfXKgI
         ZL6HxUnRDsLOK2H4ur0IuUwjR2YVtL5UXCyOz7k+Vry/ZUzmF0DtZMp+oCtBV2DhMIEx
         DBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703031572; x=1703636372;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AIfyyqU8vvkBxzT4xph+dm2KvcH+GhhY/2ZmCVqXntI=;
        b=plgU+p4OW9YSJtcZDuFFQzuZJbU/we6lJwaiB9vwQiRoHWlreqsCmAEi/Aa4B57ROC
         ZNqcBH00rKaPVXKT6BYDjcx5a/yZPe8LoB4Se4gTmm0ns6y19YwKVhFhWlbnLBInGAJq
         9MWmStOpAN5oKF67vTmR5hMS7ot0k+ydOw2oGmjqVOFm2onbMonvR2QYlpEW6dHNrW0c
         hP5UCYhARmKoyQVeodP1CuwGWTchfHx9pffYpwNoBC1aRYJG35tb05sDphUBnqqZSxBu
         YO/acuXD5ojz9w8XOwcssFzbi7RM8D9INRpY5CDqK4hejCOUVJ+PAEWnIrObzR85P+58
         4Fyg==
X-Gm-Message-State: AOJu0Yyuw/YWSTKLd9rrxQJUH5+jQdpAVHuVnjaTcLeDpJWDgg1x5nWa
	uX8aFRF2uPXnF7IGb2nfXrtGV12we56sG/ejQGmFlmcFnhn48/vpcmMAV07ddvSCH5hbAILh95x
	egTCs1EyzIj7AvNUe0mZog7TrKvsTw/GnDy+SlATtL2RhCRlSaDX/NvsBr0j6mHZ9ptrG9O4=
X-Google-Smtp-Source: AGHT+IEQVD9hjXxmvtfUNLzEVhTlYwXthri2unuNndqCOZSGlx11NHsaq76wkJ/AvlLoDcuPbV2MaXu/49yn
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:4491:b0:5e8:3e57:6900 with SMTP
 id gr17-20020a05690c449100b005e83e576900mr423186ywb.1.1703031572518; Tue, 19
 Dec 2023 16:19:32 -0800 (PST)
Date: Tue, 19 Dec 2023 16:18:28 -0800
In-Reply-To: <20231220001856.3710363-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220001856.3710363-18-jstultz@google.com>
Subject: [PATCH v7 17/23] sched: Initial sched_football test implementation
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reimplementation of the sched_football test from LTP:
https://github.com/linux-test-project/ltp/blob/master/testcases/realtime/fu=
nc/sched_football/sched_football.c

But reworked to run in the kernel and utilize mutexes
to illustrate proper boosting of low priority mutex
holders.

TODO:
* Need a rt_mutex version so it can work w/o proxy-execution
* Need a better place to put it

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/Makefile              |   1 +
 kernel/sched/test_sched_football.c | 242 +++++++++++++++++++++++++++++
 lib/Kconfig.debug                  |  14 ++
 3 files changed, 257 insertions(+)
 create mode 100644 kernel/sched/test_sched_football.c

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 976092b7bd45..2729d565dfd7 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -32,3 +32,4 @@ obj-y +=3D core.o
 obj-y +=3D fair.o
 obj-y +=3D build_policy.o
 obj-y +=3D build_utility.o
+obj-$(CONFIG_SCHED_RT_INVARIENT_TEST) +=3D test_sched_football.o
diff --git a/kernel/sched/test_sched_football.c b/kernel/sched/test_sched_f=
ootball.c
new file mode 100644
index 000000000000..9742c45c0fe0
--- /dev/null
+++ b/kernel/sched/test_sched_football.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Module-based test case for RT scheduling invariant
+ *
+ * A reimplementation of my old sched_football test
+ * found in LTP:
+ *   https://github.com/linux-test-project/ltp/blob/master/testcases/realt=
ime/func/sched_football/sched_football.c
+ *
+ * Similar to that test, this tries to validate the RT
+ * scheduling invariant, that the across N available cpus, the
+ * top N priority tasks always running.
+ *
+ * This is done via having N offsensive players that are
+ * medium priority, which constantly are trying to increment the
+ * ball_pos counter.
+ *
+ * Blocking this, are N defensive players that are higher
+ * priority which just spin on the cpu, preventing the medium
+ * priroity tasks from running.
+ *
+ * To complicate this, there are also N defensive low priority
+ * tasks. These start first and each aquire one of N mutexes.
+ * The high priority defense tasks will later try to grab the
+ * mutexes and block, opening a window for the offsensive tasks
+ * to run and increment the ball. If priority inheritance or
+ * proxy execution is used, the low priority defense players
+ * should be boosted to the high priority levels, and will
+ * prevent the mid priority offensive tasks from running.
+ *
+ * Copyright =C2=A9 International Business Machines  Corp., 2007, 2008
+ * Copyright (C) Google, 2023
+ *
+ * Authors: John Stultz <jstultz@google.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/sched/rt.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/rwsem.h>
+#include <linux/smp.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <uapi/linux/sched/types.h>
+#include <linux/rtmutex.h>
+
+atomic_t players_ready;
+atomic_t ball_pos;
+int players_per_team;
+bool game_over;
+
+struct mutex *mutex_low_list;
+struct mutex *mutex_mid_list;
+
+static inline
+struct task_struct *create_fifo_thread(int (*threadfn)(void *data), void *=
data,
+				       char *name, int prio)
+{
+	struct task_struct *kth;
+	struct sched_attr attr =3D {
+		.size		=3D sizeof(struct sched_attr),
+		.sched_policy	=3D SCHED_FIFO,
+		.sched_nice	=3D 0,
+		.sched_priority	=3D prio,
+	};
+	int ret;
+
+	kth =3D kthread_create(threadfn, data, name);
+	if (IS_ERR(kth)) {
+		pr_warn("%s eerr, kthread_create failed\n", __func__);
+		return kth;
+	}
+	ret =3D sched_setattr_nocheck(kth, &attr);
+	if (ret) {
+		kthread_stop(kth);
+		pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
+		return ERR_PTR(ret);
+	}
+
+	wake_up_process(kth);
+	return kth;
+}
+
+int defense_low_thread(void *arg)
+{
+	long tnum =3D (long)arg;
+
+	atomic_inc(&players_ready);
+	mutex_lock(&mutex_low_list[tnum]);
+	while (!READ_ONCE(game_over)) {
+		if (kthread_should_stop())
+			break;
+		schedule();
+	}
+	mutex_unlock(&mutex_low_list[tnum]);
+	return 0;
+}
+
+int defense_mid_thread(void *arg)
+{
+	long tnum =3D (long)arg;
+
+	atomic_inc(&players_ready);
+	mutex_lock(&mutex_mid_list[tnum]);
+	mutex_lock(&mutex_low_list[tnum]);
+	while (!READ_ONCE(game_over)) {
+		if (kthread_should_stop())
+			break;
+		schedule();
+	}
+	mutex_unlock(&mutex_low_list[tnum]);
+	mutex_unlock(&mutex_mid_list[tnum]);
+	return 0;
+}
+
+int offense_thread(void *)
+{
+	atomic_inc(&players_ready);
+	while (!READ_ONCE(game_over)) {
+		if (kthread_should_stop())
+			break;
+		schedule();
+		atomic_inc(&ball_pos);
+	}
+	return 0;
+}
+
+int defense_hi_thread(void *arg)
+{
+	long tnum =3D (long)arg;
+
+	atomic_inc(&players_ready);
+	mutex_lock(&mutex_mid_list[tnum]);
+	while (!READ_ONCE(game_over)) {
+		if (kthread_should_stop())
+			break;
+		schedule();
+	}
+	mutex_unlock(&mutex_mid_list[tnum]);
+	return 0;
+}
+
+int crazy_fan_thread(void *)
+{
+	int count =3D 0;
+
+	atomic_inc(&players_ready);
+	while (!READ_ONCE(game_over)) {
+		if (kthread_should_stop())
+			break;
+		schedule();
+		udelay(1000);
+		msleep(2);
+		count++;
+	}
+	return 0;
+}
+
+int ref_thread(void *arg)
+{
+	struct task_struct *kth;
+	long game_time =3D (long)arg;
+	unsigned long final_pos;
+	long i;
+
+	pr_info("%s: started ref, game_time: %ld secs !\n", __func__,
+		game_time);
+
+	/* Create low  priority defensive team */
+	for (i =3D 0; i < players_per_team; i++)
+		kth =3D create_fifo_thread(defense_low_thread, (void *)i,
+					 "defese-low-thread", 2);
+	/* Wait for the defense threads to start */
+	while (atomic_read(&players_ready) < players_per_team)
+		msleep(1);
+
+	for (i =3D 0; i < players_per_team; i++)
+		kth =3D create_fifo_thread(defense_mid_thread,
+					 (void *)(players_per_team - i - 1),
+					 "defese-mid-thread", 3);
+	/* Wait for the defense threads to start */
+	while (atomic_read(&players_ready) < players_per_team * 2)
+		msleep(1);
+
+	/* Create mid priority offensive team */
+	for (i =3D 0; i < players_per_team; i++)
+		kth =3D create_fifo_thread(offense_thread, NULL,
+					 "offense-thread", 5);
+	/* Wait for the offense threads to start */
+	while (atomic_read(&players_ready) < players_per_team * 3)
+		msleep(1);
+
+	/* Create high priority defensive team */
+	for (i =3D 0; i < players_per_team; i++)
+		kth =3D create_fifo_thread(defense_hi_thread, (void *)i,
+					 "defese-hi-thread", 10);
+	/* Wait for the defense threads to start */
+	while (atomic_read(&players_ready) < players_per_team * 4)
+		msleep(1);
+
+	/* Create high priority defensive team */
+	for (i =3D 0; i < players_per_team; i++)
+		kth =3D create_fifo_thread(crazy_fan_thread, NULL,
+					 "crazy-fan-thread", 15);
+	/* Wait for the defense threads to start */
+	while (atomic_read(&players_ready) < players_per_team * 5)
+		msleep(1);
+
+	pr_info("%s: all players checked in! Starting game.\n", __func__);
+	atomic_set(&ball_pos, 0);
+	msleep(game_time * 1000);
+	final_pos =3D atomic_read(&ball_pos);
+	pr_info("%s: final ball_pos: %ld\n", __func__, final_pos);
+	WARN_ON(final_pos !=3D 0);
+	game_over =3D true;
+	return 0;
+}
+
+static int __init test_sched_football_init(void)
+{
+	struct task_struct *kth;
+	int i;
+
+	players_per_team =3D num_online_cpus();
+
+	mutex_low_list =3D kmalloc_array(players_per_team,  sizeof(struct mutex),=
 GFP_ATOMIC);
+	mutex_mid_list =3D kmalloc_array(players_per_team,  sizeof(struct mutex),=
 GFP_ATOMIC);
+
+	for (i =3D 0; i < players_per_team; i++) {
+		mutex_init(&mutex_low_list[i]);
+		mutex_init(&mutex_mid_list[i]);
+	}
+
+	kth =3D create_fifo_thread(ref_thread, (void *)10, "ref-thread", 20);
+
+	return 0;
+}
+module_init(test_sched_football_init);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4405f81248fb..1d90059d190f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1238,6 +1238,20 @@ config SCHED_DEBUG
 	  that can help debug the scheduler. The runtime overhead of this
 	  option is minimal.
=20
+config SCHED_RT_INVARIENT_TEST
+	tristate "RT invarient scheduling tester"
+	depends on DEBUG_KERNEL
+	help
+	  This option provides a kernel module that runs tests to make
+	  sure the RT invarient holds (top N priority tasks run on N
+	  available cpus).
+
+	  Say Y here if you want kernel rt scheduling tests
+	  to be built into the kernel.
+	  Say M if you want this test to build as a module.
+	  Say N if you are unsure.
+
+
 config SCHED_INFO
 	bool
 	default n
--=20
2.43.0.472.g3155946c3a-goog


