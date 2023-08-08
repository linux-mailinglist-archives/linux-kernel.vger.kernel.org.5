Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB15A7749A9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjHHT7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjHHT7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:59:32 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C391DF2D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:13:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40a47e8e38dso33641cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691518409; x=1692123209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DHFqoL98yaw3TbOBEIMP7KbBkaabuHWFQWC3lG14M4=;
        b=P4iYOoXIUDtRGTE18hybBYwQaLGTTHkAMr2eRU1iisfgJDO6eZ+niSwPPE8j/OjZ9M
         pKKKt/drKLOC5aeTgXVVxm0kC6ZKccOUSPagdebPsLYsOKI8UA46ENOlWtKj2Ji0qzHq
         K/rvzqbxzzhaW6mOGmvK4C6Ty8VQtvfLcT/1xR/YqgFzyeL6Ilnil1N8+jacKAfaTO1X
         ybR0z75enXi6hNHtkW6kfij4ZaNlEUA9H8TxqKk6Sjlzx4q04unG46+LEHXNLWPBYGDl
         M1WwTHrCNRGPMQoSbZoWQvfE5mtML5Z2lUtj3lwOS8FsoMU2dvw10s0ACYofTiRiotr5
         XKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691518409; x=1692123209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DHFqoL98yaw3TbOBEIMP7KbBkaabuHWFQWC3lG14M4=;
        b=cU8MwZER/5wYUVWAIjv1y4kusi5jAxXKiCZ7zBdIw/WAFe5k21Bvl6es3bqPV4Uhlu
         HtUsvFg52vSx29gf1B2Xiwq/1DplucYq4R9UdCdbDHGbCB/aMEC2KsyoICZVRoh8CYef
         t01qUqfgx3NG4n80d18jxmola0FRW3jHsLQ+VkBEO363zln27xstr/ZRwh4a/IDG6Veg
         PiJVcf6mKqAXg4fHWoNcYmkRsVFvC7aoPHcwHGV7lwVqm8AseZ0V6PWzlayb0M6h7vGR
         F62XJegqiEm8uEWm2ANr8GO4HxBGhKqctmrWCGLqq4o7QToyyPBcFuwFN9ZviZhrMmFp
         beRA==
X-Gm-Message-State: AOJu0YyAWwaPu8Pnc+5XOsrXYIb/DERah1/8pDyuOghp4m07hkRNH3/9
        salMWJ7aKZDXPDGMtXP/VpzMonHM5Ac+E/1fOMw1SQ==
X-Google-Smtp-Source: AGHT+IE075x4pGL3UMoe0AzhYtX+ss/res/POhQ6v/+t6JwQ46qqG5eRhwrfe/CCkKy6gDYueZCbassXm910CuXPUNI=
X-Received: by 2002:ac8:7f93:0:b0:403:fdf1:e05e with SMTP id
 z19-20020ac87f93000000b00403fdf1e05emr17177qtj.19.1691518408535; Tue, 08 Aug
 2023 11:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <CAOUHufbdbeFhpXw_w4z62=PwCjCa-yuvE6Brhpd3AOxiswa_2Q@mail.gmail.com>
 <433fb8de-f5c0-d150-ac7b-5d73e9958e02@arm.com> <CAOUHufZwyNrNbnpgTR=o5O8__QE4NdNG=LTgUoB26bVvDfgBkA@mail.gmail.com>
 <20469f02-d62d-d925-3536-d6a1f1099fda@arm.com> <CAOUHufbo58cJiD+k_SAw9N+4xJRv6BTYCZSbP3CxSsy3UOdPMw@mail.gmail.com>
