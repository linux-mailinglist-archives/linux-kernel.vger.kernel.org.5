Return-Path: <linux-kernel+bounces-13892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626CD821449
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7063C1C20BD0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C53613D;
	Mon,  1 Jan 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jVr6MTxx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412106107
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 401EMPll003341;
	Mon, 1 Jan 2024 15:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SufSkMLZ9lbRVTW9toedV2+dZWWyVTtj22JQ9KisuS0=;
 b=jVr6MTxxie9WrNxl28goaGRhhP3oMsuGtYhbXfDgirQe1AfNWt2yHzXOO0OApxEyjO/G
 rD8KZ33ksfDLnHUCd/0eTT1/7fsB3rj8cm2miFtXj3ehRvmJ3sUlCj3H4uRMIhLsgA2R
 EXjMlm73CbwtI1eTNdL4y+DlEpbH06JJaoyj3Rp1MLCxuAsV24/W9tpSP4wCGAsmrpUa
 8hgRQAkiBk2v5Xjm42BvtLili3UvnglTaUJn4BauroVqwdeRGP2Yg8dtEDrKktHNcwlz
 xRojzA4TaD7KFZvAjhoDxL+kpnQXo3w7ndsdnc8LvbJucQzANUYEEtmJILN8fMUZTBl5 qw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vbxu09ak6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jan 2024 15:48:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 401DFlMg027288;
	Mon, 1 Jan 2024 15:46:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vawht0e1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jan 2024 15:46:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 401FkoFf56361364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jan 2024 15:46:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EDB42004B;
	Mon,  1 Jan 2024 15:46:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1840C20040;
	Mon,  1 Jan 2024 15:46:48 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.171.34.133])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jan 2024 15:46:47 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        yu.c.chen@intel.com, tim.c.chen@linux.intel.com
Subject: [PATCH v2 1/2] sched: use existing helper functions to access ->avg_rt and ->avg_dl
Date: Mon,  1 Jan 2024 21:16:23 +0530
Message-Id: <20240101154624.100981-2-sshegde@linux.vnet.ibm.com>
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
X-Proofpoint-GUID: 2KPE-ni4x0owkFT_yYSiltffWAWWqfhb
X-Proofpoint-ORIG-GUID: 2KPE-ni4x0owkFT_yYSiltffWAWWqfhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-01_08,2024-01-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=923 priorityscore=1501 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401010128

There are helper functions called cpu_util_dl and cpu_util_rt which gives
the average utilization of DL and RT respectively. But there are few
places in code where these variables are used directly.

Instead use the helper function so that code becomes simpler and easy to
maintain later on. This patch doesn't intend any functional changes.

Signed-off-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bcea3d55d95d..1aeca3f943a8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9212,10 +9212,10 @@ static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)

 static inline bool others_have_blocked(struct rq *rq)
 {
-	if (READ_ONCE(rq->avg_rt.util_avg))
+	if (cpu_util_rt(rq))
 		return true;

-	if (READ_ONCE(rq->avg_dl.util_avg))
+	if (cpu_util_dl(rq))
 		return true;

 	if (thermal_load_avg(rq))
@@ -9481,8 +9481,8 @@ static unsigned long scale_rt_capacity(int cpu)
 	 * avg_thermal.load_avg tracks thermal pressure and the weighted
 	 * average uses the actual delta max capacity(load).
 	 */
-	used = READ_ONCE(rq->avg_rt.util_avg);
-	used += READ_ONCE(rq->avg_dl.util_avg);
+	used = cpu_util_rt(rq);
+	used += cpu_util_dl(rq);
 	used += thermal_load_avg(rq);

 	if (unlikely(used >= max))
--
2.39.3


