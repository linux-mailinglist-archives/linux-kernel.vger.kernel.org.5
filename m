Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D47B3759
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjI2PyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjI2PyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:54:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39438195;
        Fri, 29 Sep 2023 08:54:13 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TFluf5024690;
        Fri, 29 Sep 2023 15:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tou9JDepNKER24jEFjelxgOmoauG7gMvSM4jJkk+5/w=;
 b=QEHJCd2ueO4yPpcjOwuTSt6nSfP0M3xw7bq5MlK5+fGSBliV9Pt6YC/Wz5mrPm0+lJJV
 xvMY+reTKgENU51W11fgPOK8yHawSrc8hS6Y6eSWE8lUHoq1IL8w2dQpjTSOs9Q2PFh9
 Hd8lnVIO/O78KfEhRGgjrrxxL4elPWSZFMzE9d3a64FovuhSUtvFyIMUWs7Xl/EACJmA
 VRGlDsq5iLSkZQ569fF5v+viFYyGhuJwQ6ds2oxptDJePlJKhfTAwYAAMyA22ZkhTwFO
 OhXy+xoi87CMDWS3vQd0gh7x/d+UDeh4zGvOF1BFkNE9VvlBADkppcEFxtiQkiYH+PRE 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3te09utfn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:53:50 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TFXcWJ020640;
        Fri, 29 Sep 2023 15:53:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3te09utfma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:53:49 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TDRd93030392;
        Fri, 29 Sep 2023 15:53:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad22d7p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:53:47 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TFrj5l13238910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 15:53:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5B0020043;
        Fri, 29 Sep 2023 15:53:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE0A820040;
        Fri, 29 Sep 2023 15:53:40 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.6.110])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 15:53:40 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        qperret@google.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com, lukasz.luba@arm.com,
        linux-doc@vger.kernel.org, bsegall@google.com, linux-eng@arm.com
Subject: [PATCH v5 1/2] sched/topology: Remove EM_MAX_COMPLEXITY limit
Date:   Fri, 29 Sep 2023 21:22:08 +0530
Message-Id: <20230929155209.667764-2-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230929155209.667764-1-sshegde@linux.vnet.ibm.com>
References: <20230929155209.667764-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: auAb-659wjVaCut74BsmO6kKcG2LAp6T
X-Proofpoint-ORIG-GUID: DSMsGcphK1c4wunnMXHSMWIiO7Wjo2ya
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_13,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Gondois <Pierre.Gondois@arm.com>

The Energy Aware Scheduler (EAS) estimates the energy consumption
of placing a task on different CPUs. The goal is to minimize this
energy consumption. Estimating the energy of different task placements
is increasingly complex with the size of the platform. To avoid having
a slow wake-up path, EAS is only enabled if this complexity is low
enough.

