Return-Path: <linux-kernel+bounces-35326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F54838F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B431F292C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA265FEF9;
	Tue, 23 Jan 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XeRyE49d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6wOstRHq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54045FDC7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015419; cv=none; b=EKRuW0SMsPPk4fUHUOeb0ls6km7OM7Ntfu0jNJQ67WR1wlAnE9zCrT1Uz9xqbMLQ6QF4GHfxcZBlkrxu2Nglbr+u69dr8Didpp3y9B1nnU9bIxSfK7DiNqclI+CtijGzZLPT37CspLbhW+pn07TGlKBZ04FpGbvjeXmbOlvViZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015419; c=relaxed/simple;
	bh=1SSu/NabS5LwMRyWIwnXDXIKFP3+DdJuv+OIyW62Yl8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=enborK9abehS2+KDgPx9koJ/c5P+Hmi2icnuxJ6LWYyY/40uWOOVi1MviiNjqmu1PzFwCfTNkQ+rKwBPSUwl7NUWjn2xQdgkJzpWoE8PC9llV6tKBqASLSuiICKQbbU7JatVdrEtZs7E6Z3VC/ZO7WN/17QImG2eEU3QyLDGdfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XeRyE49d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6wOstRHq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124902.861240618@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8uJsB2/orXh2eFSCQKQ1fVuu3OEToa2VdsoM+LyJSCw=;
	b=XeRyE49dWtSjZVdzIWsRFKruoHdQ6nAaNmyJceNO0tWGKWeWJH69sWKAzuaDW/VnVKAdXq
	ZvR7dxN6TfJE2O2kxYmBhTf6VJDNyr5QIHfKXfM3/kGUzB7qvPhWcY7R6720AzoqN1nSNe
	1kuc2SCfSA5QccaueMmqRVkd9lUE1Vebpnv8nsHrcYj4tPNaF7SdF3sdjCqlsnwW7e2FSY
	LFppiRFnQMC9DvX+8HrzyQzJzvXZn/XWbOJHn67aPw3x90QWz2v+JxqKJOeCTy/ZtEiKB8
	Hn2SSw6LOxuitirKK6M0Nt6rrR4neGVCiNQgAmlNJf6ZTUrzUYKfJ5VL1tCpdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8uJsB2/orXh2eFSCQKQ1fVuu3OEToa2VdsoM+LyJSCw=;
	b=6wOstRHqBlj4A2cby5rrkQBKc7HAUeD1vzxQEQyUbOet9VBeSAzpCZ+zgJxvmD2/ZLrEFv
	nI13717weF7c8mAg==
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
Subject: [patch V2 08/22] x86/mpparse: Rename default_find_smp_config()
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:15 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

MPTABLE is no longer the default SMP configuration mechanism.  Rename it to
mpparse_find_mptable() because that's what it does.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/mpspec.h           |   13 ++++---------
 arch/x86/include/asm/x86_init.h         |    4 ++--
 arch/x86/kernel/mpparse.c               |    2 +-
 arch/x86/kernel/setup.c                 |    6 ++----
 arch/x86/kernel/x86_init.c              |    2 +-
 arch/x86/platform/ce4100/ce4100.c       |    2 +-
 arch/x86/platform/intel-mid/intel-mid.c |    2 +-
 arch/x86/xen/smp_pv.c                   |    2 +-
 8 files changed, 13 insertions(+), 20 deletions(-)
---
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -56,21 +56,16 @@ static inline void early_get_smp_config(
 	x86_init.mpparse.get_smp_config(1);
 }
 
-static inline void find_smp_config(void)
-{
-	x86_init.mpparse.find_smp_config();
-}
-
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
-extern void default_find_smp_config(void);
+extern void mpparse_find_mptable(void);
 extern void default_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
-#define enable_update_mptable 0
-#define default_find_smp_config x86_init_noop
-#define default_get_smp_config x86_init_uint_noop
+#define enable_update_mptable	0
+#define mpparse_find_mptable	x86_init_noop
+#define default_get_smp_config	x86_init_uint_noop
 #endif
 
 int generic_processor_info(int apicid);
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -15,12 +15,12 @@ struct irq_domain;
 /**
  * struct x86_init_mpparse - platform specific mpparse ops
  * @setup_ioapic_ids:		platform specific ioapic id override
- * @find_smp_config:		find the smp configuration
+ * @find_mptable:		Find MPTABLE early to reserve the memory region
  * @get_smp_config:		get the smp configuration
  */
 struct x86_init_mpparse {
 	void (*setup_ioapic_ids)(void);
-	void (*find_smp_config)(void);
+	void (*find_mptable)(void);
 	void (*get_smp_config)(unsigned int early);
 };
 
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -587,7 +587,7 @@ static int __init smp_scan_config(unsign
 	return ret;
 }
 
-void __init default_find_smp_config(void)
+void __init mpparse_find_mptable(void)
 {
 	unsigned int address;
 
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -970,10 +970,8 @@ void __init setup_arch(char **cmdline_p)
 	high_memory = (void *)__va(max_pfn * PAGE_SIZE - 1) + 1;
 #endif
 
-	/*
-	 * Find and reserve possible boot-time SMP configuration:
-	 */
-	find_smp_config();
+	/* Find and reserve MPTABLE area */
+	x86_init.mpparse.find_mptable();
 
 	early_alloc_pgt_buf();
 
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -70,7 +70,7 @@ struct x86_init_ops x86_init __initdata
 
 	.mpparse = {
 		.setup_ioapic_ids	= x86_init_noop,
-		.find_smp_config	= default_find_smp_config,
+		.find_mptable		= mpparse_find_mptable,
 		.get_smp_config		= default_get_smp_config,
 	},
 
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -138,7 +138,7 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.oem.arch_setup = sdv_arch_setup;
 	x86_init.resources.probe_roms = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
-	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.pci.init = ce4100_pci_init;
 	x86_init.pci.init_irq = sdv_pci_init;
 
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -118,7 +118,7 @@ void __init x86_intel_mid_early_setup(vo
 	machine_ops.emergency_restart  = intel_mid_reboot;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -455,6 +455,6 @@ void __init xen_smp_init(void)
 	smp_ops = xen_smp_ops;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.get_smp_config = _get_smp_config;
 }


