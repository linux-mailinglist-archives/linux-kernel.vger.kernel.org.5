Return-Path: <linux-kernel+bounces-3122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A7C8167A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869801C22477
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751BA101EB;
	Mon, 18 Dec 2023 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IzalLcRh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38172E549
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI6bVgv013118;
	Mon, 18 Dec 2023 07:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4UDu3rXjlCqT3/8LyZBW7PcqrrzBck5KaR5LZIkTUkY=;
 b=IzalLcRhRzENzyt0C1DSRuVoarBB/h+izeB/Fd4L/dIbpIPbuNehZEH/1Sf19UVfntT/
 AhgeIRVmoQm5cRaGjSmEJ3beLt41ftwQ2KF5YOm1eVn3JH5mVVbuFpuHP9rRY83SPg+K
 xp7CpLzjfuW/QH7E83jrTWIzIacj80Y3qmjgJRoUiqDRjK7kLh03SGsSAV+RvfwS6vhO
 m9+MyBfVHqarPEj9MD8jsofVt7oQVNe8cK++CI1yTsIQ5v+Fo5lpNFxVi5lsZwqw3ur0
 iO/hRY0NIqkO+PaRgnDvAjdDIPhXrBfnoDf1gQy4ijZ4K7O7iFxAcfTiZ3V5IuZ6znb/ hg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v2gyj1p0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:45:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BI67Gdb010840;
	Mon, 18 Dec 2023 07:45:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7n7d8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:45:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BI7jOBf459510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 07:45:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 571752004D;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47C5020043;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 18 Dec 2023 07:45:24 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 15E80E16DA; Mon, 18 Dec 2023 08:45:24 +0100 (CET)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v2 3/3] entry: move syscall_enter_from_user_mode() to header file
Date: Mon, 18 Dec 2023 08:45:20 +0100
Message-Id: <20231218074520.1998026-4-svens@linux.ibm.com>
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
X-Proofpoint-GUID: wEVrj0xpU6k9jfWt2Y2zw8dxmkmnvpLB
X-Proofpoint-ORIG-GUID: wEVrj0xpU6k9jfWt2Y2zw8dxmkmnvpLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_04,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=799
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312180054

To allow inlining of syscall_enter_from_user_mode(), move it
to entry-common.h.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/entry-common.h | 27 +++++++++++++++++++++++++--
 kernel/entry/common.c        | 32 +-------------------------------
 2 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index e8f1e4bba1c1..4f8e467eaf3c 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -134,6 +134,9 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
  */
 void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
 
+long syscall_trace_enter(struct pt_regs *regs, long syscall,
+			 unsigned long work);
+
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
  *				       a syscall
@@ -157,7 +160,15 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
  *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
-long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
+static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+
+	if (work & SYSCALL_WORK_ENTER)
+		syscall = syscall_trace_enter(regs, syscall, work);
+
+	return syscall;
+}
 
 /**
  * syscall_enter_from_user_mode - Establish state and check and handle work
@@ -176,7 +187,19 @@ long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
  * Returns: The original or a modified syscall number. See
  * syscall_enter_from_user_mode_work() for further explanation.
  */
-long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
+static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	long ret;
+
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	local_irq_enable();
+	ret = syscall_enter_from_user_mode_work(regs, syscall);
+	instrumentation_end();
+
+	return ret;
+}
 
 /**
  * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index cd40cd1b4616..a35aaaa9f8bc 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -25,7 +25,7 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 	}
 }
 
-static long syscall_trace_enter(struct pt_regs *regs, long syscall,
+long syscall_trace_enter(struct pt_regs *regs, long syscall,
 				unsigned long work)
 {
 	long ret = 0;
@@ -65,36 +65,6 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	return ret ? : syscall;
 }
 
-static __always_inline long
-__syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-
-	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, syscall, work);
-
-	return syscall;
-}
-
-long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
-{
-	return __syscall_enter_from_user_work(regs, syscall);
-}
-
-noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
-{
-	long ret;
-
-	enter_from_user_mode(regs);
-
-	instrumentation_begin();
-	local_irq_enable();
-	ret = __syscall_enter_from_user_work(regs, syscall);
-	instrumentation_end();
-
-	return ret;
-}
-
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
-- 
2.40.1


