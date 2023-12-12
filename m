Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2165980F1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjLLQGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjLLQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:06:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0218E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:06:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BC1C433C8;
        Tue, 12 Dec 2023 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702397205;
        bh=/+pacyaBCTdaeI2RooruMH4tqRugpUGfvPZKsBZ7vtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuVxHOIu9PN7EY5t37Xgsdw5g54VPsNsp22aw5n78A32LWI7KnH//YmUEX788LsDX
         0P24fQ3R7OW+uQccQHa6y2rTM7U5McJjKm+pFjGWPcIJKO/VzGFjfQPKV+7FX9HbEO
         CTyHWu0riKdhelnPvg6lhpi4IBPMEyvc420LcNA4FOTwp8ToI+C0X2/WDMLv+HnXwN
         SyhKyk3y6CZ9+e3271ocVnLFCwwowhBiydWQBKyu6/wZGqypv0LfTU+gv4FKn3frGV
         ctDA4MuV+893mNue+715MczV1BjS5U6UoNuXwu+uZL2W7tXYwnAaYjHtdmZ7XL0ULq
         74CEUcH13+BNA==
Date:   Tue, 12 Dec 2023 16:06:39 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Message-ID: <20231212-caution-improvise-ed3cc6a1d305@spud>
References: <20231212115151.20016-1-quic_luoj@quicinc.com>
 <20231212115151.20016-6-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G+diO+CMPhJdHsU3"
Content-Disposition: inline
In-Reply-To: <20231212115151.20016-6-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G+diO+CMPhJdHsU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 07:51:50PM +0800, Luo Jie wrote:
> Update the yaml file for the new DTS properties.
>=20
> 1. cmn-reference-clock for the CMN PLL source clock select.
> 2. clock-frequency for MDIO clock frequency config.
> 3. add uniphy AHB & SYS GCC clocks.
> 4. add reset-gpios for MDIO bus level reset.
>=20
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  .../bindings/net/qcom,ipq4019-mdio.yaml       | 157 +++++++++++++++++-
>  1 file changed, 153 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml=
 b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> index 3407e909e8a7..9546a6ad7841 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
> @@ -20,6 +20,8 @@ properties:
>            - enum:
>                - qcom,ipq6018-mdio
>                - qcom,ipq8074-mdio
> +              - qcom,ipq9574-mdio
> +              - qcom,ipq5332-mdio
>            - const: qcom,ipq4019-mdio
> =20
>    "#address-cells":
> @@ -30,19 +32,71 @@ properties:
> =20
>    reg:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 5
>      description:
> -      the first Address and length of the register set for the MDIO cont=
roller.
> -      the second Address and length of the register for ethernet LDO, th=
is second
> -      address range is only required by the platform IPQ50xx.
> +      the first Address and length of the register set for the MDIO cont=
roller,
> +      the optional second, third and fourth address and length of the re=
gister
> +      for ethernet LDO, these three address range are required by the pl=
atform
> +      IPQ50xx/IPQ5332/IPQ9574, the last address and length is for the CM=
N clock
> +      to select the reference clock.
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 5
> =20
>    clocks:
> +    minItems: 1
>      items:
>        - description: MDIO clock source frequency fixed to 100MHZ
> +      - description: UNIPHY0 AHB clock source frequency fixed to 100MHZ
> +      - description: UNIPHY1 AHB clock source frequency fixed to 100MHZ
> +      - description: UNIPHY0 SYS clock source frequency fixed to 24MHZ
> +      - description: UNIPHY1 SYS clock source frequency fixed to 24MHZ
> =20
>    clock-names:
> +    minItems: 1
>      items:
>        - const: gcc_mdio_ahb_clk
> +      - const: gcc_uniphy0_ahb_clk
> +      - const: gcc_uniphy1_ahb_clk
> +      - const: gcc_uniphy0_sys_clk
> +      - const: gcc_uniphy1_sys_clk

> +  cmn-reference-clock:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - 0   # CMN PLL reference internal 48MHZ
> +              - 1   # CMN PLL reference external 25MHZ
> +              - 2   # CMN PLL reference external 31250KHZ
> +              - 3   # CMN PLL reference external 40MHZ
> +              - 4   # CMN PLL reference external 48MHZ
> +              - 5   # CMN PLL reference external 50MHZ
> +              - 6   # CMN PLL reference internal 96MHZ

Why is this not represented by an element of the clocks property?

> +  clock-frequency:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - 12500000
> +              - 6250000
> +              - 3125000
> +              - 1562500
> +              - 781250
> +              - 390625
> +    description:
> +      The MDIO bus clock that must be output by the MDIO bus hardware,
> +      only the listed frequecies above can be configured, other frequency
> +      will cause malfunction. If absent, the default hardware value is u=
sed.

Likewise.

Your commit message contains a bullet point list of what you are doing,
but there's no explanation here for why custom properties are required
to provide clock information.

Thanks,
Conor.

--G+diO+CMPhJdHsU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiFDwAKCRB4tDGHoIJi
0quUAQDDr4nixGEYaFJOLZBtX9ZUEEkKQqwFUm6cHie6VbRGxAEA7wYtuTlCV/Az
Alprun6Ii3/69CyX2LjKQxTESlSONgk=
=kUZs
-----END PGP SIGNATURE-----

--G+diO+CMPhJdHsU3--
