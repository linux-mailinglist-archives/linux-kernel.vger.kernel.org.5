Return-Path: <linux-kernel+bounces-91226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526D7870B7A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D411C2245F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE347AE66;
	Mon,  4 Mar 2024 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcPo69xN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2F4AEF9;
	Mon,  4 Mar 2024 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583813; cv=none; b=sALatm6mOCyAZ52oKXAjKcBwckZ/376IBXhicu8mQVHq0U37H5ghU0h0UGAJwSXhe/LAngRW74lyc27RqgRmTdxGWjZMjqy+3xV4Zfl6aZERZUFEkYixC2pSHQnN+WQ2Jc4DxrWkyADrljLINmB1JTGcx01ZDwY1g4VNvZfgwfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583813; c=relaxed/simple;
	bh=V1Qaqr+cyN7FZy2RgN8ZX4Ee45PfginbyyRueKS1KDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCZL/+9dhNwU5MWY9un31MW2u1H1KdKHxxX0r/aQpKkndCHnjCpO52emdCRxQad9FWcsKPpWieCD8lmGCdcCZHkgNFWf36EQCH3gfx5SFqodbuVvxJ9+4uWAFeUixMmYhyX5nGk5qSrGBxI/tHW9xB4LTTFwBtAUKDeJIJxKVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcPo69xN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DD4C433F1;
	Mon,  4 Mar 2024 20:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709583812;
	bh=V1Qaqr+cyN7FZy2RgN8ZX4Ee45PfginbyyRueKS1KDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcPo69xNTWbhO57HEa1G617Db21l02p4Gon6X7YSOl6YpywckluTFZMgliFwCSsqJ
	 FA0NwdejFMI7Zi2a48kyI+PWD3ui+zH0dO0QOqJnsPpgDbZkAAA1EBdr/b4/uJds2O
	 H3RKJ9Y2r2o8QI8YgRQKFmSbOS/QXtHmtutMoc5fvU3+/iomuQiDLv/tOClrGnTgxu
	 S4PJz4ULuXdurrE78SviCipbqX1LCpeIEoIUQ5T6bqFXsZHKdTIN+HW8xdYCL8BPPe
	 1C0g5Dfh8CcQDO5tvJoDF5nkDCwPeo/84jiwr7keVuO/wLeCL1BaArsBcWXwznUDca
	 y6J5OCU48OMsA==
Date: Mon, 4 Mar 2024 20:23:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT
 schema
Message-ID: <20240304-radio-urban-9843704f374e@spud>
References: <20240226031951.284847-1-andrew@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WBinYbWIzry76kSg"
Content-Disposition: inline
In-Reply-To: <20240226031951.284847-1-andrew@codeconstruct.com.au>


--WBinYbWIzry76kSg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 01:49:51PM +1030, Andrew Jeffery wrote:
> Squash warnings such as:
>=20
> ```
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb@1e60=
0000/gpio@1e780000: failed to match any schema with compatible: ['aspeed,as=
t2400-gpio']
> ```
>=20
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> v2: Address feedback from Krzysztof:
>     https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff@lina=
ro.org/
>=20
> v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew@codeconstr=
uct.com.au/
>=20
>  .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 73 +++++++++++++++++++
>  .../devicetree/bindings/gpio/gpio-aspeed.txt  | 39 ----------
>  2 files changed, 73 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400=
-gpio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.y=
aml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> new file mode 100644
> index 000000000000..74d376567dfc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed GPIO controller
> +
> +maintainers:
> +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-gpio
> +      - aspeed,ast2500-gpio
> +      - aspeed,ast2600-gpio
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: The clock to use for debounce timings

The original binding does not require this clock, but I can't help but
wonder if it should be required. I suspect that this peripheral does
not actually work if a clock is not provided to it. Whether or not the
rate of the clock is then used by the driver for debounce timings or
whatever is a different question.

Otherwise though, this looks fine to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-controller: true
> +  gpio-line-names: true
> +  gpio-ranges: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  ngpios: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - "#gpio-cells"
> +  - gpio-controller
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: aspeed,ast2600-gpio
> +    then:
> +      required:
> +        - ngpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio@1e780000 {
> +        compatible =3D "aspeed,ast2400-gpio";
> +        reg =3D <0x1e780000 0x1000>;
> +        interrupts =3D <20>;
> +        interrupt-controller;
> +        #gpio-cells =3D <2>;
> +        gpio-controller;
> +    };
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt b/Doc=
umentation/devicetree/bindings/gpio/gpio-aspeed.txt
> deleted file mode 100644
> index b2033fc3a71a..000000000000
> --- a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -Aspeed GPIO controller Device Tree Bindings
> --------------------------------------------
> -
> -Required properties:
> -- compatible		: Either "aspeed,ast2400-gpio", "aspeed,ast2500-gpio",
> -					or "aspeed,ast2600-gpio".
> -
> -- #gpio-cells 		: Should be two
> -			  - First cell is the GPIO line number
> -			  - Second cell is used to specify optional
> -			    parameters (unused)
> -
> -- reg			: Address and length of the register set for the device
> -- gpio-controller	: Marks the device node as a GPIO controller.
> -- interrupts		: Interrupt specifier (see interrupt bindings for
> -			  details)
> -- interrupt-controller	: Mark the GPIO controller as an interrupt-contro=
ller
> -
> -Optional properties:
> -
> -- clocks		: A phandle to the clock to use for debounce timings
> -- ngpios		: Number of GPIOs controlled by this controller. Should	be set
> -				  when there are multiple GPIO controllers on a SoC (ast2600).
> -
> -The gpio and interrupt properties are further described in their respect=
ive
> -bindings documentation:
> -
> -- Documentation/devicetree/bindings/gpio/gpio.txt
> -- Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> -
> -  Example:
> -	gpio@1e780000 {
> -		#gpio-cells =3D <2>;
> -		compatible =3D "aspeed,ast2400-gpio";
> -		gpio-controller;
> -		interrupts =3D <20>;
> -		reg =3D <0x1e780000 0x1000>;
> -		interrupt-controller;
> -	};
> --=20
> 2.39.2
>=20

--WBinYbWIzry76kSg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYtvwAKCRB4tDGHoIJi
0sA/AQC/NSqxk+gOMc2YKFuxBEmSMAC+J4rmo8SMcdjAjYJccwD8DNJO0vzMwQ7l
7ZJZiqqGTf2fmGaQkS/nuX0wdNesOQ0=
=jXZ8
-----END PGP SIGNATURE-----

--WBinYbWIzry76kSg--

