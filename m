Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C416B7FC3E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376271AbjK1TAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjK1TAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:00:21 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520E4131
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:00:27 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7c4adc5dcdaso921397241.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701198026; x=1701802826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anm1dOFExfLy75gHJZ/W03bfpmv/nns8TAXn2nHoHQI=;
        b=ivuwWdQr6DZjWe6bFMrAr5KTu5bJxj20aRdV6yizu6VLZpRp++5GZyn9mzvRjEkqp8
         rCN4eFhA/z3AIN4tg/wrEE3bmx3njt9Zrylksic5nTbFjXA3W98sb0MuU4GDF799z4L9
         TefbWRQs151VLW/mcyZ36glAuXQAjsSve64od8/7QX8eYG5BWzLqusVJWYPRZ+yDJwbc
         U2yKPo+KN8TKOlaKEplPtF28wbH96/V4EXig0Sl5ZOIftRcwoWtFhT64o1nxHI0huujL
         ngRl69AAqKmVxwGggfRbRbHGvixH/R8fLlsukvm8+/0KIshiGy0E4i/s25fAl9Uphy2k
         LQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198026; x=1701802826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anm1dOFExfLy75gHJZ/W03bfpmv/nns8TAXn2nHoHQI=;
        b=llXrYYaHVAXQ+FSMs+zDZ0mjloo7WkwzG4yA+FF2CL7kZw1zPRoJQ2UWk1LcMsz0Hm
         1naay/EFbinlflJ49Wz+jOwA9uxvW6KuixV1eGm29ibPzRjNzikZa4LNmZLtgzaQEdAG
         UJnfCMgDUKzHLsKMIRoCioBFsYq4iJwXG5t8Mez/TtM7FGPgGlTPXOJZ5Q1eQpKVayXJ
         t8S6x8BQBxO0hrpdka2heCRS3LcmQ3+WFdg9yikgdwT62PGb6T5af2TdcjMRDFJ8OTOi
         JDv2oLo61TMgwyRWsDujTEbSkM9bW8WziqQoB1s8uadAvApmmKVHkObMzZVaGkvfwVPU
         pi6Q==
X-Gm-Message-State: AOJu0YyoPdejAeB99IiSu1eSutGqGvGhhFqtP31kmLASbiox3aXrDI4F
        3P7WHRqKSqZJT4ZOD6gBBTAhWoLxVUWzRNupFL8=
X-Google-Smtp-Source: AGHT+IHLoiGeuCVOh3TlGs+3ECmEk64qJ+sV0ApYTRDtWpUDW3Xs3BePMa+BoYyAvROWgh4JlqPIl4RzPSt9PjU4dNU=
X-Received: by 2002:a05:6102:3bfa:b0:463:d3:513e with SMTP id
 be26-20020a0561023bfa00b0046300d3513emr6221823vsb.27.1701198024786; Tue, 28
 Nov 2023 11:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-2-ryan.roberts@arm.com>
 <20231127055414.9015-1-v-songbaohua@oppo.com> <755343a1-ce94-4d38-8317-0925e2dae3bc@arm.com>
 <CAGsJ_4z_ftxvG-EcTe=X+Te8fNSShhVHHPvbEgAa1rQXgO5XCA@mail.gmail.com> <a43d8da8-d902-440c-aa64-df78fa4e185d@arm.com>
