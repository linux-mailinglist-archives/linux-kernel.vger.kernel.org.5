Return-Path: <linux-kernel+bounces-14232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D215082198B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94341C21BCB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D393DDAD;
	Tue,  2 Jan 2024 10:18:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA548D266;
	Tue,  2 Jan 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5eefd0da5c0so35964757b3.2;
        Tue, 02 Jan 2024 02:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704190682; x=1704795482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5DxLXP6EyqotRgw2MuRFibbW2LOWQylrBdAXWNwj0E=;
        b=kDmWk4+qMWPq3ulZECXV/fAqE+GbkVeQ+8oIByA45X30vt9CZteil2nJnx2kmmRghp
         86oxzkOdzqTaALCAt9HYvQhqxPUf99lFl4s21vRc+6cEnFArwK0wuzzvcf+gsFUDdJbf
         tOr291omrrtq7HgG18g6OH6H/RnJNrMuPoRVpwpw5a4/RP/z2wmc0ekNpRyOQB+KvW+x
         0zkdCEFssFYiCMHjrKkx9zTIXM50hQz7i15To78tz/tC8MG0wkhWj5cOTvtqMweAYzO+
         /+2Wm0ZC4OYrr8khpkXPNEeC2DMLak+g7wmqbrzLwvbTp4lMFkfEzDr6R9I9PCJ9Y+QQ
         NB3A==
X-Gm-Message-State: AOJu0YzdK4/d4mXOQV/xWhpoQjrla7j2ZTRY3jlj1XnsgC77U65q9/as
	s0QY6g3JiBfB36RUADr4Wz0ylUsvQl2xWA==
X-Google-Smtp-Source: AGHT+IFHm7SGgWLdlth02VAk2lQAvQcEQ6zfBgw66YQXK7ZWQsZrYxsxiII4aqrljuaUM64w5A3Uyg==
X-Received: by 2002:a81:73c3:0:b0:5e8:e973:31ad with SMTP id o186-20020a8173c3000000b005e8e97331admr13001380ywc.33.1704190682530;
        Tue, 02 Jan 2024 02:18:02 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id gu6-20020a05690c458600b005f21555182bsm1934161ywb.1.2024.01.02.02.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 02:18:02 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5eefd0da5c0so35964627b3.2;
        Tue, 02 Jan 2024 02:18:01 -0800 (PST)
X-Received: by 2002:a0d:c383:0:b0:5d8:e267:78e5 with SMTP id
 f125-20020a0dc383000000b005d8e26778e5mr12357254ywd.61.1704190681747; Tue, 02
 Jan 2024 02:18:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201131551.201503-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231201131551.201503-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUiaL__+CDaFxRbUFgrz69SYBNfZm4JvY_qQRKLMTCY0w@mail.gmail.com> <CA+V-a8tTWf8Kx-Ex=DPsSR2ZWHC29N_pAoEZN1sR5Nqobf139A@mail.gmail.com>
In-Reply-To: <CA+V-a8tTWf8Kx-Ex=DPsSR2ZWHC29N_pAoEZN1sR5Nqobf139A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 11:17:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXosvV=EuRtL69r6=UT0SO8Aq-XjWwJMJQpWAhT2z+ffA@mail.gmail.com>
Message-ID: <CAMuHMdXosvV=EuRtL69r6=UT0SO8Aq-XjWwJMJQpWAhT2z+ffA@mail.gmail.com>
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

