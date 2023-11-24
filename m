Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3A97F75FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjKXOII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXOIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:08:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FB51990
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:08:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DABC433C8;
        Fri, 24 Nov 2023 14:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700834892;
        bh=gCNNSLuNTNgJRezDOscqJbufDhCORYGxigIFY01Gdeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tup9k2Ft33wTnh6RS3H3hryJ0gV/v7LapkgD0de9xKgsL2ZH13Qqm/RwwIktk+2lN
         uMrxmpcYKvJD++LQdgxN9oxjolbP7JkX/1cFyrD2rdEp8CHy/ymRViFW+l5wR0aNgL
         8CLv/GMg900O9kAFH8kzB7mYDR7UQY0O0Wz36khdu6qvqahYQXlb6Mu1LTrapvLD0N
         8YNtF6ssJFQJP+iHA5qysff59STyHraLrvM48XCTTr4O+Z9fJ9QHu5D7rpQhJ9itO+
         OyIDuKP3MNDlabwDIaxiVCRtJZb8/AS7Ve6Yd7x7+OE4tCQkKS2Obn3CXoce2P/gCn
         B242ivNLykdLw==
Date:   Fri, 24 Nov 2023 14:08:07 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: arm: mediatek: Add MT8186 Tentacruel /
 Tentacool Chromebooks
Message-ID: <20231124-old-each-230d55963934@spud>
References: <20231012230237.2676469-1-wenst@chromium.org>
 <20231012230237.2676469-3-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k22Pzja/5vzpnLDi"
Content-Disposition: inline
In-Reply-To: <20231012230237.2676469-3-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k22Pzja/5vzpnLDi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 07:02:28AM +0800, Chen-Yu Tsai wrote:
> Add entries for MT8186 based Tentacruel / Tentacool Chromebooks. The two
> are based on the same board design: the former is a convertible device
> with a touchscreen, stylus, and some extra buttons; the latter is a
> clamshell device and lacks these additional features.
>=20
> The two devices both have two variants. The difference is a second
> source touchpad controller that shares the same address as the original,
> but is incompatible.
>=20
> The extra SKU IDs for the Tentacruel devices map to different sensor
> components attached to the Embedded Controller. These are not visible
> to the main processor.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

I had a chat with Doug at Plumbers about the limitations of your
firmware. As a result, I am fine with acking this if you switch the
order of the sku compatibles to be in descending order.
The firmware can handle that, right?

Cheers,
Conor.

> ---
>  .../devicetree/bindings/arm/mediatek.yaml     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 60337b439744..aa7e6734b336 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -206,6 +206,32 @@ properties:
>            - enum:
>                - mediatek,mt8183-pumpkin
>            - const: mediatek,mt8183
> +      - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM1402=
F)
> +        items:
> +          - const: google,tentacruel-sku262144
> +          - const: google,tentacruel-sku262145
> +          - const: google,tentacruel-sku262146
> +          - const: google,tentacruel-sku262147
> +          - const: google,tentacruel
> +          - const: mediatek,mt8186
> +      - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM1402=
F)
> +        items:
> +          - const: google,tentacruel-sku262148
> +          - const: google,tentacruel-sku262149
> +          - const: google,tentacruel-sku262150
> +          - const: google,tentacruel-sku262151
> +          - const: google,tentacruel
> +          - const: mediatek,mt8186
> +      - description: Google Tentacool (ASUS Chromebook CM14 CM1402C)
> +        items:
> +          - const: google,tentacruel-sku327681
> +          - const: google,tentacruel
> +          - const: mediatek,mt8186
> +      - description: Google Tentacool (ASUS Chromebook CM14 CM1402C)
> +        items:
> +          - const: google,tentacruel-sku327683
> +          - const: google,tentacruel
> +          - const: mediatek,mt8186
>        - items:
>            - enum:
>                - mediatek,mt8186-evb
> --=20
> 2.42.0.655.g421f12c284-goog
>=20

--k22Pzja/5vzpnLDi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWCuLQAKCRB4tDGHoIJi
0vvFAQDqLdZ9fSLKLXtTwd018oBmapd8qz3y/vFHemYVSnYu3wEA6OPpzezOmyyj
BIxI0dbI2gD0r5mVOmRPaFRmc56q+Q8=
=B7KU
-----END PGP SIGNATURE-----

--k22Pzja/5vzpnLDi--
