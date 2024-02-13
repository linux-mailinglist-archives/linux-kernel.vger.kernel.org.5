Return-Path: <linux-kernel+bounces-64278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9EE853CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD461C2222A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5183277A14;
	Tue, 13 Feb 2024 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EKBQKfJK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KYeH+5CS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571377631
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858318; cv=none; b=jnIFAynI/G1DAhMiPwFpmVWYsheahNPckkNNNa80tCr37WsTIqt6y9yuD2IW2jrd2BpOuzRn13kLGBBI4cEYkKvFEPtnEpWFZfyxAdljq5JrDUpS925qP5oV53kgBD4d/9o6xAKazf8oDSHZV2OLwOKrs9ls+qWk3jjKRxUsVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858318; c=relaxed/simple;
	bh=k/szfxyZlFizXrKIW2lucYsX2npIpQI3Ye1rN8D4uRg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Q+FRkZJeFQ1gSCISOAQ/mblNQDvHSpq4nJG/9o4i4mql9BsBqOoFS5ZKIpTo+uzrzqsXFRQO7oIo+kYsaf/MFwz2BC1hwgbAo3HYi2sV5lGLC06VPmxcTZ1Xbge/bdwN9FWVHfRf66ObnJBHZ8V1oQZBtmPV9XSIeM0Ecp7rkAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EKBQKfJK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KYeH+5CS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.870883080@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7D2j8eDUL7diO4fhC1fgChNoqXQgRII6tyTbXDTQUtI=;
	b=EKBQKfJK9GB2YqT70t9cNIYCHrpWnwQsM8ZAgu841YMgwYer8RD6jyOChEpvg22lVdpfhg
	WV17+uMwdc+fw4ZKdisSQYEiW+mTMfJRaCfSEm/jj/u11C9tln4duhjs5++VcqXwqoPf0U
	BDMmrsRpbcXaduMIRhHcwpb4QVWDu9vzwEabfFOghbJ7Tpx6rAn8j6an9ebzphAYXfJwXR
	KH/bb4SE3sFTz2LEoOFBgw/6Q2CJOg7Cdd1nrHRz5SXMB5NlY/hDPR3Q4ECQqV0HUn73Zf
	SjnPH3jIAZ7bhOeUR1hHiRFnjxJqSi7dsmyvXMn126uDcIaGCyFQL0gYUn9gqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=7D2j8eDUL7diO4fhC1fgChNoqXQgRII6tyTbXDTQUtI=;
	b=KYeH+5CSf0VxBjyo6QVmmyNWEs1s7eAkT9hqy86Ag3Omt8C1QuomqzuCQ+zPeLsSbOKyVE
	jb82lTIiYpoq0mAQ==
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
Subject: [patch V3 17/22] x86/mpparse: Switch to new init callbacks
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:14 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Now that all platforms have the new split SMP configuration callbacks set
up, flip the switch and remove the old callback pointer and mop up the
platform code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/hyperv/hv_vtl.c                |    1 -
 arch/x86/include/asm/mpspec.h           |    9 +--------
 arch/x86/include/asm/x86_init.h         |    2 --
 arch/x86/kernel/jailhouse.c             |    8 +-------
 arch/x86/kernel/mpparse.c               |    2 +-
 arch/x86/kernel/setup.c                 |   10 +++-------
 arch/x86/kernel/x86_init.c              |    3 ++-
 arch/x86/platform/ce4100/ce4100.c       |    1 -
 arch/x86/platform/intel-mid/intel-mid.c |    1 -
 arch/x86/xen/smp_pv.c                   |   11 +----------
 10 files changed, 9 insertions(+), 39 deletions(-)
---

--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -29,7 +29,6 @@ void __init hv_vtl_init_platform(void)
 	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg = x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg = x86_init_noop;
-	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 
 	x86_platform.get_wallclock = get_rtc_noop;
 	x86_platform.set_wallclock = set_rtc_noop;
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -46,14 +46,9 @@ extern int smp_found_config;
 # define smp_found_config 0
 #endif
 
-static inline void get_smp_config(void)
-{
-	x86_init.mpparse.get_smp_config(0);
-}
-
 static inline void early_get_smp_config(void)
 {
-	x86_init.mpparse.get_smp_config(1);
+	x86_init.mpparse.early_parse_smp_cfg();
 }
 
 #ifdef CONFIG_X86_MPPARSE
@@ -62,14 +57,12 @@ extern int enable_update_mptable;
 extern void mpparse_find_mptable(void);
 extern void mpparse_parse_early_smp_config(void);
 extern void mpparse_parse_smp_config(void);
-extern void mpparse_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
 #define enable_update_mptable		0
 #define mpparse_find_mptable		x86_init_noop
 #define mpparse_parse_early_smp_config	x86_init_noop
 #define mpparse_parse_smp_config	x86_init_noop
