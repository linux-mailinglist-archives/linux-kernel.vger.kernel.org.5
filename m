Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7D7B375A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjI2PyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjI2PyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:54:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1BE199;
        Fri, 29 Sep 2023 08:54:14 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TFf7SU010269;
        Fri, 29 Sep 2023 15:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/UoWLaCgVeHqwKpdLyNPiJRQU74xtqknmO9AMUSuOrg=;
 b=P6ZMHsy9YRtEulJUsNAA3TCG1oyEzTJNP1OXRgqZuAhd/aw6H1Sb7vwbn77u57u/J+l5
 1BZVeQA+zLAo4Mu6JE5mCwt9mAGJf9C3TG+1BeCz1erD3RUlwo5Rq8u7p8aWgKHv/Avy
 sMOHwOMIXQbXMAp/dQ+lGXvYGBBNf2qIdRLKs1hbUaRelpLbYXx1RbelvUPiDsxRzeYN
 drd5w8CgoPcgWn2aplqwmKFHy3qH3f4DidhY8jD+EskDSM2JrNDFvOV1xZ4FuHTHrMW0
 Y7ej4ZGlYGfHI8l4sMV8SKGf1tQvGU28pDlU7GCC2/2r3PdKdL1dUagf/JTHfnw3LWnz zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3te082tpr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:53:56 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TFiirf022252;
        Fri, 29 Sep 2023 15:53:56 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3te082tpqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:53:55 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TDiMPQ030719;
        Fri, 29 Sep 2023 15:53:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjkna0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 15:53:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TFrrWU24314540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 15:53:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AB4A20043;
        Fri, 29 Sep 2023 15:53:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73CC120040;
        Fri, 29 Sep 2023 15:53:48 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.6.110])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 15:53:48 +0000 (GMT)
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
Subject: [PATCH v5 2/2] sched/topology: change behaviour of sysctl sched_energy_aware based on the platform
Date:   Fri, 29 Sep 2023 21:22:09 +0530
Message-Id: <20230929155209.667764-3-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230929155209.667764-1-sshegde@linux.vnet.ibm.com>
References: <20230929155209.667764-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y4pPGvhj2U6kSmSDwVR2cjkh7J6VQTiq
X-Proofpoint-GUID: jCEk-5lameQVH8GeB76N09QjkvEbBix-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_13,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290134
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysctl sched_energy_aware is available for the admin to disable/enable
energy aware scheduling(EAS). EAS is enabled only if few conditions are
met by the platform. They are, asymmetric CPU capacity, no SMT,
schedutil CPUfreq governor, frequency invariant load tracking etc.
A platform may boot without EAS capability, but could gain such
capability at runtime For example, changing/registering the CPUfreq
governor to schedutil.

At present, though platform doesn't support EAS, this sysctl returns 1
and it ends up calling build_perf_domains on write to 1 and
NOP when writing to 0. That is confusing and un-necessary.

Desired behavior would be to, have this sysctl to enable/disable the EAS
on supported platform. On Non supported platform write to the sysctl
would return not supported error and read of the sysctl would return
empty. So
sched_energy_aware returns empty - EAS is not possible at this moment
This will include EAS capable platforms which have at least one EAS
condition false during startup, e.g. using a Performance CPUfreq governor
sched_energy_aware returns 0 - EAS is supported but disabled by admin.
sched_energy_aware returns 1 - EAS is supported and enabled.

User can find out the reason why EAS is not possible by checking
info messages. sched_is_eas_possible returns true if the platform
can do EAS at this moment.

Depends on [PATCH v5 1/2] sched/topology: Remove EM_MAX_COMPLEXITY limit
to be applied first.

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |   3 +-
 kernel/sched/topology.c                     | 112 +++++++++++++-------
 2 files changed, 76 insertions(+), 39 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index cf33de56da27..d89ac2bd8dc4 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1182,7 +1182,8 @@ automatically on platforms where it can run (that is,
 platforms with asymmetric CPU topologies and having an Energy
 Model available). If your platform happens to meet the
 requirements for EAS but you do not want to use it, change
-this value to 0.
+this value to 0. On Non-EAS platforms, write operation fails and
+read doesn't return anything.

 task_delayacct
 ===============
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e0b9920e7e3e..a654d0186ac0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -212,6 +212,70 @@ static unsigned int sysctl_sched_energy_aware = 1;
 static DEFINE_MUTEX(sched_energy_mutex);
 static bool sched_energy_update;

