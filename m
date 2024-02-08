Return-Path: <linux-kernel+bounces-58753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A184EB10
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD5C1C23631
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4184F61E;
	Thu,  8 Feb 2024 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI8dmYlj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7364F5F2;
	Thu,  8 Feb 2024 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429665; cv=none; b=QUJFChV61LV1mYYpQdUwbs0z6WBmEU3H26fUyyQZRx3eAPFWePtnBP2SS/m2jBUJhjcNQ62efPN75FwX6Z8J2uYU5/YgUmo/Al29ysuaPGgNcPn+CfrKmKN/nMaxU/+cCQtel1UfJmtvvEMmYFkW1QMD7eT/k/V0trTz5LSO9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429665; c=relaxed/simple;
	bh=8o6YNAeT/tziwxPCb43CHtTeCsR1HTefiU0zavxatS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrGM8LRshrR6k/2C+qLpUDlUjgaUEZivpE+SaDe38mIu18b897g/Yf6SXwR5Ij7fBwGwTEib1TjJX0qLqDi5+MJpqdHStrArFvOW6QY6Q0vk/KvRojTCMsD1uh65t71cegV4SwtO28eOZQd4NpcqHYgLX/y5xwEz/yYmPxii9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI8dmYlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD48CC43390;
	Thu,  8 Feb 2024 22:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707429665;
	bh=8o6YNAeT/tziwxPCb43CHtTeCsR1HTefiU0zavxatS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OI8dmYljat2y9Xo9Z7wa/MVYiUX5CsJS4r2BHJ90HRXDFkCz2k7KR2XnFQk4BTs9G
	 dbQLTRrBAxiYb1mhF0VhbMhzQFzGbkzntdGYF3haXly6Saa52B2mG03pc8QTHWZN6r
	 3BLupCSvfCyFRB4ossTBGE5wbRbIpXNmrbwmM5ZZXP53CDS2Pvwn4TEVerWN3jkM1U
	 eU6Vsmh7kYnuxzvoNTbWQoXz+0NyQcEDvbEK9/SAChB1H+BvsS898nmXXFYtrhblv1
	 eLMxDyGZbx1BCrpeB851cHsOb0uZveCegXKuRQyy7zapVaatQ4dfJV5vMjTeCgX47z
	 YP3Epak519G+Q==
Date: Thu, 8 Feb 2024 22:01:02 +0000
From: Mark Brown <broonie@kernel.org>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, linux@roeck-us.net,
	heikki.krogerus@linux.intel.com, kyletso@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	rdbabiera@google.com, amitsd@google.com, stable@vger.kernel.org,
	frank.wang@rock-chips.com, regressions@leemhuis.info
Subject: Re: [PATCH v2] Revert "usb: typec: tcpm: fix cc role at port reset"
Message-ID: <ZcVPHtPt2Dppe_9q@finisterre.sirena.org.uk>
References: <20240117114742.2587779-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8svY+Xz+hFFp4U70"
Content-Disposition: inline
In-Reply-To: <20240117114742.2587779-1-badhri@google.com>
X-Cookie: Measure twice, cut once.


--8svY+Xz+hFFp4U70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:47:42AM +0000, Badhri Jagan Sridharan wrote:
> This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.
>=20
> Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
> the CC pins, setting CC pins to default state during PORT_RESET
> breaks error recovery.

Between -rc2 and -rc3 I started seeing boot issues in mainline on
rk3399-roc-pc running arm64 defconfig, a bisection identified this patch
as having broken things.  The issues manifest as a hang while loading
modules from the initd, you can see a full boot log at:

   https://lava.sirena.org.uk/scheduler/job/558789

which shows a bunch of video drivers loading at the end of the log but I
suspect that's not related the actual failure.  A successful boot can be
seen here:

   https://lava.sirena.org.uk/scheduler/job/559222

I do note that the board is powered by USB PD, I've got it connected to
a PD power supply which seems potentially relevant to the commit.  The
board had been working for a long time, at least as far as boot to
initrd goes.

