Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401807C7510
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441819AbjJLRuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379627AbjJLRuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:50:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B4CBB;
        Thu, 12 Oct 2023 10:50:18 -0700 (PDT)
Date:   Thu, 12 Oct 2023 17:50:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697133017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xoKlNZgjdrqPYu+DbG75XGlYO3OTTy8TALc2nVbhlaQ=;
        b=yrWl93Ox9a2k5CgXeTw6z0LqM0Cla9scqnZLOEuNvdZrsgz+glTkZ5hDkrFkeGDGpPnL2z
        yKgJstm/b7SMOLOFErd9LLo1Zz2Q2cuug7p+7821m5ETbaEWCF5N/gW2EAv4XJb7Br6udT
        IoVRo5ukUvzeEtcj2PJzIgGanCR1VdIDyspkvgwBMJVWKRAXe0vvqAtSh3pCb4jaeO8Ipb
        srTlFbUX5+pU2O5/BgdWJBRg6JHGoHO3vNgGjlJ43oAw0Cm0UW7OT6ZXv4I4xNJbLW7Wru
        6IutHwdo7KFHCoD7AgaXbhzIkH0DIc1rZNywfS4gqDofIkbCO1sQyVB6/4hGDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697133017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xoKlNZgjdrqPYu+DbG75XGlYO3OTTy8TALc2nVbhlaQ=;
        b=6oZUi3lQccefEf3BXBEk+9rchc1oqaC9Ad6vTUoUGIzwOSJengBUDx2hIhlUzXlNkOaW+A
        3KrKiWd85JdSdmBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Rename 'DIE' domain to 'PKG'
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
References: <20230712141056.GI3100107@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169713301636.3135.8978091401376991190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f577cd57bfaa889cf0718e30e92c08c7f78c9d85
Gitweb:        https://git.kernel.org/tip/f577cd57bfaa889cf0718e30e92c08c7f78c9d85
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 12 Jul 2023 16:10:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Oct 2023 09:38:16 +02:00

sched/topology: Rename 'DIE' domain to 'PKG'

While reworking the x86 topology code Thomas tripped over creating a 'DIE' domain
for the package mask. :-)

Since these names are CONFIG_SCHED_DEBUG=y only, rename them to make the
name less ambiguous.

[ Shrikanth Hegde: rename on s390 as well. ]
[ Valentin Schneider: also rename it in the comments. ]
[ mingo: port to recent kernels & find all remaining occurances. ]

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Valentin Schneider <vschneid@redhat.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230712141056.GI3100107@hirez.programming.kicks-ass.net
---
 arch/powerpc/kernel/smp.c   | 4 ++--
 arch/s390/kernel/topology.c | 2 +-
 arch/x86/kernel/smpboot.c   | 4 ++--
 kernel/sched/fair.c         | 2 +-
 kernel/sched/topology.c     | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5826f51..4e48700 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1051,7 +1051,7 @@ static struct sched_domain_topology_level powerpc_topology[] = {
 #endif
 	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
 	{ cpu_mc_mask, SD_INIT_NAME(MC) },
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
 	{ NULL, },
 };
 
@@ -1595,7 +1595,7 @@ static void add_cpu_to_masks(int cpu)
 	/* Skip all CPUs already part of current CPU core mask */
 	cpumask_andnot(mask, cpu_online_mask, cpu_core_mask(cpu));
 
-	/* If chip_id is -1; limit the cpu_core_mask to within DIE*/
+	/* If chip_id is -1; limit the cpu_core_mask to within PKG */
 	if (chip_id == -1)
 		cpumask_and(mask, mask, cpu_cpu_mask(cpu));
 
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 68adf1d..66bda6a 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -522,7 +522,7 @@ static struct sched_domain_topology_level s390_topology[] = {
 	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
 	{ cpu_book_mask, SD_INIT_NAME(BOOK) },
 	{ cpu_drawer_mask, SD_INIT_NAME(DRAWER) },
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
 	{ NULL, },
 };
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 02765d9..e3b3e80 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -641,13 +641,13 @@ static void __init build_sched_topology(void)
 	};
 #endif
 	/*
-	 * When there is NUMA topology inside the package skip the DIE domain
+	 * When there is NUMA topology inside the package skip the PKG domain
 	 * since the NUMA domains will auto-magically create the right spanning
 	 * domains based on the SLIT.
 	 */
 	if (!x86_has_numa_in_package) {
 		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(DIE)
+			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(PKG)
 		};
 	}
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9229051..a751e55 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9555,7 +9555,7 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
  * imbalances in the number of CPUS are dealt with in find_busiest_group().
  *
- * If we are balancing load within an SMT core, or at DIE domain level, always
+ * If we are balancing load within an SMT core, or at PKG domain level, always
  * proceed.
  *
  * Return: true if @env::dst_cpu can do with asym_packing load balance. False
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d950861..a63729f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1119,7 +1119,7 @@ fail:
  *
  *  - Simultaneous multithreading (SMT)
  *  - Multi-Core Cache (MC)
- *  - Package (DIE)
+ *  - Package (PKG)
  *
  * Where the last one more or less denotes everything up to a NUMA node.
  *
@@ -1141,13 +1141,13 @@ fail:
  *
  * CPU   0   1   2   3   4   5   6   7
  *
- * DIE  [                             ]
+ * PKG  [                             ]
  * MC   [             ] [             ]
  * SMT  [     ] [     ] [     ] [     ]
  *
  *  - or -
  *
- * DIE  0-7 0-7 0-7 0-7 0-7 0-7 0-7 0-7
+ * PKG  0-7 0-7 0-7 0-7 0-7 0-7 0-7 0-7
  * MC	0-3 0-3 0-3 0-3 4-7 4-7 4-7 4-7
  * SMT  0-1 0-1 2-3 2-3 4-5 4-5 6-7 6-7
  *
@@ -1681,7 +1681,7 @@ static struct sched_domain_topology_level default_topology[] = {
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
 #endif
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
 	{ NULL, },
 };
 
