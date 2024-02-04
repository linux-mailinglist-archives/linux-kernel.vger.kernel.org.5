Return-Path: <linux-kernel+bounces-51662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F1F848E0A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23419282F80
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A4224E4;
	Sun,  4 Feb 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLzpuEbK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCF219FF;
	Sun,  4 Feb 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707052772; cv=none; b=dCZVFcClKFekivaEefOb/23kJ/X0a3n3fQsnG71sFqRTA+raH7eqYxv2NUepuoR5rukVRCBAPtckJTteg1muVRtVRUCWji9pt7GFNyj/H8sMGRXne7f74gEdwoJ43FqZoDsv7DNHkkbh4vj07oC5K1kHXyVDWvLgkk/XFhUpGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707052772; c=relaxed/simple;
	bh=UNqEHH3dCJoLVS2Ndq4kDYwtV6GN8z2wB4AIX3Mux+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bv9K04sv8EKKenc0MmyOLHuadTYx5HbRH7fTEUUWm/OPwGTxAGX15WyLKv7/TqaZO9S5hBx7Qwi6Trnfyq7ngMxJ7aYO5Og0vytQ4jmAbyKlFmNgGYbkF55bASg1Y4EJqNKsSGDbRbM/xwM5/NUvWhBWVgJV8HHOVPpQDB3qsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLzpuEbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B4FC433B1;
	Sun,  4 Feb 2024 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707052771;
	bh=UNqEHH3dCJoLVS2Ndq4kDYwtV6GN8z2wB4AIX3Mux+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OLzpuEbK+zOm1sn8eG/MRgXm6X12YvdQq99gIzC8tLqrDquHHGDhtSg+FnchHyDTO
	 SRCC8oFpTtpv0wAvrWWjbyYmGWcNCAi485LLsLHJ5xt2T7+YBfNEaC+IsbPKDUeyxE
	 M+rWDBXPJGXLS1K5qdslX0jsCPK0rVQa38hjgz09nhocsS53GUwM+2RY4RZ1fSJAj8
	 vHQq5dkXVjWUb16ELeGRTWELWMiaDjWEYmLVnACVHDLok9/7P3ShR3tJcPLXbCaXtI
	 XjO47uytTHwNSg5pJ55YvKkpidi39Gs9dVMxxZ7oAmWo8EZFi/tzU3/s8l4E+/zg4h
	 bASQwUDUQle+w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5113a97a565so2468569e87.3;
        Sun, 04 Feb 2024 05:19:31 -0800 (PST)
X-Gm-Message-State: AOJu0Yw4aGsw3iWKvP1r9+t2kyBkm4+2aU6wohuKf7uoLIls5EVZAEkY
	MCBSKNXOEo8Q3cMM1qkAABO/Gr7jZTLkU25QIjYwMqbTRRvxM5eHnYxNcFPSttUi53YXSmMN+dB
	Hx+GQRCj9M4yXj7zHUd9D6fKmdIQ=
X-Google-Smtp-Source: AGHT+IGBi6H/m6KT3UCnhwQYIqummxJ8ILXcmZYyl95mLdpmjzdSiNAQsolwbAsHnB1qPW2jsJ62D012lQ+eQcWL2Q0=
X-Received: by 2002:ac2:555a:0:b0:511:38df:2ee7 with SMTP id
 l26-20020ac2555a000000b0051138df2ee7mr3480968lfk.48.1707052770370; Sun, 04
 Feb 2024 05:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204125716.56756-1-masahiroy@kernel.org>
In-Reply-To: <20240204125716.56756-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 4 Feb 2024 22:18:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNASC4xh5WrEaHkqFg49xzJsQMQnjLV8sCea8uceNp5EUdQ@mail.gmail.com>
Message-ID: <CAK7LNASC4xh5WrEaHkqFg49xzJsQMQnjLV8sCea8uceNp5EUdQ@mail.gmail.com>
Subject: Re: [PATCH] arm: omap1: remove duplicated 'select ARCH_OMAP'
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just a nit.

The commit subject "arm:" should be capitalized to "ARM:"
because it is a convention for changes under arch/arm/.

Maybe, the maintainer can cater to it?


On Sun, Feb 4, 2024 at 9:57=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> Commit 980a637d11fe ("ARM: omap1: fix !ARCH_OMAP1_ANY link failures")
> added one more 'select ARCH_OMAP'.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/arm/mach-omap1/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index cbf703f0d850..a643b71e30a3 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -4,7 +4,6 @@ menuconfig ARCH_OMAP1
>         depends on ARCH_MULTI_V4T || ARCH_MULTI_V5
>         depends on CPU_LITTLE_ENDIAN
>         depends on ATAGS
> -       select ARCH_OMAP
>         select ARCH_HAS_HOLES_MEMORYMODEL
>         select ARCH_OMAP
>         select CLKSRC_MMIO
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada

