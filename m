Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4588C7D8C50
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjJZXsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:48:22 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF81A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:48:20 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45845db2d63so665107137.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698364099; x=1698968899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+In5cIMB3HJpQTMHOEwIOuwXk/mnIKncDUTw+oPVd94=;
        b=XYad8IQQWgG2yoVu4U++rvQd3O5duWV9EzKGSv/ltkad1JRQh4aoERlTxJ1fefWVtD
         Jw5pLgTzJwSSlqXsl8kweKYU0xRXWIooMOpelpFv/5WicZH4CAtKJVWQJBzj+4TBvmYp
         zh6z0cyDA+/sNi00enX80dKdQo5y60Cn6/SI05jG0s5pQQ/cEHWBRA0/3Uh9CDokBEVW
         bO54wYmQkoqAk25dBeVs+mcOvv/hgGlU/nSqNZ7my0U9fpeOqyhDtl5SUaDn1VuFwDdf
         o+kqzc2I5I32hHuYwxSn4tjfUcQpmU5/ROhtjGJQme24Ss4Ceigr+NbMLOXadJykHvcu
         Cg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698364099; x=1698968899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+In5cIMB3HJpQTMHOEwIOuwXk/mnIKncDUTw+oPVd94=;
        b=Gmugwue3o1hyzSymO7IiLfxlr3IkNeTTrxGu9OGfBnF71r8l1nWnkiBr2T5wXXaKUe
         96gYIP0twsSrX/fT2lWsA0N/MfHWq6ggrQELmIa+M1EFpkpSDLCURMo1yCEfM/agoH/j
         Un2DbtLVZy6EH8pjME+JLjJAzpz25/doLG7VpcfG9QGgKQDp7ORBKIBNfWix6qHORaMz
         mHmoBRmTy4VknBXtsvOCx/Ei3tVJyj6bbsv1wZCaMctz2MANNLxCFNekG2yzFsRlruyf
         rqvucP1NhGlIEmTf4I5EppE2GPtwPjmS3XpY5DQroMUpu6I0xCGtLr3DhlVckvDK/nB8
         oQ8w==
X-Gm-Message-State: AOJu0Yz7zWj8goIRzZh0oMjNzITSmm++yTEYWdVJLS22jfm55ZQ6PPwc
        nGFBPccRtLgXa5SOKERlGVwGipTI8YwPUM3TIWQ=
X-Google-Smtp-Source: AGHT+IGHK9Xl19bFVAuBbDA6w+Zx4r5YYHEYxhcFPaOUYOyPXe2dhYoI51npOeOFy8MPncPy91scXXqyEycM+oIwE1M=
X-Received: by 2002:a67:b80c:0:b0:458:1c00:c32f with SMTP id
 i12-20020a67b80c000000b004581c00c32fmr1422072vsf.34.1698364099116; Thu, 26
 Oct 2023 16:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
 <87y1frqz2u.fsf@nvdebian.thelocal> <CAGsJ_4wFiz-obaoXqfU9p-YqgFwExyXpGjpDKMOUt7mnenD-ew@mail.gmail.com>
 <87ttqfqw8f.fsf@nvdebian.thelocal> <d2d8062c-8248-b710-ccd6-e5359d15c385@linux.alibaba.com>
 <87bkcn1j5k.fsf@nvdebian.thelocal> <CAOUHufZ84aDmiW3Efh87q1oMJr-zk5cyaebucCFzevFHx77ngQ@mail.gmail.com>
 <CAGsJ_4zueK32KMHM0=EYjB3spYvh-yJU=buorG+6+Stnu=cypw@mail.gmail.com> <877cnb0zyk.fsf@nvdebian.thelocal>
