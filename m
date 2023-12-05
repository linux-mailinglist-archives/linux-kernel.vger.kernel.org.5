Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64A3804401
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 02:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344073AbjLEBY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 20:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjLEBYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 20:24:52 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3B7D53
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 17:24:39 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4649d22b78aso593797137.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 17:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701739478; x=1702344278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tQk3YVUKG0AYOtvIQ7xyVTS9E98YjBdQc/XKS+hniA=;
        b=VLL+DUy9effbNy16CasgKdDaqIf80KXyM54X6RksYOZh09Phs+nycM+IHcy/a/lHNH
         RKBBi5GJgHq7GX0fZ++BYruW2xEj/0UCYCMu+1Gn7yfuy/TFQQHPhkRxIZsfXxRu13RQ
         8/pY/Ie0ZX6e2XgMPwDeOjTMgLIqjGgAs4L8MyVaXuUQs65D9vC9fEBE42uUogvdwHaS
         92PD1JxDnRdPIkvRvm0ARrsMzBbYfHXqMzcFRopUknX4wooe24mqf3cT7U2W840IOmiD
         syaWy+HoisjqKP4OgSjv9DeX+nlPmCix8DxeVjB7aUqFhKtQM8yBSJDOHc/WIdT5e7fX
         NmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701739478; x=1702344278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tQk3YVUKG0AYOtvIQ7xyVTS9E98YjBdQc/XKS+hniA=;
        b=w2bJFWNk27GT8GEFd+RP7yNJmK0vgtK9AWHugp98JLVkvUsyQVcm/F0zEvCvf6+Rhj
         yFqjnjrAHna6y7R2qHTe5NvnkXwZLl/lAUNpdiRcIhLJdXMiOHOnOeHhPQ9Zxq7R3HmO
         5bxD8+ynpv4Taw0HDq0+vyLuye0osFgsxnQ7fJxdvp/r8HO2sgh1y1LlpUPFVOHlIRqT
         AbDDlCnqUrTH21enpTSOu85OgxWiTPW3AIrzsE79k/5j94Bt9eH6VefLo/EpbWmIKB9Q
         dc1EmsO3Ktjj/OntAzl99J60GUv9EdvnAUfJeAohfLKE5sYrynLWjIwn+bEJqff6hqHM
         ZNrw==
X-Gm-Message-State: AOJu0YwES1PVo3Y8dzzWubUEPJHxYHMNlpK1yrm1lOZQu3L1LvE4v5jG
        gPC0mZzjwUjSH0rmM39IAZrB63OFI1T6fL5iLcc=
X-Google-Smtp-Source: AGHT+IGEHqNQ/vreG817lbcl9Wq/moPomjDB+2jbQHJismfpKyMRrpeSrvk6Q1S76981m6fSOMpJdjEJtredhlV7XI4=
X-Received: by 2002:a67:c402:0:b0:464:782c:9aa6 with SMTP id
 c2-20020a67c402000000b00464782c9aa6mr700345vsk.21.1701739478108; Mon, 04 Dec
 2023 17:24:38 -0800 (PST)
MIME-Version: 1.0
References: <20231204102027.57185-1-ryan.roberts@arm.com> <20231204102027.57185-5-ryan.roberts@arm.com>
 <CAGsJ_4zG6W_Z-u+3QcRDn4ByoeqUXjMusNS0RotfRMSqo8RCHg@mail.gmail.com>
