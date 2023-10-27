Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592657D9EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjJ0RmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjJ0RmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:42:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B86011B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 10:41:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507d1cc0538so3227825e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1698428515; x=1699033315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zl9xOdOypts4WvQdyS7jVbRn41c2NCajV1vwM0e7soo=;
        b=VQiSOs3KK/7bRSgdw8x7bA1ycXi85+TOCljMbaH7lsrBQV7e0hssFwRjumY3oslxXx
         EN6TU7ztcyyPz/ag6Npp8puj8/aWjYZMQOydT5jxkj7y8KOSmGpNAJoEpjvBB1g4l3C4
         7Nf62CkUEicvpvBkaiBrPAm3QXrCN/aK7YXVXI1zYJqJqoGYjOKbwmOTYxPC0jnI77W5
         xaXMgiJUyEFus+gJ35Byuihtu64V5+BuY8dyeedGJo+3FsVq6g5DqJyIELyKmQwObsOq
         pfDi+dRIsKKdr9zhEhknR09aULxbtSHIVpONSytyL3O2R07OESa1DOpUpuy0QFPE3cPI
         bsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698428515; x=1699033315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zl9xOdOypts4WvQdyS7jVbRn41c2NCajV1vwM0e7soo=;
        b=GjMbtA0kyyl0Kq/o/Su/ZXkToqJWubdy283OXLYkymEQpi/oZEMa86VUQJFR2j2VxI
         9AQys15s+wUS74igjp9emr5nlfst7v8xvQNbiuUB3Uu0RVpmnKc9A1+N5frKWKCmMm73
         NZ8Vt4IZafa9IBmBn+xTxtlkUxpYyG/pnfrhqRNzB6CTtBwGRTbi0cc8rJ+SnCg67gxe
         sj6S3gpKHhKca44nRwkyQGqOJSiFVMRyv7DtsWd+mZNMxV8N6d+tJe3fHdl2h6/j3fmQ
         WaeZPAhYR63hdqh1ztJ2qSpP9ZL/CvG31zPoHRJ/AbBHULk0EQcY+DeHwLDdf0P0Eyof
         SEwQ==
X-Gm-Message-State: AOJu0YzKSZW6uufZ1XDbQhRMyZT/adEgZY2Ydn9zyzM5DSI42Ntroa35
        f2/htmIiRnCgrjE7k44jMloz58DHHXa2a+A4twhHqORcY6ci63Ch5O6iJ00lxM0=
X-Google-Smtp-Source: AGHT+IFHRMYL4gdEZHBAtJc+AHbUz15+hTrEB000BnqewEz2QhmjMoLFLieXWb0l5S9dAxYJMOtNQSEd0QJsAJXcobs=
X-Received: by 2002:a05:6512:282c:b0:508:2022:7738 with SMTP id
 cf44-20020a056512282c00b0050820227738mr2385452lfb.19.1698428515297; Fri, 27
 Oct 2023 10:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <CANi1PHhzk80HvwQbBM46gpJ6_AA_P6+m5Jo0Nuy_MAdA4C2BhQ@mail.gmail.com>
 <87ttql5aq7.wl-maz@kernel.org> <CANi1PHieGooO0DK=6BPwq0UknHzsn9QM3rFQkh3HLMfWxDseUQ@mail.gmail.com>
 <86cyx250w9.wl-maz@kernel.org>
In-Reply-To: <86cyx250w9.wl-maz@kernel.org>
From:   Jan Henrik Weinstock <jan@mwa.re>
Date:   Fri, 27 Oct 2023 19:41:44 +0200
Message-ID: <CANi1PHjAwLWAq9EW7r5Yh_xbvPiJMsq8342JwAGafz1d1NUhSA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

the basic idea behind this is to have a (single-threaded) execution loop,
something like this:

vcpu-thread:    vcpu-run | process-io-devices | vcpu-run | process-io...
                         ^
                  WFX or timeout

We switch to simulating IO devices whenever the vcpu is idle (wfi) or excee=
ds
a certain budget of instructions (counted via pmu). Our fallback currently =
is
to kick the vcpu out of its execution using a signal (via a timeout/alarm).=
 But
of course, if the cpu is stuck at a wfi, we are wasting a lot of time.

I understand that the proposed behavior is not desirable for most use cases=
,
which is why I suggest locking it behind a flag, e.g.
KVM_ARCH_FLAG_WFX_EXIT_TO_USER.


Am Mi., 25. Okt. 2023 um 14:42 Uhr schrieb Marc Zyngier <maz@kernel.org>:
>
> On Wed, 25 Oct 2023 13:12:14 +0100,
> Jan Henrik Weinstock <jan@mwa.re> wrote:
> >
> > Hi Marc,
> >
> > Thanks for your feedback. I understand that request_interrupt_window
> > is not to be used. I assume a setting a flag is a better way,
> > something similar to KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER, e.g.
> > KVM_ARCH_FLAG_WFX_EXIT_TO_USER.
> >
> > I will also check that WFx traps are always enabled while this mode is
> > active to make sure userspace does not get blocked/scheduled out.
>
> Why would that be an acceptable behaviour?
>
> > The reason for this is that we cannot have the thread that executes
> > KVM_RUN to be blocked or scheduled out whenever it hits a WFI.
>
> Why? If that's not acceptable, how do you even cope with the basic
> preemption?
>
> > Nop-WFIs are not a problem, since the PE will just continue executing
> > instructions, which is fine. We are currently using a timeout signal
> > that kicks KVM_RUN back into userspace, but we are seeing a lot of
> > time wasted because our KVM thread hangs in WFI/WFEs. It would be
> > better if we could just return from KVM_RUN immediately if the thread
> > would otherwise be blocked.
>
> On the face of it, this makes little sense:
>
> - While in userspace, no interrupt source that normally delivered
>   without any userpsace intervention will be blocked (timers,
>   VLPIs...). I cannot how this can be a good idea.
>
> - Trapping WFE is an important scheduling hint, and returning to
>   userspace defeats it. Contended spinlocks, for example, will be even
>   slower to acquire.
>
> I'm sure you have a particular use case for such a degraded behaviour,
> but since you are not describing it, I'm not at all inclined to
> actively break KVM's performance and scalability.
>
> Thanks,
>
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
