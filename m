Return-Path: <linux-kernel+bounces-64293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDF1853CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4801C22B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160B67E0EB;
	Tue, 13 Feb 2024 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YKRWzRM5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C0/07zds"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E57CF06
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858348; cv=none; b=Yc2OTmmwfhKbHNT3i6225yojbFZEAJQMITr3nxrl8yaMAQlvVIe8V7Wuk0o2iyEvUdHT/JQ341qCW4Ah5nEv/O4QapaZ20mYq3qwN8yi6nRfVFHEs5A27r2YHyJFlfFKKCnMGM7kDIvW7mgqpHuANYTpbIUNENXXX58vq9X2rSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858348; c=relaxed/simple;
	bh=BKWYJny06EjSOf0YcTioblR9k858pQD/ggIOMn3ec8U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bSgaNqgkHMuUqTm5WFPNnyzKkhvdd/xqtom5NWdC64NW0CR6hB3zOKYbGc7DEGU0iqxhG6NENTq8ZuZFJAd2j12I9a+jdvBY1uCT4EE9t6ys5i+u1QerGesXDhvpvsbdBFHfo5x/98pKneoUhOloIcqZafEiz1V1Ezd9hGu3H1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YKRWzRM5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C0/07zds; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210251.940043512@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0wXS/SNETV4wAhaE3jXhuw2f33pvJhCIS1T6dH7Hlc0=;
	b=YKRWzRM5Vv6CatVZE6GJiZky0y16vUHRoIYSHeK8wbCLpCApmGLZfJqYZtakDblItvwW2K
	MM8btWamh1bYtiZcQH43neQ6gLlt7bt92nlfDmlmVn1oP8Dd5GHGHXAFPFQhUufndu78MZ
	XYkUGMHXXhytlM/qwZckx0MNXBp0QsyTpGqvtH9wH7heTQ40Hni9xWjNqE5xwyA3DgL8S6
	o8v9gdfYTd1/IwPev+tvMozhOK+J/vmaQHecRJoJr+5rPy2HoG4ZOWuoRTCeElbTeOAKdc
	ouhiaScok+OWArebdDi42xmSK0XFlsxBaiPJILnv0M3whTAtPNzXKDEtTZ7wjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0wXS/SNETV4wAhaE3jXhuw2f33pvJhCIS1T6dH7Hlc0=;
	b=C0/07zds2qQFcd9P54O4n2UDteJPiyDNftbhN9DwthLlfW7OTpHNfd2/Ops/AHMD70zoUi
	cbjz9ZzK+cd34QDw==
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
Subject: [patch 08/30] x86/xen/smp_pv: Register fake APICs
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:44 +0100 (CET)

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




