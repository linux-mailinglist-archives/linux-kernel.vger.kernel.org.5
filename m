Return-Path: <linux-kernel+bounces-64300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE34E853CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760DD286358
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E638C81755;
	Tue, 13 Feb 2024 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rs5MXGF8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zvwylgMe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8CC7E76D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858358; cv=none; b=mkt7Js0pDgu7STYrqYyBZd2MqCg+h4i0e6TwsR5BPmX+6KAAwbJIeHhpNtheToF7K2UmumBZdFEQi4qUJW3HwZX3QQQjEpQ8pdGehQl4molB6u3rD/76KyuEbopMCPDnvW7x9oc0uknNWg6upWBMEgGqxvUfQRvd3MslKeI5fdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858358; c=relaxed/simple;
	bh=JTW4jUF4bw2Z2J20O1fkn2NaWfwrPB/09rDVcEOBOes=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=p31pPr0i2uZTFy5pfrIGieTD8fEKTbCOqp47h1gh0dKVdJJqpw5oM7+V27So2RO9Pt1UF2O5dN00CrFCCNSqNeGwZq+0Meq/yZr4aSGptysIc+2NRj8gQNob+qYESTKF/vu5Pm1309+821X3BidwX0T7vTYAbUXypzwgSxYHa7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rs5MXGF8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zvwylgMe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.348542071@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aFAX03aVjPEmwT7UTyknP3rbEgKma3/xTYdPSINFEHc=;
	b=Rs5MXGF8uXTwvniXF6SbnjdNWiY8sy/waZLfu5BufIwoR3McA7WP4mxWiKV009K4feCsO7
	qQ55lmQrcc3CZqamUhF5yAf40LIuK/zr7CyEHeiharomLma1KiniyrXIpcbn8SKB+G6p2t
	j5ieNNh4a03gu2YQTDx0z8tltygkpQ7zmiPiNNZP0ZWMhOad4GkLAWUNIAQEQXRaQeTLzm
	6QElRGLDgRAnkClP2bPYECoMjHFMyd7ZVWXi3lLzJ04MjvRki1wRZ3PULBVwnDrbAtK5hq
	qm6GBlHQr2o8pLWgmFz/1tZMjkfybVBUhUaJQ2yfHwHY+RKAO04sp5tsXs4hXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aFAX03aVjPEmwT7UTyknP3rbEgKma3/xTYdPSINFEHc=;
	b=zvwylgMeuogM/svyGz5fdsAMgF0ofydnNkHgZN+RTWNaNjDZHfgfKNf2I6t/Fwvh01r9Oo
	h5oF+Vjyg1odXMDQ==
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
Subject: [patch 15/30] x86/cpu: Detect real BSP on crash kernels
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:54 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

When a kdump kernel is started from a crashing CPU then there is no
guarantee that this CPU is the real boot CPU (BSP). If the kdump kernel
tries to online the BSP then the INIT sequence will reset the machine.

There is a command line option to prevent this, but in case of nested kdump
kernels this is wrong.

But that command line option is not required at all because the real
BSP is enumerated as the first CPU by firmware. Support for the only
known system which was different (Voyager) got removed long ago.

Detect whether the boot CPU APIC ID is the first APIC ID enumerated by
the firmware. If the first APIC ID enumerated is not matching the boot
CPU APIC ID then skip registering it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Adopt to prior ordering and boot APIC exclusion changes

V2: Check for the first enumerated APIC ID (Rui)
---
 Documentation/admin-guide/kdump/kdump.rst       |    7 -
 Documentation/admin-guide/kernel-parameters.txt |    9 --
 arch/x86/kernel/cpu/topology.c                  |   97 ++++++++++++++----------
 3 files changed, 61 insertions(+), 52 deletions(-)
---

