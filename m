Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C99E7DA696
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 12:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjJ1KvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1KvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 06:51:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5F8C0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:51:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9cf83c044b7so353168266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698490259; x=1699095059; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ANDli5kQDoR/j+lmjIBnC0ydhQBYGGPV4rJ5b7voqgE=;
        b=WWp+bw74I29EC92SQJ4/ZAEzNRM7aZFaC1nkTPVDcHTtetZj7x+kIJlq4HZMQYFRlE
         FcyhNcN156twl4JmKd7mylIXvb2nZK0+DWUj6Qjfb3QHnr4ZXgvp8XTt+tIYW6TaZEVs
         6uBflSLVNl0hUWITs03NsqDqudx68hotkt/8sXo4qDmORd/R0gThNT/8LUBSlO4CfsUG
         xSkqbL1NqQxUPvNPQ5gU3Vp1YWv4CEP1SOv5RwWhCqKTz5XK1ervU5elZZxE8lhuKCFE
         dbyngVD7aI7i0DlC1KUZ9yoKuI5AZc17TAFqQ7GUR1z1I+zXbia28P5P4vo6nBFrXap1
         vJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698490259; x=1699095059;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANDli5kQDoR/j+lmjIBnC0ydhQBYGGPV4rJ5b7voqgE=;
        b=cS5v1bC9FrbVe7PYuVps5yaQkQ8i3g05KYULsN3oh5PkvO34dMOSo+SXSCnP3astHt
         UtiSJCUCCNKi5hvqyuYR9vJrmZy9G4nY2VSjOUhleRLBSyubZokBaqYz7s887TZoGBYG
         l93BH5/aEKfmEXyV/obIeDjBaSQe52eYcg2h4iV0+UbyVdJqHkCvuT/UTw+TAc1NjArp
         MBnVSbiX1qWZDXx+XxDajttmnnSjuMmYi/1t+qxjT2eGlZvZlD6v+JRocaIDIuPxyu7X
         vqknzhlfrJsiJvbmuNdEjCbDVVqRr4mFmV4FJayWP4LIAzuZQ8+sjxEOsZfpqaMi4uXD
         bIWg==
X-Gm-Message-State: AOJu0YykRBnlYFIcxp+RrR0hw6ogVaDaigNUUiZSGaI/ahIsW2wcOnQP
        NdOUbHdqPJ94stHmwOMPuK0=
X-Google-Smtp-Source: AGHT+IER5gCH0x3nc668uIHkTb1SdhDrKBHqGh2RO8mkyBVsu9wmcHV4eKmPTXHl4e1jJ/tWWXchSA==
X-Received: by 2002:a17:906:478e:b0:9b2:d78c:afe9 with SMTP id cw14-20020a170906478e00b009b2d78cafe9mr3815413ejc.49.1698490259143;
        Sat, 28 Oct 2023 03:50:59 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id dc17-20020a170906c7d100b0098e34446464sm2589628ejb.25.2023.10.28.03.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 03:50:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 28 Oct 2023 12:50:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZTznjz/o5IvAvPOY@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-28

   # HEAD: bd94d86f490b70c58b3fc5739328a53ad4b18d86 x86/tsc: Defer marking TSC unstable to a worker

Misc fixes:

 - Fix a possible CPU hotplug deadlock bug caused by the new
   TSC synchronization code.

 - Fix a legacy PIC discovery bug that results in device troubles on
   affected systems, such as non-working keybards, etc.

 - Add a new Intel CPU model number to <asm/intel-family.h>.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (2):
      x86/i8259: Skip probing when ACPI/MADT advertises PCAT compatibility
      x86/tsc: Defer marking TSC unstable to a worker

Tony Luck (1):
      x86/cpu: Add model number for Intel Arrow Lake mobile processor


 arch/x86/include/asm/i8259.h        |  2 ++
 arch/x86/include/asm/intel-family.h |  2 ++
 arch/x86/kernel/acpi/boot.c         |  3 +++
 arch/x86/kernel/i8259.c             | 38 +++++++++++++++++++++++++++++--------
 arch/x86/kernel/tsc_sync.c          | 10 +++++++++-
 5 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/i8259.h b/arch/x86/include/asm/i8259.h
index 637fa1df3512..c715097e92fd 100644
--- a/arch/x86/include/asm/i8259.h
+++ b/arch/x86/include/asm/i8259.h
@@ -69,6 +69,8 @@ struct legacy_pic {
 	void (*make_irq)(unsigned int irq);
 };
 
+void legacy_pic_pcat_compat(void);
+
 extern struct legacy_pic *legacy_pic;
 extern struct legacy_pic null_legacy_pic;
 
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5fcd85fd64fd..197316121f04 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -27,6 +27,7 @@
  *		_X	- regular server parts
  *		_D	- micro server parts
  *		_N,_P	- other mobile parts
