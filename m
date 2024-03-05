Return-Path: <linux-kernel+bounces-91642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8310E87148F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D7F28486F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125133CF5D;
	Tue,  5 Mar 2024 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LTYjrk6H"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304A638FAA;
	Tue,  5 Mar 2024 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709611845; cv=none; b=hRclLoki509ofMfhpJpI2rNbkmJZv4msWrBcaLR3L9kzPhcRYn3IKpxkiHzhU0DFIh7ePJi64ZGeaPuoTE0s80RhltqXfTTMIzH8ZZn/Qb3EiWZrAyl20VlxIsIQgDTFk+uEIDSHqIYLQ9jja2BUocZkkyvGp5x1C5DvnAxTC1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709611845; c=relaxed/simple;
	bh=9BP+RoVOQM9THe6YGmUi2qXQvQapskZCoZZSjCTLFBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=W3PDn1BOEBnfVaGBYTtX6OKV2oQCiRvmz25g97vc/0cF4eSMieMUCN98m6rMIPqD8Q8Zjb7slO7dD3CwrYEZOi1S/nPhHQsfvHgXBNuGhiUDvQV7QvaSb40mu2t5n+0QsI2o2O1VmKKBr4r+0bOlPNBrmzLMgAJ6jOIupvN/AEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LTYjrk6H; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709611840;
	bh=gSiozb6PQGK7Fp4ID/IgbPNGTIJ+GNcpWmuRh8xN9C0=;
	h=Date:From:To:Cc:Subject:From;
	b=LTYjrk6H7eY57V/pEy1pYMKULDojyZChrCxclws16xFel7s1ZN+8llk1yuVEraMG2
	 v/k50Q2OrvfeYy3PldPzvpOmsy2tceom713XtmerILxqBV4UpdphwAO1Zao0ywx3Pf
	 cM2VNQ88w1MHUaIUazrB4WqPneUsdrIUeYdkeJQWmpWb9DJ2eWWqjHpQB9U3t0pR7T
	 y/aZjyjAeNIWVvNgN17pc8IPz4QR/JtV4bAGSlzR3mMVbBYnCbnMQMXi5QbvLMC7R9
	 rtL4+6ibyEmvOtP8TLlyotAi3sUgmLa2DnEliFVW4j1n1k3MYfUQCikFMyzfAm2GDR
	 M2Vm1QPiKl+Sg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tphth66P1z4wcF;
	Tue,  5 Mar 2024 15:10:36 +1100 (AEDT)
Date: Tue, 5 Mar 2024 15:10:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Will Deacon <will@kernel.org>
Cc: Junhao He <hejunhao3@huawei.com>, Yicong Yang
 <yangyicong@hisilicon.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the arm-perf tree
Message-ID: <20240305151035.22c6f7bd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R4N+0gN8uIFRNbmELpKZwV7";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/R4N+0gN8uIFRNbmELpKZwV7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-perf tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/admin-guide/perf/hisi-pcie-pmu.rst:48: ERROR: Unexpected inde=
ntation.
Documentation/admin-guide/perf/hisi-pcie-pmu.rst:49: WARNING: Block quote e=
nds without a blank line; unexpected unindent.

Introduced by commit

  89a032923d4b ("docs: perf: Update usage for target filter of hisi-pcie-pm=
u")

--=20
Cheers,
Stephen Rothwell

--Sig_/R4N+0gN8uIFRNbmELpKZwV7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXmmzsACgkQAVBC80lX
0GxWDgf+J1d46ibjTsQ5if9apeMUiR1v9HlciQZaEWO512izG4kdtaOz73joSxnU
hyuieQt3kEZ4I1uEGg87S8QtZqU1L14Kn0xMx+CIYw2mkgJKmYtZbXJpKVMMsy2x
KGfgFLtmoQqgub5uMeZ1g3cdt7L5BTKjS1bzVR9Mbe1V9xxq2YjOBbWS7249kE+Y
btO+tE6vLmAjOJxQU9+X1Bippo6mZtwtnOzgx3KRLX2E1F7lHLHqDAdJP9nyD3nf
O4qYJbiu1IMjmXQQDRdGSFTTOhfwvAKHCAy1rwJRlBZr/AIq3XrZowcTXLqqTvKd
uMF1Nv9NsbAnxtuze48HVkwEqc7giA==
=ZR8P
-----END PGP SIGNATURE-----

--Sig_/R4N+0gN8uIFRNbmELpKZwV7--

