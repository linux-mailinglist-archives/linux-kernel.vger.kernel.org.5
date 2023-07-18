Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83E75796B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGRKnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGRKni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:43:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CD019A;
        Tue, 18 Jul 2023 03:43:37 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IAVD5g015975;
        Tue, 18 Jul 2023 10:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=5pqryEuXi7w3clM0cicqo05Ow93ZiUNgOjfFt59QOcA=;
 b=MLZgMgaFynVGFhEZgy+HljSo8qlwdpEYmMyfEK4MDgMn+6vT/mCrDKND2C/bQBJYID+A
 IElpGNDZjJGZoeUao5GfVP8UFDh35vY8TnFF0xXVCxeXHYROhkY/sA7QgjGJvOb3SDF7
 YuvURhU5e/sD363f3LLHzLWmLZ/Q0HElF4zfBkeKSFKsnXOrMtpQvyAmyoupuCJMbcQu
 XaQZsZccdGAV5EXj3AFPpgsGWkWw32WYxVnMc4xqPiwnGnQ74uCUBafblBoWQpDl1n9f
 1oK7yLn/wZcT4B9USMqGYxi+gw/WbHD2PafF0ZKW/Aqi025Lix+1BhTHxniLNce/KY2i XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rws2breec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 10:41:43 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36IAVmXg019296;
        Tue, 18 Jul 2023 10:41:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rws2bred1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 10:41:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36I6lTQw016870;
        Tue, 18 Jul 2023 10:41:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5srnpnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 10:41:40 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36IAfeE920972012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 10:41:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAFEF5805E;
        Tue, 18 Jul 2023 10:41:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C6C65805F;
        Tue, 18 Jul 2023 10:41:22 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.109.212.144])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jul 2023 10:41:21 +0000 (GMT)
X-Mailer: emacs 29.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 04/13] powerpc: assert_pte_locked() use
 pte_offset_map_nolock()
In-Reply-To: <e8d56c95-c132-a82e-5f5f-7bb1b738b057@google.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
 <e8d56c95-c132-a82e-5f5f-7bb1b738b057@google.com>
Date:   Tue, 18 Jul 2023 16:11:19 +0530
Message-ID: <87msztbiy8.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zKZQJ9IasJwI7nGrSugta0t-NqCMHUUs
X-Proofpoint-ORIG-GUID: ASlLD63EgmlMnfoUOkFOiogpO5Mj_Hpm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 spamscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hughd@google.com> writes:

> Instead of pte_lockptr(), use the recently added pte_offset_map_nolock()
> in assert_pte_locked().  BUG if pte_offset_map_nolock() fails: this is
> stricter than the previous implementation, which skipped when pmd_none()
> (with a comment on khugepaged collapse transitions): but wouldn't we want
> to know, if an assert_pte_locked() caller can be racing such transitions?
>

The reason we had that pmd_none check there was to handle khugpaged. In
case of khugepaged we do pmdp_collapse_flush and then do a ptep_clear.
ppc64 had the assert_pte_locked check inside that ptep_clear.

_pmd = pmdp_collapse_flush(vma, address, pmd);
..
ptep_clear()
-> asset_ptep_locked()
---> pmd_none
-----> BUG


The problem is how assert_pte_locked() verify whether we are holding
ptl. It does that by walking the page table again and in this specific
case by the time we call the function we already had cleared pmd .
>
> This mod might cause new crashes: which either expose my ignorance, or
> indicate issues to be fixed, or limit the usage of assert_pte_locked().
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/powerpc/mm/pgtable.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index cb2dcdb18f8e..16b061af86d7 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -311,6 +311,8 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
>  	p4d_t *p4d;
>  	pud_t *pud;
>  	pmd_t *pmd;
> +	pte_t *pte;
> +	spinlock_t *ptl;
>  
>  	if (mm == &init_mm)
>  		return;
> @@ -321,16 +323,10 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
>  	pud = pud_offset(p4d, addr);
>  	BUG_ON(pud_none(*pud));
>  	pmd = pmd_offset(pud, addr);
> -	/*
> -	 * khugepaged to collapse normal pages to hugepage, first set
> -	 * pmd to none to force page fault/gup to take mmap_lock. After
> -	 * pmd is set to none, we do a pte_clear which does this assertion
> -	 * so if we find pmd none, return.
> -	 */
> -	if (pmd_none(*pmd))
> -		return;
> -	BUG_ON(!pmd_present(*pmd));
> -	assert_spin_locked(pte_lockptr(mm, pmd));
> +	pte = pte_offset_map_nolock(mm, pmd, addr, &ptl);
> +	BUG_ON(!pte);
> +	assert_spin_locked(ptl);
> +	pte_unmap(pte);
>  }
>  #endif /* CONFIG_DEBUG_VM */
>  
> -- 
> 2.35.3
