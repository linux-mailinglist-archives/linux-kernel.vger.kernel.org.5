Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCBF7D6187
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 08:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjJYGR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 02:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjJYGR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 02:17:57 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD704136
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:17:53 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41cb7720579so148721cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 23:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698214673; x=1698819473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hrmR2jUwFTIh0kffJWcCQnTgSTrj5dr7g52/pumOQo=;
        b=s7vB06RTGtJQ/0Cx3Gx8Ic7IA8NxHAvj+bc02JMrusf+Ul/gL4PQV2SXek5Je9Q/Gk
         V0FiUx4w4dmikAjEz0YwxgWZ5YEBJmfG/OA4hcBEUwyo8/K4qClcGS2rsae4kIIbTY+1
         S7v90n2ox52On5nT8jMTaEZo02wkacnjataZHTpQqcamtZrR+rKb0FMdO3tm+z63uac7
         Y2h7eLjSZyULXQLYIKA9vTByfiC1Z1PMrcW74uea03QStvmcTSE4RqnS+XG0h5wrpsm0
         +XLoVrtnSi818SAy0hCGYN21mol3Rx/zPbIYsGjQWL27exsjLpz7Dt9U1JpOEEpMEcSf
         Fjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698214673; x=1698819473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hrmR2jUwFTIh0kffJWcCQnTgSTrj5dr7g52/pumOQo=;
        b=fNhHzOSIwjc5JVR6GwLKRS9ekZkrzdq2VUcM9HGOsphdDFHzaGh+ZPvPcx/3QbURy8
         ZVI5FsW2zUYlaTH+xtKwJCYySDEArDnmKQ6Cn86FTTxIgJPT+1BKbhcixR86E41wMFro
         uAjM+4rvJUokOKt0BpyV0nbxEQaXSz2piVxqgaMrHiC4hcCRaPoRhyXaMwSt3q8O1ioL
         5IpmwNg9jtJJ+cts631bqN5U3/Tsw4/FhwEmEUlaXeSTIy6CdeBy01PgnxvhAUgGnM1c
         i4YlLjarTyFURdSRGYt8NfhHVALnJ5fZzZvi8cSso80ndu3VhYakaBFXY2d9r4Fvetl9
         TR6A==
X-Gm-Message-State: AOJu0YxhWerPb01YkMik01U1eloMJljTnI3xGxCj6vewoEUKz+VuhbqC
        wHRMW0N9o91XbRIwaKz2YgO+NEOqVKFDqKBZtSiR6A==
X-Google-Smtp-Source: AGHT+IE1GNO48dMXbjU3HsAlI1Fec2fQ3Qbbl56+Dk+P44pufWL4vm6WMNf8PXylc6BN3EVqcCnKiujlP9EgCO7tnPI=
X-Received: by 2002:ac8:7cad:0:b0:41e:2984:6dba with SMTP id
 z13-20020ac87cad000000b0041e29846dbamr88759qtv.3.1698214672590; Tue, 24 Oct
 2023 23:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <ae3115778a3fa10ec77152e18beed54fafe0f6e7.1698151516.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4zgdAmyU-075jd8KfXn=CdAVC8Rs481sCOd5N2a68yPUg@mail.gmail.com>
 <CAGsJ_4z1u4-_JXUM9GG2cqc4Nwrx1v69uHsbff5jDQZHQgWP+w@mail.gmail.com>
 <87y1frqz2u.fsf@nvdebian.thelocal> <CAGsJ_4wFiz-obaoXqfU9p-YqgFwExyXpGjpDKMOUt7mnenD-ew@mail.gmail.com>
 <87ttqfqw8f.fsf@nvdebian.thelocal> <d2d8062c-8248-b710-ccd6-e5359d15c385@linux.alibaba.com>
 <87bkcn1j5k.fsf@nvdebian.thelocal>
In-Reply-To: <87bkcn1j5k.fsf@nvdebian.thelocal>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 25 Oct 2023 00:17:14 -0600
Message-ID: <CAOUHufZ84aDmiW3Efh87q1oMJr-zk5cyaebucCFzevFHx77ngQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: drop tlb flush operation when clearing the
 access bit
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Barry Song <21cnbao@gmail.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, v-songbaohua@oppo.com,
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

