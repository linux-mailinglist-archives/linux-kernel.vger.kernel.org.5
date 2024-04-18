Return-Path: <linux-kernel+bounces-150400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE288A9E88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377FCB2217E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF0916D316;
	Thu, 18 Apr 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8oGWQZc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B83B18D;
	Thu, 18 Apr 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454578; cv=none; b=feBKdY/Yw8yNOOIrd833XEcMhdb4IQpxf4VqnGQaBvI/qRMxlheeaIn9xfBsED7/Dc7iJvo3xlPUdh6m3I/0gpXP0Y3omAPbVmwGf2EGi1xOeOET1ry9x4gym95Zmg9IUkrFx+pnB8V6MlYRovqanMKj+9/UaAeNiW8js2hUDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454578; c=relaxed/simple;
	bh=iX5QaTNtU1cJXLRSsSLOTU8Vc2xkKeqLNQsQzn49fRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr24rNHPeEtyJkbrMIcDVzpYw92SpVOpvX4qQvGromnOegXnMdRA2MoajxUW7QwhuT+Dc6CBzc1S+SB2G4DjqF9tZeqp15Zqd2gGchTpGY8JOBNaVhGDorhz0/3cdQnu1YZsf1UPXwH2+0PDYjRifaemBPo7qDfjDV1K9XWOrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8oGWQZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F655C113CC;
	Thu, 18 Apr 2024 15:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713454577;
	bh=iX5QaTNtU1cJXLRSsSLOTU8Vc2xkKeqLNQsQzn49fRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8oGWQZcyO1SbI+PQ38bMnv1TS2PY9pUBmGOVXp3ZmdlHuJFxggE0LI9RaTsizwLT
	 UmaVtbq5HS5UFlQFPzXQzEq8Cnft33ONJiWsKLPBsdv5gtK1s7vAFATFr/Tm7J0Of8
	 qgU/aVm+OjZjEDEDnbqnMyqOUtKoQ+9xOzZpaCQRSMbf9Y45kQKosWpmtZWwt1m/Fg
	 aL6KSOvMn+McZYcfhAqpfUbQTinAXQbDE5c731YyEKo7707lCulnb9PdVDT7TjEqlP
	 qVmU6L/WMDoPvLTB8bfuepac7rGw/ecmY4WNBIuXUy9dLy70iu7rGb/NHKxupxPk1a
	 bstzE4Fe4p0kw==
Date: Thu, 18 Apr 2024 16:36:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: correct the model name
 for Radxa ROCK 3A
Message-ID: <20240418-liberty-pry-d270065a544f@spud>
References: <20240418130120.67663-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vgqi5H0ybv66eynq"
Content-Disposition: inline
In-Reply-To: <20240418130120.67663-1-amadeus@jmu.edu.cn>


--vgqi5H0ybv66eynq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 09:01:19PM +0800, Chukun Pan wrote:
> According to https://radxa.com/products/rock3/3a,
> the name of this board should be "Radxa ROCK 3A".
> Also update compatible to match the model name.
>=20
> Suggested-by: FUKAUMI Naoki <naoki@radxa.com>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docume=
ntation/devicetree/bindings/arm/rockchip.yaml
> index 99bd5e2c76a0..88e9e0011953 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -772,9 +772,9 @@ properties:
>            - const: radxa,rock2-square
>            - const: rockchip,rk3288
> =20
> -      - description: Radxa ROCK3 Model A
> +      - description: Radxa ROCK 3A

This is fine, but...

>          items:
> -          - const: radxa,rock3a
> +          - const: radxa,rock-3a

=2E..this was added 2 years ago, I think it's too late to change it, NAK.

Cheers,
Conor.

>            - const: rockchip,rk3568
> =20
>        - description: Radxa ROCK 5 Model A
> --=20
> 2.25.1
>=20

--vgqi5H0ybv66eynq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiE97QAKCRB4tDGHoIJi
0nPHAP42ecBP8384x+tVEb65jCrg5kE5XHUGHae4JCUIFDeTQwEAu/8S4FsNJBlg
gTDgwIn/8IrTGdDnnLwIAomhvsjcXwk=
=OSj/
-----END PGP SIGNATURE-----

--vgqi5H0ybv66eynq--

