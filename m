Return-Path: <linux-kernel+bounces-81515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B58676F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0814F28F8B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CD1129A9B;
	Mon, 26 Feb 2024 13:41:39 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16C128389;
	Mon, 26 Feb 2024 13:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954898; cv=none; b=j1yII5X7Lr9U1G8XzYOM2YkLbjRtD3+HNB0iOE4lItG0H2LhMiKy4ZChdGinTUaHAgFFhYLKu2fijIVun/6KWb5DqRkTAIVfqg+dBl5jYhVU8Cc1RKXvp9RDcr+OTBGbAJO2wHRQdTWBQAypkvRSvV+/uu62+VbdLz8mgeqc3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954898; c=relaxed/simple;
	bh=KkHOuTxfojJAebXRZa+XnGZj2GHfgqfYukTvO9EQtV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GM2Oh6EGKWWxEejWVNhRdfKeIOqVq1nS3bIT5zyvcdJ6wor6k7cu5FTc54EuyscwZ+KKYOTBac2qF0luzoRNW5caKpQiec/x0U97LbJsiiUa3MF1VL2RLjsvzzZz8xMdyvRVP9G6fEwrDzmSxvzX8qpsAN/W976Hf+jq7WDxDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60853ad17f9so23735087b3.0;
        Mon, 26 Feb 2024 05:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708954895; x=1709559695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+OhW/XaI7vSIwrRRZgNy39CQ/IuoQT/QK0SjQNuYlY=;
        b=MIjWoMcaWkBCDlQo4YBghPH2dKIIMX62O2/0+Z4fKO6Yp05xBEN6KpLL2buKABiC3V
         GksOhot416kR+dvSh025Ib4ErSZ6EGgPx1Fl/JXC4iqiY6WsqaPATFz6ry5aXc1H9A8A
         1oxvVnWCnXadXAvRjI8/LWnrkQLuuZWurwBnMZTPPTvSKeYBtjsHwZ12rBYa6khcRunc
         cWbnKCebB0K1BiqLK/uJt3duTI7YEYWn++3YCirka3LBnkKtYSTgZ+iW1SO9EINnbG+Y
         DP97US9igRcs4HYHe8mlcehQGx4YWCbFZpqCnBs7AUf+sfiFEaYSlDArKM5b5XB7AuDl
         cbcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoRX47MTuckJNZW5Px3LkL1enfAuOepx00sZtEl8UuU9vzUsF81s3LCMVDB4wC0vDOZMcVqObE/YE2bZZK1JALDGrwHhhCgkpae7GfMUXHD7jEqY57uzh+OpORr8pUxg+BOz+80HB3pL1TC4J/leOuMYujgChRpzfeBCPQxBHuM03j0BH5RBv22a6C
X-Gm-Message-State: AOJu0YyhFvISx1JmPx/KAD1/5Ew7H7izC5xgpvIx8/HObXulJ15OJRPb
	O1xun5IgFmFoBAkEQozWozFVaUK/LoShLOHILco5wl/2oi7C3FGBqbs5v17bNRQ=
X-Google-Smtp-Source: AGHT+IFD37X8nqQ64iCS0SOCkDERHWJpLennLTe0KLo/NJf+4Z73ZnUNEVPd8ZbMMDcU/1rdJfTeJA==
X-Received: by 2002:a05:690c:f88:b0:608:ff01:5128 with SMTP id df8-20020a05690c0f8800b00608ff015128mr1721062ywb.15.1708954895023;
        Mon, 26 Feb 2024 05:41:35 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id f187-20020a0dc3c4000000b00607bc220c5esm1167720ywd.102.2024.02.26.05.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 05:41:34 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc742543119so3162363276.0;
        Mon, 26 Feb 2024 05:41:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbYVyHpPZCzB9o3Nsx7Usvk19lWPyK37Y+8MG0h54DhCdpICKzrEzsuFTitkfYimR6JKl6HlAjJYEXpIXtDLRO7gmhuu2j6mPTqJ41TZXxSoe7efc0EGJBYaofCjpdcQySA+GhagVjHLzkraGwY7cDKmAofB13e3tfFCvZwx40Ngnqhgp+QloFi/2e
X-Received: by 2002:a25:dbcd:0:b0:dcc:1a56:597a with SMTP id
 g196-20020a25dbcd000000b00dcc1a56597amr3993501ybf.36.1708954893612; Mon, 26
 Feb 2024 05:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240219160912.1206647-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240219160912.1206647-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 14:41:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWw4V7p9RXqx_GeL6LC=rYscChbcnkuJcDzqjfac7-XoA@mail.gmail.com>
Message-ID: <CAMuHMdWw4V7p9RXqx_GeL6LC=rYscChbcnkuJcDzqjfac7-XoA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: soc: renesas: Document Renesas RZ/V2H{P}
 SoC variants
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

Thanks for your patch!

On Mon, Feb 19, 2024 at 5:10=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document Renesas RZ/V2H{P} (R9A09G057) SoC variants.

I think "RZ/V2H(P)" would be better, as curly braces are usually used
to group multiple values (e.g. "RZ/G2{L,LC}").

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  .../devicetree/bindings/soc/renesas/renesas.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b=
/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> index c1ce4da2dc32..109fbc8d48db 100644
> --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> @@ -513,6 +513,14 @@ properties:
>                - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
>            - const: renesas,r9a09g011
>
> +      - description: RZ/V2H{P} (R9A09G057)

RZ/V2H(P)

> +        items:
> +          - enum:
> +              - renesas,r9a09g057h41 # RZ/V2H
> +              - renesas,r9a09g057h42 # RZ/V2H with Mali-G31 support
> +              - renesas,r9a09g057h44 # RZ/V2HP with Mali-G31 + Mali-C55 =
support
> +          - const: renesas,r9a09g057
> +
>  additionalProperties: true

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

