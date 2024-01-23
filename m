Return-Path: <linux-kernel+bounces-35349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B27838FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BCD1C23B87
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D1A6310F;
	Tue, 23 Jan 2024 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KB9ghnAb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HaL3lWct"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BCC62A05
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015463; cv=none; b=EDluDqXpGk6P1GNZDOkJCmo937EmUvi5hK8dXwN3yrL2JWEV0ndEW+qG1jOty3UxdbavojAnsoWslfrjsl1HS9uJB1qoziFjiK1xxfT/5o4VXl5cMfV1PWXcHie6GwixHSUVgq+uMLt8L7AMPe99uO/RrRLzBHYIV9X5TRhb0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015463; c=relaxed/simple;
	bh=1w/o7YVIWiDXvAdCfShv+rwlB99SYN+vDUkSBlSoNGg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rc6X/oj0e6taTrfaCX7QRHmmNkJADihp461E4mxnxYAQaVdNrqmNEngpXQVTFYg4ERIRHUjOaeFTWlrRT6L2AmKpiC9qTQzkUrQUGrUQFcLVjCYA3y3u2dON5n9xrrlHwWM9maGnGiQaXKgHRp94zKTVvrniaOSNOku2ir+4hgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KB9ghnAb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HaL3lWct; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123648.892104721@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uc7KzIR0wfn9fEJS+nF/aoHz/Ptcj21sdxZ0GDH72RI=;
	b=KB9ghnAbVHu6c0rULM5mVI87g5j9NdUf9C/SeASe67VOCa4IC7lfpw+i7eD5jCHsk1UYEA
	f2yRbsWtqoBy5N8xGxJD/eU9AGobY5cfndJXvEDHQIw8sAFx9AJbdaLE2kUk41m1ksRwQS
	/01IkP+1gYYxb0AVK7UGoYJjoeFj7twG0eZ4zsoLhhNsff4Jd0hzpcA7uh8TUNlmpA8c+r
	vbPVChXl49M03mkLxDEokkFvacXaZzj1APVPo8djbGEP1AE7IC53pakMMeoPvb4fk7Q/M8
	XKd6wp5vf256TQz/pE/5E0WnVXpVZ3IFxQcAAumYQf4tiHnW0FybzKTCVy/uYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uc7KzIR0wfn9fEJS+nF/aoHz/Ptcj21sdxZ0GDH72RI=;
	b=HaL3lWct14EJ7o5vNDntKZzxkdA9qICGd2XKSNAma8Izsux2JjR8/DV1WY2et7uY4zopIN
	a/gQO3+bd8/6n6BQ==
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
Subject: [patch v2 06/30] x86/mpparse: Use new APIC registration function
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:58 +0100 (CET)

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


