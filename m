Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C468C76A942
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjHAGhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjHAGhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:37:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAF598
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:37:34 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4036bd4fff1so204631cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690871853; x=1691476653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6G7LTo6Jy6hFiV6lyYTVAm0bxxAsoeI0s9A13CP74E=;
        b=LZjQFu+TYG3xdnj6BFJo7O/00XTHa4nge1XmDZTQFVLMP3ZxDs2eyuCTSMfq44rOn+
         f40LfsyfcszikQvWahT6EI5+xlJHYCHyZ0HVld5sFkYV57bl7z2wi02DbrtCY//i/Uzm
         M6vfVTiEJ72f7EauT+6QUNB+Jzj+6C6rt+RrE6rFtySQP5mXtzeIE0xrphcA5pCCXSP1
         vYyhvmkvowvFUOCi91zYmAiVTues0I8mF7QH4jGE6z0e+DzIwJUmsi/IpzlybI41vnP+
         C5gcgudlm3F2+Rl4lOH0Dnyz10k4bZq72Gg6ta7RCbNociG/+uFyopj9x00cpfW2cZxl
         boSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690871853; x=1691476653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6G7LTo6Jy6hFiV6lyYTVAm0bxxAsoeI0s9A13CP74E=;
        b=YW/tGfNrnLJs5jSn1sOZ5vPGWvaGCQqUj0VyjrLHQ2YoS//bX9bJihHJW/UDrM5SVP
         tU7EdsVlzBH9XXh/tX4eu8vJuoWmKFCVq+urOC4BEI2pvsgPNPYkLcl6ZNa3whFyKVh2
         K5/9DdbqPCt/D2nFdg+FDyjW+B4TNVSql/4Zy+Am2XUbXQenNP6WV+PSJTVrxZ4iQ3nJ
         sGgvnG0scf+lxXh07LzPgsUvERJOAVlKjXTZAS16N6jcF1nywDXllSHjmajiLOxLghZT
         ZfjQ2zyIBht7ZNokN2mH6o3N8QSX8pWNljcB8l1Lc10GaI5tQdaZwbEx7hh4Rzo6wNwJ
         +t1g==
X-Gm-Message-State: ABy/qLa2o8BwChbEGB5DH5Y/3lFnIixiDTtvi8nUn6iei4uMxMtTIFQB
        UrO6J93Txrfe59+O3AR2tULOpws6ETZcBgIHR0hz0Q==
X-Google-Smtp-Source: APBJJlEjMxg0exWWA5GbAxROh93Oa0Jmjehhhbrn2Uqd54sCxiv3croFAe8UpWSXjs9LupgY63bEIQj3udPJ94hG7OQ=
X-Received: by 2002:a05:622a:1827:b0:403:eeb9:a76 with SMTP id
 t39-20020a05622a182700b00403eeb90a76mr616556qtc.17.1690871853477; Mon, 31 Jul
 2023 23:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
 <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com> <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
In-Reply-To: <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 1 Aug 2023 00:36:57 -0600
Message-ID: <CAOUHufb8D-8qOhB55WhHgX5dOgrPcrpOZhiA7q9JMi=w6cqEoA@mail.gmail.com>
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

