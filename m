Return-Path: <linux-kernel+bounces-35341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C02D838F91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9A21C264B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45395612F1;
	Tue, 23 Jan 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UEVIy6oE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aUdoqybu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65A60EE3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015442; cv=none; b=rprhJn/h7sDqP+QgV2vimyE51h4EeVE4+trz2XtrdQ9ayc56afnXoOc6q3xeZF3t2+GxLLG3+AI20xVRY9iG6aowmTF0GrvVEx/1ogDXn2FgD/Ej+vHkFv4qtm4zmTn5yLuKggTmZNCoE4QAznUVLVdGEFUT/tBq6pLU5Zg/oss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015442; c=relaxed/simple;
	bh=AE4dZsRbyr3vUhUyBHWNypcCq33ucFwqdi8D4pvpD9A=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=XkOl+u+KzKZbDYLlfH9Dnj6/EFzCcqjb8aNkNVlgONFtPd3ZcvlOZrxdIcQ9tePvrRYliQs/bvB4FxpsPetlKVix85wQIN0ac1oAkZVFQauqW6kZB7ovChPEOHpnBhY9om0gJhEmpPkWIyraqd7bQqUdJVN5wLirqrQJkwILBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UEVIy6oE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aUdoqybu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.751221896@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ObQjgEZAVOIadbux4exdLxLm8qYGhhhJuLqW/+F62q8=;
	b=UEVIy6oEksLp4SORFFBZrhAKW9TX+n49e92axNiNsGbodyk2ytGLZ+6IBVf8IDZV/fCIrP
	+ZIgBZ09eTbeHaJnjDONxnRObLvA5MVECmPRpXHH0O4EYDtikm3FcUkcM4WyVy/H+c4Hwv
	OeWt4gB28TruDBQQOM5jyZhhcAKA8aj/gbw867CmKgF64wb9kVEXDwFaL9HRVa++67te2L
	gRbPYY2TdeQyWbwmko/8R2i5o1oSZdiEhdcnth55lfrYUZvskCBgt+aMeDhPk7BJoWwa3H
	v899EsXBf9RbXSX9KRX3dnquR3OeOJFQW9KCeUTDz1bH4k2zANKZ+2AySwYuuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ObQjgEZAVOIadbux4exdLxLm8qYGhhhJuLqW/+F62q8=;
	b=aUdoqybug0v94gWbvqUBSOQfDFWJmfmlIonAvmX/XutLGX5Yd7SbvKWKzOXkAwbGJdEI6R
	g8v9gWrRJaiPcpBw==
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
Subject: [patch V2 22/22] x86/apic: Use a proper define for invalid ACPI CPU
 ID
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:38 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The ACPI ID for CPUs is preset with U32_MAX which is completely non
obvious. Use a proper define for it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/apic.h  |    3 +++
 arch/x86/kernel/apic/apic.c  |    2 +-
 arch/x86/xen/enlighten_hvm.c |    2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -48,7 +48,10 @@ static inline void x86_32_probe_apic(voi
 
 extern u32 cpuid_to_apicid[];
 
+#define CPU_ACPIID_INVALID	U32_MAX
+
 #ifdef CONFIG_X86_LOCAL_APIC
+
 extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -111,7 +111,7 @@ static inline bool apic_accessible(void)
  * Map cpu index to physical APIC ID
  */
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_apicid, BAD_APICID);
-DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, U32_MAX);
+DEFINE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid, CPU_ACPIID_INVALID);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_apicid);
 EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
 
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -168,7 +168,7 @@ static int xen_cpu_up_prepare_hvm(unsign
 	 */
 	xen_uninit_lock_cpu(cpu);
 
-	if (cpu_acpi_id(cpu) != U32_MAX)
+	if (cpu_acpi_id(cpu) != CPU_ACPIID_INVALID)
 		per_cpu(xen_vcpu_id, cpu) = cpu_acpi_id(cpu);
 	else
 		per_cpu(xen_vcpu_id, cpu) = cpu;


