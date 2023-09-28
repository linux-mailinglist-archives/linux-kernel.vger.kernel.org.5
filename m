Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880E17B26B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjI1UjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjI1UjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:39:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D131A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 13:39:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D00C433C8;
        Thu, 28 Sep 2023 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695933550;
        bh=xINXDKcTe6ijRIqT/PemFdRIVgJJnLG488c56JbijgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iwGeJcBnI4vzd0lgEzuKqStNzmqnNABTX3xmghorXxnqzGNG6fOsKS0yoXIjFGHX8
         hoRJRFEQau+i9BA8D5FUzu0TlSKY/OJeMI4mxDGOYphFOnFGBLTJu3z62TJkdw7M8o
         sBnzZaGl5t+KCMwnxVfd4WVh0oH0myH1whk9T9wT6uBC38H5H+dL5oJtYA+8HvsYIc
         7f7mWXomZ4TwjnMJRUYY5JQibY7xFJlsyh5Yvw0G2JVxXnbk36zYjIO0Jl0znRPkG5
         8TgGEbUNYa62BWEKEBKY6JSM1w1j7x//N1I9tPJOhBgtzgsEyqKrAEs/rWAlPwIXQ8
         OERuE5KGkNnXQ==
Date:   Thu, 28 Sep 2023 21:39:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Christophe Roullier <christophe.roullier@foss.st.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/12] dt-bindings: net: add STM32MP13 compatible in
 documentation for stm32
Message-ID: <20230928-footwork-padlock-524173c3e205@spud>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
 <20230928151512.322016-2-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8U54nw6WVDXbYGlQ"
Content-Disposition: inline
In-Reply-To: <20230928151512.322016-2-christophe.roullier@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8U54nw6WVDXbYGlQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Sep 28, 2023 at 05:15:01PM +0200, Christophe Roullier wrote:
> New STM32 SOC have 2 GMACs instances.
> GMAC IP version is SNPS 4.20.
>=20
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  .../devicetree/bindings/net/stm32-dwmac.yaml  | 78 +++++++++++++++++--
>  1 file changed, 70 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Doc=
umentation/devicetree/bindings/net/stm32-dwmac.yaml
> index fc8c96b08d7dc..ca976281bfc22 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -22,18 +22,17 @@ select:
>          enum:
>            - st,stm32-dwmac
>            - st,stm32mp1-dwmac
> +          - st,stm32mp13-dwmac
>    required:
>      - compatible
> =20
> -allOf:
> -  - $ref: snps,dwmac.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
>        - items:
>            - enum:
>                - st,stm32mp1-dwmac
> +              - st,stm32mp13-dwmac
>            - const: snps,dwmac-4.20a
>        - items:
>            - enum:
> @@ -74,13 +73,10 @@ properties:
> =20
>    st,syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
> -    items:
> -      - items:
> -          - description: phandle to the syscon node which encompases the=
 glue register
> -          - description: offset of the control register
>      description:
>        Should be phandle/offset pair. The phandle to the syscon node which
> -      encompases the glue register, and the offset of the control regist=
er
> +      encompases the glue register, the offset of the control register a=
nd
> +      the mask to set bitfield in control register
> =20
>    st,eth-clk-sel:
>      description:
> @@ -101,6 +97,38 @@ required:
> =20
>  unevaluatedProperties: false
> =20
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp1-dwmac
> +              - st,stm32-dwmac
> +    then:
> +      properties:
> +        st,syscon:
> +          items:
> +            items:
> +              - description: phandle to the syscon node which encompases=
 the glue register
> +              - description: offset of the control register

These descriptions should, IMO, be moved back out to the st,syscon
definition. If you put the 3 descriptions there, with "minItems: 2" &
put "maxItems: 2" and "minItems: 3" in each of the if/then clauses.
Also, it should be sufficient to simplify to if/then/else.

Cheers,
Conor.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp13-dwmac
> +    then:
> +      properties:
> +        st,syscon:
> +          items:
> +            items:
> +              - description: phandle to the syscon node which encompases=
 the glue register
> +              - description: offset of the control register
> +              - description: field to set mask in register
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -161,3 +189,37 @@ examples:
>             snps,pbl =3D <8>;
>             phy-mode =3D "mii";
>         };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    #include <dt-bindings/mfd/stm32h7-rcc.h>
> +    //Example 4
> +     ethernet3: ethernet@5800a000 {
> +           compatible =3D "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
> +           reg =3D <0x5800a000 0x2000>;
> +           reg-names =3D "stmmaceth";
> +           interrupts-extended =3D <&intc GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH=
>,
> +                                 <&exti 68 IRQ_TYPE_LEVEL_HIGH>;
> +           interrupt-names =3D "macirq",
> +                             "eth_wake_irq";
> +           clock-names =3D "stmmaceth",
> +                         "mac-clk-tx",
> +                         "mac-clk-rx",
> +                         "eth-ck",
> +                         "ptp_ref",
> +                         "ethstp";
> +           clocks =3D <&rcc ETHMAC>,
> +                    <&rcc ETHTX>,
> +                    <&rcc ETHRX>,
> +                    <&rcc ETHCK_K>,
> +                    <&rcc ETHPTP_K>,
> +                    <&rcc ETHSTP>;
> +           st,syscon =3D <&syscfg 0x4 0xff0000>;
> +           snps,mixed-burst;
> +           snps,pbl =3D <2>;
> +           snps,axi-config =3D <&stmmac_axi_config_1>;
> +           snps,tso;
> +           phy-mode =3D "rmii";
> +     };
> --=20
> 2.25.1
>=20

--8U54nw6WVDXbYGlQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRXkaAAKCRB4tDGHoIJi
0opWAP9JSnWhMjiIcX6Vc/XK2po8UfJBgrzDdpbxtFfTG/BmvwEA3JncB06h6fKE
ThgDVUqVEGxr4yKfVfIj32yBSVdxXwU=
=awMY
-----END PGP SIGNATURE-----

--8U54nw6WVDXbYGlQ--
