Return-Path: <linux-kernel+bounces-134660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3C989B490
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6EC1F213CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671D42073;
	Sun,  7 Apr 2024 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AtUhHuIy"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3038F9C;
	Sun,  7 Apr 2024 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712531737; cv=none; b=s0oL3NSnq3sLAPBpKxyYPDln9O7IIdLqq6wwVtXraCLH4kXFy+drHRXTMTU16l1Ve7QCcsfM5NKOx1B/jMPIq0XvIOAublM+kghp8DPApsgpi4kEB7oGFBsEZsM52tL8Xam+AmVikn6pOF+k4IVjZIFZLAn9hyjXNOpp/iHvycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712531737; c=relaxed/simple;
	bh=J12MOgEY8a+3bmhya1dTFLRjK77jrBUR2Fkr92yMHkg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=t40E1eTkBYJdVWajRLF8DcfVEGx4Hb8wPw0kqKCmCrJ9dlDuThFWBV3xOcySOAkitngVW2ZQ2XUBl4Z7j0XCVILtu7JFBgGsTMF72QvEu8EgcRFC8fVh1eNC9wF9HU5VDKXFdn8TkjCTjwmZVOnbGU7lyVjFgA1WfMcKD+F96Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=AtUhHuIy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712531729;
	bh=zcn+XVfd3MWVQszLLcpWvD4qpTxFdGiCrd5YkSCNqMc=;
	h=Date:From:To:Cc:Subject:From;
	b=AtUhHuIyshI0v4HylDYtmplViiPmNrsVts3ZCmbQqDy4UZdf1ZoaBxrtiro/UKPWN
	 sy/VzbA6hrQmdzdE0Hi4Ib/yvEN4PzNod5UJmgdwYoD9T3jpoSoLaZVQwxYqUhBsEl
	 7alt/lWVbmVa01DkV7+VHir7VKJP1eKbu5vYMZoAWE5f703SczJMvEET44dDf2FBtF
	 Mzve32sL4noGrUULkpZb5AnL2I9SY7Uny2U/GIUTFtZWRDxOeK7Nd6I9k5j9lkuxPI
	 pkyyFWfII0KEQqXVsFuIz619iFx0JjNu9cyU5iqdcmPaEN1j5Rzw22g/P5HSh17KMt
	 6USvc5xYqedxg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VCSkS6fNcz4wjF;
	Mon,  8 Apr 2024 09:15:28 +1000 (AEST)
Date: Mon, 8 Apr 2024 09:15:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Barry Song <v-songbaohua@oppo.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240408091526.562c30e1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1boJlDeg2tOlPJ9PAbAo0aX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1boJlDeg2tOlPJ9PAbAo0aX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/linux/mm.h:1115,
                 from include/linux/mman.h:5,
                 from arch/powerpc/kernel/asm-offsets.c:19:
include/linux/huge_mm.h:276:23: error: variably modified 'stats' at file sc=
ope
  276 |         unsigned long stats[PMD_ORDER + 1][__MTHP_STAT_COUNT];
      |                       ^~~~~

Caused by commit

  d4358ee0a075 ("mm: add per-order mTHP anon_alloc and anon_alloc_fallback =
counters")

from the mm-unstable branch of the mm tree.

PMD_ORDER is not necessarily constant on PowerPC (since it depends on
PTE_INDEX_SIZE).

I have reverted that commit (and the following one) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/1boJlDeg2tOlPJ9PAbAo0aX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYTKQ4ACgkQAVBC80lX
0GzgsAf/bwPry6OrXEcvi7DTSMPh/cRl/1HfvbPykZM4r6quhE3L4rEXYmjR38zy
kcaENe1h9GmnpyoRJ1sI/smdSDT7Ak7wSQaoMTafq3STjr5C+yrN/cAdne1V+8lQ
jwToZ/H/mSFv9jkqNQnd8ga5DLlMySewzqEMdIXh4G5F/mC8GRiDlgAtssHNI1rQ
EMYyPCi1d0GamwmoNmrGDtDKytyzC14KW+yY/ChmwGfioTkt1dJfNx8J0KqldN7k
hs63Kn1ubQ4P1pJxVx7zmBEM8jcT22X6le7ssBkepSaJ7IbzVWSw+rcDR40FL8jD
dHLppQy/fKC89FNkoAWUypSYxWMEeg==
=UaaD
-----END PGP SIGNATURE-----

--Sig_/1boJlDeg2tOlPJ9PAbAo0aX--

