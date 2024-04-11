Return-Path: <linux-kernel+bounces-140716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2161C8A1830
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13E72871FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0821427E;
	Thu, 11 Apr 2024 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHECe3j0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88320BE7F;
	Thu, 11 Apr 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848063; cv=none; b=NhQW8v4KcP4Zld4zxD9p5RohkAWDWYfnTqCobOni3MKXc3mKaLzY2xJ2hYCXHIr3H4A/lpN0EZflbevdU2o6DcRF93klyTxMxFTmTrH/2PPZKQt+2umEyLG3V/ufgAJRw0H2bxUU9HvZ9pEd2EYl2PesPkSu4dW9l5yhw/0g7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848063; c=relaxed/simple;
	bh=VpEv0RUqg4n89BJQGyRGVxP1qQqMYa3vM+hZex0YOeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHkXyhtIieYdkAWdEu/cppoYDeQpUYdInWPT5r7axZLiggrHthQnr0HB+wouxui8sSdUMor85oUnsvdbAQnWhqIaWM1Cu8mrMIaxzmWvv+nZF3tRZPNfdw5cmUSe8xS1Dp1uDPyLmU3N4V5uqabnqV/clTIDv7YujaifYbjEqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHECe3j0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28196C113CE;
	Thu, 11 Apr 2024 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712848063;
	bh=VpEv0RUqg4n89BJQGyRGVxP1qQqMYa3vM+hZex0YOeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHECe3j0C4p8Yt0BBy+MOlPPQI7mguC51Jijc2UlAycDcChcV/t9igE5resm1hJXY
	 816kOdVjm6KgP1Qz037HsCGtuoiufPuELVORLVNkTEBFfUZpUpVG6X0dO/mlkNKdWS
	 2VkzumDlVEmCc37le8ZG1yO+mnupDjo64y1l8+3y3/RCuGENK5svNPCRyUx7HHDkHq
	 B6nOJPZdLvPUOKhUihYKReckuI+Z7Ha/Nm9Hxba7j4cnH3sOtHEQfkBqBhpOn64bbm
	 aNnYN89FKxyWIuG/usB1L8Ltqr0neiZ/XCVJBkLiA83ZhWu45xXF5myJnrZywXmKti
	 U1xCeB5lHN58w==
Date: Thu, 11 Apr 2024 16:07:37 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-scsi@vger.kernel.org, alim.akhtar@samsung.com,
	avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peter.wang@mediatek.com, chu.stanley@gmail.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, lgirdwood@gmail.com, broonie@kernel.org,
	matthias.bgg@gmail.com, stanley.chu@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/8] dt-bindings: ufs: mediatek,ufs: Document MT8192
 compatible with MT8183
Message-ID: <20240411-owl-euphemism-955ca43b5190@spud>
References: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
 <20240411114300.169055-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w6qAEWdCVN3uindW"
Content-Disposition: inline
In-Reply-To: <20240411114300.169055-6-angelogioacchino.delregno@collabora.com>


--w6qAEWdCVN3uindW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 01:42:57PM +0200, AngeloGioacchino Del Regno wrote:
> The MT8192 UFS controller is compatible with the MT8183 one:
> document this by allowing to assign both compatible strings
> "mediatek,mt8192-ufshci", "mediatek,mt8183-ufshci" to the UFSHCI node.
>=20
> In preparation for adding MT8195 to the mix, the MT8192 compatible
> was added as enum instead of const.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../devicetree/bindings/ufs/mediatek,ufs.yaml        | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Do=
cumentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> index 32fd535a514a..adcd13023866 100644
> --- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> @@ -14,9 +14,15 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - mediatek,mt8183-ufshci
> -      - mediatek,mt8192-ufshci
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt8183-ufshci
> +              - mediatek,mt8192-ufshci
> +      - items:
> +          - enum:
> +              - mediatek,mt8192-ufshci
> +          - const: mediatek,mt8183-ufshci

It's a bit more distruptive since you'll have to modify a dts, but why
permit both of these ways of describing the mt8192? Could we drop it
=66rom the original enum and no longer allow it in isolation? There
shouldn't be any compatibility concerns with doing so.

--w6qAEWdCVN3uindW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhf8tQAKCRB4tDGHoIJi
0pr4AP9BKNcugGYlb1HWoH8V4MvvkEcaVh8Xm42KMyQkAxz+IgD/SPrydC7EpjyO
fuZgi9n2btcClNJjUcV7Nkr03VPk6Aw=
=PCb6
-----END PGP SIGNATURE-----

--w6qAEWdCVN3uindW--

