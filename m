Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F87812309
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442715AbjLMXgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjLMXgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:36:44 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19454F4;
        Wed, 13 Dec 2023 15:36:51 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKaLpJ003679;
        Wed, 13 Dec 2023 23:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aJy+33XKEF6nDugdst7XcqtyB+KXoQlaeqKIDwP5hKQ=;
 b=fJkCRxEnz4TCEiNvpMNnoQPJZFVJAnESonm7egrOJLGpr262EOGwp7WtzR47JmQwsYnl
 zGpRAHgg2LvR2lToAllUludnw/fGltCIOGb78kUQRtz7wtRkNcPklvbuVHb7t6G51mY0
 AXmxuP4VMlgxJBSZl+m3l3YR5l23FCXhKLJ49dl7o+jG/VDJM/aHPTa7Ixt+FV3LWkXM
 AARgHKdDMkCNshOYruiHQGFbHpuwB0vrTbJ7GKhh5n2Vxm5hO77w47Sj3R//Tvy/Xp2n
 wLNaR36Qzl4xqHfnZvZhb4XCd+P9aA4FOVFgDvhlmKXeSRQkZRj5NEo+XuL7sGV07J3U Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uykek48ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:26 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDNaHiY022962;
        Wed, 13 Dec 2023 23:36:25 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uykek48y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:25 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDNFEm5013937;
        Wed, 13 Dec 2023 23:36:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw592c4f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDNaKdT17695252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 23:36:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C56F820043;
        Wed, 13 Dec 2023 23:36:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 611AD20040;
        Wed, 13 Dec 2023 23:36:19 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.156])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Dec 2023 23:36:19 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 07/34] kmsan: Remove a useless assignment from kmsan_vmap_pages_range_noflush()
Date:   Thu, 14 Dec 2023 00:24:27 +0100
Message-ID: <20231213233605.661251-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213233605.661251-1-iii@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i4JpRSSp29x3tjdWkj2o92p0bxjHziCE
X-Proofpoint-ORIG-GUID: PRnzVNAw21kFZDf3ZPbjJSrCYd2IExSw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=997 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value assigned to prot is immediately overwritten on the next line
with PAGE_KERNEL. The right hand side of the assignment has no
side-effects.

Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operations")
Suggested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/shadow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index b9d05aff313e..2d57408c78ae 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -243,7 +243,6 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 		s_pages[i] = shadow_page_for(pages[i]);
 		o_pages[i] = origin_page_for(pages[i]);
 	}
-	prot = __pgprot(pgprot_val(prot) | _PAGE_NX);
 	prot = PAGE_KERNEL;
 
 	origin_start = vmalloc_meta((void *)start, KMSAN_META_ORIGIN);
-- 
2.43.0

