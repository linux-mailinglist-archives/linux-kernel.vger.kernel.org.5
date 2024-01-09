Return-Path: <linux-kernel+bounces-20508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90760827FEC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F6B1F24F17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74799250FA;
	Tue,  9 Jan 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTqaSmUN"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570C224F8;
	Tue,  9 Jan 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a28cfca3c45so65897766b.1;
        Mon, 08 Jan 2024 23:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704787149; x=1705391949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBn7NZy/Zod7QwDCsjt5OHGRxgWuXz7PP3UB8bDAwqY=;
        b=NTqaSmUNtBvr8I/T1oecexChiIkHmqB1Dbex85EVvaN7Jdo5iYWsYoT/POWP64xqw1
         b2ILNVOs8TmWB+3s6EwDDsA1fjBT8KOaKkNe6xZDBrUfO+knmgZbWfGWecBUmwJqbtrz
         NLT7/8PxChvlscXaS5OjeklXd6zNE3QNn0uS3Q3N7efXwRYz1e/1ZMHMr7HcheWaxKHZ
         2NxMEitv/y/wWqo97of5MJCAVoh7Y864MdM1qeKVmFGUiPBSFrW3aiMhYQTLzWSO/1L+
         Bva5Sih2W+LS4SAA1FLK4mapih9UbzZAQHvX9l8zZL5kNd43EmdI+bbhI74Kuh/tANU4
         jLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704787149; x=1705391949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBn7NZy/Zod7QwDCsjt5OHGRxgWuXz7PP3UB8bDAwqY=;
        b=YqkmZxYwvC3NP7xRlYAqofu2W8UC1l8o3ByWLltnFUgqSjfgXGi5p0yi8jfRB6I60i
         q8NHzFUjZLWhoGa4652VRbfy358UtbHGuNtow7GqUeRgCL5HPWraMS7g87WntDbaWlYh
         rvJVWcKWpAeGjfq2ug19Nf40UT0gHHiANEnUEEtsPbUR/7HpsOL6mxb+D3q347k7madL
         gXJvzUTPG/7kK0dbSdCJ5EcwfawzCOzIWEC7qOr2CVdhUIWPjBjStKiDuCEQJ0/RMZ7G
         SPAkTRZtk4XrtWIitb1juvaadn+XBmSEaYMpKaOD0IRbRas8xYIr1hszJ2aY1KXb+UYf
         FOoA==
X-Gm-Message-State: AOJu0Yw/WifpW3HpxQBXW2dOodk/JzINurJwvDG1w5baOJWvKD58bVRG
	ESteK2wuw4h7MKKq7vHYVCZ5GtyTbtNvSvgrNF4=
X-Google-Smtp-Source: AGHT+IGZYrSxLkuh7UEL+ddb0vYsf2vtlc41ZELVKZ1Ee4fi6OnhpG8OqGGG6ZdpPj72o34eH6Ycma4DTI1vyva2Pyc=
X-Received: by 2002:a17:906:c085:b0:a27:76d1:aa66 with SMTP id
 f5-20020a170906c08500b00a2776d1aa66mr3861330ejz.1.1704787149387; Mon, 08 Jan
 2024 23:59:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com> <20240104024244.12163-5-Wenhua.Lin@unisoc.com>
 <CAAfSe-u39LWO6A3sALHZqW8fVyiVBuus7ncVRq1RV6mWSgB5uA@mail.gmail.com>
In-Reply-To: <CAAfSe-u39LWO6A3sALHZqW8fVyiVBuus7ncVRq1RV6mWSgB5uA@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Tue, 9 Jan 2024 15:58:57 +0800
Message-ID: <CAB9BWhcV8uTHpiJVoL20C-L7uhC5p0vn7o2cHb=E5PzPocaZJw@mail.gmail.com>
Subject: Re: [PATCH V3 4/4] gpio: eic-sprd: Support 8 banks EIC controller
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:56=E2=80=AFPM Chunyan Zhang <zhang.lyra@gmail.com>=
 wrote:
>
> On Thu, 4 Jan 2024 at 10:43, Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:
> >
> > In order to solve the problem of insufficient eic,
> > it supports 8 banks of eic controller, each bank contains 8 eic.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >  drivers/gpio/gpio-eic-sprd.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index 1ca3c444957c..715c7d581d7f 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -52,10 +52,10 @@
> >  #define SPRD_EIC_SYNC_DATA             0x1c
> >
> >  /*
> > - * The digital-chip EIC controller can support maximum 3 banks, and ea=
ch bank
> > + * The digital-chip EIC controller can support maximum 8 banks, and ea=
ch bank
> >   * contains 8 EICs.
> >   */
> > -#define SPRD_EIC_MAX_BANK              3
> > +#define SPRD_EIC_MAX_BANK              8
>
> This change seems not backward compatible.
>
> Also this is not flexible to support more SoCs which may have more
> than 8 banks (if we have this kind of SoCs in the future).
>
> I would suggest adding a new item like 'bank_nums' into sprd_eic_variant_=
data.
>
> Thanks,
> Chunyan
>

We will refer to this plan for modifications.

> >  #define SPRD_EIC_PER_BANK_NR           8
> >  #define SPRD_EIC_DATA_MASK             GENMASK(7, 0)
> >  #define SPRD_EIC_BIT(x)                        ((x) & (SPRD_EIC_PER_BA=
NK_NR - 1))
> > @@ -627,9 +627,9 @@ static int sprd_eic_probe(struct platform_device *p=
dev)
> >
> >         for (i =3D 0; i < SPRD_EIC_MAX_BANK; i++) {
> >                 /*
> > -                * We can have maximum 3 banks EICs, and each EIC has
> > +                * We can have maximum 8 banks EICs, and each EIC has
> >                  * its own base address. But some platform maybe only
> > -                * have one bank EIC, thus base[1] and base[2] can be
> > +                * have one bank EIC, thus base[1] to base[7] can be
> >                  * optional.
> >                  */
> >                 res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
> > --
> > 2.17.1
> >

