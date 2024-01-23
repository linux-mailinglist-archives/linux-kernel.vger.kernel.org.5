Return-Path: <linux-kernel+bounces-35282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A58838EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3743E1F25B41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEDF60887;
	Tue, 23 Jan 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Y5U0jkh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="trkjBPOT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E9605D8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014441; cv=none; b=Xbas8dDeIymP+4ig3X+dB4E20TTV8NgovdvW1Ip+fx295yNMUvJzIcqqUV7Og+XXcuvkEPpf6ltiJ++nyo1zLGEG10VZC81EMECNBnIPrjb5C6ce3gY/UvLTW9t9TSD4KQwT3kl/hz+0riWA9GZPwIEm0T4xE4XJN4dha2SH/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014441; c=relaxed/simple;
	bh=PnsbmsuQuKaUVhkSUBDu0PEUx5aW5bL8PrtHc9WcVTI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dFbnMIOdiy1y4ea82SbmEHyHxK0ftNmgg8xDx6+XNLrLHHkSibbVljDxApIUYVZ+WBzgk1J5BlKcRrcrrdCATa17ejrB+ve8dfcxAbznuxvxLx+9kvb+YR4d/qT1F1GXPq1CLYZnWIzml2uymaLpAgTjxCBV9aFB/4EH5okXJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Y5U0jkh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=trkjBPOT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115909.402462466@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=N8YeS5UV8uEweP5dy/7M8glzwMeJnPQXY60aHFhlneU=;
	b=1Y5U0jkhn7CnBqdIdQDGeo+rIt7jr+R5MtlYU4g8vtKaSy+bYyO8iik/rl2j8xk2JtKr47
	8kJd5fShxCj5wBS13FSJrfxygM8Ti6p6gBN6Z+7mtovqEEn0NOk5uZUKHne/cbKXKz6IMl
	F67Nxg2dDG72mF9267cFFpgNLo5mSxt3i+SbcpT1F92QD8nHrxCYcbcT4CDhaFAGOYBF2k
	MIDIr4zeYcZ9nkQiU/aasMgArbeCNLwNXYSzuM0x7R0OT2oP5vq68QhxCyipcp2dv+ZQ/O
	TXZs1L2b0mk4Up7QiDRhDAsgVI0tyhbZ1bS7wXYwL2WrI9Ay7TVtV6T70n9L8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=N8YeS5UV8uEweP5dy/7M8glzwMeJnPQXY60aHFhlneU=;
	b=trkjBPOTpvkSKnHQi5xs6WKgaGPJDhQ/mhsUFTEcjL51x9xEwvirUOp32qGj+J3hXFhDS/
	7786lUq6gu5xcmDw==
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
Subject: [patch v5 17/19] x86/apic: Remove unused phys_pkg_id() callback
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:56 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Now that the core code does not use this monstrosity anymore, it's time to
put it to rest.

The only real purpose was to read the APIC ID on UV and VSMP systems for
the actual evaluation. That's what the core code does now.

For doing the actual shift operation there is truly no APIC callback
required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


---
 arch/x86/include/asm/apic.h           |    1 -
 arch/x86/kernel/apic/apic_flat_64.c   |    7 -------
 arch/x86/kernel/apic/apic_noop.c      |    3 ---
 arch/x86/kernel/apic/apic_numachip.c  |    7 -------
 arch/x86/kernel/apic/bigsmp_32.c      |    6 ------
 arch/x86/kernel/apic/local.h          |    1 -
 arch/x86/kernel/apic/probe_32.c       |    6 ------
 arch/x86/kernel/apic/x2apic_cluster.c |    1 -
 arch/x86/kernel/apic/x2apic_phys.c    |    6 ------
 arch/x86/kernel/apic/x2apic_uv_x.c    |   11 -----------
 arch/x86/kernel/vsmp_64.c             |   13 -------------
 arch/x86/xen/apic.c                   |    6 ------
 12 files changed, 68 deletions(-)
---
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -295,7 +295,6 @@ struct apic {
 	void	(*init_apic_ldr)(void);
 	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
-	u32	(*phys_pkg_id)(u32 cpuid_apic, int index_msb);
 
 	u32	(*get_apic_id)(u32 id);
 	u32	(*set_apic_id)(u32 apicid);
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -66,11 +66,6 @@ static u32 set_apic_id(u32 id)
 	return (id & 0xFF) << 24;
 }
 
