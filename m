Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD31776850
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjHITN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjHITNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:13:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040672D63;
        Wed,  9 Aug 2023 12:12:44 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kxkZ+OSY/XjIlIpe9/+r+r8IUjI+xW+PcSvP3oceigk=;
        b=jhptXylvcwyljHVcxdOaBCNeKJYUuuPD5nub8aWsQZEugEW29W/uEFI8X4raNnEurOD1j3
        GPIx/VGiQRuh7xH/DmZ/N/ICqg7bRcXx8jQwRPJombxuL3lN886Q0HeVudohU/iLnVs/GZ
        427Ci9nMhgotOseTTrV8WMQ6noGdU6ggCxa202x7ZsLMZEptDCaY3LHDA42yADtsVVIZ6G
        BUojMcvibeaMzPrwRM1QeILKuoNvu5EM27TnNAyLl+wBGTfrsFXkVl5eoG4ykQhh4HbhlL
        9+R4lMTRpDh18KMGxPCdM5t1SDjEaUU3nnrUwVv/tezjZa3dtz3/K0y6f4mqNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kxkZ+OSY/XjIlIpe9/+r+r8IUjI+xW+PcSvP3oceigk=;
        b=ne//xbDtYdz2c9K6K3qx/kaINQ/0tD8/JPij8ib2S8LiWLVNBoJ4tr03guyb1cB8gYCUSF
        mfhiJPUG00Tj6sDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove the pointless APIC version check
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834606.27769.3189122080648052558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     249ada2c821ff6819b5214d2f08d73aebde814eb
Gitweb:        https://git.kernel.org/tip/249ada2c821ff6819b5214d2f08d73aebde814eb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:46 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:19 -07:00

x86/apic: Remove the pointless APIC version check

This historical leftover is really uninteresting today. Whatever MPTABLE or
MADT delivers we only trust the hardware anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/mpspec.h |  2 +-
 arch/x86/kernel/acpi/boot.c   |  6 +-----
 arch/x86/kernel/apic/apic.c   | 19 ++++---------------
 arch/x86/kernel/devicetree.c  |  5 ++---
 arch/x86/kernel/jailhouse.c   |  6 ++----
 arch/x86/kernel/mpparse.c     |  2 +-
 arch/x86/kernel/smpboot.c     |  4 ++--
 7 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index fa5e24a..190d306 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -76,7 +76,7 @@ static inline void e820__memblock_alloc_reserved_mpc_new(void) { }
 #define default_get_smp_config x86_init_uint_noop
 #endif
 
-int generic_processor_info(int apicid, int version);
+int generic_processor_info(int apicid);
 
 #define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_LOCAL_APIC)
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 38a5298..cca1a07 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -169,7 +169,6 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
  */
 static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
 {
-	unsigned int ver = 0;
 	int cpu;
 
 	if (id >= MAX_LOCAL_APIC) {
@@ -182,10 +181,7 @@ static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
 		return -EINVAL;
 	}
 
-	if (boot_cpu_physical_apicid != -1U)
-		ver = boot_cpu_apic_version;
-
-	cpu = generic_processor_info(id, ver);
+	cpu = generic_processor_info(id);
 	if (cpu >= 0)
 		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpiid;
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b7ffae4..32275ca 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2428,19 +2428,8 @@ static int allocate_logical_cpuid(int apicid)
 	return nr_logical_cpuids++;
 }
 
-static void cpu_update_apic(int cpu, int apicid, int version)
+static void cpu_update_apic(int cpu, int apicid)
 {
-	if (version == 0x0) {
-		pr_warn("BIOS bug: APIC version is 0 for CPU %d/0x%x, fixing up to 0x10\n",
-			cpu, apicid);
-		version = 0x10;
-	}
-
-	if (version != boot_cpu_apic_version) {
-		pr_warn("BIOS bug: APIC version mismatch, boot CPU: %x, CPU %d: version %x\n",
-			boot_cpu_apic_version, cpu, version);
-	}
-
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif
@@ -2460,10 +2449,10 @@ static void cpu_update_apic(int cpu, int apicid, int version)
 static __init void cpu_set_boot_apic(void)
 {
 	cpuid_to_apicid[0] = boot_cpu_physical_apicid;
-	cpu_update_apic(0, boot_cpu_physical_apicid, boot_cpu_apic_version);
+	cpu_update_apic(0, boot_cpu_physical_apicid);
 }
 
-int generic_processor_info(int apicid, int version)
+int generic_processor_info(int apicid)
 {
 	int cpu, max = nr_cpu_ids;
 
@@ -2500,7 +2489,7 @@ int generic_processor_info(int apicid, int version)
 		return -EINVAL;
 	}
 
-	cpu_update_apic(cpu, apicid, version);
+	cpu_update_apic(cpu, apicid);
 	return cpu;
 }
 
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 28da5dd..56f6d59 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -128,16 +128,15 @@ static void __init dtb_setup_hpet(void)
 static void __init dtb_cpu_setup(void)
 {
 	struct device_node *dn;
-	u32 apic_id, version;
+	u32 apic_id;
 
-	version = GET_APIC_VERSION(apic_read(APIC_LVR));
 	for_each_of_cpu_node(dn) {
 		apic_id = of_get_cpu_hwid(dn, 0);
 		if (apic_id == ~0U) {
 			pr_warn("%pOF: missing local APIC ID\n", dn);
 			continue;
 		}
-		generic_processor_info(apic_id, version);
+		generic_processor_info(apic_id);
 	}
 }
 
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 4eb8f2d..578d16f 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -101,10 +101,8 @@ static void __init jailhouse_get_smp_config(unsigned int early)
 
 	register_lapic_address(0xfee00000);
 
-	for (cpu = 0; cpu < setup_data.v1.num_cpus; cpu++) {
-		generic_processor_info(setup_data.v1.cpu_ids[cpu],
-				       boot_cpu_apic_version);
-	}
+	for (cpu = 0; cpu < setup_data.v1.num_cpus; cpu++)
+		generic_processor_info(setup_data.v1.cpu_ids[cpu]);
 
 	smp_found_config = 1;
 
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fe9a7f6..82518c1 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -62,7 +62,7 @@ static void __init MP_processor_info(struct mpc_cpu *m)
 		bootup_cpu = " (Bootup-CPU)";
 
 	pr_info("Processor #%d%s\n", m->apicid, bootup_cpu);
-	generic_processor_info(apicid, m->apicver);
+	generic_processor_info(apicid);
 }
 
 #ifdef CONFIG_X86_IO_APIC
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a33fc50..5467c58 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1397,7 +1397,7 @@ __init void prefill_possible_map(void)
 {
 	int i, possible;
 
-	/* No boot processor was found in mptable or ACPI MADT */
+	/* No processor was found in mptable or ACPI MADT */
 	if (!num_processors) {
 		if (boot_cpu_has(X86_FEATURE_APIC)) {
 			int apicid = boot_cpu_physical_apicid;
@@ -1408,7 +1408,7 @@ __init void prefill_possible_map(void)
 			/* Make sure boot cpu is enumerated */
 			if (apic->cpu_present_to_apicid(0) == BAD_APICID &&
 			    apic->apic_id_valid(apicid))
-				generic_processor_info(apicid, boot_cpu_apic_version);
+				generic_processor_info(apicid);
 		}
 
 		if (!num_processors)
