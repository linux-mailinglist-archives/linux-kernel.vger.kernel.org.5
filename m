Return-Path: <linux-kernel+bounces-100201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED687937F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6C7B22584
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B479DD5;
	Tue, 12 Mar 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aRb4kCVc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ytpMkHWg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933658207;
	Tue, 12 Mar 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244822; cv=none; b=oY30JEo5kJncIGb8SXDHtg/8nuMC3kvxrTiBMaJsnv4mVWAeFYKRQzGpY8dUpxWXYXmINHAI84+sikUWOIcevL69I0uyjR9BnWY5jIk8t7K4uI9e0Y1GRvu/4xd7YRTwen+Rai14BPkQ62m9+o6yzmdcfR/HCJJ+2UYQU9SrPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244822; c=relaxed/simple;
	bh=KM1UBwQkbdFws82BZPs7LJL/AWBztGJFkHtykBh7GUg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L4IlHIiYUcqUFrjlmpOg8AQUeirAcsZAsc06LVjJtUnnzmOBjImaKFTf8KTEk6eg+KPDH0ERXI/NFewBRp5/HY9rfHyPWHkN+YCsu4oCE2bR1dXkRkKfoHeph+3GyRBVVhlyC64p4EW9SqjEKP9w7Hk/JWhAiKFFEAP1LxwIwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aRb4kCVc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ytpMkHWg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZ8pXc6XEwmfIru+Hl3JIXfbLQwZTEjs/716tqLpL/o=;
	b=aRb4kCVc2cvdabyVQZnGcdAJqjeS49m1t88ISkDOfltuP1OY+dvfA/Egt53/VlIpBe6H+p
	kvtrvMYzsIsgwWsWti595ZYq+VefNRAxN25VAB4uBYkIAkR2Pf1f5jHol1n/yB0w+eMbPz
	i08SyZxyWPEiSpPjsUfItIllKUgnFc+zSQjAOGpbypq6zjCVyfREZ3NsEy1XtA7NvzNYMA
	VrPZ4V4myv1dzJj22PfTiZ0lMl3Od+FoDxcqR9bF+zX2HJgLIUWJVfTu5FrUZ9S794tOpo
	trYRKUW0sLxR+jb+Z99c309vPk0aOtYJ7T8hja7nLC1tuZpSxNNYeLN3QvMHgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZ8pXc6XEwmfIru+Hl3JIXfbLQwZTEjs/716tqLpL/o=;
	b=ytpMkHWg3SlGaG+bhrbdJnxm+ib0/p+JLho/swgxGjlQkOW7OkGeOxJ8kaCfK4TYx9cLeF
	KlMManHsXIYQKXDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Fix a couple of outdated function
 names in comments
Cc: Honglei Wang <jameshongleiwang@126.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <5biu@gmail.com>
References: <5biu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024481767.398.13644214266877553008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d72cf62438d67b911212f8d4cf65d6167c1541ba
Gitweb:        https://git.kernel.org/tip/d72cf62438d67b911212f8d4cf65d6167c1541ba
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 12 Mar 2024 11:33:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 12:00:01 +01:00

sched/balancing: Fix a couple of outdated function names in comments

The 'idle_balance()' function hasn't existed for years, and there's no
load_balance_newidle() either - both are sched_balance_newidle() today.

Reported-by: Honglei Wang <jameshongleiwang@126.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/ZfAwNufbiyt/5biu@gmail.com
---
 kernel/sched/fair.c | 2 +-
 kernel/sched/pelt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4b3c4a1..a19ea29 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6866,7 +6866,7 @@ dequeue_throttle:
 
 #ifdef CONFIG_SMP
 
-/* Working cpumask for: sched_balance_rq, load_balance_newidle. */
+/* Working cpumask for: sched_balance_rq(), sched_balance_newidle(). */
 static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
 static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index f80955e..3a96da2 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -208,7 +208,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * se has been already dequeued but cfs_rq->curr still points to it.
 	 * This means that weight will be 0 but not running for a sched_entity
 	 * but also for a cfs_rq if the latter becomes idle. As an example,
-	 * this happens during idle_balance() which calls
+	 * this happens during sched_balance_newidle() which calls
 	 * sched_balance_update_blocked_averages().
 	 *
 	 * Also see the comment in accumulate_sum().

