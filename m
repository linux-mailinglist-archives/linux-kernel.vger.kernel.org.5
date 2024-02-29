Return-Path: <linux-kernel+bounces-87210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A586D120
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766F01F23C44
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F0757E0;
	Thu, 29 Feb 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKJ/7lZ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB770ADA;
	Thu, 29 Feb 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229112; cv=none; b=fv9ttztiC9kxrOJ9j9iN2PwDDc2+X7ZdEDyatbQHI0ggcd1O94MUm+SUFVZgSZh5hfMbzDIno0T2uVSLD/IV7v/oCowDw/ZXysNzcZ6q963UHYFAViGfhJj02JYXdFDKbkRnojHRpGArHqMLnS5Pz2rV3xMXQmbV3K6ufMA2fwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229112; c=relaxed/simple;
	bh=pztRkRIxZDjEK/P+/LrFIUNQxaKPYxqTS7e0Q1kH47s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq33k7rv9gzdvmzFchC52JE8jR8QzAD0Dc66yznM8TxOWGj0CxbIQolVUz/e2SvLi7Z6N0O+871JGsKRXM35nkxEGlBDvHYJVSbzvoq3Czyx1oYLzp+Xc9PQ3sJ8t5uZH6Z7gBgB33t89N3U417VBvUyMguBJEUDDAcEe6JByRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKJ/7lZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893DAC433F1;
	Thu, 29 Feb 2024 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709229112;
	bh=pztRkRIxZDjEK/P+/LrFIUNQxaKPYxqTS7e0Q1kH47s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKJ/7lZ8bU4TFocSdCeda8O0nO6TBeOqN6MIiu/oiBNPTBjR+0Ndya1EyyreRLmX9
	 onNTc3eQatK2kN5b4Unmui/88ihW7yh0qEmYw66E7LkX4c0iYgjvPy80EkK098Tb95
	 2d9+vDtYeneE14tMrMdZMKgJmMs/LRfyk4IZkrRQwJDuW+0s128o1lhWD+5gimsJEU
	 bvj1YBa37WM5oxwPe01AmmGJnCfojE1EEjpjTwSouhufePlGr32fz7Cz6EM+XFTeo/
	 BPIkHcR/lQVV6T0AQb5BtXgH4jVI3x7ZAkGsORvpDaIJvkyv1eEx8hhLVBomPHO/+q
	 mLAjzolrJhIWg==
Date: Thu, 29 Feb 2024 17:51:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Kelly Hung <ppighouse@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Message-ID: <20240229-rocket-fraction-76e85d9f4bfb@spud>
References: <20240229111123.1932504-1-Kelly_Hung@asus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DSM6j8ISbsPmqzxr"
Content-Disposition: inline
In-Reply-To: <20240229111123.1932504-1-Kelly_Hung@asus.com>


--DSM6j8ISbsPmqzxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 07:11:22PM +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.
>=20
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> ---
> V4 -> V5: Update all changelog from v1 to v5.
> V3 -> V4: The new compatible is a BMC for a ASUS X4TF server which use a =
ast2600-a3 chip,
> so correct string to asus,x4tf-bmc.
> V2 -> V3: Add a label to indicate it is new compatible for bmc.
> V1 -> V2: Remove blank in front of the string x4tf.
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 749ee54a3..0047eb4ab 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -74,6 +74,7 @@ properties:
>                - ampere,mtmitchell-bmc
>                - aspeed,ast2600-evb
>                - aspeed,ast2600-evb-a1
> +              - asus,x4tf-bmc
>                - facebook,bletchley-bmc
>                - facebook,cloudripper-bmc
>                - facebook,elbert-bmc
> --=20
> 2.25.1
>=20

--DSM6j8ISbsPmqzxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDEMwAKCRB4tDGHoIJi
0uSjAQDCxfOMOXE+N731h+7UuR11yoaeareD7d4LNBi19TtxKwEAwClcXRFU8kKV
1lxH4YC6Df+mCB0HWCV9QJLXzygNIQM=
=pTcc
-----END PGP SIGNATURE-----

--DSM6j8ISbsPmqzxr--

