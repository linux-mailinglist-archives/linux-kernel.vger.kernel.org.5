Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9877E0501
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjKCOvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjKCOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:51:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0C7D47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:51:17 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so10988a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699023075; x=1699627875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD/MaSMg/kgZSChzxbcT6Dosmg6sUB4leV3Wuu940+w=;
        b=CaROKxZNsEHaGYgGtOOs8Cb7ObewnZGsScJ7QKRhyssuMSUVg7Q1akmnIz894E+ejc
         gVnsU02rLrtmTMSVv7xBcFM/Cq2TyqFRQaFdKuxZc580q1qbs+iHOqM/xpp1J1OQUFEA
         z5umLy5WWekNNmQDT5Ztgu5e98xAv0Wied9/n635HNfueu1972gXKftw0RO7Ns8WA23x
         dYNoZ8DqHb3lohpCiThNiJW2xPZ4cMouU4Fsz12qMURxHivkJV8Ymd+FOd12epqU21lg
         rUzt664ebb/yY/T4bLKNkLpJmXEuUt5u4ub15SxF2HKDzkzmWqEXyScDrtYYajLOILPc
         oKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699023075; x=1699627875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zD/MaSMg/kgZSChzxbcT6Dosmg6sUB4leV3Wuu940+w=;
        b=gFXQOYtzSGrqUnzwga5qOejZVZzi0obC7rxZdTOg57KRCFJOi6KsM6GInHxrPXMw/F
         8lf4xN5uovp0J/cj9GM7apuGXZuDn8KTRrdEG4SM2tUL8mwQdy1NsXkH/dm5ruBFRT1K
         H2zggT9Do16oHdS5Hy45xlFN/ppXyiMicZ/5EODU4IW13kr+lv+P++J5omnyPP1MYIxi
         ZJuoTcGmIcR4sP2FJ5wHgQlWflkSKFLy6v6YILjEXyb5gNBYb9MTNWb5uXnjpHwKn91o
         5hNjzwO0sal95+UCmBusn0we2UWALOFprD9vMpK+ktMTb6UIWrlaYf7zn6cFe5j7JSRy
         dW5A==
X-Gm-Message-State: AOJu0YySD789RIX4IYhR9RMgB3PscV6oeR2wt8GhC13xVp3iIWEv39o3
        7mqWby9ei2HdfOJRvrtFgMXw7IuLNilhy1EupznmtpCin2JcOkidzRE=
X-Google-Smtp-Source: AGHT+IF2oN85Q8Nnco3g801bQXQ3CJKdrAkEvpDUCc/YmVsb406mQEIECzvYj7tlQdKG/TBi07IYavwOplWrfs5D04w=
X-Received: by 2002:a50:d50f:0:b0:542:d737:dc7e with SMTP id
 u15-20020a50d50f000000b00542d737dc7emr231923edi.0.1699023075385; Fri, 03 Nov
 2023 07:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231031090613.2872700-1-dapeng1.mi@linux.intel.com>
 <20231031090613.2872700-2-dapeng1.mi@linux.intel.com> <CALMp9eR_BFdNNTXhSpbuH66jXcRLVB8VvD8V+kY245NbusN2+g@mail.gmail.com>
 <c3f0e4ac-1790-40c1-a09e-209a09e3d230@linux.intel.com> <CALMp9eTDAiJ=Kuh7KkwdAY8x1BL2ZjdgFiPFRHXSSVCpcXp9rw@mail.gmail.com>
 <baa64cf4-11de-4581-89b6-3a86448e3a6e@linux.intel.com> <a14147e7-0b35-4fba-b785-ef568474c69b@linux.intel.com>
 <85706bd7-7df0-4d4b-932c-d807ddb14f9e@linux.intel.com> <CALMp9eS3NdTUnRrYPB+mMoGKj5NnsYXNUfUJX8Gv=wWCN4dkoQ@mail.gmail.com>
 <8272bad5-323e-46ae-9244-7b76832393fb@linux.intel.com>
In-Reply-To: <8272bad5-323e-46ae-9244-7b76832393fb@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 3 Nov 2023 07:50:59 -0700
Message-ID: <CALMp9eQOBAyCY9pC54rG4K2WvLnj1kw4oeNrNOPVDr1ChpbOXQ@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 3:03=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.c=
om> wrote:
>
>
> On 11/3/2023 1:45 AM, Jim Mattson wrote:
> > On Wed, Nov 1, 2023 at 7:07=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.int=
el.com> wrote:
> >>
> >> On 11/1/2023 9:33 PM, Liang, Kan wrote:
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
> >> Thanks Kan, it would be ok as long as 0 is always returned for
> >> unsupported events. IMO, it's a nice to have feature that KVM does thi=
s
> >> sanity check for supported arch events, it won't break anything.
> > The hardware PMU most assuredly does not return 0 for unsupported event=
s.
> >
> > For example, if I use host perf to sample event selector 0xa4 unit
> > mask 1 on a Broadwell host (406f1), I get...
> >
> > # perf stat -e r01a4 sleep 10
> >
> >   Performance counter stats for 'sleep 10':
> >
> >             386,964      r01a4
> >
> >        10.000907211 seconds time elapsed
> >
> > Broadwell does not advertise support for architectural event 7 in
> > CPUID.0AH:EBX, so KVM will refuse to measure this event inside a
> > guest. That seems broken to me.
>
>
> Yeah, I also saw similar results on Coffee Lake which doesn't support
> slots events and the return count seems to be a random and meaningless
> value. If so, this meaningless value may mislead the guest perf user.
>  From this point view it looks the sanity check in KVM is useful, but it
> indeed leads to different behavior between guest and host.

Calling this a "sanity check" is somewhat specious, since the guards
are based on the guest CPUID rather than the host CPUID. There is
nothing to prevent the hypervisor from setting guest
CPUID.0AH:EAX[31:24] to 32 and guest CPUID.0AH:EBX to 0, making 32
architectural events available to the guest. If it were really a
sanity check, it would prevent the guest from using architectural
events that are not supported by the host.

Moreover, I'm pretty sure that a "sanity check" would only apply to
top-down slots. Have there been any physical CPUs to date that support
architectural events, but do not support all of the first seven
architectural events?

> I'm neutral on either keeping or removing this check. How's other
> reviewers' opinion on this?
>
>
> >
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
