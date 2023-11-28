Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EBE7FB18E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjK1FtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1FtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:49:22 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1841AC4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:49:29 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7c47dd348f2so1315114241.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701150568; x=1701755368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcnDikeD6as2th0VRusiTYWeEuAc+7mTw9jCcj0CvXA=;
        b=Z7j3xFmtvKouqL+3bO2s62sfmD51sOHkLMHjW3RCTHEpAOxy3obqB+OyWx5YkYRr76
         w20AAl6+8eOUI0UesZ13gb9NHOODV3d13Z4DYU9/WwvhcjN4DMI4G5Db0ADe845IrzvE
         AT8EUwlvE2AYA6AS0E+zHhL/SN8cm3QSKMG6MIf9KClyfQQ+1imtktSgK30NyJV2gCB9
         h/EYOnB7dbmPa/9S0n0exo6TrQ5BLIzsc7Yr17DjCBCPP5rJr/N6mP2Z/zqoU8eCmGRy
         2YT98pEwbd5usj9cHSLV8LKF2A7ZJB+d8OFHCJ59gAqLjjarGmwFOCGvDD2laAsH68+2
         BXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701150568; x=1701755368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcnDikeD6as2th0VRusiTYWeEuAc+7mTw9jCcj0CvXA=;
        b=uosrs1CEnm+v+rqDtUBvP8wCG9DGJz7K1iZqT9hfkYC/9e7vdHIDijJdBEVsC+ewfK
         ayVHFW4xWsgPzD6hqSg7ebTjQhqdjqiQkBLdEGUyft3Fx+g+4LvYTh8d5PTfNvK7HQpA
         UuXDOoW2lp0iTyzMIw/0Eowzz+DqZMmn8s/ItCgzlz4WVjsPcQu68bTImJvyN4hu1UoV
         9Q18fym2k6OuwkVAWjATdPTPweRUKRwGtH5ym6JsQAoJqzPiRgC6K/BCka8xY5UAAZnl
         6Ae6+FV4R4gOKC/6u3QunhETrif5J/RtQAeq3GUH1+bNwWXBbeZsZA+rGqSEVGzFVqQe
         V1oA==
X-Gm-Message-State: AOJu0Yy+7a6MAGBEGOyDoBDhn2VC7AOto1Z+s+qXT3CeOgkFd6b6k1al
        ilxRAeceAd7HGOlNUkfogUwxeIN8CLPVe8AIkHo=
X-Google-Smtp-Source: AGHT+IFwDOs82gSKF/qp3Oro+uBkMLk10nGMkQc0S1rLsq5ki0cFMX8ZNAcNLLihcWyjdj9RrOMOH3eDEAsNQiujstw=
X-Received: by 2002:a67:e90d:0:b0:462:f544:8ba5 with SMTP id
 c13-20020a67e90d000000b00462f5448ba5mr6939340vso.21.1701150568116; Mon, 27
 Nov 2023 21:49:28 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231127031813.5576-1-v-songbaohua@oppo.com> <234021ba-73c2-474a-82f9-91e1604d5bb5@arm.com>
In-Reply-To: <234021ba-73c2-474a-82f9-91e1604d5bb5@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 28 Nov 2023 13:49:13 +0800
Message-ID: <CAGsJ_4wTtwAMydZMzWFQghN+3xGcw3fa6iCfQpPRoqP-Tjf5dA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Transparent Contiguous PTEs for User Mappings
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

On Mon, Nov 27, 2023 at 5:15=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 27/11/2023 03:18, Barry Song wrote:
> >> Ryan Roberts (14):
> >>   mm: Batch-copy PTE ranges during fork()
> >>   arm64/mm: set_pte(): New layer to manage contig bit
> >>   arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
> >>   arm64/mm: pte_clear(): New layer to manage contig bit
> >>   arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
> >>   arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bi=
t
> >>   arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
> >>   arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
> >>   arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
> >>   arm64/mm: ptep_get(): New layer to manage contig bit
> >>   arm64/mm: Split __flush_tlb_range() to elide trailing DSB
> >>   arm64/mm: Wire up PTE_CONT for user mappings
> >>   arm64/mm: Implement ptep_set_wrprotects() to optimize fork()
> >>   arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown
> >
> > Hi Ryan,
> > Not quite sure if I missed something, are we splitting/unfolding CONTPT=
ES
> > in the below cases
>
> The general idea is that the core-mm sets the individual ptes (one at a t=
ime if
> it likes with set_pte_at(), or in a block with set_ptes()), modifies its
> permissions (ptep_set_wrprotect(), ptep_set_access_flags()) and clears th=
em
> (ptep_clear(), etc); This is exactly the same interface as previously.
>
> BUT, the arm64 implementation of those interfaces will now detect when a =
set of
> adjacent PTEs (a contpte block - so 16 naturally aligned entries when usi=
ng 4K
> base pages) are all appropriate for having the CONT_PTE bit set; in this =
case
> the block is "folded". And it will detect when the first PTE in the block
> changes such that the CONT_PTE bit must now be unset ("unfolded"). One of=
 the
