Return-Path: <linux-kernel+bounces-160125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6368B397B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A031A1C21DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE491487F3;
	Fri, 26 Apr 2024 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUK9bVTl"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982714831E;
	Fri, 26 Apr 2024 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140492; cv=none; b=Sko1lQ+OPTNSxa3sjA7Wo0LOkHFP5mJnjukJzbp7xmydCLI/noOIa8/m4n85HCie6nAoxxrm2/3VVj7YuTcJhEDfFEzYX23rGkJrp0kwolHq+FOA2g5qSG+MOQsmzWYe16JHJwWCX3eTgZYltgyBGwwKCB8NwsnPBEO1kwEabBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140492; c=relaxed/simple;
	bh=+aTLzk7JOk81DejGi5QpW5fiZbYuHYRSeE08utfOlpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezuqWcmmDmLdOr3E6OVf1+dYyFg84IPJtDlE1QcIH9Mp9hm9rPymTFfYnRAZEqmZrG1Gp3TWtCTs8G0UNCCtHBjCqw/rI3V+jg1Z2aB0qqQFxpLpyDDcOYDIzZMsoEnUl2IeM5gVYmfVJ6RN79uYVJtvnBl21WekPdGWOiFPjQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUK9bVTl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a55ab922260so299403666b.3;
        Fri, 26 Apr 2024 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714140489; x=1714745289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COQPJRSVyOS1oi1cYEIQpwZeWRGmcbcrGicpacT17Ik=;
        b=JUK9bVTlHf27sNHRb1En1e8RbhI5ys1MbR1zs4pc0JK3hqAokQSoKJ5OoNqeyEf0BB
         dfKJl6GVRwPxB7o4FQdHx8XZ4sVCqIqsCM/0vrlFgcahX01K2CqN6o8GjUrYrVKgClBw
         ddxrOwIYTLzn8UIZFiXUmEFHDbAC0oAeVS52lLcTydg69Nq30yTC3WEM+18XRecu8X/L
         /aZ5M9kNpSH+3iAteBSzsDw9By+l5cEfAfpIpoQd1VL4spL7ZhQB6bwJkuZlhIhxVn+S
         CKJ/oI7wcrx9poTrAqIPJUF8np0ADzH0l8Tn73E41JEI1Skvri92koe1GrElOgg3aooy
         SAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714140489; x=1714745289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COQPJRSVyOS1oi1cYEIQpwZeWRGmcbcrGicpacT17Ik=;
        b=i0/E6/sbjCFQcqgqfQScsoPNqoz3ISsqXYNOANxFnLOHTNfvnTfoh/MotSR1I/DJHf
         k3XBagyOfCAIkLQsL+XcHt84dxi/VwnMdIWefeVY+ygxPTNZsDHTpLnBBC9m5au3DsJc
         fBrABjFTNBTh2JROxrzJBaME3shfWLmFGa444WJt9a5uZblsMNwU3HXs3wXHfRZZp2A8
         aFnCYzfyJ9JHk+WbrGRTrCiuPZJitTjEo3U96qu6bnFTqyoVJ9b3KwOCpQysTBdtJGPa
         FY/WDMEJFEPBoT++f1efsG8H4lmhMuMcJt0MMkxYw4L8N+uDV7M8JoC1JukQInSJtIdN
         ZhKg==
X-Forwarded-Encrypted: i=1; AJvYcCWQkRKk+n7ZXljj4bJ2apFPcnYEYHEL9yVbrLRrMBFjf/Bmi8njTfa/VxavkepvEtFE4GqzLV8+M8Q4zruIE1Wci2R1uvpPG9yP6h/UZButsh15TbQlSzxcxvEczTHxesVnA4lu55u3mxNLyvZlmetJGf11AzC+Y3fMn/GpPPTTdIo+
X-Gm-Message-State: AOJu0Yze5mvthN26TFu8WfpyxW71MCYomgs3AB+YIkqSs3t5jNW7KApL
	YsIHGsAPEuUhAzqLNyeyDqkoMmqrrKwdF758CtAzedhK7QrSTo8ud2N9M1KxPJi08V9Z9tn8AZt
	nofPPJOb9WiKEBBISxHeOn4JjkBinVXPB
