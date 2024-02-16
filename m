Return-Path: <linux-kernel+bounces-68835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330C68580D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5773C1C23427
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D845214AD1A;
	Fri, 16 Feb 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xRSAhgIJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1aX5/gv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BF14A082;
	Fri, 16 Feb 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096644; cv=none; b=BUe6PWMi8HQSdlGYzDa89Cu6rWySfV1Ne0Ryp3uixMZxFqceEQb+it2VF2CIpLkhdntw2nyQl+0Y8k1BRy6ydCZgrfAOX1vtthDTd+UcK/wQlm9ZxSIZTN94/Ac3YUrhpQbKMdeX9nqtET1L/KvNF6eiehQdtsBoXyWjyvYH7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096644; c=relaxed/simple;
	bh=CXUZkAzOSzCMAAkSfPypgUAC68NaLVqBR6dwwdoa9rc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bYu8R1O2ZsU8LQqXCSsEtSrUkD5usIZrtT6TY9tuy6q6PnNZY7iUzzya6PxCqFqSZYcQ9+XjdgfCC+j0gjRAM1eVeQKAStLXFErYqwO16+cj7ebHNrzgzRuQ8JuZ7jdIGC3a2nCRIgKILO7eTEnYkkMeQ/plTVJM67+KeJIBZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xRSAhgIJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a1aX5/gv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5V7IL4hgWJH/LPdKhAPAEJBvSl/NDh/M+LsO86Tq1Fw=;
	b=xRSAhgIJn+UhZl2xwt9bDNjvmrogDT34R4QiOMId6xos+yGuZqDrMPolQEj5KCuX1nVwzp
	10EiWT0VSXQGcg7g/tJEKSyO8so7sbvRZRf+DoA4Aml+PxbqTO2sa9VDG8j/QvBjpZ50sF
	FgozAiHW00Uxcz7exqgJWGo5II6jy08ofJnRSwy1PiC9NuibXSAsiag85MC8GO3fUeGSq5
	4s15telUgCmtJ9xGl+Vbjyum91bIApm8Zh+n9u6NAYSJhfb1cBvEEoj/u4dGFmLsNeuSPN
	P6k0dDZSqb1eYUHn7KCGegbCyVbtVMeXHykE7rzIoBODxFh/5iA9ka8jGXS1Mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5V7IL4hgWJH/LPdKhAPAEJBvSl/NDh/M+LsO86Tq1Fw=;
	b=a1aX5/gvVL0R5LfrxDndaEGqwpfsqFLx+LKOVVH+a6hRsZwXFbHvsTr4ljxL0xhcUhSfYc
	rHKZetrW7n3X2PDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/apic: Remove check_apicid_used() and ioapic_phys_id_map()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.243307499@linutronix.de>
References: <20240212154639.243307499@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664035.398.4455127248489417845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     3e48d804c8ea99170638b4e14931686bfc093f02
Gitweb:        https://git.kernel.org/tip/3e48d804c8ea99170638b4e14931686bfc093f02
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:39 +01:00

x86/apic: Remove check_apicid_used() and ioapic_phys_id_map()

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.243307499@linutronix.de



---
 arch/x86/include/asm/apic.h           |  3 ---
 arch/x86/include/asm/mpspec.h         |  6 ------
 arch/x86/kernel/apic/apic_noop.c      |  2 --
 arch/x86/kernel/apic/bigsmp_32.c      | 13 -------------
 arch/x86/kernel/apic/probe_32.c       |  2 --
 arch/x86/kernel/apic/x2apic_cluster.c |  2 --
 6 files changed, 28 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 6c5cffc..16e5e00 100644
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
@@ -525,7 +523,6 @@ extern int default_apic_id_valid(u32 apicid);
 extern u32 apic_default_calc_apicid(unsigned int cpu);
 extern u32 apic_flat_calc_apicid(unsigned int cpu);
 
-extern void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap);
 extern u32 default_cpu_present_to_apicid(int mps_cpu);
 
 void apic_send_nmi_to_offline_cpu(unsigned int cpu);
diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 9bf1e75..666dcdb 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -92,12 +92,6 @@ typedef struct physid_mask physid_mask_t;
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
diff --git a/arch/x86/kernel/apic/apic_noop.c b/arch/x86/kernel/apic/apic_noop.c
index 1f2de66..b5bb7a2 100644
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -50,8 +50,6 @@ struct apic apic_noop __ro_after_init = {
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= default_check_apicid_used,
-	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index dc83c2e..29f354a 100644
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
@@ -79,8 +68,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 
 	.disable_esr			= 1,
 
-	.check_apicid_used		= bigsmp_check_apicid_used,
-	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 752a955..cdf4047 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -44,9 +44,7 @@ static struct apic apic_default __ro_after_init = {
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= default_check_apicid_used,
 	.init_apic_ldr			= default_init_apic_ldr,
-	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= 0xFE,
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 59b0573..4926b12 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -231,9 +231,7 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 
 	.disable_esr			= 0,
 
-	.check_apicid_used		= NULL,
 	.init_apic_ldr			= init_x2apic_ldr,
-	.ioapic_phys_id_map		= NULL,
 	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
 
 	.max_apic_id			= UINT_MAX,

