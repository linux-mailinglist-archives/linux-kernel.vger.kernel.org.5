Return-Path: <linux-kernel+bounces-62182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B37851CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599B6B25811
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0FC405D4;
	Mon, 12 Feb 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNk7OdK5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7A4C99;
	Mon, 12 Feb 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762634; cv=none; b=r5RzGp98pMa6IDVi6jUxKlbcmgG7nXlAai0f129BqdOimxsjkVoLGgoWy2BYtXzSVq8uyEW30GLBhdcsGeWSXxUPxzClhG5z8U8mxygQ0lNKcl7VIcKDcjs49L5OAbcH2KNqwcRtVmZzxAt+MSug6r+VJK4l6mYEG3ROyIaEkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762634; c=relaxed/simple;
	bh=6WiiTc2GDFm9N1l5HMkfYx0/LzGK7veAUDVvhiMnnQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck9Dz5Pk1+mpTyNlT1S20Kf5/fGI7N9Cw72xvnR7mrsU4a5KQtizvHwv/++t1An5b0HW7i9xD3eEmkYhbpfIKRYGnPF0l5wVYV0SxlarnrxQiuLSIG1TK9ziGIPvVJqVcAWiqNDhVJ/AbA64uWDtasLALkIutdZC3JMv6i9znVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNk7OdK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368B8C433C7;
	Mon, 12 Feb 2024 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707762633;
	bh=6WiiTc2GDFm9N1l5HMkfYx0/LzGK7veAUDVvhiMnnQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNk7OdK5j2JejmjY9K8x1whAEoB5vmQrby/sMV5spd00ZhEXp7xVF0m2KWdQNIxR7
	 l2lXc1+Z0nR8cKLHDq4xzDm3UqMCMjKJUF+YDCGMtAs5smjS11kutL4/fYZrB/MFK+
	 bgNJiHV2J/hgl92rZhVaX72PXhSh/EgrDnMzSREznDqgVo34Zy4QT15p5zRqhrYQCD
	 ZGm0fk4+iNwUY48q+rAHyXhwF9S6lgavloXRGpAZDpJ/eDTviPmXHR5AbyRvy3VWk/
	 otKMRaSHE4y/cRuOz3UNZOH6NcbdBObq0hmGPrgQW69qRNTnkpHsVqhDCc/xC+OXiu
	 TDnxKbNBufdUg==
Date: Mon, 12 Feb 2024 18:30:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: memory-controller: st,stm32: add MP25
 support
Message-ID: <20240212-dial-strangle-0b6861b35ec9@spud>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-2-christophe.kerello@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YkxopxwhiToMlaYp"
Content-Disposition: inline
In-Reply-To: <20240212174822.77734-2-christophe.kerello@foss.st.com>


--YkxopxwhiToMlaYp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 06:48:11PM +0100, Christophe Kerello wrote:
> Add a new compatible string to support MP25 SOC.

You're missing an explanation here as to why this mp25 is not compatible
with the mp1.

Cheers,
Conor.

>=20
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
>  .../bindings/memory-controllers/st,stm32-fmc2-ebi.yaml        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm3=
2-fmc2-ebi.yaml b/Documentation/devicetree/bindings/memory-controllers/st,s=
tm32-fmc2-ebi.yaml
> index 14f1833d37c9..12e6afeceffd 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-=
ebi.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-=
ebi.yaml
> @@ -23,7 +23,9 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    const: st,stm32mp1-fmc2-ebi
> +    enum:
> +      - st,stm32mp1-fmc2-ebi
> +      - st,stm32mp25-fmc2-ebi
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.25.1
>=20

--YkxopxwhiToMlaYp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcpjxAAKCRB4tDGHoIJi
0jlEAP40gxiapecNCdq4bMYSWey8hRA2SHHEVuZiljTNDaCr1gD+PirbU2q0jSAQ
dUblhSmGOo/z/tonrLaHyqgGbMx3ng0=
=i0Rq
-----END PGP SIGNATURE-----

--YkxopxwhiToMlaYp--

