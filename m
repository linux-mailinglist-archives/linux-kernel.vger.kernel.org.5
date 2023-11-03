Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D10E7E031B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346251AbjKCMq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:46:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B070184;
        Fri,  3 Nov 2023 05:46:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8CEC433C7;
        Fri,  3 Nov 2023 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699015581;
        bh=it+Ur90waa0oim08aoAhpIaY4KZFUL1HCU6OwZvCS/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OhSq3YzN9otpUbZjupxrkxUum2SOI8/ixCfg/TcXthjyIqz0QXU67ZZyjbiXUUtIH
         xi8mjd9LTIIXG3VSv8aO+mG3v6ouLi3QmJuaT+yny3JqPH/HIwJ79WAmCTO6EE9Ywl
         /H0blyzj93vLYrG3WkxWWdrbtzZ51SyzT30t4S2d+br46+Tp8zhv4P1h3EiuSB4wle
         nPpmb4jhJ8TkiZKdoPcx/NQzWRepNeO7S8BYA2si+AiOWW+ewRZNVT11+w6gQKyIvk
         kWCMzuZM2g9tcH3kJzj9NkiUPhS8OIfFMxreT28Q8yKSL7LP5U2oAQkSQiM9uPvxAo
         q8We0ynRvRMCQ==
Date:   Fri, 3 Nov 2023 12:46:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/Five SoC
Message-ID: <20231103-depress-dispersed-c5965a853c8a@spud>
References: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d4uRiJ5fk19L4hXt"
Content-Disposition: inline
In-Reply-To: <20231102203922.548353-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d4uRiJ5fk19L4hXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 08:39:22PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The DMAC block on the RZ/Five SoC is identical to one found on the RZ/G2UL
> SoC. "renesas,r9a07g043-dmac" compatible string will be used on the
> RZ/Five SoC so to make this clear, update the comment to include RZ/Five
> SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rz-dmac" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b=
/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> index c284abc6784a..a42b6a26a6d3 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> +++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
> @@ -16,7 +16,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> -          - renesas,r9a07g043-dmac # RZ/G2UL
> +          - renesas,r9a07g043-dmac # RZ/G2UL and RZ/Five

Possibly the most unnecessary ack I've given to date, but
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>            - renesas,r9a07g044-dmac # RZ/G2{L,LC}
>            - renesas,r9a07g054-dmac # RZ/V2L
>        - const: renesas,rz-dmac
> --=20
> 2.34.1
>=20

--d4uRiJ5fk19L4hXt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUTrmAAKCRB4tDGHoIJi
0gzIAP9omTAPzecIsVU2EmGnnXwI4uLH2ZAEbuainbbgWH4eYQD7BEzDVcYB3ioD
IcCHf+Ye7G5eM1gLWF6LWdJTEmfi9wg=
=NqOm
-----END PGP SIGNATURE-----

--d4uRiJ5fk19L4hXt--
