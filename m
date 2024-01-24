Return-Path: <linux-kernel+bounces-37294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6534383ADE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C6282A71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287BF7CF0E;
	Wed, 24 Jan 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGS/vNP9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EEE40C1B;
	Wed, 24 Jan 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112054; cv=none; b=YwBy37RBjxil8BBSwVaVdK80eyUb6ptrV5tnyJk5RYQZLo/NIVchiJofnegozd3JqsGmWkQjHY73rw+cvZcwzH/zeVaoccRGJ6x5xihN88EkfiitOKfgiJz+ZbTbGeVEKDXZSMWNRSdJ2V8e4bdM8ZhGEc0DQDDb6W5SpL2jTK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112054; c=relaxed/simple;
	bh=TbMpid+LHATwVZnTYINaH5gIN0irhOL9HfsfcOnpyAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqIh5QGN3ZYr2/9D9O9cC9geRToVmWEt7otkRrC5tVpa2UjF8Yi6qvyoY+ntKvYCrFpMQ8qrY3DqlmdYaWSc9E+mab30lNblqgowxw9U0Wmxz0Y4Djdeu4GUpuiGDKsfZKfYQRzu82xY8Hybr1t790qfytaCG4EUr7htuhrODjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGS/vNP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CF5C433C7;
	Wed, 24 Jan 2024 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112053;
	bh=TbMpid+LHATwVZnTYINaH5gIN0irhOL9HfsfcOnpyAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGS/vNP9fAYBFK3NbuaGg90JtmMUInHteQ40zlrLJgbzYh/KKbb46rFXg+eDJTICA
	 yhtkrxMk1+N9Dqn6jyex3RxibkI4qV7RrI2ppKchYPE7rvvjvZQjXS2OSHPAezBM2H
	 jPaOnzQStHbUEHsVcP7MU/L3P86oOTq71xASZLEFLx1Uuhpk4/IuNHVzzRO6yoqmQp
	 citDPYz7HnIQm51/I6srzm1ih8jq5vb6w6j9Wii9XyCmLR1kHW2y5jzK/rVqAYuL8n
	 ca5wsX0g/TPWAN764C6wC4zLXHiDoKsxW4/J/X3hNKdaSL3f4rrjDMRIWqsyaVudZA
	 cT4maV27hDBzQ==
Date: Wed, 24 Jan 2024 16:00:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	leoyang.li@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	andy.shevchenko@gmail.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: remove redundant company name
Message-ID: <20240124-evoke-lunar-599e43a99494@spud>
References: <20240124154422.3600920-1-hugo@hugovil.com>
 <20240124154422.3600920-2-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fR4KvCHXIGNltKve"
Content-Disposition: inline
In-Reply-To: <20240124154422.3600920-2-hugo@hugovil.com>


--fR4KvCHXIGNltKve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:44:20AM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> Company name in compatible description appears twice, which is not really
> helpful, so remove it from product name.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This only landed in 6.8-rc1, right?
With a Fixes: tag this would probably be okay, but this does seem on the
"not worth fixing" side of things to be honest.

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 228dcc5c7d6f..f455c0172c84 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1026,7 +1026,7 @@ properties:
>          items:
>            - enum:
>                - dimonoff,gateway-evk # i.MX8MN Dimonoff Gateway EVK Board
> -              - rve,rve-gateway # i.MX8MN RVE Gateway Board
> +              - rve,gateway # i.MX8MN RVE Gateway Board
>                - variscite,var-som-mx8mn-symphony
>            - const: variscite,var-som-mx8mn
>            - const: fsl,imx8mn
> --=20
> 2.39.2
>=20

--fR4KvCHXIGNltKve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbE0MAAKCRB4tDGHoIJi
0kDoAQDB8OEo9sqJYqCSDRi+77Dg5aK/ySummjV3lhwEsdXoPgEA4PRGcK44NDKV
lpQ8tDB6zvgyylOtXYPT6/z+wPh5pgI=
=y8LY
-----END PGP SIGNATURE-----

--fR4KvCHXIGNltKve--

