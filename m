Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C3C7FAEE2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjK1AL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1ALZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:11:25 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9A8191
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:11:31 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7b9c8706fc1so1181114241.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701130291; x=1701735091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLPwMqJishFcOcomBEvrOdMlrWf+v3GiVQnwOo3w4A0=;
        b=NjxANURHu7lJHewk5I2AuzvPfYJmLODVdNfj3bf1S41mrRZD/3obWns6QX4GHouUA8
         axakrnI1SQzdyq6kpxjwMJlUakZis0fsfRkZwx35UpjTOmebyLImN7Xhl0tG5QYLxqPd
         Z/NIpypiLV+lN+jq3+z5wy9f5yiYcfUXlq6fUfWsw2mXUMjQl9rR419IdlhQA1VJg7iq
         715yyJ1si/b2RRDjvjyPinhDMjvqeEsByvMlomYG+DYxvLQB2jc3/a7wVF9s2OvzEMBz
         1l8ZQqaElPGQ1koG9jvC8SUHsVcT1oyrkqkXodg+NxRBHD5h6CZQQMkmXzRkHJGM5wIy
         l1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701130291; x=1701735091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLPwMqJishFcOcomBEvrOdMlrWf+v3GiVQnwOo3w4A0=;
        b=xSuHq2x2jCD2DyTEd/Q0d36IJzueg1ZuT7hpmoTG5yE4S8L3jbfPGf+I4jq/kwWpvs
         YH4nix46cuSgTONSKsr/lHrMa+Q5GAf6SiQPACYYCVz1BkXDUnWa8gOpYoxUVJObp7AE
         +q24BfV60I9h9KMJsEo+NYbhx7XwL0JCTEXL4p7irKPZrKmm8M1pFMFmhzHjFe9IN3H1
         7Mzu4ACp7oPFu708Bz5EaunxlrecG4mE3v9BFigsjAZRM7Fn4h0RWTDvU2h1sGM4+v3V
         1uoiKuqoPORTv0WGS4uA6Z9GE57YFu6s8tnhP+4TRma/IdZ7TrT8r2cfY7+RyZBLMkXS
         4CCA==
X-Gm-Message-State: AOJu0Ywt6wlZmQB+JVAxJ10+z4BB1CbBRz71i7NMfnMiq273gvAsgww+
        i6BlWOt1RXX/GK0Ktthx/9Ms2jdztc3CIlMvFbA=
X-Google-Smtp-Source: AGHT+IGu7la2NIj9H3ri3a5UzeqzTVlJJ6Ex6kMGy2z00l2RQXwr+JP0sF+ttbzxDwb7DmwDrrh7D+hgIffFXLQun4E=
X-Received: by 2002:a05:6122:1d45:b0:49c:b45:6cba with SMTP id
 gd5-20020a0561221d4500b0049c0b456cbamr13788833vkb.12.1701130290684; Mon, 27
 Nov 2023 16:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-2-ryan.roberts@arm.com>
 <20231127055414.9015-1-v-songbaohua@oppo.com> <755343a1-ce94-4d38-8317-0925e2dae3bc@arm.com>
In-Reply-To: <755343a1-ce94-4d38-8317-0925e2dae3bc@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 28 Nov 2023 13:11:19 +1300
Message-ID: <CAGsJ_4z_ftxvG-EcTe=X+Te8fNSShhVHHPvbEgAa1rQXgO5XCA@mail.gmail.com>
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

