Return-Path: <linux-kernel+bounces-48679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EBF845FAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59F8281966
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA95312FB18;
	Thu,  1 Feb 2024 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmKwZezX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF312FB05;
	Thu,  1 Feb 2024 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811327; cv=none; b=WG0mVwPM32a2wkLbMG5Iiy1Gj8431X/9pyRPcV2kjwMkXlwaay6kYK/E0wuDDL+/XmH7sCOte8Gze563FloulZTWHHfMpc3qHgI9shPcMfaHpi/36YiakaoR1WJahzcjtsHrvsOU62YwuW4ux8xb9d7pViDqqoNcqnqucbBC8pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811327; c=relaxed/simple;
	bh=qqBRy/V+j4DYg7LR5ViZpZbdV5GbisFCPkyKYMWCJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5zLPAzJOkZGhIpOv7DaPdzAHE0mDsaJZhSM5rNewRL7H2FOpC0N2InSMnD2zXzA4pDWP7RubF9Qn91bHOTfJ7IdhvExLQqx5nbECOvYLtEgTNmTjN2RWACLxXyk5tdcoHvZPRejw/VME733gcWx4XTiCoGGTNTH4SNwaqMINHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmKwZezX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86D4C43390;
	Thu,  1 Feb 2024 18:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706811325;
	bh=qqBRy/V+j4DYg7LR5ViZpZbdV5GbisFCPkyKYMWCJkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TmKwZezXAZrk9uzyqT93ZzPYnHB4FXigeUJs+bXwWdhNed6WCDuAmmY99N3p+yrGT
	 ZZJXb0oIdJFIszxgflEEjGVymxqloa4CF7SnBDOA/feW8oedK0WVyIJqYikiwwx4Ph
	 7o2g0qSGMikypqlVzHckG6G2sD6+DTd8M/27DO2X1gL8fYKbVBLfKaO/2JIurW54pt
	 TVgPEazJcRaZNiGgCNbGjwp0QZQOrliSTB9MuORKAsidD/qDIICUhaZGCJSGu65p3U
	 hNESSWwDzekKCWQkjYjS+v+zdz2ni01/A1nHPa7AXvj2nFSjnOrYTG4tiX6dY4xJoU
	 dqCS4cWIwEy6w==
Date: Thu, 1 Feb 2024 18:15:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: nm@ti.com, vigneshr@ti.com, afd@ti.com, kristo@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, srk@ti.com, r-gunasekaran@ti.com, b-liu@ti.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
Message-ID: <20240201-viewpoint-upload-fb714f650ff5@spud>
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-5-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OtyWSM2MmQ63Tw2S"
Content-Disposition: inline
In-Reply-To: <20240201120332.4811-5-rogerq@kernel.org>


--OtyWSM2MmQ63Tw2S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 02:03:31PM +0200, Roger Quadros wrote:
> So far this was not required but due to the newly identified
> Errata i2409 [1] we need to poke this register space.
>=20
> [1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>=20
> Notes:
>     Changelog:
>    =20
>     v3 - new patch
>=20
>  Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Doc=
umentation/devicetree/bindings/usb/ti,am62-usb.yaml
> index fec5651f5602..c02d9d467d9c 100644
> --- a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> @@ -14,7 +14,9 @@ properties:
>      const: ti,am62-usb
> =20
>    reg:
> -    maxItems: 1
> +    items:
> +      - description: USB CFG register space
> +      - description: USB PHY2 register space
> =20
>    ranges: true
> =20
> @@ -82,7 +84,8 @@ examples:
> =20
>        usbss1: usb@f910000 {
>          compatible =3D "ti,am62-usb";
> -        reg =3D <0x00 0x0f910000 0x00 0x800>;
> +        reg =3D <0x00 0x0f910000 0x00 0x800>,
> +              <0x00 0x0f918000 0x00 0x400>;

Why the double zeros btw?

Cheers,
Conor.

>          clocks =3D <&k3_clks 162 3>;
>          clock-names =3D "ref";
>          ti,syscon-phy-pll-refclk =3D <&wkup_conf 0x4018>;
> --=20
> 2.34.1
>=20

--OtyWSM2MmQ63Tw2S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvfuAAKCRB4tDGHoIJi
0mWrAQC3uMg2ymui8kJ6/QbX6cNAVZEC+xxJc3kwh3We812E4AEArck+H328Eujt
zt2rkVVVHTdwtsoFF7DgMldm202/zgc=
=6c4e
-----END PGP SIGNATURE-----

--OtyWSM2MmQ63Tw2S--