In-Reply-To: <CAGsJ_4zG6W_Z-u+3QcRDn4ByoeqUXjMusNS0RotfRMSqo8RCHg@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 5 Dec 2023 09:24:26 +0800
Message-ID: <CAGsJ_4zYhJWGx1DnHTiDnP3h1m8_rr6ZT6fXt8pO=jzs9QZS-A@mail.gmail.com>
Subject: Re: [PATCH v8 04/10] mm: thp: Support allocation of anonymous
 multi-size THP
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 9:15=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Mon, Dec 4, 2023 at 6:21=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
> >
> > Introduce the logic to allow THP to be configured (through the new sysf=
s
> > interface we just added) to allocate large folios to back anonymous
> > memory, which are larger than the base page size but smaller than
> > PMD-size. We call this new THP extension "multi-size THP" (mTHP).
> >
> > mTHP continues to be PTE-mapped, but in many cases can still provide
> > similar benefits to traditional PMD-sized THP: Page faults are
> > significantly reduced (by a factor of e.g. 4, 8, 16, etc. depending on
> > the configured order), but latency spikes are much less prominent
> > because the size of each page isn't as huge as the PMD-sized variant an=
d
> > there is less memory to clear in each page fault. The number of per-pag=
e
> > operations (e.g. ref counting, rmap management, lru list management) ar=
e
> > also significantly reduced since those ops now become per-folio.
> >
> > Some architectures also employ TLB compression mechanisms to squeeze
> > more entries in when a set of PTEs are virtually and physically
> > contiguous and approporiately aligned. In this case, TLB misses will
> > occur less often.
> >
> > The new behaviour is disabled by default, but can be enabled at runtime
> > by writing to /sys/kernel/mm/transparent_hugepage/hugepage-XXkb/enabled
> > (see documentation in previous commit). The long term aim is to change
> > the default to include suitable lower orders, but there are some risks
> > around internal fragmentation that need to be better understood first.
> >
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >  include/linux/huge_mm.h |   6 ++-
> >  mm/memory.c             | 106 ++++++++++++++++++++++++++++++++++++----
> >  2 files changed, 101 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index bd0eadd3befb..91a53b9835a4 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -68,9 +68,11 @@ extern struct kobj_attribute shmem_enabled_attr;
> >  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> >
> >  /*
> > - * Mask of all large folio orders supported for anonymous THP.
> > + * Mask of all large folio orders supported for anonymous THP; all ord=
ers up to
> > + * and including PMD_ORDER, except order-0 (which is not "huge") and o=
rder-1
> > + * (which is a limitation of the THP implementation).
> >   */
> > -#define THP_ORDERS_ALL_ANON    BIT(PMD_ORDER)
> > +#define THP_ORDERS_ALL_ANON    ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | =
BIT(1)))
> >
> >  /*
> >   * Mask of all large folio orders supported for file THP.
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 3ceeb0f45bf5..bf7e93813018 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4125,6 +4125,84 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         return ret;
> >  }
> >
> > +static bool pte_range_none(pte_t *pte, int nr_pages)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < nr_pages; i++) {
> > +               if (!pte_none(ptep_get_lockless(pte + i)))
> > +                       return false;
> > +       }
> > +
> > +       return true;
> > +}
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> > +{
> > +       gfp_t gfp;
> > +       pte_t *pte;
> > +       unsigned long addr;
> > +       struct folio *folio;
> > +       struct vm_area_struct *vma =3D vmf->vma;
> > +       unsigned long orders;
> > +       int order;
> > +
> > +       /*
> > +        * If uffd is active for the vma we need per-page fault fidelit=
y to
> > +        * maintain the uffd semantics.
> > +        */
> > +       if (userfaultfd_armed(vma))
> > +               goto fallback;
> > +
> > +       /*
> > +        * Get a list of all the (large) orders below PMD_ORDER that ar=
e enabled
> > +        * for this vma. Then filter out the orders that can't be alloc=
ated over
> > +        * the faulting address and still be fully contained in the vma=
.
> > +        */
> > +       orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, false, =
true, true,
> > +                                         BIT(PMD_ORDER) - 1);
> > +       orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
> > +
> > +       if (!orders)
> > +               goto fallback;
> > +
> > +       pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> > +       if (!pte)
> > +               return ERR_PTR(-EAGAIN);
> > +
> > +       order =3D first_order(orders);
> > +       while (orders) {
> > +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> > +               vmf->pte =3D pte + pte_index(addr);
> > +               if (pte_range_none(vmf->pte, 1 << order))
> > +                       break;
> > +               order =3D next_order(&orders, order);
> > +       }
> > +
> > +       vmf->pte =3D NULL;
> > +       pte_unmap(pte);
> > +
> > +       gfp =3D vma_thp_gfp_mask(vma);
> > +
> > +       while (orders) {
> > +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> > +               folio =3D vma_alloc_folio(gfp, order, vma, addr, true);
> > +               if (folio) {
> > +                       clear_huge_page(&folio->page, addr, 1 << order)=
;
>
> Minor.
>
> Do we have to constantly clear a huge page? Is it possible to let
> post_alloc_hook()
> finish this job by using __GFP_ZERO/__GFP_ZEROTAGS as
> vma_alloc_zeroed_movable_folio() is doing?
>
> struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>                                                 unsigned long vaddr)
> {
>         gfp_t flags =3D GFP_HIGHUSER_MOVABLE | __GFP_ZERO;
>
>         /*
>          * If the page is mapped with PROT_MTE, initialise the tags at th=
e
>          * point of allocation and page zeroing as this is usually faster=
 than
>          * separate DC ZVA and STGM.
>          */
>         if (vma->vm_flags & VM_MTE)
>                 flags |=3D __GFP_ZEROTAGS;
>
>         return vma_alloc_folio(flags, 0, vma, vaddr, false);
> }

I am asking this because Android and some other kernels might always set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON, that means one more explicit
clear_page is doing a duplicated job.

when the below is true, post_alloc_hook has cleared huge_page before
vma_alloc_folio() returns the folio,

static inline bool want_init_on_alloc(gfp_t flags)
{
        if (static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
                                &init_on_alloc))
                return true;
        return flags & __GFP_ZERO;
}


