Return-Path: <linux-kernel+bounces-16890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CE982457D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C60286045
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051924A03;
	Thu,  4 Jan 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvZjdmoW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EF3249EC;
	Thu,  4 Jan 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4b732dfa6e4so187303e0c.1;
        Thu, 04 Jan 2024 07:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704383723; x=1704988523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPeDIiQjNkPvl4Ik1+JkTjR4o2Soc24WzRcdY8DaVYo=;
        b=fvZjdmoWk6wPXVGe4F4nqa57sn02xom6y1xg+NPAKOfxSccOkMRO16bTL4JTuEmvEX
         xr+Gp8vIkZ68Izwg9cLZRFDwof56nQnzGHIFAYPbe7+bZD+2FrV3Eq5EEy2DYTBBv7/n
         +exlCiyRXPfHIX2Qnu4q8cxY1G8zxzZd97aTbwPrVE0qqGrbU5/biAn8xBQnMMQNfo0s
         50rwuEMRZcTCCbwnPHDY692OPm2PBPtSb+nRzYUom9EK4+waflic7yy0DcW6HlhFb4j1
         lqrtcVbGOlbpjTqhJ967GYCoVdYeVeAqZ36M6T19s0AvM9NZHuBG0LlBjAxKse3/zOTQ
         Mhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704383723; x=1704988523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPeDIiQjNkPvl4Ik1+JkTjR4o2Soc24WzRcdY8DaVYo=;
        b=HktXfpQdbaE+58/YoWKl04lYDqYF7lrv7sEzQd0IVGV+OAe1y4qFzgQ9linNmPkzoB
         MECYfACkKk9qpUswnlCJnooHySOcfbAj2d5cOplfijZMEt4k4llIVxvHCtCNCPAmxrpi
         0GD6BKKHW3DCUKHAtPD5eT0mr+pYsReWP9KDqQq+U5XRL9D3G7xLCtX+sOhapkk5dHmw
         fZOG+o0MfwQlf6XRq1/n+O4OmobY1Sbr20TjI2vxRwkRgQw6l1M0bhRkDkc1L8NQP/dk
         N/sF5gXLoy3HWzGyVPzqYfYEhj0mYPS6vNgsY9/vJ7dqSPyD0GxeaZcKX9Zeab2FUZXX
         WTvw==
X-Gm-Message-State: AOJu0YyWNTyrE0DU4l7pTEe6JPs3hvYlU2flCtNFtZLFbkJUkWTN0nEh
	w8jOoJnwgNwPqIIvB9dQfTPsfwM/MP86vlE6MPU=
X-Google-Smtp-Source: AGHT+IFziaDJ3NSo7BkYW/w+OWVaUUgoZfbD/12fbvF28wfa+TcMRxgPb+Fu8jzlDe/pBw9yISY7j4W7adlO3cvMmnA=
X-Received: by 2002:a05:6122:12d3:b0:4b7:3d44:9b05 with SMTP id
 d19-20020a05612212d300b004b73d449b05mr664953vkp.4.1704383723681; Thu, 04 Jan
 2024 07:55:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201131551.201503-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231201131551.201503-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUiaL__+CDaFxRbUFgrz69SYBNfZm4JvY_qQRKLMTCY0w@mail.gmail.com>
 <CA+V-a8tTWf8Kx-Ex=DPsSR2ZWHC29N_pAoEZN1sR5Nqobf139A@mail.gmail.com> <CAMuHMdXosvV=EuRtL69r6=UT0SO8Aq-XjWwJMJQpWAhT2z+ffA@mail.gmail.com>
In-Reply-To: <CAMuHMdXosvV=EuRtL69r6=UT0SO8Aq-XjWwJMJQpWAhT2z+ffA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 4 Jan 2024 15:54:29 +0000
Message-ID: <CA+V-a8tNeiyvK90urPF9s3JZOav77TRO8xdAEiCmYurrf3-4RA@mail.gmail.com>
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

On Tue, Jan 2, 2024 at 10:18=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Dec 21, 2023 at 10:04=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Wed, Dec 6, 2023 at 1:13=E2=80=AFPM Geert Uytterhoeven <geert@linux-=
m68k.org> wrote:
> > > On Fri, Dec 1, 2023 at 2:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gm=
ail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Currently we assume all the port pins are sequential ie always PX_0=
 to
