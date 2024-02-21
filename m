Return-Path: <linux-kernel+bounces-75338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FEE85E6D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40C82862F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430808594D;
	Wed, 21 Feb 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0GKN4uz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810769DE5;
	Wed, 21 Feb 2024 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542165; cv=none; b=oNsbQ5hOBmeZBnUZ6hI5CqjJxpbvrEuol2lZoag+stIlXhbdhLr7LBO2HdKzG1BWQ6i0MhJKyCJVVNg7bPR2g+sBftTPaD4cxNrv4imk8Eal02OvK9vsZ6fm90dU/p7zMfyaCp5eTvaHwvyKr9lfCZtdnSWaUZ0IuBAnPdkJKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542165; c=relaxed/simple;
	bh=Kq56kAG03QGNn+CX3JoT3D4J50nG3wBXsto8joaj6nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6Y4oz5WqoqzNHJW0hzxX/bc8jCfvcP9pBxS0cK55adEVkY1lUvHP+wTOe37ni6/MMiyqyOlJMhOHn7fPIAcp9968+DfHcv489jK4Kze5QKrtTO7oqzmcTIedlAqUrQhKpXPBK8+GhtBnQkyZk4uBHpbuZWrZI27vyBMDlzMu6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0GKN4uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD80AC433C7;
	Wed, 21 Feb 2024 19:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708542164;
	bh=Kq56kAG03QGNn+CX3JoT3D4J50nG3wBXsto8joaj6nA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0GKN4uzj/+puIOtsCFZuLrHJTzQ0jyTBfwk23twnDP9l6LLMEt0g1HJpcz5Ai13s
	 t383J/cZ8fQM4ntz6Paz/Y4EnD4j6RbyqnBi4/jPnaH6Be6iBJjFW+kf5sDZxNVADn
	 7GUyC44M1Bl6GDGo2v2DVoAtmZAU9BdV9kg76H92SrbM2UPqIto0x6H3WWFU5NvA4h
	 fpY5G95mIX/QimLAWQsW9N8Mg+Cjb2vJV2S1kPMT69H++A4UofxxstphFuUdF6zrL7
	 H2ibVLF8FqygO9iv3+9rHdmGhdyAO59ZTdXuTmhNj2/ihmv44lWrzbX9tG0TzLdccq
	 a77NM5l6jjb/Q==
Date: Wed, 21 Feb 2024 19:02:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm64: mediatek: add Kontron
 3.5"-SBC-i1200
Message-ID: <20240221-trance-handheld-59c5066aeca6@spud>
References: <20240221155905.1217340-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vjJZp3HexdVYJTnL"
Content-Disposition: inline
In-Reply-To: <20240221155905.1217340-1-mwalle@kernel.org>


--vjJZp3HexdVYJTnL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 04:59:04PM +0100, Michael Walle wrote:
> Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
> computer.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
> v3:
>  - drop description and add to mt8395 existing entry
>=20
> v2:
>  - convert enum to const as there is only one specific board
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 09f9ffd3ff7b..29ebe1f9c1d2 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -353,6 +353,7 @@ properties:
>            - const: mediatek,mt8365
>        - items:
>            - enum:
> +              - kontron,3-5-sbc-i1200
>                - mediatek,mt8395-evk
>                - radxa,nio-12l
>            - const: mediatek,mt8395
> --=20
> 2.39.2
>=20

--vjJZp3HexdVYJTnL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdZIzgAKCRB4tDGHoIJi
0hdYAPsEFG/2oLEhg2asBC0ZJ9IOZ+gngGyXIlvYt2JvKSi4xgEA+D+t9lQSCW7p
Fgg/S4QdArJbqce3ktlR/KlQUrx6SAw=
=8mZJ
-----END PGP SIGNATURE-----

--vjJZp3HexdVYJTnL--