>
> > +                       return folio;
> > +               }
> > +               order =3D next_order(&orders, order);
> > +       }
> > +
> > +fallback:
> > +       return vma_alloc_zeroed_movable_folio(vma, vmf->address);
> > +}
> > +#else
> > +#define alloc_anon_folio(vmf) \
> > +               vma_alloc_zeroed_movable_folio((vmf)->vma, (vmf)->addre=
ss)
> > +#endif
> > +
> >  /*
> >   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> >   * but allow concurrent faults), and pte mapped but not yet locked.
> > @@ -4132,6 +4210,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >   */
> >  static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> >  {
> > +       int i;
> > +       int nr_pages =3D 1;
> > +       unsigned long addr =3D vmf->address;
> >         bool uffd_wp =3D vmf_orig_pte_uffd_wp(vmf);
> >         struct vm_area_struct *vma =3D vmf->vma;
> >         struct folio *folio;
> > @@ -4176,10 +4257,15 @@ static vm_fault_t do_anonymous_page(struct vm_f=
ault *vmf)
> >         /* Allocate our own private page. */
> >         if (unlikely(anon_vma_prepare(vma)))
> >                 goto oom;
> > -       folio =3D vma_alloc_zeroed_movable_folio(vma, vmf->address);
> > +       folio =3D alloc_anon_folio(vmf);
> > +       if (IS_ERR(folio))
> > +               return 0;
> >         if (!folio)
> >                 goto oom;
> >
> > +       nr_pages =3D folio_nr_pages(folio);
> > +       addr =3D ALIGN_DOWN(vmf->address, nr_pages * PAGE_SIZE);
> > +
> >         if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
> >                 goto oom_free_page;
> >         folio_throttle_swaprate(folio, GFP_KERNEL);
> > @@ -4196,12 +4282,13 @@ static vm_fault_t do_anonymous_page(struct vm_f=
ault *vmf)
> >         if (vma->vm_flags & VM_WRITE)
> >                 entry =3D pte_mkwrite(pte_mkdirty(entry), vma);
> >
> > -       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->add=
ress,
> > -                       &vmf->ptl);
> > +       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &v=
mf->ptl);
> >         if (!vmf->pte)
> >                 goto release;
> > -       if (vmf_pte_changed(vmf)) {
> > -               update_mmu_tlb(vma, vmf->address, vmf->pte);
> > +       if ((nr_pages =3D=3D 1 && vmf_pte_changed(vmf)) ||
> > +           (nr_pages  > 1 && !pte_range_none(vmf->pte, nr_pages))) {
> > +               for (i =3D 0; i < nr_pages; i++)
> > +                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->=
pte + i);
> >                 goto release;
> >         }
> >
> > @@ -4216,16 +4303,17 @@ static vm_fault_t do_anonymous_page(struct vm_f=
ault *vmf)
> >                 return handle_userfault(vmf, VM_UFFD_MISSING);
> >         }
> >
> > -       inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > -       folio_add_new_anon_rmap(folio, vma, vmf->address);
> > +       folio_ref_add(folio, nr_pages - 1);
> > +       add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> > +       folio_add_new_anon_rmap(folio, vma, addr);
> >         folio_add_lru_vma(folio, vma);
> >  setpte:
> >         if (uffd_wp)
> >                 entry =3D pte_mkuffd_wp(entry);
> > -       set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> > +       set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr_pages);
> >
> >         /* No need to invalidate - it was non-present before */
> > -       update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> > +       update_mmu_cache_range(vmf, vma, addr, vmf->pte, nr_pages);
> >  unlock:
> >         if (vmf->pte)
> >                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> > --
> > 2.25.1
> >
