Return-Path: <linux-kernel+bounces-61952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FC78518E2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7021F220F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B023D397;
	Mon, 12 Feb 2024 16:25:01 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD03D0D1;
	Mon, 12 Feb 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755101; cv=none; b=k1F4w6d68wPEDXrlHYvpNBioszIczHy9SNW9JIEbxSyDa+YQ3tkVfWAm7KsCu97ZArJTAwvlNYtsnUZjYkDaA82Z/u4YnfaTFNcV2q7oW59FXDqkP1GkwWtJMxAVP3P5Dr2RjksSGXnrX4aDUpHgq8HnLRJ25Lu5qV8vAvIyRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755101; c=relaxed/simple;
	bh=rmkbXCdg84yoQwpkq7NH1fqrGGiLhnDvubFSBGJe+yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHzMHkGpGnNIAWhhJEIS8PG/lkzwUvO5TTYuE9PpV0WtTBovJcYipOZ2ViaLozdTkm6wZX5FmmkCTjMTBTEoeiPWa1spROeShSsMFZou8y0FLBBfQCP/xmIJM4G2DPAVseJAF+gyZ67PIOfP6etL6cap6Ri/QjvtHZuKjtnhJqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc75c5e3151so2088598276.1;
        Mon, 12 Feb 2024 08:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707755097; x=1708359897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb3maADtaAKKNSwdn2QybG1Ogk1CA+GA1APXldxFH+U=;
        b=mF20jCC4ZiLO2U98+apDlVN+AZAEpQIoFraQutsq0NXYaJiwAVNvUzuSzNkEQEgd8u
         ZvH+8iEetOw/3c0KT8X9HwQLFsIFtcBOkr1VD/T/NEsNAJ5PRB5yfYCrm29Tg8U0PYtW
         kacXiqV4sqxSKQvkth56FRJ6ynrJLtIY2C1BZbI8oyOG9RtxeBfuwWjMxPWEZ6WVIVrZ
         bxfvnx9zdi9nKK+EshD82kLpYr6swiUz5ED8+sEJvRM5DVqIm1GYS6oMblapFyg8XUd1
         AEC4W44qRKRf0fkQOfu8cVgIK36FCsco7pHH6oISCcLk54U8IQ9VArprPWlOud2A5G0K
         Thsw==
X-Forwarded-Encrypted: i=1; AJvYcCVY+9B52u89K1gqqvODb2qXDNgZgQmymaFZdxU/uCpdvAfwXz232F3GevlMWkORz+GlciCgd3IjUhyiluMT0jo6RV2z9qqJ82YhJ0XpTTdMWS2GYyXuJT2PpFn2l/pyH5XS0O6K3HASrKWaEysn+M322rHtDPOcsslYN3sZps19DCA5+6W5mZQj6e7T
X-Gm-Message-State: AOJu0Yy5xwE3FAThNA3rO0GWdimt+AkEwjYBWyUf7w8dK54RAwhYhNdr
	j910RZy5KzhwC6tTiLS6Rl7JXk8UqqkZF+iA+rut0RlJCyrR4xQNTt/wlMX9QTs=
X-Google-Smtp-Source: AGHT+IGpDKCUm49Jrpq+v9zw3n8Ses4IzwmHcEiXGGrrGrSeqEg5V+hCRB8febkQaOTLxNy9I3Mufw==
X-Received: by 2002:a25:4194:0:b0:dcb:ca7e:7e73 with SMTP id o142-20020a254194000000b00dcbca7e7e73mr781765yba.11.1707755097672;
        Mon, 12 Feb 2024 08:24:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW1j6E5u4H0tycjyhjF5ZCA2dOuOkHsSqfQu1bHrwCGFryKpRz468S1q5vKReoq8D8gOVhdUbEgsn0kIbVQ/0vQITaIsI0/JCAw5p4ChEjmmYFIpq5hO5D89G6E/LC7F/vEDAph58rnUmamhxCsQirxZJ8gW7iWhxcd83aVLvSW9kCoVlqMYunOL3Zr
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id l37-20020a25ad65000000b00dc230f91674sm1298716ybe.26.2024.02.12.08.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 08:24:57 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbbc41d3d5so419705276.3;
        Mon, 12 Feb 2024 08:24:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVTPj5fGxYzBzb5YQUnTZVF2f4vM3MHoXLXRXXDdMLzrJsoGc+Dkbo8pyOeFCJLMSQ/Lgl0SpEyI666KVOorETX6gCzObFtWviuc8JoXouJCWbKr3u8aAJjtTwbZsS+JHH9dXga8paw812tPDmjUgmBQpvGe8dSYRj/gGScTBPfkt+P+gsKSd1UQdbx
