Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4197622E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGYUB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjGYUBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:01:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D481FFF;
        Tue, 25 Jul 2023 13:01:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017AB618CD;
        Tue, 25 Jul 2023 20:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C47C433C7;
        Tue, 25 Jul 2023 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690315281;
        bh=lwzgyo/hKAuFK/GizHWHih6d+oZtsu+UCV4ITL+g4X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrvRwTSL077Nhz2abeL01Pl1y5Rq3ZIGKTyA15Yk5lIHqflXYSmAf+nqBLIYPHEzx
         a8MWyRLwFC+YS1tlEKiB+fWJ6FLK6yJ6IEYceXAZwhmfp6djVDfP4x8cEmnqjSYdig
         qU6qH8X/47ooz+FIbb4yLDlz/UjMtIUGoHjdDE7T9RnpUMQ6s+vMio1PZ+n7rWvqTI
         gtXCqKTgriWfMH+6lP3p4Cd4gGmRYwB7Z1878yE5ZbWsREG8MF+cZoXxtNccdDKJyO
         mvJ65AnJTJdWs1i9qAu8FqfVBb1WtAgjakwNOJjswfVuy1bGQDHJQZrSH9EQtCB3MX
         sTc5OfTuyUwYg==
Date:   Tue, 25 Jul 2023 21:01:16 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: qca,ar803x: add missing
 unevaluatedProperties for each regulator
Message-ID: <20230725-suggest-juggle-c062521399f9@spud>
References: <20230725123711.149230-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ot+MAbhOrYmNPSVw"
Content-Disposition: inline
In-Reply-To: <20230725123711.149230-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ot+MAbhOrYmNPSVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 02:37:11PM +0200, Krzysztof Kozlowski wrote:
> Each regulator node, which references common regulator.yaml schema,
> should disallow additional or unevaluated properties.  Otherwise
> mistakes in properties will go unnoticed.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


> ---
>  Documentation/devicetree/bindings/net/qca,ar803x.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/qca,ar803x.yaml b/Docu=
mentation/devicetree/bindings/net/qca,ar803x.yaml
> index 161d28919316..3acd09f0da86 100644
> --- a/Documentation/devicetree/bindings/net/qca,ar803x.yaml
> +++ b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
> @@ -75,6 +75,7 @@ properties:
>      description:
>        Initial data for the VDDIO regulator. Set this to 1.5V or 1.8V.
>      $ref: /schemas/regulator/regulator.yaml
> +    unevaluatedProperties: false
> =20
>    vddh-regulator:
>      type: object
> @@ -82,6 +83,7 @@ properties:
>        Dummy subnode to model the external connection of the PHY VDDH
>        regulator to VDDIO.
>      $ref: /schemas/regulator/regulator.yaml
> +    unevaluatedProperties: false
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.34.1
>=20

--Ot+MAbhOrYmNPSVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAqDAAKCRB4tDGHoIJi
0pTaAP4xqWscNl1Z2K7dWlggYN0rr87fskelc5n8AGihPxrlWgEAlBqN8MbJJRlI
GgDx+30oEkC/nReimgsm95+i0bISdgU=
=UjTP
-----END PGP SIGNATURE-----

--Ot+MAbhOrYmNPSVw--
