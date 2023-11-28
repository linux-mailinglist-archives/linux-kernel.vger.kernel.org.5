Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF047FB8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344479AbjK1LEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344350AbjK1LD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:03:56 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A266D6;
        Tue, 28 Nov 2023 03:04:02 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASAwBAX001844;
        Tue, 28 Nov 2023 11:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Dt1YW0vf+McTaKErPl0iHdB6D5PuLO6sey3WZMfMbwU=;
 b=Sc3zvUEFHGRTrbbi+NXR7ymvmTtLj7hSNONycQ6nE7sAOOviAIecJCsMnReq3C6+xUwD
 2pSDMewQx0vKEIJfuZ0C6Vu9MlwbmnrgOwfoySNXV8LimhdIrHwHakDMRfN/zIw2uxUS
 9jAE63F8cXP/Na09nUw0Xo1IARvDMhRgsed+RAlCB313CabNtCYCXnpmOiZA3AXO3X6j
 2tno1R2HIuFraeG+TR7kPgHVoURDqT8st5AIMBpjjdSbXYqaV+FnsoOEc78fmg4v/1AN
 xn3VdszIJM7gugKSAkdgXwYEo4rt1wy2bWloFHhTnuV/wDnB+l/UIZyyRd26M/yRpNN+ fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unewng5tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 11:03:50 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASB0Iu2009598;
        Tue, 28 Nov 2023 11:03:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unewng5tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 11:03:49 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASAV3OL028308;
        Tue, 28 Nov 2023 11:03:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ukv8nf5ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 11:03:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ASB3jRF42664230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 11:03:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C51C20040;
        Tue, 28 Nov 2023 11:03:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29DC220043;
        Tue, 28 Nov 2023 11:03:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 28 Nov 2023 11:03:45 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/5] s390/mm: allocate vmemmap pages from self-contained memory range
Date:   Tue, 28 Nov 2023 12:03:39 +0100
Message-Id: <20231128110342.102096-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128110342.102096-1-sumanthk@linux.ibm.com>
References: <20231128110342.102096-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oHUgj7lc5pWSgR15Wn2RF29slpcxcEXS
X-Proofpoint-ORIG-GUID: 1t_H8THe2gQoijmu9x2yH148SZzwcgVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_10,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=936
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate memory map (struct pages array) from the hotplugged memory
range, rather than using system memory. The change addresses the issue
where standby memory, when configured to be much larger than online
memory, could potentially lead to ipl failure due to memory map
allocation from online memory. For example, 16MB of memory map
allocation is needed for a memory block size of 1GB and when standby
memory is configured much larger than online memory, this could lead to
ipl failure.

To address this issue, the solution involves introducing "memmap on
memory" using the vmem_altmap structure on s390.  Architectures that
want to implement it should pass the altmap to the vmemmap_populate()
function and its associated callchain. This enhancement is discussed in
the commit 4b94ffdc4163 ("x86, mm: introduce vmem_altmap to augment
vmemmap_populate()").

Provide "memmap on memory" support for s390 by passing the altmap in
vmemmap_populate() and its callchain. The allocation path is described
as follows:
* When altmap is NULL in vmemmap_populate(), memory map allocation
  occurs using the existing vmemmap_alloc_block_buf().
* When altmap is not NULL in vmemmap_populate(), memory map allocation
  still uses vmemmap_alloc_block_buf(), but this function internally
  calls altmap_alloc_block_buf().

For deallocation, the process is outlined as follows:
* When altmap is NULL in vmemmap_free(), memory map deallocation happens
  through free_pages().
* When altmap is not NULL in vmemmap_free(), memory map deallocation
  occurs via vmem_altmap_free().

While memory map allocation is primarily handled through the
self-contained memory map range, there might still be a small amount of
system memory allocation required for vmemmap pagetables. To mitigate
this impact, this feature will be limited to machines with EDAT1
support.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/mm/init.c |  3 ---
 arch/s390/mm/vmem.c | 62 +++++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 43e612bc2bcd..8d9a60ccb777 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -281,9 +281,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	unsigned long size_pages = PFN_DOWN(size);
 	int rc;
 
-	if (WARN_ON_ONCE(params->altmap))
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
 		return -EINVAL;
 
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 186a020857cf..eb100479f7be 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -33,8 +33,12 @@ static void __ref *vmem_alloc_pages(unsigned int order)
 	return memblock_alloc(size, size);
 }
 
