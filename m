Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9007ED65B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbjKOVzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjKOVzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:55:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FDA199;
        Wed, 15 Nov 2023 13:55:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F554C433C8;
        Wed, 15 Nov 2023 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700085308;
        bh=6FPkdmASCVL9BjatyPPFNez/SmMwVn+Df5pcKuTZyO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+216bj8TImuQwGVZmJWMvUAJ1rJqm3cmUC50XeRID0REBiqBC32jkdnD30aN959c
         fDe4iHCsYLQTJ+sg7Glxn/gkjJoq+PwkDBTij2N4izF7ojFlw9TSUleHtxbvVqpRdl
         GsSf4ZUVrWBxv4aINzDVpIsVSRbtK4mlRL49q6fueLPkM7AywfWnvygQkwKT5iepYC
         8cKFdSda6qGRBiHcfOScT9cbRPL4sTthMjju5lDOJaY0RnrS6aMqX8ANU7KO67GcJg
         aGCea0UWbM0N9bRIGku7TDRDAt43cuoaCm7yGbXCVkYJClBEI9isEstZJhIqfOUsiM
         tqef1SlN4fsSg==
Date:   Wed, 15 Nov 2023 21:55:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,sci: Document RZ/Five SoC
Message-ID: <20231115-vineyard-cartload-91c28009a2d8@squawk>
References: <20231115212431.32872-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AJiWvaDVJmb9d83n"
Content-Disposition: inline
In-Reply-To: <20231115212431.32872-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AJiWvaDVJmb9d83n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:24:31PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The SCI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-sci" compatible string will be used on the RZ/Five
> SoC so to make this clear and to keep this file consistent, update the
> comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string "renesas,sci"
> will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/serial/renesas,sci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci.yaml b/=
Documentation/devicetree/bindings/serial/renesas,sci.yaml
> index 9f7305200c47..64d3db6e54e5 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci.yaml
> @@ -17,7 +17,7 @@ properties:
>      oneOf:
>        - items:
>            - enum:
> -              - renesas,r9a07g043-sci     # RZ/G2UL
> +              - renesas,r9a07g043-sci     # RZ/G2UL and RZ/Five
>                - renesas,r9a07g044-sci     # RZ/G2{L,LC}
>                - renesas,r9a07g054-sci     # RZ/V2L
>            - const: renesas,sci            # generic SCI compatible UART
> --=20
> 2.34.1
>=20

--AJiWvaDVJmb9d83n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVU+NQAKCRB4tDGHoIJi
0ujNAQCPEOKBixWaz5gdxaw0aG9OqkCq4DoE9oxF8EEJfn5btwEAvX4sT2aXb7cP
WSwF8KqiKJbG60crl1EtXMVJsRhpGwk=
=gtzN
-----END PGP SIGNATURE-----

--AJiWvaDVJmb9d83n--
