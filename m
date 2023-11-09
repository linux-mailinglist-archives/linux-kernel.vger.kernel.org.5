Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4527E7135
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbjKISHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344959AbjKISHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:07:33 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EABD3AA9;
        Thu,  9 Nov 2023 10:07:30 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D407FF806;
        Thu,  9 Nov 2023 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699553248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9OAy7O2pDM0Q2lNPrJvA1RTrYu+NHPhFDgK9JaSNblI=;
        b=P69XAWubg7xOLRSNWxmEnBgjZLTzexfhp+VS1f8A3gtIXVp/bEgGmbiw75e0pNGymQsLIG
        JrEaDaG1cN3LyAPU1VJ0yxrefc6LhQUeAN5BCUM4j9db6XDfeL1CkksToePmmc7NMkA1Q8
        NZ3YRBjuXHWZwlYAj9YVKKw6bIqC1Q+Aqy+1SA0E5aY4NgO45CytezfCaLfH3xQ81CbtLs
        i4qGbIp7iCyazjFSN7ahxX0ocobomYhEls74JJLDz2Pp2/u95g+BlCHFQbhUNISRy8r6bx
        sbpULUC10Wb7LYuA6R0J5R2OKF0/9wu1WVU0Vslb7JTQqPo4gWw5j4rd78I1EQ==
Date:   Thu, 9 Nov 2023 19:07:27 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, michael.riesch@wolfvision.net
Subject: Re: [PATCH v10 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Message-ID: <ZU0f33clFwlsTw16@aptenodytes>
References: <cover.1699460637.git.mehdi.djait@bootlin.com>
 <037bcabf97294d37b271537e4b11fb88cf9bb6f6.1699460637.git.mehdi.djait@bootlin.com>
 <20231109-closable-superglue-5e7f39739cf1@spud>
 <ZU0avuRRaITV4jws@aptenodytes>
 <e5b1f0dd-0aab-4ce5-82ba-879a4d736e7e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Mob4Dz8HybFSM/IA"
Content-Disposition: inline
In-Reply-To: <e5b1f0dd-0aab-4ce5-82ba-879a4d736e7e@linaro.org>
X-GND-Sasl: paul.kocialkowski@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mob4Dz8HybFSM/IA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu 09 Nov 23, 18:53, Krzysztof Kozlowski wrote:
> On 09/11/2023 18:45, Paul Kocialkowski wrote:
> > Hi,
> >=20
> > On Thu 09 Nov 23, 17:24, Conor Dooley wrote:
> >> On Wed, Nov 08, 2023 at 05:38:56PM +0100, Mehdi Djait wrote:
> >>> Add a documentation for the Rockchip Camera Interface binding.
> >>>
> >>> the name of the file rk3066 is the first Rockchip SoC generation that=
 uses cif
> >>> instead of the px30 which is just one of the many iterations of the u=
nit.
> >>
> >> I think this is becoming ridiculous. You've now removed the compatible
> >> for the rk3066 but kept it in the filename. I don't understand the
> >> hangup about naming the file after the px30-vip, but naming it after
> >> something that is not documented here at all makes no sense to me.
> >> Either document the rk3066 properly, or remove all mention of it IMO.
> >=20
> > I think the opposite is ridiculous. We have spent some time investigati=
ng the
> > history of this unit, to find out that RK3066 is the first occurence wh=
ere
> > it exists. Since we want the binding to cover all generations of the sa=
me unit
> > and give it a name that reflects this, rk3066 is the natural choice tha=
t comes
> > to mind. As far as I understand, this is the normal thing to do to name
> > bindings: name after the earliest known occurence of the unit.
> >=20
> > What is the rationale behind naming the file after a generation of the =
unit
> > that happens to be the one introducing the binding? This is neither the=
 first
> > nor the last one to include this unit. The binding will be updated late=
r to
> > cover other generations. Do we want to rename the file each time an a g=
eneration
> > earlier than px30 is introduced? That sounds quite ridiculous too.
> >=20
> > We've done the research work to give it the most relevant name here.
> > I'd expect some strong arguments not to use it. Can you ellaborate?
>=20
> If you do not have rk3066 documented here, it might be added to entirely
> different file (for whatever reasons, including that binding would be
> quite different than px30). Thus you would have rk3066 in
> rockchip,rk3066-cif-added-later.yaml and px30 in rockchip,rk3066-cif.yaml

As far as I could see we generally manage to include support for different
hardware setups in the same binding document using conditionals on the
compatible, so this feels a bit far-fetched.

Of course you're the maintainer and have significantly more experience here
so there might be a lot that I'm not seeing, but I'm not very convinced by =
this
reasoning to be honest.

> Just use the filename matching the compatible. That's what we always
> ask. In every review.

Yeah and we very often end up with naming that is less than optimal (to stay
polite). I'm generally quite appalled by the overall lack of interest that
naming gets, as if it was something secondary. Naming is one of the most
important and difficult things in our field of work and it needs to be
considered with care.

This is not just a problem with device-tree, it's a kernel-wide issue that
nobody seems to be interested in addressing. I'm quite unhappy to see that =
when
time is spent trying to improve the situation on one particular instance, w=
e are
shown the door because it doesn't match what is generally done (and often d=
one
wrong).

This is definitely a rant. I really want to express this issue loud and cle=
ar
and encourage everyone to consider it for what it is.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--Mob4Dz8HybFSM/IA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVNH98ACgkQ3cLmz3+f
v9G9twf+JR5dsdM2G3sgKunvWuC3i7/cbQl17nAbAGUF5eB6ctWTGGrxSLcyl+Q6
uBup3E59JYwmKlPE2gLeKDbETumExf5UnlQdHt01QrriMEdKggUYPPmwJ8jQItQE
byTo9DcSZWHqAB66pkyZQaTpwTPCjky3OM2H2rQ2fHbmh2wjicQbdAstt17sblkv
RNjkyiMVjSOAukV1iGtVKEZYl/QVpQnwvnchxJF/2wSTw1YEhcYGDw6Yndl3WfbU
ox4G7bjP5QRUv93bCW80M7uWl7LRSnSo8hK84WfrvNYEdWfMfs8PZVRnTfitn3YL
kXFdLP3ZAKW6iqU6UCjxaI75xtMrzg==
=+UTG
-----END PGP SIGNATURE-----

--Mob4Dz8HybFSM/IA--
