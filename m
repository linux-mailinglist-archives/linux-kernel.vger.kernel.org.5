Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCF47D6770
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjJYJsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjJYJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:48:16 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FCD9D;
        Wed, 25 Oct 2023 02:48:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 399E2C0012;
        Wed, 25 Oct 2023 09:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698227290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1k2YPUzWcOkEagcDThcHO9wlMohvRnn0bjyNb8MXgl0=;
        b=LTvFjk7ru7UkIs9uW/KET6ghc50QAERqTyVRBn2khbb2K7m4F49+ChD2Azxt9feWIyQb2T
        vJwtrXSaA7BMxp0cpTuB1L+6khhVbMYWIhlMGwH+c9yGOzqhfAHLKFk5LyrafZMIiuS6/8
        XQlcV2xRb4lzS0UhDzyOBQc7cBmkhHiG28Ytdqm2FF2KPM7w0yRVD8mNyBt2FMzfHWZTQL
        Uvsw7y3E3wGqUfMGCx3S6LjTOUZ7NlIF4YJwaQ0bpM1aFPxoQ1Gx/Q2BSwYLVrBPr6M+w5
        K4Dj6pFCie03LwOpfeIA60So2qTBctC8eqdZ9F4ypOdHw8UAubUPyRE6RLOGtg==
Date:   Wed, 25 Oct 2023 11:48:08 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH v8 2/3] media: rockchip: Add a driver for Rockhip's
 camera interface
Message-ID: <ZTjkWIbhV0OsvepD@aptenodytes>
References: <cover.1697446303.git.mehdi.djait@bootlin.com>
 <3790470ff7606fc075ec742d43254e52dde5d120.1697446303.git.mehdi.djait@bootlin.com>
 <ee4034b9-85f6-42cc-abca-d61004aa0a6c@wolfvision.net>
 <ZTjWsf69QdXoJNKj@aptenodytes>
 <a57db26a-704f-4859-a528-26d87c555576@wolfvision.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fBirLtQySHnjwSRc"
Content-Disposition: inline
In-Reply-To: <a57db26a-704f-4859-a528-26d87c555576@wolfvision.net>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fBirLtQySHnjwSRc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Michael,

On Wed 25 Oct 23, 11:38, Michael Riesch wrote:
> Hi Paul,
>=20
> On 10/25/23 10:49, Paul Kocialkowski wrote:
> > Hi,
> >=20
> > On Mon 23 Oct 23, 15:28, Michael Riesch wrote:
> >> Typo in the subject: "Rockhip's" -> "Rockchip's"
> >> I think this typo has been in there for a while now ;-)
> >=20
> > Great hips make for great dancing!
>=20
> ...to rock music, obviously.

:)

> > [...]
> >>> +#define write_vip_reg(base, addr, val)  writel(val, (addr) + (base))
> >>> +#define read_vip_reg(base, addr) readl((addr) + (base))
> >>
> >> Please provide those helpers as proper inline functions. As to the
> >> naming, the "_reg" suffix seems unnecessary.
> >>
> >> Alternatively, you could consider converting the driver to use regmap.
> >=20
> > Come to think of it, I feel like it would make more sense to have an in=
line
> > function which is given a struct rk_vip_device instead of having to der=
eference
> > it every time in the caller to access the base address.
>=20
> Indeed. Either using regmap, e.g.,
>=20
> int regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
>=20
> or something equivalant
>=20
> static inline int cif_write(struct cif_device *device, unsigned int reg,
> unsigned int val);

Looks good to me!

> Not sure what you agreed on in terms of a method prefix. The Rockchip
> RGA driver uses "rga_something", the Rockchip ISP driver uses
> "rkisp1_something". This would mean either "cif_something" or
> "rkcif_something", right?

Yeah I don't really have strong opinions on this so I'll let Mehdi decide
(as long as it's consistent everywhere in the code).

I guess there is a slight readability advantage in using "cif_" instead of
"rkcif_".

> > [...]
> >>> +	struct rk_vip_sensor_info	sensor;
> >>
> >> Using "sensor" as name does not seem correct. As pointed out above it
> >> could be a video decoder just as well. Something with "subdevice" mayb=
e?
> >=20
> > Agreed. I suggest renaming the struct "rk_vip_sensor_info" -> "rk_cif_r=
emote"
> > and just calling the member "remote".
>=20
> "remote" sounds reasonable. Prefix to be bikeshedded, see comment above.
>=20
> In the future, we may add an array with mipi_remotes that represents the
> subdevices attached wia MIPI CSI-2.

Sounds good!

Thanks,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--fBirLtQySHnjwSRc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmU45FgACgkQ3cLmz3+f
v9FojAf+IytRfPPzjE8k2tDfOt43W+J5DlDw5ygYN5c877ywwBi+bZDgapHTZWo6
arsbbgPIJqQpb7mz3bHRTzzm8COFbFO6PWrO0WKVGB6Rzm/N0kSY9rN4GGpgbT+2
ZA7eIWJ8eJza0pfp2JG/MYBznMFCuiJhta/j+4Hgz3iQH9h64UKycPfl+eiWZdZD
SaEc07LkpYZZIOrPZtGVQKDiAqQX5lrCyA5YhadGs+P1BVukq2yTSM/O5nk4N8ds
1AR6hRVMy65rGrSLagXj0enP1GFYPDoYLFRO4lfbh/CU0yriNtSkecyz2k9q4NgW
NPRaBti9VhIeNutHheCCKZyoeWPBEA==
=zaqo
-----END PGP SIGNATURE-----

--fBirLtQySHnjwSRc--
