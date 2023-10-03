Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551637B6AE2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbjJCNtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbjJCNtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:49:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1EFB8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:49:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso11357731fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696340952; x=1696945752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG4ICWklRZwoArVXezRhmmjJnqUaJNzH01DKBMch9JA=;
        b=eb60Fh3SAcf0V6GwrzI/MY9qG0sPgiWEKldUF5CcW7byO8LjyXKg29TFnzeGQ554tf
         uwjKn+U0/rLnKbf29PwTI498Z4YgH473GLmLAa8C72BOnhUFMGY5kFC/zArsswgU59jk
         dxy9W4EzPkzArUfwVaMbxejtqTq6pFNbKMo9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696340952; x=1696945752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG4ICWklRZwoArVXezRhmmjJnqUaJNzH01DKBMch9JA=;
        b=hTwcEvJEw8wtuNz9bV7tpHbjkPkykf3S9XTieCFaNxz4aGUCF1E/GTpEI5ZogQQroN
         PFntvBRBWqWwtyLEjdjvBCU9iqXpCGQOCkLMaU+8nToV8g4HK4FjFXsn284v6DKlg1S7
         ld0f8NwdbAa7l2d0yULn5LtDQQxfOYE4sKHPjYBJiGNa8K3Kt1X93AChm4C2wvjxUCn4
         k6Grfpc6qg+dqvJa47GaPsKmZgv2FvA7BMIOVxLNj0rXQAFVwKHGU/JcnRkIEmpPpjRb
         h2fOa4/LwAoTiyNPyDPVvxKK4bU33ncFNEv3If/OxmIjJ3zyyoksqUZTc9U8g0COt9Gt
         9CvQ==
X-Gm-Message-State: AOJu0YwNl8l5z7r2s/9mF0N0kScR+jCh537P0hfEaXfvi5fcp3xB02pN
        dPlDRLj0audOH+m4rZQsiFcQgD6qXruHB7DPRFo5RdPL
X-Google-Smtp-Source: AGHT+IERKqyRAPiZwUVLSvgU0xsnKN8QJ0R2ZCFbFbOMpsrN5r5rn/ogfp+w2nK1Z+JbIRMg8st/VQ==
X-Received: by 2002:a05:6512:1153:b0:500:ac10:1641 with SMTP id m19-20020a056512115300b00500ac101641mr16208837lfg.46.1696340952631;
        Tue, 03 Oct 2023 06:49:12 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id p21-20020ac246d5000000b004fe333128c0sm197475lfo.242.2023.10.03.06.49.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 06:49:12 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-502f29ed596so5706e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 06:49:12 -0700 (PDT)
X-Received: by 2002:a05:600c:1c82:b0:3fe:e9ea:9653 with SMTP id
 k2-20020a05600c1c8200b003fee9ea9653mr115672wms.4.1696340604360; Tue, 03 Oct
 2023 06:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
 <ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com> <CAD=FV=UeeL9uycVeKpOm+eDm3xHrOnKi2frt6a1qFG1HX9yEUg@mail.gmail.com>
 <ZRwJKBZaYwF1rrur@FVFF77S0Q05N>
In-Reply-To: <ZRwJKBZaYwF1rrur@FVFF77S0Q05N>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 3 Oct 2023 06:43:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WASz1uvTgwsu3H3cTr3smHk+E_XNUVnjoPpttwv095rQ@mail.gmail.com>
Message-ID: <CAD=FV=WASz1uvTgwsu3H3cTr3smHk+E_XNUVnjoPpttwv095rQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: smp: Fix pseudo NMI issues w/ broken Mediatek FW
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 3, 2023 at 5:29=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Mon, Oct 02, 2023 at 12:16:17PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Oct 2, 2023 at 10:24=E2=80=AFAM Mark Rutland <mark.rutland@arm.=
com> wrote:
> > >
> > > On Mon, Oct 02, 2023 at 09:45:29AM -0700, Douglas Anderson wrote:
> > > > Some mediatek devices have the property
> > > > "mediatek,broken-save-restore-fw" in their GIC. This means that,
> > > > although the hardware supports pseudo-NMI, the firmware has a bug
> > > > that blocks enabling it. When we're in this state,
> > > > system_uses_irq_prio_masking() will return true but we'll fail to
> > > > actually enable the IRQ in the GIC.
> > > >
> > > > Let's make the code handle this. We'll detect that we failed to
> > > > request an IPI as NMI and fallback to requesting it normally. Thoug=
h
> > > > we expect that either all of our requests will fail or all will
> > > > succeed, it's just as cheap to keep a per-IPI bitmap and that keeps=
 us
