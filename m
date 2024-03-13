Return-Path: <linux-kernel+bounces-101030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5717087A0E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BEA5B22317
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF10AB654;
	Wed, 13 Mar 2024 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evq4UNiO"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538838BE0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710294213; cv=none; b=DSzu5O7OBsSVh4/VbhzdIg3eT0UOmAik9YX20V2RcLVN5o1bbYAiGwPknqCC7ePyiRgVZs8+nLfLhyP6JYDyZnYNN2uZydLj0/3vkBAAjUG5nCN+0IEpijpF+xWH6W1JGrCHDtorQ/XUbIG5VspXfiF3acoLez7VIDfDR1t+g0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710294213; c=relaxed/simple;
	bh=nGzwNSFqCK+2PcMauYM1XnrAB1EgS6IQVgcJdVAehw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sUaedUVMCBoj97AFtirtq9ki4w+7yx8qNaxpBVO+ZX3Up6Uv1H4b+Ga2ZaF9GVHzpmhZ/NycGP+kiI7HJKw64CzRJDVQdJhs7knovEjOGF7e4/4aKfuemQ9szblP51ZkYAhYJ5mccaPMIArYlyXFW2MIzN3vbtbnMneS0fy9/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evq4UNiO; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2222c0462a9so603419fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710294211; x=1710899011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iql6IsYWjk5iivpy1BeQsKBgwnpQVKNqyu2rSOaZThE=;
        b=evq4UNiOcQk1nNzWrJV07gONGcu6D2gDjQwO1CDoWPrimLzOOd3W9ViqxAQQSfg5Sb
         3gvU6gtnURzE+S8Q0AnHjHOjhcid8fkt8J+/y4YTnbk3UFvCmRCeMHDqxTxR2Qv/bLL3
         mkrDzFC8iFlw57gFtsQFnJjVZKsgfLSlMlIaltbbZHr+aaZI9q2M7HO5KGudvDR2D6zx
         ykOHxYyNw38ijlihBRkYR5YQN3L04O+JykKHDAHIUv38PIGOaQKg0yCC5ODMCKB9sFmf
         EZ+H5BO6KTtgKEpuG9su8xwv4sr7Hq3Z4lBVZk7NB6nDPXKVlQK6i1peMVoJ3NsCXs9J
         4zzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710294211; x=1710899011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iql6IsYWjk5iivpy1BeQsKBgwnpQVKNqyu2rSOaZThE=;
        b=nrN543dj/0t7Ei7BcrigvEykxzY/4u5ECYoPDogrMyqmWWDDQ3+MQ/tyVKhcqQRgWg
         jkpmvnjP8qwzrD6t/Qtd1SxoGOomJYV/K0NA2GliIZ0NdyqqphlBA1QyroGOAzH9brUI
         35kcSNjZT/bnAY6w9evCFViLq6Nh6NnNVqFgk5aapypAyctohSzfpzuxbjYR3BZHqTbF
         fbhrbiDTmRrJyUcmC5Iv2LOldyIpollIQcmvpPL5PgaAfpoHwLUC2RSkMN+3fspoTB4D
         wjJU0PwrJ7zMGrEHw6/TAW2pVFL7KCbSIaOTU68ZO8G3fApqdG2FxSaoY7zE91yxtl0S
         WDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTPnOv7Ei63FV/l8f9RfYD3vEzfAVpnyEjGwowUy5721Q+FZcgFNd3XkZrnrHRwneScs3cMlZMYWDM+s2UhFYANY1xYZOcn5+2A2qx
X-Gm-Message-State: AOJu0Yxf90c1PNyiM95zMOysNmSEMli4OknisBrfFIASlRzsv9rFmfBf
	7PvxpBVsi8ZAPesPNCXCKZCa984POMOmSsyhJnu2soqrLoes1nZf
X-Google-Smtp-Source: AGHT+IHtLSN7Msu6dOluJxqwI8VlzT8fmE1brIbyF10FXgr9t1Zd15rzyG2+Rp2o+h0+wU9efPVMJQ==
X-Received: by 2002:a05:6870:a68f:b0:21e:459a:1fb6 with SMTP id i15-20020a056870a68f00b0021e459a1fb6mr11916342oam.23.1710294211305;
        Tue, 12 Mar 2024 18:43:31 -0700 (PDT)
