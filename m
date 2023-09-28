Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294177B2365
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjI1RKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjI1RJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:09:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE1ECCD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:09:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E21C433C7;
        Thu, 28 Sep 2023 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695920993;
        bh=ydLyUU8Ad9owlqxOzjjrCFGwsyc+eW/bHK9V17qJcvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=apM9jJiv0RiA6hfFKLaOPhe1Cr+NmHSxPw3gYMSz9f77o9G3WxZL3QUdyjoSzwzWY
         yCgOwZJUzUPsdL02+UDjWvkuM76UG3WhZWL7iVBHYRygTAjxlp+/IScNjWmYg9baIU
         JyhEhX1SQq/+NuR8vSzJ0XZ+eWhWK1l/msF9a3FlK6BXoA9+4cx4S9iUv7sX088mPY
         5Y40Nubt0BXt2WFQCJBrnP/ivAWmPOfgsMYU8oVQDClNfS8QEoeHFgH1YUBTJyOBH+
         scS5sBuZwh5x/UQk9hA8G7nebn7adDbR1fTMmCwPeGWaHKeZOp/p5nqJhaP0mo5oPX
         jPCr+rv4aQwIA==
Date:   Thu, 28 Sep 2023 18:09:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Raydium RM692E5
Message-ID: <20230928-tightrope-other-c460f227577c@spud>
References: <20230927-topic-fp5_disp-v1-0-a6aabd68199f@linaro.org>
 <20230927-topic-fp5_disp-v1-1-a6aabd68199f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x8vw0k6xdit4k0oj"
Content-Disposition: inline
In-Reply-To: <20230927-topic-fp5_disp-v1-1-a6aabd68199f@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x8vw0k6xdit4k0oj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 03:19:01PM +0200, Konrad Dybcio wrote:
> Raydium RM692E5 is a display driver IC used to drive AMOLED DSI panels.
> Describe it.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/display/panel/raydium,rm692e5.yaml    | 73 ++++++++++++++++=
++++++
>  1 file changed, 73 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm69=
2e5.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.=
yaml
> new file mode 100644
> index 000000000000..423a85616c1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/raydium,rm692e5.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raydium RM692E5 based DSI display Panels

The capitalisation here drives me crazy, but I can live with it...

> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>

In case it's a typo, you sharing the d between first and surnames in
your email addr?

> +
> +description: |

This | should not be needed.

Otherwise, this seems fine to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +  The Raydium RM692E5 is a generic DSI Panel IC used to control
> +  AMOLED panels.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fairphone,fp5-rm692e5-boe
> +      - const: raydium,rm692e5
> +
> +  dvdd-supply:
> +    description: Digital voltage rail
> +
> +  vci-supply:
> +    description: Analog voltage rail
> +
> +  vddio-supply:
> +    description: I/O voltage rail
> +
> +  reg: true
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - dvdd-supply
> +  - vci-supply
> +  - vddio-supply
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        panel@0 {
> +            compatible =3D "fairphone,fp5-rm692e5-boe", "raydium,rm692e5=
";
> +            reg =3D <0>;
> +
> +            reset-gpios =3D <&tlmm 44 GPIO_ACTIVE_LOW>;
> +            dvdd-supply =3D <&vreg_oled_vci>;
> +            vci-supply =3D <&vreg_l12c>;
> +            vddio-supply =3D <&vreg_oled_dvdd>;
> +
> +            port {
> +                panel_in_0: endpoint {
> +                    remote-endpoint =3D <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
>=20
> --=20
> 2.42.0
>=20

--x8vw0k6xdit4k0oj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRWzXAAKCRB4tDGHoIJi
0gfHAP92uHEkXiotDFaxtJYkpYkhLdDdDSZHnpPsnxRV8NHysQEAsDLjKC5cltxo
1vk1mrxxusjcbNNeK2OtqNZdrBXXwQA=
=TvCd
-----END PGP SIGNATURE-----

--x8vw0k6xdit4k0oj--
