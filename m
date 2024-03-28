Return-Path: <linux-kernel+bounces-122800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B0C88FD87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFDA294CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3B07D41B;
	Thu, 28 Mar 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TN+C5W4m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2EZVzgSJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7377BAFF;
	Thu, 28 Mar 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623372; cv=none; b=FhQRVqt7BdEi3nwXDBI3fS+NeUoCuieXJ6r6RTISzauEzMu38foSjniVmWQZ5qneZT+mLeqHKX3NEOyLjMMcb+Y93xroS4cMF1BynaqP6PjC0UXW0y0IvCaHi8jIjDwDLup2Ug7lu+vfflRR5rzNxYmxWIjTpeQHx+wokCL8a9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623372; c=relaxed/simple;
	bh=o3cow79llrvVk5cSoNfMQnm8w++hEv4cgtGexS8/E8s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c3niqwhZswaosSvAozCczuO2Z0dZc3oXGwKJGj5snfxkE4FVzKcjdEpOkbJYn+2PqEsqI3KTS9TWEvHLWKR7WImn7nYPDoCoPJh0ciMXHBDcPAXXXw/YV52cm0OVX1jiFYnsNi1/xYfkXWzcfF0rAr31E6r5cKltLNGgC1ZULSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TN+C5W4m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2EZVzgSJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Mar 2024 10:56:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711623368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ko7uZVM1Z5QV4BXSrnVVCvEPdJXVSv0HeGMT9nctmIo=;
	b=TN+C5W4misJaf+0wi3MoHszJQtVpSrmlL5DB9bV3IL2YinqFvP57c4TTw9eyeKLlG1q0Y5
	dc7IgoqzaH/GQJBHzbk5eweP9kzdmS9IEze/oeojtvYD2dgDCW7WClDp3QeGfqjVLV5aYu
	owMLbcmGZJIQ53Ebn8Xw5NJjLy6wi8OLzn3gsWrip/NCeLx1hNqtsYB/RnbxgwBgFBLWPw
	JWQCjAdPyf9+oYRQjzoi0Jx+43QBmOPV6dbemGM3MNqWAFKVy2Q0SQ6az7ltcQz4nxL9kq
	2hNRmQj5KYCVBT85iu+e7xSwvkgH9w77ObNBq0VPvuUbHrE44ih1entNkHJdsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711623368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ko7uZVM1Z5QV4BXSrnVVCvEPdJXVSv0HeGMT9nctmIo=;
	b=2EZVzgSJcV+cCg13q+vxwOFfgR9k4Igq2DqIfKE+hYYJBUUDU1HyYQYYxvzoDixIqh12sn
	PRIaWhSnAHIqQqAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename {set|get}_rd_overload() to
 {set|get}_rd_overloaded()
Cc: Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ZgVHq65XKsOZpfgK@gmail.com>
References: <ZgVHq65XKsOZpfgK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171162336779.10875.12104005368795630494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     76cc4f91488af0a808bec97794bfe434dece7d67
Gitweb:        https://git.kernel.org/tip/76cc4f91488af0a808bec97794bfe434dece7d67
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 28 Mar 2024 11:41:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Mar 2024 11:41:31 +01:00

sched/fair: Rename {set|get}_rd_overload() to {set|get}_rd_overloaded()

Follow the rename of the root_domain::overloaded flag.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/ZgVHq65XKsOZpfgK@gmail.com
---
 kernel/sched/fair.c  | 4 ++--
 kernel/sched/sched.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0cc0582..bf10665 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10657,7 +10657,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		set_rd_overload(env->dst_rq->rd, sg_status & SG_OVERLOAD);
+		set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOAD);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		set_rd_overutilized_status(env->dst_rq->rd,
@@ -12390,7 +12390,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
-	if (!get_rd_overload(this_rq->rd) ||
+	if (!get_rd_overloaded(this_rq->rd) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
 		if (sd)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cddc479..c7e7ae1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -930,14 +930,14 @@ extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
 extern void sched_get_rd(struct root_domain *rd);
 extern void sched_put_rd(struct root_domain *rd);
 
-static inline int get_rd_overload(struct root_domain *rd)
+static inline int get_rd_overloaded(struct root_domain *rd)
 {
 	return READ_ONCE(rd->overloaded);
 }
 
-static inline void set_rd_overload(struct root_domain *rd, int status)
+static inline void set_rd_overloaded(struct root_domain *rd, int status)
 {
-	if (get_rd_overload(rd) != status)
+	if (get_rd_overloaded(rd) != status)
 		WRITE_ONCE(rd->overloaded, status);
 }
 
@@ -2541,7 +2541,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 #ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2) {
-		set_rd_overload(rq->rd, SG_OVERLOAD);
+		set_rd_overloaded(rq->rd, SG_OVERLOAD);
 	}
 #endif
 

