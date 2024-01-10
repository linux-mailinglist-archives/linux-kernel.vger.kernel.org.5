Return-Path: <linux-kernel+bounces-22601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC5182A045
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEE72886A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C084D588;
	Wed, 10 Jan 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUwDJxpt"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96381E;
	Wed, 10 Jan 2024 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4b77c843fbeso1274321e0c.2;
        Wed, 10 Jan 2024 10:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704911448; x=1705516248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBETlCWQwFQvkLiFXieK/qRDXJn1CWgaXPX/9RU3+R8=;
        b=SUwDJxptoO47dwikMWYDyzGojao93RipQ1tWp4J49FYmass1u5YQVjXPQUCeKMy+jJ
         GBwLI/Gc75aXK4CI8BpNqxSCiv/so3UyMYuc+RqLmZBJ89cVK7uTLkyr5PwUVUnu3UKX
         V146IueIDrbMCSE6Gpv+4qZ126RBbWeSQ3qiDsK2LjVEKmBLRX8KFavdl1KCmP3E3mRE
         XXyKcaBSW5RiD0C2zvEpgyKopIYgWznQ8mNzDtvlu0xBAvtwNirjV4cyQHxyiAuwp36s
         0mJRtKaRLVdLL+WYe8mdRJbRq40aWfGxtcmgBjO33LpgEBULsut0EPQ5ujZhAlLbKf9v
         Ts2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911448; x=1705516248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBETlCWQwFQvkLiFXieK/qRDXJn1CWgaXPX/9RU3+R8=;
        b=TfqXRyUKfsaq9RtyCxmAuJE5pV2Xu2bR+By1U6ytnj/IXO6V37T7uEGL+5LXAOKyMH
         oZGW2FDDO4Y1wA17ZQRIO8X13Eg08ffmuOgkQrMGbApV5iQugul3vXcMMVSCJ6FkX4AE
         cm6yvQOAzA/AKNOdUqUhPBJW3RaKsK5LryhdFdlCGKCKDQdP0KhuqSIhnUwHSZMI0mZ/
         xaWb0/CjOUWK12uVGlzvlCORbY3M3lzTw2RPlD1ZHUH+kHM0SPIDBiU0F4RRboTzVlh0
         Ki6HMP/F+mPyNV1Z21+uLm5ZFSr2MSOGcV18/TssdjB5h/WsSXOc76ffNy3O0mRXn88L
         imbA==
X-Gm-Message-State: AOJu0YwoY7xCY8Azau+UTylGfSLoA9RiQTaIzKJG0ZD9eANNXp2DHv4W
	O/k/vR/L2n14iP6P3+kfR0gS+yROvpK29ia0Qrg=
X-Google-Smtp-Source: AGHT+IHqsC+ZSZhyvxqU45VHd/gkRTSqUb/5fX1ODxM8KXqIlJToe2DMl/goQ+CJ2ZDKEdg7utAIiLnKgBYLFH5aREQ=
X-Received: by 2002:ac5:c382:0:b0:4b6:b9ea:ef33 with SMTP id
 s2-20020ac5c382000000b004b6b9eaef33mr736720vkk.7.1704911447722; Wed, 10 Jan
 2024 10:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201131551.201503-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231201131551.201503-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdW+Ky7Z2LPT6qFH-fodQzXuHXf00hc8NSgnkMFOUMNT=w@mail.gmail.com>
In-Reply-To: <CAMuHMdW+Ky7Z2LPT6qFH-fodQzXuHXf00hc8NSgnkMFOUMNT=w@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 10 Jan 2024 18:30:21 +0000
Message-ID: <CA+V-a8u+mLev7TVy1byFPar3x22qNfjOSTYeH2uy7SvnHrF9Sg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

Thank you for the review.

On Wed, Dec 6, 2023 at 2:25=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Fri, Dec 1, 2023 at 2:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add the missing port pins P19 to P28 for RZ/Five SoC. These additional
> > pins provide expanded capabilities and are exclusive to the RZ/Five SoC=
.
> >
> > Couple of port pins have different configuration and is not identical f=
or
>
> s/is/are/
>
OK.

