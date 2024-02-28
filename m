Return-Path: <linux-kernel+bounces-85756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFB786BA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F35EAB28477
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B7A7D06A;
	Wed, 28 Feb 2024 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwo4QFEn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2vKFEeQr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F416C7291E;
	Wed, 28 Feb 2024 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157618; cv=none; b=iERL9uebCGmtlQVMilSjLrjwlHGwtUHwgptL++i1yCcZ1jX9oO34rzWOhFLdpqIuBSGWbXNisgDH5IZGF4PJraLRqheqt3RLCJnuC2bRiiZPbM+2euTr2xsQmSSyspH7Y7dNkRG64iM0wEtpWSruwLaR6W7ZC9rU3T35WiAGXII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157618; c=relaxed/simple;
	bh=ODJIhAp5TVgGPr0dRW90JNCR+6Uyvwlt5OWajFgQlWQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qbwqWn8V2JlW2/WHAsXhFhKoJza/Cli5yjtQAGXmT996AfbLdnmhtOebwNRtqOoYTZ+g5ClQKCXj2P7lvRo7f0LuwB7o2Eh2LKWqhZTtF/lmcMJWTtEGtgzwhEfmwFbY12jnMCeKHxCQvnbgvnmihYEToiKQQQdMmNHOdqBwfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwo4QFEn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2vKFEeQr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157611;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnS6UuJmBMH7/430zXS4EIQRF1tEAu6qefk+hRUXSUs=;
	b=cwo4QFEnNBpELvU7EUw+sU0YXJCjv3vnVDWBS7Yu5AvyKRL27cOkmKZpGMxMtpVcq9b2P+
	KLuVauTsebRGSMztcFgCjdMEcpriXPyKiD4zdYCOWIWWzYi2n4OnQxGhqZdUgTbYXJoi6k
	povhzBKEB1iRM/1jBExHAfK4txSFgxkaKxdpg8Owzjloc5f0nCF/Pd7P6mBU6OWgWWQMpq
	ACZ402AvcfguGk6xxUnafLH2w6UBTXolGjM5adEv/pKGfSaiUvULLvRKHxxMj0cldGtYJJ
	Cy1+yrnPALJ3ctrQ3sUzjxknRmuLqzSlpI4ckl5UvJuRF9HFGGuxh9kzcbytjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157611;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnS6UuJmBMH7/430zXS4EIQRF1tEAu6qefk+hRUXSUs=;
	b=2vKFEeQrnvfxn17WngBV/T9ZCSd3kiegv6ClmNX5hjYdEJL9xj4mx8p1j/F/iX/d54DI4n
	CYvtdxQYBlx6QtCQ==
From: "tip-bot2 for Keisuke Nishimura" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Take the scheduling domain into account
 in select_idle_core()
Cc: Keisuke Nishimura <keisuke.nishimura@inria.fr>,
 Julia Lawall <julia.lawall@inria.fr>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240110131707.437301-2-keisuke.nishimura@inria.fr>
References: <20240110131707.437301-2-keisuke.nishimura@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915761064.398.16226994228942102834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     23d04d8c6b8ec339057264659b7834027f3e6a63
Gitweb:        https://git.kernel.org/tip/23d04d8c6b8ec339057264659b7834027f3e6a63
Author:        Keisuke Nishimura <keisuke.nishimura@inria.fr>
AuthorDate:    Wed, 10 Jan 2024 14:17:07 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:15:49 +01:00

sched/fair: Take the scheduling domain into account in select_idle_core()

When picking a CPU on task wakeup, select_idle_core() has to take
into account the scheduling domain where the function looks for the CPU.

This is because the "isolcpus" kernel command line option can remove CPUs
from the domain to isolate them from other SMT siblings.

This change replaces the set of CPUs allowed to run the task from
p->cpus_ptr by the intersection of p->cpus_ptr and sched_domain_span(sd)
which is stored in the 'cpus' argument provided by select_idle_cpu().

Fixes: 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240110131707.437301-2-keisuke.nishimura@inria.fr
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 005f6d3..352222d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7289,7 +7289,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu = cpu;
 					break;
 				}
@@ -7297,7 +7297,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 