-#define mpparse_get_smp_config		x86_init_uint_noop
 #endif
 
 int generic_processor_info(int apicid);
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -16,14 +16,12 @@ struct irq_domain;
  * struct x86_init_mpparse - platform specific mpparse ops
  * @setup_ioapic_ids:		platform specific ioapic id override
  * @find_mptable:		Find MPTABLE early to reserve the memory region
- * @get_smp_config:		get the smp configuration
  * @early_parse_smp_cfg:	Parse the SMP configuration data early before initmem_init()
  * @parse_smp_cfg:		Parse the SMP configuration data
  */
 struct x86_init_mpparse {
 	void (*setup_ioapic_ids)(void);
 	void (*find_mptable)(void);
-	void (*get_smp_config)(unsigned int early);
 	void (*early_parse_smp_cfg)(void);
 	void (*parse_smp_cfg)(void);
 };
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -89,7 +89,7 @@ static void __init jailhouse_x2apic_init
 #endif
 }
 
-static void __init jailhouse_get_smp_config(unsigned int early)
+static void __init jailhouse_parse_smp_config(void)
 {
 	struct ioapic_domain_cfg ioapic_cfg = {
 		.type = IOAPIC_DOMAIN_STRICT,
@@ -118,11 +118,6 @@ static void __init jailhouse_get_smp_con
 	}
 }
 
-static void __init jailhouse_parse_smp_config(void)
-{
-	jailhouse_get_smp_config(false);
-}
-
 static void jailhouse_no_restart(void)
 {
 	pr_notice("Jailhouse: Restart not supported, halting\n");
@@ -211,7 +206,6 @@ static void __init jailhouse_init_platfo
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= jailhouse_parse_smp_config;
-	x86_init.mpparse.get_smp_config		= jailhouse_get_smp_config;
 	x86_init.pci.arch_init			= jailhouse_pci_arch_init;
 
 	x86_platform.calibrate_cpu		= jailhouse_get_tsc;
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -473,7 +473,7 @@ static int __init check_physptr(struct m
 /*
  * Scan the memory blocks for an SMP configuration block.
  */
-void __init mpparse_get_smp_config(unsigned int early)
+static __init void mpparse_get_smp_config(unsigned int early)
 {
 	struct mpf_intel *mpf;
 
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1128,15 +1128,11 @@ void __init setup_arch(char **cmdline_p)
 	early_quirks();
 
 	/*
-	 * Read APIC and some other early information from ACPI tables.
+	 * Parse SMP configuration. Try ACPI first and then the platform
+	 * specific parser.
 	 */
 	acpi_boot_init();
-	x86_dtb_parse_smp_config();
-
-	/*
-	 * get boot-time SMP configuration:
-	 */
-	get_smp_config();
+	x86_init.mpparse.parse_smp_cfg();
 
 	/*
 	 * Systems w/o ACPI and mptables might not have it mapped the local
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -71,7 +71,8 @@ struct x86_init_ops x86_init __initdata
 	.mpparse = {
 		.setup_ioapic_ids	= x86_init_noop,
 		.find_mptable		= mpparse_find_mptable,
-		.get_smp_config		= mpparse_get_smp_config,
+		.early_parse_smp_cfg	= mpparse_parse_early_smp_config,
+		.parse_smp_cfg		= mpparse_parse_smp_config,
 	},
 
 	.irqs = {
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -140,7 +140,6 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= x86_dtb_parse_smp_config;
-	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
 	x86_init.pci.init			= ce4100_pci_init;
 	x86_init.pci.init_irq			= sdv_pci_init;
 
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -121,6 +121,5 @@ void __init x86_intel_mid_early_setup(vo
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= x86_init_noop;
-	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -148,14 +148,11 @@ int xen_smp_intr_init_pv(unsigned int cp
 	return rc;
 }
 
-static void __init _get_smp_config(unsigned int early)
+static void __init xen_pv_smp_config(void)
 {
 	int i, rc;
 	unsigned int subtract = 0;
 
-	if (early)
-		return;
-
 	num_processors = 0;
 	disabled_cpus = 0;
 	for (i = 0; i < nr_cpu_ids; i++) {
@@ -185,11 +182,6 @@ static void __init _get_smp_config(unsig
 	smp_found_config = 1;
 }
 
-static void __init xen_pv_smp_config(void)
-{
-	_get_smp_config(false);
-}
-
 static void __init xen_pv_smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != 0);
@@ -463,5 +455,4 @@ void __init xen_smp_init(void)
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= xen_pv_smp_config;
-	x86_init.mpparse.get_smp_config		= _get_smp_config;
 }




