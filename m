Return-Path: <linux-kernel+bounces-64268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953FC853CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4F228BF96
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DB06A006;
	Tue, 13 Feb 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5y0ogIa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tTa8iwiR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CAF69D33
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858304; cv=none; b=f2wuEXVHcp5RW6lNO7enor73EqrO3tXSQWubbi/a1ETu/SSCbgA78UawaQJRgmwSs0v+Ec1gn3LLG5S9+K8jOv491ZexBVWlVHWk4kXti0H7KBtuFzZrDLBUO0lTyY9/7Q682Yi/45vrdJ9ps0Hwy2cGdiF5QRN1uf6qRBMZ2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858304; c=relaxed/simple;
	bh=QqI5Y1bc7IthojtmOR/WKZyXH76w/68p6nYaipTT6SI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FEIWfA+QFw1JHM9ZXhaCyveB8QCVJqWOgqdP6s9SbywDC2Hrrfp+++DcXC5r6TjC8MdlcbludDc8+j7pgEZ0YF8cTShS0ddaOc8TXsiphw4M+8PYfaOiRtxz6qDfe3hV8p1WwAG0amCph+zbVDyBb1NBfryuS+U5iWjHoNHvh7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5y0ogIa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tTa8iwiR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.243307499@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Q8PdqEyeGwXQIMLoyT7lJgnZ5UJI8jOJaLPrah6vTXE=;
	b=L5y0ogIazDMAxltxsb8fTGyam2BTPoFxCvSSsfdjUGbTh5l3kiWxPNT5QiNAQsMy7ogkjK
	pzUj1hWIW9I2dX6MaJFpvy5B8hofr0w9aXztkzVtGHl7ozOLjm66ozYLBjk7P2nryznFBk
	QABNGfm1jyaiNcy6V2kVuyV3482vVgoz4rse76WoFoS8AQf5mNn8icC+1Uz97TRROr85P5
	WAsa2ke7UjxZ+Q5I2sQVGAgiIWsAakcJ257Pv2mCxKO0JKmTRHNcLoU73Xi+vMptdfLZxv
	/K3UD6ZwyXd2LSOMDvO+31MKyNyQG1BhBiHpLPOsJVTjqaXr09aVlz/+/1lJGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Q8PdqEyeGwXQIMLoyT7lJgnZ5UJI8jOJaLPrah6vTXE=;
	b=tTa8iwiRFU4tqaf8qT2+XdTE2Y7pmYZe+fRNa7OZAFU76Lhq59NyFUS4BTabnHtbSVKtqo
	EwRxEN4jUj+e+NBw==
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
Subject: [patch V3 07/22] x86/apic: Remove check_apicid_used() and
 ioapic_phys_id_map()
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:00 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 arch/x86/include/asm/apic.h           |    3 ---
 arch/x86/include/asm/mpspec.h         |    6 ------
 arch/x86/kernel/apic/apic_noop.c      |    2 --
 arch/x86/kernel/apic/bigsmp_32.c      |   13 -------------
 arch/x86/kernel/apic/probe_32.c       |    2 --
 arch/x86/kernel/apic/x2apic_cluster.c |    2 --
 6 files changed, 28 deletions(-)
---

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -290,9 +290,7 @@ struct apic {
 	int	(*acpi_madt_oem_check)(char *oem_id, char *oem_table_id);
 	bool	(*apic_id_registered)(void);
 
-	bool	(*check_apicid_used)(physid_mask_t *map, u32 apicid);
 	void	(*init_apic_ldr)(void);
-	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
 
 	u32	(*get_apic_id)(u32 id);
@@ -525,7 +523,6 @@ extern int default_apic_id_valid(u32 api
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
 
-extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern u32 default_cpu_present_to_apicid(int mps_cpu);
 
 void apic_send_nmi_to_offline_cpu(unsigned int cpu);
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -92,12 +92,6 @@ typedef struct physid_mask physid_mask_t
 #define physids_empty(map)					\
 	bitmap_empty((map).mask, MAX_LOCAL_APIC)
 
-static inline void physids_promote(unsigned long physids, physid_mask_t *map)
-{
-	physids_clear(*map);
-	map->mask[0] = physids;
-}
-
 static inline void physid_set_mask_of_physid(int physid, physid_mask_t *map)
 {
 	physids_clear(*map);
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -50,8 +50,6 @@ struct apic apic_noop __ro_after_init =
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= default_check_apicid_used,
-	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -18,17 +18,6 @@ static u32 bigsmp_get_apic_id(u32 x)
 	return (x >> 24) & 0xFF;
 }
 
-static bool bigsmp_check_apicid_used(physid_mask_t *map, u32 apicid)
-{
-	return false;
-}
-
-static void bigsmp_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap)
-{
-	/* For clustered we don't have a good way to do this yet - hack */
-	physids_promote(0xFFL, retmap);
-}
-
 static void bigsmp_send_IPI_allbutself(int vector)
 {
 	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
@@ -79,8 +68,6 @@ static struct apic apic_bigsmp __ro_afte
 
 	.disable_esr			= 1,
 
-	.check_apicid_used		= bigsmp_check_apicid_used,
-	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -44,9 +44,7 @@ static struct apic apic_default __ro_aft
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= default_check_apicid_used,
 	.init_apic_ldr			= default_init_apic_ldr,
-	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -231,9 +231,7 @@ static struct apic apic_x2apic_cluster _
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
 	.init_apic_ldr			= init_x2apic_ldr,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= UINT_MAX,