> > the complete port so introduced struct rzg2l_variable_pin_cfg to handle
>
> introduce
>
OK.

> > such cases and introduced PIN_CFG_VARIABLE macro. The actual pin config=
 is
>
> introduce the
>
OK.

> > then assigned rzg2l_pinctrl_get_variable_pin_cfg().
>
> assigned in
>
OK.

> >
> > Add an additional check in rzg2l_gpio_get_gpioint() to only allow GPIO =
pins
> > which support interrupt facility.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 215 +++++++++++++++++++++++-
> >  1 file changed, 213 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/=
renesas/pinctrl-rzg2l.c
> > index 94d072c8a743..083cc63c2c82 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -57,6 +57,8 @@
> >  #define PIN_CFG_FILCLKSEL              BIT(12)
> >  #define PIN_CFG_IOLH_C                 BIT(13)
> >  #define PIN_CFG_SOFT_PS                        BIT(14)
> > +#define PIN_CFG_VARIABLE               BIT(15)
> > +#define PIN_CFG_NOGPIO_INT             BIT(16)
>
> Note to self: this conflicts with "[PATCH 08/14] pinctrl: renesas:
> rzg2l: Add output enable support", so the numbers need to be adapted.
>
> https://lore.kernel.org/all/20231120070024.4079344-9-claudiu.beznea.uj@bp=
renesas.com
>
I'll rebase the changes, as the patches have now merged.

> >
> >  #define RZG2L_MPXED_COMMON_PIN_FUNCS(group) \
> >                                         (PIN_CFG_IOLH_##group | \
> > @@ -82,6 +84,11 @@
> >   */
> >  #define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) > 0 ? ((u64)(GENMASK_ULL(=
((n) - 1 + 28), 28))) : 0) | \
> >                                          ((a) << 20) | (f))
>
> I'd rather define RZG2L_GPIO_PORT_PACK() using RZG2L_GPIO_PORT_SPARSE_PAC=
K():
>
>  #define RZG2L_GPIO_PORT_PACK(n, a, f) \
>         RZG2L_GPIO_PORT_SPARSE_PACK((1U << (n)) -1, (a), (f))
>
OK, i'll update it.

>
> > +/*
> > + * m indicates the bitmap of supported pins, a is the register index
> > + * and f is pin configuration capabilities supported.
> > + */
> > +#define RZG2L_GPIO_PORT_SPARSE_PACK(m, a, f)   (((u64)(m) << 28) | ((a=
) << 20) | (f))
> >  #define RZG2L_GPIO_PORT_GET_PINMAP(x)  (((x) & GENMASK_ULL(35, 28)) >>=
 28)
