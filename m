Return-Path: <linux-kernel+bounces-143248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630668A3648
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD511F23DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A8C14F9F8;
	Fri, 12 Apr 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Ti2aY6EE"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D714F9E5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949793; cv=none; b=hmZdWuxGfS1OqMwoMBu0INpgvDmDsrXX5A/RxA2P1Gy718O9LMixmhkrm5US+L9MTLKLdNShAfhWm1pFnOKUjNoLxuC2CEr5kSZWPbePjqi1CraDrC2m8zMq//63MdJYEDn+On6po4Vk9Eyn746qtNnPZAF930+68y2cYPcG4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949793; c=relaxed/simple;
	bh=dQaeNoDNJqFNBNKcvM6d8Hg6B1oUlqEiWbbRKzhhBt0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DPOoEHBr7zHD8nV8khOpQQsNxpmn7hgjiugIIapvRco8wWeR7mUwca+VnyfV16/sZbwK2HyeOMl5X+HmkoqR1oZZlavmcl7rr9LKwbOPGx58dCW9Rd0RA7f+W2HjsKtwMIMF83nWRfkfTwURByVb/r6nsZ+tNDHaZEx7DUCnRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Ti2aY6EE; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22a1e72f683so632403fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1712949790; x=1713554590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JHuQfDxdcx8G3zoi8ca2WXEhtf4iHfh1cxjA36KMejQ=;
        b=Ti2aY6EE/OObYpVxfI8MmubXDCJ9CEihJMMDoFZU1uewkfI6hklbH1d/X38YEUNbZo
         T3lz3L4smsRM8H59+EBytsr77/t9SnswIMSCXOcN+cvo7irlRE7nDKNKxR+iWJVRNi73
         I7pezaHF2QvbcXybkzBNq5IsCqpwQqeEMAAchrYZdvYkVBYA7zJgdOGWht94nT1eG0Bj
         1nGfV3nHKhWyuUUdtu8mNZyqU6WPWBIUQD/4vdgFiLLhpMoZgkSfd3ZCtAVqdZtF1Gsw
         IQEgmnYae2YlbQtulDWK4bz3YxIUaxsAj7HY6eL/Ncbw+UGDNMCamifiVmZZrze7kBuV
         KyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712949790; x=1713554590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHuQfDxdcx8G3zoi8ca2WXEhtf4iHfh1cxjA36KMejQ=;
        b=IL8FLyWM1J5tOK694u7f1x61LlTBJCAbySrmetKVzyf/LGUBOqH2bVjrSSas1mALcD
         9YsBmXGya0p7QVu21bxoICRJs/mSRDAWNGSj3vv3T7L7lpjXBs6VkDUZ+HEabWV3Z3SM
         BWMEojNjdaWaReAyMmdB0Fz76Uvg2+fOiVQrXQHO2gPRqb9Er68E4BKSrKlwm5cmPmvo
         SSHqbDuFKJqz1HaON9aGODrTi44Wzs6Ov0pdjA9l6aNTlDOytLdFZe022mvTLk2vd1Ie
         zmN5iG3OpRhW1RNeOqrtpTyrUwXA9eK31IYYEBUsoIu2iBBvFnvvHPw66k0BdiMDRw46
         nykQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz5tBcYtyV/FnA9nQ4PikUx1GyjUQ99+3TdovHEjYikvjscqv2FX/S3C7kxLKq47TRpqXCtMislafgYp4SMxHZdvfnKArETavOcoeu
X-Gm-Message-State: AOJu0YzBCnEDuDEd5HOQ6JIfWyMl6GP7MsxCV5BmbeJkJIGpmhGLit5o
	Kww/lNSMW5y8/tIkC3vywUORQUFpOJc5PTmS+sqIgt3MSIi3njSRfhyEK9HKm1XbWf1WTKpbMnZ
	n
X-Google-Smtp-Source: AGHT+IEziXeR+0Xci7PgO0rORcIKACmBGVlycEQiJVW7/7QeyZ8/tkEpSjI8Mf88SYwFSWRX4vFfeA==
X-Received: by 2002:a05:6870:430e:b0:229:6841:3278 with SMTP id w14-20020a056870430e00b0022968413278mr3380902oah.59.1712949790026;
        Fri, 12 Apr 2024 12:23:10 -0700 (PDT)
Received: from vinbuntup3.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id d6-20020a05620a240600b0078d735ca917sm2754133qkn.123.2024.04.12.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 12:23:09 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH] sched/fair: fix dlserver duplicate start and stop
Date: Fri, 12 Apr 2024 15:23:04 -0400
Message-Id: <20240412192304.3201847-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dlserver is started when a cfs task is enqueued to an empty runqueue.
Similarly dlserver is stopped when the last cfs task is dequeued. But
this logic doesn't take care of the cfs throttling scenarios where the
root cfs runqueue's h_nr_running stays zero while enqueue/dequeue can
happen on throttled runqueues. This causes duplicate calls to start/stop
and causes issues with deadline logic. One example is a WARN_ON in
task_non_contending because of duplicate calls to dl_server_stop().

WARNING kernel: [ 1970.747755] ------------[ cut here ]------------
WARNING kernel: [ 1970.747767] WARNING: CPU: 0 PID: 14202 at kernel/sched/deadline.c:352 task_non_contending+0x404/0x500

