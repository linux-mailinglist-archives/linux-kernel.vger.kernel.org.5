Return-Path: <linux-kernel+bounces-156603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD38B057A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70869B27B92
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C197D158D83;
	Wed, 24 Apr 2024 09:06:18 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610E158A3B;
	Wed, 24 Apr 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949578; cv=none; b=rXUHxzd0YNe/zqUNXTBd4JodPuwWD3GlbbfYN8bySfgliEULT7x0kOT2dFWODzQAUkroyyxiS2Y88TCWUH6X7eadX+d0FAWlj239kGDs3ogyqcoJmXAAZbfn8SmoAnTrf1eXJaGPCIcgGAuOlsuCF1ui044HhIQNkYyfTJCtms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949578; c=relaxed/simple;
	bh=p1Bek1Bj7I+Sm34BIpKRNTqjcJV42xj1+Ln7FbugPyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWpwXRSdHdx/FsqRXR0RUmp5Sf9lV18u4VlkDQXNR2rcvtiTOhRIagmgFJBytyMlSiYrXLu/aXlpPc19Sfndtiqp9mcYsCtCHWntY3F34GZHiUqheaqVuZZdn5IBO5eTJAseVCQxHsVrGQY86snuCiqgtcF5HRq1hWTFWM5mqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61ac183ee82so5998027b3.1;
        Wed, 24 Apr 2024 02:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949572; x=1714554372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLEQAzNUqvENBDpDsvbMZoQLKFDtnbH03RM0teNlmFQ=;
        b=ZN1UIrSJ0lBDPmQNAMrWI56cy9/AMzLl8yKgZC2R7B9wDI2yGVnt+ibMyx6mnpxIRU
         MgPKyRPMqIdaNSaKM42HPDQ0gYGaqMKQSzT0iOvtHaiiPnsMoavn1Xfs/Vbah391a39P
         SnOKvKCsEjviApt1ZhRonIfmnSumRCWlE5VHFD4mfobKpUAqMjBkAQ3Lu5okkycqDCz8
         GnVrtovMaPm1ukBd7srfsEaVyRUs8jvYaTecUR0rIIxPlIzx/T26fxu37F5r7d8y53En
         +J+21niqOReR6duaBjU8Us1Ar2uiMas0gct3BdfQFVeTbExNhcV2WH4ige2V6nsc5+bd
         Zbiw==
X-Forwarded-Encrypted: i=1; AJvYcCV1JvBD+31PaRHZlCDTt+P10iS2QxHEVvkX7PAXxILg7mbUUM59AlXHK8IN4rISUN9Cx/tNYOoFaMjYLbAORuC3F5N3w+sOkVYHKTov1DJG0UOmyplSwSjg/nz28n3fwtrR20HN7p6FswrPvgoX4sKByZAQIRIO0aZNxTTAsScEKR9tPlVrnu4m5jXKqHInI1mExYxQZfAP9yQLxlxqfFbfOhbm4QzZeg==
X-Gm-Message-State: AOJu0YzK77FRMqlfbjrGoAtXYMqAArqIlmyVzr3QYFdCnkGy7cfNT3wd
	T7sov72iBV9OqWPjr4coGtCgQXHAZtYxSwgrGbf/tyOiy613WHjm2yvf8BmS
X-Google-Smtp-Source: AGHT+IERBCGNAtoexrGTQ+HCOYODRwysSjABeI4L9ePF2iXI8N0TdPD+vn+HWIpfzdB6U8HO93gQiA==
X-Received: by 2002:a25:9a48:0:b0:ddc:ca9c:5d40 with SMTP id r8-20020a259a48000000b00ddcca9c5d40mr4617632ybo.5.1713949572179;
        Wed, 24 Apr 2024 02:06:12 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id c2-20020a258802000000b00de51e5487b3sm1531550ybl.47.2024.04.24.02.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 02:06:11 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso643781276.0;
        Wed, 24 Apr 2024 02:06:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJ5DuYKJtJZrpYyTxK1wmFaTxyaQcP56KjKUeUVT2Ihl5nAA2LT+qht/La3cz3KNkf/7eFvmPG1owoK6l5UCU13c0BDn+BJcUgQ+HmR9z78P+y0HEP1Sc1AuB53JF7JbB0srVRKqayHrlcZ8e1RmmhWlg3vznlbnSDcGSv7J88jk4vkvxvsOpIsPeJODTYubiPxxg+ZBpmC17HQX73X9qoHAMrbVTeLg==
X-Received: by 2002:a25:aae3:0:b0:de0:ee2c:b828 with SMTP id
 t90-20020a25aae3000000b00de0ee2cb828mr1566199ybi.25.1713949571004; Wed, 24
 Apr 2024 02:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240423175900.702640-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240423175900.702640-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 11:05:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV+oVFNUJse0th_PXKhtsUzXa7Mk7ozq5cKZoYX12AMRw@mail.gmail.com>
Message-ID: <CAMuHMdV+oVFNUJse0th_PXKhtsUzXa7Mk7ozq5cKZoYX12AMRw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] dt-bindings: pinctrl: renesas: Document
 RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

Thanks for your patch!

On Tue, Apr 23, 2024 at 7:59=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add documentation for the pin controller found on the Renesas RZ/V2H(P)
> (R9A09G057) SoC. The RZ/V2H PFC varies slightly compared to the RZ/G2L
> family:
> - Additional bits need to be set during pinmuxing.
> - The GPIO pin count is different.
>
> Hence, a SoC-specific compatible string, 'renesas,r9a09g057-pinctrl', is
> added for the RZ/V2H(P) SoC.
>
> Also, add the 'renesas,output-impedance' property. The drive strength
> setting on RZ/V2H(P) depends on the different power rails coming out from
> the PMIC (connected via I2C). These power rails (required for drive
> strength) can be 1.2V, 1.8V, or 3.3V.
>
> Pins are grouped into 4 groups:
>
> Group 1: Impedance
> - 150/75/38/25 ohms (at 3.3V)
> - 130/65/33/22 ohms (at 1.8V)
>
> Group 2: Impedance
> - 50/40/33/25 ohms (at 1.8V)
>
> Group 3: Impedance
> - 150/75/37.5/25 ohms (at 3.3V)
> - 130/65/33/22 ohms (at 1.8V)
>
> Group 4: Impedance
> - 110/55/30/20 ohms (at 1.8V)
> - 150/75/38/25 ohms (at 1.2V)
>
> The 'renesas,output-impedance' property, as documented, can be
> [0, 1, 2, 3], indicating x1/x2/x3/x4 drive strength.

The documentation says "x1/x2/x4/x6" for all but Group 4 (P20/P21).
Still, the actual values don't seem to match the magnification factors...

> As power rail information may not be available very early in the boot
> process, the 'renesas,output-impedance' property is added instead of
> reusing the 'output-impedance-ohms' property.
>
> Also, allow bias-disable, bias-pull-down and bias-pull-up properties
> as these can be used to configure the pins.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yam=
l
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yam=
l
> @@ -111,6 +116,18 @@ additionalProperties:
>          output-high: true
>          output-low: true
>          line-name: true
> +        bias-disable: true
> +        bias-pull-down: true
> +        bias-pull-up: true
> +        renesas,output-impedance:
> +          description: |
> +            Output impedance for pins on RZ/V2H(P) SoC.
> +            0: Corresponds to x1
> +            1: Corresponds to x2
> +            2: Corresponds to x3
> +            3: Corresponds to x4

Hence I'd drop the multiplication factors, and just say the meaning
of the value is pin-dependent?

> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          enum: [0, 1, 2, 3]
>
>      - type: object
>        additionalProperties:

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

