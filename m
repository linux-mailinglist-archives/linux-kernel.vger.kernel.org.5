Return-Path: <linux-kernel+bounces-27267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B002082ECF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D923B22C03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AFD18B06;
	Tue, 16 Jan 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="a1SnG66i"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6E17BBC;
	Tue, 16 Jan 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B91A11C0071; Tue, 16 Jan 2024 11:46:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1705402005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uJ6VNVEe3MQa3aVTkgyy1bVeVbAM3wMV1HKk86y3sEw=;
	b=a1SnG66iualXG5lAh86nGw5Eqoy1w1F657wNFWVxKHDjdTwolm7tmUO0PBNukU0k9dyY9N
	NAHwZjmRJAOlOkl67WpNPzvgCGdbx9hMoDwYyI5le9r1+0nGoLxDOxxYBVG8h7lFB34IF3
	5dHoQPkrDmzRWj+EeeKY9Mh9ipnXyYs=
Date: Tue, 16 Jan 2024 11:46:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tzimmermann@suse.de,
	Ziqi Zhao <astrajoan@yahoo.com>, Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
Subject: End of 4.14 autosel? Re: [PATCH AUTOSEL 4.14 3/6] drm/crtc: Fix
 uninit-value bug in drm_mode_setcrtc
Message-ID: <ZaZelbUWUsmYxLPB@duo.ucw.cz>
References: <20231218124725.1382738-1-sashal@kernel.org>
 <20231218124725.1382738-3-sashal@kernel.org>
 <87bkamvay5.fsf@intel.com>
 <ZaSlgTAz7vdk97JJ@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o+sd9barL1BWDrsW"
Content-Disposition: inline
In-Reply-To: <ZaSlgTAz7vdk97JJ@sashalap>


--o+sd9barL1BWDrsW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > From: Ziqi Zhao <astrajoan@yahoo.com>
> > >=20
> > > [ Upstream commit 3823119b9c2b5f9e9b760336f75bc989b805cde6 ]
> > >=20
> > > The connector_set contains uninitialized values when allocated with
> > > kmalloc_array. However, in the "out" branch, the logic assumes that a=
ny
> > > element in connector_set would be equal to NULL if failed to
> > > initialize, which causes the bug reported by Syzbot. The fix is to use
> > > an extra variable to keep track of how many connectors are initialized
> > > indeed, and use that variable to decrease any refcounts in the "out"
> > > branch.
> > >=20
> > > Reported-by: syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
> > > Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
> > > Reported-and-tested-by: syzbot+4fad2e57beb6397ab2fc@syzkaller.appspot=
mail.com
> > > Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > Link: https://lore.kernel.org/r/20230721161446.8602-1-astrajoan@yahoo=
=2Ecom
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> >=20
> > This commit fixes an uninitialized value, but introduces a new
> > one. Please backport 6e455f5dcdd1 ("drm/crtc: fix uninitialized variable
> > use") from v6.7-rc6 to go with it.
>=20
> I'll take 6e455f5dcdd1 too, thanks!

So, what is the status of 4.14-stable? Last one was
marked. .. well. .. as last one, so perhaps AUTOSEL should start
ignoring it, too?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--o+sd9barL1BWDrsW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZaZelQAKCRAw5/Bqldv6
8sdcAJ9rTyq5VQW4BNAizG86yFj6oniPRACgi8ro35eyUnFqN72aI2RVAxI1qYg=
=SCC6
-----END PGP SIGNATURE-----

--o+sd9barL1BWDrsW--

