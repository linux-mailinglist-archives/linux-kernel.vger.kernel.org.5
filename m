Return-Path: <linux-kernel+bounces-22539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB8829F35
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A147D1F2955C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF54D109;
	Wed, 10 Jan 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVcJekcy"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79FE4CE19;
	Wed, 10 Jan 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4b74a9a9d4cso1297855e0c.1;
        Wed, 10 Jan 2024 09:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704907827; x=1705512627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJQgqA7+RGkd/C8XliFqeVj2JUHDnwbsBfW3+WX0Iqw=;
        b=EVcJekcyRGCgEw6AMfHbhpvrecVtmpyt81U4PR1oai3qZ6IVxKiEUXNVELqNaNgmIu
         BZkjUG4az6i7sI3TO4DlPpjIFKXkuP3cybVGUQqT7i4fV6jf231vGNtQPDN/ZGQ5k3si
         UQQQpoRdYxQhEfmVvx44QbDZPU2+jvrnOLXfMCr//CEUyAuoDKack+EQNWtHtze7zwPF
         CfnotlO2MlSCdyN4f6Y+QBkZbGqjebIrekfMFe6HiPxvnmJxEjuDcpidD1uLiCPhYVLF
         vNQnMVN/6Y1dfMZLEz2M0yitabkzkzfY6H6ZtPwmzI5JbB43F+fBJIjV7JBkyXS8uhoV
         hLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704907827; x=1705512627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJQgqA7+RGkd/C8XliFqeVj2JUHDnwbsBfW3+WX0Iqw=;
        b=dawCnbEdftFVAiyWMOjcrDOABset9H4BJvhMzwNkL0QeKxLePwY7caKmw+tTV4TdCU
         JRQOfPsLUG3waUROfXCQH/fFVSCJdervoQmkncRjzixoWoaKBher0C96PMKPyA4mAl3D
         KcoFXFb9L0lmaBFMz3cIxA1Iwle4kAyNKcJMxRFabKJwEC5dermtVHXQu7Lhdy5y/ttj
         1jWp3O5GTIJipmnyVfosrYAqIyV4/VLe2mp6zKUGphJrRbqQ+5rH0UnBS4KxYNNf3tqz
         pasnKXI05Z9w5GAP9YUii1unHOJcBQT7k0XZi7OaW04wCbVWhGx9S/HnQ17w3hgHJ0TW
         3CIQ==
X-Gm-Message-State: AOJu0YyBMqNqjtvukjI7/hTWneS1GJjvwOkRUl2tsNYQ2BG0nsy+Jp37
	PRzUiRbXIXlVLT/1PjIvTPkx+r7vjGf6H00Pmk7NAzYDp3g=
X-Google-Smtp-Source: AGHT+IFwsjDlGrbGidyU61F0q8HzZj82rD7bqz7vCZ2gVOIcmrsxMB3AARc8xlHG9Y904DKoCa2/ORHgkABYG1i9oLY=
X-Received: by 2002:a05:6122:278e:b0:4b6:eb5a:ee98 with SMTP id
 el14-20020a056122278e00b004b6eb5aee98mr828898vkb.14.1704907827212; Wed, 10
 Jan 2024 09:30:27 -0800 (PST)
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
 <CAMuHMdXosvV=EuRtL69r6=UT0SO8Aq-XjWwJMJQpWAhT2z+ffA@mail.gmail.com>
 <CA+V-a8tNeiyvK90urPF9s3JZOav77TRO8xdAEiCmYurrf3-4RA@mail.gmail.com> <CAMuHMdXYEBg7MMJG7tqDib8eaKdvd4Fxo+ZR8K8Vq82DzjSaqg@mail.gmail.com>
In-Reply-To: <CAMuHMdXYEBg7MMJG7tqDib8eaKdvd4Fxo+ZR8K8Vq82DzjSaqg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 10 Jan 2024 17:30:01 +0000
Message-ID: <CA+V-a8sBWTd4UfSm=mFN96aLL7BvFMTovfaXjdbC4uH=UDR_Fg@mail.gmail.com>
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

On Thu, Jan 4, 2024 at 4:25=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Jan 4, 2024 at 4:55=E2=80=AFPM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, Jan 2, 2024 at 10:18=E2=80=AFAM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Thu, Dec 21, 2023 at 10:04=E2=80=AFPM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Wed, Dec 6, 2023 at 1:13=E2=80=AFPM Geert Uytterhoeven <geert@li=
nux-m68k.org> wrote:
> > > > > On Fri, Dec 1, 2023 at 2:16=E2=80=AFPM Prabhakar <prabhakar.cseng=
g@gmail.com> wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Currently we assume all the port pins are sequential ie always =
PX_0 to
> > > > > > PX_n (n=3D1..7) exist, but on RZ/Five SoC we have additional pi=
ns P19_1 to
> > > > > > P28_5 which have holes in them, for example only one pin on por=
t19 is
> > > > > > available and that is P19_1 and not P19_0. So to handle such ca=
ses
> > > > > > include pinmap for each port which would indicate the pin avail=
ability
> > > > > > on each port. As the pincount can be calculated based on pinmap=
 drop this
