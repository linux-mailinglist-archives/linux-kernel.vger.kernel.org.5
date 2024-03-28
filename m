Return-Path: <linux-kernel+bounces-122859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ABA88FE83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C851F260EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD47EF02;
	Thu, 28 Mar 2024 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GZ9lnkX3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QTR7MTbK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E128B7EEF0;
	Thu, 28 Mar 2024 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627280; cv=none; b=JMPdL4zG2M5vhsSybtskGlh84Rd6ANqM2CyHgT1yE2Sh9l6cV24t1rxhTTWlEY7wR2+nHKZs8AqOQCND6cKEqId7zUitZrrb6wI8lcHpkbZBmp0GReuVXjF/8AgPwI6ER3l9Iwb72JREdNBZITsvPTGUS2v2DAoxjqFXZQZml4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627280; c=relaxed/simple;
	bh=wOB2LfjWpNF45aDOCaXSuvmmAgZ/ioyeLxdQfdTJtKw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JcKqVWOZbu7n+igo0ZkJ13P3RvKrw8ExA0RBcZA5kJYbqwVGyvcw+OfvqrlLsXtS+9HkeRRBu9NiOEb3V3ON2t6hXw2SjivhQuabQvEMnVRghq3c06EjtuHIKNfqjTotpknH/f4XzQ7kdjNH6gGcxu2AVYOojPT/ByJE399aLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GZ9lnkX3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QTR7MTbK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Mar 2024 12:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711627269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jP0p65YWOsf77wLgWYhZ/RRn5X7bXK44Gnj/lGgc71Y=;
	b=GZ9lnkX3liD+/1xLsCpe0Wj+Jr90eH3BCCIcx1wNjDM/LG2JB3sdm7kMch1SzZjC1jKk79
	/sBHTiMyFozrJfkRtqpJ/5zqMYS+abyJJ1qVJYxSaj5vX5/9+VuHSF8O5ELljLCTaVwbRu
	googX4S70KjUl/2LNCG76rCUM8wDzVbTpY6Yi+h2CF2gmQwudkdm/x1FbAdCvNoVz2T9uG
	BwZuR8YsamDU8VXEU98XxxchKDpNw0fXdXsJzOJ68VRuKmzqyDZiAZX23dP+TTopPsH/2P
	whTNNS75zogZGdD81ObAENvNsCuFfWB5Bpw6m2SPFZ/VKqZtLlrIz1CSRG1ZSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711627269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jP0p65YWOsf77wLgWYhZ/RRn5X7bXK44Gnj/lGgc71Y=;
	b=QTR7MTbKSsNcVD31a3NHtrUVk+KmTqsrjTH9orwJCU/a3au9mc09jsE6eXaIQFs7IGHf4J
	Yr9FiRCDtOonwHDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename set_rd_overutilized_status() to
 set_rd_overutilized()
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
Message-ID: <171162726870.10875.3148729818855002567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4d0a63e5b841c759c9a306aff158420421ef016f
Gitweb:        https://git.kernel.org/tip/4d0a63e5b841c759c9a306aff158420421ef016f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 28 Mar 2024 11:54:42 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Mar 2024 11:54:42 +01:00

sched/fair: Rename set_rd_overutilized_status() to set_rd_overutilized()

The _status() postfix has no real meaning, simplify the naming
and harmonize it with set_rd_overloaded().

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/ZgVHq65XKsOZpfgK@gmail.com
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 839a97a..f29efd5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6693,7 +6693,7 @@ static inline int is_rd_overutilized(struct root_domain *rd)
 	return !sched_energy_enabled() || READ_ONCE(rd->overutilized);
 }
 
-static inline void set_rd_overutilized_status(struct root_domain *rd,
+static inline void set_rd_overutilized(struct root_domain *rd,
 					      unsigned int status)
 {
 	if (!sched_energy_enabled())
@@ -6711,7 +6711,7 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	 */
 
 	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
-		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
+		set_rd_overutilized(rq->rd, SG_OVERUTILIZED);
 }
 #else
 static inline void check_update_overutilized_status(struct rq *rq) { }
@@ -10660,10 +10660,10 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		set_rd_overloaded(env->dst_rq->rd, sg_status & SG_OVERLOADED);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		set_rd_overutilized_status(env->dst_rq->rd,
+		set_rd_overutilized(env->dst_rq->rd,
 					   sg_status & SG_OVERUTILIZED);
 	} else if (sg_status & SG_OVERUTILIZED) {
-		set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
+		set_rd_overutilized(env->dst_rq->rd, SG_OVERUTILIZED);
 	}
 
 	update_idle_cpu_scan(env, sum_util);

