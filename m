Return-Path: <linux-kernel+bounces-85753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C20486BA56
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E213EB26C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2341F76EE5;
	Wed, 28 Feb 2024 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QW3XTz9Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zk5No014"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CD72910;
	Wed, 28 Feb 2024 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157617; cv=none; b=NLFEZSEg2dmu8WZaACH2wh0NEV/calkoUn1ZYwdt2QpVMNIrSiH+vNVhj0V7j16ETPBXS80IPIUCbpbA9VnXWkKH3kdRZdZz7U+ULshJi4lPoFwQ98GHKwnrdjTIsMwsP4ddYVZl/C9+irWzysrYojz03uiapjPEQwbBXacr9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157617; c=relaxed/simple;
	bh=bckUeZ94dmzHdGIr16fUxHKXvXAKWTMpngqNvn6EkCc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X9NRdvhQB/aKbPd+MrmztQeLWaSRDd6Q3BNDAlsBjf2tBy1/BDsGajz2JBsdyBttJwo12iN3DKofEcbRb5hLVRX77L39EEbm0sXRt/MBXyO11MFio/zVZ+gxQSLiNrS2FDLSMBJm1J9EzFqArG74fYwViVm96Rdklhl4C10KtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QW3XTz9Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zk5No014; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFahADjfQXRV37mCwED59FOVdN1jcTgP4zC0mea1W98=;
	b=QW3XTz9YuiKCcyl3GBUeW1qz+yua7k3jAbWwguPJ3yL8Wo4VvetAyUfVr/KbbHdLCuSMMJ
	fTdcSkTqcRVlTH3ZEdg6wuoiIeIKaTG8uA5PMa41BaTLMXXfu405kJkSj1t053+xkL1Ts5
	nAaxywU58STv02iyBwPl1c1rnIJvAfJIq1k/DmrRG/PoIa43weK74I5QDu5ANfNYFoOuql
	75zTlbQS2/0ft/t06duqIrJmWFJCh73eooB36S6JM99I2pLF+n0A1VeKIsWg8Hy3ZFf6Kb
	XzAwjqbzi47YM22+eqaBtvcBiM8Q/sKh7p6NwP9RpL4eiIxHQBSAT6L+7os8kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFahADjfQXRV37mCwED59FOVdN1jcTgP4zC0mea1W98=;
	b=zk5No014NSzQ2w1wiSzLSwFPX1XDHorf0O7bKFCioSEQIMM4cYALOK8ETxKk6DugxHcE5u
	Ix9RJHsGXzFyu8AA==
From: "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Remove unused parameter from sched_asym()
Cc: Alex Shi <alexs@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240210113924.1130448-2-alexs@kernel.org>
References: <20240210113924.1130448-2-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915760695.398.1958628153932798013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5a64983731566f3b102b4ed12445b8a1b2f46a46
Gitweb:        https://git.kernel.org/tip/5a64983731566f3b102b4ed12445b8a1b2f46a46
Author:        Alex Shi <alexs@kernel.org>
AuthorDate:    Sat, 10 Feb 2024 19:39:20 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:43:08 +01:00

sched/fair: Remove unused parameter from sched_asym()

The 'sds' argument is not used in the sched_asym() function anymore, remove it.

Fixes: c9ca07886aaa ("sched/fair: Do not even the number of busy CPUs via asym_packing")
Signed-off-by: Alex Shi <alexs@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240210113924.1130448-2-alexs@kernel.org
---
 kernel/sched/fair.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 51fe17f..300d1bf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9753,7 +9753,6 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 /**
  * sched_asym - Check if the destination CPU can do asym_packing load balance
  * @env:	The load balancing environment
- * @sds:	Load-balancing data with statistics of the local group
  * @sgs:	Load-balancing statistics of the candidate busiest group
  * @group:	The candidate busiest group
  *
@@ -9772,8 +9771,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * otherwise.
  */
 static inline bool
-sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
-	   struct sched_group *group)
+sched_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group *group)
 {
 	/* Ensure that the whole local core is idle, if applicable. */
 	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
@@ -9944,7 +9942,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
-	    sched_asym(env, sds, sgs, group)) {
+	    sched_asym(env, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 

