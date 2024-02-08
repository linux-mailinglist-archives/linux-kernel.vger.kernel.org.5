Return-Path: <linux-kernel+bounces-57436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A383284D90E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 04:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492801F22762
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC072262B;
	Thu,  8 Feb 2024 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tVqWo7a5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9220311;
	Thu,  8 Feb 2024 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707363750; cv=none; b=G4tFp06zttipj+8gBeANP02kIcYxQt4ta7XdxCQhqlsgrnaiqw29GGr/Uy/Q46ueGgR86AcjJ7ITjqRRzBR5J6ioY4w3ymCn7x+AdHXSBZOeOeJt+eo+MeXHGN6PvizFlFD5/9co5K3ZeA7ssAIibJxDdQ7YczCeWm+VNboYv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707363750; c=relaxed/simple;
	bh=lzBBRC9iLhPy2bcYVby6zuMRE3b2v79SRR4z0QBuHtc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OMR+8mTwUmVfDl+88cYdnMBrSQk6EY9kxfjCexXakFmLoAmaNxtxF0FEtWHnLZc5f7uXXDCsBv+BZjqcDD+0qKzieEkwJM7bdA+mPFbcffozrHeG/hBICvncE3TuSeQD5iQeaCkMNomJcFwBTr+g9ROuZpiU5sK82vD2ziZvMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tVqWo7a5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707363746;
	bh=/ricgX3YbeLiF9GHdwbG+o/omDAnntZIhXV429DZHx4=;
	h=Date:From:To:Cc:Subject:From;
	b=tVqWo7a5kdbPiIP5y6gZcCXEa8IvlTxD6iXWMUivYFz7Bc/Kk4NgXYP4Np7izfQFV
	 ikTQk8Ns++T3jWgKoyo6Sid0r7YWYWxpv6f6WHEnBwHyVYUblJNOAe5HM1zX+8WKAH
	 0So9UzYRZtWQcR7qqXUkff5n0tLsn2vaNEFT5yKb7IYZS1csKc64WrIsuDAXpSWeDu
	 bqG9fZgLHouPNo0ne0LO9l3JPZdQoU9dYTSF3nOYhye/2RAOWKZ13aelRpdvi2OoSC
	 jBMVnc+kprGm1zn6y8RFAkJbRT/hT+VNlR/8bJJYaTenFocFLmgDH8jqJ1uVWVyoUE
	 gGldNgNhyq1iQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVjVB0lTPz4wcV;
	Thu,  8 Feb 2024 14:42:25 +1100 (AEDT)
Date: Thu, 8 Feb 2024 14:42:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20240208144225.3bc09ff2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jFrHdLcLHIbHv2/M5avlCgK";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/jFrHdLcLHIbHv2/M5avlCgK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (i386 defconfig)
failed like this:

In file included from include/linux/i2c.h:13,
                 from include/uapi/linux/fb.h:6,
                 from include/linux/fb.h:7,
                 from include/linux/backlight.h:13,
                 from drivers/acpi/acpi_video.c:19:
drivers/acpi/acpi_video.c: In function 'acpi_video_device_EDID':
drivers/acpi/acpi_video.c:643:34: error: format '%ld' expects argument of t=
ype 'long int', but argument 4 has type 'ssize_t' {aka 'int'} [-Werror=3Dfo=
rmat=3D]
  643 |                                  "Invalid _DDC data for length %ld\=
n", length);
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~  ~~~~~~
      |                                                                    =
    |
      |                                                                    =
    ssize_t {aka int}
include/linux/acpi.h:1224:56: note: in definition of macro 'acpi_handle_deb=
ug'
 1224 |                 acpi_handle_printk(KERN_DEBUG, handle, fmt, ##__VA_=
ARGS__); \
      |                                                        ^~~
drivers/acpi/acpi_video.c:643:66: note: format string is defined here
  643 |                                  "Invalid _DDC data for length %ld\=
n", length);
      |                                                                ~~^
      |                                                                  |
      |                                                                  lo=
ng int
      |                                                                %d

Caused by commit

  9e9c41c069ce ("ACPI: video: Handle fetching EDID that is longer than 256 =
bytes")

Presumably it should be %zd.

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/jFrHdLcLHIbHv2/M5avlCgK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXETaEACgkQAVBC80lX
0Gy1Jwf6AhBae1ebz1pfK2INgS/4GDPVvNuloqRi111vCAnZ3LaST0XAUow7JMy2
DjX0PvyMDA+XART9UY4b2wsQqKg+9AqJPicvV+ENg6O+SHwMe7ioBS8B1PS5fOiC
pDzb30nvZWhqdidV+4h8BUI11FPELVQVbGM1XI17nLN6GhwAtfMu6QLv/goKgnJ2
7sPTuXj2zQ23xg6+4MZ6+UwHNr9WHS1d/ZV4S+kbACrhjLnw7QzlwXPTfxos1ZWt
OPxkCHa9Ni46m36O/I+ujawQKhsFchRQHPUAN8tMA6Ldh1cQhkAOPtpQdpRl1X2L
egnHMBNCoZrt770QxTXA3D/VWTLDiw==
=jUx8
-----END PGP SIGNATURE-----

--Sig_/jFrHdLcLHIbHv2/M5avlCgK--

