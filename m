Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07167EB60A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 19:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjKNSDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 13:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjKNSDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 13:03:06 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408AF121;
        Tue, 14 Nov 2023 10:03:03 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEHaZXB020727;
        Tue, 14 Nov 2023 18:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UXuiVxrhS/ib2MzACnKB4Rr4sLIRlSyid8ooltH0jI4=;
 b=RAplVQvp9sbVP0ga+9CZJuhytEzKojnJWmvaIbG58Wyy0i9tFegtR5SIG8R7PuKRl+WX
 XCYV4llb51bYAr4H3bsqYZ5habUIJz7TfHifnJkVBPKLNAoWoh/6fj6hn0kIUz8uxX26
 vg/DcsMbgP9nanKYNyWBS5ohLS8EKK0REJLvNIgWcrTDPgSnnOlvQXTzJqlXK2hFPugq
 0q7NCVJsQC0XSToXpFcMAEZ0LpRTx0nE9Qyj7yuUXB8GuS25MjwurEaU1Sj6WgMY3TRs
 0WQ/AI+JmIa7Kx4nkapIQKlNeq/JpM6qSRq6DEL5TEgM+6haaQHdYDQz4V5xL1eYjvH4 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdeg8r9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:52 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEHbOQq022529;
        Tue, 14 Nov 2023 18:02:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdeg8r8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEGY3Oa020091;
        Tue, 14 Nov 2023 18:02:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxn9kn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 18:02:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AEI2keY40895122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 18:02:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F0F22004D;
        Tue, 14 Nov 2023 18:02:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9B462005A;
        Tue, 14 Nov 2023 18:02:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Nov 2023 18:02:45 +0000 (GMT)
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
Subject: [PATCH 2/8] mm/memory_hotplug: fix error handling in add_memory_resource()
Date:   Tue, 14 Nov 2023 19:02:32 +0100
Message-Id: <20231114180238.1522782-3-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
References: <20231114180238.1522782-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jVaEeKBBA0p_qfPGMQOSGvCcx2fmXvce
X-Proofpoint-GUID: 27rzWHrwdprSxIiUtgE4QBwK6wgOC6zP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_18,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=543 malwarescore=0 spamscore=0 adultscore=0
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

In add_memory_resource(), creation of memory block devices occurs after
successful call to arch_add_memory(). However, creation of memory block
devices could fail.  In that case, arch_remove_memory() is called to
perform necessary cleanup.

Currently with or without altmap support, arch_remove_memory() is always
passed with altmap set to NULL during error handling. This leads to
freeing of struct pages using free_pages(), eventhough the allocation
might have been performed with altmap support via
altmap_alloc_block_buf().

Fix the error handling by passing altmap in arch_remove_memory(). This
ensures the following:
* When altmap is disabled, deallocation of the struct pages array occurs
  via free_pages().
* When altmap is enabled, deallocation occurs via vmem_altmap_free().

Fixes: db051a0dac13 ("mm/memory_hotplug: create memory block devices after arch_add_memory()")
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c8238fc5edcb..4f476a970e84 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1458,7 +1458,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	/* create memory block devices after memory was added */
 	ret = create_memory_block_devices(start, size, params.altmap, group);
 	if (ret) {
-		arch_remove_memory(start, size, NULL);
+		arch_remove_memory(start, size, params.altmap);
 		goto error_free;
 	}
 
-- 
2.41.0

