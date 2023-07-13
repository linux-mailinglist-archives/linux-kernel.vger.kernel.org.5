Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D757517B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 06:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjGMEtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 00:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjGMEtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 00:49:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508412116;
        Wed, 12 Jul 2023 21:49:01 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D4l4EJ011353;
        Thu, 13 Jul 2023 04:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+ljgiMlZz107U3eyPiwA5r0NTzhiHexVtLB6CrIw66o=;
 b=qkhNRr7E/UwyPFnhLVXm8xNI75vYkjgJxHIbXOAw/MdHkvWGR8UDZDlzcQgn2ArljaNm
 URVntgdPCcCr8/Q78ibglD5hGmbIr64bNx7G0aCZHMvs08VQfWkWxXtoJmqCQN5RSISg
 RFQkTu8OeozsM0D1uVrcQeGK90OSyojQTc39Fs6gXq4daF9mbwuoEuFrAp9wb8pDfuVT
 GTw4mio0gj23rqOXsku+j9cRineohoHNaFIHgcPR9CBx3M4LFgjt/0UCIDHYWKyLpWZS
 pQ+no2GwpjeDJgLVzfFOma/n/iTlGiUbOl64n8SWkFqzTV0rTqR6z8LLsNjq2fX4ag27 lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtaj1g0at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 04:47:44 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36D4lhm7012902;
        Thu, 13 Jul 2023 04:47:43 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtaj1g0a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 04:47:43 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36D2dLQH020946;
        Thu, 13 Jul 2023 04:47:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rpye526nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 04:47:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36D4lak020185850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 04:47:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 880112004B;
        Thu, 13 Jul 2023 04:47:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F332920040;
        Thu, 13 Jul 2023 04:47:33 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.86.166])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 13 Jul 2023 04:47:33 +0000 (GMT)
Date:   Thu, 13 Jul 2023 06:47:32 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 07/13] s390: add pte_free_defer() for pgtables sharing
 page
Message-ID: <ZK+B5C2+GgkPsimV@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
 <94eccf5f-264c-8abe-4567-e77f4b4e14a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94eccf5f-264c-8abe-4567-e77f4b4e14a@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fABUOPxQmXtCqcbQcuCAmTBiaSww1L4T
