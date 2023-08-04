Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3D976F868
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjHDDgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHDDf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:35:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8E24495
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 20:35:55 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40a47e8e38dso105661cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 20:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691120154; x=1691724954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sb6r+VGT3TmM7MgKTQFNtqFfnqnNxxPfg5LfA7ZooI=;
        b=VMdu7EnYBlUsEreehBhYfn7bJdRZtpN/7z9eSJ7nrOK+7D71m/16Ejz+CN05lG3f31
         rWyLzpBiNbFnFXBXD68ihHDUJ/kantz1hOauIc8/5T/SgZ+7rvQYNZQGNUNWGo0CbI43
         4ZjqznBO8WaZmCdFHDAG0r+6cIPA8UmPgGCUPiPSVR6Lpfl5NTHmkWtPxXoDp8FW05H3
         mrc0su3pzc2qpIOPbiYu69P5URJAq7gIYvQq/V+eIBfmrOWjTI48Qe1clF+FrgZZ2Huc
         CpMvZfpf+QSqieQbnnS0KOAc5T1Vc5Tii5cftwBdaSUTab7cbC8gW7TdB4JtyEUHzszx
         e8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691120154; x=1691724954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sb6r+VGT3TmM7MgKTQFNtqFfnqnNxxPfg5LfA7ZooI=;
        b=l3KDiRK5OYdD97PEshHSh4nDEZ/QKHzl69KOgWzXnJ/uGyfZbFOtGYzdae55kl3GLU
         oT5TTp8OWuE+VB7WefWJ7kNVMLeZgCEiIjIBKgyVcp22QP7ffKrFrjpeSd2WdA5zl0LA
         te+OBlo75ll5zIobugYHAYOhxKFpLo2un+qjCQkuCo73ARdo2hfEozIc1r4UPrYEaoXK
         0qorW4X/uAVv7AA0f0z53NlCTrICwVsU9KXhUHpMioHXfKlUTf3PHBwo30QS+31NcbE7
         7yis3coCzDP/HpM3aTV7qSwyFA3G2+iH5RyozvLbN6cy1lA2I7Pu1hFPGWq6ntC8fnc9
         4giQ==
X-Gm-Message-State: AOJu0YxSh40sETUf6utSon/kvYA5hCZmQKL1MhCU3H54Zd7wwcgI1776
        gPCjn3IxpLygqex0Y4+6esnYocLjpQwUFnKRKM6NXg==
X-Google-Smtp-Source: AGHT+IFJ1QV7iXowTdRosjlQw57fCZaf06cnVbK6VJ5K0A8byUES61rASuZorUZ6GaJqf+Ejaa8A47vrGV7+TJPzok4=
X-Received: by 2002:ac8:5710:0:b0:3f9:56c:1129 with SMTP id
 16-20020ac85710000000b003f9056c1129mr88588qtw.5.1691120154437; Thu, 03 Aug
 2023 20:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
 <20230803142154.nvgkavg33uyn6f72@box.shutemov.name> <CAOUHufZWTdpF0vdPkyOafVNFOOY7Wui+Q-O83=SZcfv4KZcHbg@mail.gmail.com>
 <44C394AF-A9E1-499F-AE3F-7EAEA03B19DB@nvidia.com>
In-Reply-To: <44C394AF-A9E1-499F-AE3F-7EAEA03B19DB@nvidia.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 3 Aug 2023 21:35:18 -0600
Message-ID: <CAOUHufYm6Lkm4tLRbyKOc3-NYU-8d6ZDMNDWHo=e=E16oasN8A@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Zi Yan <ziy@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
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