Full bisect log:

git bisect start
# status: waiting for both good and bad commits
# bad: [54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478] Linux 6.8-rc3
git bisect bad 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
# status: waiting for good commit(s), bad commit known
# good: [41bccc98fb7931d63d03f326a746ac4d429c1dd3] Linux 6.8-rc2
git bisect good 41bccc98fb7931d63d03f326a746ac4d429c1dd3
# good: [4f18d3fd2975c943be91522d86257806374881b9] Merge tag 'iommu-fixes-v=
6.8-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
git bisect good 4f18d3fd2975c943be91522d86257806374881b9
# good: [6b89b6af459fdd6f2741d0c2e33c67af8193697e] Merge tag 'gfs2-v6.8-rc2=
-revert' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
git bisect good 6b89b6af459fdd6f2741d0c2e33c67af8193697e
# good: [bdda52cc664caaf030fdaf51dd715ef5d1f14a26] Merge tag 'i2c-for-6.8-r=
c3' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect good bdda52cc664caaf030fdaf51dd715ef5d1f14a26
# bad: [0214960971939697f1499239398874cfc3a52d69] Merge tag 'tty-6.8-rc3' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect bad 0214960971939697f1499239398874cfc3a52d69
# bad: [3caf2b2ad7334ef35f55b95f3e1b138c6f77b368] usb: ulpi: Fix debugfs di=
rectory leak
git bisect bad 3caf2b2ad7334ef35f55b95f3e1b138c6f77b368
# good: [7c4650ded49e5b88929ecbbb631efb8b0838e811] xhci: handle isoc Babble=
 and Buffer Overrun events properly
git bisect good 7c4650ded49e5b88929ecbbb631efb8b0838e811
# good: [cc509b6a47e7c8998d9e41c273191299d5d9d631] usb: chipidea: core: han=
dle power lost in workqueue
git bisect good cc509b6a47e7c8998d9e41c273191299d5d9d631
# good: [b2d2d7ea0dd09802cf5a0545bf54d8ad8987d20c] usb: f_mass_storage: for=
bid async queue when shutdown happen
git bisect good b2d2d7ea0dd09802cf5a0545bf54d8ad8987d20c
# bad: [b717dfbf73e842d15174699fe2c6ee4fdde8aa1f] Revert "usb: typec: tcpm:=
 fix cc role at port reset"
git bisect bad b717dfbf73e842d15174699fe2c6ee4fdde8aa1f
# good: [032178972f8e992b90f9794a13265fec8c8314b0] usb: gadget: pch_udc: fi=
x an Excess kernel-doc warning
git bisect good 032178972f8e992b90f9794a13265fec8c8314b0
# first bad commit: [b717dfbf73e842d15174699fe2c6ee4fdde8aa1f] Revert "usb:=
 typec: tcpm: fix cc role at port reset"

--8svY+Xz+hFFp4U70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXFTx0ACgkQJNaLcl1U
h9CX5gf9EbKGGM1ko9HMo9mS3/UGzMOECrFkz8hxo+Ym5OweBAUpcHlq0+LGV3/j
P1nbV3l51yY8VlTVxIopF57qfag4US2NvHRIkP0iXfFsNPM9j/bsfDnc6FQd5cUA
ppLLUPbYeFg3vDiM8J35iYWT3GOWnOGzHdu9s6fdKQmDyvw6BlhI+th2LGLGHcDz
G14cUM/KCfPXwUCPEGyDiMwEj64G1zopwjEBpUqemnHxe5dEiWTUETGRHjFMuzvT
2a0tqQfoJVAH9TMsJEdItCQ3TeQS8XtUHZF55nZ73vZu5NqAkEAzNMV22pfw6gOm
RxqQkMC/EcrkK3/Pzd/PrLZb6pezkg==
=rxBM
-----END PGP SIGNATURE-----

--8svY+Xz+hFFp4U70--

