Return-Path: <linux-kernel+bounces-33942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BCD83706E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6181C28066
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E910E6519F;
	Mon, 22 Jan 2024 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2foZk/I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE364AB6;
	Mon, 22 Jan 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946919; cv=none; b=S71ndhMYueUkI2volJMD/lPSo1d3Ar1GGnCZwmPl4NF1+r6swIXLzfh6rKwnKOQ7qSQJXAaoVsrr4c1255QLNdlow1Y7gq9X96uJVyqc27kgt+DwnF92ENCSAoW9WYjvdhJ9Gj0ERpzl1Qt9hT2jX7EkKFlL3VBShnAR7KM0wA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946919; c=relaxed/simple;
	bh=RqNQOuyWbnDtXgDNyqmzqdEKmeTpRwZHZjqAYNFwCTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0IpJcl4FbOavZOV5h0xyr8HlVXp+hhEqT2g/JQHh8BxpkApfAbfpS3XzXNcFcLT158DxQbbtqSv/n3zDpePkj8hcJwsI5sDkjBghPsf2xy/tApfmSj5PZUhmShGjDMQN37KVjw2OmNGHTmbF2ucilIxGFNsMDVMqM0Q4Ithw1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2foZk/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38597C43390;
	Mon, 22 Jan 2024 18:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705946919;
	bh=RqNQOuyWbnDtXgDNyqmzqdEKmeTpRwZHZjqAYNFwCTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2foZk/IRVX4SATB7c+HIWXryjXdffGbI/wmLfZfCyClsrzAjRmuuMe0woow2Anak
	 LwiujKSy7b5cwYLIGw6aD9femnb8ML21Ef9dD6I12WPNYy0FRivYQsCPIGdqEeMrVe
	 u8U0sD4eDya9xOIgC645svv6QodyjczpXeT0g0p2VbcyF4d0UwjVDwsgXSCm9GKCo5
	 fUi5PYDJzc5sMK3+vmgaQEvP1oDOrIFVymCibFbkzUzbvlT1HOKhl2nf7st2pZYUuc
	 jfz6vxjNeuUbh9JvH/mauTN0NJFxKTyTszEmoXy746CoLBUUWU1+r77uoMRg3IALMp
	 m7wk28QleOijg==
Date: Mon, 22 Jan 2024 18:08:33 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: timer: nxp,sysctr-timer: support i.MX95
Message-ID: <20240122-bagel-query-7f04434b51ad@spud>
References: <20240122092225.2083191-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ntlfkJs4R/S1G2La"
Content-Disposition: inline
In-Reply-To: <20240122092225.2083191-1-peng.fan@oss.nxp.com>


--ntlfkJs4R/S1G2La
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 05:22:24PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX95 System counter module has similar design as i.MX93, so add
> fallback compatible with nxp,sysctr-timer

It would be good, in my opinion, to add some device specific compatibles
and deprecate using "sysctr-timer" in isolation.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/timer/nxp,sysctr-timer.yaml         | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yam=
l b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
> index 2b9653dafab8..4f0b660d5ce3 100644
> --- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
> +++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
> @@ -18,7 +18,11 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: nxp,sysctr-timer
> +    oneOf:
> +      - const: nxp,sysctr-timer
> +      - items:
> +          - const: nxp,imx95-sysctr-timer
> +          - const: nxp,sysctr-timer
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.37.1
>=20

--ntlfkJs4R/S1G2La
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6vIQAKCRB4tDGHoIJi
0l2JAQDW9UVTiTQd1C7eD66iCiBow9nNP+D6eSOp0OgXVXNCRwEAoUBpEFy36J1v
v2ns7UtZ82Sv1qbPYqGpKnpKDsGZswk=
=jQc4
-----END PGP SIGNATURE-----

--ntlfkJs4R/S1G2La--