In-Reply-To: <CAOUHufbo58cJiD+k_SAw9N+4xJRv6BTYCZSbP3CxSsy3UOdPMw@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 8 Aug 2023 12:12:51 -0600
Message-ID: <CAOUHufbaWjOq4BnQasSeZyq2SZKQZ0d7DQ7mkj7Ses8hFAR5uw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 11:57=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Aug 8, 2023 at 3:37=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
> >
> > On 08/08/2023 00:21, Yu Zhao wrote:
> > > On Mon, Aug 7, 2023 at 1:07=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> > >>
> > >> On 07/08/2023 06:24, Yu Zhao wrote:
> > >>> On Wed, Jul 26, 2023 at 3:52=E2=80=AFAM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
> > >>>>
> > >>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory =
to be
> > >>>> allocated in large folios of a determined order. All pages of the =
large
> > >>>> folio are pte-mapped during the same page fault, significantly red=
ucing
> > >>>> the number of page faults. The number of per-page operations (e.g.=
 ref
> > >>>> counting, rmap management lru list management) are also significan=
tly
> > >>>> reduced since those ops now become per-folio.
> > >>>>
> > >>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfi=
g,
> > >>>> which defaults to disabled for now; The long term aim is for this =
to
> > >>>> defaut to enabled, but there are some risks around internal
> > >>>> fragmentation that need to be better understood first.
> > >>>>
> > >>>> When enabled, the folio order is determined as such: For a vma, pr=
ocess
> > >>>> or system that has explicitly disabled THP, we continue to allocat=
e
> > >>>> order-0. THP is most likely disabled to avoid any possible interna=
l
> > >>>> fragmentation so we honour that request.
> > >>>>
> > >>>> Otherwise, the return value of arch_wants_pte_order() is used. For=
 vmas
> > >>>> that have not explicitly opted-in to use transparent hugepages (e.=
g.
> > >>>> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> > >>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever =
is
> > >>>> bigger). This allows for a performance boost without requiring any
> > >>>> explicit opt-in from the workload while limitting internal
> > >>>> fragmentation.
> > >>>>
> > >>>> If the preferred order can't be used (e.g. because the folio would
> > >>>> breach the bounds of the vma, or because ptes in the region are al=
ready
> > >>>> mapped) then we fall back to a suitable lower order; first
> > >>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> > >>>>
> > >>>> arch_wants_pte_order() can be overridden by the architecture if de=
sired.
> > >>>> Some architectures (e.g. arm64) can coalsece TLB entries if a cont=
iguous
> > >>>> set of ptes map physically contigious, naturally aligned memory, s=
o this
> > >>>> mechanism allows the architecture to optimize as required.
> > >>>>
> > >>>> Here we add the default implementation of arch_wants_pte_order(), =
used
> > >>>> when the architecture does not define it, which returns -1, implyi=
ng
> > >>>> that the HW has no preference. In this case, mm will choose it's o=
wn
> > >>>> default order.
> > >>>>
> > >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > >>>> ---
> > >>>>  include/linux/pgtable.h |  13 ++++
> > >>>>  mm/Kconfig              |  10 +++
> > >>>>  mm/memory.c             | 166 +++++++++++++++++++++++++++++++++++=
+----
> > >>>>  3 files changed, 172 insertions(+), 17 deletions(-)
> > >>>>
> > >>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > >>>> index 5063b482e34f..2a1d83775837 100644
> > >>>> --- a/include/linux/pgtable.h
> > >>>> +++ b/include/linux/pgtable.h
> > >>>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void=
)
> > >>>>  }
> > >>>>  #endif
> > >>>>
> > >>>> +#ifndef arch_wants_pte_order
> > >>>> +/*
> > >>>> + * Returns preferred folio order for pte-mapped memory. Must be i=
n range [0,
> > >>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requir=
es large folios
> > >>>> + * to be at least order-2. Negative value implies that the HW has=
 no preference
> > >>>> + * and mm will choose it's own default order.
> > >>>> + */
> > >>>> +static inline int arch_wants_pte_order(void)
> > >>>> +{
> > >>>> +       return -1;
> > >>>> +}
> > >>>> +#endif
> > >>>> +
> > >>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
> > >>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> > >>>>                                        unsigned long address,
> > >>>> diff --git a/mm/Kconfig b/mm/Kconfig
> > >>>> index 09130434e30d..fa61ea160447 100644
> > >>>> --- a/mm/Kconfig
> > >>>> +++ b/mm/Kconfig
> > >>>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
> > >>>>
> > >>>>  source "mm/damon/Kconfig"
> > >>>>
> > >>>> +config LARGE_ANON_FOLIO
> > >>>> +       bool "Allocate large folios for anonymous memory"
> > >>>> +       depends on TRANSPARENT_HUGEPAGE
> > >>>> +       default n
> > >>>> +       help
> > >>>> +         Use large (bigger than order-0) folios to back anonymous=
 memory where
