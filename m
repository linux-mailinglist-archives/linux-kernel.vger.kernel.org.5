Return-Path: <linux-kernel+bounces-64291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A078853CD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448EF2863C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5017C6DF;
	Tue, 13 Feb 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PmjxtYAv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="of649M5e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C17C09E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858345; cv=none; b=bMcaWqVNuV41pt2XWg0if/9CBHoCFm5VorTyRYG9xizvF9JVp005L/TzvDlJlacj15VeomIybp1eZN9ua1OEovHrlYpQh+yqV6gqcMxReOK7vFbVsWI/evgkpU+voHj8miOngx3LpLuFNc90o/lwdMFoWaAFIAdC7QkMACwO2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858345; c=relaxed/simple;
	bh=2f2NQCXjq+Qw8tOS36sojhoEEm2F5eey1xvfWfOcfQA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jCNC318lNlRCWYc1ROWVRUnoZB0drAB/N35RLtf7JpM3SaeYWa50c/T3IXmyrh5W9edWJ8PNjVwgVHHMYwFWnI+MQrwdQEnuKAjWgYr1qKWmwi93VUGC5+0+43ifdFv0VKryWY4MR48foZ7UtXukwrW5znR/6+ziPe6ZI4EPhK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PmjxtYAv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=of649M5e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210251.830955273@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QKxEGyGg+k5hdg4U9ew42w42evdPmIVY0idUHE//9Eo=;
	b=PmjxtYAv/KDE7FBsI2oGtSa/LXG7fn32Z0EncKnxIjzchDGpDv8SvNcpgg2Dn22KGvvSZY
	ZY65lMjWRx1CoEwScUSRVRGnTxeCTYbxy0WLxenC7Pwu2fG0CI19GtNA5hWW+XfO/DHBRk
	WfZny675wTx6m4CL+nMBOdRQSJG0/j+CVuzUsdWX5ZmxTyWLuEKZzivGFu3A5fqEdeSN6c
	5iUGY1bS22MFJTNyW1F+IYFSooyfhLummo57bn4q8AnFmVBJznFlN0/XO2XpNCQa/cmX//
	i4naTJok4iWC24E8zKkL9vritlJfqjFxDUA7oKj0WSzCXgZvpQcRHlPCz77iUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QKxEGyGg+k5hdg4U9ew42w42evdPmIVY0idUHE//9Eo=;
	b=of649M5eUBoq4aB75ZUOHpRFlz8D3kS17KTcuLtDTpVBmcyrQs4OHxaw85lThZhXODeuXD
	oOiwq5eU5mMKJJDg==
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
Subject: [patch 06/30] x86/mpparse: Use new APIC registration function
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:42 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Aside of switching over to the new interface, record the number of
registered CPUs locally, which allows to make num_processors and
disabled_cpus confined to the topology code.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/include/asm/mpspec.h  |    2 --
 arch/x86/kernel/cpu/topology.c |    2 +-
 arch/x86/kernel/mpparse.c      |   17 +++++++++--------
 3 files changed, 10 insertions(+), 11 deletions(-)
---

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -61,8 +61,6 @@ static inline void e820__memblock_alloc_
 #define mpparse_parse_smp_config	x86_init_noop
 #endif
 
-int generic_processor_info(int apicid);
-
 extern DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC);
 
 static inline void reset_phys_cpu_present_map(u32 apicid)
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -133,7 +133,7 @@ static void cpu_update_apic(int cpu, u32
 		cpu_mark_primary_thread(cpu, apicid);
 }
 
-int generic_processor_info(int apicid)
+static int generic_processor_info(int apicid)
 {
 	int cpu, max = nr_cpu_ids;
 
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -36,6 +36,8 @@
  * Checksum an MP configuration block.
  */
 
+static unsigned int num_procs __initdata;
+
 static int __init mpf_checksum(unsigned char *mp, int len)
 {
 	int sum = 0;
@@ -50,16 +52,15 @@ static void __init MP_processor_info(str
 {
 	char *bootup_cpu = "";
 
-	if (!(m->cpuflag & CPU_ENABLED)) {
-		disabled_cpus++;
+	topology_register_apic(m->apicid, CPU_ACPIID_INVALID, m->cpuflag & CPU_ENABLED);
+	if (!(m->cpuflag & CPU_ENABLED))
 		return;
-	}
 
 	if (m->cpuflag & CPU_BOOTPROCESSOR)
 		bootup_cpu = " (Bootup-CPU)";
 
 	pr_info("Processor #%d%s\n", m->apicid, bootup_cpu);
-	generic_processor_info(m->apicid);
+	num_procs++;
 }
 
 #ifdef CONFIG_X86_IO_APIC
@@ -236,9 +237,9 @@ static int __init smp_read_mpc(struct mp
 		}
 	}
 
-	if (!num_processors)
+	if (!num_procs && !acpi_lapic)
 		pr_err("MPTABLE: no processors registered!\n");
-	return num_processors;
+	return num_procs || acpi_lapic;
 }
 
 #ifdef CONFIG_X86_IO_APIC
@@ -529,8 +530,8 @@ static __init void mpparse_get_smp_confi
 	} else
 		BUG();
 
-	if (!early)
-		pr_info("Processors: %d\n", num_processors);
+	if (!early && !acpi_lapic)
+		pr_info("Processors: %d\n", num_procs);
 	/*
 	 * Only use the first configuration found.
 	 */



