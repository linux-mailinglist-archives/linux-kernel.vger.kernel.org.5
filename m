Return-Path: <linux-kernel+bounces-74882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9126685DECD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27E91C23C90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D81169317;
	Wed, 21 Feb 2024 14:22:02 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8A7BB11;
	Wed, 21 Feb 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525322; cv=none; b=dnJ/4zHw/02uSacXyKGRwJIIQGVsRIXGR4xV/JA/+DIM+AeJS0bm6zRgWCDtxwtqefjz/wxWQRUGbWJPnjxDwESBd5DM9y38Vc6W1vUV3YhrxZr5GA7dxwSWJeVhHcgur58wIb/+iTOpht3l8+SuR6iZRWqNjleFeoezDm2agE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525322; c=relaxed/simple;
	bh=tbyIxQREtNsFl1chxmmOOxgq+9kmqvxm0SE09qbdS3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CY3Oglk4B7hwI14DKRQMz8czfp+JKKIMTiaDZVmjpuuZs70aXWX9li3RmEb6GXTAwL0lJzVCwzn13ZWc4s+IksGCWdxII5qaszDprfTZ3YQnDcNJxzMl4AKRcU8lSNHAlxqEVdyXlgMXHaRCeU+Rt0fN3ukIs9aObGq01hYvBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60893d33269so183937b3.1;
        Wed, 21 Feb 2024 06:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525318; x=1709130118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1d06i49LL9s1ZMGyde7w44zWXOkIzOdUii8V8sAQFpI=;
        b=NTRx488gZvLGLnd/od895OIil+ZBy1TC0mNLeM4izgnD5Hs1uas2t+ayuEIVMdzbJZ
         Q2GEpA4ezz1XYTVLu9IIMW5vkRJnNbxRGYXLKLgJN00dOG6/MCB2ilYnfhLasEr61YhH
         hB76nVtGtlwI6uKTM+6ilPALO+BJzS6dGIVj6B+uKxeKQEysLAsvSqce1km1KersM33f
         3cun18oNMKnxRCEoxDMOKT2SHOSUdouV2+7pjYCKrmq72pynsefzooCaZnyeYVfIR7iP
         gtNJ5KRRIlI/U7ZS3ACHZCYai1Qi+QalM7CkIIq1A3V6ALmI1aQEBVHbpy7t8fjTYi7S
         W6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUc5+ivMr1yhMWDfbUwexHhY+Q97SFo6mN9C3a9m/DbcEopgIUpbOcmWcE0NKUSCxIJRbjIHeqKaCRRiDrgQy/NzHM8qOUdBV6JwIruFWvZF7sW54kaIkInoa27IwfqaYEpcXcfoyINU9yUxWWQnBiBGjGUnbwuQxnDYZxbsyJBdauvgOQ5foxpal9
X-Gm-Message-State: AOJu0YxuNqm6GRnEcLu1mwCwrM+fowxrFY3kd22SLZgVSwrthlZsKmWh
	4wvxsMOwJOWwYEfXcUtYJ2dGEWaamsSfNmcTFdUgSfg7oMmxXDji8DM4Lar+3AU=
X-Google-Smtp-Source: AGHT+IEOXOIwfrVvLYMLiVSmayIuAMz+72BSqjQLMFmTQMawKKL2HeLttcbTR5CJP7/8ts4S8FgGdQ==
X-Received: by 2002:a0d:d685:0:b0:5ff:790d:62a with SMTP id y127-20020a0dd685000000b005ff790d062amr18310762ywd.5.1708525318664;
        Wed, 21 Feb 2024 06:21:58 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c129-20020a0dc187000000b00607ecc4212csm2614164ywd.80.2024.02.21.06.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:21:58 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso6800358276.1;
        Wed, 21 Feb 2024 06:21:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaE0v0rOSdBTWnYXAdEAxUKJDD0RgobQnLkao4qzilJU6q9/pax/SMMq2nrFvSbTOOd+O8V+uA6dfarue84E25nhASHwD1kpwFl2BwOFYL1PZmRpgAU6v+cjA9fL4N258BZZpH9DtVd/PINz2jpTGuMeRGPAf/mcWt/BZXmZevfHJ8T0odyT6qEHGP
X-Received: by 2002:a5b:445:0:b0:dc2:48af:bf17 with SMTP id
 s5-20020a5b0445000000b00dc248afbf17mr14910452ybp.62.1708525318012; Wed, 21
 Feb 2024 06:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215124112.2259103-1-claudiu.beznea.uj@bp.renesas.com>
 <20240215124112.2259103-2-claudiu.beznea.uj@bp.renesas.com> <CAMuHMdVi5vN5JSf9TAbdyrNa8_7eM=RajH8Mm=Qxhj5chWcK9A@mail.gmail.com>
In-Reply-To: <CAMuHMdVi5vN5JSf9TAbdyrNa8_7eM=RajH8Mm=Qxhj5chWcK9A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2024 15:21:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7jFzkX7dozKYnhp5RUPr4-1tG0Eba1he+t3nskagZMg@mail.gmail.com>
Message-ID: <CAMuHMdU7jFzkX7dozKYnhp5RUPr4-1tG0Eba1he+t3nskagZMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: renesas: Select CONFIG_IRQ_DOMAIN_HIERARCHY
 for pinctrl-rzg2l
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:13=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Thu, Feb 15, 2024 at 1:41=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev=
> wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The pinctrl-rzg2l driver uses APIs that are defined only if
> > CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy (irq_chip_*_parent() APIs). On the ARCH=
_RZG2L
> > CONFIG_IRQ_DOMAIN_HIERARCHY is selected anyway, e.g., by the
> > CONFIG_ARM_GIC_V3. Even so, make it explicit at the driver level for a
> > clearer view of the dependencies.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Thanks for your patch!
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Compile-testing on m68k reveals that you also need
>
>     select GPIOLIB_IRQCHIP

FTR:

drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function =E2=80=98rzg2l_gpio_fr=
ee=E2=80=99:
drivers/pinctrl/renesas/pinctrl-rzg2l.c:1472:30: error: =E2=80=98struct
gpio_chip=E2=80=99 has no member named =E2=80=98irq=E2=80=99
 1472 |  virq =3D irq_find_mapping(chip->irq.domain, offset);
      |                              ^~
drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function
=E2=80=98rzg2l_gpio_populate_parent_fwspec=E2=80=99:
drivers/pinctrl/renesas/pinctrl-rzg2l.c:1953:23: error: =E2=80=98struct
gpio_chip=E2=80=99 has no member named =E2=80=98irq=E2=80=99
 1953 |  fwspec->fwnode =3D chip->irq.parent_domain->fwnode;
      |                       ^~
drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function =E2=80=98rzg2l_gpio_re=
gister=E2=80=99:
drivers/pinctrl/renesas/pinctrl-rzg2l.c:2057:14: error: =E2=80=98struct
gpio_chip=E2=80=99 has no member named =E2=80=98irq=E2=80=99
 2057 |  girq =3D &chip->irq;
      |              ^~

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

