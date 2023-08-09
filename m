Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39CD7762C8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjHIOoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjHIOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:44:09 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857002127;
        Wed,  9 Aug 2023 07:44:03 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9CE81BF203;
        Wed,  9 Aug 2023 14:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691592242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FZxV3UFMeGyDsNdwjJumfIpW8uOR/MFWbZ/4b+SKd9g=;
        b=jR7AlSufdFSWkDHzoPBOoaekD48cJ2XesAnJETdAziH/WLCjpfXnALcTGC6nPtoBAnpT4Q
        CeSwpI8yllHZhRm5Wg0EcYgv7v4OytXOp4oT5/XJH2l7sC2DW6lS6q3Q7cpvLZ6fcQvK30
        l3FZaJmIjp4JcJh7vs3co3kOUy9vAbDSXZ3Lgog1ljb6Yav+xDOjVeW+flCVXo60sNIaQi
        X+Q6cABgfmdK1u6De5euoOXvK0dHi0pyoOWwwB0GEADlxfq3qCBf9qrDC1QZUQ4cgD8FGE
        +CfDtniBC41XfeY71dckK3KO8RcXVNHzvqibAxz8XUcQRCjmLsWLcOQQvygOcA==
Date:   Wed, 9 Aug 2023 16:43:59 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Message-ID: <ZNOmL_mZdYhmFsJI@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes>
 <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
 <0b5717cb-8f30-c38c-f20e-e8a81d29423a@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aWuj40h1KBiOheuV"
Content-Disposition: inline
In-Reply-To: <0b5717cb-8f30-c38c-f20e-e8a81d29423a@xs4all.nl>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aWuj40h1KBiOheuV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Wed 26 Jul 23, 10:18, Hans Verkuil wrote:
> On 11/07/2023 20:18, Nicolas Dufresne wrote:
> > Le mardi 11 juillet 2023 =C3=A0 19:12 +0200, Paul Kocialkowski a =C3=A9=
crit=C2=A0:
> >> Hi everyone!
> >>
> >> After various discussions following Andrzej's talk at EOSS, feedback f=
rom the
> >> Media Summit (which I could not attend unfortunately) and various dire=
ct
> >> discussions, I have compiled some thoughts and ideas about stateless e=
ncoders
> >> support with various proposals. This is the result of a few years of i=
nterest
> >> in the topic, after working on a PoC for the Hantro H1 using the hantr=
o driver,
> >> which turned out to have numerous design issues.
> >>
> >> I am now working on a H.264 encoder driver for Allwinner platforms (cu=
rrently
> >> focusing on the V3/V3s), which already provides some usable bitstream =
and will
> >> be published soon.
> >>
> >> This is a very long email where I've tried to split things into distin=
ct topics
> >> and explain a few concepts to make sure everyone is on the same page.
> >>
> >> # Bitstream Headers
> >>
> >> Stateless encoders typically do not generate all the bitstream headers=
 and
> >> sometimes no header at all (e.g. Allwinner encoder does not even produ=
ce slice
> >> headers). There's often some hardware block that makes bit-level writi=
ng to the
> >> destination buffer easier (deals with alignment, etc).
> >>
> >> The values of the bitstream headers must be in line with how the compr=
essed
> >> data bitstream is generated and generally follow the codec specificati=
on.
> >> Some encoders might allow configuring all the fields found in the head=
ers,
> >> others may only allow configuring a few or have specific constraints r=
egarding
> >> which values are allowed.
> >>
> >> As a result, we cannot expect that any given encoder is able to produc=
e frames
> >> for any set of headers. Reporting related constraints and limitations =
(beyond
> >> profile/level) seems quite difficult and error-prone.
> >>
> >> So it seems that keeping header generation in-kernel only (close to wh=
ere the
> >> hardware is actually configured) is the safest approach.
> >=20
> > This seems to match with what happened with the Hantro VP8 proof of con=
cept. The
> > encoder does not produce the frame header, but also, it produces 2 enco=
ded
> > buffers which cannot be made contiguous at the hardware level. This not=
ion of
> > plane in coded data wasn't something that blended well with the rest of=
 the API
> > and we didn't want to copy in the kernel while the userspace would also=
 be
> > forced to copy to align the headers. Our conclusion was that it was bes=
t to
> > generate the headers and copy both segment before delivering to userspa=
ce. I
> > suspect this type of situation will be quite common.
> >=20
> >>
> >> # Codec Features
> >>
> >> Codecs have many variable features that can be enabled or not and spec=
ific
> >> configuration fields that can take various values. There is usually so=
me
> >> top-level indication of profile/level that restricts what can be used.
> >>
> >> This is a very similar situation to stateful encoding, where codec-spe=
cific
> >> controls are used to report and set profile/level and configure these =
aspects.
> >> A particularly nice thing about it is that we can reuse these existing=
 controls
> >> and add new ones in the future for features that are not yet covered.
> >>
> >> This approach feels more flexible than designing new structures with a=
 selected
> >> set of parameters (that could match the existing controls) for each co=
dec.
> >=20
> > Though, reading more into this emails, we still have a fair amount of c=
ontrols
> > to design and add, probably some compound controls too ?
>=20
> I expect that for stateless encoders support for read-only requests will =
be needed:
>=20
> https://patchwork.linuxtv.org/project/linux-media/list/?series=3D5647
>=20
> I worked on that in the past together with dynamic control arrays. The dy=
namic
> array part was merged, but the read-only request part wasn't (there was n=
ever a
> driver that actually needed it).
>=20
> I don't know if that series still applies, but if there is a need for it =
then I
> can rebase it and post an RFCv3.

So if I understand this correctly (from a quick look), this would be to all=
ow
stateless encoder drivers to attach a particular control value to a specific
returned frame?

I guess this would be a good match to return statistics about the encoded f=
rame.
However that would probably be expressed in a hardware-specific way so it
seems preferable to not expose this to userspace and handle it in-kernel
instead.

What's really important for userspace to know (in order to do user-side
rate-control, which we definitely want to support) is the resulting bitstre=
am
size. This is already available with bytesused.

So all in all I think we're good with the current status of request support.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--aWuj40h1KBiOheuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmTTpi8ACgkQ3cLmz3+f
v9GEdAf/avLc1Cx2s9I2b1sF2Caqh/fuL4ef2D7gFNGzZzR0Uju4QiAOsAFbMD8K
Zkd4Ti8lOCvlJOsZIthNnCoCkHGv05vkaES3yysF4MWg6SJgKvZ4m7gdi4u5Xid4
8wqY4HjbccJGeMbdTU0M72euuT8kdTG4lFLBdLUGFmDefIKFisDY2hPBlgGO1uP+
sYte2KySWBhL0Vc6+7KkO42uF4KjJ2kFOx6n+1T6poCnlDHFZ92zWEClMIIK7CdE
cAMywTSrwhHekHkPoiTki0tufju6TjDENlsWHsAq1YNekKH8qc0L5zcSOGb1C8nE
CUVjZx2+BXehlrDO8Uiwb+2thYODcw==
=swV6
-----END PGP SIGNATURE-----

--aWuj40h1KBiOheuV--
