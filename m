Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A794F78F8C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344660AbjIAGxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbjIAGxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:53:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F37E7E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:53:30 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3816g97n010683;
        Fri, 1 Sep 2023 06:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=EafCQTqY3WezbXUUrFm2KuST83wzeuP3LGWS+o7cBpE=;
 b=dSfAp072bJvDFysJE+iTgp29KwGQ1hS8IPGMnP0sC018TQM8C+jbexwC1TgxURjPWgUk
 bFSWP1r9eBFdDnneTDmXQr+BQ88kkh7Ij5usGX36IYetJnFStrQjMatPT2w91D6Qdv/M
 JOmkB3zdUvplH2GOVopfsuRYRLs/qacOfXnXceBzfBAlAUjexhuvzsWL8MPAzlGaV04z
 lc1cKIb9x5ch1zdy+MfXZBdq5rx9P3iP0a59J6OS1uWpqgFKkaBz5a9m222/wP73z9fB
 3tYjTGR0BLNahQ9Jra1yJBGsNwn1IimhmTFCxfBwzL6WO5Gy2GYuA54tADI+3J0kFFXQ JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3suawrr8we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 06:53:10 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3816gngb014477;
        Fri, 1 Sep 2023 06:53:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3suawrr8vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 06:53:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3814RZKa014349;
        Fri, 1 Sep 2023 06:53:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqvqntth0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 06:53:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3816r6FF25756308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Sep 2023 06:53:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 907632004E;
        Fri,  1 Sep 2023 06:53:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72EC12004B;
        Fri,  1 Sep 2023 06:53:03 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.58.3])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  1 Sep 2023 06:53:03 +0000 (GMT)
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mingo@kernel.org, yu.c.chen@intel.com
Subject: [PATCH v2] sched/topology: remove sysctl_sched_energy_aware depending on the architecture
Date:   Fri,  1 Sep 2023 12:22:49 +0530
Message-Id: <20230901065249.137242-1-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0pAaqv-iqTD8VHGHlNxI5-oyS7C5eZvB
X-Proofpoint-ORIG-GUID: wvB6MieFTuoUpncEBQgAOZHQejM96xIx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_04,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309010061
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
that dont support it. Some of the settings can be changed later
such as smt_active by offlining the CPU's, In those cases if
build_perf_domains returns true, re-enable the sysctl.

Anytime, when sysctl_sched_energy_aware is changed sched_energy_update
is set when building the perf domains. Making use of that to find out if
the change is happening by sysctl or dynamic system change.

Taking different cases:
Case1. system while booting has EAS capability, sysctl will be set 1. Hence
perf domains will be built if needed. On changing the sysctl to 0, since
sched_energy_update is true, perf domains would be freed and sysctl will
not be removed. later sysctl is changed to 1, enabling the perf domains
rebuild again. Since sysctl is already there, it will skip register.

Case2. System while booting doesn't have EAS Capability. Later after system
change it becomes capable of EAS. sched_energy_update is false. Though
sysctl is 0, will go ahead and try to enable eas. This is the current
behaviour. if has_eas  is true, then sysctl will be registered. After
that any sysctl change is same as Case1.

Case3. System becomes not capable of EAS due to system change. Here since
sched_energy_update is false, build_perf_domains return has_eas as false
due to one of the checks and Since this is dynamic change remove the sysctl.
Any further change which enables EAS is Case2

Note: This hasn't been tested on platform which supports EAS. If the
change can be verified on that it would really help. This has been
tested on power10 which doesn't support EAS. sysctl_sched_energy_aware
is removed with patch.

changes since v1:
Chen Yu had pointed out that this will not destroy the perf domains on
architectures where EAS is supported by changing the sysctl. This patch
addresses that.
[v1] Link: https://lore.kernel.org/lkml/20230829065040.920629-1-sshegde@linux.vnet.ibm.com/#t

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 kernel/sched/topology.c | 45 +++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05a5bc678c08..4d16269ac21a 100644
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

@@ -336,10 +348,28 @@ static void sched_energy_set(bool has_eas)
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
+		if (sysctl_eas_header && !sched_energy_update) {
+			unregister_sysctl_table(sysctl_eas_header);
+			sysctl_eas_header = NULL;
+		}
+#endif
+		sysctl_sched_energy_aware = 0;
 	} else if (has_eas && !static_branch_unlikely(&sched_energy_present)) {
 		if (sched_debug())
 			pr_info("%s: starting EAS\n", __func__);
 		static_branch_enable_cpuslocked(&sched_energy_present);
+#ifdef CONFIG_PROC_SYSCTL
+		if (!sysctl_eas_header)
+			sysctl_eas_header = register_sysctl("kernel", sched_energy_aware_sysctls);
+#endif
+		sysctl_sched_energy_aware = 1;
 	}
 }

@@ -380,15 +410,14 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 	struct cpufreq_policy *policy;
 	struct cpufreq_governor *gov;

-	if (!sysctl_sched_energy_aware)
+	if (!sysctl_sched_energy_aware && sched_energy_update)
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

