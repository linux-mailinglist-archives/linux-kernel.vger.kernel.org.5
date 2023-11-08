Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36C47E52B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjKHJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:38:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC08199
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:38:24 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507f1c29f25so8767605e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 01:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1699436303; x=1700041103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG7C3k1qNJgTxQd+UMo+08+xX+MKfZu/6cmf5OErYq4=;
        b=lURNSeeNDGYf26X2Znc6FkTYy62H931F9SQbcy6pckm318jQEQkf4Q/SRhH/4uqbuf
         /rtPrQi9aZ6tDM2X0Y2qviachY3LxmIiHYiel/GXR8/NFVSjPkQOMItk3RLQr2cRHWp0
         fzEpsKxBlermADo390HflQ8Wbubg4Pb44fLs2JCg5mWzVNhww6gLCo9OjDnWQMvsz6y1
         rTg+6+LE0F9jrF2+uQDTvJgpv9hxBdOBMKJil91VLb1zW+uhZZdcmwOgFLbG92jJ6CNn
         9cws1VHabRLdUfbKU4KK4foOth8oY42yEDdcIewFtyivQjpNxLwZjQpnpYYF7gkfFgV/
         ja/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699436303; x=1700041103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bG7C3k1qNJgTxQd+UMo+08+xX+MKfZu/6cmf5OErYq4=;
        b=gYB6awN3Ch9djurP/SIOR0S6q2x7t1M5SQtKb5feEgA74NqHlJvXBG1EWLCiS9y0bV
         tAQozN4/bnOcIfcP0qlwN5xXPm8wtcc3cG/CoYbW1aoLFSztvpbczQx22BhBgLHTxvUY
         guMZq/cvm7CJiiYN0QqyCLjDIi49Fp/GJ6auFE4Qs32q5zNZg9RECnnvka2IpphRwCcR
         5Cp2GGwnDGCmHnSXca72FkdJWBfTXCAPbGE377IUejvUD7+rTLkbNPXM7ic1rL97Y4fF
         yTgJFQ7kRHYkbLJAmZO/1Nm0cf+6aYdQNJsflFEL3WJjyKKHfRHVrpQN/DGeBcfNdIgS
         RPBg==
X-Gm-Message-State: AOJu0YwLSRpkdA8YZ3jhuE0lqGPWkOlJ1HP1O2y5LEJHMHT265pZKp2P
        Uo4eXzI2+RHhv1YVTMt9MhW28UROoONvqtFM+vR9iQ==
X-Google-Smtp-Source: AGHT+IFdC111oKTdQh83UgN1Q2mg6/fMSz+soYR2rObGgWDF/KH3v7v+vvFsWbygGqwzP+r6oJGRJPyexAlRvn26NXI=
X-Received: by 2002:a05:6512:318b:b0:509:44b6:e3ac with SMTP id
 i11-20020a056512318b00b0050944b6e3acmr1153406lfe.61.1699436302659; Wed, 08
 Nov 2023 01:38:22 -0800 (PST)
MIME-Version: 1.0
References: <CANi1PHhzk80HvwQbBM46gpJ6_AA_P6+m5Jo0Nuy_MAdA4C2BhQ@mail.gmail.com>
 <87ttql5aq7.wl-maz@kernel.org> <CANi1PHieGooO0DK=6BPwq0UknHzsn9QM3rFQkh3HLMfWxDseUQ@mail.gmail.com>
 <86cyx250w9.wl-maz@kernel.org> <CANi1PHjAwLWAq9EW7r5Yh_xbvPiJMsq8342JwAGafz1d1NUhSA@mail.gmail.com>
 <86msw01e4m.wl-maz@kernel.org> <CANi1PHiXFKz6VqBys=Xw=rgR_gJKPO661iW-TMrF20j5yS4unQ@mail.gmail.com>
 <86il6h1ztt.wl-maz@kernel.org>
