Return-Path: <linux-kernel+bounces-103559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C8C87C115
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7ED1F233AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A555A7429F;
	Thu, 14 Mar 2024 16:16:21 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27073520;
	Thu, 14 Mar 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432981; cv=none; b=jis6cWpEEgzOBLsNVZfMSI78vob17Rq/EEOFGO+OhUPHPB2ic6P414N31CxuDq4iaCFGP2+CZ8kwophvT5sotDR12bjNaNXJDozdXwCM56DoY1rXj84G9Hs289W/Qg6UTd8UfGayTqhJjGvx8rSBi/S5Hniba1OPjwOPsXTzqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432981; c=relaxed/simple;
	bh=KO5o8QznOOjPNp8jQSbFM7vBgxIXlAg3wTJmFiPXF4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kc+sr3YHIozlgV3Y8l8FsYwD6oaPT4QllN9kgz2WKE9UoxvoAaB7JwSROYRxN/zRWCi2FetnZZxHMtCxWNkpi3yfhsiwoITn9XuyzxRjrBTusYnhn2IkIZG/6o4EVCOEore6Pda6CKox+CQbf2Bac7PK9GTm9zHg+4mPg5/L6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a0599f631so10452357b3.2;
        Thu, 14 Mar 2024 09:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432976; x=1711037776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OigFCA6TWncj1dITIB+Ew0q0iS/FSFUD6r9Xvtt/yu4=;
        b=Pcz00d3z6J9QBVjtQBsQEJxFOb3wWeyjTO0QSYSg88o8yJreiKt/exPaJ71sqQgouW
         9er3tNSYImz80MysaoPvU+/gJ2m/QB+0RQQjWNRAKFrXvVKEtyFQTTIAAk9qbKesP4h9
         NxwqMbs/n3bp/jIv8pe/nmsZgUNmtSwNi2PClJmonQzKswQy9yNRh9ZjGuoILkPHjfYg
         ylfGbMYGdsh+aWqUFGlL7n4C9ZeXu5saL1KmCwHpl/ScELf6/GC5o0M5+ONy8z9R0cdd
         AZhMNh6cw7dANraFva+lE9Ymb3lkh3tEf2QaqbcuDYUHuznMiYlRfIV47efpgBpFy6H8
         BhgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc4/jRsrqKNi6R+OEIa/VCEPKIg6G+ewNqFbUsFRF3pt4GNlt4/+9ndnKTlN0yK9J9SV67drxufgDlu0zrzfv1iq84XCZnlVifzL7nGuYn4C7pSB0pIOj53XMHR4zED5M4fMoYSu6d
X-Gm-Message-State: AOJu0YyWtXFhRHmVUCsjPj7Sy1ZIxGxo/z3+JdJGxPnNx8RjExfVdU1o
	9oxO0f2tROAbZj8w08o5V6PxGGeEODdYifmPyOn1E0aMvh+uTvmVC4l/fCuAY0w=
X-Google-Smtp-Source: AGHT+IGYGhBpprP5uB9x66hWbZHdCv+HfaJjqtxgY381+Xy8kkNoiqekFKWdMEVrQysx4gCvX0t+5A==
X-Received: by 2002:a0d:fb47:0:b0:609:6bfc:eb8f with SMTP id l68-20020a0dfb47000000b006096bfceb8fmr1939523ywf.48.1710432976627;
        Thu, 14 Mar 2024 09:16:16 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id s17-20020a819f11000000b005fff0d150adsm319761ywn.122.2024.03.14.09.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 09:16:15 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a0599f631so10451727b3.2;
        Thu, 14 Mar 2024 09:16:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSVNK9t50OkfW8riJu4xi5kpkQtHJG+sfthBxQjiSuDzs8L0M7wsehOP7bdKGH9NnyEsEqd+l3clDsDryhtHG0mIYQI6S0P1hzxQIBilahAOs3QnLqs5T6gG4mIwPdhyAAmXh2BwK5
X-Received: by 2002:a81:bf4a:0:b0:60a:66d3:c021 with SMTP id
 s10-20020a81bf4a000000b0060a66d3c021mr2336021ywk.22.1710432974719; Thu, 14
 Mar 2024 09:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <898aa0925a9598d44721d00145015b215434cb3b.1710414195.git.geert@linux-m68k.org>
 <695ebdde-3dc3-41b1-b20b-f02c4ba1ae5d@sifive.com> <CAMuHMdURtL1u-MDXBhiwOfX+zBnuunZYvjt+3GMOp6Y6pj1Efw@mail.gmail.com>
 <42c3d591-abe5-4343-9a94-f1705430dcea@sifive.com>
