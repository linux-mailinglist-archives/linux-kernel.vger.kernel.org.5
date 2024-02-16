Return-Path: <linux-kernel+bounces-68839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823228580DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363FB281E38
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7052914D457;
	Fri, 16 Feb 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MRhV6C1r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZWsmX0v9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590414A4DC;
	Fri, 16 Feb 2024 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096648; cv=none; b=HGwRjAbJK5eum42rEg8KoNCSmOwC8+BsGodTLXS37CRfgYHsdGxjXLiGbXl7wSXSxzZcVAb8VPRJf+Y6HPCV+wBZGBhOJSRnC/qsKrhvjNT5uszjDV37ESnR7dMpgeGrZPKW5/tOmOE/4JCfh+eCcvHt+byeJIEKhHK0PwoC8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096648; c=relaxed/simple;
	bh=djB/EPHNy0LBcF5S+QWtcHpA9MWPs1pQEkAN5zQtQJ8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bhu5ftdAdZnst+4BwJq9IRfDWE/7DwAAGEiQp7vGOjnf1tBThySPKV7wexA+/qWA/WfuPdoeHZAIJKv0N/HcHZPJfCFcWXqKR3/8AlCIq/Ue6Gq0uMaGDmz2JHbyNhFuSEo+ojbcuNjZXUCEOaNQMH7ZvbFzldjgdsRwkTYtDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MRhV6C1r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZWsmX0v9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dhkjv/Yr3gdAIdxxj3zv69onzgvUXgNZh5pInWTfBS4=;
	b=MRhV6C1rZNQibf13reKiImczPvw+rR6V6rIK0zQ+5sctD0zd30I8DdpZRGO0n+ExIk4Vvk
	0HB4sAkGuftT3Lk8/vqO6wknzx4d337JGjoU0wgNG84aEjp1G+XS6HpS/tpLiiut6Go5u5
	zso9b5/y+NpOQTVTtoVCJvhvDquKFRRyxCVdS+fkf3V7KnMOvYhUTlJxbuoQHz2jQvR7YU
	YQzd5PMSjjB5LOkbUbOYq2eaqbsZioYD/Zy9RbTkN0duDWe6uG4+P89RRkRwf3JvzcPmRl
	nZLq3Q5aTMrBD+7pF2YFeNVj5y04lmr+pcP71nK9QMhsASfqP+xCd26UKBafGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dhkjv/Yr3gdAIdxxj3zv69onzgvUXgNZh5pInWTfBS4=;
	b=ZWsmX0v92ath2WC4vtZh2oZdOkVkAtA55nYHVfNx2orCzhU0xz38NIPV4GV+94WxeeWphY
	ErglEBZrwXRam7AQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Get rid of get_physical_broadcast()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.057209154@linutronix.de>
References: <20240212154639.057209154@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664233.398.10624016431879023057.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     517234446c1ad1d6bb0d9f5b94a71b24f80edaae
Gitweb:        https://git.kernel.org/tip/517234446c1ad1d6bb0d9f5b94a71b24f80edaae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:39 +01:00

x86/apic: Get rid of get_physical_broadcast()

There is no point for this function. The only case where this is used is
when there is no XAPIC available, which means the broadcast address is 0xF.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.057209154@linutronix.de

---
 arch/x86/kernel/apic/apic.c    | 10 +-------
 arch/x86/kernel/apic/io_apic.c | 49 ++++++++++++++-------------------
 2 files changed, 22 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4667bc4..814e15c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -261,16 +261,6 @@ u64 native_apic_icr_read(void)
 	return icr1 | ((u64)icr2 << 32);
 }
 