> >  #define RZG2L_GPIO_PORT_GET_PINCNT(x)  (hweight8(RZG2L_GPIO_PORT_GET_P=
INMAP((x))))
> >
> > @@ -185,6 +192,18 @@ struct rzg2l_dedicated_configs {
> >         u64 config;
> >  };
> >
> > +/**
> > + * struct rzg2l_variable_pin_cfg - pin data cfg
> > + * @cfg: port pin configuration
> > + * @port: port number
> > + * @pin: port pin
> > + */
> > +struct rzg2l_variable_pin_cfg {
> > +       u32 cfg;
> > +       u8 port;
> > +       u8 pin;
>
> As cfg only contains the lower bits (PIN_CFG_*), I think you can fit
> everything in a u32:
>
>     u32 cfg: 20;
>     u32 port: 5;
>     u32 pin: 3;
>
Agreed.

> > +};
> > +
> >  struct rzg2l_pinctrl_data {
> >         const char * const *port_pins;
> >         const u64 *port_pin_configs;
> > @@ -193,6 +212,8 @@ struct rzg2l_pinctrl_data {
> >         unsigned int n_port_pins;
> >         unsigned int n_dedicated_pins;
> >         const struct rzg2l_hwcfg *hwcfg;
> > +       const struct rzg2l_variable_pin_cfg *variable_pin_cfg;
> > +       unsigned int n_variable_pin_cfg;
> >  };
> >
> >  /**
> > @@ -228,6 +249,158 @@ struct rzg2l_pinctrl {
> >
> >  static const u16 available_ps[] =3D { 1800, 2500, 3300 };
> >
> > +#ifdef CONFIG_RISCV
> > +static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct rzg2l_pinctrl *pc=
trl,
> > +                                             u64 pincfg,
> > +                                             unsigned int port,
> > +                                             u8 pin)
> > +{
> > +       unsigned int i;
> > +       u8 pincount;
> > +       u8 pinmap;
> > +       u32 off;
> > +
> > +       if (!pctrl->data->n_variable_pin_cfg)
> > +               return pincfg;
>
> This cannot happen (but implies a driver table bug).
>
agreed, I will drop it.

> > +
> > +       for (i =3D 0; i < pctrl->data->n_variable_pin_cfg; i++) {
> > +               if (pctrl->data->variable_pin_cfg[i].port =3D=3D port &=
&
> > +                   pctrl->data->variable_pin_cfg[i].pin =3D=3D pin)
> > +                       break;
> > +       }
> > +       if (i =3D=3D pctrl->data->n_variable_pin_cfg)
> > +               return pincfg;
>
> My first thought was that this cannot happen either, but this function
> is called for non-existent pins on sparse ports?
>
I will drop that.

> > +
> > +       pinmap =3D RZG2L_GPIO_PORT_GET_PINMAP(pincfg);
> > +       pincount =3D RZG2L_GPIO_PORT_GET_PINCNT(pincfg);
> > +       off =3D RZG2L_PIN_CFG_TO_PORT_OFFSET(pincfg);
> > +
> > +       if (pinmap =3D=3D pincount)
>
> Huh?
>
Oops.

> > +               return RZG2L_GPIO_PORT_PACK(pincount, off, pctrl->data-=
>variable_pin_cfg[i].cfg);
> > +
> > +       return RZG2L_GPIO_PORT_SPARSE_PACK(pinmap, off, pctrl->data->va=
riable_pin_cfg[i].cfg);
>
> Can't you just replace the lower bits of pincfg by
> pctrl->data->variable_pin_cfg[i].cfg?
>
>     return (pincfg & ~PIN_CFG_...) | pctrl->data->variable_pin_cfg[i].cfg=
;
>
> And just move this single statement into if-condition in the for-loop
> above?
>
Agreed.

> > +}
> > +
> > +static const struct rzg2l_variable_pin_cfg r9a07g043f_variable_pin_cfg=
[] =3D {
> > +       {
> > +               .port =3D 20,
> > +               .pin =3D 0,
> > +               .cfg =3D PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_PUPD |
> > +                      PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILC=
LKSEL |
> > +                      PIN_CFG_IEN | PIN_CFG_NOGPIO_INT,
>
> Why do all new pins have PIN_CFG_NOGPIO_INT set?
> P19_1, P20_0-2, P24_5, P25_1, P28_0-4 do have bits defined in an
> Interrupt Enable Control Register (ISEL)?
>
I have got clarification from the HW team that the ISEL bits will be
dropped for P19-P28 (and also we dont corresponding GPIOINTx for
P19-P28).

> > +       },
>
> > @@ -1320,6 +1493,27 @@ static const u64 r9a07g043_gpio_configs[] =3D {
> >         RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
> >         RZG2L_GPIO_PORT_PACK(4, 0x21, RZG2L_MPXED_PIN_FUNCS),
> >         RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
> > +#ifdef CONFIG_RISCV
> > +       /* Below additional port pins (P19 - P28) are exclusively avail=
able on RZ/Five SoC only */
> > +       RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x06, PIN_CFG_IOLH_B | PIN_CFG=
_SR | PIN_CFG_PUPD |
> > +                                   PIN_CFG_FILONOFF | PIN_CFG_FILNUM |=
 PIN_CFG_FILCLKSEL |
> > +                                   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT), =
 /* P19 */
