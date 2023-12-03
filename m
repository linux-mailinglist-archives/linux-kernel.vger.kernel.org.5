Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE1F802808
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 22:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjLCVli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 16:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCVlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 16:41:37 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EF6C2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 13:41:43 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-46495e57cdeso16962137.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 13:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701639702; x=1702244502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DidZ9inAHikZu2d6qsTQyFDw8bvSjf3fWx5m6EwOzac=;
        b=DhL5RfZauR2G4vbYfotqa+W0ylMG1Sl8U4XdJHiIjEJlEYL1IKwnxD3Ruouw3ACrPN
         FWpFnGSJNWXaNW/xTQqWjeIEv2clnocIjAIUkqTdaIefEhMxJE+iSgiTqX+gt7Sb04ME
         OP1zo9JH1Q0pWLKpJ4HWEgzebeFpNilsLfhBOgSWAn50G+bIHf2qBNRLcYnEZ6+H80x/
         g5aPpAD0F5FGLChQ2f2MxWV/GAWoGyNaXYrGBYpRegcEuNDyAN8wUIOqC3rdL52bnIW/
         5ViOoR2n8QeHWWEpSP1iIQnq7Bggl1x1qsYwq2sPjf7oAEbmWrVOI1BaM5noddHe9TtA
         mGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701639702; x=1702244502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DidZ9inAHikZu2d6qsTQyFDw8bvSjf3fWx5m6EwOzac=;
        b=QawKuhG7EtT/BsxhShMdt6+OBrsJPVbV0N1TjmGNu6sb7JWjonTi/prCiKu0GoDUYK
         KShvpvn/WTEqxTFYdBzKjDwMczfk665jSPIo0UmkCobIvItNDnyhbrc83xHcDdZRssmd
         j/opMSN2NOitSP8sRFPN0+qF2+djCiGBH4V6PGBUMAaViUjK16jauluCTjzbwyKBTOpK
         m/2FxZ6lpqxpwRjSytb5W/eBOj+cLCzLMWO/oh0v7frws3hI/Gj0s7UoFREv0kx4xXXW
         4m2s50069Ru+ZZeNtcsiUCAAwi1KISxsIVChW2s/EY7IQqguc5dH+g8Qb7ucpuWnldCP
         qUeA==
X-Gm-Message-State: AOJu0YxzOUM73bydABL5OYCT1GQb2APPXGsJdE/Hl5ajCMqxlLBsyg/z
        jnBxAcBrvfOD4piELO5WOAlM+8Jm5c02UywEZPA=
X-Google-Smtp-Source: AGHT+IFV4tqkSOEuQG/MYf+di2ncGqYs2lWfsRSsfbo/sskGMRs8c/D5YASEYEUtun1i3Ls7Wo3+osnwsUoE8G6z4oo=
X-Received: by 2002:a1f:728b:0:b0:4b2:c554:e3f8 with SMTP id
 n133-20020a1f728b000000b004b2c554e3f8mr510978vkc.24.1701639702199; Sun, 03
 Dec 2023 13:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-15-ryan.roberts@arm.com>
 <20231128081742.39204-1-v-songbaohua@oppo.com> <207de995-6d48-41ea-8373-2f9caad9b9c3@arm.com>
 <CAGsJ_4wV-z7u5N3oLM-3kONHe0fmQwO7CSWQk9w0u0EhMroXAA@mail.gmail.com>
 <34da1e06-74da-4e45-b0b5-9c93d64eb64e@arm.com> <CAGsJ_4x78VhazGu3cA=W7Nc7yshwHTJjtFYHrCY1SOjC4__qfA@mail.gmail.com>
 <1d2f8e43-447e-4af4-96ac-1eefea7d6747@arm.com>
In-Reply-To: <1d2f8e43-447e-4af4-96ac-1eefea7d6747@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 4 Dec 2023 05:41:27 +0800
Message-ID: <CAGsJ_4xJ=VibK3FFGr5UHDQn+HW_o1_ZMiUjhgo8+i=UWa3UGQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to
 optimize process teardown
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

