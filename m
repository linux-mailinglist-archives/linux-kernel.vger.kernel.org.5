Return-Path: <linux-kernel+bounces-121628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E50F88EB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC31C2DE96
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F8A130E5C;
	Wed, 27 Mar 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMxbb0Y3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478812DDA7;
	Wed, 27 Mar 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556934; cv=none; b=qxuArM3L5N1ghR0nfpnk6Ts1yv92JlvNUGLFYvraFR2n2oCHspNLbSIQDDqa/jeY8F55yg84iuO4kjz8rrbEeRWgwvZdeeiHbKHD7zjBX+7qaNl7ChWb7bEZpdQcyMwhDD6tVXipH6fjEM3YHryaIvWjQa1l9R+PgbUk1rCamt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556934; c=relaxed/simple;
	bh=d9DnxmW+a4P+dEszAOdKuPFSCcl7qq/W+ZbL07RwEwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBvHU7PAyI9g61hXT07Px+HsJonVOMnJ/w03rjUzV7xZrKz5iGHCjkeQ4gYkpf4erq43R9n5lyT1r1Qh6k9tkTD89Im7mqAP2Icrgu8YCt5S3woFK9uD858/btOzrVtCoEYqF7oksS3wyC+7ChLJo7SHLsXYoSQuFnRfD/9QssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMxbb0Y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34858C433C7;
	Wed, 27 Mar 2024 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711556933;
	bh=d9DnxmW+a4P+dEszAOdKuPFSCcl7qq/W+ZbL07RwEwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMxbb0Y3Qa/NNHrKY4OquYcNBThaVfbyHU61upgpTbCcFHlnFasflMqCeESKgyQ4A
	 tSWfpWgupdbSS8VRsWTXgrUI2cRfVODARZzRVNqQoZl5Izn/lnhpbboebnIBN8fxbv
	 InDRbXQFjTkFrPvEbUVQM940TJYOd3FxArh/rRuoN/G59hkw1eHpLjXLh0b+MeWh9A
	 WxMGg8Tv5ReJlytHfW6AtCTbcWSocuF4cnSatbUoF4mf488EL6i+8cYxi9OMVGn5vT
	 m4pvBPDiuT6fsBMZVvvnS/gJe7egoynptZ1ue20fS32a+ZIRPps2cGtCMBzyj8BIKg
	 NtqzAhYhauw8A==
Date: Wed, 27 Mar 2024 16:28:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Mihai Sain <mihai.sain@microchip.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, broonie@kernel.org,
	andrei.simion@microchip.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] regulator: mcp16502: Update the names from buck
 regulators
Message-ID: <20240327-agreed-routine-0cc60186876b@spud>
References: <20240327101724.2982-1-mihai.sain@microchip.com>
 <20240327101724.2982-8-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lqf7Y/CEqKPOGaGb"
Content-Disposition: inline
In-Reply-To: <20240327101724.2982-8-mihai.sain@microchip.com>


--lqf7Y/CEqKPOGaGb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 12:17:24PM +0200, Mihai Sain wrote:
> Use generic names for buck regulators to avoid any confusion.
> Update the names from buck regulators in order to match
> the datasheet block diagram for the buck regulators.
>=20
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>

I know the regulator core will create dummy regulators when they are not
provided in the devicetree, so I am not 100% on how backwards
compatibility works here.
You'll end up with a bunch of dummies and therefore the regulator-names
and constraints on the regulator will be lost, no?
Can you explain how is this backwards compatible with the old
devicetrees?

Thanks,
Conor.

> ---
>  drivers/regulator/mcp16502.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
> index 0c15a19fe83a..d6fc9f1afaef 100644
> --- a/drivers/regulator/mcp16502.c
> +++ b/drivers/regulator/mcp16502.c
> @@ -468,13 +468,13 @@ static const struct linear_range b234_ranges[] =3D {
> =20
>  static const struct regulator_desc mcp16502_desc[] =3D {
>  	/* MCP16502_REGULATOR(_name, _id, ranges, regulator_ops, ramp_table) */
> -	MCP16502_REGULATOR("VDD_IO", BUCK1, b1l12_ranges, mcp16502_buck_ops,
> +	MCP16502_REGULATOR("BUCK1", BUCK1, b1l12_ranges, mcp16502_buck_ops,
>  			   mcp16502_ramp_b1l12),
> -	MCP16502_REGULATOR("VDD_DDR", BUCK2, b234_ranges, mcp16502_buck_ops,
> +	MCP16502_REGULATOR("BUCK2", BUCK2, b234_ranges, mcp16502_buck_ops,
>  			   mcp16502_ramp_b234),
> -	MCP16502_REGULATOR("VDD_CORE", BUCK3, b234_ranges, mcp16502_buck_ops,
> +	MCP16502_REGULATOR("BUCK3", BUCK3, b234_ranges, mcp16502_buck_ops,
>  			   mcp16502_ramp_b234),
> -	MCP16502_REGULATOR("VDD_OTHER", BUCK4, b234_ranges, mcp16502_buck_ops,
> +	MCP16502_REGULATOR("BUCK4", BUCK4, b234_ranges, mcp16502_buck_ops,
>  			   mcp16502_ramp_b234),
>  	MCP16502_REGULATOR("LDO1", LDO1, b1l12_ranges, mcp16502_ldo_ops,
>  			   mcp16502_ramp_b1l12),
> --=20
> 2.44.0
>=20

--lqf7Y/CEqKPOGaGb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgRJQAAKCRB4tDGHoIJi
0jMkAQC28sZ5rt1TFDBpNnI9RQ9dzDj+9bBym/hmm2MyRGVBHAEA6VY1HcwfphJM
UohqJE1s3Smp5X8Ku6nzNEe7i/s5Kwk=
=CGed
-----END PGP SIGNATURE-----

--lqf7Y/CEqKPOGaGb--