-static u32 flat_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return initial_apic_id >> index_msb;
-}
-
 static int flat_probe(void)
 {
 	return 1;
@@ -88,7 +83,6 @@ static struct apic apic_flat __ro_after_
 
 	.init_apic_ldr			= default_init_apic_ldr,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
@@ -158,7 +152,6 @@ static struct apic apic_physflat __ro_af
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -29,7 +29,6 @@ static void noop_send_IPI_self(int vecto
 static void noop_apic_icr_write(u32 low, u32 id) { }
 static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
-static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
 static u32 noop_get_apic_id(u32 apicid) { return 0; }
 static void noop_apic_eoi(void) { }
 
@@ -55,8 +54,6 @@ struct apic apic_noop __ro_after_init =
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
-	.phys_pkg_id			= noop_phys_pkg_id,
-
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= noop_get_apic_id,
 
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -56,11 +56,6 @@ static u32 numachip2_set_apic_id(u32 id)
 	return id << 24;
 }
 
-static u32 numachip_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return initial_apic_id >> index_msb;
-}
-
 static void numachip1_apic_icr_write(int apicid, unsigned int val)
 {
 	write_lcsr(CSR_G3_EXT_IRQ_GEN, (apicid << 16) | val);
@@ -227,7 +222,6 @@ static const struct apic apic_numachip1
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip1_get_apic_id,
@@ -263,7 +257,6 @@ static const struct apic apic_numachip2
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip2_get_apic_id,
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -29,11 +29,6 @@ static void bigsmp_ioapic_phys_id_map(ph
 	physids_promote(0xFFL, retmap);
 }
 
-static u32 bigsmp_phys_pkg_id(u32 cpuid_apic, int index_msb)
-{
-	return cpuid_apic >> index_msb;
-}
-
 static void bigsmp_send_IPI_allbutself(int vector)
 {
 	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
@@ -87,7 +82,6 @@ static struct apic apic_bigsmp __ro_afte
 	.check_apicid_used		= bigsmp_check_apicid_used,
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= bigsmp_get_apic_id,
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -17,7 +17,6 @@
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 u32 x2apic_get_apic_id(u32 id);
 u32 x2apic_set_apic_id(u32 id);
-u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb);
 
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -18,11 +18,6 @@
 
 #include "local.h"
 
-static u32 default_phys_pkg_id(u32 cpuid_apic, int index_msb)
-{
-	return cpuid_apic >> index_msb;
-}
-
 static u32 default_get_apic_id(u32 x)
 {
 	unsigned int ver = GET_APIC_VERSION(apic_read(APIC_LVR));
@@ -53,7 +48,6 @@ static struct apic apic_default __ro_aft
 	.init_apic_ldr			= default_init_apic_ldr,
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= default_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= default_get_apic_id,
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -235,7 +235,6 @@ static struct apic apic_x2apic_cluster _
 	.init_apic_ldr			= init_x2apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -134,11 +134,6 @@ u32 x2apic_set_apic_id(u32 id)
 	return id;
 }
 
-u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb)
-{
-	return initial_apicid >> index_msb;
-}
-
 static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.name				= "physical x2apic",
@@ -150,7 +145,6 @@ static struct apic apic_x2apic_phys __ro
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -784,16 +784,6 @@ static u32 set_apic_id(u32 id)
 	return id;
 }
 
-static unsigned int uv_read_apic_id(void)
-{
-	return x2apic_get_apic_id(apic_read(APIC_ID));
-}
-
-static u32 uv_phys_pkg_id(u32 initial_apicid, int index_msb)
-{
-	return uv_read_apic_id() >> index_msb;
-}
-
 static int uv_probe(void)
 {
 	return apic == &apic_x2apic_uv_x;
@@ -810,7 +800,6 @@ static struct apic apic_x2apic_uv_x __ro
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= uv_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -127,25 +127,12 @@ static void __init vsmp_cap_cpus(void)
 #endif
 }
 
-static u32 apicid_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return read_apic_id() >> index_msb;
-}
-
-static void vsmp_apic_post_init(void)
-{
-	/* need to update phys_pkg_id */
-	apic->phys_pkg_id = apicid_phys_pkg_id;
-}
-
 void __init vsmp_init(void)
 {
 	detect_vsmp_box();
 	if (!is_vsmp_box())
 		return;
 
-	x86_platform.apic_post_init = vsmp_apic_post_init;
-
 	vsmp_cap_cpus();
 
 	set_vsmp_ctl();
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -110,11 +110,6 @@ static int xen_madt_oem_check(char *oem_
 	return xen_pv_domain();
 }
 
-static u32 xen_phys_pkg_id(u32 initial_apic_id, int index_msb)
-{
-	return initial_apic_id >> index_msb;
-}
-
 static u32 xen_cpu_present_to_apicid(int cpu)
 {
 	if (cpu_present(cpu))
@@ -133,7 +128,6 @@ static struct apic xen_pv_apic __ro_afte
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
-	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= xen_get_apic_id,


