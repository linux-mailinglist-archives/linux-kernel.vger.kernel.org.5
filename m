Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D587FD78A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjK2NJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjK2NJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:09:27 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8F85
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:09:33 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77dd0083952so15997185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701263372; x=1701868172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y10J/9zYEjEyBiZAaESmKxbLwL8fkxtF8vWnrHEiO4=;
        b=BTbcdlLHAd8g44V4PRxMFCjb/eirSncYYEMMnWJE9JKMMtQiZiuuZv959+UlwPQv9t
         AKBkPUhnXpTiJkueqPWdDM6SImYXe74xPEwKJTQRxyz2g+BMpgEX7JcnclDWJuGDk5Hn
         p+CokwwzpQOfeHZAHbsJwQFJ38yZAOWQlsgr6TUvsP3ivb8J0zu2528LqWXN1k1cqsbS
         TkWjMXGyE7RjQlevoimf+ZUs1Y+dKGrKpQXAhY0okhLwWXkYaSmHM0pAq78hd7c8Fv7I
         0hucC4lhSaXAwrnsJiyN4tra/oMFavhloggC2fzI6A87No9lBGNk2aG4VcNHW8rRFDeN
         NuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701263372; x=1701868172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y10J/9zYEjEyBiZAaESmKxbLwL8fkxtF8vWnrHEiO4=;
        b=Km2xPHbriCE7pjSsX83y4a+E5pJ8h7gbvH6UwJvKP3bCcomcJERdxAZkQhTXZYuZbb
         vvKEpvY3VF4oh2UccJ1v1mCI6I0pXqDcwZP74P58LuwtVugLXtu3OEtp4r+e3kfFKDpP
         5vuaWvB2eq1rnCapEGpcAVURiskLt/ev7x+m/coVH3co29gLwppsXuLJeiOZOMGWraPf
         h7c63YVqfnBoJ/AvDYpeKRmWX6arsBXdOIRDPEmV23YbWm25iL1yJrSXzItaPDV9JlgH
         ZIpaoebHKOflzVUTbByIavutzGJ9HWKB9h8lvL9U/lC5eyjE+sOmhf1i3kokA08lWHef
         tDPw==
X-Gm-Message-State: AOJu0Yxv8KTs5Y/S8eBKoboBaSSpKsehrgh5HXJhnqsTs/2f4c+AWxMu
        0PcXEB+6ufVnOWrYbmokRMgR5msLY1mTWcnjyX0=
X-Google-Smtp-Source: AGHT+IHmc0Y7Fdbxld0C734emUMFww8krGOJ/BdlzPjHichFFshGVV+mABB1lQIdlYam/vTDnGOs9JayhmgMk4WO1hw=
X-Received: by 2002:a0c:f808:0:b0:66d:1fcf:e1c9 with SMTP id
 r8-20020a0cf808000000b0066d1fcfe1c9mr21238118qvn.35.1701263372615; Wed, 29
 Nov 2023 05:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-2-ryan.roberts@arm.com>
 <20231127055414.9015-1-v-songbaohua@oppo.com> <755343a1-ce94-4d38-8317-0925e2dae3bc@arm.com>
 <CAGsJ_4z_ftxvG-EcTe=X+Te8fNSShhVHHPvbEgAa1rQXgO5XCA@mail.gmail.com>
 <a43d8da8-d902-440c-aa64-df78fa4e185d@arm.com> <CAGsJ_4w9E_90Bs9kWP1HWmKsknszw2i=Vtarj0UGD80yNpt5mw@mail.gmail.com>
 <02d85331-eaa0-4d76-a3d6-ea5eb18b683c@arm.com>
In-Reply-To: <02d85331-eaa0-4d76-a3d6-ea5eb18b683c@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 30 Nov 2023 02:09:20 +1300
Message-ID: <CAGsJ_4zDZb93bKMmhRn_V3a_PR11xKkaYkdxZW2ZsO6zNNj0Kw@mail.gmail.com>
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, david@redhat.com, dvyukov@google.com,
        glider@google.com, james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
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

