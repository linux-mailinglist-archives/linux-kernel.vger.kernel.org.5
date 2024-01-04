Return-Path: <linux-kernel+bounces-16915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FE2824612
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15F51F22DC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64D924B21;
	Thu,  4 Jan 2024 16:25:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3815924B20;
	Thu,  4 Jan 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e6c8b70766so6628997b3.3;
        Thu, 04 Jan 2024 08:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704385510; x=1704990310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBdLCUmjrZ1+GTPDcEU99j/uV9mS9a4gKvyVmqcT1n4=;
        b=pNfYDDKJzt4ZXKAjrXnLECwyK4RRPTroDAPplr4Y+Guo7yfJ5lqteX6onvu3kU2xMG
         Hi6GxK1zK3BnIpj0++05vzJvnRs/gDR6MBQRGDUL4eWGOHjxpIlCkX/3RIrZS/f2UTr4
         TmpGQzzxKBqVUdQmBKC3PhJbNuIvoSdwPn3twIjIeK8xApn7KJpFz4WFZMOPj5eLg+t2
         OQYOwUeKfP0mu7j5khK1gR3ExgQrJP4K1Lb6ZhACAgC2R88N7J+XkuvYrUMr4JAIhPjK
         RtygIbdhMsizIMQALIVT2WkqJfPv+8iyhG/L16ML1ZB8EE8VSaI4NNqBW1op05PF+JeU
         x6iw==
X-Gm-Message-State: AOJu0YwOBnWWU6JoPYN0/vTTp3t1ndJH3Jrp/I+cve7kNAfU3dBBd1Dz
	irZfWw8A5yx8AiDtHA7PwRUtwdXrCONYPg==
X-Google-Smtp-Source: AGHT+IGfZ5vrkM5ern0qADyGf4wpdOAwoOkvMI9LP/1RBmU9o9DehYKxf8B4DAnFPkzQkiiJ2V52fg==
X-Received: by 2002:a25:aa30:0:b0:dbc:3009:42dd with SMTP id s45-20020a25aa30000000b00dbc300942ddmr734171ybi.93.1704385509798;
        Thu, 04 Jan 2024 08:25:09 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 185-20020a2518c2000000b00dbccc57e9c8sm1363500yby.56.2024.01.04.08.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 08:25:08 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5f254d1a6daso6652327b3.2;
        Thu, 04 Jan 2024 08:25:08 -0800 (PST)
X-Received: by 2002:a81:5307:0:b0:5e7:7526:62b5 with SMTP id
 h7-20020a815307000000b005e7752662b5mr924671ywb.44.1704385508356; Thu, 04 Jan
 2024 08:25:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201131551.201503-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231201131551.201503-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUiaL__+CDaFxRbUFgrz69SYBNfZm4JvY_qQRKLMTCY0w@mail.gmail.com>
 <CA+V-a8tTWf8Kx-Ex=DPsSR2ZWHC29N_pAoEZN1sR5Nqobf139A@mail.gmail.com>
 <CAMuHMdXosvV=EuRtL69r6=UT0SO8Aq-XjWwJMJQpWAhT2z+ffA@mail.gmail.com> <CA+V-a8tNeiyvK90urPF9s3JZOav77TRO8xdAEiCmYurrf3-4RA@mail.gmail.com>
In-Reply-To: <CA+V-a8tNeiyvK90urPF9s3JZOav77TRO8xdAEiCmYurrf3-4RA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Jan 2024 17:24:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXYEBg7MMJG7tqDib8eaKdvd4Fxo+ZR8K8Vq82DzjSaqg@mail.gmail.com>
Message-ID: <CAMuHMdXYEBg7MMJG7tqDib8eaKdvd4Fxo+ZR8K8Vq82DzjSaqg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Thu, Jan 4, 2024 at 4:55=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Jan 2, 2024 at 10:18=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Thu, Dec 21, 2023 at 10:04=E2=80=AFPM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Wed, Dec 6, 2023 at 1:13=E2=80=AFPM Geert Uytterhoeven <geert@linu=
x-m68k.org> wrote:
> > > > On Fri, Dec 1, 2023 at 2:16=E2=80=AFPM Prabhakar <prabhakar.csengg@=
gmail.com> wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Currently we assume all the port pins are sequential ie always PX=
_0 to
> > > > > PX_n (n=3D1..7) exist, but on RZ/Five SoC we have additional pins=
 P19_1 to
