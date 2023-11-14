Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28B47EB60D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjKNSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjKNSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:03:07 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A8129;
        Tue, 14 Nov 2023 10:03:03 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEHvemd001950;
        Tue, 14 Nov 2023 18:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1Yp6f1FjTz6MWL+ah3/xd3SGdtmDVxo3POCoC3LZlzI=;
 b=s1U8xw9gk6cYT1zQBLN+zUsOhYxd3GRpUYfGAzciUOV+8QS9CM2gWdicQ35duVjRnxyq
 ZOFZ0UvJtiuJfGtqwVJ9ejFnOCSFhvH/lNLg3Lrh1Uk7SL/vHfMpfCTCJcyqKx0a9v54
 KWgmTxNkn1WVLxDqj2J/sHZSoF59MuaRHh/cCn733sNS690LJ8QufFieSM25yuxMULLz
 jRxhcT7zW0VPJSL7QSnCUZpsVNeTbNCwlZNlhmVPY/v1nSSbtUZjRmyEv3fP345/egE0
 qKrk9hrpL27J6KzAiAaYHXWcuvkNZxEi+iGLQqGIvxW1zoJkacKxLYAH8k344+xcrUO1 kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdrc065h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:53 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEHwaVn006514;
        Tue, 14 Nov 2023 18:02:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdrc0641-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:51 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEGXxri022358;
        Tue, 14 Nov 2023 18:02:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5k177v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AEI2mAn17826512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 18:02:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1EE120063;
        Tue, 14 Nov 2023 18:02:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98A4D2004E;
        Tue, 14 Nov 2023 18:02:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Nov 2023 18:02:47 +0000 (GMT)
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
Subject: [PATCH 6/8] s390/mm: implement MEM_PHYS_ONLINE MEM_PHYS_OFFLINE memory notifiers
Date:   Tue, 14 Nov 2023 19:02:36 +0100
Message-Id: <20231114180238.1522782-7-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X8TQEr1PfC9_ZSwf_PkeMMAQwyQAaP5M
X-Proofpoint-GUID: 6bW3L6tOpS5WQ1u6Zs9aaPnAoC0Iqwlf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_18,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Implement MEM_PHYS_ONLINE and MEM_PHYS_OFFLINE memory notifiers on s390

Implementation of MEM_PHYS_ONLINE Memory Notifier:
* Transition the memory block to an accessible/online state using the
  sclp assign command.
* Execute __add_pages() for the memory block, enabling a self-contained
  memory map range. For boot-time memory, vmemmap mapping is carried out
  through sparse_init().

Implementation of MEM_PHYS_OFFLINE Memory Notifier:
* Execute __remove_pages() exclusively for the memory block (applicable
  where a self-contained memory map was possible before).
* Shift the memory block to an inaccessible/offline state using the sclp
  unassign command.

Additional Implementation Considerations:
* When MHP_MEMMAP_ON_MEMORY is disabled, the system retains the old
  behavior. This means the memory map is allocated from default memory,
  and struct vmemmap pages are populated during the standby memory
  detection phase.
* With MHP_MEMMAP_ON_MEMORY enabled (allowing self-contained memory
  map), the memory map is allocated using the self-contained memory map
  range. Struct vmemmap pages are populated during the memory hotplug
  phase.
* If MACHINE_HAS_EDAT1 is unavailable, MHP_MEMMAP_ON_MEMORY is
  automatically disabled. This ensures that vmemmap pagetables do not
  consume additional memory from the default memory allocator.
* The MEM_GOING_ONLINE notifier has been modified to perform no
  operation, as MEM_PHYS_ONLINE already executes the sclp assign
  command.
* The MEM_CANCEL_ONLINE notifier now performs no operation, as
  MEM_PHYS_OFFLINE already executes the sclp unassign command.
* The call to __add_pages() in arch_add_memory() with altmap support is
  skipped. This operation is deferred and will be performed later in the
  MEM_PHYS_ONLINE notifier.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/mm/init.c          | 16 +++++++++++++++-
 drivers/s390/char/sclp_cmd.c | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 8d9a60ccb777..db505ed590b2 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -288,6 +288,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	rc = vmem_add_mapping(start, size);
 	if (rc)
 		return rc;
