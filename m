Return-Path: <linux-kernel+bounces-66594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B8855EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1A3B2217C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629AD66B4C;
	Thu, 15 Feb 2024 10:05:24 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F3966B4B;
	Thu, 15 Feb 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991523; cv=none; b=Zccmf1TcshUte7QSMUlHkEsn5GXPlqQrpdBraLpmgOB6H2NVdyckfTsiwUVrcimubnAWHqZVi7HElCQr1YVJ4/5dAT6G6uStr9FAfozh0lB4C4ZqDb4kLqwdpiGfrC6vOQSWj08LalNTYOczbMqKJqyvXScZH9SojBNwaPWJV3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991523; c=relaxed/simple;
	bh=zXR1Th1Fns4JSC7Jtt7QoNy6Isissiie5f7KTXRyD6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHoB4HYVyRr5afl0LHxrZI92wIEMWt8/oXQ1BpQ3t6WHWNvWpf7La3ipsg3sq14iMwLwR/biQ2LKMw1x6Ni3uKOq5Qf9RxApJimdcygwZG/2kjozt8zlTH7hV7182xVl39FQ5ZHJEAaz1JjjT7mBZfetq8DU/aLHusdUqi1bEHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511a04c837bso775214e87.0;
        Thu, 15 Feb 2024 02:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991519; x=1708596319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMGJ76noLanla/25q8E8XYSHetkA+XFXEotUyozLh+0=;
        b=PL/5fKiheZGESkle5RNOy37J0oUpdiKmjro4412xeZJylgJ00EzlfAzjUclrrOoa/w
         kEV/idGXySw/4vqURvy2GyHr5g4ICKDKMjADixm3s9aUg8nZIYeHfHRiTvGgqXaZKzoK
         0qWlWOpyiaF/nnt8VFShu79+lnk2H3AdKWnwPPzl86rmweBxOdCbCiy8LLJ/CosLbeSJ
         aw30KPdvZOt+FRS/LjuhyTjxjNJYf1jffJWvnqoq3qJsXkOVbrRsZ9saKtoGgn0j7dvG
         TvMImkz9/zc9nRhYClt04vt/kXKSgYQax2PnfVgsgs0VUPnYA3MmtXhunE9S8tDDsDSf
         ABTg==
X-Forwarded-Encrypted: i=1; AJvYcCWdIMkwH6bFK2BWSOfSOdeI5QhyrvA8EkBSZuBkFYBAY5UzAqt9ABgRvnkf7qkzgZL2hldJ8WHvWI6a1mSBMGVIX1kOtqkD7KhZBd4t
X-Gm-Message-State: AOJu0Yyy7rIvZsOxNlzSalBLFsymvg55Bixx4nNSSj1WqtQrXbiM3Wbo
	Hzid2lsPX/ZTS63brBL0DXRszY415YwLsUzMQwHGzxb/AxBu/oJkslV406TE1wIq3Q==
X-Google-Smtp-Source: AGHT+IGuKk8ytxzR5E+csW4iJscA2ebWInfYZQ+TaRtE0Dn9WyeQH1XRAXoNxabfhu/kV3SJ9ZhZIQ==
X-Received: by 2002:a05:6512:3d0f:b0:512:8a75:53f9 with SMTP id d15-20020a0565123d0f00b005128a7553f9mr815582lfv.57.1707991518871;
        Thu, 15 Feb 2024 02:05:18 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v22-20020a197416000000b0051181cbea91sm178297lfe.228.2024.02.15.02.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:05:18 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-511a04c837bso775176e87.0;
        Thu, 15 Feb 2024 02:05:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7yxXMkr9BV7pLCXIobItVSglQVQh8m8qfyB6QH0AwSKuJyGar0F61eaic8zFnxUKb6lNj6LMSnpzlOdgmTYGgE4CB28vJSbXvXKep
X-Received: by 2002:a05:6512:3d0f:b0:512:8a75:53f9 with SMTP id
 d15-20020a0565123d0f00b005128a7553f9mr815564lfv.57.1707991518416; Thu, 15 Feb
 2024 02:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com> <20240212170423.2860895-8-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240212170423.2860895-8-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:05:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=gTH12vLALAU_ioCKX9E2mJ3uR+8Q6GT0brc4yg83_A@mail.gmail.com>
Message-ID: <CAMuHMdW=gTH12vLALAU_ioCKX9E2mJ3uR+8Q6GT0brc4yg83_A@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] auxdisplay: linedisp: Group line display drivers together
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 12, 2024 at 6:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> For better usability group the line display drivers together in Kconfig
> and Makefile.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -25,12 +25,6 @@ config CHARLCD
>           This is some character LCD core interface that multiple drivers=
 can
