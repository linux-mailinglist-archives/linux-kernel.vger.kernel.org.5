Return-Path: <linux-kernel+bounces-125135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F4892087
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8276B287A62
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823DB1C0DDF;
	Fri, 29 Mar 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjJU9m/m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781E1C0DD1;
	Fri, 29 Mar 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726491; cv=none; b=JtDvkLlQBnfuipYDTT6mmOCLAi5ufAY753qk5VcfIAc3nm3DJOOXRuk6t3iMcp95TuJLsvfX4V3HmhiCQ++G7v1BSTu3a4w8TOX7mdDcWZml5AjO6OWwaFo3bccKi9XIpIdBCmQWnuPfSUlx8KapVbKRdD9ZJwwJfJTP5YD2f58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726491; c=relaxed/simple;
	bh=GyTVYnt7AdG3Dd44z6wHTNuYouzZBSyQzP189+huJ7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqXbbK5Vh7l6IWnUcwx4mM/5DtVBKZaOZH4WSc4PWEJXbnoK6yRwPAI4pmqNVyUQEhdDeLrGgD/Q1YxupsVeeWpta8c7zUVDs3ELca9A3o40Uz8zD4ekFGHAEz3AUAc9tCicqApSB2Lv41izwS8nNfBzokTF0DzB/nNf/eZWaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjJU9m/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992A3C433C7;
	Fri, 29 Mar 2024 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711726491;
	bh=GyTVYnt7AdG3Dd44z6wHTNuYouzZBSyQzP189+huJ7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjJU9m/mkyOFhkRCA3eJtctpC15kQZZyLV2FpaKA4Od00iBfjRX3Xyhy8dqdHIOmS
	 dVAwt8VDJA029Z4Mpzbr+uJWHUgwdNHL4Yy6glRiUhQa+5D0+TU4HRpPyS4dGM0kd4
	 bdbmMee/ruAWf4KYzi557+z+z8RsyV2yHmtN/dQt27nWiZ1tQ9Lb4TFdFFBvxNmmdn
	 yo0ToNWIjPPtktsbg3G44YDGY5QJJuT2j2UxLTcZiFNMfchRtznSSZi9VgKCl5SFsL
	 /WlSTbKdjAdZxNsCjvtMZPFSbIjVQkntohO7CV5F6nVQrstf3uhhJwt/kRyk41CGsP
	 VSkeCUImnc0zw==
Date: Fri, 29 Mar 2024 15:34:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	frank.li@nxp.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-imx@nxp.com
Subject: Re: [PATCH v1 1/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <20240329-phony-capsule-4e6a07a05771@spud>
References: <1711699790-16494-1-git-send-email-hongxing.zhu@nxp.com>
 <1711699790-16494-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cs7IEpTE45To2XyQ"
Content-Disposition: inline
In-Reply-To: <1711699790-16494-2-git-send-email-hongxing.zhu@nxp.com>


--cs7IEpTE45To2XyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 04:09:48PM +0800, Richard Zhu wrote:
> Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
> - Use the controller ID to specify which controller is binded to the
> PHY.
> - Introduce one HSIO configuration, mandatory required to set
> "PCIE_AB_SELECT" and "PHY_X1_EPCS_SEL" during the initialization.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8q-hsio.yaml          | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.yaml b/=
Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.yaml
> new file mode 100644
> index 000000000000..506551d4d94a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8q-hsio.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/fsl,imx8q-hsio.yaml#

Why doesn't the filename match a compatible?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8Q SoC series HSIO SERDES PHY
> +
> +maintainers:
> +  - Richard Zhu <hongxing.zhu@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qxp-serdes
> +      - fsl,imx8qm-serdes
> +  reg:
> +    minItems: 4
> +    maxItems: 4
> +
> +  "#phy-cells":
> +    const: 3
> +    description: |
> +      The first number defines the ID of the PHY contained in the HSIO m=
acro.
> +      The second defines controller ID binded to the PHY. The third defi=
nes the
> +      HSIO configuratons refer to the different use cases. They are defi=
ned in
> +      dt-bindings/phy/phy-imx8-pcie.h
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: phy
> +      - const: ctrl
> +      - const: misc
> +
> +  clocks:
> +    minItems: 5
> +    maxItems: 14
> +
> +  clock-names:
> +    minItems: 5
> +    maxItems: 14
> +
> +  fsl,refclk-pad-mode:
> +    description: |
> +      Specifies the mode of the refclk pad used. It can be UNUSED(PHY
> +      refclock is derived from SoC internal source), INPUT(PHY refclock
> +      is provided externally via the refclk pad) or OUTPUT(PHY refclock
> +      is derived from SoC internal source and provided on the refclk pad=
).
> +      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants
> +      to be used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2 ]

Why do we need numbers and a header here at all? The enum should be an
enum of strings input, output & unused. Oh and "unused" can just be
dropped, and not having the property at all would mean "unused".

> +
> +  power-domains:
> +    description: |
> +      i.MX8Q HSIO SerDes power domains. i.MX8QXP has one SerDes power do=
mains.
> +      And i.MX8QM has two.

The text description here can go, your constrains communicate this.

> +    minItems: 1
> +    maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +  - clocks
> +  - clock-names
> +  - fsl,refclk-pad-mode
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qxp-serdes
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: apb_pclk0
> +            - const: pclk0

Why would you have different ordering for the two devices?

> +            - const: phy0_crr
> +            - const: ctl0_crr
> +            - const: misc_crr
> +        power-domains:
> +          minItems: 1
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qm-serdes
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pclk0
> +            - const: pclk1
> +            - const: apb_pclk0
> +            - const: apb_pclk1
> +            - const: pclk2
> +            - const: epcs_tx
> +            - const: epcs_rx
> +            - const: apb_pclk2
> +            - const: phy0_crr
> +            - const: phy1_crr
> +            - const: ctl0_crr
> +            - const: ctl1_crr
> +            - const: ctl2_crr
> +            - const: misc_crr
> +        power-domains:
> +          minItems: 2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8-clock.h>
> +    #include <dt-bindings/clock/imx8-lpcg.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    #include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +    serdes: phy@5f1a0000 {

Drop the unused label please.

> +            compatible =3D "fsl,imx8qxp-serdes";
> +            reg =3D <0x5f1a0000 0x10000>,
> +                  <0x5f120000 0x10000>,
> +                  <0x5f140000 0x10000>,
> +                  <0x5f160000 0x10000>;
> +            reg-names =3D "reg", "phy", "ctrl", "misc";
> +            clocks =3D <&phyx1_lpcg IMX_LPCG_CLK_0>,
> +                     <&phyx1_lpcg IMX_LPCG_CLK_4>,
> +                     <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
> +                     <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
> +                     <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
> +            clock-names =3D "apb_pclk0", "pclk0", "phy0_crr", "ctl0_crr",
> +                          "misc_crr";
> +            power-domains =3D <&pd IMX_SC_R_SERDES_1>;
> +            #phy-cells =3D <3>;

> +            status =3D "disabled";

Drop this status.

Cheers,
Conor.

> +    };
> +...
> --=20
> 2.37.1
>=20

--cs7IEpTE45To2XyQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgbflgAKCRB4tDGHoIJi
0v6bAQDGLQBWxukAIrpMH4pQ8yeDJcd+eREanS8LcXD2Cb58MQD9HSfsSoQREccM
9JP9ZptFGr/5xY9XNxrVwOQBr7oWzQ8=
=7OBA
-----END PGP SIGNATURE-----

--cs7IEpTE45To2XyQ--

