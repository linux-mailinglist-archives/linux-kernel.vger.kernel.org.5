Return-Path: <linux-kernel+bounces-99945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D145878F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42ED01F228EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401EB69D02;
	Tue, 12 Mar 2024 08:18:10 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04569979
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231489; cv=none; b=PErapoxyvbKsZj0LcDrKgSmsJaktL1+fG1NCLNiL4JeRd1w8HPZPun7LhhOuKCrqlcAoGVr7gpJ+TIzof8KU/HvkgZkx4RcbYNznC2BXz8gBlk4eVueMEqzdDIPLzh5SqIcdR70KcOBJGkpJMd4sZtE6nz46vbPhTDr6ylCQYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231489; c=relaxed/simple;
	bh=im5xCCQvBKXsm/C36eZknmoToBb3Y6iI7fv1/gYG61U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhE5CwAleyECx22ktGgIpmv1tpI38gsg3hUpo8bg9oTzj8ZmXEtVvstT0XrBmdYgcYVlrs4BF4UYJge5EQxuvvhEDsROljZV+GZxpwgBQFzleqGpgQCyNEeRYJOeQG1bYWxQDziPQIjPemHPfoFA0/eglZ8pL6bXQn+sH/QmW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a0a1bd04eso40134547b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710231486; x=1710836286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gwbv8378EnfGhykpUmNolcCVClkwdVd9pkq7eLDG0Bg=;
        b=i61Qakni5Jx+O47bo9IWWR4U9ve9KbYMWlYAMe8CfwgGhavFj0nwY4D8Z4H1WXLNZY
         WDlGexArPhyJYB3AAyMNmZQSeXb19dxEwjTdf9LN83gyCffUOUNIrkpgzVK2V/RNwSLa
         yHcAKRsNgGlYw9Fs3Ib77hP2A/ywaAYtuJusBOcdn9c5eBYkNN+P37htdDE/dpro7WaL
         shq6EyT6WAttKEpszpXUBvIQXVeVXmkFCeD4igPEFlmgKqfWckQBIF/0UDHlhFoZaLPF
         8KeP4kNRPMSPG+9jl3lQ2+jEKCcWlV96WSr9kaA5Yf+TcxFi31tQEqzIxNU83B+fA9mj
         oMqg==
X-Forwarded-Encrypted: i=1; AJvYcCXYrbXYeNXwdYEfwNIlPH4T1bbIzofEXE+FA05NQWTjcOq3SS7b/gtITE9UXfzbAWdvxzMVHA5naxNKA1pDd2ugbjbyeXofJ8bv0G9X
X-Gm-Message-State: AOJu0Yw0tGRIiCtFhZ7AIMOV75r3cw9onfBYpm8DCkfecGR6ZdMxQhaU
	XtMehexPyKmly6uNFXdkV31anI82qWJ7nkDgGZIXfXWzR5YZndHmawbUjYjK/8k=
X-Google-Smtp-Source: AGHT+IG70cbeAgLCv0UT1AX07LZxz7cL/gSLS4PvxGF3DyifMwtnY+JdT1/WRBgwwm0/nlR92fMHWQ==
X-Received: by 2002:a05:690c:f12:b0:60a:1772:c11f with SMTP id dc18-20020a05690c0f1200b0060a1772c11fmr9274806ywb.46.1710231486503;
        Tue, 12 Mar 2024 01:18:06 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id r187-20020a0de8c4000000b0060a304ca3f4sm1189419ywe.19.2024.03.12.01.18.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 01:18:06 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so3849551276.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:18:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUbDjPO/WB53pmUalX4o8Bt92ycmCLDzf190jfxoW69SXniELwNjEiLAD8gsH+OGEeqKwinX8rg3zXf8pY1d88Jo8fbN+R9tbawqgj
X-Received: by 2002:a25:6886:0:b0:dc7:acb7:af14 with SMTP id
 d128-20020a256886000000b00dc7acb7af14mr6475735ybc.5.1710231485862; Tue, 12
 Mar 2024 01:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710194084.git.u.kleine-koenig@pengutronix.de> <44de2d4c1fed6fe96b68ba9ad768d297b8f392a5.1710194084.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <44de2d4c1fed6fe96b68ba9ad768d297b8f392a5.1710194084.git.u.kleine-koenig@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 09:17:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVvmN2xns_76zSDpUX-v8V16mSP12A=Y4gght9cdgNb+A@mail.gmail.com>
Message-ID: <CAMuHMdVvmN2xns_76zSDpUX-v8V16mSP12A=Y4gght9cdgNb+A@mail.gmail.com>
Subject: Re: [PATCH 3/3] auxdisplay: img-ascii-lcd: Convert to platform remove
 callback returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, Paul Burton <paulburton@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Mon, Mar 11, 2024 at 10:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks for your patch!

> --- a/drivers/auxdisplay/img-ascii-lcd.c
> +++ b/drivers/auxdisplay/img-ascii-lcd.c
> @@ -279,13 +279,12 @@ static int img_ascii_lcd_probe(struct platform_devi=
ce *pdev)
>   *
>   * Return: 0

Please remove this line.

>   */
> -static int img_ascii_lcd_remove(struct platform_device *pdev)
> +static void img_ascii_lcd_remove(struct platform_device *pdev)
>  {
>         struct img_ascii_lcd_ctx *ctx =3D platform_get_drvdata(pdev);
>
>         sysfs_remove_link(&pdev->dev.kobj, "message");
>         linedisp_unregister(&ctx->linedisp);
> -       return 0;
>  }
>
>  static struct platform_driver img_ascii_lcd_driver =3D {
> @@ -294,7 +293,7 @@ static struct platform_driver img_ascii_lcd_driver =
=3D {
>                 .of_match_table =3D img_ascii_lcd_matches,
>         },
>         .probe  =3D img_ascii_lcd_probe,
> -       .remove =3D img_ascii_lcd_remove,
> +       .remove_new =3D img_ascii_lcd_remove,
>  };
>  module_platform_driver(img_ascii_lcd_driver);

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