On Thu, Nov 30, 2023 at 8:00=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> >> Just because you found a pte that maps a page from a large folio, that=
 doesn't
> >> mean that all pages from the folio are mapped, and it doesn't mean the=
y are
> >> mapped contiguously. We have to deal with partial munmap(), partial mr=
emap()
> >> etc. We could split in these cases (and in future it might be sensible=
 to try),
> >> but that can fail (due to GUP). So we still have to handle the corner =
case.
> >>
> >> But I can imagine doing a batched version of ptep_get_and_clear(), lik=
e I did
> >> for ptep_set_wrprotects(). And I think this would be an improvement.
> >>
> >> The reason I haven't done that so far, is because ptep_get_and_clear()=
 returns
> >> the pte value when it was cleared and that's hard to do if batching du=
e to the
> >> storage requirement. But perhaps you could just return the logical OR =
of the
> >> dirty and young bits across all ptes in the batch. The caller should b=
e able to
> >> reconstitute the rest if it needs it?
> >>
> >> What do you think?
> >
> > I really don't know why we care about the return value of ptep_get_and_=
clear()
> > as zap_pte_range() doesn't ask for any ret value at all. so why not tot=
ally give
> > up this kind of complex logical OR of dirty and young as they are usele=
ss in
> > this case?
>
> That's not the case in v6.7-rc1:
>
>
> static unsigned long zap_pte_range(struct mmu_gather *tlb,
>                                 struct vm_area_struct *vma, pmd_t *pmd,
>                                 unsigned long addr, unsigned long end,
>                                 struct zap_details *details)
> {
>         ...
>
>         do {
>                 pte_t ptent =3D ptep_get(pte);
>
>                 ...
>
>                 if (pte_present(ptent)) {
>                         ...
>
>                         ptent =3D ptep_get_and_clear_full(mm, addr, pte,
>                                                         tlb->fullmm);
>                         arch_check_zapped_pte(vma, ptent);
>                         tlb_remove_tlb_entry(tlb, pte, addr);
>                         zap_install_uffd_wp_if_needed(vma, addr, pte, det=
ails,
>                                                       ptent);
>                         if (unlikely(!page)) {
>                                 ksm_might_unmap_zero_page(mm, ptent);
>                                 continue;
>                         }
>
>                         delay_rmap =3D 0;
>                         if (!PageAnon(page)) {
>                                 if (pte_dirty(ptent)) {
>                                         set_page_dirty(page);
>                                         if (tlb_delay_rmap(tlb)) {
>                                                 delay_rmap =3D 1;
>                                                 force_flush =3D 1;
>                                         }
>                                 }
>                                 if (pte_young(ptent) && likely(vma_has_re=
cency(vma)))
>                                         mark_page_accessed(page);
>                         }
>
>                         ...
>                 }
>
>                 ...
>         } while (pte++, addr +=3D PAGE_SIZE, addr !=3D end);
>
>         ...
> }
>
> Most importantly, file-backed mappings need the access/dirty bits to prop=
agate that information back to the folio, so it will be written back to dis=
k. x86 is also looking at the dirty bit in arch_check_zapped_pte(), and ksm=
 is using it in ksm_might_unmap_zero_page().
>
> Probably for your use case of anon memory on arm64 on a phone, you don't =
need the return value. But my solution is also setting cotnpte for file-bac=
ked memory, and there are performance wins to be had there, especially for =
executable mappings where contpte reduces iTLB pressure. (I have other work=
 which ensures these file-backed mappings are in correctly-sized large foli=
os).
>
> So I don't think we can just do a clear without the get part. But I think=
 I have a solution in the shape of clear_ptes(), as described in the other =
thread, which gives the characteristics you suggest.

understood. i realized OPPO's code actually also returned logic OR of
dirty and access bits while it exposes
CONTPTE to mm-core [1]:

