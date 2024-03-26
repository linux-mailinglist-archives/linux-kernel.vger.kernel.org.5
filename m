Return-Path: <linux-kernel+bounces-118859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B91288C060
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D892C34B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4513252F74;
	Tue, 26 Mar 2024 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bO29NbXc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B51345022
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451742; cv=none; b=PvwWWlbaL0kxk25AH93a3vdeO2dMR5SUcGPPFTFRdqNMucqizT9jJbhE0aR3ylQJJbw5XjA/DPsc0elL4MYTUDzmEMjKfnERAYOkqAVu7VIAVIj0VTZ7bH93al3PzTezhMxeytIixTxEsA3Etl3L2J3tK8C9qCL9wIQACw4ry2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451742; c=relaxed/simple;
	bh=p0SP+3hWz6lk8cCE7sf3j9Xgizc96y3imCYOUoZL1O0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=dWwiDXORL+VFsqx8ritNGuZEHgcbMESqokqh72TjXVLzyXLWtrkKtGWwLsMJsx6oBW1pOCJpaIpc2VKk4B8Nwp7PiHReitpu9tKEIsMhDeUzV1JDLnEthOoXlm/ksbsy5PhnyC2g1uUzDUV50h+/iaeayQ3b4rG7slNC6uDEpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bO29NbXc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E3C91497;
	Tue, 26 Mar 2024 12:15:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711451707;
	bh=p0SP+3hWz6lk8cCE7sf3j9Xgizc96y3imCYOUoZL1O0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=bO29NbXcyi6c8nEimTRS6uwmhTD+Pn8RY9rGvw3/jL9OXOJY9AO+/JWxo+ntB6A5R
	 0NNy/2pCtYUUVGbzNcHpls4ZfalMSTvwl4pgMoP0F8VEUdgBWtXYQIuBasjKCgqr00
	 yKHvnheJkotIct/IfxfqcWY2ZIpmcO7AsLgzX2Ts=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240319072712.133449-6-umang.jain@ideasonboard.com>
References: <20240319072712.133449-1-umang.jain@ideasonboard.com> <20240319072712.133449-6-umang.jain@ideasonboard.com>
Subject: Re: [PATCH v3 5/6] media: imx335: Fix active area height discrepency
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>
To: Alexander Shiyan <eagle.alexander923@gmail.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Umang Jain <umang.jain@ideasonboard.com>, open list <linux-kernel@vger.kernel.org>
Date: Tue, 26 Mar 2024 11:15:34 +0000
Message-ID: <171145173466.1011926.14195824080886002217@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Umang Jain (2024-03-19 07:27:11)
> The imx335 reports a recommended pixel area of - 2592x1944.
> The driver supported mode however limits it to height=3D1940.
>=20
> Fix the height discrepency by correctly the value of height
> (with updates to vblank and mode registers).

"Fix the height discrepency by correcting the Y_OUT_SIZE,
HTRIMMING_START, and changing the WINMODE, followed by the corresponding
updates to reflect the new minimum vblanking periods."

I'm curious though - why does IMX335_REG_HTRIMMING_START jump /so/ much
here? Something to do with the WINMODE change?


Because I've seen this works and with the optional update to the commit
message:

Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

>=20
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index 7609dbc537b1..10a09830dbd6 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -247,13 +247,13 @@ static const int imx335_tpg_val[] =3D {
>  };
> =20
>  /* Sensor mode registers */
> -static const struct cci_reg_sequence mode_2592x1940_regs[] =3D {
> +static const struct cci_reg_sequence mode_2592x1944_regs[] =3D {
>         {IMX335_REG_MODE_SELECT, 0x01},
>         {IMX335_REG_MASTER_MODE, 0x00},
> -       {IMX335_REG_WINMODE, 0x04},
> -       {IMX335_REG_HTRIMMING_START, 384},
> +       {IMX335_REG_WINMODE, 0x00},
> +       {IMX335_REG_HTRIMMING_START, 48},
>         {IMX335_REG_HNUM, 2592},
> -       {IMX335_REG_Y_OUT_SIZE, 1940},
> +       {IMX335_REG_Y_OUT_SIZE, 1944},
>         {IMX335_REG_AREA3_ST_ADR_1, 176},
>         {IMX335_REG_AREA3_WIDTH_1, 3928},
>         {IMX335_REG_OPB_SIZE_V, 0},
> @@ -404,15 +404,15 @@ static const u32 imx335_mbus_codes[] =3D {
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
>         .pclk =3D 396000000,
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

