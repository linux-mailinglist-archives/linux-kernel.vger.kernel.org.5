Return-Path: <linux-kernel+bounces-154579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EA68ADDDE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEBF28129D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFB6288DB;
	Tue, 23 Apr 2024 06:53:43 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0045B249F9;
	Tue, 23 Apr 2024 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855223; cv=none; b=eeIfvWQGHB+pTjMQtwLrpgFfEpnS08D3wnDFNuAhCAyW3sCGeX0matmpUnuvs2pauKdHJGFfs4LifdAd+t92V787r6NUYUBCPPEw/mThGuuzacs8a76/Sizu8XyPW7Z8kjUy/BXJXC2ZjfD2DHmSDW4IYIKW392sNS6Vlz2wPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855223; c=relaxed/simple;
	bh=IB24hhNHiq4eNMRwbY1E5hsdm8NutUn6FXOFJZvk3L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6jAeLisc52Ny9UtEOR2okJ3fThcNlZiYRMEEugsOBkEGhb2dnEARmOHclJ/+cBkrnVl5vw3L7R82Ari+kaeuJ2xxs14GCoOY896ixiQnf5e6ge3j+iATo1S4ped/hz4rq3JqNWkkXAPLWN7Fyf2B68LNrl9LOTsiu4ZpbrcNR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-618769020bcso56418407b3.3;
        Mon, 22 Apr 2024 23:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713855219; x=1714460019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ5EfW638x7TAtbwsyP2lwTKAYW7PkFolA3XCuVWREc=;
        b=IvMzRmXSIdSDLTVJ+n7W/QxI4QP9Q025RpcKNt56t7Qww15baq/vtG8Gfyg+w107Oq
         IwdSjaUgau87l/MTkeNEkVZSk7sKCht5EhIcwhdkXZXE71m32YI9S/UYyMgQ1Y950XTn
         +tA/jo6BHGUuZaVtXnlzPzmwIxsVy0zlbC7Ob6j/9SrQjqaARvryWLCrWfVVQwLhzkgV
         curBSQJIS3Ve/nVlKk6WtEgiSf48spAtMCYsY+kemNgtBSZPsL4L4hoR9mya/0yGv9+A
         YteRgTdJfg7hvLy+Dp55AjqsEiAcr6CHmoc/aTB4pWKeInIRYb5O6GURLQeDu6xaM/7j
         SUww==
X-Forwarded-Encrypted: i=1; AJvYcCUFYk3tWuEiSI92V/TvS7o1Gj5YJPE0fJzgOZVJL3oh8XnR29RkV1TYNSynj82Wo2imKRFjXHhxFtcNmb+hQkAYyZRptiPYTLpXA6yCPmd1BdDaFe0k0PNsYf3Z4ZBtdCFUXJkFiX3TSUURMe/MiUl4rrmgnKiYc/1L8NuQF+AMIP7nPcEq72RQf/NExZV12U0IUFBqiLD+4pIOOvO0ODxP7ckVBR82
X-Gm-Message-State: AOJu0Yw8gKZBmftpmiVxqz2PUMfKOSrfPxUrjbC4wSkqpIy7oU7466+4
	aK6cqFQe6mZjd8fojUNCVAxmRIgObhbSaJMoa7RsYvo8gxcfrkj0Tsu4FIvN
X-Google-Smtp-Source: AGHT+IGkf3p2iiW4ym9N8Q8DrtNkh9ztcDWLWg4vulScBDZxc1haKwbM82xVYBtYWDCrDwMpbavDVg==
X-Received: by 2002:a05:690c:368e:b0:61b:111b:f0ba with SMTP id fu14-20020a05690c368e00b0061b111bf0bamr13390440ywb.36.1713855219218;
        Mon, 22 Apr 2024 23:53:39 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id w63-20020a0dd442000000b0061ab76e5f4dsm2371068ywd.114.2024.04.22.23.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 23:53:39 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de46da8ced2so5166250276.0;
        Mon, 22 Apr 2024 23:53:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJVX44UvwDtG737QpkBuk7zq8yOMUzA64maDhrzUFn4MdRa5OZ2AEtfZ6/8iBZRmd9+BRQqOQJfgw8IrZEepEiZtcDfNOfC3qslabAwQYPCA6xvE2R7kvuwAj9LGoKduZlsnfRe1/+Ig0sOcBCvsc61aCqUaVY1wWHV8wBKYodGcFNQe0IN+9wM4cn63Ddma/qZiBz3OqE5BaUD5DfUNxvZowzfYzW
