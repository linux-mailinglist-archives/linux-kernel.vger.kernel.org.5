Return-Path: <linux-kernel+bounces-86565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1310B86C71C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA081F2866E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D330D7A703;
	Thu, 29 Feb 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PefuQPm3"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF47995E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203243; cv=none; b=gEfeA/fjaAz7Qg/aP8z8hkNa4jdKBk9NjqmvSDiwfW/W0udcPOpFbo3X7B4TTpQiCbKB4EsErBejUKmFIabpA/vTam8Hw8wWf2ZYF2PWXuIjWIsm8CH7Fxw61fA7ysFSVOd+lQizoGHGYTuGaIZpTRvfts0/nENnPLVpM9Y0P+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203243; c=relaxed/simple;
	bh=cjeOA8/3MZ9GSaia0NoWb8OwwjgJ0UgwMjyjw8jt2E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rdjqG23j7udYrQM8gMmNTuMzTAXskOwqUtGY4SKaUOpbkQFMyQqOoxnAUljp8Fd5qzsjwoYHGWeeherB/mboEYUdLuz6Cg5NuR3sgumdgttV17vQ1aZrTcE/+UYEfFDCkkZJ9uIrm9cfaLQyJVPwetUholJDpj+MEy2mlvFDLIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PefuQPm3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TAQVbU006088;
	Thu, 29 Feb 2024 10:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zV+9vBH6vsCvSgYAj6XucswUu11VRXhZKLGiY+vYcyQ=;
 b=PefuQPm3rPWq3V7iwUQUjef2QIZViwh40z/QMILGfw3dau21bLDsAQHUyZ4BTRESqakF
 dWSdsFva8sw/89JhRXN/p/mo04sZb97HYOmXOgerp+KbnjyDWLSIejWgtplK/w7fp7pW
 w3RLB4UDV7Srtv5Tlk02UtbK40p9s3nfmxP+TYbuTXg3bZMOjVI9su++4UsJTGqhr3fp
 hghg2VaQynYnZdS/eD/93O9OaJfEQN/gO1GCEuxr6VXoeTQKF5qLlCbPrgzp7YBioN6T
 dAWAOhVEfHlYym7OXY0l+Kkla17rX8+7ZaVRGcCxNbTaEWaZDxSYWJN9haRIvL+///pc sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjqp29kdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:40:32 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41TAQwCd009065;
	Thu, 29 Feb 2024 10:40:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wjqp29kda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:40:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41T8d4jj008189;
	Thu, 29 Feb 2024 10:40:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mmhhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 10:40:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41TAePlW38142414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 10:40:27 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DED720043;
	Thu, 29 Feb 2024 10:40:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8459D2004D;
	Thu, 29 Feb 2024 10:40:22 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Feb 2024 10:40:22 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, yu.c.chen@intel.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
        aboorvad@linux.ibm.com, srikar@linux.vnet.ibm.com, vschneid@redhat.com,
        pierre.gondois@arm.com, morten.rasmussen@arm.com, qyousef@layalina.io
Subject: [PATCH v3 2/2] sched/fair: Use helper function to access rd->overutilized
Date: Thu, 29 Feb 2024 16:10:10 +0530
Message-Id: <20240229104010.747411-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240229104010.747411-1-sshegde@linux.ibm.com>
References: <20240229104010.747411-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C932j5r432NVo8UmXx04ltx1gLOY9XGw
X-Proofpoint-ORIG-GUID: 2gRTWakppOBr9JJKC4aTAPAQwLes2hD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=805 phishscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402290081

Overutilized field is accessed directly in multiple places.
So it could use a helper function. That way one might be more
informed that it needs to be used only in case of EAS.

No change in functionality intended.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1f7d62b7c26f..99b5ddf92924 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6670,6 +6670,15 @@ static inline bool cpu_overutilized(int cpu)
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
 }

+/*
+ * Ensure that caller can do EAS. overutilized value
+ * make sense only if EAS is enabled
+ */
+static inline int is_rd_overutilized(struct root_domain *rd)
+{
+	return READ_ONCE(rd->overutilized);
+}
+
 static inline void set_rd_overutilized_status(struct root_domain *rd,
 					      unsigned int status)
 {
@@ -6686,13 +6695,14 @@ static inline void check_update_overutilized_status(struct rq *rq)
 	if (!sched_energy_enabled())
 		return;

-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+	if (!is_rd_overutilized(rq->rd) && cpu_overutilized(rq->cpu))
 		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 }
 #else
 static inline void check_update_overutilized_status(struct rq *rq) { }
 static inline void set_rd_overutilized_status(struct root_domain *rd,
 					      unsigned int status) { }
+static inline int is_rd_overutilized(struct root_domain *rd) { }
 #endif

 /* Runqueue only has SCHED_IDLE tasks enqueued */
@@ -7974,7 +7984,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)

 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
-	if (!pd || READ_ONCE(rd->overutilized))
+	if (!pd || is_rd_overutilized(rd))
 		goto unlock;

 	/*
@@ -10859,7 +10869,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (sched_energy_enabled()) {
 		struct root_domain *rd = env->dst_rq->rd;

-		if (rcu_dereference(rd->pd) && !READ_ONCE(rd->overutilized))
+		if (rcu_dereference(rd->pd) && !is_rd_overutilized(rd))
 			goto out_balanced;
 	}

--
2.39.3


