Return-Path: <linux-kernel+bounces-106399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C7887EDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D114C28393D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F9C56774;
	Mon, 18 Mar 2024 16:49:09 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCB5646A;
	Mon, 18 Mar 2024 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780549; cv=none; b=DLbwFmSpXoZCAiMdcbm8KqnHjHeG0WCqnkVEfpNAzdY+W4PqMIuGAhDw28FmkGGnakJN0kpu8KzVbh6OqgKq/IAx/EcDO8DZuVpPBFJYXawFrWfEBl80exKkRTP3F8N9/fYJagyXtPrDXWdabknD0FYeoQFzFoQuypc2KvNSqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780549; c=relaxed/simple;
	bh=9BLHtiOM2Y9S3eBqUD6Y6l0tWRCU28HpRShaWs4UV1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDjbalqWPSXMI+3j8xbjZtHuGI/Ix2pWPMPtjnSb+0CvktopCMVCQ2R7TPFhNCFGyC2PIP76ZTPp4JmZ7byPwcBgO4rXvPGq+0uxxqsnR1Aq87iHNNoncH6omAP+w5PUes/Iucs0w9U3Y71rnn+/YEvQyvDkCwUJitp603FHSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-609fb19ae76so48931247b3.2;
        Mon, 18 Mar 2024 09:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780545; x=1711385345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcxd8RIGuWD0U3DfwA0Q+JXL0ze4DLYKVsNL4T9NgQ0=;
        b=HQbZR02imzgB/DRBdF3CQX/iWkfFxrfx+d7aryPCJUuxcOQNWPcWqRPupC+HTHB6Wy
         r1jbSGRgBmH5H/AA4eJpPQXBuPaV+wVxvenVp/Bx5W3AmYsK/q0oe3LsJnXne4D/qvMT
         sNEJ5CdXJoyQ2Ctg8PggwUyiOvE2vXARHez7frOUDp6X0oEFvXD+aE7QIFwmAEvwlhJN
         QUc6wtYrYEOMew4jn9biBdJjbd00eH8V4HtnjmqcX4uisrkc/5EwNc5Al0aXjhslEcCF
         jDxdSs+25NcwSiF6EhfqLmNHQxn7E0cUoGB9mmTsGGP4L9ZMYVq2XAH+glAV5xn30gjm
         65hw==
X-Forwarded-Encrypted: i=1; AJvYcCXZQ682CzkVAT2hN2oL9ZfuZVECkH5idaV7cIcVrfhAUOYOAz+mGvGa5/52hT9jGTEXptI2y1uyLouw/s0oXXBzsEPJ6Kh057vL1f3MiRjvFbEEGte2UU0gPC8VbFhBbwupZSpSWqWLHBYUuIP0/qRkR0hb3uxStfKmTfeDCxRMWlNVfccLh8pNmgKNZVxpcUFOpv1In/L2uaq0VMGOAfjGfKFYrdMx
X-Gm-Message-State: AOJu0YyujttXw8EhawQ/l2jbJHcqO2PddDKHQjy3xZ+9yr2g3JuWtyps
	9mrH58Cp3/WaNIdXtdNeB65yWBq350XRqb/7ILXnG2iuyNcncve9RJKLENjGTnY=
X-Google-Smtp-Source: AGHT+IFgG+saLyFC5zOSIJGAOufrLKp7GhIg9yxq/uDcDGT9oWhN79rdzqdXvua7LysgjxQmeaZhYw==
X-Received: by 2002:a81:4849:0:b0:609:f87b:aad3 with SMTP id v70-20020a814849000000b00609f87baad3mr11100419ywa.31.1710780545000;
        Mon, 18 Mar 2024 09:49:05 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id b12-20020a0dd90c000000b0060a5795fde5sm2021194ywe.98.2024.03.18.09.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 09:49:03 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60a068e26d8so52487677b3.3;
        Mon, 18 Mar 2024 09:49:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVYlpclFdu9jmbE2SI3Mxd428aEv5L4q1I2MrHtfehsjsZOl0ew+U4+9kYWFE1hUgtufrFI+R1I5wEZwV7L/0qSdJxrkpNpmlw0wkXFrMNdC8EsKo18EqReiA7Zgh1osWoBmGBeP06iGzjiPkFCw6InmKQSWcgSLA4V98yHqMa8J3EBi7tNaiL3z/m3J46414JdFSchb8eoB/2VZjf4rfMa5Q2c333o
