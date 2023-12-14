Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DAD812742
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 06:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443239AbjLNF4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 00:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjLNF4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 00:56:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B553610C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 21:56:40 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE2Uej9022139;
        Thu, 14 Dec 2023 05:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/mQKPh+Q/+oVqTYrm5JhFDCdjY5bZbTlHx3Tfk9a0cM=;
 b=HviIdLMX+gGsWGnJUfcgJ1zEBu48XMwnVfecoXiEmf6Tv6qT4swY5ic30eZT4ZCJaK7F
 2tVgJWOTwb1EQta+JtuvXkYe+n0LoOzO0x4ze5EeVexeEV/A7fH+4kL6KDkGSsOgKjCj
 n3tZsn8S9GAuTnCSmmgcNu1Cjo17RPYnwC/nKQ8EkuxfFKe8TLi/BQ2ZF1BYfO2gJBt2
 kK3hoq2EcfsjQfS67rq0cjnQe2/6PR3IwJUEIKI3IFGLHTIqHrioiAHQmyNZO+BxFiWr
 NcMVBwL3zgCKwv09Az1XFXvrpqEHElxwIXHgRZHZXQQqOjeTyQYS5IB1vpQm9hJaNkfS LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyjg3cj8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:27 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BE5r8A1026718;
        Thu, 14 Dec 2023 05:56:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyjg3cj7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:27 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE5cXLZ013892;
        Thu, 14 Dec 2023 05:56:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592dwf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 05:56:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BE5uOb944237272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 05:56:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C18920040;
        Thu, 14 Dec 2023 05:56:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B55CF20043;
        Thu, 14 Dec 2023 05:56:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 14 Dec 2023 05:56:23 +0000 (GMT)
Received: from nicholasmvm.. (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 92302606DB;
        Thu, 14 Dec 2023 16:56:19 +1100 (AEDT)
From:   Nicholas Miehlbradt <nicholas@linux.ibm.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc:     linux-mm@kvack.org, kasan-dev@googlegroups.com, iii@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nicholas Miehlbradt <nicholas@linux.ibm.com>
Subject: [PATCH 09/13] powerpc: Disable KMSAN checks on functions which walk the stack
Date:   Thu, 14 Dec 2023 05:55:35 +0000
Message-Id: <20231214055539.9420-10-nicholas@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231214055539.9420-1-nicholas@linux.ibm.com>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bbcuSHGLeoKEVuj7srCG-ZCZayTjEdOS
X-Proofpoint-GUID: KH91wVFkQGDFAZOFPfyiwzBaXkKHaRsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_02,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140035
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions which walk the stack read parts of the stack which cannot be
instrumented by KMSAN e.g. the backchain. Disable KMSAN sanitization of
these functions to prevent false positives.

Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
---
 arch/powerpc/kernel/process.c    |  6 +++---
 arch/powerpc/kernel/stacktrace.c | 10 ++++++----
 arch/powerpc/perf/callchain.c    |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 392404688cec..3dc88143c3b2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2276,9 +2276,9 @@ static bool empty_user_regs(struct pt_regs *regs, struct task_struct *tsk)
 
 static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
-void __no_sanitize_address show_stack(struct task_struct *tsk,
-				      unsigned long *stack,
-				      const char *loglvl)
+void __no_sanitize_address __no_kmsan_checks show_stack(struct task_struct *tsk,
+							unsigned long *stack,
+							const char *loglvl)
 {
 	unsigned long sp, ip, lr, newsp;
 	int count = 0;
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index e6a958a5da27..369b8b2a1bcd 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -24,8 +24,9 @@
 
 #include <asm/paca.h>
 
-void __no_sanitize_address arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
-					   struct task_struct *task, struct pt_regs *regs)
+void __no_sanitize_address __no_kmsan_checks
+	arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+			struct task_struct *task, struct pt_regs *regs)
 {
 	unsigned long sp;
 
@@ -62,8 +63,9 @@ void __no_sanitize_address arch_stack_walk(stack_trace_consume_fn consume_entry,
  *
  * If the task is not 'current', the caller *must* ensure the task is inactive.
  */
-int __no_sanitize_address arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
-						   void *cookie, struct task_struct *task)
+int __no_sanitize_address __no_kmsan_checks
+	arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
+				 struct task_struct *task)
 {
 	unsigned long sp;
 	unsigned long newsp;
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index 6b4434dd0ff3..c7610b38e9b8 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -40,7 +40,7 @@ static int valid_next_sp(unsigned long sp, unsigned long prev_sp)
 	return 0;
 }
 
-void __no_sanitize_address
+void __no_sanitize_address __no_kmsan_checks
 perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
 	unsigned long sp, next_sp;
-- 
2.40.1

