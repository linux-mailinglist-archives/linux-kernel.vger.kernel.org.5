Return-Path: <linux-kernel+bounces-105403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F4587DD6D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA33B20BA4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AB41B810;
	Sun, 17 Mar 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJrBpD07"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F891C693;
	Sun, 17 Mar 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710686264; cv=none; b=qU5QgynxZwxHUZGIZ0fh+chr710d6KoyvKEVzgVU403O5i2/uXFkTlt7Uz7PQ+B75OkUn+uTY5p3FXeO06uXj/zP/rr5LT5xXteejIoiGTBj3jgzCEde3TUji/rqIgDfPWAKRe6TZsGHjAozYCSQvAAWnxASTLkCz60fLC/J2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710686264; c=relaxed/simple;
	bh=PT9YxTRcdtJLj8jNoUrOToUdo8MYa58ycoiSVTas14o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlBNiJLQI6yXGTnLL/ZGt3r6JPVVRLOFVZWZrXo9kcd0ZVBLrves1Br1WmXRvI1GEhv0clmSQszVf682uFaIgoI2NZnZ1n9uB1wRUSbh+QtiaNOTHe0bBzjI9ZqEzBp21raJZXKjB1KF1YwPNYmJKy+kjPScixkrXCGIaGTI3Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJrBpD07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96865C433C7;
	Sun, 17 Mar 2024 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710686263;
	bh=PT9YxTRcdtJLj8jNoUrOToUdo8MYa58ycoiSVTas14o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJrBpD079vjEMroEdPDcgoZ9AlhiXQLbJ97scn4FJGAycSNSCDui2S9DJC6tki/Sw
	 Hdf/4gniJcVYv1sjEA1Ad/D5jFhIIBngNhqNZP4l36jnYBgv1iDIZl6nkyx3xMNNxX
	 mSTXnLvhRE5LogW8dMhvt51xxuyzWcBc0KGHUrWzeQ/b2OYLBebPw5rLlDRQDHidzS
	 tsRA7uwOpzgeNataMsf3bS5/X5e7psgXEgwTPSINqA+0xmJ8e1ZNXhP0xALMXSKiqr
	 5H3nUqX4t0D/5s/4iOr8HG1rLOYKtle3C+t4fLnwTwPqeUlsNpJTLenqE0jKil2yxN
	 gHWnmkzQBEH2w==
Date: Sun, 17 Mar 2024 14:37:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matt Ranostay <matt@ranostay.sg>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: health: maxim,max30102: fix compatible
 check
Message-ID: <20240317-bakery-numeric-a34b928efa6d@spud>
References: <20240316-max30102_binding_fix-v1-1-e8e58f69ef8a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3m7Apa/RWUaBOpCe"
Content-Disposition: inline
In-Reply-To: <20240316-max30102_binding_fix-v1-1-e8e58f69ef8a@gmail.com>


--3m7Apa/RWUaBOpCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 11:56:57PM +0100, Javier Carrasco wrote:
> The "maxim,green-led-current-microamp" property is only available for
> the max30105 part (it provides an extra green LED), and must be set to
> false for the max30102 part.
>=20
> Instead, the max30100 part has been used for that, which is not
> supported by this binding (it has its own binding).
>=20
> This error was introduced during the txt to yaml conversion.
>=20
> Fixes: 5a6a65b11e3a ("dt-bindings:iio:health:maxim,max30102: txt to yaml =
conversion")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30102.=
yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> index c13c10c8d65d..eed0df9d3a23 100644
> --- a/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30102.yaml
> @@ -42,7 +42,7 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: maxim,max30100
> +            const: maxim,max30102
>      then:
>        properties:
>          maxim,green-led-current-microamp: false
>=20
> ---
> base-commit: c1f10ac840caced7a9f717d4170dcc14b3fac076
> change-id: 20240316-max30102_binding_fix-898e7c94cce9
>=20
> Best regards,
> --=20
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>=20

--3m7Apa/RWUaBOpCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcAMwAKCRB4tDGHoIJi
0iQVAQDqnSYSNHsDNk/8FIR4UROHkzfm7B7BmeUbEVUcYw+gIwEA47Rm8mdO6nPq
1tpXINAFvlSKjbaAvg9+B+ayG6xtqwM=
=5kuB
-----END PGP SIGNATURE-----

--3m7Apa/RWUaBOpCe--

