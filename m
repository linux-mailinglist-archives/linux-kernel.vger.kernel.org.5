Return-Path: <linux-kernel+bounces-103435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C3487BF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63427284721
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F8A71724;
	Thu, 14 Mar 2024 14:49:03 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5EE70CDD;
	Thu, 14 Mar 2024 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427743; cv=none; b=fMpQ+GLiYMVyZYQDa385XEHatN5QwL2dA/eoat9znqURP2UDQ8Ldte6xkaq2pBHTXd7YpaYudu4HJx37KDh7zaJOmAXx48mG0Lxkm9tJDAJJureM0Y3fcGZgakCmEihuXsMkz2/zw42KXJmtIavGw0ZKQjWcCJFS7+q2+J+fS/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427743; c=relaxed/simple;
	bh=6WXFdSpLCkzhqMCLiJR5o0+M79KfafrJFU0u2/j8214=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igmDP1TWKfJqVVUvP25yZvKOCHz8MxKkcHlzcuXFRGe5ipOIzl/SCB7oZ9uRlqIZYQ2y38DUMa9D/tuS0NTDcufbn9kzDgNMp2tWDFlnnZp/u2pVYC/CGsmvyv31TxtD+bhxuH6ytaFny6PHMe/kgS6vna0fQES4tZWHh7a/QC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609ff069a40so12653477b3.1;
        Thu, 14 Mar 2024 07:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710427738; x=1711032538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfL43D4as6bErODgBtnY/OPyEfChPT4gl+JbqwWRys4=;
        b=fCjKPkpQbFjh3ZBGlYsa03TAUFdPJntblVXQG/rFJbIu5ojddYgw7VCo0vi9OI+jon
         T0kkL7iboHrBXVttnYGEQcyzvpyVoOVuy8m8SVRciwygQiQLW73SPCWYYuk/NdrXCu7s
         ntWOvrHnv+rwGU+3GXwG90YHMWZUThrkReixfSbr/r7HoPM2ziZyXvzb83KEf14IO76i
         cWlMNqAHXWRRy9FGWKCKnROSydLiO29ZHn85Uvs4fEIxRzF/RM+DpJtWhZYvPyDUuOEW
         LuMXs99rkTBDVQ2K5kGs5lEfW30oCz4MIIeWz5x58e1Ep6wwK60t4UrXBAnFCc67BN6d
         VQAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwZLlFDaJL8ylKzUq1vopkXt7SJWQ8E6fzjtVYtDoiQqodeSVFcL7dTxmwzhhx6MRUoWdbbQLCstv7xtxhwa2Wevo8HRXwuUb4+mKPMYHfdGRZTcq0QK8an6wC6UQ4oDFqZOrZ4bjT
X-Gm-Message-State: AOJu0YwDvgy7DuvdS01eKlgzgySz43F4mhPJXBYIwG+xpZDibakfEPIT
	y2LxUYkFyhSkIqQzXorCB3+U79rd1ohGimAEeJQq+XaNnxMPZxnPIS4X4iC6QX0=
X-Google-Smtp-Source: AGHT+IGEx9dQ/CjBGNgySuOqxyVh5263+Fd5OAW6AgTS3CcjYzH84dWPVx1gqwjCThWcMM/vuHAlPQ==
X-Received: by 2002:a0d:e946:0:b0:60c:c941:2aee with SMTP id s67-20020a0de946000000b0060cc9412aeemr1103411ywe.11.1710427738066;
        Thu, 14 Mar 2024 07:48:58 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id n24-20020a81af18000000b0060a1f3267e2sm304151ywh.42.2024.03.14.07.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:48:57 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc71031680so899539276.2;
        Thu, 14 Mar 2024 07:48:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLIWFSzdC2sP4gsAGESJOK/0e9Wh2oUJlmYQ5zy7czjRQ0XiHbivyaqIEAvo/zETS8LPD6/eRpBMn/D+SadzSJSfuHN8tlPrkLZhPi8tgPzg1JI1FfS2aE3koKD1NiZdSgTvuoTQEe
X-Received: by 2002:a5b:912:0:b0:dc6:d093:8622 with SMTP id
 a18-20020a5b0912000000b00dc6d0938622mr1759963ybq.15.1710427736622; Thu, 14
 Mar 2024 07:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <898aa0925a9598d44721d00145015b215434cb3b.1710414195.git.geert@linux-m68k.org>
 <695ebdde-3dc3-41b1-b20b-f02c4ba1ae5d@sifive.com>
In-Reply-To: <695ebdde-3dc3-41b1-b20b-f02c4ba1ae5d@sifive.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 15:48:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdURtL1u-MDXBhiwOfX+zBnuunZYvjt+3GMOp6Y6pj1Efw@mail.gmail.com>
Message-ID: <CAMuHMdURtL1u-MDXBhiwOfX+zBnuunZYvjt+3GMOp6Y6pj1Efw@mail.gmail.com>
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

On Thu, Mar 14, 2024 at 3:32=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
> On 2024-03-14 6:05 AM, Geert Uytterhoeven wrote:
> > The Starfive JH7100 clock driver does not use the DT "clocks" property
> > to find its external input clocks, but instead relies on the names of
> > the actual external clock providers.  This is fragile, and caused
> > breakage when sanitizing clock names in DT.
> >
> > Fix this by obtaining the external input clocks through the DT "clocks"
> > property, and using their clk_hw objects or corresponding name.
> >
> > Fixes: f03606470886 ("riscv: dts: starfive: replace underscores in node=
 names")
> > Fixes: 4210be668a09ee20 ("clk: starfive: Add JH7100 clock generator dri=
ver")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> > +++ b/drivers/clk/starfive/clk-starfive-jh7100.c

> > @@ -298,13 +311,23 @@ static int __init clk_starfive_jh7100_probe(struc=
t platform_device *pdev)
> >       if (IS_ERR(priv->base))
> >               return PTR_ERR(priv->base);
> >
> > +     for (idx =3D 0; idx < EXT_NUM_CLKS; idx++) {
> > +             clk =3D devm_clk_get(&pdev->dev, jh7100_ext_clk[idx]);
> > +             if (IS_ERR(clk))
> > +                     return PTR_ERR(clk);
> > +
> > +             priv->ext[idx] =3D __clk_get_hw(clk);
> > +     }
> > +
> > +     osc_sys =3D clk_hw_get_name(priv->ext[EXT_CLK_OSC_SYS]);
> > +
> >       priv->pll[0] =3D devm_clk_hw_register_fixed_factor(priv->dev, "pl=
l0_out",
> > -                                                      "osc_sys", 0, 40=
, 1);
> > +                                                      osc_sys, 0, 40, =
1);
> >       if (IS_ERR(priv->pll[0]))
> >               return PTR_ERR(priv->pll[0]);
> >
> >       priv->pll[1] =3D devm_clk_hw_register_fixed_factor(priv->dev, "pl=
l1_out",
> > -                                                      "osc_sys", 0, 64=
, 1);
> > +                                                      osc_sys, 0, 64, =
1);
>
> These should use devm_clk_hw_register_fixed_factor_parent_hw(). (Or you c=
ould

Thanks, I didn't know about that function!

> define a devm_clk_hw_register_fixed_factor_fw_name() and drop the other c=
hanges.)

Sorry, I don't understand what you mean here?

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

