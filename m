Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CAE79D68A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbjILQki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjILQkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:40:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A13110DF;
        Tue, 12 Sep 2023 09:40:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0067AC433C7;
        Tue, 12 Sep 2023 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694536833;
        bh=A5hJ7RKJaON9rED/+nFLDpLgZWvMB8+aB01tk0eVE3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SP1pRl0D385TaNkk1URK6N9hFj+7Yv6XDTxSa7NSh4wqFquUQq4uSxzrlcjiW3cCG
         6dU/0xE8U+2jp+t1gEca0BxL1y43z20oBuInovyKB/5/fgzduSWuyCqVlURE/4g5pw
         GcrfOKHJTM2CbXOs7QFOK3y9rDcUKUsFWDad4Xf5uJ78zYRRQN+yDXYWmfCJ2gxOon
         l3mwUH+BBOmiVWzLl55FZhO3+7tRP8pcm2mpmUBfLNCM4t0arD98o7zSRHq0H3bnb+
         4vIFrUApwhhyFUG7msbhrEfPSp5XJ6cqykmOixEerrBhU+Lj0sQBfQEnOsdZn0d9In
         MVRcxwU5LXkzA==
Date:   Tue, 12 Sep 2023 17:40:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Remove properties from required
Message-ID: <20230912-seventeen-reborn-48ec5bf5f053@spud>
References: <20230912081402.51477-1-william.qiu@starfivetech.com>
 <CAJM55Z_NjSVwCcS0MfHw3mAwsBuScAU0OXX1Ga1+TfQNHKB7Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cUk6S7kc0eLwyqAK"
Content-Disposition: inline
In-Reply-To: <CAJM55Z_NjSVwCcS0MfHw3mAwsBuScAU0OXX1Ga1+TfQNHKB7Vw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cUk6S7kc0eLwyqAK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 02:12:44AM -0700, Emil Renner Berthing wrote:
> William Qiu wrote:
> > Due to the change of tuning implementation, it's no longer necessary to
> > use the "starfive,sysreg" property in dts, so remove it from required.
>=20
> nit: again the device tree should be a description of the hardware, so the
> justification here shouldn't be that the Linux driver doesn't use the fie=
ld,
> but that it turns out the registers aren't required for the peripheral to=
 work
> properly. Don't respin the series just for this though.
>=20
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

The fact that I can't actually apply this without breaking bisection
kinda hints at removing it in this patch is incorrect.

>=20
> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.=
yaml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> > index 51e1b04e799f..553a75195c2e 100644
> > --- a/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
> > @@ -55,7 +55,6 @@ required:
> >    - clocks
> >    - clock-names
> >    - interrupts
> > -  - starfive,sysreg
> >
> >  unevaluatedProperties: false
> >
> > @@ -73,5 +72,4 @@ examples:
> >          fifo-depth =3D <32>;
> >          fifo-watermark-aligned;
> >          data-addr =3D <0>;
> > -        starfive,sysreg =3D <&sys_syscon 0x14 0x1a 0x7c000000>;
> >      };
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

--cUk6S7kc0eLwyqAK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCUewAKCRB4tDGHoIJi
0maDAQDgV2ZQDW92zUjexwzbV/uBoRBa5Xy3lJvdqgHjt/yJWQEAsUru3ltxVeL3
q3k/FIGMUjG4FUDAgSr0SRZjCtFKwwI=
=ZyML
-----END PGP SIGNATURE-----

--cUk6S7kc0eLwyqAK--