In-Reply-To: <877cnb0zyk.fsf@nvdebian.thelocal>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 27 Oct 2023 07:48:07 +0800
Message-ID: <CAGsJ_4wTmA0FsPe_+EfA4wrxiWO_q1AkrJt0UyfHZaU0EJAQdw@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Wed, Oct 25, 2023 at 6:16=E2=80=AFPM Alistair Popple <apopple@nvidia.com=
> wrote:
>
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Oct 25, 2023 at 2:17=E2=80=AFPM Yu Zhao <yuzhao@google.com> wro=
te:
> >>
> >> On Tue, Oct 24, 2023 at 9:21=E2=80=AFPM Alistair Popple <apopple@nvidi=
a.com> wrote:
> >> >
> >> >
> >> > Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> >> >
> >> > > On 10/25/2023 9:58 AM, Alistair Popple wrote:
> >> > >> Barry Song <21cnbao@gmail.com> writes:
> >> > >>
> >> > >>> On Wed, Oct 25, 2023 at 9:18=E2=80=AFAM Alistair Popple <apopple=
@nvidia.com> wrote:
> >> > >>>>
> >> > >>>>
> >> > >>>> Barry Song <21cnbao@gmail.com> writes:
> >> > >>>>
> >> > >>>>> On Wed, Oct 25, 2023 at 7:16=E2=80=AFAM Barry Song <21cnbao@gm=
ail.com> wrote:
> >> > >>>>>>
> >> > >>>>>> On Tue, Oct 24, 2023 at 8:57=E2=80=AFPM Baolin Wang
> >> > >>>>>> <baolin.wang@linux.alibaba.com> wrote:
> >> > >> [...]
> >> > >>
> >> > >>>>>> (A). Constant flush cost vs. (B). very very occasional reclai=
med hot
> >> > >>>>>> page,  B might
> >> > >>>>>> be a correct choice.
> >> > >>>>>
> >> > >>>>> Plus, I doubt B is really going to happen. as after a page is =
promoted to
> >> > >>>>> the head of lru list or new generation, it needs a long time t=
o slide back
> >> > >>>>> to the inactive list tail or to the candidate generation of mg=
lru. the time
> >> > >>>>> should have been large enough for tlb to be flushed. If the pa=
ge is really
> >> > >>>>> hot, the hardware will get second, third, fourth etc opportuni=
ty to set an
> >> > >>>>> access flag in the long time in which the page is re-moved to =
the tail
> >> > >>>>> as the page can be accessed multiple times if it is really hot=
.
> >> > >>>>
> >> > >>>> This might not be true if you have external hardware sharing th=
e page
> >> > >>>> tables with software through either HMM or hardware supported A=
TS
> >> > >>>> though.
> >> > >>>>
> >> > >>>> In those cases I think it's much more likely hardware can still=
 be
> >> > >>>> accessing the page even after a context switch on the CPU say. =
So those
> >> > >>>> pages will tend to get reclaimed even though hardware is still =
actively
> >> > >>>> using them which would be quite expensive and I guess could lea=
d to
> >> > >>>> thrashing as each page is reclaimed and then immediately faulte=
d back
> >> > >>>> in.
> >> > >
> >> > > That's possible, but the chance should be relatively low. At least=
 on
> >> > > x86, I have not heard of this issue.
> >> >
> >> > Personally I've never seen any x86 system that shares page tables wi=
th
> >> > external devices, other than with HMM. More on that below.
> >> >
> >> > >>> i am not quite sure i got your point. has the external hardware =
sharing cpu's
> >> > >>> pagetable the ability to set access flag in page table entries b=
y
> >> > >>> itself? if yes,
> >> > >>> I don't see how our approach will hurt as folio_referenced can n=
otify the
> >> > >>> hardware driver and the driver can flush its own tlb. If no, i d=
on't see
> >> > >>> either as the external hardware can't set access flags, that mea=
ns we
> >> > >>> have ignored its reference and only knows cpu's access even in t=
he current
> >> > >>> mainline code. so we are not getting worse.
> >> > >>>
> >> > >>> so the external hardware can also see cpu's TLB? or cpu's tlb fl=
ush can
> >> > >>> also broadcast to external hardware, then external hardware sees=
 the
