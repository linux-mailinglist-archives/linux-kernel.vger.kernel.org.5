Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197CD783578
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjHUWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHUWRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:17:41 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA4A13D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:17:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c1f6f3884so499947066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692656250; x=1693261050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pnuXYzRxiJAi4ZTWILf7If+RLyD4xsvL3DTtJAtXks=;
        b=jLsfB40K0iTtGMHcALdftOBDI9jjEIlg57WsqwJSxo6e7OeFyL9cX/tgmBWm8jLV5r
         Mev1IgJgTtHQbUNkxuo4GfhnVEvFq0EKY2pv+3VHoLxylifSEi9E8xUtvui5tEEyREfL
         tA5sd/YKSPlF1uLSmKiUITzEvC0D5Q5uN6diw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692656250; x=1693261050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pnuXYzRxiJAi4ZTWILf7If+RLyD4xsvL3DTtJAtXks=;
        b=QMvYQtJdN5hRvXirrDlir5yidfUX43E6l6SA9BJCTWiM8tR/o9IqOWgZm7usNCQFtC
         LuOhpoToEIU0NXmstQbYZStWFJQtsHlZrtSxwoi3IvZbnTZwWChZR0b+hADi4cDDnap8
         BQgiBziTqBW/GKAypA7IwWbORACxjUzirl8waicZygAAI8hYUzXCmaQZPEZ7e8pK6QYj
         qejDDvRGJsH8ZIHZVkFYGoppHu6XBci3XS27hqyCuqK/jvlVjRP50puDhvUD4BY1nBVe
         CG1K69j8ezxwnFyVajxnnSD62Fx/xhlpGH4rQ0HN+7lkU8sm91gPEEbPjAQvZyzfbnfc
         5yYg==
X-Gm-Message-State: AOJu0YxWFR+zKXbLQQOUmoRHhUs5L6ZEFtkYhgKiIga9+YgS1/NSOU6u
        NpBTYmWBtsmDheyOhSl54h6C/i4yYB9VO5q/cTbIxMw+
X-Google-Smtp-Source: AGHT+IG0vogBmEaTqzomdqhXUdd29gogQ+GWtYBfmZjT+TJMq0cu9mwWd0QUelc5g/lar4UU3NQg0g==
X-Received: by 2002:a17:906:844a:b0:993:f12a:39ce with SMTP id e10-20020a170906844a00b00993f12a39cemr5899945ejy.15.1692656250536;
        Mon, 21 Aug 2023 15:17:30 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id x5-20020a170906148500b0098e42bef736sm7205853ejc.176.2023.08.21.15.17.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 15:17:30 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fee2ba9d09so12945e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:17:30 -0700 (PDT)
X-Received: by 2002:a05:600c:82c8:b0:3f7:e4d8:2569 with SMTP id
 eo8-20020a05600c82c800b003f7e4d82569mr16271wmb.5.1692656229438; Mon, 21 Aug
 2023 15:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.3.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid> <ZNDDgRuNGzovddaO@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZNDDgRuNGzovddaO@FVFF77S0Q05N.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 15:16:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVJsJSc=uQWad4x0EV2-iROFcueW_=4VbM+0N0+aD96g@mail.gmail.com>
