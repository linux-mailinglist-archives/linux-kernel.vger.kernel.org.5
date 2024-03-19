Return-Path: <linux-kernel+bounces-107252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C8987F9FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157622823D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCC255769;
	Tue, 19 Mar 2024 08:34:00 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF85D22339;
	Tue, 19 Mar 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710837240; cv=none; b=pxZXgVBxsIqWSiB2W02lkwI288s4qHCTyeJW77f4Vw7ChHdOV7K3f6GljFvxZ9XkW0cRk4QQ+QaZk1Husqn2oOiNc3ei5fLhmpm62JkiqquOdRejdpaZCzpbSFH6oL3j3W1OA7btq/7VeZBOq54YXMKAP29V5WP371tNS9hpGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710837240; c=relaxed/simple;
	bh=m65OXUp65tMZd6N1sROsb3jyEZ4SAmhWiSVAfNaYT20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2Q8ye+JeHGzMm40N6tGvQhn1IGwo5g3vHjzNnphreBEm8kTdU/yoIbud0nhBdzjzNiVYnzht3HBjGsGGe7nd7lNeepIjVl3uBMV7snjTlXeJrQ9H2dCEbl5nRi7NIJlaTUeqeXhgIromgnY3mKtot5BnZ3NQHp4ooTFc6C/rWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609fb19ae76so56117737b3.2;
        Tue, 19 Mar 2024 01:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710837236; x=1711442036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y82mzXv0d7bKbkRDs5LndGK+jDELmzgrUAM9QGGDkag=;
        b=ONNjKTxJ6ld4S1G11AzqgXsk+KRZpARvrp0EabLPpbuq99uFcsOtVxPKNObhLOU6nQ
         4GEWjHPfF+7HhjUvIWUuvP4e0OqmuOhK2Rhjbx3Ld04H5XYCTc98eugU2UiPty7+RXLd
         lzJL9xp+LeFbsNgbA8AnT2iorFewSQDlq3+MYOqtUP+FIxBz84vAZ4bKT72anQRKxpv1
         Ewc6VNa2OCzvtA8k4WJJ6Ik7UUV3+fvaqwNF015M6b1eWJ+gPu5mniizxgw/6dGcWYr4
         eNdQDHUOP+QXvX04WyleJMoBnDhQ+gdicRkdlNzldVpMvHnIQsCR8NWumj0LBIierdMu
         ZEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD0LdNsqlf8BdFHUpca8U02CNRTAgM892Nm9nVgDmf0kr1OGpXIVZFVVfa509IvbyWBFr3y4X6anrFTSPLN4FSMeC0D/g6VqdR8P81Ev7B28Uw2qs4t7GnzOwKhw4fQJ/0A5dE8e+KY2chAmLKZoXOXFXbm0AGEiUY4o2HdALmqjWj1IOVVdSQj55Q
X-Gm-Message-State: AOJu0YzxyK3zl/y1IGfPQm2kVyOLhns9Zarh3HPc3Afb3fI+nCZZtTwR
	lpZfX3k6lMVjgT7gkC1YE9ju4juiqV5wMdgqsy/aNgELNjNNTsn9wjIgi124Nd4=
X-Google-Smtp-Source: AGHT+IHzGPMho9LmP/n6xFE929T68mXTpKrVCPXtq7Mi/+gUfFycfiAX0pzdUusJH3ncMwkT+GP1wQ==
X-Received: by 2002:a0d:f184:0:b0:60a:b48:e467 with SMTP id a126-20020a0df184000000b0060a0b48e467mr12074963ywf.25.1710837236358;
        Tue, 19 Mar 2024 01:33:56 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id l5-20020a814005000000b0060784b3bba8sm2228468ywn.35.2024.03.19.01.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 01:33:55 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a068e26d8so60282647b3.3;
        Tue, 19 Mar 2024 01:33:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIPMV8Qggr+IRr9qqRFld6qLQW15lAEhaPk/ZpIvhAkG7qVU97ZBWrG/Mo1hg6hN5MR5e61mWpMjs/UzevEvrq6SK7zwB8iWhv1o93NQZdWCr4YWd6Ia4X7r+LE4u54De2M5Zi4sYNdSBggZ4YCE4Ec1GV2Vy+eAybz2jD4Zq7EJs01dHK5V+0ZCMz
X-Received: by 2002:a81:4f8a:0:b0:60a:a8d:b2e6 with SMTP id
 d132-20020a814f8a000000b0060a0a8db2e6mr11407277ywb.22.1710837235303; Tue, 19
 Mar 2024 01:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240318160731.33960-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240318160731.33960-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Mar 2024 09:33:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXz12n2ckm1Xk62PZcyGWokFyVv6ChVnV8jkY9VpCyQTA@mail.gmail.com>
Message-ID: <CAMuHMdXz12n2ckm1Xk62PZcyGWokFyVv6ChVnV8jkY9VpCyQTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource/drivers/renesas-ostm: Add OSTM support
 for RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
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

Hi Prabhakar,

Thanks for your patch!

On Mon, Mar 18, 2024 at 5:08=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> RZ/V2H(P) (R9A09G057) SoC has Generic Timer Module(a.k.a OSTM) which
> needs to deassert the reset line before accessing any registers just
> like the RZ/G2L SoC.
>
> Enable the entry point for RZ/V2H(P) SoC so that we can deassert
> the reset line in probe callback.

This is not really what is happening.
As OSTM on RZ/V2H has a reset specified, the early call to ostm_init()
through TIMER_OF_DECLARE() always fails with -EPROBE_DEFER, as resets
are not available that early in the boot process.  Hence the driver
needs to be reprobed later through the platform driver probe.

> While at it use IS_ENABLED() macro instead of open coding.

I don't see how the code was open-coding IS_ENABLED()?

>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> --- a/drivers/clocksource/renesas-ostm.c
> +++ b/drivers/clocksource/renesas-ostm.c
> @@ -224,7 +224,7 @@ static int __init ostm_init(struct device_node *np)
>
>  TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
>
> -#ifdef CONFIG_ARCH_RZG2L
> +#if IS_ENABLED(CONFIG_ARCH_RZG2L) || IS_ENABLED(CONFIG_ARCH_R9A09G057)

I think you want to use "defined()" instead of "IS_ENABLED()"?

>  static int __init ostm_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;

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

