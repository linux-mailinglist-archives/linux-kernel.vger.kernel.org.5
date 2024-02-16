Return-Path: <linux-kernel+bounces-68845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CDA8580E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24F89B24D98
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE9E1509A3;
	Fri, 16 Feb 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AprpjNXj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4zzpiKLB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E2413A88C;
	Fri, 16 Feb 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096652; cv=none; b=GQKo09dZqENNDWhfMfCsIA3UbYUekCE+NeL2qh3/HKw87ZE8RJUhur/qwKeCk3CdNktTnSQ2gCqEhfQ98ZbGevDXzKGosAB2L0DSfPln0FU8C6rNKbUQv1RIc0mvfsj1f2JpF43XG5nbYfhU4ynOJn5Vh3w5/egVu3tqVu10TYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096652; c=relaxed/simple;
	bh=MM7uMn1RYHGCgITyp7H4GITqSWKdgTHOn9JG6TPI+Bk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ijAj4rp20UlYUxEkBySS77XZXUeb3WpXUM2oPR9Hbwk1wfmXaya6FuXCSKNhy5Lm1Rbvbe0ViF9WmEHTU+pKgKiBDvHXsXlaumFofF6sVbiyYzcxURTstE48mCloNBP7HhvMxnltEZSj0cTntKppFg92GaAhenYkJINQuO8ec6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AprpjNXj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4zzpiKLB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNFZUOufmBfkDj7IWDVhLPxuoB6jTTbML3KVZXjZ8po=;
	b=AprpjNXj4jOXmuyeznm/971nWxC21xmQPXH2fXaUmhBHu3a0e/MpqSnmk8hodpqTiFnvki
	ucJ6PNsKKuUYqxfusxFWiZF2dxyNW9+9asvucAf1dg07rzglxtbcamJwEA3Hs+63HPXAK6
	04cWtgSPUByVOHkmh2dS0TlmnNgEuntr/+lY90rSJxS0OjRB4zLojWQ3J7bHzdR6Sn9T5O
	8BRIRk/FJHvBW0jlbNvuwctArqPHFxANPCfWs/3S7unNpfW9iSzGZItgFVMuAkP2aXmwzr
	Q+lXBB4bTbNsDQm+4T4rbAdx0v2vJDcUu+sKGTBzTQya1xdHPx7BWph/q9Z8GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNFZUOufmBfkDj7IWDVhLPxuoB6jTTbML3KVZXjZ8po=;
	b=4zzpiKLBoUUbQZCO7tE1OHcnbQPAhuLTAQ2wMH+MFet7eAu1zCILlU2RDTDVt9X/Ax5L/D
	8xbeMpEm1anNvwDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu: Remove topology.c
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153625.395230346@linutronix.de>
References: <20240212153625.395230346@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664731.398.4208655545771342974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     6cf70394e7205a0d65780473aa2081839eb93471
Gitweb:        https://git.kernel.org/tip/6cf70394e7205a0d65780473aa2081839eb93471
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:38 +01:00

x86/cpu: Remove topology.c

No more users. Stick it into the ugly code museum.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153625.395230346@linutronix.de




---
 arch/x86/kernel/cpu/Makefile   |   2 +-
 arch/x86/kernel/cpu/topology.c | 142 +--------------------------------
 2 files changed, 1 insertion(+), 143 deletions(-)
 delete mode 100644 arch/x86/kernel/cpu/topology.c

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 3ee24ff..9e0a1c1 100644
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
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
deleted file mode 100644
index 2b68f26..0000000
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

