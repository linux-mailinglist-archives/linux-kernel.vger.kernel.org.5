Return-Path: <linux-kernel+bounces-35338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3322E838F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2BD1F285AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F215660DD7;
	Tue, 23 Jan 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qwX1xr9j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N6vo34vI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B760B97
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015438; cv=none; b=M6IU9rOUP8TEQrx0IkZFDORzAgzYJuxeOwC4OTdHOMySaZCT3YiUqARn+KrITBM9vupYTjyLd4d1USnVTojZov6o6bYhXLaGe6fLgbeQyl5DdrLrUXTOffs9ZTIQPVbqedoXvThXeX1Iko7vpZqPoHIGYRUrB/8CL46xDeSNNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015438; c=relaxed/simple;
	bh=oXffus0/drmzPAshDGBwqLcrHN7KDGIhPH1AepTWgts=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IbKylfchU4Vnwg9Fl3/wLpdI+gHFHLl1bJ2HLUeC1tMahDgnKJN25Qjzi3hluh7HGEwD/fatMeAxQIUrhzw/oUG0SyZ46sDyNjlc1Bc8ZOCWw57Fo/0kHB8q1fKH6fPfaq4LheTRIfmt4ygbODIfQal0rLlVY2wfb1zGCTPazSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qwX1xr9j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N6vo34vI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.563572853@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5B8N0mer08HMaKKKfCiXR4Upu1lzwrQdogSldBR6dt4=;
	b=qwX1xr9j/voKIYk0WD2+uY9E7Al94PqUTpA7S+7QcV0pinNKBZxYwhwH/0VQgYGW/s+i9k
	zaE9pXUTSFz4SR/Fy0FVYLuF+cauqO9Fjr0vv4TurFClKVzqbSejaoiylGK2zUZKHqsnaz
	dEonCR+KqXhz/TXcoXdwqYBkw3Nz0F6bCETTdDeglK5xYp1qF0ZH5YIyrj15oKw0SzF5Px
	SNaxsY3FNE7tyKLGp/VwRv+Kk4hH+deucOzW3PaW7kObL0XKdps8RhbR7wZsNr89cvKN0K
	VBe6tbzp24FYUlyMHEKG7jUsGCsywdcMXZ2KNC0XaJQ+VbAlnv8kwU/J61iY2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5B8N0mer08HMaKKKfCiXR4Upu1lzwrQdogSldBR6dt4=;
	b=N6vo34vI+c7y5u7l9SrdYyXdwIppWMExkWpNpB3QmR/T5Z4Xmlh+QuBmweVtIyISiFYpAl
	bB9B+FfkppNT7zDQ==
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
Subject: [patch V2 19/22] x86/mpparse: Remove the physid_t bitmap wrapper
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:33 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

physid_t is a wrapper around bitmap. Just remove the onion layer and use
bitmap functionality directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/mpspec.h      |   32 +++++++++-----------------------
 arch/x86/kernel/apic/apic.c        |   11 +++++------
 arch/x86/kernel/apic/apic_common.c |   12 +-----------
 arch/x86/kernel/apic/io_apic.c     |   24 ++++++++++++------------
 arch/x86/kernel/apic/local.h       |    1 -
 arch/x86/kernel/smpboot.c          |    8 +++-----
 6 files changed, 30 insertions(+), 58 deletions(-)
---
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_MPSPEC_H
 #define _ASM_X86_MPSPEC_H
 
+#include <linux/types.h>
 
 #include <asm/mpspec_def.h>
 #include <asm/x86_init.h>
@@ -62,32 +63,17 @@ static inline void e820__memblock_alloc_
 
 int generic_processor_info(int apicid);
 
-#define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_LOCAL_APIC)
+extern DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC);
 
-struct physid_mask {
-	unsigned long mask[PHYSID_ARRAY_SIZE];
-};
-
-typedef struct physid_mask physid_mask_t;
-
-#define physid_set(physid, map)			set_bit(physid, (map).mask)
-#define physid_isset(physid, map)		test_bit(physid, (map).mask)
-
-#define physids_clear(map)					\
-	bitmap_zero((map).mask, MAX_LOCAL_APIC)
-
-#define physids_empty(map)					\
-	bitmap_empty((map).mask, MAX_LOCAL_APIC)
-
-static inline void physid_set_mask_of_physid(int physid, physid_mask_t *map)
+static inline void reset_phys_cpu_present_map(u32 apicid)
 {
-	physids_clear(*map);
-	physid_set(physid, *map);
+	bitmap_zero(phys_cpu_present_map, MAX_LOCAL_APIC);
+	set_bit(apicid, phys_cpu_present_map);
 }
 
