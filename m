Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0B979D685
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbjILQjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjILQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:39:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51398115;
        Tue, 12 Sep 2023 09:39:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D81C433C7;
        Tue, 12 Sep 2023 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694536782;
        bh=iIgQaIkZ2NodE34d4bE3iprG8w+h+eA+RXmUuBgooEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixhx0siWJ6pbfZX21c4X9mWnfIur+kAOFoUXfDX25ZgloNQjFfipyLjGIKYpP1gB+
         6IH1O2IslQPT556dIODXA2/ow2G4ACMYV8IFSZHxciJlTR7Hrlp7xl+xLZ7f62FPP5
         BbL9OUL21yNn1Qf3rRoO19NxLVqQixGg3GD7vizsmAur7sdd/xlRIvBgWGx70WyDSj
         IogMpY5QToypoN3aH/AnGnkk8b6K/MSCt8vJHJlTJPLHmvo2imMaPYkSrHNKU7npGn
         vVjKL8nY2Md/Z5bu+ZLj2mVJ/3krGcldaHdnqKF/okEGfW3pBOVccU3ga1SZnccBvf
         FiqVkjM7LDLkA==
Date:   Tue, 12 Sep 2023 17:39:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: Remove properties from required
Message-ID: <20230912-jailer-whole-41875e57a298@spud>
References: <20230912081402.51477-1-william.qiu@starfivetech.com>
 <20230912081402.51477-5-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h9UcmCWcT6OWVQ3V"
Content-Disposition: inline
In-Reply-To: <20230912081402.51477-5-william.qiu@starfivetech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h9UcmCWcT6OWVQ3V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 04:14:00PM +0800, William Qiu wrote:
> Due to the change of tuning implementation, it's no longer necessary to
> use the "starfive,sysreg" property in dts, so remove it from required.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

$subject probably should be more specific about what binding is being
modified.
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.ya=
ml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> index 51e1b04e799f..553a75195c2e 100644
> --- a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> @@ -55,7 +55,6 @@ required:
>    - clocks
>    - clock-names
>    - interrupts
> -  - starfive,sysreg
> =20
>  unevaluatedProperties: false
> =20
> @@ -73,5 +72,4 @@ examples:
>          fifo-depth =3D <32>;
>          fifo-watermark-aligned;
>          data-addr =3D <0>;
> -        starfive,sysreg =3D <&sys_syscon 0x14 0x1a 0x7c000000>;
>      };
> --=20
> 2.34.1
>=20

--h9UcmCWcT6OWVQ3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCUSQAKCRB4tDGHoIJi
0l5dAQDG9Uyg44/spYOTktXTqx5C02wOIIDlOOSA0mMIykDLtAEAgYHAdwhbEfP7
4MOV5k39/w6IRjAqcD3Hl10cLYsAZQY=
=TfmZ
-----END PGP SIGNATURE-----

--h9UcmCWcT6OWVQ3V--
