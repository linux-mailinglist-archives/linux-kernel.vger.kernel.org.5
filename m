Return-Path: <linux-kernel+bounces-147664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B78A7719
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87631F21F85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B1E6EB59;
	Tue, 16 Apr 2024 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VcxrUhG5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C10200D5;
	Tue, 16 Apr 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304692; cv=none; b=YyP+7zfrrNIAnIuxEy1qDoD44G99jTYpfUqFQv2LyL4gnH1cGVOUttZTwXQa7IZxE+tdgYjVt9KQ/G23qmNp/ZU3BPrdij6IkVh438TStnHjamKAWzFRWChQxmCYvHyfE31Phz+/flKuuhzN9OnTuZheiZ++gvvnReTwq9mjdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304692; c=relaxed/simple;
	bh=hAJ/eCBMG536qUzcN0u78ss6RJ+FlMEdTnw3NBPACIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uryEFJ7shNSYPXmf8gCcBPOsbca26kQy+CAhQQyDqPe4Eg1P/4q876hX1jZrU44ovrf7vAw9ztd7ncD6gaZTJxc6W27g5wlSCf4IzwtM2uwXQWcO+aiF8Dsv0g86DEhzuDcgFz+/8bafBzkhR9Abhl54FhuAE3gyh1n2mvqAXHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=VcxrUhG5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713304687;
	bh=bb3qRoSO7Quuf7+uIgATmDwEWC7TpHUEpy96r28G0uI=;
	h=Date:From:To:Cc:Subject:From;
	b=VcxrUhG5bkz0hv27iCaYTJlcA3NAtKoSVFu/hMSajsrs6tUVbwRGx5QktXXlnAmNn
	 q444gidHQAYY/PSNIKDstfE3SCjapOwEa3KE6WZ48bbpLGgtWk/bKMuvLwzd8EFcG4
	 Qkz+y8VPi+kCClID7IBY+wr6VV1msnbLMLWtkKyKVSKn/0wHQWM/7+1yXbvuH8FkLX
	 bz45z91EVoRb5vmdRG7IJ06aTgXo1u4WVXkQVGjTcd2mbkuf+4+mo3iEGsPleIlgZO
	 XBfR2qBu1TeL9veAnhCRPpqDTikxCx5t2W/MaL08Cc2B5UqTuR895yFO7e1TkT/toE
	 15fqi5M93Irtw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJyb31pxvz4wcr;
	Wed, 17 Apr 2024 07:58:07 +1000 (AEST)
Date: Wed, 17 Apr 2024 07:58:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tejun Heo <tj@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cgroup tree
Message-ID: <20240417075803.2dcaabb0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/itLf.i9rei3DkhYzZAWY.CN";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/itLf.i9rei3DkhYzZAWY.CN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  669ef339bbf9 ("cgroup/rstat: add cgroup_rstat_lock helpers and tracepoint=
s")

is missing a Signed-off-by from its author.

Actually, is just has a typo "Signes-off-by".

--=20
Cheers,
Stephen Rothwell

--Sig_/itLf.i9rei3DkhYzZAWY.CN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYe9GsACgkQAVBC80lX
0GzyMQf/bDq/ageJWJo58mScx1pUddAPbGD+luODVCYgjXfhrT5fy6hfTw3KyWrY
stdBaBjoQSvI/AHEW2YhG4j70geNGX+sB9CUWX/jYxNnzcqtfbC8dzdAy8HycjBx
ZaPz+IzpCiLKxMhl/mRRFeQ2yufRyDnY/BXvWufrmo3Apgdut8IYWNejDBqA+XVa
2t8QpJUBz5fMakSR1y/QYMm/PLn8Us7OoNtQmSI5y3NBTtjblj/sZALgGtKcU55l
k+kR7jFKno7QGLFvxWflw7/3s2hMC7AtCYhN4CtKqHHi4JDuDOebnVWPmvebtPXa
/pSGSNfwdqtvDL9yUV2dg4qV+O9SKQ==
=KnEt
-----END PGP SIGNATURE-----

--Sig_/itLf.i9rei3DkhYzZAWY.CN--

