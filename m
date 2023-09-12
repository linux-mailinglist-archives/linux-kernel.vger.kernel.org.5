Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8479D663
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbjILQe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjILQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:34:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D4CF;
        Tue, 12 Sep 2023 09:34:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF17EC433C7;
        Tue, 12 Sep 2023 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694536491;
        bh=26N9zTXAjfGotx0QgWazoqXDmTlLaPZTDqZavI3PM4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTPQWqAofqu9Mil3JbsonMznnQYYD4HFI202NYNDtEks8fhwHWrYfxl+18ExdXRRg
         Imy4YBqYjsmuFmuM6SMm81lrUVl9MIND+jX32oiSXaNnU6F6GL67X/Wk+AqCEoX0eb
         3hZXkOzVsE3BQAa1/Qsy2QSOx3JbdKH5SyFVmsfhPNObcjJE4dO6zsT2AdFib7Irrq
         amTBcFxnkGOwxPa6qQJhLYl8paqLzKxrKFzzmuhqlM2w2hIbcoVTdKK5voIa2tNByP
         MFXglduYImTkOq5FuXpHccIwOM98rOEN8EnoSgM9x8JIQIv7xa9noMRo4gdJG+Rj52
         Dvx8A6qubUWGQ==
Date:   Tue, 12 Sep 2023 17:34:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: nvmem: SID: Add binding for H616 SID
 controller
Message-ID: <20230912-frantic-ungreased-f9289c6dfdfc@spud>
References: <20230912-sid-h616-v3-0-ee18e1c5bbb5@somainline.org>
 <20230912-sid-h616-v3-1-ee18e1c5bbb5@somainline.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xeIZSk19Y+Pqw195"
Content-Disposition: inline
In-Reply-To: <20230912-sid-h616-v3-1-ee18e1c5bbb5@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xeIZSk19Y+Pqw195
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 02:25:12PM +0200, Martin Botka wrote:
> Add binding for the SID controller found in H616 SoC
>=20
> Signed-off-by: Martin Botka <martin.botka@somainline.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml | 4=
 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-=
sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.=
yaml
> index 296001e7f498..0928ec408170 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
> @@ -23,7 +23,9 @@ properties:
>        - const: allwinner,sun20i-d1-sid
>        - const: allwinner,sun50i-a64-sid
>        - items:
> -          - const: allwinner,sun50i-a100-sid
> +          - enum:
> +              - allwinner,sun50i-a100-sid
> +              - allwinner,sun50i-h616-sid
>            - const: allwinner,sun50i-a64-sid
>        - const: allwinner,sun50i-h5-sid
>        - const: allwinner,sun50i-h6-sid
>=20
> --=20
> 2.42.0
>=20

--xeIZSk19Y+Pqw195
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCTJQAKCRB4tDGHoIJi
0sSSAP46cISCC7/BgeOOlYd2Oh6RXSeJiPS/f7AsPFx9fvjIxQEAtAB/B4tYLm7P
u3NizZKXiIj6k9M+uuku43T5+cIOsgM=
=4685
-----END PGP SIGNATURE-----

--xeIZSk19Y+Pqw195--
