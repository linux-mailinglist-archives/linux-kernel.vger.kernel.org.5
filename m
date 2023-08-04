Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2368D770AE4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjHDV22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjHDV2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:28:00 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E0059DC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:27:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-407db3e9669so24911cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691184422; x=1691789222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWf8rRai4mrTAzPCSGbCcKN1S49JsOfOa1ZWdLYbbso=;
        b=UHeYHHtgL4DHjNKU5KYfSYeDDq1ktme8Al2AkyG/XqmS/ft1l0QZzRy1SKtlCypYdh
         OYAz7oevflI5KGZlVezUXn/KsN7LeVHDVpoOByXxIOpoWN/QbI9l+00X6oLlyLM4DOnX
         91bzf4XMtghkb5PYunfu7QfrUdlO8QBr0j6oIYYPwEQ/OuQITZD6NuBBniVeQDhosxFB
         WI8dLS0C5cFUaEzc4f953flKAjnibnDfIO6lbq+/zMXXgSt5A/9Ye8TUHShelIqW6X17
         3p5YqHrCAZWj5onMFoWPxI8DnmPxCPVd8TVYVtefuCkFf7srvMSIYT+jdukZ6kWKl9pb
         8qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691184422; x=1691789222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWf8rRai4mrTAzPCSGbCcKN1S49JsOfOa1ZWdLYbbso=;
        b=J9BkBcp1ErGd3n+l43aPOJcSZWKOoTYLOjkZlxeI8CyI8o3z0090oAoKv9mFbxMdSB
         NLhZGP4HKcSqdVDKdl5a8E8Sv+s+F3bHrB/s9hNv1CEQPK5Qfq8oAbxB38cJfb4v9n5F
         1A7CGfDKkdovJdyko7z8Lmtb5mRzyV83dT4ZR8sbLiAQtqx/gaNzXmsG+Cua22/lAEbY
         VM8dm/qfnit29U38+LIn9W1x3vjAtAPXQ0FVOu19C4GWR0uNLcW0oyMU5xEoRYfUUR8w
         Qsgf5yUBG2dtcpH2fi0jTHE0YBDW0HMVt9jjTOLfwWkhN6iv0g2Lx2gXV4CdSjagXb9n
         HEsw==
X-Gm-Message-State: AOJu0Yzk36dS+uuu6dbOc+f6t++pvATKpG8FgBdk9WxhtmIZQcg0eNKF
        kAWrDtIM+XFqGXO+WtSc3ytWQIfTQH6XRGZ8fl3mVQ==
X-Google-Smtp-Source: AGHT+IFgLCsrbUVA4Wc7YNvxYe4rbXxVs7tCCqBaQf9MzTKJw9IlqnXLy9nWlPorISL0WbRETk0hrX4M52db6inWFv8=
X-Received: by 2002:a05:622a:1c1:b0:3f8:8c06:c53b with SMTP id
 t1-20020a05622a01c100b003f88c06c53bmr103288qtw.0.1691184421832; Fri, 04 Aug
 2023 14:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com> <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
 <CAOUHufaHH3Ctu3JRHSbmebHJ7XPnBEWTQ4mwOo+MGXU9yKvwbA@mail.gmail.com>
 <5e595904-3dca-0e15-0769-7ed10975fd0d@arm.com> <b936041c-08a7-e844-19e7-eafc4ddf63b9@redhat.com>
 <CAOUHufafd4GNna2GKdSyQdW6CLVh0gxhNgeOc6t+ZOphwgw7tw@mail.gmail.com> <259ad8fc-c12b-69b9-ba16-adb9e3e6d672@redhat.com>
In-Reply-To: <259ad8fc-c12b-69b9-ba16-adb9e3e6d672@redhat.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 4 Aug 2023 15:26:25 -0600
Message-ID: <CAOUHufbbrDrSv2Ak0tyyaw7qrekkQ-p2vjCqWsXFG7b-+EP=5g@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     David Hildenbrand <david@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 3:13=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.08.23 23:00, Yu Zhao wrote:
> > On Fri, Aug 4, 2023 at 2:23=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >> On 04.08.23 10:27, Ryan Roberts wrote:
> >>> On 04/08/2023 00:50, Yu Zhao wrote:
> >>>> On Thu, Aug 3, 2023 at 6:43=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>>
> >>>>> + Kirill
> >>>>>
> >>>>> On 26/07/2023 10:51, Ryan Roberts wrote:
> >>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory =
to be
> >>>>>> allocated in large folios of a determined order. All pages of the =
large
> >>>>>> folio are pte-mapped during the same page fault, significantly red=
ucing
> >>>>>> the number of page faults. The number of per-page operations (e.g.=
 ref
> >>>>>> counting, rmap management lru list management) are also significan=
tly
> >>>>>> reduced since those ops now become per-folio.
> >>>>>>
> >>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfi=
g,
> >>>>>> which defaults to disabled for now; The long term aim is for this =
to
> >>>>>> defaut to enabled, but there are some risks around internal
> >>>>>> fragmentation that need to be better understood first.
> >>>>>>
> >>>>>> When enabled, the folio order is determined as such: For a vma, pr=
ocess
> >>>>>> or system that has explicitly disabled THP, we continue to allocat=
e
> >>>>>> order-0. THP is most likely disabled to avoid any possible interna=
l
> >>>>>> fragmentation so we honour that request.
> >>>>>>
> >>>>>> Otherwise, the return value of arch_wants_pte_order() is used. For=
 vmas