> > > > robust.
> > > >
> > > > Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace us=
ing pseudo-NMI")
> > > > Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > Closes: https://issuetracker.google.com/issues/197061987#comment68
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > >  arch/arm64/kernel/smp.c | 19 ++++++++++++-------
> > > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > >
> > > I'm not too keen on falling back here when we have no idea why the re=
quest failed.
> > >
> > > I'd prefer if we could check the `supports_pseudo_nmis` static key di=
rectly to
> > > account for the case of broken FW, e.g. as below.
> > >
> > > Mark.
> > >
> > > ---->8----
> > > From 72fdec05c64a74f21871b44c7c760bbe07cac044 Mon Sep 17 00:00:00 200=
1
> > > From: Mark Rutland <mark.rutland@arm.com>
> > > Date: Mon, 2 Oct 2023 18:00:36 +0100
> > > Subject: [PATCH] arm64: smp: avoid NMI IPIs with broken MediaTek FW
> > >
> > > Some MediaTek devices have broken firmware which corrupts some GICR
> > > registers behind the back of the OS, and pseudo-NMIs cannot be used o=
n
> > > these devices. For more details see commit:
> > >
> > >   44bd78dd2b8897f5 ("irqchip/gic-v3: Disable pseudo NMIs on Mediatek =
devices w/ firmware issues")
> > >
> > > We did not take this problem into account in commit:
> > >
> > >   331a1b3a836c0f38 ("arm64: smp: Add arch support for backtrace using=
 pseudo-NMI")
> > >
> > > Since that commit arm64's SMP code will try to setup some IPIs as
> > > pseudo-NMIs, even on systems with broken FW. The GICv3 code will
> > > (rightly) reject attempts to request interrupts as pseudo-NMIs,
> > > resulting in boot-time failures.
> > >
> > > Avoid the problem by taking the broken FW into account when deciding =
to
> > > request IPIs as pseudo-NMIs. The GICv3 driver maintains a static_key
> > > named "supports_pseudo_nmis" which is false on systems with broken FW=
,
> > > and we can consult this within ipi_should_be_nmi().
> > >
> > > Fixes: 331a1b3a836c0f38 ("arm64: smp: Add arch support for backtrace =
using pseudo-NMI")
> > > Reported-by: Chen-Yu Tsai <wenst@chromium.org>
> > > Closes: https://issuetracker.google.com/issues/197061987#comment68
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Douglas Anderson <dianders@chromium.org>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  arch/arm64/kernel/smp.c      | 5 ++++-
> > >  drivers/irqchip/irq-gic-v3.c | 2 +-
> > >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > Sure, this is OK w/ me as long as folks don't mind accessing the
> > global here, it's OK w/ me:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > It seems to work for me, thus:
> >
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> >
> >
> > > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > > index 814d9aa93b21b..061c69160f90f 100644
> > > --- a/arch/arm64/kernel/smp.c
> > > +++ b/arch/arm64/kernel/smp.c
> > > @@ -964,7 +964,10 @@ static void smp_cross_call(const struct cpumask =
*target, unsigned int ipinr)
> > >
> > >  static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
> > >  {
> > > -       if (!system_uses_irq_prio_masking())
> > > +       DECLARE_STATIC_KEY_FALSE(supports_pseudo_nmis);
> > > +
> > > +       if (!system_uses_irq_prio_masking() ||
> > > +           !static_branch_likely(&supports_pseudo_nmis))
> >
> > One thought, actually, is whether we should actually change
> > system_uses_irq_prio_masking() to return the correct value. What do
> > you think?
>
> I don't think we should add this to system_uses_irq_prio_masking(); that'=
s used
> by the low-level flags manipulation code that gets inlined all over the p=
lace,
> and that code will work regarldess of whether we actually use NMI priorit=
ies.
>
> If we want to avoid using PMR masking *at all* on these platforms, we'd n=
eed to
> detect that within can_use_gic_priorities() or early_enable_pseudo_nmi().

I suspect that anyone trying to use PMR masking on these systems for
any purpose will be unhappy. The issue is talked about in:

https://issuetracker.google.com/281831288

...where you can see that the firmware on these systems isn't properly
saving/restoring some registers, including GICR_IPRIORITYR.

-Doug
