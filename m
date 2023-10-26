Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F57D8091
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbjJZKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjJZKUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:20:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAEC1AD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 03:20:07 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QAHWfG032578;
        Thu, 26 Oct 2023 10:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YBDR3xfHeXc4PXXXPf6+6t3Ew8ZiSTWP3/Vp9QG5Rkk=;
 b=XUsOWH/yGQ9ag0h3hM6bSSelnXtAmKXyPQQD+hbhBU55NjFDBUvkbTURAnJvvPmP0FGv
 CQBG5tLoLyvh14Ws2qFfrr68eNEyX8dr8Y2wHXB1NdtNAll5JCba9nuduMHks1tQUm1W
 iC3zLqpq5Oo8DnTt9YRwv0FZeBVW49NBXv7ETH5NMczF1ux0OaBCQh+1mfxC+BX1SGjO
 qbkBy/9w/dVT5cMV/jQYr+kXSTM5ZpsULEBvOKo89VdQPgWHQaCen5Y/+z8e7XTzmVs6
 j8F4pvpfhp8FpiOPSc+5ogW5R9n5ZjzxP+dWCXYVqiuVVlLKlrJ+Dr5UYrnQ5TuBLy6F Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3typ7q0689-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:19:53 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QAHXTD032615;
        Thu, 26 Oct 2023 10:19:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3typ7q060c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:19:47 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q8UThE010290;
        Thu, 26 Oct 2023 10:19:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbywj7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 10:19:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39QAJeBg19071632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 10:19:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C49FB2007D;
        Thu, 26 Oct 2023 10:19:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E1C320063;
        Thu, 26 Oct 2023 10:19:38 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.109.198.113])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Oct 2023 10:19:38 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH v3 3/5] powerpc/smp: Add __ro_after_init attribute
Date:   Thu, 26 Oct 2023 15:48:38 +0530
Message-ID: <20231026101843.56784-4-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231026101843.56784-1-srikar@linux.vnet.ibm.com>
References: <20231026101843.56784-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HEbHgCpkSz1qK7sff_3Gmr6F1XGUNHWo
X-Proofpoint-ORIG-GUID: f6quz0pZ4Pb_BBM3nfDVJI37scPTPy8w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_08,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 9fda012d9eca..27770f7f1ae5 100644
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
 /*
  * On shared processor LPARs scheduled on a big core (which has two or more
  * independent thread groups per core), then prefer lower numbered CPUs, so
-- 
2.31.1