>           use.
>
> -config LINEDISP
> -       tristate "Character line display core support" if COMPILE_TEST
> -       help
> -         This is the core support for single-line character displays, to=
 be
> -         selected by drivers that use it.
> -
>  config HD44780_COMMON
>         tristate "Common functions for HD44780 (and compatibles) LCD disp=
lays" if COMPILE_TEST
>         select CHARLCD
> @@ -52,6 +46,16 @@ config HD44780
>           kernel and started at boot.
>           If you don't understand what all this is about, say N.
>
> +config LCD2S
> +       tristate "lcd2s 20x4 character display over I2C console"
> +       depends on I2C
> +       select CHARLCD
> +       help
> +         This is a driver that lets you use the lcd2s 20x4 character dis=
play
> +         from Modtronix engineering as a console output device. The disp=
lay
> +         is a simple single color character display. You have to connect=
 it
> +         to an I2C bus.
> +

I think it would be good to have "# <display type> section" comments,
to make the grouping clear.
Else I wonder why "L" is sorted before "K" ;-)

>  config KS0108
>         tristate "KS0108 LCD Controller"
>         depends on PARPORT_PC
> @@ -153,6 +157,12 @@ config CFAG12864B_RATE
>           If you compile this as a module, you can still override this
>           value using the module parameters.
>
> +config LINEDISP
> +       tristate "Character line display core support" if COMPILE_TEST
> +       help
> +         This is the core support for single-line character displays, to=
 be
> +         selected by drivers that use it.
> +
>  config IMG_ASCII_LCD
>         tristate "Imagination Technologies ASCII LCD Display"
>         depends on HAS_IOMEM
> @@ -177,16 +187,6 @@ config HT16K33
>           Say yes here to add support for Holtek HT16K33, RAM mapping 16*=
8
>           LED controller driver with keyscan.
>
> -config LCD2S
> -       tristate "lcd2s 20x4 character display over I2C console"
> -       depends on I2C
> -       select CHARLCD
> -       help
> -         This is a driver that lets you use the lcd2s 20x4 character dis=
play
> -         from Modtronix engineering as a console output device. The disp=
lay
> -         is a simple single color character display. You have to connect=
 it
> -         to an I2C bus.
> -
>  config ARM_CHARLCD
>         bool "ARM Ltd. Character LCD Driver"
>         depends on PLAT_VERSATILE

Shouldn't this (and PARPORT_PANEL and friends) be moved up, to the
character LCD section?

> diff --git a/drivers/auxdisplay/Makefile b/drivers/auxdisplay/Makefile
> index 6968ed4d3f0a..43bad850481c 100644
> --- a/drivers/auxdisplay/Makefile
> +++ b/drivers/auxdisplay/Makefile
> @@ -5,12 +5,12 @@
>
>  obj-$(CONFIG_CHARLCD)          +=3D charlcd.o
>  obj-$(CONFIG_HD44780_COMMON)   +=3D hd44780_common.o
> -obj-$(CONFIG_ARM_CHARLCD)      +=3D arm-charlcd.o
> +obj-$(CONFIG_HD44780)          +=3D hd44780.o
> +obj-$(CONFIG_LCD2S)            +=3D lcd2s.o
>  obj-$(CONFIG_KS0108)           +=3D ks0108.o
>  obj-$(CONFIG_CFAG12864B)       +=3D cfag12864b.o cfag12864bfb.o
> -obj-$(CONFIG_IMG_ASCII_LCD)    +=3D img-ascii-lcd.o
> -obj-$(CONFIG_HD44780)          +=3D hd44780.o
> -obj-$(CONFIG_HT16K33)          +=3D ht16k33.o
> -obj-$(CONFIG_PARPORT_PANEL)    +=3D panel.o
> -obj-$(CONFIG_LCD2S)            +=3D lcd2s.o
>  obj-$(CONFIG_LINEDISP)         +=3D line-display.o
> +obj-$(CONFIG_IMG_ASCII_LCD)    +=3D img-ascii-lcd.o
> +obj-$(CONFIG_HT16K33)          +=3D ht16k33.o
> +obj-$(CONFIG_ARM_CHARLCD)      +=3D arm-charlcd.o
> +obj-$(CONFIG_PARPORT_PANEL)    +=3D panel.o

IMHO it hurts to not sort Makefile entries alphabetically.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

