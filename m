Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FE77AE9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjIZKBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIZKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:01:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F679D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:01:33 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q9UW5q010789;
        Tue, 26 Sep 2023 10:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=6GOPQGrge8QHqX+NmUQecZfFwatDlVIjAhWapemOCaU=;
 b=rDdtH4M9+HONsXxjm9sfx60NnrmCx6WIiz6f4ANkd0KTWyRdJs3SGFbJ6PtaAQmTw48D
 Ss8rM65d7F5SE3zb7E878fwX25oF5BfkHOP3tmm6OQ9y2qli8MhJAZ86t6GB5qSO6pCU
 c+5CCxeJ/JmruIXnE3LjE3nfE73fXGtjKu/RuDwGfaytedY0jybMGpqaBdBOvO8VFdSp
 x+d0gRxlG3Kb6TZvnvYWmeDdmbQtjexWlyrAlYfKB4l5Nd+0gn/ZQFgUZJ8nk4DijVD/
 tD3bn/Js5OrQEalFROxfkQMdZOIozUIOEqSj2zsZCeCd6YiA0NEYLUKwb6isECzJDF7d 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbus5t52r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 10:01:02 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38Q9txRX026672;
        Tue, 26 Sep 2023 10:01:02 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbus5t525-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 10:01:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38Q9p8ac030719;
        Tue, 26 Sep 2023 10:01:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjjt5kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 10:01:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38QA0xYx22086268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 10:00:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6707620040;
        Tue, 26 Sep 2023 10:00:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AD102004B;
        Tue, 26 Sep 2023 10:00:55 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.20.2])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 26 Sep 2023 10:00:55 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com
Subject: [PATCH v4] sched/topology: change behaviour of sysctl sched_energy_aware based on the platform
Date:   Tue, 26 Sep 2023 15:30:46 +0530
Message-Id: <20230926100046.405188-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qM1p--iKq0AP8wacDqb9NEP9209Tr99_
X-Proofpoint-ORIG-GUID: T1RmFsAH75GmvmFxSpsYmPRLUy-E-Q8x
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_07,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260083
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
valid cpufreq policy, frequency invariant load tracking etc. A platform may
boot without EAS capability, but could gain such capability at runtime
For example, changing/registering the cpufreq policy.

At present, though platform doesn't support EAS, this sysctl returns 1
and it ends up calling rebuild of sched domain on write to 1 and
NOP when writing to 0. That is confusing and un-necessary.

Desired behavior would be to, have this sysctl to enable/disable the EAS
on supported platform. On Non supported platform write to the sysctl
would return not supported error and read of the sysctl would return
empty. So
sched_energy_aware returns empty - EAS is not possible at this moment
sched_energy_aware returns 0 - EAS is supported but disabled by admin.
sched_energy_aware returns 1 - EAS is supported and enabled.
User can find out the reason why EAS is not possible by checking
info messages.

sched_is_eas_possible return if the platform can do EAS at this moment.
It takes most of the cases into account except one where EM complexity is
too high as the code was bit tricky to separate that.

v3->v4:
valentin suggested it would be better to consider simpler approach that
was mentioned in v2. It is a standard approach to keep the knob visible
but change how read and write are handled. Did that and Refactored the
code to use a common function in build_perf_domains and in sysctl handler.
v2->v3:
Chen Yu and Pierre Gondois both pointed out that if platform becomes
capable of EAS later, this patch was not allowing that to happen.
Addressed that by using a variable to indicate the sysctl change
and re-worded the commit message with desired behaviour,
v1->v2:
Chen Yu had pointed out that this will not destroy the perf domains on
architectures where EAS is supported by changing the sysctl.
[v1] Link: https://lore.kernel.org/lkml/20230829065040.920629-1-sshegde@linux.vnet.ibm.com/
[v2] Link: https://lore.kernel.org/lkml/20230901065249.137242-1-sshegde@linux.vnet.ibm.com/
[v3] Link: https://lore.kernel.org/lkml/20230913114807.665094-1-sshegde@linux.vnet.ibm.com/

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |   3 +-
 kernel/sched/topology.c                     | 107 +++++++++++++-------
 2 files changed, 71 insertions(+), 39 deletions(-)

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
index a7b50bba7829..839ddc80a5ac 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -212,6 +212,64 @@ static unsigned int sysctl_sched_energy_aware = 1;
 static DEFINE_MUTEX(sched_energy_mutex);
 static bool sched_energy_update;

+extern struct cpufreq_governor schedutil_gov;
+static bool sched_is_eas_possible(const struct cpumask *cpu_mask)
+{
+	int cpu = cpumask_first(cpu_mask);
+	struct cpufreq_policy *policy;
+	struct cpufreq_governor *gov;
+	int i;
+
+	/* EAS is enabled for asymmetric CPU capacity topologies. */
+	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
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
@@ -231,6 +289,14 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
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
 	if (!ret && write) {
 		state = static_branch_unlikely(&sched_energy_present);
 		if (state != sysctl_sched_energy_aware)
@@ -370,61 +436,24 @@ static void sched_energy_set(bool has_eas)
  */
 #define EM_MAX_COMPLEXITY 2048

-extern struct cpufreq_governor schedutil_gov;
 static bool build_perf_domains(const struct cpumask *cpu_map)
 {
 	int i, nr_pd = 0, nr_ps = 0, nr_cpus = cpumask_weight(cpu_map);
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
@@ -458,6 +487,8 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 	return !!pd;

 free:
+	if (sched_debug())
+		pr_warn("rd %*pbl: Disabling EAS", cpumask_pr_args(cpu_map));
 	free_pd(pd);
 	tmp = rd->pd;
 	rcu_assign_pointer(rd->pd, NULL);
--
2.31.1

