Return-Path: <linux-kernel+bounces-154826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B48AE192
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A701F23B98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4335FDDC;
	Tue, 23 Apr 2024 10:01:42 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBAC5EE8D;
	Tue, 23 Apr 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866502; cv=none; b=WWokdUNwf3A5q/Ma1FwtZA1pDcv6pOVJUujja06mF0NTqc5F+tKqAO9rdA+COIsbKS1rOrEeu5f6LVoo1oIT3yJLrTwK2aWVwHG+f1ebxvtqYTeWfpoXZFkhBVHyQxydoDTomerR22fetWjzYndVEA5VyJEB2aK7EVDOwjyviq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866502; c=relaxed/simple;
	bh=vyWYebRDWDhl43XoUdYklPfaE7SPJBl5AaD0stQkpPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYCyBcpPgfxfAoIKRcnfmyasMqIw+Ka7l/8hGXMJV4+5QEJZcsJF56UPYR1OKFyJce8r1R78+9VXnBlxczVoWdrwFuDBo2qHeCTv8qGHsBRiTBc/dppbEmq9AneMFbuuTButekiOP1VFJQOkdIqOrhzRHBLCCQldw9Zcs6RlJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61587aa956eso60890277b3.1;
        Tue, 23 Apr 2024 03:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713866496; x=1714471296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgAcX24jtvExHPqFhKDe6sUvmzXmlqVKJ8fmRK4rLMM=;
        b=QnZUGVP/6G7mcoWEsqegQFXvEwQ8JyQ+PGpxLnQBzhGyaQ2jX/3Ur5mIahojx7uCpC
         X8msEsyUvwHvpJmN99f51pOmn7BA5Pxma1+kpbtsLao3RS+axKYW3xDayzYYLBBE4q/j
         fgXZOkb29IjF3HMaZF69jLtfqeBH625USjY74xWFuHgQ3jnSqMM4HRoO8If7SbaLDlr8
         TyGGhZZfPi9n5A59Y5P+alAwr5l4PIAX6Cr1b6F5dCWL+LcrzD96AkFJJ0g1mWtWFEEz
         ZCxIJgoiigNS/FhqFdpwu9u2uvhB2xUPhiZfjPdBFv61mQT+cvqEtZ/VWc9qEjyWu3gn
         B5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUenAvUDDBf4huGfXhZlXanQnx6O2Z0Y+3bD/25y3ahqfMrhTF9tbkaA/v9oZ4vP2oYxJMKMP80AqNDIymF3HjZgQNma+R7lctOHbAVS0To9NGxWkVK4xRGzOnfB+DbFrkdQ3p+36ifl+Q1
X-Gm-Message-State: AOJu0YzqpOXm53bzjpLXSX8F9Mo4MnoZJQTh5Ytk0csayEcJbQpCGaWC
	k66oOKehrMvbs9O0aCcm3qfYngzl7wrZtJEnZXq1+IHglBm79CtRMphYro2I
X-Google-Smtp-Source: AGHT+IGC+P2lDwgI+w4apZDW103kzDvUza6R3SH/Y1k0APvg3OvWJthvZQ4jmkoM7ojuFQlphP/wQQ==
X-Received: by 2002:a05:690c:94:b0:61a:f1fc:eb14 with SMTP id be20-20020a05690c009400b0061af1fceb14mr14665327ywb.18.1713866495899;
        Tue, 23 Apr 2024 03:01:35 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id n127-20020a0dfd85000000b0060a16fb9209sm2426110ywf.115.2024.04.23.03.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 03:01:35 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so5025592276.0;
        Tue, 23 Apr 2024 03:01:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsR5PtRlGJ5HkmxJ1CScy+iWGm3A02yvtpcrdEEstBV1Q/5X4froCZummg8lc+LAg+Zk78ar0FBFvk40hmpnHWw9+W+sam1xZCVvZlDZbl4MlIIdOacPGcCBRRDiEjHdxPM+CrSg2Ii9eP
