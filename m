Return-Path: <linux-kernel+bounces-90394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D11386FE9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E87AEB240D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008593B789;
	Mon,  4 Mar 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IENSuJ/e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DybwRAza"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8053A1B5;
	Mon,  4 Mar 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547147; cv=none; b=mPnDZOgV5JpEz+4SHTJwuvbXaxBy3e08V50qehPEd5W/hVdr3kFcIU+fvUhE71GG00mVCaI4mSkbAwJg1TsOF0DEi1plhZqcyrQ3OONlQE+QQkAjsnadw4Cx6rAkLsUB4OCl+SMeSjcxIShcnTrCJWMuc0zBJUH4vNvtKgtunBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547147; c=relaxed/simple;
	bh=WnYEq+v+uffBZEOPsnlQcrlcLI+VPrV3Dcry/HVzvlk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=pufusesBf8RQ1S+O5ERiNyRG1r5IJfypJKuUBWliTHre5XRcfFuoNDWlktqwA09Q3SJ72h5XIfCLbOXIzqHNhOWb2dhnz4+cnL9MZZgg0WqfBPEEnkp39u3T3aLQCwRaDQ5prewRivlyNwhXrN6Dcb0ClYaQVx9z3GP/77dmj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IENSuJ/e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DybwRAza; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240304005104.622511517@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709547144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=waWca13nkXlTk1KdzjjO2eUHwkXJkPInhR1X09TJX+0=;
	b=IENSuJ/e6a+O59bFfGCzBu967ngLsRmjlrdNl9Yj+0nWcQ2bC0X2PFYcW/Ogp06sGMJLIB
	ELnjGItFWtLl/DhXffYbhfYuZWdTuAHy8P8NVHuKbhqqPd+K6BZJft2vySb2+rum2C09Aq
	cWLbAXlF9oprSMGGqHOjLNW9tMb08579es9MRNnrISA4hAX/P0g8vPVJRs53u0MiCEmg6E
	uPe2Xr/qEg48MKdoe0aRLao5JNxk0MSqCCwClODcnS+OboqfNXt0nkNhir9tdrbcBn9GiL
	H2I7NG7MHqA3R/H+15AKqhR+hAQvt2gdQuqJz62UKfwqHFHBPFCLeUK+U6W0Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709547144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=waWca13nkXlTk1KdzjjO2eUHwkXJkPInhR1X09TJX+0=;
	b=DybwRAzaUVoj3GiTZNCzx4w9/5h1J6i6awKRx6ALpGlnYu7RBOoHK+EpiWo6GAfyzSUvKj
	08Qabz6R7eWQ3kBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: [patch 5/9] x86: Cure per CPU madness on UP
References: <20240303235029.555787150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  4 Mar 2024 11:12:23 +0100 (CET)

On UP builds sparse complains rightfully about accesses to cpu_info with
per CPU accessors:

cacheinfo.c:282:30: sparse: warning: incorrect type in initializer (different address spaces)
cacheinfo.c:282:30: sparse:    expected void const [noderef] __percpu *__vpp_verify
cacheinfo.c:282:30: sparse:    got unsigned int *

The reason is that on UP builds cpu_info which is a per CPU variable on SMP
is mapped to boot_cpu_info which is a regular variable. There is a hideous
accessor cpu_data() which tries to hide this, but it's not sufficient as
some places require raw accessors and generates worse code than the regular
per CPU accessors.

Waste sizeof(struct x86_cpuinfo) memory on UP and provide the per CPU
cpu_info unconditionally. This requires to update the CPU info on the boot
CPU as SMP does. (Ab)use the weakly defined smp_prepare_boot_cpu() function
and implement exactly that.

This allows to use regular per CPU accessors uncoditionally and paves the
way to remove the cpu_data() hackery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/processor.h |    5 -----
 arch/x86/kernel/cpu/common.c     |    3 +++
 arch/x86/kernel/setup.c          |   10 ++++++++++
 arch/x86/kernel/smpboot.c        |    4 ----
 4 files changed, 13 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -185,13 +185,8 @@ extern struct cpuinfo_x86	new_cpu_data;
 extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
 extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
 
-#ifdef CONFIG_SMP
 DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 #define cpu_data(cpu)		per_cpu(cpu_info, cpu)
-#else
-#define cpu_info		boot_cpu_data
-#define cpu_data(cpu)		boot_cpu_data
-#endif
 
 extern const struct seq_operations cpuinfo_op;
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -70,6 +70,9 @@
 
 #include "cpu.h"
 
+DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
+EXPORT_PER_CPU_SYMBOL(cpu_info);
+
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1211,6 +1211,16 @@ void __init i386_reserve_resources(void)
 
 #endif /* CONFIG_X86_32 */
 
+#ifndef CONFIG_SMP
+void __init smp_prepare_boot_cpu(void)
+{
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	*c = boot_cpu_data;
+	c->initialized = true;
+}
+#endif
+
 static struct notifier_block kernel_offset_notifier = {
 	.notifier_call = dump_kernel_offset
 };
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,10 +101,6 @@ EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 
-/* Per CPU bogomips and other parameters */
-DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
-EXPORT_PER_CPU_SYMBOL(cpu_info);
-
 /* CPUs which are the primary SMT threads */
 struct cpumask __cpu_primary_thread_mask __read_mostly;
 


