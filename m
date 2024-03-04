Return-Path: <linux-kernel+bounces-90553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794EA87010C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A811F22032
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BBB3BB3A;
	Mon,  4 Mar 2024 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SbkVbUiP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2Jz5T6i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5A3C06A;
	Mon,  4 Mar 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554509; cv=none; b=K0JNJ7lK0hz1rjRB0OVG1tlVtiqde8uuGMKncJL/w854lLdfvf9mD2RpVdHvMUGDNZ/Mtjd94mwIApOy5g7ObS1IffpSVD9yrfsPizTaGqZHD4/kqUe6ia/X4FqZz1wMusy3jiJLk1uvPgc0cU56KE3efqmqisL1NKT20ydViVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554509; c=relaxed/simple;
	bh=Y8jSKzYrsHvHsrq8Z73jN78bF54fwGh81JDZw9uOdLQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JAw8xOcjN75aXVtwFalPDosTc7pt4oKaQ0HDOJzUH0vmR1NF9ORs7PQCiRKLhuTAW2F+gvP0YJJH+WT8TsyrmzuqdvaO7QqP/Q9FBD42iEjjo375L5FU6B5DOhuuZ46s0/H10/tJIMhb0fITxUal4NZo3+2+W1Oyz85XBo8PicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SbkVbUiP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U2Jz5T6i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 12:15:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709554506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPB03qgATnER+7v2wvNlHF8c2kP3oWpO0j3I9PhKWSY=;
	b=SbkVbUiPTRXSAB3nWE9MPH4gBBUcTZb/5c/0rS/TX5gZCOWitnho0mX7cgBN6WKDRk+/Xp
	Bq8Jc5pMxFUoznw3h06Z2kueNtMWRdTqrcmyFfVnzuzg+bfkWvmjMdV4FdRSNUMYNpR0fy
	/Uuv8CIg7pEpc4tjaUUYlYzHWn6jt9+9rnng/NtyQPzHlN/QJXzrzpOYWPuN+Pvcnz3c9i
	DD1OPh45QdNgVwXaPKs76guDiHvgdT+A0b86YFxPX5MtFUPZKlotRX1usbK8qLTb0aq8nP
	8F1dOO0xc3znsfqqBodGvHhftraxwY12FHIalm3qMvJOPExCcPDUKqHOlM/EDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709554506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPB03qgATnER+7v2wvNlHF8c2kP3oWpO0j3I9PhKWSY=;
	b=U2Jz5T6iGNslPDcyCv7tIBtcXeWGPKoukm1Hz2Mxsud7YXEwzAdDzjtqeYIU75GrgTpCuR
	BIyYZlouO/oh56AA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/percpu: Cure per CPU madness on UP
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240304005104.622511517@linutronix.de>
References: <20240304005104.622511517@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170955450572.398.4892526222769670917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     71eb4893cfaf37f8884515c8f71717044b97bf44
Gitweb:        https://git.kernel.org/tip/71eb4893cfaf37f8884515c8f71717044b97bf44
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Mar 2024 11:12:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 04 Mar 2024 12:09:07 +01:00

x86/percpu: Cure per CPU madness on UP

On UP builds Sparse complains rightfully about accesses to cpu_info with
per CPU accessors:

  cacheinfo.c:282:30: sparse: warning: incorrect type in initializer (different address spaces)
  cacheinfo.c:282:30: sparse:    expected void const [noderef] __percpu *__vpp_verify
  cacheinfo.c:282:30: sparse:    got unsigned int *

The reason is that on UP builds cpu_info which is a per CPU variable on SMP
is mapped to boot_cpu_info which is a regular variable. There is a hideous
accessor cpu_data() which tries to hide this, but it's not sufficient as
some places require raw accessors and generates worse code than the regular
per CPU accessors.

Waste sizeof(struct x86_cpuinfo) memory on UP and provide the per CPU
cpu_info unconditionally. This requires to update the CPU info on the boot
CPU as SMP does. (Ab)use the weakly defined smp_prepare_boot_cpu() function
and implement exactly that.

This allows to use regular per CPU accessors uncoditionally and paves the
way to remove the cpu_data() hackery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240304005104.622511517@linutronix.de
---
 arch/x86/include/asm/processor.h |  5 -----
 arch/x86/kernel/cpu/common.c     |  3 +++
 arch/x86/kernel/setup.c          | 10 ++++++++++
 arch/x86/kernel/smpboot.c        |  4 ----
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a61f769..e2262ac 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -185,13 +185,8 @@ extern struct cpuinfo_x86	new_cpu_data;
 extern __u32			cpu_caps_cleared[NCAPINTS + NBUGINTS];
 extern __u32			cpu_caps_set[NCAPINTS + NBUGINTS];
 
-#ifdef CONFIG_SMP
 DECLARE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 #define cpu_data(cpu)		per_cpu(cpu_info, cpu)
-#else
-#define cpu_info		boot_cpu_data
-#define cpu_data(cpu)		boot_cpu_data
-#endif
 
 extern const struct seq_operations cpuinfo_op;
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fbc4e60..6057a9e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -70,6 +70,9 @@
 
 #include "cpu.h"
 
+DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
+EXPORT_PER_CPU_SYMBOL(cpu_info);
+
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 8420107..8f669d3 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1211,6 +1211,16 @@ void __init i386_reserve_resources(void)
 
 #endif /* CONFIG_X86_32 */
 
+#ifndef CONFIG_SMP
+void __init smp_prepare_boot_cpu(void)
+{
+	struct cpuinfo_x86 *c = &cpu_data(0);
+
+	*c = boot_cpu_data;
+	c->initialized = true;
+}
+#endif
+
 static struct notifier_block kernel_offset_notifier = {
 	.notifier_call = dump_kernel_offset
 };
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 980782b..37ea8c8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,10 +101,6 @@ EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 
-/* Per CPU bogomips and other parameters */
-DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
-EXPORT_PER_CPU_SYMBOL(cpu_info);
-
 /* CPUs which are the primary SMT threads */
 struct cpumask __cpu_primary_thread_mask __read_mostly;
 

