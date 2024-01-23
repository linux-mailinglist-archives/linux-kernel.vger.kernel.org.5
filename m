Return-Path: <linux-kernel+bounces-35366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B090838FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A4AB26554
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053FB664D8;
	Tue, 23 Jan 2024 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4gZenHUW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ff6/QnPC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646F664AE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015491; cv=none; b=SwvBMBm8JEn+TTp2mObJlwqi+rMEM3tV58t8ZPzC7gL2t0vY9WLLRHPjEojBBe1bvbqFhYUwH/vGnGeDrYTB5JXpVkCkPDzCn+6bPqVy7Ze8sX8QSLb6MqnIPWVJraxAZjOB/9onR4ptNRftR0dMHK1amBshfQhh/fgwbAhYU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015491; c=relaxed/simple;
	bh=Vn7gdV4WGfNx8aLyfIUr6q7nCYaATvUyyo4XK/qBAf4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rK/PQUVfd5WsXkWU4y+SBZGzfK5sLHb0ZWpGB9wmzJw1gYR6ovjsV3TEMkLEC7d8hq8KCPsUNk/WsFbBjycZqHF5bTcngR3CUhEAzJtVb0Bj5FAUblSl41/k8Kk22wzcZ1+insDiE4UvIANmmimrTVNvwahmKzqzeAhHNJBgSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4gZenHUW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ff6/QnPC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.859589066@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=z/7LKCK271zDhMePtD3LaOENCMpQvaSbIcr3vh7U/p4=;
	b=4gZenHUW0ZHyHU3KWNiCXBMCFACsK53OVjQX9jUZUSscAx4rIvzHJVeKv5GIE9CaAWlncs
	3Q9vLvSZj/9xhzeN0CZ0YKuV8Tu+87X/CLHfWofGjWdRBkmCPrYUrzfCCK58wfwYUd38ju
	zvfsuQE9g1JM4MzLb1iiB6QBOO9YhKDXldJJZdc6pShpXU08rYZMKEwJ6U4YYsCPFHvu8t
	IqbUDmsvwIg8ojXMRNGaaixZZUB6kLBXGzpLmStnFugpjp+e9dQOUNMn7sRbPrFoQKeol3
	PA9o+UAJ2MbuMzsekI+MiYXfwxWF3aN55Gd0daA/cZXfc9ufp911/JI7NsbLNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=z/7LKCK271zDhMePtD3LaOENCMpQvaSbIcr3vh7U/p4=;
	b=ff6/QnPCcCoCzV9cCY8Xb/KjEKlFohr0aBbSm4BPQJMXVngYfhiyEygy4Q14b6cozzKvP0
	srY35JEAdoPwjMCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v2 23/30] x86/cpu/topology: Simplify cpu_mark_primary_thread()
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:27 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

No point in creating a mask via fls(). smp_num_siblings is guaranteed to be
a power of 2. So just using (smp_num_siblings - 1) has the same effect.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>



---
 arch/x86/kernel/cpu/topology.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
---
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -76,10 +76,7 @@ bool arch_match_cpu_phys_id(int cpu, u64
 #ifdef CONFIG_SMP
 static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 {
-	/* Isolate the SMT bit(s) in the APICID and check for 0 */
-	u32 mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
-
-	if (smp_num_siblings == 1 || !(apicid & mask))
+	if (!(apicid & (smp_num_siblings - 1)))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
 #else


