Return-Path: <linux-kernel+bounces-68820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AECF8580B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499E71C20FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF421145FF7;
	Fri, 16 Feb 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q9c5CAqF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="blBZTl7U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4219813B289;
	Fri, 16 Feb 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096635; cv=none; b=nnhB7CJh5ndgQlZNVJ2+QtHbr6hV59MfnNq75pXX71F++4hnCB31EbPGz95gRSbKRHiTsWOHOnAxUqhv+IZNBWHqRs4UtPz9HNc0HfFOWphJ57RWiuH0IaM2R91YXw8C0FxLztYDYILvMGlu3ZmorgK1aboSyuljJHMMc2nmQNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096635; c=relaxed/simple;
	bh=IgRtrJF9dsiFDWJRQ/R34VQgki8XfrSqa7UsSwXZ4Gc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M55dZPZSeRzdHvib3zft5K5yiCg6rKXTeTzGZkj8aHVkqZrv1id05ff0/Nkb5UoA38gKGkLum/TOx5KtKXol6TYka0msef/3CZb3hc6VARDxPrtmusWj1GFo63yi/uH15yb/ElPf1Oly/ZGtz0xPwuWA3C5HEQSQbSINREEH1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q9c5CAqF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=blBZTl7U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4AARpZwWjwlbbhxZJIrDPqNgXydp7L69POTG4GXT/c=;
	b=Q9c5CAqFUfa6waYXXR+cwmTtjyxIqc3AwEz3x+QREbwHmE2M86qQ+57UO+FaUvJXpRQDe+
	nzcjZlqlJaGaiLhda4kfkJWJpldbGJB6Pd+yrni27IJoAcdmEMCiflrzYNwyHZmu4f9WpQ
	17+l1Y7Lo0auRWTPAOGh8eRcBj5exciRjtf7XHl5u3VwBdOslUMA44KTjWe8n7ZaKnMUf0
	Isd3kCQb8CAtPlcP1t4DeTZDCf1z/T126LeASCJqoLdcJjY/AVgsTr2h98pdw77jBfxL5f
	9ej1Nkn9IOfNYGUzU08f0cUtRnk/eTei0ie8orq6xU9uUFlFmJH7/bsuHJI/iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4AARpZwWjwlbbhxZJIrDPqNgXydp7L69POTG4GXT/c=;
	b=blBZTl7UmriL9Nes4P5RUSaqZRd9KDjQVhKqy4myNkP1zkVax/K9pO/nu16jAKRouFeZv1
	qAv9VuMb8SaUC/Bg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove yet another dubious callback
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154640.116510935@linutronix.de>
References: <20240212154640.116510935@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663103.398.16083175050539714376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     4a5f72a4a39f5d5dcf9b9dc1acc57ecbbb8d4caa
Gitweb:        https://git.kernel.org/tip/4a5f72a4a39f5d5dcf9b9dc1acc57ecbbb8d4caa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:41 +01:00

x86/apic: Remove yet another dubious callback

Paranoia is not wrong, but having an APIC callback which is in most
implementations a complete NOOP and in one actually looking whether the
APICID of an upcoming CPU has been registered. The same APICID which was
used to bring the CPU out of wait for startup.

That's paranoia for the paranoia sake. Remove the voodoo.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154640.116510935@linutronix.de



---
 arch/x86/include/asm/apic.h         | 1 -
 arch/x86/kernel/apic/apic.c         | 3 ---
 arch/x86/kernel/apic/apic_common.c  | 5 -----
 arch/x86/kernel/apic/apic_flat_64.c | 2 --
 arch/x86/kernel/apic/local.h        | 2 --
 arch/x86/kernel/apic/probe_32.c     | 1 -
 6 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 89eae0c..ba219d6 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -288,7 +288,6 @@ struct apic {
 	/* Probe, setup and smpboot functions */
 	int	(*probe)(void);
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
-	bool	(*apic_id_registered)(void);
 
 	void	(*init_apic_ldr)(void);
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e3cebd4..68767a9 100644
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
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index d4dfa43..9ef3be8 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -27,11 +27,6 @@ u32 default_cpu_present_to_apicid(int mps_cpu)
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
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index f6ef121..f37ad33 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -70,7 +70,6 @@ static struct apic apic_flat __ro_after_init = {
 	.name				= "flat",
 	.probe				= flat_probe,
 	.acpi_madt_oem_check		= flat_acpi_madt_oem_check,
-	.apic_id_registered		= default_apic_id_registered,
 
 	.dest_mode_logical		= true,
 
@@ -139,7 +138,6 @@ static struct apic apic_physflat __ro_after_init = {
 	.name				= "physical flat",
 	.probe				= physflat_probe,
 	.acpi_madt_oem_check		= physflat_acpi_madt_oem_check,
-	.apic_id_registered		= default_apic_id_registered,
 
 	.dest_mode_logical		= false,
 
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index f8a87f9..842fe28 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -61,8 +61,6 @@ void default_send_IPI_allbutself(int vector);
 void default_send_IPI_all(int vector);
 void default_send_IPI_self(int vector);
 
-bool default_apic_id_registered(void);
-
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index cdf4047..f75ee34 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -38,7 +38,6 @@ static struct apic apic_default __ro_after_init = {
 
 	.name				= "default",
 	.probe				= probe_default,
-	.apic_id_registered		= default_apic_id_registered,
 
 	.dest_mode_logical		= true,
 

