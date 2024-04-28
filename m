Return-Path: <linux-kernel+bounces-161625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496558B4EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D5D1F23E1A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF15C2206B;
	Sun, 28 Apr 2024 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I9GZB5kN"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70856171AF;
	Sun, 28 Apr 2024 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345482; cv=none; b=k+2qaXuG6upsJulH18FefPsyIcpspX8fqdxoqJ8mXy4/GTm9+v5GZHzJS32r8XBjI69P8sTuqkaQRUKoKt3dQkai3wclh387RtQir3nZWmcgTW0WcN9nHNnWhhuvqWK8+yGJS06SMfWXdHeQSwTQasDo57wADOmiNaYK0slwpFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345482; c=relaxed/simple;
	bh=MVa1+hiLsXLf7FIDWg2D6I5gIV3OvH53XoNCm17VSiU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GnNAapg6b/tIJ4lsyrl4b6+nud5UbicTDrCWlaAYaNk9lQAgOT5cHp3ktr1eM7O1L75oke6W46iJ5I0ig43U1Whj/P7SGhGAA6ok+OkINbpGuRj6R4UdkDnOV0jv1T20uhQEtYls5xtlh13axJNy0prYRpKsYEhCArkZMzo2w8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=I9GZB5kN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714345476;
	bh=Rd+AD8Kt3Lun/MbbWETsjzCjT480FKZMn0uktfH//AY=;
	h=Date:From:To:Cc:Subject:From;
	b=I9GZB5kNrd3YVO7YA8Vb6y36e4KIhiYkQ/T9rZJbnUviA/DP7bpGxnnkX117UPMpg
	 zBYSrpF4ULXi2+4xeKXF1wiZXVl98zef/1r2JcyH6ABHnbRMZqvIacxQdAXaSY/IB9
	 UQwdhKMNxIOpayO8vdBZIioy+XLOjzagsH+pZHEKJ3Rm0t1Y5BCC9n+tYsrtqQZvtv
	 vEhPGRHym0+KTk/lkEoP3PpARCDBa6nvQb+hrwFdnV1SrgihQ4f0aCWA7T+qaE9OTE
	 AbBkr3o9dRB+r8mmytwMLMVflfCFVy7XDmnAGBUiQmGpMJk08yvcg3RC3NoI1lhNCW
	 tdEFuxUbGaiWg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSMVD0PDFz4xMx;
	Mon, 29 Apr 2024 09:04:36 +1000 (AEST)
Date: Mon, 29 Apr 2024 09:04:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the perf tree
Message-ID: <20240429090434.71a99565@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e+CymSowB=jfE80H.8dDlF=";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/e+CymSowB=jfE80H.8dDlF=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the mm tree as a different commit (but
the same patch):

  cd88c11c6d89 ("tools lib rbtree: Pick some improvements from the kernel r=
btree code")

This is commit

  85d63b57478c ("tools lib rbtree: Pick some improvements from the kernel r=
btree code")

in the mm-nonmm-stable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/e+CymSowB=jfE80H.8dDlF=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYu1gIACgkQAVBC80lX
0GzXNgf+Np9hkCxFfiCtm5ZFgscZ4EBH2HXGzBRu4Uv40J3FAFMksJKKoqg9yQob
Okp3FBKxxL9sFAnbdsWLkxygy5LPRm+oNukXAQ9RI7wWIcZ4p3oXD8rkA5ibv9ZV
TQSTZXrEDw8wRRJt8c0ip+p4L8qiMQy5dQ94weC2W3p5jLxrZfx6TTPXvQnEpiHY
8yiH5lhgXPUjfcGIUaszDWrYhC997Lblxy/aEGw7I5D9RE2Z010CUHxu8ELoTuZw
LlPGTH3QNdt5KqcQvY51xuyzZUJpuLtHpHXL8jzeMVEd+H+6fl9ODr+HX9mbZNn/
xFU+3In4ekMiK3UKlwvF7RXhvlTd4w==
=6Tnr
-----END PGP SIGNATURE-----

--Sig_/e+CymSowB=jfE80H.8dDlF=--

