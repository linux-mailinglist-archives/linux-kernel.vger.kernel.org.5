Return-Path: <linux-kernel+bounces-40371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718F83DF25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2761F21C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E5E1DFC5;
	Fri, 26 Jan 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+AlAIzP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722D1D531;
	Fri, 26 Jan 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287734; cv=none; b=GnR6kMWGirqjlqYItF5hz1xLxJvqHQNMlUatqc9Ylmb32u9Kc1aZ5lq1LIETDh01e6YNaq0JlODNS5egh5J4KfNyk3GiFWrrKQ73H/nI9mH/9DU/ZHDXnXHUhnokKNoucg8q2p7neBug+2M6Is2Qvh4SPmBenw+2XHbpscHi7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287734; c=relaxed/simple;
	bh=WtINbuOqqT+yqMI9R34GUJM4rkoPSWZuIpbEnSUaNI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/M2qmZQUcaUttQum5ZKFgNsPkOcq281m3PC6tI6q1iQ4XFJ58PaArxgT1DMdb+LnpJQHkR7M80GiLLDl4tt2Qep4ZZNfuMIqj4r2ZWzjZCAcs08HBmI0SRPyRjzVpMth1tkBNhFzE99osfPgzPxgujlIvbDEak/+3PXyGxtKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+AlAIzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF9CC433C7;
	Fri, 26 Jan 2024 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706287734;
	bh=WtINbuOqqT+yqMI9R34GUJM4rkoPSWZuIpbEnSUaNI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+AlAIzPFO6+IwcQqvKtYkEPQ3Ygl+uqYeelGjlslqoUYY5YmkB9uffrtFUDJK7Jy
	 hKbCpNox68cM2xw1TDJYrrt3kE7HmK9nI5nvEJzHiICOc6oDVGeKBQ7n/5ZZ3tr+uB
	 zBXTXkpTGZ/NNSWwY4OHuzR9VvtrTBhvAyWLA/Z3d4chdXRdu8IuWhI/AusPGjzdTX
	 FPkyxNDRLHJXfmumJCeug/Y7ZD+aBRYuqu3UJ/CmobyxnwLDZyWB6DSwwCDVJU0A8A
	 EeSA270mgeX40L1SrYerUpiK1aBqJ5oH0rGWqUEMYKF/AiAi0z+eAHrLascLPUMDSR
	 OVGGOHlbxkNIQ==
Date: Fri, 26 Jan 2024 16:48:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	mazziesaccount@gmail.com, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: cy8x95x0: Minor fix & update
Message-ID: <20240126-contently-mute-4e5c1cf09e8e@spud>
References: <20240126115748.1491642-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+2t8z9tC2YpU7WTh"
Content-Disposition: inline
In-Reply-To: <20240126115748.1491642-1-naresh.solanki@9elements.com>


--+2t8z9tC2YpU7WTh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 05:27:48PM +0530, Naresh Solanki wrote:
> Update maxItems to 60 for gpio-reserved-ranges.
> Add input-enable property.
> Rearrange allOf
> Update example.

Same as elsewhere, please justify the changes rather than list what can
be seen in the diff.

> TEST=3DRun below command make sure there is no error.
> make DT_CHECKER_FLAGS=3D-m dt_binding_check

Same comment as elsewhere :)

Thanks,
Conor.

>=20
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
>  .../bindings/pinctrl/cypress,cy8c95x0.yaml    | 28 +++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.y=
aml b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> index 7f30ec2f1e54..89ce0cb68834 100644
> --- a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
> @@ -45,7 +45,8 @@ properties:
>      maxItems: 1
> =20
>    gpio-reserved-ranges:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 60
> =20
>    vdd-supply:
>      description:
> @@ -85,6 +86,8 @@ patternProperties:
> =20
>        bias-disable: true
> =20
> +      input-enable: true
> +
>        output-high: true
> =20
>        output-low: true
> @@ -101,6 +104,9 @@ patternProperties:
> =20
>      additionalProperties: false
> =20
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
>  required:
>    - compatible
>    - reg
> @@ -112,9 +118,6 @@ required:
> =20
>  additionalProperties: false
> =20
> -allOf:
> -  - $ref: pinctrl.yaml#
> -
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -133,6 +136,21 @@ examples:
>          interrupts =3D <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
>          interrupt-controller;
>          vdd-supply =3D <&p3v3>;
> -        gpio-reserved-ranges =3D <5 1>;
> +        gpio-reserved-ranges =3D <1 2>, <6 1>, <10 1>, <15 1>;
> +
> +        pinctrl-0 =3D <&U62160_pins>, <&U62160_ipins>;
> +        pinctrl-names =3D "default";
> +        U62160_pins: cfg-pins {
> +                        pins =3D "gp03", "gp16", "gp20", "gp50", "gp51";
> +                        function =3D "gpio";
> +                        input-enable;
> +                        bias-pull-up;
> +        };
> +        U62160_ipins: icfg-pins {
> +                        pins =3D "gp04", "gp17", "gp21", "gp52", "gp53";
> +                        function =3D "gpio";
> +                        input-enable;
> +                        bias-pull-up;
> +        };
>        };
>      };
>=20
> base-commit: ecb1b8288dc7ccbdcb3b9df005fa1c0e0c0388a7
> --=20
> 2.42.0
>=20

--+2t8z9tC2YpU7WTh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbPicQAKCRB4tDGHoIJi
0txmAPwLcy4DcpIJ8errO0RavFgIri/cwB34qCN84wKAghi3fwD+Nxo6KnbflgRr
rKDokwVCP53wtpK/259VEouFIRrpTQU=
=L/dD
-----END PGP SIGNATURE-----

--+2t8z9tC2YpU7WTh--

