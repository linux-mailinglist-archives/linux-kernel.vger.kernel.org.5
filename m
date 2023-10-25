Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08F47D61A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjJYG2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjJYG16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:27:58 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC298BD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:27:55 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-457eebf8e01so2161776137.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698215275; x=1698820075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hvhN95Hgxd5EOg3E4vQFgU+T0leLLlisysltTyUILc=;
        b=TujwKBoMhfvB2qxlHjlN/S9ZlKjwxTg9aCGK2GYOmnrQh/5JtHTC/rQWxpxnL0OPxK
         wDIMWDk16Y2eYHrh0mUcBS34Cm8ZenAavYTASC8f30mr6JFLJrOH2LTWDWiHuC8PEn8I
         IkUELaDpfqVAWnUgTM6GR3EArHgyK7px7ullAPLNykOJUGreyhhPWJwEZ/DV+/TZwTpR
         AmzXF+ITNY861mAJX2+NJfor+OsVr0sCKiBvnrEZ7pERilYCS5CvIHHuYsOODdfHp5Wj
         XQH6eCL0A1nj/M8vfflOKQ5hCL7orgrckiD7xeiYT0mn00UeUZRycu3XYLmYmGrA0+mt
         MGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698215275; x=1698820075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hvhN95Hgxd5EOg3E4vQFgU+T0leLLlisysltTyUILc=;
        b=b1o5iKqQS075dNm3hsy56nCNAH87JDAckcP2OL1FqT8jJSahlZ6f3EYJ49M9ump3oV
         h6nLNvoUiksX+UX9UCnmDNRUSz5hb8e+9AMwiBXVYaLRZCGwLqHfAmvkikrXGvO0RGFZ
         2qadAqFOaEC6vmHirzRFj50Ttlnc6s+f0t1fiAWVybanE/ibPBiunT52gkScGDL1wKKp
         pe32pSaO31NEZ9Vodkc7yKBFE0JFBkM9CQov4Sps5aZP5P6I4v4P/mY3cU3wvzS8KrMa
         y6Cj11yAZHieC9AbbZzV4CRv2q93qI+bcL6YlHpEniUi5NrFf2SpThAZ4zO6Tk0RAYwS
         lZdg==
X-Gm-Message-State: AOJu0YxjqG5B2QdCJULQThROktGG6nSCL/SY2Lm60FI1xJV6fp/i8Uvp
        KCln7IDXjm9trZ39wMeKd5GUztzLPsan+mpZHHg=
X-Google-Smtp-Source: AGHT+IEQEdH2DS0DmnrsPQe31oNAW06TD9BBbD61iByaZs2s3/SuMAYfnQN5a+0/jOZUcnYewvrmk8OpvLKvA6AGz5M=
X-Received: by 2002:a67:e009:0:b0:452:78cb:206b with SMTP id
 c9-20020a67e009000000b0045278cb206bmr11817794vsl.3.1698215274847; Tue, 24 Oct
 2023 23:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
 <87y1frqz2u.fsf@nvdebian.thelocal> <CAGsJ_4wFiz-obaoXqfU9p-YqgFwExyXpGjpDKMOUt7mnenD-ew@mail.gmail.com>
 <87ttqfqw8f.fsf@nvdebian.thelocal> <d2d8062c-8248-b710-ccd6-e5359d15c385@linux.alibaba.com>
 <87bkcn1j5k.fsf@nvdebian.thelocal> <CAOUHufZ84aDmiW3Efh87q1oMJr-zk5cyaebucCFzevFHx77ngQ@mail.gmail.com>
In-Reply-To: <CAOUHufZ84aDmiW3Efh87q1oMJr-zk5cyaebucCFzevFHx77ngQ@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 25 Oct 2023 14:27:42 +0800
Message-ID: <CAGsJ_4zueK32KMHM0=EYjB3spYvh-yJU=buorG+6+Stnu=cypw@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Yu Zhao <yuzhao@google.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, v-songbaohua@oppo.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 2:17=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Oct 24, 2023 at 9:21=E2=80=AFPM Alistair Popple <apopple@nvidia.c=
om> wrote:
> >
> >
> > Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> >
> > > On 10/25/2023 9:58 AM, Alistair Popple wrote:
> > >> Barry Song <21cnbao@gmail.com> writes:
> > >>
> > >>> On Wed, Oct 25, 2023 at 9:18=E2=80=AFAM Alistair Popple <apopple@nv=
idia.com> wrote:
> > >>>>
> > >>>>
> > >>>> Barry Song <21cnbao@gmail.com> writes:
> > >>>>
> > >>>>> On Wed, Oct 25, 2023 at 7:16=E2=80=AFAM Barry Song <21cnbao@gmail=
.com> wrote:
> > >>>>>>
> > >>>>>> On Tue, Oct 24, 2023 at 8:57=E2=80=AFPM Baolin Wang
> > >>>>>> <baolin.wang@linux.alibaba.com> wrote:
> > >> [...]
> > >>
> > >>>>>> (A). Constant flush cost vs. (B). very very occasional reclaimed=
 hot
