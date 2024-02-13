Return-Path: <linux-kernel+bounces-64304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DB7853CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7B61F28565
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B356484039;
	Tue, 13 Feb 2024 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wt+Q6owG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1Vsgm7b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DAE839E7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858364; cv=none; b=CwtjeUYKI4qNC48koSkRadENcqefIhsZdiVyCRWrc1MksqvYHZHNJ/OwnlhOSkHWkqtLEDLNQUui8tlWt69vqeaj856e2bkMSy21bd160PVk35m/Fdx1+pS89aNJyommLtMU16iqTsQuDbos5/cXZzK6gbRMSjSTjs9GRwc/2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858364; c=relaxed/simple;
	bh=rLsp+V/ZBSzycpeyYr3sAEzojATjfDc9ZcQACwfYXk0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VQDYbK4WdVn4nIESp8wM5SbBPRW7laapD366mrYh5gPs3C7omByM3j/7wR/pj/J4Fdxt55Ba+byGfy4VdfcmPAFxcdrTSMZqijtxtE/D0wcq0hmmBQqQhd3wakjIdKUbZ5HPpnVM1Cp1O++xyfGV/r5as1ajqdz0CWpTFN2dNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wt+Q6owG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a1Vsgm7b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.571795063@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=l5IIheic7HTdLbtL8FePLNCYvWctux8lTDROKkU5h0g=;
	b=Wt+Q6owGWnrNJeI13LNavmxTt5Lzs5ThH/dQXT6qesO4DKSLqgiS3ondhGjNgKOQbCvDgW
	9R2GOO5EAsdXU6sSJ+htWRBEmUrGCB/661l3aSPAsEEpCKKyJESlpafzVFP+cGSmVB8bkc
	42kYfpgOCQyZ65aXNn24eWvGdmVh708pAxPG7xivimdq00BIo+iv0VJwEIN8EPlJs3KfTT
	pII6gtnyJR95M5aNNod+zIBJybHtvUj0Z4gdtEQPnXXLSi9zCKzmUa7KMd2CmdMBycl8c/
	T1vcJwagFyvVJrB9cilnL4xYqhZO2Ghot1WZ8m60nRit2K8h4+U9Y0Z0rs1LtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=l5IIheic7HTdLbtL8FePLNCYvWctux8lTDROKkU5h0g=;
	b=a1Vsgm7b2KoILqZlz/V01LMAGTu+EopHn2bXvBSK5ls0/E3HO1hQG+Dc294cj3B67tmfnk
	WaGUvLvojc1mH2DQ==
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
Subject: [patch 19/30] x86/xen/smp_pv: Count number of vCPUs early
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:06:00 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

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




---
 arch/x86/xen/enlighten_pv.c |    3 +++
 arch/x86/xen/smp.h          |    2 ++
 arch/x86/xen/smp_pv.c       |   14 ++++++++++++++
 3 files changed, 19 insertions(+)
---

--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -200,6 +200,9 @@ static void __init xen_pv_init_platform(
 		xen_set_mtrr_data();
 	else
 		mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
+
+	/* Adjust nr_cpu_ids before "enumeration" happens */
+	xen_smp_count_cpus();
 }
 
 static void __init xen_pv_guest_late_init(void)
--- a/arch/x86/xen/smp.h
+++ b/arch/x86/xen/smp.h
@@ -19,6 +19,7 @@ extern void xen_smp_intr_free(unsigned i
 int xen_smp_intr_init_pv(unsigned int cpu);
 void xen_smp_intr_free_pv(unsigned int cpu);
 
+void xen_smp_count_cpus(void);
 void xen_smp_cpus_done(unsigned int max_cpus);
 
 void xen_smp_send_reschedule(int cpu);
@@ -44,6 +45,7 @@ static inline int xen_smp_intr_init_pv(u
 	return 0;
 }
 static inline void xen_smp_intr_free_pv(unsigned int cpu) {}
+static inline void xen_smp_count_cpus(void) { }
 #endif /* CONFIG_SMP */
 
 #endif
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -411,6 +411,20 @@ static irqreturn_t xen_irq_work_interrup
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




