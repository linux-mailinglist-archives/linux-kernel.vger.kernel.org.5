Return-Path: <linux-kernel+bounces-147464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7DB8A7489
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1CE1C225C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B10138496;
	Tue, 16 Apr 2024 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="RP/rT0lu"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A0137C23
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295190; cv=none; b=KiJ1q9wmAoDzyGXx3mVaRvWQ8ziHon0cXPoKRogz+jzds8yk1S+3VVMABsu9M6zYP6vUkSjqdvIQVHRwPUDt9ew8OGA8u0lLlu6BPy643qLbKmuJmC/z/S1ZcLm9VQNeI7jBReIPyiEWuF5wUcM+toSef9cOX4+vpxPmqeD8FQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295190; c=relaxed/simple;
	bh=1/QhQq/SNBvhM5Qukg8qId++gk6cla4fzJPkLM7SWYI=;
	h=Message-Id:In-Reply-To:References:To:Cc:From:Subject:Date; b=opFDhlfEk5kYNkKncZcZmS6PxmImN9GsJvFV8kMH9kxTcXWaKdzst2YHpX7iMrhM0NMaII1KjgfxSbhbrdzsqGNAYgVn36dZHF2nRlWvFAEG/sq+UBjGxGCAln0/NNaZHvkJhyhIrTfNF+FRwRk66agiOjAKyReOru81saJ2xrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=RP/rT0lu; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355089.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43GGKltB014625;
	Tue, 16 Apr 2024 19:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	message-id:in-reply-to:references:to:cc:from:subject:date; s=
	DKIM202306; bh=bxlhcCLLu2nVwVVshKc9HTXBGPT+xoKrYdwmFjIADko=; b=R
	P/rT0luOjR5Tc+kJKMZ7XmGq7XLTVOYOty15m6179Fn2yM62v4KuHW3xu80sOZH6
	0uxTedg/kHgnCirjUr67K3jDCBayRawwd5ZrFIKtcgcC1y2Y+eWgN+OSEHJ63HHU
	OQ0wix/aQOy/wBP/4X9C/9cLB5QbdgcgcbOg5EUO79WIkINVPFg+Fk3Hmi8DS33o
	WD2ntpRpoZGV0f4tjklC8QLJT6E5eFwHq8qjSjSGtSY1cvRem+UNKbFOYFR1zv1r
	JChKCLYb1VT7WyBbPCAkhVpy6enF21Sas6lIDBW6FhcjcbCLmXTRNhNDYoObSz+r
	S5xQvNsAkQK0dLy5oDIjw==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3xhctp42v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 19:19:22 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4VJv3t0jpxz53xyZ;
	Tue, 16 Apr 2024 19:19:22 +0000 (UTC)
Received: from ilclbld243.mot.com (ilclbld243.mot.com [100.64.22.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VJv3t0W4Hz2SlV8;
	Tue, 16 Apr 2024 19:19:22 +0000 (UTC)
Message-Id: <20240416122254.868007168-5-mbland@motorola.com>
In-Reply-To: <20240416122254.868007168-1-mbland@motorola.com>
References: <20240416122254.868007168-1-mbland@motorola.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Maxwell Bland <mbland@motorola.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Maxwell Bland <mbland@motorola.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Hildenbrand <david@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org
From: Maxwell Bland <mbland@motorola.com>
Subject: [PATCH 4/5 RESEND] arm64: dynamic enforcement of PXNTable
Date: Tue, 16 Apr 2024 14:18:18 -0500
X-Proofpoint-GUID: DROmJMmX7G07KTG0qxdXMD6DZ-9Y4P3A
X-Proofpoint-ORIG-GUID: DROmJMmX7G07KTG0qxdXMD6DZ-9Y4P3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_17,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=738
 clxscore=1015 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160122
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


