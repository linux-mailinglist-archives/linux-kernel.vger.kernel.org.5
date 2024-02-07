Return-Path: <linux-kernel+bounces-56612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF5484CC91
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A708B2423B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5B77CF0F;
	Wed,  7 Feb 2024 14:23:25 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515507A727;
	Wed,  7 Feb 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315805; cv=none; b=LA19ro2/Z4QI4XFI1JXegdbgCXA8ePR1GrP1i2foI8wZPEJzmlJ9fiCChNwb/yGu/gzr3p8hOkp1k2E7GlNwGIFa6S/FCLwfSH8DM3jYJLtBfgv2iYmXO8965squVFoUtaQ63tol/h7fEFNYVTZKwbCZVK4z6qvIYaOWmH1XOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315805; c=relaxed/simple;
	bh=C8HAWKdg+GGDjKPhogyYOys9iDIIKvHEu7Ej597B0xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlQtwyrL/IKPwd94AEltzk1xkxH5CDOxsEIs1Ne1qIcIA42d3H8gRKfWT6aIC2malHShnGfSNmFFg3OCMxhP3IjvnUeDbnoRaCYQXzrtx8ErTiGGE6tJ2EQ4+2woJuy/lcAl1aw+9PgsceeRXgAEKZm+ayQZ4Q3SdR2GoWhYPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60491b1fdeaso6387287b3.3;
        Wed, 07 Feb 2024 06:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315801; x=1707920601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quLdQVtCbPlr3R7R7qoI+1xisR6sbzdwCB1pi/XdB0E=;
        b=CrbNeQnrdfRbc7ZRmCfD9NCz2nfC2UmIZKjXUJJfUqc0FuJCD1Mz9Ty+G4dSbIqBLj
         yBEVcntpWxt1Zjxc7YOhmJ6/mdMo3QCEEzIYbDtOXX6HLRP15b1jKaaG99mmnkZVfQKi
         HBwkrDHaiSAfdjicdzlmqCaA9Z9wkPt/gRk/XIeJrYjHv83P3TFVjZ+U+/1nhivJRwBN
         Op4Hc3n88WdNgDsZy8j8cAfF7WV5t2ozuwwHEWB8ovVsf3ZStWBwa0wNURPei6b62bjV
         GmjHQV/GqW3c3AKvvqQ56tQVLJ0ftdFUwj/guRPTsM80v+qCyj4QxlZBZU5UTqnqITLe
         0gBQ==
X-Gm-Message-State: AOJu0YxAH5+WcI/BD/ydWE7gZbc/4CvG8Ec9WhobwMIWS+budCxkj0XJ
	vADx0d4kmLWaOFK7E/So4QjH5qF04g8vk4zndCA3MWuVzlEHkQtIj9KNTsapctY=
X-Google-Smtp-Source: AGHT+IFkoyZxcgIjHoazuT3U+9rYfh+rNKGQbBh9K+6z2lmCvxr8CXG2o7nsHROonhuJZzRTabavkg==
X-Received: by 2002:a05:6902:1a45:b0:dc2:2e01:4ff0 with SMTP id cy5-20020a0569021a4500b00dc22e014ff0mr5239168ybb.45.1707315800924;
        Wed, 07 Feb 2024 06:23:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXj5EIwA7CUKWQNYzVF7to7/Jv2XJXW84HaCbqfBWLzEwrckzVtACOmfONStfMc4i+n1a4fpZG94MI/NYONDOm4snGVe+1c/e8XuXb+dPj0dZHrnP6r1UP+/OB+Lsgy21JyBK86V2KqA3MByvtKbSKOM++XvbOvnYv1ScwavgA81mbnzGCnPiMrJwL87lqFgkGdiVTkw1aPQ2AsLgEnem6SnrquqwwpcYqugM=
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id ch22-20020a0569020b1600b00dc23af43ff3sm219983ybb.14.2024.02.07.06.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 06:23:20 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60491b1fdeaso6386597b3.3;
        Wed, 07 Feb 2024 06:23:19 -0800 (PST)
X-Received: by 2002:a81:8841:0:b0:604:9c80:687a with SMTP id
 y62-20020a818841000000b006049c80687amr652928ywf.6.1707315799577; Wed, 07 Feb
 2024 06:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207130745.1783198-1-claudiu.beznea.uj@bp.renesas.com> <20240207130745.1783198-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240207130745.1783198-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 7 Feb 2024 15:23:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-Lw3Ay94_gYHU4A8iYSRbXy8b7XOiMQ93Mbs+-ApsGQ@mail.gmail.com>
Message-ID: <CAMuHMdV-Lw3Ay94_gYHU4A8iYSRbXy8b7XOiMQ93Mbs+-ApsGQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] watchdog: rzg2l_wdt: Make the driver depend on PM
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

On Wed, Feb 7, 2024 at 2:08=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=3Dy (e.g. the
> clocks are enabled though pm_runtime_* specific APIs). To avoid building
> a driver that doesn't work make explicit the dependency on CONFIG_PM. Alo=
ng
> with it the dependency on CONFIG_PM and CONFIG_COMPILE_TEST was moved to =
a
> new line to have the code simpler.
>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v5:
> - updated patch description
> - added on a new line the dependency on PM and COMPILE_TEST

Thanks for the update!

> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -910,7 +910,8 @@ config RENESAS_RZN1WDT
>
>  config RENESAS_RZG2LWDT
>         tristate "Renesas RZ/G2L WDT Watchdog"
> -       depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
> +       depends on ARCH_RZG2L || ARCH_R9A09G011

Please drop this change (i.e. retain the "|| COMPILE_TEST"), as it prevents
compile-testing on any platforms but RZ/G2L(alike) and RZ/V2M.

> +       depends on PM || COMPILE_TEST
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

