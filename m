Return-Path: <linux-kernel+bounces-110696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1628A88628F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97351B223EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA313664C;
	Thu, 21 Mar 2024 21:33:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AE134CEF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711056799; cv=none; b=ibh9KAPPa+lVESZTQKnmPSQpQjrqNN82+H9O211llL43A5rBnFBxX3ReFAj6bJ+vsGWboJGxnrRpb69+P7DMqPf6h5ZC8vDEcWSw4bd7iCCJPVLO8J83ekwllWVo9dVm+q7Hf3x6YepIWXyJkgiwh8r8wtHqOXAyGlXx5kHwxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711056799; c=relaxed/simple;
	bh=yGZvNwp287SyuaKFmJmvxYqUmwCVUfZhZ91KnQ36oYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q4KHeUtbfwfhlPwpjYjgPVo01mIvhUEHW2MugHnIzS87sy9T+nRT+6CSJUJJjtzwmq51NcddFxiiCWEQ+ICjFPNYbghiZT/aQhJFSZHNGmhgO/fE664fRlK70nZKCkljac3gJY2L2k69pO/jwUKLUespU2AihMMzNDMmEwQlli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rnQ28-0000OQ-Gw; Thu, 21 Mar 2024 22:33:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rnQ27-007iyB-Ju; Thu, 21 Mar 2024 22:33:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rnQ27-009QLa-1i;
	Thu, 21 Mar 2024 22:33:07 +0100
Date: Thu, 21 Mar 2024 22:33:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Thorsten Scherer <t.scherer@eckelmann.de>
Subject: [GIT PULL] siox: Changes for v6.9-rc1
Message-ID: <7elhkk6kzp7dnx47j5dwmljgzoeefey27qecvkyp7y76jxc4th@k44dxrl3x6fp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="534r6pisrbqnipcc"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--534r6pisrbqnipcc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

I hoped these changes will reach you via Greg's char-misc pull request
but with Greg being mostly away from keyboard currently this fell
through the cracks. See
https://lore.kernel.org/lkml/k7pd3oar3e3mogaokjl7mykqy3w3cifl4dgbukmnsynyqg=
k5ze@ch5mn5xln2j7
for the conversation leading to my initial pull request to Greg. Now
that he sent his pull request for char-misc, I guess it's official that
these changes won't make it in via this path.

So I ask you directly to pull these changes for 6.9-rc1. The commits I
ask you to pull are in next since next-20240312. The changes were
already in next/20240308 leading to
4ab973203404e2b2499ddea62dac60ea34d4c572, I rebased these to drop two
patches that are part of Greg's char-misc PR. Git gets merging Greg's
char-misc branch and my branch right without problems even though both
change drivers/siox/siox-core.c.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/s=
iox/for-6.9-rc1

for you to fetch changes up to db418d5f1ca5b7bafc8eaa9393ea18a7901bb0ed:

  siox: bus-gpio: Simplify using devm_siox_* functions (2024-03-08 22:01:10=
 +0100)

I'd be glad if these made it into v6.9-rc1.

Thanks
Uwe

----------------------------------------------------------------
SIOX changes for 6.9-rc1

These patches rework how siox device registration works yielding a saner
API. This allows to simplify the gpio bus driver using two new devm
functions.

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

--534r6pisrbqnipcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmX8p5IACgkQj4D7WH0S
/k6rIggAs5jSoHJNKVm+1DGVAo2p7iRbacSd5Z473AUzJ/C8S+TfQjw82o/oldSY
kR1KUvLxvkRpX/Jb9sUrCraXEqKNZxUhtvCOqKrhIH04o+XaIKzmJOjVeBXIo39O
6e7oQWSzAcAoDT+bczj8oIHXYLXMznpdehXi2aYL+R9YKocHGof4km+C6E0FR9be
9zhw0oNBrjiaV3Udlrlori+mCQyf0PR7ir1n/j0o6BCRpwrwCreIFoaWUQB3NsJG
/SQGBvS8I2pHNWNn0TrHkgrvHC27FB83bqxRlsdUdYEIaVynp/mrLKLVSWVaT0G5
qO1IoXI6dTuDUyVEHyLqsdA++JjMyw==
=48b/
-----END PGP SIGNATURE-----

--534r6pisrbqnipcc--

