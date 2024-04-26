Return-Path: <linux-kernel+bounces-159954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1388B36BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBC8B21714
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C2314533D;
	Fri, 26 Apr 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LuCpuWUm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D73143C70;
	Fri, 26 Apr 2024 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132274; cv=none; b=F99UxY6ki4BDf4P4szW5aYGvCAg6OgtGAj1Gu4G9FCnT6HNHarerO8Y6gPk/inXkxdCAe/34swR99JhfLApBcrAq9Xm5Ul4kq6U6Xg1iSmzqVmZDylsaXbfPnTEO6IPQrIyg3FQ5vxmWyqH1PAIGsV1xqoRgI70tyXkURK3ibYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132274; c=relaxed/simple;
	bh=pUFowI5Uew0Bfbxd/9zcBIXUhLvC5pUTztv9cOZmLvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIJWpjj/7zEY/rSjlgZlAtSDlEDqXNDjyO1fkD8ss1sFIF+qOIIAkuBCMFILewQhxUH9qQ70rA46s+xTvQvy7r5zwPUJW+IRWcdcGOIAi4a5T0xRYc49CIGwXNaFfSIOJtewfiZJgam70ezFTEL6L8a0djKaUqPbdk9zryZQiFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LuCpuWUm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QBbkW2006299;
	Fri, 26 Apr 2024 11:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HsCoHq+/7P37NBOty4qKIsb4+uubEDWshiCoE+9VXQ8=;
 b=LuCpuWUm0UeZmBZN6+E9fMB90cRYAl8Pviuqa3fxMiCtYUqeCEyTK1Qq7/CLfFMy3ezv
 3yfCaStMv4Ixy2O4E5i9XLED1Jo5iPrvldFVQjFDTuPRduqzVvrm5rZDn41sPllD/hw0
 1rHczGIEdsTRQ07epzeuSEQcSSHRMRPCnOkdix7KNmvSya/vMHJprmdSMusZ/d+pjYAC
 3ZUhg/GIs0goTzK7XBsxPzm+OfAs6nU3zzBa/3N61AbrkEizQ4lIwa/bC5EtoheJHPQs
 qvUJIRVap7dpXk+Ayqfjy+Jr7aP0Z+UV9ZdgQmn/cPtQGla/vt5ah3icZVQTc5jbpdhY 6w== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xrbj6r108-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 11:51:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q9CVZa023052;
	Fri, 26 Apr 2024 11:51:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1pfgvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 11:51:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43QBovp229622824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 11:50:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08F2220040;
	Fri, 26 Apr 2024 11:50:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6D5E2004E;
	Fri, 26 Apr 2024 11:50:56 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Apr 2024 11:50:56 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v2 1/2] s390/pgtable: switch read and write softbits for puds
Date: Fri, 26 Apr 2024 13:50:55 +0200
Message-ID: <20240426115056.31768-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426115056.31768-1-imbrenda@linux.ibm.com>
References: <20240426115056.31768-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CK6Nt_4wasmbzxJ_hgb3rzilyH1N7Joz
X-Proofpoint-ORIG-GUID: CK6Nt_4wasmbzxJ_hgb3rzilyH1N7Joz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=660 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260079

There is no reason for the read and write softbits to be swapped in the
puds compared to pmds. They are different only because the softbits for
puds were introduced at the same time when the softbits for pmds were
swapped.

The current implementation is not wrong per se, since the macros are
defined correctly; only the documentation does not reflect reality.

With this patch, the read and write softbits for large pmd and large
puds will have the same layout, and will match the existing
documentation.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 60950e7a25f5..3da2995fd196 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -266,8 +266,8 @@ static inline int is_module_addr(void *addr)
 #define _REGION3_ENTRY_DIRTY	0x2000	/* SW region dirty bit */
 #define _REGION3_ENTRY_YOUNG	0x1000	/* SW region young bit */
 #define _REGION3_ENTRY_LARGE	0x0400	/* RTTE-format control, large page  */
-#define _REGION3_ENTRY_READ	0x0002	/* SW region read bit */
-#define _REGION3_ENTRY_WRITE	0x0001	/* SW region write bit */
+#define _REGION3_ENTRY_WRITE	0x0002	/* SW region write bit */
+#define _REGION3_ENTRY_READ	0x0001	/* SW region read bit */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
 #define _REGION3_ENTRY_SOFT_DIRTY 0x4000 /* SW region soft dirty bit */
-- 
2.44.0


