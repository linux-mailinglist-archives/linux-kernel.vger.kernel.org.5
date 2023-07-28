Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007A766ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbjG1Nxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjG1Nxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:53:44 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A784BDB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:53:42 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso1900363276.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690552422; x=1691157222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+J6kwTJsFkDX/akCe0Kyav4Ctw8RgrMFq9IKI8LH3rU=;
        b=AfGejJ2zG81nEj5vxrgyIE/0vNuc3UKH3VK0k33HZgppeAPeRusn2oYdzhr0FEK1zy
         GIuOlWBOvDNROWcWTuk3SXDDSEAPYF5m+oi9LXEior8/BhNtoJzBbvvw52tZVZDntwM6
         kDA3lGf8AHvOL/0NAhrFsIeLAje4s0M/rXHVrphJVFoS2JT+0WCq3QgPFJ/yVBt4175f
         G+oSTEwG+jB/Ln+IGKw9ezMgpXUF0CE1V1ZhC4WJKPdRDPJMzfm/c+qAibmSt0X+4p8q
         HsCnwib4e/U75+umYV+lZUdce/b5XcePnkBZyFyCI2HQplp2TMbkQnLQAF9UXwnnpsyM
         Wjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690552422; x=1691157222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+J6kwTJsFkDX/akCe0Kyav4Ctw8RgrMFq9IKI8LH3rU=;
        b=epfkMlZbttOwakD3kwxXV0XLIrqUeyUYSmju8qkilL1BqUylcZSaJYYf0sLPDSJ9JG
         BQqaM5skS0I3ObXz58lWFs+C2P5r2OJPceQ+GU7xMG3O6Di5SLvFh1kTT/Hs4FWEkytw
         hajYdDsbxhAPPS3JZcY4pxieUsj9gZq2tO1VL1pabc3uNH7b2TyoC2Xe6tlDcNxbATJ4
         2KAR6P/vRvN/ZCLJ/Pjdo4MR6A6vwjQnjBPKjnd9+UeAub9NLLGcHXSJZr3n3sJMPEuK
         /DJVh8gNz+s5i78fCvsIiBCgrmvaqb6UkB7zvfg5qllANaoC2aVDMU6FzNBo/7vBAet3
         XrbQ==
X-Gm-Message-State: ABy/qLZ++YeGmq9bP2rCVSoqsg8XkjYhpEQbN1wv6HyR1rt/E4oNIRwI
        8CYE4RehHNn61cGSiuDh8qYbrbD2eIXUQGRnUz9+CA==
X-Google-Smtp-Source: APBJJlF2d3xK3sg+/6K4TnCA5oLube1UGdmEuzZz7RxKgPSrEJuOf8//6B1N/CRO8ojAIYosmEKuBaRon4XkWVtVN6g=
X-Received: by 2002:a25:40c8:0:b0:d1a:6ea4:474d with SMTP id
 n191-20020a2540c8000000b00d1a6ea4474dmr1594515yba.53.1690552421647; Fri, 28
 Jul 2023 06:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com> <2929bfd-9893-a374-e463-4c3127ff9b9d@google.com>
In-Reply-To: <2929bfd-9893-a374-e463-4c3127ff9b9d@google.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Fri, 28 Jul 2023 21:53:29 +0800
Message-ID: <CAMSo37X5GzFmqNAtABuibmMAF7t=_5SYCipMPZ-TB+uEMYkSUA@mail.gmail.com>
Subject: Re: [PATCH v2 04/32] mm/pgtable: allow pte_offset_map[_lock]() to fail
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
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh

It seems this change makes pte_offset_map_lock not possible to be
called in out of tree modules,
otherwise it will report error like this:
        ERROR: modpost: "__pte_offset_map_lock"
[../omap-modules/android-mainline/pvr/pvrsrvkm.ko] undefined!

Not sure if you have any idea about it, and any suggestions on how to
resolve it?

Thanks,
Yongqin Liu

