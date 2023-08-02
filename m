Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D476D92A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjHBVGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHBVGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:06:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6B92D40
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:05:59 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4036bd4fff1so90351cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691010358; x=1691615158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWF3aL11NyD1CVoDxNQ2PmhgsCGdDd1WMU/bfe/1eEE=;
        b=eS2QUfl5KkS5/4qYspLxFcyIWawGjoXuxrzojJcFUWfhQBuk8wCmg8UjLXgWWRFMYN
         XBs0ibAOd4+hPuHgzO/POxPJi4dA9npAS36wy22iXsQYgCrO0IVOqwDfk0gJ8zeqiggT
         sDdBQsiNtJrXxPtCDBceQ/CpiFOS9ad6/PSfllq/bI/jNXbtcYNXYyCuSIweZddEJdeB
         xfaDqfH5XyQdlILjQctBmN6AGY6Hbj93z6LgU3z23IpWFWI9MHyS/KT7ufzHd+x6TEh1
         1Ks1m/juQqRFYMbFsQRMtuYzgJg/e4rgV3GOK++RStfLWZKxG3vNzDTsJGCjfvJH8tuR
         bNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691010358; x=1691615158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWF3aL11NyD1CVoDxNQ2PmhgsCGdDd1WMU/bfe/1eEE=;
        b=V6lYZPP+sArjd8mg0C3+RazXVaERyyIzTl/TJf+hc4+qn+rLt6Sp5F9i6qV12q05nb
         o5K7+Zz8rFl5//5rnTfbhYlc7IbMQBBEuIMStE63oqOrwhiNA57IQsKeiwtfG7lkIBem
         mO7Kyhd6ELVI0QLJYeZKUOnkCT0MCK0vqpzS+SjK3+vs6QzOYOCNLK5J2irEPSBxow8E
         Vhr8CO9K5QzGaT67/Ecbh0ZVNKE6MVtIFTPAf9U6OAYtCnuDcnxXyqxOHuktEnDk7M6a
         VVtFQ+/PQDbEcxlkW0dpXHv1f+xA1madUbaCfQuJw6MaTKUzm71c4C2sSbwc9Ifarwby
         Eh4g==
X-Gm-Message-State: ABy/qLahzRSCeLXvIl3tM9sMMZLBZH1BCsbby/vdD/ng3Z74J+MVImxI
        E5EvcRlDXcaSa7FsQip9ytQWiLu00pPtfvmBuXeyWA==
X-Google-Smtp-Source: APBJJlH3DxuillX6R4KD7WNDmRI2MFHocTd0U+76vT7nEv7eSiLgFEtWRYp11e+lSBPRiPfL3gqW5fUF9QCnQGbIuKY=
X-Received: by 2002:a05:622a:1441:b0:3f2:2c89:f1ef with SMTP id
 v1-20020a05622a144100b003f22c89f1efmr1316954qtx.5.1691010358222; Wed, 02 Aug
 2023 14:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <CAOUHufZDt4i=YLpQCGTgsya+kfzDCJvYCE+-cXf0PUmFVpL9zg@mail.gmail.com>
 <c34282b6-fea4-248f-79a2-4a88006dd3b3@arm.com>
