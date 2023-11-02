Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70217DF912
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjKBRqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjKBRqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:46:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57BC182
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:46:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1441a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947170; x=1699551970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G85pRGyLip1+tcQHyAvlsC1xDG3Jc9lQ+KHYjFzzSQc=;
        b=UotzgL4+aFAn85dY3jbrkStVZvaHjnjDvV7JniuwXFI3o52AE9VQ+g+ylCBJeX1f7i
         512PslTR2OQElheY1S1MRdPMPhZpI6pJKb00W/W43dz4qmU1p8gHemwlOq2wjl330yJF
         ZrUbu1yKiPVxwg/Uqjd0lGaAfKGC/IbVzS7KED5/Fim9ZuMFvLnk+T6wU5e2RuAnPcB1
         LLB4cJpH72iSqbHIFk7HHuskQL+loM5CXwbRsj+MYipp5vvIkxDMDhVnx2jpTRUjvP5q
         xv7wjGxY/+ThbF6VFPP1DlU4kPw0lq0OcYHJcl+NzTfBlwoCmhqv/tcL5UHhheteYNW+
         7J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947170; x=1699551970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G85pRGyLip1+tcQHyAvlsC1xDG3Jc9lQ+KHYjFzzSQc=;
        b=vMoJTspv4WThE+uHlxgGUkKumnlD8ja5oBw+K6RCDMUv8o16prV6PmUkg/PCySFquk
         yppQNZ8ZSNOHG+dTQ/Kscsacb/FFvEcJ9MSqdL2gXgF4LC52TrFp9OD6asYNnHXuqWZU
         x9emHFAfbvsjiyqFfuH7VmzVX7iOEMCa2tbE5PIo+GAkZfi/YXm76O1Y7NbRpUUNYw09
         jwm4wET9crFAO3lV0UlHJSn1Dux/eZgUuhWjdAsnFGdvDMNg6xoriGS5xkc9Qnx1n0N6
         YKuZ2dvE+5r6O51VOaSFMZJJsrs15eULizub28CSmGBQbnyCrVpOrSag3x1qeWH6K9Er
         HT5A==
X-Gm-Message-State: AOJu0YzKdIaqKsqlTIiYwMj5vXoMK55Snp9outDhW53rqVUzov//2xrN
        zDbME3ln1n8OvsKflSYL4YzFgppAhgKstiQ5O1F5cmFKiJBp600qY6XreQ==
X-Google-Smtp-Source: AGHT+IGSe7qAyEQZs1bKmfSacwohVtcCs/g6GqCLZ2kkpMOCfQ8TXSwwazIgs5PBRlN5AX8zrrVPCXuZiJZrVtAnLpk=
X-Received: by 2002:a50:f60b:0:b0:543:3f97:aa0f with SMTP id
 c11-20020a50f60b000000b005433f97aa0fmr106457edn.4.1698947169816; Thu, 02 Nov
 2023 10:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231031090613.2872700-1-dapeng1.mi@linux.intel.com>
 <20231031090613.2872700-2-dapeng1.mi@linux.intel.com> <CALMp9eR_BFdNNTXhSpbuH66jXcRLVB8VvD8V+kY245NbusN2+g@mail.gmail.com>
 <c3f0e4ac-1790-40c1-a09e-209a09e3d230@linux.intel.com> <CALMp9eTDAiJ=Kuh7KkwdAY8x1BL2ZjdgFiPFRHXSSVCpcXp9rw@mail.gmail.com>
 <baa64cf4-11de-4581-89b6-3a86448e3a6e@linux.intel.com> <a14147e7-0b35-4fba-b785-ef568474c69b@linux.intel.com>
 <85706bd7-7df0-4d4b-932c-d807ddb14f9e@linux.intel.com>
In-Reply-To: <85706bd7-7df0-4d4b-932c-d807ddb14f9e@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 2 Nov 2023 10:45:55 -0700
Message-ID: <CALMp9eS3NdTUnRrYPB+mMoGKj5NnsYXNUfUJX8Gv=wWCN4dkoQ@mail.gmail.com>
Subject: Re: [Patch 1/2] KVM: x86/pmu: Add Intel CPUID-hinted TopDown slots event
To:     "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
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