-#define PHYSID_MASK_ALL		{ {[0 ... PHYSID_ARRAY_SIZE-1] = ~0UL} }
-#define PHYSID_MASK_NONE	{ {[0 ... PHYSID_ARRAY_SIZE-1] = 0UL} }
-
-extern physid_mask_t phys_cpu_present_map;
+static inline void copy_phys_cpu_present_map(unsigned long *dst)
+{
+	bitmap_copy(dst, phys_cpu_present_map, MAX_LOCAL_APIC);
+}
 
 #endif /* _ASM_X86_MPSPEC_H */
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -19,6 +19,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
 #include <linux/acpi_pmtmr.h>
+#include <linux/bitmap.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/memblock.h>
@@ -77,10 +78,8 @@ EXPORT_SYMBOL_GPL(boot_cpu_physical_apic
 
 u8 boot_cpu_apic_version __ro_after_init;
 
-/*
- * Bitmask of physically existing CPUs:
- */
-physid_mask_t phys_cpu_present_map;
+/* Bitmap of physically present CPUs. */
+DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC);
 
 /*
  * Processor to be disabled specified by kernel parameter
@@ -2387,7 +2386,7 @@ static void cpu_update_apic(int cpu, u32
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif
 	set_cpu_possible(cpu, true);
-	physid_set(apicid, phys_cpu_present_map);
+	set_bit(apicid, phys_cpu_present_map);
 	set_cpu_present(cpu, true);
 	num_processors++;
 
@@ -2489,7 +2488,7 @@ static void __init apic_bsp_up_setup(voi
 #ifdef CONFIG_X86_64
 	apic_write(APIC_ID, apic->set_apic_id(boot_cpu_physical_apicid));
 #endif
-	physid_set_mask_of_physid(boot_cpu_physical_apicid, &phys_cpu_present_map);
+	reset_phys_cpu_present_map(boot_cpu_physical_apicid);
 }
 
 /**
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -18,16 +18,6 @@ u32 apic_flat_calc_apicid(unsigned int c
 	return 1U << cpu;
 }
 
-bool default_check_apicid_used(physid_mask_t *map, u32 apicid)
-{
-	return physid_isset(apicid, *map);
-}
-
-void default_ioapic_phys_id_map(physid_mask_t *phys_map, physid_mask_t *retmap)
-{
-	*retmap = *phys_map;
-}
-
 u32 default_cpu_present_to_apicid(int mps_cpu)
 {
 	if (mps_cpu < nr_cpu_ids && cpu_present(mps_cpu))
@@ -39,7 +29,7 @@ EXPORT_SYMBOL_GPL(default_cpu_present_to
 
 bool default_apic_id_registered(void)
 {
-	return physid_isset(read_apic_id(), phys_cpu_present_map);
+	return test_bit(read_apic_id(), phys_cpu_present_map);
 }
 
 /*
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1460,7 +1460,7 @@ void restore_boot_irq_mode(void)
  */
 static void __init setup_ioapic_ids_from_mpc_nocheck(void)
 {
-	physid_mask_t phys_id_present_map;
+	DECLARE_BITMAP(phys_id_present_map, MAX_LOCAL_APIC);
 	const u32 broadcast_id = 0xF;
 	union IO_APIC_reg_00 reg_00;
 	unsigned char old_id;
@@ -1471,7 +1471,7 @@ static void __init setup_ioapic_ids_from
 	 * This is broken; anything with a real cpu count has to
 	 * circumvent this idiocy regardless.
 	 */
-	phys_id_present_map = phys_cpu_present_map;
+	copy_phys_cpu_present_map(phys_id_present_map);
 
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
@@ -1496,21 +1496,21 @@ static void __init setup_ioapic_ids_from
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 */
-		if (physid_isset(mpc_ioapic_id(ioapic_idx), phys_id_present_map)) {
+		if (test_bit(mpc_ioapic_id(ioapic_idx), phys_id_present_map)) {
 			pr_err(FW_BUG "IO-APIC#%d ID %d is already used!...\n",
 				ioapic_idx, mpc_ioapic_id(ioapic_idx));
 			for (i = 0; i < broadcast_id; i++)
-				if (!physid_isset(i, phys_id_present_map))
+				if (!test_bit(i, phys_id_present_map))
 					break;
 			if (i >= broadcast_id)
 				panic("Max APIC ID exceeded!\n");
 			pr_err("... fixing up to %d. (tell your hw vendor)\n", i);
-			physid_set(i, phys_id_present_map);
+			set_bit(i, phys_id_present_map);
 			ioapics[ioapic_idx].mp_config.apicid = i;
 		} else {
 			apic_printk(APIC_VERBOSE, "Setting %d in the phys_id_present_map\n",
 				    mpc_ioapic_id(ioapic_idx));
-			physid_set(mpc_ioapic_id(ioapic_idx), phys_id_present_map);
+			set_bit(mpc_ioapic_id(ioapic_idx), phys_id_present_map);
 		}
 
 		/*
@@ -2491,15 +2491,15 @@ unsigned int arch_dynirq_lower_bound(uns
 #ifdef CONFIG_X86_32
 static int io_apic_get_unique_id(int ioapic, int apic_id)
 {
-	static physid_mask_t apic_id_map = PHYSID_MASK_NONE;
+	static DECLARE_BITMAP(apic_id_map, MAX_LOCAL_APIC);
 	const u32 broadcast_id = 0xF;
 	union IO_APIC_reg_00 reg_00;
 	unsigned long flags;
 	int i = 0;
 
 	/* Initialize the ID map */
-	if (physids_empty(apic_id_map))
-		apic_id_map = phys_cpu_present_map;
+	if (bitmap_empty(apic_id_map, MAX_LOCAL_APIC))
+		copy_phys_cpu_present_map(apic_id_map);
 
 	raw_spin_lock_irqsave(&ioapic_lock, flags);
 	reg_00.raw = io_apic_read(ioapic, 0);
@@ -2512,9 +2512,9 @@ static int io_apic_get_unique_id(int ioa
 	}
 
 	/* Every APIC in a system must have a unique ID */
-	if (physid_isset(apic_id, apic_id_map)) {
+	if (test_bit(apic_id, apic_id_map)) {
 		for (i = 0; i < broadcast_id; i++) {
-			if (!physid_isset(i, apic_id_map))
+			if (!test_bit(i, apic_id_map))
 				break;
 		}
 
@@ -2525,7 +2525,7 @@ static int io_apic_get_unique_id(int ioa
 		apic_id = i;
 	}
 
-	physid_set(apic_id, apic_id_map);
+	set_bit(apic_id, apic_id_map);
 
 	if (reg_00.bits.ID != apic_id) {
 		reg_00.bits.ID = apic_id;
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -63,7 +63,6 @@ void default_send_IPI_all(int vector);
 void default_send_IPI_self(int vector);
 
 bool default_apic_id_registered(void);
-bool default_check_apicid_used(physid_mask_t *map, u32 apicid);
 
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1072,7 +1072,7 @@ int native_kick_ap(unsigned int cpu, str
 
 	pr_debug("++++++++++++++++++++=_---CPU UP  %u\n", cpu);
 
-	if (apicid == BAD_APICID || !physid_isset(apicid, phys_cpu_present_map) ||
+	if (apicid == BAD_APICID || !test_bit(apicid, phys_cpu_present_map) ||
 	    !apic_id_valid(apicid)) {
 		pr_err("%s: bad cpu %d\n", __func__, cpu);
 		return -EINVAL;
@@ -1147,10 +1147,8 @@ static __init void disable_smp(void)
 	init_cpu_present(cpumask_of(0));
 	init_cpu_possible(cpumask_of(0));
 
-	if (smp_found_config)
-		physid_set_mask_of_physid(boot_cpu_physical_apicid, &phys_cpu_present_map);
-	else
-		physid_set_mask_of_physid(0, &phys_cpu_present_map);
+	reset_phys_cpu_present_map(smp_found_config ? boot_cpu_physical_apicid : 0);
+
 	cpumask_set_cpu(0, topology_sibling_cpumask(0));
 	cpumask_set_cpu(0, topology_core_cpumask(0));
 	cpumask_set_cpu(0, topology_die_cpumask(0));


