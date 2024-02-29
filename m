Return-Path: <linux-kernel+bounces-87318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE086D2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB801F252C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E845134436;
	Thu, 29 Feb 2024 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaWt+oH+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BE3134421;
	Thu, 29 Feb 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232964; cv=none; b=cozeoh/X00Ekn5IXmHAZ59P1joF53lXdNPrQIxsogtoznLCTHSDxlVRi1LI0CNw+iman/pfkkTt4WxoL3XTxYsnRrpCkeMj6fy7ZzdJy8PnNvkSw1rCLOgDd/57jVQ+W+kv9dSvThAsM/PqTy1CrK+x4xImUO1tvv0O0nis3N7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232964; c=relaxed/simple;
	bh=9jNWT5JzMeZ3ugm8mZo56duN3alCtt+0bTyYBz7W+gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwpWA8txUHzk2cID98WS4+lTyRhuTG5U7pw8Cibtv6nicBpwW0dctDye13adqIrgPu8Ga/C0fJp/y6FaYs4oL/1uMMdxXos6ICMkwpqoFLm/MLkeWMX0Bg76gmZihqGfR9VvtEHEH3IHnIM/6CnFpjGGZqQBVcmB9o21ut2jn/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaWt+oH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EF0C433F1;
	Thu, 29 Feb 2024 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709232963;
	bh=9jNWT5JzMeZ3ugm8mZo56duN3alCtt+0bTyYBz7W+gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaWt+oH+BlPkjG4/vxoRjseD+V5SRhv6MvPWyCWxXIwNEUMJV8JlIU5bQLpkeQUr5
	 j6lRZlGu3C5vH9Y1yrVak/3zGy0rmqm1o5Vg5FF7ep8DP2JffJN4NovDrUICo7TPRr
	 /GiwmHcb7C3HiX5FPcXfmKYCxH8j33MIlmyXNzPNOA36FnwYTnzjy0B3I1qC075+ns
	 /1x49UqQ+xZ8l4TJHiT2FvNWm7QsHW9g3aCpnDc2MK2j4eMgwhQEVyW0FpXUxY8KDE
	 cHEe5cEJiUvZfdr0fC+9pidEwQ27r9EdeoxDKs9JczPosv8Vc/4p8re6MrK3RZK3ul
	 yDU49MneUqnkw==
Date: Thu, 29 Feb 2024 18:55:58 +0000
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
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240229-husband-penalty-8c1ab0f57f55@spud>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="srZ/zPvQLoPFy/vJ"
Content-Disposition: inline
In-Reply-To: <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>


--srZ/zPvQLoPFy/vJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> Some sai only connect one direction. So allow only "rx" or "tx" for
> dma-names.

Which sai? Can you restrict this per compatible please, so that someone
cannot add 2 dmas for ones where only the tx is supported.

|  dmas:
|    minItems: 1
|    items:
|      - description: DMA controller phandle and request line for RX
|      - description: DMA controller phandle and request line for TX

The binding already allows only one, but it documents that the first dma
is always the RX dma, and that doesn't change with this patch..

Cheers,
Conor.

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Docum=
entation/devicetree/bindings/sound/fsl,sai.yaml
> index 2456d958adeef..0302752d58a2b 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
> @@ -86,10 +86,14 @@ properties:
>        - description: DMA controller phandle and request line for TX
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
> +      - items:
> +          - enum:
> +              - rx
> +              - tx
> =20
>    interrupts:
>      items:
>=20
> --=20
> 2.34.1
>=20

--srZ/zPvQLoPFy/vJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDTPgAKCRB4tDGHoIJi
0k4rAQCajuVtW1Lf1g+IHmnbW8Nz9UPj32iFkM/X0vR0/ehEEwD+K1Vs9TW7Xi0M
0xWWhKgTKjbUXNU8JBLMD9PrjjBHOw0=
=0DAk
-----END PGP SIGNATURE-----

--srZ/zPvQLoPFy/vJ--

