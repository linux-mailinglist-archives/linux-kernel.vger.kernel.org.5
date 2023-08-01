Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F8976BEB4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjHAUrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHAUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:47:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9537B1982;
        Tue,  1 Aug 2023 13:47:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29CC461700;
        Tue,  1 Aug 2023 20:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2661EC433C8;
        Tue,  1 Aug 2023 20:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690922868;
        bh=c/w4VL2J8uHP5ZIb48hOKtiDw/YDEZ6xJOJtc8VvBxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3DDZ5iY2x0AT8PvRlmN9IPjLASTVxZ8AYKDHpGJK6Hi+2NGwYYLrJM1U2hsFJsh4
         dPuLHTVXAjwPm8gDYhqLKPQUg3Q39azMZP2KW4eAtrv0lCI63hqVzMGDz1HOwE732i
         GsmHJTrew3CUNnGETYIjBq8qwD/GaeM9wKEjpMvB/bvNxinc/Fcr5Jz/zfoujqFLmh
         Q0/1ybfTo/CrGZy6sb/NKb7kO0ByCIy4kDU2zTzgY2voAmkjRpRusAh2yp6NpUgfIn
         EGzf3JSOkuZ8Fp773rj7mT1jZyhOc/TlA4gSymtd9+FJTweP5XbkQKje92q7rg9VW/
         MEy3SK/ij4pvg==
Date:   Tue, 1 Aug 2023 21:47:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: Remove the OV5642 entry
Message-ID: <20230801-clobber-attempt-7033f92b3d08@spud>
References: <20230801170015.40965-1-festevam@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CKmBG76A66lRswJw"
Content-Disposition: inline
In-Reply-To: <20230801170015.40965-1-festevam@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CKmBG76A66lRswJw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 02:00:15PM -0300, Fabio Estevam wrote:
> As explained in the description text:
>=20
> "This is a list of trivial I2C and SPI devices that have simple device tr=
ee
> bindings, consisting only of a compatible field, an address and possibly =
an
> interrupt line."
> =20
> A camera device does not fall into this category as it needs other
> properties such as regulators, reset and powerdown GPIOs, clocks,
> media endpoint.
>=20
> Remove the OV5642 entry.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Removing it without re-adding it elsewhere does not seem right, since
there'll now be some undocumented compatibles in the tree, no?

> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 40bc475ee7e1..ab1423a4aa7f 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -313,8 +313,6 @@ properties:
>            - nuvoton,w83773g
>              # OKI ML86V7667 video decoder
>            - oki,ml86v7667
> -            # OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with O=
mniBSI and Embedded TrueFocus
> -          - ovti,ov5642
>              # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
>            - plx,pex8648
>              # Pulsedlight LIDAR range-finding sensor
> --=20
> 2.34.1
>=20

--CKmBG76A66lRswJw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMlvcAAKCRB4tDGHoIJi
0kYAAP0frR1hHHkqCch70fSRkgZ5/jGlWL0EURa+XUQhvWUmlAD8CJx7omm/YugB
S4qDWaxBiBRcUGZNACCf5GcGpKlHKgQ=
=vyl9
-----END PGP SIGNATURE-----

--CKmBG76A66lRswJw--
