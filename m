Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C97C7000
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379050AbjJLOGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347196AbjJLOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:06:01 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AF891;
        Thu, 12 Oct 2023 07:05:57 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3A7351C0050; Thu, 12 Oct 2023 16:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1697119555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=inB6K2CE4naGequ0gk0UEnbCsOf+8IaxK5+AmjGjuUc=;
        b=YyQR21OtwY8naDHAxRH2uNMw3rKiw2R8OKu+ASfY5piekasLQD3IoEiGTTjCag4c8XkpXT
        UwDDArzHw3rvLkJEJj1CqhYM8lyKCNxfprM4Q3WET7RTHnvGXKUrrsVJMPRIJW8bjOR32y
        gI5FFpxReu8FVF7p0LGpIfz9ssHzEKQ=
Date:   Thu, 12 Oct 2023 16:05:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: Implement per-key keyboard backlight for
 several TUXEDO devices
Message-ID: <ZSf9QneKO/8IzWhd@duo.ucw.cz>
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aFNhJsV8yyrqsqyP"
Content-Disposition: inline
In-Reply-To: <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aFNhJsV8yyrqsqyP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > There are however some known short comings:
> > > - The sysfs leds interface does only allow to write one key at a time=
=2E The
> > > controller however can only update row wise or the whole keyboard at =
once
> > > (whole keyboard update is currently not implemented). This means that=
 even
> > > when you want to updated a whole row, the whole row is actually updat=
ed
> > > once for each key. So you actually write up to 18x as much as would be
> > > required.
> > > - When you want to update the brightness of the whole keyboard you ha=
ve to
> > > write 126 sysfs entries, which inherently is somewhat slow, especiall=
y when
> > > using a slider that is live updating the brightness.
> > > - While the controller manages up to 126 leds, not all are actually
> > > populated. However the unused are not grouped at the end but also in
> > > between. To not have dead sysfs entries, this would require manual te=
sting
> > > for each implemented device to see which leds are used and some kind =
of
> > > bitmap in the driver to sort out the unconnected ones.
> > > - It is not communicated to userspace which led entry controls which =
key
> > > exactly
> > Sooner or later, we'll need to support these keyboards.
> >=20
> > But this has way too many shortcomings (and we'd be stuck with the
> > interface forever).
>=20
> I had some thoughts on how the current userspace api could be expanded to
> better reflect the capabilities of RGB keyboards. What would be required =
for
> such an expansion to be considered?

You submit a proposal.
=20
> I'm in contact with the KDE folks. Plasma already has a keyboard brightne=
ss
> slider, that soon
> https://gitlab.freedesktop.org/upower/upower/-/merge_requests/203 will wo=
rk
> with multiple kbd_backlight. However the slowness of 126 sysfs entries ma=
kes
> it a little bit janky still.
>=20
> They are also thinking about expanding desktop accent colors to the keybo=
ard
> backlight when it supports RGB.
>=20
> I have not reached out to the OpenRGB project yet, but is it alive and we=
ll
> and under constant development: https://gitlab.com/CalcProgrammer1/OpenRG=
B.
> Afaik it is currently a userspace only driver interacting directly with
> hidraw mostly and has not yet implemented the sysfs leds interface.
>=20
> Just listing this to show that there is definitely interest in this.

Yep, there's definitely interest.

> > These days, displays with weird shapes are common. Like rounded
> > corners and holes in them. Perhaps this should be better modelled as a
> > weird display?
>=20
> I'm not sure if I can follow you here. Where would this be implemented? A=
lso
> I asume displays asume equal distance between pixels and that columns are
> straight lines perpendicular to rows, which the key backlights have and a=
re
> not.

Yes, I know displays are a bit different from RGB LEDs. Gamma is
another issue. Yes, it is quite weird display. But 6x22 display may be
better approximation of keyboard than ... 126 unrelated files.

Or you could do 6x66 sparse display, I guess, to express the
shifts. But I believe 6x22 would be better.

It would go to drivers/auxdisplay, most probably.

I checked
https://www.tuxedocomputers.com/en/Linux-Hardware/Zubehoer-USB-Co./USB-Zube=
hoer.tuxedo
, but you don't seem to have stand-alone keyboard with such RGB capability.=
=2E.?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--aFNhJsV8yyrqsqyP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSf9QgAKCRAw5/Bqldv6
8iBuAJwO/B7tRyK17+LfywKkRYaL9/c9jwCfaqw4BvVM3rR9X370LIYbVUhFic8=
=GGyX
-----END PGP SIGNATURE-----

--aFNhJsV8yyrqsqyP--
