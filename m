Return-Path: <linux-kernel+bounces-122793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 603A388FD5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919A81C22DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBC27D3F7;
	Thu, 28 Mar 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oEk4sk8o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C4fBBf7S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1481754737;
	Thu, 28 Mar 2024 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622859; cv=none; b=Qs20FZ3ZA8sBp9mlFDfEZs1ykzMpfk7aExa4DOoB4oa81iB2uFyn5Lxr5jYGhsc20tXhLJi0VFs3OR/BI/oaQnCggHzeNppZWiPJZxkeLQUnsncPfUVkINu32Ph+b9AGGuhtUhlfT5HwjXdme97aAOO5wpvCvOEPFptUhbvdxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622859; c=relaxed/simple;
	bh=2vQco+yJ0y/o5C/0p+dH62rurW30gI6ZQUTv0qzcj+s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j1/gFDu4eivqAhwbvL1RirOXjyG4KxC7l3MQ5nLKNz/J9U4A86gj6v0xyw8h+5vdJ3fvJ/pY9hZffo4bgOeV69uyqvwBqnaNl9wrmHf33opr/HSfFwbi3TzknE7lvHJezaqAn0TLN8T5ds15rDiAoEj4MCtu/8aZYSMhNWbyJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oEk4sk8o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C4fBBf7S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Mar 2024 10:47:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711622856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwgDV4oV1M7lwRW7xJmWs3ZsANnNq1v+IZybUanyPQ4=;
	b=oEk4sk8o1U0+RyIGXg5jLOAcUsC2G8O0gTwSysnpxKWmKgZzy8i9saXifSXOryPkjfZy0i
	UOYI2Zo314f3NfmjYy6n2weZMwP6dk62wPS5jVqsoQl800dKkcOSmvYzsoRjb9yv67OZyw
	dBpB9pDY8wLTQO/4DrliWEksg6tugyutKbyVNN6tiw3dbJDmUKHzb/t2+svixn7YYnAhEb
	XcrOP/OVD16QkjBEPq7LfKY8GRBCbrDn4B2iiGuiosC15I7g6GLQBG1ndEOk+t9Jz2Zl9E
	2csBX9N3AzSpMwu2v8SBxcrB41Fl+w1NTRfgxjCxgAastdk2EPVNS/8dph4VUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711622856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwgDV4oV1M7lwRW7xJmWs3ZsANnNq1v+IZybUanyPQ4=;
	b=C4fBBf7S6ALnOdCssbKAoK/Qg+gLLFjT/7Pb/riLuL/zJL6nf3FiOSzwa2yGv0KQYTQ5qr
	oIM5Op2Tga6KIyCA==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use helper functions to access
 root_domain::overload
Cc: Qais Yousef <qyousef@layalina.io>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240325054505.201995-3-sshegde@linux.ibm.com>
References: <20240325054505.201995-3-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171162285539.10875.9756096436718882314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     caac6291728ed5493d8a53f4b086c270849ce0c4
Gitweb:        https://git.kernel.org/tip/caac6291728ed5493d8a53f4b086c270849ce0c4
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Mon, 25 Mar 2024 11:15:05 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Mar 2024 11:30:13 +01:00

sched/fair: Use helper functions to access root_domain::overload

Introduce two helper functions to access & set the root_domain::overload flag:

  get_rd_overload()
  set_rd_overload()

To make sure code is always following READ_ONCE()/WRITE_ONCE() access methods.

No change in functionality intended.

[ mingo: Renamed the accessors to get_/set_rd_overload(), tidied up the changelog. ]

Suggested-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240325054505.201995-3-sshegde@linux.ibm.com
---
 kernel/sched/fair.c  |  5 ++---
 kernel/sched/sched.h | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 600fdde..0cc0582 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10657,8 +10657,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
-			WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
+		set_rd_overload(env->dst_rq->rd, sg_status & SG_OVERLOAD);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		set_rd_overutilized_status(env->dst_rq->rd,
@@ -12391,7 +12390,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
-	if (!READ_ONCE(this_rq->rd->overload) ||
+	if (!get_rd_overload(this_rq->rd) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
 		if (sd)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4f9e952..e86ee26 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -930,6 +930,17 @@ extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
 extern void sched_get_rd(struct root_domain *rd);
 extern void sched_put_rd(struct root_domain *rd);
 
+static inline int get_rd_overload(struct root_domain *rd)
+{
+	return READ_ONCE(rd->overload);
+}
+
+static inline void set_rd_overload(struct root_domain *rd, int status)
+{
+	if (get_rd_overload(rd) != status)
+		WRITE_ONCE(rd->overload, status);
+}
+
 #ifdef HAVE_RT_PUSH_IPI
 extern void rto_push_irq_work_func(struct irq_work *work);
 #endif
@@ -2530,8 +2541,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 
 #ifdef CONFIG_SMP
 	if (prev_nr < 2 && rq->nr_running >= 2) {
-		if (!READ_ONCE(rq->rd->overload))
-			WRITE_ONCE(rq->rd->overload, 1);
+		set_rd_overload(rq->rd, SG_OVERLOAD);
 	}
 #endif
 

