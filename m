Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433A77EB60F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjKNSD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjKNSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:03:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAE511B;
        Tue, 14 Nov 2023 10:03:06 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEHkGrI003687;
        Tue, 14 Nov 2023 18:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=f3ODx0nEjQw7AZiZQdgaRfqK/mj0aCKaVn/urVt+O/s=;
 b=V9o26zdqvtRS6Zy9w1PHmyl/fUFs/aMac4sn3GwMb18Vi8SYVbjGxylBLmeKLmMvuLSk
 y/Flcf5+qhoeyUNmmcmVbxGrkB7GD5XWMrcK80I4HGfy203BEp+sTMGwZ2ms4KG8gvXU
 LZwcSPldP8vVAPX86SrsUXReBVJODsgm0fYXlm2JzC0cFlUyvN5Gf34rF0jvBXu5ASgD
 r/2SMwmxK6ttOWBwkmdMwJRHkfCWraQa2DGID2ciYbH+nu6dfEV0EvB2P3QKvqIdkKJu
 xZ9b3SJMRXKw0GukJq7tAXjM6Dm27VXWQ9u8kQTJ4R4cDNCH2Vaw6AJDGir1VcpTQtG/ 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucce7ak4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:52 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEHkFHc003646;
        Tue, 14 Nov 2023 18:02:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucce7ak1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:51 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEGXxss019651;
        Tue, 14 Nov 2023 18:02:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamay9tc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AEI2kso40829366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 18:02:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4E7C2004D;
        Tue, 14 Nov 2023 18:02:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59E3A20040;
        Tue, 14 Nov 2023 18:02:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Nov 2023 18:02:46 +0000 (GMT)
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
Subject: [PATCH 3/8] mm: use vmem_altmap code without CONFIG_ZONE_DEVICE
Date:   Tue, 14 Nov 2023 19:02:33 +0100
Message-Id: <20231114180238.1522782-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gh2OxY0_rfZXOYpRCD07_I0KQppgYvSj
X-Proofpoint-ORIG-GUID: oHrM96tYm2-NwV52JlE9xvwvtGj3q7oa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_18,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=921
 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311140137
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmem_altmap_free() and vmem_altmap_offset() could be utlized without
CONFIG_ZONE_DEVICE enabled. Hence, move it to sparse-vmemmap.c

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 include/linux/memremap.h | 12 ------------
 include/linux/mm.h       |  2 ++
 mm/memremap.c            | 14 +-------------
 mm/sparse-vmemmap.c      | 13 +++++++++++++
 4 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 1314d9c5f05b..744c830f4b13 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -196,8 +196,6 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		struct dev_pagemap *pgmap);
 bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
 
-unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
-void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
 unsigned long memremap_compat_align(void);
 #else
 static inline void *devm_memremap_pages(struct device *dev,
@@ -228,16 +226,6 @@ static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
 	return false;
 }
 
-static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
-{
-	return 0;
-}
-
-static inline void vmem_altmap_free(struct vmem_altmap *altmap,
-		unsigned long nr_pfns)
-{
-}
-
 /* when memremap_pages() is disabled all archs can remap a single page */
 static inline unsigned long memremap_compat_align(void)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bf5d0b1b16f4..5edb0dfd2d01 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3765,6 +3765,8 @@ pud_t *vmemmap_pud_populate(p4d_t *p4d, unsigned long addr, int node);
 pmd_t *vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node);
 pte_t *vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, int node,
 			    struct vmem_altmap *altmap, struct page *reuse);
+unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
+void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
 void *vmemmap_alloc_block(unsigned long size, int node);
 struct vmem_altmap;
 void *vmemmap_alloc_block_buf(unsigned long size, int node,
diff --git a/mm/memremap.c b/mm/memremap.c
index bee85560a243..9531faa92a7c 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -7,6 +7,7 @@
 #include <linux/memremap.h>
 #include <linux/pfn_t.h>
 #include <linux/swap.h>
+#include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/swapops.h>
 #include <linux/types.h>
@@ -422,19 +423,6 @@ void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap)
 }
 EXPORT_SYMBOL_GPL(devm_memunmap_pages);
 
-unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
-{
-	/* number of pfns from base where pfn_to_page() is valid */
-	if (altmap)
-		return altmap->reserve + altmap->free;
-	return 0;
-}
-
-void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns)
-{
-	altmap->alloc -= nr_pfns;
-}
-
 /**
  * get_dev_pagemap() - take a new live reference on the dev_pagemap for @pfn
  * @pfn: page frame number to lookup page_map
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index a2cbe44c48e1..bd1b9a137f93 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -46,6 +46,19 @@ static void * __ref __earlyonly_bootmem_alloc(int node,
 					       MEMBLOCK_ALLOC_ACCESSIBLE, node);
 }
 
+unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+{
+	/* number of pfns from base where pfn_to_page() is valid */
+	if (altmap)
+		return altmap->reserve + altmap->free;
+	return 0;
+}
+
+void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns)
+{
+	altmap->alloc -= nr_pfns;
+}
+
 void * __meminit vmemmap_alloc_block(unsigned long size, int node)
 {
 	/* If the main allocator is up use that, fallback to bootmem. */
-- 
2.41.0