On Fri, 9 Jun 2023 at 09:10, Hugh Dickins <hughd@google.com> wrote:
>
> Make pte_offset_map() a wrapper for __pte_offset_map() (optionally
> outputs pmdval), pte_offset_map_lock() a sparse __cond_lock wrapper for
> __pte_offset_map_lock(): those __funcs added in mm/pgtable-generic.c.
>
> __pte_offset_map() do pmdval validation (including pmd_clear_bad()
> when pmd_bad()), returning NULL if pmdval is not for a page table.
> __pte_offset_map_lock() verify pmdval unchanged after getting the
> lock, trying again if it changed.
>
> No #ifdef CONFIG_TRANSPARENT_HUGEPAGE around them: that could be done
> to cover the imminent case, but we expect to generalize it later, and
> it makes a mess of where to do the pmd_bad() clearing.
>
> Add pte_offset_map_nolock(): outputs ptl like pte_offset_map_lock(),
> without actually taking the lock.  This will be preferred to open uses of
> pte_lockptr(), because (when split ptlock is in page table's struct page)
> it points to the right lock for the returned pte pointer, even if *pmd
> gets changed racily afterwards.
>
> Update corresponding Documentation.
>
> Do not add the anticipated rcu_read_lock() and rcu_read_unlock()s yet:
> they have to wait until all architectures are balancing pte_offset_map()s
> with pte_unmap()s (as in the arch series posted earlier).  But comment
> where they will go, so that it's easy to add them for experiments.  And
> only when those are in place can transient racy failure cases be enabled.
> Add more safety for the PAE mismatched pmd_low pmd_high case at that time.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  Documentation/mm/split_page_table_lock.rst | 17 ++++---
>  include/linux/mm.h                         | 27 +++++++----
>  include/linux/pgtable.h                    | 22 ++++++---
>  mm/pgtable-generic.c                       | 56 ++++++++++++++++++++++
>  4 files changed, 101 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/mm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
> index 50ee0dfc95be..a834fad9de12 100644
> --- a/Documentation/mm/split_page_table_lock.rst
> +++ b/Documentation/mm/split_page_table_lock.rst
> @@ -14,15 +14,20 @@ tables. Access to higher level tables protected by mm->page_table_lock.
>  There are helpers to lock/unlock a table and other accessor functions:
>
>   - pte_offset_map_lock()
> -       maps pte and takes PTE table lock, returns pointer to the taken
> -       lock;
> +       maps PTE and takes PTE table lock, returns pointer to PTE with
> +       pointer to its PTE table lock, or returns NULL if no PTE table;
> + - pte_offset_map_nolock()
> +       maps PTE, returns pointer to PTE with pointer to its PTE table
> +       lock (not taken), or returns NULL if no PTE table;
> + - pte_offset_map()
> +       maps PTE, returns pointer to PTE, or returns NULL if no PTE table;
> + - pte_unmap()
> +       unmaps PTE table;
>   - pte_unmap_unlock()
>         unlocks and unmaps PTE table;
>   - pte_alloc_map_lock()
> -       allocates PTE table if needed and take the lock, returns pointer
> -       to taken lock or NULL if allocation failed;
> - - pte_lockptr()
> -       returns pointer to PTE table lock;
> +       allocates PTE table if needed and takes its lock, returns pointer to
> +       PTE with pointer to its lock, or returns NULL if allocation failed;
>   - pmd_lock()
>         takes PMD table lock, returns pointer to taken lock;
>   - pmd_lockptr()
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27ce77080c79..3c2e56980853 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2787,14 +2787,25 @@ static inline void pgtable_pte_page_dtor(struct page *page)
>         dec_lruvec_page_state(page, NR_PAGETABLE);
>  }
>
> -#define pte_offset_map_lock(mm, pmd, address, ptlp)    \
> -({                                                     \
> -       spinlock_t *__ptl = pte_lockptr(mm, pmd);       \
> -       pte_t *__pte = pte_offset_map(pmd, address);    \
> -       *(ptlp) = __ptl;                                \
> -       spin_lock(__ptl);                               \
> -       __pte;                                          \
> -})
> +pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
> +static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
> +{
> +       return __pte_offset_map(pmd, addr, NULL);
> +}
> +
> +pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> +                       unsigned long addr, spinlock_t **ptlp);
> +static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> +                       unsigned long addr, spinlock_t **ptlp)
> +{
> +       pte_t *pte;
> +
> +       __cond_lock(*ptlp, pte = __pte_offset_map_lock(mm, pmd, addr, ptlp));
> +       return pte;
> +}
> +
> +pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
> +                       unsigned long addr, spinlock_t **ptlp);
>
>  #define pte_unmap_unlock(pte, ptl)     do {            \
>         spin_unlock(ptl);                               \
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 94235ff2706e..3fabbb018557 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -94,14 +94,22 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
>  #define pte_offset_kernel pte_offset_kernel
>  #endif
>
> -#if defined(CONFIG_HIGHPTE)
> -#define pte_offset_map(dir, address)                           \
> -       ((pte_t *)kmap_local_page(pmd_page(*(dir))) +           \
> -        pte_index((address)))
> -#define pte_unmap(pte) kunmap_local((pte))
> +#ifdef CONFIG_HIGHPTE
> +#define __pte_map(pmd, address) \
> +       ((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
> +#define pte_unmap(pte) do {    \
> +       kunmap_local((pte));    \
> +       /* rcu_read_unlock() to be added later */       \
> +} while (0)
>  #else
> -#define pte_offset_map(dir, address)   pte_offset_kernel((dir), (address))
> -#define pte_unmap(pte) ((void)(pte))   /* NOP */
> +static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
> +{
> +       return pte_offset_kernel(pmd, address);
> +}
> +static inline void pte_unmap(pte_t *pte)
> +{
> +       /* rcu_read_unlock() to be added later */
> +}
>  #endif
>
>  /* Find an entry in the second-level page table.. */
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index d2fc52bffafc..c7ab18a5fb77 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -10,6 +10,8 @@
>  #include <linux/pagemap.h>
>  #include <linux/hugetlb.h>
>  #include <linux/pgtable.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
>  #include <linux/mm_inline.h>
>  #include <asm/tlb.h>
>
> @@ -229,3 +231,57 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
>  }
>  #endif
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
> +{
> +       pmd_t pmdval;
> +
> +       /* rcu_read_lock() to be added later */
> +       pmdval = pmdp_get_lockless(pmd);
> +       if (pmdvalp)
> +               *pmdvalp = pmdval;
> +       if (unlikely(pmd_none(pmdval) || is_pmd_migration_entry(pmdval)))
> +               goto nomap;
> +       if (unlikely(pmd_trans_huge(pmdval) || pmd_devmap(pmdval)))
> +               goto nomap;
> +       if (unlikely(pmd_bad(pmdval))) {
> +               pmd_clear_bad(pmd);
> +               goto nomap;
> +       }
> +       return __pte_map(&pmdval, addr);
> +nomap:
> +       /* rcu_read_unlock() to be added later */
> +       return NULL;
> +}
> +
> +pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
> +                            unsigned long addr, spinlock_t **ptlp)
> +{
> +       pmd_t pmdval;
> +       pte_t *pte;
> +
> +       pte = __pte_offset_map(pmd, addr, &pmdval);
> +       if (likely(pte))
> +               *ptlp = pte_lockptr(mm, &pmdval);
> +       return pte;
> +}
> +
> +pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
> +                            unsigned long addr, spinlock_t **ptlp)
> +{
> +       spinlock_t *ptl;
> +       pmd_t pmdval;
> +       pte_t *pte;
> +again:
> +       pte = __pte_offset_map(pmd, addr, &pmdval);
> +       if (unlikely(!pte))
> +               return pte;
> +       ptl = pte_lockptr(mm, &pmdval);
> +       spin_lock(ptl);
> +       if (likely(pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
> +               *ptlp = ptl;
> +               return pte;
> +       }
> +       pte_unmap_unlock(pte, ptl);
> +       goto again;
> +}
> --
> 2.35.3
>


-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
