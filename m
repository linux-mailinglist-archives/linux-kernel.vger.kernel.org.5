Return-Path: <linux-kernel+bounces-90392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA60C86FE99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BF8B22CE0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AF03A1AF;
	Mon,  4 Mar 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EerkCNw2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v992CpVd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6B3984B;
	Mon,  4 Mar 2024 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547144; cv=none; b=YTPi9jpS7JUzoHYjkFMUv22q823RwmrQxa7YuKXPeDGtAs+Jtzl0xfZ3NE8w3oyTKpGoFN8Rqhrv9w7EOkmlCMGsa4AMBAbA0EiAYuHOoXubjr22VCHnQ489D7w98K1W+VGwDnvPkl9zJC/iS2wUBLAPGqRW14fp29d6kgJ+0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547144; c=relaxed/simple;
	bh=Xy2u0bRDImKld1wcyjYDGiVnq2irYEy02BmpMI3Gm/Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=l7bX761oN/iIVR4BIP9EImAE1rvwNkdUXmAZCQPX5orayWIe+tORDDHzPckmser8HBBy1D1isG/4fdjHoqxMg/w5a/cJ6uyFcIGqP/604+weIgD7fk23Mcl3oqN5LbBXdRHM+thnWKYgyN3sH0dEYZB1EuJqkuq0jPHW+6K58Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EerkCNw2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v992CpVd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240304005104.513181735@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709547141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RyGbWjTAxec6UVxBRQI4/who5kTeC4Qetv+7IpOA3/s=;
	b=EerkCNw2EwZUT050o6pD4jnPrRjHC0dtfkfhEJXshTi9754LlALEgL5ozins3+nZDYVXTE
	FVLnPMvBc7RjABDX20HQhDmSerXxDtyIGzj7vjIGuyQlJ04NgkAFV6MZp+e50vMFOuApx4
	MLMqO4KQDoI24+J9RHw7P/0RRGGpvNG+ACxd6Bd0H4gwlcVKY2YqpjLkILIR3b4lbnGx3Q
	San6m7VeZOrFkPMLxfva4SuepYtthCTHL0X8fAGlI4F91oHsax7vsLp6KyKVmkSaGseYwG
	bSrsavRUUdm59sW8xTYGQLtAioAquQ0TfrwRYJZ+3ajzCyYtWL5CktwjAdWmhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709547141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RyGbWjTAxec6UVxBRQI4/who5kTeC4Qetv+7IpOA3/s=;
	b=v992CpVd3cXVfweVPzJzcgmEsgJL48gP4m7p7DFZ5TdrFRRueI+GubKaP/CBnKfBOC9AX5
	bl5+WhvPg9fdW2Dw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: [patch 3/9] x86/msr: Add missing __percpu annotations
References: <20240303235029.555787150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  4 Mar 2024 11:12:20 +0100 (CET)

sparse complains rightfully about using a plain pointer for per CPU
accessors:

msr-smp.c:15:23: sparse: warning: incorrect type in initializer (different address spaces)
msr-smp.c:15:23: sparse:    expected void const [noderef] __percpu *__vpp_verify
msr-smp.c:15:23: sparse:    got struct msr *

Add __percpu annotations to the related datastructure and function
arguments to cure this. This also cures the related sparse warnings at the
callsites in drivers/edac/amd64_edac.c.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/msr.h       |   26 ++++++++++++++------------
 arch/x86/include/asm/processor.h |    1 -
 arch/x86/include/asm/tsc.h       |    3 ++-
 arch/x86/lib/msr-smp.c           |   12 +++++-------
 arch/x86/lib/msr.c               |    6 +++---
 5 files changed, 24 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -12,11 +12,13 @@
 #include <uapi/asm/msr.h>
 #include <asm/shared/msr.h>
 
