Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795A77B4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjHNI4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjHNIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:54:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF87E63
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:54:34 -0700 (PDT)
Message-ID: <20230814085114.243119281@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692003272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=urg9ytenNECEHko0hv7V/DJOW+M53i4YgT/nUx/NrAo=;
        b=Dff6vXRY8j7D8T6GTpUIc+eXgxv2k6GB9peCX9NHgSt6tblr9kVrOeGsPDSShLGI699itB
        Ngt+Bmnqzsn3xFYcp8/CwBl2aXfDWmcQ8sMhibhspHnOwDIRylyxzFut0EO1H/0ktB0UX1
        3U68EMcwlZ8g+vEuiiaBL7T1XbYy4A2irrlsBy/4dASiBGYLNDuIQjiIWwPW6QLcb8vb2P
        2WGXUwaoh7AFRffwuJ1btFtYbJJtRhHIpYwASfj2wkNm5sZKlEn2y5K2EYXuh4JV2CyrWZ
        JP4jhd6WTGEBrFPZ299vBOWI1p1s894ajc9tRbCiPgwyAKcHGKEPFdR1c4+47w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692003272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=urg9ytenNECEHko0hv7V/DJOW+M53i4YgT/nUx/NrAo=;
        b=/3Bkwk89vFBQ9+PT8swpGd0ZY+7cJ8X+TIppoi2sZm+AbFuD0fUNIpRus3pmfh87e080I2
        2yDUW5NSVjsZ1EBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Pu Wen <puwen@hygon.cn>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: [patch V4 37/41] x86/cpu: Remove topology.c
References: <20230814085006.593997112@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 10:54:32 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No more users. Stick it into the ugly code museum.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>

---
 arch/x86/kernel/cpu/Makefile   |    2 
 arch/x86/kernel/cpu/topology.c |  164 -----------------------------------------
 2 files changed, 1 insertion(+), 165 deletions(-)

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
@@ -1,164 +0,0 @@
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
-int detect_extended_topology_early(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int eax, ebx, ecx, edx;
-	int leaf;
-
-	leaf = detect_extended_topology_leaf(c);
-	if (leaf < 0)
-		return -1;
-
-	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
-
-	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	/*
-	 * initial apic id, which also represents 32-bit extended x2apic id.
-	 */
-	c->topo.initial_apicid = edx;
-	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
-#endif
-	return 0;
-}
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



