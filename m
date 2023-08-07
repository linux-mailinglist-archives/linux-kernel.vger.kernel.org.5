Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98919772803
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjHGOjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjHGOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB0A10DC;
        Mon,  7 Aug 2023 07:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDA1161D5E;
        Mon,  7 Aug 2023 14:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4259DC433C7;
        Mon,  7 Aug 2023 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691419168;
        bh=iQco7pxNtitwKp1HMGQSoYJsu9kvGpQLvoFE/amgGtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XyObQZUI96AhyQVk1KiJRgyc+06JUEN3JWAeVsYTu9Auesm40X6tyStZ2VEF+445D
         5KX/jJW04r+pqmmph88HEwa86wtORSzzOEBkovvWzwc2P+FaascJwvkxYR4Yd7X5NE
         Tm4ltGmdBLS8taEqA4MpDAsJaYX36De+cuoWCHHtL4rO/dLIG4kHIN5bo6OpzETDmG
         rM/oA2YmtSNMYY33tqdQVF2urVWi2BSNbBaDJisp6dHsKXJdj52MtaPP4xJlL3S+2j
         mRRFXkU8ZqvAWFqkgcpek2Wj6uiZozb65CJZu5sRRUe47EPnca5y8uiCMvypkot5VF
         Ex5u6xGiWQzuA==
Date:   Mon, 7 Aug 2023 15:39:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vigneshr@ti.com, srk@ti.com,
        nm@ti.com
Subject: Re: [PATCH] dt-bindings: remoteproc: pru: Add Interrupt property
Message-ID: <20230807-euphemism-trailing-ef4130dc7437@spud>
References: <20230807110836.2612730-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1jdWVwq42WtLkpBA"
Content-Disposition: inline
In-Reply-To: <20230807110836.2612730-1-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1jdWVwq42WtLkpBA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 04:38:36PM +0530, MD Danish Anwar wrote:
> Add interrupts and interrupt-names protperties for PRU and RTU cores.
>=20
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../bindings/remoteproc/ti,pru-rproc.yaml     | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.ya=
ml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> index cd55d80137f7..6970316943bb 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
> @@ -66,6 +66,16 @@ properties:
>        Should contain the name of the default firmware image
>        file located on the firmware search path.
> =20
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt specifiers enable the virtio/rpmsg communication between=
 MPU
> +      and the PRU/RTU cores.
> +
> +  interrupt-names:
> +    items:
> +      - const: vring
> +
>  if:
>    properties:
>      compatible:
> @@ -171,6 +181,9 @@ examples:
>                <0x22400 0x100>;
>          reg-names =3D "iram", "control", "debug";
>          firmware-name =3D "am65x-pru0_0-fw";
> +        interrupt-parent =3D <&icssg0_intc>;
> +        interrupts =3D <16 2 2>;
> +        interrupt-names =3D "vring";
>        };

These examples would probably be more helpful if they used the
appropriate defines, no?

> =20
>        rtu0_0: rtu@4000 {
> @@ -180,6 +193,9 @@ examples:
>                <0x23400 0x100>;
>          reg-names =3D "iram", "control", "debug";
>          firmware-name =3D "am65x-rtu0_0-fw";
> +        interrupt-parent =3D <&icssg0_intc>;
> +        interrupts =3D <20 4 4>;
> +        interrupt-names =3D "vring";
>        };
> =20
>        tx_pru0_0: txpru@a000 {
> @@ -198,6 +214,9 @@ examples:
>                <0x24400 0x100>;
>          reg-names =3D "iram", "control", "debug";
>          firmware-name =3D "am65x-pru0_1-fw";
> +        interrupt-parent =3D <&icssg0_intc>;
> +        interrupts =3D <18 3 3>;
> +        interrupt-names =3D "vring";
>        };
> =20
>        rtu0_1: rtu@6000 {
> @@ -207,6 +226,9 @@ examples:
>                <0x23c00 0x100>;
>          reg-names =3D "iram", "control", "debug";
>          firmware-name =3D "am65x-rtu0_1-fw";
> +        interrupt-parent =3D <&icssg0_intc>;
> +        interrupts =3D <22 5 5>;
> +        interrupt-names =3D "vring";
>        };
> =20
>        tx_pru0_1: txpru@c000 {
> --=20
> 2.34.1
>=20

--1jdWVwq42WtLkpBA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNECFwAKCRB4tDGHoIJi
0uAAAQCv+PBOP8/27AfSbERfPzfJ8qe0qOYDPQZg6GEo/lmsPAD+Nb/9LP9+9o+J
8HIuSivmkOmx6egC3SyRduL0FiYz9gs=
=IG6P
-----END PGP SIGNATURE-----

--1jdWVwq42WtLkpBA--
