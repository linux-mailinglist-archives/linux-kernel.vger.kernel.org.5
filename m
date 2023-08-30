Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7D278DFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjH3TQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243397AbjH3Kx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:53:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DE0198
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:53:56 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UAj1RL013253;
        Wed, 30 Aug 2023 10:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=p1536vICVb0rZUOKwlhXoq2rY6srk3fPOzW2dix0Q+8=;
 b=Ii08+nFc1g4pUKwgwmieTwa2oYVzOU+nkwH3eS/RZyeUsG2zO2M8+mrLvffzRdTs6Rir
 a1c0xtDcvLBp9Nxp4LLHBtnqeSa/lmc3jerCoRQyuQwv/OydTdZaWPRDRI2nSvEv1GAc
 yEDZs8RJmXAyCuq9B4EvFMeJoZvYQcASgnshXd1avSZmQ3vFvkjOGKXKvo//TiJJNmqH
 M+98vQR2+vVQ8hQ/ptAZndY7oi0PDkHxql7YexS4Cf259okNGkiz7JoHhvLVL81gzai6
 wIoXTnqRvVZ02F+D7eIju9YyJql7c4Y9bBGAV87bDVG1YkfgbiUliWdEAYwlzps1yWzT DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st3t3134j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:53:40 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37UAKSYf010818;
        Wed, 30 Aug 2023 10:53:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st3t3133u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:53:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UAA7eI020180;
        Wed, 30 Aug 2023 10:53:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3ykdy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:53:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UArbN84457000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 10:53:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10C852004B;
        Wed, 30 Aug 2023 10:53:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C9A820040;
        Wed, 30 Aug 2023 10:53:33 +0000 (GMT)
Received: from saptarishi.in.ibm.com (unknown [9.43.8.96])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Aug 2023 10:53:33 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul E McKenney <paulmck@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] powerpc/smp: Enable Asym packing for cores on shared processor
Date:   Wed, 30 Aug 2023 16:22:43 +0530
Message-ID: <20230830105244.62477-4-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830105244.62477-1-srikar@linux.vnet.ibm.com>
References: <20230830105244.62477-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BftQwLdOMDjas-OImbDKJRgwirAi14Fm
X-Proofpoint-GUID: 0TVRk970mXoAX8PaiOSvOXwPnnTTfFK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308300098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are shared processor lpars, underlying Hypervisor can have more
virtual cores to handle that actual physical cores.

Starting with Power 9, a core has 2 nearly independent thread groups.
On a shared processors lpars, it helps to pack threads to lesser number
of cores so that the overall system performance and utilization
improves. PowerVM schedules at a core level. Hence packing to fewer
cores helps.

For example: Lets says there are two 8-core Shared lpars that are
actually sharing a 8 Core shared physical pool, each running 8 threads
each. Then Consolidating 8 threads to 4 cores on each lpar would help
them to perform better.

To achieve this, enable SD_ASYM_PACKING flag at CACHE, MC and DIE level.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index c7d1484ed230..51403640440c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1005,7 +1005,12 @@ static int powerpc_smt_flags(void)
  */
 static int powerpc_shared_cache_flags(void)
 {
-	return SD_SHARE_PKG_RESOURCES;
+	return SD_SHARE_PKG_RESOURCES | asym_pack_flag;
+}
+
+static int powerpc_shared_proc_flags(void)
+{
+	return asym_pack_flag;
 }
 
 /*
@@ -1044,8 +1049,8 @@ static struct sched_domain_topology_level powerpc_topology[] = {
 	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
 #endif
 	{ shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE) },
-	{ cpu_mc_mask, SD_INIT_NAME(MC) },
-	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ cpu_mc_mask, powerpc_shared_proc_flags, SD_INIT_NAME(MC) },
+	{ cpu_cpu_mask, powerpc_shared_proc_flags, SD_INIT_NAME(DIE) },
 	{ NULL, },
 };
 
@@ -1671,7 +1676,9 @@ static void __init fixup_topology(void)
 {
 	int i;
 
-	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
+	if (is_shared_processor()) {
+		asym_pack_flag = SD_ASYM_PACKING;
+	} else if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
 		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
 		asym_pack_flag = SD_ASYM_PACKING;
 	}
-- 
2.41.0

