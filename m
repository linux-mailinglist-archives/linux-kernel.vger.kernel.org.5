Return-Path: <linux-kernel+bounces-157148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDB58B0D75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008021F230A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BACB15F301;
	Wed, 24 Apr 2024 14:59:13 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE715ECFE;
	Wed, 24 Apr 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970752; cv=none; b=NN5mE0TbbDHoVga6PO7AAteyrWVgvM1rSWHH8zzueasQZMUy+JCLI0dnIhFtq4WEnQz1i2J568W4lOiOMVQFXQGFIS86+IPRsIdKpPP7XD3iJcAXVwE2LlUptBcnLkLT5Af/hkmBMWPCN+imFU9lJsF5104zOTTx8c4W7V6K5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970752; c=relaxed/simple;
	bh=uSb9cMV+CSOhuQNCt8c3D/PhsmzG3Zww/AzIWuo08aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssQsCXWhGPsoSy4SZ1PVtaB25MUvM4fOkQIzu3dX9sRgO+5dyEj3Ic1XnC0SR7LP1EEzwQZIgBYvZHWc/m6aREFHePJspy4Bj0GrZj2Otv0AIWUgJXuHHFPLMe0nVERp50IZdvZKYjVircVMUWjw90w9B+l4ueVz7enNYf0D92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de56d4bb72bso989617276.2;
        Wed, 24 Apr 2024 07:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970749; x=1714575549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIf2hqRKb6fguvBX5EywVk6EIn67HUMm2ITgNqqkffU=;
        b=qjH7pQh4SVBszFxaO2ieNlswy+eoslRTMKNfC8Qf+8PSLwgOv4gKZCiiRyQMu8WhC5
         MmBBlGRgqCk04YuBL3viEwQ+Wf+occ4vrTH4RtMWvG1wwM2hS6t/1r1IkETvxPo2jyig
         vP0MgEn3fCSiKMcVgfVUOrirrsR+oBFmF/kMWFeni6gBv61TsdVdTgx5StLK4f5WXbyi
         0jU5qaFd76dd3aqGXo80nyJtEhHUpkuVbSw4fvrcM7Cnkw1xJykdhB606y2V8xFVIQrG
         abNzl4vPmKtXHHM4dES/H9PYv9J3adRxCzmL1NqtAUoGo4xTZqAaHisKYdmd9ltxppYY
         ML+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW13+0p6LgKlAJs1RSfpmVOT0fuYkIWJBFBCKwPgpBwkxHDb+sWwB5PrxiCiXT82KldHRGhvF6wg59uZb9+5fe9lNn9TRlVyqM9qGo/FeCwWObGv4bElDwZLXWo3zp/K5WV421+/j1p4kM4XUB3mxhb7+P7b/x+HjUQdOGGnEmXbrioHKhTvRs7IfXK
X-Gm-Message-State: AOJu0YyoXxOlGuZw88TZ3sCJR0AlAJHunFDemqR6sWdvjAUc216Z1l8S
	vwoFJsdQA+oOLkqKTFDBzgriHR7ABGUZArCeKO/0Y0db/8q6L25Sa9kEU5X9QTk=
X-Google-Smtp-Source: AGHT+IFA7hn3gbLzKjvVzfieMSB4O1yl8pPmJU6jEM59PIo2e8+29U4xB6Qo41X3UxDqClvx41r+3A==
X-Received: by 2002:a25:9007:0:b0:dc8:5e26:f501 with SMTP id s7-20020a259007000000b00dc85e26f501mr2666664ybl.61.1713970748657;
        Wed, 24 Apr 2024 07:59:08 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id x12-20020a25b90c000000b00dce0a67ac8bsm3120641ybj.23.2024.04.24.07.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:59:08 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de47485532cso6933669276.3;
        Wed, 24 Apr 2024 07:59:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqNyVW/hko/sbx3bPvEOHI8cR8kudg2iNpNHp7i9jH+0W1dQTfkoBGy8IY2c1IvPMGnxgNqiRvqviOvXe+u1lRvUHxQYQVdxcvgb1JPuHaqp566joW/K3cs2UrC1bn6DrtxYjEHLJVuVUqEHqfF+iJEX5sdVVBM0uNjsqTMu3vVQhEWr+JqNEIJy1b
