Return-Path: <linux-kernel+bounces-17669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357238250FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A1B283A30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D316249E1;
	Fri,  5 Jan 2024 09:39:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C01241E7;
	Fri,  5 Jan 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5e74b4d5445so12278947b3.1;
        Fri, 05 Jan 2024 01:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704447549; x=1705052349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADivkWK4lWs4Zr5dQX009Mb26e7oIT3IDUBbQqeyIfg=;
        b=nOqYqhs43LlfFJuJRjiotdqHn8KAICw422qKN6oSoKWgKhONbh+foVK/RFLJ4oEGgq
         MkTtp8ZSHwsV6xghu7u9xCAXaJ1Gc2RaQxlk/wingY27DbHdepsB/+e0WPxYxs9CDHco
         hvJmO5N1TXWrn3VtGCpsQZMSfZ5lO4UmnWt1mPRHHVLXM/JpFGee5iuXKH+76g0JfYEp
         dDTKsH6BpnqQTTfK3wxgD75SGMCv51eY718WbqzyqliX1Yk3St49L5mp54QQIYSemERd
         Mjpvl5vytf3OlvXLyCFr+CN1au8+k//MYFLdEpagwTgX8TLhCpZKyfBWSnksliCyT5rY
         ycNw==
X-Gm-Message-State: AOJu0YzRxQ/+pVcqCU3/uv3gwONcaRIwT763vbeb0ImGwi6VglTkbw4M
	voE5o52YAVrkl4Eqo5PBxH/QIIUH6cT0DA==
X-Google-Smtp-Source: AGHT+IFYXVbQLCou/QnjuW46WFagGdZwGM0eKmpsLBARP4ZrUW0XtveIfHs6X2UfdHTH+a/Aasv4yA==
X-Received: by 2002:a81:8701:0:b0:5f0:b992:d5f8 with SMTP id x1-20020a818701000000b005f0b992d5f8mr1946479ywf.64.1704447548942;
        Fri, 05 Jan 2024 01:39:08 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id s62-20020a818241000000b005f48f4e0d4bsm509457ywf.64.2024.01.05.01.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 01:39:08 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5e734d6cbe4so12338917b3.3;
        Fri, 05 Jan 2024 01:39:08 -0800 (PST)
X-Received: by 2002:a0d:f4c1:0:b0:5e8:f2e7:c48a with SMTP id
 d184-20020a0df4c1000000b005e8f2e7c48amr1763943ywf.98.1704447548262; Fri, 05
 Jan 2024 01:39:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com> <20240105082339.1468817-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240105082339.1468817-4-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jan 2024 10:38:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWTE=AUEd5iqd4Qm04sgFcGtHkbYEQJH9A=qPWph=S4+g@mail.gmail.com>
Message-ID: <CAMuHMdWTE=AUEd5iqd4Qm04sgFcGtHkbYEQJH9A=qPWph=S4+g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/19] net: ravb: Make reset controller
 support mandatory
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com, 
	wsa+renesas@sang-engineering.com, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	geert+renesas@glider.be, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Fri, Jan 5, 2024 at 9:24=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On the RZ/G3S SoC the reset controller is mandatory for the IP to work.
> The device tree binding documentation for the ravb driver specifies that
> the resets are mandatory. Based on this, make the resets mandatory also i=
n
> driver for all ravb devices.
>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2645,7 +2645,7 @@ static int ravb_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       rstc =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NU=
LL);
> +       rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
>         if (IS_ERR(rstc))
>                 return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
>                                      "failed to get cpg reset\n");

Upon second look, you also have to make config RAVB select
RESET_CONTROLLER.
Currently, you can build an R-Car Gen[234] kernel with RESET_CONTROLLER
disabled, causing devm_reset_control_get_exclusive() to fail
unconditionally.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

