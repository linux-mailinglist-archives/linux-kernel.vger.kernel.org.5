Return-Path: <linux-kernel+bounces-100212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01476879395
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CB81F210D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6F679DD9;
	Tue, 12 Mar 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sB9jUynY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XAIYDpsc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F67C096;
	Tue, 12 Mar 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244831; cv=none; b=nF5HYEEEiIs/UxudVFe4E61uPqjYd28dfqOu5J2NvgdDIxKrnXBXiwxDU+gveWLFtXwSzsid+drlWpcQEAFcZX2l+9xnQW3vkKBiSWDsBl9tQXNcIWLVtsqpuJTtVimJTf5jYWfXMrxc/vAwFmm9pWcLPFP1STpWxXAOzGYce3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244831; c=relaxed/simple;
	bh=rB8a4rNT+BQ6FZMIo+Tn7ZnYlLOfl0+xb0zZu3x4cjg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s1UH62jd6k/gMjd5IN3W65+XLnI4v6VrTAwj28pEIwE84LvG9tZOoFprOKodMoJFgEuHSS6yNasarXT4TfLsoq2j7jiJjNqJGwZkvZ/pROR6dd+pyx15L4bY8wjKl9crv0VxyUs6jI0102IusCXuEbtL+gNZi4k0TE0FwFaRE/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sB9jUynY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XAIYDpsc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbpUTMHnfQDDxH/cD5Re+XuhtOhx5VvPZ1kGeQ+fqI8=;
	b=sB9jUynYg+DF0caIEZjTf61wZaCp5xMc1FOgbXxg3O5/Io6ZHk/XFp2BdW8ONuNwDkZj3a
	VRQ/IIwnmJEUYtqFuyFi34X/h+O3zk+KFriMmHwj3p3vTWdeCX/8L73kHBB2xNjjDKTk+A
	LaruDbM8QGnE0O+odLsfDDgUGlbJjP+PZjqnDaHSYUs0Omg1WaoyqqYwyOuTvoieImgCUA
	Rk0UoVWEWnRtrTstcJNIRjvAbpueERnyoGeSry/nHqJxD3IbLN4pNy7ePj31cE96jpZ8zN
	0HPXEOiHtdXxZ7/5goIzCs7By+3oSAhnsQSPcUH4YVWOowHJ3zOGDF4TF9cl2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbpUTMHnfQDDxH/cD5Re+XuhtOhx5VvPZ1kGeQ+fqI8=;
	b=XAIYDpscFHJ61160o8vILLTcs6H0NXIG6wlkjOvfUDbCBOYKEiFFY4SAK3WiulAMJnnUe0
	sQA2MGpUzituhRCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/balancing: Rename scheduler_tick() => sched_tick()
Cc: Ingo Molnar <mingo@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-3-mingo@kernel.org>
References: <20240308111819.1101550-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482723.398.17325070700113411035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     86dd6c04ef9f213e14d60c9f64bce1cc019f816e
Gitweb:        https://git.kernel.org/tip/86dd6c04ef9f213e14d60c9f64bce1cc019=
f816e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 11:59:59 +01:00

sched/balancing: Rename scheduler_tick() =3D> sched_tick()

- Standardize on prefixing scheduler-internal functions defined
  in <linux/sched.h> with sched_*() prefix. scheduler_tick() was
  the only function using the scheduler_ prefix. Harmonize it.

- The other reason to rename it is the NOHZ scheduler tick
  handling functions are already named sched_tick_*().
  Make the 'git grep sched_tick' more meaningful.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-3-mingo@kernel.org
---
 Documentation/scheduler/sched-domains.rst                            | 4 ++--
 Documentation/translations/zh_CN/scheduler/sched-domains.rst         | 4 ++--
 include/linux/sched.h                                                | 2 +-
 kernel/sched/core.c                                                  | 4 ++--
 kernel/sched/loadavg.c                                               | 2 +-
 kernel/time/timer.c                                                  | 2 +-
 kernel/workqueue.c                                                   | 2 +-
 tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/schedu=
