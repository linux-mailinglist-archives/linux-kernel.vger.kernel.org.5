Return-Path: <linux-kernel+bounces-64284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC584853CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F192841EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F2627F5;
	Tue, 13 Feb 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K/e274NZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="75KGno8n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCD778B67
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858325; cv=none; b=EWWMyrW4mulmO/+l9wTjzD/wb5Dhx4/24StSGId1rg/kMEIIBo/Nzn6UQcN3NZkSmKYZY9Txx2zqv7bR9bNdxwz33juF4h24EmH5OY1f0W5gpN+SHc6OJKukCAOkENGIgMAuMMkiHgzs8btO5Fab20JCnjIXnAt1AYhjrB2MYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858325; c=relaxed/simple;
	bh=jcnrKQ8bGa1cI8YUc48EGSYADKgqOdIYaLgH8rg4ccM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sH2RkhPQXN0qlPUrkBU5b9bI2NpGeDiDyk4NjUFDq7fUGslbjUYRp59zbZjPYk/C7dj7L9UAGOAgrDV+qHs+Q1KsztdQlXgwO4eldyLAaY6KbcYxkY1OOJGuKM+fpqdrrjeFAy9m//4QRlsIvKWN3CSaRuOCkbsK7dGXr4gLwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K/e274NZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=75KGno8n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154640.177504138@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qpOqg8wHgWldzZv4rvX2WggJPz3SVoiC9O3+E9lyex8=;
	b=K/e274NZbDcRp4r1Y7Wy/RBSt6CiOsSqWdb47mBRlxNqEdvzxhbt3RnXj7qe0FZHN9cGBX
	oTeqHthR0sc4nEOF4jxxUgVhmd/ROeMc0HFWMLA44hmTGbeRb67DHyQ4ZZoEOwYtbwRAHH
	geFrx+Qy49AocvOIO3sAQfS8wTvedyEeG9lG1sYEzRbdApSvAxZgBndyFFDA3advQBVGlD
	c26MGoFU0ju1GChH0Ja3hvv6NMHl7M48r3/3dr/2/Ho17rMbrLjakUkWkdyxLSPFLtrGUU
	GEEvv4dbn3Y20Xo5cOAKQvXv9vU8UYg0nQWcPKHS6uMfZhT+gviBwSRjbeKeyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qpOqg8wHgWldzZv4rvX2WggJPz3SVoiC9O3+E9lyex8=;
	b=75KGno8nXfqDJKSNNZgy8X4Blr6YUpxPmpWrsBfhYqvtXNGPXRcYaUifTgOiKKdppKlleb
	rxykisF84IaPjzBQ==
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
Subject: [patch V3 22/22] x86/apic: Use a proper define for invalid ACPI CPU
 ID
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:21 +0100 (CET)

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



