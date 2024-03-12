Return-Path: <linux-kernel+bounces-100206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613B8879388
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937181C22E22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF8D7AE5F;
	Tue, 12 Mar 2024 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jd6lyc2Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jnXhA2d8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A2A7A136;
	Tue, 12 Mar 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244825; cv=none; b=VSCtn0ybNPIKOaJ0TcVyHaYdbjHPZbwIL9oIN9wktghMSPoglIsyG+XNGPVR6xxeBwVirN1BrYJnSy6v5lJKAT8eGlR8ZgItKL/zs13Wjk+H5Zk9CDuIm3rl7XH4V1Qm1NoF7lNiOcoc4mSdokzwxyDWqV+1APVETwqccMbP4zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244825; c=relaxed/simple;
	bh=Mk0IYlQCJVucfbg598j9x1hJFMFFbl+YrssFvxcubWM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ct9/CK34HgSE47n5znEMq05N8aa17MUcJulV8lXmdEtYUiYPzBF7ZfyIHTAEF4pa5Hyfj7HqCiyCrdQ3h+qmGGLW5T5uCTXz2gxXPoy8qaQrTjfRjNcY3aH9cf/K9Jc2J200O5OvOfIwqIMrYLjj88EfADDJkUHFz/lLgSReot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jd6lyc2Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jnXhA2d8; arc=none smtp.client-ip=193.142.43.55
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
	bh=Eo3JjDgnia8XvVll5zOEFper3G3rZ9oz36K5QSO7TLk=;
	b=jd6lyc2ZREA1EXq9RRmL6U5Jv5CDMWRh7dmLqK0v6DLZzoSZoXrvyLzQQihzDwY8EdaGaq
	OJSmp9daXhgv1s0WPr4XIl0SApC3Uzc+E7xKhgJTTPEGPzWFAEOhq5XycjuZ5+H1LOWp1J
	vrF1dpjxOU/IDLsuyM150zjoBEuJpRoU6W6K3qaV2wVugBAgYNeMLdgd1CIh5WDphmTmXP
	I32lfjjLGYrbhuRS+jPfUCS/UZa+Pxvdz4sjFPZfnF+GSsHczPrcZz5rxsiQY3nR4D8u9j
	XFtPPwKe5R46vbnfJq4WiE0a6+pLDCEDDgA8PqWjAUEkeWCu85jKtLldTOZA5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244822;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eo3JjDgnia8XvVll5zOEFper3G3rZ9oz36K5QSO7TLk=;
	b=jnXhA2d8ZKZgeQ2Ooda7NtJq+tkSQuTsV9pPz1XbBLBIXkc4rNcE9CZhcEoy6y4FruEUHo
	/XNkhL0Kjv5Hm2Dg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename update_blocked_averages()
 => sched_balance_update_blocked_averages()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-10-mingo@kernel.org>
References: <20240308111819.1101550-10-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482115.398.5230315172099786068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     391b7a5335c45b2bafe535cb440836ccd17515aa
Gitweb:        https://git.kernel.org/tip/391b7a5335c45b2bafe535cb440836ccd17515aa
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 12:00:00 +01:00

sched/balancing: Rename update_blocked_averages() => sched_balance_update_blocked_averages()

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-10-mingo@kernel.org
---
 kernel/sched/fair.c | 8 ++++----
 kernel/sched/pelt.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 96a81b2..95f7092 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9411,7 +9411,7 @@ static unsigned long task_h_load(struct task_struct *p)
 }
 #endif
 
-static void update_blocked_averages(int cpu)
+static void sched_balance_update_blocked_averages(int cpu)
 {
 	bool decayed = false, done = true;
 	struct rq *rq = cpu_rq(cpu);
@@ -12079,7 +12079,7 @@ static bool update_nohz_stats(struct rq *rq)
 	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
 		return true;
 
-	update_blocked_averages(cpu);
+	sched_balance_update_blocked_averages(cpu);
 
 	return rq->has_blocked_load;
 }
@@ -12339,7 +12339,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	raw_spin_rq_unlock(this_rq);
 
 	t0 = sched_clock_cpu(this_cpu);
-	update_blocked_averages(this_cpu);
+	sched_balance_update_blocked_averages(this_cpu);
 
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
@@ -12431,7 +12431,7 @@ static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
 		return;
 
 	/* normal load balance */
-	update_blocked_averages(this_rq->cpu);
+	sched_balance_update_blocked_averages(this_rq->cpu);
 	sched_balance_domains(this_rq, idle);
 }
 
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 63b6cf8..f80955e 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -209,7 +209,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	 * This means that weight will be 0 but not running for a sched_entity
 	 * but also for a cfs_rq if the latter becomes idle. As an example,
 	 * this happens during idle_balance() which calls
-	 * update_blocked_averages().
+	 * sched_balance_update_blocked_averages().
 	 *
 	 * Also see the comment in accumulate_sum().
 	 */

