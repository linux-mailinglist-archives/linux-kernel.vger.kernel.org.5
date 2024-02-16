Return-Path: <linux-kernel+bounces-68801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1CD858089
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758181F21BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292D5132C23;
	Fri, 16 Feb 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vo48m1nt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jKELYrcR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA8130E4A;
	Fri, 16 Feb 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096618; cv=none; b=eiwDkOO+OXMF7xhgu/mPaNTx3SsH/+mnkOhnm+NbF3ZO5AM6LB8JD7H4DM8dlklVzr3FdmlNpMyvr0Q0zSiwbJRfu8ku1Yt/pnICctMkWGenFG9K2im9db+cq5RvIN+TGmgR4abAAPId9xLvw5UK+MJnHvAMJ3l58hrZQLRLJyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096618; c=relaxed/simple;
	bh=R+QNnNy1teOxlVVAigZ4Eo5eHtA9VlUU1AokOKMEDms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iciacVdpN8MD3XYtwOxbnOCXV4cBxyMt/ERmV3/klUFTkS77aEnmBNl27smzjt27pkKMh1H73zhmug90G/DGfo5LkkWZ7VRbvQqC0LKL1YgnKeP+L0WmZM4QDRJb65r2egPJd7RHyCMh6QaIGoBEaqyp9WXx3Yon2Lk0DVNwf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vo48m1nt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jKELYrcR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5IMW7g7ZBFtpyVUyp9Bmha+mfhhRo2Ei0BOPf5AEqw=;
	b=Vo48m1ntxBAc1Ggz/QIItxNe5VP8efKrdwnKC1TXm5D3bBdpBES08gMAIlglbQqq2nwvws
	vOvRQD7AU2GbIVnRvd7PuHuuQ2z3nQ+F0uCzlIQuFYbpwHZ5caQa2/CmQ7eFbT1oWSUFxz
	jh3Hr1Gpk8Ij9oYPXqV/hzgWw29ehhlI0TuB2+0F1C5zS/RgIIBHwjHoq51LmiwkrnwzZe
	K21B5PwXsQul6tUUl82t5NWQhfKZ10r2ClbzdQdw45QjNbgLhCkqyqT0Hiplf1iOLEf8Qk
	wHcFIw5F3tO006vn89ZVJvCWXuvR+gyAn0QlQqty7vSExaXo78dsDGKB0tmQ5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5IMW7g7ZBFtpyVUyp9Bmha+mfhhRo2Ei0BOPf5AEqw=;
	b=jKELYrcRngTmgTHPo5kAkbosnlfWlqQBoFZRYovnimhaImtxnsc4dB8XoWCaodYNXSXkQ1
	EKRriO8yGp2PQkAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/xen/smp_pv: Count number of vCPUs early
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.571795063@linutronix.de>
References: <20240213210252.571795063@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661418.398.8946381891178522312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     c8f808231f1fb63553f90d4b3796cb6804d1e693
Gitweb:        https://git.kernel.org/tip/c8f808231f1fb63553f90d4b3796cb6804d1e693
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:44 +01:00

x86/xen/smp_pv: Count number of vCPUs early

XEN/PV has a completely broken vCPU enumeration scheme, which just works by
chance and provides zero topology information. Each vCPU ends up being a
single core package.

Dom0 provides MADT which can be used for topology information, but that
table is the unmodified host table, which means that there can be more CPUs
registered than the number of vCPUs XEN provides for the dom0 guest.

DomU does not have ACPI and both rely on counting the possible vCPUs via an
hypercall.

To prepare for using CPUID topology information either via MADT or via fake
APIC IDs count the number of possible CPUs during early boot and adjust
nr_cpu_ids() accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.571795063@linutronix.de





---
 arch/x86/xen/enlighten_pv.c |  3 +++
 arch/x86/xen/smp.h          |  2 ++
 arch/x86/xen/smp_pv.c       | 14 ++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index aeb33e0..ace2eb0 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -200,6 +200,9 @@ static void __init xen_pv_init_platform(void)
 		xen_set_mtrr_data();
 	else
 		mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
+
+	/* Adjust nr_cpu_ids before "enumeration" happens */
+	xen_smp_count_cpus();
 }
 
 static void __init xen_pv_guest_late_init(void)
diff --git a/arch/x86/xen/smp.h b/arch/x86/xen/smp.h
index c20cbb1..b8efdbc 100644
--- a/arch/x86/xen/smp.h
+++ b/arch/x86/xen/smp.h
@@ -19,6 +19,7 @@ extern void xen_smp_intr_free(unsigned int cpu);
 int xen_smp_intr_init_pv(unsigned int cpu);
 void xen_smp_intr_free_pv(unsigned int cpu);
 
+void xen_smp_count_cpus(void);
 void xen_smp_cpus_done(unsigned int max_cpus);
 
 void xen_smp_send_reschedule(int cpu);
@@ -44,6 +45,7 @@ static inline int xen_smp_intr_init_pv(unsigned int cpu)
 	return 0;
 }
 static inline void xen_smp_intr_free_pv(unsigned int cpu) {}
+static inline void xen_smp_count_cpus(void) { }
 #endif /* CONFIG_SMP */
 
 #endif
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 98849b3..44706f0 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -411,6 +411,20 @@ static irqreturn_t xen_irq_work_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+void __init xen_smp_count_cpus(void)
+{
+	unsigned int cpus;
+
+	for (cpus = 0; cpus < nr_cpu_ids; cpus++) {
+		if (HYPERVISOR_vcpu_op(VCPUOP_is_up, cpus, NULL) < 0)
+			break;
+	}
+
+	pr_info("Xen PV: Detected %u vCPUS\n", cpus);
+	if (cpus < nr_cpu_ids)
+		set_nr_cpu_ids(cpus);
+}
+
 static const struct smp_ops xen_smp_ops __initconst = {
 	.smp_prepare_boot_cpu = xen_pv_smp_prepare_boot_cpu,
 	.smp_prepare_cpus = xen_pv_smp_prepare_cpus,