In-Reply-To: <c34282b6-fea4-248f-79a2-4a88006dd3b3@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 2 Aug 2023 15:05:21 -0600
Message-ID: <CAOUHufaVTmzfo30spZ0PN+WPkJoPOQqdQBzfrAoHh6QgMvZ2AA@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 3:33=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 01/08/2023 07:18, Yu Zhao wrote:
> > On Wed, Jul 26, 2023 at 3:52=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to b=
e
> >> allocated in large folios of a determined order. All pages of the larg=
e
> >> folio are pte-mapped during the same page fault, significantly reducin=
g
> >> the number of page faults. The number of per-page operations (e.g. ref
> >> counting, rmap management lru list management) are also significantly
> >> reduced since those ops now become per-folio.
> >>
> >> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> >> which defaults to disabled for now; The long term aim is for this to
> >> defaut to enabled, but there are some risks around internal
> >> fragmentation that need to be better understood first.
> >>
> >> When enabled, the folio order is determined as such: For a vma, proces=
s
> >> or system that has explicitly disabled THP, we continue to allocate
> >> order-0. THP is most likely disabled to avoid any possible internal
> >> fragmentation so we honour that request.
> >>
> >> Otherwise, the return value of arch_wants_pte_order() is used. For vma=
s
> >> that have not explicitly opted-in to use transparent hugepages (e.g.
> >> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> >> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> >> bigger). This allows for a performance boost without requiring any
> >> explicit opt-in from the workload while limitting internal
> >> fragmentation.
> >>
> >> If the preferred order can't be used (e.g. because the folio would
> >> breach the bounds of the vma, or because ptes in the region are alread=
y
> >> mapped) then we fall back to a suitable lower order; first
> >> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >>
> >> arch_wants_pte_order() can be overridden by the architecture if desire=
d.
> >> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguo=
us
> >> set of ptes map physically contigious, naturally aligned memory, so th=
is
> >> mechanism allows the architecture to optimize as required.
> >>
> >> Here we add the default implementation of arch_wants_pte_order(), used
> >> when the architecture does not define it, which returns -1, implying
> >> that the HW has no preference. In this case, mm will choose it's own
> >> default order.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  include/linux/pgtable.h |  13 ++++
> >>  mm/Kconfig              |  10 +++
> >>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++---=
-
> >>  3 files changed, 172 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >> index 5063b482e34f..2a1d83775837 100644
> >> --- a/include/linux/pgtable.h
> >> +++ b/include/linux/pgtable.h
> >> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
> >>  }
> >>  #endif
> >>
> >> +#ifndef arch_wants_pte_order
> >> +/*
> >> + * Returns preferred folio order for pte-mapped memory. Must be in ra=
nge [0,
> >> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires l=
arge folios
> >> + * to be at least order-2. Negative value implies that the HW has no =
preference
> >> + * and mm will choose it's own default order.
> >> + */
> >> +static inline int arch_wants_pte_order(void)
> >> +{
> >> +       return -1;
> >> +}
> >> +#endif
> >> +
> >>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >>                                        unsigned long address,
> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> index 09130434e30d..fa61ea160447 100644
> >> --- a/mm/Kconfig
> >> +++ b/mm/Kconfig
> >> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
> >>
> >>  source "mm/damon/Kconfig"
> >>
> >> +config LARGE_ANON_FOLIO
> >> +       bool "Allocate large folios for anonymous memory"
> >> +       depends on TRANSPARENT_HUGEPAGE
> >> +       default n
> >> +       help
> >> +         Use large (bigger than order-0) folios to back anonymous mem=
ory where
> >> +         possible, even for pte-mapped memory. This reduces the numbe=
r of page
> >> +         faults, as well as other per-page overheads to improve perfo=
rmance for
> >> +         many workloads.
> >> +
> >>  endmenu
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 01f39e8144ef..64c3f242c49a 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>         return ret;
> >>  }
> >>
> >> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
> >> +{
> >> +       int i;
> >> +
> >> +       if (nr_pages =3D=3D 1)
> >> +               return vmf_pte_changed(vmf);
> >> +
> >> +       for (i =3D 0; i < nr_pages; i++) {
> >> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> >> +                       return true;
> >> +       }
> >> +
> >> +       return false;
> >> +}
> >> +
> >> +#ifdef CONFIG_LARGE_ANON_FOLIO
> >> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> >> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE=
_SHIFT)
> >> +
> >> +static int anon_folio_order(struct vm_area_struct *vma)
> >> +{
> >> +       int order;
> >> +
> >> +       /*
> >> +        * If THP is explicitly disabled for either the vma, the proce=
ss or the
> >> +        * system, then this is very likely intended to limit internal
> >> +        * fragmentation; in this case, don't attempt to allocate a la=
rge
> >> +        * anonymous folio.
> >> +        *
> >> +        * Else, if the vma is eligible for thp, allocate a large foli=
o of the
> >> +        * size preferred by the arch. Or if the arch requested a very=
 small
> >> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_O=
RDER,
> >> +        * which still meets the arch's requirements but means we stil=
l take
> >> +        * advantage of SW optimizations (e.g. fewer page faults).
> >> +        *
> >> +        * Finally if thp is enabled but the vma isn't eligible, take =
the
> >> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UN=
HINTED.
> >> +        * This ensures workloads that have not explicitly opted-in ta=
ke benefit
> >> +        * while capping the potential for internal fragmentation.
> >> +        */
> >> +
> >> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> >> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> >> +           !hugepage_flags_enabled())
> >> +               order =3D 0;
> >> +       else {
> >> +               order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTL=
Y_ORDER);
> >> +
> >> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, tru=
e, true))
> >> +                       order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHI=
NTED);
> >> +       }
> >> +
> >> +       return order;
> >> +}
> >> +
> >> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **foli=
o)
> >> +{
> >> +       int i;
> >> +       gfp_t gfp;
> >> +       pte_t *pte;
> >> +       unsigned long addr;
> >> +       struct vm_area_struct *vma =3D vmf->vma;
> >> +       int prefer =3D anon_folio_order(vma);
> >> +       int orders[] =3D {
> >> +               prefer,
> >> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_O=
RDER : 0,
> >> +               0,
> >> +       };
> >> +
> >> +       *folio =3D NULL;
> >> +
> >> +       if (vmf_orig_pte_uffd_wp(vmf))
> >> +               goto fallback;
> >
> > I think we need to s/vmf_orig_pte_uffd_wp/userfaultfd_armed/ here;
> > otherwise UFFD would miss VM_UFFD_MISSING/MINOR.
>
> I don't think this is the case. As far as I can see, VM_UFFD_MINOR only a=
pplies
> to shmem and hugetlb.

Correct, but we don't have a helper to check against (VM_UFFD_WP |
VM_UFFD_MISSING). Reusing userfaultfd_armed() seems cleaner to me or
even future proof.

> VM_UFFD_MISSING is checked under the PTL and if set on the
> VMA, then it is handled without mapping the folio that was just allocated=
:
>
>         /* Deliver the page fault to userland, check inside PT lock */
>         if (userfaultfd_missing(vma)) {
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>                 folio_put(folio);
>                 return handle_userfault(vmf, VM_UFFD_MISSING);
>         }
>
> So we are racing to allocate a large folio; if the vma later turns out to=
 have
> MISSING handling registered, we drop the folio and handle it, else we map=
 the
> large folio.

Yes, then we have allocated a large folio (with great effort if under
heavy memory pressure) for nothing.

> The vmf_orig_pte_uffd_wp() *is* required because we need to individually =
check
> each PTE for the uffd_wp bit and fix it up.

This is not correct: we cannot see a WP PTE before you see
VM_UFFD_WP. So checking VM_UFFD_WP is perfectly safe.

The reason we might want to check individual PTEs is because WP can be
done to a subrange of a VMA that has VM_UFFD_WP, which I don't think
is the common case and worth considering here. But if you want to keep
it, that's fine with me. Without some comments, the next person might
find these two checks confusing though, if you plan to add both.

> So I think the code is correct, but perhaps it is safer/simpler to always=
 avoid
> allocating a large folio if the vma is registered for uffd in the way you
> suggest? I don't know enough about uffd to form a strong opinion either w=
ay.

Yes, it's not about correctness. Just a second thought about not
allocating large folios unnecessarily when possible.