> > > > PX_n (n=3D1..7) exist, but on RZ/Five SoC we have additional pins P=
19_1 to
> > > > P28_5 which have holes in them, for example only one pin on port19 =
is
> > > > available and that is P19_1 and not P19_0. So to handle such cases
> > > > include pinmap for each port which would indicate the pin availabil=
ity
> > > > on each port. As the pincount can be calculated based on pinmap dro=
p this
> > > > from RZG2L_GPIO_PORT_PACK() macro and update RZG2L_GPIO_PORT_GET_PI=
NCNT()
> > > > macro.
> > > >
> > > > Previously we had a max of 7 pins on each port but on RZ/Five Port-=
20
> > > > has 8 pins, so move the single pin configuration to BIT(63).
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > @@ -80,15 +80,17 @@
> > > >   * n indicates number of pins in the port, a is the register index
> > > >   * and f is pin configuration capabilities supported.
> > > >   */
> > > > -#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) << 28) | ((a) << 20) =
| (f))
> > > > -#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (((x) & GENMASK(30, 28)) >>=
 28)
> > > > +#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) > 0 ? ((u64)(GENMASK_=
ULL(((n) - 1 + 28), 28))) : 0) | \
> > >
> > > The mask creation can be simplified to
> > >
> > >     ((1ULL << (n)) - 1) << 28
> > >
> > OK.
> >
> > > but see below...
> > >
> > > > +                                        ((a) << 20) | (f))
> > > > +#define RZG2L_GPIO_PORT_GET_PINMAP(x)  (((x) & GENMASK_ULL(35, 28)=
) >> 28)
> > > > +#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (hweight8(RZG2L_GPIO_PORT_G=
ET_PINMAP((x))))
> > >
> > > I think we've reached the point where it would be easier for the
> > > casual reviewer to #define PIN_CFG_*_MASK for all fields, and use
> > > FIELD_{PREP,GET}() to pack resp. extract values.  That would also
> > > make it more obvious which bits are in use, and how many bits are
> > > still available for future use.
> > >
> > If I use the FIELD_PREP() macro like below I get build issues as below:
> >
> > #define RZG2L_GPIO_PORT_PIN_CNT_MASK    GENMASK(31, 28)
> > #define RZG2L_GPIO_PORT_PIN_REG_MASK    GENMASK(27, 20)
> > #define RZG2L_GPIO_PORT_PIN_CFG_MASK    GENMASK(19, 0)
> > #define RZG2L_GPIO_PORT_PACK(n, a, f)
> > FIELD_PREP(RZG2L_GPIO_PORT_PIN_CNT_MASK, n) | \
> >                     FIELD_PREP(RZG2L_GPIO_PORT_PIN_REG_MASK, a) | \
> >                     FIELD_PREP(RZG2L_GPIO_PORT_PIN_CFG_MASK, f)
> >
> >
> > drivers/pinctrl/renesas/pinctrl-rzg2l.c:91:41: note: in expansion of
> > macro 'FIELD_PREP'
> >    91 |
> > FIELD_PREP(RZG2L_GPIO_PORT_PIN_CFG_MASK, f)
> >       |                                         ^~~~~~~~~~
> > drivers/pinctrl/renesas/pinctrl-rzg2l.c:1486:9: note: in expansion of
> > macro 'RZG2L_GPIO_PORT_PACK'
> >  1486 |         RZG2L_GPIO_PORT_PACK(6, 0x2a,
> > RZG3S_MPXED_PIN_FUNCS(A)),                        /* P18 */
> >       |         ^~~~~~~~~~~~~~~~~~~~
> >
> > Do you have any pointers?
>
> You left out the actual error :-(
>
Oops sorry.

> include/linux/bitfield.h:113:9: error: braced-group within expression
> allowed only inside a function
>   113 |         ({
>          \
>       |         ^
> drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:39: note: in expansion of
> macro =E2=80=98FIELD_PREP=E2=80=99
>    93 | #define RZG2L_GPIO_PORT_PACK(n, a, f)
> FIELD_PREP(RZG2L_GPIO_PORT_PIN_CNT_MASK, n) | \
>       |                                       ^~~~~~~~~~
> drivers/pinctrl/renesas/pinctrl-rzg2l.c:1555:9: note: in expansion of
> macro =E2=80=98RZG2L_GPIO_PORT_PACK=E2=80=99
>  1555 |         RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
>       |         ^~~~~~~~~~~~~~~~~~~~
>
> Using FIELD_PREP_CONST() instead makes it build.
>
Thanks for the pointer, that did the trick.

> I think we've reached the point where it would be easier for the
> casual reviewer to #define PIN_CFG_*_MASK for all fields, and use
> FIELD_{PREP,GET}() to pack resp.
To clarify, you mean to define PIN_CFG_*_MASK for all
PIN_CFG_IOLH_A..PIN_CFG_OEN macros? I ask because we dont extract the
respective CFG flags in the code.

Cheers,
Prabhakar