The current complexity limit was set in:
commit b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate
platforms").
base on the first implementation of EAS, which was re-computing
the power of the whole platform for each task placement scenario, cf:
commit 390031e4c309 ("sched/fair: Introduce an energy estimation helper
function").
but the complexity of EAS was reduced in:
commit eb92692b2544d ("sched/fair: Speed-up energy-aware wake-ups")
and find_energy_efficient_cpu() (feec) algorithm was updated in:
commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective
utilization in feec()")

find_energy_efficient_cpu() (feec) is now doing:
feec()
\_ for_each_pd(pd) [0]
  // get max_spare_cap_cpu and compute_prev_delta
  \_ for_each_cpu(pd) [1]

  \_ eenv_pd_busy_time(pd) [2]
	\_ for_each_cpu(pd)

  // compute_energy(pd) without the task
  \_ eenv_pd_max_util(pd, -1) [3.0]
    \_ for_each_cpu(pd)
  \_ em_cpu_energy(pd, -1)
    \_ for_each_ps(pd)

  // compute_energy(pd) with the task on prev_cpu
  \_ eenv_pd_max_util(pd, prev_cpu) [3.1]
    \_ for_each_cpu(pd)
  \_ em_cpu_energy(pd, prev_cpu)
    \_ for_each_ps(pd)

  // compute_energy(pd) with the task on max_spare_cap_cpu
  \_ eenv_pd_max_util(pd, max_spare_cap_cpu) [3.2]
    \_ for_each_cpu(pd)
  \_ em_cpu_energy(pd, max_spare_cap_cpu)
    \_ for_each_ps(pd)

[3.1] happens only once since prev_cpu is unique. With the same
definitions for nr_pd, nr_cpus and nr_ps, the complexity is of:
nr_pd * (2 * [nr_cpus in pd] + 2 * ([nr_cpus in pd] + [nr_ps in pd]))
+ ([nr_cpus in pd] + [nr_ps in pd])

 [0]  * (     [1] + [2]      +       [3.0] + [3.2]                  )
+ [3.1]

= nr_pd * (4 * [nr_cpus in pd] + 2 * [nr_ps in pd])
+ [nr_cpus in prev pd] + nr_ps

The complexity limit was set to 2048 in:
commit b68a4c0dba3b1 ("sched/topology: Disable EAS on inappropriate
platforms")
to make "EAS usable up to 16 CPUs with per-CPU DVFS and less than 8
performance states each". For the same platform, the complexity would
actually be of:
16 * (4 + 2 * 7) + 1 + 7 = 296

Since the EAS complexity was greatly reduced, bigger platforms can
handle EAS. For instance, a platform with 112 CPUs with 7 performance
states each would not reach it:
112 * (4 + 2 * 7) + 1 + 7 = 2024

To reflect this improvement, remove the EAS complexity check.
Note that a limit on the number of CPUs still holds against
EM_MAX_NUM_CPUS to avoid overflows during the energy estimation.

Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 Documentation/scheduler/sched-energy.rst | 29 ++----------------
 kernel/sched/topology.c                  | 39 ++----------------------
 2 files changed, 6 insertions(+), 62 deletions(-)

diff --git a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
index fc853c8cc346..70e2921ef725 100644
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -359,32 +359,9 @@ in milli-Watts or in an 'abstract scale'.
 6.3 - Energy Model complexity
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-The task wake-up path is very latency-sensitive. When the EM of a platform is
-too complex (too many CPUs, too many performance domains, too many performance
-states, ...), the cost of using it in the wake-up path can become prohibitive.
-The energy-aware wake-up algorithm has a complexity of:
-
-	C = Nd * (Nc + Ns)
-
-with: Nd the number of performance domains; Nc the number of CPUs; and Ns the
-total number of OPPs (ex: for two perf. domains with 4 OPPs each, Ns = 8).
-
-A complexity check is performed at the root domain level, when scheduling
-domains are built. EAS will not start on a root domain if its C happens to be
-higher than the completely arbitrary EM_MAX_COMPLEXITY threshold (2048 at the
-time of writing).
-
-If you really want to use EAS but the complexity of your platform's Energy
-Model is too high to be used with a single root domain, you're left with only
-two possible options:
-
-    1. split your system into separate, smaller, root domains using exclusive
-       cpusets and enable EAS locally on each of them. This option has the
-       benefit to work out of the box but the drawback of preventing load
-       balance between root domains, which can result in an unbalanced system
-       overall;
-    2. submit patches to reduce the complexity of the EAS wake-up algorithm,
-       hence enabling it to cope with larger EMs in reasonable time.
+EAS does not impose any complexity limit on the number of PDs/OPPs/CPUs but
+restricts the number of CPUs to EM_MAX_NUM_CPUS to prevent overflows during
+the energy estimation.


 6.4 - Schedutil governor
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a7b50bba7829..e0b9920e7e3e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -348,32 +348,13 @@ static void sched_energy_set(bool has_eas)
  *    1. an Energy Model (EM) is available;
  *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
  *    3. no SMT is detected.
- *    4. the EM complexity is low enough to keep scheduling overheads low;
- *    5. schedutil is driving the frequency of all CPUs of the rd;
- *    6. frequency invariance support is present;
- *
- * The complexity of the Energy Model is defined as:
- *
- *              C = nr_pd * (nr_cpus + nr_ps)
- *
- * with parameters defined as:
- *  - nr_pd:    the number of performance domains
- *  - nr_cpus:  the number of CPUs
- *  - nr_ps:    the sum of the number of performance states of all performance
- *              domains (for example, on a system with 2 performance domains,
- *              with 10 performance states each, nr_ps = 2 * 10 = 20).
- *
- * It is generally not a good idea to use such a model in the wake-up path on
- * very complex platforms because of the associated scheduling overheads. The
- * arbitrary constraint below prevents that. It makes EAS usable up to 16 CPUs
- * with per-CPU DVFS and less than 8 performance states each, for example.
+ *    4. schedutil is driving the frequency of all CPUs of the rd;
+ *    5. frequency invariance support is present;
  */
-#define EM_MAX_COMPLEXITY 2048
-
 extern struct cpufreq_governor schedutil_gov;
 static bool build_perf_domains(const struct cpumask *cpu_map)
 {
-	int i, nr_pd = 0, nr_ps = 0, nr_cpus = cpumask_weight(cpu_map);
+	int i;
 	struct perf_domain *pd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
@@ -431,20 +412,6 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 			goto free;
 		tmp->next = pd;
 		pd = tmp;
-
-		/*
-		 * Count performance domains and performance states for the
-		 * complexity check.
-		 */
-		nr_pd++;
-		nr_ps += em_pd_nr_perf_states(pd->em_pd);
-	}
-
-	/* Bail out if the Energy Model complexity is too high. */
-	if (nr_pd * (nr_ps + nr_cpus) > EM_MAX_COMPLEXITY) {
-		WARN(1, "rd %*pbl: Failed to start EAS, EM complexity is too high\n",
-						cpumask_pr_args(cpu_map));
-		goto free;
 	}

 	perf_domain_debug(cpu_map, pd);
--
2.39.3

