Return-Path: <linux-kernel+bounces-32634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DF6835E36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7581281861
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5F39AD6;
	Mon, 22 Jan 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPoQZHAB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6ED39FC3;
	Mon, 22 Jan 2024 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915863; cv=none; b=SqITJMxMOvHiIxlH3OqBUJqAUEtD9X8O5mRlJZumV0oVZlMZ3bWDk4ZhUjYFX1IeTJkE5jDN/uVRCP4D449UItLDHEVDLZ9JX7nvUqm+A51llFYlFASIWlGONZP2XFbme8Eg1OVMHonLW116c+aQMm/VJ2qUw+bsVNELXImceNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915863; c=relaxed/simple;
	bh=AIhiGO2pL6YL5/8FWal1JwrM158QfKeYdL1vKMnTZPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCOwdikMhOBY1Pv1duDVbPF2fctNlEX326VpS3KiicqcP2ALSgPncdpBOxhfPWitESAZq9RsJ8usXHBJwuOAveyc4YDTag+V34Smj+dyixJmCTQeC/46Wim8wheqbNRGmv7o7iZYHUnN7JkssYaxPBBDDLEPnCQf6CNwmUKfX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPoQZHAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9243BC433C7;
	Mon, 22 Jan 2024 09:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705915863;
	bh=AIhiGO2pL6YL5/8FWal1JwrM158QfKeYdL1vKMnTZPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MPoQZHABUovfnv8cllS1GvIFkrdvrWFOt6YFZm5YtbRn2wRU/vEPkU1cWUOky/r6w
	 546jj7RfOAVLVYJdSHF+8bPkPgLMoITvBTjiH2K7h60KRWoYcpDFChch1lgLjHZ913
	 F7E8HoPI/vIWBYf7oH8e18dQz6o0iewL5AKH8gUNX/Z+03ylFAJXLjEPhVk4rcDpyA
	 lfYdB5sbnHaETgK/Wj+qyBd6S3z7yYcfVxNq7BZDJDhRoO2v7+uyfX5vccTE8zUwnT
	 sdaDJ+0whyjjB5ETn4TVB9WFnHOWUNFdRywtmWIC1APsaRg0Zro9yrFzv4FGtZNleb
	 VjVxq9rkRkrsg==
Date: Mon, 22 Jan 2024 09:30:58 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, han.xu@nxp.com,
	haibo.chen@nxp.com, yogeshgaur.83@gmail.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: support i.MX95 LPSPI
Message-ID: <20240122-mayday-yonder-dfc7f26709e4@spud>
References: <20240122091510.2077498-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ABRGMeYM8S8Rurjv"
Content-Disposition: inline
In-Reply-To: <20240122091510.2077498-1-peng.fan@oss.nxp.com>


--ABRGMeYM8S8Rurjv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 05:15:09PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX95 LPSPI compatible string, same as i.MX93 compatible with
> i.MX7ULP
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/D=
ocumentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> index 727c5346b8ce..2ff174244795 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> @@ -22,6 +22,7 @@ properties:
>            - enum:
>                - fsl,imx8ulp-spi
>                - fsl,imx93-spi
> +              - fsl,imx95-spi
>            - const: fsl,imx7ulp-spi
>    reg:
>      maxItems: 1
> --=20
> 2.37.1
>=20

--ABRGMeYM8S8Rurjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa410gAKCRB4tDGHoIJi
0mRuAP0W94bJ7qb+XyayMvaWptK0OKUlVz6f9KdQ4mrJFKzyIgEAgvNP019ZseEv
XHe5fEYuXoqdsvV6TII1tt32yBvHlQk=
=buFX
-----END PGP SIGNATURE-----

--ABRGMeYM8S8Rurjv--

