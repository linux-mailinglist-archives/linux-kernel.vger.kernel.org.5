Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7595A760E02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjGYJJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjGYJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:09:51 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A91010B;
        Tue, 25 Jul 2023 02:09:49 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71B0C2000D;
        Tue, 25 Jul 2023 09:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690276188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJtc9a3PGhmMO8/h4CC9DQKXOK21zPv9JTdVoVJ318k=;
        b=Vlg0eYuZWhIEbpQbazYON07DWlXTfMaRsgKSzTsixhGezTtz+2OBAyB/awmn4aw5aWNCTE
        xdVWKI8j1Dsm7no8qGuKHEwLFvrEVP74ZtLqWP6t4bTZJIRv5N432HFVMqgv5PN9r/eO0p
        PDGxm7gYfcE6PFCYmu2Ge834mAuNU6xJxkCealfsbuqXgc1MOkR42nxOFZIvk53fl3o9zc
        wnf+f1hM9xU2rIkYLTC5ceC5bY0dO8Wn0hAj4DD+DIy8bnTvC4aifmISVW7UlvlRB2DUPz
        2gsfH25/tCaggNKsBpaHUJ92e2mV/FmH4erk5YLGVH9WtPekMJlz2zaVfxjm9w==
Date:   Tue, 25 Jul 2023 11:09:44 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Michael Grzeschik <mgr@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Message-ID: <ZL-RWOfUYh5VbUo1@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes>
 <20230721181951.GL12001@pengutronix.de>
 <c6a222be5eee962581cf5dcb9a1473cf45ff303c.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LqVc6g4NIsP9GW5P"
Content-Disposition: inline
In-Reply-To: <c6a222be5eee962581cf5dcb9a1473cf45ff303c.camel@collabora.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LqVc6g4NIsP9GW5P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Mon 24 Jul 23, 10:03, Nicolas Dufresne wrote:
> Le vendredi 21 juillet 2023 =C3=A0 20:19 +0200, Michael Grzeschik a =C3=
=A9crit=C2=A0:
> > > As a result, we cannot expect that any given encoder is able to produ=
ce frames
> > > for any set of headers. Reporting related constraints and limitations=
 (beyond
> > > profile/level) seems quite difficult and error-prone.
> > >=20
> > > So it seems that keeping header generation in-kernel only (close to w=
here the
> > > hardware is actually configured) is the safest approach.
> >=20
> > For the case with the rkvenc, the headers are also not created by the
> > kernel driver. Instead we use the gst_h264_bit_writer_sps/pps functions
> > that are part of the codecparsers module.
>=20
> One level of granularity we can add is split headers (like SPS/PPS) and
> slice/frame headers.

Do you mean asking the driver to return a buffer with only SPS/PPS and then
return another buffer with the slice/frame header?

Looks like there's already a control for it: V4L2_CID_MPEG_VIDEO_HEADER_MODE
which takes either
- V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE: looks like what you're suggesting
- V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME: usual case

So that could certainly be supported to easily allow userspace to stuff ext=
ra
NALUs in-between.

> It remains that in some cases, like HEVC, when the slice
> header is byte aligned, it can be nice to be able to handle it at applica=
tion
> side in order to avoid limiting SVC support (and other creative features)=
 by our
> API/abstraction limitations.

Do you see something in the headers that we expect the kernel to generate t=
hat
would need specific changes to support features like SVC?

=46rom what I can see there's a svc_extension_flag that's only set for spec=
ific
NALUs (prefix_nal_unit/lice_layer_extension) so these could be inserted by
userspace.

Also I'm not very knowledgeable about SVC so it's not very clear to me if i=
t's
possible to take an encoder that doesn't support SVC and turn the resulting
stream into something SVC-ready by adding extra NAL units or if the encoder
should be a lot more involved.

Also do you know if we have stateful codecs supporting SVC?

> I think a certain level of "per CODEC" reasoning is
> also needed. Just like, I would not want to have to ask the kernel to gen=
erate
> user data SEI and other in-band data.

Yeah it looks like there is definitely a need for adding extra NALUs from
userspace without passing that data to the kernel.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--LqVc6g4NIsP9GW5P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmS/kVgACgkQ3cLmz3+f
v9GRFwf/VznO8iHeong8AkuaWQeM7KcKco1lDbchrzz066+pA86oUP7z2Ud11wYx
fk8XrODnscy4t+9nhueQ7m0yk7+I7pgDik+0SB2ihC/HIqzABArJZDl1xeXmvD/p
Y5gkj16u7tGpeVmuBt19QQjcWFr33HPjfyv2siR9f/nS0o0FRc1P1QCWaPXujgwP
OSg/cdjat0c8f0hCYsj+vcKqkGmSaV//oHle6hOc4pZCF5GyT6AbUPhrHxj7r+J+
1sv4geBVWfOplrofSEYAx74TAQLcaVWR9pjJeZOKDpLd501Nndgxx/2/eC6Xs3bY
FYrgLk2SGts+kXFluS1nmkhBp3ujbw==
=sW6t
-----END PGP SIGNATURE-----

--LqVc6g4NIsP9GW5P--
