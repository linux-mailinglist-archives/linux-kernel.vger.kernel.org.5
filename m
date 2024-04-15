Return-Path: <linux-kernel+bounces-145211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2080F8A50DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E6D1F210FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1FD8624F;
	Mon, 15 Apr 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYV8yr1B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E174C0C;
	Mon, 15 Apr 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186022; cv=none; b=THYw4CGR0Ic9HsXYKMjBWX3WUfJK8HqECUSNS9OgvOOonWLEXsbeR5eE4k4rFaJGFm/InfKk6ZHeKcLZvnePvO/zKOtlGQKDSPxKBtSop8ke653tOMyqMDDmBc7QJYcSVnFafVG0FTFuVwc1ANw16NMP50dRBVJl/nLTdNuuzoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186022; c=relaxed/simple;
	bh=k1NHarrRf6+0evlATOpqE9bsBp5lnGFC65EI2aXuFVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlDkXUbb+FKkRaCsZaCsQUrkxQPK9rMvPYLmEqeEY4EPWGR7sf7wyBk9hOxfc7hWgV+vgpmPaNiO+9rxZ4sY1ahyorfdqdLLVXQBCi07hbbU9Z7+/brFDCVgpyfZSYu8wqzprYYVVaZRtdWcLK9uHa/ee3+0HXGvHl9IfPI8ppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYV8yr1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A79CC113CC;
	Mon, 15 Apr 2024 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186021;
	bh=k1NHarrRf6+0evlATOpqE9bsBp5lnGFC65EI2aXuFVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYV8yr1BxQ8bEDR53ZXi1krWC2JwmtpDUQAKTgtQNR/woH2FPCaPGiWE4HFUzm6hK
	 VOZQ0pmrS0AYtMm3JUk2TPSGWJGdRqVIaX3SxH6bXN73YqDvmSh7eKn7JJMl5Nh+hQ
	 n9pWGWgvN4laYTYI8T4+zcKXnx95fjv0ddFenNS9q5qPrisMcZO5pMWMLv0xRqK8FU
	 NO9MCoZ/hG3rY+5jNOCOYWNH0ebCgiWDd3A+huW9GXIQDUXoFoqackzBPute7ksLFg
	 r2mIipvDd1VAupk2DicE6mpnxj0kAutIpS8/Zcjb3jZVyBffComsq7/YPkpaCOUEy6
	 lFTF/cd/Mebxg==
Date: Mon, 15 Apr 2024 14:00:16 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-scsi@vger.kernel.org, alim.akhtar@samsung.com,
	avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peter.wang@mediatek.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, lgirdwood@gmail.com, broonie@kernel.org,
	matthias.bgg@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 7/8] dt-bindings: ufs: mediatek,ufs: Document
 additional clocks
Message-ID: <20240415-happiness-reenact-6598d7b32435@spud>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
 <20240415110012.148871-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="93PiK0lDfTnn6QRe"
Content-Disposition: inline
In-Reply-To: <20240415110012.148871-8-angelogioacchino.delregno@collabora.com>


--93PiK0lDfTnn6QRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 01:00:11PM +0200, AngeloGioacchino Del Regno wrote:
> Add additional clocks, used on all MediaTek SoCs' UFSHCI controllers:
> some of these clocks are optional and used only for scaling purposes
> to save power, or to improve performance in the case of the crypt
> clocks.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../devicetree/bindings/ufs/mediatek,ufs.yaml     | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Do=
cumentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> index 5728e750761f..1df8779ee902 100644
> --- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> @@ -23,11 +23,24 @@ properties:
>            - const: mediatek,mt8183-ufshci
> =20
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 12
> =20
>    clock-names:
> +    minItems: 1
>      items:
>        - const: ufs
> +      - const: ufs-aes
> +      - const: ufs-tick
> +      - const: unipro-sys
> +      - const: unipro-tick
> +      - const: ufs-sap
> +      - const: ufs-tx-symbol
> +      - const: ufs-rx-symbol
> +      - const: ufs-mem
> +      - const: crypt-mux
> +      - const: crypt-lp
> +      - const: crypt-perf
> =20
>    phys:
>      maxItems: 1
> --=20
> 2.44.0
>=20

--93PiK0lDfTnn6QRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh0k4AAKCRB4tDGHoIJi
0mEcAQCL6JDQAVAMOHj599dEhcGaBzsjjotAhC16jd/M9usHrgD5AYNnPqgEhjhv
gRib2qn9ljMx3UT9oOUw9481wleicQQ=
=urMw
-----END PGP SIGNATURE-----

--93PiK0lDfTnn6QRe--

