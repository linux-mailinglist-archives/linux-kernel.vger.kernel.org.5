Return-Path: <linux-kernel+bounces-35362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE3F838FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C57B26289
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F765BA3;
	Tue, 23 Jan 2024 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CxiWdZRE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="za8UYb25"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB60657B9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015484; cv=none; b=ThodwtvzZlPTXqdraaly+DEj8Y9w9uCxaYVJvoPAxIsdZwTFH3LkgwMvp4hVB8Odf7qaBGt+LxB8PR2Nz66yDrHZFsaT5vWgHwNiLj7bXHuNqKMzstTeyr1FNbguhVY98aBx8w3do9Tirjm6JwG52OBjc5/IkoHVNjP77qoqIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015484; c=relaxed/simple;
	bh=VSTRfyPlCXvwknOkQvjqc/Ec8ov0aPVQqZEK9a+yUk4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DpKCVhsLYQUY+G1z+0bcwIpQAhNzPnYxMKT1V57Qut2QMPm/tnKyLVzatRPbqD6N8P40fUPnDX7PSOzhFu7xMAKI2/OVQhuddvAOc82A2QrR/gtZwM1Ura4h7CtnpL2JljsdqNWOxZw+2J8x4D/k9wFxWZHRCK6ulkHRwBZZDKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CxiWdZRE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=za8UYb25; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.625929494@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QYkqZUVDy5aQy4fykCVti4/iE4yQ4r5vOJDLBJD/A5w=;
	b=CxiWdZREYvOTlpdW8W6JWefLqwwJPIdIur97a133OCb3dMiITTC9ZzV4hUcbN0wnxEfpwN
	D/ZKRNN3hsOBdqFKvpE8gSNG7WwWpo26YwKJUoVlg+MxmDxjdioE3tI1FCkLTFnCM4t1cB
	pCfw8toMovYObQe12Oc22l1yxlsPUyGEbgMi79BtPhuVZa/KGZRzk7/ezskw3r/AUeKeuY
	4/lnF+IoHMczWYqDXUOpXb7uA85ZYvLB2Nuh6e4vIZ5BnqCCQ8tc9Jt/QWyUkgPwOYwKoU
	947pmmuktBHeYF0OcoTPHsb9F9AywqDpSZm8TfvK1uNIp2wC3g9t/StJaZo+Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QYkqZUVDy5aQy4fykCVti4/iE4yQ4r5vOJDLBJD/A5w=;
	b=za8UYb25giBOnlzfvqR01F18iYPIbIHbBiUR+mAI01Ic6ELUBj/K06f7yKM4udv0Eza08x
	waB0Af9Qxei89hDg==
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
Subject: [patch v2 19/30] x86/xen/smp_pv: Count number of vCPUs early
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:20 +0100 (CET)

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


