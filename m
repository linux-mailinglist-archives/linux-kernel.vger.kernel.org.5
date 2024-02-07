Return-Path: <linux-kernel+bounces-55906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C13D84C33E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC27A28DFF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208001773D;
	Wed,  7 Feb 2024 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snmTf/yo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6615E86
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277454; cv=none; b=HrDmD+ddv1tML/mGFrveXp6Jl2E43J/u4hG6AaYGKZIcCpDNCl3hXLmXTIN9Sn626mVeQS4cp/JzXxhD+d/8FrIRAU9D1fRFUIvILcaJUCvw3hpJbIbch+kqKYGEfNM4oJnv752jkSOyoPPTWxrl7zxVvvJY5GQHASc2ERfwZH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277454; c=relaxed/simple;
	bh=8blD+uBMrelaCyYwKVTuyE+VAFxDX4apKVm3xaEDk4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keudBAlMtGxwBFwZFGrsZ7ZthJ3GEprlqBzWIFIoqi2dEmMR4Abee2NrsxouMY9S19n1R/tNlGBL6qwZz/zNZCtmUIAmeuVjftGrgLMuOMlR3M5VT0DZhHvGvEAn8xuMtj3IZ3DdTeOXBsk3lscVOblKt4nDKPUVm3es38pUYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snmTf/yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F0BC43394;
	Wed,  7 Feb 2024 03:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707277453;
	bh=8blD+uBMrelaCyYwKVTuyE+VAFxDX4apKVm3xaEDk4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=snmTf/yoiXRg69vxtX7HWuGaeYpHFH8rX2TAMaj1+FoxJ46nelr6wtU1GUAU0aOa3
	 8w1kNKdQjyes4Ej/qWfhAcADRJpkS3R179ZznsS5lsR+4uc4KFNewrP6EXgxKGVjor
	 d0G94TZHis5V7bV6QfNGvsqYT0hzQf00b4dLjAR20IbPI2ocNeXIKqrBzzh1cuxh3M
	 mNd9HcTmNNx+lgh+yDeW9/vIV4SQGPpkOXnsciyzbHnTJTfQ3qDyvUCFE83AoINlQh
	 UO36mcMZY/2tC31RoJdN7ljPUxZAcWLcDTh/2e2Fc5K3gxMzkpfA6eB3P4V0vvIVvo
	 rYizEE1JSLfVg==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	ricardo.neri-calderon@linux.intel.com,
	yangyicong@hisilicon.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v4 2/4] sched/fair: remove unused parameters
Date: Wed,  7 Feb 2024 11:47:02 +0800
Message-ID: <20240207034704.935774-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207034704.935774-1-alexs@kernel.org>
References: <20240207034704.935774-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

sds isn't used in function sched_asym(), so remove it to cleanup code.

Fixes: c9ca07886aaa ("sched/fair: Do not even the number of busy CPUs via asym_packing")
Signed-off-by: Alex Shi <alexs@kernel.org>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..607dc310b355 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9749,7 +9749,6 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 /**
  * sched_asym - Check if the destination CPU can do asym_packing load balance
  * @env:	The load balancing environment
- * @sds:	Load-balancing data with statistics of the local group
  * @sgs:	Load-balancing statistics of the candidate busiest group
  * @group:	The candidate busiest group
  *
@@ -9768,8 +9767,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * otherwise.
  */
 static inline bool
-sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
-	   struct sched_group *group)
+sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
 {
 	/* Ensure that the whole local core is idle, if applicable. */
 	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
@@ -9940,7 +9938,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_asym(env, sds, sgs, group)) {
+	    sched_asym(env, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
-- 
2.43.0


