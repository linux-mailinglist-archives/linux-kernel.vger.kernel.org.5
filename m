Return-Path: <linux-kernel+bounces-147785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DAA8A79A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B221C2240B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A027620;
	Wed, 17 Apr 2024 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="ALFUaIzp"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB1196
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312607; cv=none; b=U9S8akRcsT9uJB6oRZQxex7NB52FjkxaPb68Ir3Ngx5LN/+BY0akXaiV0oXZ87Pp7J1Idz3di5R+w3sxn9ZMvLI3tvty4f2B05qgaLg3E/xSoj6g1keWWYfcd/hDO1gLKqUMjQbie/yy7/qYpAnMK+DDvgzqPAMGRag8eiqFt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312607; c=relaxed/simple;
	bh=1/QhQq/SNBvhM5Qukg8qId++gk6cla4fzJPkLM7SWYI=;
	h=Message-Id:In-Reply-To:References:To:Cc:From:Date:Subject; b=L/u+MGEJsovGok5mQtElmZz2r2iA9YL7XVtjtKSOglg15wR301g/bOhDa4WBhUxZ6/vtvIedoIHRB2qcL4q1eFSFYmJiNFNwyDqWJIMSFBxpSmzMaoYuPmcnhp+2QKqSe76slngbt0/7C5xmOVWnVUwwK2pmNPq0vwMIW/8+4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=ALFUaIzp; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355092.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GEstYE010955;
	Tue, 16 Apr 2024 17:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	message-id:in-reply-to:references:to:cc:from:date:subject; s=
	DKIM202306; bh=bxlhcCLLu2nVwVVshKc9HTXBGPT+xoKrYdwmFjIADko=; b=A
	LFUaIzpDXni0XvmvS0y2Pxqhcy4PQpTgtvxQlsDj8ehh8lmGWKw/KdeDd8BuUd8Q
	hMBekukD2lvL+7VD+InMM3QMnnniANJSzk4HQYX0F3VzKOg16JlETL9y8pT4Uewi
	K5mg5FPC/nPBzPUS7n4OW0xJ0Lx2W91X6kEbRo1tCH913lQPZqh7mMBqyFTn2Ke6
	5RCAEdwT2KoGnNwjqDI+okLTM6csDjI07GYqTd23+rZUqoRAUzMrgungknlghjUI
	otEww2i4ylzuDct59uiCTfJLLIqtdgfsHjXj7PtkQXqOKESgOg+YnW7bUlt/6/qV
	3OSJR5JfFMbHDiub4UYuA==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3xha96c2th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 17:24:57 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4VJrWs1PZ0z53xyY;
	Tue, 16 Apr 2024 17:24:57 +0000 (UTC)
Received: from ilclbld243.mot.com (ilclbld243.mot.com [100.64.22.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4VJrWs15XGz2VZRf;
	Tue, 16 Apr 2024 17:24:57 +0000 (UTC)
Message-Id: <20240416122254.868007168-5-mbland@motorola.com>
In-Reply-To: <20240416122254.868007168-1-mbland@motorola.com>
References: <20240416122254.868007168-1-mbland@motorola.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Maxwell Bland <mbland@motorola.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Maxwell Bland <mbland@motorola.com>, linux-kernel@vger.kernel.org
From: Maxwell Bland <mbland@motorola.com>
Date: Fri, 12 Apr 2024 10:00:34 -0500
Subject: [PATCH 4/5] arm64: dynamic enforcement of PXNTable
X-Proofpoint-GUID: c40_PDWtT41G9D4WZ4RFrQBRvh-FsbVL
X-Proofpoint-ORIG-GUID: c40_PDWtT41G9D4WZ4RFrQBRvh-FsbVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 mlxlogscore=624 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404160108
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

PXNTable is enforced during the init process to ensure that regions of
user memory and kernel data cannot be executed from, preventing attacks
which write to writable kernel pages and then modify the kernel's page
tables to make this code executable. This patch ensures this protection
is also preserved for dynamically allocated pages/pagetables, making it
so that all PMDs populated outside of the module code region are
PXNTable by default.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 5785272144e8..2376b4e7915c 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -12,6 +12,7 @@
 #include <asm/processor.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/module.h>
 
 #define __HAVE_ARCH_PGD_FREE
 #define __HAVE_ARCH_PUD_FREE
@@ -119,6 +120,12 @@ static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t ptep,
 	set_pmd(pmdp, __pmd(__phys_to_pmd_val(ptep) | prot));
 }
 
+static inline bool vaddr_is_data(unsigned long vaddr)
+{
+	return ((vaddr + PMD_SIZE < MODULES_ASLR_START || vaddr >= MODULES_ASLR_END) &&
+		(vaddr + PMD_SIZE < (unsigned long) _text || vaddr >= (unsigned long) _etext));
+}
+
 /*
  * Populate the pmdp entry with a pointer to the pte.  This pmd is part
  * of the mm address space.
@@ -127,8 +134,11 @@ static inline void
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmdp, pte_t *ptep,
 		    unsigned long vaddr)
 {
+	pmdval_t pmd = PMD_TYPE_TABLE | PMD_TABLE_UXN;
 	VM_BUG_ON(mm && mm != &init_mm);
-	__pmd_populate(pmdp, __pa(ptep), PMD_TYPE_TABLE | PMD_TABLE_UXN);
+	if (vaddr_is_data(vaddr))
+		pmd |= PMD_TABLE_PXN;
+	__pmd_populate(pmdp, __pa(ptep), pmd);
 }
 
 static inline void
-- 
2.39.2


