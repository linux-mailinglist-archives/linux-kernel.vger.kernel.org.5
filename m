Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDFB7B0143
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjI0KFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjI0KF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:05:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB7612A;
        Wed, 27 Sep 2023 03:05:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3D2C433C7;
        Wed, 27 Sep 2023 10:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695809127;
        bh=qnrP8nXG0KaxINYqeddDcSnJIQu51tz/Syj8SawhtkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R68dpNLMbyY2PFKqG//gkhL0S9WMOiIJmABfcTzH+R3JKAUF6upvQaXIWnaqrUEw4
         bCfeBJjbBX3oA+6zTyJs9qxdoxoFuDiEDBOwY3bAWJ1iKsbuLXRT/1vYelgcK4Lt9g
         FSVFS1ndrTTZL7wiCnShwY/kRJ5eTvVE+pQCq8ONBhA/3QNm0gFRxtWqqDBaMJHlBB
         fYB/CzqOAnFN2oBTDLbwPPbRbT3gSRPLnTe+ciyASz6FDjSVexb7+n/c+dzot+imJB
         n2k/IP2NoLy7pyC0JgCi1ORtnrddd+8JD8Y/sMMN3ME9Ggp9n8hdSMYzCAu1AbMZvQ
         CN7Byr+An48Nw==
Date:   Wed, 27 Sep 2023 12:05:24 +0200
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
Message-ID: <ZRP+ZNXe975hcEJJ@finisterre.sirena.org.uk>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
 <ZRPvHJXbuZ9Db2Go@finisterre.sirena.org.uk>
 <CAMuHMdUv8FFwkde8K3Ta8FEWrkkJ=9ZqbTi1EO8sRxVOhGtvzQ@mail.gmail.com>
 <ZRP0MpIHf67tfQJY@finisterre.sirena.org.uk>
 <CAMuHMdWPxn=RTU6uytOp31BoXbW0m8Oxk_LM2Rp4Dtop7okWgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmWLiBkxLUwi0tfY"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWPxn=RTU6uytOp31BoXbW0m8Oxk_LM2Rp4Dtop7okWgQ@mail.gmail.com>
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


--nmWLiBkxLUwi0tfY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 11:44:17AM +0200, Geert Uytterhoeven wrote:
> On Wed, Sep 27, 2023 at 11:21=E2=80=AFAM Mark Brown <broonie@kernel.org> =
wrote:

> > I see.  Is there any control over what the chip select is when there is
> > one, in which case we could just look to see if there's one specified?

> On RZ/V2M there isn't, as there is only a single hardware chip select.

> On MSIOF, there are 3 hardware chip selects, but apparently only the
> primary one can be used in target mode.

OK, it sounds like we do need a property then.  Like I say I'd rather
not have one that just works for _NO_CS in order to avoid confusion for
people writing SPI device drivers, either something in the generic
target binding or a device specific one.

--nmWLiBkxLUwi0tfY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUT/mMACgkQJNaLcl1U
h9CZBgf8CVTnUG1s1acMFL5WiRrNlGR5yIFQa2lsoKcmtokW9X9Ik2Mh2pmOmltu
TClpq3pJH4F5hRMp79PVcaz6r5ILB8FMnqVq7ukwgYjN1KuE+FaSHNFbUDw0OQ8/
JoVJd7bdlrH0VM9zIlWFxIKuNkXOqbBGs9fVrertmsrVButeSJ2W7X2VSCAKO/cL
JkwbqE3qzYMdazyHfNOi1oY6DMflIP5s/LwA4nIk0Utn6YGPenkSoH1/w4pw4i9e
1g0Rs+immd11gI8xTKaF7/JYvd/cEEgQttjoGpvchX6Jo8UpkcguEslmCOkhxcla
/xbod6KEe+fkmjnwgGc14XHRR32lAw==
=Rd2y
-----END PGP SIGNATURE-----

--nmWLiBkxLUwi0tfY--
