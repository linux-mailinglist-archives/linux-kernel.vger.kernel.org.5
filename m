Return-Path: <linux-kernel+bounces-105108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2611487D934
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E0B282003
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162FE560;
	Sat, 16 Mar 2024 07:37:11 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C8CA62
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710574631; cv=none; b=BSTEJ6QYzA8VczQBxMtW8Qmyc6WDXX7nDc6jxqpZVSld7/cCCbki6cLIpSnzjfp5pMt9Zqffv8YtSiDwX74wndCeMdQVT8Q9gSez4WHvQwxvD6f1ZVoHX/btVYWxhkRxTFNqchdK3K9/BCMxeQ1UlbvsTW5FPXlIBo2aXrzh29c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710574631; c=relaxed/simple;
	bh=rmv96hAwBEDMPnwHQGe/QeXUDxsP7VuFc2cWjgW2NFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5Z5hn5BC26UxQixXBQLm+zvBbbMSZz5AZ/mRzF2KQaX0m/YnHqMhqFQhl7mW6lqyAyTI3s3r30m9GAHC3xM+lREzqUsLqORGd2vJkz8Yg5N6bjq4MlvyDDIJsA4CeCwZaRze95aQ6mthyRLJVY4jwIbhKoCoFM8AQs8Uytmm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlObK-0008Fr-1P; Sat, 16 Mar 2024 08:37:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlObJ-006eZo-AM; Sat, 16 Mar 2024 08:37:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlObJ-0079jC-0m;
	Sat, 16 Mar 2024 08:37:05 +0100
Date: Sat, 16 Mar 2024 08:37:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL] siox changes for 6.9
Message-ID: <k7pd3oar3e3mogaokjl7mykqy3w3cifl4dgbukmnsynyqgk5ze@ch5mn5xln2j7>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ad141dd22c7d95ad0bd347f257ce586e1afb22a4.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ftvih5huvc72a76s7fe4zisrqtaax5tcgoukqoi2bkz47zcrq2@4fixszonixgl>
 <2024030732-ocean-handbook-161f@gregkh>
 <nuchb5aaywc5vr6cof4gqbavq4rkte3hvzgs6au3lbg6s6wlq4@bvbjevbum7kc>
 <o52ptgjxknpxhtyemb5xdjyobidejvzluicsoc5ceajy4pz4xy@6e3aecoiz7eh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bkoh2y6adlbtsnww"
Content-Disposition: inline
In-Reply-To: <o52ptgjxknpxhtyemb5xdjyobidejvzluicsoc5ceajy4pz4xy@6e3aecoiz7eh>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--bkoh2y6adlbtsnww
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

[Cc +=3D Linus]

On Fri, Mar 08, 2024 at 10:20:05PM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Mar 07, 2024 at 09:38:07AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Mar 07, 2024 at 07:29:59AM +0000, Greg Kroah-Hartman wrote:
> > > Can you send me a "real" git pull request so that I can verify it is
> > > what you say it is (ideally with a signed tag)?
> >=20
> > Sure, can do. I will do that tomorrow when (and if) my branch is in next
> > and so got a bit more exposure.
>=20
> That has worked so far. So here comes the requested pull request. I
> dropped the two patches you collected in the meantime in your
> char-misc-next branch. The two branches (i.e. your char-misc-next and
> this PR's tag) merge without conflict.
>=20
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd3=
3d:
>=20
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags=
/siox/for-greg-6.9-rc1
>=20
> for you to fetch changes up to db418d5f1ca5b7bafc8eaa9393ea18a7901bb0ed:
>=20
>   siox: bus-gpio: Simplify using devm_siox_* functions (2024-03-08 22:01:=
10 +0100)
>=20
> Please pull this for the 6.9-rc1 merge window.

I didn't hear anything back from you and wonder if there is still a
chance to get this in. I guess that's just you being busy with other
(and more important) stuff. Would it help you if I sent a pull request
to Linus directly?

The changes are in next leading to db418d5f1ca5 since next-20240308. (As
db418d5f1ca since next-20240312, I rebased as two of the six siox
patches got into char-misc-next that were picked up directly from the
mailing list. Before the rebase it was 4ab973203404.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bkoh2y6adlbtsnww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmX1TB8ACgkQj4D7WH0S
/k6UmwgArdQWnLibF7drGcUxPzGwBs3eriG3Mm+7qvYdwmB2afWTrUJbpG7Jc7ES
BN3opcMXWqv6gry1UXTzN/c9QGrQJcc7l00WJv/yHTCvvFI1BRZp0p0AeC9kGL1q
L/m2EOieWlAiSYNSwMuS52JbS12zV/HO4gGlnKv4saQC4RvdREAgsMOGT3gm9Xum
xPBUm1MEip00Yvf6W4EOsSLys9nw/9g4E0qbiW379wtNbko/0zXrj+EItYBtu7OA
xnaQdNCVAV442aAJayyqecsBh+HetXe77JlSA7SyVpMNMqNnLwfwEeMkMW99Tj8e
iqBQGjxdxu6FGHkN+omTw5C/AjLlhQ==
=jRKH
-----END PGP SIGNATURE-----

--bkoh2y6adlbtsnww--

