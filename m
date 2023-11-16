Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015087EE19A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345203AbjKPNh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjKPNhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:37:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D424BA0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:37:18 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGDMXZj008819;
        Thu, 16 Nov 2023 13:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5tT2x94kITssepSoUFE+QAGQdO98GI5ZAe4RJoDR/JU=;
 b=Fd7p7ZGrJSCx9KIfin4lIIDTYYY9XuXpFSKoZUqA7la97Zwt+DwwJBuQyvMXPEvQk5c8
 Dh0Irw14HMlG7zn81B5/mejnQHGrpm9RgLHIgiKhoMdh9pTkoZ6LXuQGsYE6rNJeYGuc
 RKjizKWgZ8Q7AEQqrL2ztSIyRgVhbMOu7xzdD8s2t4COT1yg9l2z4z8IPzqZ/KLVcno1
 S8Q9HTPDlq07VHdv8WKxzxhGlxkjkc9100thhFySjMJ/KdDVj1JPeGHtLjL/neA5nHS3
 BsTrYnXgGfF5YSLbu1NzqlI9ohCkbmp5a01f6xzM+wnyIfhF6MWtt5gHKhLBCvnyVfXG cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udkwg8e6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:36:43 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGDMvaD010277;
        Thu, 16 Nov 2023 13:36:42 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udkwg8e5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:36:42 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGBgIbt004493;
        Thu, 16 Nov 2023 13:36:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5keewj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 13:36:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGDad7k17433296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 13:36:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C75A920040;
        Thu, 16 Nov 2023 13:36:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FD6E20063;
        Thu, 16 Nov 2023 13:36:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Nov 2023 13:36:39 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arch: remove ARCH_TASK_STRUCT_ON_STACK
Date:   Thu, 16 Nov 2023 14:36:38 +0100
Message-Id: <20231116133638.1636277-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116133638.1636277-1-hca@linux.ibm.com>
References: <20231116133638.1636277-1-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N2-JIjbstfip17sUPrL72h-OBexE9a0g
X-Proofpoint-GUID: TKL22pshACc6f3uKkVoxltfhl9qA5IP1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_13,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA-64 was the only architecture which selected ARCH_TASK_STRUCT_ON_STACK.
IA-64 was removed with commit cf8e8658100d ("arch: Remove Itanium (IA-64)
architecture"). Therefore remove support for ARCH_TASK_STRUCT_ON_STACK
as well.

Note: this also reveals a potential bug in powerpc code, which makes use of
__init_task_data without selecting ARCH_TASK_STRUCT_ON_STACK which makes
__init_task_data a no-op. This is broken since commit d11ed3ab3166 ("Expand
INIT_TASK() in init/init_task.c and remove") from 2018 and needs to be
addressed separately.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/Kconfig                 |  4 ----
 arch/powerpc/kexec/core_64.c |  3 +--
 include/linux/init_task.h    |  7 -------
 include/linux/sched.h        |  2 --
 init/init_task.c             | 10 ++--------
 5 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c2f87ef9f0ae..bfcc7c2dc039 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -301,10 +301,6 @@ config ARCH_HAS_DMA_CLEAR_UNCACHED
 config ARCH_HAS_CPU_FINALIZE_INIT
 	bool
 
-# Select if arch init_task must go in the __init_task_data section
-config ARCH_TASK_STRUCT_ON_STACK
-	bool
-
 config HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	bool
 	help
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 0bee7ca9a77c..762e4d09aacf 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -283,8 +283,7 @@ static void kexec_prepare_cpus(void)
  * We could use a smaller stack if we don't care about anything using
  * current, but that audit has not been performed.
  */
-static union thread_union kexec_stack __init_task_data =
-	{ };
+static union thread_union kexec_stack = { };
 
 /*
  * For similar reasons to the stack above, the kexecing CPU needs to be on a
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 40fc5813cf93..bccb3f1f6262 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -37,13 +37,6 @@ extern struct cred init_cred;
 
 #define INIT_TASK_COMM "swapper"
 
-/* Attach to the init_task data structure for proper alignment */
-#ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
-#define __init_task_data __section(".data..init_task")
-#else
-#define __init_task_data /**/
-#endif
-
 /* Attach to the thread_info data structure for proper alignment */
 #define __init_thread_info __section(".data..init_thread_info")
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..c2ecb2e06046 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1955,9 +1955,7 @@ extern void ia64_set_curr_task(int cpu, struct task_struct *p);
 void yield(void);
 
 union thread_union {
-#ifndef CONFIG_ARCH_TASK_STRUCT_ON_STACK
 	struct task_struct task;
-#endif
 #ifndef CONFIG_THREAD_INFO_IN_TASK
 	struct thread_info thread_info;
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index 5727d42149c3..6f6485d554df 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -51,8 +51,7 @@ static struct sighand_struct init_sighand = {
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
-unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
-		__init_task_data = {
+unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)] = {
 	[(SCS_SIZE / sizeof(long)) - 1] = SCS_END_MAGIC
 };
 #endif
@@ -61,12 +60,7 @@ unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)]
  * Set up the first task table, touch at your own risk!. Base=0,
  * limit=0x1fffff (=2MB)
  */
-struct task_struct init_task
-#ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
-	__init_task_data
-#endif
-	__aligned(L1_CACHE_BYTES)
-= {
+struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	.thread_info	= INIT_THREAD_INFO(init_task),
 	.stack_refcount	= REFCOUNT_INIT(1),
-- 
2.39.2