Message-ID: <CAD=FV=VVJsJSc=uQWad4x0EV2-iROFcueW_=4VbM+0N0+aD96g@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] arm64: Add framework for a debug IPI
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 7, 2023 at 3:12=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Thu, Jun 01, 2023 at 02:31:47PM -0700, Douglas Anderson wrote:
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> > Introduce a framework for an IPI that will be used for debug
> > purposes. The primary use case of this IPI will be to generate stack
> > crawls on other CPUs, but it will also be used to round up CPUs for
> > kgdb.
> >
> > When possible, we try to allocate this debug IPI as an NMI (or a
> > pseudo NMI). If that fails (due to CONFIG, an incompatible interrupt
> > controller, a quirk, missing the "irqchip.gicv3_pseudo_nmi=3D1" kernel
> > parameter, etc) we fall back to a normal IPI.
> >
> > NOTE: hooking this up for CPU backtrace / kgdb will happen in a future
> > patch, this just adds the framework.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I think that we shouldn't add a framework in a separate file for this:
>
> * This is very similar to our existing IPI management in smp.c, so it fee=
ls
>   like duplication, or at least another thing we'd like to keep in-sync.
>
> * We're going to want an NMI backtrace regardless of KGDB
>
> * We're going to want the IPI_CPU_STOP and IPI_CRASH_CPU_STOP IPIs to be =
NMIs
>   too.
>
> I reckon it'd be better to extend the existing IPI logic in smp.c to allo=
w IPIs
> to be requested as NMIs, e.g.
>
> ----
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index edd63894d61e8..48e6aa62c473e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -33,6 +33,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/kexec.h>
>  #include <linux/kvm_host.h>
> +#include <linux/nmi.h>
>
>  #include <asm/alternative.h>
>  #include <asm/atomic.h>
> @@ -926,6 +927,21 @@ static void smp_cross_call(const struct cpumask *tar=
get, unsigned int ipinr)
>         __ipi_send_mask(ipi_desc[ipinr], target);
>  }
>
> +static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
> +{
> +       if (!system_uses_irq_prio_masking())
> +               return false;
> +
> +       switch (ipi) {
> +       /*
> +        * TODO: select NMI IPIs here
> +        */
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static void ipi_setup(int cpu)
>  {
>         int i;
> @@ -933,8 +949,14 @@ static void ipi_setup(int cpu)
>         if (WARN_ON_ONCE(!ipi_irq_base))
>                 return;
>
> -       for (i =3D 0; i < nr_ipi; i++)
> -               enable_percpu_irq(ipi_irq_base + i, 0);
> +       for (i =3D 0; i < nr_ipi; i++) {
> +               if (ipi_should_be_nmi(i)) {
> +                       prepare_percpu_nmi(ipi_irq_base + i);
> +                       enable_percpu_nmi(ipi_irq_base + i, 0);
> +               } else {
> +                       enable_percpu_irq(ipi_irq_base + i, 0);
> +               }
> +       }
>  }
>
>  #ifdef CONFIG_HOTPLUG_CPU
> @@ -945,8 +967,14 @@ static void ipi_teardown(int cpu)
>         if (WARN_ON_ONCE(!ipi_irq_base))
>                 return;
>
> -       for (i =3D 0; i < nr_ipi; i++)
> -               disable_percpu_irq(ipi_irq_base + i);
> +       for (i =3D 0; i < nr_ipi; i++) {
> +               if (ipi_should_be_nmi(i)) {
> +                       disable_percpu_nmi(ipi_irq_base + i);
> +                       teardown_percpu_nmi(ipi_irq_base + i);
> +               } else {
> +                       disable_percpu_irq(ipi_irq_base + i);
> +               }
> +       }
>  }
>  #endif
>
> @@ -958,11 +986,19 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>         nr_ipi =3D min(n, NR_IPI);
>
>         for (i =3D 0; i < nr_ipi; i++) {
> -               int err;
> -
> -               err =3D request_percpu_irq(ipi_base + i, ipi_handler,
> -                                        "IPI", &cpu_number);
> -               WARN_ON(err);
> +               int err =3D -EINVAL;
> +
> +               if (ipi_should_be_nmi(i)) {
> +                       err =3D request_percpu_nmi(ipi_base + i, ipi_hand=
ler,
> +                                                "IPI", &cpu_number);
> +                       WARN(err, "Could not request IPI %d as NMI, err=
=3D%d\n",
> +                            i, err);
> +               } else {
> +                       err =3D request_percpu_irq(ipi_base + i, ipi_hand=
ler,
> +                                                "IPI", &cpu_number);
> +                       WARN(err, "Could not request IPI %d as IRQ, err=
=3D%d\n",
> +                            i, err);
> +               }
>
>                 ipi_desc[i] =3D irq_to_desc(ipi_base + i);
>                 irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
> ----
>
> ... and then if we need an IPI for KGDB, we can add that to the existing =
list
> of IPIs, and have it requested/enabled/disabled as usual.

Sounds good. I'm starting to work on v10 incorporating your feedback.
A few quick questions:

1. If I mostly take your patch above verbatim, do you have any
suggested tags for Author/Signed-off-by? I'd tend to set you as the
author but I can't do that because you didn't provide a
Signed-off-by...

2. Would you prefer this patch on its own, or would you rather it be
squashed with the first user ("backtrace")? On its own, I think I have
to get rid of the "switch" statement in ipi_should_be_nmi() and just
return false;

Thanks!

-Doug
