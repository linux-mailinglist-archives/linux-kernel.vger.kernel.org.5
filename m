Return-Path: <linux-kernel+bounces-64253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CA7853CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59BF1C22FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D7634E4;
	Tue, 13 Feb 2024 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U5Pp3qo2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OuW8RoM/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285C6313D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858262; cv=none; b=O3zH+iI7VLfAKKzP1wjug5DKb5XjZoDRdILpNvXxKhE+Zj+igag2UlFaYlEMHbcAKN+b+w9okDWfThL78JOjw6DkiTyeUHx2q5vu2XtOwsm+IyquyyKgawguezoVW0UF/KoToKwRtOGRWVZNC7Bv5ONMQnmzitpGswqDXAnbwDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858262; c=relaxed/simple;
	bh=ju+innb8pslJNbHLpQZZ85FEKafEiKhoPCGqWWY5XPA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=hbBsuK79UTU8Sj02Dc9JkfhaJArOUaBqWVxH9dVI9zHw9c/ztnlZWLTc4p9t3ql2ZbC+slWRWEhInj3PcIlmQR2733p0ehNYcZRKZTjTJnPoi4h8t1E8Le9Fgi/xNLacZs04gnU+lnZEEnhtj11rituz2vvhTFvtAi+O140MmeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U5Pp3qo2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OuW8RoM/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153625.334185785@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nO4ogXL/zm7ZWMdibHmPpa5pkbujidxyjVnPPEz6XAY=;
	b=U5Pp3qo2dgZ+6nKrO87s840JNvSJ0Cq0xNpvxQd6BhFsH6TeIZbesT3Xuh9prd6sm3xUma
	TseBYhlKPHYPbQrMaTa347h0SRNvGUjmsWUd0lZL4OtncJyI4YPPva149Tp5tUAVj5RLc6
	dO/2qUfsTLeZw79CxeN+L4TVDD1ssuUNSDEHZmHxs/24Qm9cKvisU0H3DkBXEitnhMGXBa
	R12srUPyWK3TJuIaymgI0V2fjUXVbqLpH3X1tV2ENN+whuZZulzNN5deHcJtc9WqFb6ML8
	lgcUPR4OJ6CDaUbBT8h+zmjCce1NfZoU8YX9Qv+R2wAblZHMwog+phWQS1+Psw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nO4ogXL/zm7ZWMdibHmPpa5pkbujidxyjVnPPEz6XAY=;
	b=OuW8RoM/aGOVYEtRchwxSfNKVw8h2F+3uHAit1rv3k+DqJw8yxEyUkgN1dADlcXV9vaGwY
	rtjXcQ1qdw1EsWAg==
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
Subject: [patch V6 14/19] x86/cpu: Make topology_amd_node_id() use the actual
 node info
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:18 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Now that everything is converted switch it over and remove the intermediate
operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>



---
 arch/x86/include/asm/topology.h       |    4 ++--
 arch/x86/kernel/cpu/topology_common.c |    7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)
---

--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -136,7 +136,7 @@ extern const struct cpumask *cpu_cluster
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
-#define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.die_id)
+#define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.amd_node_id)
 
 extern unsigned int __max_die_per_package;
 
@@ -172,7 +172,7 @@ extern unsigned int __amd_nodes_per_pkg;
 
 static inline unsigned int topology_amd_nodes_per_pkg(void)
 {
-	return __max_die_per_package;
+	return __amd_nodes_per_pkg;
 }
 
 extern struct cpumask __cpu_primary_thread_mask;
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -151,9 +151,7 @@ static void topo_set_ids(struct topo_sca
 	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
 
-	/* Temporary workaround */
-	if (tscan->amd_nodes_per_pkg)
-		c->topo.amd_node_id = c->topo.die_id = tscan->amd_node_id;
+	c->topo.amd_node_id = tscan->amd_node_id;
 
 	if (c->x86_vendor == X86_VENDOR_AMD)
 		cpu_topology_fixup_amd(tscan);
@@ -239,6 +237,5 @@ void __init cpu_init_topology(struct cpu
 	 * AMD systems have Nodes per package which cannot be mapped to
 	 * APIC ID.
 	 */
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
-		__amd_nodes_per_pkg = __max_die_per_package = tscan.amd_nodes_per_pkg;
+	__amd_nodes_per_pkg = tscan.amd_nodes_per_pkg;
 }



