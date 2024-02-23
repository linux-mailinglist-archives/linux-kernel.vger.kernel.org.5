Return-Path: <linux-kernel+bounces-78989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D36861BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E8B1F265F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E301448EB;
	Fri, 23 Feb 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkjhOTvS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D6142623;
	Fri, 23 Feb 2024 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708713445; cv=none; b=NrMsLq9P16Rc9XNVUt1xdyXFc+XrDZ0VDnX0czhHXVbrubgjua7WdXZq6LREPH0XSZIMLJ3gDQZhn5UxIfgPPCBpMCjRQDNKXg8AEEo46K2aPU0e/kkDuRX67Y0T6bCXkYp+QIB/qTs0fldF1DW3e23RIiepnL8pyAYf0EtX018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708713445; c=relaxed/simple;
	bh=nWLj7BswiRY+Rv2cQNEaNmMcKyLWVAT8jPEEecfQQOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvZ2VNgq1mpIXqn0W5sTF3d9hGMG0u6isV03L/ptBd4FTrxJuNrmKG3E3l4Ol8jNR+1G6C+80B1rgPFSATyWkSRQ8umeBSeALai1LAb1E91MVZ1/2qtBJbNz8CKUpFH2ybe6ispkDIUKyVtreXgLPOBKm2XuI3UYuxN3Clprh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkjhOTvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30104C433C7;
	Fri, 23 Feb 2024 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713443;
	bh=nWLj7BswiRY+Rv2cQNEaNmMcKyLWVAT8jPEEecfQQOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkjhOTvSBBf++VXQIYhFfweJ1MPu1fJ8pYKf7Of9FAZKLi6vxAdFNuojDYg2kioip
	 /eOCLer7fG5l32WN78LkS98D/IIvzjIg6qYQavHo0s18bhCdnk5PkOW6KqDB2736sk
	 FM78BVLa8xWb8QHZGFdbEBDTbfSo2zriYWnHTNYiW2g93wKsMO9c92du7fBiGNYlAn
	 2wquJEcDctO2onWb5+lvUjeaZFHfRyYw0R/K0HYLsy2gc2C9Svd5ZTl/X2OqALHL65
	 ANT5O9oWg57X/IolK/f9m+CTdhwikjmXEZXDPWlAhs6eG6Boq7gkAbSGY1T6wtfKft
	 wyCWn6TIrzOOA==
Date: Fri, 23 Feb 2024 18:37:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org
Subject: Re: [PATCH v2 04/14] dt-bindings: mfd: ti,tps6594: Add TI TPS65224
 PMIC
Message-ID: <20240223-amenity-amaze-771541e8c9af@spud>
References: <20240223093701.66034-1-bhargav.r@ltts.com>
 <20240223093701.66034-5-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m+6VddC4kf/ZkgtO"
Content-Disposition: inline
In-Reply-To: <20240223093701.66034-5-bhargav.r@ltts.com>


--m+6VddC4kf/ZkgtO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 03:06:51PM +0530, Bhargav Raviprakash wrote:
> TPS65224 is a Power Management IC with 4 Buck regulators and 3 LDO
> regulators, it includes additional features like GPIOs, watchdog, ESMs
> (Error Signal Monitor), and PFSM (Pre-configurable Finite State Machine)
> managing the state of the device.
>=20
> In addition TPS65224 has support for 12-bit ADC and does not have RTC
> unlike TPS6594.
>=20
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/mfd/ti,tps6594.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml b/Docu=
mentation/devicetree/bindings/mfd/ti,tps6594.yaml
> index 9d43376be..6341b6070 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> @@ -21,6 +21,7 @@ properties:
>        - ti,lp8764-q1
>        - ti,tps6593-q1
>        - ti,tps6594-q1
> +      - ti,tps65224-q1
> =20
>    reg:
>      description: I2C slave address or SPI chip select number.
> --=20
> 2.25.1
>=20

--m+6VddC4kf/ZkgtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjl2AAKCRB4tDGHoIJi
0tdzAQDrQK1Yfxs9DB42UTfX+yD9AkqCKl8eikfMYszRN8mbuwD/UGFsz0wfdaHM
VB1hlmSMcvqWdZ6R+7SLQGN3+Mz7rAA=
=HB/n
-----END PGP SIGNATURE-----

--m+6VddC4kf/ZkgtO--

