Return-Path: <linux-kernel+bounces-47818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F96584534A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B015290B71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3103215AADA;
	Thu,  1 Feb 2024 08:59:48 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C32E842;
	Thu,  1 Feb 2024 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777987; cv=none; b=Q8g43EUUrvCoIFUklo9fRRDpjFVJRkHuW8ZOnFuyHyLpSyA3uwbvC7Fz7MPlenCnZcGEnWtU7xDzWcsfiqQpnjWn2El5CJH5ASM+ZfEQj8QP8iJlp9KoH2o0HtPab7KnSJkeRyxdu3ZHl3pvMky4qaaM8OHQjEy0uzF7XpCaRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777987; c=relaxed/simple;
	bh=cz+ZxF4ZLMWMOXHZbP+Q6gNIPJ5FSkhc6BSGiGPre80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoQ75VsuSi+oszJ4PW8KkFdYZIqRYyYsPgaRLJpl/KBoW9GfjzH+wnqLHLsz9yW9TxmmV9servME4LCvvog/RU4TwV3iEseOfNlweg8vLpQied2ghnq4RrpGbr+JEeXVhJSETuaR4SKCE5urgyCbgXn9PtIVI2Y+NgVCpVq0g6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so424596b6e.3;
        Thu, 01 Feb 2024 00:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777985; x=1707382785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyEcbfKn8U3DiB08RndpiaZJ0MtFXrv7NNpiWI97AjE=;
        b=Upl2DT/qkZJdm9JK/VssnuxpBmeQI1UGkI2LxYQebTOdHij7fzIWSKbu9ceYCiXnzs
         +WfmQu4lpwJ+IGkqIt8Y7iT0sh/iimy+E1wE1a0cSOnPeBQv+PCQ38t7nzFWjamqFCQe
         yYfx03eIa18za+bKqIxHKnRPxGNMVgCdGDqopUeEz4kXEBGKLDfSxmWtYAXoFdVeNliy
         QwVZ8EgnSGB5ytZMYNaqa3Gpc9UlXpnrLTbFYktyNPpGwIPfGjVEsCd7hf2WjjzlP6+v
         w/uqtcmxeZ/b7EmXrXvnbpcXxqhaXHk33JyR2+Cijup9+WPflXIDdHi50EKiZ0+C5bxg
         37Gw==
X-Gm-Message-State: AOJu0YytmvlcQDK0XfS/io7tMo13nYX0rtGDiSbKi5jLK6v83zCA1p/a
	u2LN6btANfxfw+/Ivnmasr+H76KmOmtx9pDy0oBFITMBiQK6i1CuZL/9Q34h6Cg=
X-Google-Smtp-Source: AGHT+IGURgSlmxBy4kvQ4Wb2moMldlaTNU+ixAAwSFxnjlYEzNc/9/SWxrPBF04ficfysIgI3UfapA==
X-Received: by 2002:a05:6808:2288:b0:3be:cd14:ed28 with SMTP id bo8-20020a056808228800b003becd14ed28mr3665828oib.27.1706777984720;
        Thu, 01 Feb 2024 00:59:44 -0800 (PST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id g11-20020aa79f0b000000b006dbce4a2136sm11679586pfr.142.2024.02.01.00.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:59:44 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6de28744a46so469149b3a.3;
        Thu, 01 Feb 2024 00:59:44 -0800 (PST)
X-Received: by 2002:a25:690e:0:b0:dbe:ace5:c058 with SMTP id
 e14-20020a25690e000000b00dbeace5c058mr4137258ybc.0.1706777544928; Thu, 01 Feb
 2024 00:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131102017.1841495-1-claudiu.beznea.uj@bp.renesas.com> <20240131102017.1841495-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240131102017.1841495-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2024 09:52:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUT3XFz2a+iWxrT2p_fbe+QCoXuhYprcWY9v4e5KA5q2w@mail.gmail.com>
Message-ID: <CAMuHMdUT3XFz2a+iWxrT2p_fbe+QCoXuhYprcWY9v4e5KA5q2w@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] watchdog: rzg2l_wdt: Select PM
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 1, 2024 at 2:30=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The rzg2l_wdt watchdog driver cannot work w/o CONFIG_PM=3Dy (e.g. the
> clocks are enabled though pm_runtime_* specific APIs). To avoid building
> a driver that don't work select CONFIG_PM.
>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -912,6 +912,7 @@ config RENESAS_RZG2LWDT
>         tristate "Renesas RZ/G2L WDT Watchdog"
>         depends on ARCH_RENESAS || COMPILE_TEST
>         select WATCHDOG_CORE
> +       select PM

depends on PM

The availability of PM is architecture/platform-specific, hence it
must not be selected by individual drivers.

>         help
>           This driver adds watchdog support for the integrated watchdogs =
in the
>           Renesas RZ/G2L SoCs. These watchdogs can be used to reset a sys=
tem.

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

