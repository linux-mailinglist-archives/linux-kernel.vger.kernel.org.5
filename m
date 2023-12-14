Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE0813970
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572964AbjLNSIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjLNSI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:08:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E0F10F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:08:36 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEH7jom021883;
        Thu, 14 Dec 2023 18:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OUH+C0ezyKyEtOL9TKhhIghiURzgcKtmNs+20CGoQwc=;
 b=XLqkKP0mLsrGCb7SG8V6UqNbAUIhb1y1fjgS7biWXsLeOlSBlfxVzCHCySHYNk/IXSjL
 jZtpzGuEOxm9wHUaLXfjqVVNMFqVBit87EnqvhNbHSGQvzoRbjPCkc4GsqGlwfIJSqKf
 E7yDiZXEBQ+X2d/+4fN5p10cETKVvpKbJSxYqsDJ/yyhQEo0H3PSXVl6bJxc8xtV2RCh
 2q7jFuNU3EqtyuoJGstIGT5LZhU0aIjQhaYU0e9Cj2iXjvDJUhHvQys8AlXhiYsxRofU
 M5Sj0OVJyMEKZZqOMBMzaE4Uljb5t6X0ROfEtYQ1yN7z90MI3erIEi/LElctV22oMsk8 CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v05twhpk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 18:08:19 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEI0g8Y010870;
        Thu, 14 Dec 2023 18:08:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v05twhpj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 18:08:18 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEDCpt9014872;
        Thu, 14 Dec 2023 18:08:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42khq36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 18:08:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEI8EnF19858004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 18:08:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C6B720049;
        Thu, 14 Dec 2023 18:08:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4345520040;
        Thu, 14 Dec 2023 18:08:11 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.43.25.55])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 18:08:11 +0000 (GMT)
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
Subject: [PATCH v5 4/5] powerpc/smp: Avoid asym packing within thread_group of a core
Date:   Thu, 14 Dec 2023 23:37:14 +0530
Message-ID: <20231214180720.310852-5-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214180720.310852-1-srikar@linux.vnet.ibm.com>
References: <20231214180720.310852-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IO7CDk5UPygVm4f-V16TLi17vuzR3x_6
X-Proofpoint-ORIG-GUID: ucutSOu7rVpx8hFOIisw2-9JCzvgQiOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_12,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

PowerVM Hypervisor will schedule at a core granularity. However each
core can have more than one thread_groups. For better utilization in
case of a shared processor, its preferable for the scheduler to pack to
the lowest core. However there is no benefit of moving a thread between
two thread groups of the same core.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index aea149627209..9d8bb9a084bd 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1763,6 +1763,19 @@ void __init smp_cpus_done(unsigned int max_cpus)
 	set_sched_topology(powerpc_topology);
 }
 
+/*
+ * For asym packing, by default lower numbered CPU has higher priority.
+ * On shared processors, pack to lower numbered core. However avoid moving
+ * between thread_groups within the same core.
+ */
+int arch_asym_cpu_priority(int cpu)
+{
+	if (static_branch_unlikely(&splpar_asym_pack))
+		return -cpu / threads_per_core;
+
+	return -cpu;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 int __cpu_disable(void)
 {
-- 
2.35.3

