Return-Path: <linux-kernel+bounces-68834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 880578580D0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF22282CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4713B14AD00;
	Fri, 16 Feb 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rKTpR+/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4jRAuxfI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9D148FF4;
	Fri, 16 Feb 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096644; cv=none; b=bg8wTXcg4sgAR1nJWnwS0Ra4w+nueRaR2X6LyBGo8BJCjSLPyuLddEcQqkVCLXw3zxuxO8gl15yRMJFwM7ITZKN292DKS9iLSvc+O32xXfw9shI0XCEugf7CToGvdTf+Gpsd9QboWZqnPqV/VuUTs6wTH8PFmlgRkErzARFsgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096644; c=relaxed/simple;
	bh=PHCqxJtAp7L8c03u3mnuTBEiP/9LDBpk2avNFxq+ucU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LP9nxmLKrXlmQibuN4vmLG2hYOS8SuWynRPYNAGJtZ3umK2di4b1pZXdx/L0bxD3/5O6+0oFPllB4374VWz6p90TXM07rPQjJv8XWaf5dV/fZidtuQkgpbQFtpxTU3FWci4V12pgOp+eA0+kE6EX0OvS2Z8gSj5ShRegMGIjso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rKTpR+/u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4jRAuxfI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veTeQnAQhbqKkWRZk6azUX3f55HqJNE+Bushe6cY600=;
	b=rKTpR+/uJX/xfIffM7zNdqkXivYUBmxBirWL4pYXY2sqN9dmskuVHPZ3U7QlByosT5Rsno
	+iQYWgPR47cl8Dbd3OnAvk1dwoPLBTKIkasaV2lHOuKxr0DTr8QFo1dH04JMArpDVcJsrL
	9hXJKQw2RtXFwxtu4YjXmwAhWJKJPIcQBMYPRTMwj+hOrU+B9YLk6+oZXeeUvD04B0mVA6
	4MwmTjaBmsybLm3awogxSKTv87IPkC2lgpIoxihXp+9rT8XrVJwNy/l8anSp9jTwjDK1Up
	J4cVeqtdXwmV/Eg0bqAuQjWIoBOBwO0DmSOj5vAJbK6dwRv2UlxnWQz6O9vlbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veTeQnAQhbqKkWRZk6azUX3f55HqJNE+Bushe6cY600=;
	b=4jRAuxfIUmsTSZv8GKjB634rQS+bFkdK8fgazksWBcEjv3quLw8AY9tZIcppWs7vlLqJzQ
	kYXT3EQAC/TLOIAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/mpparse: Rename default_find_smp_config()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.306287711@linutronix.de>
References: <20240212154639.306287711@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663971.398.11639430256558521810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     e061c7ae0830ff320d77566849a5cc30decfa602
Gitweb:        https://git.kernel.org/tip/e061c7ae0830ff320d77566849a5cc30decfa602
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:40 +01:00

x86/mpparse: Rename default_find_smp_config()

MPTABLE is no longer the default SMP configuration mechanism.  Rename it to
mpparse_find_mptable() because that's what it does.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.306287711@linutronix.de



---
 arch/x86/include/asm/mpspec.h           | 13 ++++---------
 arch/x86/include/asm/x86_init.h         |  4 ++--
 arch/x86/kernel/mpparse.c               |  2 +-
 arch/x86/kernel/setup.c                 |  6 ++----
 arch/x86/kernel/x86_init.c              |  2 +-
 arch/x86/platform/ce4100/ce4100.c       |  2 +-
 arch/x86/platform/intel-mid/intel-mid.c |  2 +-
 arch/x86/xen/smp_pv.c                   |  2 +-
 8 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 666dcdb..c154dd7 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -56,21 +56,16 @@ static inline void early_get_smp_config(void)
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
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c878616..4ae7764 100644
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
 
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index b223922..86acccd 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -587,7 +587,7 @@ static int __init smp_scan_config(unsigned long base, unsigned long length)
 	return ret;
 }
 
-void __init default_find_smp_config(void)
+void __init mpparse_find_mptable(void)
 {
 	unsigned int address;
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 8420107..0e431c9 100644
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
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a37ebd3..0bbef49 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -70,7 +70,7 @@ struct x86_init_ops x86_init __initdata = {
 
 	.mpparse = {
 		.setup_ioapic_ids	= x86_init_noop,
-		.find_smp_config	= default_find_smp_config,
+		.find_mptable		= mpparse_find_mptable,
 		.get_smp_config		= default_get_smp_config,
 	},
 
diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index bbe7e91..de7f1e9 100644
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
 
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index f4592dc..595dd4c 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -118,7 +118,7 @@ void __init x86_intel_mid_early_setup(void)
 	machine_ops.emergency_restart  = intel_mid_reboot;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 3ae29c2..44c35b1 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -455,6 +455,6 @@ void __init xen_smp_init(void)
 	smp_ops = xen_smp_ops;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.get_smp_config = _get_smp_config;
 }

