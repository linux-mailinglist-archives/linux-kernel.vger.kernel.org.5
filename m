Return-Path: <linux-kernel+bounces-13891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C36821448
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B452817DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177BCBA37;
	Mon,  1 Jan 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JGdFAaCs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC118F68
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 401BPLfa015354;
	Mon, 1 Jan 2024 15:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SEi5QyF57QQotla5oo7Z73kTzQqNtaL/QU2bLCXWa3I=;
 b=JGdFAaCs26f/VLdE36CHeu3zNl5gYNOb1J+UxE9kO1n5csL7y6qnpqvaXZS7pl4cr9KB
 QnKpzjBBIji6/zzz9x+LlQihYgP6AHTvKbUFxRm5q23EKecsLNwcfQZkFOHc1bKCZDTk
 W7lIKrSaOsu0qef7hMzJDnYXPhonhJmt5LtNbj0LjVAEB7yvHLBwsYIimp64+Zqeq1BX
 RFUMFrQ1F2eoedofN8eII0dfwAjSq6s9/keFWC3SJGxz81R+Da+y0BTOdibAxjsTqLUW
 uu9UVZoUqAkfqEic223KIxtbo2e7ENkwWZtLEqTC+/WoLX/L3J3ptDmSxBP9jPjHuail JQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vb63fxfns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jan 2024 15:46:57 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 401DcplE027284;
	Mon, 1 Jan 2024 15:46:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vawht0e23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jan 2024 15:46:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 401FktLO5898766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jan 2024 15:46:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA8B92004D;
	Mon,  1 Jan 2024 15:46:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACEA520040;
	Mon,  1 Jan 2024 15:46:52 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.34.133])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jan 2024 15:46:52 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com
Subject: [PATCH v2 2/2] sched: add READ_ONCE and use existing helper function to access ->avg_irq
Date: Mon,  1 Jan 2024 21:16:24 +0530
Message-Id: <20240101154624.100981-3-sshegde@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240101154624.100981-1-sshegde@linux.vnet.ibm.com>
References: <20240101154624.100981-1-sshegde@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vN-6IJ68DUztn9UTzgfwZ0OgwTcitjLC
X-Proofpoint-ORIG-GUID: vN-6IJ68DUztn9UTzgfwZ0OgwTcitjLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-01_08,2024-01-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=645 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401010128

Use existing helper function cpu_util_irq instead of referencing it
directly.

It was noted that avg_irq could be updated by different CPU than the one
which is trying to access it. avg_irq is updated with WRITE_ONCE. Use
READ_ONCE to access it in order to avoid any compiler optimizations.

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 kernel/sched/fair.c  | 4 +---
 kernel/sched/sched.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1aeca3f943a8..02631060ca7e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9221,10 +9221,8 @@ static inline bool others_have_blocked(struct rq *rq)
 	if (thermal_load_avg(rq))
 		return true;

-#ifdef CONFIG_HAVE_SCHED_AVG_IRQ
-	if (READ_ONCE(rq->avg_irq.util_avg))
+	if (cpu_util_irq(rq))
 		return true;
-#endif

 	return false;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..edc20c5cc7ce 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3125,7 +3125,7 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
-	return rq->avg_irq.util_avg;
+	return READ_ONCE(rq->avg_irq.util_avg);
 }

 static inline
--
2.39.3