--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -191,9 +191,7 @@ Dump-capture kernel config options (Arch
    CPU is enough for kdump kernel to dump vmcore on most of systems.
 
    However, you can also specify nr_cpus=X to enable multiple processors
-   in kdump kernel. In this case, "disable_cpu_apicid=" is needed to
-   tell kdump kernel which cpu is 1st kernel's BSP. Please refer to
-   admin-guide/kernel-parameters.txt for more details.
+   in kdump kernel.
 
    With CONFIG_SMP=n, the above things are not related.
 
@@ -454,8 +452,7 @@ loading dump-capture kernel.
   to use multi-thread programs with it, such as parallel dump feature of
   makedumpfile. Otherwise, the multi-thread program may have a great
   performance degradation. To enable multi-cpu support, you should bring up an
-  SMP dump-capture kernel and specify maxcpus/nr_cpus, disable_cpu_apicid=[X]
-  options while loading it.
+  SMP dump-capture kernel and specify maxcpus/nr_cpus options while loading it.
 
 * For s390x there are two kdump modes: If a ELF header is specified with
   the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1100,15 +1100,6 @@
 			Disable TLBIE instruction. Currently does not work
 			with KVM, with HASH MMU, or with coherent accelerators.
 
-	disable_cpu_apicid= [X86,APIC,SMP]
-			Format: <int>
-			The number of initial APIC ID for the
-			corresponding CPU to be disabled at boot,
-			mostly used for the kdump 2nd kernel to
-			disable BSP to wake up multiple CPUs without
-			causing system reset or hang due to sending
-			INIT from AP to BSP.
-
 	disable_ddw	[PPC/PSERIES]
 			Disable Dynamic DMA Window support. Use this
 			to workaround buggy firmware.
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -32,18 +32,13 @@ static struct {
 	unsigned int		nr_disabled_cpus;
 	unsigned int		nr_rejected_cpus;
 	u32			boot_cpu_apic_id;
+	u32			real_bsp_apic_id;
 } topo_info __read_mostly = {
 	.nr_assigned_cpus	= 1,
 	.boot_cpu_apic_id	= BAD_APICID,
+	.real_bsp_apic_id	= BAD_APICID,
 };
 
-/*
- * Processor to be disabled specified by kernel parameter
- * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
- * avoid undefined behaviour caused by sending INIT from AP to BSP.
- */
-static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
-
 bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 {
 	return phys_id == (u64)cpuid_to_apicid[cpu];
@@ -123,6 +118,60 @@ static void topo_set_cpuids(unsigned int
 		cpu_mark_primary_thread(cpu, apic_id);
 }
 
+static __init bool check_for_real_bsp(u32 apic_id)
+{
+	/*
+	 * There is no real good way to detect whether this a kdump()
+	 * kernel, but except on the Voyager SMP monstrosity which is not
+	 * longer supported, the real BSP APIC ID is the first one which is
+	 * enumerated by firmware. That allows to detect whether the boot
+	 * CPU is the real BSP. If it is not, then do not register the APIC
+	 * because sending INIT to the real BSP would reset the whole
+	 * system.
+	 *
+	 * The first APIC ID which is enumerated by firmware is detectable
+	 * because the boot CPU APIC ID is registered before that without
+	 * invoking this code.
+	 */
+	if (topo_info.real_bsp_apic_id != BAD_APICID)
+		return false;
+
+	if (apic_id == topo_info.boot_cpu_apic_id) {
+		topo_info.real_bsp_apic_id = apic_id;
+		return false;
+	}
+
+	pr_warn("Boot CPU APIC ID not the first enumerated APIC ID: %x > %x\n",
+		topo_info.boot_cpu_apic_id, apic_id);
+	pr_warn("Crash kernel detected. Disabling real BSP to prevent machine INIT\n");
+
+	topo_info.real_bsp_apic_id = apic_id;
+	return true;
+}
+
+static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
+{
+	int cpu;
+
+	if (present) {
+		set_bit(apic_id, phys_cpu_present_map);
+
+		/*
+		 * Double registration is valid in case of the boot CPU
+		 * APIC because that is registered before the enumeration
+		 * of the APICs via firmware parsers or VM guest
+		 * mechanisms.
+		 */
+		if (apic_id == topo_info.boot_cpu_apic_id)
+			cpu = 0;
+		else
+			cpu = topo_get_cpunr(apic_id);
+		topo_set_cpuids(cpu, apic_id, acpi_id);
+	} else {
+		topo_info.nr_disabled_cpus++;
+	}
+}
+
 /**
  * topology_register_apic - Register an APIC in early topology maps
  * @apic_id:	The APIC ID to set up
@@ -131,16 +180,13 @@ static void topo_set_cpuids(unsigned int
  */
 void __init topology_register_apic(u32 apic_id, u32 acpi_id, bool present)
 {
-	int cpu;
-
 	if (apic_id >= MAX_LOCAL_APIC) {
 		pr_err_once("APIC ID %x exceeds kernel limit of: %x\n", apic_id, MAX_LOCAL_APIC - 1);
 		topo_info.nr_rejected_cpus++;
 		return;
 	}
 
-	if (disabled_cpu_apicid == apic_id) {
-		pr_info("Disabling CPU as requested via 'disable_cpu_apicid=0x%x'.\n", apic_id);
+	if (check_for_real_bsp(apic_id)) {
 		topo_info.nr_rejected_cpus++;
 		return;
 	}
@@ -152,23 +198,7 @@ void __init topology_register_apic(u32 a
 		return;
 	}
 
-	if (present) {
-		set_bit(apic_id, phys_cpu_present_map);
-
-		/*
-		 * Double registration is valid in case of the boot CPU
-		 * APIC because that is registered before the enumeration
-		 * of the APICs via firmware parsers or VM guest
-		 * mechanisms.
-		 */
-		if (apic_id == topo_info.boot_cpu_apic_id)
-			cpu = 0;
-		else
-			cpu = topo_get_cpunr(apic_id);
-		topo_set_cpuids(cpu, apic_id, acpi_id);
-	} else {
-		topo_info.nr_disabled_cpus++;
-	}
+	topo_register_apic(apic_id, acpi_id, present);
 }
 
 /**
@@ -182,7 +212,7 @@ void __init topology_register_boot_apic(
 	WARN_ON_ONCE(topo_info.boot_cpu_apic_id != BAD_APICID);
 
 	topo_info.boot_cpu_apic_id = apic_id;
-	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
+	topo_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 }
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
@@ -335,12 +365,3 @@ static int __init setup_possible_cpus(ch
 }
 early_param("possible_cpus", setup_possible_cpus);
 #endif
-
-static int __init apic_set_disabled_cpu_apicid(char *arg)
-{
-	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
-		return -EINVAL;
-
-	return 0;
-}
-early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);


