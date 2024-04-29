Return-Path: <linux-kernel+bounces-161761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3020A8B50D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CD81F22011
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646F5F9CD;
	Mon, 29 Apr 2024 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Adpq5CPz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD61119F;
	Mon, 29 Apr 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370116; cv=none; b=dUeIsbg9bQ1NiqsIZOU+3Z0OQ1gDNGlBnaeAv9BlCkTrKU0tijTWiWQB0BR7Qk3BRgvsXX15s9j3n3/4L7mh9jTePo2+1Ek2Lf3L88J/IziUxlSANcUca8pOxxa6cDOHwjtDvL/DalKv3e2r1WXgXQC4KborQKKCzHIVhjAcF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370116; c=relaxed/simple;
	bh=RpSffKBYdZJHtJT6BEJldCAqUGT6J1+z9IACpC9e4bw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OEz5UmKDmzljTDXlMG5guRZf1dBFGMPZeT0wQZspLHtMMAIY2cgJhBq7mtUyTF/RU3sUtIHvRLaodEg2QWhZBPx7QFK+zOe/wPZTlrTWsPeyxYuUnglBdu6bkKquNdACG1kRX+K8fDzf3ruaot7KD6i2cGlTbnyukUXkkp9NEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Adpq5CPz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43T4oJnU021349;
	Mon, 29 Apr 2024 05:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=cNxs2TQAt/Gjy+68TESEKnKwZfqi+c0s1TOQ+rGD0Gc=;
 b=Adpq5CPzUBrV/q5gLBQPQQyEirSZeqT+8f+l91DONSXqux+zPmw+gPVtMakAEErAbSXD
 kqXdcpCKCVNvN5cLfAVjpXKTSrAbqliXrlkJN2fRD+T3cBNSJW0+SWQWao1jWxahk/dr
 agdgHaUmrZ2TUxB46Zj419pTwEMEgc2zJSBnt1RjfBjyOREcvMqM2HmyFno+Md3p2FN6
 axNFtzHDCJQyioRjHoogAWbesBTJxn7XtBjJSFPGiiGwkyUXizhnehpngM8+nOHhDx5s
 Ob3egMdqnRbL5LU4KSRMUD1aYR8eFcp5U79UJ3H/fzNij8nbeVzzpzo0z+L95J90EiFm gA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt1yn8ahu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 05:54:31 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43T5sVDL018481;
	Mon, 29 Apr 2024 05:54:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xt1yn8ahp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 05:54:31 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43T1qmHC015545;
	Mon, 29 Apr 2024 05:54:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsed2n5we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 05:54:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43T5sQhC43385190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 05:54:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 575FD2004E;
	Mon, 29 Apr 2024 05:54:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 444CD2004D;
	Mon, 29 Apr 2024 05:54:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 29 Apr 2024 05:54:26 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id D00CEE082E; Mon, 29 Apr 2024 07:54:25 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: Test online status in available_idle_cpu()
Date: Mon, 29 Apr 2024 07:54:15 +0200
Message-Id: <20240429055415.3278672-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: It9T9tFBeBRTt7wpgRGL86vUJr4uVOoq
X-Proofpoint-ORIG-GUID: -qZoA8vCQ80tkAysgnCFlRyAJAlThVxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_03,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290038

The current implementation of available_idle_cpu() doesn't test
whether a possible cpu is offline. On s390 this dereferences a
NULL pointer in arch_vcpu_is_preempted() because lowcore is not
allocated for offline cpus. On x86, tracing also shows calls to
available_idle_cpu() after a cpu is disabled, but it looks like
this isn't causing any (obvious) issue. Nevertheless, add a check
and return early if the cpu isn't online.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 kernel/sched/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..1d9b80411594 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7434,6 +7434,9 @@ int idle_cpu(int cpu)
  */
 int available_idle_cpu(int cpu)
 {
+	if (!cpu_online(cpu))
+		return 0;
+
 	if (!idle_cpu(cpu))
 		return 0;
 
-- 
2.40.1


