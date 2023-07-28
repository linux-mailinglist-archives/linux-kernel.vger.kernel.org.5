Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1707665F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjG1H6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjG1H6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:58:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ED135A0;
        Fri, 28 Jul 2023 00:57:58 -0700 (PDT)
Date:   Fri, 28 Jul 2023 07:57:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690531075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gWSLXCy4of2Obd0KdbLgy6MwVfgLmfmLKJL7BqXty4=;
        b=x3YuUxb7qaToAxIQ8gwDu6R1CN2UDnwOxPSXZW4hNUXKGoDWYiq7anf5mfU1jKlNforkrq
        SUcPihHVpsJz531oSf8CO7198WJYlxxN8whp6RtVvVLnsKdgtKhQVjhVM2LKHrFTvwcos0
        5rbiyfUgCqgoqINXFQJ0neNilo9PxkD98jECywc5tjRzQKBldPJ3CLFqTS4dL/D4N+aJm0
        cYAxxtfhn/2o3J/t05t5gujUtMauQE2DaxRCZ4apfkD8skNcHVU8dIsvojQtH8Oimdv4q8
        hAspDC47QgfsaFtJQuE7b6CVPLw9c46toOuAwTiQk1sRBYE7iA9KkOobtuGqEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690531075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5gWSLXCy4of2Obd0KdbLgy6MwVfgLmfmLKJL7BqXty4=;
        b=sGWBYJKHHXLGO7BPQud/fRbd0IUO9my1YIAJkmNNt9bzvbRoKGTbWrrnRYlPgYXiu4bNc5
        O4Y1EQl5D2q/8FBg==
From:   "tip-bot2 for Michael Ellerman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/SMT: Move SMT prototypes into cpu_smt.h
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230705145143.40545-3-ldufour@linux.ibm.com>
References: <20230705145143.40545-3-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <169053107521.28540.11891274511415221088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     3f9169196be55590a794b52f49637561ddd1ba4f
Gitweb:        https://git.kernel.org/tip/3f9169196be55590a794b52f49637561ddd1ba4f
Author:        Michael Ellerman <mpe@ellerman.id.au>
AuthorDate:    Wed, 05 Jul 2023 16:51:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 28 Jul 2023 09:53:36 +02:00

cpu/SMT: Move SMT prototypes into cpu_smt.h

In order to export the cpuhp_smt_control enum as part of the interface
between generic and architecture code, the architecture code needs to
include asm/topology.h.

But that leads to circular header dependencies. So split the enum and
related declarations into a separate header.

[ ldufour: Reworded the commit's description ]

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230705145143.40545-3-ldufour@linux.ibm.com

---
 arch/x86/include/asm/topology.h |  2 ++
 include/linux/cpu.h             | 25 +------------------------
 include/linux/cpu_smt.h         | 29 +++++++++++++++++++++++++++++
 kernel/cpu.c                    |  1 +
 4 files changed, 33 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/cpu_smt.h

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index caf41c4..ae49ed4 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -136,6 +136,8 @@ static inline int topology_max_smt_threads(void)
 	return __max_smt_threads;
 }
 
+#include <linux/cpu_smt.h>
+
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6e6e57e..6b326a9 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -18,6 +18,7 @@
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
 #include <linux/cpuhotplug.h>
+#include <linux/cpu_smt.h>
 
 struct device;
 struct device_node;
@@ -204,30 +205,6 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
-enum cpuhp_smt_control {
-	CPU_SMT_ENABLED,
-	CPU_SMT_DISABLED,
-	CPU_SMT_FORCE_DISABLED,
-	CPU_SMT_NOT_SUPPORTED,
-	CPU_SMT_NOT_IMPLEMENTED,
-};
-
-#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
-extern enum cpuhp_smt_control cpu_smt_control;
-extern void cpu_smt_disable(bool force);
-extern void cpu_smt_check_topology(void);
-extern bool cpu_smt_possible(void);
-extern int cpuhp_smt_enable(void);
-extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
-#else
-# define cpu_smt_control		(CPU_SMT_NOT_IMPLEMENTED)
-static inline void cpu_smt_disable(bool force) { }
-static inline void cpu_smt_check_topology(void) { }
-static inline bool cpu_smt_possible(void) { return false; }
-static inline int cpuhp_smt_enable(void) { return 0; }
-static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0; }
-#endif
-
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
 
diff --git a/include/linux/cpu_smt.h b/include/linux/cpu_smt.h
new file mode 100644
index 0000000..722c2e3
--- /dev/null
+++ b/include/linux/cpu_smt.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CPU_SMT_H_
+#define _LINUX_CPU_SMT_H_
+
+enum cpuhp_smt_control {
+	CPU_SMT_ENABLED,
+	CPU_SMT_DISABLED,
+	CPU_SMT_FORCE_DISABLED,
+	CPU_SMT_NOT_SUPPORTED,
+	CPU_SMT_NOT_IMPLEMENTED,
+};
+
+#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
+extern enum cpuhp_smt_control cpu_smt_control;
+extern void cpu_smt_disable(bool force);
+extern void cpu_smt_check_topology(void);
+extern bool cpu_smt_possible(void);
+extern int cpuhp_smt_enable(void);
+extern int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval);
+#else
+# define cpu_smt_control               (CPU_SMT_NOT_IMPLEMENTED)
+static inline void cpu_smt_disable(bool force) { }
+static inline void cpu_smt_check_topology(void) { }
+static inline bool cpu_smt_possible(void) { return false; }
+static inline int cpuhp_smt_enable(void) { return 0; }
+static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0; }
+#endif
+
+#endif /* _LINUX_CPU_SMT_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 03309f2..e02204c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -592,6 +592,7 @@ static void lockdep_release_cpus_lock(void)
 void __weak arch_smt_update(void) { }
 
 #ifdef CONFIG_HOTPLUG_SMT
+
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 
 void __init cpu_smt_disable(bool force)
