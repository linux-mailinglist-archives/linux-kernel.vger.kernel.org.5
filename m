Return-Path: <linux-kernel+bounces-54186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A433884AC0B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75C21C213EE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E05C56B77;
	Tue,  6 Feb 2024 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cO+vyvtG"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6D56B60;
	Tue,  6 Feb 2024 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185460; cv=none; b=HIlR8iOeqWEcNtrdihYoa3QTB6BG2oFVTInrBZIgNN5aMFL1a6rcQHtPArChn+XES7uyqWCsNDt3Yiq8LcDQz1i2cTdRVKpXix5Q3lRFIa7aPi+qTh6Wk7VSysxb3fs+QkUMq0TJbyxd11lZmhDsarNZ5D/pq7KbSRDDkPswsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185460; c=relaxed/simple;
	bh=llVHZ09AAUg5Ua/K8lgYTVmRcSKF8WL8Sa7phrJs/6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mKHvkm/8PmLQlAPkEcAz7LwRuQqQXOpZsAfLIRhKoL4mAmFWLDzhPfW8ku863JBLHdui7YZbpcjRB6DCWOIxseKef2RwxkxIISSX0ICA0prQdagQT3zu5AnJhoCVHnnhgTkeqh4fTBA0xH1sdYT4v+jwfa8Epw6kHba5bh1ux7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cO+vyvtG; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707185451;
	bh=qvUjlRGiT0R0UyPBwSvLm1sF6la5BWpDJ2bNkVs4/8o=;
	h=Date:From:To:Cc:Subject:From;
	b=cO+vyvtGiMhuNMkKoGucbeylg13ikAiYYGkvxH2QSNKU0NGys98VQfReoNLn3XPi6
	 T0sXtNxZWoWOUG97fOC+nDg0DCctt2OzaGk1zLVrJWRCSCNeUIoUk7UCAAEnP/APTO
	 wXeycQQ/awDOTEjT7281Knkawl+7JeCOzjrY4Qq1l47uBQGVWE9zqbXayYDouDU1ZL
	 spJfYp5C1276FSw6IS4ycWsGAcnWOS6D6ePlHXiLN7lzSgNhglD7O0yfd5RTi5TMhz
	 5RDtjzYy/c0rjneAlx4aR9SCfVYp0cMy6BBfRI1HXAM0YIhJOAP4sIRPdr+hz4TZi0
	 /sDIH612Ss+Uw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TTRYR3MzXz4wcB;
	Tue,  6 Feb 2024 13:10:51 +1100 (AEDT)
Date: Tue, 6 Feb 2024 13:10:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the block tree
Message-ID: <20240206131050.0e86d882@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b28S8sDf2iTRHrvBTQ+1HBS";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/b28S8sDf2iTRHrvBTQ+1HBS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (arm
multi_v7_defconfig) produced these warnings:

In file included from /home/sfr/next/next/include/linux/bits.h:6,
                 from /home/sfr/next/next/include/linux/bitops.h:6,
                 from /home/sfr/next/next/include/linux/kernel.h:23,
                 from /home/sfr/next/next/io_uring/nop.c:2:
/home/sfr/next/next/include/vdso/bits.h:7:40: warning: left shift count >=
=3D width of type [-Wshift-count-overflow]
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                        ^~
/home/sfr/next/next/include/linux/io_uring_types.h:538:35: note: in expansi=
on of macro 'BIT'
  538 |         REQ_F_CAN_POLL          =3D BIT(REQ_F_CAN_POLL_BIT),
      |                                   ^~~

(and mny more similar)

Introduced by commit

  d964e8440442 ("io_uring: add io_file_can_poll() helper")

REQ_F_CAN_POLL_BIT is 32.

--=20
Cheers,
Stephen Rothwell

--Sig_/b28S8sDf2iTRHrvBTQ+1HBS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXBlSoACgkQAVBC80lX
0Gxh6gf+Ko6niJLhlxOadBkRpxHo9Ky3PVZ1yQFBMLPWL+F/S+22DsNZNEWEq2Ko
7lHDWfTliKKZ1j1YL3NsNA6UXKNKNlJ3hzH88fqqFZZ8fnzx/1JTDPXpB9/YOfPY
j3DlLtAvsrkpPLma8bQ17fPv3EBP5ewaZo6xwGwMY6asz/Y4Q10jxjhLRRkFT0Ns
bplgoESqKyMlpaBZfPkXbMV7Ni15WoojWLMAhX5e8WUtrseHFESYmvMNH3/3rIop
z+6PyRRtEy6CuhFPlJhSy5u7amBFb6W9QveHy/uXTavEKTNyHEbhqTGeVs2F4hre
M8BDEcmBZ1Pq3cTjZn6Had32EWR60g==
=rOLE
-----END PGP SIGNATURE-----

--Sig_/b28S8sDf2iTRHrvBTQ+1HBS--

