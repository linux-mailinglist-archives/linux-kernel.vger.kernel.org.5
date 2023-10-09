Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2DA7BD2F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbjJIGBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345137AbjJIGBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:01:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B839E;
        Sun,  8 Oct 2023 23:01:40 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3995sheN026587;
        Mon, 9 Oct 2023 06:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KON/mFmdpxnx2QSuGR6HXlIclbbczsFP3g4kLfpfQuo=;
 b=hK/4G+azgq3PzbsnQzhSM69OaxtznGuSjmzcVETPcJGHtLF6avZVx6TyFx8FH+qPMfZv
 YHpbp8IqXHQiS374B8Hpq1XRRYjGDEGU1N5WP4OVRZMLaNHFTqiF9LngMkOCcNjgcsie
 HIZS4IOBmurxDa0Wd60CjW8EVX4vpqamEFlfzKcJa/tA7MWCfGtf3iGgEw7aV72wcZv6
 UYbn2Qno760/l+KkdPYqWnU4pURlegal0Q+eYT1dT4qGm5xK43aEcUnym+J1gtOpR1Ce
 cmjOkJfQEA/4o6RcKpv8CdooBw+Dl3wuQcb8TpZq2gb8AHMJgqjt+81z2gpMquIzHdRe hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmbsmg4a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 06:01:19 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3995tECE027723;
        Mon, 9 Oct 2023 06:01:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmbsmg493-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 06:01:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3994kksU024452;
        Mon, 9 Oct 2023 06:01:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhns79x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 06:01:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39961GY619202578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Oct 2023 06:01:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EF9C2004B;
        Mon,  9 Oct 2023 06:01:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D3E920043;
        Mon,  9 Oct 2023 06:01:13 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Oct 2023 06:01:13 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        vschneid@redhat.com
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, qperret@google.com,
        srikar@linux.vnet.ibm.com, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com, pauld@redhat.com, lukasz.luba@arm.com,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 2/2] sched/topology: change behaviour of sysctl sched_energy_aware based on the platform
Date:   Mon,  9 Oct 2023 11:30:37 +0530
Message-Id: <20231009060037.170765-3-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231009060037.170765-1-sshegde@linux.vnet.ibm.com>
References: <20231009060037.170765-1-sshegde@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0Zt-aGIbe0uwd8DgZmmaF3ir7UCSusD6
X-Proofpoint-GUID: qkr_HaIaV-VszhHDFLoEAhL71-mAYhoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_04,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090052
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
capability at runtime. For example, changing/registering the CPUfreq
governor to schedutil.

At present, though platform doesn't support EAS, this sysctl returns 1
and it ends up calling build_perf_domains on write to 1 and
NOP when writing to 0. That is confusing and un-necessary.

Desired behavior would be to have this sysctl to enable/disable the EAS
on supported platform. On non-supported platform write to the sysctl
would return not supported error and read of the sysctl would return
empty. So
sched_energy_aware returns empty - EAS is not possible at this moment
This will include EAS capable platforms which have at least one EAS
condition false during startup, e.g. not using the schedutil CPUfreq governor
sched_energy_aware returns 0 - EAS is supported but disabled by admin.
sched_energy_aware returns 1 - EAS is supported and enabled.

User can find out the reason why EAS is not possible by checking
info messages. sched_is_eas_possible returns true if the platform
can do EAS at this moment.

Tested-by: Pierre Gondois <pierre.gondois@arm.com>
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
index e0b9920e7e3e..dcf8c3558b01 100644
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
+		if (rcu_access_pointer(per_cpu(sd_asym_cpucapacity, i))) {
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
@@ -230,6 +294,15 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;

+	if (!sched_is_eas_possible(cpu_active_mask)) {
+		if (write) {
+			return -EOPNOTSUPP;
+		} else {
+			*lenp = 0;
+			return 0;
+		}
+	}
+
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		state = static_branch_unlikely(&sched_energy_present);
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
2.31.1

