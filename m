Return-Path: <linux-kernel+bounces-54497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE74284B000
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF375287843
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451BB12B164;
	Tue,  6 Feb 2024 08:34:23 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC112AADB;
	Tue,  6 Feb 2024 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208462; cv=none; b=uW7XebqNHQrfraGtFiwybglN7IjUYP5GnwgnEkO3sK1DOtk1Mk0YupEFIrW6hQ1qIDzAZ/uSWFAYZ43irWuGSx+lX72jfJPxnruka/4bYtMLQTqun3NEYfRHdc/brgdDdvvd8Oo/X+2aOuiOHr80eVQmJ1WED/D8pR8ofRWvBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208462; c=relaxed/simple;
	bh=RgplDxrOi270SZjJkk1u3JMj/RZ5eLF/Ts5e7aG3o90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWosJyMhBg33am6hCBmEsTwhUWjSX3udQziIhNMHzSzJde7NpR20DEiFqCEGvMoPvzEQjaO7h+FksIAehzIo5eFWiLxZWJnW+BsdTxYIzrgixqrpb/QDwYY87WUAxKKd03u57FWJ1P+C84evzF1hrFNs6vOPEGkM5tGhpyTLhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6041c6333cdso43462387b3.2;
        Tue, 06 Feb 2024 00:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707208458; x=1707813258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lrgv2jhxyZmi4EmcR51AnI5pPGn50lZCESvCg5LBKWU=;
        b=skhtINY0Izsj4vnY18F+0QstepToVzKXnFoSqU93I04cAE0qZ3X6t7OFLOlrvW3ne0
         T1T4b6lXgxfgM/AUFAQMbjyeVk3dXHtU5F1lDlprrlx2ay7UNLmsnY/i+OhSUwJsQseZ
         SO8A+HJqA2hH2WSCpBZBzhvE7HH3kqfO1XDTEtrphRdQ2IcdKlDIqlC5IKybwSvomFZX
         GEOkomtTWHNJm/AAOj4FzaTC1ZpqGyMIgb/WVLw7phGu7MRfMflZQl8ADL0Xo9lCflUx
         0P6YldK5fXHspgGeJunkeIDvBONkvuJdE20B+fznV2afqodmADhIZQt7Kr9zrLzQlmGW
         jPlA==
X-Gm-Message-State: AOJu0YzWio49S2bA4FaGBCWHMuTrtOe3vrQP533GAFZb+kybAzzdXT5M
	FeqBwNa/B0Cupal+3E4cXcAtgQ8x8elyiUHvsKBV5M4HDb/e6A0+TncAqYVJ1BM=
X-Google-Smtp-Source: AGHT+IEcV68xRjShjrrfdq5TkVziODNZCs7qnMG85evQKsC1H0xUY+3l8nfqaCSsX2XYmal6lovT5Q==
X-Received: by 2002:a81:5d8a:0:b0:5ff:5867:e675 with SMTP id r132-20020a815d8a000000b005ff5867e675mr829172ywb.28.1707208458299;
        Tue, 06 Feb 2024 00:34:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXozpEenJ+xMJaDnpOiGdoFVfMm19q4aQsdpIer5qmcFWi49xM/awc2MuvDomb5/b3OwkudjryE5aMfwUVgGVgMYRMpXspc0hA9Tca7pxwJmSCrNKTBlnE5EbvMdSQO0jTs3I0WkhHyf5otu6A+uVXDyUH9c0WJpl/BKA10HaxxiGd5VgnbH9UF1yUm3fli5xykMrcpv4r+PZP+BG9dmL7ZZ9BvRW+eAICTPl0=
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id fp3-20020a05690c34c300b005ff9d3ca38fsm384810ywb.1.2024.02.06.00.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:34:17 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60406f4e1d0so46803097b3.1;
        Tue, 06 Feb 2024 00:34:17 -0800 (PST)
X-Received: by 2002:a81:4507:0:b0:5ff:4b67:9291 with SMTP id
 s7-20020a814507000000b005ff4b679291mr973716ywa.14.1707208457048; Tue, 06 Feb
 2024 00:34:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206075149.864996-1-claudiu.beznea.uj@bp.renesas.com> <20240206075149.864996-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240206075149.864996-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Feb 2024 09:34:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXtNgoTEBjC92BB2NSLL_8MM78sVm3A3WbhY=b-6J=vqA@mail.gmail.com>
Message-ID: <CAMuHMdXtNgoTEBjC92BB2NSLL_8MM78sVm3A3WbhY=b-6J=vqA@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] watchdog: rzg2l_wdt: Make the driver depend on PM
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thanks for your patch!

On Tue, Feb 6, 2024 at 8:52=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=3Dy (e.g. the
> clocks are enabled though pm_runtime_* specific APIs). To avoid building
> a driver that don't work select CONFIG_PM.

depend on?

> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -910,7 +910,7 @@ config RENESAS_RZN1WDT
>
>  config RENESAS_RZG2LWDT
>         tristate "Renesas RZ/G2L WDT Watchdog"
> -       depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
> +       depends on ((ARCH_RZG2L || ARCH_R9A09G011) && PM) || COMPILE_TEST

IMHO this is still a bit futile, as both ARCH_RZG2L and ARCH_R9A09G011
select PM, so this is always met.  In addition, the "&& PM" clutters
the logic, and makes the expression harder to read.

If G=C3=BCnter insists on having the dependency, what about adding a
separate line instead?

    depends on PM || COMPILE_TEST

>         select WATCHDOG_CORE
>         help
>           This driver adds watchdog support for the integrated watchdogs =
in the

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

