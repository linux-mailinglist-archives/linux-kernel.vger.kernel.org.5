Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E847FE4DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbjK3AeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK3AeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:34:20 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DF1BC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:34:25 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7c461a8684fso105592241.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701304465; x=1701909265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iE0EOVY/boKVVt75az+2H2IylfQ/rY8ywinKA1Q3dE=;
        b=JXasDpFpFiLlrs8xDemj+k+wjAiydnMAiz3o6X5tH9SyI82kmVyUCyvHa+R9saIfqV
         bwhvd1Zd/qXv+p2rmtbxYnoYkopKV8crhnXHEcHAx9NMPxGis7AD4G4IIGU71gclYrSa
         7AhIqrl29EsDmmdlJkae1DJaHA8br7MZoQV7OvP6c3gPciFSMC2ImkQ+BwvnY5nZwQS7
         wVF0dRmSv3djUEGVF8JU+U+Ufumlcfjn4bD3aGV9uWWbOj2TSSJrYz4liRxzI/pqV4BG
         3W46+Vyl3FP6IwhOIbAD3yC9x+UACh43qceOB3zBiqTiaWWj7Ec3RHlUNk8r92Ja5NL3
         YLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701304465; x=1701909265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iE0EOVY/boKVVt75az+2H2IylfQ/rY8ywinKA1Q3dE=;
        b=iFnXXaxnqc3wJnnzzxzsWaQ0Z4+PF4Qa0l3H7zCcx5sEMf1Ob8hM07adbSI06ZbMNX
         YCXfg1ZBM6e+oDfrRHmv1BKU0B+WnHPIitqele+eP8zgWZ+qnN3Xj8ca7Nx3nbtUTylH
         GNt0G8wktqTcB9uM1aCKGyY/2ZNxP40M3/k3u2zXMgnhYCdlHqOZKBJVPsdenn4LEt/D
         fxHQeGkNsOdtsom/R2X7kI5/gVBWKaz2w9tAbBmb8P8MGOiCyI4lwbN93jpw1HI3uNL4
         HU0YdWwqc8fzuPGHtCWgDy2uJUsIUJJJ6xCPZGwf0tbSEKAq2BzXNOWCHMchjYDRV0NG
         hPIg==
X-Gm-Message-State: AOJu0YxmAOPb+v2YZsqH096cDr3CHhWOfLG5Yp2xfbm3dDfMAoj4aC31
        mfnJY/SImZOkM5fcijotgPpx/w8Gxabptv2sHJk=
X-Google-Smtp-Source: AGHT+IH/7TiXtW+dJCvD+hegyntTLRvMUl/FFmAv+2SlmPHJ0VgdYi2kHtEuesXQ3+WWHl2KBOhCT+zweurmoUcAGEM=
X-Received: by 2002:ac5:c386:0:b0:4ab:f099:17ad with SMTP id
 s6-20020ac5c386000000b004abf09917admr19420175vkk.9.1701304464688; Wed, 29 Nov
 2023 16:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-2-ryan.roberts@arm.com>
 <20231127055414.9015-1-v-songbaohua@oppo.com> <755343a1-ce94-4d38-8317-0925e2dae3bc@arm.com>
 <CAGsJ_4z_ftxvG-EcTe=X+Te8fNSShhVHHPvbEgAa1rQXgO5XCA@mail.gmail.com>
 <a43d8da8-d902-440c-aa64-df78fa4e185d@arm.com> <CAGsJ_4w9E_90Bs9kWP1HWmKsknszw2i=Vtarj0UGD80yNpt5mw@mail.gmail.com>
 <02d85331-eaa0-4d76-a3d6-ea5eb18b683c@arm.com> <CAGsJ_4zDZb93bKMmhRn_V3a_PR11xKkaYkdxZW2ZsO6zNNj0Kw@mail.gmail.com>
 <b485e908-770b-4cd9-8e45-b9107a581ae8@arm.com>
In-Reply-To: <b485e908-770b-4cd9-8e45-b9107a581ae8@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 30 Nov 2023 13:34:13 +1300
Message-ID: <CAGsJ_4wXawhY5OsjjZUkgaBwXeFeBbcZa5NcsWETgXty=iogJg@mail.gmail.com>
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

