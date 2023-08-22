Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B1D783695
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 02:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjHVAHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 20:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHVAHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:07:11 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E716E11C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 17:07:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-986d8332f50so520107866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692662825; x=1693267625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J3x0Gt197keDgNUTYsLDArxgf8balIGee5TfL+T5L0=;
        b=FWjSYVQEGXEWzEz7GKPzFrw4WfqoUcZzBam9Jo6qvspHpx1KR6FY84BJ7KFQj7WdNc
         V/lt2+wWYExmou42pnOfM6FJUvl6adCPRo9OQSZ8fT2el28gfCscm5P+A/fOL4YNnQrL
         xPWH70zL7Vxiqx8agwhI7xu1Nh+ezqxcH8Gxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692662825; x=1693267625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J3x0Gt197keDgNUTYsLDArxgf8balIGee5TfL+T5L0=;
        b=ktz4xNaZOixwglLzGi7pVU4QcXepczJPSYEydNgpMglUU/dip9P1e68bIqXTmSnfJX
         i9DsQisKB7tXs7vdX9SzkMDt71f8aHiuAf1TEDcOZQJNh/3h1y0Nej4AODisEfK9+B5d
         82vGWVHLQ7y7xbeGLtx9bbKNjvn7QIGhQXYDIfHDq/rMPb98e1qUZRailFswtl9QCQq0
         Z9KSmSrA6/5TP8vRqnrOd1wWO4tClXTU7tHzohxeAwBLpx8Gb8KKTOStR/s3Wm5hF2Zl
         bo7PJQNsjeXgzJf/usn9IpBnMo4T5Q1lsZBNfWD0K77HrrHNkcf28obrkYYqKGqXqZg2
         hUHw==
X-Gm-Message-State: AOJu0YzLHOM6bX0dX0SectZvrIW7rV5eSq/2YTHtWGMxMpTgCV3CH53f
        NjI8w8eSkyCX0Imp+1Z/QgWg6uHNabcVCm0DcUNBk2B/
X-Google-Smtp-Source: AGHT+IHx19bTJy5pEaohg3F8HoLAuyHCf9QbA1/WEaFQ4mv5ZRG//cSeWZnxZoqqfKfDGL73I5n4AA==
X-Received: by 2002:a17:906:2d1:b0:98d:e605:2bce with SMTP id 17-20020a17090602d100b0098de6052bcemr6945211ejk.46.1692662824829;
        Mon, 21 Aug 2023 17:07:04 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id lh18-20020a170906f8d200b009a1a5a7ebacsm1328415ejb.201.2023.08.21.17.07.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 17:07:04 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so5724a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 17:07:03 -0700 (PDT)
X-Received: by 2002:a50:8757:0:b0:51a:1ffd:10e with SMTP id
 23-20020a508757000000b0051a1ffd010emr19923edv.3.1692662823330; Mon, 21 Aug
 2023 17:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.5.I65981105e1f62550b0316625dd1e599deaf9e1aa@changeid> <ZNDGMJW01avOMShn@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZNDGMJW01avOMShn@FVFF77S0Q05N.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 17:06:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wz4Y836__Fo=Va8ek9BLEoTTbYx_zycBuVony37eOGVg@mail.gmail.com>
