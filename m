Return-Path: <linux-kernel+bounces-68811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE1D8580A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A2128569F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426912FB0D;
	Fri, 16 Feb 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CnyTXgo3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Euuk8fxL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9BE1350D8;
	Fri, 16 Feb 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096627; cv=none; b=DMUjVxmMxdoRxkv2TUgP4K699hGpaJB0O2LBnzHwVA7wY/tYTBbQkcbwzQlr4AKYGyfkqOkCKOtL7QcL38OpvfcN5IRCwyba3NB52QNQQSCDv30ymqC/SvCgzNIPdRNDvG9A+ZcDSnKhv9UKAToOr4hPYEKqABebkU88hEyy+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096627; c=relaxed/simple;
	bh=IitY8G8n/RkqvgQ9VELSid8s+aPi1eVKxKbGDUtu/2M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k6j9CaF8/0bjf6uleh3W+XvA/QYfy6pAz/cwoc/cT0w08970wmYvuES7cNUGz4CoKXI8B8BA9waYi0YaoTNg/ytL6fBJOMorJYhy2gTOzo8fXqigRXSFcQ8snqeRoYMXMnIVkvbBFlJ4SkBAqfMcXC/ONbfiGo96kAN3UaTyyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CnyTXgo3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Euuk8fxL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkdZ5F8LC9ZFkpl1eya+O5soyvlsiTF9897MrUm11vA=;
	b=CnyTXgo3CHmJ1ls8WZIgBCDOPTdUnlfs1noSJ5bI8+cn3TBf/QaSQJ5h7WAGEYeElSgSSh
	1+XBSJsIejs9+X2Hdl28HaeJqi4phHntBjLdwvkJwpoQFW5CYCrCbqhq3Csj3FjdtslvRc
	oLUXQpRLO8uTOwiMihmvrROg/9izZ7T972WmM/L2+iDTnAnAzKCSjLbcR6XPmTmalU7fTT
	RbdbfQtxHZo5Gem/aK2+SiVXo/Y4Q/5CSWBdEbtlU7kC+wdd9lICdT9QEh5mBGiG1IlKZo
	Q1+NUuSFw9ielPaBfXZkSFYMKtlrBAtWcWPIqTiwSGfLePOoqbGLJ8+Ut55/tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkdZ5F8LC9ZFkpl1eya+O5soyvlsiTF9897MrUm11vA=;
	b=Euuk8fxLR2xULGX0Cxf2V7QoTgWE+ktZ9mRbPNRcWZ2tr/Df/rq9YVL9PlY3l3uAUHs92s
	liURtkyTN8hO6IDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Confine topology information
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210251.994756960@linutronix.de>
References: <20240213210251.994756960@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662288.398.16525230259695602703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     58aa34abe9954cd5dfbf322fc612146c5f45e52b
Gitweb:        https://git.kernel.org/tip/58aa34abe9954cd5dfbf322fc612146c5f45e52b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:42 +01:00

x86/cpu/topology: Confine topology information

Now that all external fiddling with num_processors and disabled_cpus is
gone, move the last user prefill_possible_map() into the topology code too
and remove the global visibility of these variables.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210251.994756960@linutronix.de



---
 arch/x86/include/asm/smp.h     |  3 +-
 arch/x86/kernel/apic/apic.c    |  1 +-
 arch/x86/kernel/cpu/topology.c | 76 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c      | 72 +-------------------------------
 4 files changed, 74 insertions(+), 78 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed..f1510d6 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -9,7 +9,6 @@
 #include <asm/thread_info.h>
 
 extern int smp_num_siblings;
-extern unsigned int num_processors;
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
@@ -174,8 +173,6 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 }
 #endif /* CONFIG_SMP */
 
-extern unsigned disabled_cpus;
-
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
 extern void nmi_selftest(void);
 #else
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 5814b80..a42d8a6 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2054,7 +2054,6 @@ void __init init_apic_mappings(void)
 			pr_info("APIC: disable apic facility\n");
 			apic_disable();
 		}
-		num_processors = 1;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 669e258..a6c9314 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -29,8 +29,8 @@ u32 cpuid_to_apicid[] __read_mostly = { [0 ... NR_CPUS - 1] = BAD_APICID, };
  */
 static u32 disabled_cpu_apicid __ro_after_init = BAD_APICID;
 