+	/*
+	 * If MHP_MEMMAP_ON_MEMORY is enabled, perform __add_pages() during memory
+	 * onlining phase
+	 */
+	if (params->altmap)
+		return 0;
 
 	rc = __add_pages(nid, start_pfn, size_pages, params);
 	if (rc)
@@ -300,7 +306,15 @@ void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	__remove_pages(start_pfn, nr_pages, altmap);
+	/*
+	 * On s390, currently arch_remove_memory() will be called during error
+	 * handling of add_memory_resource(). When MHP_MEMMAP_ON_MEMORY is
+	 * enabled, __add_pages() is performed later during the memory onlining
+	 * phase.  Hence, __remove_pages() should not be called here in that
+	 * case, but only later during memory offline phase
+	 */
+	if (!altmap)
+		__remove_pages(start_pfn, nr_pages, NULL);
 	vmem_remove_mapping(start, size);
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 11c428f4c7cf..12f3d4af7e4e 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/memory.h>
+#include <linux/memory_hotplug.h>
 #include <linux/module.h>
 #include <asm/ctlreg.h>
 #include <asm/chpid.h>
@@ -26,6 +27,7 @@
 #include <asm/sclp.h>
 #include <asm/numa.h>
 #include <asm/facility.h>
+#include <asm/page-states.h>
 
 #include "sclp.h"
 
@@ -319,6 +321,8 @@ static bool contains_standby_increment(unsigned long start, unsigned long end)
 static int sclp_mem_notifier(struct notifier_block *nb,
 			     unsigned long action, void *data)
 {
+	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
+	struct memory_block *memory_block;
 	unsigned long start, size;
 	struct memory_notify *arg;
 	unsigned char id;
@@ -330,6 +334,11 @@ static int sclp_mem_notifier(struct notifier_block *nb,
 	mutex_lock(&sclp_mem_mutex);
 	for_each_clear_bit(id, sclp_storage_ids, sclp_max_storage_id + 1)
 		sclp_attach_storage(id);
+	memory_block = find_memory_block(pfn_to_section_nr(arg->start_pfn));
+	if (!memory_block) {
+		rc = -EINVAL;
+		goto out;
+	}
 	switch (action) {
 	case MEM_GOING_OFFLINE:
 		/*
@@ -344,17 +353,34 @@ static int sclp_mem_notifier(struct notifier_block *nb,
 	case MEM_CANCEL_OFFLINE:
 		break;
 	case MEM_GOING_ONLINE:
+		break;
+	case MEM_PHYS_ONLINE:
 		rc = sclp_mem_change_state(start, size, 1);
+		if (rc || !memory_block->altmap)
+			goto out;
+		params.altmap = memory_block->altmap;
+		rc = __add_pages(0, arg->start_pfn, arg->nr_pages, &params);
+		if (rc)
+			sclp_mem_change_state(start, size, 0);
+		/*
+		 * Set CMMA state to nodat here, since the struct page memory
+		 * at the beginning of the memory block will not go through the
+		 * buddy allocator later.
+		 */
+		__arch_set_page_nodat((void *)start, memory_block->altmap->free);
 		break;
 	case MEM_CANCEL_ONLINE:
-		sclp_mem_change_state(start, size, 0);
-		break;
 	case MEM_OFFLINE:
+		break;
+	case MEM_PHYS_OFFLINE:
+		if (memory_block->altmap)
+			__remove_pages(arg->start_pfn, arg->nr_pages, memory_block->altmap);
 		sclp_mem_change_state(start, size, 0);
 		break;
 	default:
 		break;
 	}
+out:
 	mutex_unlock(&sclp_mem_mutex);
 	return rc ? NOTIFY_BAD : NOTIFY_OK;
 }
@@ -400,7 +426,8 @@ static void __init add_memory_merged(u16 rn)
 	if (!size)
 		goto skip_add;
 	for (addr = start; addr < start + size; addr += block_size)
-		add_memory(0, addr, block_size, MHP_NONE);
+		add_memory(0, addr, block_size,
+			   MACHINE_HAS_EDAT1 ? MHP_MEMMAP_ON_MEMORY : MHP_NONE);
 skip_add:
 	first_rn = rn;
 	num = 1;
-- 
2.41.0