-static void vmem_free_pages(unsigned long addr, int order)
+static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *altmap)
 {
+	if (altmap) {
+		vmem_altmap_free(altmap, 1 << order);
+		return;
+	}
 	/* We don't expect boot memory to be removed ever. */
 	if (!slab_is_available() ||
 	    WARN_ON_ONCE(PageReserved(virt_to_page((void *)addr))))
@@ -156,7 +160,8 @@ static bool vmemmap_unuse_sub_pmd(unsigned long start, unsigned long end)
 
 /* __ref: we'll only call vmemmap_alloc_block() via vmemmap_populate() */
 static int __ref modify_pte_table(pmd_t *pmd, unsigned long addr,
-				  unsigned long end, bool add, bool direct)
+				  unsigned long end, bool add, bool direct,
+				  struct vmem_altmap *altmap)
 {
 	unsigned long prot, pages = 0;
 	int ret = -ENOMEM;
@@ -172,11 +177,11 @@ static int __ref modify_pte_table(pmd_t *pmd, unsigned long addr,
 			if (pte_none(*pte))
 				continue;
 			if (!direct)
-				vmem_free_pages((unsigned long) pfn_to_virt(pte_pfn(*pte)), 0);
+				vmem_free_pages((unsigned long)pfn_to_virt(pte_pfn(*pte)), get_order(PAGE_SIZE), altmap);
 			pte_clear(&init_mm, addr, pte);
 		} else if (pte_none(*pte)) {
 			if (!direct) {
-				void *new_page = vmemmap_alloc_block(PAGE_SIZE, NUMA_NO_NODE);
+				void *new_page = vmemmap_alloc_block_buf(PAGE_SIZE, NUMA_NO_NODE, altmap);
 
 				if (!new_page)
 					goto out;
@@ -213,7 +218,8 @@ static void try_free_pte_table(pmd_t *pmd, unsigned long start)
 
 /* __ref: we'll only call vmemmap_alloc_block() via vmemmap_populate() */
 static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
-				  unsigned long end, bool add, bool direct)
+				  unsigned long end, bool add, bool direct,
+				  struct vmem_altmap *altmap)
 {
 	unsigned long next, prot, pages = 0;
 	int ret = -ENOMEM;
@@ -234,11 +240,11 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 				if (IS_ALIGNED(addr, PMD_SIZE) &&
 				    IS_ALIGNED(next, PMD_SIZE)) {
 					if (!direct)
-						vmem_free_pages(pmd_deref(*pmd), get_order(PMD_SIZE));
+						vmem_free_pages(pmd_deref(*pmd), get_order(PMD_SIZE), altmap);
 					pmd_clear(pmd);
 					pages++;
 				} else if (!direct && vmemmap_unuse_sub_pmd(addr, next)) {
-					vmem_free_pages(pmd_deref(*pmd), get_order(PMD_SIZE));
+					vmem_free_pages(pmd_deref(*pmd), get_order(PMD_SIZE), altmap);
 					pmd_clear(pmd);
 				}
 				continue;
@@ -261,7 +267,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 				 * page tables since vmemmap_populate gets
 				 * called for each section separately.
 				 */
-				new_page = vmemmap_alloc_block(PMD_SIZE, NUMA_NO_NODE);
+				new_page = vmemmap_alloc_block_buf(PMD_SIZE, NUMA_NO_NODE, altmap);
 				if (new_page) {
 					set_pmd(pmd, __pmd(__pa(new_page) | prot));
 					if (!IS_ALIGNED(addr, PMD_SIZE) ||
@@ -280,7 +286,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 				vmemmap_use_sub_pmd(addr, next);
 			continue;
 		}
-		ret = modify_pte_table(pmd, addr, next, add, direct);
+		ret = modify_pte_table(pmd, addr, next, add, direct, altmap);
 		if (ret)
 			goto out;
 		if (!add)
@@ -302,12 +308,12 @@ static void try_free_pmd_table(pud_t *pud, unsigned long start)
 	for (i = 0; i < PTRS_PER_PMD; i++, pmd++)
 		if (!pmd_none(*pmd))
 			return;
-	vmem_free_pages(pud_deref(*pud), CRST_ALLOC_ORDER);
+	vmem_free_pages(pud_deref(*pud), CRST_ALLOC_ORDER, NULL);
 	pud_clear(pud);
 }
 
 static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
-			    bool add, bool direct)
+			    bool add, bool direct, struct vmem_altmap *altmap)
 {
 	unsigned long next, prot, pages = 0;
 	int ret = -ENOMEM;
@@ -347,7 +353,7 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 		} else if (pud_large(*pud)) {
 			continue;
 		}