+extern struct cpufreq_governor schedutil_gov;
+static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
+{
+	bool any_asym_capacity = false;
+	struct cpufreq_policy *policy;
+	struct cpufreq_governor *gov;
+	int i;
+
+	/* EAS is enabled for asymmetric CPU capacity topologies. */
+	for_each_cpu(i, cpu_mask) {
+		if (per_cpu(sd_asym_cpucapacity, i)) {
+			any_asym_capacity = true;
+			break;
+		}
+	}
+	if (!any_asym_capacity) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: Checking EAS, CPUs do not have asymmetric capacities\n",
+				cpumask_pr_args(cpu_mask));
+		}
+		return false;
+	}
+
+	/* EAS definitely does *not* handle SMT */
+	if (sched_smt_active()) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: Checking EAS, SMT is not supported\n",
+				cpumask_pr_args(cpu_mask));
+		}
+		return false;
+	}
+
+	if (!arch_scale_freq_invariant()) {
+		if (sched_debug()) {
+			pr_info("rd %*pbl: Checking EAS: frequency-invariant load tracking not yet supported",
+				cpumask_pr_args(cpu_mask));
+		}
+		return false;
+	}
+
+	/* Do not attempt EAS if schedutil is not being used. */
+	for_each_cpu(i, cpu_mask) {
+		policy = cpufreq_cpu_get(i);
+		if (!policy) {
+			if (sched_debug()) {
+				pr_info("rd %*pbl: Checking EAS, cpufreq policy not set for CPU: %d",
+					cpumask_pr_args(cpu_mask), i);
+			}
+			return false;
+		}
+		gov = policy->governor;
+		cpufreq_cpu_put(policy);
+		if (gov != &schedutil_gov) {
+			if (sched_debug()) {
+				pr_info("rd %*pbl: Checking EAS, schedutil is mandatory\n",
+					cpumask_pr_args(cpu_mask));
+			}
+			return false;
+		}
+	}
+
+	return true;
+}
+
 void rebuild_sched_domains_energy(void)
 {
 	mutex_lock(&sched_energy_mutex);
@@ -231,6 +295,15 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
 		return -EPERM;

 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (!sched_is_eas_possible(cpu_active_mask)) {
+		if (write) {
+			return -EOPNOTSUPP;
+		} else {
+			*lenp = 0;
+			return 0;
+		}
+	}
+
 	if (!ret && write) {
 		state = static_branch_unlikely(&sched_energy_present);
 		if (state != sysctl_sched_energy_aware)
@@ -351,61 +424,24 @@ static void sched_energy_set(bool has_eas)
  *    4. schedutil is driving the frequency of all CPUs of the rd;
  *    5. frequency invariance support is present;
  */
-extern struct cpufreq_governor schedutil_gov;
 static bool build_perf_domains(const struct cpumask *cpu_map)
 {
 	int i;
 	struct perf_domain *pd = NULL, *tmp;
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
-	struct cpufreq_policy *policy;
-	struct cpufreq_governor *gov;

 	if (!sysctl_sched_energy_aware)
 		goto free;

-	/* EAS is enabled for asymmetric CPU capacity topologies. */
-	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
-		if (sched_debug()) {
-			pr_info("rd %*pbl: CPUs do not have asymmetric capacities\n",
-					cpumask_pr_args(cpu_map));
-		}
-		goto free;
-	}
-
-	/* EAS definitely does *not* handle SMT */
-	if (sched_smt_active()) {
-		pr_warn("rd %*pbl: Disabling EAS, SMT is not supported\n",
-			cpumask_pr_args(cpu_map));
-		goto free;
-	}
-
-	if (!arch_scale_freq_invariant()) {
-		if (sched_debug()) {
-			pr_warn("rd %*pbl: Disabling EAS: frequency-invariant load tracking not yet supported",
-				cpumask_pr_args(cpu_map));
-		}
+	if (!sched_is_eas_possible(cpu_map))
 		goto free;
-	}

 	for_each_cpu(i, cpu_map) {
 		/* Skip already covered CPUs. */
 		if (find_pd(pd, i))
 			continue;

-		/* Do not attempt EAS if schedutil is not being used. */
-		policy = cpufreq_cpu_get(i);
-		if (!policy)
-			goto free;
-		gov = policy->governor;
-		cpufreq_cpu_put(policy);
-		if (gov != &schedutil_gov) {
-			if (rd->pd)
-				pr_warn("rd %*pbl: Disabling EAS, schedutil is mandatory\n",
-						cpumask_pr_args(cpu_map));
-			goto free;
-		}
-
 		/* Create the new pd and add it to the local list. */
 		tmp = pd_init(i);
 		if (!tmp)
--
2.39.3

