Return-Path: <linux-kernel+bounces-94312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93398873CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44CD1C22F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63113E7C0;
	Wed,  6 Mar 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VX+uZX7x"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638113C9F5;
	Wed,  6 Mar 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744720; cv=none; b=bzrB8qHuBm8r723gXXlQYwxDIP8sfgL+W8wwZVp7R+qw/g3sCvfEDYgVd1hrHU4Ufuh5lugHdVz/7RqIJ82GrQ1sn09XSx3hKVkfYdgfMSvqxuub7NGVYt/s/wGZEOgUAVsYXgAch947wbISk+eH2lMgkgb3AUYfupflU+QemK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744720; c=relaxed/simple;
	bh=pF2s3i3reDHDZmh/M6AbVMstX1uKJb42NVyBEJK/0T8=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=cEkNKKvwPks9V5H+dPpYqtFlL9mrFyBfybRSgnuPNyoN99Ew+WQYx4HJLDY5O4kQtQ3b5CPwiweR8VqV5GEE1daqqHkmCMQikOF+8IjLM2UmNWIB18hM7m+YqCrOkGi5jlKYI//srXHuepb6k6DSsSbBLavBcE6knMeiOjHkaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VX+uZX7x; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BE45122A;
	Wed,  6 Mar 2024 18:04:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709744698;
	bh=pF2s3i3reDHDZmh/M6AbVMstX1uKJb42NVyBEJK/0T8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VX+uZX7xEe9xfRQHj1mV+V3bF00MLoeB+gj4hvaB10X2xZQ1r10n8KLgFKK4Z7kla
	 /PiygMmykVImjTImZ2c9WQ7LMnn/D835p+mvVo6KuHXEfBmBl6k1tlvoxgZqQpY6vF
	 HFZ/da3RfeKb2nqXuTgLpCksaUQ/crFKJXt7WMs8=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240306081038.212412-5-umang.jain@ideasonboard.com>
References: <20240306081038.212412-1-umang.jain@ideasonboard.com> <20240306081038.212412-5-umang.jain@ideasonboard.com>
Subject: Re: [PATCH 4/5] media: imx335: Fix active area height discrepency
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Alexander Shiyan <eagle.alexander923@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Umang Jain <umang.jain@ideasonboard.com>
To: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org
Date: Wed, 06 Mar 2024 17:05:13 +0000
Message-ID: <170974471357.362031.9683522744235199514@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Umang Jain (2024-03-06 08:10:37)
> The imx335 reports a recommended pixel area of - 2592x1944.
> The driver supported mode however limits it to height=3D1940.

Hrm, I think I would convert widths and sizes to decimal as a patch
before this patch so the effect is clearer in this diff.

> Fix the height discrepency by correctly the value of height
> (with updates to vblank and mode registers).
>=20
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index 6ea09933e47b..c00e0c2be3f3 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -246,13 +246,13 @@ static const int imx335_tpg_val[] =3D {
>  };
> =20
>  /* Sensor mode registers */
> -static const struct cci_reg_sequence mode_2592x1940_regs[] =3D {
> +static const struct cci_reg_sequence mode_2592x1944_regs[] =3D {
>         {IMX335_REG_MODE_SELECT, 0x01},
>         {IMX335_REG_MASTER_MODE, 0x00},
> -       {IMX335_REG_WINMODE, 0x04},
> -       {IMX335_REG_HTRIMMING_START, 0x0180},
> +       {IMX335_REG_WINMODE, 0x00},

What's the distinction of the winmode here. What is 0x04 vs 0x00?

Is this something that could be a defined value? Or is that not worth
the effort?

> +       {IMX335_REG_HTRIMMING_START, 0x30},

HTRIMMING_START has moved a lot more than I would expect there.
Is there a visual impact of any concern here?

>         {IMX335_REG_HNUM, 0x0a20},
> -       {IMX335_REG_Y_OUT_SIZE, 0x0794},
> +       {IMX335_REG_Y_OUT_SIZE, 0x0798},

This bit looks expected ;-)

>         {IMX335_REG_VCROP_POS, 0x00b0},
>         {IMX335_REG_VCROP_SIZE, 0x0f58},

0x0f58 =3D 3928. Does that correspond to anything on the pixel array size?
We're modifying the vertical size, so I'm curious if the 'vcrop' is or
should be impacted?

>         {IMX335_REG_OPB_SIZE_V, 0x00},
> @@ -403,14 +403,14 @@ static const u32 imx335_mbus_codes[] =3D {
>  /* Supported sensor mode configurations */
>  static const struct imx335_mode supported_mode =3D {
>         .width =3D 2592,
> -       .height =3D 1940,
> +       .height =3D 1944,
>         .hblank =3D 342,
> -       .vblank =3D 2560,
> -       .vblank_min =3D 2560,
> +       .vblank =3D 2556,
> +       .vblank_min =3D 2556,
>         .vblank_max =3D 133060,
>         .reg_list =3D {
> -               .num_of_regs =3D ARRAY_SIZE(mode_2592x1940_regs),
> -               .regs =3D mode_2592x1940_regs,
> +               .num_of_regs =3D ARRAY_SIZE(mode_2592x1944_regs),
> +               .regs =3D mode_2592x1944_regs,
>         },
>  };
> =20
> --=20
> 2.43.0
>

