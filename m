Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081CC7644DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjG0Eb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjG0Ebz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:31:55 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83FC272E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:31:49 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40631c5b9e9so113901cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 21:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690432309; x=1691037109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3w0FH4CjJDIBFyA51YvZ3lQg46RveqwMJV9+4UPQTQ=;
        b=tiQGzgkubknW1XnV4IGn5gHMvhlhCs0mes7lxMy3wqTbWS1W/JPH3NajGMzseqtvjH
         Ix5dmrxa/WLsmVa2yuFCj1uoT6LMII9WY+ZtxwMGy16pAyV4ictgQe4jeqzHku/phZq8
         2wjHbNGMbmrr1lqOeaSpkGwAwZhsadHb8bHnnu1CCsCCg+uXhxWy3fUur0a96bwTwdkH
         OCfQM4lUjGf/RoyvS7pNOWOgHLazgxtPDFs/dwJVI/N6azCHZ8o/cThUH48B5mf8Jf6y
         dAVk+bXgAMZMvXFjG462ed0txUjgqfWHoKpFOP8OiC0/sS0DPZ5loWGZxDCZO+h/cGtd
         0geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690432309; x=1691037109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3w0FH4CjJDIBFyA51YvZ3lQg46RveqwMJV9+4UPQTQ=;
        b=Twpas8GwlHzgYfATwFcw9l4pH5zbdct6dDjqJ0laIJO2M4ROSW3KR11lq/3k+y2LFk
         yOT0PUR/XbS6woKkm0UawKKEXuYXhxb9XZiiKyCAtGq0ODKbU10OvBZguJTUzuGNqFGy
         L0DhGYt0wiHHzUKYm/shvdoDrRd/4YpNk+2BgEgW+7R6aGsI7E5X/3NbSCA1xSzaXlwq
         y1Uj7GF+OajpJbq0cFMPkzYoGCURM4Uz4auvVCXkTX+mRwoMIMOfXZi0GlKHh6DXQpxL
         0WzK/S1RL8naqIbj5mnZwFi+rF049AwsiYb4fNOHLBA1f+x1aTxsAJZz5cbxaoRrHVej
         ROyw==
X-Gm-Message-State: ABy/qLb6fTT9u9GX1P3fCIJxOLRTRQ3F6mkjWV6d6kHwWwz/MYWbnQjG
        jz6rD7ECtjS2+p3AvG0+b19gaUsttnE5fal1WmGl3w==
X-Google-Smtp-Source: APBJJlEOo3/9VlFawlnup3UBJzX6pcgDITB7PrzOjd1oko7BdM0KtLXpbiINM6REydHM+PiOAyar9lq0y+O1w+mQMQI=
X-Received: by 2002:a05:622a:1488:b0:3f0:af20:1a37 with SMTP id
 t8-20020a05622a148800b003f0af201a37mr89732qtx.15.1690432308831; Wed, 26 Jul
 2023 21:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
In-Reply-To: <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 26 Jul 2023 22:31:12 -0600
Message-ID: <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 10:41=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Jul 26, 2023 at 3:52=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.co=
m> wrote:
> >
> > Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
> > allocated in large folios of a determined order. All pages of the large
> > folio are pte-mapped during the same page fault, significantly reducing
> > the number of page faults. The number of per-page operations (e.g. ref
> > counting, rmap management lru list management) are also significantly
> > reduced since those ops now become per-folio.
> >
> > The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> > which defaults to disabled for now; The long term aim is for this to
> > defaut to enabled, but there are some risks around internal
> > fragmentation that need to be better understood first.
> >
> > When enabled, the folio order is determined as such: For a vma, process
> > or system that has explicitly disabled THP, we continue to allocate
> > order-0. THP is most likely disabled to avoid any possible internal
> > fragmentation so we honour that request.
> >
> > Otherwise, the return value of arch_wants_pte_order() is used. For vmas
> > that have not explicitly opted-in to use transparent hugepages (e.g.
> > where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> > arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> > bigger). This allows for a performance boost without requiring any
> > explicit opt-in from the workload while limitting internal
> > fragmentation.
> >
> > If the preferred order can't be used (e.g. because the folio would
> > breach the bounds of the vma, or because ptes in the region are already
> > mapped) then we fall back to a suitable lower order; first
> > PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >
> > arch_wants_pte_order() can be overridden by the architecture if desired=
.
> > Some architectures (e.g. arm64) can coalsece TLB entries if a contiguou=
s
> > set of ptes map physically contigious, naturally aligned memory, so thi=
s
> > mechanism allows the architecture to optimize as required.
> >
> > Here we add the default implementation of arch_wants_pte_order(), used
> > when the architecture does not define it, which returns -1, implying
> > that the HW has no preference. In this case, mm will choose it's own
> > default order.
> >
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >  include/linux/pgtable.h |  13 ++++
> >  mm/Kconfig              |  10 +++
> >  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 172 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 5063b482e34f..2a1d83775837 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
> >  }
> >  #endif
> >
> > +#ifndef arch_wants_pte_order
> > +/*
> > + * Returns preferred folio order for pte-mapped memory. Must be in ran=
ge [0,
> > + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires la=
rge folios
> > + * to be at least order-2. Negative value implies that the HW has no p=
reference
> > + * and mm will choose it's own default order.
> > + */
> > +static inline int arch_wants_pte_order(void)
> > +{
> > +       return -1;
> > +}
> > +#endif
> > +
> >  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >                                        unsigned long address,
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 09130434e30d..fa61ea160447 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
> >
> >  source "mm/damon/Kconfig"
> >
> > +config LARGE_ANON_FOLIO
> > +       bool "Allocate large folios for anonymous memory"
> > +       depends on TRANSPARENT_HUGEPAGE
> > +       default n
> > +       help
> > +         Use large (bigger than order-0) folios to back anonymous memo=
ry where
> > +         possible, even for pte-mapped memory. This reduces the number=
 of page
