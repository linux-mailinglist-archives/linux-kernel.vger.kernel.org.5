Return-Path: <linux-kernel+bounces-3120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A90578167A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373E5B20F72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F37E57F;
	Mon, 18 Dec 2023 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hj91gRty"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3819FE553
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI7ZUOS011115;
	Mon, 18 Dec 2023 07:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GEniAdUQCRgZQi4eZ2dmeoTq2XuNKM3RqrVv1xpRjaQ=;
 b=Hj91gRtyb+4swPm66EqL/HxlZOlAg+zqSDPk2uJRuzHUQlen/h1EsScNh9Thhps/D236
 YjI5LL+PlQHfLVowR/2Xdz2/fpmX47deXo+ZMX4C4AXml14+Xo9CCQy6m/K8CUg3RUhB
 Gf+r+wLmr6/g54nPhyIy0dI+8lf5GUOsDV8xnVbZ5tr9sDQWwlezIM+5ivcfZoBrCvI6
 8L5JB4emlu5i1gTwi3Yh84twor+/WoaHnV6AQw767jbArVh3dGdA/vPhjkgXJDrFxNF1
 5/GIl+2QQAKfdl+xH5NsLUlOiHKzblP6VO9NXH4ieN50389b1WANFVWPSAW8pcHkHo3a EA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2dkmxp59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:45:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI6PnG4010904;
	Mon, 18 Dec 2023 07:45:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7n7d8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:45:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BI7jOS711993726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 07:45:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F80520043;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EECA20040;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 13E3FE1506; Mon, 18 Dec 2023 08:45:24 +0100 (CET)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v2 2/3] entry: move enter_from_user_mode() to header file
Date: Mon, 18 Dec 2023 08:45:19 +0100
Message-Id: <20231218074520.1998026-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231218074520.1998026-1-svens@linux.ibm.com>
References: <20231218074520.1998026-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tWRgv-oV7nog7uBoCnfkO3vE1TbX0oc8
X-Proofpoint-GUID: tWRgv-oV7nog7uBoCnfkO3vE1TbX0oc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_04,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=578 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180054

To allow inlining of enter_from_user_mode(), move it to
entry-common.h.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/entry-common.h | 15 ++++++++++++++-
 kernel/entry/common.c        | 26 +++-----------------------
 2 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b08aceb26e8e..e8f1e4bba1c1 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -11,6 +11,7 @@
 #include <linux/livepatch.h>
 #include <linux/resume_user_mode.h>
 #include <linux/tick.h>
+#include <linux/kmsan.h>
 
 #include <asm/entry-common.h>
 
@@ -102,7 +103,19 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
  * done between establishing state and enabling interrupts. The caller must
  * enable interrupts before invoking syscall_enter_from_user_mode_work().
  */
-void enter_from_user_mode(struct pt_regs *regs);
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	arch_enter_from_user_mode(regs);
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
+	CT_WARN_ON(__ct_state() != CONTEXT_USER);
+	user_exit_irqoff();
+
+	instrumentation_begin();
+	kmsan_unpoison_entry_regs(regs);
+	trace_hardirqs_off_finish();
+	instrumentation_end();
+}
 
 /**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 113bd3e8e73e..cd40cd1b4616 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -15,26 +15,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/* See comment for enter_from_user_mode() in entry-common.h */
-static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
-{
-	arch_enter_from_user_mode(regs);
-	lockdep_hardirqs_off(CALLER_ADDR0);
-
-	CT_WARN_ON(__ct_state() != CONTEXT_USER);
-	user_exit_irqoff();
-
-	instrumentation_begin();
-	kmsan_unpoison_entry_regs(regs);
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-
-void noinstr enter_from_user_mode(struct pt_regs *regs)
-{
-	__enter_from_user_mode(regs);
-}
-
 static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 {
 	if (unlikely(audit_context())) {
@@ -105,7 +85,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 {
 	long ret;
 
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 
 	instrumentation_begin();
 	local_irq_enable();
@@ -117,7 +97,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 	instrumentation_begin();
 	local_irq_enable();
 	instrumentation_end();
@@ -264,7 +244,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
-	__enter_from_user_mode(regs);
+	enter_from_user_mode(regs);
 }
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
-- 
2.40.1


