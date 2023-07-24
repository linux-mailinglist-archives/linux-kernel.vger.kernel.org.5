Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E8E75FE95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjGXR4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjGXRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:55:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0070F2D49;
        Mon, 24 Jul 2023 10:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75C816134C;
        Mon, 24 Jul 2023 17:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A724C433C7;
        Mon, 24 Jul 2023 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690221225;
        bh=RmS93u12TUXlfHMnOa2tBUZl7RpdMaVcIA79pN6ptPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxvsHC0AulXsxmImaPvHNCDTQD8Fiqlc3uftPBq96UdqjW7kiv9B/ccd+a8nq9vXy
         0uGV1gitOUSXjmxKfidGojMcsa15GuHr7boIeH7ET7LWvtnX2ogmQwHaljZDyXpuzu
         4BX5aXLK8oXANmwPX3xV9RCNERBtd9pY5fu5zaZzO2xK7y4id6BIP8ywNDfDK4749c
         UT5hDuhqZtvFb8sNQ++Weg8baQDgMBq+I5v5dh1C/UMHC9hozDUoJ3PMO5paAjKNL1
         FRkOQFOXd/JkSG2/Qof34OQGI65CG1UBMo/ItH76VXvlodktMvEvxTQiUw4TR72z99
         Lu5ydMSPit10A==
Date:   Mon, 24 Jul 2023 18:53:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com, rogerq@kernel.org,
        s-vadapalli@ti.com
Subject: Re: [PATCH 1/5] dt-bindings: phy: cadence-torrent: Add second
 optional input reference clock
Message-ID: <20230724-unhappily-promptly-b25c7e42504d@spud>
References: <20230724150002.5645-1-sjakhade@cadence.com>
 <20230724150002.5645-2-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oyZMCPGh/vy2WcGY"
Content-Disposition: inline
In-Reply-To: <20230724150002.5645-2-sjakhade@cadence.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyZMCPGh/vy2WcGY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 04:59:58PM +0200, Swapnil Jakhade wrote:
> Torrent(SD0801) PHY supports two input reference clocks. Update bindings
> to support dual reference clock multilink configurations.
>=20
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml     | 23 +++++++++++++------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.ya=
ml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index dfb31314face..ddb86ee0cebf 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -33,16 +33,25 @@ properties:
> =20
>    clocks:
>      minItems: 1
> -    maxItems: 2
> +    maxItems: 3
>      description:
> -      PHY reference clock for 1 item. Must contain an entry in clock-nam=
es.
> -      Optional Parent to enable output reference clock.
> +      PHY input reference clocks (refclk & refclk1).

"refclk" and "refclk1" don't seem like great names. What is each one
used for & should refclk1 be renamed to match its use case?

> +      Optional Parent to enable output reference clock (phy_en_refclk).
> =20
>    clock-names:
> -    minItems: 1
> -    items:
> -      - const: refclk
> -      - const: phy_en_refclk
> +    oneOf:
> +      - items:
> +          - const: refclk
> +      - items:
> +          - const: refclk
> +          - const: phy_en_refclk
> +      - items:
> +          - const: refclk
> +          - const: refclk1
> +      - items:
> +          - const: refclk
> +          - const: refclk1
> +          - const: phy_en_refclk
> =20
>    reg:
>      minItems: 1
> --=20
> 2.34.1
>=20

--oyZMCPGh/vy2WcGY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL66pAAKCRB4tDGHoIJi
0qDUAPwMqzAdfRJtG0klPd1RxCXfkaouJIVXAnXRRMKTS2C+nwD9Er70D3Obm51r
nr07DbmhAB+F0oC1rqxqfD0GFgDGpgc=
=RT+f
-----END PGP SIGNATURE-----

--oyZMCPGh/vy2WcGY--
