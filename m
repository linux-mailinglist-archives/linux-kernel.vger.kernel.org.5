Return-Path: <linux-kernel+bounces-165625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8B38B8EC9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96701C20FD3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1E718042;
	Wed,  1 May 2024 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5EPMXKH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8517580;
	Wed,  1 May 2024 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583269; cv=none; b=iEgybuiHm2Kmef4v5Hl1Enhp+DrvJekVR57AxnXrBy/9RCSe+jDzTPY3Cegnqphguzd0gBfkHNsGTeJJMirc+bcaK3SzwdjidW9YkK3z3i8+3UV6Yb5/+P3NUkJamWrpUYts/U2hHnEPKh70tCxqXLUcOd4K6X0d0jmivr1ETl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583269; c=relaxed/simple;
	bh=8/png6sxsqEGBRMcXp6Bjwq65G0P803V71/0WDXSe9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iouvc9KTiGCOPjFdPvz3ZrkL3gpt84+XkovL+UbxYdTfjkgOgau/IUAK4+IiHKxUKFY/FwHSLD2OuCXkoJuHixEiT+iYJqAFmxz1KTCiDES+SoZaCy3slVpwLZrUHsibNAPTBED0zAJpNMDeq3UOIydoZDibGiW3GMQLlEr9f+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5EPMXKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E807C072AA;
	Wed,  1 May 2024 17:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714583269;
	bh=8/png6sxsqEGBRMcXp6Bjwq65G0P803V71/0WDXSe9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5EPMXKHlB4SDJriFUqz44y53RD4A4LCX3HHMjR9aPglBpE3/T1/QFAGTBfxIriFc
	 HT57GzvsDFFNwRYNYrnW+qhDr4Lz+BfijWMLpYbTNW8uWKmh1znJO6KrQ95ZpNt+nU
	 fQDZ0mybKZitIuvm8e+6qPLfF/04nfjKc3DSNokViAZ2ZVkBQcoyeeESvdQNqF8qTO
	 ONaG2w9eamgRMad9Yfq8gKpcqDHexNAD7vpi29kk0fL2/B5mJxnweXjJUjBBSbRUyr
	 KwYrB7CX1coBz497nT2Wf6OA1ScS/hbd2upZXmN2yCjj4VIg3VVM9dlrC0+KPPSh7h
	 RRKngkClwAnWA==
Date: Wed, 1 May 2024 18:07:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: net: mediatek: remove wrongly added clocks
 and SerDes
Message-ID: <20240501-prorate-hanky-5fbb9ff28bc5@spud>
References: <ea2e786eda4561cb5d11b62a4edd7e75c0975f1f.1714513773.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iA7tPiIVLweNoVjq"
Content-Disposition: inline
In-Reply-To: <ea2e786eda4561cb5d11b62a4edd7e75c0975f1f.1714513773.git.daniel@makrotopia.org>


--iA7tPiIVLweNoVjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:53:55PM +0100, Daniel Golle wrote:
> Several clocks as well as both sgmiisys phandles were added by mistake
> to the Ethernet bindings for MT7988.
>=20
> This happened because the vendor driver which served as a reference uses
> a high number of syscon phandles to access various parts of the SoC
> which wasn't acceptable upstream. Hence several parts which have never
> previously been supported (such SerDes PHY and USXGMII PCS) are going to
> be implemented by separate drivers. As a result the device tree will
> look much more sane.
>=20
> Quickly align the bindings with the upcoming reality of the drivers
> actually adding support for the remaining Ethernet-related features of
> the MT7988 SoC.
>=20
> Fixes: c94a9aabec36 ("dt-bindings: net: mediatek,net: add mt7988-eth bind=
ing")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml | 32 ++++---------------
>  1 file changed, 7 insertions(+), 25 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Do=
cumentation/devicetree/bindings/net/mediatek,net.yaml
> index e74502a0afe8..030d106bc7d3 100644
> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
> @@ -337,32 +337,23 @@ allOf:
>            minItems: 4
> =20
>          clocks:
> -          minItems: 34
> -          maxItems: 34
> +          minItems: 24
> +          maxItems: 24
> =20
>          clock-names:
>            items:
> -            - const: crypto
> +            - const: xgp1
> +            - const: xgp2
> +            - const: xgp3

Why is the ordering changing too?

>              - const: fe
>              - const: gp2
>              - const: gp1
>              - const: gp3
> +            - const: esw
> +            - const: crypto
>              - const: ethwarp_wocpu2
>              - const: ethwarp_wocpu1
>              - const: ethwarp_wocpu0
> -            - const: esw
> -            - const: netsys0
> -            - const: netsys1
> -            - const: sgmii_tx250m
> -            - const: sgmii_rx250m
> -            - const: sgmii2_tx250m
> -            - const: sgmii2_rx250m
> -            - const: top_usxgmii0_sel
> -            - const: top_usxgmii1_sel
> -            - const: top_sgm0_sel
> -            - const: top_sgm1_sel
> -            - const: top_xfi_phy0_xtal_sel
> -            - const: top_xfi_phy1_xtal_sel
>              - const: top_eth_gmii_sel
>              - const: top_eth_refck_50m_sel
>              - const: top_eth_sys_200m_sel
> @@ -375,15 +366,6 @@ allOf:
>              - const: top_netsys_sync_250m_sel
>              - const: top_netsys_ppefb_250m_sel
>              - const: top_netsys_warp_sel
> -            - const: wocpu1
> -            - const: wocpu0
> -            - const: xgp1
> -            - const: xgp2
> -            - const: xgp3
> -
> -        mediatek,sgmiisys:
> -          minItems: 2
> -          maxItems: 2
> =20
>  patternProperties:
>    "^mac@[0-1]$":
> --=20
> 2.44.0
>=20

--iA7tPiIVLweNoVjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjJ23wAKCRB4tDGHoIJi
0jQoAQCrI827zGT9l/GNCLHhBDxuB2DyQ+FKu0l+4FvZTur7ZwEA3BOvbyZ4jXdL
DGa1XxfE8CunnKNn9b20At6jUlGZwwk=
=dQTZ
-----END PGP SIGNATURE-----

--iA7tPiIVLweNoVjq--