> > >>>>>> page,  B might
> > >>>>>> be a correct choice.
> > >>>>>
> > >>>>> Plus, I doubt B is really going to happen. as after a page is pro=
moted to
> > >>>>> the head of lru list or new generation, it needs a long time to s=
lide back
> > >>>>> to the inactive list tail or to the candidate generation of mglru=
. the time
> > >>>>> should have been large enough for tlb to be flushed. If the page =
is really
> > >>>>> hot, the hardware will get second, third, fourth etc opportunity =
to set an
> > >>>>> access flag in the long time in which the page is re-moved to the=
 tail
> > >>>>> as the page can be accessed multiple times if it is really hot.
> > >>>>
> > >>>> This might not be true if you have external hardware sharing the p=
age
> > >>>> tables with software through either HMM or hardware supported ATS
> > >>>> though.
> > >>>>
> > >>>> In those cases I think it's much more likely hardware can still be
> > >>>> accessing the page even after a context switch on the CPU say. So =
those
> > >>>> pages will tend to get reclaimed even though hardware is still act=
ively
> > >>>> using them which would be quite expensive and I guess could lead t=
o
> > >>>> thrashing as each page is reclaimed and then immediately faulted b=
ack
> > >>>> in.
> > >
> > > That's possible, but the chance should be relatively low. At least on
> > > x86, I have not heard of this issue.
> >
> > Personally I've never seen any x86 system that shares page tables with
> > external devices, other than with HMM. More on that below.
> >
> > >>> i am not quite sure i got your point. has the external hardware sha=
ring cpu's
> > >>> pagetable the ability to set access flag in page table entries by
> > >>> itself? if yes,
> > >>> I don't see how our approach will hurt as folio_referenced can noti=
fy the
> > >>> hardware driver and the driver can flush its own tlb. If no, i don'=
t see
> > >>> either as the external hardware can't set access flags, that means =
we
> > >>> have ignored its reference and only knows cpu's access even in the =
current
> > >>> mainline code. so we are not getting worse.
> > >>>
> > >>> so the external hardware can also see cpu's TLB? or cpu's tlb flush=
 can
> > >>> also broadcast to external hardware, then external hardware sees th=
e
> > >>> cleared access flag, thus, it can set access flag in page table whe=
n the
> > >>> hardware access it?  If this is the case, I feel what you said is t=
rue.
> > >> Perhaps it would help if I gave a concrete example. Take for example
> > >> the
> > >> ARM SMMU. It has it's own TLB. Invalidating this TLB is done in one =
of
> > >> two ways depending on the specific HW implementation.
> > >> If broadcast TLB maintenance (BTM) is supported it will snoop CPU
> > >> TLB
> > >> invalidations. If BTM is not supported it relies on SW to explicitly
> > >> forward TLB invalidations via MMU notifiers.
> > >
> > > On our ARM64 hardware, we rely on BTM to maintain TLB coherency.
> >
> > Lucky you :-)
> >
> > ARM64 SMMU architecture specification supports the possibilty of both,
> > as does the driver. Not that I think whether or not BTM is supported ha=
s
> > much relevance to this issue.
> >
> > >> Now consider the case where some external device is accessing mappin=
gs
> > >> via the SMMU. The access flag will be cached in the SMMU TLB. If we
> > >> clear the access flag without a TLB invalidate the access flag in th=
e
> > >> CPU page table will not get updated because it's already set in the =
SMMU
> > >> TLB.
> > >> As an aside access flag updates happen in one of two ways. If the
> > >> SMMU
> > >> HW supports hardware translation table updates (HTTU) then hardware =
will
> > >> manage updating access/dirty flags as required. If this is not suppo=
rted
> > >> then SW is relied on to update these flags which in practice means
> > >> taking a minor fault. But I don't think that is relevant here - in
> > >> either case without a TLB invalidate neither of those things will
> > >> happen.
> > >> I suppose drivers could implement the clear_flush_young() MMU
> > >> notifier
> > >> callback (none do at the moment AFAICT) but then won't that just lea=
d to
> > >> the opposite problem - that every page ever used by an external devi=
ce
> > >> remains active and unavailable for reclaim because the access flag n=
ever
> > >> gets cleared? I suppose they could do the flush then which would ens=
ure
> > >
> > > Yes, I think so too. The reason there is currently no problem, perhap=
s
> > > I think, there are no actual use cases at the moment? At least on our
> > > Alibaba's fleet, SMMU and MMU do not share page tables now.
> >
> > We have systems that do.
>
> Just curious: do those systems run the Linux kernel? If so, are pages
> shared with SMMU pinned? If not, then how are IO PFs handled after
> pages are reclaimed?

it will call handle_mm_fault(vma, prm->addr, fault_flags, NULL); in
I/O PF, so finally
it runs the same codes to get page back just like CPU's PF.

years ago, we recommended a pin solution, but obviously there were lots of
push backs:
https://lore.kernel.org/linux-mm/1612685884-19514-1-git-send-email-wangzhou=
1@hisilicon.com/

Thanks
Barry