On Thu, Nov 30, 2023 at 1:29=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 28/11/2023 19:00, Barry Song wrote:
> > On Wed, Nov 29, 2023 at 12:00=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> On 28/11/2023 00:11, Barry Song wrote:
> >>> On Mon, Nov 27, 2023 at 10:24=E2=80=AFPM Ryan Roberts <ryan.roberts@a=
rm.com> wrote:
> >>>>
> >>>> On 27/11/2023 05:54, Barry Song wrote:
> >>>>>> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_=
struct *src_vma,
> >>>>>> +              pte_t *dst_pte, pte_t *src_pte,
> >>>>>> +              unsigned long addr, unsigned long end,
> >>>>>> +              int *rss, struct folio **prealloc)
> >>>>>>  {
> >>>>>>      struct mm_struct *src_mm =3D src_vma->vm_mm;
> >>>>>>      unsigned long vm_flags =3D src_vma->vm_flags;
> >>>>>>      pte_t pte =3D ptep_get(src_pte);
> >>>>>>      struct page *page;
> >>>>>>      struct folio *folio;
> >>>>>> +    int nr =3D 1;
> >>>>>> +    bool anon;
> >>>>>> +    bool any_dirty =3D pte_dirty(pte);
> >>>>>> +    int i;
> >>>>>>
> >>>>>>      page =3D vm_normal_page(src_vma, addr, pte);
> >>>>>> -    if (page)
> >>>>>> +    if (page) {
> >>>>>>              folio =3D page_folio(page);
> >>>>>> -    if (page && folio_test_anon(folio)) {
> >>>>>> -            /*
> >>>>>> -             * If this page may have been pinned by the parent pr=
ocess,
> >>>>>> -             * copy the page immediately for the child so that we=
'll always
> >>>>>> -             * guarantee the pinned page won't be randomly replac=
ed in the
> >>>>>> -             * future.
> >>>>>> -             */
> >>>>>> -            folio_get(folio);
> >>>>>> -            if (unlikely(page_try_dup_anon_rmap(page, false, src_=
vma))) {
> >>>>>> -                    /* Page may be pinned, we have to copy. */
> >>>>>> -                    folio_put(folio);
> >>>>>> -                    return copy_present_page(dst_vma, src_vma, ds=
t_pte, src_pte,
> >>>>>> -                                             addr, rss, prealloc,=
 page);
> >>>>>> +            anon =3D folio_test_anon(folio);
> >>>>>> +            nr =3D folio_nr_pages_cont_mapped(folio, page, src_pt=
e, addr,
> >>>>>> +                                            end, pte, &any_dirty)=
;
> >>>>>
> >>>>> in case we have a large folio with 16 CONTPTE basepages, and usersp=
ace
> >>>>> do madvise(addr + 4KB * 5, DONTNEED);
> >>>>
> >>>> nit: if you are offsetting by 5 pages from addr, then below I think =
you mean
> >>>> page0~page4 and page6~15?
> >>>>
> >>>>>
> >>>>> thus, the 4th basepage of PTE becomes PTE_NONE and folio_nr_pages_c=
ont_mapped()
> >>>>> will return 15. in this case, we should copy page0~page3 and page5~=
page15.
> >>>>
> >>>> No I don't think folio_nr_pages_cont_mapped() will return 15; that's=
 certainly
> >>>> not how its intended to work. The function is scanning forwards from=
 the current
> >>>> pte until it finds the first pte that does not fit in the batch - ei=
ther because
> >>>> it maps a PFN that is not contiguous, or because the permissions are=
 different
> >>>> (although this is being relaxed a bit; see conversation with DavidH =
against this
> >>>> same patch).
> >>>>
> >>>> So the first time through this loop, folio_nr_pages_cont_mapped() wi=
ll return 5,
> >>>> (page0~page4) then the next time through the loop we will go through=
 the
> >>>> !present path and process the single swap marker. Then the 3rd time =
through the
> >>>> loop folio_nr_pages_cont_mapped() will return 10.
> >>>
> >>> one case we have met by running hundreds of real phones is as below,
> >>>
> >>>
> >>> static int
> >>> copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct =
*src_vma,
> >>>                pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
> >>>                unsigned long end)
> >>> {
> >>>         ...
> >>>         dst_pte =3D pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_pt=
l);
> >>>         if (!dst_pte) {
> >>>                 ret =3D -ENOMEM;
> >>>                 goto out;
> >>>         }
> >>>         src_pte =3D pte_offset_map_nolock(src_mm, src_pmd, addr, &src=
_ptl);
> >>>         if (!src_pte) {
> >>>                 pte_unmap_unlock(dst_pte, dst_ptl);
> >>>                 /* ret =3D=3D 0 */
> >>>                 goto out;
> >>>         }
> >>>         spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> >>>         orig_src_pte =3D src_pte;
> >>>         orig_dst_pte =3D dst_pte;
> >>>         arch_enter_lazy_mmu_mode();
> >>>
> >>>         do {
> >>>                 /*
> >>>                  * We are holding two locks at this point - either of=
 them
> >>>                  * could generate latencies in another task on anothe=
r CPU.
> >>>                  */
> >>>                 if (progress >=3D 32) {
> >>>                         progress =3D 0;
> >>>                         if (need_resched() ||
> >>>                             spin_needbreak(src_ptl) || spin_needbreak=
(dst_ptl))
> >>>                                 break;
> >>>                 }
> >>>                 ptent =3D ptep_get(src_pte);
> >>>                 if (pte_none(ptent)) {
> >>>                         progress++;
> >>>                         continue;
> >>>                 }
> >>>
> >>> the above iteration can break when progress > =3D32. for example, at =
the
> >>> beginning,
> >>> if all PTEs are none, we break when progress >=3D32, and we break whe=
n we
> >>> are in the 8th pte of 16PTEs which might become CONTPTE after we rele=
ase
> >>> PTL.
> >>>
> >>> since we are releasing PTLs, next time when we get PTL, those pte_non=
e() might
> >>> become pte_cont(), then are you going to copy CONTPTE from 8th pte,
> >>> thus, immediately
> >>> break the consistent CONPTEs rule of hardware?
> >>>
> >>> pte0 - pte_none
> >>> pte1 - pte_none
> >>> ...
> >>> pte7 - pte_none
> >>>
> >>> pte8 - pte_cont
> >>> ...
> >>> pte15 - pte_cont
> >>>
> >>> so we did some modification to avoid a break in the middle of PTEs
> >>> which can potentially
> >>> become CONTPE.
> >>> do {
> >>>                 /*
> >>>                 * We are holding two locks at this point - either of =
them
> >>>                 * could generate latencies in another task on another=
 CPU.
> >>>                 */
> >>>                 if (progress >=3D 32) {
> >>>                                 progress =3D 0;
> >>> #ifdef CONFIG_CONT_PTE_HUGEPAGE
> >>>                 /*
> >>>                 * XXX: don't release ptl at an unligned address as
> >>> cont_pte might form while
> >>>                 * ptl is released, this causes double-map
> >>>                 */
> >>>                 if (!vma_is_chp_anonymous(src_vma) ||
> >>>                    (vma_is_chp_anonymous(src_vma) && IS_ALIGNED(addr,
> >>> HPAGE_CONT_PTE_SIZE)))
> >>> #endif
> >>>                 if (need_resched() ||
> >>>                    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl)=
)
> >>>                                 break;
> >>> }
> >>>
> >>> We could only reproduce the above issue by running thousands of phone=
s.
> >>>
> >>> Does your code survive from this problem?
> >>
> >> Yes I'm confident my code is safe against this; as I said before, the =
CONT_PTE
> >> bit is not blindly "copied" from parent to child pte. As far as the co=
re-mm is
> >> concerned, there is no CONT_PTE bit; they are just regular PTEs. So th=
e code
> >> will see some pte_none() entries followed by some pte_present() entrie=
s. And
> >> when calling set_ptes() on the child, the arch code will evaluate the =
current
> >> state of the pgtable along with the new set_ptes() request and determi=
ne where
> >> it should insert the CONT_PTE bit.
> >
> > yep, i have read very carefully and think your code is safe here. The
> > only problem
> > is that the code can randomly unfold parent processes' CONPTE while set=
ting
> > wrprotect in the middle of a large folio while it actually should keep =
CONT
> > bit as all PTEs can be still consistent if we set protect from the 1st =
PTE.
> >
> > while A forks B,  progress >=3D 32 might interrupt in the middle of a
> > new CONTPTE folio which is forming, as we have to set wrprotect to pare=
nt A,
> > this parent immediately loses CONT bit. this is  sad. but i can't find =
a
> > good way to resolve it unless CONT is exposed to mm-core. any idea on
> > this?
>
> No this is not the case; copy_present_ptes() will copy as many ptes as ar=
e
> physcially contiguous and belong to the same folio (which usually means "=
the
> whole folio" - the only time it doesn't is when we hit the end of the vma=
). We
> will then return to the main loop and move forwards by the number of ptes=
 that
> were serviced, including:

I probably have failed to describe my question. i'd like to give a
concrete example

1. process A forks B
2. At the beginning, address~address +64KB has pte_none PTEs
3. we scan the 5th pte of address + 5 * 4KB, progress becomes 32, we
break and release PTLs
4. another page fault in process A gets PTL and set
address~address+64KB to pte_cont
5. we get the PTL again and arrive 5th pte
6. we set wrprotects on 5,6,7....15 ptes, in this case, we have to
unfold parent A
and child B also gets unfolded PTEs unless our loop can go back the 0th pte=
.

technically, A should be able to keep CONTPTE, but because of the implement=
ation
of the code, it can't. That is the sadness. but it is obviously not your fa=
ult.

no worries. This is not happening quite often. but i just want to make a no=
te
here, maybe someday we can get back to address it.

>
> progress +=3D 8 * ret;
>
> That might go above 32, so we will flash the lock. But we haven't done th=
at in
> the middle of a large folio. So the contpte-ness should be preserved.
>
> >
> > Our code[1] resolves this by only breaking at the aligned address
> >
> > if (progress >=3D 32) {
> >      progress =3D 0;
> >      #ifdef CONFIG_CONT_PTE_HUGEPAGE
> >      /*
> >       * XXX: don't release ptl at an unligned address as cont_pte
> > might form while
> >       * ptl is released, this causes double-map
> >      */
> >     if (!vma_is_chp_anonymous(src_vma) ||
> >         (vma_is_chp_anonymous(src_vma) && IS_ALIGNED(addr,
> > HPAGE_CONT_PTE_SIZE)))
> >     #endif
> >         if (need_resched() ||
> >            spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
> >              break;
> > }
> >
> > [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/on=
eplus/sm8550_u_14.0.0_oneplus11/mm/memory.c#L1180
> >
> >
Thanks
Barry