On Mon, Nov 27, 2023 at 10:24=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 27/11/2023 05:54, Barry Song wrote:
> >> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_stru=
ct *src_vma,
> >> +              pte_t *dst_pte, pte_t *src_pte,
> >> +              unsigned long addr, unsigned long end,
> >> +              int *rss, struct folio **prealloc)
> >>  {
> >>      struct mm_struct *src_mm =3D src_vma->vm_mm;
> >>      unsigned long vm_flags =3D src_vma->vm_flags;
> >>      pte_t pte =3D ptep_get(src_pte);
> >>      struct page *page;
> >>      struct folio *folio;
> >> +    int nr =3D 1;
> >> +    bool anon;
> >> +    bool any_dirty =3D pte_dirty(pte);
> >> +    int i;
> >>
> >>      page =3D vm_normal_page(src_vma, addr, pte);
> >> -    if (page)
> >> +    if (page) {
> >>              folio =3D page_folio(page);
> >> -    if (page && folio_test_anon(folio)) {
> >> -            /*
> >> -             * If this page may have been pinned by the parent proces=
s,
> >> -             * copy the page immediately for the child so that we'll =
always
> >> -             * guarantee the pinned page won't be randomly replaced i=
n the
> >> -             * future.
> >> -             */
> >> -            folio_get(folio);
> >> -            if (unlikely(page_try_dup_anon_rmap(page, false, src_vma)=
)) {
> >> -                    /* Page may be pinned, we have to copy. */
> >> -                    folio_put(folio);
> >> -                    return copy_present_page(dst_vma, src_vma, dst_pt=
e, src_pte,
> >> -                                             addr, rss, prealloc, pag=
e);
> >> +            anon =3D folio_test_anon(folio);
> >> +            nr =3D folio_nr_pages_cont_mapped(folio, page, src_pte, a=
ddr,
> >> +                                            end, pte, &any_dirty);
> >
> > in case we have a large folio with 16 CONTPTE basepages, and userspace
> > do madvise(addr + 4KB * 5, DONTNEED);
>
> nit: if you are offsetting by 5 pages from addr, then below I think you m=
ean
> page0~page4 and page6~15?
>
> >
> > thus, the 4th basepage of PTE becomes PTE_NONE and folio_nr_pages_cont_=
mapped()
> > will return 15. in this case, we should copy page0~page3 and page5~page=
15.
>
> No I don't think folio_nr_pages_cont_mapped() will return 15; that's cert=
ainly
> not how its intended to work. The function is scanning forwards from the =
current
> pte until it finds the first pte that does not fit in the batch - either =
because
> it maps a PFN that is not contiguous, or because the permissions are diff=
erent
> (although this is being relaxed a bit; see conversation with DavidH again=
st this
> same patch).
>
> So the first time through this loop, folio_nr_pages_cont_mapped() will re=
turn 5,
> (page0~page4) then the next time through the loop we will go through the
> !present path and process the single swap marker. Then the 3rd time throu=
gh the
> loop folio_nr_pages_cont_mapped() will return 10.

one case we have met by running hundreds of real phones is as below,


static int
copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_v=
ma,
               pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
               unsigned long end)
{
        ...
        dst_pte =3D pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
        if (!dst_pte) {
                ret =3D -ENOMEM;
                goto out;
        }
        src_pte =3D pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
        if (!src_pte) {
                pte_unmap_unlock(dst_pte, dst_ptl);
                /* ret =3D=3D 0 */
                goto out;
        }
        spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
        orig_src_pte =3D src_pte;
        orig_dst_pte =3D dst_pte;
        arch_enter_lazy_mmu_mode();

        do {
                /*
                 * We are holding two locks at this point - either of them
                 * could generate latencies in another task on another CPU.
                 */
                if (progress >=3D 32) {
                        progress =3D 0;
                        if (need_resched() ||
                            spin_needbreak(src_ptl) || spin_needbreak(dst_p=
tl))
                                break;
                }
                ptent =3D ptep_get(src_pte);
                if (pte_none(ptent)) {
                        progress++;
                        continue;
                }

the above iteration can break when progress > =3D32. for example, at the
beginning,
if all PTEs are none, we break when progress >=3D32, and we break when we
are in the 8th pte of 16PTEs which might become CONTPTE after we release
PTL.

since we are releasing PTLs, next time when we get PTL, those pte_none() mi=
ght
become pte_cont(), then are you going to copy CONTPTE from 8th pte,
thus, immediately
break the consistent CONPTEs rule of hardware?

pte0 - pte_none
pte1 - pte_none
...
pte7 - pte_none

pte8 - pte_cont
...
pte15 - pte_cont

so we did some modification to avoid a break in the middle of PTEs
which can potentially
become CONTPE.
do {
                /*
                * We are holding two locks at this point - either of them
                * could generate latencies in another task on another CPU.
                */
                if (progress >=3D 32) {
                                progress =3D 0;
#ifdef CONFIG_CONT_PTE_HUGEPAGE
                /*
                * XXX: don't release ptl at an unligned address as
cont_pte might form while
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

We could only reproduce the above issue by running thousands of phones.

Does your code survive from this problem?

>
> Thanks,
> Ryan
>
> >
> > but the current code is copying page0~page14, right? unless we are imme=
diatly
> > split_folio to basepages in zap_pte_range(), we will have problems?
> >
> >> +
> >> +            for (i =3D 0; i < nr; i++, page++) {
> >> +                    if (anon) {
> >> +                            /*
> >> +                             * If this page may have been pinned by t=
he
> >> +                             * parent process, copy the page immediat=
ely for
> >> +                             * the child so that we'll always guarant=
ee the
> >> +                             * pinned page won't be randomly replaced=
 in the
> >> +                             * future.
> >> +                             */
> >> +                            if (unlikely(page_try_dup_anon_rmap(
> >> +                                            page, false, src_vma))) {
> >> +                                    if (i !=3D 0)
> >> +                                            break;
> >> +                                    /* Page may be pinned, we have to=
 copy. */
> >> +                                    return copy_present_page(
> >> +                                            dst_vma, src_vma, dst_pte=
,
> >> +                                            src_pte, addr, rss, preal=
loc,
> >> +                                            page);
> >> +                            }
> >> +                            rss[MM_ANONPAGES]++;
> >> +                            VM_BUG_ON(PageAnonExclusive(page));
> >> +                    } else {
> >> +                            page_dup_file_rmap(page, false);
> >> +                            rss[mm_counter_file(page)]++;
> >> +                    }
> >

Thanks
Barry