Message-ID: <CAD=FV=Wz4Y836__Fo=Va8ek9BLEoTTbYx_zycBuVony37eOGVg@mail.gmail.com>
Subject: Re: [PATCH v9 5/7] arm64: ipi_debug: Add support for backtrace using
 the debug IPI
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 7, 2023 at 3:23=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Thu, Jun 01, 2023 at 02:31:49PM -0700, Douglas Anderson wrote:
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> > Enable arch_trigger_cpumask_backtrace() support on arm64 using the new
> > debug IPI. With this arm64 can now get backtraces in cases where
> > callers of the trigger_xyz_backtrace() class of functions don't check
> > the return code and implement a fallback. One example is
> > `kernel.softlockup_all_cpu_backtrace`. This also allows us to
> > backtrace hard locked up CPUs in cases where the debug IPI is backed
> > by an NMI (or pseudo NMI).
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v9:
> > - Added comments that we might not be using NMI always.
> > - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> > - arch_trigger_cpumask_backtrace() no longer returns bool
> >
> > Changes in v8:
> > - Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
> >
> >  arch/arm64/include/asm/irq.h  |  3 +++
> >  arch/arm64/kernel/ipi_debug.c | 25 +++++++++++++++++++++++--
> >  2 files changed, 26 insertions(+), 2 deletions(-)
>
> As with prior patches, I'd prefer if this lived in smp.c with the other I=
PI
> logic.
>
> >
> > diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.=
h
> > index fac08e18bcd5..be2d103f316e 100644
> > --- a/arch/arm64/include/asm/irq.h
> > +++ b/arch/arm64/include/asm/irq.h
> > @@ -6,6 +6,9 @@
> >
> >  #include <asm-generic/irq.h>
> >
> > +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclud=
e_self);
> > +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> > +
> >  struct pt_regs;
> >
> >  int set_handle_irq(void (*handle_irq)(struct pt_regs *));
> > diff --git a/arch/arm64/kernel/ipi_debug.c b/arch/arm64/kernel/ipi_debu=
g.c
> > index b57833e31eaf..6984ed507e1f 100644
> > --- a/arch/arm64/kernel/ipi_debug.c
> > +++ b/arch/arm64/kernel/ipi_debug.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > +#include <linux/nmi.h>
> >  #include <linux/smp.h>
> >
> >  #include "ipi_debug.h"
> > @@ -24,11 +25,31 @@ void arm64_debug_ipi(cpumask_t *mask)
> >       __ipi_send_mask(ipi_debug_desc, mask);
> >  }
> >
> > +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclud=
e_self)
> > +{
> > +     /*
> > +      * NOTE: though nmi_trigger_cpumask_backtrace has "nmi_" in the n=
ame,
> > +      * nothing about it truly needs to be backed by an NMI, it's just=
 that
> > +      * it's _allowed_ to be called from an NMI. If set_smp_debug_ipi(=
)
> > +      * failed to get an NMI (or pseudo-NMI) this will just be backed =
by a
> > +      * regular IPI.
> > +      */
> > +     nmi_trigger_cpumask_backtrace(mask, exclude_self, arm64_debug_ipi=
);
> > +}
> > +
> >  static irqreturn_t ipi_debug_handler(int irq, void *data)
> >  {
> > -     /* nop, NMI handlers for special features can be added here. */
> > +     irqreturn_t ret =3D IRQ_NONE;
> > +
> > +     /*
> > +      * NOTE: Just like in arch_trigger_cpumask_backtrace(), we're cal=
ling
> > +      * a function with "nmi_" in the name but it works fine even if w=
e
> > +      * are using a regulaor IPI.
> > +      */
> > +     if (nmi_cpu_backtrace(get_irq_regs()))
> > +             ret =3D IRQ_HANDLED;
> >
>
> Does this need the printk_deferred_{enter,exit}() that 32-bit arm has?

I don't _think_ so, but I also don't _think_ it's needed for arm32.
;-) Let me explain my logic and you can tell me if it sounds right to
you.

If we're doing the backtrace in pseudo-NMI context then we definitely
don't need it. Specifically, the printk_deferred_{enter,exit}() just
manages the per-cpu "printk_context" value. That value doesn't matter
if "in_nmi()" returns true.

If we're _not_ doing the backtrace in pseudo-NMI context then I think
we also don't need it. After all, if we're not in pseudo-NMI context
then it's perfectly fine to print, right?

While it's hard to know 100% for sure, my best guess is that in arm
this might have helped prevent stack traces from getting interspersed
among one another. I guess this is no longer needed as of commit
55d6af1d6688 ("lib/nmi_backtrace: explicitly serialize banner and
regs")? In any case, when I tested this earlier things seemed to
printout fine without it...

That being said, it wouldn't hurt to include it here and I'll do it if you =
want.

-Doug
