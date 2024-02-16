Return-Path: <linux-kernel+bounces-69383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E811858847
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B89289E43
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327C1482FE;
	Fri, 16 Feb 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="UvjVpO7k"
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D31468FE
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120560; cv=none; b=GePhnXEDNp2cSz1gHVOBbMvoraYbZZWb5ToM7h9868B93bU74r4CKvPUtc9ooiJMT5g1FyfJJuPEo0Bh3czrsPgQkVuyU9ctZ//smUAeqceS0p/LHBnIOEGSGDPhuqlezS2UYklnxjoNXcNNoTdqh1BbT6HOe//+rOnbN15JR+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120560; c=relaxed/simple;
	bh=HtzhTbrig6Q7FsxiULJj6MkqqvnTNQdjjMtBWF11WCU=;
	h=Date:Message-Id:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:From:To:Cc; b=CvOHcQg5Nk5VJt1kIWzC11tJ30/rOikwo5ML5aNUVTogBFgk/ISA16TSgTane7AFT5Q4rYtV4XuScMeGF66TDLk85UE0LsPXLCzvD6ztu5uN7AeM4tFX/IVgdCEagefjNxYdAKZV/Jt8tNGS2fYgdH74ar64QRr0+tADQ0E4Lt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=UvjVpO7k; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4Tc5N31Y9MzBj;
	Fri, 16 Feb 2024 22:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1708120547; bh=HtzhTbrig6Q7FsxiULJj6MkqqvnTNQdjjMtBWF11WCU=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:From;
	b=UvjVpO7kHbh1e+/CsN/kZj4Z3jeV5bKfuvUqY+enYSTDUTAgvYVBXwwMdBaMTeJBv
	 XzHwnr7w6HPdx23p6lfEWYXXawNvPcIfkNTyoYxejTnwMgkBw43KqK+WEKFTBAYmLh
	 T6ZbpYvGuFoNvUTe7/fLJ0j/P78Ke1TABieofL83eW0zzbP/CCleXAE3yv+f2rBzsc
	 K15pwVwaMDDmpCKM30FcLuDYr8+edt/0hTa8yq2oUDNPnsMt/76VxbtTmE9tVmTx8L
	 c6UCmO+JqVRwsGJnW+GyweNqoyi70YklulKtCYpRZxxXha5RNaSFGbhNJ9lwuUD29d
	 ufC8Pyd47xnkw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.10 at mail
Date: Fri, 16 Feb 2024 22:55:47 +0100
Message-Id: <3fa064422ddd6b15d6d572fc0c6e99b94eea1235.1708120036.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <64955b50602fc64e2d3c7d4a92a1f9459e8c7ead.1708120036.git.mirq-linux@rere.qmqm.pl>
References: <64955b50602fc64e2d3c7d4a92a1f9459e8c7ead.1708120036.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] sched: add for_each_sched_group() and use everywhere
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To:	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Len Brown <len.brown@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:	linux-kernel@vger.kernel.org

Make code iterating over all sched_groups more straightforward.

Note: There's no point in WARN_ON in init_sched_groups_capacity() if
we're going to unconditionally dereference a NULL pointer just a few
instructions later.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 kernel/sched/fair.c     | 13 +++++--------
 kernel/sched/sched.h    |  5 +++++
 kernel/sched/topology.c | 19 ++++++-------------
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7ac9f4b1d955..a8a011f24a6d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9566,15 +9566,13 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 		 * span the current group.
 		 */
 
-		group = child->groups;
-		do {
+		for_each_sched_group(child, group) {
 			struct sched_group_capacity *sgc = group->sgc;
 
 			capacity += sgc->capacity;
 			min_capacity = min(sgc->min_capacity, min_capacity);
 			max_capacity = max(sgc->max_capacity, max_capacity);
-			group = group->next;
-		} while (group != child->groups);
+		}
 	}
 
 	sdg->sgc->capacity = capacity;
@@ -10549,13 +10547,13 @@ static void update_idle_cpu_scan(struct lb_env *env,
 
 static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
 {
-	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
 	unsigned long sum_util = 0;
+	struct sched_group *sg;
 	int sg_status = 0;
 
-	do {
+	for_each_sched_group(env->sd, sg) {
 		struct sg_lb_stats *sgs = &tmp_sgs;
 		int local_group;
 
@@ -10586,8 +10584,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		sds->total_capacity += sgs->group_capacity;
 
 		sum_util += sgs->group_util;
-		sg = sg->next;
-	} while (sg != env->sd->groups);
+	}
 
 	/*
 	 * Indicate that the child domain of the busiest group prefers tasks
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..88f3cba60b1e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1902,6 +1902,11 @@ struct sched_group {
 	unsigned long		cpumask[];
 };
 
+#define for_each_sched_group(sd, sg) \
+	for ((sg) = NULL; \
+	     likely((sg)) ? (sg) != (sd)->groups : ((((sg) = (sd)->groups)), 1); \
+	     (void)((((sg) = (sg)->next)) || ({ BUG(); 0; })))
+
 static inline struct cpumask *sched_group_span(struct sched_group *sg)
 {
 	return to_cpumask(sg->cpumask);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 75b1a18783c2..dce29cf28f32 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -758,17 +758,15 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 		sd = sd->parent;
 		destroy_sched_domain(tmp);
 		if (sd) {
-			struct sched_group *sg = sd->groups;
+			struct sched_group *sg;
 
 			/*
 			 * sched groups hold the flags of the child sched
 			 * domain for convenience. Clear such flags since
 			 * the child is being destroyed.
 			 */
-			do {
+			for_each_sched_group(sd, sg)
 				sg->flags = 0;
-				sg = sg->next;
-			} while (sg != sd->groups);
 
 			sd->child = NULL;
 		}
@@ -1290,12 +1288,10 @@ build_sched_groups(struct sched_domain *sd, int cpu)
  */
 static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 {
-	struct sched_group *sg = sd->groups;
 	struct cpumask *mask = sched_domains_tmpmask2;
+	struct sched_group *sg;
 
-	WARN_ON(!sg);
-
-	do {
+	for_each_sched_group(sd, sg) {
 		int cpu, cores = 0, max_cpu = -1;
 
 		sg->group_weight = cpumask_weight(sched_group_span(sg));
@@ -1310,7 +1306,7 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 		sg->cores = cores;
 
 		if (!(sd->flags & SD_ASYM_PACKING))
-			goto next;
+			continue;
 
 		for_each_cpu(cpu, sched_group_span(sg)) {
 			if (max_cpu < 0)
@@ -1319,10 +1315,7 @@ static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 				max_cpu = cpu;
 		}
 		sg->asym_prefer_cpu = max_cpu;
-
-next:
-		sg = sg->next;
-	} while (sg != sd->groups);
+	}
 
 	if (cpu != group_balance_cpu(sg))
 		return;
-- 
2.39.2


