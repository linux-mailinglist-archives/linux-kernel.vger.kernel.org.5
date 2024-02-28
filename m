Return-Path: <linux-kernel+bounces-85761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3538386BA66
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37D628711F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BFE15F303;
	Wed, 28 Feb 2024 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WewddyJg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+w2OuNeS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C350976F05;
	Wed, 28 Feb 2024 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157620; cv=none; b=FW6y/1iSt7xg4QMqshq9IUBI4hTY54Pd858IwDb/PAeTr7JKN7IA/ujYSe8U2NT+1ZmgNQCWHdjxU2ixvewTlhv4KeLyBvWsGxPmVX8iZJCme3FNVIfykJrRdYMAErtZ65YAKKdk/gYbW00PABiufsjAT9LL5LTATjd+GhgizGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157620; c=relaxed/simple;
	bh=9emDvAedWN9rmRR8bDr15NnduJ46OtPj/3ek5td6ug8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Eu5DP4SqTe234Ujfn+NvK/tUtKBAJjJNHLBapuNTYQ6zzIpF7eoCjrEOpf01o+tG3+rHqVVGSlG3tRatVYX6gNakLk0545f4vxeBRi7wpoDOHXK2OwWk7d03rvcoQyWAO6ddgBBLPiZj/H2zsE7TV3orOt6DH6wwO2g+LXvgEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WewddyJg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+w2OuNeS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHm2ZDW4tzn8fmxKIYL7cBPEc1EwE+EhSY93r1nFsdk=;
	b=WewddyJgQ9MSvxNWR40aXe4p5GU99RvzJC/6M23o88uBKybOY+53gizfY/5fW/vYKmyxmj
	2Xl/kn6g5iLaUQlWm/n5hVPMXlRvcvI19Wcv3lkZKxSZK5sxsdrRVdhMOzj9oeAm0g8AzT
	0gdWluAzEBeJghGrHNLS73lagpQK/ZgNw0r8RIdHlg9tBe/6T65uULD5bu5BhtMXfc7EQa
	Eaw5nuYo/zMktTO47hhO6Q7xJoWrn8AF7/S3Z90uAp0jiF+91Kjg3UV0a0zRZaLqtSKp4M
	vfWaAsduXNfLxwif+8E1sk5lMllCUQoMefPzVseVWspkzzBh4vG4WJrOIOnDLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHm2ZDW4tzn8fmxKIYL7cBPEc1EwE+EhSY93r1nFsdk=;
	b=+w2OuNeSMH6GRZaIJbA8v1SPl3+FxAI3C4cAXHMP8lvy5eYtlYq0lCBa+0//JF4rHZICJE
	591YpWTXnOIB2SBg==
From: "tip-bot2 for Keisuke Nishimura" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Take the scheduling domain into account
 in select_idle_smt()
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
 Julia Lawall <julia.lawall@inria.fr>, Ingo Molnar <mingo@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240110131707.437301-1-keisuke.nishimura@inria.fr>
References: <20240110131707.437301-1-keisuke.nishimura@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915761137.398.9006530576239959101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8aeaffef8c6eceab0e1498486fdd4f3dc3b7066c
Gitweb:        https://git.kernel.org/tip/8aeaffef8c6eceab0e1498486fdd4f3dc3b7066c
Author:        Keisuke Nishimura <keisuke.nishimura@inria.fr>
AuthorDate:    Wed, 10 Jan 2024 14:17:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:15:48 +01:00

sched/fair: Take the scheduling domain into account in select_idle_smt()

When picking a CPU on task wakeup, select_idle_smt() has to take
into account the scheduling domain of @target. This is because the
"isolcpus" kernel command line option can remove CPUs from the domain to
isolate them from other SMT siblings.

This fix checks if the candidate CPU is in the target scheduling domain.

Commit:

  df3cb4ea1fb6 ("sched/fair: Fix wrong cpu selecting from isolated domain")

.. originally introduced this fix by adding the check of the scheduling
domain in the loop.

However, commit:

  3e6efe87cd5cc ("sched/fair: Remove redundant check in select_idle_smt()")

.. accidentally removed the check. Bring it back.

Fixes: 3e6efe87cd5c ("sched/fair: Remove redundant check in select_idle_smt()")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240110131707.437301-1-keisuke.nishimura@inria.fr
---
 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ba36339..005f6d3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7311,13 +7311,19 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, int target)
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	int cpu;
 
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
 		if (cpu == target)
 			continue;
+		/*
+		 * Check if the CPU is in the LLC scheduling domain of @target.
+		 * Due to isolcpus, there is no guarantee that all the siblings are in the domain.
+		 */
+		if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
+			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
@@ -7341,7 +7347,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core, p);
 }
 
-static inline int select_idle_smt(struct task_struct *p, int target)
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	return -1;
 }
@@ -7591,7 +7597,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		has_idle_core = test_idle_cores(target);
 
 		if (!has_idle_core && cpus_share_cache(prev, target)) {
-			i = select_idle_smt(p, prev);
+			i = select_idle_smt(p, sd, prev);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
 		}

