Return-Path: <linux-kernel+bounces-41918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EEE83F994
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B964282879
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D3A3BB5E;
	Sun, 28 Jan 2024 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Rt5FgHJf"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841533CD6;
	Sun, 28 Jan 2024 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706471951; cv=none; b=D+dAZJK5ymgn/3ROsdDi1+LaHwxGRN0tthpbVYEu3t98Dg4DSfVjDHpXqsb7Mg560CczCYnEW3Znh7DurpqO4CUOW+w69IuJgSr85ZrEuK+K5eLB4bLpvMMiqq8y51cgmRCeOxH2FuY7w9A+knMhxLwVVoeYAclT6zA1pnr2/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706471951; c=relaxed/simple;
	bh=AvzOX+YLvgoEfFY+O1q34caaqKaHWvjS5dkviD8ygF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oELiCO+Pllu1lJVqIHltsJ7bcspszcrX6pYd9PoDKo2g0BQyncSz/NkyCSr/5jQs1SGoEH4DLnRpwBnJmukzKCP/i9Epr6kAV7m/5vh2lMs2KBbVmm4wt5OA2wl2tnzTKtjmVOMwWD/WXRecpKokKhsT9pMAN5Ava78QMUwvXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Rt5FgHJf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40SHskIM017315;
	Sun, 28 Jan 2024 19:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HqWJnNirYD2mZc4aShg2yzFvukCr30wCusQwz3eGeQw=;
 b=Rt5FgHJf79Sz6qvHnfL0WMT6E1GZVRsEFUcwgKXZHENG1yTjO82kFu7NysqUYTL07P+4
 D6GzR8AB6//RCtCGhQfbnIbS9toGUxEczyBRVsAw1db7AOREBy95tXGi3j6EOkOBzJ0D
 KdUMP+O7PbDAoX3hL8loG4W1T+uwIoxld6h4k/XDrxFk0jBR/yqoAvJkkEajULvXdm7i
 VkhAiHS26g1XWTkdOWTjGz+E8jKoS5gWnZ1mU1afWWGQHOeml+kFiL5wYFoqXG4wki9n
 j7D37piEa7ZxK6Q2gNBW+t6TZNrZUnS74OVL8v1LLwDXyd8GB+IQ6428ZA1JoP34r322 gw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vwr6m4a94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 19:58:59 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40SHKPFI008234;
	Sun, 28 Jan 2024 19:58:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnkm49g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jan 2024 19:58:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40SJwtkx13042222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jan 2024 19:58:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CCFA2004D;
	Sun, 28 Jan 2024 19:58:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEF9B20043;
	Sun, 28 Jan 2024 19:58:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 28 Jan 2024 19:58:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id AE3A5E079D; Sun, 28 Jan 2024 20:58:54 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/5] s390/vtime: remove unused __ARCH_HAS_VTIME_TASK_SWITCH leftover
Date: Sun, 28 Jan 2024 20:58:52 +0100
Message-Id: <b3623605ba5c1d386d8f59e17c930ca2c3cca07c.1706470223.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706470223.git.agordeev@linux.ibm.com>
References: <cover.1706470223.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xt6cwiIK9tVwUe-fhmMhvVLPErmDmlky
X-Proofpoint-ORIG-GUID: Xt6cwiIK9tVwUe-fhmMhvVLPErmDmlky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=656 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401280151

__ARCH_HAS_VTIME_TASK_SWITCH macro is not used anymore.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/include/asm/vtime.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
index fe17e448c0c5..561c91c1a87c 100644
--- a/arch/s390/include/asm/vtime.h
+++ b/arch/s390/include/asm/vtime.h
@@ -2,8 +2,6 @@
 #ifndef _S390_VTIME_H
 #define _S390_VTIME_H
 
-#define __ARCH_HAS_VTIME_TASK_SWITCH
-
 static inline void update_timer_sys(void)
 {
 	S390_lowcore.system_timer += S390_lowcore.last_update_timer - S390_lowcore.exit_timer;
-- 
2.40.1


