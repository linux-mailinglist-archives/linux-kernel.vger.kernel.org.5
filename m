Return-Path: <linux-kernel+bounces-145984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B48A5DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41640B21521
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B30158DA7;
	Mon, 15 Apr 2024 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WrhySR0D"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73696158A3F;
	Mon, 15 Apr 2024 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221670; cv=none; b=b8Uy0erbJxKG4VTap6JLWm2XEpUMa7oMoRw1vF6NFeXfrE+vAQzPNnF23pGmyGw0mK37uNnxDDUOGM7d9+08S/wQ6VeDXAMtJozxMWyehFoT2qVAb6VTnBCL+/OGTVul7bjQ6Rq5gGsHL2sZqksTRUtANpMeq5f9vpg0A5xwntQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221670; c=relaxed/simple;
	bh=eLdKbhfCKAc4eBkgl5w1SoE/tt8ypJjBULGOvS9Cdy0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LMKdmYSgygHbxSEIhvNp0fjTffHkDhlgKYMHnE5jyBAwWnee61/H+jLWKbIH0mRmMhHuJ2X5iH/DObjQsXfvT8AAwyRiH077fo/6E5svycqcu/qhLVkxg2c1xoOL2I1/pcLUNS0UVpcKvMcyzVzu2FDnyDhDyoAbkB0oZAobksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WrhySR0D; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713221658;
	bh=g1EPgwqf9sduDDei4TjE6YHMPLCCnqDUBgN59o47rVY=;
	h=Date:From:To:Cc:Subject:From;
	b=WrhySR0Dspah7FdjjreL+xUh5E3TBxL//3y1arXBrw1ma2N66S0P/QHUB/ql/Wz/X
	 diF9tckiG6b4PdXGUw0+t4k5N4yN5o8OK1ltR9tR2Fz4T7q0dST4ktxazU47ORZZpu
	 BmTxtmpZdWcQDR5krZVI1vX2FIutYmyyhng0p0xGRh4dAh6758y5Wo3oFo/Y1knKMY
	 A99Od0tFKFJON4XAJKNeQmATO4U2/ONqUqs58LerHClv60JxUmD55O9setwu9hv1ni
	 xwzVYwA+SFeZpVgoKKdJzXKCMyiDLt2S/52MzgCxi4amjyy+mKBjN+GJEYXNLpxDYX
	 seRgwgi86pP8w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VJMtL3WXmz4wcb;
	Tue, 16 Apr 2024 08:54:18 +1000 (AEST)
Date: Tue, 16 Apr 2024 08:54:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Saket Dumbre <saket.dumbre@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pm tree
Message-ID: <20240416085414.2ca9ed0a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0Fy1zJ6S39YCM0TC2rVgI64";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/0Fy1zJ6S39YCM0TC2rVgI64
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  e1d3f9d46f17 ("ACPICA: Update acpixf.h for new ACPICA release 20240322")
  ed5addd09827 ("ACPICA: Fix spelling and typos")
  5a02527783ca ("ACPICA: Clean up the fix for Issue #900")
  c15fe3916b77 ("ACPICA: Attempt 1 to fix issue #900")

are missing a Signed-off-by from their author.

--=20
Cheers,
Stephen Rothwell

--Sig_/0Fy1zJ6S39YCM0TC2rVgI64
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYdsBYACgkQAVBC80lX
0GwrPgf/eqYxoKoXZhEkiGBhtHrRWQZQ7OzCdIlr14COnBXyuvbaCY4cb4f6jZ7B
iA3sw4a0uxazG7Ppk1tVpO9AfQ0f4MTz0aO68k+VdlQmjB+bcHPch8mfgflhZJrN
5S7UlRuo2E3nZHlZMm3umYXhXzfJ5Ikq64N89xHw58GKUS4JDaBf2x7jLV8ob7+f
dcRlApMhcCJ4/4txZyEDqZzDENtObBwSsfTNaMul2N43c4FdY2zxVsMWty391+mB
mpzfuCd/sLfuYWjqfGzJ+BQnAK1jCxslYiSwT0V1XIVhc8SxS+7wNa4LhdWszuhM
GvSeVrtfNtIMrmoly4c1Nb60LeaEcQ==
=YU22
-----END PGP SIGNATURE-----

--Sig_/0Fy1zJ6S39YCM0TC2rVgI64--