> >>>>>> that have not explicitly opted-in to use transparent hugepages (e.=
g.
> >>>>>> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> >>>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever =
is
> >>>>>> bigger). This allows for a performance boost without requiring any
> >>>>>> explicit opt-in from the workload while limitting internal
> >>>>>> fragmentation.
> >>>>>>
> >>>>>> If the preferred order can't be used (e.g. because the folio would
> >>>>>> breach the bounds of the vma, or because ptes in the region are al=
ready
> >>>>>> mapped) then we fall back to a suitable lower order; first
> >>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> >>>>>>
> >>>>>
> >>>>> ...
> >>>>>
> >>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> >>>>>> +             (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PA=
GE_SHIFT)
> >>>>>> +
> >>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
> >>>>>> +{
> >>>>>> +     int order;
> >>>>>> +
> >>>>>> +     /*
> >>>>>> +      * If THP is explicitly disabled for either the vma, the pro=
cess or the
> >>>>>> +      * system, then this is very likely intended to limit intern=
al
> >>>>>> +      * fragmentation; in this case, don't attempt to allocate a =
large
> >>>>>> +      * anonymous folio.
> >>>>>> +      *
> >>>>>> +      * Else, if the vma is eligible for thp, allocate a large fo=
lio of the
> >>>>>> +      * size preferred by the arch. Or if the arch requested a ve=
ry small
> >>>>>> +      * size or didn't request a size, then use PAGE_ALLOC_COSTLY=
_ORDER,
> >>>>>> +      * which still meets the arch's requirements but means we st=
ill take
> >>>>>> +      * advantage of SW optimizations (e.g. fewer page faults).
> >>>>>> +      *
> >>>>>> +      * Finally if thp is enabled but the vma isn't eligible, tak=
e the
> >>>>>> +      * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_=
UNHINTED.
> >>>>>> +      * This ensures workloads that have not explicitly opted-in =
take benefit
> >>>>>> +      * while capping the potential for internal fragmentation.
> >>>>>> +      */
> >>>>>> +
> >>>>>> +     if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> >>>>>> +         test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> >>>>>> +         !hugepage_flags_enabled())
> >>>>>> +             order =3D 0;
> >>>>>> +     else {
> >>>>>> +             order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COS=
TLY_ORDER);
> >>>>>> +
> >>>>>> +             if (!hugepage_vma_check(vma, vma->vm_flags, false, t=
rue, true))
> >>>>>> +                     order =3D min(order, ANON_FOLIO_MAX_ORDER_UN=
HINTED);
> >>>>>> +     }
> >>>>>> +
> >>>>>> +     return order;
> >>>>>> +}
> >>>>>
> >>>>>
> >>>>> Hi All,
> >>>>>
> >>>>> I'm writing up the conclusions that we arrived at during discussion=
 in the THP
> >>>>> meeting yesterday, regarding linkage with exiting THP ABIs. It woul=
d be great if
> >>>>> I can get explicit "agree" or disagree + rationale from at least Da=
vid, Yu and
> >>>>> Kirill.
> >>>>>
> >>>>> In summary; I think we are converging on the approach that is alrea=
dy coded, but
> >>>>> I'd like confirmation.
> >>>>>
> >>>>>
> >>>>>
> >>>>> The THP situation today
> >>>>> -----------------------
> >>>>>
> >>>>>    - At system level: THP can be set to "never", "madvise" or "alwa=
ys"
> >>>>>    - At process level: THP can be "never" or "defer to system setti=
ng"
> >>>>>    - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
> >>>>>
> >>>>> That gives us this table to describe how a page fault is handled, a=
ccording to
> >>>>> process state (columns) and vma flags (rows):
> >>>>>
> >>>>>                   | never     | madvise   | always
> >>>>> ----------------|-----------|-----------|-----------
> >>>>> no hint         | S         | S         | THP>S
> >>>>> MADV_HUGEPAGE   | S         | THP>S     | THP>S
> >>>>> MADV_NOHUGEPAGE | S         | S         | S
> >>>>>
> >>>>> Legend:
> >>>>> S       allocate single page (PTE-mapped)
> >>>>> LAF     allocate lage anon folio (PTE-mapped)
> >>>>> THP     allocate THP-sized folio (PMD-mapped)
> >>>>>>         fallback (usually because vma size/alignment insufficient =
for folio)
> >>>>>
> >>>>>
> >>>>>
> >>>>> Principles for Large Anon Folios (LAF)
> >>>>> --------------------------------------
> >>>>>
> >>>>> David tells us there are use cases today (e.g. qemu live migration)=
 which use
