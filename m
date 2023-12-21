Return-Path: <linux-kernel+bounces-9071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D677281BFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F53E288925
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A4876DAD;
	Thu, 21 Dec 2023 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eh2YgSCb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2347690B;
	Thu, 21 Dec 2023 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b9f8c9307dso1006523b6e.0;
        Thu, 21 Dec 2023 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703192692; x=1703797492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3iK+XCFKHi89cS9qJf066rKv09q1lojAXsmMshz01Y=;
        b=Eh2YgSCbF9rWIrYAmUeVg1hMg7FRx7oW5XWCD0ynvWxsy7INwMHK6w2fwxmJGXjImA
         849zrLUY3Tit8+sV714A6aVZPyehOvRLUu+tvlUik0aUkQWUb54SD4/auYdwIASJM9gM
         ikwjAYNsN1+HiMB/wIcm0QM9z363h6avn/P/pfN9jzWkCuMRIn5MviC1rF+L2TheDTkG
         TdLSou6CqJ+nAO5hUwn+O2yxbS6sC1CMaenO928c3340ilDUSv/INRoCZqgSISfIlFDi
         5EJ7gjb3hqnCGSsNaHBOxo1shEfp4bnXKTdvTBZqtqUpmWQUPYY8KMr7RFbPe/dWlIAv
         Jbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703192692; x=1703797492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3iK+XCFKHi89cS9qJf066rKv09q1lojAXsmMshz01Y=;
        b=KsSbpvPjDknVL58zlK+XFHZL88Tlu4zLjIIt/iiRz46v9n/R1948bGvws3FtCh3scJ
         mkz+/stt535GRm1L5E4xZ00kjRR5MfYGNXoboRp9itLSPBh1UoeLlZ7OKuU/RB7hQsrO
         R+NMfM8YFPBFhpWzcOpVchlVX5Qsls9loYSTTiuRgYQqkhrRg5x1FsRfabmbJOJegvy8
         cslvgxCcePpzJQ5lbIEhH062dqKlNbMSDdoCEGogT/7zrJq+/b4DLxFS/WBZFhbHft1x
         95+izei1yyFBQFhN+npnhb8gS5RDutvDcbHpohz8vXjAV1ZAul+Trmnwce7hLU3CFuSc
         t48g==
X-Gm-Message-State: AOJu0YzPHFahowdLNgaCscn2byWfRtNaHG7IU5hGNSQccoDKoWIZNS2C
	xfn5ZRE1Cb7UktuvFoo27ymKcMyRoWQlCpPIhsg=
X-Google-Smtp-Source: AGHT+IEUZcUgQO01TA3QnTE4wGBRJXR3a8c0TbyeunrTHBygIVKvTGF9lNP5Ysmbw0AZg+9ePrkWX8aaxUxn15ecHP0=
X-Received: by 2002:a05:6870:b150:b0:203:a833:237e with SMTP id
 a16-20020a056870b15000b00203a833237emr553136oal.9.1703192692341; Thu, 21 Dec
 2023 13:04:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201131551.201503-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231201131551.201503-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUiaL__+CDaFxRbUFgrz69SYBNfZm4JvY_qQRKLMTCY0w@mail.gmail.com>
In-Reply-To: <CAMuHMdUiaL__+CDaFxRbUFgrz69SYBNfZm4JvY_qQRKLMTCY0w@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 21 Dec 2023 21:04:12 +0000
Message-ID: <CA+V-a8tTWf8Kx-Ex=DPsSR2ZWHC29N_pAoEZN1sR5Nqobf139A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
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

On Wed, Dec 6, 2023 at 1:13=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Dec 1, 2023 at 2:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Currently we assume all the port pins are sequential ie always PX_0 to
> > PX_n (n=3D1..7) exist, but on RZ/Five SoC we have additional pins P19_1=
 to
