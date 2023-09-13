Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF35C79E722
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbjIMLtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbjIMLtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:49:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37178BE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:49:08 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DBc7hv019034;
        Wed, 13 Sep 2023 11:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=m+b5CGFNAdMneHO7X16BtaFZXWfEKz+iqwA840SILKY=;
 b=PgoT4wlNi7KraA1Cifg1QT9enwxim0ATCBEOXE+bTVpozCHYSn4NQZ4MADDPJpcPrWXi
 7GB70V6gkvhc9iJ8DOLM6z2pXp2wEWSsxGBW6giIb0xVDGNBVAbwG+j9jR4ayY9a55VR
 kxIowEd6soMXimpzgBBhHG76BAyQ5UVi8DrzTnn3xlm0Suoew0jGII5UhLPROJT+FoD4
 tFv3qNLTG07eArGzb/duzpBZQBpp6P5D36v2chMuYHWLUk/ZCZ6o1NmsGFPfdHAILfRG
 2/5h/0UJF9xed7EFZQm2Cxw5Nv25H8TC+KMYCzdj9mZGkODhIXrvRqFVZljsPAOrF6He DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3c7c0bns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:48:42 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38DBcK86019603;
        Wed, 13 Sep 2023 11:48:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t3c7c0bnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:48:41 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38D9sGNE012083;
        Wed, 13 Sep 2023 11:48:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dyu13n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:48:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38DBmcen52953594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 11:48:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7303C20040;
        Wed, 13 Sep 2023 11:48:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D4FA20043;
        Wed, 13 Sep 2023 11:48:34 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.0.21])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Sep 2023 11:48:34 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware depending on the architecture
Date:   Wed, 13 Sep 2023 17:18:07 +0530
Message-Id: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pskSjXobpmc7ZNItj94Ci9nFt8WpmV2C
X-Proofpoint-ORIG-GUID: H868QPus0nKuio5ns-v_NIsx1mPNTynN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_04,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysctl_sched_energy_aware is available for the admin to disable/enable
energy aware scheduling(EAS). EAS is enabled only if few conditions are
met by the platform. They are, asymmetric CPU capacity, no SMT,
valid cpufreq policy, frequency invariant load tracking. It is possible
platform when booting may not have EAS capability, but can do that after.
For example, changing/registering the cpufreq policy.

At present, though platform doesn't support EAS, this sysctl is still
present and it ends up calling rebuild of sched domain on write to 1 and
NOP when writing to 0. That is confusing and un-necessary.

Desired behaviour can be, have the sysctl only when the platform can do
EAS. i.e when platform becomes capable enable the sysctl and when it can't
remove the sysctl. On Supported platform using this sysctl, admin should be
able to enable/disable EAS.

Update the sysctl guide as well.

Different Scenarios:
Scenario 1: System while booting has EAS capability.
Expected: sysctl will be present and admin can enable/disable EAS by writing
1 or 0 respectively. This operation shouldn't remove the sysctl specially when
disabling as sysctl would be needed to enable it later.
Scenario 2: System becomes capable of EAS later
Expected: At boot, sysctl will not be present. Once eas is enabled by passing
all the checks, perf domains will be built and sysctl will be enabled. Any
further change to sysctl should be treated same as Scenario 1.
Scenario 3: system becomes not capable of EAS.
Expected: Since EAS is going to be disabled now, remove the sysctl in this
scenario. If it becomes capable of EAS later again, that would be Scenario 2.

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

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  3 +-
 kernel/sched/topology.c                     | 49 +++++++++++++++++----
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 3800fab1619b..455e12f1331b 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1134,7 +1134,8 @@ automatically on platforms where it can run (that is,
 platforms with asymmetric CPU topologies and having an Energy
 Model available). If your platform happens to meet the
 requirements for EAS but you do not want to use it, change
-this value to 0.
+this value to 0. If platform doesn't support EAS at this moment,
+this would be removed.

 task_delayacct
 ===============
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05a5bc678c08..57df938d5ec0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -208,9 +208,11 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)

 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
