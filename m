Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1447F1748
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbjKTP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjKTP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:29:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA7DB4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:29:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E5BC433C8;
        Mon, 20 Nov 2023 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700494147;
        bh=Ms5XKqtV48T/7UWkSrtXy8BuO4sjZAxUYswyT96cTb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYrQtGZUnR3SRdwudlFE6g0WV/S2aM4KJwrApP6542QsWIezo8ojScYmzsxWGPGf5
         O0m6Stfksf9vN8HV3vtgUNp232PHwMwV68/l8bM0arNUwlpRn616TWLE60HTyK2yGn
         JLr14Ny2bY6g5aKWJXOtxYFZtpGl+rvFv7ZlnohaCYf3bXultZxBc23HRtlY+VJLA4
         Qa5mCUAIdEqdKz4OAUgqMtmQalbKMuOiDpwBL68GFks29AbUNnK+emimIw9IZIG6gg
         10VgaRoy+TIxeIGZqM3/nRARDiUAWho4F7BbDBz9hlxUREYh5TDNF1D8etnJDXv1qP
         iom29oMCjOvyg==
Date:   Mon, 20 Nov 2023 15:29:02 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <quic_sibis@quicinc.com>
Subject: Re: [PATCH] dt-bindings: arm: qcom-soc: extend pattern for matching
 existing SoCs
Message-ID: <20231120-shortness-constrict-1f1120a20229@spud>
References: <20231120100617.47156-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r0bVCTV5dwKUg7bb"
Content-Disposition: inline
In-Reply-To: <20231120100617.47156-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r0bVCTV5dwKUg7bb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 11:06:17AM +0100, Krzysztof Kozlowski wrote:
> Add missing QDU, QRU and SDA platform names to the pattern matching all
> Qualcomm compatibles.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> ---
>=20
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>  .../devicetree/bindings/arm/qcom-soc.yaml        | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Docume=
ntation/devicetree/bindings/arm/qcom-soc.yaml
> index 97621c92a1ab..09db42456c12 100644
> --- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> @@ -23,7 +23,7 @@ description: |
>  select:
>    properties:
>      compatible:
> -      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+=
=2E*$"
> +      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm=
)[0-9]+.*$"
>    required:
>      - compatible
> =20
> @@ -31,17 +31,17 @@ properties:
>    compatible:
>      oneOf:
>        # Preferred naming style for compatibles of SoC components:
> -      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+=
(pro)?-.*$"
> +      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm=
)[0-9]+(pro)?-.*$"
>        - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
> =20
>        # Legacy namings - variations of existing patterns/compatibles are=
 OK,
>        # but do not add completely new entries to these:
> -      - pattern: "^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|s=
dx|sm)[0-9]+.*$"
> -      - pattern: "^qcom,gcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0=
-9]+.*$"
> -      - pattern: "^qcom,mmcc-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[=
0-9]+.*$"
> -      - pattern: "^qcom,pcie-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[=
0-9]+.*$"
> -      - pattern: "^qcom,rpm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0=
-9]+.*$"
> -      - pattern: "^qcom,scm-(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0=
-9]+.*$"
> +      - pattern: "^qcom,[ak]pss-wdt-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|s=
c|sd[amx]|sm)[0-9]+.*$"
> +      - pattern: "^qcom,gcc-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx=
]|sm)[0-9]+.*$"
> +      - pattern: "^qcom,mmcc-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[am=
x]|sm)[0-9]+.*$"
> +      - pattern: "^qcom,pcie-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[am=
x]|sm)[0-9]+.*$"
> +      - pattern: "^qcom,rpm-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx=
]|sm)[0-9]+.*$"
> +      - pattern: "^qcom,scm-(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx=
]|sm)[0-9]+.*$"
>        - enum:
>            - qcom,dsi-ctrl-6g-qcm2290
>            - qcom,gpucc-sdm630
> --=20
> 2.34.1
>=20

--r0bVCTV5dwKUg7bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVt7OgAKCRB4tDGHoIJi
0l1bAQCF5GBmK2eKai9vLgMMx0ff+FQhDKfiJeTeczYIUaFWGwEAp8bmFBFKBnBg
j4ddSuvql8JifMTzf/dPYflQ5I29xw0=
=uBeI
-----END PGP SIGNATURE-----

--r0bVCTV5dwKUg7bb--