Received: from pc-mac.company.local (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id t125-20020a625f83000000b006e669357e83sm7020895pfb.189.2024.03.12.18.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:43:31 -0700 (PDT)
From: Chunxin Zang <spring.cxz@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Chunxin Zang <spring.cxz@gmail.com>
Subject: [PATCH] sched/debug: Correctly print the title fields of runnable tasks
Date: Wed, 13 Mar 2024 09:43:18 +0800
Message-Id: <20240313014318.1971985-1-spring.cxz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The title fields displayed for runnable tasks are now incorrect.
like this:

  runnable tasks:
   S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
  -------------------------------------------------------------------------------------------------------------
   Ikworker/R-rcu_g     4        -1.048576 E        -1.039924         0.750000         0.000000         2   100         0.000000         0.000000         0.000000         0.000000 0 0 /
   Ikworker/R-slub_     5        -1.048576 E        -1.039924         0.750000         0.000000         2   100         0.000000         0.000000         0.000000         0.000000 0 0 /
   Ikworker/R-netns     6        -1.048576 E        -1.039924         0.750000         0.000000         2   100         0.000000         0.000000         0.000000         0.000000 0 0 /
   I   kworker/0:0H     8       194.270371 E       194.304864         3.000000         0.016500         4   100         0.000000         0.016500         0.000000         0.000000 0 0 /
   I    kworker/0:1     9     40954.080088 E     40957.028485         3.000000       132.979107      1516   120         0.000000       132.979107         0.000000         0.000000 0 0 /
   Ikworker/R-mm_pe    11        -1.048576 E        -1.039924         0.750000         0.000000         2   100         0.000000         0.000000         0.000000         0.000000 0 0 /
   Ircu_tasks_kthre    12        -1.048576 E         0.298576         0.750000         0.000000         2   120         0.000000         0.000000         0.000000         0.000000 0 0 /

The display information after fixing is as follows:

  runnable tasks:
   S            task   PID         tree-key E         deadline            slice  switches  prio        wait-time         sum-exec        sum-sleep        sum-block
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------
   S pool_workqueue_     3       115.900753 E       118.861289         3.000000         3   120         0.000000         0.039464         0.000000         0.000000 0 0 /
   I kworker/R-rcu_g     4        -1.048576 E        -1.039924         0.750000         2   100         0.000000         0.000000         0.000000         0.000000 0 0 /
   I kworker/R-slub_     5        -1.048576 E        -1.039924         0.750000         2   100         0.000000         0.000000         0.000000         0.000000 0 0 /
   I kworker/R-netns     6        -1.048576 E        -1.039924         0.750000         2   100         0.000000         0.000000         0.000000         0.000000 0 0 /
   I     kworker/0:0     7       391.218398 E       394.210989         3.000000         5   120         0.000000         0.016042         0.000000         0.000000 0 0 /

Signed-off-by: Chunxin Zang <spring.cxz@gmail.com>
---
 kernel/sched/debug.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..5359e724d270 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -575,17 +575,16 @@ static void
 print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 {
 	if (task_current(rq, p))
-		SEQ_printf(m, ">R");
+		SEQ_printf(m, ">R ");
 	else
-		SEQ_printf(m, " %c", task_state_to_char(p));
+		SEQ_printf(m, " %c ", task_state_to_char(p));
 
-	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, "%15s %5d %9lld.%06ld %c %9lld.%06ld %9lld.%06ld %9lld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
 		SPLIT_NS(p->se.deadline),
 		SPLIT_NS(p->se.slice),
-		SPLIT_NS(p->se.sum_exec_runtime),
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
 
@@ -611,10 +610,12 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
-		   "     wait-time             sum-exec        sum-sleep\n");
-	SEQ_printf(m, "-------------------------------------------------------"
-		   "------------------------------------------------------\n");
+	SEQ_printf(m, " S %15s %5s %16s %c %16s %16s %9s %5s %16s %16s %16s %16s\n",
+		   "task", "PID", "tree-key", 'E', "deadline", "slice",
+		   "switches", "prio", "wait-time", "sum-exec", "sum-sleep", "sum-block");
+	SEQ_printf(m, "---------------------------------------------------------------"
+		   "------------------------------------------------------------------"
+		   "--------------------------------\n");
 
 	rcu_read_lock();
 	for_each_process_thread(g, p) {
-- 
2.34.1


