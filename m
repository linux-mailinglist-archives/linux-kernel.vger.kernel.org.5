Return-Path: <linux-kernel+bounces-44532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F9B842357
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA421C2495F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D406D1B5;
	Tue, 30 Jan 2024 11:38:16 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477E6A34D;
	Tue, 30 Jan 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614696; cv=none; b=uydxcr4y3XluQm8uDuh0vepnXyzSPm5gEFtiw7CuMmQy54emyusKtxOxCUixvc3F4f7HwK0MfgfHNQrWxi2Kbjzn2Is79y9ApWB0VenLWEaTc2Ys+j4Wq1B+nQV3bWORjjg71pooxuVfwlWA5p6+zsJ8yTEzZ8qnlC0zhnTNCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614696; c=relaxed/simple;
	bh=p8c/mHTXGGnT4oXtWTCZLHq7kKnl6GsnEVgDNwo1j3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMOp82Ic2cvGgpCQMdRN+yAUTEavgm//hRZ3qCnmZ9LgF0vZQVTXJlHmVGq1dpAZBLBfpNefnAtmv/UxAuNBIqP5qvX7q0KJnzB4+SNO7npchDhS0YywwkFRRacqLGovfTfpY+k8Mt5F4HagPA5mGEInif2muZUdTfL7OWvpNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-603e370790cso17193437b3.3;
        Tue, 30 Jan 2024 03:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614693; x=1707219493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMem4Wnyl/FAVyRvXWDBiw17T/CYF02xtBqauVXYuOA=;
        b=I1RrN5VypJQL0NRdmr8v63pFpWRgJM6OW+GK5cNhCEkyZwkeK6pyX4aVR/xm6vlB/s
         Y5HqVxkeNh3NomYRWGV4NM8C9Vz3TR+RSq90IyOrvCNxpL332PS8Y3+i/FcpGzbvk46P
         nmyi7kwnDo9sOCIUhJkjPt7gtAGFAx/6Sk0zyLLvI4qYgF6rZvuskdpV1dW8O4+Yj4R4
         7f+9eCkBwBVs70jP6daCAK/EIPAegMZ7GHVglaf+7/6sEcPUr2nWqQQ199FUahX8JhOl
         /I4wfEgUY0vz5FUymf8f/CKULnNzKXmUTWCXCIJGXD22wRbC7AJsyQmGHqZIi14rLoUu
         gKvA==
X-Gm-Message-State: AOJu0YzLoR1ScAPAXLzwcJ41dXfZqV0wfNIjT4wnDotc12+p2dvhymcK
	qcwUTxLMHCSM93Ajub7q8xctea+hhSCnJvwrV1yiaLMtScFj+TyJ7rQHPKVRnaY=
X-Google-Smtp-Source: AGHT+IFk04bMlmsesF16iNPJrpvyojRPlSgTAPbgkzCsXQbLHtU/bXJQCOAUXCZvduiJRkE4wQvpxg==
X-Received: by 2002:a25:2d08:0:b0:dc2:43d0:6e05 with SMTP id t8-20020a252d08000000b00dc243d06e05mr5203578ybt.50.1706614693083;
        Tue, 30 Jan 2024 03:38:13 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 63-20020a250a42000000b00dc2324b3cddsm2908270ybk.37.2024.01.30.03.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:38:12 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc24ead4428so2829314276.1;
        Tue, 30 Jan 2024 03:38:12 -0800 (PST)
X-Received: by 2002:a05:6902:14e:b0:dc2:35c1:7d9c with SMTP id
 p14-20020a056902014e00b00dc235c17d9cmr4871757ybh.60.1706614692403; Tue, 30
 Jan 2024 03:38:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240129151618.90922-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240129151618.90922-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 12:38:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV7Q4kMv1pFVNBf5oYF=_W_snp=5GKLpr9+OxeqxywhBw@mail.gmail.com>
Message-ID: <CAMuHMdV7Q4kMv1pFVNBf5oYF=_W_snp=5GKLpr9+OxeqxywhBw@mail.gmail.com>
Subject: Re: [PATCH 2/5] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
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
> The IX45 block has additional mask registers (NMSK/IMSK/TMSK) as compared
> to the RZ/G2L (family) SoC.
>
> Introduce masking/unmasking support for IRQ and TINT interrupts in IRQC
> controller driver. Two new registers, IMSK and TMSK, are defined to
> handle masking on RZ/Five SoC. The implementation utilizes a new data
> structure, `struct rzg2l_irqc_data`, to determine mask support for a
> specific controller instance.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -66,15 +68,25 @@ struct rzg2l_irqc_reg_cache {
>         u32     titsr[2];
>  };
>
> +/**
> + * struct rzg2l_irqc_data - OF data structure
> + * @mask_supported: Indicates if mask registers are available
> + */
> +struct rzg2l_irqc_data {

This structure has the same name as the single static struct
rzg2l_irqc_priv instance, which is confusing.

> +       bool    mask_supported;
> +};
> +
>  /**
>   * struct rzg2l_irqc_priv - IRQ controller private data structure
>   * @base:      Controller's base address
> + * @data:      OF data pointer
>   * @fwspec:    IRQ firmware specific data
>   * @lock:      Lock to serialize access to hardware registers
>   * @cache:     Registers cache for suspend/resume
>   */
>  static struct rzg2l_irqc_priv {
>         void __iomem                    *base;
> +       const struct rzg2l_irqc_data    *data;

Replacing this by a bool would avoid a pointer dereference in each user,
and allows you to make rzg2l_irqc_data etc. __initconst.

>         struct irq_fwspec               fwspec[IRQC_NUM_IRQ];
>         raw_spinlock_t                  lock;
>         struct rzg2l_irqc_reg_cache     cache;

> @@ -371,9 +475,23 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_=
irqc_priv *priv,
>         return 0;
>  }
>
> +static const struct rzg2l_irqc_data rzfive_irqc_data =3D {
> +       .mask_supported =3D true,
> +};
> +
> +static const struct rzg2l_irqc_data rzg2l_irqc_default_data =3D {
> +       .mask_supported =3D false,
> +};
> +
> +static const struct of_device_id rzg2l_irqc_matches[] =3D {
> +       { .compatible =3D "renesas,r9a07g043f-irqc", .data =3D &rzfive_ir=
qc_data },
> +       { }
> +};
> +
>  static int rzg2l_irqc_init(struct device_node *node, struct device_node =
*parent)
>  {
>         struct irq_domain *irq_domain, *parent_domain;
> +       const struct of_device_id *match;
>         struct platform_device *pdev;
>         struct reset_control *resetn;
>         int ret;
> @@ -392,6 +510,12 @@ static int rzg2l_irqc_init(struct device_node *node,=
 struct device_node *parent)
>         if (!rzg2l_irqc_data)
>                 return -ENOMEM;
>
> +       match =3D of_match_node(rzg2l_irqc_matches, node);
> +       if (match)
> +               rzg2l_irqc_data->data =3D match->data;
> +       else
> +               rzg2l_irqc_data->data =3D &rzg2l_irqc_default_data;

Instead of matching a second time, I'd rather add a second
IRQCHIP_MATCH() entry with a different init function, passing the
actual rzg2l_irqc_data pointer.

> +
>         rzg2l_irqc_data->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_=
node, 0, NULL);
>         if (IS_ERR(rzg2l_irqc_data->base))
>                 return PTR_ERR(rzg2l_irqc_data->base);

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