On Wed, Nov 1, 2023 at 7:07=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.c=
om> wrote:
>
>
> On 11/1/2023 9:33 PM, Liang, Kan wrote:
> >
> > On 2023-10-31 11:31 p.m., Mi, Dapeng wrote:
> >> On 11/1/2023 11:04 AM, Jim Mattson wrote:
> >>> On Tue, Oct 31, 2023 at 6:59=E2=80=AFPM Mi, Dapeng
> >>> <dapeng1.mi@linux.intel.com> wrote:
> >>>> On 11/1/2023 2:22 AM, Jim Mattson wrote:
> >>>>> On Tue, Oct 31, 2023 at 1:58=E2=80=AFAM Dapeng Mi
> >>>>> <dapeng1.mi@linux.intel.com> wrote:
> >>>>>> This patch adds support for the architectural topdown slots event
> >>>>>> which
> >>>>>> is hinted by CPUID.0AH.EBX.
> >>>>> Can't a guest already program an event selector to count event sele=
ct
> >>>>> 0xa4, unit mask 1, unless the event is prohibited by
> >>>>> KVM_SET_PMU_EVENT_FILTER?
> >>>> Actually defining this new slots arch event is to do the sanity chec=
k
> >>>> for supported arch-events which is enumerated by CPUID.0AH.EBX.
> >>>> Currently vPMU would check if the arch event from guest is supported=
 by
> >>>> KVM. If not, it would be rejected just like intel_hw_event_available=
()
> >>>> shows.
> >>>>
> >>>> If we don't add the slots event in the intel_arch_events[] array, gu=
est
> >>>> may program the slots event and pass the sanity check of KVM on a
> >>>> platform which actually doesn't support slots event and program the
> >>>> event on a real GP counter and got an invalid count. This is not
> >>>> correct.
> >>> On physical hardware, it is possible to program a GP counter with the
> >>> event selector and unit mask of the slots event whether or not the
> >>> platform supports it. Isn't KVM wrong to disallow something that a
> >>> physical CPU allows?
> >>
> >> Yeah, I agree. But I'm not sure if this is a flaw on PMU driver. If an
> >> event is not supported by the hardware,  we can't predict the PMU's
> >> behavior and a meaningless count may be returned and this could mislea=
d
> >> the user.
> > The user can program any events on the GP counter. The perf doesn't
> > limit it. For the unsupported event, 0 should be returned. Please keep
> > in mind, the event list keeps updating. If the kernel checks for each
> > event, it could be a disaster. I don't think it's a flaw.
>
>
> Thanks Kan, it would be ok as long as 0 is always returned for
> unsupported events. IMO, it's a nice to have feature that KVM does this
> sanity check for supported arch events, it won't break anything.

The hardware PMU most assuredly does not return 0 for unsupported events.

For example, if I use host perf to sample event selector 0xa4 unit
mask 1 on a Broadwell host (406f1), I get...

# perf stat -e r01a4 sleep 10

 Performance counter stats for 'sleep 10':

           386,964      r01a4

      10.000907211 seconds time elapsed

Broadwell does not advertise support for architectural event 7 in
CPUID.0AH:EBX, so KVM will refuse to measure this event inside a
guest. That seems broken to me.

>
> >
> > Thanks,
> > Kan
> >> Add Kan to confirm this.
> >>
> >> Hi Kan,
> >>
> >> Have you any comments on this? Thanks.
> >>
> >>
> >>>>> AFAICT, this change just enables event filtering based on
> >>>>> CPUID.0AH:EBX[bit 7] (though it's not clear to me why two independe=
nt
> >>>>> mechanisms are necessary for event filtering).
> >>>> IMO, these are two different things. this change is just to enable t=
he
> >>>> supported arch events check for slot events, the event filtering is
> >>>> another thing.
> >>> How is clearing CPUID.0AH:EBX[bit 7] any different from putting {even=
t
> >>> select 0xa4, unit mask 1} in a deny list with the PMU event filter?
> >> I think there is no difference in the conclusion but with two differen=
t
> >> methods.
> >>
> >>
