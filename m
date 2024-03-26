Return-Path: <linux-kernel+bounces-119802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB888CD20
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81011C6692E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF13213CFB3;
	Tue, 26 Mar 2024 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7jcxuwX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K8FRbeLy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E465802;
	Tue, 26 Mar 2024 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481053; cv=none; b=aN+13xKWHwN3panO1qXjymU1DC8JKm40heM8Q8Vsg7ZufeluyGgAG73Rx9HVyuh03H3+eN2rHFCNW7ajBcXmK5rzNL/R/F6PzJMzW+SFKPir3xbOCOgPK2VfhiV/7jVKgXljaziXh/JKsHpVSzbSSR4otE20E1O7r48t5vrs7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481053; c=relaxed/simple;
	bh=JCXdozmnkFPX1WkDRioLRzOTLAtfQiY/F1KQJhvEJvY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f33h1S9FMQBECaybYjvhS7lSSbTtT98bUGZBMniamgLtvPpOPc79pmIc0RXn+Z08C53h7NIdAILc/9ezgNzGeCZ32ELTENqvmmK2U9NsVfgqiGKA5CYq8If7Ks929m5oWXCXhm7y/gNXzA+pMw/5FSKhI0Rf3jAZ2kY3/tkU8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7jcxuwX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K8FRbeLy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Mar 2024 19:24:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711481048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0bPrOBaybgV0zMx9zb0a7yAk6f3pE1zicCfdO6qy9U=;
	b=Q7jcxuwXkPZWSSkZroA2Z/0ftNbGpVonkqN+0Y94C2EFuSbuPplow2V4QHU7ZwCrSQ4UKj
	Lb47bBc5UNI+jnBIxnngDkKMUr9Ti7FBs54l9ZrkmPrOxlABXZPq5+X/0+FUxd4dLjPNJP
	akFOEUPdRj8J6GMyuaK6QbBC5IaujYpq4lU5ePGyK8bGvHrhUWSWoLC0amKkQM06fS09za
	YuAwgA0mLzZT4pncltz4Z/jHpRyS56c9DWPtbcUw4zbrv0kJ7c6cUzg/yVP4ECkyobrJpe
	cXgUFKhaSZROj5EnE/kfh+X97s7dQ+QcaBUpxoyc0WeAkMxP78pGoBgeYDSmdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711481048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0bPrOBaybgV0zMx9zb0a7yAk6f3pE1zicCfdO6qy9U=;
	b=K8FRbeLys8ng03ART++ksn/EqD981zwAXjoLO81KvyJNm8d3JV7DUDpJWuo4ICQt/m1h95
	2KS4g5wr0noYffBA==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Simplify the continue_balancing logic
 in sched_balance_newidle()
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325153926.274284-1-sshegde@linux.ibm.com>
References: <20240325153926.274284-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171148104719.10875.2014914765830035022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c829d6818b60c591f70c060b2bb75d76cf0cec6d
Gitweb:        https://git.kernel.org/tip/c829d6818b60c591f70c060b2bb75d76cf0cec6d
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Mon, 25 Mar 2024 21:09:26 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Mar 2024 20:16:20 +01:00

sched/fair: Simplify the continue_balancing logic in sched_balance_newidle()

newidle(CPU_NEWLY_IDLE) balancing doesn't stop the load-balancing if the
continue_balancing flag is reset, but the other two balancing (IDLE, BUSY)
cases do that.

newidle balance stops the load balancing if rq has a task or there
is wakeup pending. The same checks are present in should_we_balance for
newidle. Hence use the return value and simplify continue_balancing
mechanism for newidle. Update the comment surrounding it as well.

No change in functionality intended.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20240325153926.274284-1-sshegde@linux.ibm.com
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24a7530..1856e58 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12358,6 +12358,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
+	int continue_balancing = 1;
 	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
 	int pulled_task = 0;
@@ -12372,8 +12373,9 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 		return 0;
 
 	/*
-	 * We must set idle_stamp _before_ calling idle_balance(), such that we
-	 * measure the duration of idle_balance() as idle time.
+	 * We must set idle_stamp _before_ calling sched_balance_rq()
+	 * for CPU_NEWLY_IDLE, such that we measure the this duration
+	 * as idle time.
 	 */
 	this_rq->idle_stamp = rq_clock(this_rq);
 
@@ -12412,7 +12414,6 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
-		int continue_balancing = 1;
 		u64 domain_cost;
 
 		update_next_balance(sd, &next_balance);
@@ -12438,8 +12439,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 		 * Stop searching for tasks to pull if there are
 		 * now runnable tasks on this rq.
 		 */
-		if (pulled_task || this_rq->nr_running > 0 ||
-		    this_rq->ttwu_pending)
+		if (pulled_task || !continue_balancing)
 			break;
 	}
 	rcu_read_unlock();

