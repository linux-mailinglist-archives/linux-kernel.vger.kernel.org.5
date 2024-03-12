Return-Path: <linux-kernel+bounces-100205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F38A879385
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEEDB23DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215467A720;
	Tue, 12 Mar 2024 12:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p0zOV226";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ynDkCjgp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F579DD0;
	Tue, 12 Mar 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244824; cv=none; b=Cjnynf55DKVkak1u0YGKA0rAkSXzJVq22ouYiuyNoJKqcB/em6UBLKSKAjys59KNEQwx336qCFJgruKC195Z5CL9Rvi248KW9m4oZqjvPTDQ2CzQli/mMu1VVnLoA6gtvJzY7xSC/XZkqHHmGWGgErfpE2C47fQKBSSbjZ6L0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244824; c=relaxed/simple;
	bh=b1mMbI6lID5n8qjV1S7dmie7OFUVRAPPpmbbEOPqwdU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X+0kWhsqyACKBOxWGCPHSFvEp0Cvl7jEvc4HytXR+rqBwjyT+rv34DSUXOlU/ogglS7Ws1G+RD11Wjy6OjdBDL05mGHQdOOvlfYp+2BKBzqXMXFXxAPhLnvSidS0eUJDAqJ2KWdyE+lDSYBZDSnjEKO6IWg0ZEwc1HNinZwCPoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p0zOV226; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ynDkCjgp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244821;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElUiyIrF/PtVcYTBy1Buyncg8p/ge/E3VzM9JW4kMqY=;
	b=p0zOV226r2K4G95nejYJch7lWeaFH6I1q08MbmCUE2c+N2UE/JPFwJlTiChDx5aXc3DGF0
	ledIllYjSS+rIA9ysglq+yZn5kzySlNwNQuO7h6xbP9tGRyHlGVGEyNhzzxRyW1RWc2NhA
	6IpiPrRzcEZ+0IPTy068jn0Zcz0b/nQZTome6NkOK8mKsAPVYOv6xmUbRP5W+TNCAYYdF/
	CSoSS7pO3Q8mjdoJrUDZ+SnGU4WeAcgu4LyT/64fac5VIDrcUIXW/8NN3QnGTsY2iW+ikr
	p0ndw6SFtyvTC1gWHy1DH/n2Ti2fPEabZ+UDwBvqRrVKSBlymK4YZedYoosEqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244821;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElUiyIrF/PtVcYTBy1Buyncg8p/ge/E3VzM9JW4kMqY=;
	b=ynDkCjgpiVto7X0UupAuqE8W03ZrQW+amDx+36RdScfiL9f7V/fbW92AwAupvQFLPkcsdK
	sWG86XpJvtDfZHDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename newidle_balance() =>
 sched_balance_newidle()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-11-mingo@kernel.org>
References: <20240308111819.1101550-11-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024482045.398.12996146036821244603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7d058285cd77cc1411c91efd1b1673530bb1bee8
Gitweb:        https://git.kernel.org/tip/7d058285cd77cc1411c91efd1b1673530bb1bee8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 12:00:00 +01:00

sched/balancing: Rename newidle_balance() => sched_balance_newidle()

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-11-mingo@kernel.org
---
 kernel/sched/fair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 95f7092..aa5ff0e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4816,7 +4816,7 @@ static inline unsigned long cfs_rq_load_avg(struct cfs_rq *cfs_rq)
 	return cfs_rq->avg.load_avg;
 }
 
-static int newidle_balance(struct rq *this_rq, struct rq_flags *rf);
+static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf);
 
 static inline unsigned long task_util(struct task_struct *p)
 {
@@ -5136,7 +5136,7 @@ attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void
 detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 
-static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
+static inline int sched_balance_newidle(struct rq *rq, struct rq_flags *rf)
 {
 	return 0;
 }
@@ -8253,7 +8253,7 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (rq->nr_running)
 		return 1;
 
-	return newidle_balance(rq, rf) != 0;
+	return sched_balance_newidle(rq, rf) != 0;
 }
 #endif /* CONFIG_SMP */
 
@@ -8505,10 +8505,10 @@ idle:
 	if (!rf)
 		return NULL;
 
-	new_tasks = newidle_balance(rq, rf);
+	new_tasks = sched_balance_newidle(rq, rf);
 
 	/*
-	 * Because newidle_balance() releases (and re-acquires) rq->lock, it is
+	 * Because sched_balance_newidle() releases (and re-acquires) rq->lock, it is
 	 * possible for any higher priority task to appear. In that case we
 	 * must re-start the pick_next_entity() loop.
 	 */
@@ -11493,7 +11493,7 @@ out_one_pinned:
 	ld_moved = 0;
 
 	/*
-	 * newidle_balance() disregards balance intervals, so we could
+	 * sched_balance_newidle() disregards balance intervals, so we could
 	 * repeatedly reach this code, which would lead to balance_interval
 	 * skyrocketing in a short amount of time. Skip the balance_interval
 	 * increase logic to avoid that.
@@ -12277,7 +12277,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
- * newidle_balance is called by schedule() if this_cpu is about to become
+ * sched_balance_newidle is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  *
  * Returns:
@@ -12285,7 +12285,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
  *     0 - failed, no new tasks
  *   > 0 - success, new (fair) tasks present
  */
-static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
+static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;