> > > > > > from RZG2L_GPIO_PORT_PACK() macro and update RZG2L_GPIO_PORT_GE=
T_PINCNT()
> > > > > > macro.
> > > > > >
> > > > > > Previously we had a max of 7 pins on each port but on RZ/Five P=
ort-20
> > > > > > has 8 pins, so move the single pin configuration to BIT(63).
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renes=
as.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > > > @@ -80,15 +80,17 @@
> > > > > >   * n indicates number of pins in the port, a is the register i=
ndex
> > > > > >   * and f is pin configuration capabilities supported.
> > > > > >   */
> > > > > > -#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) << 28) | ((a) << =
20) | (f))
> > > > > > -#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (((x) & GENMASK(30, 28)=
) >> 28)
> > > > > > +#define RZG2L_GPIO_PORT_PACK(n, a, f)  (((n) > 0 ? ((u64)(GENM=
ASK_ULL(((n) - 1 + 28), 28))) : 0) | \
> > > > >
> > > > > The mask creation can be simplified to
> > > > >
> > > > >     ((1ULL << (n)) - 1) << 28
> > > > >
> > > > OK.
> > > >
> > > > > but see below...
> > > > >
> > > > > > +                                        ((a) << 20) | (f))
> > > > > > +#define RZG2L_GPIO_PORT_GET_PINMAP(x)  (((x) & GENMASK_ULL(35,=
 28)) >> 28)
> > > > > > +#define RZG2L_GPIO_PORT_GET_PINCNT(x)  (hweight8(RZG2L_GPIO_PO=
RT_GET_PINMAP((x))))
> > > > >
> > > > > I think we've reached the point where it would be easier for the
> > > > > casual reviewer to #define PIN_CFG_*_MASK for all fields, and use
> > > > > FIELD_{PREP,GET}() to pack resp. extract values.  That would also
> > > > > make it more obvious which bits are in use, and how many bits are
> > > > > still available for future use.
>
> > To clarify, you mean to define PIN_CFG_*_MASK for all
> > PIN_CFG_IOLH_A..PIN_CFG_OEN macros? I ask because we dont extract the
> > respective CFG flags in the code.
>
> The PIN_CFG_IOLH_A..PIN_CFG_OEN macros are single-bit definitions.
> I mean to #define PIN_CFG_*_MASK macros for all multi-bit fields, current=
ly
> accessed using open-coded GENMASK().
>
> You already tried:
>
>     #define RZG2L_GPIO_PORT_PIN_CNT_MASK    GENMASK(31, 28)
>     #define RZG2L_GPIO_PORT_PIN_REG_MASK    GENMASK(27, 20)
>     #define RZG2L_GPIO_PORT_PIN_CFG_MASK    GENMASK(19, 0)
>
> As they actually share the PIN_CFG_* bit space, I'd call them:
>
>     #define PIN_CFG_PIN_CNT_MASK    GENMASK(31, 28)
>     #define PIN_CFG_PIN_REG_MASK    GENMASK(27, 20)
>     #define PIN_CFG_MASK    GENMASK(19, 0)
>
> Also, you already have:
>
>     #define MUX_PIN_ID_MASK         GENMASK(15, 0)
>     #define MUX_FUNC_MASK           GENMASK(31, 16)
>     #define MUX_FUNC_OFFS           16
>
> But all of
>
>     #define MUX_FUNC(pinconf)       (((pinconf) & MUX_FUNC_MASK) >>
> MUX_FUNC_OFFS)
>
>     pins[i] =3D value & MUX_PIN_ID_MASK;
>
> can use FIELD_GET(), removing the need for MUX_FUNC_OFFS.
>
> Also:
>
>     u8 pincount =3D RZG2L_GPIO_PORT_GET_PINCNT(cfg);
>
> can become
>
>     u8 pincount =3D FIELD_GET(PIN_CFG_PIN_CNT_MASK, cfg);
>
> Same for all the other macros using GENMASK().
>
> I hope this makes it more clear what I had in mind?
> Thanks!
>
Thanks for the detailed explanation. I'll get that sorted soon.

Cheers,
Prabhakar

