Return-Path: <linux-kernel+bounces-68713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B203F857ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DAB288557
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C75712D76A;
	Fri, 16 Feb 2024 14:10:23 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB612CDB9;
	Fri, 16 Feb 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092622; cv=none; b=A5rjyp7m0imIgejiybyyocoxLsGSFJkPHxygkFa/x+Je8wtxuo7jB0rv+YsoM6JPmR3KoI7+2RcdZ7WI1zovAGaNH4al6Mf5XLRoVenixrH9yys3kKj2TwHu73qhMNaPARUECWaUVJ/7WH9SL0Hxb8rDVZmBVuSK5hby/7FkKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092622; c=relaxed/simple;
	bh=K2z/qROCMRTrnmXFCa6xgAOJzGryLZm5B9XqgpmSsPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKqmoAF7vJU3Go2RadgtgOh6piMp0b6fVazqJt/AMkhxRwCyRkrJEV18hEQ/wef3CU1SDE2A3O169XS2tQq9XgdvhbndyEV6zdBA9Okc9Z8GiPGDDP97+Ol3HSwrOD58uqvNl20vZM7lYrwKJiTu6N2HAiQ+Qyy1mBhSeChjrak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2db19761fso916664a34.1;
        Fri, 16 Feb 2024 06:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092618; x=1708697418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hW9Q5Vje3u6JbOgMeYVD/UJCDJh5KQkLlQ9cs+fUFoQ=;
        b=t1L1BESoDnQeXfjHtklY0AwJWc7LVywv8M3yzuxIKz0W3zMgv9LiLyBVes9cF8+tEF
         hh++xLBsRt8hkSrFH0y0SUC5/hFUSuZLQ5sV3TTVO2dLVGX4avZchaSeJtP0YzSmcRrU
         xUhCJZEJeLczUHisvYIoGxzUvtZrqwRwmxeaLrRfgQ03d5xqPd8bu0Sv/+Bc8KxLxjdy
         II3zWVlFYf67Wxhsz7nmD0QzXSLKOTIBrXQo0A8IrqTWjmqej5eQZ6Bw51ehqT/QtyC6
         iRWBzRfPqoSvIzh/5Erbl/BDQPSZ3trPf2xCkwqyIHjeQP2x7Ij4YjunqJm+S6rjoLjc
         GILg==
X-Forwarded-Encrypted: i=1; AJvYcCWNUa7ueowEphthyclctun5GsgoCs3kED1Ixh/EZWYfx79esAOwzZ05xTzZzbwVvAGABCFgr8kuH4aCKgv26oDoHt82ZDbXY0q54s28PAq4OKazPvLiMoQ2Ra13DC50X+4XDBzRcsx/BfepGK4HCY1Dg+yGFVn0kfOYeerLzdaoy25s3nxQdLh5w30XLGhD+YsVRp0Gq5kyEbSSJ6X99BiGV1I1s15f
X-Gm-Message-State: AOJu0Yxjhi7BIw5nevi+OI/smWSTWpMjjQZvUhFMnmaQVLXx1IG+tlg7
	eYcXLBDodneRgBJgm1zGOHlchKknPMrxyGfMoTT4imaxbORvWkCYlLiGptw6ZNk=
X-Google-Smtp-Source: AGHT+IHI2M5iUik3q6EFRqD68IaXTy28KmsKtc4KB30U0XVkjsls29l/7YLb/C1suNXmPOLpChDqEg==
X-Received: by 2002:a05:6359:4581:b0:176:d552:c681 with SMTP id no1-20020a056359458100b00176d552c681mr5526674rwb.21.1708092617820;
        Fri, 16 Feb 2024 06:10:17 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id l123-20020a819481000000b00604ae9cb29bsm351329ywg.127.2024.02.16.06.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:10:17 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcc73148611so2282959276.3;
        Fri, 16 Feb 2024 06:10:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2Krh2TDFNxXm2AKbPRBfKPG0F7UI/FDfZyGmLcyarMX0beSLmYP5VIsxQFJCRIJMbzBW+H0LrtQUPZBHyIbyIXH6lIoKkb3EnvFs8rS1RDVlLlP52hIjWD7OtAsv0qU8bxmH+CcwpNHURlwuIF+ZEoC2pjzQTSQuXjCIQxRzF/a/3XMqz+JWoK5q+eVXh4PKA751PiVT5jn407R7vv+zsCRsx/4wB
