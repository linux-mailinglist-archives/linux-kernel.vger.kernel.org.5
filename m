Return-Path: <linux-kernel+bounces-160389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E18B3CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B621C22E23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503EE148854;
	Fri, 26 Apr 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFdNnU/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A78E2B9AF;
	Fri, 26 Apr 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149415; cv=none; b=MFY7qnd2fZWPJ2NmeDyUEeX1VCIzfVMdW97+efsXorvxul3an/WAE1Oo1zN8nYhQAlfRFfXyZ8D8rbSoIMo65FCMcot5NpfC/S7ZuaCzxfI8ahbzB6kuqEuHL6Rg2nLnXuGfYDeZa2XoQqkDC07hDD9RAIPBH1lJv0GgxlAPHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149415; c=relaxed/simple;
	bh=Cg4JilBD044EVGTAr/r8RwfgSTZjH3NdYHYffLsTKZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsWNUCaWcLAYgb72OhhZk9AKUPuyuRc4cZ+qpod2INWWK5RQ9t/KbCI7ztV9D4jYPcNUuTv9Hc4gIoSOWBQNTwdJrNBNifvhkKrnwIjN9cibG8/J9m7RMUh9BARzaV3QYYJ7Dn0Sor0qd93PBNPN6MnlSzK/d1oCN2tYduXA3CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFdNnU/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23674C113CD;
	Fri, 26 Apr 2024 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714149415;
	bh=Cg4JilBD044EVGTAr/r8RwfgSTZjH3NdYHYffLsTKZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFdNnU/9yvV7iX+m+ABudXsOce+L3GJT2reex1XBJoOR5oVp4G8DBjcOFDykro2dK
	 cZB5PvnCU3r8a+5Z19axKWNdGWwvLgbuygUkjHAdQb6WvAl24pSBlVczxRWG01MKOb
	 YkRC3BMuBqo1P3/wTEKwPeJrS0LXlbqsTaUwNy+B0vhr+HpudAKdfp9Hb2LGpxgTbV
	 n1niP0VpwYi7uIxtz2iOLU8GvL3yCehCAJsAmXfy2fGq9Mhyp75CTITorfHQts3pmJ
	 fjEsUQQzuCV9NGqhV9Kz4B7bfQfTOzbHcM+lgUI0zjpQiIHxEHpndzJvNXMj9NKBJJ
	 nNJg1KqatH0EQ==
Date: Fri, 26 Apr 2024 17:36:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH 1/7] dt-bindings: iio: imu: Add ADIS16501 compatibles
Message-ID: <20240426-chemo-ensnare-9246b013bd6e@spud>
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
 <20240426135339.185602-2-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8EakgkyhqOY7eHK0"
Content-Disposition: inline
In-Reply-To: <20240426135339.185602-2-ramona.bolboaca13@gmail.com>


--8EakgkyhqOY7eHK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 04:53:33PM +0300, Ramona Gradinariu wrote:
> Add ADIS16501 compatible. Similarly to other ADIS1650X devices,
> ADIS16501 supports sync-mode values [0,2].

To avoid me having to check the driver patch, you should point out what
makes this device different from the existing drivers and therefore
justify not having a fallback compatible.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml=
 b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> index 9b7ad609f7db..db52e7063116 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
> @@ -30,6 +30,7 @@ properties:
>        - adi,adis16467-2
>        - adi,adis16467-3
>        - adi,adis16500
> +      - adi,adis16501
>        - adi,adis16505-1
>        - adi,adis16505-2
>        - adi,adis16505-3
> @@ -90,6 +91,7 @@ allOf:
>            contains:
>              enum:
>                - adi,adis16500
> +              - adi,adis16501
>                - adi,adis16505-1
>                - adi,adis16505-2
>                - adi,adis16505-3
> --=20
> 2.34.1
>

--8EakgkyhqOY7eHK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZivYIgAKCRB4tDGHoIJi
0gbhAP9Ow4Olsjl4OA8MQjIEcoPxjHZum2CxoDhfP4mJfs/b2QEAg9fdL8bgnNPa
opBNQaaVGT60lupc8+vpfUdB3SWOAwc=
=OQ6q
-----END PGP SIGNATURE-----

--8EakgkyhqOY7eHK0--