On Fri, Jul 28, 2023 at 4:13=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/07/2023 05:31, Yu Zhao wrote:
> > On Wed, Jul 26, 2023 at 10:41=E2=80=AFAM Yu Zhao <yuzhao@google.com> wr=
ote:
> >>
> >> On Wed, Jul 26, 2023 at 3:52=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>>
> >>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to =
be
> >>> allocated in large folios of a determined order. All pages of the lar=
ge
> >>> folio are pte-mapped during the same page fault, significantly reduci=
ng
> >>> the number of page faults. The number of per-page operations (e.g. re=
f
> >>> counting, rmap management lru list management) are also significantly
> >>> reduced since those ops now become per-folio.
> >>>
> >>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> >>> which defaults to disabled for now; The long term aim is for this to
> >>> defaut to enabled, but there are some risks around internal
> >>> fragmentation that need to be better understood first.
> >>>
> >>> When enabled, the folio order is determined as such: For a vma, proce=
ss
> >>> or system that has explicitly disabled THP, we continue to allocate
> >>> order-0. THP is most likely disabled to avoid any possible internal
> >>> fragmentation so we honour that request.
> >>>
> >>> Otherwise, the return value of arch_wants_pte_order() is used. For vm=
as
> >>> that have not explicitly opted-in to use transparent hugepages (e.g.
> >>> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> >>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> >>> bigger). This allows for a performance boost without requiring any
> >>> explicit opt-in from the workload while limitting internal
> >>> fragmentation.
> >>>
> >>> If the preferred order can't be used (e.g. because the folio would
> >>> breach the bounds of the vma, or because ptes in the region are alrea=
dy
> >>> mapped) then we fall back to a suitable lower order; first
> >>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >>>
> >>> arch_wants_pte_order() can be overridden by the architecture if desir=
ed.
> >>> Some architectures (e.g. arm64) can coalsece TLB entries if a contigu=
ous
> >>> set of ptes map physically contigious, naturally aligned memory, so t=
his
> >>> mechanism allows the architecture to optimize as required.
> >>>
> >>> Here we add the default implementation of arch_wants_pte_order(), use=
d
> >>> when the architecture does not define it, which returns -1, implying
> >>> that the HW has no preference. In this case, mm will choose it's own
> >>> default order.
> >>>
> >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >>> ---
> >>>  include/linux/pgtable.h |  13 ++++
> >>>  mm/Kconfig              |  10 +++
> >>>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++--=
--
> >>>  3 files changed, 172 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> >>> index 5063b482e34f..2a1d83775837 100644
> >>> --- a/include/linux/pgtable.h
> >>> +++ b/include/linux/pgtable.h
> >>> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
> >>>  }
> >>>  #endif
> >>>
> >>> +#ifndef arch_wants_pte_order
> >>> +/*
> >>> + * Returns preferred folio order for pte-mapped memory. Must be in r=
ange [0,
> >>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires =
large folios
> >>> + * to be at least order-2. Negative value implies that the HW has no=
 preference
> >>> + * and mm will choose it's own default order.
> >>> + */
> >>> +static inline int arch_wants_pte_order(void)
> >>> +{
> >>> +       return -1;
> >>> +}
> >>> +#endif
> >>> +
> >>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >>>                                        unsigned long address,
> >>> diff --git a/mm/Kconfig b/mm/Kconfig
> >>> index 09130434e30d..fa61ea160447 100644
> >>> --- a/mm/Kconfig
> >>> +++ b/mm/Kconfig
> >>> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
> >>>
> >>>  source "mm/damon/Kconfig"
> >>>
> >>> +config LARGE_ANON_FOLIO
> >>> +       bool "Allocate large folios for anonymous memory"
> >>> +       depends on TRANSPARENT_HUGEPAGE
> >>> +       default n
> >>> +       help
> >>> +         Use large (bigger than order-0) folios to back anonymous me=
mory where
> >>> +         possible, even for pte-mapped memory. This reduces the numb=
er of page
> >>> +         faults, as well as other per-page overheads to improve perf=
ormance for
> >>> +         many workloads.
> >>> +
> >>>  endmenu
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 01f39e8144ef..64c3f242c49a 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>         return ret;
> >>>  }
> >>>
> >>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages=
)
> >>> +{
> >>> +       int i;
> >>> +
> >>> +       if (nr_pages =3D=3D 1)
> >>> +               return vmf_pte_changed(vmf);
> >>> +
> >>> +       for (i =3D 0; i < nr_pages; i++) {
> >>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> >>> +                       return true;
> >>> +       }
> >>> +
> >>> +       return false;
> >>> +}
> >>> +
> >>> +#ifdef CONFIG_LARGE_ANON_FOLIO
> >>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> >>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAG=
E_SHIFT)
> >>> +
> >>> +static int anon_folio_order(struct vm_area_struct *vma)
> >>> +{
> >>> +       int order;
> >>> +
> >>> +       /*
> >>> +        * If THP is explicitly disabled for either the vma, the proc=
ess or the
> >>> +        * system, then this is very likely intended to limit interna=
l
> >>> +        * fragmentation; in this case, don't attempt to allocate a l=
arge
> >>> +        * anonymous folio.
> >>> +        *
> >>> +        * Else, if the vma is eligible for thp, allocate a large fol=
io of the
> >>> +        * size preferred by the arch. Or if the arch requested a ver=
y small
> >>> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_=
ORDER,
> >>> +        * which still meets the arch's requirements but means we sti=
ll take
> >>> +        * advantage of SW optimizations (e.g. fewer page faults).
> >>> +        *
> >>> +        * Finally if thp is enabled but the vma isn't eligible, take=
 the
> >>> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_U=
NHINTED.
> >>> +        * This ensures workloads that have not explicitly opted-in t=
ake benefit
> >>> +        * while capping the potential for internal fragmentation.
> >>> +        */
> >>
> >> What empirical evidence is SZ_64K based on?
> >> What workloads would benefit from it?
> >> How much would they benefit from it?
> >> Would they benefit more or less from different values?
> >> How much internal fragmentation would it cause?
> >> What cost function was used to arrive at the conclusion that its
> >> benefits outweigh its costs?
>
> Sorry this has taken a little while to reply to; I've been re-running my =
perf
> tests with the modern patches to recomfirm old data.

Thanks for the data!

> In terms of empirical evidence, I've run the kernel compilation benchmark=
 (yes I
> know its a narrow use case, but I figure some data is better than no data=
), for
> all values of ANON_FOLIO_MAX_ORDER_UNHINTED {4k, 16k, 32k, 64k, 128k, 256=
k}.
>
> I've run each test 15 times across 5 system reboots on Ampere Altra (arm6=
4),

