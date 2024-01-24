Return-Path: <linux-kernel+bounces-36267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FA2839E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667591C27B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B084417CD;
	Wed, 24 Jan 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YmOWnwON"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B910E5;
	Wed, 24 Jan 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059246; cv=none; b=J2E0jEW+/aewpLE3LzdCzjfnbli52+2kb2H55KR/yHbOd6Lgle/IFVJm6kwxYgJXUTpLcRuzzJxmDSoexAVBuAaUw5qHZAd6nD+xheAHK/l+mJ+dHG2bcAgeSArN+co5bp/huAKLaGgty0m52vFkses8xL4Xo9ZoK11GnB4+XCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059246; c=relaxed/simple;
	bh=DlUG2Zfv+VlC9R78AA7XXMcscCle7LDwie4DRrQrrS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkSnCHumjwonKCB7lfx3L8YkYdb63QoKLOuE0fXhXDiroOeMhvCMsfdoqihkLQoXIcf6RrF/XMC/JkoXa0oG0IFeZWKALQ1mGvQWaSYTk4kNMYsuNiEBY/FzSxb839gTac3mh3Rxkx5V9iCIoHgQsztq7MFPIMyJoxrHJLxM5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YmOWnwON; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706059241;
	bh=asYAKAHzzR5q9ebahZtAuIYyNofHyBLRh6/Ww9HqgsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YmOWnwONzpqZisp4gxI7yM1h9NcFd/B4O8H+4A64RQa65JxJ+A5weP5QMdFm3LhFZ
	 /OPbSydxNhOo/zl5JoXq7N4soubnk/aLNoXoc7Xcl44zvdljJB6v9RLpIyYLmJR8Xd
	 b0T3lAdm3/t5JJzpduy21xoxaxE58SVIg9fBItlDXfSY4eIniseNZdaBDkSDGGSjFU
	 kf2f4w32KeGskWTv2UrIUBddUk2/37FnY/v+jQ7aSvHL3Huyf/Hm80+R6i4Zi8QSDR
	 N33mi1dVodAQPtEtuoOJtwdLA2gkQUFVY0SO77eRTqfphv1F1ANRpUNmy0ho5/ycNz
	 dt9Pqd4kekLcA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKR3Y1Bxjz4wby;
	Wed, 24 Jan 2024 12:20:41 +1100 (AEDT)
Date: Wed, 24 Jan 2024 12:20:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20240124122040.04cd2c8a@canb.auug.org.au>
In-Reply-To: <20240123125227.0521c8d9@canb.auug.org.au>
References: <20240123125227.0521c8d9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oWBOxkiS20m+fB2I4rUQ7ZR";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/oWBOxkiS20m+fB2I4rUQ7ZR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 23 Jan 2024 12:52:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the vfs-brauner tree, today's linux-next build (powerpc
> allnoconfig) failed like this:
>=20
> In file included from <command-line>:
> In function 'i_size_read',
>     inlined from '__iomap_dio_rw' at fs/iomap/direct-io.c:570:16:
> include/linux/compiler_types.h:435:45: error: call to '__compiletime_asse=
rt_229' declared with attribute error: Need native word sized stores/loads =
for atomicity.
>   435 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |                                             ^
> include/linux/compiler_types.h:416:25: note: in definition of macro '__co=
mpiletime_assert'
>   416 |                         prefix ## suffix();                      =
       \
>       |                         ^~~~~~
> include/linux/compiler_types.h:435:9: note: in expansion of macro '_compi=
letime_assert'
>   435 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/compiler_types.h:438:9: note: in expansion of macro 'compil=
etime_assert'
>   438 |         compiletime_assert(__native_word(t),                     =
       \
>       |         ^~~~~~~~~~~~~~~~~~
> include/asm-generic/barrier.h:206:9: note: in expansion of macro 'compile=
time_assert_atomic_type'
>   206 |         compiletime_assert_atomic_type(*p);                      =
       \
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/fs.h:911:16: note: in expansion of macro 'smp_load_acquire'
>   911 |         return smp_load_acquire(&inode->i_size);
>       |                ^~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   4bbd51d0f0ad ("fs: make the i_size_read/write helpers be smp_load_acqui=
re/store_release()")
>=20
> I have used the vfs-brauner tree from next-20240122 for today.

Pending a better resolution, today I have reverted that commit and the
following one.

--=20
Cheers,
Stephen Rothwell

--Sig_/oWBOxkiS20m+fB2I4rUQ7ZR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWwZegACgkQAVBC80lX
0GwPMAf9GnMCwBQOZ0NigjRc3FjjD1Y8bDXIXTo+EGovtHKenqWztRjLFB093BWP
dDxqGiNHBFRk/Qly4u8MX2EBRdbYF7S1W8nEF54DfbAJgZCH5ADnDYIdXR30/Zsl
nvhYbGdLI6BMzqB0axafN1Wcz2sRqh7h3MwimYXSNlAqvJdaoI0XXTMX0NPWityB
EUhOb7qO0IQXjGCQRMTITHElqd2qoTxHMa+WAPd408eTBlCxM+sjGwlbPs2GvQm0
pcp9DUr46Wm16xXDvUwaOUgIWGfw26XMmXqKFT3F9xJLyhzh8KncYuXy9xEESEV5
jbpHSFM4K1RTPB1Te/MZ44KuoHeC7A==
=Vnmt
-----END PGP SIGNATURE-----

--Sig_/oWBOxkiS20m+fB2I4rUQ7ZR--

