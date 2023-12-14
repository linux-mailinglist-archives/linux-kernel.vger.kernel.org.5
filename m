Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC6813972
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572975AbjLNSIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572929AbjLNSIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:08:32 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7CBA6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:08:39 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEHHtvJ031155;
        Thu, 14 Dec 2023 18:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kSRGxFo5gG0a/Y18f3ozNyYBdBaI5uNGjN6/lpUbqDY=;
 b=YSqsXatrbB8AIWwAkOQTiCM6FNWfn6GhIPilbJ4GWhfPK3vPmGFwB9iAc8gb/xk0i4Lh
 zIVMr61y8gH3qqJ2U2olXpuvPJM7qj7tQffX+UnNxDXGHREwRrpqFl9qxw5OmaJe3Nda
 M8yVHlmR7lrQjAa1JPm7Jk4NFC4LReI84/NO92IUot29lGQ9jGJkIJcQtNUIh0Lw+rDn
 kO7R0M4sFAFtH1GLw7A6OcDpB7lRn5WqZsrj2GD7si/jn5Rwo5nuQpANzhK78qAcF9Vp
 fSBXB5GLfCSI7qE+nFwc87sNpm61o6FZz9/FuK8J4eZMCyRKKWv0QWxukqEAG6JGUXbx SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v05yu9a72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 18:08:22 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEHrQUl015467;
        Thu, 14 Dec 2023 18:08:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v05yu9a6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 18:08:21 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEHY59x028217;
        Thu, 14 Dec 2023 18:08:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2y02me1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 18:08:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEI8I5h11993782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 18:08:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6E6120049;
        Thu, 14 Dec 2023 18:08:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98B9920040;
        Thu, 14 Dec 2023 18:08:15 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.43.25.55])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 18:08:15 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aneesh <aneesh.kumar@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: [PATCH v5 5/5] powerpc/smp: Dynamically build Powerpc topology
Date:   Thu, 14 Dec 2023 23:37:15 +0530
Message-ID: <20231214180720.310852-6-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214180720.310852-1-srikar@linux.vnet.ibm.com>
References: <20231214180720.310852-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9vLLj_W6yaXcKHksMtZ7A8088n46A80J
X-Proofpoint-GUID: mtXEDbzLlTk5SslFsmsgTHIeloCAk8hy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_12,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are four Powerpc specific sched topologies.  These are
all statically defined.  However not all these topologies are used by
all Powerpc systems.

To avoid unnecessary degenerations by the scheduler, masks and flags
are compared. However if the sched topologies are build dynamically then
the code is simpler and there are greater chances of avoiding
degenerations.

Note:
Even X86 builds its sched topologies dynamically and proposed changes
are very similar to the way X86 is building its topologies.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog:
v3 -> v4:
- Conflict resolution due to rebase
	(DIE changed to PKG)

 arch/powerpc/kernel/smp.c | 78 ++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9d8bb9a084bd..693334c20d07 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -93,15 +93,6 @@ EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 EXPORT_SYMBOL_GPL(has_big_cores);
 
-enum {
-#ifdef CONFIG_SCHED_SMT
-	smt_idx,
-#endif
-	cache_idx,
-	mc_idx,
-	die_idx,
-};
-
 #define MAX_THREAD_LIST_SIZE	8
 #define THREAD_GROUP_SHARE_L1   1
 #define THREAD_GROUP_SHARE_L2_L3 2
@@ -1067,16 +1058,6 @@ static const struct cpumask *cpu_mc_mask(int cpu)
 	return cpu_coregroup_mask(cpu);
 }
 
-static struct sched_domain_topology_level powerpc_topology[] = {
-#ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
-#endif
-	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
-	{ cpu_mc_mask, powerpc_shared_proc_flags, SD_INIT_NAME(MC) },
-	{ cpu_cpu_mask, powerpc_shared_proc_flags, SD_INIT_NAME(PKG) },
-	{ NULL, },
-};
-
 static int __init init_big_cores(void)
 {
 	int cpu;
@@ -1704,9 +1685,11 @@ void start_secondary(void *unused)
 	BUG();
 }
 
-static void __init fixup_topology(void)
+static struct sched_domain_topology_level powerpc_topology[6];
+
+static void __init build_sched_topology(void)
 {
-	int i;
+	int i = 0;
 
 	if (is_shared_processor() && has_big_cores)
 		static_branch_enable(&splpar_asym_pack);
@@ -1714,36 +1697,33 @@ static void __init fixup_topology(void)
 #ifdef CONFIG_SCHED_SMT
 	if (has_big_cores) {
 		pr_info("Big cores detected but using small core scheduling\n");
-		powerpc_topology[smt_idx].mask = smallcore_smt_mask;
+		powerpc_topology[i++] = (struct sched_domain_topology_level){
+			smallcore_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT)
+		};
+	} else {
+		powerpc_topology[i++] = (struct sched_domain_topology_level){
+			cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT)
+		};
 	}
 #endif
+	if (shared_caches) {
+		powerpc_topology[i++] = (struct sched_domain_topology_level){
+			shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE)
+		};
+	}
+	if (has_coregroup_support()) {
+		powerpc_topology[i++] = (struct sched_domain_topology_level){
+			cpu_mc_mask, powerpc_shared_proc_flags, SD_INIT_NAME(MC)
+		};
+	}
+	powerpc_topology[i++] = (struct sched_domain_topology_level){
+		cpu_cpu_mask, powerpc_shared_proc_flags, SD_INIT_NAME(PKG)
+	};
 
-	if (!has_coregroup_support())
-		powerpc_topology[mc_idx].mask = powerpc_topology[cache_idx].mask;
-
-	/*
-	 * Try to consolidate topology levels here instead of
-	 * allowing scheduler to degenerate.
-	 * - Dont consolidate if masks are different.
-	 * - Dont consolidate if sd_flags exists and are different.
-	 */
-	for (i = 1; i <= die_idx; i++) {
-		if (powerpc_topology[i].mask != powerpc_topology[i - 1].mask)
-			continue;
-
-		if (powerpc_topology[i].sd_flags && powerpc_topology[i - 1].sd_flags &&
-				powerpc_topology[i].sd_flags != powerpc_topology[i - 1].sd_flags)
-			continue;
-
-		if (!powerpc_topology[i - 1].sd_flags)
-			powerpc_topology[i - 1].sd_flags = powerpc_topology[i].sd_flags;
+	/* There must be one trailing NULL entry left.  */
+	BUG_ON(i >= ARRAY_SIZE(powerpc_topology) - 1);
 
-		powerpc_topology[i].mask = powerpc_topology[i + 1].mask;
-		powerpc_topology[i].sd_flags = powerpc_topology[i + 1].sd_flags;
-#ifdef CONFIG_SCHED_DEBUG
-		powerpc_topology[i].name = powerpc_topology[i + 1].name;
-#endif
-	}
+	set_sched_topology(powerpc_topology);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
@@ -1758,9 +1738,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 		smp_ops->bringup_done();
 
 	dump_numa_cpu_topology();
-
-	fixup_topology();
-	set_sched_topology(powerpc_topology);
+	build_sched_topology();
 }
 
 /*
-- 
2.35.3