> requirements for folding a contpte block is that all the pages must belon=
g to
> the *same* folio (that means its safe to only track access/dirty for thec=
ontpte
> block as a whole rather than for each individual pte).
>
> (there are a couple of optimizations that make the reality slightly more
> complicated than what I've just explained, but you get the idea).
>
> On that basis, I believe all the specific cases you describe below are al=
l
> covered and safe - please let me know if you think there is a hole here!
>
> >
> > 1. madvise(MADV_DONTNEED) on a part of basepages on a CONTPTE large fol=
io
>
> The page will first be unmapped (e.g. ptep_clear() or ptep_get_and_clear(=
), or
> whatever). The implementation of that will cause an unfold and the CONT_P=
TE bit
> is removed from the whole contpte block. If there is then a subsequent
> set_pte_at() to set a swap entry, the implementation will see that its no=
t
> appropriate to re-fold, so the range will remain unfolded.
>
> >
> > 2. vma split in a large folio due to various reasons such as mprotect,
> > munmap, mlock etc.
>
> I'm not sure if PTEs are explicitly unmapped/remapped when splitting a VM=
A? I
> suspect not, so if the VMA is split in the middle of a currently folded c=
ontpte
> block, it will remain folded. But this is safe and continues to work corr=
ectly.
> The VMA arrangement is not important; it is just important that a single =
folio
> is mapped contiguously across the whole block.
>
> >
> > 3. try_to_unmap_one() to reclaim a folio, ptes are scanned one by one
> > rather than being as a whole.
>
> Yes, as per 1; the arm64 implementation will notice when the first entry =
is
> cleared and unfold the contpte block.
>
> >
> > In hardware, we need to make sure CONTPTE follow the rule - always 16
> > contiguous physical address with CONTPTE set. if one of them run away
> > from the 16 ptes group and PTEs become unconsistent, some terrible
> > errors/faults can happen in HW. for example
>
> Yes, the implementation obeys all these rules; see contpte_try_fold() and
> contpte_try_unfold(). the fold/unfold operation is only done when all
> requirements are met, and we perform it in a manner that is conformant to=
 the
> architecture requirements (see contpte_fold() - being renamed to
> contpte_convert() in the next version).

Hi Ryan,

sorry for too many comments, I remembered another case

4. mremap

a CONTPTE might be remapped to another address which might not be
aligned with 16*basepage. thus, in move_ptes(), we are copying CONPTEs
from src to dst.
static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
                unsigned long old_addr, unsigned long old_end,
                struct vm_area_struct *new_vma, pmd_t *new_pmd,
                unsigned long new_addr, bool need_rmap_locks)
{
        struct mm_struct *mm =3D vma->vm_mm;
        pte_t *old_pte, *new_pte, pte;
        ...

        /*
         * We don't have to worry about the ordering of src and dst
         * pte locks because exclusive mmap_lock prevents deadlock.
         */
        old_pte =3D pte_offset_map_lock(mm, old_pmd, old_addr, &old_ptl);
        if (!old_pte) {
                err =3D -EAGAIN;
                goto out;
        }
        new_pte =3D pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
        if (!new_pte) {
                pte_unmap_unlock(old_pte, old_ptl);
                err =3D -EAGAIN;
                goto out;
        }
        if (new_ptl !=3D old_ptl)
                spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
        flush_tlb_batched_pending(vma->vm_mm);
        arch_enter_lazy_mmu_mode();

        for (; old_addr < old_end; old_pte++, old_addr +=3D PAGE_SIZE,
                                   new_pte++, new_addr +=3D PAGE_SIZE) {
                if (pte_none(ptep_get(old_pte)))
                        continue;

                pte =3D ptep_get_and_clear(mm, old_addr, old_pte);
       ....
}

This has two possibilities
1. new_pte is aligned with CONT_PTES, we can still keep CONTPTE;
2. new_pte is not aligned with CONT_PTES, we should drop CONTPTE
while copying.

does your code also handle this properly=EF=BC=9F

>
> Thanks for the review!
>
> Thanks,
> Ryan
>
> >
> > case0:
> > addr0 PTE - has no CONTPE
> > addr0+4kb PTE - has CONTPTE
> > ....
> > addr0+60kb PTE - has CONTPTE
> >
> > case 1:
> > addr0 PTE - has no CONTPE
> > addr0+4kb PTE - has CONTPTE
> > ....
> > addr0+60kb PTE - has swap
> >
> > Unconsistent 16 PTEs will lead to crash even in the firmware based on
> > our observation.
> >
> > Thanks
> > Barry

Thanks
Barry
