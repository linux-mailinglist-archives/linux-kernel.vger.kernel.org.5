Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E687E03AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377723AbjKCNPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377707AbjKCNPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:15:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DCB19D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:15:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A5DC433C8;
        Fri,  3 Nov 2023 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699017342;
        bh=L+y3pCKIDHVDD+QAE6LGVWOwqVYmCViPL4AD52mv6b8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loZ3AabEaf5V5IE23nMneEE9MrEnPsqnoa/FbrFykY2QlaPhnGk9JW/eIuRV0BPcj
         6F2UizdxzUyBdorja5OX5dfXUaYkbHPZ7TyxO30vDTTy0nSACNydTVHinYMgNSTfia
         gukQMPzsBZgmkcLIhRgcDrYSJ9abtaPBvynVIUkAaUIfXU4AA1Y8WMzuuYwPAO/sXR
         80gYO6IRcXLBD77l/g7B1DwOfKk9LvSv2bFW4tu8SENp94rvW0KLlB8O3kLwiZM/iA
         PNVJozJbfFGDUnSlY59x7EhxAI/cCdd2v4boVUfFep14QbuqU0HZge8kX1yygUSgg3
         dca9dXSeIrs1Q==
Date:   Fri, 3 Nov 2023 13:15:37 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v4 4/4] dt-bindings: Document bindings for
 Marvell Aquantia PHY
Message-ID: <20231103-pretense-caviar-eacbb7f2fe09@spud>
References: <20231103123532.687-1-ansuelsmth@gmail.com>
 <20231103123532.687-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+7u5ZFTmWOdAn48p"
Content-Disposition: inline
In-Reply-To: <20231103123532.687-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+7u5ZFTmWOdAn48p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Fri, Nov 03, 2023 at 01:35:32PM +0100, Christian Marangi wrote:
> Document bindings for Marvell Aquantia PHY.
>=20
> The Marvell Aquantia PHY require a firmware to work correctly and there
> at least 3 way to load this firmware.
>=20
> Describe all the different way and document the binding "firmware-name"
> to load the PHY firmware from userspace.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v3:
> - Make DT description more OS agnostic
> - Use custom select to fix dtbs checks
> Changes v2:
> - Add DT patch


Please, it's the merge window, there's even less reason than usual to
spit out versions less than 24h apart. This is the third version in 48
hours. As there are no changes to the binding in the v4 patch, please
take a look at
<https://lore.kernel.org/all/20231103-outboard-murkiness-e3256874c9a7@spud/>
I left a review there a few moments ago.

Thanks,
Conor.

>  .../bindings/net/marvell,aquantia.yaml        | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/marvell,aquanti=
a.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml =
b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> new file mode 100644
> index 000000000000..d43cf28a4d61
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Aquantia Ethernet PHY
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  Marvell Aquantia Ethernet PHY require a firmware to be loaded to actua=
lly
> +  work.
> +
> +  This can be done and is implemented by OEM in 3 different way:
> +    - Attached SPI directly to the PHY with the firmware. The PHY will
> +      self load the firmware in the presence of this configuration.
> +    - Dedicated partition on system NAND with firmware in it. NVMEM
> +      subsystem will be used and the declared NVMEM cell will load
> +      the firmware to the PHY using the PHY mailbox interface.
> +    - Manually provided firmware loaded from a file in the filesystem.
> +
> +  If declared, NVMEM will always take priority over filesystem provided
> +  firmware.
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - ethernet-phy-id03a1.b445
> +          - ethernet-phy-id03a1.b460
> +          - ethernet-phy-id03a1.b4a2
> +          - ethernet-phy-id03a1.b4d0
> +          - ethernet-phy-id03a1.b4e0
> +          - ethernet-phy-id03a1.b5c2
> +          - ethernet-phy-id03a1.b4b0
> +          - ethernet-phy-id03a1.b662
> +          - ethernet-phy-id03a1.b712
> +          - ethernet-phy-id31c3.1c12
> +  required:
> +    - compatible
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  firmware-name:
> +    description: specify the name of PHY firmware to load
> +
> +  nvmem-cells:
> +    description: phandle to the firmware nvmem cell
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    const: firmware
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ethernet-phy@0 {
> +            /*  Only needed to make DT lint tools work. Do not copy/paste
> +             *  into real DTS files.
> +             */
> +            compatible =3D "ethernet-phy-id31c3.1c12",
> +                         "ethernet-phy-ieee802.3-c45";
> +
> +            reg =3D <0>;
> +            firmware-name =3D "AQR-G4_v5.4.C-AQR_CIG_WF-1945_0x8_ID44776=
_VER1630.cld";
> +        };
> +
> +        ethernet-phy@1 {
> +            /*  Only needed to make DT lint tools work. Do not copy/paste
> +             *  into real DTS files.
> +             */
> +            compatible =3D "ethernet-phy-id31c3.1c12",
> +                         "ethernet-phy-ieee802.3-c45";
> +
> +            reg =3D <0>;
> +            nvmem-cells =3D <&aqr_fw>;
> +            nvmem-cell-names =3D "firmware";
> +        };
> +    };
> +
> +    flash {
> +        compatible =3D "jedec,spi-nor";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +
> +        partitions {
> +            compatible =3D "fixed-partitions";
> +            #address-cells =3D <1>;
> +            #size-cells =3D <1>;
> +
> +            /* ... */
> +
> +            partition@650000 {
> +                compatible =3D "nvmem-cells";
> +                label =3D "0:ethphyfw";
> +                reg =3D <0x650000 0x80000>;
> +                read-only;
> +                #address-cells =3D <1>;
> +                #size-cells =3D <1>;
> +
> +                aqr_fw: aqr_fw@0 {
> +                    reg =3D <0x0 0x5f42a>;
> +                };
> +            };
> +
> +            /* ... */
> +
> +        };
> +    };
> --=20
> 2.40.1
>=20

--+7u5ZFTmWOdAn48p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUTyeQAKCRB4tDGHoIJi
0gsKAP9d60hhn+nxIiDAkI0uSgvpGki4jTVDOSGmlKyqVCLa2gD9HRrea+1xVvT6
R/DZL98It5zqyAZts8tmhjcTtlYFTg8=
=b+LX
-----END PGP SIGNATURE-----

--+7u5ZFTmWOdAn48p--
