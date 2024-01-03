Return-Path: <linux-kernel+bounces-15486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40312822C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474901C206A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AAF18EB4;
	Wed,  3 Jan 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6ry8eee"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D118EA6;
	Wed,  3 Jan 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a232b787259so142135266b.0;
        Wed, 03 Jan 2024 04:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704283434; x=1704888234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ68mM3ENyCFlFoKsRXtTYapy1Od7dvlW9m4qkREFmw=;
        b=F6ry8eee82Ux91UMrhhDvRhcOL/TJDI3pQvPQLWd7kjn9/kscbtZEmLfME87GzkXLB
         ZpTKRHU/+s19Fel680rktHgHANt2gk39wARwfYZGjJHwR9jxngEwQSnLxGPJXgke5Svi
         vO4yJdogRqovbanwP+PNI/f7u0gAbcutxewHpJgcK76nRIl/sQkIIloIGju5eFIjDGOA
         B1cAyzudR9euvjRTkSdw0la5wvWlSgU3kKzviRchexkOXTZm6uPVPWL6QdlPMJ13Cggw
         VuoE3SrXD6UTIuTEJ0EwG5Got0yCuitr9ihjxPZxnoQNnLmaXzPk778QeRNsq3a5RNA/
         X+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704283434; x=1704888234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ68mM3ENyCFlFoKsRXtTYapy1Od7dvlW9m4qkREFmw=;
        b=umeflHp6xbEoT5Z4Hr4mjJjcP5YEAhSNt3iJbLNhMbZdVLlxCCUMxwgJFD12MKjiIQ
         4knPEi+WoSyyU866cxtZIg0EqsymSbMlbHYRab8lMAo+AE3ThvFdEd4UtPs/lIl9LKhY
         DcEzeWULfa7zYgdX+c/6b/x1+76h0IHQmZxIwkC2a0dDEyvSbGABSAnLDzT6CA9Ezu8J
         Tc9UgqHdsJrWuXeoc/NhpiAsr7EyDIszm7g/1cF21jdijFXPVq07u5phpnBVFnjF8ifQ
         1f7EI6lY4dOCQVABLqXzm26dcnjsX808Z6SGSY8979q0u3V9NFoUfCytL2IvIBz43LE3
         aH1g==
X-Gm-Message-State: AOJu0Yw8buVJkQ2qfHv13Z4sQmfr/UWF8KxlOk9c5lN1YulpnCkaPMVo
	AXK7uPMhlJADupO3iYIyoIAQELmQE8AhccdWDkK+mWUBYq1r6g==
X-Google-Smtp-Source: AGHT+IEuYC9oGoTmGkChhADCEW2yxUR60dS77231L4O9iyDZ6v3p7muWT+2mgLP+uaZzVLEG8EKtLoMxGrP6bkT65lg=
X-Received: by 2002:a17:906:7114:b0:a28:926f:a6c1 with SMTP id
 x20-20020a170906711400b00a28926fa6c1mr950589ejj.1.1704283434067; Wed, 03 Jan
 2024 04:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com> <20230921090027.11136-5-Wenhua.Lin@unisoc.com>
 <89009348-9580-433a-05b5-1290116e7633@linux.alibaba.com>
In-Reply-To: <89009348-9580-433a-05b5-1290116e7633@linux.alibaba.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Wed, 3 Jan 2024 20:03:42 +0800
Message-ID: <CAB9BWhdqebdLjzVX83YHcsJ6iZ01FOqSdMB-VB1JQaQEVCPEwg@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] gpio: sprd: Support 8 banks EIC controller
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 5:28=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 9/21/2023 5:00 PM, Wenhua Lin wrote:
> > In order to solve the problem of insufficient eic,
> > it supports 8 banks of eic controller, each bank contains 8 eic.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >   drivers/gpio/gpio-eic-sprd.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.=
c
> > index e85addbdf8aa..6bb002060c3e 100644
> > --- a/drivers/gpio/gpio-eic-sprd.c
> > +++ b/drivers/gpio/gpio-eic-sprd.c
> > @@ -51,10 +51,10 @@
> >   #define SPRD_EIC_SYNC_DATA          0x1c
> >
> >   /*
> > - * The digital-chip EIC controller can support maximum 3 banks, and ea=
ch bank
> > + * The digital-chip EIC controller can support maximum 8 banks, and ea=
ch bank
> >    * contains 8 EICs.
> >    */
> > -#define SPRD_EIC_MAX_BANK            3
> > +#define SPRD_EIC_MAX_BANK            8
> >   #define SPRD_EIC_PER_BANK_NR                8
> >   #define SPRD_EIC_DATA_MASK          GENMASK(7, 0)
> >   #define SPRD_EIC_BIT(x)                     ((x) & (SPRD_EIC_PER_BANK=
_NR - 1))
> > @@ -615,9 +615,9 @@ static int sprd_eic_probe(struct platform_device *p=
dev)
> >
> >       for (i =3D 0; i < SPRD_EIC_MAX_BANK; i++) {
> >               /*
> > -              * We can have maximum 3 banks EICs, and each EIC has
> > +              * We can have maximum 8 banks EICs, and each EIC has
> >                * its own base address. But some platform maybe only
> > -              * have one bank EIC, thus base[1] and base[2] can be
> > +              * have one bank EIC, thus base[1] and base[7] can be
>
> Should be "base[1] to base[7]"

Thank you very much for your review.
I will fix this issue in patch v3.

>
> >                * optional.
> >                */
> >               res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);