> > > > > P28_5 which have holes in them, for example only one pin on port1=
9 is
> > > > > available and that is P19_1 and not P19_0. So to handle such case=
s
> > > > > include pinmap for each port which would indicate the pin availab=
ility
> > > > > on each port. As the pincount can be calculated based on pinmap d=
rop this
> > > > > from RZG2L_GPIO_PORT_PACK() macro and update RZG2L_GPIO_PORT_GET_=
PINCNT()
> > > > > macro.
> > > > >
> > > > > Previously we had a max of 7 pins on each port but on RZ/Five Por=
t-20
> > > > > has 8 pins, so move the single pin configuration to BIT(63).
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas=
.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > > @@ -80,15 +80,17 @@
> > > > >   * n indicates number of pins in the port, a is the register ind=
ex
> > > > >   * and f is pin configuration capabilities supported.
> > > > >   */
> > > > > -#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) << 28) | ((a) << 20=
) | (f))
> > > > > -#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (((x) & GENMASK(30, 28)) =
>> 28)
> > > > > +#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) > 0 ? ((u64)(GENMAS=
K_ULL(((n) - 1 + 28), 28))) : 0) | \
> > > >
> > > > The mask creation can be simplified to
> > > >
> > > >     ((1ULL << (n)) - 1) << 28
> > > >
> > > OK.
> > >
> > > > but see below...
> > > >
> > > > > +                                        ((a) << 20) | (f))
> > > > > +#define RZG2L_GPIO_PORT_GET_PINMAP(x)  (((x) & GENMASK_ULL(35, 2=
8)) >> 28)
> > > > > +#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (hweight8(RZG2L_GPIO_PORT=
_GET_PINMAP((x))))
> > > >
> > > > I think we've reached the point where it would be easier for the
> > > > casual reviewer to #define PIN_CFG_*_MASK for all fields, and use
> > > > FIELD_{PREP,GET}() to pack resp. extract values.  That would also
> > > > make it more obvious which bits are in use, and how many bits are
> > > > still available for future use.

> To clarify, you mean to define PIN_CFG_*_MASK for all
> PIN_CFG_IOLH_A..PIN_CFG_OEN macros? I ask because we dont extract the
> respective CFG flags in the code.

The PIN_CFG_IOLH_A..PIN_CFG_OEN macros are single-bit definitions.
I mean to #define PIN_CFG_*_MASK macros for all multi-bit fields, currently
accessed using open-coded GENMASK().

You already tried:

    #define RZG2L_GPIO_PORT_PIN_CNT_MASK    GENMASK(31, 28)
    #define RZG2L_GPIO_PORT_PIN_REG_MASK    GENMASK(27, 20)
    #define RZG2L_GPIO_PORT_PIN_CFG_MASK    GENMASK(19, 0)

As they actually share the PIN_CFG_* bit space, I'd call them:

    #define PIN_CFG_PIN_CNT_MASK    GENMASK(31, 28)
    #define PIN_CFG_PIN_REG_MASK    GENMASK(27, 20)
    #define PIN_CFG_MASK    GENMASK(19, 0)

Also, you already have:

    #define MUX_PIN_ID_MASK         GENMASK(15, 0)
    #define MUX_FUNC_MASK           GENMASK(31, 16)
    #define MUX_FUNC_OFFS           16

But all of

    #define MUX_FUNC(pinconf)       (((pinconf) & MUX_FUNC_MASK) >>
MUX_FUNC_OFFS)

    pins[i] =3D value & MUX_PIN_ID_MASK;

can use FIELD_GET(), removing the need for MUX_FUNC_OFFS.

Also:

    u8 pincount =3D RZG2L_GPIO_PORT_GET_PINCNT(cfg);

can become

    u8 pincount =3D FIELD_GET(PIN_CFG_PIN_CNT_MASK, cfg);

Same for all the other macros using GENMASK().

I hope this makes it more clear what I had in mind?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