-static unsigned int sysctl_sched_energy_aware = 1;
+static unsigned int sysctl_sched_energy_aware;
+static struct ctl_table_header *sysctl_eas_header;
 static DEFINE_MUTEX(sched_energy_mutex);
 static bool sched_energy_update;
+static bool is_sysctl_eas_changing;

 void rebuild_sched_domains_energy(void)
 {
@@ -226,6 +228,7 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret, state;
+	int prev_val = sysctl_sched_energy_aware;

 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -233,8 +236,13 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		state = static_branch_unlikely(&sched_energy_present);
-		if (state != sysctl_sched_energy_aware)
+		if (state != sysctl_sched_energy_aware && prev_val != sysctl_sched_energy_aware) {
+			is_sysctl_eas_changing = true;
+			if (sysctl_sched_energy_aware && !state)
+				pr_warn("Attempt to build energy domains when EAS is disabled\n");
 			rebuild_sched_domains_energy();
+			is_sysctl_eas_changing = false;
+		}
 	}

 	return ret;
@@ -255,7 +263,14 @@ static struct ctl_table sched_energy_aware_sysctls[] = {

 static int __init sched_energy_aware_sysctl_init(void)
 {
-	register_sysctl_init("kernel", sched_energy_aware_sysctls);
+	int cpu = cpumask_first(cpu_active_mask);
+
+	if (sched_smt_active() || !per_cpu(sd_asym_cpucapacity, cpu) ||
+	    !arch_scale_freq_invariant())
+		return 0;
+
+	sysctl_eas_header = register_sysctl("kernel", sched_energy_aware_sysctls);
+	sysctl_sched_energy_aware = 1;
 	return 0;
 }

@@ -336,10 +351,29 @@ static void sched_energy_set(bool has_eas)
 		if (sched_debug())
 			pr_info("%s: stopping EAS\n", __func__);
 		static_branch_disable_cpuslocked(&sched_energy_present);
+#ifdef CONFIG_PROC_SYSCTL
+		/*
+		 * if the architecture supports EAS and forcefully
+		 * perf domains are destroyed, there should be a sysctl
+		 * to enable it later. If this was due to dynamic system
+		 * change such as SMT<->NON_SMT then remove sysctl.
+		 */
+		if (sysctl_eas_header && !is_sysctl_eas_changing) {
+			unregister_sysctl_table(sysctl_eas_header);
+			sysctl_eas_header = NULL;
+			sysctl_sched_energy_aware = 0;
+		}
+#endif
 	} else if (has_eas && !static_branch_unlikely(&sched_energy_present)) {
 		if (sched_debug())
 			pr_info("%s: starting EAS\n", __func__);
 		static_branch_enable_cpuslocked(&sched_energy_present);
+#ifdef CONFIG_PROC_SYSCTL
+		if (!sysctl_eas_header) {
+			sysctl_eas_header = register_sysctl("kernel", sched_energy_aware_sysctls);
+			sysctl_sched_energy_aware = 1;
+		}
+#endif
 	}
 }

@@ -380,15 +414,14 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 	struct cpufreq_policy *policy;
 	struct cpufreq_governor *gov;

-	if (!sysctl_sched_energy_aware)
+	if (!sysctl_sched_energy_aware && is_sysctl_eas_changing)
 		goto free;

 	/* EAS is enabled for asymmetric CPU capacity topologies. */
 	if (!per_cpu(sd_asym_cpucapacity, cpu)) {
-		if (sched_debug()) {
-			pr_info("rd %*pbl: CPUs do not have asymmetric capacities\n",
-					cpumask_pr_args(cpu_map));
-		}
+		if (sched_debug())
+			pr_info("rd %*pbl: Disabling EAS,  CPUs do not have asymmetric capacities\n",
+				cpumask_pr_args(cpu_map));
 		goto free;
 	}

--
2.31.1

