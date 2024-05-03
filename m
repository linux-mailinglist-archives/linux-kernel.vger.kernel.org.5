Return-Path: <linux-kernel+bounces-167894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CCA8BB0C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4001C20EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49572155381;
	Fri,  3 May 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8Qb7Kok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C86154428;
	Fri,  3 May 2024 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753307; cv=none; b=WREhSFTRIAiC/B3g1sUtlFT78+UWiDMi0J7aZ40swubXhuXKG9YcSUYuvzo9FBPHDt4fyk6jhJ2g2f7yeZY4+Cm9TD13/pYk+yiKZIhr0+vfAHONaz86TED7Y/INtIdNC8Ycwky9rZE/Fu6ams1X33ccQp6i7HrqKaH9nJz3NE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753307; c=relaxed/simple;
	bh=1xspHNPP+TAZ5j87YBguQVSvoCMWV6Hj7z2sBpc6Hfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzW4jDLqCMQXPh4IXpF7VUzqNnfsp/ho1BwuFmdGZkarC3AuaUoZyBeh5dUN1bmfMz2RJQPXqdl+f2NeYCtHanNA16VbPoxNnXY0SY4JgHyN8pTnyGDPPkuBn8hhjmaS1VUmSTQrZFsmYUEAW/L+RYN9SLuHPhYtkHyjigHumQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8Qb7Kok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECD2C32789;
	Fri,  3 May 2024 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714753306;
	bh=1xspHNPP+TAZ5j87YBguQVSvoCMWV6Hj7z2sBpc6Hfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8Qb7Kok9YovhpoYrNxz5FxEMbMUkRFVMkQHsBPD8AB14xyiH5BEBEaXXhLcgyLva
	 3a+J3KrE2k0Y2f4EJQ8qvf+7B2k5wdW8XVFSmlLwOA09cBtBQojng0v+lpI1UVNdry
	 bF9I6r961mQGpUhMd5pP1HEgtU5Kf1hHTYpqiiKXsyTt8MhxdbJZ3IUYI0/uwzhRCj
	 FmX2JPdPgc66nGFIr0l+AQYknCaBDnP2TGm2lUpjab64QY8rPw278SKNnSyM5DGPdr
	 Ne1hJsF/0AmSojg7Mim/dTvurTJpp924uEvCW2rFnzAy05fIQB8er2EDKpNbc7p93U
	 96cL6plnyP48g==
Date: Fri, 3 May 2024 17:21:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: mips: brcm: Document mips-cbr-reg
 property
Message-ID: <20240503-oncoming-taste-bab71375b67c@spud>
References: <20240503135455.966-1-ansuelsmth@gmail.com>
 <20240503135455.966-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LyhWp7dhQDBYJl7Z"
Content-Disposition: inline
In-Reply-To: <20240503135455.966-4-ansuelsmth@gmail.com>


--LyhWp7dhQDBYJl7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 03:54:03PM +0200, Christian Marangi wrote:
> Document mips-cbr-reg and mips-broken-cbr-reg property.
>=20
> Some SoC suffer from a BUG where read_c0_brcm_cbr() might return 0
> if called from TP1. The CBR address is always the same on the SoC
> hence it can be provided in DT to handle broken case where bootloader
> doesn't init it or SMP where read_c0_brcm_cbr() returns 0 from TP1.
>=20
> Usage of this property is to give an address also in these broken
> configuration/bootloader.
>=20
> If the SoC/Bootloader ALWAYS provide a broken CBR address the property
> "mips-broken-cbr-reg" can be used to ignore any value already set in the
> registers for CBR address.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mips/brcm/soc.yaml    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.yaml b/Docum=
entation/devicetree/bindings/mips/brcm/soc.yaml
> index 975945ca2888..12d394b7e011 100644
> --- a/Documentation/devicetree/bindings/mips/brcm/soc.yaml
> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.yaml
> @@ -55,6 +55,21 @@ properties:
>           under the "cpus" node.
>          $ref: /schemas/types.yaml#/definitions/uint32
> =20
> +      mips-broken-cbr-reg:
> +        description: Declare that the Bootloader init a broken
> +          CBR address in the registers and the one provided from
> +          DT should always be used.

Why is this property even needed, is it not sufficient to just add the
mips-cbr-reg property to the DT for SoCs that need it and use the
property when present?

> +        type: boolean
> +
> +      mips-cbr-reg:

Missing a vendor prefix.

> +        description: Reference address of the CBR.
> +          Some SoC suffer from a BUG where read_c0_brcm_cbr() might
> +          return 0 if called from TP1. The CBR address is always the
> +          same on the SoC hence it can be provided in DT to handle
> +          broken case where bootloader doesn't init it or SMP where

s/init/initialise/ please :)

Thanks,
Conor.

> +          read_c0_brcm_cbr() returns 0 from TP1.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
>      patternProperties:
>        "^cpu@[0-9]$":
>          type: object
> @@ -64,6 +79,23 @@ properties:
>      required:
>        - mips-hpt-frequency
> =20
> +dependencies:
> +  mips-broken-cbr-reg: [ mips-cbr-reg ]
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        anyOf:
> +          - const: brcm,bcm6358
> +          - const: brcm,bcm6368
> +
> +then:
> +  properties:
> +    cpus:
> +      required:
> +        - mips-cbr-reg
> +
>  additionalProperties: true
> =20
>  examples:
> --=20
> 2.43.0
>=20

--LyhWp7dhQDBYJl7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjUPFQAKCRB4tDGHoIJi
0pNZAP96jyklbklNPKY4YnOx/KmP7ftWMWURZUPZ4jJx+TeBcgEA5ffTEJvJzWNp
Msg4JtZu9TUybY2OeU8jwDgGHKilzQQ=
=Csss
-----END PGP SIGNATURE-----

--LyhWp7dhQDBYJl7Z--

