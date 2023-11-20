Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D367F0CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjKTHXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjKTHXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:23:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0000DAF;
        Sun, 19 Nov 2023 23:23:43 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7Fubv009362;
        Mon, 20 Nov 2023 07:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=aDeQRku6qF8MgYKu7kDp5/ujjCadBbyKMfJTF6YyagQ=;
 b=Uz1eNN67Dn8tXGb2jzNu+Wy7NNjNi4j9HVMtUL8L4hf226TRZqVWbNaq9GG+QjBP7qq3
 oAKSZRJAXI3XceOTXP7Yad/2hZYkmVhaaypmMJGyZ/bfymb1ZxDgLiNq8kBq6wOgYl8H
 NEojattdDuOszlWRXbaaPKVG2l7s27VhekE0dm6meMwycJCf38dlgwzZsCwcVrmuSqSm
 Xa6WU7L71cSFAYW/EIHpzewKGovJnlnRckDL93EKoV65WEfexIS45sorAPqMrRJR9vta
 RUbts6oTvkemMNMbqUdk0tQPjy34A41A7l0dn+enc7bDndmMvP8CrbdizUnja5LTXh+z Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf1f75jge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 07:23:31 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AK7GGeM010484;
        Mon, 20 Nov 2023 07:23:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf1f75jfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 07:23:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK7KVQS008740;
        Mon, 20 Nov 2023 07:23:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93kfexd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 07:23:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AK7NQl242074554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 07:23:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82EB12004B;
        Mon, 20 Nov 2023 07:23:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3650420043;
        Mon, 20 Nov 2023 07:23:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 07:23:26 +0000 (GMT)
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
Subject: [PATCH 3/3] mm: use vmem_altmap code without CONFIG_ZONE_DEVICE
Date:   Mon, 20 Nov 2023 08:23:17 +0100
Message-Id: <20231120072317.3169630-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120072317.3169630-1-sumanthk@linux.ibm.com>
References: <20231120072317.3169630-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fOcwcO2GdxtHgWM1gb_XUVRYNsl-Xv3S
X-Proofpoint-ORIG-GUID: giaqMMErEImI2rd7aVgq2i-gi426kzpD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_05,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=671 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200047
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
CONFIG_ZONE_DEVICE enabled. For example,
mm/memory_hotplug.c:__add_pages() relies on that.  The altmap is no
longer restricted to ZONE_DEVICE handling, but instead depends on
CONFIG_SPARSEMEM_VMEMMAP.

When CONFIG_SPARSEMEM_VMEMMAP is disabled, these functions are defined
as inline stubs, ensuring compatibility with configurations that do not
use sparsemem vmemmap. Without it, lkp reported the following:

ld: arch/x86/mm/init_64.o: in function `remove_pagetable':
init_64.c:(.meminit.text+0xfc7): undefined reference to
`vmem_altmap_free'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311180545.VeyRXEDq-lkp@intel.com/
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 include/linux/memremap.h | 12 ------------
 include/linux/mm.h       | 15 +++++++++++++++
 mm/memremap.c            | 14 +-------------
 mm/sparse-vmemmap.c      | 13 +++++++++++++
 4 files changed, 29 insertions(+), 25 deletions(-)

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
index bf5d0b1b16f4..a90f939d5d57 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3786,6 +3786,21 @@ void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap);
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
+void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
+#else
+static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+{
+	return 0;
+}
+
+static inline void vmem_altmap_free(struct vmem_altmap *altmap,
+				    unsigned long nr_pfns)
+{
+}
+#endif
+
 #define VMEMMAP_RESERVE_NR	2
 #ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 static inline bool __vmemmap_can_optimize(struct vmem_altmap *altmap,
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