On Tue, Oct 24, 2023 at 9:21=E2=80=AFPM Alistair Popple <apopple@nvidia.com=
> wrote:
>
>
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>
> > On 10/25/2023 9:58 AM, Alistair Popple wrote:
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >>> On Wed, Oct 25, 2023 at 9:18=E2=80=AFAM Alistair Popple <apopple@nvid=
ia.com> wrote:
> >>>>
> >>>>
> >>>> Barry Song <21cnbao@gmail.com> writes:
> >>>>
> >>>>> On Wed, Oct 25, 2023 at 7:16=E2=80=AFAM Barry Song <21cnbao@gmail.c=
om> wrote:
> >>>>>>
> >>>>>> On Tue, Oct 24, 2023 at 8:57=E2=80=AFPM Baolin Wang
> >>>>>> <baolin.wang@linux.alibaba.com> wrote:
> >> [...]
> >>
> >>>>>> (A). Constant flush cost vs. (B). very very occasional reclaimed h=
ot
> >>>>>> page,  B might
> >>>>>> be a correct choice.
> >>>>>
> >>>>> Plus, I doubt B is really going to happen. as after a page is promo=
ted to
> >>>>> the head of lru list or new generation, it needs a long time to sli=
de back
> >>>>> to the inactive list tail or to the candidate generation of mglru. =
the time
> >>>>> should have been large enough for tlb to be flushed. If the page is=
 really
> >>>>> hot, the hardware will get second, third, fourth etc opportunity to=
 set an
> >>>>> access flag in the long time in which the page is re-moved to the t=
ail
> >>>>> as the page can be accessed multiple times if it is really hot.
> >>>>
> >>>> This might not be true if you have external hardware sharing the pag=
e
> >>>> tables with software through either HMM or hardware supported ATS
> >>>> though.
> >>>>
> >>>> In those cases I think it's much more likely hardware can still be
> >>>> accessing the page even after a context switch on the CPU say. So th=
ose
> >>>> pages will tend to get reclaimed even though hardware is still activ=
ely
> >>>> using them which would be quite expensive and I guess could lead to
> >>>> thrashing as each page is reclaimed and then immediately faulted bac=
k
> >>>> in.
> >
> > That's possible, but the chance should be relatively low. At least on
> > x86, I have not heard of this issue.
>
> Personally I've never seen any x86 system that shares page tables with
> external devices, other than with HMM. More on that below.
>
> >>> i am not quite sure i got your point. has the external hardware shari=
ng cpu's
> >>> pagetable the ability to set access flag in page table entries by
> >>> itself? if yes,
> >>> I don't see how our approach will hurt as folio_referenced can notify=
 the
> >>> hardware driver and the driver can flush its own tlb. If no, i don't =
see
> >>> either as the external hardware can't set access flags, that means we
> >>> have ignored its reference and only knows cpu's access even in the cu=
rrent
> >>> mainline code. so we are not getting worse.
> >>>
> >>> so the external hardware can also see cpu's TLB? or cpu's tlb flush c=
an
> >>> also broadcast to external hardware, then external hardware sees the
> >>> cleared access flag, thus, it can set access flag in page table when =
the
> >>> hardware access it?  If this is the case, I feel what you said is tru=
e.
> >> Perhaps it would help if I gave a concrete example. Take for example
> >> the
> >> ARM SMMU. It has it's own TLB. Invalidating this TLB is done in one of
> >> two ways depending on the specific HW implementation.
> >> If broadcast TLB maintenance (BTM) is supported it will snoop CPU
> >> TLB
> >> invalidations. If BTM is not supported it relies on SW to explicitly
> >> forward TLB invalidations via MMU notifiers.
> >
> > On our ARM64 hardware, we rely on BTM to maintain TLB coherency.
>
> Lucky you :-)
>
> ARM64 SMMU architecture specification supports the possibilty of both,
> as does the driver. Not that I think whether or not BTM is supported has
> much relevance to this issue.
>
> >> Now consider the case where some external device is accessing mappings
> >> via the SMMU. The access flag will be cached in the SMMU TLB. If we
> >> clear the access flag without a TLB invalidate the access flag in the
> >> CPU page table will not get updated because it's already set in the SM=
MU
> >> TLB.
> >> As an aside access flag updates happen in one of two ways. If the
> >> SMMU
> >> HW supports hardware translation table updates (HTTU) then hardware wi=
ll
> >> manage updating access/dirty flags as required. If this is not support=
ed
> >> then SW is relied on to update these flags which in practice means
> >> taking a minor fault. But I don't think that is relevant here - in
> >> either case without a TLB invalidate neither of those things will
> >> happen.
> >> I suppose drivers could implement the clear_flush_young() MMU
> >> notifier
> >> callback (none do at the moment AFAICT) but then won't that just lead =
to
> >> the opposite problem - that every page ever used by an external device
> >> remains active and unavailable for reclaim because the access flag nev=
er
> >> gets cleared? I suppose they could do the flush then which would ensur=
e
> >
> > Yes, I think so too. The reason there is currently no problem, perhaps
> > I think, there are no actual use cases at the moment? At least on our
> > Alibaba's fleet, SMMU and MMU do not share page tables now.
>
> We have systems that do.

Just curious: do those systems run the Linux kernel? If so, are pages
shared with SMMU pinned? If not, then how are IO PFs handled after
pages are reclaimed?
