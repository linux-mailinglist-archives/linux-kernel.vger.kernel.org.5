Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74737B01C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjI0KZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI0KYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:24:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBFFCF4;
        Wed, 27 Sep 2023 03:23:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD11C433C7;
        Wed, 27 Sep 2023 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695810213;
        bh=mJtkcoqAxjc3capOnsYp/Ti3db2yjrAid5Uj7rgquYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQ9ZoLYPAOcGdFlIzX7JdymQVx3fL2BNysG9Ry+JkQAVBnVz/pwO2aFE2WYKOAwrr
         k8mlfs9Ga7f6h1BC/igfCBLh9QrrIXnyjg83ujenCmhNour0TIbsK7viHMYNp0oO53
         b1CLzyZA2F1obO6tv5UDXUaohmt8ucVsgUVrcfB2CdZe7e0q5kPXCe8WxvS1pIgoeU
         CyhUDp4lxRMELKWNEOrUjiA753FvvRyYRJUPk6waiVtewxvFXwysd7D+U25AkY2Yly
         aDDx365GMO0SVNhlthr6fiEaAG7KBdz6FQEBujmrHTZ23ywUQ6FwPypbohm0RktKEL
         l6kiAZQAJnVLQ==
Date:   Wed, 27 Sep 2023 12:22:59 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] spi: renesas,rzv2m-csi: Add SPI Slave related
 properties
Message-ID: <ZRQCg6Xf/wYfC2PD@finisterre.sirena.org.uk>
References: <20230926210818.197356-1-fabrizio.castro.jz@renesas.com>
 <20230926210818.197356-2-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUibHxPBCLbeWdNrEk_szm+o4cOcskEMZAqUufNTzQKMQ@mail.gmail.com>
 <ZRPvHJXbuZ9Db2Go@finisterre.sirena.org.uk>
 <CAMuHMdUv8FFwkde8K3Ta8FEWrkkJ=9ZqbTi1EO8sRxVOhGtvzQ@mail.gmail.com>
 <ZRP0MpIHf67tfQJY@finisterre.sirena.org.uk>
 <CAMuHMdWPxn=RTU6uytOp31BoXbW0m8Oxk_LM2Rp4Dtop7okWgQ@mail.gmail.com>
 <ZRP+ZNXe975hcEJJ@finisterre.sirena.org.uk>
 <TYWPR01MB8775B9F9F70CA75410788F83C2C2A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wJt9p1k0SYjlzPnn"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB8775B9F9F70CA75410788F83C2C2A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
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


--wJt9p1k0SYjlzPnn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 27, 2023 at 10:18:57AM +0000, Fabrizio Castro wrote:
> > From: Mark Brown <broonie@kernel.org>

> > OK, it sounds like we do need a property then.  Like I say I'd rather
> > not have one that just works for _NO_CS in order to avoid confusion
> > for
> > people writing SPI device drivers, either something in the generic
> > target binding or a device specific one.

> Shall I invert the logic then? What I mean is I could drop property
> "renesas,csi-ss" and add property "renesas,csi-no-ss" instead, therefore
> without "renesas,csi-no-ss" pin SS will be used, with "renesas,csi-no-ss"
> pin SS won't be used.
> What do you think?

That sounds fine for me, I guess we could add a further property if some
new IP allows multiple options for the chip select in target mode.

> Also, I could drop "renesas,csi-ss-high" and use "spi-cs-high" instead?

I think that's OK but I looked less at that bit.

--wJt9p1k0SYjlzPnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUUAoIACgkQJNaLcl1U
h9BenQf/T5TRoV+paJzdI1UKZ9rbSIu9tmoNiCO+wN1CocdXkQTHXMnL2+7uo8Ww
olbvVZYkep2xoEplvaH+cvqqlo+tXkyikqcYVph9nAJhvYx3T8gu0AFlKi2JBGrm
FCziMUNMVRCdvTseCf1oLzbidaWHDoJJOOYcIiCwd+HINYQ1jx5ZdbWDaprGaRaT
SfkqMEMbOfBxeeXri1O/PQq8piU8il35ms9fi0j1Gfsu3qLuYMNPc9otNzS++e9G
jytCxVYn8C1Hyy6Cdk2GVZIIpjj32fFKkVb/KUeQRxHbR9O0aFhTCpF8K8BS4Ckv
BR0pk5tdVoAE8xKxHL5PIegeIZe9hQ==
=+JaN
-----END PGP SIGNATURE-----

--wJt9p1k0SYjlzPnn--
