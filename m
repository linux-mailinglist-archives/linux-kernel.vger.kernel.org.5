Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40C3762AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjGZFWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGZFWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:22:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C972E212D;
        Tue, 25 Jul 2023 22:22:50 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q5Degi026238;
        Wed, 26 Jul 2023 05:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=lrhE6zSML3mt1HrTLpARJdTJn19701GWxWVxGgFFXtw=;
 b=F9j7ytoxzOTYx/6GUAMgwe1x0DY32GQ7JeWfEjhkLuCknLjZnlknIXRHtk0iX8THyblN
 89mPH8k3MoYwjcl7SP6Hkaiz6Y5DmzBr78dGL/ckXh0GEnBhGOYNygSDQVPlWQnawlvY
 je3auIbhHb1Oge1vjuDWTyKKVxQ/WngKQ2elwpFB6lsPX0gGBt46vWsbaDEpaCgUPnFM
 mhVBcq7NR+y4+c86A42dCN8TQkBU3XXIgblGwyWYO8+gIz8VBpzng/urcA9oaRV4zGZ+
 NQdsax1CDQv+fK3JyfvksboMMDcVN8q53tCWLgNgRcrUon+p3B27OhZ4m/Z9epI0UVWM Jg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2w5d85cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:22:39 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q2xao5001973;
        Wed, 26 Jul 2023 05:22:38 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0ten25mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:22:38 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36Q5Mc0e63439222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 05:22:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19D9258063;
        Wed, 26 Jul 2023 05:22:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 129D058065;
        Wed, 26 Jul 2023 05:22:36 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.89.11])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jul 2023 05:22:35 +0000 (GMT)
X-Mailer: emacs 29.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
In-Reply-To: <20230726145356.5e42830f@canb.auug.org.au>
References: <20230726145356.5e42830f@canb.auug.org.au>
Date:   Wed, 26 Jul 2023 10:52:33 +0530
Message-ID: <87zg3jw8km.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xZTSslukUv5ss7XL3WhAoI07aINYxShq
X-Proofpoint-GUID: xZTSslukUv5ss7XL3WhAoI07aINYxShq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> After merging the mm tree, today's linux-next build (powerpc64
> allnoconfig) failed like this:
>
> In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:285,
>                  from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
>                  from arch/powerpc/include/asm/book3s/64/mmu.h:32,
>                  from arch/powerpc/include/asm/mmu.h:396,
>                  from arch/powerpc/include/asm/lppaca.h:46,
>                  from arch/powerpc/include/asm/paca.h:18,
>                  from arch/powerpc/include/asm/current.h:13,
>                  from include/linux/thread_info.h:23,
>                  from include/asm-generic/preempt.h:5,
>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                  from include/linux/preempt.h:79,
>                  from include/linux/spinlock.h:56,
>                  from include/linux/ipc.h:5,
>                  from include/uapi/linux/sem.h:5,
>                  from include/linux/sem.h:5,
>                  from include/linux/compat.h:14,
>                  from arch/powerpc/kernel/asm-offsets.c:12:
> arch/powerpc/include/asm/book3s/64/radix.h:367:30: error: static declaration of 'vmemmap_can_optimize' follows non-static declaration
>   367 | #define vmemmap_can_optimize vmemmap_can_optimize
>       |                              ^~~~~~~~~~~~~~~~~~~~
> include/linux/mm.h:3695:20: note: in expansion of macro 'vmemmap_can_optimize'
>  3695 | static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
>       |                    ^~~~~~~~~~~~~~~~~~~~
> arch/powerpc/include/asm/book3s/64/radix.h:367:30: note: previous declaration of 'vmemmap_can_optimize' with type 'bool(struct vmem_altmap *, struct dev_pagemap *)' {aka '_Bool(struct vmem_altmap *, struct dev_pagemap *)'}
>   367 | #define vmemmap_can_optimize vmemmap_can_optimize
>       |                              ^~~~~~~~~~~~~~~~~~~~
> arch/powerpc/include/asm/book3s/64/radix.h:368:6: note: in expansion of macro 'vmemmap_can_optimize'
>   368 | bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
>       |      ^~~~~~~~~~~~~~~~~~~~
>
> Presumably caused by commit
>
>   f684ffc3ac9f ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
>
> I have reverted that commit (and the following 2) for today.

Thanks for the report. Can you add the below diff. We should look at
ppc64 not including radix headers if CONFIG_PPC_RADIX_MMU is disabled.
But for now we can keep the below diff?

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 3195f268ed7f..357e23a403d3 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -364,8 +364,10 @@ int radix__remove_section_mapping(unsigned long start, unsigned long end);
 
 void radix__kernel_map_pages(struct page *page, int numpages, int enable);
 
+#ifdef CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 #define vmemmap_can_optimize vmemmap_can_optimize
 bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pagemap *pgmap);
+#endif
 
 #define vmemmap_populate_compound_pages vmemmap_populate_compound_pages
 int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
