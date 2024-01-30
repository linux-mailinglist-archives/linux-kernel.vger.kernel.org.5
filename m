Return-Path: <linux-kernel+bounces-44506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A038422F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691F51F26493
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B046366B38;
	Tue, 30 Jan 2024 11:25:46 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42259B7C;
	Tue, 30 Jan 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613946; cv=none; b=t2Gavn4lGymPzlG5Vsueh/grMsD2rzP5qMkB8sChHoapQXw79VlYIa1SFuqJaC9k93H7SKqkLxq2KgtN18A8nIK1zt5jwwxbjaFyuerumKeSt7e3PJR4fyTXm+LTWsLsLn2O0MoVzxLKOH3pjXtDuHZr0nZomOaYrwqs54afmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613946; c=relaxed/simple;
	bh=lZFXC4siu4ARAFRn2/Hx/DBP/KEO5uNA29OSiJb3/f8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLeYfTq5v6+tWs70O5no5P1RWs3atd659XnybCmA1MfwivlMGTrt8om8II+Pkq6XLvSvX27cGHl1UqNvLR1F/j8exITTBRjn8XTopQ8+HjwTiZsMcPO5XFhzl7hFwTWA3Klvd89Kk10RGBTW9ZvYnStvD+qaS/3q7cjHkZe10mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3101047276.2;
        Tue, 30 Jan 2024 03:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613943; x=1707218743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRnlMJumtKu3HGeJaBtjZds244bkDv4Dl9koHy9aL+0=;
        b=l9nQ2JpPjbARhN4zL1R3pHFAA1CxxWwLbdXpw4pqf0ZpxTMhQJl8Erw5qI5Vh8RoGa
         +frVGD/+g5TR4L07PBqLpYDE0lKfmmMnl/OJkOFmZLOcuZSKOTJ6CF7VWAc4JBmjbNiD
         2joNFMFZ9ufjw3njyL38CPESEY81bwswk/RylBAGHNCPy+nLWdknJ2iMeWRsn3uh6obz
         bawYZGzRyfzwItbwG6wxx2P9HZVjdiCefA0ycU3UiqiWo2DVcNYsBgOBw3aGtucuG3Sz
         Szt8G59cmcJhnYUS9Mojzct2o9pWXLXpQOe4DcAacvLVmRwx4C7IeQaukjNMX0TX9oZV
         ytag==
X-Gm-Message-State: AOJu0YyNzh7YGYhCJSz/JASCp/dphAZBv4RdFhnsh7t2P/PKTVObKnRR
	TBGK58NvhxXuD6nTGgnufRJ6VxXI40Apz+PxkcX6ezRGAiWRl/AiyrBBldX1lmA=
X-Google-Smtp-Source: AGHT+IFPlkQJEWJGO12npwfx0+I92P18+pn/rh4GgyqcFB3Tczg+4kA0eKFC6ftqMnladRDM+XZHJw==
X-Received: by 2002:a25:260c:0:b0:dc2:4e05:4f87 with SMTP id m12-20020a25260c000000b00dc24e054f87mr4228780ybm.56.1706613943371;
        Tue, 30 Jan 2024 03:25:43 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id u129-20020a256087000000b00dc230f91674sm2918210ybb.26.2024.01.30.03.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:25:43 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc642cd955fso2886862276.0;
        Tue, 30 Jan 2024 03:25:43 -0800 (PST)
X-Received: by 2002:a25:203:0:b0:dc2:4d3e:acf6 with SMTP id
 3-20020a250203000000b00dc24d3eacf6mr3997077ybc.13.1706613943089; Tue, 30 Jan
 2024 03:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240129151618.90922-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240129151618.90922-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 12:25:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV=E5VDZn0QjiGQL73j135LiA1QNrYH-hCve1Yk0PqJ=A@mail.gmail.com>
Message-ID: <CAMuHMdV=E5VDZn0QjiGQL73j135LiA1QNrYH-hCve1Yk0PqJ=A@mail.gmail.com>
Subject: Re: [PATCH 3/5] riscv: dts: renesas: r9a07g043f: Add IRQC node to
 RZ/Five SoC DTSI
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Mon, Jan 29, 2024 at 4:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add the IRQC node to RZ/Five (R9A07G043F) SoC DTSI.

Thanks for your patch!

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> --- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> @@ -50,6 +50,82 @@ &soc {
>         dma-noncoherent;
>         interrupt-parent =3D <&plic>;
>
> +       irqc: interrupt-controller@110a0000 {
> +               compatible =3D "renesas,r9a07g043f-irqc",
> +                            "renesas,rzg2l-irqc";
> +               reg =3D <0 0x110a0000 0 0x20000>;
> +               #interrupt-cells =3D <2>;
> +               #address-cells =3D <0>;
> +               interrupt-controller;
> +               interrupts =3D <SOC_PERIPHERAL_IRQ(0) IRQ_TYPE_LEVEL_HIGH=
>,

As this is the RZ/Five-specific .dtsi file, and not the common base
dtsi, you could avoid using SOC_PERIPHERAL_IRQ() here.
I am not sure what is most readable...

The rest LGTM (pending interrupt names review comments).

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

