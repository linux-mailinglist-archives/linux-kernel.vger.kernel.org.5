Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640387984D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbjIHJbz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 05:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIHJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:31:52 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B0311B;
        Fri,  8 Sep 2023 02:31:48 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-58dce1f42d6so41465407b3.0;
        Fri, 08 Sep 2023 02:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694165508; x=1694770308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7In3jR24QqYcvy6RjXqyS7E+iqbgjrxBTgClw17SH70=;
        b=nq2dorLvSPIABtLMNGQWWjWNl8kZVvFj94DJccgDjfpvtPhuwZjXwCSdoJQoSCemgp
         Su/aZ5rh8ouIuHuLUheWzUmgIIzplbpnl8kQ0SxDiiaa4IjDP8R2gOY2m/kzHo4QHjBL
         5RcKV+TZK5a6/bPesdD36CsXdGZ/3W4R4vjTwVeTTw4fm1ehL5+jV2V46e5ZDSBZwnqJ
         CQHQbsdzNeagz4uGUNxV2GSyfEMo0SVOmjL/zrGXWIq77stZ0eMdSj0B43r2jnS65Twh
         GE6CraDnDOjNey6NCUrU5p9SbIC6xuacpPJonvPM+ksBbViY/OgkIHxnV7i6hxJz80w+
         tFdw==
X-Gm-Message-State: AOJu0YwERo0Z3IpwXJ3yMc+0hqdRPoh92syQrQmk9YfKowxBhMUzBcy/
        WuwD7Kgwjn6oYnJdKamJ0lLXb71KLbFhRric
X-Google-Smtp-Source: AGHT+IEoNrLwZvpSekGIl9JE3t0jLTjGytmc3FyOCEjVNnC+moEkI+hbYGIaZxvpx+LeJL6/FxTXpA==
X-Received: by 2002:a25:ab26:0:b0:d7b:9b3c:7388 with SMTP id u35-20020a25ab26000000b00d7b9b3c7388mr2169078ybi.6.1694165507791;
        Fri, 08 Sep 2023 02:31:47 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id y18-20020a25bb92000000b00d7e08d9972asm281895ybg.11.2023.09.08.02.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 02:31:47 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d7830c5b20aso2538422276.0;
        Fri, 08 Sep 2023 02:31:46 -0700 (PDT)
X-Received: by 2002:a25:ad10:0:b0:d40:3069:b3b1 with SMTP id
 y16-20020a25ad10000000b00d403069b3b1mr5512491ybi.17.1694165506752; Fri, 08
 Sep 2023 02:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220722151155.21100-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220722151155.21100-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8735eqdbav.wl-maz@kernel.org> <CAMuHMdVj7J442iMr0PN5jxMhLv1U22+G9jNXLWFzLYkS0JTf5A@mail.gmail.com>
In-Reply-To: <CAMuHMdVj7J442iMr0PN5jxMhLv1U22+G9jNXLWFzLYkS0JTf5A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Sep 2023 11:31:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_d5isU5Y2p6ne6_9j1-uqWnRY=Qw34SqR5EC0CndG+Q@mail.gmail.com>
Message-ID: <CAMuHMdW_d5isU5Y2p6ne6_9j1-uqWnRY=Qw34SqR5EC0CndG+Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Update description for '#interrupt-cells' property
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Aug 11, 2022 at 4:50 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, Jul 24, 2022 at 1:01 PM Marc Zyngier <maz@kernel.org> wrote:
> > On Fri, 22 Jul 2022 16:11:54 +0100,
> > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > >
> > > Update description for '#interrupt-cells' property to utilize the
> > > RZG2L_{NMI,IRQX} for the first cell defined in the
> > > include/dt-bindings/interrupt-controller/irqc-rzg2l.h file.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > v3:
> > > * New patch
>
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
> > > @@ -31,8 +31,9 @@ properties:
> > >        - const: renesas,rzg2l-irqc
> > >
> > >    '#interrupt-cells':
> > > -    description: The first cell should contain external interrupt number (IRQ0-7) and the
> > > -                 second cell is used to specify the flag.
> > > +    description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the
> > > +                 include/dt-bindings/interrupt-controller/irqc-rzg2l.h and the second
> > > +                 cell is used to specify the flag.
> >
> > I think a binding should be self describing, and not rely on an opaque
> > macro. Mentioning that there is a macro that encodes it is fine, but
> > the values are what matter, specially when considering that other OSs
> > could (and should be able to) write their own DTs from scratch without
> > depending on something that is very much Linux-specific.
>
> The macros are not Linux-specific, and are part of the bindings.
> But the only hard dependency on <dt-bindings/interrupt-controller/irqc-rzg2l.h>
> is the DT source file describing the board.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks like this fell through the cracks?
The two other patches from this series were applied in v6.1.

Note that the current DT bindings are incorrect, as they do not take into
account that the value of zero is used to represent the NMI.

Fixes: 96fed779d3d4cb3c ("dt-bindings: interrupt-controller: Add
Renesas RZ/G2L Interrupt Controller")

Should we resend instead?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