WARNING kernel: [ 1970.747868] CPU: 0 PID: 14202 Comm: tpm_manager_cli Tainted: G  W 5.15.152-22017-ga797d64dcd15 #1
WARNING kernel: [ 1970.747874] Hardware name: HP Meep/Meep, BIOS Google_Meep.11297.250.0 01/25/2021
WARNING kernel: [ 1970.747877] RIP: 0010:task_non_contending+0x404/0x500

WARNING kernel: [ 1970.747910] Call Trace:
WARNING kernel: [ 1970.747914]  <TASK>
WARNING kernel: [ 1970.747918]  ? __warn+0xa3/0x131
WARNING kernel: [ 1970.747923]  ? task_non_contending+0x404/0x500
WARNING kernel: [ 1970.747927]  ? report_bug+0x97/0xfa
WARNING kernel: [ 1970.747932]  ? handle_bug+0x41/0x66
WARNING kernel: [ 1970.747937]  ? exc_invalid_op+0x1b/0x4b
WARNING kernel: [ 1970.747941]  ? asm_exc_invalid_op+0x16/0x20
WARNING kernel: [ 1970.747946]  ? task_non_contending+0x404/0x500
WARNING kernel: [ 1970.747949]  ? dequeue_dl_entity+0x112/0x2cd
WARNING kernel: [ 1970.747952]  dl_server_stop+0x17/0x2b
WARNING kernel: [ 1970.747956]  dequeue_task_fair+0x262/0x4c4
WARNING kernel: [ 1970.747962]  __schedule+0x17c/0xf13
WARNING kernel: [ 1970.747966]  ? update_load_avg+0x9b/0x611
WARNING kernel: [ 1970.747970]  schedule+0x4e/0xd0
WARNING kernel: [ 1970.747974]  schedule_hrtimeout_range_clock+0x10f/0x126
WARNING kernel: [ 1970.747977]  ? add_wait_queue+0x4d/0x84
WARNING kernel: [ 1970.747982]  poll_schedule_timeout+0x33/0x50
WARNING kernel: [ 1970.747987]  do_sys_poll+0x4a3/0x626
WARNING kernel: [ 1970.747993]  ? __se_sys_ppoll+0xdf/0xdf
WARNING kernel: [ 1970.748000]  __se_sys_poll+0x70/0xf7
WARNING kernel: [ 1970.748003]  do_syscall_64+0x51/0xa1
WARNING kernel: [ 1970.748007]  entry_SYSCALL_64_after_hwframe+0x5c/0xc6
WARNING kernel: [ 1970.748012] RIP: 0033:0x7bc815769510

dlserver should be started on an idle root cfs rq, when
 - enqueue on a non-throttled cfs_rq causing the root cfs rq to
   go non-idle, or
 - untthrottle results in the root cfs rq to go non-idle.

Similarly dlserver should be stopped on a non-idle root cfs rq, when
 - dequeue on a non-throttled cfs_rq causing the root cfs rq to
   go idle, or
 - throttle results in the root cfs rq to go idle.

This patch also adds a flag to track the state of the dlserver(active or
not) to catch bugs which causes similar duplicate start/stops. This
alone will fix the issue actually, but I feel we need the caller to be
responsible not to make duplicate calls.

BUG=b:332187250
TEST=tast run brya ui.DocsCUJ.field_trials

Change-Id: Iafe463ca76d1ec08f9588bf825df23a151591e96
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 include/linux/sched.h   |  1 +
 kernel/sched/deadline.c |  9 +++++++++
 kernel/sched/fair.c     | 22 ++++++++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b0a5983cf3d1..fe5e39006188 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -646,6 +646,7 @@ struct sched_dl_entity {
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
+	unsigned int			dl_server_active  : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f0a7f0e43ff0..bda964ac8d7c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1642,13 +1642,18 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
+		dl_se->dl_server_active = 0;
 		setup_new_dl_entity(dl_se);
 	}
 
 	if (!dl_se->dl_runtime)
 		return;
 
+	if (WARN_ON_ONCE(dl_se->dl_server_active))
+		return;
+
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
+	dl_se->dl_server_active = 1;
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
 		resched_curr(dl_se->rq);
 }
@@ -1658,10 +1663,14 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	if (!dl_se->dl_runtime)
 		return;
 
+	if (WARN_ON_ONCE(!dl_se->dl_server_active))
+		return;
+
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_server_active = 0;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b86bb3f23fb2..c11f872bb196 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5765,6 +5765,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, idle_task_delta, dequeue = 1;
+	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5837,6 +5838,13 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	sub_nr_running(rq, task_delta);
 
 done:
+	/*
+	 * Stop the dlserver if throttling resulted in no runnable
+	 * tasks.
+	 */
+	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
+
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
@@ -5854,6 +5862,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, idle_task_delta;
+	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -5929,6 +5938,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
+	/*
+	 * Start the dlserver if un-throttling resulted in new runnable
+	 * tasks.
+	 */
+	if (!rq_h_nr_running && rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
 		resched_curr(rq);
@@ -6734,7 +6750,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
-	if (!rq->cfs.h_nr_running) {
+	if (!throttled_hierarchy(task_cfs_rq(p)) &&
+			!rq->cfs.h_nr_running) {
 		/* Account for idle runtime */
 		if (!rq->nr_running)
 			dl_server_update_idle_time(rq, rq->curr);
@@ -6885,7 +6902,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
-	if (!rq->cfs.h_nr_running)
+	if (!throttled_hierarchy(task_cfs_rq(p)) &&
+			!rq->cfs.h_nr_running)
 		dl_server_stop(&rq->fair_server);
 
 	util_est_update(&rq->cfs, p, task_sleep);
-- 
2.40.1


