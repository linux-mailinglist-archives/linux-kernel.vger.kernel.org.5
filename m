Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FEE7E9DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjKMNuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKMNux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:50:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F03AD53
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:50:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB04C433C7;
        Mon, 13 Nov 2023 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883450;
        bh=WwbCN114QiP0MlzJD2sfEH3eE1j43I2qgLo7i+dL0oM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pBcX2G4QpFuzkUw+JPFg6UnLmIlTopw4x8DNRWIOX1NLF6olH5z/k6PoX/+bJKR/F
         tV1xtPVI2+fXG7Pv1NzDzVt9fb/vbF8GfCXvgG6FRXK9OHjk8XBtFt7QuXpwqjuFaj
         J0qQ3sHlhc2jGPbGiUcLgsdxP+tLl04HRs173VPI3KCtUZrpIQbEk0FsxMRtQ/7uPd
         FZMHD3UdOUyauWqFoDtkHQyMAzwFXwEK8H2NrV47w3mJ9tl2tj12TFYZOg9NhMxLcl
         r6V7LC5Za/wHKjMKhp0N43PV090Va8UG5JcytghrWM8fF0sd42fY3jyNIJC5nXmLTr
         Jiq5SRm6kjp0A==
Date:   Mon, 13 Nov 2023 13:50:47 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: gpu: samsung: re-order entries to match
 coding convention
Message-ID: <20231113-tweet-batboy-c2867f2ceeee@squawk>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
 <20231112184403.3449-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YTvCgQf37/RkS4VO"
Content-Disposition: inline
In-Reply-To: <20231112184403.3449-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YTvCgQf37/RkS4VO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 07:44:00PM +0100, Krzysztof Kozlowski wrote:
> The Devicetree bindings coding convention, as used in most of the files
> and expressed in Documentation/devicetree/bindings/example-schema.yaml,
> expects "allOf:" block with if-statements after "required:" block.
>=20
> Re-order few schemas to match the convention to avoid repeating review
> comments for new patches using existing code as template.  No functional
> changes.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

thanks,
Conor,

> ---
>  .../devicetree/bindings/gpu/samsung-g2d.yaml  | 53 +++++++++--------
>  .../bindings/gpu/samsung-scaler.yaml          | 59 +++++++++----------
>  2 files changed, 56 insertions(+), 56 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml b/Doc=
umentation/devicetree/bindings/gpu/samsung-g2d.yaml
> index e7daae862578..b6951acc7643 100644
> --- a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
> +++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
> @@ -27,32 +27,6 @@ properties:
>    iommus: {}
>    power-domains: {}
> =20
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        const: samsung,exynos5250-g2d
> -
> -then:
> -  properties:
> -    clocks:
> -      items:
> -        - description: fimg2d clock
> -    clock-names:
> -      items:
> -        - const: fimg2d
> -
> -else:
> -  properties:
> -    clocks:
> -      items:
> -        - description: sclk_fimg2d clock
> -        - description: fimg2d clock
> -    clock-names:
> -      items:
> -        - const: sclk_fimg2d
> -        - const: fimg2d
> -
>  required:
>    - compatible
>    - reg
> @@ -60,6 +34,33 @@ required:
>    - clocks
>    - clock-names
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos5250-g2d
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: fimg2d clock
> +        clock-names:
> +          items:
> +            - const: fimg2d
> +
> +    else:
> +      properties:
> +        clocks:
> +          items:
> +            - description: sclk_fimg2d clock
> +            - description: fimg2d clock
> +        clock-names:
> +          items:
> +            - const: sclk_fimg2d
> +            - const: fimg2d
> +
>  additionalProperties: false
> =20
>  examples:
> diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/=
Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> index 5317ac64426a..97d86a002a90 100644
> --- a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> +++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
> @@ -26,36 +26,6 @@ properties:
>    iommus: {}
>    power-domains: {}
> =20
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        const: samsung,exynos5420-scaler
> -
> -then:
> -  properties:
> -    clocks:
> -      items:
> -        - description: mscl clock
> -
> -    clock-names:
> -      items:
> -        - const: mscl
> -
> -else:
> -  properties:
> -    clocks:
> -      items:
> -        - description: pclk clock
> -        - description: aclk clock
> -        - description: aclk_xiu clock
> -
> -    clock-names:
> -      items:
> -        - const: pclk
> -        - const: aclk
> -        - const: aclk_xiu
> -
>  required:
>    - compatible
>    - reg
> @@ -63,6 +33,35 @@ required:
>    - clocks
>    - clock-names
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: samsung,exynos5420-scaler
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: mscl clock
> +        clock-names:
> +          items:
> +            - const: mscl
> +
> +    else:
> +      properties:
> +        clocks:
> +          items:
> +            - description: pclk clock
> +            - description: aclk clock
> +            - description: aclk_xiu clock
> +        clock-names:
> +          items:
> +            - const: pclk
> +            - const: aclk
> +            - const: aclk_xiu
> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.34.1
>=20

--YTvCgQf37/RkS4VO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVIpswAKCRB4tDGHoIJi
0hmMAP93B7Y0eOqTKSYR5l7ofAt+w3rJUe42+UR2t2Y79C3dBgD+OJWQvdiQaVVX
vWFPGy2vuZOGzCeK7ttAqRIvXZ+3WgM=
=VtkS
-----END PGP SIGNATURE-----

--YTvCgQf37/RkS4VO--
