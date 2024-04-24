Return-Path: <linux-kernel+bounces-156832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFACB8B08DE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB714B24E41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C54B15AD9A;
	Wed, 24 Apr 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNKbxxd8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7A1598E6;
	Wed, 24 Apr 2024 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713960272; cv=none; b=e+2uWNYxYsUZUmN0biNCfHAlTzy/FDEmct/ZLxOcW89SOGNLvZG/VyboFu+LiQnzzUzmlQgfgLUm3vazUuxM1S3SgGyEt07RN/f0KlPz9AOv4ZrPGYd9oxzcMH4O6MyCoNXCX5xV6k7AzyPhmeoYJjbw396bVNy+nciB0QlP8dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713960272; c=relaxed/simple;
	bh=pYYOLqQqvUPgIBFX7QGymQlQHxbe30l4/QeB1EAN03A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuwPnXgcHVk+5qjXckSPMRwZQPF3GZrVnkRvoenwFiqcj24l3hFvYxr6piaQ5NVwXbnU9eZ3uJdxw/r9Af++OnPKQIXJw86eu9nW5inWxmtp1rs2h06s6gNIqa4LiSxgmhaf4Qe/ZG64LZq5XqXuWq+k77G96gSi1Yx992nOYkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNKbxxd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE34C113CE;
	Wed, 24 Apr 2024 12:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713960271;
	bh=pYYOLqQqvUPgIBFX7QGymQlQHxbe30l4/QeB1EAN03A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNKbxxd8hXnmn5DUGCaxpL6+4VAhvQIszoAWYHbgTsYPLSivwzvqolBSi99q+rY+T
	 2cxBhivMbfFEhz8JK8evCD52NpidHF24ZNzdtzB1gGkUGVSXWYu3O7XDv5dGAZTffp
	 d7yp+prjgdUwnq2GGbkFm/LL2Z1xSt4v2w4ELUnP+6O6UcNBA0iYgjl0u6gcmLkE4p
	 2ZCrLikzHQ3TEaQErrELp2cORASIWSRpmoDhWmBdNQ9hiNwrjt/nLTsFKTA5kNqOnV
	 n+/5HIZboWw/Fx1gqv6qDXel1GN7UOYss230u1QDPWk7sdKkIUl48aENrBxaksyixn
	 dy9L9CaJbnijw==
Date: Wed, 24 Apr 2024 13:04:27 +0100
From: Conor Dooley <conor@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, frank.li@nxp.com,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Message-ID: <20240424-lustfully-region-826b9570bc38@spud>
References: <1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com>
 <1713939683-15328-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FnrRZ8qNOS4RlZZi"
Content-Disposition: inline
In-Reply-To: <1713939683-15328-3-git-send-email-hongxing.zhu@nxp.com>


--FnrRZ8qNOS4RlZZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 02:21:22PM +0800, Richard Zhu wrote:
> Add i.MX8QM and i.MX8QXP HSIO SerDes PHY binding.
> Introduce one HSIO configuration 'fsl,hsio-cfg', which need be set at
> initialization according to board design.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8qm-hsio.yaml         | 146 ++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml b=
/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> new file mode 100644
> index 000000000000..3e2824d1616c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml
> @@ -0,0 +1,146 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/fsl,imx8qm-hsio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale i.MX8QM SoC series HSIO SERDES PHY
> +
> +maintainers:
> +  - Richard Zhu <hongxing.zhu@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8qm-hsio
> +      - fsl,imx8qxp-hsio
> +  reg:
> +    minItems: 4
> +    maxItems: 4
> +
> +  "#phy-cells":
> +    const: 3
> +    description:
> +      The first defines the type of the PHY refer to the include phy.h.
> +      The second defines controller index.
> +      The third defines the lane mask of the lane ID, indicated which
> +      lane is used by the PHY. They are defined as HSIO_LAN* in
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
> +  fsl,hsio-cfg:
> +    description: Refer macro HSIO_CFG* include/dt-bindings/phy/phy-imx8-=
pcie.h.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  fsl,refclk-pad-mode:
> +    description:
> +      Specifies the mode of the refclk pad used. It can be UNUSED(PHY
> +      refclock is derived from SoC internal source), INPUT(PHY refclock
> +      is provided externally via the refclk pad) or OUTPUT(PHY refclock
> +      is derived from SoC internal source and provided on the refclk pad=
).
> +      Refer include/dt-bindings/phy/phy-imx8-pcie.h for the constants
> +      to be used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: IMX8_PCIE_REFCLK_PAD_OUTPUT

My comments on this are still not addressed. Please go back and read my
comments about this property on v1.

--FnrRZ8qNOS4RlZZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZij1SwAKCRB4tDGHoIJi
0sB9AQCUlEN4Y+iM2h4RLoTcf+CyW85JNz9s592IJ1e0LbfxeAD/daenH3uvdPSY
R6e+lzBzHxm/BsOJDs7cEViLd9gIzQA=
=wBaM
-----END PGP SIGNATURE-----

--FnrRZ8qNOS4RlZZi--