> > +       RZG2L_GPIO_PORT_PACK(8, 0x07, PIN_CFG_VARIABLE),        /* P20 =
*/
> > +       RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x08, PIN_CFG_IOLH_B | PIN_CFG=
_SR | PIN_CFG_PUPD |
> > +                                   PIN_CFG_IEN | PIN_CFG_NOGPIO_INT), =
 /* P21 */
> > +       RZG2L_GPIO_PORT_PACK(4, 0x09, PIN_CFG_IOLH_B | PIN_CFG_SR | PIN=
_CFG_PUPD |
> > +                            PIN_CFG_IEN | PIN_CFG_NOGPIO_INT), /* P22 =
*/
> > +       RZG2L_GPIO_PORT_SPARSE_PACK(0x3e, 0x0a, PIN_CFG_VARIABLE),     =
 /* P23 */
> > +       RZG2L_GPIO_PORT_PACK(6, 0x0b, PIN_CFG_VARIABLE),        /* P24 =
*/
> > +       RZG2L_GPIO_PORT_SPARSE_PACK(0x2, 0x0c, PIN_CFG_IOLH_B | PIN_CFG=
_SR | PIN_CFG_FILONOFF |
> > +                                   PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL =
|
> > +                                   PIN_CFG_NOGPIO_INT),        /* P25 =
*/
> > +       0x0,    /* Dummy port P26 */
> > +       0x0,    /* Dummy port P27 */
> > +       RZG2L_GPIO_PORT_PACK(6, 0x0f, PIN_CFG_IOLH_A | PIN_CFG_SR | PIN=
_CFG_PUPD |
> > +                            PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CF=
G_FILCLKSEL |
> > +                            PIN_CFG_NOGPIO_INT),       /* P28 */
>
> The P28 config can be simplified to "RZG2L_MPXED_PIN_FUNCS |
> PIN_CFG_NOGPIO_INT".
>
Agreed.

> > +#endif
> >  };
> >
> >  static const u64 r9a08g045_gpio_configs[] =3D {
> > @@ -1478,12 +1672,18 @@ static const struct rzg2l_dedicated_configs rzg=
3s_dedicated_pins[] =3D {
> >                                                        PIN_CFG_IO_VMC_S=
D1)) },
> >  };
> >
> > -static int rzg2l_gpio_get_gpioint(unsigned int virq, const struct rzg2=
l_pinctrl_data *data)
> > +static int rzg2l_gpio_get_gpioint(unsigned int virq, struct rzg2l_pinc=
trl *pctrl)
> >  {
> > +       const struct pinctrl_pin_desc *pin_desc =3D &pctrl->desc.pins[v=
irq];
> > +       const struct rzg2l_pinctrl_data *data =3D pctrl->data;
> > +       u64 *pin_data =3D pin_desc->drv_data;
> >         unsigned int gpioint;
> >         unsigned int i;
> >         u32 port, bit;
> >
> > +       if (*pin_data & PIN_CFG_NOGPIO_INT)
> > +               return -EINVAL;
> > +
> >         port =3D virq / 8;
> >         bit =3D virq % 8;
>
> Out-of-context, you have:
>
>         gpioint =3D bit;
>         for (i =3D 0; i < port; i++)
>                 gpioint +=3D
> RZG2L_GPIO_PORT_GET_PINCNT(data->port_pin_configs[i]);
>
>         return gpioint;
>
> Shouldn't the for-loop skip pins with PIN_CFG_NOGPIO_INT set?
>
As of now P19-P28 cannot be used as interrupt pins and there is no SoC
where we can test this case (as this has to match GPIOINTx for a given
port pin). So we can ignore it for now.


> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

