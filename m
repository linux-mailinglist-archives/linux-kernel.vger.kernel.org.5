Return-Path: <linux-kernel+bounces-107297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D3687FAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1584B214E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7753D7CF26;
	Tue, 19 Mar 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeCHUa1p"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B6664CF6;
	Tue, 19 Mar 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840461; cv=none; b=sUsIMMD15wLHFtixbMKherILm6aVeZkkoPqJaTp1DZdfW1A0JG9Zd3TqLYj6yaZHVwqvQbKrOuagPJCC8QG7/zfQ97rkaOEJsqfjAriFbJUXyxsSsrlbvkf+VMlwWyreMJEtXhLd5wN6VIQMZXGZVpPqFM+3Ru/ipOUHaP1O6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840461; c=relaxed/simple;
	bh=pjS5J2LAFBWN/x50rbg6snjzZLt3GBdzg+UgDvYER8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Izn/ggrjXj1S3xKQadUVmIIKYSrkwcTn727aqK08OAthPpM3AMPkfGYsgiIubsZGQtvJ+sRKc8leHzDPG8VHePsn6awYD2pez98wLMN0LgQgfQ6iTVxYG1lhNAg76cEzg4J7hWUyvcOyBHUKJESGVySXKYQh4Ab8a1OU2dVTtHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeCHUa1p; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7e07aabfd87so734149241.0;
        Tue, 19 Mar 2024 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710840459; x=1711445259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDt/qzf3eqYn44q9JzgdESv117en7YhDsjNcNkx/NqM=;
        b=YeCHUa1pY81Af0xul1OBTDNwM7czkBvNrv63NrXjQqw9qwSTZH5QWjkeWMZlt0gwq1
         X17LzP4Gq1gFh06Z9CPiusR5yg2s+EQXqltamsoV8nwZja1YNwR+hBl9WTtFoaCy5xUu
         PDr3d746/VBKAoND6EQfbqiqYFgXwppjTkmG5NAaFb+2fK6MlE+JEgEBxGZbq8zbVsOY
         F8YMNlOyzrAqSa5avOsGdMff+AavjvyvyBveFFNg2yL6FM/r/jXKOe7lXZeMuGfP4nTm
         CEHXwAkOKoAUa0BQliH5xUNlce3AC03d6TVIKCiDb/1VNFhrzirmX/LeIR/5TnUFtQZO
         L94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840459; x=1711445259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDt/qzf3eqYn44q9JzgdESv117en7YhDsjNcNkx/NqM=;
        b=ivDvXs5bbrQYuhbwhg2xW10DP6WfnuKVmDS5HJua+4dk0/D3SuE8BqH7aIELAz5pgy
         d65BsoF+Hf6fwOJrY6cV2ZeCucO10Nwe2mvq1lHCzcZfWI1gAY/p+hS2ztMvtOW2CsdJ
         GfY2oFnFsgMJe749NRMlxJ4LB2khKAfPe6zRgW4eSlfj9Po4e4Ce1zoHGP6W4+eph9ZS
         0sya/SRytoTmpJ+IOXr3CuMZzrtME1uMEdaotISPHCc7LsolWUPTKETU7BP3gTpZOjXO
         5w3IpIydDkT23QAZyu9dCnYqTQIjfvrvFG6QuHY1hbsaLLsY7aLLlMEajo/3lswCvZSw
         TxEg==
X-Forwarded-Encrypted: i=1; AJvYcCXuaJag42AiADPysZaVMD8V7bqEB/8pbg+vGMtYLaGczA7PDiBneXqgCzFH/NF2EDqpyLv2NyOpeh+Bdn8DjeWngk87bQbglCf0+jVoHnfyjsWlv1H5igb5iwy7l0bIfSEOqUn6zKZ/BcMgsm0PcTxn96epMy3FW54327hOvLuxrY/ru3qadcCM+5do
X-Gm-Message-State: AOJu0YwCXvdVreqnGgDsMFAlugM9Q5BakH5yNNr3JgBYG4IIaU53Mdd7
	BQJAgv6m2Unw+hQZWSmY/CAUhuVZWN+j37Lon0SwuBVkTiaaKgocGEcZrZ33r6tcx4za1tgTjel
	Yt7HwQEvRz7+Bc+fKaTHsd6GGbP8=
X-Google-Smtp-Source: AGHT+IGD+wSVW4yUk/XT4NellCkxmQoM9ux+qcW+omLXB1d0DdhZUVdHvs3tc0FxDcyxozrCiv6Mt5CiXNzlk5vWSB8=
X-Received: by 2002:a05:6122:984:b0:4b9:e8bd:3b2 with SMTP id
 g4-20020a056122098400b004b9e8bd03b2mr1418800vkd.2.1710840458983; Tue, 19 Mar
 2024 02:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240318160731.33960-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXz12n2ckm1Xk62PZcyGWokFyVv6ChVnV8jkY9VpCyQTA@mail.gmail.com>
In-Reply-To: <CAMuHMdXz12n2ckm1Xk62PZcyGWokFyVv6ChVnV8jkY9VpCyQTA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 Mar 2024 09:26:14 +0000
Message-ID: <CA+V-a8ucEyNFSQQ+ZuiS6OdRk_wepPzVyFqXG8hgT6diFG=sXg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource/drivers/renesas-ostm: Add OSTM support
 for RZ/V2H(P) SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Brandt <chris.brandt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Tue, Mar 19, 2024 at 8:33=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Mon, Mar 18, 2024 at 5:08=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > RZ/V2H(P) (R9A09G057) SoC has Generic Timer Module(a.k.a OSTM) which
> > needs to deassert the reset line before accessing any registers just
> > like the RZ/G2L SoC.
> >
> > Enable the entry point for RZ/V2H(P) SoC so that we can deassert
> > the reset line in probe callback.
>
> This is not really what is happening.
> As OSTM on RZ/V2H has a reset specified, the early call to ostm_init()
> through TIMER_OF_DECLARE() always fails with -EPROBE_DEFER, as resets
> are not available that early in the boot process.  Hence the driver
> needs to be reprobed later through the platform driver probe.
>
Thank you for clarification. Ill update the commit description as above.

> > While at it use IS_ENABLED() macro instead of open coding.
>
> I don't see how the code was open-coding IS_ENABLED()?
>
Ahh..

> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> > --- a/drivers/clocksource/renesas-ostm.c
> > +++ b/drivers/clocksource/renesas-ostm.c
> > @@ -224,7 +224,7 @@ static int __init ostm_init(struct device_node *np)
> >
> >  TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
> >
> > -#ifdef CONFIG_ARCH_RZG2L
> > +#if IS_ENABLED(CONFIG_ARCH_RZG2L) || IS_ENABLED(CONFIG_ARCH_R9A09G057)
>
> I think you want to use "defined()" instead of "IS_ENABLED()"?
>
OK, I will use defined().

Cheers,
Prabhakar

> >  static int __init ostm_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev =3D &pdev->dev;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