-unsigned int num_processors;
-unsigned disabled_cpus;
+static unsigned int num_processors;
+static unsigned int disabled_cpus;
 
 /*
  * The number of allocated logical CPU IDs. Since logical CPU IDs are allocated
@@ -174,6 +174,71 @@ static int generic_processor_info(int apicid)
 	return cpu;
 }
 
+static int __initdata setup_possible_cpus = -1;
+
+/*
+ * cpu_possible_mask should be static, it cannot change as cpu's
+ * are onlined, or offlined. The reason is per-cpu data-structures
+ * are allocated by some modules at init time, and don't expect to
+ * do this dynamically on cpu arrival/departure.
+ * cpu_present_mask on the other hand can change dynamically.
+ * In case when cpu_hotplug is not compiled, then we resort to current
+ * behaviour, which is cpu_possible == cpu_present.
+ * - Ashok Raj
+ *
+ * Three ways to find out the number of additional hotplug CPUs:
+ * - If the BIOS specified disabled CPUs in ACPI/mptables use that.
+ * - The user can overwrite it with possible_cpus=NUM
+ * - Otherwise don't reserve additional CPUs.
+ * We do this because additional CPUs waste a lot of memory.
+ * -AK
+ */
+__init void prefill_possible_map(void)
+{
+	int i, possible;
+
+	i = setup_max_cpus ?: 1;
+	if (setup_possible_cpus == -1) {
+		possible = num_processors;
+#ifdef CONFIG_HOTPLUG_CPU
+		if (setup_max_cpus)
+			possible += disabled_cpus;
+#else
+		if (possible > i)
+			possible = i;
+#endif
+	} else
+		possible = setup_possible_cpus;
+
+	total_cpus = max_t(int, possible, num_processors + disabled_cpus);
+
+	/* nr_cpu_ids could be reduced via nr_cpus= */
+	if (possible > nr_cpu_ids) {
+		pr_warn("%d Processors exceeds NR_CPUS limit of %u\n",
+			possible, nr_cpu_ids);
+		possible = nr_cpu_ids;
+	}
+
+#ifdef CONFIG_HOTPLUG_CPU
+	if (!setup_max_cpus)
+#endif
+	if (possible > i) {
+		pr_warn("%d Processors exceeds max_cpus limit of %u\n",
+			possible, setup_max_cpus);
+		possible = i;
+	}
+
+	set_nr_cpu_ids(possible);
+
+	pr_info("Allowing %d CPUs, %d hotplug CPUs\n",
+		possible, max_t(int, possible - num_processors, 0));
+
+	reset_cpu_possible_mask();
+
+	for (i = 0; i < possible; i++)
+		set_cpu_possible(i, true);
+}
+
 /**
  * topology_register_apic - Register an APIC in early topology maps
  * @apic_id:	The APIC ID to set up
@@ -251,6 +316,13 @@ void topology_hotunplug_apic(unsigned int cpu)
 }
 #endif
 
+static int __init _setup_possible_cpus(char *str)
+{
+	get_option(&str, &setup_possible_cpus);
+	return 0;
+}
+early_param("possible_cpus", _setup_possible_cpus);
+
 static int __init apic_set_disabled_cpu_apicid(char *arg)
 {
 	if (!arg || !get_option(&arg, &disabled_cpu_apicid))
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 000b856..bfb99b5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1291,78 +1291,6 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 	cache_aps_init();
 }
 
-static int __initdata setup_possible_cpus = -1;
-static int __init _setup_possible_cpus(char *str)
-{
-	get_option(&str, &setup_possible_cpus);
-	return 0;
-}
-early_param("possible_cpus", _setup_possible_cpus);
-
-
-/*
- * cpu_possible_mask should be static, it cannot change as cpu's
- * are onlined, or offlined. The reason is per-cpu data-structures
- * are allocated by some modules at init time, and don't expect to
- * do this dynamically on cpu arrival/departure.
- * cpu_present_mask on the other hand can change dynamically.
- * In case when cpu_hotplug is not compiled, then we resort to current
- * behaviour, which is cpu_possible == cpu_present.
- * - Ashok Raj
- *
- * Three ways to find out the number of additional hotplug CPUs:
- * - If the BIOS specified disabled CPUs in ACPI/mptables use that.
- * - The user can overwrite it with possible_cpus=NUM
- * - Otherwise don't reserve additional CPUs.
- * We do this because additional CPUs waste a lot of memory.
- * -AK
- */
-__init void prefill_possible_map(void)
-{
-	int i, possible;
-
-	i = setup_max_cpus ?: 1;
-	if (setup_possible_cpus == -1) {
-		possible = num_processors;
-#ifdef CONFIG_HOTPLUG_CPU
-		if (setup_max_cpus)
-			possible += disabled_cpus;
-#else
-		if (possible > i)
-			possible = i;
-#endif
-	} else
-		possible = setup_possible_cpus;
-
-	total_cpus = max_t(int, possible, num_processors + disabled_cpus);
-
-	/* nr_cpu_ids could be reduced via nr_cpus= */
-	if (possible > nr_cpu_ids) {
-		pr_warn("%d Processors exceeds NR_CPUS limit of %u\n",
-			possible, nr_cpu_ids);
-		possible = nr_cpu_ids;
-	}
-
-#ifdef CONFIG_HOTPLUG_CPU
-	if (!setup_max_cpus)
-#endif
-	if (possible > i) {
-		pr_warn("%d Processors exceeds max_cpus limit of %u\n",
-			possible, setup_max_cpus);
-		possible = i;
-	}
-
-	set_nr_cpu_ids(possible);
-
-	pr_info("Allowing %d CPUs, %d hotplug CPUs\n",
-		possible, max_t(int, possible - num_processors, 0));
-
-	reset_cpu_possible_mask();
-
-	for (i = 0; i < possible; i++)
-		set_cpu_possible(i, true);
-}
-
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {

