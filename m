Return-Path: <linux-kernel+bounces-68846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D5F8580EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DAC1F214F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C5F12FF80;
	Fri, 16 Feb 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0BoGB2FN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MSNwyC1z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E70E14D428;
	Fri, 16 Feb 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096652; cv=none; b=WVXS98xzZUARFbIm/8MPooQ+O8JQcJy5aXzXb1EsPkz/tVOAX4T2dMkbNJQH+hcyqnoBwmsiXa7t1oVlP4XOIsL5MRgGSeW9W1vymFXuikV0I5Qu9zZS+7Ywz2YdUV3B7Y8EdTxFOzVDIomWfGO0DKLyBwIBDQhX5VYnHLuKoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096652; c=relaxed/simple;
	bh=vpw7wUAVCIJs+1oGVjVt9a1H008CxssALlrETAvE02g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FZGUaTdmqHh5OzUYpSY5vQDyWcT29+p5ENU/Q29RPe3OpQsvbDmVKoknVu831GrlA4cVDxO14KjAl/g2TkB5Xnxz2qnzzmq2cRKBH4CX6L9dsGQhfMVGDqY93GybfV52iKaI6BfS0CxLXGVuyq8LxXNKku+qqAgSDvomrCakbyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0BoGB2FN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MSNwyC1z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096646;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTavNb5j24MfrRX7BiG+LaZXGxr6U0Y0ZNtGC/oTIJQ=;
	b=0BoGB2FNNH+qXZfDZGyLxFq59VQKlEVl/qCVV0EKXiwpB0XvdCX5P7WcBAywTGxa9YbLhv
	9tiRRxYFV4lbW9KXbrXDEmrp/FMBoFGw0/ihD3xzrL48dcwcKYXiTBUGU0MOlV0KATvSKD
	NX76HymyAqbCAYEgIvHBFdrBqc9yWjvCjuSVa0XHAczW2nb7RmcQHP5YceN5HpVzaMZqxe
	5uvAMriv68TmPVuw3KXE4Ebe3cxRKCgLdsrg5GTUUIAD00Uj3IHbyYZ3EUl40doVH3+o5J
	AkRyoJbAUq7VOR6UDJ/4F+zr1zZwLZ6JmwCm4eY16zhzk1agwsaxDjKGfgVFEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096646;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTavNb5j24MfrRX7BiG+LaZXGxr6U0Y0ZNtGC/oTIJQ=;
	b=MSNwyC1z389rnhLwaJrBKT8JiUwRFYVyCKv4mMLaPJDXHbrH/GolAHx/DHVWT0AgaKZoqP
	vWZUYr7729iOSpBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove unused phys_pkg_id() callback
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153625.516536121@linutronix.de>
References: <20240212153625.516536121@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664610.398.13431614917686826801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     035fc90a9d8fcff39b9bb43b9ff132756d947ea5
Gitweb:        https://git.kernel.org/tip/035fc90a9d8fcff39b9bb43b9ff132756d947ea5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:38 +01:00

x86/apic: Remove unused phys_pkg_id() callback

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
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153625.516536121@linutronix.de




---
 arch/x86/include/asm/apic.h           |  1 -
 arch/x86/kernel/apic/apic_flat_64.c   |  7 -------
 arch/x86/kernel/apic/apic_noop.c      |  3 ---
 arch/x86/kernel/apic/apic_numachip.c  |  7 -------
 arch/x86/kernel/apic/bigsmp_32.c      |  6 ------
 arch/x86/kernel/apic/local.h          |  1 -
 arch/x86/kernel/apic/probe_32.c       |  6 ------
 arch/x86/kernel/apic/x2apic_cluster.c |  1 -
 arch/x86/kernel/apic/x2apic_phys.c    |  6 ------
 arch/x86/kernel/apic/x2apic_uv_x.c    | 11 -----------
 arch/x86/kernel/vsmp_64.c             | 13 -------------
 arch/x86/xen/apic.c                   |  6 ------
 12 files changed, 68 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9d159b7..80d6383 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -295,7 +295,6 @@ struct apic {
 	void	(*init_apic_ldr)(void);
 	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
-	u32	(*phys_pkg_id)(u32 cpuid_apic, int index_msb);
 
 	u32	(*get_apic_id)(u32 id);
 	u32	(*set_apic_id)(u32 apicid);
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index b295a05..fe9b728 100644
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
@@ -88,7 +83,6 @@ static struct apic apic_flat __ro_after_init = {
 
 	.init_apic_ldr			= default_init_apic_ldr,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
@@ -158,7 +152,6 @@ static struct apic apic_physflat __ro_after_init = {
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= flat_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 9f1d553..1f2de66 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -29,7 +29,6 @@ static void noop_send_IPI_self(int vector) { }
 static void noop_apic_icr_write(u32 low, u32 id) { }
 static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
 static u64 noop_apic_icr_read(void) { return 0; }
-static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
 static u32 noop_get_apic_id(u32 apicid) { return 0; }
 static void noop_apic_eoi(void) { }
 
@@ -55,8 +54,6 @@ struct apic apic_noop __ro_after_init = {
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
-	.phys_pkg_id			= noop_phys_pkg_id,
-
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= noop_get_apic_id,
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 7d0c51b..f7591dc 100644
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
@@ -227,7 +222,6 @@ static const struct apic apic_numachip1 __refconst = {
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip1_get_apic_id,
@@ -263,7 +257,6 @@ static const struct apic apic_numachip2 __refconst = {
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= numachip_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip2_get_apic_id,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 5a0d60b..dc83c2e 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -29,11 +29,6 @@ static void bigsmp_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *re
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
@@ -87,7 +82,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 	.check_apicid_used		= bigsmp_check_apicid_used,
 	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= bigsmp_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= bigsmp_get_apic_id,
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 9ea6186..8fd37c9 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -17,7 +17,6 @@
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 u32 x2apic_get_apic_id(u32 id);
 u32 x2apic_set_apic_id(u32 id);
-u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb);
 
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index c0f7805..752a955 100644
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
@@ -53,7 +48,6 @@ static struct apic apic_default __ro_after_init = {
 	.init_apic_ldr			= default_init_apic_ldr,
 	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= default_phys_pkg_id,
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= default_get_apic_id,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 28a7d3f..59b0573 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -235,7 +235,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.init_apic_ldr			= init_x2apic_ldr,
 	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 409815a..8f1c39f 100644
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
@@ -150,7 +145,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= x2apic_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f1766b1..51485f2 100644
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
@@ -810,7 +800,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
-	.phys_pkg_id			= uv_phys_pkg_id,
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index d3fc017..7351133 100644
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
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index 9dd5490..d475238 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -110,11 +110,6 @@ static int xen_madt_oem_check(char *oem_id, char *oem_table_id)
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
@@ -133,7 +128,6 @@ static struct apic xen_pv_apic __ro_after_init = {
 	.disable_esr			= 0,
 
 	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
-	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= xen_get_apic_id,

