Return-Path: <linux-kernel+bounces-96525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DF2875D89
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E8F3B22C95
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED1831A83;
	Fri,  8 Mar 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtNQdM13"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75390E555
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709875426; cv=none; b=eXJgDHVcIHqAcdi294vsTf87Ywxo8kv1YJX5lyJGTWnroSxbQnPmmyX+z7Y4x2wuBSeQYAPXSe0f/i20prFE6h/vPOk05W/582Fk3xkqV/o4LAeH6jV/w71cMe99pHn2pF29wARdOouLda1cqTAezWTIfQ45DyBhfKalwMUPXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709875426; c=relaxed/simple;
	bh=kw7AJoKGkFmiWqvSYpogBR8yq/OQUri8BSmMIoNuHGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkemsxWuCedBlLCmIlOUJWxvQBaKzMj204/E8n7ev2v8fiYPtJGwEijage1W5ahqlnDd2ZorOSSKNmPCDPCGq2ZQYXK24mZovKJnPpfwogzYhfKNb8oqLWhx3IjXTRrSN3YiI9uc07NabcfqoDwnGSbfgxiU28kegyxfOtH6Ezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtNQdM13; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4285JorA004853;
	Fri, 8 Mar 2024 05:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6bPHqLmeoAnSxO9jAMkfq9TLxFp1tMawuGXGLO0w1Wk=;
 b=qtNQdM139deroJPZn0pd5bt7keW4roamSOlytHKOCNK8XGpW+IJ8NtG6a4UEy8gzL/Vc
 WhODHMrDk5w6UHNoWBx1nd2d4geNsXESxzHF7uojIOwqpzbN+jVdUhJxxGyVD2RsyPX4
 VZy05DPSUspw4Dv5/IFarRPDsLIMEs8sDmEX2yrm/sVXUKXV/VKH/dC2eKlfEHLOiRxV
 0OYvcZ+Zbg+QzQ5BDOb9dGZghOHDFkdrCZnkGXoEU1qXemJr32kYbrSWyFg1yrlt9Xi7
 lKd5zHNlaCKhfDvyUYSuChljd1ktnacIc8bbUiVFKvU8gfBV4TslKhycrA7YoYtX9PVp fQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqtx9s4p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 05:23:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4284W0gG026180;
	Fri, 8 Mar 2024 05:23:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wmfepae98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 05:23:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4285NWVN38601188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 05:23:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A07020040;
	Fri,  8 Mar 2024 05:23:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4388120043;
	Fri,  8 Mar 2024 05:23:31 +0000 (GMT)
Received: from li-5024144c-279b-11b2-a85c-93837c9a6aab.in.ibm.com (unknown [9.204.201.194])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 05:23:31 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org, linux-kernel@vger.kernel.org
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [RFC 1/1] sched: Deprecate DOUBLE_TICK feature
Date: Fri,  8 Mar 2024 10:53:04 +0530
Message-ID: <20240308052304.1835792-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308052304.1835792-1-vishalc@linux.ibm.com>
References: <20240308052304.1835792-1-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BRCjc4IpKjfSfnqvEH0-kMM9kUzYQyof
X-Proofpoint-ORIG-GUID: BRCjc4IpKjfSfnqvEH0-kMM9kUzYQyof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_03,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2403080040

The DOUBLE_TICK feature, introduced to manage the interaction between
periodic and high-resolution timer ticks, has become obsolete following
the removal of the check_preempt_tick method in commit 5e963f2bd465
("sched/fair: Commit to EEVDF"). This change rendered the DOUBLE_TICK
check in entity_tick pointless, as it no longer influences scheduling
decisions.

This commit removes the DOUBLE_TICK feature flag, simplifying the
scheduler code and eliminating a now-unnecessary check.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 kernel/sched/fair.c     | 6 ------
 kernel/sched/features.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..73e1372d1a0d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5510,12 +5510,6 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		resched_curr(rq_of(cfs_rq));
 		return;
 	}
-	/*
-	 * don't let the period tick interfere with the hrtick preemption
-	 */
-	if (!sched_feat(DOUBLE_TICK) &&
-			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
-		return;
 #endif
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 143f55df890b..f2671bf8d6ab 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -28,7 +28,6 @@ SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)
-SCHED_FEAT(DOUBLE_TICK, false)
 
 /*
  * Decrement CPU capacity based on time not spent running tasks
-- 
2.43.0