+ *		_H	- premium mobile parts
  *		_S	- other client parts
  *
  *		Historical OPTDIFFs:
@@ -124,6 +125,7 @@
 #define INTEL_FAM6_METEORLAKE		0xAC
 #define INTEL_FAM6_METEORLAKE_L		0xAA
 
+#define INTEL_FAM6_ARROWLAKE_H		0xC5
 #define INTEL_FAM6_ARROWLAKE		0xC6
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2a0ea38955df..c55c0ef47a18 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -148,6 +148,9 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
 		pr_debug("Local APIC address 0x%08x\n", madt->address);
 	}
 
+	if (madt->flags & ACPI_MADT_PCAT_COMPAT)
+		legacy_pic_pcat_compat();
+
 	/* ACPI 6.3 and newer support the online capable bit. */
 	if (acpi_gbl_FADT.header.revision > 6 ||
 	    (acpi_gbl_FADT.header.revision == 6 &&
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 30a55207c000..c20d1832c481 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -32,6 +32,7 @@
  */
 static void init_8259A(int auto_eoi);
 
+static bool pcat_compat __ro_after_init;
 static int i8259A_auto_eoi;
 DEFINE_RAW_SPINLOCK(i8259A_lock);
 
@@ -299,15 +300,32 @@ static void unmask_8259A(void)
 
 static int probe_8259A(void)
 {
+	unsigned char new_val, probe_val = ~(1 << PIC_CASCADE_IR);
 	unsigned long flags;
-	unsigned char probe_val = ~(1 << PIC_CASCADE_IR);
-	unsigned char new_val;
+
 	/*
-	 * Check to see if we have a PIC.
-	 * Mask all except the cascade and read
-	 * back the value we just wrote. If we don't
-	 * have a PIC, we will read 0xff as opposed to the
-	 * value we wrote.
+	 * If MADT has the PCAT_COMPAT flag set, then do not bother probing
+	 * for the PIC. Some BIOSes leave the PIC uninitialized and probing
+	 * fails.
+	 *
+	 * Right now this causes problems as quite some code depends on
+	 * nr_legacy_irqs() > 0 or has_legacy_pic() == true. This is silly
+	 * when the system has an IO/APIC because then PIC is not required
+	 * at all, except for really old machines where the timer interrupt
+	 * must be routed through the PIC. So just pretend that the PIC is
+	 * there and let legacy_pic->init() initialize it for nothing.
+	 *
+	 * Alternatively this could just try to initialize the PIC and
+	 * repeat the probe, but for cases where there is no PIC that's
+	 * just pointless.
+	 */
+	if (pcat_compat)
+		return nr_legacy_irqs();
+
+	/*
+	 * Check to see if we have a PIC.  Mask all except the cascade and
+	 * read back the value we just wrote. If we don't have a PIC, we
+	 * will read 0xff as opposed to the value we wrote.
 	 */
 	raw_spin_lock_irqsave(&i8259A_lock, flags);
 
@@ -429,5 +447,9 @@ static int __init i8259A_init_ops(void)
 
 	return 0;
 }
-
 device_initcall(i8259A_init_ops);
+
+void __init legacy_pic_pcat_compat(void)
+{
+	pcat_compat = true;
+}
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index bbc440c93e08..1123ef3ccf90 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -15,6 +15,7 @@
  * ( The serial nature of the boot logic and the CPU hotplug lock
  *   protects against more than 2 CPUs entering this code. )
  */
+#include <linux/workqueue.h>
 #include <linux/topology.h>
 #include <linux/spinlock.h>
 #include <linux/kernel.h>
@@ -342,6 +343,13 @@ static inline unsigned int loop_timeout(int cpu)
 	return (cpumask_weight(topology_core_cpumask(cpu)) > 1) ? 2 : 20;
 }
 
+static void tsc_sync_mark_tsc_unstable(struct work_struct *work)
+{
+	mark_tsc_unstable("check_tsc_sync_source failed");
+}
+
+static DECLARE_WORK(tsc_sync_work, tsc_sync_mark_tsc_unstable);
+
 /*
  * The freshly booted CPU initiates this via an async SMP function call.
  */
@@ -395,7 +403,7 @@ static void check_tsc_sync_source(void *__cpu)
 			"turning off TSC clock.\n", max_warp);
 		if (random_warps)
 			pr_warn("TSC warped randomly between CPUs\n");
-		mark_tsc_unstable("check_tsc_sync_source failed");
+		schedule_work(&tsc_sync_work);
 	}
 
 	/*
