Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5537D5F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJYBo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJYBo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:44:57 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064910D5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:44:54 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7b6d6773d05so1833596241.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698198293; x=1698803093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvYlReFl2iFwDppsisTa/4XhhXlafVLVna0q5Gl6KZ8=;
        b=UrzjBkcHUyg/y5DbNpOjlAFkcJDXbiG58qTOzrGqkZeqCLUddhDz/BUE9sCcrCxvDY
         hPFRxbqqCfCAh9jALhKbdxmKhG8SoWe41hZFQQ65cAEWcQVjgOYqCwhskFUHVPXDo/NO
         Sm0RMSEaKSYv7wQu0B+o12Ku9de8VVkjibRUJji9aSOPiWyezNmh7tSlmrdQRcFU3KOd
         T0LJZJTff8KFBLXzTBr1DRIk0cpSpuPELne6ZFuKFjULb9s/M6MmlLl4X2LSGInefZtW
         hxhBVwjPg+zeDnfNu3L43z0YRsgCxKXG46ZFOrq51O5d8yE53xmUfaEIYYu9/QnuYHqo
         JXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698198293; x=1698803093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvYlReFl2iFwDppsisTa/4XhhXlafVLVna0q5Gl6KZ8=;
        b=fXXcw/th8Ke/YnK5qGbL9X6RexAfD/mHu7VSECOtMihNlnBQqASY6z9rpVDZtqLd52
         7MIAMUSHOXCPtzxhUUg25vV1Zu5YkKjRFyLlDnqOs2fdWShSR90VoGCYGUNvkIYudi3e
         /BdZ6cdR2LQdiGZm2XaiTWrWJufDLfsV3HkdLQghQXdXwU5MJPxGfIxWc/D869KEzYAR
         NQtgT+JokrVZNNXQzO6mk7e4zaFt/tbvh662PvXYlRwJ39X8jYMWUK4gFKxZWkEvLjot
         FAsZcr7vWXDLeqGYOeYsWR7MTEsxar/EyGfU29C/HB7G7XpRidh7EjnPnRBsm8ucCUsD
         bnTA==
X-Gm-Message-State: AOJu0Ywxcl2u0PiJeE7z7pdu8b7beXQy3AKw/CqJg3738OQ5mMO9SnMn
        vuHRKcBYbTVAtX6g5PPx77iyF6WJrXMvyp7eaUE=
X-Google-Smtp-Source: AGHT+IHHQ/64kU/wjSFBYKOc/erC/5nP1nhYJPI9Gj/z5cI4PH/ZXR2KmQnm4B4cnNtN35XqOvVPFa0hZSBe4O5Zvvw=
X-Received: by 2002:a67:ae05:0:b0:452:5798:64bd with SMTP id
 x5-20020a67ae05000000b00452579864bdmr11995808vse.35.1698198293316; Tue, 24
 Oct 2023 18:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com> <87y1frqz2u.fsf@nvdebian.thelocal>
