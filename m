Return-Path: <linux-kernel+bounces-136445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA0C89D422
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99EF284A87
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707967EEF2;
	Tue,  9 Apr 2024 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbH3Hfeg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8417E119;
	Tue,  9 Apr 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712650786; cv=none; b=UFe4OLVDntkkEnXeKpMJ5yrkmKMkptkSKX3wxDlVxfudOxLSliw9QWqxfLko81+Amo0iM0PIqbt2Mk0q4dylG6+kN0ggvnkLSInBmBjkGvroZ7ztsldaawjTj/av6bdYwU3rjj3t/zAR2mmrICm6pqsFPojNTQ9GVmsAGzDtAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712650786; c=relaxed/simple;
	bh=zvaQmIW25IHYVY8ZOdI704qDj0s6SsNEJOw9PPj4dVo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=NrEYLDNunsYpr35P3+yydRG/+J6KJ23VkQxQ8s+EVFsFR1iRKwroetqsxlmAOzbaUzbz31ofCUxx61PmsJGFNELNEGV/1aGPMANQ8PKDUdiV0yKNLyc2pHkgJZR+PVNjUA7aTOnBva8TexleNzh46LHAoM2j8aTgS2ljXx9zexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbH3Hfeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7435FC433F1;
	Tue,  9 Apr 2024 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712650786;
	bh=zvaQmIW25IHYVY8ZOdI704qDj0s6SsNEJOw9PPj4dVo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=TbH3HfegiU2N9f4AmivJmhmp1q4mI5aFr3TlAUAEvU0eAmRWFyioHZ7ilBUkDBUbH
	 RaAOEw8b24gCJMTAo4/+hfmEYoRhpgVr9l6SP6R7VaADQU7UWP2jEZHGz8g5fwMuAK
	 THq0oP4nEJI6vhDpo7XsT+zobzy/E0l3mBhVrEyQMBcOMpm2JEjgoGQkXZu6A9wcee
	 PycR+KdgPVduoifItRM290bq+8akFg+253765Qbnh1PwdblLb2c8FB0zJji3xhMA9c
	 vyije/4dxp81uwmIo2nAAK5sSHJqiOv3uknHZ9NBujXmtanE9e/QfUXtmrgVbGdvQG
	 a4T0enXwMcS7Q==
Message-ID: <a5595ba92a3d65a222398824b09d7d37.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240306180435.1033052-1-catalin.popescu@leica-geosystems.com>
References: <20240306180435.1033052-1-catalin.popescu@leica-geosystems.com>
Subject: Re: [PATCH next] clk: rs9: fix wrong default value for clock amplitude
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de, Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>, mturquette@baylibre.com, Biju Das <biju.das.jz@bp.renesas.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Date: Tue, 09 Apr 2024 01:19:44 -0700
User-Agent: alot/0.10

Quoting Catalin Popescu (2024-03-06 10:04:35)
> According to 9FGV0241 & 9FGV0441 datasheets, the default value
> for the clock amplitude is 0.8V, while the driver was assuming
> 0.7V.
>=20
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---

Adding folks who seem to know about this than me.

-Stephen

>  drivers/clk/clk-renesas-pcie.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pci=
e.c
> index 53e21ac302e6..4c3a5e4eb77a 100644
> --- a/drivers/clk/clk-renesas-pcie.c
> +++ b/drivers/clk/clk-renesas-pcie.c
> @@ -25,10 +25,12 @@
>  #define RS9_REG_SS_AMP_0V7                     0x1
>  #define RS9_REG_SS_AMP_0V8                     0x2
>  #define RS9_REG_SS_AMP_0V9                     0x3
> +#define RS9_REG_SS_AMP_DEFAULT                 RS9_REG_SS_AMP_0V8
>  #define RS9_REG_SS_AMP_MASK                    0x3
>  #define RS9_REG_SS_SSC_100                     0
>  #define RS9_REG_SS_SSC_M025                    (1 << 3)
>  #define RS9_REG_SS_SSC_M050                    (3 << 3)
> +#define RS9_REG_SS_SSC_DEFAULT                 RS9_REG_SS_SSC_100
>  #define RS9_REG_SS_SSC_MASK                    (3 << 3)
>  #define RS9_REG_SS_SSC_LOCK                    BIT(5)
>  #define RS9_REG_SR                             0x2
> @@ -205,8 +207,8 @@ static int rs9_get_common_config(struct rs9_driver_da=
ta *rs9)
>         int ret;
> =20
>         /* Set defaults */
> -       rs9->pll_amplitude =3D RS9_REG_SS_AMP_0V7;
> -       rs9->pll_ssc =3D RS9_REG_SS_SSC_100;
> +       rs9->pll_amplitude =3D RS9_REG_SS_AMP_DEFAULT;
> +       rs9->pll_ssc =3D RS9_REG_SS_SSC_DEFAULT;
> =20
>         /* Output clock amplitude */
>         ret =3D of_property_read_u32(np, "renesas,out-amplitude-microvolt=
",
> @@ -247,13 +249,13 @@ static void rs9_update_config(struct rs9_driver_dat=
a *rs9)
>         int i;
> =20
>         /* If amplitude is non-default, update it. */
> -       if (rs9->pll_amplitude !=3D RS9_REG_SS_AMP_0V7) {
> +       if (rs9->pll_amplitude !=3D RS9_REG_SS_AMP_DEFAULT) {
>                 regmap_update_bits(rs9->regmap, RS9_REG_SS, RS9_REG_SS_AM=
P_MASK,
>                                    rs9->pll_amplitude);
>         }
> =20
>         /* If SSC is non-default, update it. */
> -       if (rs9->pll_ssc !=3D RS9_REG_SS_SSC_100) {
> +       if (rs9->pll_ssc !=3D RS9_REG_SS_SSC_DEFAULT) {
>                 regmap_update_bits(rs9->regmap, RS9_REG_SS, RS9_REG_SS_SS=
C_MASK,
>                                    rs9->pll_ssc);
>         }
>=20
> base-commit: 61996c073c9b070922ad3a36c981ca6ddbea19a5
> prerequisite-patch-id: 0000000000000000000000000000000000000000
> --=20
> 2.34.1
>

