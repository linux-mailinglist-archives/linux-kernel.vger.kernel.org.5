Return-Path: <linux-kernel+bounces-35365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 988F8838FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D877B2657F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0F664C0;
	Tue, 23 Jan 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+qILiHH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rqc5v9+z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6EC65BDF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015490; cv=none; b=QB/uXZ8B3WQ54sP7S34gob0hcwah2nvnLHu4G4BIi5vTr9DARVC78W2Z5Rnr3ZNYZFVU/OZOy0H1WqyRwgs2ZPsRsIZQjPV4JLlv7MPrJyIWJMU7Kc+I80tATSpAHmGAYU6d5xIp7GWIBAWtQCvPT+sCi36z/DbPuKpnI7dQAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015490; c=relaxed/simple;
	bh=g6J2asPgFD0LMsaQKbG6sg+BTdgOsXYI9ZSt8dfSSUM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=cN8Vct+mJMr4f6YRPtQUhRMwIPxUsXtmfyCBByDNEgMZkvlkiNzdBufcbRHeiFsHVQYi5ShloQ/S4YcwDA1FgDMRuHONdCXXDFVPbqTydstMLJZQGdwFr2qKt6iMS5IWjBjJAyzdaYeJDgrXDv5g/39gBiLK9EpoiV0wb50zjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+qILiHH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rqc5v9+z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.804004114@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MpTsqbRm/7LUvkcxZ0AyD5uJRHhE5ALqrQ6PV/OvYUc=;
	b=S+qILiHHXkAV2EyV12l6SUzg4bOrkeMeqfcxYTq2fGIK9ysa6UCP1cTi7jEqLBzGOuNulh
	+z+uCDx02XhhNOiSvVd7fNoCKVit55iWZuOemkBdVdCOjY3XcNNGeYy+hqI1jF0rn9U75a
	0lMtRAOavZgJQz8sjuMJ6yoyjahHdk1KIH9XOUkTE1wP5jsuiYTWiCtk0MrMLHHBagH8YO
	2FNVh7FaFy9o9uA9pCcJ0bBfQDAM7I8w4QgWXleUr4nDdZhumt9FWtLgBM2TtjZk+ixyW7
	80mhVnWwaMwv2uy/luEbbeb+sFK2haxI/Yh3liGimhxpX4fA1NUYo/Bykm0lOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MpTsqbRm/7LUvkcxZ0AyD5uJRHhE5ALqrQ6PV/OvYUc=;
	b=Rqc5v9+zUQ+oABH3eVS3CDpEx390ImF/uMcW41yMzYE6744komWHBhxtLZ2WoumUxO5ViX
	nB9JP7YfNF+lv8CQ==
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
Subject: [patch v2 22/30] x86/cpu/topology: Mop up primary thread mask
 handling
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:26 +0100 (CET)

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


