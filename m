Return-Path: <linux-kernel+bounces-81519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ADB867703
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A5E1F2B276
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587E12BE97;
	Mon, 26 Feb 2024 13:43:13 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8038380611;
	Mon, 26 Feb 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954993; cv=none; b=LtJ148L0q76BaTlXFxZ66Xrh04lBi2TpNXt8krEnIC+IFb1Z4rMfWRBjV4Blbevy/id/+8bVlWxkpqqwoX+EIt1poBeJizCZYzrdTb6wnve1guzT8DzmUD3DLEPujIxseyy5nyQmaBjbyZJtHqGnU/SrtBzqs3+eDsqnhho29+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954993; c=relaxed/simple;
	bh=pFAt37In4C1NGUQzKKJcVZieVDmlSteEWuDMwevIIU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F6/brScmbZHPiO7u6DXxShWRmc0AtorAus7yNW5MyBkFzWcnDffg9/Z7ovQdTB2wERHDtUgRRQoA6CpqkDFAD083NlLfP5LvHV0AERidvOzMOGVb8SlQ1eRGgdSb05WwaqBN//wk0WxkvLHamDCCoQB9j0jCJXHZMRNlx5tLj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-608a21f1cbcso17598777b3.0;
        Mon, 26 Feb 2024 05:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708954990; x=1709559790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM9IBJmjocubPpIlyX8DCM6VK9Xw+wbgUopHfemYUIs=;
        b=AvoDZAkjDxy76XOlw/H7hd+xBQi2VlG96CQJrxFHDPOuTfmjGtwr+BpoooVWGcct6o
         ZmhIQfsPbz/9BeJK1zIHIZI6EgSxRkO/b3asP4JtYree1WtciIfpJB4eyOpLT9+R7jwX
         74PCzCX2vCMKjYGqlxw7ezn2JngDaYg0qJlBE+w9U0ZsmXvjBvi5Y31OHlyoKl/iBzi8
         0VKRpiEb16CZeUozkOxa4Wz1CrtS2EZtDihDBJ/DvmqijuWGqt/lFDkXkPNwvklghJNK
         w9IuxWWUUuMXzaV/m4ClnYlIHIdZjnHgbFI0xzsH3DC7Be4RjlVzQQV1yxPbd2kbWO1S
         aQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXLdT4ju+PPsKEYfzaLAKjp6u+/Tzwd/IR0GKQWW1cp/8d4K5u7aqnFosH2YD2+/1QO+wFcRr0LyZpaTyZennl9gVOM1qDeDYJAF1gG26svu/ae8vDyveORAxBpwZ5uKZA0w/UhPA0PwoGV0GauhkD+2MYWoD/QeAxYjeEBktAlXxBqIcHG0Ewk/miN
X-Gm-Message-State: AOJu0YyWQrvHqS4Ms3XZmflYbJ+lL2y7lzzx4I6l/AawUC5OKCQ6X7m1
	pqTPKFcCdY6sVwjsAp68MJX4QsGXf3GYgiF/M/xrrADdy9f+jXKw3+e6VWWYcLM=
X-Google-Smtp-Source: AGHT+IG3KoBCFG6KHC2jOrv9Fy/qqOiJCvyFxbgXF/Ud6DivdWQAefObxkDGV/P3ONHYR2SOffOFwg==
X-Received: by 2002:a05:690c:5:b0:608:dc99:b217 with SMTP id bc5-20020a05690c000500b00608dc99b217mr5252884ywb.50.1708954989711;
        Mon, 26 Feb 2024 05:43:09 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id u18-20020a81a512000000b00607b6c0065fsm1142838ywg.43.2024.02.26.05.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 05:43:09 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-608959cfcbfso30643317b3.3;
        Mon, 26 Feb 2024 05:43:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWGEyK37I1/BZLIg775tpFkfmlvMxqpgs5kMiTjzLrvLL98E0jdt7nMyq5tU3I5La1Or+p62SVHQUn20XCH5RBrbeGH6MFyZrAHpu41yQDNtyCgu8wavCbq9WwMdG0f4ZnQxrlnbXw50hf6BFkAlThxeBxiKD3EliqE8u/FgX//zQH1GC3JO+D+/KG
X-Received: by 2002:a25:ac8f:0:b0:dc7:1d:5db4 with SMTP id x15-20020a25ac8f000000b00dc7001d5db4mr5324955ybi.34.1708954989329;
 Mon, 26 Feb 2024 05:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240219160912.1206647-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240219160912.1206647-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 14:42:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVUpq3+O298s=2V95T5Ub4MgM9kj=mQ-fHL8KUgD0Uug@mail.gmail.com>
Message-ID: <CAMuHMdVVUpq3+O298s=2V95T5Ub4MgM9kj=mQ-fHL8KUgD0Uug@mail.gmail.com>
Subject: Re: [PATCH 3/4] soc: renesas: Add identification support for RZ/V2H SoC
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

On Mon, Feb 19, 2024 at 5:10=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Add support to identify the RZ/V2H (R9A09G057) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Thanks for your patch!

> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -344,6 +344,11 @@ config ARCH_R9A09G011
>         help
>           This enables support for the Renesas RZ/V2M SoC.
>
> +config ARCH_R9A09G057
> +       bool "ARM64 Platform support for RZ/V2H{P}"
> +       help
> +         This enables support for the Renesas RZ/V2H{P} SoC variants.

"RZ/V2H(P)" (everywhere).

> +
>  endif # ARM64

> --- a/drivers/soc/renesas/renesas-soc.c
> +++ b/drivers/soc/renesas/renesas-soc.c

> @@ -177,6 +181,11 @@ static const struct renesas_soc soc_rz_g3s __initcon=
st __maybe_unused =3D {
>         .id     =3D 0x85e0447,
>  };
>
> +static const struct renesas_soc soc_rz_v2h __initconst __maybe_unused =
=3D {
> +       .family =3D &fam_rzv2h,
> +       .id     =3D 0x847A447,

Lower case hex please.

> +};

The rest LGTM.

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

