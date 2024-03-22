Return-Path: <linux-kernel+bounces-111875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ED2887207
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAB91F24436
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B395FDAE;
	Fri, 22 Mar 2024 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej6Aeh3C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5D5A4C5;
	Fri, 22 Mar 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129354; cv=none; b=Z41niSyGqBsiPkH+1c0RTNKKoHMJ4p2+aQS4C7epujrwGPzADoVdwC/J8yAbgiJjXjOpBooX5T7/Qq8yIMLzkrmh4Xh39IdX2ydslGDyI6gRHkl9clJwqTSjEBWS5MSVayiO2Bp8sG7HlUVXOsO166mvJ0GCagSynt5ye2MH3Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129354; c=relaxed/simple;
	bh=3kctBgA6lO8k+iTgwdlRZdF4LsZ7E3FLLcIygOl/PhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBhBxo4/l2pqPG5jEU8KwXmyM2RoYl0BwQXiG7yjnP7Nscw7vTI8C6nE1kmGhyCol8f/5VatS2a1bSmFQjDd4X/qweovnmxpAwMAwALTBxoEz4rI6wnslBJxNUImDfv/tQhmx5I66OUgcPrv5M5EnyP1utvPftSwDwVuZdTWJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej6Aeh3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D76C433C7;
	Fri, 22 Mar 2024 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711129353;
	bh=3kctBgA6lO8k+iTgwdlRZdF4LsZ7E3FLLcIygOl/PhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ej6Aeh3CoH8kLnzYgrIrHa5ws9MHyb+JqLdpLA+ALsczv8CRg8/W1qneRl9NPhV4G
	 Sb2kDLEfDcMLXH7JCyGchJOLx8n4d4TTwDAKVFZHhnsMglnxNPbOtWWgdUm031o4+k
	 8GEA50RUjoTQzt7mBz7lj47lE29RMH4TTimr1KYfjuB2SMSKMn8/vbFz0Vs0/9hPbE
	 EesxTpYwPk3Z8PdOezw5pySCQrINyRMTaFai4XymGi/99vf3AHBB7+N5Iqf7LmFQNC
	 gbwZ3YE3PI08ccSeltFvAEF8eGqIS6yyPKRNd+JkkhA/jGwyIYvGD6mE6R1NHkq3fy
	 mf0YaS+HrXt0Q==
Date: Fri, 22 Mar 2024 17:42:27 +0000
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
Subject: Re: [PATCH 1/4] dt-bindings: soc: mediatek: Add support for MT8188
 VPPSYS
Message-ID: <20240322-lugged-tabloid-3d5a85dc58d0@spud>
References: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
 <20240322092845.381313-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RnulqveRO5MGLP2A"
Content-Disposition: inline
In-Reply-To: <20240322092845.381313-2-angelogioacchino.delregno@collabora.com>


--RnulqveRO5MGLP2A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 10:28:42AM +0100, AngeloGioacchino Del Regno wrote:
> Add compatible for MT8188 VPP mutex.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

You should at least mention the difference between this any anything
else.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mute=
x.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> index ba2014a8725c..a10326a9683d 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> @@ -33,6 +33,7 @@ properties:
>        - mediatek,mt8186-disp-mutex
>        - mediatek,mt8186-mdp3-mutex
>        - mediatek,mt8188-disp-mutex
> +      - mediatek,mt8188-vpp-mutex
>        - mediatek,mt8192-disp-mutex
>        - mediatek,mt8195-disp-mutex
>        - mediatek,mt8195-vpp-mutex
> --=20
> 2.44.0
>=20

--RnulqveRO5MGLP2A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZf3DAwAKCRB4tDGHoIJi
0h/UAQCmi1zJDBqq/ELBeN+fgFnCvi/ZrBGGgS+TL6o5qCdBGgD/RNFzAN9Zq2LO
sIgPEEJHFQ88CwRPTus+5+JuaPXzLgQ=
=m4WI
-----END PGP SIGNATURE-----

--RnulqveRO5MGLP2A--

