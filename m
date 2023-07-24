Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4752775FE9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGXR6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGXR6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89783AA1;
        Mon, 24 Jul 2023 10:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2897361356;
        Mon, 24 Jul 2023 17:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC6AC433C8;
        Mon, 24 Jul 2023 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690221388;
        bh=EoU2mL1gtuuaXdfBR+KnZtr/Rqd1NuPOSOhdR1Blljk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CTnSuqCqUVG+82HZjo6wV812xv8w1NbG6WQHw95JxygLo14Qz+c4PgKXuG68X/Qx2
         Pz0d+mPUDuA2NaE+PW/8ROfoT7jbSN3Dhqo1RpGV+ldyvy7BUge/9aw6WFT0BGFdQ1
         6y91KAtvww1+n3lh/Z4sDEN6Zfeq4U0t5TK91W8b503xeIG+bCD8FvrBNjXYxZwoEc
         +c4orP4G81N/KUPCuSg7UeRiduSRsBWdOcYEyPWx0RVo/jGsRVY1fJuabeMgOr/B1N
         4nmlA3Pqzc+BQbM0WB7AUV2Pdk7/9iqZqPSNpetZzxk0y9PmY3nDeojno9Zf5M0eYa
         6SmniY7KQXFzA==
Date:   Mon, 24 Jul 2023 18:56:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com, rogerq@kernel.org,
        s-vadapalli@ti.com
Subject: Re: [PATCH 4/5] dt-bindings: phy: cadence-torrent: Add a separate
 compatible for TI J7200
Message-ID: <20230724-shampoo-junior-f9e0bb095668@spud>
References: <20230724150002.5645-1-sjakhade@cadence.com>
 <20230724150002.5645-5-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bGIJ911Wz6RGVT1e"
Content-Disposition: inline
In-Reply-To: <20230724150002.5645-5-sjakhade@cadence.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bGIJ911Wz6RGVT1e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 05:00:01PM +0200, Swapnil Jakhade wrote:
> TI J7200 uses Torrent SD0805 version which is a special version
> derived from SD0801 that has an additional input reference clock.
> Add a separate compatible for TI J7200 platforms.
>=20
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.ya=
ml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> index ddb86ee0cebf..e3a1efd61033 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -20,6 +20,7 @@ properties:
>    compatible:
>      enum:
>        - cdns,torrent-phy
> +      - ti,j7200-serdes-10g
>        - ti,j721e-serdes-10g

Should the number of clocks not be restricted dynamically based on the
compatible, since only the 7200 requires the extra refclk?


--bGIJ911Wz6RGVT1e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL67RwAKCRB4tDGHoIJi
0vcMAP4noEcvSdlF5E1v6dNB2dJ9iZHEzf31j10soPGA7MlG9wEA8lZWSCFG+Vcx
cmh3GJkbkHg7ET7cZgc52F/k+9xMGAI=
=nuHG
-----END PGP SIGNATURE-----

--bGIJ911Wz6RGVT1e--
