Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E0275B57B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjGTRVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGTRVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA8CC;
        Thu, 20 Jul 2023 10:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3C6D61BA9;
        Thu, 20 Jul 2023 17:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5283C433C8;
        Thu, 20 Jul 2023 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873663;
        bh=TPhswv/SPDq8a3pMV3LA6XHcj0530L73fp2ouFPJpf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oN64Lgsz608zFqLYyIFDgUuRJfoSeG7LUDhQviJfNZBGVyMmwS0lAEimCffPQLVKG
         DAQBVpYlCNzOiF1gSFbekw0Q/4FjkWyfnwF3sSe716XNZXb/jAu1grRxG0hJwM7vEq
         hxcrvY6JEQoWOlhPaL2c/pjIh450Yt3PbDyGIkq77Vw48vRuZJyotNEq6Db5Fxm5lX
         MFNu7OQ5JBVK8X2Y92/+GhKg/Ei6+lSffQKr3KcXJgdm2VcGr4YShdLwc7a2bd0dzB
         PPRn04ooBSfoiq629t9wNBQVRC8ySLsjpaW46OFrqm59/d7Bt7CNiV1W/goy0dwBgt
         y99mrOXYmSbVQ==
Date:   Thu, 20 Jul 2023 18:20:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-gpio: document PMC8180
 and PMC8180C
Message-ID: <20230720-abstain-outwit-16fa79ef873e@spud>
References: <20230720083539.73675-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HW8D6UPgOw6ZaB72"
Content-Disposition: inline
In-Reply-To: <20230720083539.73675-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HW8D6UPgOw6ZaB72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 10:35:39AM +0200, Krzysztof Kozlowski wrote:
> Document qcom,pmc8180-gpio and qcom,pmc8180c-gpio compatibles already
> used in DTS and in the same binding in allOf:if:then section for
> narrowing available GPIOs:
>=20
>   sc8180x-primus.dtb: pmic@4: gpio@c000:compatible:0: 'qcom,pmc8180c-gpio=
' is not one of ...
>=20
> Fixes: 04bed6407ee6 ("dt-bindings: pinctrl: qcom,pmic-gpio: describe gpio=
-line-names")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thaks,
Conor.

> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yam=
l b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> index 52b3d78645b3..3f8ad07c7cfd 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> @@ -54,6 +54,8 @@ properties:
>            - qcom,pm8994-gpio
>            - qcom,pm8998-gpio
>            - qcom,pma8084-gpio
> +          - qcom,pmc8180-gpio
> +          - qcom,pmc8180c-gpio
>            - qcom,pmi632-gpio
>            - qcom,pmi8950-gpio
>            - qcom,pmi8994-gpio
> --=20
> 2.34.1
>=20

--HW8D6UPgOw6ZaB72
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLls+gAKCRB4tDGHoIJi
0ic2AQCKjgg2Z2jHu/RJB283TwfwDjNiXHQd/6GV120Z1u6ihAEAltxJ1BI5BBHj
Wu/h/eMCl636OeH6L6POpmfEZdg69gc=
=DGC2
-----END PGP SIGNATURE-----

--HW8D6UPgOw6ZaB72--
