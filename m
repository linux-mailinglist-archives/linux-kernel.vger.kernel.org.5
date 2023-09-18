Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67317A54FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 23:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjIRV0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 17:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjIRV0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 17:26:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E828E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 14:26:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA42C433C8;
        Mon, 18 Sep 2023 21:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695072377;
        bh=lEN1ls2dQkgYbioyJtFPuLMXALUsRxPq6Ic/riPZ0ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NqgBdUlH+wSg9plu2Er1SzBhJU2wj9WSfxwhShNfKjOe9Cul0jpDI0hk/Cl1V6UQt
         2PV2q+GfZjLlBLJguSRIuqd+qC0nmbnJIgSO2DC4u2zmLq7R9u6sN8y1mullDfZTm1
         47tYhx3uPj0wmmaZV7ArWxgMhrgKh3jz/i3AucsqOGlQdsKIkt+LGVbDhA5eRzlrVX
         D2kQCfd54mO6pXJhqFiH3KqscVbnUj/oDJCrSBwTh4Oz+z6Ul6B6y81r88Vhu1A69P
         jeG0jQtFYwafrk/+TMtIyAEOttfVYJqQUEePKOdIlriH8KHrZ/0HxooyiY0OomwOAs
         tkd32TsQDs6GA==
Date:   Mon, 18 Sep 2023 22:26:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kwanghoon Son <k.son@samsung.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Document th1520 reset control
Message-ID: <20230918-4ef7f52da269f3a7e4023bb3@fedora>
References: <20230918045125.4000083-1-k.son@samsung.com>
 <CGME20230918045134epcas1p1b80b338b66512a976c3783cd0e51da50@epcas1p1.samsung.com>
 <20230918045125.4000083-2-k.son@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WE881O0NIJLSEjS/"
Content-Disposition: inline
In-Reply-To: <20230918045125.4000083-2-k.son@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WE881O0NIJLSEjS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 04:51:23AM +0000, Kwanghoon Son wrote:
> Add documentation to describe th1520 reset device

I would appreciate if you could add some information here as to what is
missing from this - the reset controller isn't just for two WDTs is it?

>=20
> Signed-off-by: Kwanghoon Son <k.son@samsung.com>
> ---
>  .../bindings/reset/thead,th1520-reset.yaml    | 44 +++++++++++++++++++
>  .../dt-bindings/reset/thead,th1520-reset.h    |  9 ++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-=
reset.yaml
>  create mode 100644 include/dt-bindings/reset/thead,th1520-reset.h
>=20
> diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.y=
aml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> new file mode 100644
> index 000000000000..49ea8c6a331f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/thead,th1520-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD th1520 SoC Reset Controller
> +
> +maintainers:
> +  - Kwanghoon Son <k.son@samsung.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: thead,th1520-reset
> +      - const: syscon

iDumb question perhaps, but why is this a syscon?

Cheers,
Conor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/thead,th1520-reset.h>
> +
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        reset-controller@ffef014000 {
> +            compatible =3D "thead,th1520-reset", "syscon";
> +            reg =3D <0xff 0xef014000 0x0 0x1000>;
> +            #reset-cells =3D <1>;
> +        };
> +    };
> diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-=
bindings/reset/thead,th1520-reset.h
> new file mode 100644
> index 000000000000..ec10751814e5
> --- /dev/null
> +++ b/include/dt-bindings/reset/thead,th1520-reset.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef DT_BINDING_RESET_TH1520_H
> +#define DT_BINDING_RESET_TH1520_H
> +
> +#define TH1520_RESET_WDT0 0
> +#define TH1520_RESET_WDT1 1


--WE881O0NIJLSEjS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQjAcAAKCRB4tDGHoIJi
0n1CAP4m0yajHLa/MSox0QSJHmD92CP5eFO1xINILg9LNE7KowD/edgItl4xdrao
dBqNau3d679aFegrxyqICNRrYm8figQ=
=9Hl8
-----END PGP SIGNATURE-----

--WE881O0NIJLSEjS/--
