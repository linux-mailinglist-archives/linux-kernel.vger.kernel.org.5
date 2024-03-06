Return-Path: <linux-kernel+bounces-94381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4860873E4B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4952B281390
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5813E7F3;
	Wed,  6 Mar 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0N4GB3G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADE913D316;
	Wed,  6 Mar 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748753; cv=none; b=JHVPSLl/2x2jM2xb5CXedO23AIPmIBhu2ONy/WnDGqZgOKqEGbtRR3zoIR8fUnFitRMPHvamn9rrQpHCuYELfubp6sQKbiMm79fElGa4KAoV1marcW6enIpKV2EI7xVmQP1L963pJWHtokjDViL9CU9O/ck0LYc2uI3Pjf9GxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748753; c=relaxed/simple;
	bh=afwCLu3j1RMg8ttoPrRNYdyjhqT4Dte2nEoHL0A3CNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2zh9eYOq3/Px/gWRtWeJ+qehKv3MyhQi+LkkyR7HAwTPBc2qLSsik+OhEECO9zWmqB6yoMDB2MI1He/wZ+s6EXxeXXFTiyWkBADjWhKkHoAFwSxH6l2vp4Y+GmwEYlPaySzKAMNxZ73GY/jf2D6ALrH16eKp8HaBA5x9yp/fJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0N4GB3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F71C433C7;
	Wed,  6 Mar 2024 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709748752;
	bh=afwCLu3j1RMg8ttoPrRNYdyjhqT4Dte2nEoHL0A3CNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0N4GB3GV22GBKek7bbG86feaEL3jmUh6EnaDPWP60z+WzYa3bI5D6jW+Wbl6io3U
	 sYlPTYKUIEFvnB3WB6NqEE67FLtnU9ACNvnNvfl3UPeyOVYcVZyTD8jsplkk1za3fs
	 aLtnVUcFO+BAFmkLVgm5ckdOltUHa+CCtMcuQKYZgbzHPs3/TX3l/lWFdfhBWqBAVD
	 cojMK9y1JRSrQLotaJBYNGlxdgS+10BANvHmkpIkAkWOZ/IkgFRCeIuNbsTgd5pyTX
	 i73v+aO7o2Gj21FWAfvc2qWpMPZ55xKN74fRd7HFd6q4Tmn+gZsCX8HuNXf7RXeP7H
	 0DzaAOfIXv7LA==
Date: Wed, 6 Mar 2024 18:12:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: dumitru.ceclan@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dlechner@baylibre.com
Subject: Re: [PATCH v3 1/3] dt-bindings: adc: ad7173: add support for
 additional models
Message-ID: <20240306-pulsate-suspend-f88e6978ca7e@spud>
References: <20240306110956.13167-1-mitrutzceclan@gmail.com>
 <20240306110956.13167-2-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BtJ5XcjlTBKGRw+b"
Content-Disposition: inline
In-Reply-To: <20240306110956.13167-2-mitrutzceclan@gmail.com>


--BtJ5XcjlTBKGRw+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 01:09:54PM +0200, Dumitru Ceclan wrote:
> Add support for: AD7172-2, AD7175-8, AD7177-2.
> AD7172-4 does not feature an internal reference, check for external
>  reference presence.
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/iio/adc/adi,ad7173.yaml          | 39 +++++++++++++++++--
>  1 file changed, 36 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> index 36f16a325bc5..ea6cfcd0aff4 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -21,17 +21,23 @@ description: |
> =20
>    Datasheets for supported chips:
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-4.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7173-8.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7175-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7175-8.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7176-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7177-2.pdf
> =20
>  properties:
>    compatible:
>      enum:
>        - adi,ad7172-2
> +      - adi,ad7172-4
>        - adi,ad7173-8
>        - adi,ad7175-2
> +      - adi,ad7175-8
>        - adi,ad7176-2
> +      - adi,ad7177-2
> =20
>    reg:
>      maxItems: 1
> @@ -136,8 +142,10 @@ patternProperties:
>            refout-avss: REFOUT/AVSS (Internal reference)
>            avdd       : AVDD  /AVSS
> =20
> -          External reference ref2 only available on ad7173-8.
> -          If not specified, internal reference used.
> +          External reference ref2 only available on ad7173-8 and ad7172-=
4.
> +          Internal reference refout-avss not available on ad7172-4.
> +
> +          If not specified, internal reference used (if available).
>          $ref: /schemas/types.yaml#/definitions/string
>          enum:
>            - vref
> @@ -157,12 +165,17 @@ required:
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> =20
> +  # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
> +  # Other models have [0-3] channel registers
>    - if:
>        properties:
>          compatible:
>            not:
>              contains:
> -              const: adi,ad7173-8
> +              enum:
> +                - adi,ad7172-4
> +                - adi,ad7173-8
> +                - adi,ad7175-8
>      then:
>        properties:
>          vref2-supply: false
> @@ -177,6 +190,26 @@ allOf:
>              reg:
>                maximum: 3
> =20
> +  # Model ad7172-4 does not support internal reference
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad7172-4
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
> +            reg:
> +              maximum: 7
> +            adi,reference-select:
> +              enum:
> +                - vref
> +                - vref2
> +                - avdd
> +          required:
> +            - adi,reference-select
> +
>    - if:
>        anyOf:
>          - required: [clock-names]
> --=20
> 2.43.0
>=20

--BtJ5XcjlTBKGRw+b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeiyDAAKCRB4tDGHoIJi
0v0oAP9RjenSUIQ8qluKAZcJSEAowTF8Iwpd1QDeSRrttcsTDgD+P2JqWihqoQRX
zBTlCgh6bvQx3vrE9ot0b4bXc/eZhAQ=
=mxHT
-----END PGP SIGNATURE-----

--BtJ5XcjlTBKGRw+b--

