Return-Path: <linux-kernel+bounces-70965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA538859EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D2B22D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4A3241EA;
	Mon, 19 Feb 2024 08:49:11 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C10122619;
	Mon, 19 Feb 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332550; cv=none; b=AvfXxQL4Ug8oYfJ8ubxGcj389F8nz0m7tKcCGkMkuGzAAnkfLiLpxXmesqqk+dkvrFHBlkNzrRdAp7rcZhtf5S+Yh+Sm5TY5358KO6cKYv21YP2vfKOCCMicz92AUE7xpqxSqYMl5OkFfJE4W0yLB/lgRPSLvY1m9gMqd6+P7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332550; c=relaxed/simple;
	bh=RjDKfILXb40j2Cpnf4ME6MMUhFxxBWNmtqaomKkvvI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkBFarnLPYa41tVAYFt6TrazLrKa1w9WRSHmVTUnHdGYZHOWcB3gBHXykWJRMWD2khsGMrpDgbMWuL5SLU7NZy1amBiU+OGI6IFsITAAGvRV0w5qROqGlMZ2eYl4XVvskAcLIEVOPC64s+TZt3yOj2AKjMxtlyg+zWS6s9rB5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6084c93f80eso1385647b3.3;
        Mon, 19 Feb 2024 00:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708332546; x=1708937346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTdtRAbjyGCzCQegMpo3kd+/+HCaaACEQW/D0yb7/D4=;
        b=dUYu+2Pju5/hsFLt5GyTIScfOmrOBYBm8w1SnI7ySptCN5Dh04fyGjVOIluOI4TpQB
         xOuXPiWdKDIgQicsY1gqmC8Em00GipCzB3+vsy87SdNOjAO9YEtK0c6hxJnam7UHLhE5
         J27hXK2uMa9+reDmsFNLPbz/9BR/T878PyV7wpAha08ka/qeSX3wsf2e7aiX4B8xqEeX
         FbX88ZbauDr+jzaAS6nUv8T4APnqCFM/m7xYVdTun0nUX+xsYyN4xSMnDmQK28qjHtUg
         WCggGR5fgKsEBuPuepkRyJ3d1l7w/M9PU8DbeC1s2UXKpXvtllNnyDd5B035NBI8LU+j
         1yTg==
X-Forwarded-Encrypted: i=1; AJvYcCWbSv7QvWngRBz1Q/gUzS4xiHKHvwcuv5aNsWFUfQ/0yOYqhpRJ303hc0yVpSGPX616FAQgivXOCiN5jGdYGpD2PDQQDn0MWaTBjj1j+Ip7E5MF76ubuXuslNVePdqvQxg5mv7HN/XCpAy3t2wEv1oL4DijsgCog+hLNTcA48xGy5C1wbHqcwbIXJ9N9WP1Hpj356joQf3IY2IarTY+NnprjpWrR1ck
X-Gm-Message-State: AOJu0YwgzKskVqnjnneWVfGktwGXfgQuoUgPBz5Uamld29keBYSjEf+A
	/gElbjFrYxsPyuu6PBdbJmf6KIy7pOxNhaE+Jm//GI+PinSTQDrZxXOFT8Pe1zs=
X-Google-Smtp-Source: AGHT+IEXvfLNDRihTseLNe40xN7P42NeVedN7+2fShY9NhqErXAy11qGnpzHoZp0L6gUI3tRR1e5jg==
X-Received: by 2002:a0d:cb8d:0:b0:608:1cf8:bfc1 with SMTP id n135-20020a0dcb8d000000b006081cf8bfc1mr4033002ywd.41.1708332546312;
        Mon, 19 Feb 2024 00:49:06 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id b1-20020a0dd901000000b005ffa352a84fsm1532120ywe.21.2024.02.19.00.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:49:06 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-608245e549fso9515247b3.1;
        Mon, 19 Feb 2024 00:49:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfZracA1pCHPIVKpGKmWryvuLuLucaE0zDhEYAij9TvPNWSFxJaq/jJ0G1bzL48pe2jtPcDEs3UezWQuFCDNxTPTOhWrUoM3HChFDK+0O5RpJPbDqhGxTlPl3CTxCK9EpsXqwrGcQrI4Yu8FCeLaIEXt88Y/BR/GOX0u0oWZ+84hwW3oFJMO+Qw0ILvRE5k7Xmp5hqWY9IdIIMr+Pn3iKXkv8YB/jp
