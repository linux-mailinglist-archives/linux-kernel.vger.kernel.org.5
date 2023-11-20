Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB857F1058
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjKTK2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:28:06 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A899BA0;
        Mon, 20 Nov 2023 02:28:00 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKA9ab1008039;
        Mon, 20 Nov 2023 10:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=YuByY8UcYVe/2pEd+OXjEA/TKfRRXD0L4gZpHO5Zb+c=;
 b=fQ8tHwWbTtNepEiyf8FAlx5ZNOsU1NSYcKwGQLeasfjjpjc1YomQLQ9jhf1zrJwqVYaq
 JCfcWMbXzX4Bvhk3fZs8WbfhcXHup1/mo9nPE5qFgepaJPSS33RvK6bYw3y9vYNOQTfO
 haWG6sUkoob80g/tX8T4THCQGauLU/c8ahbXfvi5wARiV0Sh4qKQA3LGDcg4irjoq/nj
 GJF66MCkjLgzlrJ0XX92BZ5LFtEuVDGrPm/ICYmTYt41F+MYdjOFMLqWOIzpUJvpySZr
 gjlCEB2jVlW+6CKWN4i2xwVB3gb5seFgsgEupnTIbumA1PXmHKf0Cssx/k/no/dNjbAq QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug5f68nv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:27:49 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AKA9d7T008206;
        Mon, 20 Nov 2023 10:27:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ug5f68nuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:27:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKAJlsc028315;
        Mon, 20 Nov 2023 10:27:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7ksrs6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:27:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AKARjtA16319228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 10:27:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CCEF20043;
        Mon, 20 Nov 2023 10:27:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 044B32004E;
        Mon, 20 Nov 2023 10:27:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 20 Nov 2023 10:27:44 +0000 (GMT)
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
        LKML <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 3/3] mm: use vmem_altmap code without CONFIG_ZONE_DEVICE
Date:   Mon, 20 Nov 2023 11:27:34 +0100
Message-Id: <20231120102734.2001576-4-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120102734.2001576-1-sumanthk@linux.ibm.com>
References: <20231120102734.2001576-1-sumanthk@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YUzjKIfFsqOrpbts2GRzQdmR2_ToRB-W
X-Proofpoint-GUID: GxddkNpk9q-fOwTroGesLN7lVj1DNFDi
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_08,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 mlxlogscore=645 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311200069
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
 include/linux/mm.h       | 26 ++++++++++++++++++++++++++
 mm/memremap.c            | 14 +-------------
 3 files changed, 27 insertions(+), 25 deletions(-)

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
index bf5d0b1b16f4..f2344fd8acbe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3786,6 +3786,32 @@ void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap);
 #endif
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+static inline unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
+{
+	/* number of pfns from base where pfn_to_page() is valid */
+	if (altmap)
+		return altmap->reserve + altmap->free;
+	return 0;
+}
+
+static inline void vmem_altmap_free(struct vmem_altmap *altmap,
+				    unsigned long nr_pfns)
+{
+	altmap->alloc -= nr_pfns;
+}
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
-- 
2.41.0

