Return-Path: <linux-kernel+bounces-87316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 294A586D295
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2480EB20C85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96C134424;
	Thu, 29 Feb 2024 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNvuM8+I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C9160629;
	Thu, 29 Feb 2024 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232775; cv=none; b=qVygKN7CsMc3LffdHMbCajNS+VF+3Yk6bP7cEALFUvFPwi+LDrzo2Ljty2BoZ655eqfH4CrFa3wIGt47GlryIGuYwRlXUuseDhzXFdNN0TNkXD3BHZSn9HKR8vqVk9I1ZU1+ZUWuRf81bFSDEqOZt41SAQWlh9AcdwgKIvJs0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232775; c=relaxed/simple;
	bh=iOuQ3NLogT9DUhHCagui9Zsqnob82CO/bZ+hAddHmV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRRLZd/dLseTsHnQ7wigPL2SMqru42lhZXVrrE3V2A75GHzHMVrZBfpxLhmD6UW3KICDdK/cFDxd+BtD9RhBfB6p6q6JLZoJNAZyr010w/rRgMdT5AK9nPHEt9L9lb5NSbwqDqrYBCg6jLHM8Mwavycohn2W3yumlw7/V1PmN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNvuM8+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59734C433F1;
	Thu, 29 Feb 2024 18:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709232775;
	bh=iOuQ3NLogT9DUhHCagui9Zsqnob82CO/bZ+hAddHmV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNvuM8+IbumeEEu2/usJApVNDKku+NSX689Gbx5KT0ldIbrE7CdXg/5HCMy5SuED1
	 gZQA+8iFyuieDIj9HkM5Eqn/5LxosMa6yq2udvAWMmZHx7yWofHDHav8SFCEpVg10i
	 UPCzzxrBweoU5EPTG02X9+2x06wXfDr+AEYjLgGRCnHIpeqqKhQ8YqBYORtKQ0zzz6
	 WPke1aaNXmL9m2V5Q6Ado9e7F2dy3Ekarze0bKm6dmJ+YIJ63Je46maRWJPHLBv6ym
	 fyBV3GLBn0q8HN1Y1SdHHMQsNVtzLEWeJSA6NZPTBkScrswa/doyBRJdGX3nxAD3Cn
	 LkrU62uN9FgZw==
Date: Thu, 29 Feb 2024 18:52:50 +0000
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
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains requirement
Message-ID: <20240229-gladly-morse-28a3a06e8845@spud>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-1-521bcc7eb1c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xrZyC8VUYzqklLdV"
Content-Disposition: inline
In-Reply-To: <20240227-asrc_8qxp-v2-1-521bcc7eb1c0@nxp.com>


--xrZyC8VUYzqklLdV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 03:54:09PM -0500, Frank Li wrote:
> Add power-domains property for asrc and spdif.

Is this valid for all compatibles documented in these bindings?
Also, your $subject says "requirement", but you do not mark these as
required. Why not?

Cheers,
Conor.

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 3 +++
>  Documentation/devicetree/bindings/sound/fsl,spdif.yaml    | 3 +++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/=
Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> index bfef2fcb75b14..98616507e3c10 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> @@ -74,6 +74,9 @@ properties:
>        - const: asrck_f
>        - const: spba
> =20
> +  power-domains:
> +    maxItems: 1
> +
>    fsl,asrc-rate:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: The mutual sample rate used by DPCM Back Ends
> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Doc=
umentation/devicetree/bindings/sound/fsl,spdif.yaml
> index 1d64e8337aa4b..82430f1d5e5a2 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
> @@ -86,6 +86,9 @@ properties:
>        registers. Set this flag for HCDs with big endian descriptors and =
big
>        endian registers.
> =20
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>=20
> --=20
> 2.34.1
>=20

--xrZyC8VUYzqklLdV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDSgQAKCRB4tDGHoIJi
0nEKAQC75ySPnVkmXzXAPanKzHsx8/8kj8yWlRUKAoJEv1oycwEAmDYO/yWZJvnA
5yDq517lBIAwBlPF//RY2lokX/YdJQQ=
=xvu+
-----END PGP SIGNATURE-----

--xrZyC8VUYzqklLdV--