X-Received: by 2002:a05:690c:a16:b0:608:28a9:5cfb with SMTP id
 cg22-20020a05690c0a1600b0060828a95cfbmr2721260ywb.16.1708332545819; Mon, 19
 Feb 2024 00:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208124300.2740313-8-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWdJ9jN9-cko2zSoqSS0acbwYB77aBWvenJHMrFTXhdWg@mail.gmail.com> <4098873b-a7e7-4c88-9af2-01f3c76424ab@tuxon.dev>
In-Reply-To: <4098873b-a7e7-4c88-9af2-01f3c76424ab@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Feb 2024 09:48:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX0HDK2w1N-k_R9ud_CVotRgAd2CjOoHTsWkSE_Rb7zyQ@mail.gmail.com>
Message-ID: <CAMuHMdX0HDK2w1N-k_R9ud_CVotRgAd2CjOoHTsWkSE_Rb7zyQ@mail.gmail.com>
Subject: Re: [PATCH 07/17] clk: renesas: rzg2l: Extend power domain support
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Mon, Feb 19, 2024 at 9:24=E2=80=AFAM claudiu beznea <claudiu.beznea@tuxo=
n.dev> wrote:
> On 16.02.2024 16:08, Geert Uytterhoeven wrote:
> > On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.de=
v> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> RZ/{G2L, V2L, G3S}-based CPG versions have support for saving extra
> >> power when clocks are disabled by activating module standby. This is d=
one
> >> through MSTOP-specific registers that are part of CPG. Each individual
> >> module has one or more bits associated with one MSTOP register (see ta=
ble
> >> "Registers for Module Standby Mode" from HW manuals). Hardware manual
> >> associates modules' clocks with one or more MSTOP bits. There are 3 ma=
ppings
> >> available (identified by researching RZ/G2L, RZ/G3S, RZ/V2L HW manuals=
):
> >>
> >> case 1: N clocks mapped to N MSTOP bits (with N=3D{0, ..., X})
> >> case 2: N clocks mapped to 1 MSTOP bit  (with N=3D{0, ..., X})
> >> case 3: N clocks mapped to M MSTOP bits (with N=3D{0, ..., X}, M=3D{0,=
 ..., Y})
> >>
> >> Case 3 has been currently identified on RZ/V2L for the VCPL4 module.
> >>
> >> To cover all three cases, the individual platform drivers will provide=
 to
> >> clock driver MSTOP register offset and associated bits in this registe=
r
> >> as a bitmask and the clock driver will apply this bitmask to proper
> >> MSTOP register.
> >>
> >> Apart from MSTOP support, RZ/G3S can save more power by powering down =
the
> >> individual IPs (after MSTOP has been set) if proper bits in
> >> CPG_PWRDN_IP{1,2} registers are set.
> >>
> >> The MSTOP and IP power down support were implemented through power
> >> domains. Platform-specific clock drivers will register an array of
> >> type struct rzg2l_cpg_pm_domain_init_data, which will be used to
> >> instantiate properly the power domains.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- a/drivers/clk/renesas/rzg2l-cpg.c
> >> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> >> @@ -1559,9 +1556,34 @@ static bool rzg2l_cpg_is_pm_clk(struct rzg2l_cp=
g_priv *priv,
> >>         return true;
> >>  }
> [ ... ]
>
> >
> >> @@ -234,6 +246,54 @@ struct rzg2l_reset {
> >>  #define DEF_RST(_id, _off, _bit)       \
> >>         DEF_RST_MON(_id, _off, _bit, -1)
> >>
> >> +/**
> >> + * struct rzg2l_cpg_pm_domain_conf - PM domain configuration data str=
ucture
> >> + * @mstop: MSTOP configuration (MSB =3D register offset, LSB =3D bitm=
ask)
> >> + * @pwrdn: PWRDN configuration (MSB =3D register offset, LSB =3D regi=
ster bit)
> >> + */
> >> +struct rzg2l_cpg_pm_domain_conf {
> >> +       u32 mstop;
> >> +       u32 pwrdn;
> >
> > Why not
> >
> >     u16 mstop_off;
> >     u16 mstop_mask;
> >     u16 pwrdn_off;
> >     u16 pwrdn_mask;
> >
> > so you can drop the MSTOP*() and PWRDN*() macros below?
>
> I did it like this to align with the already existing approach for this
> kind of things available in this driver. I can do it as you proposed.

The other fields do not align nicely with byte or word boundaries.

I can see the value of the MSTOP(name, bitmask) and
PWRDN(name, bitmask) macros, but I'd rather get rid of the *_MASK()
and *_OFF() variants.

> For the rest of your comments on this patch: I agree and will adjust the
> patch in the next version.

Thanks!

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

