Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB45177A5DB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjHMJsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 05:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHMJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 05:48:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C696410CE;
        Sun, 13 Aug 2023 02:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 632336227B;
        Sun, 13 Aug 2023 09:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DBAC433C8;
        Sun, 13 Aug 2023 09:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691920121;
        bh=MA2+PJqOeFmwFTlNJcRp71uT1hWwf5woRDqJwXhaHMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+WHGTVquOf/ckiSKobRJ5wScQSNFvIY1LaVLpN6w0Fa6X7x9IzpNCpE3Piosk/bI
         A4rMXam+DF0xUHDWesbB/vFghPLBx8ySWheDDlBTmIZ07icF+qPN0w/uIODJwkUfyM
         aUoUbWynTck/Jzu2aA3sLFR2AtwSUGCelcbUQBRgwqEhtcL20mAGUFIpJLEvuZG/A2
         8o9tPc/YLtR8QahlAKjRjYuf3tM/tqm9tOYcNurrAiSv9iOEyVlncOpIGa6gW6BI3a
         GcJN5bxTiVPxppfx7hMYd95NUx+o8VQ+0knKk8puNPWkg2tqidmqRP9ELuibna0IYG
         +LP+5j+mBCTYQ==
Date:   Sun, 13 Aug 2023 10:48:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: crypto: qcom,prng: Add SM8450
Message-ID: <20230813-velvet-folic-10625075aedd@spud>
References: <20230811-topic-8450_prng-v1-0-01becceeb1ee@linaro.org>
 <20230811-topic-8450_prng-v1-1-01becceeb1ee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ayu4EmJnvOAjxhgj"
Content-Disposition: inline
In-Reply-To: <20230811-topic-8450_prng-v1-1-01becceeb1ee@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ayu4EmJnvOAjxhgj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 10:50:56PM +0200, Konrad Dybcio wrote:
> SM8450's PRNG does not require a core clock reference. Add a new
> compatible with a qcom,prng-ee fallback and handle that.
>=20
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/crypto/qcom,prng.yaml      | 24 ++++++++++++++++=
+-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Do=
cumentation/devicetree/bindings/crypto/qcom,prng.yaml
> index bb42f4588b40..36b0ebd9a44b 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> @@ -11,9 +11,13 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - qcom,prng  # 8916 etc.
> -      - qcom,prng-ee  # 8996 and later using EE
> +    oneOf:
> +      - enum:
> +          - qcom,prng  # 8916 etc.
> +          - qcom,prng-ee  # 8996 and later using EE
> +      - items:
> +          - const: qcom,sm8450-prng-ee
> +          - const: qcom,prng-ee
> =20
>    reg:
>      maxItems: 1
> @@ -28,8 +32,18 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - clocks
> -  - clock-names
> +
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: qcom,sm8450-prng-ee
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> =20
>  additionalProperties: false
> =20
>=20
> --=20
> 2.41.0
>=20

--Ayu4EmJnvOAjxhgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNim9AAKCRB4tDGHoIJi
0gpPAP9xK4CE35RqLQN5w2zN+bQ2RtZFfGU2Rd+iS2cXdKx7MAD8CZwhnVxeDnWh
ehZFdNmoaPawbCYAclmBc7ISspdejgA=
=6i5X
-----END PGP SIGNATURE-----

--Ayu4EmJnvOAjxhgj--
