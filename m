Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078BF7D7329
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjJYSXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjJYSXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:23:19 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEAA93
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:23:16 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41cdc669c5eso386801cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698258196; x=1698862996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOngol+UNt2BS7ROUL819iuWlTNz6vkC6Ill4epbCm4=;
        b=3TbvoHk0iknr8ChUUxFLh1dBPj8vdx5P94zAuAajR72x5rzASpXuSSckMLvpX6EfL6
         HXNV8M2EmDXCbW3zy63ynkNI7j9s7EW5ucaZhTELHNAxd7RlIs7TchbCan5ZJgMFoI/I
         Mlfz9/yHTzeCrUhDkhs5nUEXK5r+CVmrELjNPIUjyj0bd0/P2AbsKlEweTk8ei+eRe1Z
         RO+kLZaamn1MQzGJNjTaZkVSQT76qXmop8Qg1LNjmdiUSq+IDkBV2AVYI/pp2neENlaw
         WTMxbhmmiVl78/YrHKLw6FjBlAZqfBmZ+gt2mlmvEtKAUiYGIh5n1wDT8fa/kgo4rSNA
         D2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258196; x=1698862996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOngol+UNt2BS7ROUL819iuWlTNz6vkC6Ill4epbCm4=;
        b=gUmJWXT8L/ahBMZ1zz9SujPjelxek4oj/eOld1W/qHdpV/i6o0XEe2rzOgZCePAPOc
         oX2pYQxwRtBlpQaHmip10TAQ1/O2laimo2R48adseK7zccMQ6rc9smT7xaSKV5ZOvmLi
         7kKRlAgfy20EIFya4Qn7s3OTj1nwLacBOsPtlsWbpaltJF46OJfH4jW0OL1DhX2LieoY
         b9YHMSnNJ5md07EK5pfX0of6pXv57+Q6WNKixduk0hW14+kma1fDayqWub7ssGA5N0Vy
         SQsFpfhXlQT/eAAutU6jYWzlPxKvjMiDJeM7oE7lIgfGGQ6s6Ubt1MmLJMU+TLxiq7AL
         sUyg==
X-Gm-Message-State: AOJu0Yw1yeni/DmoviNdyqc/PhaoCmVo/AROVpek2YulfoZf0yetjpiQ
        aEChi6YyRSPdW+wgcRpQJa64+AOKdoiqcDR/DzXgzg==
X-Google-Smtp-Source: AGHT+IEUBTKIA5WOFudfFWTufeAV1wkNsfXYI8/ec5yQNnrsqrBY/obT/m/kMgdVpKFvpflGNbKialGaTG9YnDoC3Aw=
X-Received: by 2002:a05:622a:6dcd:b0:41c:da9e:efc6 with SMTP id
 ir13-20020a05622a6dcd00b0041cda9eefc6mr319724qtb.28.1698258195584; Wed, 25
 Oct 2023 11:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
 <87y1frqz2u.fsf@nvdebian.thelocal> <CAGsJ_4wFiz-obaoXqfU9p-YqgFwExyXpGjpDKMOUt7mnenD-ew@mail.gmail.com>
 <87ttqfqw8f.fsf@nvdebian.thelocal> <d2d8062c-8248-b710-ccd6-e5359d15c385@linux.alibaba.com>
 <87bkcn1j5k.fsf@nvdebian.thelocal> <CAOUHufZ84aDmiW3Efh87q1oMJr-zk5cyaebucCFzevFHx77ngQ@mail.gmail.com>
 <CAGsJ_4zueK32KMHM0=EYjB3spYvh-yJU=buorG+6+Stnu=cypw@mail.gmail.com> <877cnb0zyk.fsf@nvdebian.thelocal>
In-Reply-To: <877cnb0zyk.fsf@nvdebian.thelocal>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 25 Oct 2023 12:22:37 -0600
Message-ID: <CAOUHufbpyR_wFARsCZ-wVqN0w3ieW2RVfVaJkbikY_O8WGwF1g@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 4:16=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
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

Thanks. How would a DMA transaction be retried after the kernel
resolves an IO PF? I.e., does the h/w (PCIe spec, etc.) support auto
retries or is the s/w responsible for doing so? At least when I worked
on the PCI subsystem, I didn't know any device that was capable of
doing auto retries. (Pasha and I will have a talk on IOMMU at the
coming LPC, so this might be an interesting intersection between IOMMU
and MM to discuss.)
