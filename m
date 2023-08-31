Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DF378F05F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbjHaPcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjHaPcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:32:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD9E4C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:32:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a21b6d105cso111910166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693495934; x=1694100734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkBoG7R/Bh/kZjYjKo0ralsC3KC777LpPg9zwJWSmVg=;
        b=OblV37Ug+/5YLH9wLAZ8T8mBT5eWp9SHuChWb6hC1+Rx9Ao5DcrBsrpnLVIqAehxRt
         IU1BYn4upQbA+R88AKZm3Djxr4FZGXfO2HP8Vo/7UtBE4euFHE6aX+OfMGpZniMnCnva
         md4x4VBflVQqlnVB9xdRVukW5tnqMplZePspc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495934; x=1694100734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkBoG7R/Bh/kZjYjKo0ralsC3KC777LpPg9zwJWSmVg=;
        b=lKhnZDfQwJg8mvVawDJv6rBgKg6Lc7b3ub0XPY1sqtiDUp3og7s1DGw05vKBuU/yLB
         CeFsR0a8i44/QnSFjkSTNm9Yp78cQNTS29Qfm4Vt2zmFT97PHwtDt7OemsRy+Y6hmWSS
         vNq53dwS+Xy8Rn8FHtAjzHb8lZFf+bsajpSQkJ0UB3uhOrInev544doFyQoNCSAuK4Vp
         oMSG3O3Mt6aqux9YD+tfp5i4XckKYHRJD5dohW6caksb8RBAKFxrkD6q2/PlmVBFBst/
         wcoMjGpommmBB3HYIbZi+vyY3NI4B6jxDczjlrT4iW0gaC1eC834KINEpWGkMl4c3EWg
         +DTA==
X-Gm-Message-State: AOJu0YwvIsfnfBFDnTlOCyKWE6p8W5eKbT5D8vTlRiDvofJ0pja+owTQ
        oBAdFg2I2Qjr5nBtx7MPfcMAMXOHMBYsP7oIIk7Pw4lF
X-Google-Smtp-Source: AGHT+IEwv/YbR43J9oeWuk6ZJ9YNl3XaXfZqtjpttyCCy9MStMqiWldRdKykSn29NFqC3EfSJIbaig==
X-Received: by 2002:a17:906:6a10:b0:9a5:b8c1:916c with SMTP id qw16-20020a1709066a1000b009a5b8c1916cmr5507585ejc.30.1693495934417;
        Thu, 31 Aug 2023 08:32:14 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906349500b0098f33157e7dsm880782ejb.82.2023.08.31.08.32.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 08:32:14 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so16220a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:32:14 -0700 (PDT)
X-Received: by 2002:a05:600c:364f:b0:3fe:f32f:c57f with SMTP id
 y15-20020a05600c364f00b003fef32fc57fmr169559wmq.0.1693495913002; Thu, 31 Aug
 2023 08:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230830191314.1618136-1-dianders@chromium.org>
 <20230830121115.v12.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid> <ZPBVB_z3FTl2nBy0@FVFF77S0Q05N>
