Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4B2767E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 12:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjG2KRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 06:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjG2KRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 06:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABF61FE7;
        Sat, 29 Jul 2023 03:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4DA60B52;
        Sat, 29 Jul 2023 10:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281EBC433C8;
        Sat, 29 Jul 2023 10:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690625827;
        bh=LLtK0W9au1ec/B+PX7duXrAoJ45Fx1caP/dPstfZ0Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBAwhR6XU6Ggmt71z8g76/UQJ38iYkzIu3WzEKxhs4cCYqMryWH0Ng2h+ko2OY4wD
         +EUY0XPSMrcRNvQtQG9OYdZdvgOWBS1ULOkoDE2vu0Bq6mLwwnGtk2cTmUClhCyJNq
         7vsEUYu/rBJeOoVB9/M2cG8JADRNNl5oe2Gczer7rn5UlOSRBrJY5nka6mlMFvx3Dj
         5xdNLsRCGnuHgcngTCLeqP9YoZs1U8BpISgradzjBx/i3E3tjhBJO2EAGvV2I03kim
         88BuIdGTYdlYMnw2a19IUVZLnQUz9KqoYyM9nyFEdAPFWZVNTsPrCib1GVtpn4O6Im
         kNSSJ8ZDg2tsw==
Date:   Sat, 29 Jul 2023 11:17:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        patchwork-jzi@pengutronix.de, kernel@pengutronix.de,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: display: move LVDS data-mapping
 definition to separate file
Message-ID: <20230729-ultimatum-rickety-b26e118eaeb0@spud>
References: <20230523-simplepanel_support_nondefault_datamapping-v4-0-e6e7011f34b5@pengutronix.de>
 <20230523-simplepanel_support_nondefault_datamapping-v4-1-e6e7011f34b5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="moll4ESZB2UhCi3o"
Content-Disposition: inline
In-Reply-To: <20230523-simplepanel_support_nondefault_datamapping-v4-1-e6e7011f34b5@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--moll4ESZB2UhCi3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 04:16:55PM +0200, Johannes Zink wrote:
> As the LVDS data-mapping property is required in multiple bindings: move
> it to separate file and include instead of duplicating it.
>=20
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
>=20
> ---
>=20
> Changes:
>=20
> v3 -> v4: none
>=20
> v2 -> v3: worked in Conor's and Laurent's review findings (thank you
>           for reviewing my work): drop +| on description

I think both Laurent & I provided reviewed-bys on v2. Is there a reason
you did not include them? Here's mine back again:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
and here's a link to Laurent's:
https://lore.kernel.org/all/20230602153239.GK26944@pendragon.ideasonboard.c=
om/

--moll4ESZB2UhCi3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMTnHQAKCRB4tDGHoIJi
0ghuAP9U/DSQJSkadJ2XepyP6FsnHzyMueedqxt+5GWrjXizTAD/Z9CRNc8Uhre8
FOOH1OA4iX1wA5ArCf5tLfEgJzx4cw8=
=ipsV
-----END PGP SIGNATURE-----

--moll4ESZB2UhCi3o--
