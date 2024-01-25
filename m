Return-Path: <linux-kernel+bounces-39041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F2783CA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CFD28498A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFC131E2B;
	Thu, 25 Jan 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktYgjR7w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349664F611;
	Thu, 25 Jan 2024 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203914; cv=none; b=Az1L8/JfYmGawtlWjU0YvL+PHgxBXZ3R/bXiMVOzBAVpPjZYL3MoJVRPffAMm/swHhMUSJpoqumG6p99BIH5qlcms71csiY34G2svCo5m/+l8CggiXQ6+D34YaxA/VJd+PQqGBCzWQakB4HsZxeB6rQ2/1W0ppYQttuX4+Yna3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203914; c=relaxed/simple;
	bh=SqNihTfWMbvieu+0aF6nJM9xGvFsSQBOFvPuLPG09pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7fI0UMt0MXXL1/B8DzqrvonFZQ8hriUOq7FOVncbSF6Zw7gzBpJRDvAOUanGrORmBfYA07GV6AZdVoP6UfgdGwimll88Xxe1a5m5sPnLJpZxGjUjjjdZIvw7ZUjAodq/4JfvJZshaJogrNJy/3yDzbcB5n3vdKfFrEW9JhSrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktYgjR7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FADC433F1;
	Thu, 25 Jan 2024 17:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706203914;
	bh=SqNihTfWMbvieu+0aF6nJM9xGvFsSQBOFvPuLPG09pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktYgjR7w7ingRdc8X51gT+O/OeXKYi6UufTuDpboqZbRHXtYWRP+lAeHlSJCDivA1
	 MkBEYiEkwLvsFkI9pYKkmPb3NMdRr2MniZ/aF7Km34+sn8/5Rq/GxnzX+HLuMB/bGS
	 HYdTydF+xOPNe36puyCFDgAKHdqAamWs9oF8AQgqzRoM19gaPVqPB26XfYGKek7++u
	 O+1HVBQXtwVr8VQmLXTvUjUm9GD1fKbGIBS9C2i0yYrBM63phkMJP3alfDBN/UkSvN
	 eHvKcVMZyUCfBABZlvaJ7VpoWX+djfvmQ+f8uqK2mR1Ba6vGaM57ij05oT7i2MoiGq
	 715H1J7ZqjcBQ==
Date: Thu, 25 Jan 2024 17:31:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	wenhua lin <wenhua.lin1994@gmail.com>,
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>,
	zhaochen su <zhaochen.su29@gmail.com>,
	Zhaochen Su <Zhaochen.Su@unisoc.com>,
	Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: Re: [PATCH V2 4/6] dt-bindings: pwm: sprd: Convert to YAML
Message-ID: <20240125-sleeve-defeat-61f74942e2d9@spud>
References: <20240125025533.10315-1-Wenhua.Lin@unisoc.com>
 <20240125025533.10315-5-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q6vbl6fY+x+VAwSi"
Content-Disposition: inline
In-Reply-To: <20240125025533.10315-5-Wenhua.Lin@unisoc.com>


