Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BEC7F32A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjKUPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjKUPqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:46:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E099;
        Tue, 21 Nov 2023 07:46:39 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALFW5fU000814;
        Tue, 21 Nov 2023 15:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Kc0D4WzPKq3iWD2G8Wh6oSBHInN47itmeV13Xhjx3os=;
 b=AumFU0KfGSn8ZhpF7eq2J/+mxKBooIeUwTQDv2m3J32YGyijl6indK6y9OkC/dpWAnhO
 4xVbh/85nHg6yBd/orGBODvJXlyRyy+69/7NJiUGlJ0B0IZUt6CHGTLV2pLwHAil0arp
 rFWerUY2L130IKMCbv8jfuUHiOaVicm1gVhJahlyNEmehZhDMUfS5Nq/HqkHcgkIInGF
 +0CD8k3szuxI8ir0YATHxbMa/xQxU+4CvMEaCtB/t78icFicTq8886GZ16ouVhy/HLf4
 KUSCj+9KLNaBTrexsklNcY1kJjIgtGmzpAYKwixb0wh78g1nGsIjW8r95jIcM3gSEby3 VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugy98gqux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 15:46:33 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALFifwl012309;
        Tue, 21 Nov 2023 15:45:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ugy98gq0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 15:45:35 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALDngrL021057;
        Tue, 21 Nov 2023 15:45:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yyhrq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 15:45:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALFjNSE26739236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 15:45:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E604020043;
        Tue, 21 Nov 2023 15:45:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B391A20040;
        Tue, 21 Nov 2023 15:45:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Nov 2023 15:45:22 +0000 (GMT)
Date:   Tue, 21 Nov 2023 16:45:21 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH v2] pgtable: do not expose _refcount field via ptdesc
Message-ID: <ZVzQkTueDRSJ76me@tuxmaker.boeblingen.de.ibm.com>
References: <20231121120310.696335-1-agordeev@linux.ibm.com>
 <20231121144717.6318-A-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121144717.6318-A-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5-3E7TzkY4XFvme5GjwB1HczMe7vwYwm
X-Proofpoint-GUID: PBEsB0zrvUBrRPq6pxPf0lYE_n0UT9zW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_09,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d08d4e7cd6bf ("s390/mm: use full 4KB page for 2KB PTE")
_refcount field is not used for fragmented page tracking on s390 and
there is no other code left that accesses this field explicitly.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/linux/mm_types.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 957ce38768b2..ce0cfc6e4d94 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -401,11 +401,11 @@ FOLIO_MATCH(compound_head, _head_2a);
  * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
  * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
  * @pt_mm:            Used for x86 pgds.
- * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
+ * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
  * @_pt_pad_2:        Padding to ensure proper alignment.
  * @ptl:              Lock for the page table.
  * @__page_type:      Same as page->page_type. Unused for page tables.
- * @_refcount:        Same as page refcount. Used for s390 page tables.
+ * @_pt_pad_3:        Padding that aliases with page's refcount.
  * @pt_memcg_data:    Memcg data. Tracked for page tables here.
  *
  * This struct overlays struct page for now. Do not modify without a good
@@ -438,7 +438,7 @@ struct ptdesc {
 #endif
 	};
 	unsigned int __page_type;
-	atomic_t _refcount;
+	unsigned int _pt_pad_3;
 #ifdef CONFIG_MEMCG
 	unsigned long pt_memcg_data;
 #endif
@@ -452,7 +452,6 @@ TABLE_MATCH(compound_head, _pt_pad_1);
 TABLE_MATCH(mapping, __page_mapping);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
-TABLE_MATCH(_refcount, _refcount);
 #ifdef CONFIG_MEMCG
 TABLE_MATCH(memcg_data, pt_memcg_data);
 #endif
-- 
2.39.2

