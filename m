Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D047D6621
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjJYJCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjJYJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:02:50 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B096116;
        Wed, 25 Oct 2023 02:02:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A82044000C;
        Wed, 25 Oct 2023 09:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698224564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IgtN2DDo1pUwYXtxkw/V7hIJN2MXuUz4L/Sadc9jmhc=;
        b=MAoVJSGmX0FOirLRMC3TP2rx9iYL39ti1GjmeRCOg2E/gnTbuxJ3oc/tYTECxBLLYmt+/P
        CT31V6Ka8/A2o2LN10bBF2InLzFHYICFkUcLW1Ey7hIJWRby91zhXzgHT4kTzmQpy8pgcJ
        SO3+QxwsJbtv5x7mL4N/3lT6FMyILP1iS5Dx3lMtU+heXaqze7mnnXNsZiTAF53i6EO3Tj
        FwrptaeOPDmqmyA/uBPWHySftL+EjN8QJjcKbWQMFjARGPUMwmT1MKDAvhazMOj1cbD5E6
        xXhEyDtKHoj1QLWjr+kZ3Im4R0uPTrZgHjvmN96IuvMdoxIzghU/Ci9ukHfiGg==
Date:   Wed, 25 Oct 2023 11:02:43 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: V4L2 Encoders Pre-Processing Support Questions
Message-ID: <ZTjZs5vYF-YT-rA-@aptenodytes>
References: <ZTD5TXND4R7JqvCD@aptenodytes>
 <437e4ea0c2c2681c1b333ad109f8f02fc229537f.camel@ndufresne.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yfS1BwUP+ZZlB72g"
Content-Disposition: inline
In-Reply-To: <437e4ea0c2c2681c1b333ad109f8f02fc229537f.camel@ndufresne.ca>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yfS1BwUP+ZZlB72g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

Thanks for you useful answer!

On Fri 20 Oct 23, 13:56, Nicolas Dufresne wrote:
> > For example this means that you can feed the encoder with YUV 4:2:2 dat=
a and
> > it will downsample it to 4:2:0 since that's the only thing the hardware=
 can do.
> > It can also happen when e.g. providing RGB source pictures which will be
> > converted to YUV 4:2:0 internally.
> >=20
> > I was wondering how all of this is dealt with currently and whether thi=
s should
> > be a topic of attention. As far as I can see there is currently no prac=
tical way
> > for userspace to know that such downsampling will take place, although =
this is
> > useful to know.
>=20
> Userspace already know that the driver will be downsample through the sel=
ected
> profile. The only issue would be if a users want to force a profile with =
422
> support, but have its  422 data downsampled anyway. This is legal in the =
spec,
> but I'd question myself if its worth supporting.

Yeah indeed I think there's a distinction between selecting a profile that
allows 422 and ensuring that this is what the encoder selects. Not sure if =
420
is always valid for any profile, but there's surely some overlap where both
could be selected in compliance with the profile.

> > Would it make sense to have an additional media entity between the sour=
ce video
> > node and the encoder proc and have the actual pixel format configured i=
n that
> > link (this would still be a video-centric device so userspace would not=
 be
> > expected to configure that link). But then what if the hardware can eit=
her
> > down-sample or keep the provided sub-sampling? How would userspace indi=
cate
> > which behavior to select? It is maybe not great to let userspace config=
ure the
> > pads when this is a video-node-centric driver.
> >=20
> > Perhaps this could be a control or the driver could decide to pick the =
least
> > destructive sub-sampling available based on the selected codec profile
> > (but this is still a guess that may not match the use case). With a con=
trol
> > we probably don't need an extra media entity.
>=20
> Yes, for the cases not covered by the profile, I'd consider a control to =
force
> downsampling. A menu, so we can use the available menu items to get enume=
rate
> what is supported.

Sounds good then.