In-Reply-To: <42c3d591-abe5-4343-9a94-f1705430dcea@sifive.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 17:16:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWLuK=SvwW-MvmCc4hhPTChDzU6q6SPCFTzjGFe8oijig@mail.gmail.com>
Message-ID: <CAMuHMdWLuK=SvwW-MvmCc4hhPTChDzU6q6SPCFTzjGFe8oijig@mail.gmail.com>
Subject: Re: [PATCH] clk: starfive: jh7100: Use provided clocks instead of
 hardcoded names
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Thu, Mar 14, 2024 at 3:56=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
> On 2024-03-14 9:48 AM, Geert Uytterhoeven wrote:
> > On Thu, Mar 14, 2024 at 3:32=E2=80=AFPM Samuel Holland
> > <samuel.holland@sifive.com> wrote:
> >> On 2024-03-14 6:05 AM, Geert Uytterhoeven wrote:
> >>> The Starfive JH7100 clock driver does not use the DT "clocks" propert=
y
> >>> to find its external input clocks, but instead relies on the names of
> >>> the actual external clock providers.  This is fragile, and caused
> >>> breakage when sanitizing clock names in DT.
> >>>
> >>> Fix this by obtaining the external input clocks through the DT "clock=
s"
> >>> property, and using their clk_hw objects or corresponding name.
> >>>
> >>> Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in no=
de names")
> >>> Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator d=
river")
> >>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> >>> --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> >>> +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> >
> >>> @@ -298,13 +311,23 @@ static int __init clk_starfive_jh7100_probe(str=
uct platform_device *pdev)
> >>>       if (IS_ERR(priv->base))
> >>>               return PTR_ERR(priv->base);
> >>>
> >>> +     for (idx =3D 0; idx < EXT_NUM_CLKS; idx++) {
> >>> +             clk =3D devm_clk_get(&pdev->dev, jh7100_ext_clk[idx]);
> >>> +             if (IS_ERR(clk))
> >>> +                     return PTR_ERR(clk);
> >>> +
> >>> +             priv->ext[idx] =3D __clk_get_hw(clk);
> >>> +     }
> >>> +
> >>> +     osc_sys =3D clk_hw_get_name(priv->ext[EXT_CLK_OSC_SYS]);
> >>> +
> >>>       priv->pll[0] =3D devm_clk_hw_register_fixed_factor(priv->dev, "=
pll0_out",
> >>> -                                                      "osc_sys", 0, =
40, 1);
> >>> +                                                      osc_sys, 0, 40=
, 1);
> >>>       if (IS_ERR(priv->pll[0]))
> >>>               return PTR_ERR(priv->pll[0]);
> >>>
> >>>       priv->pll[1] =3D devm_clk_hw_register_fixed_factor(priv->dev, "=
pll1_out",
> >>> -                                                      "osc_sys", 0, =
64, 1);
> >>> +                                                      osc_sys, 0, 64=
, 1);
> >>
> >> These should use devm_clk_hw_register_fixed_factor_parent_hw(). (Or yo=
u could
> >
> > Thanks, I didn't know about that function!
> >
> >> define a devm_clk_hw_register_fixed_factor_fw_name() and drop the othe=
r changes.)
> >
> > Sorry, I don't understand what you mean here?
>
> In the loop below, the parents are already referenced via .fw_name. That =
means
> the string is the DT clock-names property value, not the Linux-internal c=
lock
> name (see clk_core_get()). These two function calls are the only ones tha=
t
> depend on the internal clock name. If you change them to use .fw_name as =
well,
> the clk_core_get() will do the right thing, and you don't need to manuall=
y call
> devm_clk_get().

Thank you, I wasn't aware these fw_name names were actually doing the
right thing ;-)

Still, looking up by name is more expensive than just using the passed
clk_hw.  As there are multiple occurrences of the four external
clocks in the clocks table, thus involving multiple look-ups, I think
it's better to use clk_hw everywhere.

I will update for v2...

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

