Return-Path: <linux-kernel+bounces-31366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BDD832D44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6746B25584
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA5153E0C;
	Fri, 19 Jan 2024 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZG+yPfp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8E54F83;
	Fri, 19 Jan 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682128; cv=none; b=f81B8XLUfhh/Z/yCVEk3JaFDd9MqGMoQmTFQ9TLLzXOAe3sOfNetjp+YOv0ne+PnRBhcD1g2sJB7WuwOBNYOhSliIYTx4vA5wqgCEAQeeIWKzQdtPaZGfqGlACABrcqJmOQQ3H1krQqWsdGh5ZvGotwiPOYQp0oyxxq1WVCqa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682128; c=relaxed/simple;
	bh=tKOxeGFjeKoiekCBWLj47nmpwstbrJvnMnXHaaRAOmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRJnPJ20UWVYV91Dpat7V4GM41F9/F84RzwwKRH5F1HzhwmZS1nvjxBaElFbNHZ1iZdTC0DltUSh6SSVHtVSGaWig+QcaUA3eaxefhlnp743NyK0uLuNB9UhBfLjF8LKj4Vwb1y2xjRW3gWvacd5kJE+wtiuc0Bm6v+J94TenK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZG+yPfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E90C433C7;
	Fri, 19 Jan 2024 16:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705682127;
	bh=tKOxeGFjeKoiekCBWLj47nmpwstbrJvnMnXHaaRAOmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZG+yPfpPvhKMdntDIhG7aCcn22TX1D5D3K6nCHtISZDHnOMVTL8XtkqQUNxVbLdq
	 LhTaixTd60/x0ZPNU6y0uiKwdbHISXVZ3eiZ5D2Upvd0qOkFN5ftTfyFUwS83xge19
	 zdxBXIsfoZVcOYTh0estRoF5vTrbL+va8UJ7IYQ4y4jbX8JEJeGS2YOU0qOp0JnV1d
	 ZAQcvCOg6/0qV4nHluu2laIn4+HMmLQroK1ifu2GOMlGcpPks0WK/moiaSWLI6FxAg
	 xld64AuD6U8yJ/DPn4YJFwDkthQs356SWRje27PanjEGe/2ad9F4pz+3jdTp8vkEK+
	 ETK0TKpxFn/3w==
Date: Fri, 19 Jan 2024 16:35:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Primoz Fiser <primoz.fiser@norik.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Wadim Egorov <w.egorov@phytec.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@list.phytec.de
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: fsl: Add phyBOARD-Segin-i.MX93
Message-ID: <20240119-art-impromptu-11de2ccb2664@spud>
References: <20240119092835.21462-1-othacehe@gnu.org>
 <20240119092835.21462-2-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w2icVjWluU6E8Ba6"
Content-Disposition: inline
In-Reply-To: <20240119092835.21462-2-othacehe@gnu.org>


--w2icVjWluU6E8Ba6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 10:28:34AM +0100, Mathieu Othacehe wrote:
> Add support for phyBOARD-Segin-i.MX93 board.
>=20
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 228dcc5c7d6f..b6c523d02d29 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1275,6 +1275,12 @@ properties:
>            - const: tq,imx93-tqma9352        # TQ-Systems GmbH i.MX93 TQM=
a93xxCA/LA SOM
>            - const: fsl,imx93
> =20
> +      - description: PHYTEC phyCORE-i.MX93 SoM based boards
> +        items:
> +          - const: phytec,imx93-phyboard-segin # phyBOARD-Segin with i.M=
X93
> +          - const: phytec,imx93-phycore-som    # phyCORE-i.MX93 SoM
> +          - const: fsl,imx93
> +
>        - description:
>            Freescale Vybrid Platform Device Tree Bindings
> =20
> --=20
> 2.41.0
>=20

--w2icVjWluU6E8Ba6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaqkyQAKCRB4tDGHoIJi
0hWRAP9dRermiyMXJ2IRHf29ldKI6uDQ99VWYrnnOLSa0Ti5jwEAhw2ZKr/FOj11
hMuS4wrkJDv4Kxref9R9S9ncwNPpjgg=
=olU5
-----END PGP SIGNATURE-----

--w2icVjWluU6E8Ba6--

