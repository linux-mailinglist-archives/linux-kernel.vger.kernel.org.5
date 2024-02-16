Return-Path: <linux-kernel+bounces-68813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5184E8580A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037361F21D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666313665A;
	Fri, 16 Feb 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QPjXR9qY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qqxk4Fza"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA341353E5;
	Fri, 16 Feb 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096628; cv=none; b=ZumiEtOzuE9YsfqQmJpXpBnxxKVbnJFMVzGYzYo3VAcvf2zJbqVrg3lp0w06ts4EamvXIRS8hkxQ9WHyeGkuTpp/zAcwCLu7WH1VAxGNcq5/fONseoY/TcxPqxDY8U3Yc0AfdcCxC6KFV/YaPUhW1yknwD3HnagW/AbRtTPyN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096628; c=relaxed/simple;
	bh=emJDLlnHKVanNbQ6vdtT7ASier8FBGto9Qbr3l7og2c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sW5RmQ+bUCgsJHrMRxI/vcnPi5qzQGQpMFZ45v46033ueVM+1pcOpZ/7XExNI8Q34xGdkP+c9P3F7HajVEJa/WEAv470aIrYmn4SBzivJOn/L3vfKSvgdvUgo9LQaNZk4CS5+ovseNyO2J3cSTkLhDzplo45MHC1aEcRq4reiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QPjXR9qY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qqxk4Fza; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096625;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+L5iRYmZdYjIECIcXNFLJj4hBT/g4HKkiw3kOQFReC8=;
	b=QPjXR9qYJa6yr+f3ezd0sIWhCZy96JHvy+JuvRg2clGJJWzOfq28WfhdB8TRyXim7pAZ/i
	BRnjOm79NlJHpnOF6ep0QA1Xw+DjVBwmGRpXtMe3liPrKrdwfqlD3K+TluUqlEbHIHnYML
	I++rukq8+DEhlJaUVaSJqCPtljtVCe4+sof5Vu6mjwEErUzWc8KXDB3rK9HHk6MWjz0LQS
	yq6+lf0l2obLCC0hbIjePtbvKN/rhDxwQ+gfS9dgc9cbJp0LwoMFH2tAQZQb4Go3GAwWqP
	cGgrwWknd+iHi4+hjVOt813Ie6w2pEP2Lx8Nf8zhKRsbtk3wMbzJvu5EXr8LZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096625;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+L5iRYmZdYjIECIcXNFLJj4hBT/g4HKkiw3kOQFReC8=;
	b=qqxk4Fza/6tZ/UXObGxnqgXVD1Kpu6leRziXXEQf+S+u6SBNvc91iTaqFEJNnOfwr0N+pO
	pwnuo2LyL6YnMkCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/acpi: Dont invoke topology_register_apic() for XEN PV
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210251.885489468@linutronix.de>
References: <20240213210251.885489468@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662457.398.4835651325448978814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     cab8e164a49c0ee5c9acb7edec33d76422d831bf
Gitweb:        https://git.kernel.org/tip/cab8e164a49c0ee5c9acb7edec33d76422d831bf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:42 +01:00

x86/acpi: Dont invoke topology_register_apic() for XEN PV

The MADT table for XEN/PV dom0 is not really useful and registering the
APICs is momentarily a pointless exercise because XENPV does not use an
APIC at all.

It overrides the x86_init.mpparse.parse_smp_config() callback, resets
num_processors and counts how many of them are provided by the hypervisor.

This is in the way of cleaning up the APIC registration. Prevent MADT
registration for XEN/PV temporarily until the rework is completed and
XEN/PV can use the MADT again.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210251.885489468@linutronix.de



---
 arch/x86/kernel/acpi/boot.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 42799d5..df741fb 100644
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
@@ -166,7 +168,8 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 
 static __init void acpi_register_lapic(u32 apic_id, u32 acpi_id, bool present)
 {
-	topology_register_apic(apic_id, acpi_id, present);
+	if (!xen_pv_domain())
+		topology_register_apic(apic_id, acpi_id, present);
 }
 
 static bool __init acpi_is_processor_usable(u32 lapic_flags)
@@ -1087,7 +1090,8 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 		return count;
 	}
 
-	register_lapic_address(acpi_lapic_addr);
+	if (!xen_pv_domain())
+		register_lapic_address(acpi_lapic_addr);
 
 	return count;
 }

