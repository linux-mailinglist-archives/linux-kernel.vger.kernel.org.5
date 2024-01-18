Return-Path: <linux-kernel+bounces-29936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB04831566
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D861F2211C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798F13FEF;
	Thu, 18 Jan 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1iayccb"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DA712E41;
	Thu, 18 Jan 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568664; cv=none; b=tPIzmbSG7spz+1t84McunorgFNQIhWe8u15nLCSgzHsFYSq/ytgBVoMMwGW1AV4T/euPpUb58FR/EgE4PCpvZH82X7MeL4qn6lVDSxms4ReV9rIcLLYbqPAiur363litq5hL6x3AemcL2UFcNmUvsC9ce3LxPZN9VueiWWfPy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568664; c=relaxed/simple;
	bh=Cy29blYtOL8hXF3iNGpo76Fmt3RU8Vjz1i2wkMTBQ98=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=NuGUkbc5SixOga85Er/IgbqOj2+vlJsXRvW5WQtWj1V9aPmfP2ReserpsbjYS99AktoU6bwyhY6Q0s3laJ6uKmEzntWmr+NbawdVy5qn/HcH/DOQDN+OpqQQ0EL02y+aFg8YvSvCWYTQ4YapgLc9lSLLJbISf5X3yn5Q3u71ZFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1iayccb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26fa294e56so1251658466b.0;
        Thu, 18 Jan 2024 01:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705568661; x=1706173461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5t772S8vsp7sqvQIHtML2Lp6V766h0wNn7VzTTwTSA=;
        b=m1iayccb/kjogDT+tiYK2QuGkp4j8kYIDHngXrXi2y8wBGzXsc6y17/NajW6uNh4nD
         j3pxtpkM90TzPn7GuNRhnt4rF0EEKBE96y1YMUZ87v8eM+UZwkY0GSlHyNKcpK/eix9c
         rhUTEybBY8syW96fWzT3vUTsNZsO23Wq4G6+074wHNhxlPNZVPmHYW8vk4aXx9EjwbLj
         BZDNdAWrePxkz306kc3gj6vY16bKT7cndSCgmNB4gIF4PUKndyscExazfGpxn9yajqav
         HSP7gtYYaxWJLd9RcMDjI1yM+oQakp0pRp0NPNswCnAUYiMcQE4SCvAHwNWl6GSQQhYP
         IUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705568661; x=1706173461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5t772S8vsp7sqvQIHtML2Lp6V766h0wNn7VzTTwTSA=;
        b=GG2cl7EVqRb8weMehJFOu1H0Aoxow92dMsXZ3Le9wRSMHCDvhoiaSWofGQxMTjGVZW
         J/u31n/gdTE09FbzWUrsEcuiegODL4OD438m1k8QdWlHd14vUeH2bjFGzMns3vr9NcRk
         tPPxpSKqiqg06bBhF7TXr7HLuuBqehKleQj4kdrnKvMvlCf/Cnizn2La2YeKRAs7fRH+
         jyXSibfxvJo3/k9iqOvOaar0eTiwqn4XJDmVoOgp/rklltP7gWlpq25CZWQOLoXdkbOo
         DzTYyEIOirfSYdV5PPymI+84UfZnWiWrq+37OpOzxd0KsnfmmCAkxbSYQtT4JobLRIti
         R8rg==
X-Gm-Message-State: AOJu0Ywe+dECGlCx7XKo2tbBw2DZtkfu63pWjVDUeBrz85HzUiS5mDfr
	8HIi8TMbW+hNluldu3foqXuKuZi9E7TJ7HgsOdtdqGjyG929HoE6MrYkxXHK+xk/xb5VKVIhJXp
	0d+KryLYIVe+6hGvN7ynjHbg6nuE=
X-Google-Smtp-Source: AGHT+IEVS3DrF0VDBRkpOHBLTP50YToKVYiSYI8gmaMux7Cp4NGxB2HLSReD4CdWSdU8opRHU5ykcHcHvmKJd6CgA9w=
X-Received: by 2002:a17:906:d96d:b0:a2f:1817:2ef with SMTP id
 rp13-20020a170906d96d00b00a2f181702efmr308106ejb.70.1705568661001; Thu, 18
 Jan 2024 01:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117083251.53868-1-hector.palacios@digi.com>
 <20240117083251.53868-2-hector.palacios@digi.com> <CAHp75Vci=1nAvxRcbkK2SxGWGbQVbzQMTycMt8tZ5snPRTYXOg@mail.gmail.com>
 <fd5550ad-76c0-419b-aa07-a0493a57286e@digi.com>
In-Reply-To: <fd5550ad-76c0-419b-aa07-a0493a57286e@digi.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 18 Jan 2024 11:03:44 +0200
Message-ID: <CAHp75Vf4wXLEjmfpz6KQSCB0Jd8LNv6+SU_ikbhR_8PsJHuq-g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: vf610: add support to DT 'ngpios' property
To: Hector Palacios <hector.palacios@digi.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, andy@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:25=E2=80=AFAM Hector Palacios
<hector.palacios@digi.com> wrote:
> On 1/17/24 21:51, Andy Shevchenko wrote:
> >> Some SoCs, such as i.MX93, don't have all 32 pins available
> >> per port. Allow optional generic 'ngpios' property to be
> >> specified from the device tree and default to
> >> VF610_GPIO_PER_PORT (32) if the property does not exist.

..

> >> +       ret =3D device_property_read_u32(dev, "ngpios", &ngpios);
> >> +       if (ret || ngpios > VF610_GPIO_PER_PORT)
> >> +               gc->ngpio =3D VF610_GPIO_PER_PORT;
> >> +       else
> >> +               gc->ngpio =3D (u16)ngpios;
> >
> > This property is being read by the GPIOLIB core. Why do you need to rep=
eat this?
>
> My apologies; I had not seen this.
> I'll use gpiochip_get_ngpios() on the next iteration.

But still why?
https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L867

It's called for every driver.

Maybe it's needed to be refactored to allow fallbacks? Then can the
GPIO MMIO case also be updated?

--=20
With Best Regards,
Andy Shevchenko

