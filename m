Return-Path: <linux-kernel+bounces-100202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95789879380
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366E6B21119
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0490779DDB;
	Tue, 12 Mar 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MhCoOfXA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e7UrunNh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114E79B9B;
	Tue, 12 Mar 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244822; cv=none; b=rUZzbNzSQTfGcJYEUNCxmo6QFflY7vZJ4GsUdNtC+uEjRHxKR1tEpPchcLCefFc3TIrTVi8DGZEDNm8o9FVafV37d7OSg0jVt8UsuBDh1IdfT8E/z4dY2TZ5Omyqj1Y+18z8JA4OMbJX0ETREUXGLmWi4zLC6bFKoBIefnVWDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244822; c=relaxed/simple;
	bh=v0hv7sduDpVvlHwqpVb0Dpchl23luLw9eUQRFFsz2Cs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MU5ypWHid3O1/cxMfNtVmedc1eZCwIepP6SgGH4gcL1zBHbRS5kJdvnGhJ957D+Rfbjr69UliJXi9f9K/eQf9QK5ySxfaHl08AcjsSbRNnT3R6u0k71vpFF5MeXStNVoWut32Nli3jWkrXzsQuBXH6pdshECLAseMp6Z6aIhhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MhCoOfXA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e7UrunNh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 12 Mar 2024 12:00:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710244819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/XIY7++yUOkom3Z43lhbUS04fROMAoyOpQ6RGjet9E=;
	b=MhCoOfXAESGG7aiiMhTGB/FdvbHX9x173Jx1vpeViOcJ/yXd2Qr0sI3wnm2OjUmkJcHiJG
	L/s17HJxAoYEEp2943bsVaNEAftEkFQIPIf3OkjdF/g6EOw4hEPDWlaEJb3udENheeeDUO
	6puTQ31ZzoI3ZsoYUz485t2BSkDQXd7jXt/yuSqqXiciZvV+0xT1I73cb9fdx2M9P1ST3F
	9A/pf5OX54QzPaP9BopEyhbTEEmyCaVIAm9Smk8xJhbeN2at49gmNcZl9q7I2MFPSajgXC
	nMtDF4LOCCsuLBx+U8lsK4Aip/AzqVlHsfPiTtuFoWy4dNW+SiUih7Dc58NKWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710244819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/XIY7++yUOkom3Z43lhbUS04fROMAoyOpQ6RGjet9E=;
	b=e7UrunNhYXsDSA7aY1+qtROJXLDY6QJJO1ZRBfj8Dm5OqSP2Oc301tp7KkFG7Q+/K7Z921
	pqQGKT9ckMSAW9CQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balancing: Rename find_idlest_cpu() =>
 sched_balance_find_dst_cpu()
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240308111819.1101550-14-mingo@kernel.org>
References: <20240308111819.1101550-14-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171024481845.398.6678071993830758312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     686d148cbb5a1c2891914b8d11147d3c5556a29a
Gitweb:        https://git.kernel.org/tip/686d148cbb5a1c2891914b8d11147d3c5556a29a
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 08 Mar 2024 12:18:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 12 Mar 2024 12:00:00 +01:00

sched/balancing: Rename find_idlest_cpu() => sched_balance_find_dst_cpu()

Standardize scheduler load-balancing function names on the
sched_balance_() prefix.

Also use 'dst' instead of 'idlest', because it's not really
true that we return the 'idlest' group or CPU, we sort by
idle-exit latency and only return the idlest CPUs from the
lowest-latency set of CPUs.

The true 'idlest' CPUs often remain idle for a long time
and are never returned as long as the system is under-loaded.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://lore.kernel.org/r/20240308111819.1101550-14-mingo@kernel.org
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d0c3a09..4b3c4a1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7160,7 +7160,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 	return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
 }
 
-static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p,
+static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct task_struct *p,
 				  int cpu, int prev_cpu, int sd_flag)
 {
 	int new_cpu = cpu;
@@ -7936,7 +7936,7 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
  * NOTE: Forkees are not accepted in the energy-aware wake-up path because
  * they don't have any useful utilization data yet and it's not possible to
  * forecast their impact on energy consumption. Consequently, they will be
- * placed by find_idlest_cpu() on the least loaded CPU, which might turn out
+ * placed by sched_balance_find_dst_cpu() on the least loaded CPU, which might turn out
  * to be energy-inefficient in some use-cases. The alternative would be to
  * bias new tasks towards specific types of CPUs first, or to try to infer
  * their util_avg from the parent task, but those heuristics could hurt
@@ -8201,7 +8201,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 
 	if (unlikely(sd)) {
 		/* Slow path */
-		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
+		new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);

