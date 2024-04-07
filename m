Return-Path: <linux-kernel+bounces-134651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E2389B475
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 00:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3277B20FAD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F3744C7B;
	Sun,  7 Apr 2024 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ccdy9Jkp"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1401E49B;
	Sun,  7 Apr 2024 22:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712527667; cv=none; b=HPPBbHSTa7Qy1FM/sHtvaGe/sWA1Cxjwu2S5cpqN/Q213AxBGcsxcEgPdSyUb4mhYo/L2pvgqsM1NzDdRy527eKbqvFScxV2VwuX9Jjhb9gyRUZAzcU20yvMoz8/2mImp+W8Lj1MJsOkgJ/fQVW+O61qFYK9nk5RYw5jcLvgE3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712527667; c=relaxed/simple;
	bh=N3fPe2eKTXb4S0nQf5W8FSqKDYXdk5rlyV0PXb+k+Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lgtvliD+nT7OrGUF+t/HYk694SeD3elQy38rXHAGb7kQabiXjNaHdweY3PtypARr6IeFiEjRMQ7VkgaX3rF9oCpQQzFvwWsVeDsqKE94wBd+NzAUbek/jEpwG1E8LXKTZdtmZJG4Y8A6aXMeT5FSapwTPUsKQOVm3ctrnL3cCqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Ccdy9Jkp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712527652;
	bh=171l4RcSwZERFvN1wKdEPSjDiIsWeuoCLer72DvNuj8=;
	h=Date:From:To:Cc:Subject:From;
	b=Ccdy9Jkprc3Q9cL8VYbDveOpoxcNMP/OksfZzEUQj9NmiG+elBECGGYi95lIpBKX0
	 w0OOXKw5alh3un3xxvE2fouc6U/nBL2L2OqUHUAC3k14X7I6z4duabAUPnTKs0aMx8
	 5kbg0XUXdxKn4Xq2IS1dkcPZ9d1i/3HseGN1cV+6CgfA03riZXDM92fCNXPY4PVfOZ
	 ivJ1Mjn68BNrUmQZ4987dICqChnFUI6MfMYxcXTbhmY+nY5LPtPwRj3tnomJT0fJN4
	 ap95ogSR1wUxNaReqiyKSmibZWbeJutTr/exNHePcoPWThPvOWJCj/t4S3iR2X1lSC
	 J4dlC4h/EyDjw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCRD44T42z4wcR;
	Mon,  8 Apr 2024 08:07:32 +1000 (AEST)
Date: Mon, 8 Apr 2024 08:07:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Dave Jiang
 <dave.jiang@intel.com>
Subject: linux-next: Fixes tag needs some work in the cxl-fixes tree
Message-ID: <20240408080702.77f868be@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9M1sQo9LPB9oBrFX80t0oNG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/9M1sQo9LPB9oBrFX80t0oNG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c2db06c1a27e ("cxl: Fix retrieving of access_coordinates in PCIe path")

Fixes tag

  Fixes: 4d59ba915318 ("cxl: Fix retrieving of access_coordinates in PCIe p=
ath")

has these problem(s):

  - Target SHA1 does not exist

The fixes tag seems to be referring to the fixing commit.

--=20
Cheers,
Stephen Rothwell

--Sig_/9M1sQo9LPB9oBrFX80t0oNG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYTGQYACgkQAVBC80lX
0Gyxowf/Z7VtTysyYXJ3gZDaCy1nshojlg09m6GacvjK2adwoMUw+lPKzr3izhtO
dJQKRN6hI0GESh9q0bBxGct9MII8MPdEEs7fKYVF8/iFn/N3LSvMIcZtw2kAHCzU
RB5ZX982Slpa4O9ojp+aV2NGF9z9wtXJHMpp0iEOUuwNx1FSFGiNhrA2sVL3rk8f
KQkn3QJj0dr1oirDNbhP756n6ockeUx862WfTgpBJWuPQYjxB5AXyM2TVh4LvIy4
FkUiUcsSz7FFZ/gW3ysZyH2q1YwGSpey5t9x4oMGKeyFO3F02u7Fl3kOvluC95N0
CZoTXA2h294p+B3ej6KjtPhmuSgigQ==
=H+y8
-----END PGP SIGNATURE-----

--Sig_/9M1sQo9LPB9oBrFX80t0oNG--

