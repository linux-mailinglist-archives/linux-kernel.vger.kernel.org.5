Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215487E0568
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjKCPSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjKCPSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:18:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9017D48
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:18:26 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so14798a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 08:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699024705; x=1699629505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X57psH+OB85EKMrdxaU2Ma2i9zrDrzyePuaysDdtYkg=;
        b=4CkfvGg22GExKu/GKUGVmcgz3bMX+guUyuEPUfQOl8OKRR0ya3bEluVIoewq8kxphL
         82x1bpoBeeEjZL5IcQDPnH0fpg4oOeXiP+K+TKwdbg1KuCpszrXr3WRoE7N+asG7eCWI
         GNpZnbpI6GXefkuGzMAMHBVqPiJlP48BM5tYQ3NW7TIc5Z8sC9ZKK1c7iJ55Nt7T8zCA
         V42piWlluPXFCsW0N3sjPvkWxAixqbG74XsrKUX7eDdDk03LP0TEOajE2eyRqGQusaIz
         0f9vAhXLnE1yB58aFTMLP/woD1tgNsvT2sIAI4w9Ljdvg2JT2Ao2mjmcaIagoluhfs9q
         Jojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699024705; x=1699629505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X57psH+OB85EKMrdxaU2Ma2i9zrDrzyePuaysDdtYkg=;
        b=Q4MPBU9mOXES7MB71d4VkzLYAFeWQtOZnhpHqSxLV7TXaoA/kewBbWnD5DzymEUm1h
         1VcjOg/Y+STD0x8jF90GGuqNyKXXV27S7gJvRkbPwoYQ58RemJI8OGbw7wowuUznbgau
         7ko21/wOvTSShR20WoHChIGRpG/aRh/A/MmGFdDao7VlZkkFdhop5EWG1qyL821pNl3S
         G3uXMbL9qs7fPqtiZ+yf3bB/IEy3xPTTW0z+bzZ08kuSkORbdsAdcW+SFNpiaaG/Wvih
         B9DmRTUHjwZ2D3D/TgphYQ6+73ilVMuXgTevzneQupdN5ehnCwgP+Madhgads7goPzh7
         AV4A==
X-Gm-Message-State: AOJu0Yzs9WiyfQ/X+rL65gYsPaj0EzX2eFijqvnRGTMXy0VY7qSen4jx
        cTUpJkXqpTzaLyOGgNVf90Fpm9kdzV8uzg4LKXhiWw==
X-Google-Smtp-Source: AGHT+IEJc9WUvkIi6GxIXpAkohHYz8SyXVpr1o5R/HdJx6X53xgpFtg5/fpwefEjkwTM/XdXfQuLLuKQoDO+eaM7yxM=
X-Received: by 2002:a50:a68b:0:b0:543:6397:b46d with SMTP id
 e11-20020a50a68b000000b005436397b46dmr250321edc.2.1699024705010; Fri, 03 Nov
 2023 08:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231031090613.2872700-1-dapeng1.mi@linux.intel.com>
 <20231031090613.2872700-2-dapeng1.mi@linux.intel.com> <CALMp9eR_BFdNNTXhSpbuH66jXcRLVB8VvD8V+kY245NbusN2+g@mail.gmail.com>
 <c3f0e4ac-1790-40c1-a09e-209a09e3d230@linux.intel.com> <CALMp9eTDAiJ=Kuh7KkwdAY8x1BL2ZjdgFiPFRHXSSVCpcXp9rw@mail.gmail.com>
 <baa64cf4-11de-4581-89b6-3a86448e3a6e@linux.intel.com> <a14147e7-0b35-4fba-b785-ef568474c69b@linux.intel.com>
 <85706bd7-7df0-4d4b-932c-d807ddb14f9e@linux.intel.com> <CALMp9eS3NdTUnRrYPB+mMoGKj5NnsYXNUfUJX8Gv=wWCN4dkoQ@mail.gmail.com>
 <2004baa6-b494-462c-a11f-8104ea152c6a@linux.intel.com>
