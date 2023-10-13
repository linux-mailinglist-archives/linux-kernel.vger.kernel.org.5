Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED257C8589
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjJMMUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJMMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:19:59 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4269CBE;
        Fri, 13 Oct 2023 05:19:57 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 725D51C0050; Fri, 13 Oct 2023 14:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1697199595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/y2UoERvx8e0wwtD04T8hSXGJ9Ej3eDoObCJrOk+Msc=;
        b=XlbA8Hh7BmDFC+bSVIHd6zYdRmtX4n5nLogZ7neLVGIhSPWKArMBBbaUT3b4CMxJVg9yne
        iiqY7+SVBbWQeYNyvRjHII3Lf/Nk+FJNnywSbU1mNbqr4JQ4Gv1xdZc/31Sgm1bRGQ55nN
        0vPQXRz7G3zbXAlE++sTMyEmumGHoSA=
Date:   Fri, 13 Oct 2023 14:19:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: rgb: Implement per-key keyboard backlight for
 several TUXEDO devices
Message-ID: <ZSk16iTBmZ2fLHZ0@duo.ucw.cz>
References: <20231011190017.1230898-1-wse@tuxedocomputers.com>
 <ZSe1GYLplZo5fsAe@duo.ucw.cz>
 <0440ed38-c53b-4aa1-8899-969e5193cfef@tuxedocomputers.com>
 <ZSf9QneKO/8IzWhd@duo.ucw.cz>
 <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="15YJOgOjsKwaYDow"
Content-Disposition: inline
In-Reply-To: <a244a00d-6be4-44bc-9d41-6f9df14de8ee@tuxedocomputers.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--15YJOgOjsKwaYDow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Every multi_zone_* mode could also output a zones_image. That is a greysc=
ale
> bitmap or even a svg containing the information where each zone is located
> and which outline it has. For the bitmap the information would be encoded=
 in
> the grey value, aka 0 =3D zone 0 etc with 0xff =3D no zone (i.e. space be=
tween
> the keys). For the svg, the name of the paths would indicate the
> zone they

This is not really suitable for kernel.

> > It would go to drivers/auxdisplay, most probably.
>=20
> Looking into it, thanks for the direction. But this would come with the
> downside that upowers kbd_brightness no longer controls the keyboard.

Yep. We could add some kind of kludge to fix that.

Perhaps first question is to ask auxdisplay people if treating
keyboard as a weird display is okay? cc: lkml, leds, drm, input at
least.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--15YJOgOjsKwaYDow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSk16gAKCRAw5/Bqldv6
8sniAJ0WixY2vRASdMoSZ+sZGVmhrjybCACguFT9SBT9d9Dr5wR4G9/UCeJNMs0=
=cElG
-----END PGP SIGNATURE-----

--15YJOgOjsKwaYDow--
