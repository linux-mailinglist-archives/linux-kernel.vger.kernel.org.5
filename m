Return-Path: <linux-kernel+bounces-97309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8217E87688F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF654283B65
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED63536D;
	Fri,  8 Mar 2024 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkUsgxrv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DCEE545;
	Fri,  8 Mar 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915602; cv=none; b=oKO9LbMSQSeiKnqIePXkd16o83M8SYiOk3O+IpP/oRccpnsl5r4IcIaHBQPxK6w0Jd74Kw0wK6JBBEmq7ndwHbeD483srCm24pT4JmsKVyhCS5zyDj5/Meip6rnQIo6GuyNtSF8nRENIX3fgqMQ1+CP1I7jwtY5E0+oF+brIfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915602; c=relaxed/simple;
	bh=r2+iM8M2Z34V5nudt6nzbhdrCjOpq+BHqqDCvSY1X98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epjhHKGBjBbrYX640CtsMa4Q6oZ+zqmlTrbZtdXCbToizCciGhWANDOXv5YE9/DFPCpGsG6B2Mw4EzqMyNAoB99mzMewPrLQv7ry3Xag+7xIOkGSDjpMOAMZCT2M8tKX2FwRp9YvRbiCssc9P5wvUQckA++/mdJh0hJrpZfA4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkUsgxrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D48C43390;
	Fri,  8 Mar 2024 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709915601;
	bh=r2+iM8M2Z34V5nudt6nzbhdrCjOpq+BHqqDCvSY1X98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkUsgxrvaiRIAY8MlqNwt/I6J3aSpY4Yfp4yLCTeyny+YkWOloT61h5p8kBv5iLQj
	 YLFM5fqZYNhideHjYSBtzmgl88FlgezOkSpF6ekmKKsJow2IX5QrYUY2kTqbkBjjRE
	 Z9k/7U/V9FxiXMGLzACNmUT8D6H2F+foQH6+djUTLpy+vIGjdHUZsWWRfHvqC0sVD2
	 hpDUhbzoYFp7spQ4XwFGM3olq8+Jff7w3COQb2xiwWLOdjSlPqPSitqtXMrgpmM1GX
	 LBQTi/K34cBXf3wcYQ6u7oPF2dpFCCsevuLX4a9AYsYbk5RA52J0ALZQeBS+lXQ8O3
	 qJGWOl4Y/ukZw==
Date: Fri, 8 Mar 2024 16:33:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v5 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240308-flyaway-hangup-112b11535823@spud>
References: <20240307-asrc_8qxp-v5-0-db363740368d@nxp.com>
 <20240307-asrc_8qxp-v5-3-db363740368d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AC0SKmhkrE3YKJD+"
Content-Disposition: inline
In-Reply-To: <20240307-asrc_8qxp-v5-3-db363740368d@nxp.com>


--AC0SKmhkrE3YKJD+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 02:19:10PM -0500, Frank Li wrote:
> Some sai only connect one direction dma (rx/tx) in SOC. For example:
> imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
> for dma-names.
>=20
> Remove description under dmas because no user use index to get dma channe=
l.
> All user use 'dma-names' to get correct dma channel. dma-names already in
> 'required' list.
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Could you please drop the ack when you change a patch significantly
between versions?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Docum=
entation/devicetree/bindings/sound/fsl,sai.yaml
> index 2456d958adeef..93e7737a49a7b 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> @@ -81,15 +81,13 @@ properties:
> =20
>    dmas:
>      minItems: 1
> -    items:
> -      - description: DMA controller phandle and request line for RX
> -      - description: DMA controller phandle and request line for TX
> +    maxItems: 2
> =20
>    dma-names:
>      minItems: 1
> +    maxItems: 2
>      items:
> -      - const: rx
> -      - const: tx
> +      enum: [ rx, tx ]
> =20
>    interrupts:
>      items:
>=20
> --=20
> 2.34.1
>=20

--AC0SKmhkrE3YKJD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZes9zAAKCRB4tDGHoIJi
0uwUAQDcaoMs1u+9QgLu4SZf0tZtJEIUg5uNYbiBoVj3GhR5wwEA/LOxIJVjMGHJ
DQtJaLtRvDKsgIRW78M+Zlg/BVuPhA8=
=PcA6
-----END PGP SIGNATURE-----

--AC0SKmhkrE3YKJD+--

