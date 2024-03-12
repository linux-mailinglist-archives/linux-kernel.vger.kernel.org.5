Return-Path: <linux-kernel+bounces-100207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E135387938C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18CA9B2438D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392E7AE7B;
	Tue, 12 Mar 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sjqXx4Fk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Krof+BT6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2107A14E;
	Tue, 12 Mar 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244826; cv=none; b=SzS4IZehhas/xKGumgr14lJZDqN/q0EaQ0K22kbASoxgbJ6j701D0Emqfx8p9EhXW5XIq+PLSxZFug7mI1oJfm0ixUAtOu6MztdIvlER3IZ3FP1tWxdlShj25DYpJm13NB4CtWHXR6y3rlwVMLg0CpOb+BexNG9oNWwjx95n6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244826; c=relaxed/simple;
	bh=BzUbsRiDXjdVab2HqCh0vjQyR41/5o/mENHfXRaGE5w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NBTKS1NxGlPjPgqi7qAszNm1Dv/4jpbfQFnii298C3C/ZyeU8EJcd0vzYVDGKUc8IiHYeyflMfBcNPRwtaO1z4fN3qUgXm7qLNsT2etzI0xQMyEMY0N1cqqvH9eSFoPM/moV65qiKpOYC7+DaToFMq+ZB15ma1MdQyIvbX3s9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sjqXx4Fk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Krof+BT6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244822;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4zkUl2qin+CmtmzrXqPoF7esVJnv3OpdRqKYGnsp/E=;
	b=sjqXx4FkBiZOcxNYQpkP81Oohh27SrZhHYo6z5IZEljkneUkk7wN5uaoSMlafc2vHllbMC
	ivkIsDEU3cJuWJpDEzVU8luv1TMlSZ98tKcluSg+Hzhd4e/39gDKMJYJ8WQJELKpTo/mDr
	NSkNkNHi27ZvxMNkCPSoaAc0YV5w+GNjpX4pvq0OBhPuMgiY4mLmAacoMhXpu7Q8PzblFD
	i2aXI4KTur3VSXvOW0Q3W4nArBcOM7iMH9Dte6lOw0wTmhYLlDCjlFp9E2sN2RZ+EPYNH5
	+eu66F9x/CFfADQ+jK759op+fAAS+nB2aAD674Jk1rjV+LCVDMNMvFPkgO3x1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244822;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4zkUl2qin+CmtmzrXqPoF7esVJnv3OpdRqKYGnsp/E=;
	b=Krof+BT6f+F/2d5PnWWDbL8+Bj/8YmaUFmIR8P2z2+9IhFs2ridUJ9Fm8BOMe0r8MVVhUg
	ob+4WrbcnD4atGBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename find_busiest_group() =>
 sched_balance_find_src_group()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-9-mingo@kernel.org>
References: <20240308111819.1101550-9-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482185.398.14157262219438674696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     82cf921432fc184adbbb9c1bced182564876ec5e
Gitweb:        https://git.kernel.org/tip/82cf921432fc184adbbb9c1bced182564876ec5e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 12:00:00 +01:00

sched/balancing: Rename find_busiest_group() => sched_balance_find_src_group()

Make two naming changes:

1)
   Standardize scheduler load-balancing function names on the
   sched_balance_() prefix.

2)

   Similar to find_busiest_queue(), the find_busiest_group() naming
   has become a bit of a misnomer: the 'busiest' qualifier to this
   function was historically correct but in the current code
   in quite a few cases we will not pick the 'busiest' group - but the best
   (possible) group we can balance from based on a complex set of
   constraints.

So name it a bit more neutrally, similar to the 'src/dst' nomenclature
we are already using when moving tasks between runqueues, and also
use the sched_balance_ prefix: sched_balance_find_src_group().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-9-mingo@kernel.org
---
 kernel/sched/fair.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1cd9a18..96a81b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9430,7 +9430,7 @@ static void update_blocked_averages(int cpu)
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-/********** Helpers for find_busiest_group ************************/
+/********** Helpers for sched_balance_find_src_group ************************/
 
 /*
  * sg_lb_stats - stats of a sched_group required for load-balancing:
@@ -9637,7 +9637,7 @@ static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
  *
  * When this is so detected; this group becomes a candidate for busiest; see
  * update_sd_pick_busiest(). And calculate_imbalance() and
- * find_busiest_group() avoid some of the usual balance conditions to allow it
+ * sched_balance_find_src_group() avoid some of the usual balance conditions to allow it
  * to create an effective group imbalance.
  *
  * This is a somewhat tricky proposition since the next run might not find the
@@ -10788,7 +10788,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	) / SCHED_CAPACITY_SCALE;
 }
 
-/******* find_busiest_group() helpers end here *********************/
+/******* sched_balance_find_src_group() helpers end here *********************/
 
 /*
  * Decision matrix according to the local and busiest group type:
@@ -10811,7 +10811,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
  */
 
 /**
- * find_busiest_group - Returns the busiest group within the sched_domain
+ * sched_balance_find_src_group - Returns the busiest group within the sched_domain
  * if there is an imbalance.
  * @env: The load balancing environment.
  *
@@ -10820,7 +10820,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
  *
  * Return:	- The busiest group if imbalance exists.
  */
-static struct sched_group *find_busiest_group(struct lb_env *env)
+static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
 {
 	struct sg_lb_stats *local, *busiest;
 	struct sd_lb_stats sds;
@@ -11274,7 +11274,7 @@ redo:
 		goto out_balanced;
 	}
 
-	group = find_busiest_group(&env);
+	group = sched_balance_find_src_group(&env);
 	if (!group) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
 		goto out_balanced;
@@ -11298,7 +11298,7 @@ redo:
 	env.flags |= LBF_ALL_PINNED;
 	if (busiest->nr_running > 1) {
 		/*
-		 * Attempt to move tasks. If find_busiest_group has found
+		 * Attempt to move tasks. If sched_balance_find_src_group has found
 		 * an imbalance but busiest->nr_running <= 1, the group is
 		 * still unbalanced. ld_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.

