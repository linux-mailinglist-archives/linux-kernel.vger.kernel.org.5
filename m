Return-Path: <linux-kernel+bounces-22963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7582A5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C11286903
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3983CA48;
	Thu, 11 Jan 2024 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h0RGAH13"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA147ED;
	Thu, 11 Jan 2024 02:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704939532;
	bh=qLu/Bj3EMcSiSCEM6xFdcWbhdysUejR+x/tfsjeNTuQ=;
	h=Date:From:To:Cc:Subject:From;
	b=h0RGAH13th6YHTn0ZFQ8/P0LRSbxAZ8ALzXs3JELgmpPI706hUquoOlb9TBah0IBp
	 GDntDG56riHxjFVAOwyteP4pMb/cFKWx42MjmywAZ8nUNZj6V1gv8VaYwXY6WLUcc7
	 2qIAifWDt+saoz8CA/yJLFmBLBbwvJ6YVrrZm/88S6q6SQbU3+G5isjqIgoB/Z1uIE
	 GGGdXC+lbXgmjkSyT1O32JYJGWBHnzwi/9cLyGvOXkyg5LSzqQU91qYhTT8gYvP/hp
	 MPcRgkqKBPHh1Jh71ZkUX5eqzDiKJ5mdO0dRLMhSawFsteg2mSV2Tb3MeptTN2UXaI
	 8AvLfD3NXXvbw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T9Syg3K3hz4wy9;
	Thu, 11 Jan 2024 13:18:51 +1100 (AEDT)
Date: Thu, 11 Jan 2024 13:18:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the devicetree tree
Message-ID: <20240111131849.7f7c851f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C1YpWEnyB/nw.a/d.fGQ_M7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/C1YpWEnyB/nw.a/d.fGQ_M7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4dde83569832 ("of: Fix double free in of_parse_phandle_with_args_map")

Fixes tag

  Fixes: bd6f2fd5a1 ("of: Support parsing phandle argument lists through a =
nexus node")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/C1YpWEnyB/nw.a/d.fGQ_M7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWfUAkACgkQAVBC80lX
0GzSKgf/fCNqvAiOi0IYQel1rvdirZBjRL5S1bfahyUDlLuPWN31UYJnVPfgIpAI
U/AzGPHoWZ5TA9EfN/HbeTrHrCLNPpmeG5xx3ZF14VxIH3Mg6GIKXdQYiGuJiQH0
YuntAi21buJ4RC+lImpQvI1sX3yg4u+iTq4EH5f04pi/EwOLyEzEmrgHmSMjd7tw
ud12UxostuKXetAfbYlZpL0MLqaGI9FwJJNtMvgdvfVPoD6Rp2YDm0ZOZ319Hq6R
hmA115uhXh4B0Fi0D59AcGHeCI88PWf09VPWtQoRlOcH+Nu5l2qXxVv70XUsQ9Hn
wCUEBAaUyvjzABJwIY1FqhlOP/Uwqw==
=jjTh
-----END PGP SIGNATURE-----

--Sig_/C1YpWEnyB/nw.a/d.fGQ_M7--