> >> > >>> cleared access flag, thus, it can set access flag in page table =
when the
> >> > >>> hardware access it?  If this is the case, I feel what you said i=
s true.
> >> > >> Perhaps it would help if I gave a concrete example. Take for exam=
ple
> >> > >> the
> >> > >> ARM SMMU. It has it's own TLB. Invalidating this TLB is done in o=
ne of
> >> > >> two ways depending on the specific HW implementation.
> >> > >> If broadcast TLB maintenance (BTM) is supported it will snoop CPU
> >> > >> TLB
> >> > >> invalidations. If BTM is not supported it relies on SW to explici=
tly
> >> > >> forward TLB invalidations via MMU notifiers.
> >> > >
> >> > > On our ARM64 hardware, we rely on BTM to maintain TLB coherency.
> >> >
> >> > Lucky you :-)
> >> >
> >> > ARM64 SMMU architecture specification supports the possibilty of bot=
h,
> >> > as does the driver. Not that I think whether or not BTM is supported=
 has
> >> > much relevance to this issue.
> >> >
> >> > >> Now consider the case where some external device is accessing map=
pings
> >> > >> via the SMMU. The access flag will be cached in the SMMU TLB. If =
we
> >> > >> clear the access flag without a TLB invalidate the access flag in=
 the
> >> > >> CPU page table will not get updated because it's already set in t=
he SMMU
> >> > >> TLB.
> >> > >> As an aside access flag updates happen in one of two ways. If the
> >> > >> SMMU
> >> > >> HW supports hardware translation table updates (HTTU) then hardwa=
re will
> >> > >> manage updating access/dirty flags as required. If this is not su=
pported
> >> > >> then SW is relied on to update these flags which in practice mean=
s
> >> > >> taking a minor fault. But I don't think that is relevant here - i=
n
> >> > >> either case without a TLB invalidate neither of those things will
> >> > >> happen.
> >> > >> I suppose drivers could implement the clear_flush_young() MMU
> >> > >> notifier
> >> > >> callback (none do at the moment AFAICT) but then won't that just =
lead to
> >> > >> the opposite problem - that every page ever used by an external d=
evice
> >> > >> remains active and unavailable for reclaim because the access fla=
g never
> >> > >> gets cleared? I suppose they could do the flush then which would =
ensure
> >> > >
> >> > > Yes, I think so too. The reason there is currently no problem, per=
haps
> >> > > I think, there are no actual use cases at the moment? At least on =
our
> >> > > Alibaba's fleet, SMMU and MMU do not share page tables now.
> >> >
> >> > We have systems that do.
> >>
> >> Just curious: do those systems run the Linux kernel? If so, are pages
> >> shared with SMMU pinned? If not, then how are IO PFs handled after
> >> pages are reclaimed?
>
> Yes, these systems all run Linux. Pages shared with SMMU aren't pinned
> and fault handling works as Barry notes below - a driver is notified of
> a fault and calls handle_mm_fault() in response.
>
> > it will call handle_mm_fault(vma, prm->addr, fault_flags, NULL); in
> > I/O PF, so finally
> > it runs the same codes to get page back just like CPU's PF.
> >
> > years ago, we recommended a pin solution, but obviously there were lots=
 of
> > push backs:
> > https://lore.kernel.org/linux-mm/1612685884-19514-1-git-send-email-wang=
zhou1@hisilicon.com/
>
> Right. Having to pin pages defeats the whole point of having hardware
> that can handle page faults.

Right. But
Sometimes I feel that purpose and the technology for the purpose are
contradictory.
People want user space dma to have high bandwidth and performance by droppi=
ng
u/k copying and complicated syscalls managing those buffers. but IO PF some=
how
defeats all the efforts to improve performance.

AFAIK, IO PF is much much slower than PF as it depends on interrupts and ev=
ent
queues in hardware. Even a minor page fault due to page migration or
demand paging
can significantly decrease the speed of userspace DMA. So finally people ha=
ve to
depend on some mlock-like and pre-paging ways to achieve the purpose
if performance
is the key concern.

Thanks
Barry
