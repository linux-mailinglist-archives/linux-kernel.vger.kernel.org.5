Return-Path: <linux-kernel+bounces-99557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B918789F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42ADD281447
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3056B70;
	Mon, 11 Mar 2024 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iXUIJuQF"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048254744;
	Mon, 11 Mar 2024 21:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710191979; cv=none; b=t7/25sJEnyaCuhgN7+Epz6lIXB8mtdtZa5T3gZcuMoLh3G8J1nKY746Ng7eRg84AIQx9pCIV3L5NRodTzmYzgbDERtwx2+I6I1Gv5rmZHV6LUn5gZCcU7pVWXCgwXE7DEkWrdc1v0Z+WocJm4+bk6xcVsOxC0lgWHtx0MECNQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710191979; c=relaxed/simple;
	bh=pp1J+wO2pLK2Ww6D4lisBTN2bpgFh/kOYf7ND2JkJaE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=K1GlIjO8ncTVYYDb/OJ2eW09Kc6rRjnG4JKnql30XVQDZ7yNtnfB2vMat4eaS1OhuNQdE+jJRgR4/UM1hyERplTEGb9olfJ86x4iL2SoVvzuTMtz6YgScW2BlEfTOuMngOjkvLOFFbnIkODl8C3cW1h92o/fYxFc4e+adE00Lsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=iXUIJuQF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710191974;
	bh=UgNlD9H92TGEVF/ZpYVrokGDVAItokw3r8sShZDRJWk=;
	h=Date:From:To:Cc:Subject:From;
	b=iXUIJuQFuM0rIaMq89FeS6vLPsLiItfMDtNtAKG75D+cvpBl87pqzIu0MLl31xOd4
	 0Ro2FExWkxH0ptkNKldPOIpQ8ogqWqAj6UMsyQCRNMB+NJOgjlgUeQsDbff4O7jr6r
	 ZP17sZs53ERI2Upjb/t6FzirXFT893TUEyf7a4+8X945UOUchmi5xKT0T9vKo3TeYU
	 m1upI5DyV93aaY2a8AX1WkdfXzmJjr+gNu4LOdiCmrF1ubnXeqYVm9oA+n/B1BXHlt
	 OXQ9CLNIhqEyNPUEtCCIvyjZ3R1+oiqyk33m8vi4Bnvms6TKgQwC9HBp7FGC7x6E6x
	 OMtc4m+8AbY+Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TtqRB3n8pz4wcg;
	Tue, 12 Mar 2024 08:19:33 +1100 (AEDT)
Date: Tue, 12 Mar 2024 08:19:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the i2c tree
Message-ID: <20240312081933.64de63c0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FRwj.kSztp4q.pCHzRjCpKI";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/FRwj.kSztp4q.pCHzRjCpKI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f58418edf0cf ("i2c: aspeed: Fix the dummy irq expected print")

is missing a Signed-off-by from its committer.

This patch is also a duplicate of a patch in Linus Torvald's tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/FRwj.kSztp4q.pCHzRjCpKI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXvdWUACgkQAVBC80lX
0GwQSwf/f7fo1I0ND/mRhCnYZnQNFvMJUIIcpM8eoFk1tZUEHcKX7DuZDF97RDGL
3H6myg9XTPUpQdXY5zBxOMpzMcuUemW2B44X24WhjW3xOToQgaVMGVR/iC7Sw1e2
Q+QYr4TRH9amvGIHKswJ01pztAOOchvPjX4OfhdxyOBCkkqv9Ls0TSbVjB1GjvkA
kFrBd/FGycgX1pVqQW6nSJS0If5tXnAbzHK5USSp+jKJbs0Jf/sgMa2pJhWM2Ggf
I+yf6QbbOOcNDVXmaausCIq+ClV+tW/APoRI4AhQoyxErrFgtO85RyAVSGTJxGfM
tK022Ou9nxSla0XvbsGRcV+qTtcE5A==
=FTXV
-----END PGP SIGNATURE-----

--Sig_/FRwj.kSztp4q.pCHzRjCpKI--

