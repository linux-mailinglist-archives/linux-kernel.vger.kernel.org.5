Return-Path: <linux-kernel+bounces-162449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE198B5B64
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A04DB24764
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B607E0F0;
	Mon, 29 Apr 2024 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HlHHzq2p"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC717D414;
	Mon, 29 Apr 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401274; cv=none; b=j0Ln7gWnVP3vkdxfUCBnLNnq76tWOeq5YylGIFEEDO/go9zUcppZ2js9FoOYXZ8kHzrf/fF/RCtPWXH2at/b0KS4vhUPRHKbGboL9mxEGVe8ijw92wbh9Me0ZC5BShqLT/E0sSAY61n0xcjbbWnUjw+NkzFg4Gp508tHOLk2s+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401274; c=relaxed/simple;
	bh=pUFowI5Uew0Bfbxd/9zcBIXUhLvC5pUTztv9cOZmLvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5fPjyL9vr3GbpYGV2hpUZR82fwx7lzMlR7n9zWWaZxhOyhnHW2ZMQK/h2d26jgJK7kxwqjSq+V0tsOg1qVUK9keBLlBENshNgZ3GQd/yj9dP+FDiYh80KjNLfwHvVKuqF5t4I20hz6yNL+jYTSSW0JwAu+nHAqQclpiKqn4q2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HlHHzq2p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TEYU86024986;
	Mon, 29 Apr 2024 14:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HsCoHq+/7P37NBOty4qKIsb4+uubEDWshiCoE+9VXQ8=;
 b=HlHHzq2pC0NGeoncnxr3lHwE23d9BIshVuCOJ0UPjHeAGI4P/Xp6gg1JT4FZxo3LEOCc
 D4fyx5Cg5qwR7P4yxkrV+lJ+xAfMZTl5O+FVaCmo+5Y2jlJQUQgJ/HhtbUE3RGyb8u24
 4uySfxYPCSS6sUbjZpvjmw8GkX/5Q21haGuQN7i6IAoSUebVspld6BIU7NN5NVa310Zf
 NGQ1JIK6D3RM6aVZRaEF2hMKL+tkVS9VN31bZQR5Id19YShSTYvECjQ5QjHaTGWH/oJM
 Yb4arRK+mQpda/ljJjg4FJGmVHoupWHpD1ZgP/+WTKpRkMlOcTnbZbSbc9t1OsGcB3lt yg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtcju05v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 14:34:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43TCxWaN011750;
	Mon, 29 Apr 2024 14:34:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsdwkyfvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 14:34:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43TEY93W45941078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 14:34:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C197820040;
	Mon, 29 Apr 2024 14:34:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A5352004D;
	Mon, 29 Apr 2024 14:34:09 +0000 (GMT)
Received: from p-imbrenda.boeblingen.de.ibm.com (unknown [9.152.224.66])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2024 14:34:09 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [PATCH v4 1/2] s390/pgtable: switch read and write softbits for puds
Date: Mon, 29 Apr 2024 16:34:08 +0200
Message-ID: <20240429143409.49892-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143409.49892-1-imbrenda@linux.ibm.com>
References: <20240429143409.49892-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h28NO31rdEg2GTCS_--0d63oSYlnlVSD
X-Proofpoint-ORIG-GUID: h28NO31rdEg2GTCS_--0d63oSYlnlVSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_12,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 mlxlogscore=653
 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290092

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


