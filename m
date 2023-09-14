Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE17A0189
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbjINKVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbjINKVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:21:16 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559B61BE9;
        Thu, 14 Sep 2023 03:21:12 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0F3AC1C001A; Thu, 14 Sep 2023 12:21:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1694686870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9VuvLFAgOapdxIBaFQmCyHnGviBZ/c74QA8VXYTIyQA=;
        b=kjrUGT2++ncwIXHKIoX2n8QjkUoCQkDyOcKaaPMwc2w7NDkHVlZ8MrOceUKeDa2h4HHfXX
        GhE4IKiJctHjOD/kavNUg+F6E7DITOlwyJhZ/MEqlqv76EOHlzwgtTlEArS1piEFYA1/TJ
        O8V9LyCpgATysKpn0oODDAHJG7cimag=
Date:   Thu, 14 Sep 2023 12:21:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Da Xue <da@libre.computer>, kabel@kernel.org, lee@kernel.org,
        sashal@kernel.org
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stable <stable@vger.kernel.org>
Subject: Re: linux-stable 6.1.53 kernel crash on COLOR_ID_MULTI handling
 change
Message-ID: <ZQLelWcNjjp2xndY@duo.ucw.cz>
References: <CACqvRUb_X14pjaxA0Q7bQf53TAFmk5rjQOSWqx3Tvi4g+vcNMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5BBXTsWOpV35xwsR"
Content-Disposition: inline
In-Reply-To: <CACqvRUb_X14pjaxA0Q7bQf53TAFmk5rjQOSWqx3Tvi4g+vcNMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5BBXTsWOpV35xwsR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We have running systems that use COLOR_ID_MULTI. The GPIO toggles
> between two colors and we have used the identifier. RGB is not a good
> fit since it is not a RGB LED. Please provide guidance.
>=20
> This patch causes the system to not start: f741121a2251 leds: Fix
> BUG_ON check for LED_COLOR_ID_MULTI that is always false
>=20
> It was also backported to stable causing previously booting systems to
> no longer boot.

Lets cc patch authors.

And please drop this from stable, it does not belong there.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--5BBXTsWOpV35xwsR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZQLelQAKCRAw5/Bqldv6
8g40AJoD27etLUUmaYCy5BPMt6NYcBV+TgCcCl2ikwBAgGDPWOQA+8bYY4vwjm0=
=EZAw
-----END PGP SIGNATURE-----

--5BBXTsWOpV35xwsR--
