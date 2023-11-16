Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9518B7EE199
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjKPNhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjKPNhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:37:21 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D0B4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:37:17 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGDYf9J023843;
        Thu, 16 Nov 2023 13:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pde1pdLboIN8W79lmwAN4H0erhMLSWfQpdyYFspntGs=;
 b=LfrB8Ubl2famq3uk0WtJPTfbX4FbwWCxeUcgTpv/kOlWtRDdz0AiOMUVZ1ufESLL2exX
 EAL/6G9Z8ZG278I/pYreXq38n7nByJF+rPKc2AgQ4+Bdqffz+gu/oUyiA3w/dqsxPOzC
 7koTePUuK7jYauo0Yx1YI0Bcsjf7kMhQ3Ck0bp+pdm1D5ybr991USMH9Lm9a3yVYRxzs
 TzdKNMWio01KvflOebNwVS/js52Hnx49WdDAHSg2CejwddTifcM1dbqoNPp7arSO3PH7
 9HxeTjxqRjNkYZBa8dCUoxsyPk/lfxTgZD/jmXL6id0IUIfA5/HzY1RqRJXNBhCKJqO3 bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udm3381yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:36:42 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGDZCU6025730;
        Thu, 16 Nov 2023 13:36:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udm3381y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:36:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGBXwUV003431;
        Thu, 16 Nov 2023 13:36:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamayq3ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:36:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGDadk566519406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 13:36:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4600120040;
        Thu, 16 Nov 2023 13:36:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E32A2004B;
        Thu, 16 Nov 2023 13:36:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Nov 2023 13:36:38 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arch: remove ARCH_THREAD_STACK_ALLOCATOR
Date:   Thu, 16 Nov 2023 14:36:36 +0100
Message-Id: <20231116133638.1636277-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116133638.1636277-1-hca@linux.ibm.com>
References: <20231116133638.1636277-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p6x4_xx8h73lxdulrHPylu-IJ4kPqT57
X-Proofpoint-ORIG-GUID: qBotvUq9bJCcFlayRp5dJ458tEk6APPZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_13,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxlogscore=819
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA-64 was the only architecture which selected ARCH_THREAD_STACK_ALLOCATOR.
IA-64 was removed with commit cf8e8658100d ("arch: Remove Itanium (IA-64)
architecture"). Therefore remove support for ARCH_THREAD_STACK_ALLOCATOR as
well.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/Kconfig  |  4 ----
 kernel/fork.c | 20 --------------------
 2 files changed, 24 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f4b210ab0612..310162b41a1c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -320,10 +320,6 @@ config HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	  should be implemented. Without this, the entire thread_struct
 	  field in task_struct will be left whitelisted.
 
-# Select if arch has its private alloc_thread_stack() function
-config ARCH_THREAD_STACK_ALLOCATOR
-	bool
-
 # Select if arch wants to size task_struct dynamically via arch_task_struct_size:
 config ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	bool
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..d071809866e0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -179,8 +179,6 @@ static inline void free_task_struct(struct task_struct *tsk)
 }
 #endif
 
-#ifndef CONFIG_ARCH_THREAD_STACK_ALLOCATOR
-
 /*
  * Allocate pages if THREAD_SIZE is >= PAGE_SIZE, otherwise use a
  * kmemcache based allocator.
@@ -412,24 +410,6 @@ void thread_stack_cache_init(void)
 }
 
 # endif /* THREAD_SIZE >= PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
-#else /* CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
-
-static int alloc_thread_stack_node(struct task_struct *tsk, int node)
-{
-	unsigned long *stack;
-
-	stack = arch_alloc_thread_stack_node(tsk, node);
-	tsk->stack = stack;
-	return stack ? 0 : -ENOMEM;
-}
-
-static void free_thread_stack(struct task_struct *tsk)
-{
-	arch_free_thread_stack(tsk);
-	tsk->stack = NULL;
-}
-
-#endif /* !CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
 
 /* SLAB cache for signal_struct structures (tsk->signal) */
 static struct kmem_cache *signal_cachep;
-- 
2.39.2