X-Received: by 2002:a25:aa6d:0:b0:dc6:d7de:5b29 with SMTP id
 s100-20020a25aa6d000000b00dc6d7de5b29mr5622636ybi.10.1707755097054; Mon, 12
 Feb 2024 08:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205144421.51195-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240205144421.51195-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240205144421.51195-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 17:24:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW0xWgA+9rtDcRUgoS1HYvd+mukvK25MHbzHpo=1uGq0g@mail.gmail.com>
Message-ID: <CAMuHMdW0xWgA+9rtDcRUgoS1HYvd+mukvK25MHbzHpo=1uGq0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Update interrupts
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Mon, Feb 5, 2024 at 3:44=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.co=
m> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> All the RZ/G2L and alike SoC's (listed below) have ECCRAM0/1 interrupts
> supported by the IRQC block, reflect the same in DT binding doc.
>
> - R9A07G043U              - RZ/G2UL
> - R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
> - R9A07G054               - RZ/V2L
> - R9A08G045               - RZ/G3S
>
> For the RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts combined into singl=
e
> interrupt so we just use the below to represent them:
> - ec7tie1-0
> - ec7tie2-0
> - ec7tiovf-0
>
> Previously, it was assumed that BUS-error and ECCRAM0/1 error interrupts
> were only supported by RZ/G2UL ("R9A07G043U") and RZ/G3S ("R9A08G045")
> SoCs. However, in reality, all RZ/G2L and similar SoCs (listed above)
> support these interrupts. Therefore, mark the 'interrupt-names' property
> as required for all the SoCs and update the example node in the binding
> document.
>
> Fixes: 96fed779d3d4 ("dt-bindings: interrupt-controller: Add Renesas RZ/G=
2L Interrupt Controller")
> Fixes: 1cf0697a24ef ("dt-bindings: interrupt-controller: renesas,rzg2l-ir=
qc: Document RZ/G3S")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2=
l-irqc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2=
l-irqc.yaml
> @@ -88,9 +88,15 @@ properties:
>        - description: GPIO interrupt, TINT30
>        - description: GPIO interrupt, TINT31
>        - description: Bus error interrupt
> +      - description: ECCRAM0 1bit error interrupt
> +      - description: ECCRAM0 2bit error interrupt
> +      - description: ECCRAM0 error overflow interrupt
> +      - description: ECCRAM1 1bit error interrupt
> +      - description: ECCRAM1 2bit error interrupt
> +      - description: ECCRAM1 error overflow interrupt
>
>    interrupt-names:
> -    minItems: 41
> +    minItems: 45
>      items:
>        - const: nmi
>        - const: irq0
> @@ -134,6 +140,12 @@ properties:
>        - const: tint30
>        - const: tint31
>        - const: bus-err
> +      - const: ec7tie1-0   # For RZ/G3S SoC ("R9A08G045") ECCRAM0/1 inte=
rrupts are combined into single interrupt.
> +      - const: ec7tie2-0   # For RZ/G3S SoC ("R9A08G045") ECCRAM0/1 inte=
rrupts are combined into single interrupt.
> +      - const: ec7tiovf-0  # For RZ/G3S SoC ("R9A08G045") ECCRAM0/1 inte=
rrupts are combined into single interrupt.

These lines are indeed a bit long, and might become longer when newer
SoCs are introduced.

What about changing the descriptions instead, like

    -      - description: ECCRAM0 1bit error interrupt
    +      - description: ECCRAM0 or combined ECCRAM0/1 1bit error interrup=
t

?

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

