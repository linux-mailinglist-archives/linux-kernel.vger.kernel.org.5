Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C57A36EB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjIQRk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbjIQRj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:39:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0F4133
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:39:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so3600952f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694972356; x=1695577156; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rjVgYDkcGJHaTJGuxffjuQtYb6/8W9LL97TfZMfJOLE=;
        b=SZTc8RoujDc2n1Oi9xmrWOQ73iiZG03vC2GefoiWyj4W1BGmSJUdw/YsK0HqmOkVwU
         M7YM+B1Kna9hVRquBJPq93mx2SS696GLL8/9qrjq5JCq7RgDSfZbF8q/ZkVRlbOmO+IH
         20qKaprWoVBMVekfPW9cb03UVV//GpbC0/SoawU+tKTwVCB3I+t9zROvfC0SVK2aQgYB
         9RWIuEpytYmf0DiQifNGMFU3SM8tXIeCOAH4LZKt4r1CouSguVg2QrTVetAjrjWfcSUd
         R0TCPJCQOu43t4VrH10BV0M29M+IsdrVvw4xF084EU1Zn4jg9CfyxvjdsJihMcN0xmMd
         y8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694972356; x=1695577156;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjVgYDkcGJHaTJGuxffjuQtYb6/8W9LL97TfZMfJOLE=;
        b=LXA3RKcoN7hK5Zq/rZzwmFQeZdI4LTbiem2qf+2+gSJt73nqxZG8CvRp1y6rL6gNNt
         JI8XD3oGzVTG/56sD1LkH59EZvI0Qd2+sVh1pPc0xjDRR2j5i+PrhGtK6VcSAa5+PP2Z
         sjPnUT27EC25WE9FQPxZz13rwLzW5e0tBHh29M6cXKbPmWeU/CE/nB8jMX1+/Bio9jcg
         BL7g1m0qtPP50MxwrlrUymR++NQ7BegErQWec8/knBIReMwvaGDwSQxNyIlE4KlnrKVu
         T6EWeBivH4+RjipR+CuO7NVyuXFEXpOhEwf3I2JKu6WOpDp3+EnGs/s7Bwus7ovUeItF
         ukug==
X-Gm-Message-State: AOJu0YwdaXj3ZXhQvwQg2DwiZR+75zANzpg8YQI5mV1pB8HtdunxVSoE
        S2j3SAQwbOAIxySsiT1MgT8=
X-Google-Smtp-Source: AGHT+IEXFgDSjc1+0/puOvTlQD8dxFlQFTK8Cg0h2JLQ0a8G0oXMYaReAOF383KpEWqnqofxDtN0pA==
X-Received: by 2002:a5d:4a4d:0:b0:317:597b:9f92 with SMTP id v13-20020a5d4a4d000000b00317597b9f92mr5388410wrs.57.1694972355808;
        Sun, 17 Sep 2023 10:39:15 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id j21-20020adfd215000000b003179d7ed4f3sm6862106wrh.12.2023.09.17.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 10:39:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 17 Sep 2023 19:39:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <ZQc5wbfmwslRp8yM@gmail.com>
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

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-09-17

   # HEAD: 108af4b4bd3813610701379a58538e3339b162e4 x86/sched: Restore the SD_ASYM_PACKING flag in the DIE domain

Fix a performance regression on large SMT systems, an Intel SMT4
balancing bug, and a topology setup bug on (Intel) hybrid processors.

 Thanks,

	Ingo

------------------>
Ricardo Neri (1):
      x86/sched: Restore the SD_ASYM_PACKING flag in the DIE domain

Shrikanth Hegde (1):
      sched/fair: Optimize should_we_balance() for large SMT systems

Tim Chen (1):
      sched/fair: Fix SMT4 group_smt_balance handling


 arch/x86/kernel/smpboot.c | 12 +++++++++---
 kernel/sched/fair.c       | 27 +++++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index d40ed3a7dc23..266d05e22ac3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -579,7 +579,6 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 }
 
 
-#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
 	return sysctl_sched_itmt_enabled ? SD_ASYM_PACKING : 0;
