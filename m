Return-Path: <linux-kernel+bounces-105431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68AD87DDC8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663941F21375
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73721C698;
	Sun, 17 Mar 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWg/4XMJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13151179B1;
	Sun, 17 Mar 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688255; cv=none; b=T7ZOLdXoNT/uMnViD0EEjwG2a6JyCAOzkpiugIb/fSHWObNbPBBCPArxHLysIgMWJJi7sRwWF+dMhXPde4DipnxeteAQ4Ntz8Fcx4QoTkHqT1QfznrUz3p7KHPKm/xifC57ru39YqOgivmfoJXmzWMMQdl+B1MYBUd9jrIPpJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688255; c=relaxed/simple;
	bh=z1ClYt8EUFyrksAqbU/+xgzstdH+GsoxmA2t05ngUuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM7/cT3Goc/EH82JoqSYWBEWQuxQEZ8NX4nGw6g9RT9byD+1RIrYNPPrgMz1qccANgJylsUu4aU/ZpbhU6Nx5/nTQiWE4wRfJcFl5Ymtrn5vT68VFV8Nef18yX69kEnOpV9UIq03h0yvtBpR/F6BkjPARmh9wHp/Beo5DPl7LnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWg/4XMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9869C433C7;
	Sun, 17 Mar 2024 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710688254;
	bh=z1ClYt8EUFyrksAqbU/+xgzstdH+GsoxmA2t05ngUuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWg/4XMJ771mEhsDvVPEpo3UcCsALpk8y6YLcMufT+lgeaUrEsxxIibYFIorN5+y6
	 7Jr5WjeFSyoqLwhF9axqJKGOItZJpTUOPPvC2z6ooI2pGi8dPEmcj+sg1W+Erk/ta7
	 WMLB3r06ZV22TJGd+ywC03USWb6kpZdj3TWoaFt4IS8Mbnu+dt8Ha7VFkVe++N6wt4
	 1tIJIzKjQCnVBLY6l4E76mllsAuppSgxCpsUlZjDtz/eikmPBspF+4VbvbiFxj1DEc
	 KwWDM3zQQUMJ8l5nfVqJnhzLmSw4+BypFJnwhMQquyvu7Ki9tFPCbyr+ioPV5U+YTm
	 GwEAhMMaW4FhA==
Date: Sun, 17 Mar 2024 15:10:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Richard Alpe <richard@bit42.se>, linux-kernel@vger.kernel.org,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Michael Walle <michael@walle.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of
 fsl,layerscape-sfp
Message-ID: <20240317-starved-pager-7a81c5045cfc@spud>
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qdcgMcn0a8NU6Sgl"
Content-Disposition: inline
In-Reply-To: <20240316002026.1808336-1-sean.anderson@linux.dev>


--qdcgMcn0a8NU6Sgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 08:20:25PM -0400, Sean Anderson wrote:
> These bindings document the same hardware (just different minor
> revisions). Remove the newer fsl,t1023-sfp.
>=20
> Fixes: aa1ed6047107 ("dt-bindings: nvmem: Add t1023-sfp efuse support")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>=20
>  .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 21 ++++++++++-
>  .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 -------------------
>  2 files changed, 19 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.y=
aml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> index 70fb2ad25103..8a54dd1328ea 100644
> --- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
> @@ -19,6 +19,13 @@ allOf:
>  properties:
>    compatible:
>      oneOf:
> +      - description: Trust architecture 2.0 SFP
> +        items:
> +          enum:
> +            - fsl,t1023-sfp

> +            - fsl,t1040-sfp
> +            - fsl,t2080-sfp
> +            - fsl,t4240-sfp

You should at least mention where these three compatibles came from,
given they were not documented in t1023-sfp.yaml. Additionally, should
they fall back to t1023-sfp? I see that there's already some dts files
with these compatibles in them but seemingly no driver support as there
is for the t1023-sfp.

Cheers,
Conor.

>        - description: Trust architecture 2.1 SFP
>          items:
>            - const: fsl,ls1021a-sfp
> @@ -45,8 +52,18 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - clock-names
> -  - clocks
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - fsl,ls1021a-sfp
> +          - fsl,ls1028a-sfp
> +then:
> +  required:
> +    - clocks
> +    - clock-names
> =20
>  unevaluatedProperties: false
> =20
> diff --git a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml b=
/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
> deleted file mode 100644
> index df826b40d8ca..000000000000
> --- a/Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> -%YAML 1.2
> ----
> -$id: http://devicetree.org/schemas/nvmem/fsl,t1023-sfp.yaml#
> -$schema: http://devicetree.org/meta-schemas/core.yaml#
> -
> -title: NXP QorIQ eFuse support
> -
> -maintainers:
> -  - Richard Alpe <richard@bit42.se>
> -
> -description:
> -  Read support for the eFuses (SFP) on NXP QorIQ series SoC's.
> -
> -allOf:
> -  - $ref: nvmem.yaml#
> -
> -properties:
> -  compatible:
> -    const: fsl,t1023-sfp
> -
> -  reg:
> -    maxItems: 1
> -
> -required:
> -  - compatible
> -  - reg
> -
> -unevaluatedProperties: false
> -
> -examples:
> -  - |
> -    efuse@e8000 {
> -        compatible =3D "fsl,t1023-sfp";
> -        reg =3D <0xe8000 0x1000>;
> -    };
> -...
> --=20
> 2.35.1.1320.gc452695387.dirty
>=20

--qdcgMcn0a8NU6Sgl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcH+gAKCRB4tDGHoIJi
0pFuAQDqrCOmUxYfA1oAhhnaZfgL9V6w5ZzssuGIgEpmygC4AgEA2zieUzo695X6
3fiDYut3t9RQWwS2y36mLX+mAVEKaQs=
=/Tm2
-----END PGP SIGNATURE-----

--qdcgMcn0a8NU6Sgl--