ler/sched-domains.rst
index 6577b06..541d6c6 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -32,13 +32,13 @@ load of each of its member CPUs, and only when the load o=
f a group becomes
 out of balance are tasks moved between groups.
=20
 In kernel/sched/core.c, trigger_load_balance() is run periodically on each C=
PU
-through scheduler_tick(). It raises a softirq after the next regularly sched=
uled
+through sched_tick(). It raises a softirq after the next regularly scheduled
 rebalancing event for the current runqueue has arrived. The actual load
 balancing workhorse, sched_balance_softirq()->rebalance_domains(), is then r=
un
 in softirq context (SCHED_SOFTIRQ).
=20
 The latter function takes two arguments: the runqueue of current CPU and whe=
ther
-the CPU was idle at the time the scheduler_tick() happened and iterates over=
 all
+the CPU was idle at the time the sched_tick() happened and iterates over all
 sched domains our CPU is on, starting from its base domain and going up the =
->parent
 chain. While doing that, it checks to see if the current domain has exhauste=
d its
 rebalance interval. If so, it runs load_balance() on that domain. It then ch=
ecks
diff --git a/Documentation/translations/zh_CN/scheduler/sched-domains.rst b/D=
ocumentation/translations/zh_CN/scheduler/sched-domains.rst
index fbc3266..fa0c0bc 100644
--- a/Documentation/translations/zh_CN/scheduler/sched-domains.rst
+++ b/Documentation/translations/zh_CN/scheduler/sched-domains.rst
@@ -34,12 +34,12 @@ CPU=E5=85=B1=E4=BA=AB=E3=80=82=E4=BB=BB=E6=84=8F=E4=B8=A4=
=E4=B8=AA=E7=BB=84=E7=9A=84CPU=E6=8E=A9=E7=A0=81=E7=9A=84=E4=BA=A4=E9=9B=86=
=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=B8=BA=E7=A9=BA=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=
=98=AF=E8=BF=99=EF=BF=BD
 =E8=B0=83=E5=BA=A6=E5=9F=9F=E4=B8=AD=E7=9A=84=E8=B4=9F=E8=BD=BD=E5=9D=87=E8=
=A1=A1=E5=8F=91=E7=94=9F=E5=9C=A8=E8=B0=83=E5=BA=A6=E7=BB=84=E4=B8=AD=E3=80=
=82=E4=B9=9F=E5=B0=B1=E6=98=AF=E8=AF=B4=EF=BC=8C=E6=AF=8F=E4=B8=AA=E7=BB=84=
=E8=A2=AB=E8=A7=86=E4=B8=BA=E4=B8=80=E4=B8=AA=E5=AE=9E=E4=BD=93=E3=80=82=E7=
=BB=84=E7=9A=84=E8=B4=9F=E8=BD=BD=E8=A2=AB=E5=AE=9A=E4=B9=89=E4=B8=BA=E5=AE=83
 =E7=AE=A1=E8=BE=96=E7=9A=84=E6=AF=8F=E4=B8=AACPU=E7=9A=84=E8=B4=9F=E8=BD=BD=
=E4=B9=8B=E5=92=8C=E3=80=82=E4=BB=85=E5=BD=93=E7=BB=84=E7=9A=84=E8=B4=9F=E8=
=BD=BD=E4=B8=8D=E5=9D=87=E8=A1=A1=E5=90=8E=EF=BC=8C=E4=BB=BB=E5=8A=A1=E6=89=
=8D=E5=9C=A8=E7=BB=84=E4=B9=8B=E9=97=B4=E5=8F=91=E7=94=9F=E8=BF=81=E7=A7=BB=
=E3=80=82
=20
-=E5=9C=A8kernel/sched/core.c=E4=B8=AD=EF=BC=8Ctrigger_load_balance()=E5=9C=
=A8=E6=AF=8F=E4=B8=AACPU=E4=B8=8A=E9=80=9A=E8=BF=87scheduler_tick()
+=E5=9C=A8kernel/sched/core.c=E4=B8=AD=EF=BC=8Ctrigger_load_balance()=E5=9C=
=A8=E6=AF=8F=E4=B8=AACPU=E4=B8=8A=E9=80=9A=E8=BF=87sched_tick()
 =E5=91=A8=E6=9C=9F=E6=89=A7=E8=A1=8C=E3=80=82=E5=9C=A8=E5=BD=93=E5=89=8D=E8=