> > Another topic is scaling. We can generally support scaling by allowing a
> > different size for the coded queue after configuring the picture queue.
> > However there would be some interaction with the selection rectangle, w=
hich is
> > used to set the cropping rectangle from the *source*. So the driver wil=
l need
> > to take this rectangle and scale it to match with the coded size.
> >=20
> > The main inconsistency here is that the rectangle would no longer corre=
spond to
> > what will be set in the bitstream, nor would the destination size since=
 it does
> > not count the cropping rectangle by definition. It might be more sensib=
le to
> > have the selection rectangle operate on the coded/destination queue ins=
tead,
> > but things are already specified to be the other way round.
> >=20
> > Maybe a selection rectangle could be introduced for the coded queue too=
, which
> > would generally be propagated from the picture-side one, except in the =
case of
> > scaling where it would be used to clarify the actual final size (coded =
size
> > taking the cropping in account). It this case the source selection rect=
angle
> > would be understood as an actual source crop (may not be supported by h=
ardware)
> > instead of an indication for the codec metadata crop fields. And the co=
ded
> > queue dimensions would need to take in account this source cropping, wh=
ich is
> > kinda contradictory with the current semantics. Perhaps we could define=
 that
> > the source crop rectangle should be entirely ignored when scaling is us=
ed,
> > which would simplify things (although we lose the ability to support so=
urce
> > cropping if the hardware can do it).
>=20
> Yes, we should use selection on both queue (fortunately there is a v4l2_b=
uf_type
> in that API). Otherwise we cannot model all the scaling and cropping opti=
ons.
> What the spec must do is define the configuration sequence, so that a
> negotiation is possible. We need a convention regarding the order, so tha=
t there
> is a way to converge with the driver, and also to conclude if the driver =
cannot
> handle it.

Agreed. I'm just a bit worried that it's a bit late to change the semantics=
 now
that the source crop is defined in the stateful encoding uAPI and its meani=
ng
would become unclear/different when a destination crop is added.

Cheers,

Paul

> > If operating on the source selection rectangle only (no second rectangl=
e on the
> > coded queue) some cases would be impossible to reach, for instance goin=
g from
> > some aligned dimensions to unaligned ones (e.g. 1280x720 source scaled =
to
> > 1920x1088 and we want the codec cropping fields to indicate 1920x1080).
> >=20
> > Anyway just wanted to check if people have already thought about these =
topics,
> > but I'm mostly thinking out loud and I'm of course not saying we need t=
o solve
> > these problems now.
>=20
> We might find extra corner case by implementing the spec, but I think the=
 API we
> have makes most of this possible already. Remember that we have fwht sw c=
odec in
> kernel for the purpose of developing this kind of feature. A simple bob s=
caler
> can be added for testing scaling.
>=20
> >=20
> > Sorry again for the long email, I hope the points I'm making are somewh=
at
> > understandable.
> >=20
> > Cheers,
> >=20
> > Paul
> >=20
>=20
> regards,
> Nicolas
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--yfS1BwUP+ZZlB72g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmU42bMACgkQ3cLmz3+f
v9FnNAf/Y16PjB0ADByNN+sKglPxkHzDyouIZg4aowgACQK4Kwfuw3ldlSZWfeFk
H7tHi8gQrz/tRcEiFXtsZzVS/Xuse7OPLcfZfaXvvywVAxa8mQpjUNsrPgvp6DU+
3KWPO6NyabcF+7JUWsRXjFlS+EnnA0DQ6ZwdE/XMWbm2t/5xc5yadzzQrjjZg9Hx
5q/DP86jyKz2q958LvW9xVnL3mC/daXFyMqsh2TCz/UEYpWqc729x093DTZh+uYx
eNx4/Hb+P8dAKtsCHae78eRgJN4jPEyDjdbusLddq0xpu3m+wLydX7bIZ5f9xS0E
RbKIIUAgFrJYZg2+NSNt3pn6V+dTaQ==
=40D5
-----END PGP SIGNATURE-----

--yfS1BwUP+ZZlB72g--
