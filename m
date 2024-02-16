Return-Path: <linux-kernel+bounces-68847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A258580EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2611F2128D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B1B1509AE;
	Fri, 16 Feb 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z6qdcApz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/f0Z78o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA414E2E9;
	Fri, 16 Feb 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096652; cv=none; b=r3J8akk3iWiTWv+9+Xw8uqZTWlnusZIFqmqLqecuSNyyaJAmwlg1Y+LdOVxbES+vGMCV+9shNlBBg1iNwfI8nP8oTeuKM7XMiY/bCchrQClOV4fzgL5a+T6BAmPhZDLKGmPIbqfFWN45OiMTpb4oHhce3JZmrhHhjqf3zQvm05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096652; c=relaxed/simple;
	bh=DODkPoqWhTMfrI5oan2h3DRkeB1/XNcUy1xOM7qRdxI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=plHCjJjJrOGqmQARvCWhJW2qsmItXiYUrboZzNkxQLD0rakdHqZWD2dv2PVjmvEQ9ZWgKeXUSbsCWe6yGYFPwBQsRFG/Ls+0i9hj6mW6PAFCOxrgVkhQWdxhbQOgd8eKBbtrU14BFESkuyv9eAtsClQlwtzi0sxb1wPVdY55RxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z6qdcApz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/f0Z78o; arc=none smtp.client-ip=193.142.43.55
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
	bh=ga4yLXsOmv8/4O+8lPqdHWglAMTzbopx2uIk37Fyykk=;
	b=z6qdcApzotVIuEwIKAIZsDVtRCeVgdW125SGq3phIsJvtfMMwcYsEn92RnvrvoRxnr9Bsx
	GnQrQ587wAtAAaRkpbZVbbG2a6EeiZo6Mr5vofRu1Mzqs1kQMiAC5/KNwQjW3IFyRphAow
	HtN0+mgJWhlSIRQ39DN1rg3n4JzI+V8VnBGNdbORfeAKtO75P1A149/UHoWCrhmPZ4MqTz
	V4gdyn1FXAsZxWav3FthNMMXxX2wr+0tjsM2GG+lyg9znSEzwXXyowzJgiv7B9QpzxDbc9
	9g9VNDF4ODEoXscSbpx68Oam4Lihdz5U6Dcm4/3eShS92wnFhKPVwweXCpDZwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096648;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ga4yLXsOmv8/4O+8lPqdHWglAMTzbopx2uIk37Fyykk=;
	b=0/f0Z78o+ZOpbMxVbGmz2ncgbNikUMVLvIRaXRLmDg4Nb3/UnxkqALFFOrJzrf7gOdoHtM
	jN1x2j3TpCr4DODw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu: Make topology_amd_node_id() use the actual node info
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153625.334185785@linutronix.de>
References: <20240212153625.334185785@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664790.398.12723983843351864445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     03fa6bea5a3e13ccbc211af1fa7e75d34239a408
Gitweb:        https://git.kernel.org/tip/03fa6bea5a3e13ccbc211af1fa7e75d34239a408
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:38 +01:00

x86/cpu: Make topology_amd_node_id() use the actual node info

Now that everything is converted switch it over and remove the intermediate
operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153625.334185785@linutronix.de




---
 arch/x86/include/asm/topology.h       | 4 ++--
 arch/x86/kernel/cpu/topology_common.c | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index be27ef7..5d70618 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -136,7 +136,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
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
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index ab944d6..afea34d 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -151,9 +151,7 @@ static void topo_set_ids(struct topo_scan *tscan)
 	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
 
-	/* Temporary workaround */
-	if (tscan->amd_nodes_per_pkg)
-		c->topo.amd_node_id = c->topo.die_id = tscan->amd_node_id;
+	c->topo.amd_node_id = tscan->amd_node_id;
 
 	if (c->x86_vendor == X86_VENDOR_AMD)
 		cpu_topology_fixup_amd(tscan);
@@ -239,6 +237,5 @@ void __init cpu_init_topology(struct cpuinfo_x86 *c)
 	 * AMD systems have Nodes per package which cannot be mapped to
 	 * APIC ID.
 	 */
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON)
-		__amd_nodes_per_pkg = __max_die_per_package = tscan.amd_nodes_per_pkg;
+	__amd_nodes_per_pkg = tscan.amd_nodes_per_pkg;
 }