X-Received: by 2002:a25:7903:0:b0:de5:5037:8861 with SMTP id
 u3-20020a257903000000b00de550378861mr2891333ybc.48.1713970748109; Wed, 24 Apr
 2024 07:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422205053.496095-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240422205053.496095-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240422205053.496095-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 16:58:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXx46TORh7fCNBwbddSLLGFmV_haQ1q+Y=n4GkzheDzaA@mail.gmail.com>
Message-ID: <CAMuHMdXx46TORh7fCNBwbddSLLGFmV_haQ1q+Y=n4GkzheDzaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] irqchip/renesas-rzg2l: Add support for RZ/Five SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Mon, Apr 22, 2024 at 10:51=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The IX45 block on the RZ/Five SoC has additional mask registers
> (NMSK/IMSK/TMSK) compared to the RZ/G2L (family) SoC.
>
> A new rzfive_irqc_chip irq_chip is introduced for RZ/Five, where function
> pointers for irq_(un)mask and irq_(dis/en)able handle the (un)masking
> of the interrupts. The irq_chip pointer is now passed as an init callback
> and stored in the priv pointer to differentiate between RZ/G2L and RZ/Fiv=
e.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> - Added RZ/Five specific irqchip instead of polluting the functions
> - Fixed review comments pointed by Biju and Geert
> - Updated commit message
> - moved locking respective read/write functions

Thanks for the update!

> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -138,6 +142,113 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
>         irq_chip_eoi_parent(d);
>  }
>
> +static void rzfive_irqc_mask_irq_interrupt(struct rzg2l_irqc_priv *priv,
> +                                          unsigned int hwirq)
> +{
> +       u32 bit =3D BIT(hwirq - IRQC_IRQ_START);
> +
> +       raw_spin_lock(&priv->lock);

I think you best move the locking to the callers that really need it...

> +       writel_relaxed(readl_relaxed(priv->base + IMSK) | bit, priv->base=
 + IMSK);
> +       raw_spin_unlock(&priv->lock);
> +}

> +static void rzfive_tint_irq_endisable(struct irq_data *d, bool enable)
> +{
> +       struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
> +       unsigned int hwirq =3D irqd_to_hwirq(d);
> +
> +       if (hwirq >=3D IRQC_TINT_START && hwirq < IRQC_NUM_IRQ) {
> +               u32 offset =3D hwirq - IRQC_TINT_START;
> +               u32 tssr_offset =3D TSSR_OFFSET(offset);
> +               u8 tssr_index =3D TSSR_INDEX(offset);
> +               u32 reg;
> +
> +               if (enable)
> +                       rzfive_irqc_unmask_tint_interrupt(priv, hwirq);
> +               else
> +                       rzfive_irqc_mask_tint_interrupt(priv, hwirq);

.. else you will do a lock/unlock here, followed by another one below.

> +               raw_spin_lock(&priv->lock);
> +               reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
> +               if (enable)
> +                       reg |=3D TIEN << TSSEL_SHIFT(tssr_offset);
> +               else
> +                       reg &=3D ~(TIEN << TSSEL_SHIFT(tssr_offset));
> +               writel_relaxed(reg, priv->base + TSSR(tssr_index));
> +               raw_spin_unlock(&priv->lock);
> +       } else {
> +               if (enable)
> +                       rzfive_irqc_unmask_irq_interrupt(priv, hwirq);
> +               else
> +                       rzfive_irqc_mask_irq_interrupt(priv, hwirq);
> +       }
> +}

> @@ -401,7 +529,8 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_i=
rqc_priv *priv,
>         return 0;
>  }
>
> -static int rzg2l_irqc_init(struct device_node *node, struct device_node =
*parent)
> +static int rzg2l_irqc_init_helper(struct device_node *node, struct devic=
e_node *parent,

rzg2l_irqc_common_init()?

> +                                 const struct irq_chip *irq_chip)
>  {
>         struct irq_domain *irq_domain, *parent_domain;
>         struct platform_device *pdev;

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