On Thu, Nov 30, 2023 at 3:07=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 29/11/2023 13:09, Barry Song wrote:
> > On Thu, Nov 30, 2023 at 1:29=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 28/11/2023 19:00, Barry Song wrote:
> >>> On Wed, Nov 29, 2023 at 12:00=E2=80=AFAM Ryan Roberts <ryan.roberts@a=
rm.com> wrote:
> >>>>
> >>>> On 28/11/2023 00:11, Barry Song wrote:
> >>>>> On Mon, Nov 27, 2023 at 10:24=E2=80=AFPM Ryan Roberts <ryan.roberts=
@arm.com> wrote:
> >>>>>>
> >>>>>> On 27/11/2023 05:54, Barry Song wrote:
> >>>>>>>> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_are=
a_struct *src_vma,
> >>>>>>>> +              pte_t *dst_pte, pte_t *src_pte,
> >>>>>>>> +              unsigned long addr, unsigned long end,
> >>>>>>>> +              int *rss, struct folio **prealloc)
> >>>>>>>>  {
> >>>>>>>>      struct mm_struct *src_mm =3D src_vma->vm_mm;
> >>>>>>>>      unsigned long vm_flags =3D src_vma->vm_flags;
> >>>>>>>>      pte_t pte =3D ptep_get(src_pte);
> >>>>>>>>      struct page *page;
> >>>>>>>>      struct folio *folio;
> >>>>>>>> +    int nr =3D 1;
> >>>>>>>> +    bool anon;
> >>>>>>>> +    bool any_dirty =3D pte_dirty(pte);
> >>>>>>>> +    int i;
> >>>>>>>>
> >>>>>>>>      page =3D vm_normal_page(src_vma, addr, pte);
> >>>>>>>> -    if (page)
> >>>>>>>> +    if (page) {
> >>>>>>>>              folio =3D page_folio(page);
> >>>>>>>> -    if (page && folio_test_anon(folio)) {
> >>>>>>>> -            /*
> >>>>>>>> -             * If this page may have been pinned by the parent =
process,
> >>>>>>>> -             * copy the page immediately for the child so that =
we'll always
> >>>>>>>> -             * guarantee the pinned page won't be randomly repl=
aced in the
> >>>>>>>> -             * future.
> >>>>>>>> -             */
> >>>>>>>> -            folio_get(folio);
> >>>>>>>> -            if (unlikely(page_try_dup_anon_rmap(page, false, sr=
c_vma))) {
> >>>>>>>> -                    /* Page may be pinned, we have to copy. */
> >>>>>>>> -                    folio_put(folio);
> >>>>>>>> -                    return copy_present_page(dst_vma, src_vma, =
dst_pte, src_pte,
> >>>>>>>> -                                             addr, rss, preallo=
c, page);
> >>>>>>>> +            anon =3D folio_test_anon(folio);
> >>>>>>>> +            nr =3D folio_nr_pages_cont_mapped(folio, page, src_=
pte, addr,
> >>>>>>>> +                                            end, pte, &any_dirt=
y);
> >>>>>>>
> >>>>>>> in case we have a large folio with 16 CONTPTE basepages, and user=
space
> >>>>>>> do madvise(addr + 4KB * 5, DONTNEED);
> >>>>>>
> >>>>>> nit: if you are offsetting by 5 pages from addr, then below I thin=
k you mean
> >>>>>> page0~page4 and page6~15?
> >>>>>>
> >>>>>>>
> >>>>>>> thus, the 4th basepage of PTE becomes PTE_NONE and folio_nr_pages=
_cont_mapped()
> >>>>>>> will return 15. in this case, we should copy page0~page3 and page=
5~page15.
> >>>>>>
> >>>>>> No I don't think folio_nr_pages_cont_mapped() will return 15; that=
's certainly
> >>>>>> not how its intended to work. The function is scanning forwards fr=
om the current
> >>>>>> pte until it finds the first pte that does not fit in the batch - =
either because
> >>>>>> it maps a PFN that is not contiguous, or because the permissions a=
re different
> >>>>>> (although this is being relaxed a bit; see conversation with David=
H against this
> >>>>>> same patch).
> >>>>>>
> >>>>>> So the first time through this loop, folio_nr_pages_cont_mapped() =
will return 5,
> >>>>>> (page0~page4) then the next time through the loop we will go throu=
gh the
> >>>>>> !present path and process the single swap marker. Then the 3rd tim=
e through the
> >>>>>> loop folio_nr_pages_cont_mapped() will return 10.
> >>>>>
> >>>>> one case we have met by running hundreds of real phones is as below=
,
> >>>>>
> >>>>>
> >>>>> static int
> >>>>> copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struc=
t *src_vma,
> >>>>>                pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
> >>>>>                unsigned long end)
> >>>>> {
> >>>>>         ...
> >>>>>         dst_pte =3D pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_=
ptl);
> >>>>>         if (!dst_pte) {
> >>>>>                 ret =3D -ENOMEM;
> >>>>>                 goto out;
> >>>>>         }
> >>>>>         src_pte =3D pte_offset_map_nolock(src_mm, src_pmd, addr, &s=
rc_ptl);
> >>>>>         if (!src_pte) {
> >>>>>                 pte_unmap_unlock(dst_pte, dst_ptl);
> >>>>>                 /* ret =3D=3D 0 */
> >>>>>                 goto out;
> >>>>>         }
> >>>>>         spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> >>>>>         orig_src_pte =3D src_pte;
> >>>>>         orig_dst_pte =3D dst_pte;
> >>>>>         arch_enter_lazy_mmu_mode();
> >>>>>
> >>>>>         do {
> >>>>>                 /*
> >>>>>                  * We are holding two locks at this point - either =
of them
> >>>>>                  * could generate latencies in another task on anot=
her CPU.
> >>>>>                  */
> >>>>>                 if (progress >=3D 32) {
> >>>>>                         progress =3D 0;
> >>>>>                         if (need_resched() ||
> >>>>>                             spin_needbreak(src_ptl) || spin_needbre=
ak(dst_ptl))
> >>>>>                                 break;
> >>>>>                 }
> >>>>>                 ptent =3D ptep_get(src_pte);
> >>>>>                 if (pte_none(ptent)) {
> >>>>>                         progress++;
> >>>>>                         continue;
> >>>>>                 }
> >>>>>
> >>>>> the above iteration can break when progress > =3D32. for example, a=
t the
> >>>>> beginning,
> >>>>> if all PTEs are none, we break when progress >=3D32, and we break w=
hen we
> >>>>> are in the 8th pte of 16PTEs which might become CONTPTE after we re=
lease
> >>>>> PTL.
> >>>>>
> >>>>> since we are releasing PTLs, next time when we get PTL, those pte_n=
one() might
> >>>>> become pte_cont(), then are you going to copy CONTPTE from 8th pte,
> >>>>> thus, immediately
> >>>>> break the consistent CONPTEs rule of hardware?
> >>>>>
> >>>>> pte0 - pte_none
> >>>>> pte1 - pte_none
> >>>>> ...
> >>>>> pte7 - pte_none
> >>>>>
> >>>>> pte8 - pte_cont
> >>>>> ...
> >>>>> pte15 - pte_cont
> >>>>>
> >>>>> so we did some modification to avoid a break in the middle of PTEs
> >>>>> which can potentially
> >>>>> become CONTPE.
> >>>>> do {
> >>>>>                 /*
> >>>>>                 * We are holding two locks at this point - either o=
f them
> >>>>>                 * could generate latencies in another task on anoth=
er CPU.
> >>>>>                 */
> >>>>>                 if (progress >=3D 32) {
> >>>>>                                 progress =3D 0;
> >>>>> #ifdef CONFIG_CONT_PTE_HUGEPAGE
> >>>>>                 /*
> >>>>>                 * XXX: don't release ptl at an unligned address as
> >>>>> cont_pte might form while
> >>>>>                 * ptl is released, this causes double-map
> >>>>>                 */
> >>>>>                 if (!vma_is_chp_anonymous(src_vma) ||
> >>>>>                    (vma_is_chp_anonymous(src_vma) && IS_ALIGNED(add=
r,
> >>>>> HPAGE_CONT_PTE_SIZE)))
> >>>>> #endif
> >>>>>                 if (need_resched() ||
> >>>>>                    spin_needbreak(src_ptl) || spin_needbreak(dst_pt=
l))
> >>>>>                                 break;
> >>>>> }
> >>>>>
> >>>>> We could only reproduce the above issue by running thousands of pho=
nes.
> >>>>>
> >>>>> Does your code survive from this problem?
> >>>>
> >>>> Yes I'm confident my code is safe against this; as I said before, th=
e CONT_PTE
> >>>> bit is not blindly "copied" from parent to child pte. As far as the =
core-mm is
> >>>> concerned, there is no CONT_PTE bit; they are just regular PTEs. So =
the code
> >>>> will see some pte_none() entries followed by some pte_present() entr=
ies. And
> >>>> when calling set_ptes() on the child, the arch code will evaluate th=
e current
> >>>> state of the pgtable along with the new set_ptes() request and deter=
mine where
> >>>> it should insert the CONT_PTE bit.
> >>>
> >>> yep, i have read very carefully and think your code is safe here. The
> >>> only problem
> >>> is that the code can randomly unfold parent processes' CONPTE while s=
etting
> >>> wrprotect in the middle of a large folio while it actually should kee=
p CONT
> >>> bit as all PTEs can be still consistent if we set protect from the 1s=
t PTE.
> >>>
> >>> while A forks B,  progress >=3D 32 might interrupt in the middle of a
> >>> new CONTPTE folio which is forming, as we have to set wrprotect to pa=
rent A,
> >>> this parent immediately loses CONT bit. this is  sad. but i can't fin=
d a
> >>> good way to resolve it unless CONT is exposed to mm-core. any idea on
> >>> this?
> >>
> >> No this is not the case; copy_present_ptes() will copy as many ptes as=
 are
> >> physcially contiguous and belong to the same folio (which usually mean=
s "the
> >> whole folio" - the only time it doesn't is when we hit the end of the =
vma). We
> >> will then return to the main loop and move forwards by the number of p=
tes that
> >> were serviced, including:
> >
> > I probably have failed to describe my question. i'd like to give a
> > concrete example
> >
> > 1. process A forks B
> > 2. At the beginning, address~address +64KB has pte_none PTEs
> > 3. we scan the 5th pte of address + 5 * 4KB, progress becomes 32, we
> > break and release PTLs
> > 4. another page fault in process A gets PTL and set
> > address~address+64KB to pte_cont
> > 5. we get the PTL again and arrive 5th pte
> > 6. we set wrprotects on 5,6,7....15 ptes, in this case, we have to
> > unfold parent A
> > and child B also gets unfolded PTEs unless our loop can go back the 0th=
 pte.
> >
> > technically, A should be able to keep CONTPTE, but because of the imple=
mentation
> > of the code, it can't. That is the sadness. but it is obviously not you=
r fault.
> >
> > no worries. This is not happening quite often. but i just want to make =
a note
> > here, maybe someday we can get back to address it.
>
> Ahh, I understand the situation now, sorry for being slow!
>
> I expect this to be a very rare situation anyway since (4) suggests proce=
ss A
> has another thread, and forking is not encouraged for multithreaded progr=
ams. In
> fact the fork man page says:
>
>   After a fork() in a multithreaded program, the child can safely call on=
ly
>   async-signal-safe functions (see signal-safety(7)) until such time as i=
t calls
>   execve(2).
>
> So in this case, we are about to completely repaint the child's address s=
pace
> with execve() anyway.
>
> So its just the racing parent that loses the CONT_PTE bit. I expect this =
to be
> extremely rare. I'm not sure there is much we can do to solve it though, =
because
> unlike with your solution, we have to cater for multiple sizes so there i=
s no
> obvious boarder until we get to PMD size and I'm guessing that's going to=
 be a
> problem for latency spikes.

right. i don't think this can be a big problem. the background is that
we have some
way to constantly detect and report unexpected unfold/events, so we run hun=
dreds
of phones in lab, and collect data to find out if we have any
potential problems. we
record unexpected unfold and reasons in a proc file, we monitor those data =
to
look for potential bugs we might have. this ">=3D32" break and unfold was f=
ound in
this way, thus we simply addressed it by disallowing the break at an unalig=
ned
address.

This is never an issue which can stop your patchset. but I was still
glad to share
our observations with you and would like to hear if you had any idea :-)

>
>
> >
> >>
> >> progress +=3D 8 * ret;
> >>
> >> That might go above 32, so we will flash the lock. But we haven't done=
 that in
> >> the middle of a large folio. So the contpte-ness should be preserved.
> >>
> >>>
> >>> Our code[1] resolves this by only breaking at the aligned address
> >>>
> >>> if (progress >=3D 32) {
> >>>      progress =3D 0;
> >>>      #ifdef CONFIG_CONT_PTE_HUGEPAGE
> >>>      /*
> >>>       * XXX: don't release ptl at an unligned address as cont_pte
> >>> might form while
> >>>       * ptl is released, this causes double-map
> >>>      */
> >>>     if (!vma_is_chp_anonymous(src_vma) ||
> >>>         (vma_is_chp_anonymous(src_vma) && IS_ALIGNED(addr,
> >>> HPAGE_CONT_PTE_SIZE)))
> >>>     #endif
> >>>         if (need_resched() ||
> >>>            spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
> >>>              break;
> >>> }
> >>>
> >>> [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/=
oneplus/sm8550_u_14.0.0_oneplus11/mm/memory.c#L1180

Thanks
Barry
