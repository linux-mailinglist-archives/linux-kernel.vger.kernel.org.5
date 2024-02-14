Return-Path: <linux-kernel+bounces-65725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDE8550DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E022EB22AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9761272C8;
	Wed, 14 Feb 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+A8JqIH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6364CCE;
	Wed, 14 Feb 2024 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933273; cv=none; b=bCeQSysirG38JiUPsmMJp1xaq8XAwuEBbgYrzNzlESkhqA7xZbpcKn9jUMyLsWO0E1LWnvxbGAumCvYrJi/+Z3VuNh80kT78GJGAz9NJQj9wOZN0unXHp+x+ti8AE3hnqt97sx6EGI9WXexx9Xe2A2qEaUkteY7ya0EHmEgBw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933273; c=relaxed/simple;
	bh=ZTeQV27LyiWxhDtHvAK8nA1pMIO1NH+Bi7YkTdMe1Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEaG7+3+aJ3mXSE3ZxNE+QDvC3e/NWvSLMXHJT/4Tl4AbTInNrQ5o7dzhfQHX/yUZQnsvsUi70tp7UzsEYuliqOF1IJ6oZWvxLFkFbVlBWEz9JCwS4dV2CnjGMOCDYqa2Ao/oQmakJuFy10ZrH4uL4UJLpNymCIXva5HzKO8XgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+A8JqIH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161EFC43390;
	Wed, 14 Feb 2024 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933271;
	bh=ZTeQV27LyiWxhDtHvAK8nA1pMIO1NH+Bi7YkTdMe1Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+A8JqIHfa1E7pwjzgdiEZ9CjIGzy8gR8nzllyIV+xKO9W75Qa0joiLYavYkuERQN
	 ollX9l2H04JjvxyAHukxkwSzA0tfvqUe2qI1EOPVeDMN4pdnT7N7abb+lLNXQGe0BA
	 1SmpexPHgOE1PhF4a45Mq3LERnkNh37z0zr5yTMPtJH7xUHt5F8hdbd1CALu/NGMmU
	 SybUUusGxx6jvkaEZl+sRMJkzsOVB9AKK2IJtsqNaY6u7flnUMa1ZvKoJktHDIzY/S
	 1uLzzgiEOvk4JsnRc98awQmCwBIrKj8Bz+Pd3wg/zGx/QHevq1AaTVfN3VzvMaqW5A
	 UKOZy3wHVSPiw==
Date: Wed, 14 Feb 2024 17:54:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Mihai Sain <mihai.sain@microchip.com>
Cc: claudiu.beznea@tuxon.dev, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	andre.przywara@arm.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	cristian.birsan@microchip.com
Subject: Re: [PATCH v2 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Message-ID: <20240214-robe-pregnancy-a1b056c9fe14@spud>
References: <20240214080348.7540-1-mihai.sain@microchip.com>
 <20240214080348.7540-3-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7w97PXK10Ag2OJm"
Content-Disposition: inline
In-Reply-To: <20240214080348.7540-3-mihai.sain@microchip.com>


--i7w97PXK10Ag2OJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:03:47AM +0200, Mihai Sain wrote:
> Add flexcom 10 node for usage on the SAMA7G54 Curiosity board.
>=20
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  arch/arm/boot/dts/microchip/sama7g5.dtsi | 26 ++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts=
/microchip/sama7g5.dtsi
> index 269e0a3ca269..c90e404e8ed9 100644
> --- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
> @@ -958,6 +958,32 @@ i2c9: i2c@600 {
>  			};
>  		};
> =20
> +		flx10: flexcom@e2820000 {
> +			compatible =3D "atmel,sama5d2-flexcom";
> +			reg =3D <0xe2820000 0x200>;

This is a sama7g5, how come this flexcom is using a sama5d2 compatible?

Cheers,
Conor.

> +			clocks =3D <&pmc PMC_TYPE_PERIPHERAL 48>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges =3D <0x0 0xe2820000 0x800>;
> +			status =3D "disabled";
> +
> +			i2c10: i2c@600 {
> +				compatible =3D "microchip,sama7g5-i2c", "microchip,sam9x60-i2c";
> +				reg =3D <0x600 0x200>;
> +				interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +				clocks =3D <&pmc PMC_TYPE_PERIPHERAL 48>;
> +				atmel,fifo-size =3D <32>;
> +				dmas =3D <&dma0 AT91_XDMAC_DT_PERID(25)>,
> +					<&dma0 AT91_XDMAC_DT_PERID(26)>;
> +				dma-names =3D "rx", "tx";
> +				atmel,use-dma-rx;
> +				atmel,use-dma-tx;
> +				status =3D "disabled";
> +			};
> +		};
> +
>  		flx11: flexcom@e2824000 {
>  			compatible =3D "atmel,sama5d2-flexcom";
>  			reg =3D <0xe2824000 0x200>;
> --=20
> 2.43.0
>=20

--i7w97PXK10Ag2OJm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcz+UgAKCRB4tDGHoIJi
0uiBAP9sCfWXzDmB20GQqPgUx21MD2Wufjy5otnUOVcS3lrfHwEAnup1ChedOWaD
nqbRyjVqCuvpc2j/lqTpMnNgspprFwg=
=Rbar
-----END PGP SIGNATURE-----

--i7w97PXK10Ag2OJm--

