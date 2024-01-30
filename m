Return-Path: <linux-kernel+bounces-45035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4252E842ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68701F27559
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F89129A87;
	Tue, 30 Jan 2024 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs+/G0Zi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B871292D0;
	Tue, 30 Jan 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635397; cv=none; b=cjb+3gDwAd06cRpllP0eMkmvU4L3Ph+vAjeIqWnjNlzk2Rl+7EH+ABxxgZ6o0FdLvgrboayoYNXYPzxXELWuETI006KjCKblWwxy9nJCf0C8L2DNdito3yN+szdvKu7jREGtaTMxdhw0Cl7OjjvvHUx6cLI1b5FKCD9yU60Ap40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635397; c=relaxed/simple;
	bh=VRfD3UKkyqM3D52QPTjY/kGlTpnyKjRRfLoiCClFqCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxagt4eybrHzEgGddip/1JE01dhtRK1XnT8DRRpOL/4DZ0Zt4FER69Brm6UwC9jXgSj7pJzIJyFWYJLiNEz8iaNxzmKgMorvDM78qfatMd+oWClkwKhwDtlJs9zGIO3GyEZmT1iQdxxduuUToqpQh7obVg+72AFYbhtjZaufd/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs+/G0Zi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BA3C433F1;
	Tue, 30 Jan 2024 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706635397;
	bh=VRfD3UKkyqM3D52QPTjY/kGlTpnyKjRRfLoiCClFqCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xs+/G0ZidSLCDpXPjUUl21Mh+E7xeHzv2SztdWr03WvUMz+qGUFiUwjkoollpGW4J
	 dKEJCj6PF/MK60GsUMAv0l1yiyaChw1MZRYS+LV3oQsF7SGOqTcyGXhL/lnWrQOJzm
	 lf24A8ULGBW8zVRzdwXWdhEn5BXG/p2EY5z47whD3e4XXcp0y2XIygPwvYGC4UfHhN
	 SQDEkOpnkNz/W2LzNQCilnR4FTe+gCgA8I224x/9UvymXc24T4rlKzqIUd0mkNMMH9
	 ByoDJjqMw7FCZIeBwFRy6WRqHjesUamxpm7cgpDaKITcLNUsg0Rjhrgd4QkZaeggHL
	 tq63LRH8zgBDA==
Date: Tue, 30 Jan 2024 17:23:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, mazziesaccount@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: afe: voltage-divider: Add
 io-channel-cells
Message-ID: <20240130-abroad-repeater-7966f998e1f6@spud>
References: <20240130115651.457800-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="toQvdWVCqzr+Zex9"
Content-Disposition: inline
In-Reply-To: <20240130115651.457800-1-naresh.solanki@9elements.com>


--toQvdWVCqzr+Zex9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Jan 30, 2024 at 05:26:50PM +0530, Naresh Solanki wrote:
> voltage-divider is always an iio consumer at the same time it is
> optionally an iio provider.
> Hence add #io-channel-cells
> Also update example.
>=20
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  .../bindings/iio/afe/voltage-divider.yaml          | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.ya=
ml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> index dddf97b50549..98fec8548cc3 100644
> --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> @@ -39,6 +39,13 @@ properties:
>      description: |
>        Channel node of a voltage io-channel.
> =20
> +  '#io-channel-cells':
> +    description:
> +      In addition to consuming the measurement services of a voltage out=
put
> +      channel the voltage divider can act as a provider of measurement
> +      services to other devices.

Did you miss:
https://lore.kernel.org/all/20240127165542.6eeb23e9@jic23-huawei/
Where I said that I would like to have an example of where this would be
used in the description? Peter gave a good example that you can draw on.

> +    const: 1
> +
>    output-ohms:
>      description:
>        Resistance Rout over which the output voltage is measured. See ful=
l-ohms.
> @@ -75,12 +82,17 @@ examples:
>              spi-max-frequency =3D <1000000>;
>          };
>      };
> -    sysv {
> +    p12v_vd: sysv {
>          compatible =3D "voltage-divider";
>          io-channels =3D <&maxadc 1>;
> +        #io-channel-cells =3D <1>;
> =20
>          /* Scale the system voltage by 22/222 to fit the ADC range. */
>          output-ohms =3D <22>;
>          full-ohms =3D <222>; /* 200 + 22 */
>      };

Blank line here please.

Thanks,
Conor.

> +    iio-hwmon {
> +        compatible =3D "iio-hwmon";
> +        io-channels =3D <&p12v_vd 0>;
> +    };
>  ...
>=20
> base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
> --=20
> 2.42.0
>=20

--toQvdWVCqzr+Zex9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbkwgAAKCRB4tDGHoIJi
0jh0AQCf42G+DhRYSRloF1zdFV1JWBEczufKUo+D/M8fqdW7EAEAgG/RyQdQq3a2
vGwwXqVD8ZruqcgkkjX7oJJIcPhIcwE=
=t3ag
-----END PGP SIGNATURE-----

--toQvdWVCqzr+Zex9--