X-Received: by 2002:a25:f904:0:b0:dd0:c866:ec3a with SMTP id
 q4-20020a25f904000000b00dd0c866ec3amr1697417ybe.22.1713855218760; Mon, 22 Apr
 2024 23:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240422213006.505576-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240422213006.505576-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 08:53:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUmSp1JTADtnsTqExssP1h1pQSLDeMd5NkC=uSXC+javA@mail.gmail.com>
Message-ID: <CAMuHMdUmSp1JTADtnsTqExssP1h1pQSLDeMd5NkC=uSXC+javA@mail.gmail.com>
Subject: Re: [PATCH 3/6] mmc: renesas_sdhi: Add compatible string for RZ/G2L
 family, RZ/G3S, and RZ/V2M SoCs
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Mon, Apr 22, 2024 at 11:30=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> - RZ/G2UL and RZ/Five ("r9a07g043")
> - RZ/G2L(C) ("r9a07g044")
> - RZ/V2L ("r9a07g054")
> - RZ/G3S ("r9a08g045")
> - RZ/V2M ("r9a09g011")
>
> The above SoCs have HS400 disabled and use fixed address mode. Add a
> generic compatible 'renesas,rzg2l-sdhi' fallback string for these SoCs,
> where fixed_addr_mode and hs400_disabled quirks are applied.

Thanks for your patch!
>
> Note, 'renesas,sdhi-r9a09g011' is dropped as we will be using
> 'renesas,rzg2l-sdhi' as a fallback string for RZ/V2M SoC.

Doesn't that break backwards compatibility with existing DTBs?

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
> index 53d34c3eddce..1828c37e0198 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -210,7 +210,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_r=
8a77990 =3D {
>         .manual_tap_correction =3D true,
>  };
>
> -static const struct renesas_sdhi_quirks sdhi_quirks_r9a09g011 =3D {
> +static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l =3D {
>         .fixed_addr_mode =3D true,
>         .hs400_disabled =3D true,
>  };
> @@ -255,9 +255,9 @@ static const struct renesas_sdhi_of_data_with_quirks =
of_r8a77990_compatible =3D {
>         .quirks =3D &sdhi_quirks_r8a77990,
>  };
>
> -static const struct renesas_sdhi_of_data_with_quirks of_r9a09g011_compat=
ible =3D {
> +static const struct renesas_sdhi_of_data_with_quirks of_rzg2l_compatible=
 =3D {
>         .of_data =3D &of_data_rcar_gen3,
> -       .quirks =3D &sdhi_quirks_r9a09g011,
> +       .quirks =3D &sdhi_quirks_rzg2l,
>  };
>
>  static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_compat=
ible =3D {
> @@ -283,7 +283,7 @@ static const struct of_device_id renesas_sdhi_interna=
l_dmac_of_match[] =3D {
>         { .compatible =3D "renesas,sdhi-r8a77970", .data =3D &of_r8a77970=
_compatible, },
>         { .compatible =3D "renesas,sdhi-r8a77990", .data =3D &of_r8a77990=
_compatible, },
>         { .compatible =3D "renesas,sdhi-r8a77995", .data =3D &of_rcar_gen=
3_nohs400_compatible, },
> -       { .compatible =3D "renesas,sdhi-r9a09g011", .data =3D &of_r9a09g0=
11_compatible, },

Hence I think the above line should be kept, but changed to point
to &of_rzg2l_compatible.

> +       { .compatible =3D "renesas,rzg2l-sdhi", .data =3D &of_rzg2l_compa=
tible, },
>         { .compatible =3D "renesas,rcar-gen3-sdhi", .data =3D &of_rcar_ge=
n3_compatible, },
>         { .compatible =3D "renesas,rcar-gen4-sdhi", .data =3D &of_rcar_ge=
n3_compatible, },
>         {},

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

