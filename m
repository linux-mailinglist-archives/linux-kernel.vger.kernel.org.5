Return-Path: <linux-kernel+bounces-35336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6772838F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5882D28EE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0260B82;
	Tue, 23 Jan 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NY9bFF2u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCuJupXb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03095F55E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015434; cv=none; b=dW0fmMEtpbSUQr+wpXWwJe0xpcrkFTOHLaCSgS3dYDfBzpXbGLmv3UMcyRF5iuo48ye0AkphJm/pA4J+NRiMb7o27W38PjsgzwGSEGrLlaBRsQtc3pQ0hmuhusAmUzawfwWrH/lYuj3OsFQ9n1Jp91O3kNsLAmdB18d7dQ81hQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015434; c=relaxed/simple;
	bh=IqKysSQupdnNmRRzDm+pX9DYBOtwOZH+/v0LgMW+WXQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mzYiehGkLZdkJ/dy/i3CfukaIr4RzcbzYZGXuOvsrx7kEyoA+HiGIZzIAPbc0QXYzj2mRVq+HbOQmNCZRvkiAsa90igh4pYme37ijDj7ja3i+/BkKAosrjsjkTHvloNashTsWNrAhWxO2RRjS2ubCi45EnsxLa3D1KFwyENRH0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NY9bFF2u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hCuJupXb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.437732578@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lCZnmz1KSfERdPxN+dnECuuiq3zoZfJv2vR+o747wAM=;
	b=NY9bFF2ujChl7dy+g3KW7t9CJCLbXzUqdQ/SskdhBMhYQR18cHYrPqUYqganHQyOfOLb2H
	wgc2D+03zahBIKc6FGGEbezGcKvi0XslxeUlpKT+R0eQxyK52GdsqK0H63DAPnmSf1qG0l
	ZZyTwpJcwzTgcPhMOfDIiwZAwWINgHMfTwtpovQ5VKpIuovFes34qzeL+y/ywJysg0GqeQ
	EfFOVg4DubOIkCD+HxGtKG9QnKiZzBtc0OgucfpUiKfV72b7bbK+xe6LzJP0oACFYBaZSh
	VrMDJBzpuPKhEKu03ivf6ishSTMcdzeQ2uVaG7Nf7w3u4lpVMY8sBQNUhmIPzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=lCZnmz1KSfERdPxN+dnECuuiq3zoZfJv2vR+o747wAM=;
	b=hCuJupXbklnBT+Bw1bXjhXagtviiJfi4LPiksdtQwoxarMI8johlZf7phvAYScswbXv/L6
	ttNMmgcdypQMTyBA==
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
Subject: [patch V2 17/22] x86/mpparse: Switch to new init callbacks
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:30 +0100 (CET)

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


