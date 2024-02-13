Return-Path: <linux-kernel+bounces-64259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 325DA853CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D687D1F2838C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301464CF8;
	Tue, 13 Feb 2024 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTjlJ759";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fw6zbRxa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CD861687
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858269; cv=none; b=YhVA196MFhbdMSi3XYUc4Fbc3HYMsV2J6zPh8IPDRe0FvucoFcQyjBtgWmhSTU2ysHooieA+NS9/i0gy231rzPWfX5t5SIDrtOlW1H2rGaOyqcuMt81yaXXnqjM36lCBWN7dC0BqTqLmYkTH0L0MJX3bDcLno69RE3mRHNuQlL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858269; c=relaxed/simple;
	bh=7Cb7/du6kErwh45yPf9eV+BkuCekgKIyTT0FgHiX2Ng=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dnTChBWBKZbQzCdLVcZPJlFrIaXlIfOjcTonGOI0C73pKScZtixJqmv9YChisrQ90WbLZpVW2PbEU8IlKBhDof63GYHeNDbqxCupy8L0PYsDGlwAkQQ8RJRqO3cZPFN+NbNUCjJZAooP/WuGn6JVE1MXcmbQRyKPTCo1ga8hGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTjlJ759; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fw6zbRxa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153625.637385562@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XwJ0QaSKJYUlMs7BjkVS3/Pl3Z3VCdhmpQOd6QtZAx0=;
	b=MTjlJ759gd5o1C1FOVxEVvqfiLiLMnWFreFRGVdtm47vuADZ5jP4QKLaY6fazFkbbG5Tpy
	B4ZraYt2T2jaPeMVLv3vlU5j/u+LJ1xIeANU4Dp2YbqrrX+F3z7Ax37aUNDX7vgQKt4API
	d6h+9QQrgpDdkjX+R8woCQB9zDdnipLW81Bkh2ELXH/lak7qyQEcbVtBkzyOWjbwqjvdnS
	0Rj/cXusxnmIjq+z1Y5a8itXCbq9nA2QOq9/VjeMw6DUV3KD0dlGI5JlrD2iXYgtWZyHHx
	7y0QlDrkIS6jsqY/elM2zusSEUc6eZzTmK58ZwI7jVVxiUamQ4N3ZlFyNdHB3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XwJ0QaSKJYUlMs7BjkVS3/Pl3Z3VCdhmpQOd6QtZAx0=;
	b=fw6zbRxauUpt0eEYzaLL7grA1cJAGhQjblfSKgAWTKJoqKRy8TdcacRmauvd3gIovW9bBL
	On79xOtSmWSKOzCw==
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
 Wang Wendy <wendy.wang@intel.com>
Subject: [patch V6 19/19] x86/apic/uv: Remove the private leaf 0xb parser
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:25 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The package shift has been already evaluated by the early CPU init.

Put the mindless copy right next to the original leaf 0xb parser.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>



---
 arch/x86/include/asm/topology.h    |    5 +++
 arch/x86/kernel/apic/x2apic_uv_x.c |   52 ++++++-------------------------------
 2 files changed, 14 insertions(+), 43 deletions(-)
---

--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -126,6 +126,11 @@ static inline unsigned int topology_get_
 	return x86_topo_system.dom_size[dom];
 }
 
+static inline unsigned int topology_get_domain_shift(enum x86_topology_domains dom)
+{
+	return dom == TOPO_SMT_DOMAIN ? 0 : x86_topo_system.dom_shifts[dom - 1];
+}
+
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -241,54 +241,20 @@ static void __init uv_tsc_check_sync(voi
 	is_uv(UV3) ? sname.s3.field :		\
 	undef)
 
-/* [Copied from arch/x86/kernel/cpu/topology.c:detect_extended_topology()] */
-
-#define SMT_LEVEL			0	/* Leaf 0xb SMT level */
-#define INVALID_TYPE			0	/* Leaf 0xb sub-leaf types */
-#define SMT_TYPE			1
-#define CORE_TYPE			2
-#define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
-#define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
-
-static void set_x2apic_bits(void)
-{
-	unsigned int eax, ebx, ecx, edx, sub_index;
-	unsigned int sid_shift;
-
-	cpuid(0, &eax, &ebx, &ecx, &edx);
-	if (eax < 0xb) {
-		pr_info("UV: CPU does not have CPUID.11\n");
-		return;
-	}
-
-	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE)) {
-		pr_info("UV: CPUID.11 not implemented\n");
-		return;
-	}
-
-	sid_shift = BITS_SHIFT_NEXT_LEVEL(eax);
-	sub_index = 1;
-	do {
-		cpuid_count(0xb, sub_index, &eax, &ebx, &ecx, &edx);
-		if (LEAFB_SUBTYPE(ecx) == CORE_TYPE) {
-			sid_shift = BITS_SHIFT_NEXT_LEVEL(eax);
-			break;
-		}
-		sub_index++;
-	} while (LEAFB_SUBTYPE(ecx) != INVALID_TYPE);
-
-	uv_cpuid.apicid_shift	= 0;
-	uv_cpuid.apicid_mask	= (~(-1 << sid_shift));
-	uv_cpuid.socketid_shift = sid_shift;
-}
-
 static void __init early_get_apic_socketid_shift(void)
 {
+	unsigned int sid_shift = topology_get_domain_shift(TOPO_PKG_DOMAIN);
+
 	if (is_uv2_hub() || is_uv3_hub())
 		uvh_apicid.v = uv_early_read_mmr(UVH_APICID);
 
-	set_x2apic_bits();
+	if (sid_shift) {
+		uv_cpuid.apicid_shift	= 0;
+		uv_cpuid.apicid_mask	= (~(-1 << sid_shift));
+		uv_cpuid.socketid_shift = sid_shift;
+	} else {
+		pr_info("UV: CPU does not have valid CPUID.11\n");
+	}
 
 	pr_info("UV: apicid_shift:%d apicid_mask:0x%x\n", uv_cpuid.apicid_shift, uv_cpuid.apicid_mask);
 	pr_info("UV: socketid_shift:%d pnode_mask:0x%x\n", uv_cpuid.socketid_shift, uv_cpuid.pnode_mask);


