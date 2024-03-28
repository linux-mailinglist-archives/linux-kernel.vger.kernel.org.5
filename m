Return-Path: <linux-kernel+bounces-122794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9659688FD5E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF375B23EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33B87D40A;
	Thu, 28 Mar 2024 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i4VpQc7W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0GQ3z+k/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F19548ED;
	Thu, 28 Mar 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622860; cv=none; b=Q5gapA8fVOmtbKkXA195Y/DznYCx022AUn2dDAU6b1w1tNkW4tUkGKKx58Nz5GbIlxXTcUT5uBTIdLevOlr9Vh7FjDviZBxoNmDTXicPM4/eit/Ip0u86bkeSgQ44OCEntKgxZxqD+Kwp2O5obQFIWJJLmQUqSoLXeTD7yKsu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622860; c=relaxed/simple;
	bh=1lWqY7ww+03iHVlLjQ4XgDXJv22CG5zhP/Hot8DPtEo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zm1IksnNR48WDaFjDTSQ1j6zqJ3Ax7ZM/Kx7Xqh8QCjLvNal+lim2G4uWm7DqT9gQFyDlL3CiKKxBb6vMUkBSpKurLSPjOoRotxw/RD++M7KyaUof4ZENidl9TM0mJu0gZpiDEjHSX4FmhyTRJoLNs09GNW+s/NwhGIZLPvKm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i4VpQc7W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0GQ3z+k/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Mar 2024 10:47:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711622856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2QPzRuhw07tXH8Qd2OrMZkRj3Gca3fhPoDDAvZZ/sg=;
	b=i4VpQc7W8FE0ZzEEnnRKfvg2uPaXYGzWnEQqGfJQBe1WavSFU194KvpJxrUiaV2Ojy6rIk
	48ss/I8uzrNSfEdxLAzOi+V+F7+FRrkLwP16n7sz+zpm7Etwuf3sgQ5TT5qX4TMQTgSVLC
	Q9F54rleIie8L1qwHBftjaBiALgoS2ITvyNtjCPCBkMbQOXd9LnCn6DiWyop2eSBEeEdB/
	MSnjIUeZ4P6mbxvzJrFtJA3oFPDPVfKZGf3+Vhpd0mqbFUW6A1F7LwxCI76xThl2YWxsMQ
	9kuXgthBc6bJcAcYeXgTaCyXxsFPTWo3nval1s9oQY9kaY3LJVE3bF1nLzrYHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711622856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2QPzRuhw07tXH8Qd2OrMZkRj3Gca3fhPoDDAvZZ/sg=;
	b=0GQ3z+k/w7bPCJtyOBoEAIOsCHM5CyuPiwa8WtDjMBqwjK8MF2n2RJzDkurp9ASvpBLzDV
	uJlG4ymqoU8bRFCQ==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Check root_domain::overload value before update
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Qais Yousef <qyousef@layalina.io>,
 Vincent Guittot <vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240325054505.201995-2-sshegde@linux.ibm.com>
References: <20240325054505.201995-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171162285612.10875.3210405155539598767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c628db0a6831f80e89873ee44f1b40e3ab3216c6
Gitweb:        https://git.kernel.org/tip/c628db0a6831f80e89873ee44f1b40e3ab3216c6
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Mon, 25 Mar 2024 11:15:04 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 Mar 2024 11:30:13 +01:00

sched/fair: Check root_domain::overload value before update

The root_domain::overload flag is 1 when there's any rq
in the root domain that has 2 or more running tasks. (Ie. it's overloaded.)

The root_domain structure itself is a global structure per cpuset island.

The ::overload flag is maintained the following way:

  - Set when adding a second task to the runqueue.

  - It is cleared in update_sd_lb_stats() during load balance,
    if none of the rqs have 2 or more running tasks.

This flag is used during newidle balance to see if its worth doing a full
load balance pass, which can be an expensive operation. If it is set,
then newidle balance will try to aggressively pull a task.

Since commit:

  630246a06ae2 ("sched/fair: Clean-up update_sg_lb_stats parameters")

::overload is being written unconditionally, even if it has the same
value. The change in value of this depends on the workload, but on
typical workloads, it doesn't change all that often: a system is
either dominantly overloaded for substantial amounts of time, or not.

Extra writes to this semi-global structure cause unnecessary overhead, extra
bus traffic, etc. - so avoid it as much as possible.

Perf probe stats show that it's worth making this change (numbers are
with patch applied):

	1M    probe:sched_balance_newidle_L38
	139   probe:update_sd_lb_stats_L53     <====== 1->0 writes
	129K  probe:add_nr_running_L12
	74    probe:add_nr_running_L13         <====== 0->1 writes
	54K   probe:update_sd_lb_stats_L50     <====== reads

These numbers prove that actual change in the ::overload value is (much) less
frequent: L50 is much larger at ~54,000 accesses vs L53+L13 of 139+74.

[ mingo: Rewrote the changelog. ]

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20240325054505.201995-2-sshegde@linux.ibm.com
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3846230..600fdde 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10657,7 +10657,8 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 	if (!env->sd->parent) {
 		/* update overload indicator if we are at root domain */
-		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
+		if (READ_ONCE(env->dst_rq->rd->overload) != (sg_status & SG_OVERLOAD))
+			WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
 		set_rd_overutilized_status(env->dst_rq->rd,

