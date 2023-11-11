Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C817E8B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjKKQYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKQYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:24:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F073A8D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:24:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52ECC433C7;
        Sat, 11 Nov 2023 16:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699719870;
        bh=GKClXD6GTs5Oe+8N+6T6uTSKxWAvXwwhgME3dE69DWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ia4YKeMpG9rSsEq3hD1a5IKv88nxmCe3BKpAPUdJD+Ya4zgGwkdBHTiJBtzVY9xZB
         h3GqPZjtaWpzBfyEi8ceV80bQ1VwYje8yKIa1AHBRN88AjxhzwJz5QSf6UL8A40I7v
         p114zGSA59Fj4i/Ce2ls+JiTywezvTb4XyGW8YSaIYOUz+MuKqvzpZGKbQ3Z8BH5UE
         4h/vkBws6PVMBfrNyMeKBkX4NJ6hWfdCSMWlma3Hv/0RYi7Azw9pNw5SjJmRtxyOjs
         xjdjbYKygvIRfcIR19lzll9fOYPn0dN99fQESZ3EhXi4vl2A05LvXCyljNJ2VTiOQH
         r/HZLocG37oYw==
Date:   Sat, 11 Nov 2023 16:24:27 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: qcom,dwc3: adjust number of interrupts
 on SM6125
Message-ID: <20231111-credible-omnivore-656130622958@squawk>
References: <20231111141953.51841-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8Myb6ZhNzaHjc+lW"
Content-Disposition: inline
In-Reply-To: <20231111141953.51841-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8Myb6ZhNzaHjc+lW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 03:19:53PM +0100, Krzysztof Kozlowski wrote:
> Qualcomm SM6125 DWC3 USB controller comes with two interrupts (verified
> with downstream/vendor code of Trinket DTSI from Xiaomi Laurel device).
> Move the qcom,sm6125-dwc3 to appropriate place in allOf:if:then blocks
> constraining interrupts.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Docum=
entation/devicetree/bindings/usb/qcom,dwc3.yaml
> index 64043b91ffb9..3f41362b2a91 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -375,7 +375,6 @@ allOf:
>                - qcom,sdx65-dwc3
>                - qcom,sdx75-dwc3
>                - qcom,sm4250-dwc3
> -              - qcom,sm6125-dwc3
>                - qcom,sm6350-dwc3
>                - qcom,sm8150-dwc3
>                - qcom,sm8250-dwc3
> @@ -408,6 +407,7 @@ allOf:
>                - qcom,msm8996-dwc3
>                - qcom,msm8998-dwc3
>                - qcom,sm6115-dwc3
> +              - qcom,sm6125-dwc3
>      then:
>        properties:
>          interrupts:
> --=20
> 2.34.1
>=20

--8Myb6ZhNzaHjc+lW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZU+quAAKCRB4tDGHoIJi
0r8eAP9enjrVOoi1KjZy3pS4wNk/dw2cmGZGu8BLhIKkrJ/bkAEAqgolF9+SK2Op
6vpVoYMg53Uh4MsnhxTTUEH2xSZC+g0=
=mUHv
-----END PGP SIGNATURE-----

--8Myb6ZhNzaHjc+lW--