What about x86 and ppc? Do we expect they might perform similarly wrt
different page sizes?

> with the kernel configured for 4K base pages - I could rerun for other ba=
se page
> sizes if we want to go further down this route.
>
> I've captured run time and peak memory usage, and taken the mean. The std=
ev for
> the peak memory usage is big-ish, but I'm confident this still captures t=
he
> central tendancy well:
>
> | MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak mem=
ory |
> |:-------------------|------------:|------------:|------------:|:--------=
----|
> | 4k                 |        0.0% |        0.0% |        0.0% |        0=
.0% |
> | 16k                |       -3.6% |      -26.5% |       -0.5% |       -0=
.1% |
> | 32k                |       -4.8% |      -37.4% |       -0.6% |       -0=
.1% |
> | 64k                |       -5.7% |      -42.0% |       -0.6% |       -1=
.1% |
> | 128k               |       -5.6% |      -42.1% |       -0.7% |        1=
.4% |
> | 256k               |       -4.9% |      -41.9% |       -0.4% |        1=
.9% |
>
> 64K looks like the clear sweet spot to me.

Were the tests done under memory pressure? I agree 64KB might be a
reasonable value, but I don't think we can or need to make a
conclusion at this point: there are still pending questions from my
list.

Just to double check: we only need ANON_FOLIO_MAX_ORDER_UNHINTED
because of hugepage_vma_check(), is it correct?

> I know you have argued for using a page order in the past, rather than a =
size in
> bytes. But my argument is that user space is mostly doing mmaps based on =
sizes
> independent of the base page size (an assumption!) and a system's memory =
is
> obviously a fixed quantity that doesn't it doesn't change with base page =
size.
> So it feels more natural to limit internal fragmentation based on an abso=
lute
> size rather than a quantity of pages. Kyril have also suggested using abs=
olute
> sizes in the past [1].
>
> It's also worth mentioning that the file-backed memory "fault_around" mec=
hanism
> chooses 64K.

This example actually is against your argument:
1. There have been multiple reports that fault around hurt
performances and had to be disabled for some workloads over the years
-- ANON_FOLIO_MAX_ORDER_UNHINTED is likely to cause regressions too.
2. Not only can fault around be disabled, its default value can be
changed too -- this series can't do either.
3. Most importantly, fault around does not do high-order allocations
-- this series does, and high-order allocations can be very difficult
under memory pressure.

> If this approach really looks unacceptable, I have a couple of other idea=
s. But
> I personally favour the approach that is already in the patch.

I understand. If the answer to my question above is yes, then let's
take a step back and figure out whether overloading existing ABIs is
acceptable or not. Does this sound good to you?

> 1) Add a large/small flag to arch_wants_pte_order(). arm64, at least, act=
ually
> has 2 mechanisms, HPA and contpte. Currently arm64 is always returning th=
e
> contpte order, but with a flag, it could return contpte order for large, =
and HPA
> order for small. (I know we previously passed the vma and we didn't like =
that,
> and this is pretty similar). I still think the SW (core-mm) needs a way t=
o
> sensibly limit internal fragmentation though, so personally I still think=
 having
> an upper limit in this case is useful.
>
> 2) More radical: move to a per-vma auto-tuning solution, which looks at t=
he
> fault pattern and maintains an allocation order in the VMA, which is modi=
fied
> based on fault pattern. e.g. When we get faults that occur immediately ad=
jacent
> to the allocated range, we increase; when we get faults not connected to
> previously allocated pages we decrease. I think it's an interesting thing=
 to
> look at, but certainly prefer that it's not part of an MVP implementation=
.
>
> [1]
> https://lore.kernel.org/linux-mm/20230414140948.7pcaz6niyr2tpa7s@box.shut=
emov.name/
>
>
> >>
> >>> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> >>> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> >>> +           !hugepage_flags_enabled())
> >>> +               order =3D 0;
> >>> +       else {
> >>> +               order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COST=
LY_ORDER);
> >>> +
> >>> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, tr=
ue, true))
> >>> +                       order =3D min(order, ANON_FOLIO_MAX_ORDER_UNH=
INTED);
> >>> +       }
> >
> > I'm a bit surprised to see the above: why can we overload existing
> > ABIs? I don't think we can.
>
> I think this is all covered by the conversation with David against v2; se=
e [2]
> and proceeding replies. Argument is that VM_NOHUGEPAGE (and friends) is r=
eally a
> request from user space to optimize for the least memory wastage possible=
 and
> avoid populating ptes that have not been expressly requested.
>
> [2]
> https://lore.kernel.org/linux-mm/524bacd2-4a47-2b8b-6685-c46e31a01631@red=
hat.com/

Thanks for the info.

I think there might be a misunderstanding here.

David, can you please clarify whether you suggested we overland
(change the semantics) of existing ABIs?

This sounds like a big red flag to me. If that's really what you
suggest, can you shed some light on why this is acceptable to existing
userspace at all?

Thanks.
