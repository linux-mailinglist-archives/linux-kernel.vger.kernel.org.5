Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659947748D7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjHHTmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236778AbjHHTmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:42:10 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1328CC309F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:58:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40a47e8e38dso27601cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691517516; x=1692122316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sULfjATLZ+TD4aptIsGhX/+syaJzg9nTxWAKu34TQSA=;
        b=s3fjHZLkMRb2MSBpxiCL0mTobiiZ9vOCNcgn7q7/fH4L1e2pTktJata1vQgyawxmM9
         cmSW8vb9ri3zDmSaCvnfwjTGqpsCLKRedHnV+7CvdrPuTQVognjN38WCDLtfPWBND4FQ
         JPd+U9cWI2zWk/2ijRDSDnii0rZ6j2c2niJk9ZioBntaFBMo5Mi6uUZzpkVcF9KcWGtv
         iSl7EqATYlUX7/kc6dBUbD+eEQhsJT2a/oHVp7JFmjasH8mCE797xzE4D/kEZy7d0ISm
         V4eZ/5dlsdfqvXu8jnzqMZI4ko7spZn7PRGkVuYypbW2bS02Z6DbXbli4Gpf1/UiLwum
         Nfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691517516; x=1692122316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sULfjATLZ+TD4aptIsGhX/+syaJzg9nTxWAKu34TQSA=;
        b=kMbMCFD6ppxmfqDamhVTi0Ztiqw1ssvfoa2DlbpjyJRdRTR6dHgpPO4jA47MVoAT6/
         NFRIkoU9fVzUTqrtful4MautW5r4xtquJAVUykDO7ErhL4Qcv5n83hzJ38OPsfqw7nYL
         XHdc/I/MbkopL4vK3UpFH23W+Lw43gJjxTa7yk5jlpcjvgpGCgmbw33HQS7TSXcYaEqR
         aC10dyZFzWFX9VTgil8ureA30iMwdKLQCXqhaXGOb/dhSNgAK4taP1PLB38WfyTLC8iD
         u6p4aoiM/CsHN/FYgxYQmcmM1k2eNzg/w7kBdeOMGOSEC5YOgU373ZXJafBmcYLY5Di1
         B4cw==
X-Gm-Message-State: AOJu0YwkmNZW7cOIFcWMgkqJxg517vxBCwqVavKS564Zqmn215msVkWq
        3mU/lW4kdlAi/fy/ti0hA4M4oNtyQ/DOAGV9Cv5JzQ==
X-Google-Smtp-Source: AGHT+IGHAyIE5IxDDX8kJC1lq76Y7IY5o/icthSsZbBKvg6kg+djkgYnPea86MrYvv28PYLZxdZqNahXr/dt/2jPvxQ=
X-Received: by 2002:ac8:5804:0:b0:3f8:5b2:aeed with SMTP id
 g4-20020ac85804000000b003f805b2aeedmr21266qtg.21.1691517515979; Tue, 08 Aug
 2023 10:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <CAOUHufbdbeFhpXw_w4z62=PwCjCa-yuvE6Brhpd3AOxiswa_2Q@mail.gmail.com>
 <433fb8de-f5c0-d150-ac7b-5d73e9958e02@arm.com> <CAOUHufZwyNrNbnpgTR=o5O8__QE4NdNG=LTgUoB26bVvDfgBkA@mail.gmail.com>
 <20469f02-d62d-d925-3536-d6a1f1099fda@arm.com>
In-Reply-To: <20469f02-d62d-d925-3536-d6a1f1099fda@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 8 Aug 2023 11:57:59 -0600
Message-ID: <CAOUHufbo58cJiD+k_SAw9N+4xJRv6BTYCZSbP3CxSsy3UOdPMw@mail.gmail.com>
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

On Tue, Aug 8, 2023 at 3:37=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 08/08/2023 00:21, Yu Zhao wrote:
> > On Mon, Aug 7, 2023 at 1:07=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> On 07/08/2023 06:24, Yu Zhao wrote:
> >>> On Wed, Jul 26, 2023 at 3:52=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to=
 be