static pte_t get_clear_flush(struct mm_struct *mm,
                             unsigned long addr,
                             pte_t *ptep,
                             unsigned long pgsize,
                             unsigned long ncontig,
                             bool flush)
{
        pte_t orig_pte =3D ptep_get(ptep);
        bool valid =3D pte_valid(orig_pte);
        unsigned long i, saddr =3D addr;

        for (i =3D 0; i < ncontig; i++, addr +=3D pgsize, ptep++) {
                pte_t pte =3D ptep_get_and_clear(mm, addr, ptep);

                if (pte_dirty(pte))
                        orig_pte =3D pte_mkdirty(orig_pte);

                if (pte_young(pte))
                        orig_pte =3D pte_mkyoung(orig_pte);
        }

        if (valid && flush) {
                struct vm_area_struct vma =3D TLB_FLUSH_VMA(mm, 0);

                flush_tlb_range(&vma, saddr, addr);
        }
        return orig_pte;
}

static inline pte_t __cont_pte_huge_ptep_get_and_clear_flush(struct
mm_struct *mm,
                                       unsigned long addr,
                                       pte_t *ptep,
                                       bool flush)
{
        pte_t orig_pte =3D ptep_get(ptep);

        CHP_BUG_ON(!pte_cont(orig_pte));
        CHP_BUG_ON(!IS_ALIGNED(addr, HPAGE_CONT_PTE_SIZE));
        CHP_BUG_ON(!IS_ALIGNED(pte_pfn(orig_pte), HPAGE_CONT_PTE_NR));

        return get_clear_flush(mm, addr, ptep, PAGE_SIZE, CONT_PTES, flush)=
;
}

[1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplu=
s/sm8550_u_14.0.0_oneplus11/mm/cont_pte_hugepage.c#L1421

>
>
> >
> > Is it possible for us to introduce a new api like?
> >
> > bool clear_folio_ptes(folio, ptep)
> > {
> >     if(ptes are contiguous mapped) {
> >            clear all ptes all together    // this also clears all CONTP=
TE
> >            return true;
> >     }
> >     return false;
> > }
> >
> > in zap_pte_range():
> >
> > if (large_folio(folio) && clear_folio_ptes(folio, ptep)) {
> >          addr +=3D nr - 1
> >          pte +=3D nr  -1
> > } else
> >          old path.
> >
> >
> >>
> >>>
> >>> zap_pte_range is the most frequent behaviour from userspace libc heap
> >>> as i explained
> >>> before. libc can call madvise(DONTNEED) the most often. It is crucial
> >>> to performance.
> >>>
> >>> and this way can also help drop your full version by moving to full
> >>> flushing the whole
> >>> large folios? and we don't need to depend on fullmm any more?
> >>>
> >>>>
> >>>> I don't think there is any correctness issue here. But there is a pr=
oblem with
> >>>> fragility, as raised by Alistair. I have some ideas on potentially h=
ow to solve
> >>>> that. I'm going to try to work on it this afternoon and will post if=
 I get some
> >>>> confidence that it is a real solution.
> >>>>
> >>>> Thanks,
> >>>> Ryan
> >>>>
> >>>>>
> >>>>> static inline pte_t __cont_pte_huge_ptep_get_and_clear_flush(struct=
 mm_struct *mm,
> >>>>>                                      unsigned long addr,
> >>>>>                                      pte_t *ptep,
> >>>>>                                      bool flush)
> >>>>> {
> >>>>>       pte_t orig_pte =3D ptep_get(ptep);
> >>>>>
> >>>>>       CHP_BUG_ON(!pte_cont(orig_pte));
> >>>>>       CHP_BUG_ON(!IS_ALIGNED(addr, HPAGE_CONT_PTE_SIZE));
> >>>>>       CHP_BUG_ON(!IS_ALIGNED(pte_pfn(orig_pte), HPAGE_CONT_PTE_NR))=
;
> >>>>>
> >>>>>       return get_clear_flush(mm, addr, ptep, PAGE_SIZE, CONT_PTES, =
flush);
> >>>>> }
> >>>>>
> >>>>> [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blo=
b/oneplus/sm8550_u_14.0.0_oneplus11/mm/memory.c#L1539
> >>>>>
> >>>>>> +     */
> >>>>>> +
> >>>>>> +    return __ptep_get_and_clear(mm, addr, ptep);
> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
> >>>>>> +
> >>>>>
> >>>
> >  Thanks
> >  Barry
>
