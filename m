Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7BC7FC541
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbjK1UYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjK1UX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:23:57 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6629893
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:24:03 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7ba75345e71so1911461241.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701203042; x=1701807842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFSKYAwLLr04eh+vVEp6SSPOAXKBW77ZjLnzCS5PLp4=;
        b=jisJPOWzzHiHlywQxYEjuYNpSN5wg7pseUnNyhLVCpD1Hm6RwuvxZrGy3pphQVqW/W
         wTx2fAKn70yfdVy7EUpsVuhk+Qrogvurpp1k2w/kG9VqfXR1D2ymBC77p5zPQjUYTSTt
         6hjBYuytenR2k3iYHtFpi0fgBSw5WpaU5+0oAWlgECoXao9LMGXYgbOzrBKv9t9HypOL
         KBsvPd4M6/iO5kuEZZTBsEf+0y62JCmHaJnVEj6gM5qrRiRiJ0Ae0OvR89mvSehrwEYT
         8uvV+0qLcRlz9ZbuxgiKtpsTi0gEeCR5G3BQwZ3/YYs5FIrZ9OPptqTTIyo4EMSySO9D
         to8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701203042; x=1701807842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFSKYAwLLr04eh+vVEp6SSPOAXKBW77ZjLnzCS5PLp4=;
        b=I2FmThKXSpkabcNAe1GOnoXqW6po9pttpcKOGaNwQogy8AOXr7ife+E7UInifNF+0K
         Snp0NS0tE74bEkbVLd7xOL6b7sdNiPEgaNGJg3toTy3CNWiqJ0/L8bzM7WwUQZgGDbVo
         k9tPlZjw5wsK2gX1GkgFbw7dkiCLnpy3IeX7j4tYdUNTjtAC+914sKyTwbam0foogYZV
         xkViEIFNj2QqDlBV9W3Wwrzjc0mo2b3yWCoyhvpkmCqh8r6ce2fkZ7jjLzlGLEknV0QP
         38gzOk2Tf7e0CXQSPvhlOMcxI7DGvYhXQVdNw4BQY8X0FuqrEkk6iSgjMZC2PWtxnLGN
         X+ew==
X-Gm-Message-State: AOJu0YxrGCzn1srWJGRVq7QWi+hpqa7fj1iBZod0M1QKjvVN2Ev7NQuK
        TAlgoX8L7/dqZfLDT/l6HDkaUvjj/jkayZ7uvwI=
X-Google-Smtp-Source: AGHT+IGyQAsHSanRpeOW3ExhYoboTHRlINbyUtuzj5/GesB904sSicagSOUcFEkNF1NT0DbQpgpkJkw+c6iw0exRmE0=
X-Received: by 2002:a05:6122:16a8:b0:4a4:cd2:5ebe with SMTP id
 40-20020a05612216a800b004a40cd25ebemr12311779vkl.12.1701203041863; Tue, 28
 Nov 2023 12:24:01 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-15-ryan.roberts@arm.com>
 <20231128081742.39204-1-v-songbaohua@oppo.com> <207de995-6d48-41ea-8373-2f9caad9b9c3@arm.com>
