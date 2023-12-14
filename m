Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5781361C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjLNQXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLNQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:23:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B647B112
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:23:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A04C433C8;
        Thu, 14 Dec 2023 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702571033;
        bh=i9cOYx/Gayn1zgR+NrAJh8IzX0ZjGHvQDZb6Hpxnipo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAa61Vz1CS4IUtt7zsP4Cre/tCNw+loHnsPAbhOM3KapWjC9d+uQ+yF5C4Pw5+L51
         xB0UWCLEaYPgbp0vyePULtL9N/X0QNnM0ou0RjK4tqu18067LjrN+W8zU0f0EDx71h
         kWyuXlhsw9LOtyCcFboBMvNXkaVAjlHSiMJuZb7fR/LJ37yjOrDjKkH8Vz/+vc5hDk
         +YxZ8bB5sqEYCsMNUiNyUukhX1IsRHcFg3u8xUYNXx+SUD8euLturiXSEGA9DLz9Wm
         wiiT15ijd4cNaJ34S6Dh1davDIfUSsjLUhoaXe/k+ht5gIdFeDQEOC4dp0ZGqhzyeK
         GH2xfDXrcUsFQ==
Date:   Thu, 14 Dec 2023 16:23:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: marvell,orion-mdio: Drop
 "reg" sizes schema
Message-ID: <20231214-buzz-playlist-2f75095ef2b0@spud>
References: <20231213232455.2248056-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="egZ0O0hNuZugmFUi"
Content-Disposition: inline
In-Reply-To: <20231213232455.2248056-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--egZ0O0hNuZugmFUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 05:24:55PM -0600, Rob Herring wrote:
> Defining the size of register regions is not really in scope of what
> bindings need to cover. The schema for this is also not completely correct
> as a reg entry can be variable number of cells for the address and size,
> but the schema assumes 1 cell.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Does this not also remove restrictions on what the number in the reg
entry is actually allowed to be?

> ---
>  .../bindings/net/marvell,orion-mdio.yaml      | 22 -------------------
>  1 file changed, 22 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/marvell,orion-mdio.yam=
l b/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
> index e35da8b01dc2..73429855d584 100644
> --- a/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
> @@ -39,28 +39,6 @@ required:
>  allOf:
>    - $ref: mdio.yaml#
> =20
> -  - if:
> -      required:
> -        - interrupts
> -
> -    then:
> -      properties:
> -        reg:
> -          items:
> -            - items:
> -                - $ref: /schemas/types.yaml#/definitions/cell
> -                - const: 0x84
> -
> -    else:
> -      properties:
> -        reg:
> -          items:
> -            - items:
> -                - $ref: /schemas/types.yaml#/definitions/cell
> -                - enum:
> -                    - 0x4
> -                    - 0x10
> -
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.43.0
>=20

--egZ0O0hNuZugmFUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXssFAAKCRB4tDGHoIJi
0pixAPwNgOnRCXWNYCkXX0M7j++l5pDAq9K5Z0tCgSSn1UjfvwEAiqBUm+qx9bhF
d1itS4+VsRTjBeGiiR5fJiry2jVTtQs=
=sfO/
-----END PGP SIGNATURE-----

--egZ0O0hNuZugmFUi--
