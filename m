Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF09878BED0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjH2Gvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbjH2Gvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:51:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7700F10A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:51:38 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T6bDr6026348;
        Tue, 29 Aug 2023 06:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kv9sFNTNb7XzHqBnahuMpKgXZcWRSUpQ3QMMPGKkXUo=;
 b=gSOs/GnrVoU3ksOH74rWN34v8wlGruOHFNXdldv9/FgVGUdJ7ujrpIDJqg0IExOHUvwk
 wp/xlu/XppssMpFRPtwCTekuAkJFw077+28YDPwfWUVbsCyvzyfOhaxb4W8S9+GcG653
 +go6lnbxMI3xjpVvTShK+7SwVebplC60ZxjB/iJ0uNuuFmxkD0OfiRpRy3WkcFugLMiF
 ACogya+e/fwLhEA7fh0gBmKwY+IT14PEwvhEg+sugc/Xh9aV+51dtXeCmKRiitj6bZxJ
 jT+GGIHo/fHmw8Np7n6FcWpQiFaBiXkbLxtcWmCOyKMPXHnlDIQrnkiyNTRebZoqkyvh lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr8s72m8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:51:20 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37T6bjFX027729;
        Tue, 29 Aug 2023 06:51:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr8s72m83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:51:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37T4PLv2014416;
        Tue, 29 Aug 2023 06:51:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqvqn1cr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:51:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37T6pGuE7733816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 06:51:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E85420043;
        Tue, 29 Aug 2023 06:51:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6F352004B;
        Tue, 29 Aug 2023 06:51:13 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Aug 2023 06:51:13 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org
Subject: [PATCH] sched/topology: remove sysctl_sched_energy_aware depending on the architecture
Date:   Tue, 29 Aug 2023 12:20:40 +0530
Message-Id: <20230829065040.920629-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: POV81p3fvZZBlscA_yMEG0hpGBsXaVkj
X-Proofpoint-ORIG-GUID: p2ddn3MSb6PaTukO0n9f26mJAdsCT6pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_03,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sysctl_sched_energy_aware doesn't alter the said behaviour on
some of the architectures. IIUC its meant to either force rebuild the
perf domains or cleanup the perf domains by echoing 1 or 0 respectively.

perf domains are not built when there is SMT, or when there is no
Asymmetric CPU topologies or when there is no frequency invariance.
Since such cases EAS is not set and perf domains are not built. By
changing the values of sysctl_sched_energy_aware, its not possible to
force build the perf domains. Hence remove this sysctl on such platforms
that dont support it at boot. Some of the settings can be changed later
such as smt_active by offlining the CPU's, In those cases
build_perf_domains returns true, in that case re-enable the sysctl.

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 kernel/sched/topology.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05a5bc678c08..ff68366be280 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -208,7 +208,8 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)

 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
-static unsigned int sysctl_sched_energy_aware = 1;
+static unsigned int sysctl_sched_energy_aware;
+static struct ctl_table_header *sysctl_eas_header;
 static DEFINE_MUTEX(sched_energy_mutex);
 static bool sched_energy_update;

@@ -226,6 +227,7 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret, state;
+	int prev_val = sysctl_sched_energy_aware;

 	if (write && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -233,8 +235,11 @@ static int sched_energy_aware_handler(struct ctl_table *table, int write,
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 	if (!ret && write) {
 		state = static_branch_unlikely(&sched_energy_present);
-		if (state != sysctl_sched_energy_aware)
+		if (state != sysctl_sched_energy_aware && prev_val != sysctl_sched_energy_aware) {
+			if (sysctl_sched_energy_aware && !state)
+				pr_warn("Attempt to build energy domains when EAS is disabled\n");
 			rebuild_sched_domains_energy();
+		}
 	}

 	return ret;
@@ -255,7 +260,14 @@ static struct ctl_table sched_energy_aware_sysctls[] = {

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

@@ -336,10 +348,18 @@ static void sched_energy_set(bool has_eas)
 		if (sched_debug())
 			pr_info("%s: stopping EAS\n", __func__);
 		static_branch_disable_cpuslocked(&sched_energy_present);
+#ifdef CONFIG_PROC_SYSCTL
+		unregister_sysctl_table(sysctl_eas_header);
+#endif
+		sysctl_sched_energy_aware = 0;
 	} else if (has_eas && !static_branch_unlikely(&sched_energy_present)) {
 		if (sched_debug())
 			pr_info("%s: starting EAS\n", __func__);
 		static_branch_enable_cpuslocked(&sched_energy_present);
+#ifdef CONFIG_PROC_SYSCTL
+		sysctl_eas_header = register_sysctl("kernel", sched_energy_aware_sysctls);
+#endif
+		sysctl_sched_energy_aware = 1;
 	}
 }

@@ -380,15 +400,11 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 	struct cpufreq_policy *policy;
 	struct cpufreq_governor *gov;

-	if (!sysctl_sched_energy_aware)
-		goto free;
-
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