In-Reply-To: <207de995-6d48-41ea-8373-2f9caad9b9c3@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 29 Nov 2023 09:23:50 +1300
Message-ID: <CAGsJ_4wV-z7u5N3oLM-3kONHe0fmQwO7CSWQk9w0u0EhMroXAA@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 12:49=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 28/11/2023 08:17, Barry Song wrote:
> >> +pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
> >> +                                    unsigned long addr, pte_t *ptep)
> >> +{
> >> +    /*
> >> +     * When doing a full address space teardown, we can avoid unfoldi=
ng the
> >> +     * contiguous range, and therefore avoid the associated tlbi. Ins=
tead,
> >> +     * just get and clear the pte. The caller is promising to call us=
 for
> >> +     * every pte, so every pte in the range will be cleared by the ti=
me the
> >> +     * tlbi is issued.
> >> +     *
> >> +     * This approach is not perfect though, as for the duration betwe=
en
> >> +     * returning from the first call to ptep_get_and_clear_full() and=
 making
> >> +     * the final call, the contpte block in an intermediate state, wh=
ere
> >> +     * some ptes are cleared and others are still set with the PTE_CO=
NT bit.
> >> +     * If any other APIs are called for the ptes in the contpte block=
 during
> >> +     * that time, we have to be very careful. The core code currently
> >> +     * interleaves calls to ptep_get_and_clear_full() with ptep_get()=
 and so
> >> +     * ptep_get() must be careful to ignore the cleared entries when
> >> +     * accumulating the access and dirty bits - the same goes for
> >> +     * ptep_get_lockless(). The only other calls we might resonably e=
xpect
> >> +     * are to set markers in the previously cleared ptes. (We shouldn=
't see
> >> +     * valid entries being set until after the tlbi, at which point w=
e are
> >> +     * no longer in the intermediate state). Since markers are not va=
lid,
> >> +     * this is safe; set_ptes() will see the old, invalid entry and w=
ill not
> >> +     * attempt to unfold. And the new pte is also invalid so it won't
> >> +     * attempt to fold. We shouldn't see this for the 'full' case any=
way.
> >> +     *
> >> +     * The last remaining issue is returning the access/dirty bits. T=
hat
> >> +     * info could be present in any of the ptes in the contpte block.
> >> +     * ptep_get() will gather those bits from across the contpte bloc=
k. We
> >> +     * don't bother doing that here, because we know that the informa=
tion is
> >> +     * used by the core-mm to mark the underlying folio as accessed/d=
irty.
> >> +     * And since the same folio must be underpinning the whole block =
(that
> >> +     * was a requirement for folding in the first place), that inform=
ation
> >> +     * will make it to the folio eventually once all the ptes have be=
en
> >> +     * cleared. This approach means we don't have to play games with
> >> +     * accumulating and storing the bits. It does mean that any inter=
leaved
> >> +     * calls to ptep_get() may lack correct access/dirty information =
if we
> >> +     * have already cleared the pte that happened to store it. The co=
re code
> >> +     * does not rely on this though.
> >
> > even without any other threads running and touching those PTEs, this wo=
n't survive
> > on some hardware. we expose inconsistent CONTPTEs to hardware, this mig=
ht result
>
> No that's not the case; if you read the Arm ARM, the page table is only
> considered "misgrogrammed" when *valid* entries within the same contpte b=
lock
> have different values for the contiguous bit. We are clearing the ptes to=
 zero
> here, which is an *invalid* entry. So if the TLB entry somehow gets inval=
idated
> (either due to explicit tlbi as you point out below, or due to a concurre=
nt TLB
> miss which selects our entry for removal to make space for the new incomm=
ing
> entry), then it gets an access request for an address in our partially cl=
eared
> contpte block the address will either be:
>
> A) an address for a pte entry we have already cleared, so its invalid and=
 it
> will fault (and get serialized behind the PTL).
>
> or
>
> B) an address for a pte entry we haven't yet cleared, so it will reform a=
 TLB
> entry for the contpte block. But that's ok because the memory still exist=
s
> because we haven't yet finished clearing the page table and have not yet =
issued
> the final tlbi.
>
>
> > in crashed firmware even in trustzone, strange&unknown faults to trustz=
one we have
> > seen on Qualcomm, but for MTK, it seems fine. when you do tlbi on a par=
t of PTEs
> > with dropped CONT but still some other PTEs have CONT, we make hardware=
 totally
> > confused.
>
> I suspect this is because in your case you are "misprogramming" the contp=
te
> block; there are *valid* pte entries within the block that disagree about=
 the
> contiguous bit or about various other fields. In this case some HW TLB de=
signs
> can do weird things. I suspect in your case, that's resulting in accessin=
g bad
> memory space and causing an SError, which is trapped by EL3, and the FW i=
s
> probably just panicking at that point.

you are probably right. as we met the SError, we became very very
cautious. so anytime
when we flush tlb for a CONTPTE, we strictly do it by
1. set all 16 ptes to zero
2. flush the whole 16 ptes

in your case, it can be:
1. set pte0 to zero
2. flush pte0

TBH, i have never tried this. but it might be safe according to your
description.

>
> >
> > zap_pte_range() has a force_flush when tlbbatch is full:
> >
> >                         if (unlikely(__tlb_remove_page(tlb, page, delay=
_rmap))) {
> >                                 force_flush =3D 1;
> >                                 addr +=3D PAGE_SIZE;
> >                                 break;
> >                         }
> >
> > this means you can expose partial tlbi/flush directly to hardware while=
 some
> > other PTEs are still CONT.
>
> Yes, but that's also possible even if we have a tight loop that clears do=
wn the
> contpte block; there could still be another core that issues a tlbi while=
 you're
> halfway through that loop, or the HW could happen to evict due to TLB pre=
ssure
> at any time. The point is, it's safe if you are clearing the pte to an *i=
nvalid*
> entry.
>
> >
> > on the other hand, contpte_ptep_get_and_clear_full() doesn't need to de=
pend
> > on fullmm, as long as zap range covers a large folio, we can flush tlbi=
 for
> > those CONTPTEs all together in your contpte_ptep_get_and_clear_full() r=
ather
> > than clearing one PTE.
> >
> > Our approach in [1] is we do a flush for all CONTPTEs and go directly t=
o the end
> > of the large folio:
> >
> > #ifdef CONFIG_CONT_PTE_HUGEPAGE
> >                       if (pte_cont(ptent)) {
> >                               unsigned long next =3D pte_cont_addr_end(=
addr, end);
> >
> >                               if (next - addr !=3D HPAGE_CONT_PTE_SIZE)=
 {
> >                                       __split_huge_cont_pte(vma, pte, a=
ddr, false, NULL, ptl);
> >                                       /*
> >                                        * After splitting cont-pte
> >                                        * we need to process pte again.
> >                                        */
> >                                       goto again_pte;
> >                               } else {
> >                                       cont_pte_huge_ptep_get_and_clear(=
mm, addr, pte);
> >
> >                                       tlb_remove_cont_pte_tlb_entry(tlb=
, pte, addr);
> >                                       if (unlikely(!page))
> >                                               continue;
> >
> >                                       if (is_huge_zero_page(page)) {
> >                                               tlb_remove_page_size(tlb,=
 page, HPAGE_CONT_PTE_SIZE);
> >                                               goto cont_next;
> >                                       }
> >
> >                                       rss[mm_counter(page)] -=3D HPAGE_=
CONT_PTE_NR;
> >                                       page_remove_rmap(page, true);
> >                                       if (unlikely(page_mapcount(page) =
< 0))
> >                                               print_bad_pte(vma, addr, =
ptent, page);
> >
> >                                       tlb_remove_page_size(tlb, page, H=
PAGE_CONT_PTE_SIZE);
> >                               }
> > cont_next:
> >                               /* "do while()" will do "pte++" and "addr=
 + PAGE_SIZE" */