On Thu, Dec 21, 2023 at 10:04=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, Dec 6, 2023 at 1:13=E2=80=AFPM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > On Fri, Dec 1, 2023 at 2:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Currently we assume all the port pins are sequential ie always PX_0 t=
o
> > > PX_n (n=3D1..7) exist, but on RZ/Five SoC we have additional pins P19=
_1 to
> > > P28_5 which have holes in them, for example only one pin on port19 is
> > > available and that is P19_1 and not P19_0. So to handle such cases
> > > include pinmap for each port which would indicate the pin availabilit=
y
> > > on each port. As the pincount can be calculated based on pinmap drop =
this
> > > from RZG2L_GPIO_PORT_PACK() macro and update RZG2L_GPIO_PORT_GET_PINC=
NT()
> > > macro.
> > >
> > > Previously we had a max of 7 pins on each port but on RZ/Five Port-20
> > > has 8 pins, so move the single pin configuration to BIT(63).
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > @@ -80,15 +80,17 @@
> > >   * n indicates number of pins in the port, a is the register index
> > >   * and f is pin configuration capabilities supported.
> > >   */
> > > -#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) << 28) | ((a) << 20) | =
(f))
> > > -#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (((x) & GENMASK(30, 28)) >> 2=
8)
> > > +#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) > 0 ? ((u64)(GENMASK_UL=
L(((n) - 1 + 28), 28))) : 0) | \
> >
> > The mask creation can be simplified to
> >
> >     ((1ULL << (n)) - 1) << 28
> >
> OK.
>
> > but see below...
> >
> > > +                                        ((a) << 20) | (f))
> > > +#define RZG2L_GPIO_PORT_GET_PINMAP(x)  (((x) & GENMASK_ULL(35, 28)) =
>> 28)
> > > +#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (hweight8(RZG2L_GPIO_PORT_GET=
_PINMAP((x))))
> >
> > I think we've reached the point where it would be easier for the
> > casual reviewer to #define PIN_CFG_*_MASK for all fields, and use
> > FIELD_{PREP,GET}() to pack resp. extract values.  That would also
> > make it more obvious which bits are in use, and how many bits are
> > still available for future use.
> >
> If I use the FIELD_PREP() macro like below I get build issues as below:
>
> #define RZG2L_GPIO_PORT_PIN_CNT_MASK    GENMASK(31, 28)
> #define RZG2L_GPIO_PORT_PIN_REG_MASK    GENMASK(27, 20)
> #define RZG2L_GPIO_PORT_PIN_CFG_MASK    GENMASK(19, 0)
> #define RZG2L_GPIO_PORT_PACK(n, a, f)
> FIELD_PREP(RZG2L_GPIO_PORT_PIN_CNT_MASK, n) | \
>                     FIELD_PREP(RZG2L_GPIO_PORT_PIN_REG_MASK, a) | \
>                     FIELD_PREP(RZG2L_GPIO_PORT_PIN_CFG_MASK, f)
>
>
> drivers/pinctrl/renesas/pinctrl-rzg2l.c:91:41: note: in expansion of
> macro 'FIELD_PREP'
>    91 |
> FIELD_PREP(RZG2L_GPIO_PORT_PIN_CFG_MASK, f)
>       |                                         ^~~~~~~~~~
> drivers/pinctrl/renesas/pinctrl-rzg2l.c:1486:9: note: in expansion of
> macro 'RZG2L_GPIO_PORT_PACK'
>  1486 |         RZG2L_GPIO_PORT_PACK(6, 0x2a,
> RZG3S_MPXED_PIN_FUNCS(A)),                        /* P18 */
>       |         ^~~~~~~~~~~~~~~~~~~~
>
> Do you have any pointers?

You left out the actual error :-(

include/linux/bitfield.h:113:9: error: braced-group within expression
allowed only inside a function
  113 |         ({
         \
      |         ^
drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:39: note: in expansion of
macro =E2=80=98FIELD_PREP=E2=80=99
   93 | #define RZG2L_GPIO_PORT_PACK(n, a, f)
FIELD_PREP(RZG2L_GPIO_PORT_PIN_CNT_MASK, n) | \
      |                                       ^~~~~~~~~~
drivers/pinctrl/renesas/pinctrl-rzg2l.c:1555:9: note: in expansion of
macro =E2=80=98RZG2L_GPIO_PORT_PACK=E2=80=99
 1555 |         RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
      |         ^~~~~~~~~~~~~~~~~~~~

Using FIELD_PREP_CONST() instead makes it build.

/**
 * FIELD_PREP_CONST() - prepare a constant bitfield element
 * @_mask: shifted mask defining the field's length and position
 * @_val:  value to put in the field
 *
 * FIELD_PREP_CONST() masks and shifts up the value.  The result should
 * be combined with other fields of the bitfield using logical OR.
 *
 * Unlike FIELD_PREP() this is a constant expression and can therefore
 * be used in initializers. Error checking is less comfortable for this
 * version, and non-constant masks cannot be used.
 */

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