> > +         faults, as well as other per-page overheads to improve perfor=
mance for
> > +         many workloads.
> > +
> >  endmenu
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 01f39e8144ef..64c3f242c49a 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         return ret;
> >  }
> >
> > +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
> > +{
> > +       int i;
> > +
> > +       if (nr_pages =3D=3D 1)
> > +               return vmf_pte_changed(vmf);
> > +
> > +       for (i =3D 0; i < nr_pages; i++) {
> > +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> > +                       return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> > +#ifdef CONFIG_LARGE_ANON_FOLIO
> > +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> > +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_=
SHIFT)
> > +
> > +static int anon_folio_order(struct vm_area_struct *vma)
> > +{
> > +       int order;
> > +
> > +       /*
> > +        * If THP is explicitly disabled for either the vma, the proces=
s or the
> > +        * system, then this is very likely intended to limit internal
> > +        * fragmentation; in this case, don't attempt to allocate a lar=
ge
> > +        * anonymous folio.
> > +        *
> > +        * Else, if the vma is eligible for thp, allocate a large folio=
 of the
> > +        * size preferred by the arch. Or if the arch requested a very =
small
> > +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_OR=
DER,
> > +        * which still meets the arch's requirements but means we still=
 take
> > +        * advantage of SW optimizations (e.g. fewer page faults).
> > +        *
> > +        * Finally if thp is enabled but the vma isn't eligible, take t=
he
> > +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNH=
INTED.
> > +        * This ensures workloads that have not explicitly opted-in tak=
e benefit
> > +        * while capping the potential for internal fragmentation.
> > +        */
>
> What empirical evidence is SZ_64K based on?
> What workloads would benefit from it?
> How much would they benefit from it?
> Would they benefit more or less from different values?
> How much internal fragmentation would it cause?
> What cost function was used to arrive at the conclusion that its
> benefits outweigh its costs?
>
> > +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> > +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> > +           !hugepage_flags_enabled())
> > +               order =3D 0;
> > +       else {
> > +               order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY=
_ORDER);
> > +
> > +               if (!hugepage_vma_check(vma, vma->vm_flags, false, true=
, true))
> > +                       order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHIN=
TED);
> > +       }

I'm a bit surprised to see the above: why can we overload existing
ABIs? I don't think we can. Assuming we could, you would have to
update Documentation/admin-guide/mm/transhuge.rst in the same
patchset, and the man page for madvise() in a separate patch.

Most importantly, existing userspace programs that don't work well
with THPs won't be able to use (try) large folios either -- this is a
big no no.



