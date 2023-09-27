Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB597AFFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjI0JWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjI0JV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:21:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C4A3;
        Wed, 27 Sep 2023 02:21:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E62C433D9;
        Wed, 27 Sep 2023 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695806517;
        bh=I448svr5ZDYp4rTesI5QISMQCcJhofO8M8peXBBCVFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cpKxZGCHxET7gWuWcExH6CsMZ9pfGLXCTxYP/6YtBpQYujCM4n+xPTZfWZt+hhP0+
         NXnwHc+pAdxCGnMaHqG/Fe0XfyZ7hnrvR9yUvw5WO7wnbI2+AAbR5mEarzdMpY4ZrU
         Q29GnboTaxtoij/admCVD36krYP8urbjTRMsMmGABzccsys3ZA/Ny0/47irocy/c1H
         kwy9x7vYNoO9GgSvezOMjMyX1J+5JH9ldG3965MD6GB6quP81N1kV3L5vIp+dYPh66
         aRBHYrFHWg5mxLkDxWgfrWMMQpw32GaL4V4LoXSvjgjHS40bbRBm3cj0Mf5hKGUQu9
         2N2HvVBwnyXrA==
Date:   Wed, 27 Sep 2023 11:21:54 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
 properties
Message-ID: <ZRP0MpIHf67tfQJY@finisterre.sirena.org.uk>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
 <ZRPvHJXbuZ9Db2Go@finisterre.sirena.org.uk>
 <CAMuHMdUv8FFwkde8K3Ta8FEWrkkJ=9ZqbTi1EO8sRxVOhGtvzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pm+YXDPO8WF2t5nM"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUv8FFwkde8K3Ta8FEWrkkJ=9ZqbTi1EO8sRxVOhGtvzQ@mail.gmail.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pm+YXDPO8WF2t5nM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 11:10:58AM +0200, Geert Uytterhoeven wrote:
> On Wed, Sep 27, 2023 at 11:00=E2=80=AFAM Mark Brown <broonie@kernel.org> =
wrote:

> > The description is clearly saying there is a chip select, _NO_CS seems
> > entirely inappropriate.  It's not specified in the device tree because
> > when there's no chip select for a device it's a fundamental property of
> > how the device is controlled and we don't need any information beyond
> > the compatible.

> In host mode, it indeed doesn't matter, as you can have only a single
> device connected with SPI_NO_CS.
> In device mode, the device needs to know if it must monitor the chip
> select line or not.

> In hindsight, I should have kept the question I had written initially,
> but deleted after having read the documentation for the corresponding
> RZ/V2M register bits:

>     What does it mean if this is false? That there is no chip select?

> So "spi-no-cs" would be the inverse of "renesas,csi-ss".

I see.  Is there any control over what the chip select is when there is
one, in which case we could just look to see if there's one specified?

I'm a bit nervous about a generic property that maps onto _NO_CS since
it's likely that people will start using that in device bindings when
they shouldn't.

--Pm+YXDPO8WF2t5nM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUT9DIACgkQJNaLcl1U
h9AoWgf8C4m4QGJxKqU2uTMR2OZGAiTjBvZPPRlWk3tOi86FMNdl2y3nyWSLo8Xn
wX09m6jOWe9hdlXxeP865u3KMrDvVsHaL8wF8T7jNQc4h7LwGdE2PxsjvWEXS9qL
301JwbJPnR0u3DMoCfv6QzfDsJdw3BWhMgjYsA5fid0cnOjY1BENubwtg5egP5qB
0XbxeqK6/6GGtLIVl4IVobJaJbt76H5jKvXrqUNVskKQg+FfxA2yE6aWRoAcGbVn
lQ09uL2W6G57XFRq9r4/R2y9AJWNgFeVmzpKsPSEiA/Yzd6RUHU/UN6mqAKNHgAi
VUZMiQi/SpBI7EqDkS/x22F4sENSAw==
=CrDz
-----END PGP SIGNATURE-----

--Pm+YXDPO8WF2t5nM--