=BF=90=E8=A1=8C=E9=98=9F=E5=88=97=E4=B8=8B=E4=B8=80=E4=B8=AA=E5=AE=9A=E6=9C=
=9F=E8=B0=83=E5=BA=A6=E5=86=8D=E5=B9=B3=E8=A1=A1=E4=BA=8B=E4=BB=B6=E5=88=B0=
=E8=BE=BE=E5=90=8E=EF=BC=8C=E5=AE=83=E5=BC=95=E5=8F=91=E4=B8=80=E4=B8=AA=E8=
=BD=AF=E4=B8=AD=E6=96=AD=E3=80=82=E8=B4=9F=E8=BD=BD=E5=9D=87=E8=A1=A1=E7=9C=
=9F=E6=AD=A3
 =E7=9A=84=E5=B7=A5=E4=BD=9C=E7=94=B1sched_balance_softirq()->rebalance_domai=
ns()=E5=AE=8C=E6=88=90=EF=BC=8C=E5=9C=A8=E8=BD=AF=E4=B8=AD=E6=96=AD=E4=B8=8A=
=E4=B8=8B=E6=96=87=E4=B8=AD=E6=89=A7=E8=A1=8C
 =EF=BC=88SCHED_SOFTIRQ=EF=BC=89=E3=80=82
=20
-=E5=90=8E=E4=B8=80=E4=B8=AA=E5=87=BD=E6=95=B0=E6=9C=89=E4=B8=A4=E4=B8=AA=E5=
=85=A5=E5=8F=82=EF=BC=9A=E5=BD=93=E5=89=8DCPU=E7=9A=84=E8=BF=90=E8=A1=8C=E9=
=98=9F=E5=88=97=E3=80=81=E5=AE=83=E5=9C=A8scheduler_tick()=E8=B0=83=E7=94=A8=
=E6=97=B6=E6=98=AF=E5=90=A6=E7=A9=BA=E9=97=B2=E3=80=82=E5=87=BD=E6=95=B0=E4=
=BC=9A=E4=BB=8E
+=E5=90=8E=E4=B8=80=E4=B8=AA=E5=87=BD=E6=95=B0=E6=9C=89=E4=B8=A4=E4=B8=AA=E5=
=85=A5=E5=8F=82=EF=BC=9A=E5=BD=93=E5=89=8DCPU=E7=9A=84=E8=BF=90=E8=A1=8C=E9=
=98=9F=E5=88=97=E3=80=81=E5=AE=83=E5=9C=A8sched_tick()=E8=B0=83=E7=94=A8=E6=
=97=B6=E6=98=AF=E5=90=A6=E7=A9=BA=E9=97=B2=E3=80=82=E5=87=BD=E6=95=B0=E4=BC=
=9A=E4=BB=8E
 =E5=BD=93=E5=89=8DCPU=E6=89=80=E5=9C=A8=E7=9A=84=E5=9F=BA=E8=B0=83=E5=BA=A6=
=E5=9F=9F=E5=BC=80=E5=A7=8B=E8=BF=AD=E4=BB=A3=E6=89=A7=E8=A1=8C=EF=BC=8C=E5=
=B9=B6=E6=B2=BF=E7=9D=80parent=E6=8C=87=E9=92=88=E9=93=BE=E5=90=91=E4=B8=8A=
=E8=BF=9B=E5=85=A5=E6=9B=B4=E9=AB=98=E5=B1=82=E7=BA=A7=E7=9A=84=E8=B0=83=E5=
=BA=A6=E5=9F=9F=E3=80=82=E5=9C=A8=E8=BF=AD=E4=BB=A3
 =E8=BF=87=E7=A8=8B=E4=B8=AD=EF=BC=8C=E5=87=BD=E6=95=B0=E4=BC=9A=E6=A3=80=E6=
