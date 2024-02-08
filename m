Return-Path: <linux-kernel+bounces-58654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1832984E97F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2CF1F2EA39
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2673CF5F;
	Thu,  8 Feb 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OmA2fD7Z"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6EA38DF2;
	Thu,  8 Feb 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423368; cv=none; b=dCWpn01c1HaiwISa7AKyuCyBvIsF7/tmktQ3+s+u6CEWWU+YUkOxMbxbaKjcz09c5faiVFEsuxxuPPfWJBiGa6oZINzEjtejTbJDVZ8ZhJRpN3I68bIYspln1R4ud6FniNkBVF8mImdaJOv+tVN3gW44qyBEdGGTQETNxhE0OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423368; c=relaxed/simple;
	bh=Fy7fAeEhRXxhYJattsaY48xUX8wq/xaXtUTxoRFdE5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iSIzJVvpaCDe5oO8OguZYwKDncJAI+XNXyQG5GjQRZw9gtHhC0my7G/ABNQfprz+sanCtiZGHMtVgle0fBnyGtJ7XvgK5QVb2uFSIA1R6n2vcGIs1tDwpzxKG1VvvDlEuzyy/UZ1UmGlAtV2KzDPDwjVhf/a0JkZBsx2kg+ZG+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OmA2fD7Z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418K2Epk018476;
	Thu, 8 Feb 2024 20:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tSsEosjDWuVTaWskzvg+GCeL8Q0KczxNBRDsV5Z9Z9Q=;
 b=OmA2fD7ZLP862a8WyWZM3Zlzqjn6BaJI4N3wDuahQLg3aFd0ApZWjACS+gVF7QJI6Apz
 qs/96aVkBoL+vA6eJIovutjSB0DyNFDfUqriUQgR/KAk3vFeUIqsnFjgWduPVu3xJKxH
 QpxeGtI4zwBSQ1T2NbWPTwtQFLGQBXzv0o0EgfbZCFTnUzbuc8/N9+VNVp9ukTfmZX1C
 ChJBZ9g7OYkwJ5TtjqjjLq7V98SZ1YuLXR0yIJs9dMHihdeYqiyTfWxayGm0W/yrQYZp
 AwYY3lFgWrlLcOk14ibNVjGu0PxDrn2lMIc2btH1eMddrSBP2kNJdeRYoRBYMmCKSk9S nA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w55mu8c6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:54 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418K3Hvf021562;
	Thu, 8 Feb 2024 20:15:53 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w55mu8c6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:53 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418Istae016137;
	Thu, 8 Feb 2024 20:15:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h2eg9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 20:15:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418KFnpp44106182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 20:15:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C47CD2004D;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B34C32004B;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 20:15:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 7856EE04E8; Thu,  8 Feb 2024 21:15:49 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/5] sched/vtime: remove confusing arch_vtime_task_switch() declaration
Date: Thu,  8 Feb 2024 21:15:45 +0100
Message-Id: <f5c88d9290bca3b280cfdd499c236a3c390af51b.1707422448.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707422448.git.agordeev@linux.ibm.com>
References: <cover.1707422448.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aNx-Vlg6OimIWDavsXMhHhUaI-gyM5i7
X-Proofpoint-ORIG-GUID: 3yQcFb620ijS_fnTGJmVldLx0cmZ4uqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=749 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080108

Callback arch_vtime_task_switch() is only defined when
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is selected. Yet, the
function prototype forward declaration is present for
CONFIG_VIRT_CPU_ACCOUNTING_GEN variant. Remove it.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/linux/vtime.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 3684487d01e1..593466ceebed 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -18,7 +18,6 @@ extern void vtime_account_idle(struct task_struct *tsk);
 #endif /* !CONFIG_VIRT_CPU_ACCOUNTING */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern void arch_vtime_task_switch(struct task_struct *tsk);
 extern void vtime_user_enter(struct task_struct *tsk);
 extern void vtime_user_exit(struct task_struct *tsk);
 extern void vtime_guest_enter(struct task_struct *tsk);
-- 
2.40.1


