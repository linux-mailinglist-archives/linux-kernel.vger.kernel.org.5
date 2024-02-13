Return-Path: <linux-kernel+bounces-64283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6186D853CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4F7281E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FB978B7F;
	Tue, 13 Feb 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HvZnpc2A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2uJXnAEO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73843627E9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858324; cv=none; b=o2T3X9ieHMGdF8WlZSCu3/P6EVsh2wjsb2txD6vdc73zIRzwMFPhkcjTj7KhO5E6yCGwn/vdcR6qG5tNH67nOGzeICuA+BkzSl2yW2YQK69wBoMmtv2Pjpu6a4/8a0A0Gl8U79UiW2vdIL+uWUbX1sgHuniIuVzGL69Iw/uWGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858324; c=relaxed/simple;
	bh=iwNdGOeSVe6o7r5mvqVEJ7poQ3L/f+oh3Rm2SkBIMDE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rmFXN2f6LfGTFULLFhmYtEhD0fahFzVgCIx0kpZ90qMp/K4jZaNzkjz6kxoIqlqLAHCkFqhYurh4wF+8+Gu8lyNWF9Wu29AI3Ig+ti7m3Lb1zEkhvguJOQe/grAbcXAQNyUeP1SpbBgGq3TF7xz1WwuGC4eOdoejjepx4u+llQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HvZnpc2A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2uJXnAEO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154640.116510935@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LlwjbTUKZDaDXOeEu1A/4l2ILD7qxyCuJhH/mK8lvCs=;
	b=HvZnpc2Ax8YC1GFOZi3XHewVo1wWonyQCozbRS2McNVtZEekxh9WfF7do8HQ2Z0DtAUfzE
	soCzCzmp9l0d4ZaKaFij1y6O1+8+nOOKWsOEhNuotcoymdP0V7dnTWT9+ClNO8wLIPU46K
	DDXB/ZuXAIB+qYWmrtPAEuTuUxg/AQ96BDME5Nd6gXWSSm9e8HS0RaiiOeH2Lwb2I4/wm8
	3xwUgtHcoIONYECKYanTW7WtwQLquRzu7y48HxZWZdWrA4a0pJZMXvzzb5tKc+Ld5vTF8o
	EI82w59yYGaCMxJHwes9S9PXuF54UZzVty6gTLz/hio8K9HrUkf4pxMqTGathQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=LlwjbTUKZDaDXOeEu1A/4l2ILD7qxyCuJhH/mK8lvCs=;
	b=2uJXnAEOy9woif+kAVFrMbP4V7oics0Cf9f/WtYw5iIzWNWNP8Tz5uu0NHAfkm5SX/9NxC
	Ei8CFfh1QFjQoQDw==
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
Subject: [patch V3 21/22] x86/apic: Remove yet another dubious callback
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:20 +0100 (CET)

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
 




