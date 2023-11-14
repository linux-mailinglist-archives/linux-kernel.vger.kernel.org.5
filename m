Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3584B7EB603
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjKNSDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjKNSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:03:05 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CCFFD;
        Tue, 14 Nov 2023 10:03:01 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEHmjJl000591;
        Tue, 14 Nov 2023 18:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gcatVFRylgUt8az7PKF3Ve1gzVhxgYmwZT9J8GPrpLY=;
 b=XBiMfqZ/l9GZtCoBIFQA/jkxYJHcUDru4iN/e9ysnae0JlSOL5OlyspucGPD2QblpKtw
 cArsNiC6VXBpy+vk0Q6sEbMrlke2Kc9/5TSca8XsSocErktzv8L1e6b9RHPFh+YDt8xD
 y81MbsqEGkNr9og2tPCiZJVtuRZXa2TwA5RP9IXx+LTbKCJXuD6nUIt5BIMBWHPxXKNu
 PrWxESVSOY6wjf3Gbd2/+kcPjzJBvLfDyv/9ldfiZTyZrDXXavLbITU8W+qjE8sTv+Uc
 9ppGnEiOHiZAMDGoXzEVWHN1o7nv9q4B+hutuu7VqGm8RQTv78+4fcKwyJG9ahm/UQNr cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdeg8r9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:51 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEHan3d021195;
        Tue, 14 Nov 2023 18:02:50 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdeg8r8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:50 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEGXurS009528;
        Tue, 14 Nov 2023 18:02:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uakxst00s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AEI2lCQ28639800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 18:02:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 249462004D;
        Tue, 14 Nov 2023 18:02:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF7A52004E;
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
Subject: [PATCH 4/8] mm/memory_hotplug: introduce MEM_PHYS_ONLINE/OFFLINE memory notifiers
Date:   Tue, 14 Nov 2023 19:02:34 +0100
Message-Id: <20231114180238.1522782-5-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3-B0AODtqVsG1D4YTR0K2oZv4CBkSvD_
X-Proofpoint-GUID: A7TIJdN-oyc-T-PIMNWKJUo0g9NKc9hB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_18,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=601 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new memory notifiers to mimic the dynamic ACPI event triggered logic
for memory hotplug on platforms that do not generate such events. This
will be used to implement "memmap on memory" feature for s390 in a later
patch.

Platforms such as x86 can support physical memory hotplug via ACPI. When
there is physical memory hotplug, ACPI event leads to the memory
addition with the following callchain:
acpi_memory_device_add()
  -> acpi_memory_enable_device()
     -> __add_memory()

After this, the hotplugged memory is physically accessible, and altmap
support prepared, before the "memmap on memory" initialization in
memory_block_online() is called.

On s390, memory hotplug works in a different way. The available hotplug
memory has to be defined upfront in the hypervisor, but it is made
physically accessible only when the user sets it online via sysfs,
currently in the MEM_GOING_ONLINE notifier. This requires calling
add_memory() during early memory detection, in order to get the sysfs
representation, but we cannot use "memmap on memory" altmap support at
this stage, w/o having it physically accessible.

Since no ACPI or similar events are generated, there is no way to set up
altmap support, or even make the memory physically accessible at all,
before the "memmap on memory" initialization in memory_block_online().

The new MEM_PHYS_ONLINE notifier allows to work around this, by
providing a hook to make the memory physically accessible, and also call
__add_pages() with altmap support, early in memory_block_online().
Similarly, the MEM_PHYS_OFFLINE notifier allows to make the memory
inaccessible and call __remove_pages(), at the end of
memory_block_offline().

Calling __add/remove_pages() requires mem_hotplug_lock, so move
mem_hotplug_begin/done() to include the new notifiers.

All architectures ignore unknown memory notifiers, so this patch should
not introduce any functional changes.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/base/memory.c  | 18 +++++++++++++++++-
 include/linux/memory.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 1e9f6a1749b9..604940f62246 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -185,6 +185,7 @@ static int memory_block_online(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = 0;
+	struct memory_notify arg;
 	struct zone *zone;
 	int ret;
 
@@ -194,6 +195,14 @@ static int memory_block_online(struct memory_block *mem)
 	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
 				  start_pfn, nr_pages);
 
+	arg.start_pfn = start_pfn;
+	arg.nr_pages = nr_pages;
+	mem_hotplug_begin();
+	ret = memory_notify(MEM_PHYS_ONLINE, &arg);
+	ret = notifier_to_errno(ret);
+	if (ret)
+		goto out_notifier;
+
 	/*
 	 * Although vmemmap pages have a different lifecycle than the pages
 	 * they describe (they remain until the memory is unplugged), doing
@@ -204,7 +213,6 @@ static int memory_block_online(struct memory_block *mem)
 	if (mem->altmap)
 		nr_vmemmap_pages = mem->altmap->free;
 
-	mem_hotplug_begin();
 	if (nr_vmemmap_pages) {
 		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages, zone);
 		if (ret)
@@ -228,7 +236,11 @@ static int memory_block_online(struct memory_block *mem)
 					  nr_vmemmap_pages);
 
 	mem->zone = zone;
+	mem_hotplug_done();
+	return ret;
 out:
+	memory_notify(MEM_PHYS_OFFLINE, &arg);
+out_notifier:
 	mem_hotplug_done();
 	return ret;
 }
@@ -238,6 +250,7 @@ static int memory_block_offline(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = 0;
+	struct memory_notify arg;
 	int ret;
 
 	if (!mem->zone)
@@ -269,6 +282,9 @@ static int memory_block_offline(struct memory_block *mem)
 		mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
 
 	mem->zone = NULL;
+	arg.start_pfn = start_pfn;
+	arg.nr_pages = nr_pages;
+	memory_notify(MEM_PHYS_OFFLINE, &arg);
 out:
 	mem_hotplug_done();
 	return ret;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index f53cfdaaaa41..5d8b962b8fa1 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -96,6 +96,8 @@ int set_memory_block_size_order(unsigned int order);
 #define	MEM_GOING_ONLINE	(1<<3)
 #define	MEM_CANCEL_ONLINE	(1<<4)
 #define	MEM_CANCEL_OFFLINE	(1<<5)
+#define	MEM_PHYS_ONLINE		(1<<6)
+#define	MEM_PHYS_OFFLINE	(1<<7)
 
 struct memory_notify {
 	unsigned long start_pfn;
-- 
2.41.0

