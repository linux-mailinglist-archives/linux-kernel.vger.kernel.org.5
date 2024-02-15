Return-Path: <linux-kernel+bounces-67375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30C4856A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D70C2833D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC351369BF;
	Thu, 15 Feb 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbco+Ket"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B20136988;
	Thu, 15 Feb 2024 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016956; cv=none; b=Xf1zJ7QKAnrWmW9JLPvXi9QHWyckhIhI4XtfD7Lugg+Y/J9IIC/UHaxfsEZxNuhaHaHt+DBWy75CVboyQ9O4ylY1q5JUfn4VK3JRI0UzAeRHHEs3tCg8pxS5b+sYKepipzFR0Xv/mf+cf2aaze7S8K5IfkkxEql2cyn0WzGYBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016956; c=relaxed/simple;
	bh=iYuaQPEfpoZMaguUakN8GMeMOfkpNsph0ragFrzOlps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbn5jGi/wbfhwZBswbDyIm5keIohV5BdfMf0TuLdpfLHG9aD5AGl9jGPitDP6pjaqZdIvgKqpiSQE67MeI317Kq9vit6ZN5ag97+nGgEoMxhmbBG1dPNShmmCnVwrCQ2zHGFFr5lg5je7jsTMuSyC089Qq4N2haGr6KIXfhoaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbco+Ket; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E8DC433F1;
	Thu, 15 Feb 2024 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708016955;
	bh=iYuaQPEfpoZMaguUakN8GMeMOfkpNsph0ragFrzOlps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cbco+Ket1Xpt3QUm+m0Nii0K+QlMMiAk9HvlywVaCUu81Jp3Ghz9lHhZz3gLDRDlM
	 EYI8a/utOCbK+iQR4kTi83Qpvr1WD9TW+1IEZjQmTP48CFo/oR7Ju66a1yhmFM8UfL
	 DbQSoCCMS4CYS8LeG8Bvk3/oqFEY/73eAC2CM2RhoqrRycyjSX46rjSrTiDC47IvyO
	 MxllMrmhCLXFC42wcLC1X0lALxG2XUW58QxpwyZoYPLBAtHPfc/gEksXrlSxtGzg+C
	 HrGik8kiiFW//qYvfLPg1uc/LYliYpcdj98/p+jIdd94XuSBTH8a6CIzcF6g2QZyiy
	 fL6Aogj/NCprw==
Date: Thu, 15 Feb 2024 17:09:10 +0000
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quentin.schulz@theobroma-systems.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: add prefix for admatec
 GmbH
Message-ID: <20240215-settle-province-41ad1a2f77e7@spud>
References: <20240215090442.3513760-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tGCrTqscGmACoUi4"
Content-Disposition: inline
In-Reply-To: <20240215090442.3513760-1-heiko@sntech.de>


--tGCrTqscGmACoUi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:04:41AM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>=20
> admatec GmbH is a german supplier for industrial displays.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

There's a fair few Admatec's it seems, so a link would be good:

Link: https://www.admatec.de/
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 1a0dc04f1db47..fef2e12b504ee 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -61,6 +61,8 @@ patternProperties:
>      description: Analog Devices, Inc.
>    "^adieng,.*":
>      description: ADI Engineering, Inc.
> +  "^admatec,.*":
> +    description: admatec GmbH
>    "^advantech,.*":
>      description: Advantech Corporation
>    "^aeroflexgaisler,.*":
> --=20
> 2.39.2
>=20

--tGCrTqscGmACoUi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc5FNgAKCRB4tDGHoIJi
0hx3AP9aePTSJI1q2YqKlAHMe+jLDYuIkE/T6r+mNA0NZhL55AD/X4ONMTJ5vE7+
EzhpHmzcA/qdoXcOzAmgfmMxb5xMYgo=
=nFDp
-----END PGP SIGNATURE-----

--tGCrTqscGmACoUi4--

