Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A847E55E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjKHMHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjKHMHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:07:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D1172E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:06:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A35BC433C7;
        Wed,  8 Nov 2023 12:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699445217;
        bh=E8ffCvvVSy06+RkLnh3gDcrcEXxVvHjtlU89OGGbBwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2FLrWlBUaAsotYQvQXCbzq+GBtEZGHCW66vHWouh/atqF8maj3CV6pi4Jq89NMRe
         7w1e9PO3usdQ/dHZPJv8NugSwScFCCLLtBJjBmAGsXwRFG1h3E5XeAxVmu6wMS1OtK
         kc5xrJgr60JD5RNa4VWX3f7g77QmGulaW+KBLXFIMe529nSJgm9p50N/Jp1j2HzP/F
         4Zy5fSPptinnCqvhNqJzPhDMnx0/XMOWMDqMjIcqNkqwE6ilwb2yU2ngvtZLxwsLu1
         4Z2bzp5iMD8ih9oaN12oEwwef4ZOsAnDp/g5Ow3yJHdp2KggL7LmD1XeqN/VGzXZBG
         l1HpKeVl9RUNA==
Date:   Wed, 8 Nov 2023 12:06:51 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display/msm: qcom,sm8250-mdss: add
 DisplayPort controller node
Message-ID: <20231108-shady-fretted-04b62ebc3a9d@spud>
References: <20231107103600.27424-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nKFadshYx5Iq5ePI"
Content-Disposition: inline
In-Reply-To: <20231107103600.27424-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nKFadshYx5Iq5ePI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 11:36:00AM +0100, Krzysztof Kozlowski wrote:
> Document the DisplayPort controller node in MDSS binding, already used
> in DTS:
>=20
>   sm8250-xiaomi-elish-boe.dtb: display-subsystem@ae00000: Unevaluated pro=
perties are not allowed ('displayport-controller@ae90000' was unexpected)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/display/msm/qcom,sm8250-mdss.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-md=
ss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.ya=
ml
> index 994975909fea..51368cda7b2f 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
> @@ -52,6 +52,16 @@ patternProperties:
>        compatible:
>          const: qcom,sm8250-dpu
> =20
> +  "^displayport-controller@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: true
> +
> +    properties:
> +      compatible:
> +        items:
> +          - const: qcom,sm8250-dp
> +          - const: qcom,sm8350-dp
> +
>    "^dsi@[0-9a-f]+$":
>      type: object
>      additionalProperties: true
> --=20
> 2.34.1
>=20

--nKFadshYx5Iq5ePI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUt52wAKCRB4tDGHoIJi
0jNCAP913yxIWogE9QqPm+1GT8ZYPoNmJBQ48DPDYxIIJTtx+QD/bAY8GRpKjJ4K
z0nP0V083UgpjsG73rOJ4pFJl5Vx6gE=
=YNNb
-----END PGP SIGNATURE-----

--nKFadshYx5Iq5ePI--
