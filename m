Return-Path: <linux-kernel+bounces-50206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E68B8475C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4E528C673
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E3A14AD03;
	Fri,  2 Feb 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdZQO27T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78B1487C7;
	Fri,  2 Feb 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893635; cv=none; b=pob6UzDd+tNnlyU7ZPyoQLtWe2Z/S85ROFKZtV0hSnGRdNvBDLKgs/wUMT/giC34Wpw5TDFX2D9Ohn/rs5dIYCP2/mJbZr32D9BxJJWnWcB7QU39ZoKXdUTp8pOIGy8soI1hPnt7hHQ4rnG+7UsNfh7H+XW1ZmMnDRpStJF52ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893635; c=relaxed/simple;
	bh=DXSZf1yhUvstE8TjzG+rogtSnmOsbLXU/2W/hD+3UFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bm6tlLOIc8noztSC3SSkWTCmNuEPfhMLSp9a68Vp3QqshLo8+a8oAIJqAlixhh8LCCATDTWUMYgfJhkT9uLIZnUJ7bo/GwKeKoOJkVNi7zPfecUJlPcqZzafu6dRajR5CWJ+mjYBdZvgiNOC3qJuHpAJsXX91Frrdzx+4qo9XtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdZQO27T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A93C433C7;
	Fri,  2 Feb 2024 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706893634;
	bh=DXSZf1yhUvstE8TjzG+rogtSnmOsbLXU/2W/hD+3UFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdZQO27T+VWAk1wOysOiE4Dve716JUGmFm3rPW9as/+/bRaR+LJF9BFsZ8DhjG9iS
	 266gqd2ljIWinw/tTXtQG+WxhqALkBqV1Mtd9uljrI414GVb0g/9kndbH0+dOvSNPq
	 XzTZ4TeRwlwvdglPIcFPBqLQcop5itnya3gx6Ky/UhVBNYSh+M45SDqy9I+qiWRlb4
	 +1vA5UxjUhcxYi1Zgzu873WAzyz/43q8cNhxIzFsSimA+KQleqEcKdwVZxspJ5txot
	 yGrrQHKEC9SiDYNArkq2VHBKIt+8ZBkx5s//NyKGqt+g49FYxod//5dXPkAAQBHWx5
	 UK1fE8sRqJxcA==
Date: Fri, 2 Feb 2024 17:07:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Update interrupts
Message-ID: <20240202-explain-harsh-b5d81cb5f59a@spud>
References: <20240202093907.9465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240202093907.9465-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJALSXVusKs4DC57"
Content-Disposition: inline
In-Reply-To: <20240202093907.9465-2-prabhakar.mahadev-lad.rj@bp.renesas.com>


--IJALSXVusKs4DC57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 09:39:05AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> RZ/{G2L, G2LC}, RZ/G2UL, RZ/V2L and RZ/G3S SoCs have ECCRAM0/1 interrupts,
> reflect the same in the DT binding doc.

Renesas' naming scheme really does not help here, but using the
shorthands in the commit message when the diff uses the long form names
is not the easiest thing to follow. (:

>=20
> RZ/G3S SoC has ECCRAM0/1 interrupts combined into single interrupts so
> we just use the below to represent them:
> - ec7tie1-0
> - ec7tie2-0
> - ec7tiovf-0

I think this information would be good in the itemised description,
since that claims these interrupt are only for ECCRAM0.


> Additionally mark 'interrupt-names' property as required for all the SoCs
> and update the example node in the binding doc.

Why? You've not given a reason for doing this, so it just seems
gratuitous.

Thanks,
Conor.

>=20
> Fixes: 96fed779d3d4 ("dt-bindings: interrupt-controller: Add Renesas RZ/G=
2L Interrupt Controller")
> Fixes: 1cf0697a24ef ("dt-bindings: interrupt-controller: renesas,rzg2l-ir=
qc: Document RZ/G3S")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../renesas,rzg2l-irqc.yaml                   | 44 +++++++++++++++----
>  1 file changed, 35 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renes=
as,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/renesas,rzg2l-irqc.yaml
> index d3b5aec0a3f7..0bc9c604a2d7 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2=
l-irqc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2=
l-irqc.yaml
> @@ -44,7 +44,7 @@ properties:
>      maxItems: 1
> =20
>    interrupts:
> -    minItems: 41
> +    minItems: 45
>      items:
>        - description: NMI interrupt
>        - description: IRQ0 interrupt
> @@ -88,9 +88,15 @@ properties:
>        - description: GPIO interrupt, TINT30
>        - description: GPIO interrupt, TINT31
>        - description: Bus error interrupt
> +      - description: ECCRAM0 1bit error interrupt
> +      - description: ECCRAM0 2bit error interrupt
> +      - description: ECCRAM0 error overflow interrupt
> +      - description: ECCRAM1 1bit error interrupt
> +      - description: ECCRAM1 2bit error interrupt
> +      - description: ECCRAM1 error overflow interrupt
> =20
>    interrupt-names:
> -    minItems: 41
> +    minItems: 45
>      items:
>        - const: nmi
>        - const: irq0
> @@ -134,6 +140,12 @@ properties:
>        - const: tint30
>        - const: tint31
>        - const: bus-err
> +      - const: ec7tie1-0
> +      - const: ec7tie2-0
> +      - const: ec7tiovf-0
> +      - const: ec7tie1-1
> +      - const: ec7tie2-1
> +      - const: ec7tiovf-1
> =20
>    clocks:
>      maxItems: 2
> @@ -156,6 +168,7 @@ required:
>    - interrupt-controller
>    - reg
>    - interrupts
> +  - interrupt-names
>    - clocks
>    - clock-names
>    - power-domains
> @@ -169,16 +182,19 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - renesas,r9a07g043u-irqc
>                - renesas,r9a08g045-irqc
>      then:
>        properties:
>          interrupts:
> -          minItems: 42
> +          maxItems: 45
>          interrupt-names:
> -          minItems: 42
> -      required:
> -        - interrupt-names
> +          maxItems: 45
> +    else:
> +      properties:
> +        interrupts:
> +          minItems: 48
> +        interrupt-names:
> +          minItems: 48
> =20
>  unevaluatedProperties: false
> =20
> @@ -233,7 +249,14 @@ examples:
>                       <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
>                       <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
> -                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
> +                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>,
> +                     <GIC_SPI 39 IRQ_TYPE_EDGE_RISING>;
>          interrupt-names =3D "nmi",
>                            "irq0", "irq1", "irq2", "irq3",
>                            "irq4", "irq5", "irq6", "irq7",
> @@ -244,7 +267,10 @@ examples:
>                            "tint16", "tint17", "tint18", "tint19",
>                            "tint20", "tint21", "tint22", "tint23",
>                            "tint24", "tint25", "tint26", "tint27",
> -                          "tint28", "tint29", "tint30", "tint31";
> +                          "tint28", "tint29", "tint30", "tint31",
> +                          "bus-err", "ec7tie1-0", "ec7tie2-0",
> +                          "ec7tiovf-0", "ec7tie1-1", "ec7tie2-1",
> +                          "ec7tiovf-1";
>          clocks =3D <&cpg CPG_MOD R9A07G044_IA55_CLK>,
>                   <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
>          clock-names =3D "clk", "pclk";
> --=20
> 2.34.1
>=20

--IJALSXVusKs4DC57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb0hPQAKCRB4tDGHoIJi
0rAOAQDurAEgL927nhnnWJlJb2F2czsqKJfYyND013ASE8RxiwD9Fw/tXnrqathm
0dbNZcVCER+Lr5urADUxslomMupcbwY=
=ixSf
-----END PGP SIGNATURE-----

--IJALSXVusKs4DC57--

