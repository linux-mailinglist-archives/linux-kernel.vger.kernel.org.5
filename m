Return-Path: <linux-kernel+bounces-123492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17689096D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AAC1F2375E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D851384B1;
	Thu, 28 Mar 2024 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaA9Q3h4"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701641849;
	Thu, 28 Mar 2024 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654860; cv=none; b=n+00L757N3vT1dZ82YdB3MOdwSfoospGHoxMUWUMLIaS0khyDCncM+yfoWz1HspulBqPej4M2WKiKCLMxmZH6UBePKjNdpJdxUCxtvxCgHV8way5NTenBFRIaxnT21aWPr/ZcG4k671BZ8FFW5nleeptDp0M6jlaqN2ud7AHCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654860; c=relaxed/simple;
	bh=+3NWWwXtkzvrmA576fnyloztaGBywL+XKq+YksdA5gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHDj/yQVgG6GaPJlEoUIAFSKe1lc8CGfwP9G+eSe9AJvOKUuRw4DfGmBVAOi1OYoc7i47o25Gymm6o/wheYEd04wsUMUmk4yXBN1J/Be/F+jQPajk4Yx6Hwi4tAYiusTWIKgb9Zn6OtGGRp+R5pKWLYqVyXLodOYUb8fQSCLNV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaA9Q3h4; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4d438e141d5so714815e0c.0;
        Thu, 28 Mar 2024 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711654857; x=1712259657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGCaq9OrigqbkBbwFdgSJ7iz+P7VgNUODi7EL0TTbPM=;
        b=kaA9Q3h42sLRsltH3mK4bf+Kysp/vEkP2EoztKKfGf4F4xo6le+/mbcT4YLDaCYv6Z
         xyRCPRRVYeFeLtWk60JRQo/lhm0nVbAhWwQdEyuJnCQ5FDVND7S6fF/lESZh8AuAEglD
         U5rHDu9EO38SqP7eEn3ts72lj4BNehdOye1oINE4wx1KUm189/ee4LkA6rD0DGLNJmC+
         SKi87e9FI4Wkw1Ts62f9Pta9G9aT1yB2xZRb8KwCWW2yUnbXQy4G33SLOJKEwEa4h5YX
         IpJgUApWG5cCCjpunC0CbLCFKtnk7uSvKiCvxuSjCLl37Y8abg1i/SJ6qikSxLAIA+eJ
         3Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654857; x=1712259657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGCaq9OrigqbkBbwFdgSJ7iz+P7VgNUODi7EL0TTbPM=;
        b=a3s489Fbi4hZfjyX/B0EKYrhCm1t3VuQs570uBZTQCl31R2SPSsrdiKvd8pudOzjBx
         wXI6pTPTISpwU3jOt/is6cC6Qm8WaJSl0+eVmiN9fccXoJGgPZN92iz7AywAKzrxi1oE
         2h4TyqZN4soRrKPv0SqhnLShTQhWljzSh7Al5RhhPGFbT1aNurlrlvcN2Y7Qdi7i+XjH
         RbbF7/Grlq6HugKq181Wd3nSuo9fc3LIAhsXkPE3ZB89V5pAuszm3MfqmeQCzkovpD6T
         wuAMUp9jknOFj3z2Q58t4iTlFmGMca30Tu7OZLCXtJNiwsVyt48XfT08MetR0LTelxdP
         CrGg==
X-Forwarded-Encrypted: i=1; AJvYcCU+nzXZJ9kY0ZKk29e1ABHDbAnsnGpfFLM1Q+wWuFcJkBW1QOsw2UH9oWE52rJlV3BjmQcKFxpMAUz32imU8kEFgVg9OK1p5oOzvXxfFd0KdOY2AQ5pP3NkkP8QB93HmgWoJhhE5Sa0PW5KToP9RJmDEd9pBxbXfuWUuN+xdkoMlTonsENPBIggZpE/YT9n86drMwA0phvXEsrTVRvzAVxfLZENcx94wg==
X-Gm-Message-State: AOJu0YyEFheS7pG4zIkBH9fn3j9FjjOfXf2bgvMXLfTTC3ZXZQ2mKKZy
	GC20hOjHjnUGRcUW5UsNipqMfHhTX/u98H51iq2VifWd3MgEZr3flsUqtiH6l6IJhHZOtoG/Ohn
	scYD7hQ3XVt16n4chIV3glVm8xic=
X-Google-Smtp-Source: AGHT+IGGIZX5yS8mpZls/4SrlztMQeLHRiz+4BGAHryeTkdghkFMlHhUz+zkCt0bmRB5EW/857MaTjogeo0ycR0LGVQ=
X-Received: by 2002:a05:6122:2806:b0:4c8:df97:139d with SMTP id
 en6-20020a056122280600b004c8df97139dmr2962055vkb.2.1711654857269; Thu, 28 Mar
 2024 12:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-8-prabhakar.mahadev-lad.rj@bp.renesas.com> <c200e87e-1c65-4926-9307-16229e90594e@tuxon.dev>
In-Reply-To: <c200e87e-1c65-4926-9307-16229e90594e@tuxon.dev>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 28 Mar 2024 19:40:31 +0000
Message-ID: <CA+V-a8vcyxrEmHrhgwDf2bhL1QpiXW6r1+aoH3my3uAJZfCtQA@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] pinctrl: renesas: pinctrl-rzg2l: Validate power
 registers for SD and ETH
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thank you for the review.

On Thu, Mar 28, 2024 at 8:01=E2=80=AFAM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
>
> Hi, Prabhakar,
>
> On 27.03.2024 00:28, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > On RZ/V2H(P) SoC, the power registers for SD and ETH do not exist,
> > resulting in invalid register offsets. Ensure that the register offsets
> > are valid before any read/write operations are performed. If the power
> > registers are not available, both SD and ETH will be set to -EINVAL.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/=
renesas/pinctrl-rzg2l.c
> > index 348fdccaff72..705372faaeff 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -184,8 +184,8 @@
> >   */
> >  struct rzg2l_register_offsets {
> >       u16 pwpr;
> > -     u16 sd_ch;
> > -     u16 eth_poc;
> > +     int sd_ch;
> > +     int eth_poc;
> >  };
> >
> >  /**
> > @@ -2567,8 +2567,10 @@ static int rzg2l_pinctrl_suspend_noirq(struct de=
vice *dev)
> >       rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, true);
> >
> >       for (u8 i =3D 0; i < 2; i++) {
> > -             cache->sd_ch[i] =3D readb(pctrl->base + SD_CH(regs->sd_ch=
, i));
> > -             cache->eth_poc[i] =3D readb(pctrl->base + ETH_POC(regs->e=
th_poc, i));
> > +             if (regs->sd_ch !=3D -EINVAL)
>
> As of my knowledge, the current users of this driver uses SD and ETH
> offsets different from zero. To avoid populating these values for all the
> SoCs and avoid increasing the size of these fields I think you can add
> checks like these:
>
> if (regs->sd_ch)
>         // set sd_ch
>
Agreed.

>
> Same for the rest.
>
OK.

Cheers,
Prabhakar