In-Reply-To: <ZPBVB_z3FTl2nBy0@FVFF77S0Q05N>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 31 Aug 2023 08:31:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V3-XaT_KsJXwUXVuaXfx-RfbW3ehW4JJcvWLsty_9fcA@mail.gmail.com>
Message-ID: <CAD=FV=V3-XaT_KsJXwUXVuaXfx-RfbW3ehW4JJcvWLsty_9fcA@mail.gmail.com>
Subject: Re: [PATCH v12 1/7] irqchip/gic-v3: Enable support for SGIs to act as NMIs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 31, 2023 at 1:53=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Wed, Aug 30, 2023 at 12:11:22PM -0700, Douglas Anderson wrote:
> > As of commit 6abbd6988971 ("irqchip/gic, gic-v3: Make SGIs use
> > handle_percpu_devid_irq()") SGIs are treated the same as PPIs/EPPIs
> > and use handle_percpu_devid_irq() by default. Unfortunately,
> > handle_percpu_devid_irq() isn't NMI safe, and so to run in an NMI
> > context those should use handle_percpu_devid_fasteoi_nmi().
> >
> > In order to accomplish this, we just have to make room for SGIs in the
> > array of refcounts that keeps track of which interrupts are set as
> > NMI. We also rename the array and create a new indexing scheme that
> > accounts for SGIs.
> >
> > Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> > as IRQs/NMIs happen as part of this routine.
> >
> > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I'll note that this change is a little more black magic to me than
> > others in this series. I don't have a massive amounts of familiarity
> > with all the moving parts of gic-v3, so I mostly just followed Mark
> > Rutland's advice [1]. Please pay extra attention to make sure I didn't
> > do anything too terrible.
> >
> > Mark's advice wasn't a full patch and I ended up doing a bit of work
> > to translate it to reality, so I did not add him as "Co-developed-by"
> > here. Mark: if you would like this tag then please provide it and your
> > Signed-off-by. I certainly won't object.
>
> That's all reasonable, and I'm perfectly happy without a tag.
>
> I have one trivial nit below, but with or without that fixed up:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> >
> > [1] https://lore.kernel.org/r/ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.a=
rm.com
> >
> > Changes in v12:
> > - Added a comment about why we account for 16 SGIs when Linux uses 8.
> >
> > Changes in v10:
> > - Rewrite as needed for 5.11+ as per Mark Rutland and Sumit.
> >
> >  drivers/irqchip/irq-gic-v3.c | 59 +++++++++++++++++++++++++-----------
> >  1 file changed, 41 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.=
c
> > index eedfa8e9f077..8d20122ba0a8 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -78,6 +78,13 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_ke=
y);
> >  #define GIC_LINE_NR  min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), =
1020U)
> >  #define GIC_ESPI_NR  GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
> >
> > +/*
> > + * There are 16 SGIs, though we only actually use 8 in Linux. The othe=
r 8 SGIs
> > + * are potentially stolen by the secure side. Some code, especially co=
de dealing
> > + * with hwirq IDs, is simplified by accounting for all 16.
> > + */
> > +#define SGI_NR               16
> > +
> >  /*
> >   * The behaviours of RPR and PMR registers differ depending on the val=
ue of
> >   * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of =
the
> > @@ -125,8 +132,8 @@ EXPORT_SYMBOL(gic_nonsecure_priorities);
> >               __priority;                                             \
> >       })
> >
> > -/* ppi_nmi_refs[n] =3D=3D number of cpus having ppi[n + 16] set as NMI=
 */
> > -static refcount_t *ppi_nmi_refs;
> > +/* rdist_nmi_refs[n] =3D=3D number of cpus having the rdist interrupt =
n set as NMI */
> > +static refcount_t *rdist_nmi_refs;
> >
> >  static struct gic_kvm_info gic_v3_kvm_info __initdata;
> >  static DEFINE_PER_CPU(bool, has_rss);
> > @@ -519,9 +526,22 @@ static u32 __gic_get_ppi_index(irq_hw_number_t hwi=
rq)
> >       }
> >  }
> >
> > -static u32 gic_get_ppi_index(struct irq_data *d)
> > +static u32 __gic_get_rdist_idx(irq_hw_number_t hwirq)
> > +{
> > +     switch (__get_intid_range(hwirq)) {
> > +     case SGI_RANGE:
> > +     case PPI_RANGE:
> > +             return hwirq;
> > +     case EPPI_RANGE:
> > +             return hwirq - EPPI_BASE_INTID + 32;
> > +     default:
> > +             unreachable();
> > +     }
> > +}
> > +
> > +static u32 gic_get_rdist_idx(struct irq_data *d)
> >  {
> > -     return __gic_get_ppi_index(d->hwirq);
> > +     return __gic_get_rdist_idx(d->hwirq);
> >  }
>
> Nit: It would be nicer to call this gic_get_rdist_index() to match
> gic_get_ppi_index(); likewise with __gic_get_rdist_index().
>
> That's my fault given I suggested the gic_get_rdist_idx() name in:
>
>   https://lore.kernel.org/linux-arm-kernel/ZNC-YRQopO0PaIIo@FVFF77S0Q05N.=
cambridge.arm.com/
>
> ... so sorry about that!

Yeah, I kept the name you suggested even though it seemed a little
inconsistent. I'll happily send a v13 with that fixed up, though I'll
probably wait a little bit just to avoid spamming new versions too
quickly. It's not like the patches can land in the middle of the merge
window anyway.

Unless someone says otherwise, I guess this series is in good shape to
land then. Does anyone have any plans for the details of how to land
it? I guess this would be something that Marc, Catalin and Will would
need to hash out since the first patch would ideally go through a
different tree than the others.

-Doug
