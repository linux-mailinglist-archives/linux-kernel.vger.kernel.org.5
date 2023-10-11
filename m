Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412417C5408
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjJKMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjJKMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:34:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA71D98;
        Wed, 11 Oct 2023 05:34:37 -0700 (PDT)
Date:   Wed, 11 Oct 2023 12:34:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697027676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lRLz5u7rlrapgnDTjt3gDSupwa+PRH+Rw4WNxZmPyb0=;
        b=n4QIALyduIPB0kM7M3PRjriO1TAVy74sewCk4A4ETc2hHgTmEcyC1J7avZJ01NxM/Qvi7e
        bxxnCg1QP26BET9dQN9VJsMuHPYXry+MvXGAaq94f+d6UjzGgmLmb3E2ZkacxQkOnIXo/A
        KMVnsK1XjJDGkXWI19Fg2Q3zi1w5JOvPBZcg9b+6//le3OioYh/JxAYJH4evUVHNXlT4ZX
        CfrLdEAeRbps1Pas6uRMlX1vmsje/XyhP5UnwDS4MXa9aSjdPwPblsNsNhak/76eL0Ui9p
        Dbc+s2eY8a9mZx7xeqqwEQ1l519L1vTH3JIm0JYT+S9VoWsNuI8nWRaS97Fwqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697027676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lRLz5u7rlrapgnDTjt3gDSupwa+PRH+Rw4WNxZmPyb0=;
        b=WiuildRm7y+0w0UUy4xm6Jab8uTEDXZvt9ZMJ82ds0BNHaMNc0EvhQDaRmoSdeTKRHylPR
        262tShZ5j7Rn4CCA==
From:   "tip-bot2 for Russell King (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] cpu-hotplug: Provide prototypes for arch CPU registration
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
References: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Message-ID: <169702767511.3135.14022878103064178933.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     c4dd854f740c21ae8dd9903fc67969c5497cb14b
Gitweb:        https://git.kernel.org/tip/c4dd854f740c21ae8dd9903fc67969c5497cb14b
Author:        Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
AuthorDate:    Mon, 25 Sep 2023 17:28:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Oct 2023 14:27:37 +02:00

cpu-hotplug: Provide prototypes for arch CPU registration

Provide common prototypes for arch_register_cpu() and
arch_unregister_cpu(). These are called by acpi_processor.c, with weak
versions, so the prototype for this is already set. It is generally not
necessary for function prototypes to be conditional on preprocessor macros.

Some architectures (e.g. Loongarch) are missing the prototype for this, and
rather than add it to Loongarch's asm/cpu.h, do the job once for everyone.

Since this covers everyone, remove the now unnecessary prototypes in
asm/cpu.h, and therefore remove the 'static' from one of ia64's
arch_register_cpu() definitions.

[ tglx: Bring back the ia64 part and remove the ACPI prototypes ]

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk

---
 arch/ia64/include/asm/cpu.h   | 5 -----
 arch/ia64/kernel/topology.c   | 2 +-
 arch/x86/include/asm/cpu.h    | 2 --
 arch/x86/kernel/topology.c    | 2 +-
 drivers/acpi/acpi_processor.c | 1 +
 include/acpi/processor.h      | 5 -----
 include/linux/cpu.h           | 2 ++
 7 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
index db125df..642d716 100644
--- a/arch/ia64/include/asm/cpu.h
+++ b/arch/ia64/include/asm/cpu.h
@@ -15,9 +15,4 @@ DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
 
 DECLARE_PER_CPU(int, cpu_state);
 
-#ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
-extern void arch_unregister_cpu(int);
-#endif
-
 #endif /* _ASM_IA64_CPU_H_ */
diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
index 94a848b..741863a 100644
--- a/arch/ia64/kernel/topology.c
+++ b/arch/ia64/kernel/topology.c
@@ -59,7 +59,7 @@ void __ref arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(arch_unregister_cpu);
 #else
-static int __init arch_register_cpu(int num)
+int __init arch_register_cpu(int num)
 {
 	return register_cpu(&sysfs_cpus[num].cpu, num);
 }
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 3a233eb..25050d9 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -28,8 +28,6 @@ struct x86_cpu {
 };
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
-extern void arch_unregister_cpu(int);
 extern void soft_restart_cpu(void);
 #endif
 
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index ca004e2..0bab031 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -54,7 +54,7 @@ void arch_unregister_cpu(int num)
 EXPORT_SYMBOL(arch_unregister_cpu);
 #else /* CONFIG_HOTPLUG_CPU */
 
-static int __init arch_register_cpu(int num)
+int __init arch_register_cpu(int num)
 {
 	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
 }
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index c711db8..0f5218e 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) "ACPI: " fmt
 
 #include <linux/acpi.h>
+#include <linux/cpu.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/kernel.h>
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 94181fe..3f34ebb 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -465,9 +465,4 @@ extern int acpi_processor_ffh_lpi_probe(unsigned int cpu);
 extern int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
 #endif
 
-#ifdef CONFIG_ACPI_HOTPLUG_CPU
-extern int arch_register_cpu(int cpu);
-extern void arch_unregister_cpu(int cpu);
-#endif
-
 #endif
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 0abd60a..eb768a8 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -80,6 +80,8 @@ extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
 				 const struct attribute_group **groups,
 				 const char *fmt, ...);
+extern int arch_register_cpu(int cpu);
+extern void arch_unregister_cpu(int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
 extern ssize_t arch_cpu_probe(const char *, size_t);
