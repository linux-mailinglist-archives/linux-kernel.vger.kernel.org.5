Return-Path: <linux-kernel+bounces-35279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9592D838EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82E61C22CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E4C5F55B;
	Tue, 23 Jan 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOC3Q1Nf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hiUJeyIv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D228D604C9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014436; cv=none; b=DhhwcvmA6LDLtkqXaOh5yd74/psFDEMQtZXPNbeSYjcTUZoYkX7NgyLpBiAHPVzVEMgG+SOFS+aJ2dT990SKyaZzzelmQp8P4ogc8VW68DN5ArltnTTKpKB+P+ADWLQulvoKQ9MLyi13SMk+YtbXrZm9l1o5xRQg6wdbBiQxIvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014436; c=relaxed/simple;
	bh=dxJPvwsmxdFo/LFFVRtcyswigBmF+7W8Cgmx74fu2jA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Qo9E9nvu2/9gtDGICKK8sHJFmmik9IwAF2i1sp8SA9RKF01gl8WpNvYmtuK/c4jFfRKq0zctw9JGcBX8JJNo+kdorRnfWCKEw6YYSF8Uu7NluknDYQtsXjmFajQKz02jzzHqZdccOiJlj2MIuSf9BaIe7QTC2xfqJsmnetFs/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IOC3Q1Nf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hiUJeyIv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115909.207795463@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LX3PhNTWCMPpuLR0eISm6zXY5IPronq86Dl5H/SqaXU=;
	b=IOC3Q1NfZoYkF2fUzZ84snVBGvQ7qQPuJa7wto/Fp5PguyXR5ZrOcwruDzLypsR8sd8jW3
	ayWFiud+i1RldfMfLKPPrfYguuXXz2yatNNOi+EnK6rlenFnVSPjm5KXjxnRNSDKEQyBNf
	YAG1ezk1YU4lomTyOChB3opnW+AWfrsdiMBgmcFANL5E5sb7XN+h5kvVtA3MBpotPBPMgF
	afpPnBwJNiabzW7Z8mOKOA/U8ROqPd7LF6mqhdh0C0LnkaMNIWeJYWy3txf+Bt4zxPM50r
	Bah8w2pZj/YUMPJrh6SDvBdPJxSuvDmJ7n660XqixxgJgmtr77w1lv0GaQcHqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LX3PhNTWCMPpuLR0eISm6zXY5IPronq86Dl5H/SqaXU=;
	b=hiUJeyIvJJiyUuLZ23DsYlP/DPL0gfMcE8mi/OMP+Sq2nN/BbnBGc4/Ef84h0bBLdtyBh8
	8t7mLZ2Qvxu1eQCQ==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v5 14/19] x86/cpu: Make topology_amd_node_id() use the actual
 node info
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:52 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Now that everything is converted switch it over and remove the intermediate
operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


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


