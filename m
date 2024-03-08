Return-Path: <linux-kernel+bounces-97338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8F8768FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291BA1C20B06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B0F1CD0A;
	Fri,  8 Mar 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmrAho/9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26946568A;
	Fri,  8 Mar 2024 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917102; cv=none; b=AgcagG5mrztG/IctpSWZ+EzMidVrdGcUTKg3e5ygqWf7BffKGdcpFgF2C7yYDhQ3wyte2vonllQhUjrpn56O+i5bUvv9tDzbpqLx2iVk0PeckZAYUZv9j3dLqyyUmrMHq1lzTWpEpZ31cxR3zrI8HCDQ+KH6yDTAzCERSlEZ1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917102; c=relaxed/simple;
	bh=EuVxJD2mHfKnoyQBcowTIaQagWYJL80opZu/yj/GV0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlssJsa6B3DG1YrF3uRraSO8HJzyzWZsAc8lA4hLkWJ2gvZleQyBxI68PjIBu1v+f38Xcf8IYqCQkqh4cQ1TbrVy0G53G2NSAW7Kn/m0Dj9Pwyd2XW/zXYwxxFf8U7RdFl2sAHkle+VrPlFT+utMrA4NHHAF6Uu8MH9122iLIRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmrAho/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC37C433C7;
	Fri,  8 Mar 2024 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709917101;
	bh=EuVxJD2mHfKnoyQBcowTIaQagWYJL80opZu/yj/GV0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmrAho/9nVEkb9cd/5KFFzOsfYCcwASNebcl8zju555mMlRc/37x7VdH/dGNnaESa
	 6bg1wBfr//iiMHZgy2M/zWxgVnxbv3mjcolGzZBlaPCG2GQIartPxGbAZRRqynkLlJ
	 1wGCS5+XSBQk5UJ/nSneEG1nfxnFLCxuHmgfyXCbLPEJFUDqVQPgU7lFbl3kELYdsx
	 Lwne+5FRbKM63dW5Kbb5pEQAOX37B4YQ4c/2WKPVOKcb4+WY0NNJhwprV3lUA5CYUO
	 BCzoTPyb32rwTGP8fqNfkLFqoI/PNUNqqX/cSGpugqK6+x3uwr2TNl1Y7YUFHdcHLL
	 O9t7Dc8COFnnw==
Date: Fri, 8 Mar 2024 16:58:16 +0000
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
Subject: Re: [PATCH v6 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240308-croon-goofball-797d091e981a@spud>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
 <20240308-asrc_8qxp-v6-3-e08f6d030e09@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AtYEuJt27XJncbRZ"
Content-Disposition: inline
In-Reply-To: <20240308-asrc_8qxp-v6-3-e08f6d030e09@nxp.com>


--AtYEuJt27XJncbRZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 10:30:52AM -0500, Frank Li wrote:
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
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Please drop my ack from this, this isn't the patch I acked originally
and we were having a conversation as recently as yesterday on v4 about
this patch because Rob didn't like this approach. His suggestion is
better than the one I gave on v4 that you have used here.

Please give it a few days between resubmissions, and do not send new
versions of a series every day. It is very confusing to have different
conversions on three versions of this patch in my inbox all at the same
time.

Thanks,
Conor.

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

--AtYEuJt27XJncbRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZetDpwAKCRB4tDGHoIJi
0p1zAPwOVqZkJw5DaQiuRLY7UuKy72/FOl/NK/YmqCZ4DyG7uQEA+Ki09p+Lossj
bxiyf19v0Oygl2gWDK2Oq8f11MiHpgA=
=OJXG
-----END PGP SIGNATURE-----

--AtYEuJt27XJncbRZ--

