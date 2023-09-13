Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23F779EB33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbjIMOgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjIMOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:36:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFEE90;
        Wed, 13 Sep 2023 07:36:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACA5C433C7;
        Wed, 13 Sep 2023 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694615797;
        bh=l/HLN/NV+mFI79hNIP6t/1/MsWeZvJq9VBZFuP7L0SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aI/4Xcwr+/SuDZ5RkIVFKe9vn9OzdOumSxTas1jMNhT+/73O1+a0lXXTJBML0z3LU
         StRAQNvoVbDofRUBdveADi1CI+u4Yy9CSzbWb7bJHILn3duxC5skYh7TAWTQMg6JuZ
         CKVkcDM0YAIIEGVFsll5G9mqeKOl+gfSnuNjVqhGg9vN7LMEvGTOJEGCOLRPSv/Y6x
         IQ0arNn2a3ROxugi/vYgxqg/vJ88kF8HvkMdLzawcLJ21Vmn+1E5gKwIYuTz8jFmMu
         PpnrwSAE6hT8PmjI3unD7rnKGBRJGpqX4WAyZZFNtLoWCSzCtloCa7roZmHcudeAMN
         JleoCQvuhV7Nw==
Date:   Wed, 13 Sep 2023 15:36:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: add mt8390-evk
 board
Message-ID: <20230913-scoop-agnostic-66e65d426134@spud>
References: <20230913040449.29560-1-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iUv/m+HGu/hljI90"
Content-Disposition: inline
In-Reply-To: <20230913040449.29560-1-macpaul.lin@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iUv/m+HGu/hljI90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

For $subject, the "dts: " can be dropped.

On Wed, Sep 13, 2023 at 12:04:48PM +0800, Macpaul Lin wrote:
> 1. Add compatible for MT8390.
> 2. Add bindings for the MediaTek mt8390-evk board, also known
> as the "Genio 700-EVK".
>=20
> The MT8390 and MT8188 belong to the same SoC family,
> with only minor differences in their physical characteristics.
> They utilize unique efuse values for differentiation.
>=20
> The booting process and configurations are managed by boot
> loaders, firmware, and TF-A. Consequently, the part numbers
> and procurement channels vary.
>=20
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> dependencies for v1:
>  - This patch should be applied after the following patch set
>   - mt8365's bindings
>    - https://lore.kernel.org/linux-arm-kernel/20230912092444.31635-1-macp=
aul.lin@mediatek.com/T/
>   - mt8395's bindings: v6
>    - https://lore.kernel.org/lkml/20230911115717.26184-1-macpaul.lin@medi=
atek.com/T/
>   - mt8188's bindings
>    - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47c=
c.camel@mediatek.com/T/
>=20
> Changess for v2:
>  - drop description for multiple boards
>  - update dependencies with the following patch sets
>   - mt8395's bindings: v7
>    - https://lore.kernel.org/linux-arm-kernel/20230913032057.3197-1-macpa=
ul.lin@mediatek.com/T/ =20
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docume=
ntation/devicetree/bindings/arm/mediatek.yaml
> index 0248bb458180..3968d5934fa2 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -252,6 +252,11 @@ properties:
>            - enum:
>                - mediatek,mt8365-evk
>            - const: mediatek,mt8365
> +      - items:
> +          - enum:
> +              - mediatek,mt8390-evk
> +          - const: mediatek,mt8390
> +          - const: mediatek,mt8188

This is prob a little unusual (at least I don't think I've seen a patch
doing this so far), but the mediatek maintainers can do as they wish
here I think.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>        - items:
>            - enum:
>                - mediatek,mt8395-evk
> --=20
> 2.18.0
>=20

--iUv/m+HGu/hljI90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQHI7wAKCRB4tDGHoIJi
0ll7AQDZ+UG2u+qicKq6nOFt/uOuzVVJA4Fv1p7iu8KWnBvSIwD7B0k3SXfuHDhe
2TnPbFUp4xoHPLJaJt4Oe/zhg3/Y/Ak=
=ky4l
-----END PGP SIGNATURE-----

--iUv/m+HGu/hljI90--
