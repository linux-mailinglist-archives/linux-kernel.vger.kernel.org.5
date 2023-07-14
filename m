Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478D67544D8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjGNWM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGNWMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:12:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD1226A5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:12:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-401d1d967beso102211cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689372742; x=1691964742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9de+hA4ebf9aptJWYEQO2aAbMXZTXSZawaEiQbnb8U=;
        b=ZUArQV7JecXTavU9ahh8QcEbfl1vcBUv2PI4mnBecCPSyAQUrGbZ4qfnRqnKy4lFEA
         up/4sHtUegYOkQtsPAC7VahUhrPFknnKCAucWgNEWEsmuDG578pB5eTurzt1qts/1WXI
         x5CdzNj4lrz8iDsBf+n9BkO7PW8emvn6hSPogEw070QMu1HXePW9LsnacyJbAx3MFQNH
         NPgtVtKKCrgCDR6OEHovhuwCnunp5730iPKPKAsMmJK3TbejSJMrA9lkARshuvp6Dpqo
         N7xxXpkYWSdSZSzNXdCX21a01waqZgckFSLNsoYAc0sofIIb5Ar7GHUmSaQVXdrlieWA
         FSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689372742; x=1691964742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9de+hA4ebf9aptJWYEQO2aAbMXZTXSZawaEiQbnb8U=;
        b=LsCFsjkFiUXkgWMnfTyWLM2K8rbF440zvgDYeE0eTf/zFeuZJaFkzaC5vKrCH+D/J5
         RCYGDRvAqR+pon62ETjzO0qbEz2uqKOz+WC1AUihQHh+rDY34aJQlfVeDP1MhyE3o+Wn
         tmj9SL8qmhMUFrz3ShoAT8mHHTifTOxPugShaCuCOwonv6rlKV4uOSOK4IhSCdC71MBj
         R9Oaihl6xx3ldYLn0IKZeqZ9dAP1azb5wmMJEh6Y/PUypQHIx7GSB3AUe56Hu97icSf7
         QPvTNSNAyyBHOj3ZfA68LjmIxX874eNT7V7ZAvpVRmw+Azm6QSi1HPcVCkgLvcsTgX52
         Pfiw==
X-Gm-Message-State: ABy/qLaPgpzKPVXjjWG965B1WnMXipbiF3LgLg+VUYFKZPmlW5SegcKk
        v85cJsbl17ylYUbqwcZykXDyVWcctJrvyY8kBAYhdA==
X-Google-Smtp-Source: APBJJlELCYnkeCHF9T4WkxuVISvm2NnPaFLBVM50iBL78P1T627UwfRVVy6EExjEF1sRA2otj2sgxCsvKqVuD5IWV/8=
X-Received: by 2002:a05:622a:245:b0:3fa:3c8f:3435 with SMTP id
 c5-20020a05622a024500b003fa3c8f3435mr869632qtx.27.1689372741958; Fri, 14 Jul
 2023 15:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-3-ryan.roberts@arm.com> <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
 <432490d1-8d1e-1742-295a-d6e60a054ab6@arm.com>
