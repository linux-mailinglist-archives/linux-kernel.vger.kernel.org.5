Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC39F80D42D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344790AbjLKRj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjLKRjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:39:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5BC8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:39:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAB1C433C8;
        Mon, 11 Dec 2023 17:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702316370;
        bh=O6AOhUXq8XE/FHy4bPs9tLe8C7adGEEQpi6qHeKwxvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dr1tUscWRDFTAj58M2+OjPEC0HEZ/kAi6sHKEk24hQ2XyZBlKHO8vrVOZt3N+0znC
         n/G2QIuH6lJtUFPvfBfBKIS0m+kJCjCmnIItUEztD31mT60ezJrEjOXluhigcPeVR3
         1CxSuiB51PXHJwn2AS0wTLRUcD/+FEB/s2k1AzoJfyDB1U49pibrM7d5NKmpZdoz7t
         pMLIiY+III374wx1Ji+BZpS9BlkG+e0dW/kiS7z3/KvHpfeRnczOGqgyNaRVu70+Cv
         GBh/bDhh09tnJ3CBdTv+qSKXgYVQ4j7ndooxAtzWhg9Yv2BwlJmm6A71q1RGd9Q0KJ
         0GW/yvOWLp/iA==
Date:   Mon, 11 Dec 2023 17:39:25 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-msm: document dedicated
 IPQ4019 and IPQ8074
Message-ID: <20231211-blurb-colonist-af57c8c74ff2@spud>
References: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y3JNkiG3IRiGRNIN"
Content-Disposition: inline
In-Reply-To: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3JNkiG3IRiGRNIN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 09:58:28AM +0100, Krzysztof Kozlowski wrote:
> Add dedicated compatibles for the Qualcomm IPQ4019 and IPQ8074 SoCs,
> because usage of generic qcom,sdhci-msm-v4 compatible alone is
> deprecated.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Docum=
entation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 86fae733d9a0..c24c537f62b1 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -22,6 +22,8 @@ properties:
>        - items:
>            - enum:
>                - qcom,apq8084-sdhci
> +              - qcom,ipq4019-sdhci
> +              - qcom,ipq8074-sdhci
>                - qcom,msm8226-sdhci
>                - qcom,msm8953-sdhci
>                - qcom,msm8974-sdhci
> --=20
> 2.34.1
>=20

--y3JNkiG3IRiGRNIN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXdJTQAKCRB4tDGHoIJi
0tXvAQC0yIMoEs0QjZaKYhKOM/7LGjW+c2GpVAf8yCG/qgw8wQEAxw3wwBBHVtsK
VUjNIMFzAEUlM5nFZyczrZIYAKoZCQ8=
=0Z1o
-----END PGP SIGNATURE-----

--y3JNkiG3IRiGRNIN--
