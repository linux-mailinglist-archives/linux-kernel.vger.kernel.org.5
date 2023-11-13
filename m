Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625A77EA187
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjKMQyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:54:17 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE6010E0;
        Mon, 13 Nov 2023 08:54:11 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B1F2C000D;
        Mon, 13 Nov 2023 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699894450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=51lY1jIgGkWGCtkDFu685j7ycEyBpmmPBxB/qCXnQdE=;
        b=KS5AVR2L0bwXYfspT0LmpBJqYogWSdu9kyiEorhugKOjuRNTmFyJZw73KX81qNVWFvUBvB
        0HaUerdHTv77zUNAr7LL2cJ9aeugUzu59PG2AxmJXCNspfxa1dcuWSNyIreTFGhJ31v7/E
        8aRcAlHOVfeq0YQ6iknlSMd84pjtJa5ogn1nzKP4v1Lwv8Tuqomfz3bTRIQyiK2U7wW/An
        DyYAjtI4DKJZQevmADcX1UouHuMu3zn758OtXvub0ReCVciuBeufHheIrwF6l71ZoTXrL5
        oKfqyKlnG58waiz33bZHgd2me1bVMzjHGxmj3GUUm2+2KQdw+27xHV2zXGqv5w==
Date:   Mon, 13 Nov 2023 17:54:08 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Conor Dooley <conor@kernel.org>
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
Message-ID: <ZVJUsDb1mPVtcjdX@aptenodytes>
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <037bcabf97294d37b271537e4b11fb88cf9bb6f6.1699460637.git.mehdi.djait@bootlin.com>
 <20231109-closable-superglue-5e7f39739cf1@spud>
 <ZU0avuRRaITV4jws@aptenodytes>
 <e5b1f0dd-0aab-4ce5-82ba-879a4d736e7e@linaro.org>
 <ZU0f33clFwlsTw16@aptenodytes>
 <20231110-appetizer-fame-2152806c7442@roley>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SBtJWaByrnKsba6Z"
Content-Disposition: inline
In-Reply-To: <20231110-appetizer-fame-2152806c7442@roley>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SBtJWaByrnKsba6Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Fri 10 Nov 23, 18:23, Conor Dooley wrote:
> On Thu, Nov 09, 2023 at 07:07:27PM +0100, Paul Kocialkowski wrote:
> > On Thu 09 Nov 23, 18:53, Krzysztof Kozlowski wrote:
> > > On 09/11/2023 18:45, Paul Kocialkowski wrote:
> > > > On Thu 09 Nov 23, 17:24, Conor Dooley wrote:
> > > >> On Wed, Nov 08, 2023 at 05:38:56PM +0100, Mehdi Djait wrote:
> > > >>> Add a documentation for the Rockchip Camera Interface binding.
> > > >>>
> > > >>> the name of the file rk3066 is the first Rockchip SoC generation =
that uses cif
> > > >>> instead of the px30 which is just one of the many iterations of t=
he unit.
> > > >>
> > > >> I think this is becoming ridiculous. You've now removed the compat=
ible
> > > >> for the rk3066 but kept it in the filename. I don't understand the
> > > >> hangup about naming the file after the px30-vip, but naming it aft=
er
> > > >> something that is not documented here at all makes no sense to me.
> > > >> Either document the rk3066 properly, or remove all mention of it I=
MO.
> > > >=20
> > > > I think the opposite is ridiculous. We have spent some time investi=
gating the
> > > > history of this unit, to find out that RK3066 is the first occurenc=
e where
> > > > it exists. Since we want the binding to cover all generations of th=
e same unit
> > > > and give it a name that reflects this, rk3066 is the natural choice=
 that comes
> > > > to mind. As far as I understand, this is the normal thing to do to =
name
> > > > bindings: name after the earliest known occurence of the unit.
> > > >=20
> > > > What is the rationale behind naming the file after a generation of =
the unit
> > > > that happens to be the one introducing the binding? This is neither=
 the first
> > > > nor the last one to include this unit. The binding will be updated =
later to
> > > > cover other generations. Do we want to rename the file each time an=
 a generation
