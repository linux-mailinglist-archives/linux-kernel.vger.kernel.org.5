Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAD87D835F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbjJZNQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjJZNQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:16:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6DFAB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:16:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8796C433C9;
        Thu, 26 Oct 2023 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698326204;
        bh=K9OAFyz+7TNreG16Cevm17Kt9VFkMRVq0eOtrmSO5Ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Om7zOqYTp6V3XsoLvP5+ArLRL0sJbOrEYW8ljitfiu3783rlKacY152DZWCbdtjuk
         ECyj1VAA7nymvEW0jgdbbUFcxxuKitjKcLe+o14HTW70Rrnmxx/CbCdvz21CY6Mhrw
         zacgjzBdcy+dGT73FVndVFz5aSg6FY/d7Zs99nyFXE8OoPvR0AD0/M8WSTTuP0I90Y
         Gy93YXEl2xEvrRaBEKx3HgA5vlsi5FoGxZ5S9XFogMaEOqy0qDeC50DEygXxiFIMAv
         Uwdtdbc8z7NrxmjY9JtNAdGlqMhzwfhk2Y1B5rjuipx6E7OlDI2nF84mNsRclO5I2m
         6490aI19k4F/A==
Date:   Thu, 26 Oct 2023 14:16:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 3/4] dt-bindings: cache: sifive,ccache0: Add
 sifive,cache-ops property
Message-ID: <20231026-cupcake-smashing-eb150e74a17c@spud>
References: <CAJM55Z8DXDs6LT0JrTyEMp8V6BHvsjUW7aJ8Gj+fRGsasHAi_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hRUnr5j1rWZpVzgz"
Content-Disposition: inline
In-Reply-To: <CAJM55Z8DXDs6LT0JrTyEMp8V6BHvsjUW7aJ8Gj+fRGsasHAi_A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hRUnr5j1rWZpVzgz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Emil,

On Wed, Oct 25, 2023 at 11:56:41AM -0700, Emil Renner Berthing wrote:
> This cache controller also supports flushing cache lines by writing
> their address to a register. This can be used for cache management on
> SoCs with non-coherent DMAs that predate the RISC-V Zicbom extension
> such as the StarFive JH7100 SoC.

I'm not really sure why we need the flag, is it not sufficient to
register the cache ops on a per-compatible basis? At least for the
jh7110, you're always going to want them, otherwise your system is going
to be largely non-functional, right?

>=20
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> index 7e8cebe21584..36ae6f48ce0b 100644
> --- a/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> +++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
> @@ -81,6 +81,11 @@ properties:
>        The reference to the reserved-memory for the L2 Loosely
> Integrated Memory region.
>        The reserved memory node should be defined as per the bindings
> in reserved-memory.txt.
>=20
> +  sifive,cache-ops:
> +    type: boolean
> +    description: |

and this | is not required btw, since there's no formatting here that
would need to be preserved.

Cheers,
Conor.

> +      Use this cache controller for non-standard cache management operat=
ions.
> +
>  allOf:
>    - $ref: /schemas/cache-controller.yaml#
>=20
> --=20
> 2.40.1

--hRUnr5j1rWZpVzgz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTpmuAAKCRB4tDGHoIJi
0vG1AQD9Fhze9QKqj00P+zguWQSroVY9G3kMiTWghXQbNb9PoAD/bQUYVQNgsLE2
5yEvG+pxv0JoZjPqvCdpwD909s1ZAQ0=
=1ovc
-----END PGP SIGNATURE-----

--hRUnr5j1rWZpVzgz--
