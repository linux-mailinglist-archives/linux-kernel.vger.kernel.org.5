Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8358176450C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjG0Eqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjG0Eqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:46:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57FE2736;
        Wed, 26 Jul 2023 21:46:31 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36R4butD023417;
        Thu, 27 Jul 2023 04:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=DKK8DrzPBzpvAD68FwmJDzOHQA0NfeNxPOhA1uhcEOo=;
 b=oH9C7Cw7TJajP9rknk4nJmtzNuj10O303+fsjUUckAEbeWY8joVqrYZYV/pBdvKADi6K
 8LfdhSfvQawEj3Ve9tfiE6Jcv4ZMdNSzfMLsDUxOgUpqRbZSTorN5jH7Kz6pp01UWbFr
 lFNBKpRJ7ygemubBLtJSCpYklcaBdK44EudupBVoBH0BNWe++4gE4S6901glivkTaLA1
 iOdkc3KnyUspbOWM3isMHInYLPM485kbDyGkNRj9s7R2cOsYw0ROoZryYdjlqKXJ0Dnu
 2uTePUd0kB7mCp4GMz+bdqofpaO4WF32kkSgmL0EDx6FkwEjmkSr3d5w1cbZ6uZDX/uT YA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3hjj8awq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:46:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36R4STLJ003634;
        Thu, 27 Jul 2023 04:46:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0txkacyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 04:46:24 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36R4kNtr20316490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 04:46:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D45C05805E;
        Thu, 27 Jul 2023 04:46:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F44958051;
        Thu, 27 Jul 2023 04:46:22 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.109.212.144])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jul 2023 04:46:21 +0000 (GMT)
X-Mailer: emacs 29.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the mm tree
In-Reply-To: <20230727142844.5e00c84d@canb.auug.org.au>
References: <20230727142844.5e00c84d@canb.auug.org.au>
Date:   Thu, 27 Jul 2023 10:16:19 +0530
Message-ID: <87h6pqvu5g.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6bu0zTRsCXH7ezfsN5S_rqSXWKH6sGrc
X-Proofpoint-GUID: 6bu0zTRsCXH7ezfsN5S_rqSXWKH6sGrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> After merging the mm tree, today's linux-next build (powerpc allyesconfig)
> produced these warnings:
>
> WARNING: modpost: vmlinux: section mismatch in reference: remove_pte_table+0x230 (section: .text.remove_pte_table) -> free_vmemmap_pages (section: .meminit.text)
> WARNING: modpost: vmlinux: section mismatch in reference: remove_pte_table+0x43c (section: .text.remove_pte_table) -> vmemmap_populated (section: .meminit.text)
> WARNING: modpost: vmlinux: section mismatch in reference: remove_pte_table+0x4a4 (section: .text.remove_pte_table) -> free_vmemmap_pages (section: .meminit.text)
>
> Introduced by commit
>
>   25081814314b ("powerpc/book3s64/vmemmap: switch radix to use a different vmemmap handling function")
>

I will send this as a separate patch to linuxppc-dev ? Even though the
warning started with this series because it is using functions in
meminit from remove_pte_table, marking remove_pte_table correctly is
applicable outside series that caused this warning ?

From 29ddcbbcae6ec2a7b70015274b2d5c4ec9b6beea Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Thu, 27 Jul 2023 10:02:37 +0530
Subject: [PATCH] powerpc/mm: Fix section mismatch warning

remove_pte_table is only called from remove_pmd_table which is marked
__meminit. These functions are used only during memory hotplug and they
also call functions marked __meminit. Mark remote_pte_table also with
__meminit so that we can avoid the section mismatch warning below.

WARNING: modpost: vmlinux: section mismatch in reference: remove_pte_table+0x230 (section: .text.remove_pte_table) -> free_vmemmap_pages (section: .meminit.text)
WARNING: modpost: vmlinux: section mismatch in reference: remove_pte_table+0x43c (section: .text.remove_pte_table) -> vmemmap_populated (section: .meminit.text)
WARNING: modpost: vmlinux: section mismatch in reference: remove_pte_table+0x4a4 (section: .text.remove_pte_table) -> free_vmemmap_pages (section: .meminit.text)

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 59aaa30a7c0d..96679018e7fb 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -782,9 +782,9 @@ static void __meminit free_vmemmap_pages(struct page *page,
 		free_pages((unsigned long)page_address(page), order);
 }
 
-static void remove_pte_table(pte_t *pte_start, unsigned long addr,
-			     unsigned long end, bool direct,
-			     struct vmem_altmap *altmap)
+static void __meminit remove_pte_table(pte_t *pte_start, unsigned long addr,
+				       unsigned long end, bool direct,
+				       struct vmem_altmap *altmap)
 {
 	unsigned long next, pages = 0;
 	pte_t *pte;
-- 
2.41.0