On Thu, Aug 3, 2023 at 8:16=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 3 Aug 2023, at 20:19, Yu Zhao wrote:
>
> > On Thu, Aug 3, 2023 at 8:27=E2=80=AFAM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> >>
> >> On Thu, Aug 03, 2023 at 01:43:31PM +0100, Ryan Roberts wrote:
> >>> + Kirill
> >>>
> >>> On 26/07/2023 10:51, Ryan Roberts wrote:
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
> >>>
> >>> ...
> >>>
> >>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> >>>> +           (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_S=
HIFT)
> >>>> +
> >>>> +static int anon_folio_order(struct vm_area_struct *vma)
> >>>> +{
> >>>> +   int order;
> >>>> +
> >>>> +   /*
> >>>> +    * If THP is explicitly disabled for either the vma, the process=
 or the
> >>>> +    * system, then this is very likely intended to limit internal
> >>>> +    * fragmentation; in this case, don't attempt to allocate a larg=
e
> >>>> +    * anonymous folio.
> >>>> +    *
> >>>> +    * Else, if the vma is eligible for thp, allocate a large folio =
of the
> >>>> +    * size preferred by the arch. Or if the arch requested a very s=
mall
> >>>> +    * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORD=
ER,
> >>>> +    * which still meets the arch's requirements but means we still =
take
> >>>> +    * advantage of SW optimizations (e.g. fewer page faults).
> >>>> +    *
> >>>> +    * Finally if thp is enabled but the vma isn't eligible, take th=
e
> >>>> +    * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHI=
NTED.
> >>>> +    * This ensures workloads that have not explicitly opted-in take=
 benefit
> >>>> +    * while capping the potential for internal fragmentation.
> >>>> +    */
> >>>> +
> >>>> +   if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> >>>> +       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> >>>> +       !hugepage_flags_enabled())
> >>>> +           order =3D 0;
> >>>> +   else {
> >>>> +           order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_=
ORDER);
> >>>> +
> >>>> +           if (!hugepage_vma_check(vma, vma->vm_flags, false, true,=
 true))
> >>>> +                   order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHINT=
ED);
> >>>> +   }
> >>>> +
> >>>> +   return order;
> >>>> +}
> >>>
> >>>
> >>> Hi All,
> >>>
> >>> I'm writing up the conclusions that we arrived at during discussion i=
n the THP
> >>> meeting yesterday, regarding linkage with exiting THP ABIs. It would =
be great if
> >>> I can get explicit "agree" or disagree + rationale from at least Davi=
d, Yu and
> >>> Kirill.
> >>>
> >>> In summary; I think we are converging on the approach that is already=
 coded, but
> >>> I'd like confirmation.
> >>>
> >>>
> >>>
> >>> The THP situation today
> >>> -----------------------
> >>>
> >>>  - At system level: THP can be set to "never", "madvise" or "always"
> >>>  - At process level: THP can be "never" or "defer to system setting"
> >>>  - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
> >>>
> >>> That gives us this table to describe how a page fault is handled, acc=
ording to
> >>> process state (columns) and vma flags (rows):
> >>>
> >>>                 | never     | madvise   | always
> >>> ----------------|-----------|-----------|-----------
> >>> no hint         | S         | S         | THP>S
> >>> MADV_HUGEPAGE   | S         | THP>S     | THP>S
> >>> MADV_NOHUGEPAGE | S         | S         | S
> >>>
> >>> Legend:
> >>> S     allocate single page (PTE-mapped)
> >>> LAF   allocate lage anon folio (PTE-mapped)
> >>> THP   allocate THP-sized folio (PMD-mapped)
> >>>>     fallback (usually because vma size/alignment insufficient for fo=
lio)
> >>>
> >>>
> >>>
> >>> Principles for Large Anon Folios (LAF)
> >>> --------------------------------------
> >>>
> >>> David tells us there are use cases today (e.g. qemu live migration) w=
hich use
> >>> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitly =
faulted"
> >>> and these use cases will break (i.e. functionally incorrect) if this =
request is
> >>> not honoured.
> >>>
> >>> So LAF must at least honour MADV_NOHUGEPAGE to prevent breaking exist=
ing use
> >>> cases. And once we do this, then I think the least confusing thing is=
 for it to
> >>> also honor the "never" system/process state; so if either the system,=
 process or
