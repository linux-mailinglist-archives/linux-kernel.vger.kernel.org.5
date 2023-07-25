Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A084C762243
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGYT3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGYT3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:29:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD0FFE;
        Tue, 25 Jul 2023 12:29:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 208806189B;
        Tue, 25 Jul 2023 19:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9B1C433C7;
        Tue, 25 Jul 2023 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690313375;
        bh=aw19mftFcyQki2PQHlA98mbcBzXuWNh8pKa925BaS+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZeJBt/MQvQ74Grt94WdQCipDu4Y762H8rFaWcX0guam6XvP9gb7DAVWuAcGzmsd0V
         6a/UmuGzUuhFPFtYCeFClwcf9QXFCuwElYenp034uWKqzRtgXMBukj0YiWXQygjnQB
         miFNq28w3cU6nQJkGoOqivk9djn+dUkINTwFeg5JhOpFmdjxo1gdGzogWmvhScZgj0
         dV0uOJOgOgTym+fgA3p53XxuCIRW6PWAhcIgZtAX1VIxEyIczPm4cabTqk7LXXVY5R
         fI2Sxshr3jHRnfcwmBEt9ZzwPyVdsYj/yphz2PgYLCGiMEDx2qgosxs3dtuBde5qv4
         meD1oQQ28EGeg==
Date:   Tue, 25 Jul 2023 20:29:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] regulator: dt-bindings: qcom,rpm: fix pattern for
 children
Message-ID: <20230725-rejoicing-lying-385eb50f988b@spud>
References: <20230725164047.368892-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CAZ1vCHBbimoAGq1"
Content-Disposition: inline
In-Reply-To: <20230725164047.368892-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CAZ1vCHBbimoAGq1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 06:40:47PM +0200, Krzysztof Kozlowski wrote:
> The "or" (|) in regular expression must be within parentheses,
> otherwise it is not really an "or" and it matches supplies:
>=20
>   qcom-apq8060-dragonboard.dtb: regulators-1: vdd_ncp-supply: [[34]] is n=
ot of type 'object'
>=20
> Fixes: fde0e25b71a9 ("dt-bindings: regulators: convert non-smd RPM Regula=
tors bindings to dt-schema")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/regulator/qcom,rpm-regulator.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpm-regulat=
or.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.ya=
ml
> index 8a08698e3484..b4eb4001eb3d 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
> @@ -49,7 +49,7 @@ patternProperties:
>    ".*-supply$":
>      description: Input supply phandle(s) for this node
> =20
> -  "^((s|l|lvs)[0-9]*)|(s[1-2][a-b])|(ncp)|(mvs)|(usb-switch)|(hdmi-switc=
h)$":
> +  "^((s|l|lvs)[0-9]*|s[1-2][a-b]|ncp|mvs|usb-switch|hdmi-switch)$":
>      description: List of regulators and its properties
>      $ref: regulator.yaml#
>      unevaluatedProperties: false
> --=20
> 2.34.1
>=20

--CAZ1vCHBbimoAGq1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAimgAKCRB4tDGHoIJi
0vatAQCvTM4CWBmZLgNfavCUCUcSLqZLax4U6upAuXalaPoBLwEA68TjEBOVHkSF
4miI5R5DwFkJN1Kw966nLoeYFoEpUgM=
=KMaP
-----END PGP SIGNATURE-----

--CAZ1vCHBbimoAGq1--