In-Reply-To: <2004baa6-b494-462c-a11f-8104ea152c6a@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 3 Nov 2023 08:18:10 -0700
Message-ID: <CALMp9eQkWtfppw2XemFpf2WT7PPpvPTuBjjmGbR6RP_i9mCENQ@mail.gmail.com>
Subject: Re: [Patch 1/2] KVM: x86/pmu: Add Intel CPUID-hinted TopDown slots event
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 8:13=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2023-11-02 1:45 p.m., Jim Mattson wrote:
> > On Wed, Nov 1, 2023 at 7:07=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.int=
el.com> wrote:
> >>
> >>
> >> On 11/1/2023 9:33 PM, Liang, Kan wrote:
> >>>
> >>> On 2023-10-31 11:31 p.m., Mi, Dapeng wrote:
> >>>> On 11/1/2023 11:04 AM, Jim Mattson wrote:
> >>>>> On Tue, Oct 31, 2023 at 6:59=E2=80=AFPM Mi, Dapeng
> >>>>> <dapeng1.mi@linux.intel.com> wrote:
> >>>>>> On 11/1/2023 2:22 AM, Jim Mattson wrote:
> >>>>>>> On Tue, Oct 31, 2023 at 1:58=E2=80=AFAM Dapeng Mi
> >>>>>>> <dapeng1.mi@linux.intel.com> wrote:
> >>>>>>>> This patch adds support for the architectural topdown slots even=
t
> >>>>>>>> which
> >>>>>>>> is hinted by CPUID.0AH.EBX.
> >>>>>>> Can't a guest already program an event selector to count event se=
lect
> >>>>>>> 0xa4, unit mask 1, unless the event is prohibited by
> >>>>>>> KVM_SET_PMU_EVENT_FILTER?
> >>>>>> Actually defining this new slots arch event is to do the sanity ch=
eck
> >>>>>> for supported arch-events which is enumerated by CPUID.0AH.EBX.
> >>>>>> Currently vPMU would check if the arch event from guest is support=
ed by
> >>>>>> KVM. If not, it would be rejected just like intel_hw_event_availab=
le()
> >>>>>> shows.
> >>>>>>
> >>>>>> If we don't add the slots event in the intel_arch_events[] array, =
guest
> >>>>>> may program the slots event and pass the sanity check of KVM on a
> >>>>>> platform which actually doesn't support slots event and program th=
e
> >>>>>> event on a real GP counter and got an invalid count. This is not
> >>>>>> correct.
> >>>>> On physical hardware, it is possible to program a GP counter with t=
he
> >>>>> event selector and unit mask of the slots event whether or not the
> >>>>> platform supports it. Isn't KVM wrong to disallow something that a
> >>>>> physical CPU allows?
> >>>>
> >>>> Yeah, I agree. But I'm not sure if this is a flaw on PMU driver. If =
an
> >>>> event is not supported by the hardware,  we can't predict the PMU's
> >>>> behavior and a meaningless count may be returned and this could misl=
ead
> >>>> the user.
> >>> The user can program any events on the GP counter. The perf doesn't
> >>> limit it. For the unsupported event, 0 should be returned. Please kee=
p
> >>> in mind, the event list keeps updating. If the kernel checks for each
> >>> event, it could be a disaster. I don't think it's a flaw.
> >>
> >>
> >> Thanks Kan, it would be ok as long as 0 is always returned for
> >> unsupported events. IMO, it's a nice to have feature that KVM does thi=
s
> >> sanity check for supported arch events, it won't break anything.
> >
> > The hardware PMU most assuredly does not return 0 for unsupported event=
s.
> >
> > For example, if I use host perf to sample event selector 0xa4 unit
> > mask 1 on a Broadwell host (406f1), I get...
>
> I think we have different understanding about the meaning of the
> "unsupported". There is no enumeration of the Architectural Topdown
> Slots, which only means the Topdown Slots/01a4 is not an architectural
> event on the platform. It doesn't mean that the event encoding is
> unsupported. It could be used by another event, especially on the
> previous platform.

If the same event encoding could be used by a microarchitectural event
on a prior platform, then it is *definitely* wrong for KVM to refuse
to monitor the event just because it isn't enumerated as a supported
architectural event.

> Except for the architectural events, the event encoding of model
> specific event is not guaranteed to be the same among different
> generations. On BDW, the 01a4 is a model specific event with other
> meanings. That's why you can observe some values.
>
> Please make sure to only test the event on an enumerated platform.
>
> Thanks,
> Kan
> >
> > # perf stat -e r01a4 sleep 10
> >
> >  Performance counter stats for 'sleep 10':
> >
> >            386,964      r01a4
> >
> >       10.000907211 seconds time elapsed
> >
> > Broadwell does not advertise support for architectural event 7 in
> > CPUID.0AH:EBX, so KVM will refuse to measure this event inside a
> > guest. That seems broken to me.
> >
> >>
> >>>
> >>> Thanks,
> >>> Kan
> >>>> Add Kan to confirm this.
> >>>>
> >>>> Hi Kan,
> >>>>
> >>>> Have you any comments on this? Thanks.
> >>>>
> >>>>
> >>>>>>> AFAICT, this change just enables event filtering based on
> >>>>>>> CPUID.0AH:EBX[bit 7] (though it's not clear to me why two indepen=
dent
> >>>>>>> mechanisms are necessary for event filtering).
> >>>>>> IMO, these are two different things. this change is just to enable=
 the
> >>>>>> supported arch events check for slot events, the event filtering i=
s
> >>>>>> another thing.
> >>>>> How is clearing CPUID.0AH:EBX[bit 7] any different from putting {ev=
ent
> >>>>> select 0xa4, unit mask 1} in a deny list with the PMU event filter?
> >>>> I think there is no difference in the conclusion but with two differ=
ent
> >>>> methods.
> >>>>
> >>>>