X-Proofpoint-GUID: KLYvaFI7PtCqqIfrc7eGSKpr9vMWBkXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_02,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 09:38:35PM -0700, Hugh Dickins wrote:
> Add s390-specific pte_free_defer(), to free table page via call_rcu().
> pte_free_defer() will be called inside khugepaged's retract_page_tables()
> loop, where allocating extra memory cannot be relied upon.  This precedes
> the generic version to avoid build breakage from incompatible pgtable_t.
> 
> This version is more complicated than others: because s390 fits two 2K
> page tables into one 4K page (so page->rcu_head must be shared between
> both halves), and already uses page->lru (which page->rcu_head overlays)
> to list any free halves; with clever management by page->_refcount bits.
> 
> Build upon the existing management, adjusted to follow a new rule: that
> a page is never on the free list if pte_free_defer() was used on either
> half (marked by PageActive).  And for simplicity, delay calling RCU until
> both halves are freed.
> 
> Not adding back unallocated fragments to the list in pte_free_defer()
> can result in wasting some amount of memory for pagetables, depending
> on how long the allocated fragment will stay in use. In practice, this
> effect is expected to be insignificant, and not justify a far more
> complex approach, which might allow to add the fragments back later
> in __tlb_remove_table(), where we might not have a stable mm any more.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>  arch/s390/include/asm/pgalloc.h |  4 ++
>  arch/s390/mm/pgalloc.c          | 80 +++++++++++++++++++++++++++++------
>  2 files changed, 72 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
> index 17eb618f1348..89a9d5ef94f8 100644
> --- a/arch/s390/include/asm/pgalloc.h
> +++ b/arch/s390/include/asm/pgalloc.h
> @@ -143,6 +143,10 @@ static inline void pmd_populate(struct mm_struct *mm,
>  #define pte_free_kernel(mm, pte) page_table_free(mm, (unsigned long *) pte)
>  #define pte_free(mm, pte) page_table_free(mm, (unsigned long *) pte)
>  
> +/* arch use pte_free_defer() implementation in arch/s390/mm/pgalloc.c */
> +#define pte_free_defer pte_free_defer
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
> +
>  void vmem_map_init(void);
>  void *vmem_crst_alloc(unsigned long val);
>  pte_t *vmem_pte_alloc(void);
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index 66ab68db9842..760b4ace475e 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -229,6 +229,15 @@ void page_table_free_pgste(struct page *page)
>   * logic described above. Both AA bits are set to 1 to denote a 4KB-pgtable
>   * while the PP bits are never used, nor such a page is added to or removed
>   * from mm_context_t::pgtable_list.
> + *
> + * pte_free_defer() overrides those rules: it takes the page off pgtable_list,
> + * and prevents both 2K fragments from being reused. pte_free_defer() has to
> + * guarantee that its pgtable cannot be reused before the RCU grace period
> + * has elapsed (which page_table_free_rcu() does not actually guarantee).
> + * But for simplicity, because page->rcu_head overlays page->lru, and because
> + * the RCU callback might not be called before the mm_context_t has been freed,
> + * pte_free_defer() in this implementation prevents both fragments from being
> + * reused, and delays making the call to RCU until both fragments are freed.
>   */
>  unsigned long *page_table_alloc(struct mm_struct *mm)
>  {
> @@ -261,7 +270,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  					table += PTRS_PER_PTE;
>  				atomic_xor_bits(&page->_refcount,
>  							0x01U << (bit + 24));
> -				list_del(&page->lru);
> +				list_del_init(&page->lru);
>  			}
>  		}
>  		spin_unlock_bh(&mm->context.lock);
> @@ -281,6 +290,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  	table = (unsigned long *) page_to_virt(page);
>  	if (mm_alloc_pgste(mm)) {
>  		/* Return 4K page table with PGSTEs */
> +		INIT_LIST_HEAD(&page->lru);
>  		atomic_xor_bits(&page->_refcount, 0x03U << 24);
>  		memset64((u64 *)table, _PAGE_INVALID, PTRS_PER_PTE);
>  		memset64((u64 *)table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
> @@ -300,7 +310,9 @@ static void page_table_release_check(struct page *page, void *table,
>  {
>  	char msg[128];
>  
> -	if (!IS_ENABLED(CONFIG_DEBUG_VM) || !mask)
> +	if (!IS_ENABLED(CONFIG_DEBUG_VM))
> +		return;
> +	if (!mask && list_empty(&page->lru))
>  		return;
>  	snprintf(msg, sizeof(msg),
>  		 "Invalid pgtable %p release half 0x%02x mask 0x%02x",
> @@ -308,6 +320,15 @@ static void page_table_release_check(struct page *page, void *table,
>  	dump_page(page, msg);
>  }
>  
> +static void pte_free_now(struct rcu_head *head)
> +{
> +	struct page *page;
> +
> +	page = container_of(head, struct page, rcu_head);
> +	pgtable_pte_page_dtor(page);
> +	__free_page(page);
> +}
> +
>  void page_table_free(struct mm_struct *mm, unsigned long *table)
>  {
>  	unsigned int mask, bit, half;
> @@ -325,10 +346,17 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>  		 */
>  		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
>  		mask >>= 24;
> -		if (mask & 0x03U)
> +		if ((mask & 0x03U) && !PageActive(page)) {
> +			/*
> +			 * Other half is allocated, and neither half has had
> +			 * its free deferred: add page to head of list, to make
> +			 * this freed half available for immediate reuse.
> +			 */
>  			list_add(&page->lru, &mm->context.pgtable_list);
> -		else
> -			list_del(&page->lru);
> +		} else {
> +			/* If page is on list, now remove it. */
> +			list_del_init(&page->lru);
> +		}
>  		spin_unlock_bh(&mm->context.lock);
>  		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
>  		mask >>= 24;
> @@ -342,8 +370,10 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>  	}
>  
>  	page_table_release_check(page, table, half, mask);
> -	pgtable_pte_page_dtor(page);
> -	__free_page(page);
> +	if (TestClearPageActive(page))
> +		call_rcu(&page->rcu_head, pte_free_now);
> +	else
> +		pte_free_now(&page->rcu_head);
>  }
>  
>  void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
> @@ -370,10 +400,18 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
>  	 */
>  	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
>  	mask >>= 24;
> -	if (mask & 0x03U)
> +	if ((mask & 0x03U) && !PageActive(page)) {
> +		/*
> +		 * Other half is allocated, and neither half has had
> +		 * its free deferred: add page to end of list, to make
> +		 * this freed half available for reuse once its pending
> +		 * bit has been cleared by __tlb_remove_table().
> +		 */
>  		list_add_tail(&page->lru, &mm->context.pgtable_list);
> -	else
> -		list_del(&page->lru);
> +	} else {
> +		/* If page is on list, now remove it. */
> +		list_del_init(&page->lru);
> +	}
>  	spin_unlock_bh(&mm->context.lock);
>  	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
>  	tlb_remove_table(tlb, table);
> @@ -403,10 +441,28 @@ void __tlb_remove_table(void *_table)
>  	}
>  
>  	page_table_release_check(page, table, half, mask);
> -	pgtable_pte_page_dtor(page);
> -	__free_page(page);
> +	if (TestClearPageActive(page))
> +		call_rcu(&page->rcu_head, pte_free_now);
> +	else
> +		pte_free_now(&page->rcu_head);
>  }
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> +{
> +	struct page *page;
> +
> +	page = virt_to_page(pgtable);
> +	SetPageActive(page);
> +	page_table_free(mm, (unsigned long *)pgtable);
> +	/*
> +	 * page_table_free() does not do the pgste gmap_unlink() which
> +	 * page_table_free_rcu() does: warn us if pgste ever reaches here.
> +	 */
> +	WARN_ON_ONCE(mm_alloc_pgste(mm));
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
>  /*
>   * Base infrastructure required to generate basic asces, region, segment,
>   * and page tables that do not make use of enhanced features like EDAT1.

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
