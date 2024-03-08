Return-Path: <linux-kernel+bounces-97596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AADE876C53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93929B211D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE85FBA7;
	Fri,  8 Mar 2024 21:20:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3C5E08E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932813; cv=none; b=hjugEAG3IMQBlDUgaJEkMRo0D6htazRnX0vN/mjS/rHTZvDs4bGxaVI5Uj2YI4PZHoBcPq6m1d4u+fP4NpBZbKdwZzQd6CW8N5ASDkxtszG9/kB9U07YmZ5LsFWfBHWp5hV4IO469parPuFbyIRt+S0Jk1VC92NAAWx2dXS/p2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932813; c=relaxed/simple;
	bh=8TKM2G1utLgMWASRIHyb76DCmGBEYaEoOZTLkFlHcKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RL9kbHxPsuE7dOlSYgRqAA3aoX5uiVzxLglOVRimHqmJ8JqheDNSJHHyzBimrPIuwiL34y7ugvi7qTm1ZIaXRKKFMSOTsM9u2qO98TnvueW/OJZMX9fDkV9ZFoN+lIM4raJsRUtCJVk99//WFYWsjBPSv3FLv2xwT38RKnwe3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rihdO-00081X-JV; Fri, 08 Mar 2024 22:20:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rihdO-005Cz6-2V; Fri, 08 Mar 2024 22:20:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rihdN-002WI0-3B;
	Fri, 08 Mar 2024 22:20:05 +0100
Date: Fri, 8 Mar 2024 22:20:05 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PULL] siox changes for 6.9
Message-ID: <o52ptgjxknpxhtyemb5xdjyobidejvzluicsoc5ceajy4pz4xy@6e3aecoiz7eh>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ad141dd22c7d95ad0bd347f257ce586e1afb22a4.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ftvih5huvc72a76s7fe4zisrqtaax5tcgoukqoi2bkz47zcrq2@4fixszonixgl>
 <2024030732-ocean-handbook-161f@gregkh>
 <nuchb5aaywc5vr6cof4gqbavq4rkte3hvzgs6au3lbg6s6wlq4@bvbjevbum7kc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kfwe5w54khiwgr55"
Content-Disposition: inline
In-Reply-To: <nuchb5aaywc5vr6cof4gqbavq4rkte3hvzgs6au3lbg6s6wlq4@bvbjevbum7kc>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--kfwe5w54khiwgr55
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Thu, Mar 07, 2024 at 09:38:07AM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Mar 07, 2024 at 07:29:59AM +0000, Greg Kroah-Hartman wrote:
> > Can you send me a "real" git pull request so that I can verify it is
> > what you say it is (ideally with a signed tag)?
>=20
> Sure, can do. I will do that tomorrow when (and if) my branch is in next
> and so got a bit more exposure.

That has worked so far. So here comes the requested pull request. I
dropped the two patches you collected in the meantime in your
char-misc-next branch. The two branches (i.e. your char-misc-next and
this PR's tag) merge without conflict.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/s=
iox/for-greg-6.9-rc1

for you to fetch changes up to db418d5f1ca5b7bafc8eaa9393ea18a7901bb0ed:

  siox: bus-gpio: Simplify using devm_siox_* functions (2024-03-08 22:01:10=
 +0100)

Please pull this for the 6.9-rc1 merge window.

Thanks
Uwe

----------------------------------------------------------------
SIOX changes for 6.9-rc1

These patches rework how siox device registration works. This allows to
simplify the gpio bus driver using two new devm functions.

----------------------------------------------------------------
Uwe Kleine-K=F6nig (4):
      siox: Don't pass the reference on a master in siox_master_register()
      siox: Provide a devm variant of siox_master_alloc()
      siox: Provide a devm variant of siox_master_register()
      siox: bus-gpio: Simplify using devm_siox_* functions

 drivers/siox/siox-bus-gpio.c | 62 ++++++++++++++--------------------------=
----
 drivers/siox/siox-core.c     | 46 ++++++++++++++++++++++++++++++++
 drivers/siox/siox.h          |  4 +++
 3 files changed, 70 insertions(+), 42 deletions(-)

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kfwe5w54khiwgr55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXrgQQACgkQj4D7WH0S
/k5gmQf/fMpsx2ugsO8+79yEYNO5NU6YEAOSDsboapH9aqL3/8C6pRHArpoIJdTv
WklB1GQHrrsvVf/Utl3ejNbtP3TlAJR1RU8aJ+OFFBinppdaK9zRAmZBDlvytcTk
jU+0pKwq9hs5y91IzUlVPr/yykY9cNuG8SyBi8Bwmt8XwSzpi56w2cCcFTJZCU1J
jYRFZJEZ8HwZzk+nZO8PdW5OWw4p2fIzFbrHSRqD38+3PKz4+GndPoseNww5Tg+E
AsQ73ej0jPUlH522vzR3hGCPNjvNv5AY75blYQ3+9W4g2jFn5FVxGiunG9sEIVJF
TgVtF4pEm97fGoYcJSxw/KGLlkYeSQ==
=jwSB
-----END PGP SIGNATURE-----

--kfwe5w54khiwgr55--