> >>>>> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitl=
y faulted"
> >>>>> and these use cases will break (i.e. functionally incorrect) if thi=
s request is
> >>>>> not honoured.
> >>>>
> >>>> I don't remember David saying this. I think he was referring to UFFD=
,
> >>>> not MADV_NOHUGEPAGE, when discussing what we need to absolutely
> >>>> respect.
> >>>
> >>> My understanding was that MADV_NOHUGEPAGE was being applied to region=
s *before*
> >>> UFFD was being registered, and the app relied on MADV_NOHUGEPAGE to n=
ot back any
> >>> unfaulted pages. It's not completely clear to me how not honouring
> >>> MADV_NOHUGEPAGE would break things though. David?
> >>
> >> Sorry, I'm still lagging behind on some threads.
> >>
> >> Imagine the following for VM postcopy live migration:
> >>
> >> (1) Set MADV_NOHUGEPAGE on guest memory and discard all memory (e.g.,
> >>       MADV_DONTNEED), to start with a clean slate.
> >> (2) Migrates some pages during precopy from the source and stores them
> >>       into guest memory on the destination. Some of the memory locatio=
ns
> >>       will have pages populated.
> >> (3) At some point, decide to enable postcopy: enable userfaultfd on
> >>       guest memory.
> >> (4) Discard *selected* pages again that have been dirtied in the
> >>       meantime on the source. These are pages that have been migrated
> >>       previously.
> >> (5) Start running the VM on the destination.
> >> (6) Anything that's not populated will trigger userfaultfd missing
> >>       faults. Then, you can request them from the source and place the=
m.
> >>
> >> Assume you would populate more than required during 2), you can end up
> >> not getting userfaultfd faults during 4) and corrupt your guest state.
> >> It works if during (2) you migrated all guest memory, or if during 4)
> >> you zap everything that still needs migr
> >
> > I see what you mean now. Thanks.
> >
> > Yes, in this case we have to interpret MADV_NOHUGEPAGE as nothing >4KB.
>
> Note that it's still even unclear to me why we want to *not* call these
> things THP. It would certainly make everything less confusing if we call
> them THP, but with additional attributes.
>
> I think that is one of the first things we should figure out because it
> also indirectly tells us what all these toggles mean and how/if we
> should redefine them (and if they even apply).
>
> Currently THP =3D=3D PMD size
>
> In 2016, Hugh already envisioned PUD/PGD THP (see 49920d28781d ("mm:
> make transparent hugepage size public")) when he explicitly exposed
> "hpage_pmd_size". Not "hpage_size".
>
> For hugetlb on arm64 we already support various sizes that are < PMD
> size and *not* call them differently. It's a huge(tlb) page. Sometimes
> we refer to them as cont-PTE hugetlb pages.
>
>
> So, nowadays we do have "PMD-sized THP", someday we might have
> "PUD-sized THP". Can't we come up with a name to describe sub-PMD THP?
>
> Is it really of value if we invent a new term for them? Yes, I was not
> enjoying "Flexible THP".
>
>
> Once we figured that out, we should figure out if MADV_HUGEPAGE meant
> "only PMD-sized THP" or anything else?
>
> Also, we can then figure out if MADV_NOHUGEPAGE meant "only PMD-sized
> THP" or anything else?
>
>
> The simplest approach to me would be "they imply any THP, and once we
> need more tunables we might add some", similar to what Kirill also raised=
.
>
>
> Again, it's all unclear to me at this point and I'm happy to hear
> opinions, because I really don't know.

I agree these points require more discussion. But I don't think we
need to conclude them now, unless they cause correctness issues like
ignoring MADV_NOHUGEPAGE would. My concern is that if we decide to go
with "they imply any THP" and *expose this to userspace now*, we might
regret later.

Also that "Flexible THP" Kconfig is just a placeholder, from my POV.
It should be removed after we nail down the runtime ABI, which again
IMO, isn't now.
