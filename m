Return-Path: <linux-kernel+bounces-64279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A3853CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FBB2820F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82649627E8;
	Tue, 13 Feb 2024 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JDRkOor+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wbWWgI7H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22A779F2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858319; cv=none; b=AL6e1s5dkACFFdAIQJrxAjKgZf6e6CoJ1CvOxCH7kbOLkoLcsejlh2vkhCcA8WWJUbn6RxnfTww1Imyeb2iiGlFKNtPh2XxpCX/n3XF864Wy8lHn2Cw246/6+rdDSxN/SvFMURZx5euz+SQzTHRU/98aFRZ+MDiAf2DkO5y/r1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858319; c=relaxed/simple;
	bh=fFDDm+IcPIJ8ufw0BZKYFGMy6vU1yM2Z0NwvzimfUPM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=XlG/ExQn2bRViVHf/oAxLINeuy3oYDzwAdZgVzQYt5+L+Y0/045qghHjzHW8gh6EbnRNgs2uLv1CvlQOYFY5WF7Cjj95AwiK/paG/diFa/mAH9BdkYNyiVAxbfzP7ApeaBWtCXYW+Y83Au5aX0VSSHMeXKl4JPtFlNiAyd+5d8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JDRkOor+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wbWWgI7H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.931761608@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yULM2Gj9hY++VfH+YxKvELgZNf/bRFWwj5nxSBjyXNI=;
	b=JDRkOor+tdCFby6x3IuKyyIR64tpc3Yp0iExZNAojUGNYRcTYxSl2q6UIcCwfw4P1KjtCS
	ThCAI3qD0TaTo/01i7xFW8kIkRQGDef6g2hMbztVqIH2nVthPEwR9sDeRUR2yyz1iYKC6b
	+GfoVVrdZp1gepuidgwWPXUnnVDF4Xap0zUCsgaD6vQPZMLGtfIjBPqWAJ2HahMFK6EznH
	WTc7HUcMtXl0cNPQ61qT8gFpAE6EN/cZENI8ktrFzqetYUKSTHgN56THZIG/+d3XqUSJev
	ih0fLoZnBMNN8H6NG+FenZcfK6efYmYOB4gOQWlswe5ndSsIGz2B5qk/elzelQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yULM2Gj9hY++VfH+YxKvELgZNf/bRFWwj5nxSBjyXNI=;
	b=wbWWgI7H08J+gqeR0lshjzk5jBNFhte+1/cT5Q9T7NlOPbva5dSxp62OR+joSXlaT8Ac0c
	tmcalz+YGbl9nfDQ==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V3 18/22] x86/mm/numa: Move early mptable evaluation into
 common code
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:16 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

There is no reason to have the early mptable evaluation conditionally
invoked only from the AMD numa topology code.

Make it explicit and invoke it from setup_arch() right after the
corresponding ACPI init call. Remove the pointless wrapper and invoke
x86_init::mpparse::early_parse_smp_config() directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/include/asm/mpspec.h |    5 -----
 arch/x86/kernel/setup.c       |    2 ++
 arch/x86/mm/amdtopology.c     |    7 -------
 3 files changed, 2 insertions(+), 12 deletions(-)
---

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -46,11 +46,6 @@ extern int smp_found_config;
 # define smp_found_config 0
 #endif
 
-static inline void early_get_smp_config(void)
-{
-	x86_init.mpparse.early_parse_smp_cfg();
-}
-
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1086,7 +1086,9 @@ void __init setup_arch(char **cmdline_p)
 
 	early_platform_quirks();
 
+	/* Some platforms need the APIC registered for NUMA configuration */
 	early_acpi_boot_init();
+	x86_init.mpparse.early_parse_smp_cfg();
 
 	x86_flattree_get_config();
 
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -161,13 +161,6 @@ int __init amd_numa_init(void)
 	 */
 	cores = topology_get_domain_size(TOPO_CORE_DOMAIN);
 
-	/*
-	 * Scan MPTABLE to map the local APIC and ensure that the boot CPU
-	 * APIC ID is valid. This is required because on pre ACPI/SRAT
-	 * systems IO-APICs are mapped before the boot CPU.
-	 */
-	early_get_smp_config();
-
 	apicid = boot_cpu_physical_apicid;
 	if (apicid > 0)
 		pr_info("BSP APIC ID: %02x\n", apicid);