X-Received: by 2002:a0d:f3c4:0:b0:60a:38ef:82f9 with SMTP id
 c187-20020a0df3c4000000b0060a38ef82f9mr11889664ywf.37.1710780543176; Mon, 18
 Mar 2024 09:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com> <20240307140728.190184-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240307140728.190184-9-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 Mar 2024 17:48:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVdn9K1gKJAKyyDz8ObaJboknE_qqYfS_vyxNU+zhRWPA@mail.gmail.com>
Message-ID: <CAMuHMdVdn9K1gKJAKyyDz8ObaJboknE_qqYfS_vyxNU+zhRWPA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] clk: renesas: rzg2l-cpg: Add suspend/resume
 support for power domains
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Mar 7, 2024 at 3:07=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/G3S supports deep sleep states that it can reach with the help of the
> TF-A.
>
> RZ/G3S has a few power domains (e.g. GIC) that need to be always-on while
> Linux is running. These domains are initialized (and powered on) when
> clock driver is probed.
>
> As the TF-A takes control at the very last(suspend)/first(resume)
> phase of configuring the deep sleep state, it can do it's own settings on
> power domains.
>
> Thus, to restore the proper Linux state, add rzg2l_cpg_resume() which
> powers on the always-on domains and rzg2l_cpg_complete() which activates
> the power down mode for the IPs selected through CPG_PWRDN_IP{1, 2}.
>
> Along with it, added the suspend_check member to the RZ/G2L power domain
> data structure whose purpose is to checks if a domain can be powered off
> while the system is going to suspend. This is necessary for the serial
> console domain which needs to be powered on if no_console_suspend is
> available in bootargs.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - none; this patch is new

Thanks for your patch!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -1700,6 +1719,8 @@ static int __init rzg2l_cpg_pd_setup(struct rzg2l_c=
pg_pd *pd, bool always_on)
>         } else {
>                 pd->genpd.power_on =3D rzg2l_cpg_power_on;
>                 pd->genpd.power_off =3D rzg2l_cpg_power_off;
> +               if (flags & RZG2L_PD_F_CONSOLE)

I think this should be replaced by some dynamic check, cfr. my comments
on PATCH 9/10.

> +                       pd->suspend_check =3D rzg2l_pd_suspend_check_cons=
ole;
>                 governor =3D &simple_qos_governor;
>         }
>

> @@ -1890,9 +1911,43 @@ static int __init rzg2l_cpg_probe(struct platform_=
device *pdev)
>         if (error)
>                 return error;
>
> +       dev_set_drvdata(dev, priv);
> +
>         return 0;
>  }
>
> +static int rzg2l_cpg_resume(struct device *dev)
> +{
> +       struct rzg2l_cpg_priv *priv =3D dev_get_drvdata(dev);
> +       const struct rzg2l_cpg_info *info =3D priv->info;
> +
> +       /* Power on always ON domains. */
> +       for (unsigned int i =3D 0; i < info->num_pm_domains; i++) {
> +               if (info->pm_domains[i].flags & RZG2L_PD_F_ALWAYS_ON) {

If you would check "priv-domains[i].flags & GENPD_FLAG_ALWAYS_ON"
instead, I think you can make r9a08g045_pm_domains[] __initconst.
You may need to make a copy of the name for pd->genpd.name, though.

> +                       int ret =3D rzg2l_cpg_power_on(priv->domains[i]);

I assume you are sure none of these domains are enabled by TF/A after
system resume, or by the pmdomain core code?

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

