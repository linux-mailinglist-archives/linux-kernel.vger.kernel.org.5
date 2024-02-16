Return-Path: <linux-kernel+bounces-68805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07065858091
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C2C285101
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3F913473F;
	Fri, 16 Feb 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XDLPXuyu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1PQ76xT2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772C133287;
	Fri, 16 Feb 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096621; cv=none; b=mm/m9w81bAqWClqG4L5FhDWXC52jnntrqJg9wUjhWyjIZv/O+8U8Um2wojP5kYod5sWeWsJXjcM4fjO2yjvcKI0Fu8qKIfxjJv4b6ZQeQFy5/QKaQxWpRtnfRp7qSfYInYCtyYhDiVW5oCLIQf4KiQ6OhmvCcUdgaMb3e+vX4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096621; c=relaxed/simple;
	bh=AbqijlPt80c2InDCg35jW6obEJh9+g59xwJpBncspDU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Irvri4eIUS60DN96fztPm0F7OLXbJGOvYJNJc2lmsARIh5j45gUoFmo4bItN8YOeJfVVUgV/DyocwzBck+nnUJ+zUd31R8Ynh7IjTipZIXNdNipK5t4dYBo7MqdK+DMqdwf3unOOQOBQos8SGrKDcs2AZ9zrHm94br2IBojJmas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XDLPXuyu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1PQ76xT2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEy8f57+2FPSQHV4D+33Gtdvmd3obVrGFj2MC1N7Clw=;
	b=XDLPXuyuBYhSPZqyrYnH/FeB5/xSQKs33SYEd227g8pytu+re7uo3pFraPoQjGApFPNC/N
	EEOHnTo7TTyBg0adxUB4m9pWsV2RImbCwjhLnzvCt5jE+AXOA9N9VOQK0rgGF2vBABYZml
	5BXtRx1rm6fR4X9S1rUY8MmynirehE1HDoUAsQza9bUJa18JYPP1reK8RkWC/ruiN+IDdf
	W7fSFIBaDTz4ZzoHULAxI18cn8uCM3ZY8WlGs+N8GMPYVTlLbh/0vT08auuGe2Y/w3fOYa
	Unsox1mPh2n8YcFP1qsuQVbDlLCRjedJ0eQNFM7Wh2xBW4ymzyVoAh0KujfsEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEy8f57+2FPSQHV4D+33Gtdvmd3obVrGFj2MC1N7Clw=;
	b=1PQ76xT2lnQfn06ZKIEAoCAic4CLWgtXf93M25X3wwaIfZUhXBrfaFj6ughyY7a7wzIFza
	spZUKqEuRQHXtFBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu: Detect real BSP on crash kernels
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.348542071@linutronix.de>
References: <20240213210252.348542071@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661761.398.703921008740132032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     5c5682b9f87a3b7bd4833884f300ec673685f6a6
Gitweb:        https://git.kernel.org/tip/5c5682b9f87a3b7bd4833884f300ec673685f6a6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:43 +01:00

x86/cpu: Detect real BSP on crash kernels

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
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.348542071@linutronix.de

---
 Documentation/admin-guide/kdump/kdump.rst       |  7 +-
 Documentation/admin-guide/kernel-parameters.txt |  9 +-
 arch/x86/kernel/cpu/topology.c                  | 97 +++++++++-------
 3 files changed, 61 insertions(+), 52 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 5762e74..0302a93 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -191,9 +191,7 @@ Dump-capture kernel config options (Arch Dependent, i386 and x86_64)
    CPU is enough for kdump kernel to dump vmcore on most of systems.
 
    However, you can also specify nr_cpus=X to enable multiple processors
-   in kdump kernel. In this case, "disable_cpu_apicid=" is needed to
-   tell kdump kernel which cpu is 1st kernel's BSP. Please refer to
-   admin-guide/kernel-parameters.txt for more details.
+   in kdump kernel.
 
    With CONFIG_SMP=n, the above things are not related.
 
@@ -454,8 +452,7 @@ Notes on loading the dump-capture kernel:
   to use multi-thread programs with it, such as parallel dump feature of
   makedumpfile. Otherwise, the multi-thread program may have a great
   performance degradation. To enable multi-cpu support, you should bring up an
-  SMP dump-capture kernel and specify maxcpus/nr_cpus, disable_cpu_apicid=[X]
-  options while loading it.
+  SMP dump-capture kernel and specify maxcpus/nr_cpus options while loading it.
 
 * For s390x there are two kdump modes: If a ELF header is specified with
   the elfcorehdr= kernel parameter, it is used by the kdump kernel as it
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25..4b9b4d6 100644
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
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index fc47f52..d555331 100644
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
@@ -123,6 +118,60 @@ static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
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
@@ -131,16 +180,13 @@ static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
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
@@ -152,23 +198,7 @@ void __init topology_register_apic(u32 apic_id, u32 acpi_id, bool present)
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
@@ -182,7 +212,7 @@ void __init topology_register_boot_apic(u32 apic_id)
 	WARN_ON_ONCE(topo_info.boot_cpu_apic_id != BAD_APICID);
 
 	topo_info.boot_cpu_apic_id = apic_id;
-	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
+	topo_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 }
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
@@ -335,12 +365,3 @@ static int __init setup_possible_cpus(char *str)
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

