Return-Path: <linux-kernel+bounces-3123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971A8167A6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF311F22E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95BD1094F;
	Mon, 18 Dec 2023 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="klnx9C8E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9833CF9D9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI7c4TH008028;
	Mon, 18 Dec 2023 07:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O+m799fDNDuTFzAl1Uz02x4uU4icAhsA+6Orlujt//4=;
 b=klnx9C8EMOskCaRlEPTCgPTo6Ym/UfjJrX+7NQH9Z/iNWNOWsixPSlcTmFR0mjcUoa2C
 vgBvtqXlV+P/zbzAxiS5nVOZ92cQDB3EjmY3ZT1nR8ULaGcFYJ8rtt6XciEAME3yvqOx
 T+GulfHNmzB4Q6dZl3alpSjDxDQDc5Y+UA+We4LPZTQRS6du9TAg/zEtK8EXITnaNlqh
 CK4NYT18egv2C+UkpYyuI3xsw7k0p9btuU43obUuIHAfVLA0HFVCaH+41BjBUq+tR5FZ
 4H3odmoVdsuR2M7EcIDIW6qQ8qG8DNQ29dnK0m8Q9eNuZ1AUJyyNDMybEoWBC7v71xcm 1w== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2huvg5ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:45:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI7QqN4027073;
	Mon, 18 Dec 2023 07:45:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rejq3kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:45:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BI7jO6U16122450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 07:45:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5986120040;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4624E2004B;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 11E17E0826; Mon, 18 Dec 2023 08:45:24 +0100 (CET)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v2 1/3] entry: move exit to usermode functions to header file
Date: Mon, 18 Dec 2023 08:45:18 +0100
Message-Id: <20231218074520.1998026-2-svens@linux.ibm.com>
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
X-Proofpoint-GUID: ONIUIVRsCoRPg6BhrHZAaXm3D6pucdIT
X-Proofpoint-ORIG-GUID: ONIUIVRsCoRPg6BhrHZAaXm3D6pucdIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_04,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=763
 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180054

To allow inlining, move exit_to_user_mode() to
entry-common.h.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/entry-common.h | 52 +++++++++++++++++++++++++++++++++++-
 kernel/entry/common.c        | 50 +++++-----------------------------
 2 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d95ab85f96ba..b08aceb26e8e 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -7,6 +7,10 @@
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
+#include <linux/context_tracking.h>
+#include <linux/livepatch.h>
+#include <linux/resume_user_mode.h>
+#include <linux/tick.h>
 
 #include <asm/entry-common.h>
 
@@ -258,6 +262,42 @@ static __always_inline void arch_exit_to_user_mode(void) { }
  */
 void arch_do_signal_or_restart(struct pt_regs *regs);
 
+/**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ */
+unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+				     unsigned long ti_work);
+
+/**
+ * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
+ *
+ * 1) check that interrupts are disabled
+ * 2) call tick_nohz_user_enter_prepare()
+ * 3) call exit_to_user_mode_loop() if any flags from
+ *    EXIT_TO_USER_MODE_WORK are set
+ * 4) check that interrupts are still disabled
+ */
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long ti_work;
+
+	lockdep_assert_irqs_disabled();
+
+	/* Flush pending rcuog wakeup before the last need_resched() check */
+	tick_nohz_user_enter_prepare();
+
+	ti_work = read_thread_flags();
+	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+		ti_work = exit_to_user_mode_loop(regs, ti_work);
+
+	arch_exit_to_user_mode_prepare(regs, ti_work);
+
+	/* Ensure that kernel state is sane for a return to userspace */
+	kmap_assert_nomap();
+	lockdep_assert_irqs_disabled();
+	lockdep_sys_exit();
+}
+
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
@@ -276,7 +316,17 @@ void arch_do_signal_or_restart(struct pt_regs *regs);
  * non-instrumentable.
  * The caller has to invoke syscall_exit_to_user_mode_work() before this.
  */
-void exit_to_user_mode(void);
+static __always_inline void exit_to_user_mode(void)
+{
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare();
+	instrumentation_end();
+
+	user_enter_irqoff();
+	arch_exit_to_user_mode();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
 
 /**
  * syscall_exit_to_user_mode_work - Handle work before returning to user mode
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d7ee4bc3f2ba..113bd3e8e73e 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -123,29 +123,14 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 	instrumentation_end();
 }
 
-/* See comment for exit_to_user_mode() in entry-common.h */
-static __always_inline void __exit_to_user_mode(void)
-{
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare();
-	instrumentation_end();
-
-	user_enter_irqoff();
-	arch_exit_to_user_mode();
-	lockdep_hardirqs_on(CALLER_ADDR0);
-}
-
-void noinstr exit_to_user_mode(void)
-{
-	__exit_to_user_mode();
-}
-
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
-static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-					    unsigned long ti_work)
+/**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ */
+__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+						     unsigned long ti_work)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -190,27 +175,6 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 	return ti_work;
 }
 
-static void exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long ti_work;
-
-	lockdep_assert_irqs_disabled();
-
-	/* Flush pending rcuog wakeup before the last need_resched() check */
-	tick_nohz_user_enter_prepare();
-
-	ti_work = read_thread_flags();
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
-
-	arch_exit_to_user_mode_prepare(regs, ti_work);
-
-	/* Ensure that kernel state is sane for a return to userspace */
-	kmap_assert_nomap();
-	lockdep_assert_irqs_disabled();
-	lockdep_sys_exit();
-}
-
 /*
  * If SYSCALL_EMU is set, then the only reason to report is when
  * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
@@ -295,7 +259,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	__syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
-	__exit_to_user_mode();
+	exit_to_user_mode();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
@@ -308,7 +272,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	__exit_to_user_mode();
+	exit_to_user_mode();
 }
 
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
-- 
2.40.1


