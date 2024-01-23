Return-Path: <linux-kernel+bounces-35779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A43839663
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8032C1F24B94
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98894811EA;
	Tue, 23 Jan 2024 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNCZ7fRS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8118180027;
	Tue, 23 Jan 2024 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030839; cv=none; b=PYAXE8pbvybEgLH0HTzWyYtIrz3oXSNsYvWTpH1gbef/YS+kChfjKv1ruSLWJeEcWpVoNmtgWfkEgobda5ZDTHDjWcIbqchfXiu6QbdhV0NO12O2NsIhMwrmwBVJ/EsZxLBNnOn8gthUpUXm9GSrDGRf27SR85w/9o/cwyPiIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030839; c=relaxed/simple;
	bh=x/RapcgkYrZ4n19ONhCZoeWczR9Ix/nCHIHmNGyqH4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZywm/2PibXjdJDGMgJvZ7w3saNnB2LGtJiNfid0ZkzINp4XOYbp9NQQnoMLiPBXfNpFLztEYMwd9IY4S40cVO1fpjKr8guEs2/yIlMerXvEs+bUBjTwRDtSET5X+URSbFkYb/aDwvxJdbkaYK/aKBO88mUywL1FcXUZenGmTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNCZ7fRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D5BC433C7;
	Tue, 23 Jan 2024 17:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706030839;
	bh=x/RapcgkYrZ4n19ONhCZoeWczR9Ix/nCHIHmNGyqH4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNCZ7fRSS8wM7eJBgeIxDdpmfWk2pUbMREhEl1lbnJRRtNT+z8AQuz5BbxDjpvQtQ
	 VhcawpcmgSJYGPrSLFHnfxCBpS3tJSP+FfhXKfNHK3CMcrfQu3cDqZzZbqivUxhSyt
	 +XY8qgPysam2pvlAkGvXN32dhasHg3Mnb5zBY4QbAD8W+XahQ2rsNagyxHodFBihUK
	 biwTnXnwlDZzcLwKkUlCQK3Rb/JSsIWqtwk0pKYUZd6KwngGenefDTuOQVh03s4gL7
	 4g496QDuvH136IIez1h4JSWthsq/D49mc7VMeVwwOu+6Tsymu05912/vPP0cIxXlcy
	 j+An4F2+MP1dQ==
Date: Tue, 23 Jan 2024 17:27:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: thinh.nguyen@synopsys.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	balbi@kernel.org, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mark.rutland@arm.com, mathias.nyman@intel.com, pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add system bus request info
Message-ID: <20240123-poking-geography-33be2b5ae578@spud>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uT6qsPdC97JrYgBl"
Content-Disposition: inline
In-Reply-To: <20240123170206.3702413-1-Frank.Li@nxp.com>


--uT6qsPdC97JrYgBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:02:05PM -0500, Frank Li wrote:
> Add device tree binding allow platform overwrite default value of *REQIN =
in
> GSBUSCFG0.

Why might a platform actually want to do this? Why does this need to be
set at the board level and being aware of which SoC is in use is not
sufficient for the driver to set the correct values?

Thanks,
Conor.

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Docum=
entation/devicetree/bindings/usb/snps,dwc3.yaml
> index 8f5d250070c78..43e7fea3f6798 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -439,6 +439,42 @@ properties:
>      items:
>        enum: [1, 4, 8, 16, 32, 64, 128, 256]
> =20
> +  snps,des-wr-reqinfo:
> +    description: Value for DESEWRREQIN of GSBUSCFG0 register.
> +      ----------------------------------------------------------------
> +       MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
> +      ----------------------------------------------------------------
> +       AHB      |Cacheable     |Bufferable   |Privilegge |Data
> +       AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
> +       AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
> +       AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
> +       Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
> +      ----------------------------------------------------------------
> +      The AHB, AXI3, AXI4, and PCIe busses use different names for certa=
in
> +      signals, which have the same meaning:
> +      Bufferable =3D Posted
> +      Cacheable =3D Modifiable =3D Snoop (negation of No Snoop)
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    maxItem: 15
> +
> +  snps,des-rd-reqinfo:
> +    description: Value for DESRDREQIN of GSBUSCFG0 register. ref
> +      snps,des-wr-reqinfo
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    maxItem: 15
> +
> +  snps,dat-wr-reqinfo:
> +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> +      snps,des-wr-reqinfo
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    maxItem: 15
> +
> +  snps,des-wr-reqinfo:
> +    description: Value for DATWRREQIN of GSBUSCFG0 register. ref
> +      snps,des-wr-reqinfo
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    maxItem: 15
> +
>    num-hc-interrupters:
>      maximum: 8
>      default: 1
> --=20
> 2.34.1
>=20

--uT6qsPdC97JrYgBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa/28QAKCRB4tDGHoIJi
0rqJAQC4jL1FYVAySaeVuLvke0qQEQUpG/jJ7OxO64ZUcXl6nwD+In3AVAC2usfT
M0thzO+OawvnE9qiNWUlsEyPa511vQY=
=lZL6
-----END PGP SIGNATURE-----

--uT6qsPdC97JrYgBl--

