Return-Path: <linux-kernel+bounces-94444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76F6873FE7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A5A1C234FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0313E7C5;
	Wed,  6 Mar 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYwSno0V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D15FDCC;
	Wed,  6 Mar 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750719; cv=none; b=ZJ5647bJGByT+EmKAzMvYqReq4Q0od+OS6iDQR8mkh2ZNm5+skoGlzZmk1CT+VVXynEV0w08Fw2QHEPNQkQnQgXD2QooQKpv9OFN8lIfx0DfLiBRJe6VT7zWddoj6A1dET8ANGapEuKzQI4HuO9evT64XdWAk7V5Ffv4G0+Zkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750719; c=relaxed/simple;
	bh=7CP+A26tMm7Rg/McJFoxPIsRAv/dhgwhokRlKJJDh7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2i+KjWodf8WPwfl0HHgbwBH3V6uUPXtmIZ2ymDv7cgBshZJU3wP910r9DpelcnO9L+cYFb2z3B8htgsmL9wlYzuv+lETi1h5YxDDwyHqdFK6V8/V6oO5SWzvREPo8Ta4+gcVVvZx/n0ApeKmb4LqCqstn90b6BjEX24LyoVNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYwSno0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD37C433F1;
	Wed,  6 Mar 2024 18:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709750718;
	bh=7CP+A26tMm7Rg/McJFoxPIsRAv/dhgwhokRlKJJDh7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYwSno0VcyP2eJcPt9fDzb7A1sk+TV/0ju9H33p/7aSBi8RntoPqX68fZvNOHstAr
	 XfImv0tjdAICPJNdwMKFMoIEN0GfdQPErxzOvyRrpBOYvR6JhN3fWlPqiSbv4OkxAe
	 9c5dZ3dzsxHOfPQZmtgxqch3xwxrb/8pZZMztKjmM3Y1Xm94fe89qxFaQ6yZenKWIU
	 1t9k3xhkOkg3YPCgZoUu+JwS6XPT4/CVcHB/r/72RbINrIOUne9+6obnjJSGKEd5rE
	 OxGaA8FY75l+Mbd//X4M2xXFO1D4wbd+l4bBkl6iNdRhurtL5hSHwfKQf8IxbnJAcV
	 9Tbqkyjk5V6bw==
Date: Wed, 6 Mar 2024 18:45:13 +0000
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
Subject: Re: [PATCH v4 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240306-pebble-grope-88fdaa95a87c@spud>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
 <20240305-asrc_8qxp-v4-3-c61b98046591@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3EPdioiMTrMIrN3t"
Content-Disposition: inline
In-Reply-To: <20240305-asrc_8qxp-v4-3-c61b98046591@nxp.com>


--3EPdioiMTrMIrN3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 12:33:04PM -0500, Frank Li wrote:
> Some sai only connect one direction dma (rx/tx) in SOC. For example:
> imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
> for dma-names.
>=20
> Remove description under dmas because no user use index to get dma channe=
l.
> All user use 'dma-names' to get correct dma channel. dma-names already in
> 'required' list.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Docum=
entation/devicetree/bindings/sound/fsl,sai.yaml
> index 2456d958adeef..6f551c68d33db 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> @@ -81,15 +81,14 @@ properties:
> =20
>    dmas:
>      minItems: 1
> -    items:
> -      - description: DMA controller phandle and request line for RX
> -      - description: DMA controller phandle and request line for TX
> +    maxItems: 2
> =20
>    dma-names:
> -    minItems: 1
> -    items:
> -      - const: rx
> -      - const: tx
> +    oneOf:
> +      - items:
> +          - const: rx
> +          - const: tx
> +      - enum: [ rx, tx ]

I'm not entirely sure if this was Rob's suggestion, I got the impression
he was suggesting that in the two items case we'd not care about the
order. But while I think this is different to that suggestion it's also
not wrong.

Thanks,
Conor.

--3EPdioiMTrMIrN3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZei5uQAKCRB4tDGHoIJi
0oGVAQC0WUWgje4xSZZqPzRwX4PZpsGdXdHoL3D6DvpnrN9/GgD/UgvXhmOyhVOO
woy4Ab0tIG63oNAMuHs9RTTQly9j3gI=
=3qdj
-----END PGP SIGNATURE-----

--3EPdioiMTrMIrN3t--