X-Received: by 2002:a5b:ed0:0:b0:dbd:120e:f337 with SMTP id
 a16-20020a5b0ed0000000b00dbd120ef337mr4834256ybs.30.1708092616773; Fri, 16
 Feb 2024 06:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-11-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-11-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:10:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUn6j8aZ+7iahrovWC8oWLiijqH=+cUDjYwdL3tWiuhDg@mail.gmail.com>
Message-ID: <CAMuHMdUn6j8aZ+7iahrovWC8oWLiijqH=+cUDjYwdL3tWiuhDg@mail.gmail.com>
Subject: Re: [PATCH 10/17] clk: renesas: r9a08g045: Add support for power domains
To: Claudiu <claudiu.beznea@tuxon.dev>
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

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Instantiate power domains for the currently enabled IPs of R9A08G045 SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a08g045-cpg.c
> +++ b/drivers/clk/renesas/r9a08g045-cpg.c
> @@ -240,6 +240,28 @@ static const unsigned int r9a08g045_crit_mod_clks[] =
__initconst =3D {
>         MOD_CLK_BASE + R9A08G045_DMAC_ACLK,
>  };
>
> +static const struct rzg2l_cpg_pm_domain_init_data r9a08g045_pm_domains[]=
 =3D {
> +       DEF_PD("always-on",     R9A08G045_PD_ALWAYS_ON, 0, 0,
> +                               RZG2L_PD_F_PARENT | RZG2L_PD_F_ALWAYS_ON)=
,
> +       DEF_PD("gic",           R9A08G045_PD_GIC, MSTOP(ACPU, BIT(3)), PW=
RDN(IP1, 2),

My docs document only bit 0 of the CPG_BUS_ACPU_MSTOP register.

> +                               RZG2L_PD_F_ALWAYS_ON),
> +       DEF_PD("ia55",          R9A08G045_PD_IA55, MSTOP(PERI_CPU, BIT(13=
)), PWRDN(IP1, 3),
> +                               RZG2L_PD_F_ALWAYS_ON),
> +       DEF_PD("dmac",          R9A08G045_PD_DMAC, MSTOP(REG1, GENMASK(3,=
 0)), 0,
> +                               RZG2L_PD_F_ALWAYS_ON),
> +       DEF_PD("ddr",           R9A08G045_PD_DDR, MSTOP(PERI_DDR, BIT(1))=
, PWRDN(IP2, 0),

Only BIT(1)? My docs suggest GENMASK(1, 0).

> +                               RZG2L_PD_F_ALWAYS_ON),
> +       DEF_PD("tzcddr",        R9A08G045_PD_TZCDDR, MSTOP(TZCDDR, GENMAS=
K(2, 0)),
> +                               PWRDN(IP2, 1), RZG2L_PD_F_ALWAYS_ON),
> +       DEF_PD("otfde_ddr",     R9A08G045_PD_OTFDE_DDR, 0, PWRDN(IP2, 2),=
 RZG2L_PD_F_ALWAYS_ON),

MSTOP(PERI_CPU2, BIT(2))?

> +       DEF_PD("sdhi0",         R9A08G045_PD_SDHI0, MSTOP(PERI_COM, BIT(0=
)), PWRDN(IP1, 13), 0),
> +       DEF_PD("sdhi1",         R9A08G045_PD_SDHI1, MSTOP(PERI_COM, BIT(1=
)), PWRDN(IP1, 14), 0),
> +       DEF_PD("sdhi2",         R9A08G045_PD_SDHI2, MSTOP(PERI_COM, BIT(1=
1)), PWRDN(IP1, 15), 0),
> +       DEF_PD("eth0",          R9A08G045_PD_ETHER0, MSTOP(PERI_COM, BIT(=
2)), PWRDN(IP1, 11), 0),
> +       DEF_PD("eth1",          R9A08G045_PD_ETHER1, MSTOP(PERI_COM, BIT(=
3)), PWRDN(IP1, 12), 0),
> +       DEF_PD("scif0",         R9A08G045_PD_SCIF0, MSTOP(MCPU2, BIT(1)),=
 0, 0),
> +};
> +

The rest LGTM.

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

