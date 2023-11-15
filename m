Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430057EC87A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjKOQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjKOQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:24:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C398E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:24:22 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso5656105b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700065461; x=1700670261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm2s3ZZnh5AYNa/PtFkxzzQrA/071VVCNOg0IXiaNPw=;
        b=a/wDF22EFLP/CL6q8girZXy+uFLolWU+A+XaYhumUYXm6m3/RaYk/kxcsHZ1MairZs
         3xMiIEUHjrrTYQZHi0P4eQ2PLo7Wa8MTNxnzKgJTAgrmr2/gD/ymGjcNuY2D9TvPxeP8
         gikmbE3PcqsRi6CeiDVS8aZEh/YPmvoLNHBkyAZuOvLArxByqHko8w6FgVfoin7w9/2Y
         32gl1vwPhUEBOX5S+Gh5vTJZ5fKtbb4sMCCrTjAlJnlOgwz4bpT4oTpNwd0PI6GEsqaG
         kNfjaa+hh6bhlH5bZWQWXQjhcsc2wEcT/orqY/LVDzIHvMy7S0Db/CYkgfWBc6IA1inz
         FhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065461; x=1700670261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rm2s3ZZnh5AYNa/PtFkxzzQrA/071VVCNOg0IXiaNPw=;
        b=XPzoRvqbBuBWuyUopcfbwqhWuJ7fjPCVaOuaJMDHztxyMD2Cmpus+BjFBRkBVxfUlu
         1oQT2mOhEWJrktSyIpfJPtWX7jzbTKGiRLrPyJO3Csx/qTbHZgZTj60GT1n9dqLe/WAi
         1UqwVCaqpDfX1pmTCqSDxH+Yry1BQfDpmW7hkc+SdGNjYWWwIRUj0nhj5WJ+n2zs2rbG
         HCG6vRl+3yGCYE3rT9HzbVbvWnyE/6ZfycffZXVGMLZZcft9kY30QmjaWwoh6nD49xgt
         Q7Pv2DEGF/us1kjYCKTHXBUr0WruxLEjjZzN6Dan46tRiS9IU34uTgVz96nBGOIC+h8T
         gtTQ==
X-Gm-Message-State: AOJu0Yw3Xx/dcsNq8bLfO3SRt4OOl+j+g7lpoIOeaw5hVNQn/4yKTO7P
        qM1jZ9dGues0iToRfDppR0bMnvIJwRCfMynIlDbxRA==
X-Google-Smtp-Source: AGHT+IEYqoGyBOYH2CRUEUDNMopPpnlzW8Jhu4m6FA70HrcOz9vMc3lEjSBBgyTkxcz58VzywgmUSpFDneJs6jg67/I=
X-Received: by 2002:a05:6a20:da82:b0:187:9392:cfdd with SMTP id
 iy2-20020a056a20da8200b001879392cfddmr1099674pzb.24.1700065461385; Wed, 15
 Nov 2023 08:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20231115061811.10041-1-joshua.yeong@starfivetech.com>
 <CAK9=C2VXxNjKOq1XqQ9t6iVELdj2fFi85K77xNCOfdf3WRdy8w@mail.gmail.com> <f373645c-1e89-df76-e545-21bf0ba9ee8f@starfivetech.com>
In-Reply-To: <f373645c-1e89-df76-e545-21bf0ba9ee8f@starfivetech.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 15 Nov 2023 21:54:09 +0530
Message-ID: <CAK9=C2W3_LNjQkW0G5TypNW_=3sGOV8NMuYEwnq5Yj=RmgkE3A@mail.gmail.com>
Subject: Re: [PATCH 1/1] clocksource/timer-risc: Add riscv_clock_shutdown callback
To:     Joshua Yeong <joshua.yeong@starfivetech.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, leyfoon.tan@starfivetech.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 1:22=E2=80=AFPM Joshua Yeong
<joshua.yeong@starfivetech.com> wrote:
>
> Hi Anup,
>
> On 15-Nov-23 3:00 PM, Anup Patel wrote:
> > On Wed, Nov 15, 2023 at 11:49=E2=80=AFAM Joshua Yeong
> > <joshua.yeong@starfivetech.com> wrote:
> >> Add clocksource detach/shutdown callback to disable RISC-V timer inter=
rupt when
> >> switching out riscv timer as clock source
> >>
> >> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> >> ---
> >>   drivers/clocksource/timer-riscv.c | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/t=
imer-riscv.c
> >> index da3071b387eb..588a05459b6a 100644
> >> --- a/drivers/clocksource/timer-riscv.c
> >> +++ b/drivers/clocksource/timer-riscv.c
> >> @@ -50,12 +50,19 @@ static int riscv_clock_next_event(unsigned long de=
lta,
> >>          return 0;
> >>   }
> >>
> >> +static int riscv_clock_shutdown(struct clock_event_device *evt)
> >> +{
> >> +       sbi_set_timer(-1);
> > Use riscv_clock_event_stop() here.
> You mean replacing riscv_clock_shutdown as riscv_clock_event_stop?

I meant replacing sbi_set_timer() with riscv_clock_event_stop().

> >
> >> +       return 0;
> >> +}
> >> +
> >>   static unsigned int riscv_clock_event_irq;
> >>   static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) =
=3D {
> >>          .name                   =3D "riscv_timer_clockevent",
> >>          .features               =3D CLOCK_EVT_FEAT_ONESHOT,
> >>          .rating                 =3D 100,
> >>          .set_next_event         =3D riscv_clock_next_event,
> >> +       .set_state_shutdown     =3D riscv_clock_shutdown,
> >>   };
> >>
> >>   /*
> >> --
> >> 2.25.1
> >>
> > Regards,
> > Anup

Regards,
Anup
