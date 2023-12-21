Return-Path: <linux-kernel+bounces-8785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AFE81BC2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02624284D69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871DF58209;
	Thu, 21 Dec 2023 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQ6bEooL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154955E64
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d3bebbf6eso7849995e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703176824; x=1703781624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26r5Wm7YdD5l6fiQ/WF7+YqJsDRqdt8+j15sNtHTNTY=;
        b=DQ6bEooLbR5RmbFZoQWhOVZsbej1pXxrBncOX+t6gCw8pWdoKkgAGAFVgJwiZWkOao
         Uw++XZCioWiHvi4nWdSdlMZTiq3btLgcF3kT4S69iGZX42dihmodUonmtoAGARJuqD4P
         coRuFOhNrCM0NkXs1TUVgurtaFnaShyMCvuo0Zt4GC7HdPL9sSz7QM8MMhf2/TKJYn2z
         OOwzuVr9n47zL1UYyUX3ReXQnuNgmXmzQAqdg9SJtQAk2+y4w+Bj4HnCV1+Ry4VfEf4c
         vb9TaJhx3G4OZfWmxLWgpGLGuIyNxDJ3f8B4SkLtPTM3RsdfDGtcZ874vIcoGgQNL/ce
         Gnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703176824; x=1703781624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26r5Wm7YdD5l6fiQ/WF7+YqJsDRqdt8+j15sNtHTNTY=;
        b=tAyFVgnYp23Qc6mD0lRgljJGnBZEgJyPORokWEzMocS1quqlLcGplsH8gs693yaUAf
         DQikEwwIeEcJnNG9JfuUSGgTuYHCQ2trVZUJK5OAKBcQkGhBeZ8idUPgF/8mPMvGy11T
         lqw97x1mRk1x0T0WBFnUcqRScpp2rpeQIRbyXdtx6r2qCLje+mWlXAR52Kp4xsY7bWNR
         sfghGYJ3uxFLZtZX4MWr9M5H5o1ZViOoDcG6/WpI1iVeIDhJBtD8/7OrUwCoX17q9D/f
         Uqle5AladiSTzuTQQQ6N0D3OwsmL1po4VTAkHVpkqefTlQpnsTEWyc0TonEIuFLclNXu
         qNsA==
X-Gm-Message-State: AOJu0YwPYlZKhx+El48R7AXSx74G0Gzc+eWLsjgheMoKASCoTJwG4TP8
	MPs7AHzZBIZfZOJxzbaFuu4oKw==
X-Google-Smtp-Source: AGHT+IHhbYS1KA73rBUZURjxHCdLiPaAcXV208BVQGnTq0/CSDUHQOmiZFNkfVWHwQjHk6yxgfCI3Q==
X-Received: by 2002:a05:600c:1705:b0:40c:610e:3c7a with SMTP id c5-20020a05600c170500b0040c610e3c7amr1029413wmn.88.1703176824278;
        Thu, 21 Dec 2023 08:40:24 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:2db4:9d2a:db65:42d6])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b004042dbb8925sm11693466wms.38.2023.12.21.08.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 08:40:23 -0800 (PST)
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
Subject: [PATCH] sched: Fix tg->load when offlining a CPU
Date: Thu, 21 Dec 2023 17:40:14 +0100
Message-Id: <20231221164014.447122-1-vincent.guittot@linaro.org>
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
---
 kernel/sched/fair.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 07200b4751b3..07edb7dce671 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4094,6 +4094,10 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 	if (cfs_rq->tg == &root_task_group)
 		return;
 
+	/* rq has been offline and doesn't contribute anymore to the share */
+	if (!cpu_active(cpu_of(rq_of(cfs_rq))))
+		return;
+
 	/*
 	 * For migration heavy workloads, access to tg->load_avg can be
 	 * unbound. Limit the update rate to at most once per ms.
@@ -4110,6 +4114,49 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
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
@@ -12423,6 +12470,9 @@ static void rq_offline_fair(struct rq *rq)
 
 	/* Ensure any throttled groups are reachable by pick_next_task */
 	unthrottle_offline_cfs_rqs(rq);
+
+	/* Ensure that we remove rq contribution to group share */
+	clear_tg_offline_cfs_rqs(rq);
 }
 
 #endif /* CONFIG_SMP */
-- 
2.34.1


