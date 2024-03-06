Return-Path: <linux-kernel+bounces-93993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F39A873802
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839A01C21968
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C12131739;
	Wed,  6 Mar 2024 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ku2SIWdj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8rsFia/T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F712D208;
	Wed,  6 Mar 2024 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732578; cv=none; b=jwcxOn5z0XFsxastuvJFCA4KuroMXa2+3vNFx0CsqrUMnLZ9jgIFvVHBWXKEK7ofl1aO8WWPhwfybsAJwZPzvvh+oqzKOzDawRuqM4sK4KkKObeykZkDRhBtr66u/X/jj4HZDdX1Lvweu4/jwLy6VJerrUiDYWROXIdc4svXAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732578; c=relaxed/simple;
	bh=HVjMc8CVQ1jrgupstiVR9/S+aObbWibTgffHr+hczE0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sZ7N/RF7A3BPh+SotVxlEOYfknmPFosS75TCvl+ebly2i3du6JSXltKyXyPmfCe++pRv3hXY77eZOFbLzNj8LT68rWOxo33xO2rjYBwDywgN+RVamPNYJCW1xd5maZG7wM+tRHK641PbQ9XjlGdwt5mF5/HuD1xcOuFp3vCx354=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ku2SIWdj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8rsFia/T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Mar 2024 13:42:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709732575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/UQh+cWN1wv4y4EOOlV9B2v0eJnmk+ZsfSlS1RdISk=;
	b=Ku2SIWdj4fmBTCge69/DtUPqxd3EtKDzw07ycUeRVaHxzwHZctVqWxSKL0+Td5vt2ix9Of
	yWIVZSzt6oKpxhu8MIM1t3j4APHImKtADQDFsihf/WntKimtZoN73LmfW+0fj3ExUl9xLB
	t7tWJ4cHdN5LJccwW1uhDxoK/51i3vfQA3xmt5RGTDXLL5r3u9jb+ImnVG0bqODnBFqYAv
	unm4PmN8bMCeoA04y3B2JVjiTJDB90R7hC+VkFZ49Le8zQq5c8A3LcXj//MRdVxHxlj+lz
	vBcwA//mmvd5oCjv7szufJmC2iaFt7kChtqmBt4nJBX8QRk7CU7SyqVkIrYslA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709732575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/UQh+cWN1wv4y4EOOlV9B2v0eJnmk+ZsfSlS1RdISk=;
	b=8rsFia/TaIFBxCt/G/cTpGbPZaLlpWGhCIw3CNHD5UM/Aez21qVK3hUAE1NUflcsql7Mzp
	HilJiSsLynVVBjBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/topology: Ignore non-present APIC IDs in a
 present package
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87a5nbvccx.ffs@tglx>
References: <87a5nbvccx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170973257400.398.13676030407350802838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     f0551af021308a2a1163dc63d1f1bba3594208bd
Gitweb:        https://git.kernel.org/tip/f0551af021308a2a1163dc63d1f1bba3594208bd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Mar 2024 12:17:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 06 Mar 2024 14:35:30 +01:00

x86/topology: Ignore non-present APIC IDs in a present package

Borislav reported that one of his systems has a broken MADT table which
advertises eight present APICs and 24 non-present APICs in the same
package.

The non-present ones are considered hot-pluggable by the topology
evaluation code, which is obviously bogus as there is no way to hot-plug
within the same package.

As the topology evaluation code accounts for hot-pluggable CPUs in a
package, the maximum number of cores per package is computed wrong, which
in turn causes the uncore performance counter driver to access non-existing
MSRs. It will probably confuse other entities which rely on the maximum
number of cores and threads per package too.

Cure this by ignoring hot-pluggable APIC IDs within a present package.

In theory it would be reasonable to just do this unconditionally, but then
there is this thing called reality^Wvirtualization which ruins
everything. Virtualization is the only existing user of "physical" hotplug
and the virtualization tools allow the above scenario. Whether that is
actually in use or not is unknown.

As it can be argued that the virtualization case is not affected by the
issues which exposed the reported problem, allow the bogosity if the kernel
determined that it is running in a VM for now.

Fixes: 89b0f15f408f ("x86/cpu/topology: Get rid of cpuinfo::x86_max_cores")
Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/87a5nbvccx.ffs@tglx

---
 arch/x86/kernel/cpu/topology.c | 39 +++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 43650fe..3259b1d 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -27,6 +27,7 @@
 #include <xen/xen.h>
 
 #include <asm/apic.h>
+#include <asm/hypervisor.h>
 #include <asm/io_apic.h>
 #include <asm/mpspec.h>
 #include <asm/smp.h>
@@ -157,6 +158,20 @@ static __init bool check_for_real_bsp(u32 apic_id)
 	return true;
 }
 
+static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_level,
+				    unsigned long *map)
+{
+	unsigned int id, end, cnt = 0;
+
+	/* Calculate the exclusive end */
+	end = lvlid + (1U << x86_topo_system.dom_shifts[at_level]);
+
+	/* Unfortunately there is no bitmap_weight_range() */
+	for (id = find_next_bit(map, end, lvlid); id < end; id = find_next_bit(map, end, ++id))
+		cnt++;
+	return cnt;
+}
+
 static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 {
 	int cpu, dom;
@@ -178,6 +193,20 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 		cpuid_to_apicid[cpu] = apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
+		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
+
+		/*
+		 * Check for present APICs in the same package when running
+		 * on bare metal. Allow the bogosity in a guest.
+		 */
+		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
+		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
+			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
+				     apic_id);
+			topo_info.nr_rejected_cpus++;
+			return;
+		}
+
 		topo_info.nr_disabled_cpus++;
 	}
 
@@ -280,7 +309,6 @@ unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which_uni
 {
 	/* Remove the bits below @at_level to get the proper level ID of @apicid */
 	unsigned int lvlid = topo_apicid(apicid, at_level);
-	unsigned int id, end, cnt = 0;
 
 	if (lvlid >= MAX_LOCAL_APIC)
 		return 0;
@@ -290,14 +318,7 @@ unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which_uni
 		return 0;
 	if (which_units == at_level)
 		return 1;
-
-	/* Calculate the exclusive end */
-	end = lvlid + (1U << x86_topo_system.dom_shifts[at_level]);
-	/* Unfortunately there is no bitmap_weight_range() */
-	for (id = find_next_bit(apic_maps[which_units].map, end, lvlid);
-	     id < end; id = find_next_bit(apic_maps[which_units].map, end, ++id))
-		cnt++;
-	return cnt;
+	return topo_unit_count(lvlid, at_level, apic_maps[which_units].map);
 }
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU

