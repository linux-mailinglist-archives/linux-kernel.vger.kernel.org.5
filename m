Return-Path: <linux-kernel+bounces-31010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE65832786
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8301F238CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A63C697;
	Fri, 19 Jan 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xoV+DeqE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A990DDA5;
	Fri, 19 Jan 2024 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659455; cv=none; b=sRnCtluJPQaQhqcFOE2q4Y9u+30z5lz+U39L7p9w6RkvWwsa9rAqyVhw5klhZz/2oUh7xMRpWgIT8u1LTZgFhr/guYJSwZwastVBiCUIIhfhhAN4I+YhaMJlTXNQmpoCR+5B8BddqPYXp/El7NhcKAPaSC9pHSIR7hJU9mSqtrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659455; c=relaxed/simple;
	bh=+LtMZPOF1yo585gqDoaAA6wOBqB5Aivtv5s5vcPOK50=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZgQggmxaIBhZGPqiYcwvztH04qeQ76aP/dy1q2F/ZW2GOITmLUk6xgfsNHoXvSg+cMbbyNxQsT8KkKlCvoBJoKYnH7TefkEY2S16NUcB0vuArxuGPipXsraI7tCLo4EpP3OA32REhblT4c3CoTiZS/IFQHb8WKfRh/+l82v2m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xoV+DeqE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1705659453; x=1737195453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+LtMZPOF1yo585gqDoaAA6wOBqB5Aivtv5s5vcPOK50=;
  b=xoV+DeqE3CUXdy9URhQDrHmi8k+DbWw6DW7QFEgyuC22WxnMn7oJCnG8
   s9FetOukohBy7Kks+rOAaRAcEFSyDKBxr0FF3tpeGZvnU6rsCiJ7+9rtb
   /RMpbH7id1llCfK3YyXIMKep2HrLYdd4tM3x9+8fR7uHpbwtiO5DACAL7
   g1wAxD7+KoLBRGhGApgsakHy2S9vKFFz9p6IAqxmH3c+J9cDZxNCVUE5W
   cq9EzMZhGghFIeg3KXL6XfFBpRfjz2TedigQiNjkrJ6xVCnWmXGTruLMm
   pK2gA1x33p9xf98ja9jQwOQO/pLt9Kbqe1UcSdv6/vIZH7fGi1r7iN21e
   g==;
X-CSE-ConnectionGUID: K82mF02xSm2dPv+Ypq+eGQ==
X-CSE-MsgGUID: vERtogOnTAm69wiMAgHXnw==
X-IronPort-AV: E=Sophos;i="6.05,204,1701154800"; 
   d="asc'?scan'208";a="245712682"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jan 2024 03:17:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 03:17:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Jan 2024 03:17:23 -0700
Date: Fri, 19 Jan 2024 10:16:46 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Emil
 Renner Berthing <kernel@esmil.dk>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jack
 Zhu <jack.zhu@starfivetech.com>, <linux-media@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: media: starfive: Match driver and
 yaml property names
Message-ID: <20240119-despair-festival-59ab2d4d896b@wendy>
References: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
 <20240119100639.84029-2-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BFH1MedVdG7X979+"
Content-Disposition: inline
In-Reply-To: <20240119100639.84029-2-changhuang.liang@starfivetech.com>

--BFH1MedVdG7X979+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 02:06:38AM -0800, Changhuang Liang wrote:
> Drop some unused properties for clocks, resets and interrupts for
> StarFive JH7110 camera subsystem.

What do you mean "unused"?

Do these clocks etc exist but are not used by the driver?

Or do they not exist at all?

The two are very different!

Thanks,
Conor.

>=20
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> Reviewed-by: Jack Zhu <jack.zhu@starfivetech.com>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/media/starfive,jh7110-camss.yaml | 31 +++++--------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/starfive,jh7110-cams=
s.yaml b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> index c66586d90fa2..2504381058b3 100644
> --- a/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/starfive,jh7110-camss.yaml
> @@ -4,14 +4,14 @@
>  $id: http://devicetree.org/schemas/media/starfive,jh7110-camss.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Starfive SoC CAMSS ISP
> +title: StarFive SoC CAMSS ISP
> =20
>  maintainers:
>    - Jack Zhu <jack.zhu@starfivetech.com>
>    - Changhuang Liang <changhuang.liang@starfivetech.com>
> =20
>  description:
> -  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC. =
It
> +  The StarFive CAMSS ISP is a Camera interface for StarFive JH7110 SoC. =
It
>    consists of a VIN controller (Video In Controller, a top-level control=
 unit)
>    and an ISP.
> =20
> @@ -28,26 +28,21 @@ properties:
>        - const: isp
> =20
>    clocks:
> -    maxItems: 7
> +    maxItems: 3
> =20
>    clock-names:
>      items:
> -      - const: apb_func
>        - const: wrapper_clk_c
> -      - const: dvp_inv
> -      - const: axiwr
> -      - const: mipi_rx0_pxl
>        - const: ispcore_2x
>        - const: isp_axi
> =20
>    resets:
> -    maxItems: 6
> +    maxItems: 5
> =20
>    reset-names:
>      items:
>        - const: wrapper_p
>        - const: wrapper_c
> -      - const: axird
>        - const: axiwr
>        - const: isp_top_n
>        - const: isp_top_axi
> @@ -57,7 +52,7 @@ properties:
>        - description: JH7110 ISP Power Domain Switch Controller.
> =20
>    interrupts:
> -    maxItems: 4
> +    maxItems: 3
> =20
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> @@ -125,34 +120,24 @@ examples:
>          reg =3D <0x19840000 0x10000>,
>                <0x19870000 0x30000>;
>          reg-names =3D "syscon", "isp";
> -        clocks =3D <&ispcrg 0>,
> -                 <&ispcrg 13>,
> -                 <&ispcrg 2>,
> -                 <&ispcrg 12>,
> -                 <&ispcrg 1>,
> +        clocks =3D <&ispcrg 13>,
>                   <&syscrg 51>,
>                   <&syscrg 52>;
> -        clock-names =3D "apb_func",
> -                      "wrapper_clk_c",
> -                      "dvp_inv",
> -                      "axiwr",
> -                      "mipi_rx0_pxl",
> +        clock-names =3D "wrapper_clk_c",
>                        "ispcore_2x",
>                        "isp_axi";
>          resets =3D <&ispcrg 0>,
>                   <&ispcrg 1>,
> -                 <&ispcrg 10>,
>                   <&ispcrg 11>,
>                   <&syscrg 41>,
>                   <&syscrg 42>;
>          reset-names =3D "wrapper_p",
>                        "wrapper_c",
> -                      "axird",
>                        "axiwr",
>                        "isp_top_n",
>                        "isp_top_axi";
>          power-domains =3D <&pwrc 5>;
> -        interrupts =3D <92>, <87>, <88>, <90>;
> +        interrupts =3D <92>, <87>, <90>;
> =20
>          ports {
>              #address-cells =3D <1>;
> --=20
> 2.25.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--BFH1MedVdG7X979+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZapMDgAKCRB4tDGHoIJi
0lzdAP0XhGNQY1wQcLpLFfEc/Sj9meIVrA/jD1GxiMXgdQqWnQD/QUG80+qLfwIm
6Glfk4ikQIoSAIG9e230u0TETuQEkQg=
=ngD+
-----END PGP SIGNATURE-----

--BFH1MedVdG7X979+--