> > > > earlier than px30 is introduced? That sounds quite ridiculous too.
> > > >=20
> > > > We've done the research work to give it the most relevant name here.
> > > > I'd expect some strong arguments not to use it. Can you ellaborate?
> > >=20
> > > If you do not have rk3066 documented here, it might be added to entir=
ely
> > > different file (for whatever reasons, including that binding would be
> > > quite different than px30). Thus you would have rk3066 in
> > > rockchip,rk3066-cif-added-later.yaml and px30 in rockchip,rk3066-cif.=
yaml
> >=20
> > As far as I could see we generally manage to include support for differ=
ent
> > hardware setups in the same binding document using conditionals on the
> > compatible, so this feels a bit far-fetched.
> >=20
> > Of course you're the maintainer and have significantly more experience =
here
> > so there might be a lot that I'm not seeing, but I'm not very convinced=
 by this
> > reasoning to be honest.
> >=20
> > > Just use the filename matching the compatible. That's what we always
> > > ask. In every review.
> >=20
> > Yeah and we very often end up with naming that is less than optimal (to=
 stay
> > polite). I'm generally quite appalled by the overall lack of interest t=
hat
> > naming gets, as if it was something secondary. Naming is one of the most
> > important and difficult things in our field of work and it needs to be
> > considered with care.
> >=20
> > This is not just a problem with device-tree, it's a kernel-wide issue t=
hat
> > nobody seems to be interested in addressing. I'm quite unhappy to see t=
hat when
> > time is spent trying to improve the situation on one particular instanc=
e, we are
> > shown the door because it doesn't match what is generally done (and oft=
en done
> > wrong).
> >=20
> > This is definitely a rant. I really want to express this issue loud and=
 clear
> > and encourage everyone to consider it for what it is.
>=20
> Look chief, I do understand your frustration here, with the seemingly
> arbitrary naming etc. I'm apologise if using the word "ridiculous" earlier
> pissed you off.

Sorry if my reply was a bit harsh too, it was of course nothing personal but
I really felt like this issue was not being considered seriously.

> I'm sure you can similarly understand why we don't want
> to accept either having a compatible for the rk3066-cif in the file,
> when you are not yet sure of the correct constraints, or given your
> interest in naming,

Sure I understand that we don't want to introduce a compatible for which we
don't have a clear idea of the resources/hardware constraints. I fully agree
that there shouldn't be a fallback on a rk3066-cif for the px30.

> why calling it after something that it does not even
> document is misleading.

My opinion is that the two things are separate and that as long as we know
it's the same unit, it should be fine to name the file after the first
generation even if it is not yet described in the binding. I find that it's=
 a
bit unusual, yes, but I wouldn't go as far as calling it confusing.

The description text can clearly mention that the first occurrence of the u=
nit
is in the RK3066 and thus it will be clear why the file is named after it.
Also people looking for binding documentation for the px30 vip will still e=
asily
find it with the usual git grep. So I don't really see any serious downside.

> Ultimately, I don't care what the file ends up being called when there
> are multiple devices documented in it. I'd ack a patch renaming to the
> =C5=93riginal incarnation of the IP when the documentation for that IP is
> added without a second thought.

That would be agreeable to me if my proposal still ends up feeling unreason=
able
to you. But I might very well take you at your word since I ended up purcha=
sing
a RK3066 board in a moment of weakness last week.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--SBtJWaByrnKsba6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVSVLAACgkQ3cLmz3+f
v9G/yggAmq6aXtUBwrWlzJDVvbuhGjLAIE9UCOE/w3e69PC9J0HKH5rVwmys9TqP
TfuSaaaQK0VThsU2t9zcnVgvnbn2E37hcZZ7KiM1mfJV3av173lsQWnP8EIEzMSJ
Kktz1VqQDZIodjMCLrG5BE6InNU81p+UnnaMPSsKn6ezPujJgHDFwODai0v3dh69
BnNrSVqL045Eb60aRtStcQ1AVEazFuwgvXQPV+zdo6f5JvYB4G4PvxRzTFJqCZDU
Zgp8MrFAGYyq/tSDh69f0Ghm9kaxMRVpUe0UNzoVuNrM6gHdWjeb9yxevPDoIigH
UxmJkMvvdE3UMBXQfUg1KZkzMNaBbQ==
=J+G/
-----END PGP SIGNATURE-----

--SBtJWaByrnKsba6Z--
