Return-Path: <linux-kernel+bounces-64271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9314853CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E30B1F2847A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0086A353;
	Tue, 13 Feb 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lIfrOJs1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/69QRnWv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BDD62143
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858308; cv=none; b=nwatnXvbIggOCT8mHiIoBFDBtKt/JE3wyuIl7O3Gzw+SFKihPIkOob+BC6ao1pP3g94wNgH3NWgSYsiTOyagbnTsHkkLTcugnvLDtyzgBj7qj9m1/qMYhiQAj15k6os9EMnUSRHx6PKj7mktrUu78weTsPS+8kIU8tLNom8vTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858308; c=relaxed/simple;
	bh=OH9i/6sHljeMHBBOlfRzZZbmmIB9/VmPJS89M329bvY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MYFvXQxBDqzhifk5lfOpFT7xW7AZU7RD8PiSii4d89dsLODr5FHTBldigMYvg7PWwZTD61bokVJgkGpJp+a5/PvZTJhVzZ5YVONT4w25+secwFvZNgs80GPqPi2iLHF4hkTeL+OaPLKHZVYO8jXVkZEr9emrixerOHHSvTQaKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lIfrOJs1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/69QRnWv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.433811243@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gVhd+douULzCtgDBreFZyPvTMBxpG3zFTSdanDfkXCw=;
	b=lIfrOJs1mYiD0f7xk4erYC8zZXa3nvgau6DI0WgquZB6VVevUSmoxCgstkIf92ixFVfLmn
	dNbgj+ulm5BOn6+j4J+7+HTQzbPA0r5y3O2k8zOMAmaHHZ4OSPVtb+mRLGUpO69XT5ghsl
	SzA653RUzahP4xb3Cy4tbCuUjLhEH0Rip+dw3fVh/aWcWzY9S2i9p3CGHnYR1ML6a4Pi2C
	o9MU1lgJDFg0CCioSgHAhyoJvv9mrWlrOmEodk+Sk+pUNFKetbX02wDIgSRhQkdLjkQDiB
	QDFC0cxYmaTc6lsHwplnhbCppjuK0KcMVKixeyHfn7yhwRhjRc+wpoNKPFyJ6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gVhd+douULzCtgDBreFZyPvTMBxpG3zFTSdanDfkXCw=;
	b=/69QRnWvZHeR8yS1mghJRl3Asd6oA9tmlsPitBukwFEdJajmPpQdYZNRjRq7kJB3/fqyjl
	PK5ab7O1JJ0MWxCA==
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
Subject: [patch V3 10/22] x86/mpparse: Prepare for callback separation
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:04 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

In preparation of splitting the get_smp_config() callback, rename
default_get_smp_config() to mpparse_get_smp_config() and provide an early
and late wrapper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/include/asm/mpspec.h |   12 ++++++++----
 arch/x86/kernel/mpparse.c     |   12 +++++++++++-
 arch/x86/kernel/x86_init.c    |    2 +-
 3 files changed, 20 insertions(+), 6 deletions(-)
---

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -60,12 +60,16 @@ static inline void early_get_smp_config(
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
 extern void mpparse_find_mptable(void);
-extern void default_get_smp_config(unsigned int early);
+extern void mpparse_parse_early_smp_config(void);
+extern void mpparse_parse_smp_config(void);
+extern void mpparse_get_smp_config(unsigned int early);
 #else
 static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
-#define enable_update_mptable	0
-#define mpparse_find_mptable	x86_init_noop
-#define default_get_smp_config	x86_init_uint_noop
+#define enable_update_mptable		0
+#define mpparse_find_mptable		x86_init_noop
+#define mpparse_parse_early_smp_config	x86_init_noop
+#define mpparse_parse_smp_config	x86_init_noop
+#define mpparse_get_smp_config		x86_init_uint_noop
 #endif
 
 int generic_processor_info(int apicid);
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -473,7 +473,7 @@ static int __init check_physptr(struct m
 /*
  * Scan the memory blocks for an SMP configuration block.
  */
-void __init default_get_smp_config(unsigned int early)
+void __init mpparse_get_smp_config(unsigned int early)
 {
 	struct mpf_intel *mpf;
 
@@ -538,6 +538,16 @@ void __init default_get_smp_config(unsig
 	early_memunmap(mpf, sizeof(*mpf));
 }
 
+void __init mpparse_parse_early_smp_config(void)
+{
+	mpparse_get_smp_config(true);
+}
+
+void __init mpparse_parse_smp_config(void)
+{
+	mpparse_get_smp_config(false);
+}
+
 static void __init smp_reserve_memory(struct mpf_intel *mpf)
 {
 	memblock_reserve(mpf->physptr, get_mpc_size(mpf->physptr));
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -71,7 +71,7 @@ struct x86_init_ops x86_init __initdata
 	.mpparse = {
 		.setup_ioapic_ids	= x86_init_noop,
 		.find_mptable		= mpparse_find_mptable,
-		.get_smp_config		= default_get_smp_config,
+		.get_smp_config		= mpparse_get_smp_config,
 	},
 
 	.irqs = {