> > >>>> +         possible, even for pte-mapped memory. This reduces the n=
umber of page
> > >>>> +         faults, as well as other per-page overheads to improve p=
erformance for
> > >>>> +         many workloads.
> > >>>> +
> > >>>>  endmenu
> > >>>> diff --git a/mm/memory.c b/mm/memory.c
> > >>>> index 01f39e8144ef..64c3f242c49a 100644
> > >>>> --- a/mm/memory.c
> > >>>> +++ b/mm/memory.c
> > >>>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
> > >>>>         return ret;
> > >>>>  }
> > >>>>
> > >>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pa=
ges)
> > >>>> +{
> > >>>> +       int i;
> > >>>> +
> > >>>> +       if (nr_pages =3D=3D 1)
> > >>>> +               return vmf_pte_changed(vmf);
> > >>>> +
> > >>>> +       for (i =3D 0; i < nr_pages; i++) {
> > >>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> > >>>> +                       return true;
> > >>>> +       }
> > >>>> +
> > >>>> +       return false;
> > >>>> +}
> > >>>> +
> > >>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
> > >>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> > >>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - =
PAGE_SHIFT)
> > >>>> +
> > >>>> +static int anon_folio_order(struct vm_area_struct *vma)
> > >>>> +{
> > >>>> +       int order;
> > >>>> +
> > >>>> +       /*
> > >>>> +        * If THP is explicitly disabled for either the vma, the p=
rocess or the
> > >>>> +        * system, then this is very likely intended to limit inte=
rnal
> > >>>> +        * fragmentation; in this case, don't attempt to allocate =
a large
> > >>>> +        * anonymous folio.
> > >>>> +        *
> > >>>> +        * Else, if the vma is eligible for thp, allocate a large =
folio of the
> > >>>> +        * size preferred by the arch. Or if the arch requested a =
very small
> > >>>> +        * size or didn't request a size, then use PAGE_ALLOC_COST=
LY_ORDER,
> > >>>> +        * which still meets the arch's requirements but means we =
still take
> > >>>> +        * advantage of SW optimizations (e.g. fewer page faults).
> > >>>> +        *
> > >>>> +        * Finally if thp is enabled but the vma isn't eligible, t=
ake the
> > >>>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDE=
R_UNHINTED.
> > >>>> +        * This ensures workloads that have not explicitly opted-i=
n take benefit
> > >>>> +        * while capping the potential for internal fragmentation.
> > >>>> +        */
> > >>>> +
> > >>>> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> > >>>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> > >>>> +           !hugepage_flags_enabled())
> > >>>> +               order =3D 0;
> > >>>> +       else {
> > >>>> +               order =3D max(arch_wants_pte_order(), PAGE_ALLOC_C=
OSTLY_ORDER);
> > >>>> +
> > >>>> +               if (!hugepage_vma_check(vma, vma->vm_flags, false,=
 true, true))
> > >>>> +                       order =3D min(order, ANON_FOLIO_MAX_ORDER_=
UNHINTED);
> > >>>> +       }
> > >>>> +
> > >>>> +       return order;
> > >>>> +}
> > >>>> +
> > >>>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **=
folio)
> > >>>> +{
> > >>>> +       int i;
> > >>>> +       gfp_t gfp;
> > >>>> +       pte_t *pte;
> > >>>> +       unsigned long addr;
> > >>>> +       struct vm_area_struct *vma =3D vmf->vma;
> > >>>> +       int prefer =3D anon_folio_order(vma);
> > >>>> +       int orders[] =3D {
> > >>>> +               prefer,
> > >>>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COST=
LY_ORDER : 0,
> > >>>> +               0,
> > >>>> +       };
> > >>>> +
> > >>>> +       *folio =3D NULL;
> > >>>> +
> > >>>> +       if (vmf_orig_pte_uffd_wp(vmf))
> > >>>> +               goto fallback;
> > >>>
> > >>> Per the discussion, we need to check hugepage_vma_check() for
> > >>> correctness of VM LM. I'd just check it here and fall back to order=
 0
> > >>> if that helper returns false.
> > >>
> > >> I'm not sure if either you haven't noticed the logic in anon_folio_o=
rder()
> > >> above, or whether you are making this suggestion because you disagre=
e with the
> > >> subtle difference in my logic?
> > >
> > > The latter, or more generally the policy you described earlier.
> > >
> > >> My logic is deliberately not calling hugepage_vma_check() because th=
at would
> > >> return false for the thp=3Dmadvise,mmap=3Dunhinted case, whereas the=
 policy I'm
> > >> implementing wants to apply LAF in that case.
> > >>
> > >>
> > >> My intended policy:
> > >>
> > >>                 | never     | madvise   | always
> > >> ----------------|-----------|-----------|-----------
> > >> no hint         | S         | LAF>S     | THP>LAF>S
> > >> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
> > >> MADV_NOHUGEPAGE | S         | S         | S
> > >>
> > >>
> > >> What your suggestion would give:
> > >>
> > >>                 | never     | madvise   | always
> > >> ----------------|-----------|-----------|-----------
> > >> no hint         | S         | S         | THP>LAF>S
> > >> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
> > >> MADV_NOHUGEPAGE | S         | S         | S
> > >
> > > This is not what I'm suggesting.
> > >
> > > Let me reiterate [1]:
> > >   My impression is we only agreed on one thing: at the current stage,=
 we
> > >   should respect things we absolutely have to. We didn't agree on wha=
t
> > >   "never" means ("never 2MB" or "never >4KB"), and we didn't touch on
> > >   how "always" should behave at all.
> > >
> > > And [2]:
> > >   (Thanks to David, now I agree that) we have to interpret MADV_NOHUG=
EPAGE
> > >   as nothing >4KB.
> > >
> > > My final take [3]:
> > >   I agree these points require more discussion. But I don't think we
> > >   need to conclude them now, unless they cause correctness issues lik=
e
> > >   ignoring MADV_NOHUGEPAGE would.
> >
> > Thanks, I've read all of these comments previously, and appreciate the =
time you
> > have put into the feedback. I'm not sure I fully agree with your point =
that we
> > don't need to conclude on a policy now; I certainly don't think we need=
 the
> > whole thing in place on day 1, but I do think that whatever we put in s=
hould
> > strive to be a strict subset of where we think we are going. For exampl=
e, if we
> > put something in with one policy (i.e. "never" only means "never 2MB") =
then find
> > a problem and have to change that to be more conservative, are we riski=
ng perf
> > regressions for any LAF users that started using it on day 1?
>
> It's not that I don't want to -- I just don't think we have enough
> information before we have a wider deployment [1] and gain a better
> understanding of real-world scenarios.
>
> Of course we could force a conclusion, a mostly opinion-based one. But
> it would still involve prolonged discussions and delay this series, or
> rush into decisions we might regret later.
>
> [1] Our fleets (servers, laptops and phones) support large-scale
> experiments and I plan to run them on both client and server devices.
>
> > > But I should have been clear about the parameters to
> > > hugepage_vma_check(): enforce_sysfs=3Dfalse.
> >
> > So hugepage_vma_check(..., smaps=3Dfalse, in_pf=3Dtrue, enforce_sysfs=
=3Dfalse) would
> > give us:
> >
> >                 | prctl/fw  | sysfs     | sysfs     | sysfs
> >                 | disable   | never     | madvise   | always
> > ----------------|-----------|-----------|-----------|-----------
> > no hint         | S         | LAF>S     | LAF>S     | THP>LAF>S
> > MADV_HUGEPAGE   | S         | LAF>S     | THP>LAF>S | THP>LAF>S
> > MADV_NOHUGEPAGE | S         | S         | S         | S
> >
> > Where "prctl/fw disable" trumps the sysfs setting.
> >
> > I can certainly see the benefit of this approach; it gives us a way to =
enable
> > LAF while disabling THP (thp=3Dnever). It doesn't give us a way to enab=
le THP
> > without enabling LAF though (unless you recompile with LAF disabled). D=
oes
> > anyone see a problem with this?
>
> I do myself :)
>
> This is just something temporary to get this series landed. We are
> hiding behind a Kconfig, not making any ABI changes, and not exposing
> this policy to userspace (i.e., not updating Documentation/, man
> pages, etc.)
>
> Meanwhile, we can keep discussing all the open questions in parallel.

And the stat ABI changes should be discussed before or at the same
time. If we came up with a policy but there was *zero* observability
of how well that policy works...
