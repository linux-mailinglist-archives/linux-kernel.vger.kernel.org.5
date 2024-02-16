Return-Path: <linux-kernel+bounces-68798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AFD858082
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06ECEB21D80
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F026130E37;
	Fri, 16 Feb 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o6wxKkMC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0dmvNtVo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E612FF6A;
	Fri, 16 Feb 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096615; cv=none; b=AuNJ9vLg38lddFVoG5iEl5ak0tmox2b9Na07gftYWVTQ83FUyL7G7J+W5SUH2WDm0ZuMHOr95LFV0ZkejKHEQf6O7AxVlhPFACTw+m67Qa+wmWPYluwx7yhBFstMlnXoOORUf5zv5vb3LyOWKB2z0ezP2M6EAxk7dZCiyPNlDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096615; c=relaxed/simple;
	bh=+iCBmghLvJVLfiGpSV1Z3ppsEi6mg8VJ9OHCHddr75k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=McrYZBP9R9AvSWZFEi+Ah4UKYGgKWfyV+tAKKiKZH1AHqNT0M6UYaA+K0pyVKfyeOPW2YOSzf1jG7ZLoLOlGCI27tnTe5rn1I2OtMEffCdSQ2YaHxJr/+Mnz8iHaVLhruW5j5vE7yTLR9nKXuXiJ4VVaU0nInFjRNciIqUajRN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o6wxKkMC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0dmvNtVo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rPsFwIag80nH8xCEKkQYS0E3xZOuBJPGMzSNXnwWL0=;
	b=o6wxKkMCEZV+95m7jOeNhcjPFCcp5UqMiP3BKv4BcsJhtqjKhBHhrVtBRPAOZXpM6zQIKL
	be6NP/MZ0h68Ir8MUl/vM14aNaa5YrgrF5us8zEd6x38PJ5XQk+7zdfN9nNtAOnxfP+5sI
	5wbZLbxWQUTTceMnY5tN4SUgxOD/u7X/3ArfMkfOtVO9GrMIztylRjJp0xX82WeFAk9OuG
	X/C/8+d7ZsTruyMmo7lP5I6swxJxb6qf8LlsoPNYE3pQIZHG+aPld1ChFaHRuR1+p4pTvZ
	eoaVBO44+qd11k/QbUVBMo8WJFPkdOhxEWOU6lWEvIFTJAwVCBUeQ+n4iGvq9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rPsFwIag80nH8xCEKkQYS0E3xZOuBJPGMzSNXnwWL0=;
	b=0dmvNtVougfg5d9p5kIziHhBOBKPxnYVqeIYZioA5rU7QxXjrQVPffaq+3d4WWltV3LUFk
	CwztEJs4TssQBUBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Mop up primary thread mask handling
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.736104257@linutronix.de>
References: <20240213210252.736104257@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661157.398.17319974294779396678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     882e0cff9ef340e7a47659a9aab9da64f4b9b847
Gitweb:        https://git.kernel.org/tip/882e0cff9ef340e7a47659a9aab9da64f4b9b847
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:44 +01:00

x86/cpu/topology: Mop up primary thread mask handling

The early initcall to initialize the primary thread mask is not longer
required because topology_init_possible_cpus() can mark primary threads
correctly when initializing the possible and present map as the number of
SMT threads is already determined correctly.

The XENPV workaround is not longer required because XENPV now registers
fake APIC IDs which will just work like any other enumeration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.736104257@linutronix.de





---
 arch/x86/kernel/cpu/topology.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 630ebe5..f3397e2 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -82,30 +82,6 @@ static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 	if (smp_num_siblings == 1 || !(apicid & mask))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
-
-/*
- * Due to the utter mess of CPUID evaluation smp_num_siblings is not valid
- * during early boot. Initialize the primary thread mask before SMP
- * bringup.
- */
-static int __init smp_init_primary_thread_mask(void)
-{
-	unsigned int cpu;
-
-	/*
-	 * XEN/PV provides either none or useless topology information.
-	 * Pretend that all vCPUs are primary threads.
-	 */
-	if (xen_pv_domain()) {
-		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
-		return 0;
-	}
-
-	for (cpu = 0; cpu < topo_info.nr_assigned_cpus; cpu++)
-		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
-	return 0;
-}
-early_initcall(smp_init_primary_thread_mask);
 #else
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
@@ -151,9 +127,6 @@ static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
 #endif
 	set_cpu_possible(cpu, true);
 	set_cpu_present(cpu, true);
-
-	if (system_state != SYSTEM_BOOTING)
-		cpu_mark_primary_thread(cpu, apic_id);
 }
 
 static __init bool check_for_real_bsp(u32 apic_id)
@@ -282,6 +255,7 @@ int topology_hotplug_apic(u32 apic_id, u32 acpi_id)
 
 	set_bit(apic_id, phys_cpu_present_map);
 	topo_set_cpuids(cpu, apic_id, acpi_id);
+	cpu_mark_primary_thread(cpu, apic_id);
 	return cpu;
 }
 
@@ -414,6 +388,7 @@ void __init topology_init_possible_cpus(void)
 		if (apicid == BAD_APICID)
 			continue;
 
+		cpu_mark_primary_thread(cpu, apicid);
 		set_cpu_present(cpu, test_bit(apicid, phys_cpu_present_map));
 	}
 }

