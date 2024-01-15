Return-Path: <linux-kernel+bounces-26072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB94282DAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49875281DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5DD17591;
	Mon, 15 Jan 2024 14:07:24 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96B17584;
	Mon, 15 Jan 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e86fc3f1e2so71379417b3.0;
        Mon, 15 Jan 2024 06:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705327642; x=1705932442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOou55N2EN6e58V59PT+366RWYrogOI3loiDbYwDF18=;
        b=KYrBhJH0dCPiq1ue1VjA49OL7f4LKkx489v4pScejeIf7wAf7N+TmCa/9sPbRD8f5q
         4G0U06QzA/NlnBGRz+bCw2lKHEjkBuOdyA1V2U8Eq1vc4roGh3qaiXU0cnWqhTeAtRxG
         7EjITJwiIYQPWFdZRMmBXe8HZGDU0EB31JThpJHOhCvGN9yuZ4Q1Jw5gTFK3vDxPe5MM
         2/Ih2Nt4S4pDY9ZGMN7weTEW3vycKdHBhwk88Ps64dRJiuBN0iPNxFcOYEqPA7v7mRjt
         qAgYBw86eWZPDkvBrsRO1rE6pWBDvKMM7uTuBwJIro8nlZWEOy3HI4XU75Nnu2WEFiOd
         JMOg==
X-Gm-Message-State: AOJu0YxyxaJb+JMsq6sxSgfxZQb6EAN1YKFOmn67Y+cfmMZDavjHL/ZR
	HyGRfyJ6L/8Olq5+hcdUtubxUZ3+Pj5VWQ==
X-Google-Smtp-Source: AGHT+IFK/yvxQHDdnHwF8dC3j0/M+snFXM6wzDcXP/cq3A4zdGU+i/TtFeLRpXwi4PTL0vLUmTCeeA==
X-Received: by 2002:a81:6d57:0:b0:5fb:700d:100d with SMTP id i84-20020a816d57000000b005fb700d100dmr4154131ywc.22.1705327642068;
        Mon, 15 Jan 2024 06:07:22 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id r68-20020a0dcf47000000b005f66a83db14sm3995048ywd.131.2024.01.15.06.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 06:07:21 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc202317415so681315276.0;
        Mon, 15 Jan 2024 06:07:21 -0800 (PST)
X-Received: by 2002:a25:268b:0:b0:dbf:11e:d0a5 with SMTP id
 m133-20020a25268b000000b00dbf011ed0a5mr2764196ybm.123.1705327641690; Mon, 15
 Jan 2024 06:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115130817.88456-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240115130817.88456-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240115130817.88456-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jan 2024 15:07:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXGBxFbjy+WZYzCq3ARB7HrKUAQpYmKea1bDmvny3myag@mail.gmail.com>
Message-ID: <CAMuHMdXGBxFbjy+WZYzCq3ARB7HrKUAQpYmKea1bDmvny3myag@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] riscv: dts: renesas: r9a07g043f: Update
 gpio-ranges property
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 2:08=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On RZ/Five we have additional pins compared to the RZ/G2UL SoC so update
> the gpio-ranges property in RZ/Five SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

My
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
on v3 is still valid.

> --- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> @@ -46,6 +46,10 @@ cpu0_intc: interrupt-controller {
>         };
>  };
>
> +&pinctrl {
> +       gpio-ranges =3D <&pinctrl 0 0 232>;
> +};
> +
>  &soc {
>         dma-noncoherent;
>         interrupt-parent =3D <&plic>;

I believe this has a hard dependency on the pinctrl driver changes, due to
the following check in in rzg2l_gpio_register():

    if (of_args.args[0] !=3D 0 || of_args.args[1] !=3D 0 ||
        of_args.args[2] !=3D pctrl->data->n_port_pins) {
            dev_err(pctrl->dev, "gpio-ranges does not match selected SOC\n"=
);
            return -EINVAL;
    }

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

