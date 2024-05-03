Return-Path: <linux-kernel+bounces-167526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F188BAAD5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98CB8B2296F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A8139587;
	Fri,  3 May 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSimArr3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624196AA1;
	Fri,  3 May 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732823; cv=none; b=VDQHteUsKYF6RZ1iAwK245pSQz7DnN/QuiUoxYjSeAD8mfZQVFjkKieNCezUkoppsYTzrwNurLH8aE63eVjD+o7093AKFr5zvoBb6F8fqp0GL0j5y81kJe+fbtKjdFaeEq0HF0ZaTik4PgcX40Fbm/MoyTSdN9VzhhIs0WzLwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732823; c=relaxed/simple;
	bh=HwTDULx37Hivyl033gJtCf+zwXB9XjlSfMV+ADfX2R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivnVMjsO3Y68x8Gk2NurPG9jkXbbBYf/XNByheYOgGNjSPP4yQEhAlL9RmWz5+MbherfcqQ3UaTjmMzUeY/9rTBFKY7Z6RaANX+h0sI2Ly6UkvTSIy1HHPYHfhF+lnAXP0PfhKdgSnmli1/eCHI2IzHmTzseDhyUolc9zJOwgbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSimArr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50E8C116B1;
	Fri,  3 May 2024 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714732822;
	bh=HwTDULx37Hivyl033gJtCf+zwXB9XjlSfMV+ADfX2R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cSimArr3h5HMGwFITZ05NcVzIiDIDgU0D4grxMiFIuv0D7p2lV1eQri4uCWaRU7zW
	 ySK+e0AUgYM7fszEq32bfTG0L/CjV3Q+YdXSnAK3RnM5vyt9VoLh5uPSs5pg1JSRV8
	 g4CaPgpXfbMr/p9OSviNzHxwgKGHOj8qDRsvMubzrLP56Sr9eRvA1NQXTeSzIPH8EW
	 MeLFLEcRgasif/XJkavoyWC4lZF4ryyXBtn5+pMe0wiZ5L24IlvqNtXpXX8bCq5okY
	 c3w0Sre3oAFRF41ihWTk0oDl9JF8TlmK5tM77kzv5w6nLelQ6UdxU+hZ7Jq7zdqJ4g
	 d77VtLvMbQwLw==
Date: Fri, 3 May 2024 11:40:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	valentina.fernandezalanis@microchip.com
Subject: Re: [PATCH 2/3] spi: dt-bindings: Add num-cs property for mpfs-spi
Message-ID: <20240503-gooey-distill-40e09638c082@spud>
References: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
 <20240502143410.12629-3-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RpCXvjDOjTtHu/S6"
Content-Disposition: inline
In-Reply-To: <20240502143410.12629-3-prajna.rajendrakumar@microchip.com>


--RpCXvjDOjTtHu/S6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 03:34:09PM +0100, Prajna Rajendra Kumar wrote:
> The PolarFire SoC SPI controller supports multiple chip selects,but in
> the MSS, only one CS line is physically wired. To reflect this hardware
> limitation in the device tree, the binding enforces that the 'num-cs'
> property defaults to 1 and cannot exceed 1 unless additional
> chip select lines are explicitly defined using GPIO descriptors.
>=20
> Fixes: 2da187304e55 ("spi: add bindings for microchip mpfs spi")
> Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> ---
>  .../bindings/spi/microchip,mpfs-spi.yaml      | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yam=
l b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> index 74a817cc7d94..19951951fdd6 100644
> --- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> @@ -13,9 +13,6 @@ description:
>  maintainers:
>    - Conor Dooley <conor.dooley@microchip.com>
> =20
> -allOf:
> -  - $ref: spi-controller.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -43,6 +40,22 @@ required:
>    - interrupts
>    - clocks
> =20
> +allOf:
> +  - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microchip,mpfs-spi
> +      not:
> +        required:
> +          - cs-gpios
> +    then:
> +      properties:
> +        num-cs:
> +          default: 1
> +          maximum: 1

I think this isn't quite right actually. The default for num-cs should
be 1, regardless of whether cs-gpios are used or not, only the maximum
is affected by using GPIOs for chip select.

> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.25.1
>=20

--RpCXvjDOjTtHu/S6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjS/EgAKCRB4tDGHoIJi
0gUKAQCnSigafjhVUe3GHPm6zS2lCDzCAuS4IBfpgkSpfFBarwD/SbdHQKZYcw3w
D2Nz5ZJzoYFiIZKxzyWEK7CqQHUspQw=
=yaL9
-----END PGP SIGNATURE-----

--RpCXvjDOjTtHu/S6--

