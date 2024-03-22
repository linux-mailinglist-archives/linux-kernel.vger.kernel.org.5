Return-Path: <linux-kernel+bounces-111872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF178871F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376CD1F242D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B895FDA6;
	Fri, 22 Mar 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUV4V9ch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C015FBA5;
	Fri, 22 Mar 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129214; cv=none; b=UgMtDn88TE3i3fV22J8dXkcijwYGkLpNKbVNZouQBWPB9q26bvhkP2XsI0fmLjdROxDOd7zLLoCFT1LjBYCyhM8hJRV/bYFkdPqtLO3zF5K1Xcj1zSkUtcaF9P36v5glOdsBlHfBQ7L5CQqulAM1iZWPKrnEcwPtqZCA7CInMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129214; c=relaxed/simple;
	bh=tTwBbRt2pqHamlnWharifXWWwuWmdQz8Rk753vrs9Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGbaeP+bk/ShdsMxJX7Yj+DDkIxBw4jKn1yDd6BrZ40YxOod4pRaXHCzTL6EPqzGCoT32D+mIV4cc6KLrQ7uoykHLQ7FIpm3kbI9tIcWqu6olAByoDWqo2pc3ktCoHAemE403nna3QZuPZidSTwMelThruHj8SYfR0HZL0YSvKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUV4V9ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E1DC433C7;
	Fri, 22 Mar 2024 17:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711129214;
	bh=tTwBbRt2pqHamlnWharifXWWwuWmdQz8Rk753vrs9Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUV4V9chSdBEhmS3/ab/LOTuC18tZ5+Xt9D4PIFL9rhdteNBuxvFgwNzKnxUCpx39
	 xSNyMVK0iGDIKqvXHfr9GfE6EqcmmKwGa2zd3AQOkAaAiVFr2DIcDnvL/eLoWCW0+g
	 T0htdNedHpFoIJJrZjeG+pIY4NSf6RT4FWmmi4Ncvt0nkLS1j1l+pVWgHYJr+arT9G
	 LO7EgQJiZcHwwYVh4DCjxTcMZ+tqxSVapjXaPc7b5hPiwjEX4VkCK97zQZaYp73t/Z
	 tPiMy5yoJp4rpdLUxmFWfwpualX/lxqznaUpeG7zx71u3mZE32PxtDCWgqQbHBDw36
	 XaNwctZduV9JQ==
Date: Fri, 22 Mar 2024 17:40:08 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, amergnat@baylibre.com,
	moudy.ho@mediatek.com, hverkuil-cisco@xs4all.nl,
	sebastian.fricke@collabora.com, u.kleine-koenig@pengutronix.de,
	chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 3/4] dt-bindings: media: mediatek: mdp3: Add support for
 MT8188 RDMA
Message-ID: <20240322-elderly-ether-170408423883@spud>
References: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
 <20240322092845.381313-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TYbo2CO3aIfqwZwQ"
Content-Disposition: inline
In-Reply-To: <20240322092845.381313-4-angelogioacchino.delregno@collabora.com>


--TYbo2CO3aIfqwZwQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:28:44AM +0100, AngeloGioacchino Del Regno wrote:
> Add a compatible for MediaTek MT8188 RDMA, which supports only a
> subset of the MDP3 components of its similar MT8195 counterpart.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.y=
aml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> index 59db8306485b..18603f6c5e06 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -23,6 +23,7 @@ properties:
>      oneOf:
>        - enum:
>            - mediatek,mt8183-mdp3-rdma
> +          - mediatek,mt8188-mdp3-rdma
>            - mediatek,mt8195-mdp3-rdma
>            - mediatek,mt8195-vdo1-rdma
>        - items:
> --=20
> 2.44.0
>=20

--TYbo2CO3aIfqwZwQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3CeAAKCRB4tDGHoIJi
0l3AAQCL5XSgotDR4l9Rji+b5MSgqPkrXB/7xT15infA4yxeLgD/dJ3reW+ywpxg
TVn9ErbQIAsrdGYLZO/BdFSmBaP5pgE=
=sIb/
-----END PGP SIGNATURE-----

--TYbo2CO3aIfqwZwQ--

