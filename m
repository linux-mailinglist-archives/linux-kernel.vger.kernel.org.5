Return-Path: <linux-kernel+bounces-105576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0ACC87E0A7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2181F210B3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2967D21105;
	Sun, 17 Mar 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HwJd6V29"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B60208C3;
	Sun, 17 Mar 2024 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710713883; cv=none; b=MyxvsL7sGfG/8HOYCuQsi7AgWwCUzZ+Se2lVLhRls7gYJC1mC8ZFXX+hEWoaCbSwyxDyAXTqQ5/GHggNANDjSQURPJppCCN8Klh23f/nAk2hoTBODEMifC1iotOILtvIsh2z1rQWeR6fRNS13EawhL0xZtGY2mfiVFA/BJcQ6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710713883; c=relaxed/simple;
	bh=nWdR6SqADhA51kuEkeK0ctmtF/15R2BgpkZTF1ggYlk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ar4EPLucB+ffWBjGCx9CP5lhn7XG4C7kT+NukeT6esdNUcOdY+HTImN4xc+0jyj0Ru6v1vRVX/WSv/tYZBlHlGNtrNRFHZuKwnW+liQi8BA968jst79OJNCYLvDcoZJRds5vh8eUNAgzOmHckEAs/Li4TWlEqpFPq8JT0bBNx/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=HwJd6V29; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710713877;
	bh=axKNvvyMK/UlmUL98w4a1tTPpghQtaaNyqLWtMBk7VI=;
	h=Date:From:To:Cc:Subject:From;
	b=HwJd6V29ZE+ZoTXsNH81WmLuQRrXk3yU5h3wqMDeUjDfWFBAJBDAohltwKQqcn7D/
	 oz1Vq3T7FuPWSl9cq7mu2xQ9FCvk+X1i1gCMlXURqtNb48QI7CybIbRsmpqZSXxIhZ
	 4PMVZA1xcWpSOVbVfwTPI2GVvm89/s3MskeCVn/fYkRECRghb36i8YkYk/+Fj3PBGg
	 +4BKK/uPAm7Kicb+8eSKZx2/cWwXaBs7Ti7y+kLZZFFNR7dvxs12EdtHkZqR0/hCJH
	 qs10B5EEw8J1tHMYjrgBd8uxCLtc3WE/LXEZryV4KgXirXSQBBtOMUZoVePxZJV1zH
	 Mlv24CiTr3EmQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TyXRm5zWpz4wcQ;
	Mon, 18 Mar 2024 09:17:56 +1100 (AEDT)
Date: Mon, 18 Mar 2024 09:17:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Christian Brauner
 <brauner@kernel.org>
Subject: linux-next: build failure after merge of the btrfs-fixes tree
Message-ID: <20240318091755.1d0f696f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ekYdt.4IWTaM6d9VF5WnO2d";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ekYdt.4IWTaM6d9VF5WnO2d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the btrfs-fixes tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

fs/btrfs/volumes.c: In function 'btrfs_scan_one_device':
fs/btrfs/volumes.c:1413:55: error: 'bdev_handle' undeclared (first use in t=
his function)
 1413 |         if (btrfs_skip_registration(disk_super, path, bdev_handle->=
bdev->bd_dev,
      |                                                       ^~~~~~~~~~~
fs/btrfs/volumes.c:1413:55: note: each undeclared identifier is reported on=
ly once for each function it appears in

Caused by commit

  cc019bc0d55b ("btrfs: do not skip re-registration for the mounted device")

I have used the btrfs-fixes tree from next-20240315 for today.

This is actually caused by an interaction with commit

  9ae061cf2a46 ("btrfs: port device access to file")

which has been in Linus' tree since March 12 (and linux-next since Feb 26).
--=20
Cheers,
Stephen Rothwell

--Sig_/ekYdt.4IWTaM6d9VF5WnO2d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX3bBMACgkQAVBC80lX
0Gya0wf/Rw9aRRRX0gEmPwpmD5rZ/f0GcOhHksY531T87P1KduQBP62VnkSYDwdv
qYjg3FqWBy3rNYL9wri8CPT4aYxTabCEIo5IVKbTThOajAXy+UhnnKPm7ooBB6e0
XmRoxQTFvkL6O4I7DL746GSBy+X5m8wI7ymHq8+6BZcav++gKFqPx0KO32Jlu9Yf
JwIXS/HAducVVSHMiO2oSNyZM46DISOWgxTsm+/jfesAwnkfO9vAe3ha7RRSwFI+
Lemwx/LHreZUMuRsmX17lOHR17TvL9uR9l3XblouEeydn921fjtw5vwvQ62AJyyF
8NieG2KsEt3wnVJFhc9U+mIUvJChdw==
=3LA5
-----END PGP SIGNATURE-----

--Sig_/ekYdt.4IWTaM6d9VF5WnO2d--

