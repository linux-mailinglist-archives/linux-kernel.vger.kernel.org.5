Return-Path: <linux-kernel+bounces-148683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F17D88A8624
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911DC1F211CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5A1420C6;
	Wed, 17 Apr 2024 14:38:31 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1413D53B;
	Wed, 17 Apr 2024 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364710; cv=none; b=nFqrbQqp5a7pI+IJ+G6hBpMAlv90cjYOzmsmE/j0XLncx8FB/cwI323hc2Whr4yBK0QhFG2RiKRTmcAw+mxFiAEGEzW9hyzwObjaD+wW/VjWeTH7vVgJ79uTHW0cnxd9t4ZyPPdVRyJ32uLbHomrtLPLcTLM1BM5UHtw/00f0mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364710; c=relaxed/simple;
	bh=jLb75MpAdcnVk2677o897/IAdy8Q6IZIxsTA8GELTZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3uzOSextaZn8FR2agPO8v2njro9OWwR8wMrwbwNfKTkfmOaeb5c6w09yN56aFNzj304SYTBptNRU4ifPkwAu/b34boM0dpgzPZOoruYgfVchGmBJ1xiliNXHuQy+5+1kjUCtaZwdPeYrQqUz0syMGHRZYcBJVu8sZkOOcXpi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so908478276.0;
        Wed, 17 Apr 2024 07:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364707; x=1713969507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9TnUioeKtNrYSjSpU0xUOKSjJt/djcW6aYlEJUt3U0=;
        b=lCCIRINDCQGMCi+jrXw80q2K3NhCXrOSFNe8tUw/qnDsLu3Yqq3YmdHlZrMw0uRFMo
         +mxYDUej5nFqDqjeFhpT675m2yj8MiRb+HAMt6uT/URcd549/y2WD58TIT4lNKzmRRqv
         rZ7qE/ixKO7A/Xup6oTf5lPIm9NkFgzGqSbp9HChnVLbNedoyEJRV+9wq46OUyk45z3J
         ea08Jbbl5hBOUUt90zkceLKlVnzqEunmVU6PzDNOcNr1uv6HiiIz3S42AXDW3+OaOOUR
         f92QAXEG1rMCwH4lx72NvW1TZj3kaFvtI9bwxzyVsvIp2SI0D6WnYFk5ERSG6fPvec8O
         TkWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGIn1eJs8ICQvYpX/9nkvFSoyOy9JBgrgUufGwPswrKvFGerNBAk1n2xLlo+stFZwiIATygxKrwtbSJQwniZrZHGElNbRbe2uZjgn6EqJGP50byDFONrMIKNsgvwnRNzfLYCN8AzS1cH7EQC1O22Q=
X-Gm-Message-State: AOJu0Yyp3dFCQUKdS/3tONP03Bls7Kt0DezTZ0MkETIuK20jxeEwGvP9
	eiCpPuoQSSCrRJOE9kFAqqNyEIdBNRvRegkXQfK5vVyBegFgh/2lpfFi7INOXeE=
X-Google-Smtp-Source: AGHT+IGHT9UShlSOglkOY+xkmt3lOVto1FfABvma14Fna1eK9o4tsU2SRVHptDGwsQ3mK48acGoijg==
X-Received: by 2002:a25:c749:0:b0:de1:5656:ba49 with SMTP id w70-20020a25c749000000b00de15656ba49mr4603380ybe.16.1713364707461;
        Wed, 17 Apr 2024 07:38:27 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id i9-20020a256d09000000b00dc6e5ea9152sm2994739ybc.29.2024.04.17.07.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:38:27 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61ab31d63edso8541217b3.1;
        Wed, 17 Apr 2024 07:38:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXp54gAA/EtlZ8jDB2Z8ngX3ZOO3jqeX6TF0eMyNCQLeUsDLjwolAz4YlmamwCnET4OX9Rq7OFVTr8Pj3s4i0rlqnthPk5uKltTMEo8irXvUPbC80XTgPY0fjkUoMQI11+uQtAnNVryJM9UCEHQgBU=
X-Received: by 2002:a81:c741:0:b0:618:a587:7a41 with SMTP id
 i1-20020a81c741000000b00618a5877a41mr4603735ywl.16.1713364706955; Wed, 17 Apr
 2024 07:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321114201.359381-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240321114201.359381-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Apr 2024 16:38:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvARk6i_aU6B7yPFfAGwaK5Yh=idYP9iuEAHoP9PvjOg@mail.gmail.com>
Message-ID: <CAMuHMdVvARk6i_aU6B7yPFfAGwaK5Yh=idYP9iuEAHoP9PvjOg@mail.gmail.com>
Subject: Re: [PATCH] reset: reset-rzg2l-usbphy-ctrl: Ensure reset line is
 asserted in error path
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Thu, Mar 21, 2024 at 12:43=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> In the event of failure during devm_reset_controller_register(), ensure
> that the reset line is asserted back.
>
> Fixes: bee08559701fb ("reset: renesas: Add RZ/G2L usbphy control driver")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> @@ -132,8 +132,10 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_d=
evice *pdev)
>         priv->rcdev.dev =3D dev;
>
>         error =3D devm_reset_controller_register(dev, &priv->rcdev);
> -       if (error)
> +       if (error) {
> +               reset_control_assert(priv->rstc);
>                 return error;
> +       }
>
>         spin_lock_init(&priv->lock);
>         dev_set_drvdata(dev, priv);

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Alternatively, you could register a cleanup handler with
devm_add_action_or_reset(), like many drivers already do.
Or better, turn devm_aspeed_peci_reset_control_deassert() into a
generic helper, and convert all drivers[1] to use that.

That would just leave us with undoing pm_runtime_enable(), which can
be automated using devm_pm_runtime_enable() instead.

[1] git grep -w devm.*reset_control_assert

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

