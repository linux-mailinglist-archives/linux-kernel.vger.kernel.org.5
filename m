Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365CF76EEBE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbjHCPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHCPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:55:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491F63A96;
        Thu,  3 Aug 2023 08:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBEF261E27;
        Thu,  3 Aug 2023 15:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4FCC433C7;
        Thu,  3 Aug 2023 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691078149;
        bh=+eLMOgUF23VOAMlLhbEH8z/Tx50XNFh55UmE12N2s24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l3c00lWZrHC+bF3zJo6joDD0EoyFvaiTRs/WX0BHeplrdxVRe59qcJWNVcNil+XBh
         ePTo/tOO9X0avsLtrZA8L+mGp+uy7Hf3CRpqz/i1pY0dhfH3WgI4BC4ZQDSE16zDoA
         XKYjxdaCf9IFLHgxhos2BgG2xVEFGeoHrXWXMjXffj3hK9YlUAHdPTfTJSrWvHi8h3
         I9Y8a506y7tl6n+WDvAKgfmK+cte10Xff5AbiAQTNXrvzpv7yGm6M/j/BQJ6K2Y1q7
         gDn6sC6IVtKOUBdWbbgw3xkiF0M/SHpoUopdaVTwAAvoz92HkN5P6w3kfK+UPJLIRE
         lQlbxkocJCyTg==
Date:   Thu, 3 Aug 2023 16:55:44 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Shengyu Qu <wiagn233@outlook.com>,
        Martin Botka <martin.botka@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: make interrupt
 optional for more chips
Message-ID: <20230803-sterilize-dollar-2cb4fdd0a050@spud>
References: <20230802141829.522595-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uOlktQ89PMiAkitZ"
Content-Disposition: inline
In-Reply-To: <20230802141829.522595-1-andre.przywara@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uOlktQ89PMiAkitZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 03:18:29PM +0100, Andre Przywara wrote:
> All X-Powers PMICs described by this binding have an IRQ pin, and so
> far (almost) all boards connected this to some NMI pin or GPIO on the SoC
> they are connected to.
> However we start to see boards that omit this connection, and technically
> the IRQ pin is not essential to the basic PMIC operation.
> The existing Linux driver allows skipping an IRQ pin setup for some
> chips already, so update the binding to also make the DT property
> optional for these chips, so that we can actually have DTs describing
> boards with the PMIC interrupt not wired up.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
> Hi,
>=20
> arguably the IRQ functionality is optional for many more PMICs,
> especially if a board doesn't use GPIOs or a power key.
> So I wonder if the interrupts property should become optional for all?
> After all it's more a board designer's decision to wire up the IRQ pin
> or not, and nothing that's really related to a particular PMIC.

No ack for this, but if the things function without the interrupts
wired up, it seems like it'd make sense to drop others too.

Cheers,
Conor.

>=20
> Cheers,
> Andre
>=20
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b=
/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> index 9ad55746133b5..06f1779835a1e 100644
> --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> @@ -67,7 +67,10 @@ allOf:
>          properties:
>            compatible:
>              contains:
> -              const: x-powers,axp305
> +              enum:
> +                - x-powers,axp15060
> +                - x-powers,axp305
> +                - x-powers,axp313a
> =20
>      then:
>        required:
> --=20
> 2.25.1
>=20

--uOlktQ89PMiAkitZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvOAAAKCRB4tDGHoIJi
0vchAP0WN3dNW+wtwRvHlYKec0m0wG4PEwTYWc4LQtyduziiBAD+IXzDW5CKznDO
2OAoiXm3sKS4XSn1edXvKDqX2l/gNwk=
=XJ08
-----END PGP SIGNATURE-----

--uOlktQ89PMiAkitZ--