X-Google-Smtp-Source: AGHT+IFrPeGqCdDLMxEk/fY8rJBfvNVTkvVULlYAtdksblzM5U9eSQi9z1SXm8Oa1N1FNroV8Dn/+jnHkliqofKUqB4=
X-Received: by 2002:a17:906:c182:b0:a55:59e6:13f5 with SMTP id
 g2-20020a170906c18200b00a5559e613f5mr2151094ejz.26.1714140488963; Fri, 26 Apr
 2024 07:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426135937.3810959-1-hugo@hugovil.com>
In-Reply-To: <20240426135937.3810959-1-hugo@hugovil.com>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Fri, 26 Apr 2024 17:10:29 +0300
Message-ID: <CAF1WSuy60hWPX5gnhg+uWYu6E=i6=Gn-wFcYKNrXKSqCZ54LAg@mail.gmail.com>
Subject: Re: [PATCH] serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when
 using prescaler
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jon Ringle <jringle@gridpoint.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 4:59=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> When using a high speed clock with a low baud rate, the 4x prescaler is
> automatically selected if required. In that case, sc16is7xx_set_baud()
> properly configures the chip registers, but returns an incorrect baud
> rate by not taking into account the prescaler value. This incorrect baud
> rate is then fed to uart_update_timeout().
>
> For example, with an input clock of 80MHz, and a selected baud rate of 50=
,
> sc16is7xx_set_baud() will return 200 instead of 50.
>
> Fix this by first changing the prescaler variable to hold the selected
> prescaler value instead of the MCR bitfield. Then properly take into
> account the selected prescaler value in the return value computation.
>
> Also add better documentation about the divisor value computation.
>
> Fixes: dfeae619d781 ("serial: sc16is7xx")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7x=
x.c
> index 03cf30e20b75..dcd6c5615401 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -555,16 +555,28 @@ static bool sc16is7xx_regmap_noinc(struct device *d=
ev, unsigned int reg)
>         return reg =3D=3D SC16IS7XX_RHR_REG;
>  }
>
> +/*
> + * Configure programmable baud rate generator (divisor) according to the
> + * desired baud rate.
> + *
> + * From the datasheet, the divisor is computed according to:
> + *
> + *              XTAL1 input frequency
> + *             -----------------------
> + *                    prescaler
> + * divisor =3D ---------------------------
> + *            baud-rate x sampling-rate
> + */
>  static int sc16is7xx_set_baud(struct uart_port *port, int baud)
>  {
>         struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
>         u8 lcr;
> -       u8 prescaler =3D 0;
> +       int prescaler =3D 1;
>         unsigned long clk =3D port->uartclk, div =3D clk / 16 / baud;
>
>         if (div >=3D BIT(16)) {
> -               prescaler =3D SC16IS7XX_MCR_CLKSEL_BIT;
> -               div /=3D 4;
> +               prescaler =3D 4;
> +               div /=3D prescaler;
>         }
>
>         /* Enable enhanced features */
> @@ -574,9 +586,10 @@ static int sc16is7xx_set_baud(struct uart_port *port=
, int baud)
>                               SC16IS7XX_EFR_ENABLE_BIT);
>         sc16is7xx_efr_unlock(port);
>
> +       /* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activat=
ed. */
>         sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
>                               SC16IS7XX_MCR_CLKSEL_BIT,
> -                             prescaler);
> +                             prescaler =3D=3D 1 ? 0 : SC16IS7XX_MCR_CLKS=
EL_BIT);
>
>         /* Backup LCR and access special register set (DLL/DLH) */
>         lcr =3D sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
> @@ -592,7 +605,7 @@ static int sc16is7xx_set_baud(struct uart_port *port,=
 int baud)
>         /* Restore LCR and access to general register set */
>         sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
>
> -       return DIV_ROUND_CLOSEST(clk / 16, div);
> +       return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
>  }
>
>  static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxl=
en,
>
> base-commit: 660a708098569a66a47d0abdad998e29e1259de6
> --
> 2.39.2
>

For me, looks normal. Does not cause problems on my vendored kernel
with my XR20M1172 patches. Do I need to integrate those inside my
patch? Or how should I do?