--Q6vbl6fY+x+VAwSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Jan 25, 2024 at 10:55:31AM +0800, Wenhua Lin wrote:
> Convert Spreadtrum PWM controller bindings to DT schema.
>=20
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sprd.txt      | 40 --------
>  .../devicetree/bindings/pwm/pwm-sprd.yaml     | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt b/Documen=
tation/devicetree/bindings/pwm/pwm-sprd.txt
> deleted file mode 100644
> index 87b206fd0618..000000000000
> --- a/Documentation/devicetree/bindings/pwm/pwm-sprd.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -Spreadtrum PWM controller
> -
> -Spreadtrum SoCs PWM controller provides 4 PWM channels.
> -
> -Required properties:
> -- compatible : Should be "sprd,ums512-pwm".
> -- reg: Physical base address and length of the controller's registers.
> -- clocks: The phandle and specifier referencing the controller's clocks.
> -- clock-names: Should contain following entries:
> -  "pwmn": used to derive the functional clock for PWM channel n (n range=
: 0 ~ 3).
> -  "enablen": for PWM channel n enable clock (n range: 0 ~ 3).
> -- #pwm-cells: Should be 2. See pwm.yaml in this directory for a descript=
ion of
> -  the cells format.
> -
> -Optional properties:
> -- assigned-clocks: Reference to the PWM clock entries.
> -- assigned-clock-parents: The phandle of the parent clock of PWM clock.
> -
> -Example:
> -	pwms: pwm@32260000 {
> -		compatible =3D "sprd,ums512-pwm";
> -		reg =3D <0 0x32260000 0 0x10000>;
> -		clock-names =3D "pwm0", "enable0",
> -			"pwm1", "enable1",
> -			"pwm2", "enable2",
> -			"pwm3", "enable3";
> -		clocks =3D <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
> -		       <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
> -		       <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
> -		       <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
> -		assigned-clocks =3D <&aon_clk CLK_PWM0>,
> -			<&aon_clk CLK_PWM1>,
> -			<&aon_clk CLK_PWM2>,
> -			<&aon_clk CLK_PWM3>;
> -		assigned-clock-parents =3D <&ext_26m>,
> -			<&ext_26m>,
> -			<&ext_26m>,
> -			<&ext_26m>;
> -		#pwm-cells =3D <2>;
> -	};
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml b/Docume=
ntation/devicetree/bindings/pwm/pwm-sprd.yaml
> new file mode 100644
> index 000000000000..81c5fd688c3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sprd.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2023 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/pwm-sprd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum PWM controller
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description: |

The | here is not need, you have no formatting to preserve.

> +  Spreadtrum SoCs PWM controller provides 4 PWM channels.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - sprd,ums512-pwm

this is just

compatible:
  const: sprd,ums512-pwm

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 8
> +    maxItems: 8
> +
> +  clock-names:
> +    items:
> +      - const: pwm0
> +      - const: enable0
> +      - const: pwm1
> +      - const: enable1
> +      - const: pwm2
> +      - const: enable2
> +      - const: pwm3
> +      - const: enable3

> +    description: |
> +      Should contain following entries:
> +      "pwmn": used to derive the functional clock for PWM channel n (n r=
ange: 0 ~ 3).
> +      "enablen": for PWM channel n enable clock (n range: 0 ~ 3).

I would drop this description from here, and create an items list under
clocks, describing each clock. You can then drop the "minItems: 8" &
"maxItems: 8" from there.

> +
> +  assigned-clocks:
> +    minItems: 4
> +    maxItems: 4
> +
> +  assigned-clock-parents:
> +    minItems: 4
> +    maxItems: 4
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sprd,ums512-clk.h>

nit: newline here please.

> +    pwms: pwm@32260000 {

The "pwms" label here is not used and should be dropped.

Thanks,
Conor.


> +        compatible =3D "sprd,ums512-pwm";
> +        reg =3D <0x32260000 0x10000>;
> +        clock-names =3D "pwm0", "enable0",
> +                      "pwm1", "enable1",
> +                      "pwm2", "enable2",
> +                      "pwm3", "enable3";
> +        clocks =3D <&aon_clk CLK_PWM0>, <&aonapb_gate CLK_PWM0_EB>,
> +                 <&aon_clk CLK_PWM1>, <&aonapb_gate CLK_PWM1_EB>,
> +                 <&aon_clk CLK_PWM2>, <&aonapb_gate CLK_PWM2_EB>,
> +                 <&aon_clk CLK_PWM3>, <&aonapb_gate CLK_PWM3_EB>;
> +        assigned-clocks =3D <&aon_clk CLK_PWM0>,
> +                          <&aon_clk CLK_PWM1>,
> +                          <&aon_clk CLK_PWM2>,
> +                          <&aon_clk CLK_PWM3>;
> +        assigned-clock-parents =3D <&ext_26m>,
> +                                 <&ext_26m>,
> +                                 <&ext_26m>,
> +                                 <&ext_26m>;
> +        #pwm-cells =3D <2>;
> +    };
> +
> +...
> --=20
> 2.17.1
>=20

--Q6vbl6fY+x+VAwSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKbBAAKCRB4tDGHoIJi
0gnIAP4trCphvhaTR74sYjRe5mG0kKK5FkhhNOZR+Fc2MAz9uQD9HwyjQC6ESyAK
XPxnd5zdwLBhsPmlLkR8WW07JT3ihAU=
=l8Yz
-----END PGP SIGNATURE-----

--Q6vbl6fY+x+VAwSi--