In-Reply-To: <a43d8da8-d902-440c-aa64-df78fa4e185d@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 29 Nov 2023 08:00:13 +1300
Message-ID: <CAGsJ_4w9E_90Bs9kWP1HWmKsknszw2i=Vtarj0UGD80yNpt5mw@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 12:00=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 28/11/2023 00:11, Barry Song wrote:
> > On Mon, Nov 27, 2023 at 10:24=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> On 27/11/2023 05:54, Barry Song wrote:
> >>>> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_st=
ruct *src_vma,
> >>>> +              pte_t *dst_pte, pte_t *src_pte,
> >>>> +              unsigned long addr, unsigned long end,
> >>>> +              int *rss, struct folio **prealloc)
> >>>>  {
> >>>>      struct mm_struct *src_mm =3D src_vma->vm_mm;
> >>>>      unsigned long vm_flags =3D src_vma->vm_flags;
> >>>>      pte_t pte =3D ptep_get(src_pte);
> >>>>      struct page *page;
> >>>>      struct folio *folio;
> >>>> +    int nr =3D 1;
> >>>> +    bool anon;
> >>>> +    bool any_dirty =3D pte_dirty(pte);
> >>>> +    int i;
> >>>>
> >>>>      page =3D vm_normal_page(src_vma, addr, pte);
> >>>> -    if (page)
> >>>> +    if (page) {
> >>>>              folio =3D page_folio(page);
> >>>> -    if (page && folio_test_anon(folio)) {
> >>>> -            /*
> >>>> -             * If this page may have been pinned by the parent proc=
ess,
> >>>> -             * copy the page immediately for the child so that we'l=
l always
> >>>> -             * guarantee the pinned page won't be randomly replaced=
 in the
> >>>> -             * future.
> >>>> -             */
> >>>> -            folio_get(folio);
> >>>> -            if (unlikely(page_try_dup_anon_rmap(page, false, src_vm=
a))) {
> >>>> -                    /* Page may be pinned, we have to copy. */
> >>>> -                    folio_put(folio);
> >>>> -                    return copy_present_page(dst_vma, src_vma, dst_=
pte, src_pte,
> >>>> -                                             addr, rss, prealloc, p=
age);
> >>>> +            anon =3D folio_test_anon(folio);
> >>>> +            nr =3D folio_nr_pages_cont_mapped(folio, page, src_pte,=
 addr,
> >>>> +                                            end, pte, &any_dirty);
> >>>
> >>> in case we have a large folio with 16 CONTPTE basepages, and userspac=
e
> >>> do madvise(addr + 4KB * 5, DONTNEED);
> >>
> >> nit: if you are offsetting by 5 pages from addr, then below I think yo=
u mean
> >> page0~page4 and page6~15?
> >>
> >>>
> >>> thus, the 4th basepage of PTE becomes PTE_NONE and folio_nr_pages_con=
t_mapped()
> >>> will return 15. in this case, we should copy page0~page3 and page5~pa=
ge15.
> >>
> >> No I don't think folio_nr_pages_cont_mapped() will return 15; that's c=
ertainly
> >> not how its intended to work. The function is scanning forwards from t=
he current
> >> pte until it finds the first pte that does not fit in the batch - eith=
er because
> >> it maps a PFN that is not contiguous, or because the permissions are d=
ifferent
> >> (although this is being relaxed a bit; see conversation with DavidH ag=
ainst this
> >> same patch).
> >>
> >> So the first time through this loop, folio_nr_pages_cont_mapped() will=
 return 5,
> >> (page0~page4) then the next time through the loop we will go through t=
he
> >> !present path and process the single swap marker. Then the 3rd time th=
rough the
> >> loop folio_nr_pages_cont_mapped() will return 10.
> >
> > one case we have met by running hundreds of real phones is as below,
> >
> >
> > static int
> > copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *s=
rc_vma,
> >                pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
> >                unsigned long end)
> > {
> >         ...
> >         dst_pte =3D pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl)=
;
> >         if (!dst_pte) {
> >                 ret =3D -ENOMEM;
> >                 goto out;
> >         }
> >         src_pte =3D pte_offset_map_nolock(src_mm, src_pmd, addr, &src_p=
tl);
> >         if (!src_pte) {
> >                 pte_unmap_unlock(dst_pte, dst_ptl);
> >                 /* ret =3D=3D 0 */
> >                 goto out;
> >         }
> >         spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> >         orig_src_pte =3D src_pte;
> >         orig_dst_pte =3D dst_pte;
> >         arch_enter_lazy_mmu_mode();
> >
> >         do {
> >                 /*
> >                  * We are holding two locks at this point - either of t=
hem
> >                  * could generate latencies in another task on another =
CPU.
> >                  */
> >                 if (progress >=3D 32) {
> >                         progress =3D 0;
> >                         if (need_resched() ||
> >                             spin_needbreak(src_ptl) || spin_needbreak(d=
st_ptl))
> >                                 break;
> >                 }
> >                 ptent =3D ptep_get(src_pte);
> >                 if (pte_none(ptent)) {
> >                         progress++;
> >                         continue;
> >                 }
> >
> > the above iteration can break when progress > =3D32. for example, at th=
e
> > beginning,
> > if all PTEs are none, we break when progress >=3D32, and we break when =
we
> > are in the 8th pte of 16PTEs which might become CONTPTE after we releas=
e
> > PTL.
> >
> > since we are releasing PTLs, next time when we get PTL, those pte_none(=
) might
> > become pte_cont(), then are you going to copy CONTPTE from 8th pte,
> > thus, immediately
> > break the consistent CONPTEs rule of hardware?
> >
> > pte0 - pte_none
> > pte1 - pte_none
> > ...
> > pte7 - pte_none
> >
> > pte8 - pte_cont
> > ...
> > pte15 - pte_cont
> >
> > so we did some modification to avoid a break in the middle of PTEs
> > which can potentially
> > become CONTPE.
> > do {
> >                 /*
> >                 * We are holding two locks at this point - either of th=
em
> >                 * could generate latencies in another task on another C=
PU.
> >                 */
> >                 if (progress >=3D 32) {
> >                                 progress =3D 0;
> > #ifdef CONFIG_CONT_PTE_HUGEPAGE
> >                 /*
> >                 * XXX: don't release ptl at an unligned address as
> > cont_pte might form while
> >                 * ptl is released, this causes double-map
> >                 */
> >                 if (!vma_is_chp_anonymous(src_vma) ||
> >                    (vma_is_chp_anonymous(src_vma) && IS_ALIGNED(addr,
> > HPAGE_CONT_PTE_SIZE)))
> > #endif
> >                 if (need_resched() ||
> >                    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
> >                                 break;
> > }
> >
> > We could only reproduce the above issue by running thousands of phones.
> >
> > Does your code survive from this problem?
>
> Yes I'm confident my code is safe against this; as I said before, the CON=
T_PTE
> bit is not blindly "copied" from parent to child pte. As far as the core-=
mm is
> concerned, there is no CONT_PTE bit; they are just regular PTEs. So the c=
ode
> will see some pte_none() entries followed by some pte_present() entries. =
And
> when calling set_ptes() on the child, the arch code will evaluate the cur=
rent
> state of the pgtable along with the new set_ptes() request and determine =
where
> it should insert the CONT_PTE bit.

yep, i have read very carefully and think your code is safe here. The
only problem
is that the code can randomly unfold parent processes' CONPTE while setting
wrprotect in the middle of a large folio while it actually should keep CONT
bit as all PTEs can be still consistent if we set protect from the 1st PTE.

while A forks B,  progress >=3D 32 might interrupt in the middle of a
new CONTPTE folio which is forming, as we have to set wrprotect to parent A=
,
this parent immediately loses CONT bit. this is  sad. but i can't find a
good way to resolve it unless CONT is exposed to mm-core. any idea on
this?

Our code[1] resolves this by only breaking at the aligned address

if (progress >=3D 32) {
     progress =3D 0;
     #ifdef CONFIG_CONT_PTE_HUGEPAGE
     /*
      * XXX: don't release ptl at an unligned address as cont_pte
might form while
      * ptl is released, this causes double-map
     */
    if (!vma_is_chp_anonymous(src_vma) ||
        (vma_is_chp_anonymous(src_vma) && IS_ALIGNED(addr,
HPAGE_CONT_PTE_SIZE)))
    #endif
        if (need_resched() ||
           spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
             break;
}

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplu=
s/sm8550_u_14.0.0_oneplus11/mm/memory.c#L1180


Thanks
Barry