In-Reply-To: <86il6h1ztt.wl-maz@kernel.org>
From:   Jan Henrik Weinstock <jan@mwa.re>
Date:   Wed, 8 Nov 2023 10:38:11 +0100
Message-ID: <CANi1PHgnoXveoeokTDHtNSRXC9tU0QGykpSVUz2H3wON5MaXBA@mail.gmail.com>
Subject: Re: KVM exit to userspace on WFI
To:     Marc Zyngier <maz@kernel.org>
Cc:     oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Lukas_J=C3=BCnger?= <lukas@mwa.re>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa., 4. Nov. 2023 um 13:13 Uhr schrieb Marc Zyngier <maz@kernel.org>:
>
> On Tue, 31 Oct 2023 19:21:16 +0000,
> Jan Henrik Weinstock <jan@mwa.re> wrote:
> >
> > Am Mo., 30. Okt. 2023 um 13:36 Uhr schrieb Marc Zyngier <maz@kernel.org=
>:
> > >
> > > [please make an effort not to top-post]
> > >
> > > On Fri, 27 Oct 2023 18:41:44 +0100,
> > > Jan Henrik Weinstock <jan@mwa.re> wrote:
> > > >
> > > > Hi Marc,
> > > >
> > > > the basic idea behind this is to have a (single-threaded) execution=
 loop,
> > > > something like this:
> > > >
> > > > vcpu-thread:    vcpu-run | process-io-devices | vcpu-run | process-=
io...
> > > >                          ^
> > > >                   WFX or timeout
> > > >
> > > > We switch to simulating IO devices whenever the vcpu is idle (wfi) =
or exceeds
> > > > a certain budget of instructions (counted via pmu). Our fallback cu=
rrently is
> > > > to kick the vcpu out of its execution using a signal (via a timeout=
/alarm). But
> > > > of course, if the cpu is stuck at a wfi, we are wasting a lot of ti=
me.
> > > >
> > > > I understand that the proposed behavior is not desirable for most u=
se cases,
> > > > which is why I suggest locking it behind a flag, e.g.
> > > > KVM_ARCH_FLAG_WFX_EXIT_TO_USER.
> > >
> > > But how do you reconcile the fact that exposing this to userspace
> > > breaks fundamental expectations that the guest has, such as getting
> > > its timer interrupts and directly injected LPIs? Implementing WFI in
> > > userspace breaks it. What about the case where we don't trap WFx and
> > > let the *guest* wait for an interrupt?
> >
> > Timer interrupts etc. will be injected into the vcpu during the
> > io-phases. When there are no interrupts present and the guest performs
> > a WFI, we can just skip forward to the next timer event.
>
> Skip forward? What does that mean? Compress time and move along?

Yes, advance virtual time to the next relevant event (timer interrupt, I/O,=
 ...)