-#ifdef CONFIG_X86_32
-/**
- * get_physical_broadcast - Get number of physical broadcast IDs
- */
-int get_physical_broadcast(void)
-{
-	return modern_apic() ? 0xff : 0xf;
-}
-#endif
-
 /**
  * lapic_get_maxlvt - get the maximum number of local vector table entries
  */
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index b62c7ee..a4219b9 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1460,12 +1460,12 @@ void restore_boot_irq_mode(void)
  */
 static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 {
-	union IO_APIC_reg_00 reg_00;
 	physid_mask_t phys_id_present_map;
-	int ioapic_idx;
-	int i;
+	const u32 broadcast_id = 0xF;
+	union IO_APIC_reg_00 reg_00;
 	unsigned char old_id;
 	unsigned long flags;
+	int ioapic_idx, i;
 
 	/*
 	 * This is broken; anything with a real cpu count has to
@@ -1484,11 +1484,10 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 
 		old_id = mpc_ioapic_id(ioapic_idx);
 
-		if (mpc_ioapic_id(ioapic_idx) >= get_physical_broadcast()) {
-			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
-				ioapic_idx, mpc_ioapic_id(ioapic_idx));
-			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
-				reg_00.bits.ID);
+		if (mpc_ioapic_id(ioapic_idx) >= broadcast_id) {
+			pr_err(FW_BUG "IO-APIC#%d ID is %d in the MPC table!...\n",
+			       ioapic_idx, mpc_ioapic_id(ioapic_idx));
+			pr_err("... fixing up to %d. (tell your hw vendor)\n", reg_00.bits.ID);
 			ioapics[ioapic_idx].mp_config.apicid = reg_00.bits.ID;
 		}
 
@@ -1499,15 +1498,14 @@ static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 		 */
 		if (apic->check_apicid_used(&phys_id_present_map,
 					    mpc_ioapic_id(ioapic_idx))) {
-			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
-				ioapic_idx, mpc_ioapic_id(ioapic_idx));
-			for (i = 0; i < get_physical_broadcast(); i++)
+			pr_err(FW_BUG "IO-APIC#%d ID %d is already used!...\n",
+			       ioapic_idx, mpc_ioapic_id(ioapic_idx));
+			for (i = 0; i < broadcast_id; i++)
 				if (!physid_isset(i, phys_id_present_map))
 					break;
-			if (i >= get_physical_broadcast())
+			if (i >= broadcast_id)
 				panic("Max APIC ID exceeded!\n");
-			printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
-				i);
+			pr_err("... fixing up to %d. (tell your hw vendor)\n", i);
 			physid_set(i, phys_id_present_map);
 			ioapics[ioapic_idx].mp_config.apicid = i;
 		} else {
@@ -2209,7 +2207,7 @@ static inline void __init check_timer(void)
 	 * 8259A.
 	 */
 	if (pin1 == -1) {
-		panic_if_irq_remap("BIOS bug: timer not connected to IO-APIC");
+		panic_if_irq_remap(FW_BUG "Timer not connected to IO-APIC");
 		pin1 = pin2;
 		apic1 = apic2;
 		no_pin1 = 1;
@@ -2495,6 +2493,7 @@ unsigned int arch_dynirq_lower_bound(unsigned int from)
 static int io_apic_get_unique_id(int ioapic, int apic_id)
 {
 	static physid_mask_t apic_id_map = PHYSID_MASK_NONE;
+	const u32 broadcast_id = 0xF;
 	union IO_APIC_reg_00 reg_00;
 	unsigned long flags;
 	int i = 0;
@@ -2515,9 +2514,9 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 	reg_00.raw = io_apic_read(ioapic, 0);
 	raw_spin_unlock_irqrestore(&ioapic_lock, flags);
 
-	if (apic_id >= get_physical_broadcast()) {
-		printk(KERN_WARNING "IOAPIC[%d]: Invalid apic_id %d, trying "
-			"%d\n", ioapic, apic_id, reg_00.bits.ID);
+	if (apic_id >= broadcast_id) {
+		pr_warn("IOAPIC[%d]: Invalid apic_id %d, trying %d\n",
+			ioapic, apic_id, reg_00.bits.ID);
 		apic_id = reg_00.bits.ID;
 	}
 
@@ -2527,17 +2526,15 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 	 */
 	if (apic->check_apicid_used(&apic_id_map, apic_id)) {
 
-		for (i = 0; i < get_physical_broadcast(); i++) {
+		for (i = 0; i < broadcast_id; i++) {
 			if (!apic->check_apicid_used(&apic_id_map, i))
 				break;
 		}
 
-		if (i == get_physical_broadcast())
+		if (i == broadcast_id)
 			panic("Max apic_id exceeded!\n");
 
-		printk(KERN_WARNING "IOAPIC[%d]: apic_id %d already used, "
-			"trying %d\n", ioapic, apic_id, i);
-
+		pr_warn("IOAPIC[%d]: apic_id %d already used, trying %d\n", ioapic, apic_id, i);
 		apic_id = i;
 	}
 
@@ -2567,11 +2564,9 @@ static int io_apic_get_unique_id(int ioapic, int apic_id)
 
 static u8 io_apic_unique_id(int idx, u8 id)
 {
-	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) &&
-	    !APIC_XAPIC(boot_cpu_apic_version))
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && !APIC_XAPIC(boot_cpu_apic_version))
 		return io_apic_get_unique_id(idx, id);
-	else
-		return id;
+	return id;
 }
 #else
 static u8 io_apic_unique_id(int idx, u8 id)

