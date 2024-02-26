Return-Path: <linux-kernel+bounces-80350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5151866713
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B431F21467
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 00:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957FD33EC;
	Mon, 26 Feb 2024 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QJOXE1g/"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FB173;
	Mon, 26 Feb 2024 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708905828; cv=none; b=ZaFPbCjdvdLF4qj1pgGHVeevtb1Vg0dj7BntTyxrv8PXqMtSewxLravEEPn2HshuS3qJxs7L3XJIuXxj6VLl11G/dOjTDY7zPd4GI1/zALNh1ZVm/8cItInO+HpykNILpwGY0+t/Sxy5RxoyX7tPYljnWEJRPSW6XxWx+tvlj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708905828; c=relaxed/simple;
	bh=fnEvOrO1k5JWNVipLI8U/c/k/XQR9Ok+LP4dmL8s0Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nbUxp9IVcmlOXZGZL15f5pPOgtoKCIa21c48j2kamoLz3H5zVpHmtARhsaKW5hRMvGEhoG4TLJzom8142NgClLhtGrxS8+99ubSUTesofY86TR/+nf1FU6aeKA3oKypaVBmujnBiuckmR/nGWVfAeZvDqmECVwaTqTesp5ohtsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=QJOXE1g/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708905824;
	bh=1fAQ2/PKsEagwRfg9sC2E9Bl6mn8gmCy2OfiKeNgfi8=;
	h=Date:From:To:Cc:Subject:From;
	b=QJOXE1g/K4bhGQnk/NYbLOB5HAA1A1Sa36fbEb8MAIPguMk7o9O9xJAr+zrkN2Lc5
	 gVebqt71q69rDd0LW54xNYPxeRCnt9dJvGIOYqUw9srlTMA/m+Jfl/CuBiyXczf4+j
	 YZ5PU4F79vdW6xn8scntX4tX2Sb2egxjoQUa/oPAmVdtZ9XTjDX0p1iatClv+sGeCF
	 uzbBQc8fWirQT+o0r0aW7dbpalCyOfsAD1v2qvbTQp5VO6wa59KodCyX+/OFiZ1RVn
	 EnLwSMs+N5OaKkCUiWMDcnr74vD9sT3ZT/Jp0SUQQVikGbQ0JNRzpK8Fbj/3tuq1DR
	 2UQU4wgO3b0AQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TjgnX1ZBYz4wc8;
	Mon, 26 Feb 2024 11:03:44 +1100 (AEDT)
Date: Mon, 26 Feb 2024 11:03:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Steve French
 <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the cifs tree
Message-ID: <20240226110343.28e340eb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qI5ugzFz2F5LCxVdGo=J9Ul";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qI5ugzFz2F5LCxVdGo=J9Ul
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/smb/client/file.c

between commit:

  d7e87923939a ("cifs: Fix writeback data corruption")

from the cifs tree and commit:

  a69ce85ec9af ("filelock: split common fields into struct file_lock_core")

from the vfs-brauner tree.

Please do not do unrelated white space cleanups ...

I fixed it up (I used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/qI5ugzFz2F5LCxVdGo=J9Ul
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXb1V8ACgkQAVBC80lX
0GwUmwf/am9zWAuEqziEydqmjGDaawepn69ZqkkZRw+Xo6PLS25lKY8UbvL1ozZj
bOrTe+Pxj49Tlh9DPmhnxQxGb4kUDANJp7WeP3Uts6zEPbiCkceqdDYbFkjzFMQ3
CZPeRZZ2urX5WOsjCDhWch5yQDYCeVammx+YnEgTYu4ZqF1qw0zqAqpiGvM5+Tvn
sm7He1Fw7phJwVDo2fJsXfDMRD7PHWYvec3A5Unv3O82qf+UEGcDIcYYS933VrPz
iHyj0iMHgvXvz7L6QUBVzxZd2ewJVUtN/h3msws4dhuH+4AcyXo58KcnoC1ANRcw
z2ovBoRbOj5zQQMOWcp+N4EcmF5Lyg==
=eT63
-----END PGP SIGNATURE-----

--Sig_/qI5ugzFz2F5LCxVdGo=J9Ul--

