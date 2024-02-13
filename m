Return-Path: <linux-kernel+bounces-64308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C74E853CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A2B28B3E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9DC85292;
	Tue, 13 Feb 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GY2mq/NF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ISgqYSJn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488A84FD8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858368; cv=none; b=E87GPmvlOwNGG4O6cbBO2MaUEWD+80Ehy4KmsA31IV1cqVJCofw4ouQwg6sy2E+gt+daT4moyjMYZH1kkGyzODU6prcjRym5HX9YSLGM5jHSUolAV/Ngluw/37Ap+YFdZ8CaJzPZZGKm9nNYSwt1tv1/jz+D1rph08cSo9ulDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858368; c=relaxed/simple;
	bh=f7TjAfRNJePRvBVh60Mlq3WaXOIueC9RaU3KBd5vNSQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ua+/FUqpGh3ENO6E1U1NyMJtDYJKDMLBIf2AVzxYlNTed53zeXoLg/+HahnCUo++WsXzGPAJG5AoOeW40SKajlZJVS3l9z+nojCCykkeh+MnTlqIPxmXEc5iuM33+Qr0ye9Fo3CQ23KGv5CMdwc5nxK52q6Y+TkklBCvGbazVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GY2mq/NF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ISgqYSJn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.736104257@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TKbUBcNH0EQ/gLK3fnpU18ylL1ck8LsuH2l84iqWPqs=;
	b=GY2mq/NFSPH+GSw6gAmOmCoE9kHYCGw4vM72bnpYhTyDS3u1MHINPu/krM8Jgqc2PmZ9R9
	xBxOT10RrZYSfYiZ39GK4gdvoGjd8zud5fn+Bhccf0dKSQqBwLLAHw8BU8m1VOjDmIILFS
	Maf4nQ7m47HrA0nNfa/zpCgBbDoRqZQNKf0mwtWSSb2NOuTVyxOwYPqjn/U0dktUFLqSgS
	kycW7Q2XO2FvZQpoPrbPdgMl5qjUEj7yBm8ofV2K2RJ5l1oBdi9IqqfAisbCDwxMU5d9+A
	mjIEDB9AT0eLmaLyWcYzMY5bXbr9rtnZyLjFZjCc7WlKSVrNqJqokvmMPWLxeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TKbUBcNH0EQ/gLK3fnpU18ylL1ck8LsuH2l84iqWPqs=;
	b=ISgqYSJnb4ORWJzaBcbYql6oOdFC9OeW55CfrtR04MA+nvxYVpoxTfG1/Dqa+VQTCDYjUF
	3CGlPAMSK89T5mAA==
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
Subject: [patch 22/30] x86/cpu/topology: Mop up primary thread mask handling
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:06:05 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The early initcall to initialize the primary thread mask is not longer
required because topology_init_possible_cpus() can mark primary threads
correctly when initializing the possible and present map as the number of
SMT threads is already determined correctly.

The XENPV workaround is not longer required because XENPV now registers
fake APIC IDs which will just work like any other enumeration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>




---
 arch/x86/kernel/cpu/topology.c |   29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)
---

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -82,30 +82,6 @@ static void cpu_mark_primary_thread(unsi
 	if (smp_num_siblings == 1 || !(apicid & mask))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
-
-/*
- * Due to the utter mess of CPUID evaluation smp_num_siblings is not valid
- * during early boot. Initialize the primary thread mask before SMP
- * bringup.
- */
-static int __init smp_init_primary_thread_mask(void)
-{
-	unsigned int cpu;
-
-	/*
-	 * XEN/PV provides either none or useless topology information.
-	 * Pretend that all vCPUs are primary threads.
-	 */
-	if (xen_pv_domain()) {
-		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
-		return 0;
-	}
-
-	for (cpu = 0; cpu < topo_info.nr_assigned_cpus; cpu++)
-		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
-	return 0;
-}
-early_initcall(smp_init_primary_thread_mask);
 #else
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
@@ -151,9 +127,6 @@ static void topo_set_cpuids(unsigned int
 #endif
 	set_cpu_possible(cpu, true);
 	set_cpu_present(cpu, true);
-
-	if (system_state != SYSTEM_BOOTING)
-		cpu_mark_primary_thread(cpu, apic_id);
 }
 
 static __init bool check_for_real_bsp(u32 apic_id)
@@ -276,6 +249,7 @@ int topology_hotplug_apic(u32 apic_id, u
 
 	set_bit(apic_id, phys_cpu_present_map);
 	topo_set_cpuids(cpu, apic_id, acpi_id);
+	cpu_mark_primary_thread(cpu, apic_id);
 	return cpu;
 }
 
@@ -411,6 +385,7 @@ void __init topology_init_possible_cpus(
 		if (apicid == BAD_APICID)
 			continue;
 
+		cpu_mark_primary_thread(cpu, apicid);
 		set_cpu_present(cpu, test_bit(apicid, phys_cpu_present_map));
 	}
 }



