Return-Path: <linux-kernel+bounces-35340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671E0838F90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22D5B28B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E16F60EF8;
	Tue, 23 Jan 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WSK6FtNA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="shTrjPJ0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79560DDE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015440; cv=none; b=aVRzzIcXjm5BrnnO5Yh5fuMSH3CI4sn26rrPkfLn6uJFLCmEm0bcMThpdKD41QxUTFLK40tkJsVbsaAuIgu390v4l8pt5NQQEKeD0W/rC6c+b59qtOFuNE6p8uDY9KgqRfZSsvSuSuAJouq4bffPlV1l6EBbGKlRCKQSgqZn7CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015440; c=relaxed/simple;
	bh=EPgNKJsjv0Fvj2hFIw+msrMoAr7OoiLKu49+yMak/Rk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iD/IhIxRuVp8UqhGqko/f7ykYSd4DcU7RpwDnJS37yiSKXZ3ky7nmyN+jauiJbF7+EbjviuNZizkCCcwk27cAZ5v1HKhyYuPmBWcxtsR/FLvezJksa/IMJBgk0inW32C+wnE1Srh3/iYzClnb6cgayiizkpptny6JfQB2ENTR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WSK6FtNA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=shTrjPJ0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.688820635@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xSMyMDhOOAbYsok2gC1QscNssWoM6sZikBlB/DuMwl0=;
	b=WSK6FtNAQqTIiCpO+wruRfAJkEevseyTp3nP74Njzj9hIMa+iu9saJ+kT7YvLVBP46LrBn
	oqKLL/gxsRhtp0FGjYgE7pSTxHqzSri4L+znndUR/ie8gwyYUgUJkjm4At5g4YtfFW21yH
	T0ZB6QMdeWOPprFG8nO6jDVpxzFhrcNsHxL2cWPYZNiur/pVfJXq0NkrlAaFmjHBzzpg7k
	0HyRoHw7/V9lxlJMa4es8+olq9+epPjaGk7oavlfMRYoEMA4PBZ4kIuXoODg01XCwxriRE
	q5KiAm+c7lyAUvwtLVdz8t+0vVRBJbr7yHh3cEEOy9B3+k/ZSbx871YWE8MnyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xSMyMDhOOAbYsok2gC1QscNssWoM6sZikBlB/DuMwl0=;
	b=shTrjPJ05i1hLSyN02PjJKye/hLpIvIDIaOSwSQHPH3wrCEe4xJ5h9NPYb2KH7pKqkrnbG
	MXBtLHqKt/vjJyAQ==
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
Subject: [patch V2 21/22] x86/apic: Remove yet another dubious callback
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:36 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Paranoia is not wrong, but having an APIC callback which is in most
implementations a complete NOOP and in one actually looking whether the
APICID of an upcoming CPU has been registered. The same APICID which was
used to bring the CPU out of wait for startup.

That's paranoia for the paranoia sake. Remove the voodoo.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/apic.h         |    1 -
 arch/x86/kernel/apic/apic.c         |    3 ---
 arch/x86/kernel/apic/apic_common.c  |    5 -----
 arch/x86/kernel/apic/apic_flat_64.c |    2 --
 arch/x86/kernel/apic/local.h        |    2 --
 arch/x86/kernel/apic/probe_32.c     |    1 -
 6 files changed, 14 deletions(-)
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -288,7 +288,6 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	bool	(*apic_id_registered)(void);
 
 	void	(*init_apic_ldr)(void);
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1538,9 +1538,6 @@ static void setup_local_APIC(void)
 		apic_write(APIC_ESR, 0);
 	}
 #endif
-	/* Validate that the APIC is registered if required */
-	BUG_ON(apic->apic_id_registered && !apic->apic_id_registered());
-
 	/*
 	 * Intel recommends to set DFR, LDR and TPR before enabling
 	 * an APIC.  See e.g. "AP-388 82489DX User's Manual" (Intel
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -27,11 +27,6 @@ u32 default_cpu_present_to_apicid(int mp
 }
 EXPORT_SYMBOL_GPL(default_cpu_present_to_apicid);
 
-bool default_apic_id_registered(void)
-{
-	return test_bit(read_apic_id(), phys_cpu_present_map);
-}
-
 /*
  * Set up the logical destination ID when the APIC operates in logical
  * destination mode.
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -70,7 +70,6 @@ static struct apic apic_flat __ro_after_
 	.name				= "flat",
 	.probe				= flat_probe,
 	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
-	.apic_id_registered		= default_apic_id_registered,
 
 	.dest_mode_logical		= true,
 
@@ -139,7 +138,6 @@ static struct apic apic_physflat __ro_af
 	.name				= "physical flat",
 	.probe				= physflat_probe,
 	.acpi_madt_oem_check		= physflat_acpi_madt_oem_check,
-	.apic_id_registered		= default_apic_id_registered,
 
 	.dest_mode_logical		= false,
 
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -61,8 +61,6 @@ void default_send_IPI_allbutself(int vec
 void default_send_IPI_all(int vector);
 void default_send_IPI_self(int vector);
 
-bool default_apic_id_registered(void);
-
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -38,7 +38,6 @@ static struct apic apic_default __ro_aft
 
 	.name				= "default",
 	.probe				= probe_default,
-	.apic_id_registered		= default_apic_id_registered,
 
 	.dest_mode_logical		= true,
 


