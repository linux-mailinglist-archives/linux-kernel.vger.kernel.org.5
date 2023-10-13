Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E037C885B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjJMPLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjJMPLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:11:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85161BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:11:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B15CC433C8;
        Fri, 13 Oct 2023 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697209905;
        bh=wWx6bTT4peFPZVDN8jlp9bueUTF/tNc81wMs/mO9uj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/mL+Odl84kIo3oHvupfFbsf/tVcWYeTnMdAdhvutDphfIzwGZgAZX6nKHwUgdkl8
         y0I2K113S2oSv3XP+IsqGupv/EcJv9Cvy52dpxXXBr2SadAyCCiSjJrUhpI33TpLZu
         V+FP8aeAU3rPI0msypo955hyfUfQJhqqrh0etKmTBXop34CyGW1hAtowpMaMyu6qvp
         N1REqtSE8WxrQAttdX636Xfo0wji19uJTF8HMrZJHPOfLxhSLPdK424sdrGM8tYRyh
         OWXc7SMwPtx4nD49z7HZRfyNRYKpC9N08nJMUlcI5yF0oy9LPQAd/LdGnXz4WAPrjm
         3pm7uPxI+BWcA==
Date:   Fri, 13 Oct 2023 16:11:40 +0100
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
Message-ID: <20231013-washer-mortally-b27c196ac50f@spud>
References: <20231012230237.2676469-1-wenst@chromium.org>
 <20231012230237.2676469-3-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qZrNVeNY4C8BPHbt"
Content-Disposition: inline
In-Reply-To: <20231012230237.2676469-3-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qZrNVeNY4C8BPHbt
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

> The extra SKU IDs for the Tentacruel devices map to different sensor
> components attached to the Embedded Controller. These are not visible
> to the main processor.

Wha? Given your ordering, is a "google,tentacruel-sku262144" a super-set
of "google,tentacruel-sku262145"? If not, this compatible ordering
doesn't make sense. I can't tell from your description, and the
absence of a
items:
	  - const: google,tentacruel-sku262145
	  - const: google,tentacruel-sku262146
	  - const: google,tentacruel-sku262147
	  - const: google,tentacruel
	  - const: mediatek,mt8186
suggests that there is no google,tentacruel-sku262145
device?

Cheers,
Conor.

>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
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

--qZrNVeNY4C8BPHbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSleLAAKCRB4tDGHoIJi
0pRSAQCm5Pjv7akIozKm62dk8SGuLSxCh0ovD5X2IwGkDAvM9gD+LDDRxce4O9bi
/KzKV6TfbpjgrtL+at7HUZafG9wFlQM=
=wdgM
-----END PGP SIGNATURE-----

--qZrNVeNY4C8BPHbt--
