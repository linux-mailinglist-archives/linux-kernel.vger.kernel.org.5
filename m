Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA40F7E8225
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjKJTDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbjKJTDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:03:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B89B4131D;
        Fri, 10 Nov 2023 10:24:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F8CC43391;
        Fri, 10 Nov 2023 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699640650;
        bh=5Cnpf5r8iWd0CmH6dX7jzJeU1NDBsOBBm+7XS06qRkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tl1FHn9hBWjpY5JhlH9QfJvHRjysmHUYI0IjLduVnMIZYgJjZyr+sfk/ZZhdvI1hY
         h5IH4BGndC7iBLeafXSLZofUqqxdJeg1WB0g1mF+/i/6loaSJ9RiUlNg8+AehwaBgo
         g5+3x0gzZnSYhyDNNQpV7OPDowLc8aeIsNOZWDMo46xRi8PzY7a4vrGeRkqvbZa4xD
         glIfoymeiQUIJhSne9NO7q648Bd0oOjNC+dMfyyEpcPKRjnlKU+shMdZhy1WWA1JaP
         r9HnBciKjvR1NFqHIGGKSIcgNKsS0eAkYzwE1KilKGVyHTHDXJUiEwbL2V+JyTiLdZ
         5gajgwpeUimZQ==
Date:   Fri, 10 Nov 2023 18:23:57 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, michael.riesch@wolfvision.net
Subject: Re: [PATCH v10 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Message-ID: <20231110-appetizer-fame-2152806c7442@roley>
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <037bcabf97294d37b271537e4b11fb88cf9bb6f6.1699460637.git.mehdi.djait@bootlin.com>
 <20231109-closable-superglue-5e7f39739cf1@spud>
 <ZU0avuRRaITV4jws@aptenodytes>
 <e5b1f0dd-0aab-4ce5-82ba-879a4d736e7e@linaro.org>
 <ZU0f33clFwlsTw16@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tkoOwTNqqLjvCZ6v"
Content-Disposition: inline
In-Reply-To: <ZU0f33clFwlsTw16@aptenodytes>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tkoOwTNqqLjvCZ6v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 07:07:27PM +0100, Paul Kocialkowski wrote:
> On Thu 09 Nov 23, 18:53, Krzysztof Kozlowski wrote:
> > On 09/11/2023 18:45, Paul Kocialkowski wrote:
> > > On Thu 09 Nov 23, 17:24, Conor Dooley wrote:
> > >> On Wed, Nov 08, 2023 at 05:38:56PM +0100, Mehdi Djait wrote:
> > >>> Add a documentation for the Rockchip Camera Interface binding.
> > >>>
> > >>> the name of the file rk3066 is the first Rockchip SoC generation th=
at uses cif
> > >>> instead of the px30 which is just one of the many iterations of the=
 unit.
> > >>
> > >> I think this is becoming ridiculous. You've now removed the compatib=
le
> > >> for the rk3066 but kept it in the filename. I don't understand the
> > >> hangup about naming the file after the px30-vip, but naming it after
> > >> something that is not documented here at all makes no sense to me.
> > >> Either document the rk3066 properly, or remove all mention of it IMO.
> > >=20
> > > I think the opposite is ridiculous. We have spent some time investiga=
ting the
> > > history of this unit, to find out that RK3066 is the first occurence =
where
> > > it exists. Since we want the binding to cover all generations of the =
same unit
> > > and give it a name that reflects this, rk3066 is the natural choice t=
hat comes
> > > to mind. As far as I understand, this is the normal thing to do to na=
me
> > > bindings: name after the earliest known occurence of the unit.
> > >=20
> > > What is the rationale behind naming the file after a generation of th=
e unit
> > > that happens to be the one introducing the binding? This is neither t=
he first
> > > nor the last one to include this unit. The binding will be updated la=
ter to
> > > cover other generations. Do we want to rename the file each time an a=
 generation
> > > earlier than px30 is introduced? That sounds quite ridiculous too.
> > >=20
> > > We've done the research work to give it the most relevant name here.
> > > I'd expect some strong arguments not to use it. Can you ellaborate?
> >=20
> > If you do not have rk3066 documented here, it might be added to entirely
> > different file (for whatever reasons, including that binding would be
> > quite different than px30). Thus you would have rk3066 in
> > rockchip,rk3066-cif-added-later.yaml and px30 in rockchip,rk3066-cif.ya=
ml
>=20
> As far as I could see we generally manage to include support for different
> hardware setups in the same binding document using conditionals on the
> compatible, so this feels a bit far-fetched.
>=20
> Of course you're the maintainer and have significantly more experience he=
re
> so there might be a lot that I'm not seeing, but I'm not very convinced b=
y this
> reasoning to be honest.
>=20
> > Just use the filename matching the compatible. That's what we always
> > ask. In every review.
>=20
> Yeah and we very often end up with naming that is less than optimal (to s=
tay
> polite). I'm generally quite appalled by the overall lack of interest that
> naming gets, as if it was something secondary. Naming is one of the most
> important and difficult things in our field of work and it needs to be
> considered with care.
>=20
> This is not just a problem with device-tree, it's a kernel-wide issue that
> nobody seems to be interested in addressing. I'm quite unhappy to see tha=
t when
> time is spent trying to improve the situation on one particular instance,=
 we are
> shown the door because it doesn't match what is generally done (and often=
 done
> wrong).
>=20
> This is definitely a rant. I really want to express this issue loud and c=
lear
> and encourage everyone to consider it for what it is.

Look chief, I do understand your frustration here, with the seemingly
arbitrary naming etc. I'm apologise if using the word "ridiculous" earlier
pissed you off. I'm sure you can similarly understand why we don't want
to accept either having a compatible for the rk3066-cif in the file,
when you are not yet sure of the correct constraints, or given your
interest in naming, why calling it after something that it does not even
document is misleading.
Ultimately, I don't care what the file ends up being called when there
are multiple devices documented in it. I'd ack a patch renaming to the
=C5=93riginal incarnation of the IP when the documentation for that IP is
added without a second thought.

--tkoOwTNqqLjvCZ6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZU51MwAKCRB4tDGHoIJi
0kScAQDf+B0t7fgSDHGxdUzFgfdNTZjMafc19Bc8+A8VwvxxowD8C1VXDUA8yC/A
16c4pdrfajLloJy4M/muYCeWBytydQ0=
=plf4
-----END PGP SIGNATURE-----

--tkoOwTNqqLjvCZ6v--