> > +
> > +       return order;
> > +}
> > +
> > +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio=
)
>
> static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>
> and use ERR_PTR() and its friends.
>
> > +{
> > +       int i;
> > +       gfp_t gfp;
> > +       pte_t *pte;
> > +       unsigned long addr;
> > +       struct vm_area_struct *vma =3D vmf->vma;
> > +       int prefer =3D anon_folio_order(vma);
> > +       int orders[] =3D {
> > +               prefer,
> > +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_OR=
DER : 0,
> > +               0,
> > +       };
> > +
> > +       *folio =3D NULL;
> > +
> > +       if (vmf_orig_pte_uffd_wp(vmf))
> > +               goto fallback;
> > +
> > +       for (i =3D 0; orders[i]; i++) {
> > +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i=
]);
> > +               if (addr >=3D vma->vm_start &&
> > +                   addr + (PAGE_SIZE << orders[i]) <=3D vma->vm_end)
> > +                       break;
> > +       }
> > +
> > +       if (!orders[i])
> > +               goto fallback;
> > +
> > +       pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> > +       if (!pte)
> > +               return -EAGAIN;
> > +
> > +       for (; orders[i]; i++) {
> > +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i=
]);
> > +               vmf->pte =3D pte + pte_index(addr);
> > +               if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
> > +                       break;
> > +       }
> > +
> > +       vmf->pte =3D NULL;
> > +       pte_unmap(pte);
> > +
> > +       gfp =3D vma_thp_gfp_mask(vma);
> > +
> > +       for (; orders[i]; i++) {
> > +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i=
]);
> > +               *folio =3D vma_alloc_folio(gfp, orders[i], vma, addr, t=
rue);
> > +               if (*folio) {
> > +                       clear_huge_page(&(*folio)->page, addr, 1 << ord=
ers[i]);
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +fallback:
> > +       *folio =3D vma_alloc_zeroed_movable_folio(vma, vmf->address);
> > +       return *folio ? 0 : -ENOMEM;
> > +}
> > +#else
> > +static inline int alloc_anon_folio(struct vm_fault *vmf, struct folio =
**folio)
> > +{
> > +       *folio =3D vma_alloc_zeroed_movable_folio(vmf->vma, vmf->addres=
s);
> > +       return *folio ? 0 : -ENOMEM;
> > +}
> > +#endif
> > +
> >  /*
> >   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> >   * but allow concurrent faults), and pte mapped but not yet locked.
> > @@ -4057,6 +4178,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >   */
> >  static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> >  {
> > +       int i =3D 0;
> > +       int nr_pages =3D 1;
> > +       unsigned long addr =3D vmf->address;
> >         bool uffd_wp =3D vmf_orig_pte_uffd_wp(vmf);
> >         struct vm_area_struct *vma =3D vmf->vma;
> >         struct folio *folio;
> > @@ -4101,10 +4225,15 @@ static vm_fault_t do_anonymous_page(struct vm_f=
ault *vmf)
> >         /* Allocate our own private page. */
> >         if (unlikely(anon_vma_prepare(vma)))
> >                 goto oom;
> > -       folio =3D vma_alloc_zeroed_movable_folio(vma, vmf->address);
> > +       ret =3D alloc_anon_folio(vmf, &folio);
> > +       if (unlikely(ret =3D=3D -EAGAIN))
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
> > @@ -4116,17 +4245,12 @@ static vm_fault_t do_anonymous_page(struct vm_f=
ault *vmf)
> >          */
> >         __folio_mark_uptodate(folio);
> >
> > -       entry =3D mk_pte(&folio->page, vma->vm_page_prot);
> > -       entry =3D pte_sw_mkyoung(entry);
> > -       if (vma->vm_flags & VM_WRITE)
> > -               entry =3D pte_mkwrite(pte_mkdirty(entry));
> > -
> > -       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->add=
ress,
> > -                       &vmf->ptl);
> > +       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &v=
mf->ptl);
> >         if (!vmf->pte)
> >                 goto release;
> > -       if (vmf_pte_changed(vmf)) {
> > -               update_mmu_tlb(vma, vmf->address, vmf->pte);
> > +       if (vmf_pte_range_changed(vmf, nr_pages)) {
> > +               for (i =3D 0; i < nr_pages; i++)
> > +                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->=
pte + i);
> >                 goto release;
> >         }
> >
> > @@ -4141,16 +4265,24 @@ static vm_fault_t do_anonymous_page(struct vm_f=
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
> > +
> > +       for (i =3D 0; i < nr_pages; i++) {
> > +               entry =3D mk_pte(folio_page(folio, i), vma->vm_page_pro=
t);
> > +               entry =3D pte_sw_mkyoung(entry);
> > +               if (vma->vm_flags & VM_WRITE)
> > +                       entry =3D pte_mkwrite(pte_mkdirty(entry));
> >  setpte:
> > -       if (uffd_wp)
> > -               entry =3D pte_mkuffd_wp(entry);
> > -       set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
> > +               if (uffd_wp)
> > +                       entry =3D pte_mkuffd_wp(entry);
> > +               set_pte_at(vma->vm_mm, addr + PAGE_SIZE * i, vmf->pte +=
 i, entry);
> >
> > -       /* No need to invalidate - it was non-present before */
> > -       update_mmu_cache(vma, vmf->address, vmf->pte);
> > +               /* No need to invalidate - it was non-present before */
> > +               update_mmu_cache(vma, addr + PAGE_SIZE * i, vmf->pte + =
i);
> > +       }
> >  unlock:
> >         if (vmf->pte)
> >                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>
> The rest looks good to me.
