Return-Path: <linux-kernel+bounces-29780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A88831351
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988B61C2283B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1780DC126;
	Thu, 18 Jan 2024 07:46:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F8BE50
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563982; cv=none; b=K13h7rigYlugzji9aJkBwHqpXHsxVqQ0n3gO5BS6lhoV10YUbTKnXjMmIft8Drdj6rk5M+topumsuRbER49HtupTodyAHz5fBnJF1TU6pXdDS+M5xzgOBHYjapyl6b8QFaHgBKY/3nlpb2rj4VfDhJiUPrMTlnChZ5JWg6B7850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563982; c=relaxed/simple;
	bh=I+AwgK7hDw+c6EEynL5Kyfwmh9VClF8/96eM8ycGszg=;
	h=Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-SA-Exim-Scanned:X-PTX-Original-Recipient; b=ZxjLeN3biqbFnOKrvvyJkDWnNrITOhFdkP3iVcMiSWc4HPaQzPKEY++InD9SeHv2Zwx9pnItG71qOg+O37c/lDK0z+CxDZXSfu3ywAat5a5H/CrmKrpxPeyRoRLyL/mt4b1JcqKVNnfdBsJ0NrPh334i0bEyS4zLLovNEqbNDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQN5p-000356-TN; Thu, 18 Jan 2024 08:45:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQN5m-000dlb-1S; Thu, 18 Jan 2024 08:45:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQN5l-002Fc2-30;
	Thu, 18 Jan 2024 08:45:37 +0100
Date: Thu, 18 Jan 2024 08:45:37 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Javier Martinez Canillas <javierm@redhat.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Prathu Baronia <prathubaronia2011@gmail.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Sui Jingfeng <suijingfeng@loongson.cn>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-parisc@vger.kernel.org
Subject: Re: [BUG][BISECTED] Freeze at loading init ramdisk
Message-ID: <gevqxytidg5efylozindaqntkbl4yeoyzqnh5m3ylitmipgum3@sgmv7qieo7rs>
References: <8a6aa228-f2da-4dcd-93c1-e34614cd6471@alu.unizg.hr>
 <cc813525-5484-443e-a40a-cb98f2ed4e1f@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vrvcwpg6gkakpejo"
Content-Disposition: inline
In-Reply-To: <cc813525-5484-443e-a40a-cb98f2ed4e1f@alu.unizg.hr>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--vrvcwpg6gkakpejo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mirsad,

On Wed, Jan 17, 2024 at 07:47:49PM +0100, Mirsad Todorovac wrote:
> On 1/16/24 01:32, Mirsad Todorovac wrote:
> > On the Ubuntu 22.04 LTS Jammy platform, on a mainline vanilla torvalds =
tree kernel, the boot
> > freezes upon first two lines and before any systemd messages.
> >=20
> > (Please find the config attached.)
> >=20
> > Bisecting the bug led to this result:
> >=20
> > marvin@defiant:~/linux/kernel/linux_torvalds$ git bisect good
> > d97a78423c33f68ca6543de510a409167baed6f5 is the first bad commit
> > commit d97a78423c33f68ca6543de510a409167baed6f5
> > Merge: 61da593f4458 689237ab37c5
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:=A0=A0 Fri Jan 12 14:38:08 2024 -0800
> >=20
> > [...]
> >=20
> > Hope this helps.
>=20
> P.S.
>=20
> As I see that this is a larger merge commit, with 5K+ lines changed, I do=
n't think I can
> bisect further to determine the culprit.

Actually it's not that hard. If a merge commit is the first bad commit
for a bisection, either the merge wasn't done correctly (less likely,
looking at d97a78423c33f68ca6543de510a409167baed6f5 I'd bet this isn't
the problem); or changes on different sides conflict or you did
something wrong during bisection.

To rule out the third option, you can just retest d97a78423c33,
61da593f4458 and 689237ab37c5. If d97a78423c33 is the only bad one, you
did it right.

Then to further debug the second option you can find out the offending
commit on each side with a bisection as follows, here for the RHS (i.e.
689237ab37c5):

	git bisect start 689237ab37c5 $(git merge-base 61da593f4458 689237ab37c5)

and then in each bisection step do:

	git merge --no-commit 61da593f4458
	test if the problem is present
	git reset --hard
	git bisect good/bad

In this case you get merge conflicts in drivers/video/fbdev/amba-clcd.c
and drivers/video/fbdev/vermilion/vermilion.c. In the assumption that
you don't have these enabled in your .config, you can just ignore these.

Side note: A problem during bisection can be that the .config changes
along the process. You should put your config into (say)
arch/x86/configs/lala_defconfig and do

	make lala_defconfig

before building each step to prevent this.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vrvcwpg6gkakpejo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWo1yAACgkQj4D7WH0S
/k7q0Qf/W0t/IirzZUaGB+CH/LGga+7j/KLL5uCh7l6cqhTW1WPWQm1GuEidN2KK
Hw1/HRMjxHlFtrZWoKVrXpT8mtNXb+vVSIQwxPItzFprY2c1aip9azmc95CcUjx1
kiVbkKYhwoO93CVo5y9k8dRiapAKGqJ3om5WYeGhaaP7O2id0H/QMHpDC8IUd6vk
5+UKkqzUznooHGbxuNYhpRUVKaeZZW4yK9fcT6YfFCSqRcYcB/wJ0vfvX4+4nSf6
0NVvZo3kvwhaTuvX5CjgD49kr5WRRcnypUE/2UwVSdChUyUTnx15+cKnvnYCkPQ5
Rbed4l9pWRYUp8DZAnt65Xl9tHMvxA==
=OgfD
-----END PGP SIGNATURE-----

--vrvcwpg6gkakpejo--

