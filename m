Return-Path: <linux-kernel+bounces-33886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B280836FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD00A2866C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864152F8A;
	Mon, 22 Jan 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p31vfK3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259553E18;
	Mon, 22 Jan 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946482; cv=none; b=jUTVN4XEe5txGtljnv7JSSLWWHAqnjwpiJXLSJvAcrJNBXAhN35lfv0V02jwYXdkFp8z2pI2A9ANfQiMEI9KfPP/dWITrSSE5q8M8JD0oo+73/RasEYQy7pBRijLS2kVNV29eLS7cGBHrSBSwW71GAouRFMrNP+7QpRkttu7vhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946482; c=relaxed/simple;
	bh=oEbbC2q8F+AF5T397yDBPdDm6rnnpagXKXo3DxyprZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pu4eVOasi3zcTobfqyHSJ65aSDnzqX/yGrkWMe7/8j4R0sZB/M5dql8sXuim1oOVzMkFPrAhoOUoLnqdk7uSe0nkUmXm0vvHT5J0Zh5aVYGoXQxztD4ps3kliLkBVOsmTqa1qTG0Tr633IhX5GwueHsBD2iEAh2WPo6xWw+6MFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p31vfK3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5793C43390;
	Mon, 22 Jan 2024 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705946481;
	bh=oEbbC2q8F+AF5T397yDBPdDm6rnnpagXKXo3DxyprZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p31vfK3SVEwVWGy0cxtiYygJLuWHKJBYZu7xOHxVjG8KP+mp3Uvi3Y/6pJ1jo1Cp0
	 biFPvU5XjWR/c8YkX5BEdpY3t59I6rW/TCGwe2VPVlboWGtV4gihKee2N95GDIkp+L
	 XhlgkAGmHCZCVaPvXDkUpkVZQ2bldl+UmdV5s4iCaQB9x6b2FdMDNJsDsqDqhq4kDO
	 RYvan+wEjYsmLppfsMxuJ+9ywQeI4a5bag4vgsMazZtQ1HlLSZCQeQztlh4hn8+4Rx
	 kSHKQJTtfT1PYnxs5Tl7SeN9FnaxpuIVH4Lgb43FVHVRkXwzShZYXymmF3oiPdTddT
	 ttSYie78V8X3A==
Date: Mon, 22 Jan 2024 18:01:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] dt-bindings: gpio: gpio-vf610: add gpio-line-names
Message-ID: <20240122-earmuff-naming-b3a09908d14a@spud>
References: <20240122095306.14084-1-othacehe@gnu.org>
 <20240122095306.14084-3-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vjIPSd7XCLzMGIkr"
Content-Disposition: inline
In-Reply-To: <20240122095306.14084-3-othacehe@gnu.org>


--vjIPSd7XCLzMGIkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:53:05AM +0100, Mathieu Othacehe wrote:
> Describe common "gpio-line-names" property to fix dtbs_check warnings
> like:
>=20
> /home/mathieu/linux/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dt=
b:
> gpio@43830000: 'gpio-line-names' does not match any of the regexes:
> '^.+-hog(-[0-9]+)?$', 'pinctrl-[0-9]+' from schema $id:
> http://devicetree.org/schemas/gpio/gpio-vf610.yaml#
>=20
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Doc=
umentation/devicetree/bindings/gpio/gpio-vf610.yaml
> index a27f92950257..7230ba1a386a 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> @@ -50,6 +50,7 @@ properties:
>      const: 2
> =20
>    gpio-controller: true
> +  gpio-line-names: true
> =20
>    clocks:
>      items:
> --=20
> 2.41.0
>=20

--vjIPSd7XCLzMGIkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6tawAKCRB4tDGHoIJi
0u47APwMrEzzVWM0oQscLmV+zo/2+o2UzPHxSk3CEgmvDLnVGwEA8bDPZyO2/lhI
DGlTeOilh65nzS752iylG9w07c5a5wY=
=xD75
-----END PGP SIGNATURE-----

--vjIPSd7XCLzMGIkr--

