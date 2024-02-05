Return-Path: <linux-kernel+bounces-53995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1784A8F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59912B24763
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870E5608F1;
	Mon,  5 Feb 2024 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kb2s0+q4"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6A60878;
	Mon,  5 Feb 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170639; cv=none; b=ojElExxaZN/BX57EaJHD+LRcl6XOfikjje02geBTpWSeoJb93MD17jupw92VThqI0m/9iReV+ZP5Rf4dTfzODOPzz8XtheBt8YVjebOSxa5Rd8Zs0fh6KZOkUc7Ax39ewZr95M9yz8H2V76GfllPGoQMCeJRXIrEzxdSscXfv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170639; c=relaxed/simple;
	bh=ZuIgEWXDaw78xMqOUOadpO2rhYAyUJFjADvXdH32uAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gI7swz9UNwndiDU0Qv5KLTPGeMwdxinQLiYN4vSThYr7UFsS8AZmYjATQR5iOKFV96NrfAIHaWj1KBlc98+wi4azaTrngogBCmu14tLtB8wfGiLwD1KrYJq5gzsukn3J6tSjcPCq1i715QA+7UEfkJRabu7izmwvs8Y+rWTpai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kb2s0+q4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707170627;
	bh=3tNkv4NP/NzAdkSDGC1/j5xdukaM3oAMcY4wpku783c=;
	h=Date:From:To:Cc:Subject:From;
	b=kb2s0+q4UIGTdyNXuieGcMjiaVlC5+JBn+lQhqfXzK4flyHPlY5Ew2rtl9QICUb0B
	 72UYe34OA8UNkoRfVBfPO296uG79YeiET4PiBcfTE7Zd7x7CnvntOvbiDASKuJ/M7U
	 yfyOT9NHmgNq6U3GEnc7eIlb73ynoRfsZqM+a6ua1f8pCYkwadkmpMKAVEypWNcUKU
	 6VY0fdmzAq1Qek2hUY6QvWeH8agcLsd8SO/iTJxZqavHqb46rhj/itACmbdLAsPw6y
	 p29x0wacHB8IV8sPEfejbY/BXlHlPR0rWIq+6Hx9EPGtcCOW2dmspFsnH8ibyApGAb
	 IlznFTLxIUPqQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTL4M0ndzz4wp3;
	Tue,  6 Feb 2024 09:03:47 +1100 (AEDT)
Date: Tue, 6 Feb 2024 09:03:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>
Cc: Mustafa Ismail <mustafa.ismail@intel.com>, Shiraz Saleem
 <shiraz.saleem@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the rdma-fixes tree
Message-ID: <20240206090345.210c2760@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FJNTYA+DxP+IJTwzo4_yk.t";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FJNTYA+DxP+IJTwzo4_yk.t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  772e5fb38843 ("RDMA/irdma: Add AE for too many RNRS")

Fixes tag

  Fixes: b48c24c ("RDMA/irdma: Implement device supported verb APIs")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/FJNTYA+DxP+IJTwzo4_yk.t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXBW0EACgkQAVBC80lX
0GyR3ggAjqp27dSUgB6ctfW8hMVl5B26NtJE+EAtRZCpuZgWzx3lAT1+MGj1Ex1b
eOjgLl7l6kqzLm9KFeKcR/TVga3bDKnvlcE+qrJR2pBfyMLYM6yt4fjdz2BpLUXJ
iz6b+qkGj5gRJARpV0tQ+bzPYphvybn8Gy1KEfgSDHgXO+Ehsxs3xRwInG+ekxij
a14B4LUaAc34t5zvH3TZCW6SChsoEn4jw/cYXbIoziAVmkN/k4LMrursUUUTpk8S
mJ+WOyxCOeKzGBH4ouhnoGez6bIft3sgNkHzbZWkqi++O9VZmHJGhHqux4Nimiro
rsGtqE1hLW4rMCURtqXzp5/Pc+6bLg==
=aPAU
-----END PGP SIGNATURE-----

--Sig_/FJNTYA+DxP+IJTwzo4_yk.t--

