Return-Path: <linux-kernel+bounces-35322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769E838F77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8ADC1F245AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533B15EE98;
	Tue, 23 Jan 2024 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CjkcWMoR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DG7qT2k+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B315F84D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015413; cv=none; b=cQOkh0aFvVHvuO2ApAZj6JVXLfYFW0CNJpLR9WITvPWGFg+gnd/aKJG5CQEcjcDeVbK795MEBrNZD/euMXGBmBNvXtYAa5jJbB432IHX+adNnX1vVusvFBKJTGfhLIcimOrL8MVcG2onuCzk+UuputE+gKgUJLii/6yrGxSz5xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015413; c=relaxed/simple;
	bh=0p6IN+AaI2RdILkReS0xPI4wWfYRKh9PPMTaliLCBuU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HF2apx3gyNOzNht6imrSf8VO4kPr0LT/KKLAvgdHKBLBiUd+dAeYTevGVAXyOmSsaJY41tabwlKaSejMYXhoXR6/Vx7BvNkbUkIBKQ61uS5VsTTPayfdJEwEN5pjMWvpT1zK4UcUBcBphO7FFpkZGq4EsyPp/6hpTuH6W1IMarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CjkcWMoR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DG7qT2k+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124902.600583242@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tIGbjb7boAsKyR9djKX32geCIl4aYf7Km9q18AwgrU8=;
	b=CjkcWMoRY5XfwVmn/hSLi67X+PgbUxnYgAGQ/q8RIhVtFhmU1lAOwW4deSox/ythvj+EzY
	0VmuAVoP0Xqy+YcmUDtabLkvSNMQc+rLlBJq1s8EZXwDLsmGXkCT9WfqSCJRxE9OLka4ar
	AjDYDNOTq2l/o+3V5hMprK/zDTeVT00kgdUE929xyuQ10fPApDin8XCXlLVZE7rM43SLaL
	UccQExLG18tp92UzkjQK6XflvxpROtushsX4mo50ZUHYbEtnFywmZK6AlBxhKhqps/7Bpr
	8Bh4RAG0NQP26ZgivTUaMxCPLGQs0QGWr4uJMNsuRx+hBrd8robDN3a8ZSBd9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tIGbjb7boAsKyR9djKX32geCIl4aYf7Km9q18AwgrU8=;
	b=DG7qT2k+j4qGOj18yB2ca9hXZv0MPmXtA2gVkCmnHJxb25AgPDeT5/xfLrJg8M957ly4eQ
	wnHEbiKpwgYTJiBw==
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
Subject: [patch V2 04/22] x86/apic: Get rid of get_physical_broadcast()
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:08 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

There is no point for this function. The only case where this is used is
when there is no XAPIC available, which means the broadcast address is 0xF.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Shevchenko <andy@infradead.org>

---
 arch/x86/kernel/apic/apic.c    |   10 --------
 arch/x86/kernel/apic/io_apic.c |   47 ++++++++++++++++++-----------------------
 2 files changed, 21 insertions(+), 36 deletions(-)
---
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
@@ -1484,11 +1484,10 @@ static void __init setup_ioapic_ids_from
 
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
 
@@ -1499,15 +1498,14 @@ static void __init setup_ioapic_ids_from
 		 */
 		if (apic->check_apicid_used(&phys_id_present_map,
 					    mpc_ioapic_id(ioapic_idx))) {
-			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
+			pr_err(FW_BUG "IO-APIC#%d ID %d is already used!...\n",
 				ioapic_idx, mpc_ioapic_id(ioapic_idx));
-			for (i = 0; i < get_physical_broadcast(); i++)
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
@@ -2209,7 +2207,7 @@ static inline void __init check_timer(vo
 	 * 8259A.
 	 */
 	if (pin1 == -1) {
-		panic_if_irq_remap("BIOS bug: timer not connected to IO-APIC");
+		panic_if_irq_remap(FW_BUG "Timer not connected to IO-APIC");
 		pin1 = pin2;
 		apic1 = apic2;
 		no_pin1 = 1;
@@ -2495,6 +2493,7 @@ unsigned int arch_dynirq_lower_bound(uns
 static int io_apic_get_unique_id(int ioapic, int apic_id)
 {
 	static physid_mask_t apic_id_map = PHYSID_MASK_NONE;
+	const u32 broadcast_id = 0xF;
 	union IO_APIC_reg_00 reg_00;
 	unsigned long flags;
 	int i = 0;
@@ -2515,9 +2514,9 @@ static int io_apic_get_unique_id(int ioa
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
 
@@ -2527,17 +2526,15 @@ static int io_apic_get_unique_id(int ioa
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
 
@@ -2567,11 +2564,9 @@ static int io_apic_get_unique_id(int ioa
 
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


