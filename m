Return-Path: <linux-kernel+bounces-10389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B1381D3B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 12:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6F01F213C0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2ACCA56;
	Sat, 23 Dec 2023 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJCxuxxd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF78F7E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d4a222818so5765945e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 03:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703330148; x=1703934948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SADc7px+sR4nuAno22IJVc06fyLfUXcgmjlh3tsbOJo=;
        b=AJCxuxxdgFyfH7IRUnSOg0u0OZbL6TAWBj9ZYH4Y1+hlivhb6CxHEU3dwv+cQ9iBsU
         /EPmd10euzc5DzG200UJFXzaGt0NHZwLkxjsDN5IrCWXFd7SiEdBB0I0+hIrjAb3/9hu
         FjJADkv5S6uJKRJ0gA9aB+iFgghZ8HOkGTsYLMZ36zTnViurEb4i/gjoVhz3m1How3Xs
         uZCFjPjJ2u1RcflmKFqqP6xgFGRTOJcAepkGan4OHA7XjtIPjb8BP5j05Rqn909AKugd
         B6OWnQl5fLLPR6m4icFGbJTKwUiMcvyY+fovaOHf4t+fqbgqaRwH0jl5kNpJTAetZ20R
         OoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703330148; x=1703934948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SADc7px+sR4nuAno22IJVc06fyLfUXcgmjlh3tsbOJo=;
        b=e9L/60qxn0j//07xk5zHtz9VESy/uRhGz1rt1aXax697uIaPoXaABI1aSkSY7mDaex
         VnR9XKQdcfm/fedH2YeT6PB3bkKjlis8Z85YT/l4GzIJAIvfnbOSIW/OTUBL8/5QsM0t
         yj3aLSBO6s8R3xrRdimNjGFk18TLh+0ZXX9To13PXEK6fbag/VxbNzSOm84RZ0tZDjKN
         EPipNQjBPZWResiJP9OTtJdWxpNTGMmQHSDrv3FlL6Bwmn3uhs5gWdc2nLHNfNBLJc72
         FK+lNCHOnk3WNBH3W6SiakNWnA04nY7soZybzI3cc0rJx0/xqYa61oCXzZu8s3c18ohl
         KF1A==
X-Gm-Message-State: AOJu0YzTacIk5zwcyOvU9LJhNBCCvQVqRbB8JC+S5bvUY9IStjAeyQqc
	WifELetulUNnX40BO7yjEzJWgpWluFV/UA==
X-Google-Smtp-Source: AGHT+IH9KmGU2dahhtJ2WL2aYYwTC9kUyQCUs3M3xUAgpm8V9SVCqOO6svzXG+P3BVRS0HC1SH4Llg==
X-Received: by 2002:a05:600c:1e89:b0:40b:5e4a:2368 with SMTP id be9-20020a05600c1e8900b0040b5e4a2368mr1474144wmb.106.1703330148159;
        Sat, 23 Dec 2023 03:15:48 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:630e:7902:82da:dbf6])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm17974773wmn.14.2023.12.23.03.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 03:15:47 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	imran.f.khan@oracle.com,
	aaron.lu@intel.com,
	linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] v2 sched: Fix tg->load when offlining a CPU
Date: Sat, 23 Dec 2023 12:15:45 +0100
Message-Id: <20231223111545.62135-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a CPU taken offline, the contribution of its cfs_rqs to task_groups'
load may remain and impact the calculation of the share of the online
CPUs.
Clear the contribution of an offlining CPU to task groups' load and skip
its contribution while it is inactive.

Reported-by: Imran Khan <imran.f.khan@oracle.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-and-tested-by: Imran Khan <imran.f.khan@oracle.com>
---

- Fix !CONFIG_FAIR_GROUP_SCHED case

 kernel/sched/fair.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..4b09237d24b9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4100,6 +4100,10 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	if (cfs_rq->tg == &root_task_group)
 		return;
 
+	/* rq has been offline and doesn't contribute anymore to the share */
+	if (!cpu_active(cpu_of(rq_of(cfs_rq))))
+		return;
+
 	/*
 	 * For migration heavy workloads, access to tg->load_avg can be
 	 * unbound. Limit the update rate to at most once per ms.
@@ -4116,6 +4120,49 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	}
 }
 
+static inline void clear_tg_load_avg(struct cfs_rq *cfs_rq)
+{
+	long delta;
+	u64 now;
+
+	/*
+	 * No need to update load_avg for root_task_group as it is not used.
+	 */
+	if (cfs_rq->tg == &root_task_group)
+		return;
+
+	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
+	delta = 0 - cfs_rq->tg_load_avg_contrib;
+	atomic_long_add(delta, &cfs_rq->tg->load_avg);
+	cfs_rq->tg_load_avg_contrib = 0;
+	cfs_rq->last_update_tg_load_avg = now;
+}
+
+/* cpu offline callback */
+static void __maybe_unused clear_tg_offline_cfs_rqs(struct rq *rq)
+{
+	struct task_group *tg;
+
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * The rq clock has already been updated in the
+	 * set_rq_offline(), so we should skip updating
+	 * the rq clock again in unthrottle_cfs_rq().
+	 */
+	rq_clock_start_loop_update(rq);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(tg, &task_groups, list) {
+		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+
+		clear_tg_load_avg(cfs_rq);
+	}
+	rcu_read_unlock();
+
+	rq_clock_stop_loop_update(rq);
+}
+
 /*
  * Called within set_task_rq() right before setting a task's CPU. The
  * caller only guarantees p->pi_lock is held; no other assumptions,
@@ -4412,6 +4459,8 @@ static inline bool skip_blocked_update(struct sched_entity *se)
 
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
 
+static inline void clear_tg_offline_cfs_rqs(struct rq *rq) {}
+
 static inline int propagate_entity_load_avg(struct sched_entity *se)
 {
 	return 0;
@@ -12446,6 +12495,9 @@ static void rq_offline_fair(struct rq *rq)
 
 	/* Ensure any throttled groups are reachable by pick_next_task */
 	unthrottle_offline_cfs_rqs(rq);
+
+	/* Ensure that we remove rq contribution to group share */
+	clear_tg_offline_cfs_rqs(rq);
 }
 
 #endif /* CONFIG_SMP */
-- 
2.34.1


