Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4657FC45A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 20:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjK1Th5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 14:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjK1Thz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 14:37:55 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE25319B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:37:59 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4abf8ba3e4fso1862422e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 11:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701200279; x=1701805079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3Gm6/DIYApCGqZzJw3xggCyDpCzeOTMLSM+4LpuTjg=;
        b=h2jLfLUXLEt2IPqADKR/5VTZlj2jn3j/vopDOMTMc+SdsfJ9b0L8hLYJ/sD6Dfziwx
         xMzESiSfk+OXz1a9pgriKfi6+9EWgPU5GOZu9EFf1XdDCUDDaVfAkwSBzxCmTQgwAeKp
         Vt4+Lu7kivaspHEMJY3jYizsposUEndPNt0cimk8s4cv4O42WG3Lz7LK6VU0hMKPlYMS
         529ArA4xViQF8d90VSkZfX0rfP8Wys0ICq0ZeUVq/0dSj465WfT89KVJhX6GgVhLMsJ7
         1uSXFyPZkmJfS0lHuVm0K/ib8v8D3qCqhzwY+oNFt1+8brwFqTEd3rpqfqJ6QT1Ac24/
         YISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701200279; x=1701805079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3Gm6/DIYApCGqZzJw3xggCyDpCzeOTMLSM+4LpuTjg=;
        b=Dr3kR/cJcg/1MrF+GvF4LvF4LR0JbOE62DKhHwfN9NJq3zqfl5UGUoSGJav2VWblOd
         n0IbTrtEOXr9lY4ZAsnty8KdHKU7/F7DBW/g9YrZ9GJBqbcRODsFxKFiRetuBuV3+zdY
         YLoBrexJsQhVfPPGs85htlfrQsxqUBMQfSVYOpcEM1EdD5hEZLgCSeiB9hXSV4Xc23eB
         66VsnsUqc5mYMWUCyrenxU16eKdRMnC06JDpTO2uFvtXmqbG13gvtE7hKwv/OO9hwgch
         b+VLjxhgKgcY1zz3qxgHfaiLHC52eszA+mawJP2OYAjdHL1haOCJdK1AibTkBrtbEmiq
         xOzg==
X-Gm-Message-State: AOJu0YzkoUWjngqAYXD8OIftfszuIoDEVEdhDdv3Gd5WMEBsk1Mcbmtl
        gJbo+5YQBdyFt+4snxbaqETgbp4ICJOSgZarxqc=
X-Google-Smtp-Source: AGHT+IGir5jTOY7RKQD/AnoE6vdw0pLitauMeJc2rnR87SBafSDEKTjLOF8lJSFz9e5TIPpYUFgai5KS5hrLHnTDgGk=
X-Received: by 2002:a05:6122:c98:b0:4a8:4218:804b with SMTP id
 ba24-20020a0561220c9800b004a84218804bmr15605885vkb.12.1701200278658; Tue, 28
 Nov 2023 11:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231127031813.5576-1-v-songbaohua@oppo.com> <234021ba-73c2-474a-82f9-91e1604d5bb5@arm.com>
 <CAGsJ_4wTtwAMydZMzWFQghN+3xGcw3fa6iCfQpPRoqP-Tjf5dA@mail.gmail.com> <3e61d181-5e8d-4103-8dee-e18e493bc125@arm.com>
In-Reply-To: <3e61d181-5e8d-4103-8dee-e18e493bc125@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 29 Nov 2023 08:37:47 +1300
Message-ID: <CAGsJ_4yLNEDtq5iv0BD96LfdbKzB5KqL0xDcuLGSXBKT02tk+g@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 1:08=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 28/11/2023 05:49, Barry Song wrote:
> > On Mon, Nov 27, 2023 at 5:15=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 27/11/2023 03:18, Barry Song wrote:
> >>>> Ryan Roberts (14):
> >>>>   mm: Batch-copy PTE ranges during fork()
> >>>>   arm64/mm: set_pte(): New layer to manage contig bit
> >>>>   arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
> >>>>   arm64/mm: pte_clear(): New layer to manage contig bit
> >>>>   arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
> >>>>   arm64/mm: ptep_test_and_clear_young(): New layer to manage contig =
bit
> >>>>   arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
> >>>>   arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
> >>>>   arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
> >>>>   arm64/mm: ptep_get(): New layer to manage contig bit
> >>>>   arm64/mm: Split __flush_tlb_range() to elide trailing DSB
> >>>>   arm64/mm: Wire up PTE_CONT for user mappings
> >>>>   arm64/mm: Implement ptep_set_wrprotects() to optimize fork()
> >>>>   arm64/mm: Add ptep_get_and_clear_full() to optimize process teardo=
wn
> >>>
> >>> Hi Ryan,
> >>> Not quite sure if I missed something, are we splitting/unfolding CONT=
PTES
> >>> in the below cases
> >>
> >> The general idea is that the core-mm sets the individual ptes (one at =
a time if
> >> it likes with set_pte_at(), or in a block with set_ptes()), modifies i=
ts
> >> permissions (ptep_set_wrprotect(), ptep_set_access_flags()) and clears=
 them
> >> (ptep_clear(), etc); This is exactly the same interface as previously.
> >>
> >> BUT, the arm64 implementation of those interfaces will now detect when=
 a set of
> >> adjacent PTEs (a contpte block - so 16 naturally aligned entries when =
using 4K
> >> base pages) are all appropriate for having the CONT_PTE bit set; in th=
is case
> >> the block is "folded". And it will detect when the first PTE in the bl=
ock
> >> changes such that the CONT_PTE bit must now be unset ("unfolded"). One=
 of the