=9F=A5=E5=BD=93=E5=89=8D=E8=B0=83=E5=BA=A6=E5=9F=9F=E6=98=AF=E5=90=A6=E5=B7=
=B2=E7=BB=8F=E8=80=97=E5=B0=BD=E4=BA=86=E5=86=8D=E5=B9=B3=E8=A1=A1=E7=9A=84=
=E6=97=B6=E9=97=B4=E9=97=B4=E9=9A=94=EF=BC=8C=E5=A6=82=E6=9E=9C=E6=98=AF=EF=
=BC=8C=E5=AE=83=E5=9C=A8=E8=AF=A5=E8=B0=83=E5=BA=A6=E5=9F=9F=E8=BF=90=E8=A1=8C
 load_balance()=E3=80=82=E6=8E=A5=E4=B8=8B=E6=9D=A5=E5=AE=83=E6=A3=80=E6=9F=
=A5=E7=88=B6=E8=B0=83=E5=BA=A6=E5=9F=9F=EF=BC=88=E5=A6=82=E6=9E=9C=E5=AD=98=
=E5=9C=A8=EF=BC=89=EF=BC=8C=E5=86=8D=E5=90=8E=E6=9D=A5=E7=88=B6=E8=B0=83=E5=
=BA=A6=E5=9F=9F=E7=9A=84=E7=88=B6=E8=B0=83=E5=BA=A6=E5=9F=9F=EF=BC=8C=E4=BB=
=A5=E6=AD=A4=E7=B1=BB=E6=8E=A8=E3=80=82
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 17cb076..7eb7f31 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -301,7 +301,7 @@ enum {
 	TASK_COMM_LEN =3D 16,
 };
=20
-extern void scheduler_tick(void);
+extern void sched_tick(void);
=20
 #define	MAX_SCHEDULE_TIMEOUT		LONG_MAX
=20
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d44efa0..71b7a08 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5662,7 +5662,7 @@ static inline u64 cpu_resched_latency(struct rq *rq) { =
return 0; }
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
-void scheduler_tick(void)
+void sched_tick(void)
 {
 	int cpu =3D smp_processor_id();
 	struct rq *rq =3D cpu_rq(cpu);
@@ -6585,7 +6585,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev,=
 struct rq_flags *rf)
  *      paths. For example, see arch/x86/entry_64.S.
  *
  *      To drive preemption between tasks, the scheduler sets the flag in ti=
mer
- *      interrupt handler scheduler_tick().
+ *      interrupt handler sched_tick().
  *
  *   3. Wakeups don't really cause entry into schedule(). They add a
  *      task to the run-queue and that's it.
diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index 52c8f82..ca9da66 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -379,7 +379,7 @@ void calc_global_load(void)
 }
=20
 /*
- * Called from scheduler_tick() to periodically update this CPU's
+ * Called from sched_tick() to periodically update this CPU's
  * active count.
  */
 void calc_global_load_tick(struct rq *this_rq)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e69e75d..ff49ddc 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2478,7 +2478,7 @@ void update_process_times(int user_tick)
 	if (in_irq())
 		irq_work_tick();
 #endif
-	scheduler_tick();
+	sched_tick();
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
 		run_posix_cpu_timers();
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bf2bdac..8fbb0ec 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1464,7 +1464,7 @@ void wq_worker_sleeping(struct task_struct *task)
  * wq_worker_tick - a scheduler tick occurred while a kworker is running
  * @task: task currently running
  *
- * Called from scheduler_tick(). We're in the IRQ context and the current
+ * Called from sched_tick(). We're in the IRQ context and the current
  * worker's fields which follow the 'K' locking rule can be accessed safely.
  */
 void wq_worker_tick(struct task_struct *task)
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_fil=
e.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index 25432b8..073a748 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -19,7 +19,7 @@ fail() { # mesg
=20
 FILTER=3Dset_ftrace_filter
 FUNC1=3D"schedule"
-FUNC2=3D"scheduler_tick"
+FUNC2=3D"sched_tick"
=20
 ALL_FUNCS=3D"#### all functions enabled ####"
=20

