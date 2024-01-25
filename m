Return-Path: <linux-kernel+bounces-39029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E51C83C9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA69528D506
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CA4130E2F;
	Thu, 25 Jan 2024 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6J1Gi0D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E14F611;
	Thu, 25 Jan 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203264; cv=none; b=WdDvekwji4jXJK5KEuW/RlmYEQvjNw0PR+c1bq+FibrsJpdEiX43ngDm6EVIsDzuDVirIF6WnHrP3VyC+0xuuX4qa4tjvNWxHa3m49dammpnceOorM2tQbXHavJABfResD06TqNVxf3WnhClmREKciAlz/0necex+QpTPaL1kDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203264; c=relaxed/simple;
	bh=qJy6aD69ChOOiKQIQ8IywuiR88JjYpmJGGBZxwAX/9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8PpPVO0GmwFyuZDNcwdP3McxSyL/19ZVudzfoevctMQhJWkH5xatXbEhPBolfzyns+LFT5e5ZHmyFMM8nIH3cn+HPChV/CA4hX7me+UyWXQMYeE1gO0xnaooVGLE7IdDrn8I/y3SC0WNiODkO7NDBm0u/q7EPsJhkoZ1kuO/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6J1Gi0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BB6C433F1;
	Thu, 25 Jan 2024 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706203264;
	bh=qJy6aD69ChOOiKQIQ8IywuiR88JjYpmJGGBZxwAX/9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6J1Gi0Db2CKExachaEhFx0H826vwASbgafEzEYdAl8/lwrm1DMbWukjBnAwkSBRU
	 XigEeGOjEeH1lpeb+xflyEys6WWb8w9y/ox6mGn0FZCkO+3/aRjJU860uG+DvrP9OJ
	 XMVfQ7umWSnXKX1ed1gUy3JP6cCcaX/TsbfWTzjNZtIOKTrWU8fFvP+43jrHL8tfhE
	 /FFU0xBRwASKxZ0hPu7qLnHmUT5TRJWwVfJmgb8gvgKj8Qphnf86w5l/GorvD2BtKN
	 3wEAo1ZOKwLv0IYWWQTWK38/1y+nhvEn8Ae3fmyP196FVDy6Rt9Zum69d+PFE7Dkts
	 tq2flJcOg7RrA==
Date: Thu, 25 Jan 2024 17:20:59 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Message-ID: <20240125-prudishly-contort-274a48bbb33e@spud>
References: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
 <20240125-imx-mailbox-v4-1-800be5383c20@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gZWG52K1GgRCAoNi"
Content-Disposition: inline
In-Reply-To: <20240125-imx-mailbox-v4-1-800be5383c20@nxp.com>


--gZWG52K1GgRCAoNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 01:20:03PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX95 Generic, Secure Enclave and V2X Message Unit compatible string.
> And some MUs has internal RAMs for SCMI shared buffer usage.

Please restrict the SRAM child none to whatever the "some MUs" are that
actually have it.

Thanks,
Conor.

>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mailbox/fsl,mu.yaml        | 52 ++++++++++++++++=
+++++-
>  1 file changed, 50 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Docu=
mentation/devicetree/bindings/mailbox/fsl,mu.yaml
> index 12e7a7d536a3..86759831b24a 100644
> --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> @@ -29,10 +29,14 @@ properties:
>        - const: fsl,imx8ulp-mu
>        - const: fsl,imx8-mu-scu
>        - const: fsl,imx8-mu-seco
> -      - const: fsl,imx93-mu-s4
>        - const: fsl,imx8ulp-mu-s4
> +      - const: fsl,imx93-mu-s4
> +      - const: fsl,imx95-mu-ele
> +      - const: fsl,imx95-mu-v2x
>        - items:
> -          - const: fsl,imx93-mu
> +          - enum:
> +              - fsl,imx93-mu
> +              - fsl,imx95-mu
>            - const: fsl,imx8ulp-mu
>        - items:
>            - enum:
> @@ -95,6 +99,19 @@ properties:
>    power-domains:
>      maxItems: 1
> =20
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +patternProperties:
> +  "^sram@[a-f0-9]+":
> +    $ref: /schemas/sram/sram.yaml#
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -134,3 +151,34 @@ examples:
>          interrupts =3D <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
>          #mbox-cells =3D <2>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mu2: mailbox@445b0000 {
> +        compatible =3D "fsl,imx95-mu", "fsl,imx8ulp-mu";
> +        reg =3D <0x445b0000 0x10000>;
> +        ranges;
> +        interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +        #mbox-cells =3D <2>;
> +
> +        sram@445b1000 {
> +            compatible =3D "mmio-sram";
> +            reg =3D <0x445b1000 0x400>;
> +            ranges =3D <0x0 0x445b1000 0x400>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +
> +            scmi_buf0: scmi-sram-section@0 {
> +                compatible =3D "arm,scmi-shmem";
> +                reg =3D <0x0 0x80>;
> +            };
> +
> +            scmi_buf1: scmi-sram-section@80 {
> +                compatible =3D "arm,scmi-shmem";
> +                reg =3D <0x80 0x80>;
> +            };
> +        };
> +    };
>=20
> --=20
> 2.37.1
>=20

--gZWG52K1GgRCAoNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKYegAKCRB4tDGHoIJi
0uQkAP9DvCsBlILZzMc3awEyQXoCSoSWWB6nyUnmS7/lsZOxaAEArkQa8GnAv7FF
vPfHkN1MKkWVPBG4ByV36ieeHXZ5OgA=
=tP/N
-----END PGP SIGNATURE-----

--gZWG52K1GgRCAoNi--