> >> requirements for folding a contpte block is that all the pages must be=
long to
> >> the *same* folio (that means its safe to only track access/dirty for t=
hecontpte
> >> block as a whole rather than for each individual pte).
> >>
> >> (there are a couple of optimizations that make the reality slightly mo=
re
> >> complicated than what I've just explained, but you get the idea).
> >>
> >> On that basis, I believe all the specific cases you describe below are=
 all
> >> covered and safe - please let me know if you think there is a hole her=
e!
> >>
> >>>
> >>> 1. madvise(MADV_DONTNEED) on a part of basepages on a CONTPTE large f=
olio
> >>
> >> The page will first be unmapped (e.g. ptep_clear() or ptep_get_and_cle=
ar(), or
> >> whatever). The implementation of that will cause an unfold and the CON=
T_PTE bit
> >> is removed from the whole contpte block. If there is then a subsequent
> >> set_pte_at() to set a swap entry, the implementation will see that its=
 not
> >> appropriate to re-fold, so the range will remain unfolded.
> >>
> >>>
> >>> 2. vma split in a large folio due to various reasons such as mprotect=
,
> >>> munmap, mlock etc.
> >>
> >> I'm not sure if PTEs are explicitly unmapped/remapped when splitting a=
 VMA? I
> >> suspect not, so if the VMA is split in the middle of a currently folde=
d contpte
> >> block, it will remain folded. But this is safe and continues to work c=
orrectly.
> >> The VMA arrangement is not important; it is just important that a sing=
le folio
> >> is mapped contiguously across the whole block.
> >>
> >>>
> >>> 3. try_to_unmap_one() to reclaim a folio, ptes are scanned one by one
> >>> rather than being as a whole.
> >>
> >> Yes, as per 1; the arm64 implementation will notice when the first ent=
ry is
> >> cleared and unfold the contpte block.
> >>
> >>>
> >>> In hardware, we need to make sure CONTPTE follow the rule - always 16
> >>> contiguous physical address with CONTPTE set. if one of them run away
> >>> from the 16 ptes group and PTEs become unconsistent, some terrible
> >>> errors/faults can happen in HW. for example
> >>
> >> Yes, the implementation obeys all these rules; see contpte_try_fold() =
and
> >> contpte_try_unfold(). the fold/unfold operation is only done when all
> >> requirements are met, and we perform it in a manner that is conformant=
 to the
> >> architecture requirements (see contpte_fold() - being renamed to
> >> contpte_convert() in the next version).
> >
> > Hi Ryan,
> >
> > sorry for too many comments, I remembered another case
> >
> > 4. mremap
> >
> > a CONTPTE might be remapped to another address which might not be
> > aligned with 16*basepage. thus, in move_ptes(), we are copying CONPTEs
> > from src to dst.
> > static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
> >                 unsigned long old_addr, unsigned long old_end,
> >                 struct vm_area_struct *new_vma, pmd_t *new_pmd,
> >                 unsigned long new_addr, bool need_rmap_locks)
> > {
> >         struct mm_struct *mm =3D vma->vm_mm;
> >         pte_t *old_pte, *new_pte, pte;
> >         ...
> >
> >         /*
> >          * We don't have to worry about the ordering of src and dst
> >          * pte locks because exclusive mmap_lock prevents deadlock.
> >          */
> >         old_pte =3D pte_offset_map_lock(mm, old_pmd, old_addr, &old_ptl=
);
> >         if (!old_pte) {
> >                 err =3D -EAGAIN;
> >                 goto out;
> >         }
> >         new_pte =3D pte_offset_map_nolock(mm, new_pmd, new_addr, &new_p=
tl);
> >         if (!new_pte) {
> >                 pte_unmap_unlock(old_pte, old_ptl);
> >                 err =3D -EAGAIN;
> >                 goto out;
> >         }
> >         if (new_ptl !=3D old_ptl)
> >                 spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
> >         flush_tlb_batched_pending(vma->vm_mm);
> >         arch_enter_lazy_mmu_mode();
> >
> >         for (; old_addr < old_end; old_pte++, old_addr +=3D PAGE_SIZE,
> >                                    new_pte++, new_addr +=3D PAGE_SIZE) =
{
> >                 if (pte_none(ptep_get(old_pte)))
> >                         continue;
> >
> >                 pte =3D ptep_get_and_clear(mm, old_addr, old_pte);
> >        ....
> > }
> >
> > This has two possibilities
> > 1. new_pte is aligned with CONT_PTES, we can still keep CONTPTE;
> > 2. new_pte is not aligned with CONT_PTES, we should drop CONTPTE
> > while copying.
> >
> > does your code also handle this properly=EF=BC=9F
>
> Yes; same mechanism - the arm64 arch code does the CONT_PTE bit managemen=
t and
> folds/unfolds as neccessary.
>
> Admittedly this may be non-optimal because we are iterating a single PTE =
at a
> time. When we clear the first pte of a contpte block in the source, the b=
lock
> will be unfolded. When we set the last pte of the contpte block in the de=
st, the
> block will be folded. If we had a batching mechanism, we could just clear=
 the
> whole source contpte block in one hit (no need to unfold first) and we co=
uld
> just set the dest contpte block in one hit (no need to fold at the end).
>
> I haven't personally seen this as a hotspot though; I don't know if you h=
ave any
> data to the contrary? I've followed this type of batching technique for t=
he fork
> case (patch 13). We could do a similar thing in theory, but its a bit mor=
e

in my previous testing, i don't see mremap quite often, so no worries.
as long as it is bug-free,
it is fine to me though a mremap microbench will definitely lose :-)

> complex because of the ptep_get_and_clear() return value; you would need =
to
> return all ptes for the cleared range, or somehow collapse the actual inf=
o that
> the caller requires (presumably access/dirty info).
>

Thanks
Barry
