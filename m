Return-Path: <linux-kernel+bounces-90555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8B9870111
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953C7283753
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18A3BB46;
	Mon,  4 Mar 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nTEHyS0c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wm5uZKSA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031A3CF74;
	Mon,  4 Mar 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554511; cv=none; b=CNjbHq07BvN42xzpWyy+yWGfkI113HgtBmLdilPuAYq/eoA6uRmUZyq7iOj7gLQTd1KuIByVoDWECw/5AAbg4dlo0tW9RurJxa2/X8GvnbBXdmHCUnFfJgj8t4QiWJwQpFwmKvhumqzbCkFsc691mUd6VyKB8N8L0Lu7jWK2hIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554511; c=relaxed/simple;
	bh=4e7c4XeoMoqErMEUvZy9LPZhvhSF317wV2byPficIbM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r9VIGtmC61FrvXyeEA6x4Dva22u7BmNRYb4tSB2pKZjVRNptK+q0SzZ9NAmzyYCkYwh2oLYjU3kAWImtnBPIIeWWvLg0O3yqgXI/P/7mNU/7tK/+fZxw3DAMc/Z2fZXWjO6P57j7tqKyMgOPOgVXHLdhmJMGUtuZIwEgKK4135Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nTEHyS0c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wm5uZKSA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 12:15:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709554508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWggXFl6uEUV2KrPyBZxmWrCftIgyB21SQjzfWt7kjk=;
	b=nTEHyS0cs83SLuAwdkPuqDt9rluQiU0JbTqqJIrUSHfBPMtYO7kSFicve5dWTGnIBoJPcn
	sPCdog1ekfJW/roabZKMVeeIX+tDmoSxJau76502mHpIUHXIY2K2+VFhlNU4Sb521JqOKH
	OkP487E+uY44Y/JZauNz+dlWTH/PBcb9pohsP4nnwNA6ZJFUhHw1ghA+s168due/GZnkK4
	Onp42H62LA0CsaXL5yQCu4+Ew2JiYPntQWc2RHBqr8fzKYtJn7JScq+vgXiJHMkcqdxkOc
	wZnxxUF/FVvOPCAj/vzsv2YsYGKca+NUD5YE6owZsaW21lCoIbtI/W37pjoyvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709554508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWggXFl6uEUV2KrPyBZxmWrCftIgyB21SQjzfWt7kjk=;
	b=Wm5uZKSAxjEzzIFxW5aTKWT12gT48v5ApyrRhYn87lK92NEX525hx4FIQ6X1KDzu+xr+sK
	VnEknZm7Df7Vr7Bw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/msr: Add missing __percpu annotations
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240304005104.513181735@linutronix.de>
References: <20240304005104.513181735@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170955450713.398.6405328311126408942.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     5323922f50ecdf9d10cdd2fabd06507e5b4f3feb
Gitweb:        https://git.kernel.org/tip/5323922f50ecdf9d10cdd2fabd06507e5b4f3feb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 04 Mar 2024 11:12:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 04 Mar 2024 12:01:54 +01:00

x86/msr: Add missing __percpu annotations

Sparse rightfully complains about using a plain pointer for per CPU
accessors:

  msr-smp.c:15:23: sparse: warning: incorrect type in initializer (different address spaces)
  msr-smp.c:15:23: sparse:    expected void const [noderef] __percpu *__vpp_verify
  msr-smp.c:15:23: sparse:    got struct msr *

Add __percpu annotations to the related datastructure and function
arguments to cure this. This also cures the related sparse warnings at the
callsites in drivers/edac/amd64_edac.c.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240304005104.513181735@linutronix.de
---
 arch/x86/include/asm/msr.h       | 26 ++++++++++++++------------
 arch/x86/include/asm/processor.h |  1 -
 arch/x86/include/asm/tsc.h       |  3 ++-
 arch/x86/lib/msr-smp.c           | 12 +++++-------
 arch/x86/lib/msr.c               |  6 +++---
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 65ec196..4621e08 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -12,11 +12,13 @@
 #include <uapi/asm/msr.h>
 #include <asm/shared/msr.h>
 
+#include <linux/percpu.h>
+
 struct msr_info {
-	u32 msr_no;
-	struct msr reg;
-	struct msr *msrs;
-	int err;
+	u32			msr_no;
+	struct msr		reg;
+	struct msr __percpu	*msrs;
+	int			err;
 };
 
 struct msr_regs_info {
@@ -305,8 +307,8 @@ static inline int wrmsrl_safe(u32 msr, u64 val)
 	return wrmsr_safe(msr, (u32)val,  (u32)(val >> 32));
 }
 
