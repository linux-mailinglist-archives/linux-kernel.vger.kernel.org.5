Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B237FADB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjK0Wx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0Wx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:53:57 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0580A137
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:54:03 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7bb3e55c120so1403543241.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701125642; x=1701730442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4jTo4Nl5QOfj+i8ClgVWtaOb4p2NtBPY55Cf4vOdgU=;
        b=RPx9YO17skHPIfUO8X8QRqfAm2ws9mTBjMBHQl+EKNx9vtM2QVJxeFWyGuvmLN+3PK
         fnB2lGaJVykT+aKnqnawgwMM0yLigm9ljWslyZQkGNoPi4zdJ3PuEriH+m6DDvoFHIOE
         1E+aEZ/PXAG32ot9LaNtOL8KIAzHroIDHbyTEDClY9KFxHvWJ0IhCUGD02iYHbiBoUo6
         NZMiNrkFFq3a6m2eruJAOVESFZr1BUGhC/gcgf4p2a4dQC+8al7SDPfy76/VJLH9eTGZ
         w3+nZKQcIcY7zhwbLmoVP2gnRLn/sHkopIi7chz2GEA4a6c1617EY0BqMLThYzLHuCF8
         poCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701125642; x=1701730442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4jTo4Nl5QOfj+i8ClgVWtaOb4p2NtBPY55Cf4vOdgU=;
        b=RJmX5mLqpOjpwG+wdEKHo+/lSWmsXTACA4Hh6a7cbYUc0GmHnJs4CkVAFbfSQa1xg+
         8K74rfkbLC+8tUwIbGaX9jpAc6TX2TGwhAYD1G1rP3T/32tpTvL2ss9HYLNgZhpByYTx
         9+lX98hyRbXf5B6omtJroZ2KaxZJ4cGutJmWkpQ/rOZoD6Dl/3DkV3zOs5hr3T4/AAVI
         hYllcZ3WYNGNYSskWaX6oVTROrjmAI5RFMjLsyrTXgI1Sua5We+03i1lVVaitc3uOoH4
         j99ms34aIXcZrxFrx/MFuc5sJ7vfN4iBKhaKYTBFFL6e5GclEvV645V9X4tzKsnSAPlV
         BO3w==
X-Gm-Message-State: AOJu0YxzAEsLmGb4YMeXq+9VFRhy+xaRo+Klrtu3iRKVXkSmWe5HaQVL
        xqVojCtcxBYYLeiS/z0sIm4BJChCjyQ7tckaRUM=
X-Google-Smtp-Source: AGHT+IGekE2LN0Cg4u5BOtKEQozDVxDXNwhTBdKonUMT/PJ3qDvYv4NiD6tzxfknhNrzUH5mW9r5TH2UE5goMY4OYik=
X-Received: by 2002:a67:fb03:0:b0:462:d592:b078 with SMTP id
 d3-20020a67fb03000000b00462d592b078mr12636292vsr.32.1701125642060; Mon, 27
 Nov 2023 14:54:02 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231127031813.5576-1-v-songbaohua@oppo.com> <234021ba-73c2-474a-82f9-91e1604d5bb5@arm.com>
 <CAGsJ_4w3nGSO+CF-PQaHOVtzpb-RkZiWTqkg51ibT6dDo_EeJA@mail.gmail.com> <d11d713c-9c4e-4d26-9888-8cc843861785@arm.com>
In-Reply-To: <d11d713c-9c4e-4d26-9888-8cc843861785@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 28 Nov 2023 11:53:50 +1300
Message-ID: <CAGsJ_4yhHuT1Sra+vEzfFykYM3Jdm85q6fRydX_3QjwHL38UMA@mail.gmail.com>
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

On Tue, Nov 28, 2023 at 12:11=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 27/11/2023 10:35, Barry Song wrote:
> > On Mon, Nov 27, 2023 at 10:15=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
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
> >
> > I don't think it is safe to keep CONTPTE folded in a split_vma case. as
> > otherwise, copy_ptes in your other patch might only copy a part
> > of CONTPES.
> > For example,  if page0-page4 and page5-page15 are splitted in split_vma=
,
> > in fork, while copying pte for the first VMA, we are copying page0-page=
4,
> > this will immediately cause inconsistent CONTPTE. as we have to
> > make sure all CONTPTEs are atomically mapped in a PTL.
>
> No that's not how it works. The CONT_PTE bit is not blindly copied from p=
arent
> to child. It is explicitly managed by the arch code and set when appropri=
ate. In
> the case above, we will end up calling set_ptes() for page0-page4 in the =
child.
> set_ptes() will notice that there are only 5 contiguous pages so it will =
map
> without the CONT_PTE bit.

Ok. cool. alternatively, in the code I shared to you, we are doing an unfol=
d
immediately when split_vma happens within a large anon folio, so we disallo=
w
CONTPTE to cross two VMAs to avoid all kinds of complexity afterwards.

https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm=
8550_u_14.0.0_oneplus11/mm/huge_memory.c

#ifdef CONFIG_CONT_PTE_HUGEPAGE
void vma_adjust_cont_pte_trans_huge(struct vm_area_struct *vma,
    unsigned long start,
    unsigned long end,
    long adjust_next)
{
         /*
         * If the new start address isn't hpage aligned and it could
         * previously contain an hugepage: check if we need to split
         * an huge pmd.
         */
         if (start & ~HPAGE_CONT_PTE_MASK &&
             (start & HPAGE_CONT_PTE_MASK) >=3D vma->vm_start &&
             (start & HPAGE_CONT_PTE_MASK) + HPAGE_CONT_PTE_SIZE <=3D vma->=
vm_end)
                  split_huge_cont_pte_address(vma, start, false, NULL);

         ....
}
#endif

In your approach, you are still holding CONTPTE crossing two VMAs. but it s=
eems
ok. I can't have a case which might fail in my brain right now. only
running the code on
a large amount of real hardware will tell :-)

>
> >
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
> >>
> >> Thanks for the review!
> >>
> >> Thanks,
> >> Ryan
> >>
> >>>
> >>> case0:
> >>> addr0 PTE - has no CONTPE
> >>> addr0+4kb PTE - has CONTPTE
> >>> ....
> >>> addr0+60kb PTE - has CONTPTE
> >>>
> >>> case 1:
> >>> addr0 PTE - has no CONTPE
> >>> addr0+4kb PTE - has CONTPTE
> >>> ....
> >>> addr0+60kb PTE - has swap
> >>>
> >>> Unconsistent 16 PTEs will lead to crash even in the firmware based on
> >>> our observation.
> >>>
> >

Thanks
Barry
