Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F8F7F0659
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjKSNN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKSNN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:13:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53126B7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:13:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0829EC433C9;
        Sun, 19 Nov 2023 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700399633;
        bh=V5DrQvF6t0U/HsWpd5WvEPfjpOcCReCCCj86sAPbP3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oX/nHFCEfPImk+7retm6wyFAS/q9qe6NpBwcZE5N5hmznsGxkW1sQsABX0CyEQDOt
         +GxjPJ6h7EipvTIFNKpJc5uD5ktNSiQqtJD7iERW8I7kFIbjJjUxh8pvOQfZIYBgut
         MjYIQFCOvwloPORwGduT3zMIu4AGqeHTLHSWvPmhbo/wqv9IsHwZP0e4UDPjk8FijL
         bUw4QEbakMWS8viI2MKACCA6flPp6NiaAThN8RYHO8P7cex6xD1GY8v/1YN+DRG71y
         oKmfnEm7FFRjrJcExqD9MDcRfqKeosHccc8jriv2Xdn02e31rZuaioKOhWD/pr3gra
         hQPB4NpiBnstQ==
Date:   Sun, 19 Nov 2023 13:13:47 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "yu-chang.lee" <yu-chang.lee@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Garmin Chang <garmin.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: mediatek: Remove compatible
 for MT8188 VPPSYS
Message-ID: <20231119-gem-plus-3217ffee6278@spud>
References: <20231117053934.10571-1-yu-chang.lee@mediatek.com>
 <20231117053934.10571-2-yu-chang.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/qVEodwOwNmr9weC"
Content-Disposition: inline
In-Reply-To: <20231117053934.10571-2-yu-chang.lee@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/qVEodwOwNmr9weC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 01:39:33PM +0800, yu-chang.lee wrote:
> MT8188 VPPSYS 0/1 should be probed from mtk-mmsys driver to
> populate device by platform_device_register_data then start
> its own clock driver.

How does one operating system's driver probing model render these
compatibles invalid?

Cheers,
Conor.

>=20
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
> ---
>  .../devicetree/bindings/clock/mediatek,mt8188-clock.yaml        | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8188-cloc=
k.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
> index d7214d97b2ba..860570320545 100644
> --- a/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
> @@ -43,8 +43,6 @@ properties:
>        - mediatek,mt8188-vdecsys
>        - mediatek,mt8188-vdecsys-soc
>        - mediatek,mt8188-vencsys
> -      - mediatek,mt8188-vppsys0
> -      - mediatek,mt8188-vppsys1
>        - mediatek,mt8188-wpesys
>        - mediatek,mt8188-wpesys-vpp0
> =20
> --=20
> 2.18.0
>=20
>=20

--/qVEodwOwNmr9weC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVoKCwAKCRB4tDGHoIJi
0mmwAP4xlBMe7KzcRqab0tzLkrFxcEcp+1zazJckesSqDZjnDgEA1RUf5bBcEP+x
B3LIvAw1RBNkkHCQMJDouIVhi3zTvQM=
=RCYq
-----END PGP SIGNATURE-----

--/qVEodwOwNmr9weC--
