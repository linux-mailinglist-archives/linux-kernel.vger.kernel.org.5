Return-Path: <linux-kernel+bounces-13885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81482143B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816151F2164F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B763C3;
	Mon,  1 Jan 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Bw7gu7Gq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0166107;
	Mon,  1 Jan 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704123139;
	bh=zZup1NtWD6tYDgbKVSVBZ5xea/9XVub2TO+YT7cp2PI=;
	h=Date:From:To:Cc:Subject:From;
	b=Bw7gu7Gq2uHfU+LYn7i2GTq+lTXrDR57EPhig1b0+sdAaIi4fz6Mq/tmbDsmLYIVI
	 2Gb4p2BMZOn/+WoiuFZPxG5KCBZQXWr4RYUIhDXhgDplCSMqotoL1pD5hFzII4oWk4
	 xOXr3sHWETDrpDXfHVyhti+Dr0JxNU8+W606SaRh0vuhDuS3kV5qRYKKfsMRNK38dd
	 7KsKluZQNfJK1Z2uS5ngeKCJq2oO0rh508Rr1YuLZLZl0VzeHnSJyxPyaB5NQLZlid
	 J+/7zJQaeVwMlVVsLyWiF22nMRlIrJokd43VHybxhV89qaPkHodcVs5YZUvmTN8GYB
	 jBwya9PIHOUcQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3g2q2y56z4wch;
	Tue,  2 Jan 2024 02:32:19 +1100 (AEDT)
Date: Tue, 2 Jan 2024 02:32:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the cxl-fixes tree
Message-ID: <20240102023218.3cd3e4ea@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xyAl45k18yn/iPsyzckNY=q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xyAl45k18yn/iPsyzckNY=q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

A large number of commits in the cxl-fixes tree are also in Linus
Torvalds' tree as different commits (but the same patches).

A bad rebase onto v6.7-rc6 has been done.  I cannot use this tree as
it is.

--=20
Cheers,
Stephen Rothwell

--Sig_/xyAl45k18yn/iPsyzckNY=q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWS2wIACgkQAVBC80lX
0GylZgf/UPShg8qdXKalNrg1avaE40IthXskApgw9LMu+8lZz1SFoqmkNFbTLxqb
88/m3pfGmcW//BHOqWjsMA821IKlFGkiabfJf0TpTT9/6jklb1LLEDqTs3Gph+zb
sA/6dG48TUeewVdl2h1AMCb7yGvsHJbSlMkfByLS4kfLpc9Q8U0l4isPaOM+2N/1
MoWVCqv2YkeVV58bcK0d6gpJoqLfoT7XENjhdSpgLvn+qsV3IUxom3Kiw2LYaWYC
zbRLza/0V+z0FQo2pMprGdkAkGK4PTNVHmx+PkLJcgY1WUv0eFhlPsE2IBOGuPTT
hMCoyTZUf7zxMu1mjnZ3wjSXQy7cAQ==
=QBZe
-----END PGP SIGNATURE-----

--Sig_/xyAl45k18yn/iPsyzckNY=q--