In-Reply-To: <87y1frqz2u.fsf@nvdebian.thelocal>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 25 Oct 2023 09:44:41 +0800
Message-ID: <CAGsJ_4wFiz-obaoXqfU9p-YqgFwExyXpGjpDKMOUt7mnenD-ew@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        yuzhao@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 9:18=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Oct 25, 2023 at 7:16=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Tue, Oct 24, 2023 at 8:57=E2=80=AFPM Baolin Wang
> >> <baolin.wang@linux.alibaba.com> wrote:
> >> >
> >> > Now ptep_clear_flush_young() is only called by folio_referenced() to
> >> > check if the folio was referenced, and now it will call a tlb flush =
on
> >> > ARM64 architecture. However the tlb flush can be expensive on ARM64
> >> > servers, especially for the systems with a large CPU numbers.
> >> >
> >> > Similar to the x86 architecture, below comments also apply equally t=
o
> >> > ARM64 architecture. So we can drop the tlb flush operation in
> >> > ptep_clear_flush_young() on ARM64 architecture to improve the perfor=
mance.
> >> > "
> >> > /* Clearing the accessed bit without a TLB flush
> >> >  * doesn't cause data corruption. [ It could cause incorrect
> >> >  * page aging and the (mistaken) reclaim of hot pages, but the
> >> >  * chance of that should be relatively low. ]
> >> >  *
> >> >  * So as a performance optimization don't flush the TLB when
> >> >  * clearing the accessed bit, it will eventually be flushed by
> >> >  * a context switch or a VM operation anyway. [ In the rare
> >> >  * event of it not getting flushed for a long time the delay
> >> >  * shouldn't really matter because there's no real memory
> >> >  * pressure for swapout to react to. ]
> >> >  */
> >> > "
> >> > Running the thpscale to show some obvious improvements for compactio=
n
> >> > latency with this patch:
> >> >                              base                   patched
> >> > Amean     fault-both-1      1093.19 (   0.00%)     1084.57 *   0.79%=
*
> >> > Amean     fault-both-3      2566.22 (   0.00%)     2228.45 *  13.16%=
*
> >> > Amean     fault-both-5      3591.22 (   0.00%)     3146.73 *  12.38%=
*
> >> > Amean     fault-both-7      4157.26 (   0.00%)     4113.67 *   1.05%=
*
> >> > Amean     fault-both-12     6184.79 (   0.00%)     5218.70 *  15.62%=
*
> >> > Amean     fault-both-18     9103.70 (   0.00%)     7739.71 *  14.98%=
*
> >> > Amean     fault-both-24    12341.73 (   0.00%)    10684.23 *  13.43%=
*
> >> > Amean     fault-both-30    15519.00 (   0.00%)    13695.14 *  11.75%=
*
> >> > Amean     fault-both-32    16189.15 (   0.00%)    14365.73 *  11.26%=
*
> >> >                        base       patched
> >> > Duration User         167.78      161.03
> >> > Duration System      1836.66     1673.01
> >> > Duration Elapsed     2074.58     2059.75
> >> >
> >> > Barry Song submitted a similar patch [1] before, that replaces the
> >> > ptep_clear_flush_young_notify() with ptep_clear_young_notify() in
> >> > folio_referenced_one(). However, I'm not sure if removing the tlb fl=
ush
> >> > operation is applicable to every architecture in kernel, so dropping
> >> > the tlb flush for ARM64 seems a sensible change.
> >> >
> >> > Note: I am okay for both approach, if someone can help to ensure tha=
t
> >> > all architectures do not need the tlb flush when clearing the access=
ed
> >> > bit, then I also think Barry's patch is better (hope Barry can resen=
d
> >> > his patch).
> >> >
> >>
> >> Thanks!
> >>
> >> ptep_clear_flush_young() with "flush" in its name clearly says it need=
s a
> >> flush. but it happens in arm64, all other code which needs a flush has
> >> called other variants, for example __flush_tlb_page_nosync():
> >>
> >> static inline void arch_tlbbatch_add_pending(struct
> >> arch_tlbflush_unmap_batch *batch,
> >>  struct mm_struct *mm, unsigned long uaddr)
> >> {
> >>  __flush_tlb_page_nosync(mm, uaddr);
> >> }
> >>
> >> so it seems folio_referenced is the only left user of this
> >> ptep_clear_flush_young().
> >> The fact makes Baolin's patch look safe now.
> >>
> >> but this function still has "flush" in its name, so one day, one perso=
n might
> >> call it with the understanding that it will flush tlb but actually it
> >> won't. This is
> >> bad smell in code.
> >>
> >> I guess one side effect of not flushing tlb while clearing the access
> >> flag is that
> >> hardware won't see this cleared flag in the tlb, so it might not set t=
his bit in
> >> memory even though the bit has been cleared before in memory(but not i=
n tlb)
> >> while the page is accessed *again*.
> >>
> >> next time, someone reads the access flag in memory again by folio_refe=
renced,
> >> he/she will see the page is cold as hardware has lost a chance to set
> >> the bit again
> >> since it finds tlb already has a true access flag.
> >>
> >> But anyway, tlb is so small, it will be flushed by context switch and
> >> other running
> >> code soon. so it seems we don't actually require the access flag being=
 instantly
> >> updated. the time gap, in which access flag might lose the new set by =
hardware,
> >> seems to be too short to really affect the accuracy of page reclamatio=
n. but its
> >> cost is large.
> >>
> >> (A). Constant flush cost vs. (B). very very occasional reclaimed hot
> >> page,  B might
> >> be a correct choice.
> >
> > Plus, I doubt B is really going to happen. as after a page is promoted =
to
> > the head of lru list or new generation, it needs a long time to slide b=
ack
> > to the inactive list tail or to the candidate generation of mglru. the =
time
> > should have been large enough for tlb to be flushed. If the page is rea=
lly
> > hot, the hardware will get second, third, fourth etc opportunity to set=
 an
