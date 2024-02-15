Return-Path: <linux-kernel+bounces-67079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 786818565E0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4EC1C22AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE715131E52;
	Thu, 15 Feb 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7PC2yP2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F512FB33;
	Thu, 15 Feb 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007049; cv=none; b=FTdwEpXZhbAKbeX7HAwuSAWKVFUbz46JpjZdGd5vYLr1+GBY7fzY2noMdjengAioJ3eCl1NMloyw4bVuSCD+bHD85Ljq/zHpIGO3rReUi1Ci1SE3qBUPpfRSb3tzsYhEhpNdNBRcM2xJy5/W9ZXr13Hjo/AhkFX8ro+GxtI7saI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007049; c=relaxed/simple;
	bh=n4QN1QaOnHa9dWqkKphOT17gFQtTnkhJWHRJ7aqMprY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQPQFQ6lHHQEmemjlOoowksuXFu7PX2ubnWkcua1RrIn5nzbuN4jaRm57SMtxddu65TekNuTE6+lOFGU485sPpJQBk6m2FSceHg3f5jdbXrgPC7LxLAXxuf9bYwBH4iqFboxwn+J0Nq0nfsQZrPDkLiZT8xLuRxbd13ldfgGhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7PC2yP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D23BC433C7;
	Thu, 15 Feb 2024 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708007048;
	bh=n4QN1QaOnHa9dWqkKphOT17gFQtTnkhJWHRJ7aqMprY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7PC2yP239Rulrb4Oc0X42S7d0fM0Qj3QMQ7xzjZKF6YFGVw1OWI0WKrgzuZCMR1u
	 FZ21DlxMcKnKJmfKG2ILc8JfIxKYteCJwBlYJtO8NPD76hUWOJwMScsukUMbNQPkvW
	 3TEa3/xe0SGtmFGuZPO+FxLf3K5zo9ILVYuFwg4pnJShUsfgTqYsdfoIu6kO16v1oN
	 O1pZejF6PC71dGBeD3ggzxHxqGdteuIjhg5T/gOPSxqZilj0Bk6JpK9exc5X/FDjfh
	 yEhuGn/4vntrq34XCOgVmOMZsMYwfwi9a5wQDA59IME5uJWA9JV8GO4J2/tyPDjFW5
	 Xon+tLJr8u3Ig==
Date: Thu, 15 Feb 2024 14:24:02 +0000
From: Conor Dooley <conor@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, broonie@kernel.org,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
	vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, quic_srichara@quicinc.com,
	quic_varada@quicinc.com
Subject: Re: [PATCH 1/5] spi: dt-bindings: add binding doc for spi-qpic-snand
Message-ID: <20240215-upon-anime-af032e49e84d@spud>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UDj3Iu6IuX6GpJeg"
Content-Disposition: inline
In-Reply-To: <20240215134856.1313239-2-quic_mdalam@quicinc.com>


--UDj3Iu6IuX6GpJeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 07:18:52PM +0530, Md Sadre Alam wrote:
> Add device-tree binding documentation for QCOM QPIC-SNAND-NAND Flash
> Interface.
>=20
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  .../bindings/spi/qcom,spi-qpic-snand.yaml     | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-s=
nand.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.ya=
ml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
> new file mode 100644
> index 000000000000..fa7484ce1319
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/qcom,spi-qpic-snand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QPIC NAND controller
> +
> +maintainers:
> +  - Md sadre Alam <quic_mdalam@quicinc.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq9574-snand
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +  - if:

> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq9574-snand
> +
> +    then:
> +      properties:
> +        dmas:
> +          items:
> +            - description: tx DMA channel
> +            - description: rx DMA channel
> +            - description: cmd DMA channel
> +
> +        dma-names:
> +          items:
> +            - const: tx
> +            - const: rx
> +            - const: cmd

None of this complexity here is needed, you have only one device in this
binding and therefore can define these properties at the top level.

Cheers,
Conor.

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +    qpic_nand: spi@79b0000 {
> +        compatible =3D "qcom,ipq9574-snand";
> +        reg =3D <0x1ac00000 0x800>;
> +
> +        clocks =3D <&gcc GCC_QPIC_CLK>,
> +                 <&gcc GCC_QPIC_AHB_CLK>,
> +                 <&gcc GCC_QPIC_IO_MACRO_CLK>;
> +        clock-names =3D "core", "aon", "iom";
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        flash@0 {
> +            compatible =3D "spi-nand";
> +            reg =3D <0>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +            nand-ecc-engine =3D <&qpic_nand>;
> +            nand-ecc-strength =3D <4>;
> +            nand-ecc-step-size =3D <512>;
> +            };
> +        };
> --=20
> 2.34.1
>=20

--UDj3Iu6IuX6GpJeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc4eggAKCRB4tDGHoIJi
0vO4AQC/9EXBXWmYMmh41rKINWfmf2C0tle9Rbns/1KqqVSKAQD+Lo3EUIx5DARc
ZjZm/tSapiiF/R0brf6h1Z0Dk28FfQQ=
=mzbY
-----END PGP SIGNATURE-----

--UDj3Iu6IuX6GpJeg--

