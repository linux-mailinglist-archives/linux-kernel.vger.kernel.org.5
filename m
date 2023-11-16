Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5427EE8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjKPV1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPV1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:27:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2B2181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:27:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE62C433C7;
        Thu, 16 Nov 2023 21:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700170037;
        bh=DAOtcq1zMF1girYv5SQDATfAeM8THxXQXfmsjJVnJA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgKJq/QD8stVhIpR/r8PCv6X4X5ysSU0fRx9NOxvlHIU6w5azKdXbmeZWObcF+bTv
         hEFPEpIDIjNzUVFct0cTyZwcBywCDju9AEkiqxg1yHC/5sWdESYA/pM+c9ud1lgJxU
         9H4rZIb+9rVAewatn+OS7Evhm/pabMNK4iLjhnpv+0pAoNI5JqTwZ32EB64DpC/yoa
         RiWofW7/9uHCf+fjdZCaPQEoNQu483c8nV8266QiCZCKRO8XgjLz9CbJOuV3XLo2yi
         0M9GLyVP5ZYoeYx1p6nqqdqx9ehsoyOVljmaQXneveyV7rJDUu1sArIcECQeEWwGe0
         JG+eEoICwH9Cw==
Date:   Thu, 16 Nov 2023 21:27:03 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] docs: dt-bindings: add DTS Coding Style document
Message-ID: <20231116-sandblast-groggy-c35eb536c34d@squawk>
References: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y+pm6WEz4WXUC9Og"
Content-Disposition: inline
In-Reply-To: <20231116181218.18886-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y+pm6WEz4WXUC9Og
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 07:12:18PM +0100, Krzysztof Kozlowski wrote:
> Document preferred coding style for Devicetree sources (DTS and DTSI),
> to bring consistency among all (sub)architectures and ease in reviews.

This is a good idea IMO, thanks for writing it.

Should we also mention in this about the expected breakdown of things
between $soc.dtsi and $soc-$board.dtsi? There's commonly confusion about
things like oscillators and where they belong - particularly when the
SoC mandates that these oscillators be of a single frequency.
It may seem obvious to us what goes where, but certainly contributors
frequently get this wrong.

Cheers,
Conor.

>=20
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Merging idea: Rob/DT bindings
> ---
>  Documentation/devicetree/bindings/index.rst   |   1 +
>  .../devicetree/bindings/writing-dts.rst       | 137 ++++++++++++++++++
>  2 files changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/writing-dts.rst
>=20
> diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/=
devicetree/bindings/index.rst
> index d9002a3a0abb..975449be4862 100644
> --- a/Documentation/devicetree/bindings/index.rst
> +++ b/Documentation/devicetree/bindings/index.rst
> @@ -5,5 +5,6 @@
> =20
>     ABI
>     writing-bindings
> +   writing-dts
>     writing-schema
>     submitting-patches
> diff --git a/Documentation/devicetree/bindings/writing-dts.rst b/Document=
ation/devicetree/bindings/writing-dts.rst
> new file mode 100644
> index 000000000000..10c477ec1eed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/writing-dts.rst
> @@ -0,0 +1,137 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _writingdts:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +Writing Devicetree Sources (DTS) - DTS Coding Style
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +When writing Devicetree Sources (DTS) please observe below guidelines.  =
They
> +should be considered complementary to any rules expressed already in Dev=
icetree
> +Specification and dtc compiler (including W=3D1 and W=3D2 builds).
> +
> +Individual architectures and sub-architectures can add additional rules,=
 making
> +the style stricter.
> +
> +Naming and Valid Characters
> +---------------------------
> +
> +1. Node and property names are allowed to use only:
> +
> +   * lowercase characters:: [a-z]
> +   * digits:: [0-9]
> +   * dash:: -
> +
> +2. Labels are allowed to use only:
> +
> +   * lowercase characters:: [a-z]
> +   * digits:: [0-9]
> +   * underscore:: _
> +
> +3. Unit addresses should use lowercase hex, without leading zeros (paddi=
ng).
> +
> +4. Hex values in properties, e.g. "reg", should use lowercase hex.  Any =
address
> +   part can be padded with leading zeros.
> +
> +Example::
> +
> +	gpi_dma2: dma-controller@800000 {
> +		compatible =3D "qcom,sm8550-gpi-dma", "qcom,sm6350-gpi-dma";
> +		reg =3D <0x0 0x00800000 0x0 0x60000>;
> +	}
> +
> +Order of Nodes
> +--------------
> +
> +1. Nodes within any bus, thus using unit addresses for children, shall be
> +   ordered incrementally by unit address.
> +
> +2. Nodes without unit addresses should be ordered alpha-numerically.
> +
> +3. When extending nodes in board DTS via &label, the entries should be o=
rdered
> +   alpha-numerically.
> +
> +Example::
> +
> +	// SoC DTSI
> +
> +	\ {
> +		cpus {
> +			// ...
> +		};
> +
> +		psci {
> +			// ...
> +		};
> +
> +		soc@ {
> +			dma: dma-controller@10000 {
> +				// ...
> +			};
> +
> +			clk: clock-controller@80000 {
> +				// ...
> +			};
> +		};
> +	};
> +
> +	// Board DTS
> +
> +	&clk {
> +		// ...
> +	};
> +
> +	&dma {
> +		// ...
> +	};
> +
> +
> +Order of Properties in Device Node
> +----------------------------------
> +
> +Following order of properties in device nodes is preferred:
> +
> +1. compatible
> +2. reg
> +3. ranges
> +4. All properties with values
> +5. Boolean properties
> +6. status (if applicable)
> +7. Child nodes
> +
> +The "status" property is by default "okay", thus it can be omitted.
> +
> +Example::
> +
> +	// SoC DTSI
> +
> +	usb_1_hsphy: phy@88e3000 {
> +		compatible =3D "qcom,sm8550-snps-eusb2-phy";
> +		reg =3D <0x0 0x088e3000 0x0 0x154>;
> +		#phy-cells =3D <0>;
> +		resets =3D <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +		status =3D "disabled";
> +	};
> +
> +	// Board DTS
> +
> +	&usb_1_hsphy {
> +		clocks =3D <&tcsr TCSR_USB2_CLKREF_EN>;
> +		clock-names =3D "ref";
> +		status =3D "okay";
> +	};
> +
> +
> +Indentation
> +-----------
> +
> +1. Use indentation according to :ref:`codingstyle`.
> +2. For arrays spanning across lines, preferred is to align the continued
> +   entries with opening < from first line.
> +
> +Example::
> +
> +	thermal-sensor@c271000 {
> +		compatible =3D "qcom,sm8550-tsens", "qcom,tsens-v2";
> +		reg =3D <0x0 0x0c271000 0x0 0x1000>,
> +		      <0x0 0x0c222000 0x0 0x1000>;
> +	};
> --=20
> 2.34.1
>=20

--Y+pm6WEz4WXUC9Og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVaJIgAKCRB4tDGHoIJi
0r1yAP9o2caUltEmkEWDqLU3Tlm+mTi7fNnOb2qZvyU0tMt2bQD+KxlUe2ouxli+
MRdL1PWOT18vLa7+L04wUtMvNG/7yAo=
=f/OM
-----END PGP SIGNATURE-----

--Y+pm6WEz4WXUC9Og--