X-Received: by 2002:a25:2685:0:b0:de5:53c0:b9e5 with SMTP id
 m127-20020a252685000000b00de553c0b9e5mr1358571ybm.40.1713866495562; Tue, 23
 Apr 2024 03:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409154253.3043822-1-hugo@hugovil.com> <20240409154253.3043822-4-hugo@hugovil.com>
In-Reply-To: <20240409154253.3043822-4-hugo@hugovil.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 12:01:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
Message-ID: <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, peterz@infradead.org, 
	mingo@kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andy.shevchenko@gmail.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hugo,

On Tue, Apr 9, 2024 at 5:48=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Split the common code from sc16is7xx driver and move the I2C and SPI bus
> parts into interface-specific source files.
>
> sc16is7xx becomes the core functions which can support multiple bus
> interfaces like I2C and SPI.
>
> No functional changes intended.
>
> Also simplify and improve Kconfig entries.
>   - Capitalize SPI keyword for consistency
>   - Display list of supported ICs each on a separate line (and aligned) t=
o
>     facilitate locating a specific IC model
>   - Add Manufacturer name at start of description string
>   - Add UART keyword to description string
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Thanks for your patch, which is now commit d49216438139bca0
("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
in tty-next (next-20240415 and later).

> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1021,41 +1021,30 @@ config SERIAL_SCCNXP_CONSOLE
>           Support for console on SCCNXP serial ports.
>
>  config SERIAL_SC16IS7XX_CORE
> -       tristate
> -
> -config SERIAL_SC16IS7XX
> -       tristate "SC16IS7xx serial support"
> +       tristate "NXP SC16IS7xx UART support"

Hence this replaces SERIAL_SC16IS7XX_CORE by SERIAL_SC16IS7XX,
so arch/mips/configs/cu1??0-neo_defconfig needs to updated.

>         select SERIAL_CORE
> -       depends on (SPI_MASTER && !I2C) || I2C
> +       select SERIAL_SC16IS7XX_SPI if SPI_MASTER
> +       select SERIAL_SC16IS7XX_I2C if I2C

So if SPI_MASTER or I2C is enabled, the corresponding SERIAL_SC16IS7XX_*
subdriver can no longer be disabled?  According to
https://lore.kernel.org/all/20240403123501.8ef5c99f65a40ca2c10f635a@hugovil=
com/
you did want to support that?

>         help
> -         This selects support for SC16IS7xx serial ports.
> -         Supported ICs are SC16IS740, SC16IS741, SC16IS750, SC16IS752,
> -         SC16IS760 and SC16IS762. Select supported buses using options b=
elow.
> +         Core driver for NXP SC16IS7xx UARTs.
> +         Supported ICs are:
> +
> +           SC16IS740
> +           SC16IS741
> +           SC16IS750
> +           SC16IS752
> +           SC16IS760
> +           SC16IS762
> +
> +         The driver supports both I2C and SPI interfaces.
>
>  config SERIAL_SC16IS7XX_I2C
> -       bool "SC16IS7xx for I2C interface"
> -       depends on SERIAL_SC16IS7XX
> -       depends on I2C
> -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> -       select REGMAP_I2C if I2C
> -       default y
> -       help
> -         Enable SC16IS7xx driver on I2C bus,
> -         If required say y, and say n to i2c if not required,
> -         Enabled by default to support oldconfig.
> -         You must select at least one bus for the driver to be built.
> +       tristate
> +       select REGMAP_I2C
>
>  config SERIAL_SC16IS7XX_SPI
> -       bool "SC16IS7xx for spi interface"
> -       depends on SERIAL_SC16IS7XX
> -       depends on SPI_MASTER
> -       select SERIAL_SC16IS7XX_CORE if SERIAL_SC16IS7XX
> -       select REGMAP_SPI if SPI_MASTER
> -       help
> -         Enable SC16IS7xx driver on SPI bus,
> -         If required say y, and say n to spi if not required,
> -         This is additional support to existing driver.
> -         You must select at least one bus for the driver to be built.
> +       tristate
> +       select REGMAP_SPI
>
>  config SERIAL_TIMBERDALE
>         tristate "Support for timberdale UART"

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