> > P28_5 which have holes in them, for example only one pin on port19 is
> > available and that is P19_1 and not P19_0. So to handle such cases
> > include pinmap for each port which would indicate the pin availability
> > on each port. As the pincount can be calculated based on pinmap drop th=
is
> > from RZG2L_GPIO_PORT_PACK() macro and update RZG2L_GPIO_PORT_GET_PINCNT=
()
> > macro.
> >
> > Previously we had a max of 7 pins on each port but on RZ/Five Port-20
> > has 8 pins, so move the single pin configuration to BIT(63).
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -80,15 +80,17 @@
> >   * n indicates number of pins in the port, a is the register index
> >   * and f is pin configuration capabilities supported.
> >   */
> > -#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) << 28) | ((a) << 20) | (f=
))
> > -#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (((x) & GENMASK(30, 28)) >> 28)
> > +#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) > 0 ? ((u64)(GENMASK_ULL(=
((n) - 1 + 28), 28))) : 0) | \
>
> The mask creation can be simplified to
>
>     ((1ULL << (n)) - 1) << 28
>
OK.

> but see below...
>
> > +                                        ((a) << 20) | (f))
> > +#define RZG2L_GPIO_PORT_GET_PINMAP(x)  (((x) & GENMASK_ULL(35, 28)) >>=
 28)
> > +#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (hweight8(RZG2L_GPIO_PORT_GET_P=
INMAP((x))))
>
> I think we've reached the point where it would be easier for the
> casual reviewer to #define PIN_CFG_*_MASK for all fields, and use
> FIELD_{PREP,GET}() to pack resp. extract values.  That would also
> make it more obvious which bits are in use, and how many bits are
> still available for future use.
>
If I use the FIELD_PREP() macro like below I get build issues as below:

#define RZG2L_GPIO_PORT_PIN_CNT_MASK    GENMASK(31, 28)
#define RZG2L_GPIO_PORT_PIN_REG_MASK    GENMASK(27, 20)
#define RZG2L_GPIO_PORT_PIN_CFG_MASK    GENMASK(19, 0)
#define RZG2L_GPIO_PORT_PACK(n, a, f)
FIELD_PREP(RZG2L_GPIO_PORT_PIN_CNT_MASK, n) | \
                    FIELD_PREP(RZG2L_GPIO_PORT_PIN_REG_MASK, a) | \
                    FIELD_PREP(RZG2L_GPIO_PORT_PIN_CFG_MASK, f)


drivers/pinctrl/renesas/pinctrl-rzg2l.c:91:41: note: in expansion of
macro 'FIELD_PREP'
   91 |
FIELD_PREP(RZG2L_GPIO_PORT_PIN_CFG_MASK, f)
      |                                         ^~~~~~~~~~
drivers/pinctrl/renesas/pinctrl-rzg2l.c:1486:9: note: in expansion of
macro 'RZG2L_GPIO_PORT_PACK'
 1486 |         RZG2L_GPIO_PORT_PACK(6, 0x2a,
RZG3S_MPXED_PIN_FUNCS(A)),                        /* P18 */
      |         ^~~~~~~~~~~~~~~~~~~~

Do you have any pointers?

Cheers,
Prabhakar

> >
> >  /*
> > - * BIT(31) indicates dedicated pin, p is the register index while
> > + * BIT(63) indicates dedicated pin, p is the register index while
> >   * referencing to SR/IEN/IOLH/FILxx registers, b is the register bits
> >   * (b * 8) and f is the pin configuration capabilities supported.
> >   */
> > -#define RZG2L_SINGLE_PIN               BIT(31)
> > +#define RZG2L_SINGLE_PIN               BIT_ULL(63)
> >  #define RZG2L_SINGLE_PIN_PACK(p, b, f) (RZG2L_SINGLE_PIN | \
> >                                          ((p) << 24) | ((b) << 20) | (f=
))
> >  #define RZG2L_SINGLE_PIN_GET_BIT(x)    (((x) & GENMASK(22, 20)) >> 20)
>
> Likewise.
>
> > @@ -180,12 +182,12 @@ struct rzg2l_hwcfg {
> >
> >  struct rzg2l_dedicated_configs {
> >         const char *name;
> > -       u32 config;
> > +       u64 config;
> >  };
>
> The rest LGTM.  It's a pity we have to switch to 64 bits, but I'm
> afraid there is not much we can do about that...
>
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

