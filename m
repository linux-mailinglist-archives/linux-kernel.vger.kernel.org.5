Return-Path: <linux-kernel+bounces-81889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3562867B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFC5290E81
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885D312C7F2;
	Mon, 26 Feb 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fxo40mUJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E71D531;
	Mon, 26 Feb 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964461; cv=none; b=qvkrosIu92KAFKPrC1DglxWyZ0gaw3+bX3MYJLzHbdeZkYs6SdfInaTT6C8/4Hib7L0tOX4kmk35wOvbvjQ9nU7yRHCbGfGeLZjWHtqnNPEU8jqMj2hq9pmXMNZOVKFq7ffFfsbT00HhZYsKHCi+QteHXbVXn62hvUQg8PNc4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964461; c=relaxed/simple;
	bh=C6tE3K79M1feIkZlGioaGmywnXiz4aPQZcwoC8cUC6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttMBFHEXwTj/B24IHg0GL3A/j5S6YJ8N5FJZ4ZEzvoho1/QaehI/ckBKrnq2IYq1GnEN78IYlHGdJKmB+sOCV8h7KrTprpLAAEJf5Jh2Yk5kVq4Zv4Cftly0rOLDYwK/1i6jx+diK6eBO9ti3ZzRDC4BSsG3WXYpavu8WWpu+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fxo40mUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF3DC433C7;
	Mon, 26 Feb 2024 16:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708964461;
	bh=C6tE3K79M1feIkZlGioaGmywnXiz4aPQZcwoC8cUC6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fxo40mUJLCrHJrkY4ZRit37Q29j2FLt76QszjOvrsMRHUAjz/HROZcjCxrKA2DofT
	 D7topPGgz52MhANrIij/057RhFKEvP3o6nvxan4UpcliGbZo6dzl0Q+IIPowITDDb2
	 GaQYzbM21bq3vSw+1eGa//ZnkSS++aZhWoJ5x3VeFrygY8JkMtCDnOLeg3EbeKJbHX
	 QV+COFG7T0QxdVveORNck1VkWFGnDbW7RVNsCofQOXicRuydjnIou2h7r7GZrtMWWE
	 0fWfYJkdl8j/s90K97411LPDHMokeVk9D6ZEsVwherN/uUHYpIl6K6CaAPSR5eLg2Q
	 OusjiKSSYUILA==
Date: Mon, 26 Feb 2024 16:20:56 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Message-ID: <20240226-sharpness-material-54a8e719ce91@spud>
References: <20240226-imx95-dts-v2-0-00e36637b07e@nxp.com>
 <20240226-imx95-dts-v2-1-00e36637b07e@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rUkY2RhctmtN3G5T"
Content-Disposition: inline
In-Reply-To: <20240226-imx95-dts-v2-1-00e36637b07e@nxp.com>


--rUkY2RhctmtN3G5T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 09:20:16PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add DT compatible string for NXP i.MX95 19x19 EVK board.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
A passing comment, it feels like it'd be good to add a Link: pointing to
the docs for this board. This is true generally, but doubly so when
googling the name above doesn't give me anything other than LKML.

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 39378879777b..42c6e8467dc5 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1264,6 +1264,12 @@ properties:
>                - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
>            - const: fsl,imx93
> =20
> +      - description: i.MX95 based Boards
> +        items:
> +          - enum:
> +              - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
> +          - const: fsl,imx95
> +
>        - description: i.MXRT1050 based Boards
>          items:
>            - enum:
>=20
> --=20
> 2.37.1
>=20

--rUkY2RhctmtN3G5T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdy6aAAKCRB4tDGHoIJi
0gjOAP9Rgfuc3rAtLjLFrfH5OqhO2c+vaRrkr3viH+WrvvsSQAD/RqOHIWP+4NNY
M4k1synCu0LAfkZEy7Ae2vTHkNXzXQs=
=t3G2
-----END PGP SIGNATURE-----

--rUkY2RhctmtN3G5T--

