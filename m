Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09E67665EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjG1H6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbjG1H55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:57:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2C4173F;
        Fri, 28 Jul 2023 00:57:56 -0700 (PDT)
Date:   Fri, 28 Jul 2023 07:57:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690531074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVvxUXWn/TUtSBpKuX4qV5akrpnLYTnw5GQvQ+pw/2M=;
        b=wZwB09rvqV6Xvwti8DrLJqeTT1zSYF+qJUBIpwUCH9zo8hiAD6gAiLyT43Rj75rDHCor9K
        r+qyY3b4R+LVGXV4e7E6GJMSHjoouVKRvZLAO7liIHvnRp7OT5XQ5zkP7ruUsrbAYGMfpI
        Q4RN6AMaGSj/QeAUHRazTjh4cvPTGulni+E3a5bYL4q+fmseCGvPqRr6Uqa8BuBu/c0Fn8
        aLfxLL4Z1n5zXUHKGBQXHOX+HDTKYS+J2x6RN/JrPeGI4VqslrGbX2gvsy+EUQU7dWtInS
        j8WfpqaRFp34Zm731l4/ZOhEBRyTEhjn8TP4C9iY3tUD/mKbWaKkcKy5ZDU0ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690531074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVvxUXWn/TUtSBpKuX4qV5akrpnLYTnw5GQvQ+pw/2M=;
        b=ufcRcceQ4HuhEku4E7Mvb2/0ZMUPgHnta3QZHWP2udbQi8yx93cGY1/x93mClxh2YKHJS7
        5GnukH1Abqz2eqDg==
From:   "tip-bot2 for Laurent Dufour" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/SMT: Remove topology_smt_supported()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230705145143.40545-6-ldufour@linux.ibm.com>
References: <20230705145143.40545-6-ldufour@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <169053107408.28540.17386853558326393812.tip-bot2@tip-bot2>
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

Commit-ID:     91b4a7dbfe05ddb6fd3cf78cc11fb5ed64d3af90
Gitweb:        https://git.kernel.org/tip/91b4a7dbfe05ddb6fd3cf78cc11fb5ed64d3af90
Author:        Laurent Dufour <ldufour@linux.ibm.com>
AuthorDate:    Wed, 05 Jul 2023 16:51:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 28 Jul 2023 09:53:37 +02:00

cpu/SMT: Remove topology_smt_supported()

Since the maximum number of threads is now passed to cpu_smt_set_num_threads(),
checking that value is enough to know whether SMT is supported.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230705145143.40545-6-ldufour@linux.ibm.com

---
 arch/x86/include/asm/topology.h | 2 --
 arch/x86/kernel/smpboot.c       | 8 --------
 kernel/cpu.c                    | 4 ++--
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index ae49ed4..3235ba1 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -141,7 +141,6 @@ static inline int topology_max_smt_threads(void)
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
 int topology_update_die_map(unsigned int dieid, unsigned int cpu);
 int topology_phys_to_logical_pkg(unsigned int pkg);
-bool topology_smt_supported(void);
 
 extern struct cpumask __cpu_primary_thread_mask;
 #define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thread_mask)
@@ -164,7 +163,6 @@ static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
-static inline bool topology_smt_supported(void) { return false; }
 #endif /* !CONFIG_SMP */
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e1aa2cd..d4e897b 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -327,14 +327,6 @@ static void notrace start_secondary(void *unused)
 }
 
 /**
- * topology_smt_supported - Check whether SMT is supported by the CPUs
- */
-bool topology_smt_supported(void)
-{
-	return smp_num_siblings > 1;
-}
-
-/**
  * topology_phys_to_logical_pkg - Map a physical package id to a logical
  * @phys_pkg:	The physical package id to map
  *
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d7dd535..70add05 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -621,7 +621,7 @@ void __init cpu_smt_set_num_threads(unsigned int num_threads,
 {
 	WARN_ON(!num_threads || (num_threads > max_threads));
 
-	if (!topology_smt_supported())
+	if (max_threads == 1)
 		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
 
 	cpu_smt_max_threads = max_threads;
@@ -1801,7 +1801,7 @@ early_param("cpuhp.parallel", parallel_bringup_parse_param);
 
 static inline bool cpuhp_smt_aware(void)
 {
-	return topology_smt_supported();
+	return cpu_smt_max_threads > 1;
 }
 
 static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
