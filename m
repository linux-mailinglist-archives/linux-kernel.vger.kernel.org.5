Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA77E4A21
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjKGUvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKGUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:51:02 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2772310CC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:51:00 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-4a13374a1e8so2661491e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699390259; x=1699995059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vekju1KMs5CW5Xn64e+qJMXt5jILCHDisKThefITH0I=;
        b=fhvUYUaa+tw3w+quHMwLdX2zATGgmY5Qdw7Vka606MFfFDnGG5FnME4rK6KoJfu7fJ
         VYCmGXn094MFUOm9U1ICBy6FDH40O8u+ZR/vLxy94J6A7E+Lgida4ADKX0O6RxbRxOsC
         UDMrJZjdzcezqqSKRLjyx8mfjsGg80yOyZqq1wMR8Liqnd6dpeJeYfhvYsiP+R4kgMmI
         VRElbM/4yPXLLrWs1YJ3C6pRpMrnwVtf1b48qbD5c0F2zpmGQa237KJ0ykIGAOJk80yJ
         G7dtYqXN8R/z2RpehwVi93WEF76/jpq1F5T89nx0SxKjPpvEbBEWEfi26b0Ry7b+SZs2
         /2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699390259; x=1699995059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vekju1KMs5CW5Xn64e+qJMXt5jILCHDisKThefITH0I=;
        b=jTzdUxPH0qFoPxJr/7w+KguZ3RHohinw5k73pav1iKbq6ubYH4AKO4oxuOxtuJZZal
         +HgshAOOhFpmYwhEfBO+4mCB9lI9OgGL6SrcUlW4KLU9iMVmcK+q6ythDHfRRFAbqOOb
         HhxiTgFSBA4KeP8j/a8YqAJRg/KOypxfoTJyIrrb6LGKBSaCn4eIKO5gqWEjdCy4x4yE
         74smfM4dEKV2gbXygLJOaRx3tOXwwONOWIJaY7/NNDzyZxk03EtQE7FMWnFcvx9D/mok
         YC80LFVXfvhqj9g5vGQiP2rSLkkZ8UF1l8wgfLos1aetPedFg2vtxBkS0adoZGuxiu6W
         CjbA==
X-Gm-Message-State: AOJu0Ywp+xkYT6Rmk8QpToCUIDtAs6WsQCZaABNXlmSxj/6RLBhBxmvi
        f/nDOLrFTbOG5vDQOh+FCzdTlCwc9WbJ6BVq2cI=
X-Google-Smtp-Source: AGHT+IEsjhCBSQNPhCIobyEzL+51aFPawFNigHITYI3WoLoOE4v8jd4TaQrJzQhU+TdlDhqgBUwGES1YCX/c5SwRqe4=
X-Received: by 2002:a05:6102:23f7:b0:457:bc52:9b04 with SMTP id
 p23-20020a05610223f700b00457bc529b04mr27393994vsc.35.1699390259218; Tue, 07
 Nov 2023 12:50:59 -0800 (PST)
MIME-Version: 1.0
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <44e32b0e-0e41-4055-bdb9-15bc7d47197c@intel.com> <20231107101221.GB18944@willie-the-truck>
In-Reply-To: <20231107101221.GB18944@willie-the-truck>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 8 Nov 2023 04:50:46 +0800
Message-ID: <CAGsJ_4z3hTeOnMct4wZwDPQzWRn2h4as=-+82DSTT45RH7dQeA@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Will Deacon <will@kernel.org>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, akpm@linux-foundation.org,
        v-songbaohua@oppo.com, yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 6:12=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Oct 25, 2023 at 09:39:19AM +0800, Yin, Fengwei wrote:
> >
> > >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/a=
sm/pgtable.h
> > >> index 0bd18de9fd97..2979d796ba9d 100644
> > >> --- a/arch/arm64/include/asm/pgtable.h
> > >> +++ b/arch/arm64/include/asm/pgtable.h
> > >> @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(st=
ruct vm_area_struct *vma,
> > >>  static inline int ptep_clear_flush_young(struct vm_area_struct *vma=
,
> > >>                                          unsigned long address, pte_=
t *ptep)
> > >>  {
> > >> -       int young =3D ptep_test_and_clear_young(vma, address, ptep);
> > >> -
> > >> -       if (young) {
> > >> -               /*
> > >> -                * We can elide the trailing DSB here since the wors=
t that can
> > >> -                * happen is that a CPU continues to use the young e=
ntry in its
> > >> -                * TLB and we mistakenly reclaim the associated page=
. The
> > >> -                * window for such an event is bounded by the next
> > >> -                * context-switch, which provides a DSB to complete =
the TLB
> > >> -                * invalidation.
> > >> -                */
> > >> -               flush_tlb_page_nosync(vma, address);
> > >> -       }
> > >> -
> > >> -       return young;
> > >> +       /*
> > >> +        * This comment is borrowed from x86, but applies equally to=
 ARM64:
> > >> +        *
> > >> +        * Clearing the accessed bit without a TLB flush doesn't cau=
se
> > >> +        * data corruption. [ It could cause incorrect page aging an=
d
> > >> +        * the (mistaken) reclaim of hot pages, but the chance of th=
at
> > >> +        * should be relatively low. ]
> > >> +        *
> > >> +        * So as a performance optimization don't flush the TLB when
> > >> +        * clearing the accessed bit, it will eventually be flushed =
by
> > >> +        * a context switch or a VM operation anyway. [ In the rare
> > >> +        * event of it not getting flushed for a long time the delay
> > >> +        * shouldn't really matter because there's no real memory
> > >> +        * pressure for swapout to react to. ]
> > >> +        */
> > >> +       return ptep_test_and_clear_young(vma, address, ptep);
> > >>  }
> > From https://lore.kernel.org/lkml/20181029105515.GD14127@arm.com/:
> >
> > This is blindly copied from x86 and isn't true for us: we don't invalid=
ate
> > the TLB on context switch. That means our window for keeping the stale
> > entries around is potentially much bigger and might not be a great idea=
.
>
> I completely agree.
>
> > My understanding is that arm64 doesn't do invalidate the TLB during
> > context switch. The flush_tlb_page_nosync() here + DSB during context
> > switch make sure the TLB is invalidated during context switch.
> > So we can't remove flush_tlb_page_nosync() here? Or something was chang=
ed
> > for arm64 (I have zero knowledge to TLB on arm64. So some obvious thing
> > may be missed)? Thanks.
>
> As you point out, we already elide the DSB here but I don't think we shou=
ld
> remove the TLB invalidation entirely because then we lose the guarantee
> that the update ever becomes visible to the page-table walker.
>
> I'm surprised that the TLBI is showing up as a performance issue without
> the DSB present. Is it because we're walking over a large VA range and
> invalidating on a per-page basis? If so, we'd be better off batching them

nop. in lru cases, there are thousands of pages in LRU list. doing vmscan,
we depend on rmap to find their PTEs, then read and clear AF to figure out
if a page is young. So it is not from a big VM area to those pages in this =
VA
range. There are just too many pages from lots of processes in LRU to be
scanned. The thing is done by rmap.

> up and doing the invalidation at the end (which will be upgraded to a
> full-mm invalidation if the range is large enough).

Those pages in LRU could be from hundreds of different processes, they are
not in just one process. i guess one possibility is that hardware has a lim=
ited
tlbi/nosync buffer, once the buffer is full, something similar with dsb wil=
l be
done automatically by hardware. So too many tlbi even without dsb can still
harm performance.

>
> Will

Thanks
Barry