> >>> vma has explicitly opted-out of THP, then LAF should also be bypassed=
.
> >>>
> >>> Similarly, any case that would previously cause the allocation of PMD=
-sized THP
> >>> must continue to be honoured, else we risk performance regression.
> >>>
> >>> That leaves the "madvise/no-hint" case, and all THP fallback paths du=
e to the
> >>> VMA not being correctly aligned or sized to hold a PMD-sized mapping.=
 In these
> >>> cases, we will attempt to use LAF first, and fallback to single page =
if the vma
> >>> size/alignment doesn't permit it.
> >>>
> >>>                 | never     | madvise   | always
> >>> ----------------|-----------|-----------|-----------
> >>> no hint         | S         | LAF>S     | THP>LAF>S
> >>> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
> >>> MADV_NOHUGEPAGE | S         | S         | S
> >>>
> >>> I think this (perhaps conservative) approach will be the least surpri=
sing to
> >>> users. And is the policy that is already implemented in this patch.
> >>
> >> This looks very reasonable.
> >>
> >> The only questionable field is no-hint/madvise. I can argue for both L=
AF>S
> >> and S here. I think LAF>S is fine as long as we are not too aggressive
> >> with allocation order.
> >>
> >> I think we need to work on eliminating reasons for users to set 'never=
'.
> >> If something behaves better with 'never' kernel has failed user.
> >>
> >>> Downsides of this policy
> >>> ------------------------
> >>>
> >>> As Yu and Yin have pointed out, there are some workloads which do not=
 perform
> >>> well with THP, due to large fault latency or memory wastage, etc. But=
 which
> >>> _may_ still benefit from LAF. By taking the conservative approach, we=
 exclude
> >>> these workloads from benefiting automatically.
> >>
> >> Hm. I don't buy it. Why THP with order-9 is too much, but order-8 LAF =
is
> >> fine?
> >
> > No, it's not. And no one said order-8 LAF is fine :) The starting
> > order for LAF that we have been discussing is at most 64KB (vs 2MB
> > THP). For my taste, it's still too large. I'd go with 32KB/16KB.
>
> I guess it is because ARM64 supports contig PTE at 64KB, so getting
> large anon folio at 64KB on ARM64 would have an extra perf boost when
> set contig PTE bits patch is also in.
>
> On x86_64, 32KB might be better on AMD CPUs that support PTE clustering,
> which would use a single TLB entry for 8 contiguous 4KB pages and is
> done at microarchitecture level without additional software changes.
>
> >
> > However, the same argument can be used to argue against the policy
> > Ryan listed above: why order-10 LAF is ok for madvise but not order-11
> > (which becomes "always")?
> >
> > I'm strongly against this policy for two practical reasons I learned
> > from tuning THPs in our data centers:
>
> Do you mind writing down your policy? That would help us see and discuss
> the difference.
>
> > 1. By doing the above, we are blurring the lines between those values
> > and making real-world performance tuning extremely hard if not
> > impractice.
> > 2. As I previously pointed out: if we mix LAFs with THPs, we actually
> > risk causing performance regressions because giving smaller VMAs LAFs
> > can deprive large VMAs of THPs.
>
> I think these two reasons are based on that we do not have a reasonable
> LAF+THP allocation and management policy and we do not fully understand
> the pros and cons of using LAF and mixing LAF with THP. It would be
> safe to separate LAF and THP. By doing so,
>
> 1. for workloads do not benefit from THP, we can turn on LAF alone to
> see if there is a performance boost and further understand if LAF
> hurts, has no impactor , or improves the performance of these workloads.
>
> 2. for workloads benefit from THP, we can also turn on LAF separately
> to understand the performance impact of LAF (hurt, no change, or improve)=
.

This is basically what I've been suggesting. We should have a separate
knob, not overload the existing ones. And this separate knob should be
able to take a list of fallback orders. After we have a wider
deployment, we might gain a better understanding of the "cost
function". Then we can try to build some in-kernel heuristics that
automatically decides the best orders to fallback. If/when we get
there, we can simply extend the knob by adding a new "magic word",
e.g., "auto".

> Ultimately, after we understand the performance impact of LAF, THP, and
> mix of them and come up a reasonable kernel policy, a unified knob would
> make sense. But we are not there yet.

Exactly.
