Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A765D7E636D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjKIFun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjKIFud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:50:33 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C91BD7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:50:31 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A95lce2015558;
        Thu, 9 Nov 2023 05:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=N7am5QLVzzx8O8JCxpQgP7g2QAN9Pmg/pFTC6I0PJF0=;
 b=G0lnM0cibPWcIIeJEyNB3HIBk4cZ1pSqqa0yRy+mD/ajPSKGT7aoVZUmgMbKIjg3r5MZ
 UU8BRIazKDjBYBos3+rD1UgC/n8s2yTymInUeN8MIC2su8aGtI5ef0PKym4S7mjF31lQ
 Fado+/gsoH/m6eyDQFTMrZTrZQhQ+EKggkz/XK3SkVtSnitnoywkal9qfbaUdlWDBa2L
 NvBryncYGu5AvLAMc4IUYRhtXdf11QdfS+lprexpMej5Zu3PDGCDIV8Ty67ne1eNXfx9
 jIMSQOGfxO4m+YiCUyf6r1/T+Y1g81VTz1Eb60dDZx6yM3AIC+Q/V3LJFADiXOwmkWi+ 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8s201f77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 05:50:10 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A95nFnt021854;
        Thu, 9 Nov 2023 05:50:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8s201f6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 05:50:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A94rlc5000726;
        Thu, 9 Nov 2023 05:50:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w231tub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 05:50:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A95o6xg29229758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Nov 2023 05:50:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB8C220040;
        Thu,  9 Nov 2023 05:50:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 652DC20043;
        Thu,  9 Nov 2023 05:50:04 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.109.198.19])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Nov 2023 05:50:04 +0000 (GMT)
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
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: [PATCH v4 3/5] powerpc/smp: Add __ro_after_init attribute
Date:   Thu,  9 Nov 2023 11:19:31 +0530
Message-ID: <20231109054938.26589-4-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231109054938.26589-1-srikar@linux.vnet.ibm.com>
References: <20231109054938.26589-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PSDQxOS8L3g2JqApkrUVbOG1x477vcUC
X-Proofpoint-ORIG-GUID: ni8jdxWrzvgFhFjKjWh9iEw0rR7Ho9aR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_04,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some variables that are only updated at boot time.
So add __ro_after_init attribute to such variables

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog:
v2 -> v3:
Use __ro_after_init instead of __read_mostly
Suggested by : Peter Zijlstra and Michael Ellerman

 arch/powerpc/kernel/smp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 1dae4e9ba42d..65a6f988374a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -77,10 +77,10 @@ static DEFINE_PER_CPU(int, cpu_state) = { 0 };
 #endif
 
 struct task_struct *secondary_current;
-bool has_big_cores;
-bool coregroup_enabled;
-bool thread_group_shares_l2;
-bool thread_group_shares_l3;
+bool has_big_cores __ro_after_init;
+bool coregroup_enabled __ro_after_init;
+bool thread_group_shares_l2 __ro_after_init;
+bool thread_group_shares_l3 __ro_after_init;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_smallcore_map);
@@ -987,7 +987,7 @@ static int __init init_thread_group_cache_map(int cpu, int cache_property)
 	return 0;
 }
 
-static bool shared_caches;
+static bool shared_caches __ro_after_init;
 
 #ifdef CONFIG_SCHED_SMT
 /* cpumask of CPUs with asymmetric SMT dependency */
-- 
2.31.1

