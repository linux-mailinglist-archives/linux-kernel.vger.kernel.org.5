Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035857F5B01
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjKWJYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKWJYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:24:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5D2DD;
        Thu, 23 Nov 2023 01:24:11 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN97U12030589;
        Thu, 23 Nov 2023 09:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uoYg6XFVhnl9z1m4lIqYlmnlEpI3Bitpu8U7076l1/0=;
 b=NfaQnenE1yp4HWqR+BEL+kF6EZb5gVgWUwl18bsE/tWMoGAd9ruHHX6xCyzEWnlEwpNg
 YqEhLPKXe1WJXRGSIaHlezzfvfEWr4se4tlYZWQm2H1PkN8sIi09W/inz3f11xsYdKKZ
 cTVClozXIqZcTAi8TzH1XmPJ6iWu2SD6A3VNS6sydVKrfSzZjwz7Ze8O4ZVQARoCYRft
 O8otFGiHDfIfgYHIZCVGrbVrocnU3J6MMAIWVmYdRyUMnE5mrcrYDBo6kZSt9QxddrIr
 ulcYI9PIzeO71Xdc5bk8ZAwWaNP3vyXxkUF/pbKRTiv3BlPJw7mj1vyXSndsXozDqIW9 pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj3twrepb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:24:00 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN9FU5P027019;
        Thu, 23 Nov 2023 09:24:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj3twrenq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:24:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN8nA1Y018157;
        Thu, 23 Nov 2023 09:23:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa2dp5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:23:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AN9Nuaj29229738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 09:23:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F08620040;
        Thu, 23 Nov 2023 09:23:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 005CB20043;
        Thu, 23 Nov 2023 09:23:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Nov 2023 09:23:55 +0000 (GMT)
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/7] mm/memory_hotplug: avoid poisoning memmap during mhp addition phase
Date:   Thu, 23 Nov 2023 10:23:38 +0100
Message-Id: <20231123092343.1703707-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123092343.1703707-1-sumanthk@linux.ibm.com>
References: <20231123092343.1703707-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F68q5nW_FI2KdT5X8K-1UeDdw0_hK_Ml
X-Proofpoint-ORIG-GUID: kQUWhC4ccdO8whY8KOUfTcwkFzLFfVMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxlogscore=356
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311230067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memory block is marked inaccessible, avoid page_init_poison() on
memmap during memory hotplug addition phase. Instead, perform it later
when the memory is physically accessible in memory hotplug online phase.

When the memory block is marked accessible (by default turned on without
passing any mhp_flags), page poisoning initialization on memmap is
performed in sparse_add_section().

Page init poisining on memmap is performed with cond_resched(). This
reflects the functionality of commit d33695b16a9f ("mm/memory_hotplug:
poison memmap in remove_pfn_range_from_zone()")

Architectures can pass MHP_OFFLINE_INACCESSIBLE mhp_flag in add_memory()
to mark the memory block as initially inaccessible during memory hotplug
addition phase.

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c          |  3 ++-
 include/linux/memory_hotplug.h |  2 +-
 mm/memory_hotplug.c            | 27 ++++++++++++++++++++++++++-
 mm/sparse.c                    |  3 ++-
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 51915d5c3f88..cbff43b2ef44 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -209,7 +209,8 @@ static int memory_block_online(struct memory_block *mem)
 
 	mem_hotplug_begin();
 	if (nr_vmemmap_pages) {
-		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
+		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages,
+						zone, mem->inaccessible);
 		if (ret)
 			goto out;
 	}
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 8988cd5ad55d..791bc019e992 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -164,7 +164,7 @@ extern void adjust_present_page_count(struct page *page,
 				      long nr_pages);
 /* VM interface that may be used by firmware interface */
 extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
-				     struct zone *zone);
+				     struct zone *zone, bool mhp_off_inaccessible);
 extern void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages);
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
 			struct zone *zone, struct memory_group *group);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1e02eba166b0..ac7cfc09502d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1083,8 +1083,25 @@ void adjust_present_page_count(struct page *page, struct memory_group *group,
 		group->present_kernel_pages += nr_pages;
 }
 
+static void page_init_poison_with_resched(unsigned long start_pfn, unsigned long nr_pages)
+{
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn, cur_nr_pages;
+
+	/* Poison struct pages because they are now uninitialized again. */
+	for (pfn = start_pfn; pfn < end_pfn; pfn += cur_nr_pages) {
+		cond_resched();
+
+		/* Select all remaining pages up to the next section boundary */
+		cur_nr_pages =
+			min(end_pfn - pfn, SECTION_ALIGN_UP(pfn + 1) - pfn);
+		page_init_poison(pfn_to_page(pfn),
+				 sizeof(struct page) * cur_nr_pages);
+	}
+}
+
 int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
-			      struct zone *zone)
+			      struct zone *zone, bool mhp_off_inaccessible)
 {
 	unsigned long end_pfn = pfn + nr_pages;
 	int ret, i;
@@ -1092,6 +1109,14 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 	ret = kasan_add_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
 	if (ret)
 		return ret;
+	/*
+	 * Memory block is accessible at this stage and hence poison the struct
+	 * pages now.  If the memory block is accessible during memory hotplug
+	 * addition phase, then page poisining is already performed in
+	 * sparse_add_section().
+	 */
+	if (mhp_off_inaccessible)
+		page_init_poison_with_resched(pfn, nr_pages);
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);
 
 	for (i = 0; i < nr_pages; i++)
diff --git a/mm/sparse.c b/mm/sparse.c
index 77d91e565045..3991c717b769 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -907,7 +907,8 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
 	 */
-	page_init_poison(memmap, sizeof(struct page) * nr_pages);
+	if (!altmap || !altmap->inaccessible)
+		page_init_poison(memmap, sizeof(struct page) * nr_pages);
 
 	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);
-- 
2.39.2

