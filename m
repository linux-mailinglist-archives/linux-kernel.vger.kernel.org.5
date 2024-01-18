Return-Path: <linux-kernel+bounces-29838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF899831436
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76F01C23022
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310ED219E8;
	Thu, 18 Jan 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FqnT8Vdu"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726220B0F;
	Thu, 18 Jan 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565084; cv=none; b=agwOeyCIlWmUv4OfRuvGgKGS0uGbWZgsZPir0ITJ91SMcogCpTH3beLP5IiWygX/s6eWbyw+mnJ1FacVLVlWwJkf/GXGbF87Vlzo5yq1/WoKseqQBs4NuWVOZOEX7aQa3XGvY+f3c555UMorvnc7JaCRRvarj6/BagXyvZvaKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565084; c=relaxed/simple;
	bh=K8eg0pqC+sIW1kI2LZK1mp+VToCJVbHNLbydGcE1ljk=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=YIukj/N9dFLbgHHUwk6Up9GZ6ZtxDwdidgMxXEi68NX44EcyK7frdSQaqweY8xMHT4eZOO9LPTa/rcO0qw2UH15zMHR3g68BSoX+q3QhnUpeDGriV6qbSd0QfKN/zhqpsAh1E4gexOVPha5O04Q1E7ulLM3pYMxLhDI4pnIb6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FqnT8Vdu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40I7vMeD011578;
	Thu, 18 Jan 2024 08:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=he2i3jOgA8ugAT3gEAoGWdurDGiSbKEL1Suh3vTdnWQ=;
 b=FqnT8Vdu+4klNVAUZNOFJmePrzOyFXCDdMuhtEEUFUIQMhwAzmZSuaztVMjfuzWcGrS+
 wmepl0Qk64klA1q/8MSAWI/LuFnKEpQsXhSWtD3fiYsf9pTGhnmE92y4DHkHfdAMDKfU
 o+WxFX4KVKYRWVO2VR6pmmurMwIM6U8V7AONGVztE8cSYr8M2j87B8UUTM+pfagTpYkd
 P3M6VsZtiFLdZVxIuDn3FpHKye4a0CJpZf8HnmQxtfbAko/z468v1jPdM1ZfcO6DOfBd
 KbLrGtSKuwNw/FHp1r7+v8Dx8bv4SkgdXqwGNMT3dv84t2UFPJOtc2uDGkqJ3pGVB/Rt fw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq02206hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 08:04:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40I74lOb011009;
	Thu, 18 Jan 2024 08:04:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm57ytc11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 08:04:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40I845W424707822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 08:04:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55C0120040;
	Thu, 18 Jan 2024 08:04:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F279320043;
	Thu, 18 Jan 2024 08:04:02 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.in.ibm.com (unknown [9.109.201.126])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jan 2024 08:04:02 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, mingo@kernel.org,
        peterz@infradead.org, chandan.babu@oracle.com, anton@tuxera.com
Subject: [RFC PATCH 1/3] sched: remove duplicate ifdefs
Date: Thu, 18 Jan 2024 13:33:24 +0530
Message-Id: <20240118080326.13137-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240118080326.13137-1-sshegde@linux.ibm.com>
References: <20240118080326.13137-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3PWccwYfkYM-DHA16-RytUKNot96V0J9
X-Proofpoint-GUID: 3PWccwYfkYM-DHA16-RytUKNot96V0J9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=961
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180056

when a ifdef is used in the below manner, second one could be considered as
duplicate.

ifdef DEFINE_A
..code block...
ifdef DEFINE_A
..code block...
endif
..code block...
endif

In the scheduler code, there are two places where above pattern can be
observed. Hence second ifdef is a duplicate and not needed.
Plus a minor comment update to reflect the else case.

No functional change is intended here. It only aims to improve code
readability.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c | 4 +---
 kernel/sched/fair.c | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 038eeaf76d2d..1bfb186fd67f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1792,7 +1792,6 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css);
 #endif

 #ifdef CONFIG_SYSCTL
-#ifdef CONFIG_UCLAMP_TASK
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static void uclamp_update_root_tg(void)
 {
@@ -1898,7 +1897,6 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	return result;
 }
 #endif
-#endif

 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
@@ -2065,7 +2063,7 @@ static void __init init_uclamp(void)
 	}
 }

-#else /* CONFIG_UCLAMP_TASK */
+#else /* !CONFIG_UCLAMP_TASK */
 static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
 static inline int uclamp_validate(struct task_struct *p,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f2bb83675e4a..6158a6752c25 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10166,10 +10166,8 @@ static int idle_cpu_without(int cpu, struct task_struct *p)
 	 * be computed and tested before calling idle_cpu_without().
 	 */

-#ifdef CONFIG_SMP
 	if (rq->ttwu_pending)
 		return 0;
-#endif

 	return 1;
 }
--
2.39.3


