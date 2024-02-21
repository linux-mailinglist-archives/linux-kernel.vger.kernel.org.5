Return-Path: <linux-kernel+bounces-75335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8017A85E6BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CC4B26E05
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93178594C;
	Wed, 21 Feb 2024 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL4f1MhE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002985926;
	Wed, 21 Feb 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541700; cv=none; b=GX3Hgr51uT1pGN7nUU/iTAh1fTIjb+kF4tWS2uPhulLBW8EkpqMPhL9MmkJR9rag2Jos9922R17sz4au1dXnuDaD6PbPnD/u+rIZVW/YRR4J/mODg9j1nL/VseXKzQveX/20XeA1Dfw9N6FRLpyKkCgoxGe5sLqVZB8MpDFu91g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541700; c=relaxed/simple;
	bh=Jh0l9s/OaCV3bCuHry8sm0OOyqREosn9JrZQ9umrq7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0OA1XXgYlzqEFasC3zZcc8DK8iA8mEV264viZ2wgDx2Of2My8Yemb4KH0kKyp5y1KQOd8g0g1tcMHwKS+j29hPypKy7IJwktg1XGWWoe0j3IXAAS00hdiNmJZRhukP0Q1tKMtw8Dl7gTHXPQoAvmm9PeLngq1E2rp0/Lj0qmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL4f1MhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27454C433F1;
	Wed, 21 Feb 2024 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541699;
	bh=Jh0l9s/OaCV3bCuHry8sm0OOyqREosn9JrZQ9umrq7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JL4f1MhE9m1YXkzejJB5OF1kGPwFEykYLL1M/7+97FQgC+jq4QFKX48DFP/S0mf7n
	 MfJghzF9K/8iKnp0ciL+XJa2goHThVZvq+w2r7HZdBLw4EtGnnOvl35UZ7VAvMkdfM
	 qvjmQsdDpKoMBhClfDcc69oUoom7ndnkx1XBRDNfO9GYYc0KQvBUHzqrQcIU9mXArW
	 hwXpl/PzgYTU34J4eV1YIlA4MTQYDSCpW1kh7+FhGZ0U/ntMLHcroTymfugEv79JBn
	 +3szynYfd1Zaylc9o1KYoGyDMZgDGLc4VDIp/KUBnj+zYV/8b764Bz1j45uOZwOpd1
	 aazsaavG9dNmw==
Date: Wed, 21 Feb 2024 18:54:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	denis.ciocca@st.com, linus.walleij@linaro.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: st-sensors: Add IIS2MDC magnetometer
Message-ID: <20240221-undecided-union-4078db711693@spud>
References: <20240221175810.3581399-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ULmJpzOTRNdVIOBt"
Content-Disposition: inline
In-Reply-To: <20240221175810.3581399-1-m.felsch@pengutronix.de>


--ULmJpzOTRNdVIOBt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 06:58:10PM +0100, Marco Felsch wrote:
> Add the iis2mdc magnetometer support which is equivalent to the lis2mdl.
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/D=
ocumentation/devicetree/bindings/iio/st,st-sensors.yaml
> index fff7e3d83a02..ee593c8bbb65 100644
> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> @@ -64,6 +64,7 @@ properties:
>            - st,lsm9ds0-gyro
>        - description: STMicroelectronics Magnetometers
>          enum:
> +          - st,iis2mdc

Without a fallback compatible to the equivilent device, how does a
driver bind to this device?

Cheers,
Conor.

>            - st,lis2mdl
>            - st,lis3mdl-magn
>            - st,lsm303agr-magn
> --=20
> 2.39.2
>=20

--ULmJpzOTRNdVIOBt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdZG/gAKCRB4tDGHoIJi
0u+ZAP9Zr+6N1XZjes/rf+rNJqpgfQs8owLck2P23SipRZVnXAEAr0zKQ7xJNxz0
MpFoROjvKA9vwOuXthDy41hZuXC6ngk=
=gf8S
-----END PGP SIGNATURE-----

--ULmJpzOTRNdVIOBt--