In-Reply-To: <432490d1-8d1e-1742-295a-d6e60a054ab6@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 14 Jul 2023 16:11:45 -0600
Message-ID: <CAOUHufaDfJwF_-zb6zV5COG-KaaGcSyrNmbaEzaWz2UjcGGgHQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Fri, Jul 14, 2023 at 11:59=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 14/07/2023 18:17, Yu Zhao wrote:
> > On Fri, Jul 14, 2023 at 10:17=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
> >> allocated in large folios of a determined order. All pages of the larg=
e
> >> folio are pte-mapped during the same page fault, significantly reducin=
g
> >> the number of page faults. The number of per-page operations (e.g. ref
> >> counting, rmap management lru list management) are also significantly
> >> reduced since those ops now become per-folio.
> >>
> >> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
> >> defaults to disabled for now; The long term aim is for this to defaut =
to
> >> enabled, but there are some risks around internal fragmentation that
> >> need to be better understood first.
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
> >> arch_wants_pte_order() is limited by the new cmdline parameter,
> >> `flexthp_unhinted_max`. This allows for a performance boost without
> >> requiring any explicit opt-in from the workload while allowing the
> >> sysadmin to tune between performance and internal fragmentation.
> >>
> >> arch_wants_pte_order() can be overridden by the architecture if desire=
d.
> >> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguo=
us
> >> set of ptes map physically contigious, naturally aligned memory, so th=
is
> >> mechanism allows the architecture to optimize as required.
> >>
> >> If the preferred order can't be used (e.g. because the folio would
> >> breach the bounds of the vma, or because ptes in the region are alread=
y
> >> mapped) then we fall back to a suitable lower order; first
> >> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>  .../admin-guide/kernel-parameters.txt         |  10 +
> >>  mm/Kconfig                                    |  10 +
> >>  mm/memory.c                                   | 187 ++++++++++++++++-=
-
> >>  3 files changed, 190 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documen=
tation/admin-guide/kernel-parameters.txt
> >> index a1457995fd41..405d624e2191 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -1497,6 +1497,16 @@
> >>                         See Documentation/admin-guide/sysctl/net.rst f=
or
> >>                         fb_tunnels_only_for_init_ns
> >>
> >> +       flexthp_unhinted_max=3D
> >> +                       [KNL] Requires CONFIG_FLEXIBLE_THP enabled. Th=
e maximum
> >> +                       folio size that will be allocated for an anony=
mous vma
> >> +                       that has neither explicitly opted in nor out o=
f using
> >> +                       transparent hugepages. The size must be a powe=
r-of-2 in
> >> +                       the range [PAGE_SIZE, PMD_SIZE). A larger size=
 improves
> >> +                       performance by reducing page faults, while a s=
maller
> >> +                       size reduces internal fragmentation. Default: =
max(64K,
> >> +                       PAGE_SIZE). Format: size[KMG].
> >> +
> >
> > Let's split this parameter into a separate patch.
>
> Ha - I had it as a separate patch originally, but thought you'd ask for i=
t to be
> a single patch so squashed it ;-). I can separate it again, no problem.
>
> >
> > And I'm going to ask many questions about it (I can live with a sysctl
> > parameter but this boot parameter is unacceptable to me).
>
> Please do. Hopefully the thread with DavidH against v2 gives the rational=
e. Care
> to elaborate on why its unacceptable?

For starters, it's a bad practice not to support the first one that
works first, and then support the following ones if/when new use cases
arise.
1. per vma/process policies, e.g., madvise
2. per memcg policy, e..g, cgroup/memory.*
3. systemwide runtime knobs, e.g., sysctl
4. boot parameter, e.g., this one
5. kconfig option

Assuming the optimal state has one systemwide value, we would have to
find it by trial and error. And each trial would require a reboot,
which could be avoided if it was a sysctl parameter.

And why can we assume the optimal state has only one value?

(CONFIG_FLEXIBLE_THP is better than sysctl only because we plan to get
rid of it once we are ready -- using sysctl would cause an ABI
breakage, which might be acceptable but why do so if it can be
avoided.)

> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 01f39e8144ef..e8bc729efb9d 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -4050,6 +4050,148 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
> >> +#ifdef CONFIG_FLEXIBLE_THP
> >> +static int flexthp_unhinted_max_order =3D
> >> +               ilog2(SZ_64K > PAGE_SIZE ? SZ_64K : PAGE_SIZE) - PAGE_=
SHIFT;
> >> +
> >> +static int __init parse_flexthp_unhinted_max(char *s)
> >> +{
> >> +       unsigned long long size =3D memparse(s, NULL);
> >> +
> >> +       if (!is_power_of_2(size) || size < PAGE_SIZE || size > PMD_SIZ=
E) {
> >> +               pr_warn("flexthp: flexthp_unhinted_max=3D%s must be po=
wer-of-2 between PAGE_SIZE (%lu) and PMD_SIZE (%lu), ignoring\n",
> >> +                       s, PAGE_SIZE, PMD_SIZE);
> >> +               return 1;
> >> +       }
> >> +
> >> +       flexthp_unhinted_max_order =3D ilog2(size) - PAGE_SHIFT;
> >> +
> >> +       /* THP machinery requires at least 3 struct pages for meta dat=
a. */
> >> +       if (flexthp_unhinted_max_order =3D=3D 1)
> >> +               flexthp_unhinted_max_order--;
> >> +
> >> +       return 1;
> >> +}
> >> +
> >> +__setup("flexthp_unhinted_max=3D", parse_flexthp_unhinted_max);
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
> >> +        * arch-preferred size and limit it to the flexthp_unhinted_ma=
x cmdline
> >> +        * parameter. This allows a sysadmin to tune performance vs in=
ternal
> >> +        * fragmentation.
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
> >> +                       order =3D min(order, flexthp_unhinted_max_orde=
r);
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
> >> +
> >> +       for (i =3D 0; orders[i]; i++) {
> >> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[=
i]);
> >> +               if (addr >=3D vma->vm_start &&
> >> +                   addr + (PAGE_SIZE << orders[i]) <=3D vma->vm_end)
> >> +                       break;
> >> +       }
> >> +
> >> +       if (!orders[i])
> >> +               goto fallback;
> >> +
> >> +       pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> >> +       if (!pte)
> >> +               return -EAGAIN;
> >
> > It would be a bug if this happens. So probably -EINVAL?
>
> Not sure what you mean? Hugh Dickins' series that went into v6.5-rc1 make=
s it
> possible for pte_offset_map() to fail (if I understood correctly) and we =
have to
> handle this. The intent is that we will return from the fault without mak=
ing any
> change, then we will refault and try again.

Thanks for checking that -- it's very relevant. One detail is that
that series doesn't affect anon. IOW, collapsing PTEs into a PMD can't
happen while we are holding mmap_lock for read here, and therefore,
the race that could cause pte_offset_map() on shmem/file PTEs to fail
doesn't apply here.

+Hugh Dickins for further consultation if you need it.

> >> +
> >> +       for (; orders[i]; i++) {
> >> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[=
i]);
> >> +               vmf->pte =3D pte + pte_index(addr);
> >> +               if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
> >> +                       break;
> >> +       }
> >> +
> >> +       vmf->pte =3D NULL;
> >> +       pte_unmap(pte);
> >> +
> >> +       gfp =3D vma_thp_gfp_mask(vma);
> >> +
> >> +       for (; orders[i]; i++) {
> >> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[=
i]);
> >> +               *folio =3D vma_alloc_folio(gfp, orders[i], vma, addr, =
true);
> >> +               if (*folio) {
> >> +                       clear_huge_page(&(*folio)->page, addr, 1 << or=
ders[i]);
> >> +                       return 0;
> >> +               }
> >> +       }
> >> +
> >> +fallback:
> >> +       *folio =3D vma_alloc_zeroed_movable_folio(vma, vmf->address);
> >> +       return *folio ? 0 : -ENOMEM;
> >> +}
> >> +#else
> >> +static inline int alloc_anon_folio(struct vm_fault *vmf, struct folio=
 **folio)
> >
> > Drop "inline" (it doesn't do anything in .c).
>
> There are 38 instances of inline in memory.c alone, so looks like a well =
used
> convention, even if the compiler may choose to ignore. Perhaps you can ed=
ucate
> me; what's the benefit of dropping it?

I'll let Willy and Andrew educate both of us :)

+Matthew Wilcox +Andrew Morton please. Thank you.

> > The rest looks good to me.
>
> Great - just incase it wasn't obvious, I decided not to overwrite vmf->ad=
dress
> with the aligned version, as you suggested

Yes, I've noticed. Not overwriting has its own merits for sure.

> for 2 reasons; 1) address is const
> in the struct, so would have had to change that. 2) there is a uffd path =
that
> can be taken after the vmf->address fixup would have occured and the path
> consumes that member, so it would have had to be un-fixed-up making it mo=
re
> messy than the way I opted for.
>
> Thanks for the quick review as always!
