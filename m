Return-Path: <linux-kernel+bounces-64254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDCE853CA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E2028304A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4D64A80;
	Tue, 13 Feb 2024 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FGQ4SkzP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ljlKok6N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EA63408
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858263; cv=none; b=P3nSeqYcZsa1UutXVk77tgLmAHm0e9dWqfYWPBNTwG74q5LfNbS/SjypUqEH1EyOM2Uar1r8VIMzl3FEviwyfBSLtBSK6NEbfyCPU3QNCxRa8MVdtS94lZyfjjAmmSkJynG0nm+4/gutczx6y0P9krUxgOpgghqxJB7EZ6MaCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858263; c=relaxed/simple;
	bh=swUJgfNVhjwrZII83+6GSi9j+s/XkYQeOa3Vgleo/6M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=q6XvxG35ZrzVgJ6kQx6wFGIRoyEeIxWiISkpsrdsZXN+EVmItBy0CZo+N9vsBzAShwJyVHQMVL1sLsnKQH6nye5w02mFC77Guv2WNyq45ACos9/qshmZ/KhqFVM+MbuMkrrNyhTn7HGYaRXxJNhSnzxnw5hc13XTwRHQr7s9RKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FGQ4SkzP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ljlKok6N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153625.395230346@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=14vpVUg4NgC36dmKytDzQfFlwR9EgV0MbRQlWlktVgs=;
	b=FGQ4SkzPjDldemscVxHubKqj2q2akEv4L0rrEaBQHyS+fBeQwPQ/DVU04Zgm9AZeECLYwL
	L8E31sKzm0F60hf5+7nMJUAD8WoYi6BdRANRb39KRTJsKaGBPuUOI1C8tG54xu+eUKnuky
	+QMBxIl0KJ4rCiY3vMjZcOJLx+eTThkMSCsv7gatwBF5AlJ3sQnSdXwVI0NKY4W3F3XeBu
	BFNsxv0MUtqNZBKbsQpvJGkKo8w0y5sNUACMX0lITJvWwOzsx2DDndE9KLzUpNnb+J6IFl
	pVzmtAWnOxma9Zuf/V+GJt26VL7qzBLSvV57MlMCaBmcX8lSzKpCrqU2A8OCeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=14vpVUg4NgC36dmKytDzQfFlwR9EgV0MbRQlWlktVgs=;
	b=ljlKok6NhHVzl5ifmbvoq5yCK88BzpB4EQkbzhrdOUhfnsw7VL5rXtKhoncqS6rrygGzcF
	BTR5zsje96xHt4Cw==
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
Subject: [patch V6 15/19] x86/cpu: Remove topology.c
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:20 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

No more users. Stick it into the ugly code museum.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>



---
 arch/x86/kernel/cpu/Makefile   |    2 
 arch/x86/kernel/cpu/topology.c |  142 -----------------------------------------
 2 files changed, 1 insertion(+), 143 deletions(-)
 delete mode 100644 arch/x86/kernel/cpu/topology.c
---

--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -18,7 +18,7 @@ KMSAN_SANITIZE_common.o := n
 KCSAN_SANITIZE_common.o := n
 
 obj-y			:= cacheinfo.o scattered.o
-obj-y			+= topology_common.o topology_ext.o topology_amd.o topology.o
+obj-y			+= topology_common.o topology_ext.o topology_amd.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
--- a/arch/x86/kernel/cpu/topology.c
+++ /dev/null
@@ -1,142 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Check for extended topology enumeration cpuid leaf 0xb and if it
- * exists, use it for populating initial_apicid and cpu topology
- * detection.
- */
-
-#include <linux/cpu.h>
-#include <asm/apic.h>
-#include <asm/memtype.h>
-#include <asm/processor.h>
-
-#include "cpu.h"
-
-/* leaf 0xb SMT level */
-#define SMT_LEVEL	0
-
-/* extended topology sub-leaf types */
-#define INVALID_TYPE	0
-#define SMT_TYPE	1
-#define CORE_TYPE	2
-#define DIE_TYPE	5
-
-#define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
-#define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
-#define LEVEL_MAX_SIBLINGS(ebx)		((ebx) & 0xffff)
-
-#ifdef CONFIG_SMP
-/*
- * Check if given CPUID extended topology "leaf" is implemented
- */
-static int check_extended_topology_leaf(int leaf)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-
-	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
-		return -1;
-
-	return 0;
-}
-/*
- * Return best CPUID Extended Topology Leaf supported
- */
-static int detect_extended_topology_leaf(struct cpuinfo_x86 *c)
-{
-	if (c->cpuid_level >= 0x1f) {
-		if (check_extended_topology_leaf(0x1f) == 0)
-			return 0x1f;
-	}
-
-	if (c->cpuid_level >= 0xb) {
-		if (check_extended_topology_leaf(0xb) == 0)
-			return 0xb;
-	}
-
-	return -1;
-}
-#endif
-
-/*
- * Check for extended topology enumeration cpuid leaf, and if it
- * exists, use it for populating initial_apicid and cpu topology
- * detection.
- */
-int detect_extended_topology(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int eax, ebx, ecx, edx, sub_index;
-	unsigned int ht_mask_width, core_plus_mask_width, die_plus_mask_width;
-	unsigned int core_select_mask, core_level_siblings;
-	unsigned int die_select_mask, die_level_siblings;
-	unsigned int pkg_mask_width;
-	bool die_level_present = false;
-	int leaf;
-
-	leaf = detect_extended_topology_leaf(c);
-	if (leaf < 0)
-		return -1;
-
-	/*
-	 * Populate HT related information from sub-leaf level 0.
-	 */
-	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	c->topo.initial_apicid = edx;
-	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
-	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
-	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
-	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-
-	sub_index = 1;
-	while (true) {
-		cpuid_count(leaf, sub_index, &eax, &ebx, &ecx, &edx);
-
-		/*
-		 * Check for the Core type in the implemented sub leaves.
-		 */
-		if (LEAFB_SUBTYPE(ecx) == CORE_TYPE) {
-			core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
-			core_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-			die_level_siblings = core_level_siblings;
-			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-		}
-		if (LEAFB_SUBTYPE(ecx) == DIE_TYPE) {
-			die_level_present = true;
-			die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
-			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-		}
-
-		if (LEAFB_SUBTYPE(ecx) != INVALID_TYPE)
-			pkg_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-		else
-			break;
-
-		sub_index++;
-	}
-
-	core_select_mask = (~(-1 << pkg_mask_width)) >> ht_mask_width;
-	die_select_mask = (~(-1 << die_plus_mask_width)) >>
-				core_plus_mask_width;
-
-	c->topo.core_id = apic->phys_pkg_id(c->topo.initial_apicid,
-				ht_mask_width) & core_select_mask;
-
-	if (die_level_present) {
-		c->topo.die_id = apic->phys_pkg_id(c->topo.initial_apicid,
-					core_plus_mask_width) & die_select_mask;
-	}
-
-	c->topo.pkg_id = apic->phys_pkg_id(c->topo.initial_apicid, pkg_mask_width);
-	/*
-	 * Reinit the apicid, now that we have extended initial_apicid.
-	 */
-	c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
-
-	c->x86_max_cores = (core_level_siblings / smp_num_siblings);
-	__max_die_per_package = (die_level_siblings / core_level_siblings);
-#endif
-	return 0;
-}


