Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F007B0967
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjI0PzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjI0PzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:55:02 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838FD10DB;
        Wed, 27 Sep 2023 08:52:27 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6EE071C002E; Wed, 27 Sep 2023 17:52:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1695829945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gKmlF24D9wEYZmpPY4pyhX2RZKAFbVwikfJcj8WeaM0=;
        b=oO1c9uhQ2eI5cunUP9Zglr8sb92Noy1qFKhmSpB8VGObMguJ5N7hwEEMiybrDyAHHvU8ss
        wjoU8hwybc60n/+zprXid9vQ2OsKhSwhAW+c2Kb9gkg1VkMig2GDmeyD10Q2h/Whfl6aU8
        ZEA3J/LTB1acZQZQJbaOWptd79iIZok=
Date:   Wed, 27 Sep 2023 17:52:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        phone-devel@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: Re: droid4 -- weird behaviour when attempting to use usb host
Message-ID: <ZRRPsWQiTP21hozK@duo.ucw.cz>
References: <ZRGa+0OFNluV4T5t@localhost>
 <20230926071415.GW5285@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dNROfh5L9PZtEJdO"
Content-Disposition: inline
In-Reply-To: <20230926071415.GW5285@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dNROfh5L9PZtEJdO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I'm having some fun with usb host. Good news is it works with
> > externally powered hub... after a while. I get some error messages
> > about inability to go host mode, but with enough patience it
> > eventually does enter host mode and I see my keyboard/mouse.
> >=20
> > And usually in that process, one of my cpu cores disappear. top no
> > longer shows 2 cores, and I was wondering for a while if d4 is
> > single-core system. It is not, my two cores are back after reboot.
> >=20
> > That's with 6.1.9 kernel from leste. Ideas how to debug this would be
> > welcome. (Do you use usb host?)
>=20
> You are using a "proper" non-standard usb micro-b cable that grounds
> the id pin, right?

Yes.

> If not, try with one of those as it allows the hardware to do what it's
> supposed to do.
>=20
> And presumably you don't have a hacked usb hub that feeds back the
> vbus to your phone, right?

Do have hacked hub. Or more precisely, have device that needs external
power (spinning rust), and hub passes it back to the device.

I'll retry with a keyboard... but I recall it behaved funny with that, too.

> If you have, that should not be used as the pmic can feed vbus.

Well, my plan was to use it as a desktop, and external power is useful
that as Droid battery is not that big.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--dNROfh5L9PZtEJdO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZRRPsQAKCRAw5/Bqldv6
8ra8AKC7lzjBB+3yYRhK28e2x1T8h8LbwwCgqUR1vYbz8ywFk9hMmsDOjdNra2g=
=ItwB
-----END PGP SIGNATURE-----

--dNROfh5L9PZtEJdO--