-		ret = modify_pmd_table(pud, addr, next, add, direct);
+		ret = modify_pmd_table(pud, addr, next, add, direct, altmap);
 		if (ret)
 			goto out;
 		if (!add)
@@ -370,12 +376,12 @@ static void try_free_pud_table(p4d_t *p4d, unsigned long start)
 		if (!pud_none(*pud))
 			return;
 	}
-	vmem_free_pages(p4d_deref(*p4d), CRST_ALLOC_ORDER);
+	vmem_free_pages(p4d_deref(*p4d), CRST_ALLOC_ORDER, NULL);
 	p4d_clear(p4d);
 }
 
 static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
-			    bool add, bool direct)
+			    bool add, bool direct, struct vmem_altmap *altmap)
 {
 	unsigned long next;
 	int ret = -ENOMEM;
@@ -394,7 +400,7 @@ static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
 				goto out;
 			p4d_populate(&init_mm, p4d, pud);
 		}
-		ret = modify_pud_table(p4d, addr, next, add, direct);
+		ret = modify_pud_table(p4d, addr, next, add, direct, altmap);
 		if (ret)
 			goto out;
 		if (!add)
@@ -415,12 +421,12 @@ static void try_free_p4d_table(pgd_t *pgd, unsigned long start)
 		if (!p4d_none(*p4d))
 			return;
 	}
-	vmem_free_pages(pgd_deref(*pgd), CRST_ALLOC_ORDER);
+	vmem_free_pages(pgd_deref(*pgd), CRST_ALLOC_ORDER, NULL);
 	pgd_clear(pgd);
 }
 
 static int modify_pagetable(unsigned long start, unsigned long end, bool add,
-			    bool direct)
+			    bool direct, struct vmem_altmap *altmap)
 {
 	unsigned long addr, next;
 	int ret = -ENOMEM;
@@ -445,7 +451,7 @@ static int modify_pagetable(unsigned long start, unsigned long end, bool add,
 				goto out;
 			pgd_populate(&init_mm, pgd, p4d);
 		}
-		ret = modify_p4d_table(pgd, addr, next, add, direct);
+		ret = modify_p4d_table(pgd, addr, next, add, direct, altmap);
 		if (ret)
 			goto out;
 		if (!add)
@@ -458,14 +464,16 @@ static int modify_pagetable(unsigned long start, unsigned long end, bool add,
 	return ret;
 }
 
-static int add_pagetable(unsigned long start, unsigned long end, bool direct)
+static int add_pagetable(unsigned long start, unsigned long end, bool direct,
+			 struct vmem_altmap *altmap)
 {
-	return modify_pagetable(start, end, true, direct);
+	return modify_pagetable(start, end, true, direct, altmap);
 }
 
-static int remove_pagetable(unsigned long start, unsigned long end, bool direct)
+static int remove_pagetable(unsigned long start, unsigned long end, bool direct,
+			    struct vmem_altmap *altmap)
 {
-	return modify_pagetable(start, end, false, direct);
+	return modify_pagetable(start, end, false, direct, altmap);
 }
 
 /*
@@ -474,7 +482,7 @@ static int remove_pagetable(unsigned long start, unsigned long end, bool direct)
 static int vmem_add_range(unsigned long start, unsigned long size)
 {
 	start = (unsigned long)__va(start);
-	return add_pagetable(start, start + size, true);
+	return add_pagetable(start, start + size, true, NULL);
 }
 
 /*
@@ -483,7 +491,7 @@ static int vmem_add_range(unsigned long start, unsigned long size)
 static void vmem_remove_range(unsigned long start, unsigned long size)
 {
 	start = (unsigned long)__va(start);
-	remove_pagetable(start, start + size, true);
+	remove_pagetable(start, start + size, true, NULL);
 }
 
 /*
@@ -496,9 +504,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 
 	mutex_lock(&vmem_mutex);
 	/* We don't care about the node, just use NUMA_NO_NODE on allocations */
-	ret = add_pagetable(start, end, false);
+	ret = add_pagetable(start, end, false, altmap);
 	if (ret)
-		remove_pagetable(start, end, false);
+		remove_pagetable(start, end, false, altmap);
 	mutex_unlock(&vmem_mutex);
 	return ret;
 }
@@ -509,7 +517,7 @@ void vmemmap_free(unsigned long start, unsigned long end,
 		  struct vmem_altmap *altmap)
 {
 	mutex_lock(&vmem_mutex);
-	remove_pagetable(start, end, false);
+	remove_pagetable(start, end, false, altmap);
 	mutex_unlock(&vmem_mutex);
 }
 
-- 
2.41.0

