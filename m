Return-Path: <linux-kernel+bounces-68843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D348580E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B19B2868D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D867914E2EE;
	Fri, 16 Feb 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4TZAUPdC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B1vje755"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7612F58D;
	Fri, 16 Feb 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096649; cv=none; b=VehfgDRHtEjllwvNHV44EJkemrIGwHenZDBwCAxvhrIcQZFwUJJy5Lr4vLOpJ0FmA1ED+rdnkG8WXj0pJBPGnlQ67F8TvAK7l94Yiq6TP/u7hD9kvgksglfV9ismSlQufrUL8u2dQ6Yov6MdV/B19gQFRlUHUPt7rSZ+exe3b/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096649; c=relaxed/simple;
	bh=8cdF4nJc/NezUQ1k15TPJrqCgYyOPfS4W5KTkMfEusg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=juKq6tdYv7HPE532Pt7Qw8ZZH/PdJefJvDHk2I+oSEUO+poPD7ppkJ7s1xwEYF0f0oxBp5DA57teUbojY8nUY2A4wN5KADWNbP2dv2bnW3RG3PkX2NDq6ndAoMXs9TsVt40Mg7eHh1LeH9Y8pi6n/B1dX2wJtzhDkxGlYprIlb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4TZAUPdC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B1vje755; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nyf5vPBCyA9RJo+YS/uARuaBg+gykllQ+AWwiGrcIg=;
	b=4TZAUPdCPtv7ZJb0nb7LmaFyW72HDhqSF5kRCD4Eyj/kq1q8+qPQGM3upVNj0niJ3q7a4P
	5B/ti/+CGxhp3TE2D7CLvIQvddkc4bRwTKbNWcgtr/Oex3PW+BlUI2sx7jRYlI4Mpha27F
	27EJnuZgCVWzxCD1MCCnpZmNq7s9GfLa6vLZ+tO5CLyuHWS5ychTmgoME92kPjiFyW05Cw
	LIMETiu8ZacDFG9XM+VfgnhgJwB1506hjP+tIYan7ij0FWNWQy5h27RDZ/6kFmfMbuCquD
	7ryYM+grlsdlwh7oCEsaofTGyhffqZC3Rl99+aApF1sYNEIQ/Foi3L1syc7Xmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nyf5vPBCyA9RJo+YS/uARuaBg+gykllQ+AWwiGrcIg=;
	b=B1vje755DNTJLgIDDbAmeJqAywIafrZ2a25FO0OzbWjTeeCDnmlwxs9EKCMKPW35cr0C0g
	25Bk3m6g2Sr0sLDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/uv: Remove the private leaf 0xb parser
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153625.637385562@linutronix.de>
References: <20240212153625.637385562@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664482.398.109104581721016072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     bcccdf8b30736250d5057e0940468a41d633e672
Gitweb:        https://git.kernel.org/tip/bcccdf8b30736250d5057e0940468a41d633e672
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:39 +01:00

x86/apic/uv: Remove the private leaf 0xb parser

The package shift has been already evaluated by the early CPU init.

Put the mindless copy right next to the original leaf 0xb parser.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153625.637385562@linutronix.de




---
 arch/x86/include/asm/topology.h    |  5 +++-
 arch/x86/kernel/apic/x2apic_uv_x.c | 52 +++++------------------------
 2 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 5d70618..cb6bafd 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -126,6 +126,11 @@ static inline unsigned int topology_get_domain_size(enum x86_topology_domains do
 	return x86_topo_system.dom_size[dom];
 }
 
+static inline unsigned int topology_get_domain_shift(enum x86_topology_domains dom)
+{
+	return dom == TOPO_SMT_DOMAIN ? 0 : x86_topo_system.dom_shifts[dom - 1];
+}
+
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 51485f2..3ae696f 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -241,54 +241,20 @@ static void __init uv_tsc_check_sync(void)
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