> >>>> allocated in large folios of a determined order. All pages of the la=
rge
> >>>> folio are pte-mapped during the same page fault, significantly reduc=
ing
> >>>> the number of page faults. The number of per-page operations (e.g. r=
ef
> >>>> counting, rmap management lru list management) are also significantl=
y
> >>>> reduced since those ops now become per-folio.
> >>>>
> >>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> >>>> which defaults to disabled for now; The long term aim is for this to
> >>>> defaut to enabled, but there are some risks around internal
> >>>> fragmentation that need to be better understood first.
> >>>>
> >>>> When enabled, the folio order is determined as such: For a vma, proc=
ess
> >>>> or system that has explicitly disabled THP, we continue to allocate
> >>>> order-0. THP is most likely disabled to avoid any possible internal
> >>>> fragmentation so we honour that request.
> >>>>
> >>>> Otherwise, the return value of arch_wants_pte_order() is used. For v=
mas
> >>>> that have not explicitly opted-in to use transparent hugepages (e.g.
> >>>> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> >>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> >>>> bigger). This allows for a performance boost without requiring any
> >>>> explicit opt-in from the workload while limitting internal
> >>>> fragmentation.
> >>>>
> >>>> If the preferred order can't be used (e.g. because the folio would
> >>>> breach the bounds of the vma, or because ptes in the region are alre=
ady
> >>>> mapped) then we fall back to a suitable lower order; first
> >>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >>>>
> >>>> arch_wants_pte_order() can be overridden by the architecture if desi=
red.
> >>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contig=
uous
> >>>> set of ptes map physically contigious, naturally aligned memory, so =
this
> >>>> mechanism allows the architecture to optimize as required.
> >>>>
> >>>> Here we add the default implementation of arch_wants_pte_order(), us=
ed
> >>>> when the architecture does not define it, which returns -1, implying
> >>>> that the HW has no preference. In this case, mm will choose it's own
> >>>> default order.
> >>>>
> >>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>>> ---
> >>>>  include/linux/pgtable.h |  13 ++++
> >>>>  mm/Kconfig              |  10 +++
> >>>>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++-=
---
> >>>>  3 files changed, 172 insertions(+), 17 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>>> index 5063b482e34f..2a1d83775837 100644
> >>>> --- a/include/linux/pgtable.h
> >>>> +++ b/include/linux/pgtable.h
> >>>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
> >>>>  }
> >>>>  #endif
> >>>>
> >>>> +#ifndef arch_wants_pte_order
> >>>> +/*
> >>>> + * Returns preferred folio order for pte-mapped memory. Must be in =
range [0,
> >>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires=
 large folios
> >>>> + * to be at least order-2. Negative value implies that the HW has n=
o preference
> >>>> + * and mm will choose it's own default order.
> >>>> + */
> >>>> +static inline int arch_wants_pte_order(void)
> >>>> +{
> >>>> +       return -1;
> >>>> +}
> >>>> +#endif
> >>>> +
> >>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >>>>                                        unsigned long address,
> >>>> diff --git a/mm/Kconfig b/mm/Kconfig
> >>>> index 09130434e30d..fa61ea160447 100644
> >>>> --- a/mm/Kconfig
> >>>> +++ b/mm/Kconfig
> >>>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
> >>>>
> >>>>  source "mm/damon/Kconfig"
> >>>>
> >>>> +config LARGE_ANON_FOLIO
> >>>> +       bool "Allocate large folios for anonymous memory"
> >>>> +       depends on TRANSPARENT_HUGEPAGE
> >>>> +       default n
> >>>> +       help
> >>>> +         Use large (bigger than order-0) folios to back anonymous m=
emory where
> >>>> +         possible, even for pte-mapped memory. This reduces the num=
ber of page
> >>>> +         faults, as well as other per-page overheads to improve per=
formance for
> >>>> +         many workloads.
> >>>> +
> >>>>  endmenu
> >>>> diff --git a/mm/memory.c b/mm/memory.c
> >>>> index 01f39e8144ef..64c3f242c49a 100644
> >>>> --- a/mm/memory.c
> >>>> +++ b/mm/memory.c
> >>>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> >>>>         return ret;
> >>>>  }
> >>>>
> >>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_page=
s)
> >>>> +{
> >>>> +       int i;
> >>>> +
> >>>> +       if (nr_pages =3D=3D 1)
> >>>> +               return vmf_pte_changed(vmf);
> >>>> +
> >>>> +       for (i =3D 0; i < nr_pages; i++) {
> >>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> >>>> +                       return true;
> >>>> +       }
> >>>> +
> >>>> +       return false;
> >>>> +}
> >>>> +
> >>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
> >>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> >>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PA=
GE_SHIFT)
> >>>> +
> >>>> +static int anon_folio_order(struct vm_area_struct *vma)
> >>>> +{
> >>>> +       int order;
> >>>> +
> >>>> +       /*
> >>>> +        * If THP is explicitly disabled for either the vma, the pro=
cess or the
> >>>> +        * system, then this is very likely intended to limit intern=
al
> >>>> +        * fragmentation; in this case, don't attempt to allocate a =
large
> >>>> +        * anonymous folio.
> >>>> +        *
> >>>> +        * Else, if the vma is eligible for thp, allocate a large fo=
lio of the
> >>>> +        * size preferred by the arch. Or if the arch requested a ve=
ry small
> >>>> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY=
_ORDER,
> >>>> +        * which still meets the arch's requirements but means we st=
ill take
> >>>> +        * advantage of SW optimizations (e.g. fewer page faults).
> >>>> +        *
> >>>> +        * Finally if thp is enabled but the vma isn't eligible, tak=
e the
> >>>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_=
UNHINTED.
> >>>> +        * This ensures workloads that have not explicitly opted-in =
take benefit
> >>>> +        * while capping the potential for internal fragmentation.
> >>>> +        */
> >>>> +
> >>>> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> >>>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> >>>> +           !hugepage_flags_enabled())
> >>>> +               order =3D 0;
> >>>> +       else {
> >>>> +               order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COS=
TLY_ORDER);
> >>>> +
> >>>> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, t=
rue, true))
> >>>> +                       order =3D min(order, ANON_FOLIO_MAX_ORDER_UN=
HINTED);
> >>>> +       }
> >>>> +
> >>>> +       return order;
> >>>> +}
> >>>> +
> >>>> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **fo=
lio)
> >>>> +{
> >>>> +       int i;
> >>>> +       gfp_t gfp;
> >>>> +       pte_t *pte;
> >>>> +       unsigned long addr;
> >>>> +       struct vm_area_struct *vma =3D vmf->vma;
> >>>> +       int prefer =3D anon_folio_order(vma);
> >>>> +       int orders[] =3D {
> >>>> +               prefer,
> >>>> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY=
_ORDER : 0,
> >>>> +               0,
> >>>> +       };
> >>>> +
> >>>> +       *folio =3D NULL;
> >>>> +
> >>>> +       if (vmf_orig_pte_uffd_wp(vmf))
> >>>> +               goto fallback;
> >>>
> >>> Per the discussion, we need to check hugepage_vma_check() for
> >>> correctness of VM LM. I'd just check it here and fall back to order 0
> >>> if that helper returns false.
> >>
> >> I'm not sure if either you haven't noticed the logic in anon_folio_ord=
er()
> >> above, or whether you are making this suggestion because you disagree =
with the
> >> subtle difference in my logic?
> >
> > The latter, or more generally the policy you described earlier.
> >
> >> My logic is deliberately not calling hugepage_vma_check() because that=
 would
> >> return false for the thp=3Dmadvise,mmap=3Dunhinted case, whereas the p=
olicy I'm
> >> implementing wants to apply LAF in that case.
> >>
> >>
> >> My intended policy:
> >>
> >>                 | never     | madvise   | always
> >> ----------------|-----------|-----------|-----------
> >> no hint         | S         | LAF>S     | THP>LAF>S
> >> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
> >> MADV_NOHUGEPAGE | S         | S         | S
> >>
> >>
> >> What your suggestion would give:
> >>
> >>                 | never     | madvise   | always
> >> ----------------|-----------|-----------|-----------
> >> no hint         | S         | S         | THP>LAF>S
> >> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
> >> MADV_NOHUGEPAGE | S         | S         | S
> >
> > This is not what I'm suggesting.
> >
> > Let me reiterate [1]:
> >   My impression is we only agreed on one thing: at the current stage, w=
e
> >   should respect things we absolutely have to. We didn't agree on what
> >   "never" means ("never 2MB" or "never >4KB"), and we didn't touch on
> >   how "always" should behave at all.
> >
> > And [2]:
> >   (Thanks to David, now I agree that) we have to interpret MADV_NOHUGEP=
AGE
> >   as nothing >4KB.
> >
> > My final take [3]:
> >   I agree these points require more discussion. But I don't think we
> >   need to conclude them now, unless they cause correctness issues like
> >   ignoring MADV_NOHUGEPAGE would.
>
> Thanks, I've read all of these comments previously, and appreciate the ti=
me you
> have put into the feedback. I'm not sure I fully agree with your point th=
at we
> don't need to conclude on a policy now; I certainly don't think we need t=
he
> whole thing in place on day 1, but I do think that whatever we put in sho=
uld
> strive to be a strict subset of where we think we are going. For example,=
 if we
> put something in with one policy (i.e. "never" only means "never 2MB") th=
en find
> a problem and have to change that to be more conservative, are we risking=
 perf
> regressions for any LAF users that started using it on day 1?

It's not that I don't want to -- I just don't think we have enough
information before we have a wider deployment [1] and gain a better
understanding of real-world scenarios.

Of course we could force a conclusion, a mostly opinion-based one. But
it would still involve prolonged discussions and delay this series, or
rush into decisions we might regret later.

[1] Our fleets (servers, laptops and phones) support large-scale
experiments and I plan to run them on both client and server devices.

> > But I should have been clear about the parameters to
> > hugepage_vma_check(): enforce_sysfs=3Dfalse.
>
> So hugepage_vma_check(..., smaps=3Dfalse, in_pf=3Dtrue, enforce_sysfs=3Df=
alse) would
> give us:
>
>                 | prctl/fw  | sysfs     | sysfs     | sysfs
>                 | disable   | never     | madvise   | always
> ----------------|-----------|-----------|-----------|-----------
> no hint         | S         | LAF>S     | LAF>S     | THP>LAF>S
> MADV_HUGEPAGE   | S         | LAF>S     | THP>LAF>S | THP>LAF>S
> MADV_NOHUGEPAGE | S         | S         | S         | S
>
> Where "prctl/fw disable" trumps the sysfs setting.
>
> I can certainly see the benefit of this approach; it gives us a way to en=
able
> LAF while disabling THP (thp=3Dnever). It doesn't give us a way to enable=
 THP
> without enabling LAF though (unless you recompile with LAF disabled). Doe=
s
> anyone see a problem with this?

I do myself :)

This is just something temporary to get this series landed. We are
hiding behind a Kconfig, not making any ABI changes, and not exposing
this policy to userspace (i.e., not updating Documentation/, man
pages, etc.)

Meanwhile, we can keep discussing all the open questions in parallel.