> >                               pte +=3D (next - PAGE_SIZE - (addr & PAGE=
_MASK))/PAGE_SIZE;
> >                               addr =3D next - PAGE_SIZE;
> >                               continue;
> >                       }
> > #endif
> >
> > this is our "full" counterpart, which clear_flush CONT_PTES pages direc=
tly, and
> > it never requires tlb->fullmm at all.
>
> Yes, but you are benefitting from the fact that contpte is exposed to cor=
e-mm
> and it is special-casing them at this level. I'm trying to avoid that.

I am thinking we can even do this while we don't expose CONTPTE.
if zap_pte_range meets a large folio and the zap_range covers the whole
folio, we can flush all ptes in this folio and jump to the end of this foli=
o?
i mean

if (folio head && range_end > folio_end) {
         nr =3D folio_nr_page(folio);
         full_flush_nr_ptes()
         pte +=3D nr -1;
         addr +=3D (nr - 1) * basepage size
}

zap_pte_range is the most frequent behaviour from userspace libc heap
as i explained
before. libc can call madvise(DONTNEED) the most often. It is crucial
to performance.

and this way can also help drop your full version by moving to full
flushing the whole
large folios? and we don't need to depend on fullmm any more?

>
> I don't think there is any correctness issue here. But there is a problem=
 with
> fragility, as raised by Alistair. I have some ideas on potentially how to=
 solve
> that. I'm going to try to work on it this afternoon and will post if I ge=
t some
> confidence that it is a real solution.
>
> Thanks,
> Ryan
>
> >
> > static inline pte_t __cont_pte_huge_ptep_get_and_clear_flush(struct mm_=
struct *mm,
> >                                      unsigned long addr,
> >                                      pte_t *ptep,
> >                                      bool flush)
> > {
> >       pte_t orig_pte =3D ptep_get(ptep);
> >
> >       CHP_BUG_ON(!pte_cont(orig_pte));
> >       CHP_BUG_ON(!IS_ALIGNED(addr, HPAGE_CONT_PTE_SIZE));
> >       CHP_BUG_ON(!IS_ALIGNED(pte_pfn(orig_pte), HPAGE_CONT_PTE_NR));
> >
> >       return get_clear_flush(mm, addr, ptep, PAGE_SIZE, CONT_PTES, flus=
h);
> > }
> >
> > [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/on=
eplus/sm8550_u_14.0.0_oneplus11/mm/memory.c#L1539
> >
> >> +     */
> >> +
> >> +    return __ptep_get_and_clear(mm, addr, ptep);
> >> +}
> >> +EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
> >> +
> >

Thanks
Barry

>
