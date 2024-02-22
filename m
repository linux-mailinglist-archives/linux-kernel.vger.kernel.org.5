Return-Path: <linux-kernel+bounces-76841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D6C85FD75
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949101C24DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F3482D4;
	Thu, 22 Feb 2024 16:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7mjcf7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7914E2EE;
	Thu, 22 Feb 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617732; cv=none; b=QpSfygY+q/70DeOWq4g7nGl1nrx6KdrUcLMIBBhowHB93uSvo7LN4m4CmOrTwbJLEJNkeSwkpxNhGBozvr/G4jGiHiaDtkV5O/d8yAJiWWFDMNyl3+pvlL5RqQYxOfbNVXAkWC6Vm5n7DcF9ufrpFM9Cy6BIcthlGYDdcrL6bao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617732; c=relaxed/simple;
	bh=Qr0MkPs/G1e5Xn714YNrc9XRwhwgTkOSsxVVNWdF2LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBSr5PJv2lJHncjFxAJqKc6EdaZGu1s1VJxjPKHfSJk1dW/zCbFha/jf8/eyozu5O8rVyv8ZcX7I2FOKI+MSB+P4v+KJ1UtXp+l38gXBC+c2kdSrSNu/2mlaiH2iyoPGt2eTtnMExupLfmiL1Iy3BXMYg9hxLvxEuAhsMNf0BL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7mjcf7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A48C433F1;
	Thu, 22 Feb 2024 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708617732;
	bh=Qr0MkPs/G1e5Xn714YNrc9XRwhwgTkOSsxVVNWdF2LE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7mjcf7iuOCCBUXl/GQVlFFrxMwTHUcTkCCmfkoomiM+Dv+2Ji337lHaRBi7KaRVf
	 zsK4AmYrzBVIe+S43UmP/PCC7cBK5RDG/s4gFrZnNeNwWBdGB6jMB6HFKwQHPT7D3B
	 Nxji6MxxWHxhhtdIR0KcOxmZve7jfDNMrj8o4id73SFjKHTJSX/mz908fPjxvt9RTb
	 If4iL7FxlwrKaYFp9JZNW8x5dsZtvnDlpm8blbWXdO4JJysKg3apcq9dwrJm1TvgZk
	 QTJiczzpJfupb6RZyOhh5Labj0zj0eYBitvztx5Q+9JKzPmBXxiDpFUkfGJo1YvVbv
	 Fp4WixOUQC98A==
Date: Thu, 22 Feb 2024 16:02:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Kelly Hung <ppighouse@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Message-ID: <20240222-getting-nebulizer-8f75ba8063b1@spud>
References: <20240222085914.1218037-1-Kelly_Hung@asus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Au0+rESux1qqjOB8"
Content-Disposition: inline
In-Reply-To: <20240222085914.1218037-1-Kelly_Hung@asus.com>


--Au0+rESux1qqjOB8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 04:59:13PM +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.

It would be good to mention here what the x4tf is - is it a bmc or
an sbc etc.

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 749ee54a3..80009948e 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -74,6 +74,7 @@ properties:
>                - ampere,mtmitchell-bmc
>                - aspeed,ast2600-evb
>                - aspeed,ast2600-evb-a1
> +              - asus,x4tf
>                - facebook,bletchley-bmc
>                - facebook,cloudripper-bmc
>                - facebook,elbert-bmc
> --=20
> 2.25.1
>=20

--Au0+rESux1qqjOB8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZddv/wAKCRB4tDGHoIJi
0o1NAQDiH3SRJuW0MwTpJkcBg5fhpGT7l0kNzZE50LRD8OTzpQEAvil0P51VktVE
eKT9OoXtIoNfTpFjZaZWh785rWy/lQw=
=qCiR
-----END PGP SIGNATURE-----

--Au0+rESux1qqjOB8--

