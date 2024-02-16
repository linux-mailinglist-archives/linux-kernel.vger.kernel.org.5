Return-Path: <linux-kernel+bounces-68825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989398580BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AC61C21636
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098AB1474C2;
	Fri, 16 Feb 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyBzSfZL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNQWPm1Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F50145FF4;
	Fri, 16 Feb 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096637; cv=none; b=QnroLhyMa63JGI+ELwvO1I+FBH3OJvKFyTSS55ugnQe805yoeyNfMFCE8JsmbYZMtYglZ1p4pf+plRoPkI5pi/SyvRDxvpgrvpfJfDWAiL/dh8P9s8tMShhRyZ+ZysL1yWknkLxZx5oDh1kTuY3193CRuWcUsgNF4prUFDYCrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096637; c=relaxed/simple;
	bh=SgntP+cZRwOHXiY7cxfJL5VNOXhgYuYz/MN3+Mdcg0E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jECrRiqoVmymbRr0NMvMy43JBMeZTTAxeqTD2xlYCMSfAGVtr7FNqXucoYQwc3MwVPXaAWOpiOldVdwU5jvCEUdLX8k1GRfvrcPFbKxbv7wp1hLpcApjbVUMCaoaXX6CpQ7ImqeyhcdCOUdBcNZeEivxxui+lQBj+3+tBJyFGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyBzSfZL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNQWPm1Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3dpL7REZOFC8Ql1N9CIx7iOBIfD0EOdE0pjt8XXcHg=;
	b=yyBzSfZLA0/KkTR+jn+iMHmJzFtufbuI66xd4hZBJfA5Uke2f+CtFcfm+g8JwdO5OmG6f5
	dPgojmOtJte2cHezu2KPRXWYc4R0xaUon+QIXRmq+ys27I6DzrGZZwSkYOhbYK4z4fbUmi
	1TCo8x3k+HA3wHtbJZSvWnejRtiGYTIfwhTw08vk90gDiI5WDJ3ZS7NfqFqPXNeejf6RHx
	TUnDkIRF4koenplQbSF3jx7b5XvffKEQX6mCtCTQZPjX/KIijYMNrZWP7MrN/S8E87Hpri
	S/uuNHg/J5GflMMNujXG6D41+spNWit/zTxgvycug5Cm/xl+2BfPnavCmIPt6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3dpL7REZOFC8Ql1N9CIx7iOBIfD0EOdE0pjt8XXcHg=;
	b=fNQWPm1QPTGVT7IC53ktyrUSKwYagO5U6ec8qEkQmcUgVp4PD14wALdlflIJAB5h9Bu0lk
	AyGiXDq8L16nM9DA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/mpparse: Switch to new init callbacks
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.870883080@linutronix.de>
References: <20240212154639.870883080@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663353.398.7462754714965768816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     dcb7600849ce9b3d9b3d2965f452287f06fc9093
Gitweb:        https://git.kernel.org/tip/dcb7600849ce9b3d9b3d2965f452287f06fc9093
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:41 +01:00

x86/mpparse: Switch to new init callbacks

Now that all platforms have the new split SMP configuration callbacks set
up, flip the switch and remove the old callback pointer and mop up the
platform code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.870883080@linutronix.de



---
 arch/x86/hyperv/hv_vtl.c                |  1 -
 arch/x86/include/asm/mpspec.h           |  9 +--------
 arch/x86/include/asm/x86_init.h         |  2 --
 arch/x86/kernel/jailhouse.c             |  8 +-------
 arch/x86/kernel/mpparse.c               |  2 +-
 arch/x86/kernel/setup.c                 | 10 +++-------
 arch/x86/kernel/x86_init.c              |  3 ++-
 arch/x86/platform/ce4100/ce4100.c       |  1 -
 arch/x86/platform/intel-mid/intel-mid.c |  1 -
 arch/x86/xen/smp_pv.c                   | 11 +----------
 10 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index f573cac..804b629 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -29,7 +29,6 @@ void __init hv_vtl_init_platform(void)
 	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg = x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg = x86_init_noop;
-	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 
 	x86_platform.get_wallclock = get_rtc_noop;
 	x86_platform.set_wallclock = set_rtc_noop;
diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 72700ae..82480b7 100644
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
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 375825f..9ca6247 100644
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
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 6d663af..5128ac8 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -89,7 +89,7 @@ static void __init jailhouse_x2apic_init(void)
 #endif
 }
 
-static void __init jailhouse_get_smp_config(unsigned int early)
+static void __init jailhouse_parse_smp_config(void)
 {
 	struct ioapic_domain_cfg ioapic_cfg = {
 		.type = IOAPIC_DOMAIN_STRICT,
@@ -118,11 +118,6 @@ static void __init jailhouse_get_smp_config(unsigned int early)
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
@@ -211,7 +206,6 @@ static void __init jailhouse_init_platform(void)
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= jailhouse_parse_smp_config;
-	x86_init.mpparse.get_smp_config		= jailhouse_get_smp_config;
 	x86_init.pci.arch_init			= jailhouse_pci_arch_init;
 
 	x86_platform.calibrate_cpu		= jailhouse_get_tsc;
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index b22093d..9c000c4 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -473,7 +473,7 @@ static int __init check_physptr(struct mpf_intel *mpf, unsigned int early)
 /*
  * Scan the memory blocks for an SMP configuration block.
  */
-void __init mpparse_get_smp_config(unsigned int early)
+static __init void mpparse_get_smp_config(unsigned int early)
 {
 	struct mpf_intel *mpf;
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 39edb89..1a3d66f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1130,15 +1130,11 @@ void __init setup_arch(char **cmdline_p)
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
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 5d86d57..a42830d 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -71,7 +71,8 @@ struct x86_init_ops x86_init __initdata = {
 	.mpparse = {
 		.setup_ioapic_ids	= x86_init_noop,
 		.find_mptable		= mpparse_find_mptable,
-		.get_smp_config		= mpparse_get_smp_config,
+		.early_parse_smp_cfg	= mpparse_parse_early_smp_config,
+		.parse_smp_cfg		= mpparse_parse_smp_config,
 	},
 
 	.irqs = {
diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index 6378082..f32451b 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -140,7 +140,6 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= x86_dtb_parse_smp_config;
-	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
 	x86_init.pci.init			= ce4100_pci_init;
 	x86_init.pci.init_irq			= sdv_pci_init;
 
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 14ca367..7be71c2 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -121,6 +121,5 @@ void __init x86_intel_mid_early_setup(void)
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
 	x86_init.mpparse.parse_smp_cfg		= x86_init_noop;
-	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index bd939b8..7f6f340 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -148,14 +148,11 @@ int xen_smp_intr_init_pv(unsigned int cpu)
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
@@ -185,11 +182,6 @@ static void __init _get_smp_config(unsigned int early)
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

