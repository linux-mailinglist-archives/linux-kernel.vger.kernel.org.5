Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710507C885E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjJMPM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjJMPMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:12:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E47495
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:12:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A706CC433C8;
        Fri, 13 Oct 2023 15:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697209941;
        bh=4E09wJEx+hUjRW7ZMgCIOg2Gy6RCgWzCpZcW8uW0hV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEw1/nod0VWsOUN96f/HB/xl14XHvv7bs8HaaT9VgRUOIoCZr4Oa8kO+poHc9DIv1
         /jto6hgFaVnMLq5MlmrXPgdoL9rahdni23v4TZElMiKN+RkaJaVtqclD0v9SfILjM+
         bMlJtFdwtTOBZrUxWNkPsbSt64bj1Sv/8AuCsCX1wEI0AYD66b23bisvUxoJ2uP6S1
         OOB5KT1DZ7koGouBAB8r0hvq0IOAawxcFxE1raczRRrel472KVzLjuw90HdRGA3eXr
         eF1flLrayL6Mrw9vHsyw7N/Lp3KGwM3zOjSGZ4oXGoReV7SzCuZT5QOpgbHBvISlv5
         hvpIyTL8eqDSA==
Date:   Fri, 13 Oct 2023 16:12:17 +0100
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
Subject: Re: [PATCH 3/9] dt-bindings: arm: mediatek: Add MT8186 Steelix
 Chromebook
Message-ID: <20231013-playoff-unsmooth-2d3c8b30790e@spud>
References: <20231012230237.2676469-1-wenst@chromium.org>
 <20231012230237.2676469-4-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HPmS7nFTK45JskTw"
Content-Disposition: inline
In-Reply-To: <20231012230237.2676469-4-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HPmS7nFTK45JskTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 07:02:29AM +0800, Chen-Yu Tsai wrote:
> Add an entry for the MT8186 based Steelix Chromebook, also known as the
> Lenovo 300e Yoga Chromebook Gen 4.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index aa7e6734b336..fafd5e18f640 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -206,6 +206,13 @@ properties:
>            - enum:
>                - mediatek,mt8183-pumpkin
>            - const: mediatek,mt8183
> +      - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4)
> +        items:
> +          - enum:
> +              - google,steelix-sku131072
> +              - google,steelix-sku131073

This one makes sense though, because both of the SKUs are in an enum.

> +          - const: google,steelix
> +          - const: mediatek,mt8186
>        - description: Google Tentacruel (ASUS Chromebook CM14 Flip CM1402=
F)
>          items:
>            - const: google,tentacruel-sku262144
> --=20
> 2.42.0.655.g421f12c284-goog
>=20

--HPmS7nFTK45JskTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSleUQAKCRB4tDGHoIJi
0v6CAQCmJE4kCmgE2JDh5U5bt3i9neQPQ4ZHWoVy6VSjohWS5AD/QfDDtg1Oc4Ft
FZpadGnpde7ftxx7TPCKzl7RQjgdOQw=
=ZIPt
-----END PGP SIGNATURE-----

--HPmS7nFTK45JskTw--
