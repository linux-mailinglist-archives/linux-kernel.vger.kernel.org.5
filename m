Return-Path: <linux-kernel+bounces-35351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F1C838FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DDC28FC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F00633F2;
	Tue, 23 Jan 2024 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vZ9RCMwl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="scjIdNdh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCE063124
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015466; cv=none; b=aH5s9VsKg6SZxTSw7fzYzpFqDdnNxOHjeaXF/Pef9+StTYUMIDHGO6dR9IC+b9STG2mY5WGAUtLMT67V2pVx3pMQfBgGHQO4C93riZk8h4LwWLsF+R8pFHo4Na27HAgaixD6A4uVmt/9amrT69yENqKRIinT2upezQNEa6cEuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015466; c=relaxed/simple;
	bh=2wV7ykerxk1/jQA/W/5bsZ8RwfdIrkcxyTy4F0//EiM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=buYwDVoxjXEtxAREpmJZoVhshId50eWgtaZ2BBBl2bsD5EEl6rBmpVQ9SUxEDsOcG8gZEKObWfgTptGRXdH3xbh7E4l12Z5cONty/eA7nImH+RIlKQJa4Ate8qFO1pkjDuKR+uWv5vi4Eib6MKCFuCcp3D2MY2Ap+9iEiKZuU54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vZ9RCMwl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=scjIdNdh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.004729855@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kMpbD1VU1nu86eLTMCHECRFHSSIbIijtpAP8E+y+cAc=;
	b=vZ9RCMwlv2xR3Su3DwRWadenZREgrkyTjimh+GLRXeVelaPiZSHdvc7g49JNPqXvM+oQk/
	4bd1nRqM+orgW8DE67VCxGFqc6SHdb20ZGv1rXXGFKRWi9BgsOg/mY2vinHX2BnjxTdLRD
	0zuCVKQlgU5ToOesDNfkYZE6t/i8ircClAMC5heSiEWogZ18/USs0h/yxV3Do+QDlY93OZ
	oio9cvWri8ihyNmzXZPAm7QYndpiCYnChU2D+AsJXIBPWGNb7aSMG4ZGg0XAVBMGVjI595
	DB0nhmJkL8r7U+icqsETrxAPJlsR1yOE5CqEzwZ53uh/XR1nHHEkj7Urfm10xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kMpbD1VU1nu86eLTMCHECRFHSSIbIijtpAP8E+y+cAc=;
	b=scjIdNdhyTN0nIAf8DAJEiprw5v7CK0zkgP8+4nx91HKkGkLRMHNTJEe3XyJFYatmx2IcH
	PDD5e/zcs0EcaqBg==
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
Subject: [patch v2 08/30] x86/xen/smp_pv: Register fake APICs
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:02 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

XENPV does not use the APIC. It's just piggy packing on the infrastructure
and fiddles with global variables as it sees fit.

These global variables are going away, so let XENPV register pseudo APIC
IDs to keep the accounting correct and keep up the illusion that XEN/PV is
something sane.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/xen/smp_pv.c |   35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)
---
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -29,6 +29,7 @@
 #include <asm/idtentry.h>
 #include <asm/desc.h>
 #include <asm/cpu.h>
+#include <asm/apic.h>
 #include <asm/io_apic.h>
 
 #include <xen/interface/xen.h>
@@ -150,34 +151,16 @@ int xen_smp_intr_init_pv(unsigned int cp
 
 static void __init xen_pv_smp_config(void)
 {
-	int i, rc;
-	unsigned int subtract = 0;
+	u32 apicid = 0;
+	int i;
 
-	num_processors = 0;
-	disabled_cpus = 0;
-	for (i = 0; i < nr_cpu_ids; i++) {
-		rc = HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL);
-		if (rc >= 0) {
-			num_processors++;
-			set_cpu_possible(i, true);
-		} else {
-			set_cpu_possible(i, false);
-			set_cpu_present(i, false);
-			subtract++;
-		}
+	topology_register_boot_apic(apicid++);
+
+	for (i = 1; i < nr_cpu_ids; i++) {
+		if (HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL) < 0)
+			break;
+		topology_register_apic(apicid++, CPU_ACPIID_INVALID, true);
 	}
-#ifdef CONFIG_HOTPLUG_CPU
-	/* This is akin to using 'nr_cpus' on the Linux command line.
-	 * Which is OK as when we use 'dom0_max_vcpus=X' we can only
-	 * have up to X, while nr_cpu_ids is greater than X. This
-	 * normally is not a problem, except when CPU hotplugging
-	 * is involved and then there might be more than X CPUs
-	 * in the guest - which will not work as there is no
-	 * hypercall to expand the max number of VCPUs an already
-	 * running guest has. So cap it up to X. */
-	if (subtract)
-		set_nr_cpu_ids(nr_cpu_ids - subtract);
-#endif
 	/* Pretend to be a proper enumerated system */
 	smp_found_config = 1;
 }


