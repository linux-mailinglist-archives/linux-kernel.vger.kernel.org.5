Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD27799D88
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 11:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346574AbjIJJkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjIJJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 05:40:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7229FCC9;
        Sun, 10 Sep 2023 02:40:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EF5C433C7;
        Sun, 10 Sep 2023 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694338834;
        bh=jLtGOqox7MJX7EormqHEUu+Ks0UsdUWX+SnzA6zN8gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeG9lPcJ0IYIef8emoCjw6630u4trREQM3bdU0sLMltnc74KkmXsrGS+2dntfryPG
         8E++qMFdSaDDdLwm3Hm1RHH5pIJOXFTuzaiEB4tDuVXTmDC6ya/gsA9BLp+/ItgRYb
         mmmOGnN2psGTw7fnf61nMaMZEu5lV2F86L7z8Ts6l20FRO360N0+1cpvV5uErYYpfr
         42XRy2I9o6mBFN783JKzyj836uiMTFu5mAmdL1204HOc2GCsOmNQupgI5mATqO6Veo
         zwqQu/m/QSK6ewknMvrrfz9WX/IsfT0e4pV9j2NflUo8H5YBPUCUQackgtdc5B/4WJ
         iX3r71mUEB8Pw==
Date:   Sun, 10 Sep 2023 10:40:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Shuijing Li <shuijing.li@mediatek.com>
Cc:     chunfeng.yun@mediatek.com, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, linux-phy@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
Subject: Re: [PATCH v3] dt-bindings: phy: Add compatible for Mediatek MT8188
Message-ID: <20230910-say-kebab-b6968c44809d@spud>
References: <20230908075310.17825-1-shuijing.li@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="usyFpcbg56OVilwN"
Content-Disposition: inline
In-Reply-To: <20230908075310.17825-1-shuijing.li@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--usyFpcbg56OVilwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 03:53:10PM +0800, Shuijing Li wrote:
> Add dt-binding documentation of dsi-phy for MediaTek MT8188 SoC.
>=20
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
> Changes in v3:
> After upstreaming the basic version of mt8188.dtsi, we will add the
> following mipi node in mt8188.dtsi:
> mipi_tx_config0: mipi_dphy0@11c80000 {
> 			compatible =3D "mediatek,mt8188-mipi-tx",
> 				     "mediatek,mt8183-mipi-tx";
> 			reg =3D <0 0x11c80000 0 0x1000>;
> 			clocks =3D <&clk26m>;
> 			#clock-cells =3D <0>;
> 			#phy-cells =3D <0>;
> 			clock-output-names =3D "mipi_tx0_pll";
> 			status =3D "disabled";
> 		};
> per suggestion from the previous thread:
> https://lore.kernel.org/all/0a6d3d14-33f0-92d2-b42f-e4d336c8cd91@linaro.o=
rg/
> Changes in v2:
> Adjust mt8188 position.
> ---
>  Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml =
b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> index a63b20dfa4a5..6703689fcdbe 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> @@ -30,6 +30,7 @@ properties:
>            - const: mediatek,mt8173-mipi-tx
>        - items:
>            - enum:
> +              - mediatek,mt8188-mipi-tx
>                - mediatek,mt8365-mipi-tx
>            - const: mediatek,mt8183-mipi-tx
>        - const: mediatek,mt2701-mipi-tx
> --=20
> 2.40.1
>=20

--usyFpcbg56OVilwN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP2PDAAKCRB4tDGHoIJi
0pFIAP9jrgL8n+v3mPL3S1wh1wd48GwQVMGsnmrG6WeVsQI/5QD/ZtNCfHkVx9lM
r4VnXPQ1uUnAjilJIX5m0w9Bp6N30QM=
=d8a5
-----END PGP SIGNATURE-----

--usyFpcbg56OVilwN--
