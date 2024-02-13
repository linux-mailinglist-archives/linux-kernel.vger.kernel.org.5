Return-Path: <linux-kernel+bounces-64292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7B853CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB891F21A84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5107E0EA;
	Tue, 13 Feb 2024 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YMa/4oRs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IilBDjYa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51097A715
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858348; cv=none; b=IOjEUPXk5A10LWJ0u71SpVHXdYm0mhwnvdQdBR7/RO18RxoJgXCNbuW9aavcsuPd+9MiuQRc1ueDldzos3tOvmGW32t1yRpaSf1kop7VQIQeHdMKZQZk8sTKIqS+3hKJ5lyO3TuVubyxL36ebOFlDVp+7IUB+41V7KaolB5BpoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858348; c=relaxed/simple;
	bh=mSWHUsAxY2vmF0UO1GwGRNnmjm20vOkVOPe+MQZCqus=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dJU7EijMsP+AHsITCE5QVNrLlHGPxe8prZjNhYvG35K66eY/62A9Krr+45hZBSpgcz6lDTKUSyeatb+B09hYb9yXCId0DNRPVAuC25wWVmdJrKrXdQEYhMdDoexd5Q2OnGCS9gHs4kE341RXDqjHAC/pcF+BzqyqWvVeVFTHLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YMa/4oRs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IilBDjYa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210251.885489468@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zfzAs64wbbWdEGs0dn8m5hF5zCfLwYbKo95JpIfEf0U=;
	b=YMa/4oRsy0Pii4k/xjdkMaYv4i3IMWaYiTXJC3ucB6Sekc/vkVV4XYDv6hyTkrdaD9o/FI
	LqzC7mu/f23ZXt6llYj6xU2faiLibcl4sM0wS1H1caH4bu/8P++VMOp5VcXls5HjREYSMl
	umdZ7PqfWilYj2EdQPd4G3F11d3XrAIu0PbiP8BAkdqnPsb6vBQwCONyQ03fqURXStuojh
	s0TY6exnOd/ETrIIe/lo3rZzCx19DdQOPTiZTrGsSCgjndZr750/T0YSYjuflLjxRky/PE
	0xTiJ4VdgxnTEK0KXIwEfiUvegP4ExN7uw454Wm5aaCuYKKYTBxjQ2HjmnVaCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zfzAs64wbbWdEGs0dn8m5hF5zCfLwYbKo95JpIfEf0U=;
	b=IilBDjYa2CMXByjzWh8M66Rwa6nYypEhsd1xMTUvOTrb8HisiDeKEb/twy+tfW6m0zOmYv
	qbQ82LK9C+jdGdDA==
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
Subject: [patch 07/30] x86/acpi: Dont invoke topology_register_apic() for XEN
 PV
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:43 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The MADT table for XEN/PV dom0 is not really useful and registering the
APICs is momentarily a pointless exercise because XENPV does not use an
APIC at all.

It overrides the x86_init.mpparse.parse_smp_config() callback, resets
num_processors and counts how many of them are provided by the hypervisor.

This is in the way of cleaning up the APIC registration. Prevent MADT
registration for XEN/PV temporarily until the rework is completed and
XEN/PV can use the MADT again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/kernel/acpi/boot.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
---

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -23,6 +23,8 @@
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
 
+#include <xen/xen.h>
+
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
 #include <asm/pci_x86.h>
@@ -166,7 +168,8 @@ static int __init acpi_parse_madt(struct
 
 static __init void acpi_register_lapic(u32 apic_id, u32 acpi_id, bool present)
 {
-	topology_register_apic(apic_id, acpi_id, present);
+	if (!xen_pv_domain())
+		topology_register_apic(apic_id, acpi_id, present);
 }
 
 static bool __init acpi_is_processor_usable(u32 lapic_flags)
@@ -1087,7 +1090,8 @@ static int __init early_acpi_parse_madt_
 		return count;
 	}
 
-	register_lapic_address(acpi_lapic_addr);
+	if (!xen_pv_domain())
+		register_lapic_address(acpi_lapic_addr);
 
 	return count;
 }



