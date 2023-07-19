Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96B8759A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjGSQTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGSQTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F371BB;
        Wed, 19 Jul 2023 09:19:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AB3361783;
        Wed, 19 Jul 2023 16:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65CDC433C7;
        Wed, 19 Jul 2023 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689783570;
        bh=ExPtoNyHUFeA29htWYi8hJzCPMxOdh9y0o8C7+6x1lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfTgyiTQhVxWaw755l10GClhg5+3b6Fp4FGzCfjaksK42v6g8fqT7ScwGk5/3hgfF
         DBSZ2GMM24bHrNcLaDxGwITGb7o/Ga0jGOOsjBp7Jf3o4Mwhz1auzwHyPGc4b3ycVS
         Zb3bXv8VtRDApWZg+oioE4IJY72NBKG+2Uo5bqwqiEBu1aqkRx2mK4vWihpgdpbq7Y
         jk4P/nlwgijz1hDCElZ3EUjkhoa192INmKvNtqigHkW/mIQnSC3tWzAcx4Kbf0p7hS
         10tQEjDtI4ytiTsTk6AuKJRwxzThXwaPmjBMP3XO4VmipcZ2UrNYlz5+1bj1SeAmpi
         eVC0qOD3uM8Mg==
Date:   Wed, 19 Jul 2023 17:19:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: convert U-Boot env to NVMEM
 layout
Message-ID: <20230719-prelaunch-hatching-556f6fe97c43@spud>
References: <20230718160652.26756-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BSVX58EKAjDZorw2"
Content-Disposition: inline
In-Reply-To: <20230718160652.26756-1-zajec5@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BSVX58EKAjDZorw2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 06:06:50PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> Use "nvmem-layout" and drop unused "mac" label while at it.

Stupid question perhaps, does the "old" way of doing this still work
after this series?

Thanks
Conor.

>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
>  .../bindings/nvmem/layouts/nvmem-layout.yaml    |  1 +
>  .../nvmem/{ =3D> layouts}/u-boot,env.yaml         | 17 +++++++++++------
>  2 files changed, 12 insertions(+), 6 deletions(-)
>  rename Documentation/devicetree/bindings/nvmem/{ =3D> layouts}/u-boot,en=
v.yaml (87%)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout=
=2Eyaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> index 3b40f7880774..382507060651 100644
> --- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> @@ -21,6 +21,7 @@ oneOf:
>    - $ref: fixed-layout.yaml
>    - $ref: kontron,sl28-vpd.yaml
>    - $ref: onie,tlv-layout.yaml
> +  - $ref: u-boot,env.yaml
> =20
>  properties:
>    compatible: true
> diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Do=
cumentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> similarity index 87%
> rename from Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> rename to Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> index 36d97fb87865..ebe3b71ba155 100644
> --- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
> +$id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
>  title: U-Boot environment variables
> @@ -72,11 +72,14 @@ examples:
>          };
> =20
>          env: partition@40000 {
> -            compatible =3D "u-boot,env";
>              reg =3D <0x40000 0x10000>;
> =20
> -            mac: ethaddr {
> -                #nvmem-cell-cells =3D <1>;
> +            nvmem-layout {
> +                compatible =3D "u-boot,env";
> +
> +                ethaddr {
> +                    #nvmem-cell-cells =3D <1>;
> +                };
>              };
>          };
>      };
> @@ -92,9 +95,11 @@ examples:
>              label =3D "u-boot";
> =20
>              partition-u-boot-env {
> -                compatible =3D "brcm,env";
> +                nvmem-layout {
> +                    compatible =3D "brcm,env";
> =20
> -                ethaddr {
> +                    ethaddr {
> +                    };
>                  };
>              };
>          };
> --=20
> 2.35.3
>=20

--BSVX58EKAjDZorw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLgNDQAKCRB4tDGHoIJi
0hwUAP4j+zpbaVgSQrGuOwLm3aPVNHHJgVIEwIMMpon8jA4FeQD/b+UUjeXlLRus
R4eNI7ua07EPpuM/RbOpElBPPSqdog8=
=ON60
-----END PGP SIGNATURE-----

--BSVX58EKAjDZorw2--