> > access flag in the long time in which the page is re-moved to the tail
> > as the page can be accessed multiple times if it is really hot.
>
> This might not be true if you have external hardware sharing the page
> tables with software through either HMM or hardware supported ATS
> though.
>
> In those cases I think it's much more likely hardware can still be
> accessing the page even after a context switch on the CPU say. So those
> pages will tend to get reclaimed even though hardware is still actively
> using them which would be quite expensive and I guess could lead to
> thrashing as each page is reclaimed and then immediately faulted back
> in.

i am not quite sure i got your point. has the external hardware sharing cpu=
's
pagetable the ability to set access flag in page table entries by
itself? if yes,
I don't see how our approach will hurt as folio_referenced can notify the
hardware driver and the driver can flush its own tlb. If no, i don't see
either as the external hardware can't set access flags, that means we
have ignored its reference and only knows cpu's access even in the current
mainline code. so we are not getting worse.

so the external hardware can also see cpu's TLB? or cpu's tlb flush can
also broadcast to external hardware, then external hardware sees the
cleared access flag, thus, it can set access flag in page table when the
hardware access it?  If this is the case, I feel what you said is true.

>
> Of course TLB flushes are equally (perhaps even more) expensive for this
> kind of external HW so reducing them would still be beneficial. I wonder
> if there's some way they could be deferred until the page is moved to
> the inactive list say?
>
> >>
> >> > [1] https://lore.kernel.org/lkml/20220617070555.344368-1-21cnbao@gma=
il.com/
> >> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> > ---
> >> >  arch/arm64/include/asm/pgtable.h | 31 ++++++++++++++++-------------=
--
> >> >  1 file changed, 16 insertions(+), 15 deletions(-)
> >> >
> >> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/a=
sm/pgtable.h
> >> > index 0bd18de9fd97..2979d796ba9d 100644
> >> > --- a/arch/arm64/include/asm/pgtable.h
> >> > +++ b/arch/arm64/include/asm/pgtable.h
> >> > @@ -905,21 +905,22 @@ static inline int ptep_test_and_clear_young(st=
ruct vm_area_struct *vma,
> >> >  static inline int ptep_clear_flush_young(struct vm_area_struct *vma=
,
> >> >                                          unsigned long address, pte_=
t *ptep)
> >> >  {
> >> > -       int young =3D ptep_test_and_clear_young(vma, address, ptep);
> >> > -
> >> > -       if (young) {
> >> > -               /*
> >> > -                * We can elide the trailing DSB here since the wors=
t that can
> >> > -                * happen is that a CPU continues to use the young e=
ntry in its
> >> > -                * TLB and we mistakenly reclaim the associated page=
. The
> >> > -                * window for such an event is bounded by the next
> >> > -                * context-switch, which provides a DSB to complete =
the TLB
> >> > -                * invalidation.
> >> > -                */
> >> > -               flush_tlb_page_nosync(vma, address);
> >> > -       }
> >> > -
> >> > -       return young;
> >> > +       /*
> >> > +        * This comment is borrowed from x86, but applies equally to=
 ARM64:
> >> > +        *
> >> > +        * Clearing the accessed bit without a TLB flush doesn't cau=
se
> >> > +        * data corruption. [ It could cause incorrect page aging an=
d
> >> > +        * the (mistaken) reclaim of hot pages, but the chance of th=
at
> >> > +        * should be relatively low. ]
> >> > +        *
> >> > +        * So as a performance optimization don't flush the TLB when
> >> > +        * clearing the accessed bit, it will eventually be flushed =
by
> >> > +        * a context switch or a VM operation anyway. [ In the rare
> >> > +        * event of it not getting flushed for a long time the delay
> >> > +        * shouldn't really matter because there's no real memory
> >> > +        * pressure for swapout to react to. ]
> >> > +        */
> >> > +       return ptep_test_and_clear_young(vma, address, ptep);
> >> >  }
> >> >
> >> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> > --
> >> > 2.39.3
> >> >
> >>
> >> Thanks
> >> Barry
>
Thanks
Barry