-struct msr *msrs_alloc(void);
-void msrs_free(struct msr *msrs);
+struct msr __percpu *msrs_alloc(void);
+void msrs_free(struct msr __percpu *msrs);
 int msr_set_bit(u32 msr, u8 bit);
 int msr_clear_bit(u32 msr, u8 bit);
 
@@ -315,8 +317,8 @@ int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
-void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
-void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
+void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
+void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
@@ -345,14 +347,14 @@ static inline int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 	return 0;
 }
 static inline void rdmsr_on_cpus(const struct cpumask *m, u32 msr_no,
-				struct msr *msrs)
+				struct msr __percpu *msrs)
 {
-	rdmsr_on_cpu(0, msr_no, &(msrs[0].l), &(msrs[0].h));
+	rdmsr_on_cpu(0, msr_no, raw_cpu_ptr(&msrs->l), raw_cpu_ptr(&msrs->h));
 }
 static inline void wrmsr_on_cpus(const struct cpumask *m, u32 msr_no,
-				struct msr *msrs)
+				struct msr __percpu *msrs)
 {
-	wrmsr_on_cpu(0, msr_no, msrs[0].l, msrs[0].h);
+	wrmsr_on_cpu(0, msr_no, raw_cpu_read(msrs->l), raw_cpu_read(msrs->h));
 }
 static inline int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no,
 				    u32 *l, u32 *h)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d2ef4f5..a61f769 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -20,7 +20,6 @@ struct vm86;
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
 #include <asm/percpu.h>
-#include <asm/msr.h>
 #include <asm/desc_defs.h>
 #include <asm/nops.h>
 #include <asm/special_insns.h>
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 594fce0..405efb3 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -5,8 +5,9 @@
 #ifndef _ASM_X86_TSC_H
 #define _ASM_X86_TSC_H
 
-#include <asm/processor.h>
 #include <asm/cpufeature.h>
+#include <asm/processor.h>
+#include <asm/msr.h>
 
 /*
  * Standard way to access the cycle counter.
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 40bbe56..acd463d 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -9,10 +9,9 @@ static void __rdmsr_on_cpu(void *info)
 {
 	struct msr_info *rv = info;
 	struct msr *reg;
-	int this_cpu = raw_smp_processor_id();
 
 	if (rv->msrs)
-		reg = per_cpu_ptr(rv->msrs, this_cpu);
+		reg = this_cpu_ptr(rv->msrs);
 	else
 		reg = &rv->reg;
 
@@ -23,10 +22,9 @@ static void __wrmsr_on_cpu(void *info)
 {
 	struct msr_info *rv = info;
 	struct msr *reg;
-	int this_cpu = raw_smp_processor_id();
 
 	if (rv->msrs)
-		reg = per_cpu_ptr(rv->msrs, this_cpu);
+		reg = this_cpu_ptr(rv->msrs);
 	else
 		reg = &rv->reg;
 
@@ -97,7 +95,7 @@ int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 EXPORT_SYMBOL(wrmsrl_on_cpu);
 
 static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
-			    struct msr *msrs,
+			    struct msr __percpu *msrs,
 			    void (*msr_func) (void *info))
 {
 	struct msr_info rv;
@@ -124,7 +122,7 @@ static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
  * @msrs:       array of MSR values
  *
  */
-void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
+void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs)
 {
 	__rwmsr_on_cpus(mask, msr_no, msrs, __rdmsr_on_cpu);
 }
@@ -138,7 +136,7 @@ EXPORT_SYMBOL(rdmsr_on_cpus);
  * @msrs:       array of MSR values
  *
  */
-void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
+void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs)
 {
 	__rwmsr_on_cpus(mask, msr_no, msrs, __wrmsr_on_cpu);
 }
diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index 47fd9bd..4bf4fad 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -6,9 +6,9 @@
 #define CREATE_TRACE_POINTS
 #include <asm/msr-trace.h>
 
-struct msr *msrs_alloc(void)
+struct msr __percpu *msrs_alloc(void)
 {
-	struct msr *msrs = NULL;
+	struct msr __percpu *msrs = NULL;
 
 	msrs = alloc_percpu(struct msr);
 	if (!msrs) {
@@ -20,7 +20,7 @@ struct msr *msrs_alloc(void)
 }
 EXPORT_SYMBOL(msrs_alloc);
 
-void msrs_free(struct msr *msrs)
+void msrs_free(struct msr __percpu *msrs)
 {
 	free_percpu(msrs);
 }

