Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1088F7F5AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjKWJYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWJYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:24:04 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37071A4;
        Thu, 23 Nov 2023 01:24:10 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN8GH1E024136;
        Thu, 23 Nov 2023 09:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ewbkfVQBj0M9I8UbdtY2XS3tABNia4iOMwJYWS5n50M=;
 b=P2jwBsiiB9KZyUclRC/qIyrUvPimJExVuso8pPMvhDFqzEnEEP6RTF9U4M+jEFRvpRAl
 S7tj8Pfe5IN88qMxiXVRU1ugV73Z/6bjzcguT08hKmZfqDor90Gt+ufKcfoMpljMn3Pm
 hQIqbal1makbqsnaqlUHDQ8exFF4lCpkGppShjh0BFb8MAzLXjAv9eDwfHvq+NCHyavj
 QY0MK0Zd9HNDvOqPJbzJtln1LtBNlSx/5CrBh6E5y6zRote50nhHBhH7+S9/A4U52kmP
 ZHLUPjA/pDTfXnGpYFRm57yYIaNvmb1OHocKZwlwqHV/H1FBuDEiMKkZKfr07yjgdSfr sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj32u1n6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:24:02 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AN8fN6u006581;
        Thu, 23 Nov 2023 09:24:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj32u1n4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:24:01 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN8n31u018103;
        Thu, 23 Nov 2023 09:23:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa2dp5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 09:23:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AN9NvBi2163292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 09:23:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1819320040;
        Thu, 23 Nov 2023 09:23:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEAC320043;
        Thu, 23 Nov 2023 09:23:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Nov 2023 09:23:56 +0000 (GMT)
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
Subject: [PATCH v2 6/7] s390/mm: implement MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
Date:   Thu, 23 Nov 2023 10:23:42 +0100
Message-Id: <20231123092343.1703707-7-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123092343.1703707-1-sumanthk@linux.ibm.com>
References: <20231123092343.1703707-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nApaJoMH-KY3uRKJLQnwJfmUJM5pdMoa
X-Proofpoint-ORIG-GUID: sXRtQvlnca6MCDp35otHAIbFMyCOS4rl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MEM_PREPARE_ONLINE memory notifier makes memory block physical
accessible via sclp assign command. The notifier ensures self-contained
memory maps are accessible and hence enabling the "memmap on memory" on
s390.

MEM_FINISH_OFFLINE memory notifier shifts the memory block to an
inaccessible state via sclp unassign command.

Implementation considerations:
* When MHP_MEMMAP_ON_MEMORY is disabled, the system retains the old
  behavior. This means the memory map is allocated from default memory.
* If MACHINE_HAS_EDAT1 is unavailable, MHP_MEMMAP_ON_MEMORY is
  automatically disabled. This ensures that vmemmap pagetables do not
  consume additional memory from the default memory allocator.
* The MEM_GOING_ONLINE notifier has been modified to perform no
  operation, as MEM_PREPARE_ONLINE already executes the sclp assign
  command.
* The MEM_CANCEL_ONLINE/MEM_OFFLINE notifier now performs no operation, as
  MEM_FINISH_OFFLINE already executes the sclp unassign command.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 drivers/s390/char/sclp_cmd.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 355e63e44e95..30b829e4c052 100644
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
 
@@ -319,6 +321,7 @@ static bool contains_standby_increment(unsigned long start, unsigned long end)
 static int sclp_mem_notifier(struct notifier_block *nb,
 			     unsigned long action, void *data)
 {
+	struct memory_block *memory_block;
 	unsigned long start, size;
 	struct memory_notify *arg;
 	unsigned char id;
@@ -340,18 +343,29 @@ static int sclp_mem_notifier(struct notifier_block *nb,
 		if (contains_standby_increment(start, start + size))
 			rc = -EPERM;
 		break;
-	case MEM_GOING_ONLINE:
+	case MEM_PREPARE_ONLINE:
+		memory_block = find_memory_block(pfn_to_section_nr(arg->start_pfn));
+		if (!memory_block) {
+			rc = -EINVAL;
+			goto out;
+		}
 		rc = sclp_mem_change_state(start, size, 1);
+		if (rc || !memory_block->altmap)
+			goto out;
+		/*
+		 * Set CMMA state to nodat here, since the struct page memory
+		 * at the beginning of the memory block will not go through the
+		 * buddy allocator later.
+		 */
+		__arch_set_page_nodat((void *)__va(start), memory_block->altmap->free);
 		break;
-	case MEM_CANCEL_ONLINE:
-		sclp_mem_change_state(start, size, 0);
-		break;
-	case MEM_OFFLINE:
+	case MEM_FINISH_OFFLINE:
 		sclp_mem_change_state(start, size, 0);
 		break;
 	default:
 		break;
 	}
+out:
 	mutex_unlock(&sclp_mem_mutex);
 	return rc ? NOTIFY_BAD : NOTIFY_OK;
 }
@@ -397,7 +411,9 @@ static void __init add_memory_merged(u16 rn)
 	if (!size)
 		goto skip_add;
 	for (addr = start; addr < start + size; addr += block_size)
-		add_memory(0, addr, block_size, MHP_NONE);
+		add_memory(0, addr, block_size,
+			   MACHINE_HAS_EDAT1 ?
+			   MHP_MEMMAP_ON_MEMORY | MHP_OFFLINE_INACCESSIBLE : MHP_NONE);
 skip_add:
 	first_rn = rn;
 	num = 1;
-- 
2.39.2

