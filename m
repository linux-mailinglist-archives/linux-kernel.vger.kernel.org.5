Return-Path: <linux-kernel+bounces-35350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB7838FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2E01F261DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF6563122;
	Tue, 23 Jan 2024 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5BtuxLH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/yLqH3ew"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAD262A19
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015464; cv=none; b=CXb5bV4nM6FiG+6vH+DZ9czgZBvYPmCXwigrgFLzkF72n4/ynRwA84MZcrBVURyogqtpATzPIm2efN1XQ4z96d//eItD7SV/w3i9UVMnPLQgbqdsekVvAorc8tPDbkH1pzi6jSmagbtDood9oPvsTeQqjeziyrntvh+aZ40gXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015464; c=relaxed/simple;
	bh=sbC882hJWb/fNP4Yqsgrkp1IVTrtRgBvpz6ApXdOtig=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ZBQo9fy/QJkFiTRhw/L2hOk5TZLE7FJVl+rwDSEJ4jKjqSr9Q2ZIx9Z/wRAVkxNVwxHcC+zhUNGutSi3NqU6PwfguA2cCwtpcQ+DFQ/lure3RxnqPhEbd6l4lKbLVSQe1lDfVP4XAXLAQwj8ze45bCqdyD23psz7neZxiC1Tinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d5BtuxLH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/yLqH3ew; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123648.948521234@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pLIvwy/vIOrYDLB+6HqyysBkTudlRmJDSmXo9JtDbRA=;
	b=d5BtuxLHl8fI+oemgL6BYKbt8SbxrCKUlc2z1cLl9nz1ptdMeTs/nYItoQms2MavzetvoZ
	YulaZd88wEsXSMU6cwNL6lZ7Udue4dLYVm+/Wx4olhaXg9E+XsO7k9Mn9q8AdwFzRUDdIT
	ch7+3aaiYp3jg16P2cJpdvaRbL7M5nHbd3UH1lcPKzKhAdBKh9wQehHhKCH1i10H7JdD/J
	hmYZdA8DVDXgi8TSPgDkIdoTTfXQoYq+jfcvTkhbPITKNrDQU1dO1cNW9WCv8nUpibic7V
	jM8j/S/GYNMHDZynWxWRxQMxQ7Oy7W5gw2BxCN877eYa3updOVDnNcy+92aQhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pLIvwy/vIOrYDLB+6HqyysBkTudlRmJDSmXo9JtDbRA=;
	b=/yLqH3ewRAOkciIivfvbfhmtiQxfotNM2ssRiZOyt2tDnW5wbERoofQZ49tDamCDA7uv6B
	vSBHr7fUwOWjjrDg==
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
Subject: [patch v2 07/30] x86/acpi: Dont invoke topology_register_apic() for
 XEN PV
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:00 +0100 (CET)

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