@@ -603,7 +602,14 @@ static int x86_cluster_flags(void)
 	return cpu_cluster_flags() | x86_sched_itmt_flags();
 }
 #endif
-#endif
+
+static int x86_die_flags(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+	       return x86_sched_itmt_flags();
+
+	return 0;
+}
 
 /*
  * Set if a package/die has multiple NUMA nodes inside.
@@ -640,7 +646,7 @@ static void __init build_sched_topology(void)
 	 */
 	if (!x86_has_numa_in_package) {
 		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, SD_INIT_NAME(DIE)
+			cpu_cpu_mask, x86_die_flags, SD_INIT_NAME(DIE)
 		};
 	}
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8dbff6e7ad4f..cb225921bbca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6619,6 +6619,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 /* Working cpumask for: load_balance, load_balance_newidle. */
 static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
 static DEFINE_PER_CPU(cpumask_var_t, select_rq_mask);
+static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
 
 #ifdef CONFIG_NO_HZ_COMMON
 
@@ -9579,7 +9580,7 @@ static inline long sibling_imbalance(struct lb_env *env,
 	imbalance /= ncores_local + ncores_busiest;
 
 	/* Take advantage of resource in an empty sched group */
-	if (imbalance == 0 && local->sum_nr_running == 0 &&
+	if (imbalance <= 1 && local->sum_nr_running == 0 &&
 	    busiest->sum_nr_running > 1)
 		imbalance = 2;
 
@@ -9767,6 +9768,15 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		break;
 
 	case group_smt_balance:
+		/*
+		 * Check if we have spare CPUs on either SMT group to
+		 * choose has spare or fully busy handling.
+		 */
+		if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0)
+			goto has_spare;
+
+		fallthrough;
+
 	case group_fully_busy:
 		/*
 		 * Select the fully busy group with highest avg_load. In
@@ -9806,6 +9816,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 			else
 				return true;
 		}
+has_spare:
 
 		/*
 		 * Select not overloaded group with lowest number of idle cpus
@@ -10917,6 +10928,7 @@ static int active_load_balance_cpu_stop(void *data);
 
 static int should_we_balance(struct lb_env *env)
 {
+	struct cpumask *swb_cpus = this_cpu_cpumask_var_ptr(should_we_balance_tmpmask);
 	struct sched_group *sg = env->sd->groups;
 	int cpu, idle_smt = -1;
 
@@ -10940,8 +10952,9 @@ static int should_we_balance(struct lb_env *env)
 		return 1;
 	}
 
+	cpumask_copy(swb_cpus, group_balance_mask(sg));
 	/* Try to find first idle CPU */
-	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
+	for_each_cpu_and(cpu, swb_cpus, env->cpus) {
 		if (!idle_cpu(cpu))
 			continue;
 
@@ -10953,6 +10966,14 @@ static int should_we_balance(struct lb_env *env)
 		if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
 			if (idle_smt == -1)
 				idle_smt = cpu;
+			/*
+			 * If the core is not idle, and first SMT sibling which is
+			 * idle has been found, then its not needed to check other
+			 * SMT siblings for idleness:
+			 */
+#ifdef CONFIG_SCHED_SMT
+			cpumask_andnot(swb_cpus, swb_cpus, cpu_smt_mask(cpu));
+#endif
 			continue;
 		}
 
@@ -12918,6 +12939,8 @@ __init void init_sched_fair_class(void)
 	for_each_possible_cpu(i) {
 		zalloc_cpumask_var_node(&per_cpu(load_balance_mask, i), GFP_KERNEL, cpu_to_node(i));
 		zalloc_cpumask_var_node(&per_cpu(select_rq_mask,    i), GFP_KERNEL, cpu_to_node(i));
+		zalloc_cpumask_var_node(&per_cpu(should_we_balance_tmpmask, i),
+					GFP_KERNEL, cpu_to_node(i));
 
 #ifdef CONFIG_CFS_BANDWIDTH
 		INIT_CSD(&cpu_rq(i)->cfsb_csd, __cfsb_csd_unthrottle, cpu_rq(i));
