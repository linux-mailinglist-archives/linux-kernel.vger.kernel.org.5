Return-Path: <linux-kernel+bounces-59712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DEE84FACF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB5DB23F09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A897E77F;
	Fri,  9 Feb 2024 17:14:17 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48D4D112;
	Fri,  9 Feb 2024 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498857; cv=none; b=aSwWNbxNtnEcWvZtZqS9rYjEXihF2+bpm7PS6D77HjcdUq1z9XToqBKUqsNsz6raGXSEMfF9vMoIcSP+e5ph7X22ggfmAFcrEiceQwOmeeAEHuG9sZwuXFqiu6LsdlKaSuTrlS+Ogcfx6HDeCB+WtNXFHiolT4gORYuzoU4Gfzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498857; c=relaxed/simple;
	bh=+DTDGzLknxo/ZOoEm1bGhlARIpKxl17yogEhWgOhX6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3gCJ2pJxE4wsChnS0oay2jgQjwhvwfdP8MaMnRhC+Ao4bVCjOqyMuydHgWj/H4AxTEgOAr+qGPkpwQlHwexqj5Fwcu65ySb6ARCNCLFZ/g/FvqtRLO4WyBs3M0DXfxoQV05seMAht0BjRJoWnasGaq8LcLEiF0RhqsIGUf6utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-603fd31f5c2so19581917b3.0;
        Fri, 09 Feb 2024 09:14:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498853; x=1708103653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdDdMzA8rqlb5+lk3BPGGmoUh4tuhQ6PGFVYwnqwvAU=;
        b=JOZH8vAEgHp1WFUVMx2TFSxXLRI1EIgfA5/MOXO6kA8G+OuuHhi99V1emexGMOMr/g
         qmE9kpHQaTQJObv8xECwdifLB9uhzWEuE6juHKBuuuhc4QN2WmFhk9nTr//GAXv/P3ej
         HBGsoW3N9cGnII5Xy2nWkVyGGMFS1bWKRZ3G1JUsIzhekeii+AlPigBAC+F5hZZc0WCj
         RFwzxZ+CkE74H+ZUWVO/GEWgK6Q0OFKAnem6mc4EQ6Mg2TZtYzQ2e6Z/Kze5OVWdIZoC
         VggYxQBSbKgUfpL1LnQK535kCuXXlndeFVXq16IBEY+pFylHl+uyjMuQZYAhrT6kH9vy
         Pwyw==
X-Gm-Message-State: AOJu0YyZsv2Eoui3OgR83zG2CerH/+unHd3HyYbwIJHCAOjDZGXWYXXe
	1oHGrj4okkcFv+aeJRUSY+jAXSyJo8FpRUFccFqJhmALZUk188VAGo1FxgilDWw=
X-Google-Smtp-Source: AGHT+IE6B/Co1YRt+cE8VwwHGwCVN5zGEsDVSd3ykEiszvLfBtuxiEZUk4RX8vwPy8vNh26LxxXfzA==
X-Received: by 2002:a0d:db42:0:b0:604:95db:c4c5 with SMTP id d63-20020a0ddb42000000b0060495dbc4c5mr1167605ywe.25.1707498853060;
        Fri, 09 Feb 2024 09:14:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4wJgA301Dmptw9GlKGEcLXqi5f8g0qDjEHS7FhZ3ukwjlNAvLwk/9Xl5KGGUnaj3no8/EhsklyDzXII+NPJbSJ/V2pwbTq7KovJwkKUcKPM5vIh+CdMOGecbI5ZNP+J1y47MTzjJFmeT06cW4OW1uL+xaey61f3UJkQ+GJKe+TFWPptEpISQO0R2WsKr0cYG+qWqo9+QF6nsabD7IDmgzS1S6B9lYWccHW01XB7DW4Qtn5hpUXUNJ1j6sw8HM0efgwCDnvy+Yuqw=
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id u13-20020a81a50d000000b006047567a828sm384273ywg.96.2024.02.09.09.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 09:14:12 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6049b115630so15899537b3.1;
        Fri, 09 Feb 2024 09:14:12 -0800 (PST)
X-Received: by 2002:a81:4956:0:b0:604:48a9:44a3 with SMTP id
 w83-20020a814956000000b0060448a944a3mr1528272ywa.16.1707498851842; Fri, 09
 Feb 2024 09:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135045.3728927-1-tudor.ambarus@linaro.org> <20240208135045.3728927-2-tudor.ambarus@linaro.org>
In-Reply-To: <20240208135045.3728927-2-tudor.ambarus@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 9 Feb 2024 18:13:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU_Hx9PLmHf2Xm1KKTy_OF-TeCv7SzmA5CZWz+PLkbAGA@mail.gmail.com>
Message-ID: <CAMuHMdU_Hx9PLmHf2Xm1KKTy_OF-TeCv7SzmA5CZWz+PLkbAGA@mail.gmail.com>
Subject: Re: [PATCH 01/12] spi: dt-bindings: introduce the ``fifo-depth`` property
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, robh@kernel.org, andi.shyti@kernel.org, 
	semen.protsenko@linaro.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, arnd@arndb.de, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

On Thu, Feb 8, 2024 at 2:51=E2=80=AFPM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
> There are instances of the same IP that are configured by the integrator
> with different FIFO depths. Introduce the fifo-depth property to allow
> such nodes to specify their FIFO depth.
>
> We haven't seen SPI IPs with different FIFO depths for RX and TX, thus
> introduce a single property.

Ha...

Current documentation for the Clock-Synchronized Serial Interface with
FIFO (MSIOF) on e.g. R-Car Gen2 and later states:

    FIFO capacity: 32 bits =C3=97 64 stages for transmission and 32 bits =
=C3=97
256 stages for reception

Initially (many years ago), there was some doubt about the validity
of these values (older variants on SH supported 64/64), hence
drivers/spi/spi-sh-msiof.c still has

    .tx_fifo_size =3D 64,
    .rx_fifo_size =3D 64,

Probably we should test and revisit this...

> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -69,6 +69,11 @@ properties:
>           Should be generally avoided and be replaced by
>           spi-cs-high + ACTIVE_HIGH.
>
> +  fifo-depth:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Size of the data FIFO in bytes.

I think it is prudent to consider the asymmetric case, too.
Whether that should be just two properties ("rx-fifo-depth" and
"tx-fifo-depth"), or also a third "fifo-depth", I defer to the DT
maintainers...

> +
>    num-cs:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:

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