+#include <linux/percpu.h>
+
 struct msr_info {
-	u32 msr_no;
-	struct msr reg;
-	struct msr *msrs;
-	int err;
+	u32			msr_no;
+	struct msr		reg;
+	struct msr __percpu	*msrs;
+	int			err;
 };
 
 struct msr_regs_info {
@@ -323,8 +325,8 @@ static inline int wrmsrl_safe(u32 msr, u
 	return wrmsr_safe(msr, (u32)val,  (u32)(val >> 32));
 }
 
-struct msr *msrs_alloc(void);
-void msrs_free(struct msr *msrs);
+struct msr __percpu *msrs_alloc(void);
+void msrs_free(struct msr __percpu *msrs);
 int msr_set_bit(u32 msr, u8 bit);
 int msr_clear_bit(u32 msr, u8 bit);
 
@@ -333,8 +335,8 @@ int rdmsr_on_cpu(unsigned int cpu, u32 m
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
-void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
-void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
+void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
+void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
@@ -363,14 +365,14 @@ static inline int wrmsrl_on_cpu(unsigned
 	return 0;
 }
 static inline void rdmsr_on_cpus(const struct cpumask *m, u32 msr_no,
-				struct msr *msrs)
+				struct msr __percpu *msrs)
 {
-	rdmsr_on_cpu(0, msr_no, &(msrs[0].l), &(msrs[0].h));
+	rdmsr_on_cpu(0, msr_no, raw_cpu_ptr(&msrs->l), raw_cpu_ptr(&msrs->h));
 }
 static inline void wrmsr_on_cpus(const struct cpumask *m, u32 msr_no,
-				struct msr *msrs)
+				struct msr __percpu *msrs)
 {
-	wrmsr_on_cpu(0, msr_no, msrs[0].l, msrs[0].h);
+	wrmsr_on_cpu(0, msr_no, raw_cpu_read(msrs->l), raw_cpu_read(msrs->h));
 }
 static inline int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no,
 				    u32 *l, u32 *h)
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -20,7 +20,6 @@ struct vm86;
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
-#include <asm/msr.h>
 #include <asm/desc_defs.h>
 #include <asm/nops.h>
 #include <asm/special_insns.h>
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -5,8 +5,9 @@
 #ifndef _ASM_X86_TSC_H
 #define _ASM_X86_TSC_H
 
-#include <asm/processor.h>
 #include <asm/cpufeature.h>
+#include <asm/processor.h>
+#include <asm/msr.h>
 
 /*
  * Standard way to access the cycle counter.
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -9,10 +9,9 @@ static void __rdmsr_on_cpu(void *info)
 {
 	struct msr_info *rv = info;
 	struct msr *reg;
-	int this_cpu = raw_smp_processor_id();
 
 	if (rv->msrs)
-		reg = per_cpu_ptr(rv->msrs, this_cpu);
+		reg = this_cpu_ptr(rv->msrs);
 	else
 		reg = &rv->reg;
 
@@ -23,10 +22,9 @@ static void __wrmsr_on_cpu(void *info)
 {
 	struct msr_info *rv = info;
 	struct msr *reg;
-	int this_cpu = raw_smp_processor_id();
 
 	if (rv->msrs)
-		reg = per_cpu_ptr(rv->msrs, this_cpu);
+		reg = this_cpu_ptr(rv->msrs);
 	else
 		reg = &rv->reg;
 
@@ -97,7 +95,7 @@ int wrmsrl_on_cpu(unsigned int cpu, u32
 EXPORT_SYMBOL(wrmsrl_on_cpu);
 
 static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
-			    struct msr *msrs,
+			    struct msr __percpu *msrs,
 			    void (*msr_func) (void *info))
 {
 	struct msr_info rv;
@@ -124,7 +122,7 @@ static void __rwmsr_on_cpus(const struct
  * @msrs:       array of MSR values
  *
  */
-void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
+void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs)
 {
 	__rwmsr_on_cpus(mask, msr_no, msrs, __rdmsr_on_cpu);
 }
@@ -138,7 +136,7 @@ EXPORT_SYMBOL(rdmsr_on_cpus);
  * @msrs:       array of MSR values
  *
  */
-void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
+void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs)
 {
 	__rwmsr_on_cpus(mask, msr_no, msrs, __wrmsr_on_cpu);
 }
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -6,9 +6,9 @@
 #define CREATE_TRACE_POINTS
 #include <asm/msr-trace.h>
 
-struct msr *msrs_alloc(void)
+struct msr __percpu *msrs_alloc(void)
 {
-	struct msr *msrs = NULL;
+	struct msr __percpu *msrs = NULL;
 
 	msrs = alloc_percpu(struct msr);
 	if (!msrs) {
@@ -20,7 +20,7 @@ struct msr *msrs_alloc(void)
 }
 EXPORT_SYMBOL(msrs_alloc);
 
-void msrs_free(struct msr *msrs)
+void msrs_free(struct msr __percpu *msrs)
 {
 	free_percpu(msrs);
 }


