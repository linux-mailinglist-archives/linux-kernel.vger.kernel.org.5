Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D62A7F2E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjKUNNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjKUNNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:13:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E52097;
        Tue, 21 Nov 2023 05:13:39 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALD8aDG014292;
        Tue, 21 Nov 2023 13:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=FVLudUXUSGBYrgKo4pjp6gW2MJGR16/V+Q84VE+FdT4=;
 b=RTiOE0dcISiB10gBTWM52WD5taMYo+spqImDJa9yPg1sRPuKLCm40Gv18xWymnqpvxxO
 eR2+x7Lck8iN157vRHUtZ85mV/kPSgpYoFw6h3/7BupCgz8B9m2eK+BBeoNybytYXfsE
 23/clwKa0XId8ybFMqGp/yOKRVLwPcFq1DES30AE60Uv43Z2UxDQRhyY6SQfWeJpw3a0
 U1GKETkC2g6lgj0Bo6aTw3jnQQUd7NkArDpQ2MSso8SHFgdqectSLcToUe1CiQjFs2Jv
 9I0ldvdif4V63rahqYWCMDy5f8gw0q5bAfGIU07kDKOaZBtYi5uKCCBqzfyuFL51gzZ3 yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugw5wg7ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 13:13:27 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALD918p016490;
        Tue, 21 Nov 2023 13:13:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugw5wg7t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 13:13:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALD4MFx001932;
        Tue, 21 Nov 2023 13:13:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yygx7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 13:13:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALDDMwf17302072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 13:13:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C1592004F;
        Tue, 21 Nov 2023 13:13:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8CE720043;
        Tue, 21 Nov 2023 13:13:21 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.171.14.211])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Nov 2023 13:13:21 +0000 (GMT)
Date:   Tue, 21 Nov 2023 14:13:20 +0100
From:   Sumanth Korikkar <sumanthk@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] implement "memmap on memory" feature on s390
Message-ID: <ZVys8HF1lgbA8u0c@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
 <ec3fcd7d-17a0-4901-9261-a204c2c50c52@redhat.com>
 <20231117140009.5d8a509c@thinkpad-T15>
 <ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee492da8-74b4-4a97-8b24-73e07257f01d@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AJanLlsY0DZjit79sGiGlLyBnR8MrbUo
X-Proofpoint-GUID: 16ssfV0qc6WYzzIzCYXOAZjH7Oqe5kmd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=96 lowpriorityscore=0
 mlxscore=96 bulkscore=0 spamscore=96 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=-136 priorityscore=1501
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 04:37:29PM +0100, David Hildenbrand wrote:
> > 
> > Maybe there is also already a common code bug with that, s390 might be
> > special but that is often also good for finding bugs in common code ...
> 
> If it's only the page_init_poison() as noted by Sumanth, we could disable
> that on s390x with an altmap some way or the other; should be possible.
> 
> I mean, you effectively have your own poisoning if the altmap is effectively
> inaccessible and makes your CPU angry on access :)
> 
> Last but not least, support for an inaccessible altmap might come in handy
> for virtio-mem eventually, and make altmap support eventually simpler. So
> added bonus points.

We tried out two possibilities dealing with vmemmap altmap inaccessibilty.
Approach 1: Add MHP_ALTMAP_INACCESSIBLE flag and pass it in add_memory()

diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 075094ca59b4..ab2dfcc7e9e4 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -358,6 +358,13 @@ static int sclp_mem_notifier(struct notifier_block *nb,
 		 * buddy allocator later.
 		 */
 		__arch_set_page_nodat((void *)__va(start), memory_block->altmap->free);
+		/*
+		 * Poison the struct pages after memory block is accessible.
+		 * This is needed for only altmap. Without altmap, the struct
+		 * pages are poisoined in sparse_add_section().
+		 */
+		if (memory_block->altmap->inaccessible)
+			page_init_poison(pfn_to_page(arg->start_pfn), memory_block->altmap->free);
 		break;
 	case MEM_FINISH_OFFLINE:
 		sclp_mem_change_state(start, size, 0);
@@ -412,7 +419,7 @@ static void __init add_memory_merged(u16 rn)
 		goto skip_add;
 	for (addr = start; addr < start + size; addr += block_size)
 		add_memory(0, addr, block_size,
-			   MACHINE_HAS_EDAT1 ? MHP_MEMMAP_ON_MEMORY : MHP_NONE);
+			   MACHINE_HAS_EDAT1 ? MHP_MEMMAP_ON_MEMORY|MHP_ALTMAP_INACCESSIBLE : MHP_NONE);
 skip_add:
 	first_rn = rn;
 	num = 1;
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7d2076583494..5c70707e706f 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -106,6 +106,11 @@ typedef int __bitwise mhp_t;
  * implies the node id (nid).
  */
 #define MHP_NID_IS_MGID		((__force mhp_t)BIT(2))
+/*
+ * Mark memmap on memory (struct pages array) as inaccessible during memory
+ * hotplug addition phase.
+ */
+#define MHP_ALTMAP_INACCESSIBLE	((__force mhp_t)BIT(3))
 
 /*
  * Extended parameters for memory hotplug:
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 744c830f4b13..9837f3e6fb95 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -25,6 +25,7 @@ struct vmem_altmap {
 	unsigned long free;
 	unsigned long align;
 	unsigned long alloc;
+	bool inaccessible;
 };
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7a5fc89a8652..d8299853cdcc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1439,6 +1439,8 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
 		if (mhp_supports_memmap_on_memory(size)) {
 			mhp_altmap.free = memory_block_memmap_on_memory_pages();
+			if (mhp_flags & MHP_ALTMAP_INACCESSIBLE)
+				mhp_altmap.inaccessible = true;
 			params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
 			if (!params.altmap) {
 				ret = -ENOMEM;
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


Approach 2:
===========
Shouldnt kasan zero shadow mapping performed first before
accessing/initializing memmap via page_init_poisining()?  If that is
true, then it is a problem for all architectures and should could be
fixed like:


diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7a5fc89a8652..eb3975740537 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1093,6 +1093,7 @@ int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 	if (ret)
 		return ret;

+	page_init_poison(pfn_to_page(pfn), sizeof(struct page) * nr_pages);
 	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_UNMOVABLE);

 	for (i = 0; i < nr_pages; i++)
diff --git a/mm/sparse.c b/mm/sparse.c
index 77d91e565045..4ddf53f52075 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -906,8 +906,11 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
 	/*
 	 * Poison uninitialized struct pages in order to catch invalid flags
 	 * combinations.
+	 * For altmap, do this later when onlining the memory, as it might
+	 * not be accessible at this point.
 	 */
-	page_init_poison(memmap, sizeof(struct page) * nr_pages);
+	if (!altmap)
+		page_init_poison(memmap, sizeof(struct page) * nr_pages);

 	ms = __nr_to_section(section_nr);
 	set_section_nid(section_nr, nid);



Also, if this approach is taken, should page_init_poison() be performed
with cond_resched() as mentioned in commit d33695b16a9f
("mm/memory_hotplug: poison memmap in remove_pfn_range_from_zone()") ?

Opinions?

Thank you
