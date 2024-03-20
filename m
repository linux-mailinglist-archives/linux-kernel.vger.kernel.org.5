Return-Path: <linux-kernel+bounces-109010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2C1881352
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B096DB224E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608EF45BEA;
	Wed, 20 Mar 2024 14:28:53 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C72446DC;
	Wed, 20 Mar 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944932; cv=none; b=NUPDP1NeyHNq4wkSQQe1l1JdQq1ymHHscNoGh4OS+7j5X28qgFlWd6ufAY7xFS4/7Yllxi3BqIUHYnK9EDB3zL+86ogK9a7gsEciZBmNIV/5lghXHzAK4LipItlcXbPF07gIwjsu7uFI6ncxtQvlZleR0ahmplZyFAUTBoB3W1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944932; c=relaxed/simple;
	bh=n7Qf9UdJwRH34jQxS+mXGbofBAvO4f5PiVJjc4drzzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y835CaiaEcJ/fU9Rw0WC9nuOW15ZxH71Jpw0y5SKHz18OnDwCDEQW4sRulpzKUpZHIwXiM2p+px8ifhoZdP9fepIwDhdjmhulMr3gJAaiBw3MZlhprspU14ht1RmMTdmob8lvjaCIu8/SVFCguHJnkAyN/smOhmfe0vn8X4Ufk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609fd5fbe50so72347627b3.0;
        Wed, 20 Mar 2024 07:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710944929; x=1711549729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNEkSKkVWT+9MCxMbsjwWRjuZvzej3VkUeX2qsKaTBc=;
        b=m4upX/j9I2TqCoxkQR0RCORg4nZkJIaj3ulCYGAPhDMt27ho+1zHKhrfwJND0DrxqC
         PPleUx1Mznp3poZQkw5jc8GNBG7KCIcTBImj3JE6mnolmvwNr0dpfegmiqP1YydFMjk7
         x+YuLGzPiFoJ3ImFQOBo+lb4LUumMQSMqThNI1IEvT2OZ4Z38Z6YzenKtUa8PP+yJ+AX
         1vsU5eUhZjIkhAUGp4ovocoMUAlGQ4+G6EU7DP1VMgH4FXsIiOby3Wvi3eS2KzZcOMcm
         5k8cDEQ5rdXqbM/B6eIKmDDjWNnYJ+a0NJZUxCvPv2iHqHNFvBL5d3MOIBwKOSUG42ct
         JTkg==
X-Forwarded-Encrypted: i=1; AJvYcCUr8MWml2TeJ5l+3XaWXKljKShdOSVOu+FFAqBlJj6boPOZxQXI19AnRc6Ru4fXjVyM189FnrXMOwgx9mB6/sQ2+qERdPzlcB93Repn
X-Gm-Message-State: AOJu0Yyy4LxnMBIlpkiA7OuYiuMNMdFuyytoKMhJxR2h1wNn2DE5oed/
	s6wuLUrtDz5GlBd54e2aP3DQOyyWWuxD2e6bv5dtXtNyV9SjrLBXUSWzXKsc8os=
X-Google-Smtp-Source: AGHT+IGBoMuunogxDlBCgjjGKw1owtTZDPgXvtDu9gbH9iYN1tW7Kju/ve0x2fF5ctrUmh2nX5Ibcw==
X-Received: by 2002:a25:8392:0:b0:dc7:347e:c6f4 with SMTP id t18-20020a258392000000b00dc7347ec6f4mr15212897ybk.32.1710944929159;
        Wed, 20 Mar 2024 07:28:49 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id s10-20020a25830a000000b00dcdba3056e9sm2534961ybk.25.2024.03.20.07.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 07:28:48 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609eb3e5a56so73037587b3.1;
        Wed, 20 Mar 2024 07:28:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvh12kQfhWC3Si7/fUUtOhxYM7ruYESUFdFuhJkfeyLZSMMZz4Bx8s0a6tOtcTS2wJlC3VhM9Z2H5uq6kB8LakXJmXovWA+SYl18zM
X-Received: by 2002:a25:68c1:0:b0:dcd:2d3a:b528 with SMTP id
 d184-20020a2568c1000000b00dcd2d3ab528mr15753354ybc.9.1710944928665; Wed, 20
 Mar 2024 07:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <beb746c7538a4ff720a25fd8f309da20d8d854ef.1710933713.git.geert@linux-m68k.org>
 <47bddec7-953d-4ea4-84f1-b0dcf0641baa@sifive.com>
In-Reply-To: <47bddec7-953d-4ea4-84f1-b0dcf0641baa@sifive.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 15:28:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWP4R6Y6G0qzhMKJy1zJEeHE8a0XEK+Hs_D4wXB2i2BFA@mail.gmail.com>
Message-ID: <CAMuHMdWP4R6Y6G0qzhMKJy1zJEeHE8a0XEK+Hs_D4wXB2i2BFA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: starfive: jh7100: Use clk_hw for external input clocks
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>, 
	Hal Feng <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor.dooley@microchip.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Wed, Mar 20, 2024 at 2:31=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
> On 2024-03-20 6:24 AM, Geert Uytterhoeven wrote:
> > The Starfive JH7100 clock driver does not use the DT "clocks" property
> > to find the external main input clock, but instead relies on the name o=
f
> > the actual clock provider ("osc_sys").  This is fragile, and caused
> > breakage when sanitizing clock node names in DTS.
> >
> > Fix this by obtaining the external main input clock using
> > devm_clk_get(), and passing the returned clk_hw object to
> > devm_clk_hw_register_fixed_factor_parent_hw().
> >
> > While name-based look-up of the other external input clocks works as-is=
,
> > convert them to a similar clk_hw-based scheme to increase uniformity,
> > and to decrease the number of name-based look-ups.
> >
> > Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node=
 names")
> > Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator dri=
ver")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>


> > --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> > +++ b/drivers/clk/starfive/clk-starfive-jh7100.c

> > @@ -284,8 +293,11 @@ static struct clk_hw *jh7100_clk_get(struct of_pha=
ndle_args *clkspec, void *data
> >
> >  static int __init clk_starfive_jh7100_probe(struct platform_device *pd=
ev)
> >  {
> > +     static const char *jh7100_ext_clk[EXT_NUM_CLKS] =3D
> > +             { "osc_sys", "osc_aud", "gmac_rmii_ref", "gmac_gr_mii_rxc=
lk" };
>
> This should be __initconst. Otherwise:

With

    -       static const char *jh7100_ext_clk[EXT_NUM_CLKS] =3D
    +       static const char *jh7100_ext_clk[EXT_NUM_CLKS] __initconst =3D

I get:

    drivers/clk/starfive/clk-starfive-jh7100.c: In function
=E2=80=98clk_starfive_jh7100_probe=E2=80=99:
    drivers/clk/starfive/clk-starfive-jh7100.c:35:37: error:
=E2=80=98jh7100_clk_data=E2=80=99 causes a section type conflict with =E2=
=80=98jh7100_ext_clk=E2=80=99
       35 | static const struct jh71x0_clk_data jh7100_clk_data[]
__initconst =3D {
          |                                     ^~~~~~~~~~~~~~~
    drivers/clk/starfive/clk-starfive-jh7100.c:296:28: note:
=E2=80=98jh7100_ext_clk=E2=80=99 was declared here
      296 |         static const char *jh7100_ext_clk[EXT_NUM_CLKS]
__initconst =3D
          |                            ^~~~~~~~~~~~~~

which is a bit strange...
What am I missing?

> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>

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

