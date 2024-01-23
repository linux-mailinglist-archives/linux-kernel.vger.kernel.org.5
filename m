Return-Path: <linux-kernel+bounces-35320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD1838F74
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028EF1F21FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB5A5F843;
	Tue, 23 Jan 2024 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HclJnoX8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m64vyryh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83C5F54F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015410; cv=none; b=k7KcLLgj6KsY0KkpVXYFPCvUaLwd6hdmA0JLOyAQ3WKobA1f6Rq4yQ5yttGFkv2sCqbt30YfiI1UkmnlCDdjPlLVVdFq8CSs1e+yWA15NV1SfKEjJRbTHdXHAISaI7GcEkvEvNKSS40whmnhA1PPkZe7Qa1ySAGoEG7T52FFOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015410; c=relaxed/simple;
	bh=jNnqs11fI6iywdMHCkIqDzbP9Wvbp5V89kSzMcsFEEM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MbodEVss55fD3bMwa5dMmebR/Nu06lfKeklVd9J1ZHVtS8h6MQB2ZYE7sea2S2qe0JndgYFDIy0DIQT3QObJ+6L/xqcdEZoCoudLOO6USfxw5g55eZ75dhU/HkrTHw4Bwt8CRiOXl/4Av//6qtqThXi6ghP5eMOxksw5bkuLKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HclJnoX8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m64vyryh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124902.469526593@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8UGDhAkmDc1R8O704cFzYJXmpGJsWUzoGbpGIqdauCw=;
	b=HclJnoX8vxNxhbo1d4fYjOo0Q3bxLG46Lhg+15r+p3LqQuOqh+GMhr/xQ8SWfec8g5BnDi
	Kj8MPmGzR0iTiXg7ATiyMFgG/HP+BTlIKWCdAAry5fTsJ+2poQYLoCK/x5+6OnoFah/8M/
	931yxo1fhExEjq2TgMKk0xn2gAvVLh9xfvEkEovCCqNKpSdGsEg1B9WeGxuRwJxIACUiUp
	GPq8e3+V6+AAexhwrBgZCN4jPqu5x0UsmiLJjhim6D14CWh2rAm4uWQuiifll2XX3qO2Ww
	LCJiLDcuwipgK6HsYWFp765hiMlUEjN18IVE32sfjItqEOxk98oFsOQm7cWzTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8UGDhAkmDc1R8O704cFzYJXmpGJsWUzoGbpGIqdauCw=;
	b=m64vyryhkddtj8Et1aIghVsfIY1pLwSo/OpNF6X/DsGldCRJMKehiZfkNoX7oXuWCSix+6
	kD3txYZcHqWqWMAA==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V2 02/22] x86/platform/ce4100: Dont override
 x86_init.mpparse.setup_ioapic_ids
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:05 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

There is no point to do that. The ATOMs have an XAPIC for which this
function is a pointless exercise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andy@infradead.org>

---
 arch/x86/include/asm/io_apic.h    |    1 -
 arch/x86/kernel/apic/io_apic.c    |    2 +-
 arch/x86/platform/ce4100/ce4100.c |    1 -
 3 files changed, 1 insertion(+), 3 deletions(-)
---
--- a/arch/x86/include/asm/io_apic.h
+++ b/arch/x86/include/asm/io_apic.h
@@ -140,7 +140,6 @@ extern void mask_ioapic_entries(void);
 extern int restore_ioapic_entries(void);
 
 extern void setup_ioapic_ids_from_mpc(void);
-extern void setup_ioapic_ids_from_mpc_nocheck(void);
 
 extern int mp_find_ioapic(u32 gsi);
 extern int mp_find_ioapic_pin(int ioapic, u32 gsi);
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1458,7 +1458,7 @@ void restore_boot_irq_mode(void)
  *
  * by Matt Domsch <Matt_Domsch@dell.com>  Tue Dec 21 12:25:05 CST 1999
  */
-void __init setup_ioapic_ids_from_mpc_nocheck(void)
+static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 {
 	union IO_APIC_reg_00 reg_00;
 	physid_mask_t phys_id_present_map;
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -139,7 +139,6 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.resources.probe_roms = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 	x86_init.mpparse.find_smp_config = x86_init_noop;
-	x86_init.mpparse.setup_ioapic_ids = setup_ioapic_ids_from_mpc_nocheck;
 	x86_init.pci.init = ce4100_pci_init;
 	x86_init.pci.init_irq = sdv_pci_init;
 


