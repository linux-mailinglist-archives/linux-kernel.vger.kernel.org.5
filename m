Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558EF7C68B4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbjJLI6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjJLI6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:58:06 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FFB91;
        Thu, 12 Oct 2023 01:58:03 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5C2B01C0050; Thu, 12 Oct 2023 10:58:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1697101082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=stIMuFGSGT3Yz1fYEWDo5wEHiIttSpIcz9uPDVqTXX4=;
        b=GOGfnOC9apeRfgMYelDNmaCvcGWcURzVkjm4l4S6nVTcKTfyF5EiWU6yaaaTMBoQwTrYVj
        8E+2UKHCL+H85SktX/4GRrKz0gJbpqZE5PTrwJOdsmHNQvmxwMH8E0ML7ii2JUutk3Skm6
        coPGet32YPDoW8td7Jk3kVUbNM31iTk=
Date:   Thu, 12 Oct 2023 10:58:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: Implement per-key keyboard backlight for
 several TUXEDO devices
Message-ID: <ZSe1GYLplZo5fsAe@duo.ucw.cz>
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="V6zkJUxOqwHngDD1"
Content-Disposition: inline
In-Reply-To: <20231011190017.1230898-1-wse@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V6zkJUxOqwHngDD1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Christoffer Sandberg <cs@tuxedo.de>
>=20
> Implement per-key keyboard backlight in the leds sysfs interface for
> several TUXEDO devices using the ite8291 controller.
>=20
> There are however some known short comings:
> - The sysfs leds interface does only allow to write one key at a time. The
> controller however can only update row wise or the whole keyboard at once
> (whole keyboard update is currently not implemented). This means that even
> when you want to updated a whole row, the whole row is actually updated
> once for each key. So you actually write up to 18x as much as would be
> required.
> - When you want to update the brightness of the whole keyboard you have to
> write 126 sysfs entries, which inherently is somewhat slow, especially wh=
en
> using a slider that is live updating the brightness.
> - While the controller manages up to 126 leds, not all are actually
> populated. However the unused are not grouped at the end but also in
> between. To not have dead sysfs entries, this would require manual testing
> for each implemented device to see which leds are used and some kind of
> bitmap in the driver to sort out the unconnected ones.
> - It is not communicated to userspace which led entry controls which key
> exactly

Sooner or later, we'll need to support these keyboards.

But this has way too many shortcomings (and we'd be stuck with the
interface forever).

These days, displays with weird shapes are common. Like rounded
corners and holes in them. Perhaps this should be better modelled as a
weird display?

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--V6zkJUxOqwHngDD1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSe1GQAKCRAw5/Bqldv6
8iNMAJ9m3A5f5EFMcFNJM5Bnpc+qVPGnAwCgiIGFr63rqP803FMGSrhyOtznJ+E=
=o063
-----END PGP SIGNATURE-----

--V6zkJUxOqwHngDD1--
