Return-Path: <linux-kernel+bounces-154931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBCE8AE331
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61346B23BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF7F64CF2;
	Tue, 23 Apr 2024 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FKlmAwYP"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9327560B9C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869826; cv=none; b=LlwBiMLy4/ggpW+K7yfnjeBRVp/2QvVsbn9mz33qdfCWDt1rs1njMDdAk0PVuOIb+xYlWNCuWha69UULfE054St4oIaRxEBXwLzO7lMjn7wyNJVaePUSmUh0or/EtlgPNONcgPi3MAslZHC02bVXlvOXDSOxjdyIfM7WjzT9Q5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869826; c=relaxed/simple;
	bh=wLVBgPgK46w9KM0ua1X9pCnwdk9I/0PinDZppvDLcmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzC1EzGNQPJwXkwjMe9Cvu2KtcJFRKbMkoRc9v7Q/u96gMjW5LkCeX8PUk4HabUutmdTW05yzgtIxWwwt40MyywbAbJgnDev6812aVrRPWvgM02Jb579KipnF/6gwtTDf85/eIkgck8eKIHfXREOubnXIaO7t9Ac7yR9VXLwyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FKlmAwYP; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51ac5923ef6so3260647e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713869822; x=1714474622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdW/LjY6qj29zoQWo6lWGy4ogoBC4CsCwa2E/E8rpTg=;
        b=FKlmAwYPCVuTvzgimu8LM8+rewAEw6pe2SSrycXxV3GrrDnAuLopXO5ogfv1WoV894
         FQpsU+OI/vUkZ46EA6+0G52v3PZTGpW/R20yOm1DPpDOdq0IcanzXiK/fMdy6APWJA1W
         u+COoTqWCTZHXirL4oNAytKy76VzVrIC0ohRL0U/8Kok4aBk9y57oxqzrbF5rxS7kVUh
         1S5K0gGTVP/mvwe5dV47LpB6UjRHCE2/KA6EqhNZJAUvz/KSADHajLLAoOn+ZxyTgVnV
         Ls4/BjdtuNqowlQX/FbbDR+xIhsFLfzFSVU2XvuoYE9yiUBHInl+Mb9FAWG1T4Qda5Zx
         IXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713869822; x=1714474622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdW/LjY6qj29zoQWo6lWGy4ogoBC4CsCwa2E/E8rpTg=;
        b=S7ZojqINtdoGLvug0XV4lssxFYTRhcz9p6RkXtH6pEmmkaq+DPeohuDQboyIhO0kge
         9aCkcD3feDR9e3vXT0Pni4jqQwFQ2U+DlWjoiu2XJoyXHgbRM08+3yT07djr52KSPIas
         8HRh/e6SGxcY8OIQ+yf2BLlz+GpALg3WUOEz4a9UcENjJuTrd4ECGr8dVKfEx07RUvwJ
         fJQ6B/8IWkdiqMv2AIH9zzJWebZIJUYxoBlatN3XCJuiyTl5z9XyPXJhcRYPlyJHtYZb
         srWaoLo6saVjduWxr4sBdimSjuQAP34BMZnbF46qYFsYRN9LdGBtTpPQB7zErGAdZrkL
         yTQA==
X-Forwarded-Encrypted: i=1; AJvYcCUAlxUuoaLzi8Y5/sdck0GFQzq5BS8vEWDIgeSHIqTo/TInXtgmE7uwG4eaOWA/x32O2RbF//4hwEVRiF7/zBFG5eY2IRIQBfcghWSq
X-Gm-Message-State: AOJu0Ywco8/mycR7RZx8BtOAaJBQPkO7WhI6VfdEUrL7A8tU8k82jn6P
	GCbKjDI+Tt/W754KQKblihtkVelBfylcavXKg46G7itzourfQ0JGsFYztqRF8RWlof5Soktcjko
	vnTN/KjWw6If30vTtmuaZbM4sbmBYbwbrhqD80Q==
X-Google-Smtp-Source: AGHT+IHq2NMdnc+Cduu/lVn33H+Myuo+m7Js3CIcZkZiVbqVDmL57a3r9YJygCSp+EwxMqSAKS5xQlOBYQJzMkAjP60=
X-Received: by 2002:ac2:5e9e:0:b0:51b:533f:6483 with SMTP id
 b30-20020ac25e9e000000b0051b533f6483mr745330lfq.30.1713869821680; Tue, 23 Apr
 2024 03:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423022814.3951048-1-haibo.chen@nxp.com>
In-Reply-To: <20240423022814.3951048-1-haibo.chen@nxp.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 23 Apr 2024 12:56:50 +0200
Message-ID: <CAMRc=MeoAbdqwtpK87zQytC7PcS==HjQ6GUO7MeWcZHRXf-SjQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
To: haibo.chen@nxp.com
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 4:28=E2=80=AFAM <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Though the default pin configuration is INPUT, but if the prior stage doe=
s
> configure the pins as OUTPUT, then Linux will not reconfigure the pin as
> INPUT.
>
> e.g. When use one pin as interrupt source, and set as low level trigger,
> if prior stage already set this pin as OUTPUT low, then will meet interru=
pt
> storm.
>
> So always set GPIO to input mode when used as interrupt source to fix abo=
ve
> case.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/gpio/gpio-vf610.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> index 07e5e6323e86..305b0bcdee6f 100644
> --- a/drivers/gpio/gpio-vf610.c
> +++ b/drivers/gpio/gpio-vf610.c
> @@ -214,7 +214,7 @@ static int vf610_gpio_irq_set_type(struct irq_data *d=
, u32 type)
>         else
>                 irq_set_handler_locked(d, handle_edge_irq);
>
> -       return 0;
> +       return port->gc.direction_input(&port->gc, d->hwirq);
>  }
>
>  static void vf610_gpio_irq_mask(struct irq_data *d)
> --
> 2.34.1
>

Can you use gpiod_direction_output()? Otherwise the flags of the
descriptor will tell a different story.

Also: this doesn't matter here as it's a built-in driver but irq
callbacks accessing gpio_chip is a thing that still needs addressing
as it doesn't use SRCU. :(

Bart

