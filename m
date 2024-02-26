Return-Path: <linux-kernel+bounces-81901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB56A867C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18DBB1C2B3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4437D12F382;
	Mon, 26 Feb 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7H+L9C8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7905E12D766;
	Mon, 26 Feb 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964693; cv=none; b=dhMtJL1OeNs0uOGd2bfb47glNJzWKZKBZmNv/ir3cuO+PURMNwdDSnWnbI681vHKgnNYYDP8DsRVgVV+MIopSRYKitnpXQpfIp3Gs4xbzUy7j0BPcWWWW+8bjCDwpwey4M7sNBo3hLDDSZdsaJVdseY3xpS5tR7xsMacNlmp3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964693; c=relaxed/simple;
	bh=xA7rJ3U9BuNcjzyN+hOIyJEDKeHkmFiAgGybOThfT6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBRWxdzw8Mv5OrQ1tGoEKnETEQfLnyMjTveYt+uKE55axgOwFiRJyoaAo8fAE9NTAWgcVBuEdnPxIRox/IwL9ta8JXbK+QxwFxhF0J2/s5ogSONGW8AjvCwsSy4nhC9l1eFodX0jkfSyHjoUxIbOHmWQNCs2p9T38ZTDWz9inWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7H+L9C8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94D1C43390;
	Mon, 26 Feb 2024 16:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708964693;
	bh=xA7rJ3U9BuNcjzyN+hOIyJEDKeHkmFiAgGybOThfT6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H7H+L9C8w5vx49N2lLinQDgZHOIrLm/m+T4KikquLtF1IHtBQlNWW8OuCqWd80p3/
	 sekPxizzUUd20P8CNQ/yO6jEwQM5CXyFGkYdyCKefG5u0acChlxWTTk+30A69ZNtnR
	 vfgQ6JEN8FPqKk7zmByDSil2/9FClpM9nEtseDhJsU6BQgAYVfWgNYEnr25LaEuPwk
	 I7dOYSTZ6u0p2umXFQRByIGuOdMMgGrD/DnvYChXM/tnB7fuoFrqkaIO7CzuPnSqiq
	 IFDZD8918rPMfywzYD0btMEdQdlU9kqG7nBfv2pHxPE7zl3t/esuL5KSAHNkF9olXM
	 T/RIHBOIx9tLw==
Date: Mon, 26 Feb 2024 16:24:47 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: haibo.chen@nxp.com, jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: drop the 4th interrupt
Message-ID: <20240226-germinate-anymore-fb85ca9bb226@spud>
References: <20240226130826.3824251-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KDf/GB9r/eUFTniC"
Content-Disposition: inline
In-Reply-To: <20240226130826.3824251-1-peng.fan@oss.nxp.com>


--KDf/GB9r/eUFTniC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 09:08:25PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Per i.MX93 Reference Mannual Rev.4, 12/2013, there is no interrupt 268,
> so drop it.

Don't just remove it from the example, drop it from the binding too?
It does permit a 4th "self testing" interrupt.

Thanks,
Conor.

>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml=
 b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> index dacc526dc695..dfc3f512918f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> @@ -31,7 +31,6 @@ properties:
>        - description: normal conversion, include EOC (End of Conversion),
>            ECH (End of Chain), JEOC (End of Injected Conversion) and
>            JECH (End of injected Chain).
> -      - description: Self-testing Interrupts.
> =20
>    clocks:
>      maxItems: 1
> @@ -70,8 +69,7 @@ examples:
>              reg =3D <0x44530000 0x10000>;
>              interrupts =3D <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
>                           <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
> -                         <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
> +                         <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
>              clocks =3D <&clk IMX93_CLK_ADC1_GATE>;
>              clock-names =3D "ipg";
>              vref-supply =3D <&reg_vref_1v8>;
> --=20
> 2.37.1
>=20

--KDf/GB9r/eUFTniC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdy7TwAKCRB4tDGHoIJi
0jiBAP47uO3KUowK4k4Q2P4b5rgtZ/Y4YuZ79RpRL0Rb4+E1jAD/deGLacfUyxqF
xY7kk9/vNJWngdQW7RU/N6r/w/U/LgE=
=oLVV
-----END PGP SIGNATURE-----

--KDf/GB9r/eUFTniC--