> > > Honestly, what you are describing seems to be a use model that doesn'=
t
> > > fit KVM, which is a general purpose hypervisor, but more a simulation
> > > environment. Yes, the primitives are the same, but the plumbing is
> > > wildly different.
> >
> > Agreed.
> >
> > > *If* that's the stuff you're looking at, then I'm afraid you'll have
> > > to do it in different way, because what you are suggesting is
> > > fundamentally incompatible with the guarantees that KVM gives to gues=
t
> > > and userspace. Because your KVM_ARCH_FLAG_WFX_EXIT_TO_USER is really =
a
> > > lie. It should really be named something more along the lines of
> > > KVM_ARCH_FLAG_WFX_EXIT_TO_USER_SOMETIME_AND_I_DONT_EVEN_KNOW_WHEN
> > > (probably with additional clauses related to breaking things).
> >
> > I have attached a reworked version of the patch as a reference (based
> > on my 5.15 kernel). It puts the modified behavior behind a new
> > capability so as to not interfere with the current expectations
> > towards handling WFI/WFE.
> > I think it should now trap all blocking calls to WFx on the vcpu and
> > reliably return to the userspace. If I have missed something that
> > would cause the vcpu to not trap on a WFI kindly let me know.
>
> Oh FFS. Please read my previous emails, the architecture spec, and
> understand that WFx is a *hint*. Given your line of work, I would hope
> you understand the implications of this.
>
> >
> > > Overall, you are still asking for something that is not guaranteed at
> > > the architecture level, even less in KVM, and I'm not going to add
> > > support for something that can only work "sometime".
> >
> > I am not quite sure what you mean with "sometime". Are you referring
> > to WFIs as NOPs? Or WFIs that do not yield because of pending
> > interrupts?
>
> NOP is a valid implementation of WFx. WFx doesn't have to trap. Its
> only requirements are not to lose state. Nothing else. Trapping is a
> 'quality of implementation' feature, and doesn't affect correctness.
> And yes, there are machines out there that will absolutely ignore any
> request for trapping.
>
> From the architecture spec (ARM DDI 0487J.a, D19.2.48, TWI):
>
> <quote>
> Since a WFI can complete at any time, even without a Wakeup event, the
> traps on WFI are not guaranteed to be taken, even if the WFI is
> executed when there is no Wakeup event. The only guarantee is that if
> the instruction does not complete in finite time in the absence of a
> Wakeup event, the trap will be taken.
> </quote>

Yes, this guarantee is what I want: if the instruction does not
complete within a finite time, trap (and return to userspace).

> Similar verbiage exists for WFE. Do you now see why your proposal
> makes little sense?
>
> >
> > The point of my patch is not to accurately count every single WFI. The
> > point is to prevent the host cpu from sleeping just because my vcpu
> > executed a WFI somewhere in the guest software. If a WFI is executed
> > by the guest and that does not result in my vcpu thread to block (in
> > other words: the vcpu continues executing instructions beyond the WFI)
> > then it also should not exit to userspace. So instead of
> > "KVM_ARCH_FLAG_WFX_EXIT_TO_USER_SOMETIME_AND_I_DONT_EVEN_KNOW_WHEN" it
> > is really "KVM_ARCH_FLAG_WFX_EXIT_TO_USER_WHENEVER_YOU_WOULD_OTHERWISE_=
YIELD_AND_I_CANNOT_GET_MY_THREAD_BACK".
>
> You already must be able to handle a guest spinning in a loop without
> a WFI. So why would WFI be of interest more than anything else? You
> can always make an interrupt pending at any point, without having to
> wait for WFI to occur. Just make the interrupt pending (which, if you
> emulate everything in userspace, is just giving the vcpu thread a
> signal).

I can use a watchdog that kicks ("interrupts") the VCPU every so often
in order to check if it was stuck in a WFI. But if a WFI occurs right
at the beginning of its execution, I am wasting a lot of time waiting
for the watchdog timeout. Hence my idea to have the VCPU report its
idleness back to userspace.

> My hunch is that your SW is trying to do the interrupt injection from
> the vcpu thread, which is a pretty broken model (it would badly model
> the concept of an interrupt being an asynchronous event).
>
> Honestly, if there was one thing I would add to the kernel, it would
> be an option to *prevent* any trap of WFx, because that at least is
> something we can universally enforce and guarantee to userspace.
> Anything else is only wishful thinking.

Would that not block your host CPU until the next periodic timer
event? What about other processes that could run on that core while
your VCPU is idle?

>         M.
>
> --
> Without deviation from the norm, progress is not possible.

--=20
Dr.-Ing. Jan Henrik Weinstock
Managing Director

MachineWare GmbH | www.machineware.de
H=C3=BChnermarkt 19, 52062 Aachen, Germany
Amtsgericht Aachen HRB25734

Gesch=C3=A4ftsf=C3=BChrung
Lukas J=C3=BCnger
Dr.-Ing. Jan Henrik Weinstock
