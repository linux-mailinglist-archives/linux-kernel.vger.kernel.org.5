Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC6779344
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjHKPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjHKPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:34:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465030FC;
        Fri, 11 Aug 2023 08:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E854261044;
        Fri, 11 Aug 2023 15:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FA4C433C8;
        Fri, 11 Aug 2023 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691768079;
        bh=r3PGtOgGMhkDijdv+iZVGveDNuPb4HD9QD/+iFIfZYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCl3cPD8dgdIUONQxajxeQQgRrlu1YgPEm+SYDUJk01vLAZIbHIIAWMubcho9PGLK
         K+ydgi3DaBDyvwiwiX3k3bdVfrNIbrCR61N3oTIx9n3AZbVXWy/cWO9F+x2jPBkgqw
         Qxm4p4FoGvTXvB9Jx/1iAMeZKqgBivx6dfMeVfY1HgRLWHEuEvQqMQJ8q++3YifJYK
         hhF/CC4jFkpZ3pZ61RJQw1+MwomN6gkJxqmTuBKsy3nz1Hx26BOH+1+vZYIoC9wa9H
         3kUmxgBdwIUtDDuQZOLWE8oa4avDf3up6Nne0WtTKzIfjW87BdJ90p9fsJD553ygg2
         UyHpB6r03DLyQ==
Date:   Fri, 11 Aug 2023 16:34:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kamlesh Gurudasani <kamlesh@ti.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 3/6] dt-bindings: crypto: Add Texas Instruments MCRC64
Message-ID: <20230811-crestless-gratify-21c9bb422375@spud>
References: <20230719-mcrc-upstream-v2-0-4152b987e4c2@ti.com>
 <20230719-mcrc-upstream-v2-3-4152b987e4c2@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4VYflVWwOKTpj1iN"
Content-Disposition: inline
In-Reply-To: <20230719-mcrc-upstream-v2-3-4152b987e4c2@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4VYflVWwOKTpj1iN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 12:58:50AM +0530, Kamlesh Gurudasani wrote:
> Add binding for Texas Instruments MCRC64
>=20
> MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
> according to the ISO 3309 standard.
>=20
> The ISO 3309 64-bit CRC model parameters are as follows:
>     Generator Polynomial: x^64 + x^4 + x^3 + x + 1
>     Polynomial Value: 0x000000000000001B
>     Initial value: 0x0000000000000000
>     Reflected Input: False
>     Reflected Output: False
>     Xor Final: 0x0000000000000000
>=20
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>  Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml | 47 +++++++++++=
++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                                             |  5 +++++
>  2 files changed, 52 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml b/Do=
cumentation/devicetree/bindings/crypto/ti,mcrc64.yaml
> new file mode 100644
> index 000000000000..38bc7efebd68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/ti,mcrc64.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments MCRC64
> +
> +description: The MCRC64 engine calculates 64-bit cyclic redundancy checks

A newline after "description" please.

> +  (CRC) according to the ISO 3309 standard.
> +
> +maintainers:
> +  - Kamlesh Gurudasani <kamlesh@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,am62-mcrc64

Is the am62 an SoC or a family of SoCs? I googled a wee bit for am62 &
there seems to be an am625 and an am623?

Otherwise, this looks good to me.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    crc@30300000 {
> +      compatible =3D "ti,am62-mcrc64";
> +      reg =3D <0x30300000 0x1000>;
> +      clocks =3D <&k3_clks 116 0>;
> +      power-domains =3D <&k3_pds 116 TI_SCI_PD_EXCLUSIVE>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 02a3192195af..66b51f43d196 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21481,6 +21481,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/ti,lmp92064.yaml
>  F:	drivers/iio/adc/ti-lmp92064.c
> =20
> +TI MEMORY CYCLIC REDUNDANCY CHECK (MCRC64) DRIVER
> +M:	Kamlesh Gurudasani <kamlesh@ti.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml
> +
>  TI PCM3060 ASoC CODEC DRIVER
>  M:	Kirill Marinushkin <kmarinushkin@birdec.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>=20
> --=20
> 2.34.1
>=20

--4VYflVWwOKTpj1iN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNZVCQAKCRB4tDGHoIJi
0n5RAP97iRCzLqZPNVjEVkEGcarsRXECumq3U8b3igybE6JXhgD+Kb1DanuELAIb
I7R1WODmew1XCk2Elgnp/H8EOq2KKAA=
=2dLk
-----END PGP SIGNATURE-----

--4VYflVWwOKTpj1iN--
