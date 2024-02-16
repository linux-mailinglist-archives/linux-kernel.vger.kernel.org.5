Return-Path: <linux-kernel+bounces-68814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045AF8580A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2381C20898
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D38137C29;
	Fri, 16 Feb 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FE2LLrM4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EzkP9Xsk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07F135415;
	Fri, 16 Feb 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096629; cv=none; b=UtapIiy9iBRWMAqDIWAnn0SSvmMuVnRpthMFgnQOC0ScZEqD5G4FcxX7vpUZeZDj0WfbYLSNECfNNWZumW4qikryYkw8NtRUqzWyDD60JgFPmZYJQTClZrNQcc3qSyiP5BK/XpmF2B3ZD2w9CRk8clTj6TNzz97Fu/OcdXmyWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096629; c=relaxed/simple;
	bh=Aoid/j/2kJ1H3MzhNhcYn/1lICaVzaVs8c3hTgP/iNM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DrTNSXeOtjJGZT1f5w1KwIvvobjgpUtGc443UgV0fzOHaRhL6mtcrgqQrjmsxArpulx08gAVfIiMM8Lm8qFth6RnDuTrykS/yBRsusjj+da6jBuWZJ11HGlXQr5eiQU9uk2D0+1BQayicQLpB/Qp+11lAE5Z3ps8n0r06kY20Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FE2LLrM4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EzkP9Xsk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9SZ1GfnMuBHVW5yv9SZS4/73ty5TsHvMTRmf+02IKk=;
	b=FE2LLrM4LKdzGglEipZYSPpQ8WTSha6la1K+6wYtuR4OZs+HAlcn8rGCWOJNkEkEfOtZlv
	YthUG01VSafsg0KYN47jLHHzt8l7Lbj2r0Ce2UPtZ11nQMRHbLP9g1OyU2HJoPDRNMiBOQ
	tPtrcLJvaGVdSU3FTSPqnOe0bNsYWAEBvTcuou3gxz75jX0Mn3JeEF7z7uB0dLHsVA7f30
	LuPplnHycjxa4A7umkAjLj3jF8eqTDPelgiPNGHjzhyF6z9jMDHop66FUmiBlULcb7Pxho
	/mK98CmvXUAVvqchI4kNxcvgrgBJNLMdODACTwhjS9fa+Bu8RxQ3eym/HlDvuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i9SZ1GfnMuBHVW5yv9SZS4/73ty5TsHvMTRmf+02IKk=;
	b=EzkP9XskpTWP+/OsYKl4t7NcYaINUrapw+hr9itaphZNTXVBWVRrlBiZzRZB7nEOFVge3x
	7I7EaQHtC7pErLDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/mpparse: Use new APIC registration function
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210251.830955273@linutronix.de>
References: <20240213210251.830955273@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662543.398.9851688228218743226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     8098428c541212e9835c1771ee90caa968ffef4f
Gitweb:        https://git.kernel.org/tip/8098428c541212e9835c1771ee90caa968ffef4f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:42 +01:00

x86/mpparse: Use new APIC registration function

Aside of switching over to the new interface, record the number of
registered CPUs locally, which allows to make num_processors and
disabled_cpus confined to the topology code.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210251.830955273@linutronix.de



---
 arch/x86/include/asm/mpspec.h  |  2 --
 arch/x86/kernel/cpu/topology.c |  2 +-
 arch/x86/kernel/mpparse.c      | 17 +++++++++--------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 1b79d0e..c72c7ff 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -61,8 +61,6 @@ static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
 #define mpparse_parse_smp_config	x86_init_noop
 #endif
 
-int generic_processor_info(int apicid);
-
 extern DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC);
 
 static inline void reset_phys_cpu_present_map(u32 apicid)
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 3dd7e6c..669e258 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -133,7 +133,7 @@ static void cpu_update_apic(int cpu, u32 apicid)
 		cpu_mark_primary_thread(cpu, apicid);
 }
 
-int generic_processor_info(int apicid)
+static int generic_processor_info(int apicid)
 {
 	int cpu, max = nr_cpu_ids;
 
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 9c000c4..1ccd30c 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -36,6 +36,8 @@
  * Checksum an MP configuration block.
  */
 
+static unsigned int num_procs __initdata;
+
 static int __init mpf_checksum(unsigned char *mp, int len)
 {
 	int sum = 0;
@@ -50,16 +52,15 @@ static void __init MP_processor_info(struct mpc_cpu *m)
 {
 	char *bootup_cpu = "";
 
-	if (!(m->cpuflag & CPU_ENABLED)) {
-		disabled_cpus++;
+	topology_register_apic(m->apicid, CPU_ACPIID_INVALID, m->cpuflag & CPU_ENABLED);
+	if (!(m->cpuflag & CPU_ENABLED))
 		return;
-	}
 
 	if (m->cpuflag & CPU_BOOTPROCESSOR)
 		bootup_cpu = " (Bootup-CPU)";
 
 	pr_info("Processor #%d%s\n", m->apicid, bootup_cpu);
-	generic_processor_info(m->apicid);
+	num_procs++;
 }
 
 #ifdef CONFIG_X86_IO_APIC
@@ -236,9 +237,9 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 		}
 	}
 
-	if (!num_processors)
+	if (!num_procs && !acpi_lapic)
 		pr_err("MPTABLE: no processors registered!\n");
-	return num_processors;
+	return num_procs || acpi_lapic;
 }
 
 #ifdef CONFIG_X86_IO_APIC
@@ -529,8 +530,8 @@ static __init void mpparse_get_smp_config(unsigned int early)
 	} else
 		BUG();
 
-	if (!early)
-		pr_info("Processors: %d\n", num_processors);
+	if (!early && !acpi_lapic)
+		pr_info("Processors: %d\n", num_procs);
 	/*
 	 * Only use the first configuration found.
 	 */

