Return-Path: <linux-kernel+bounces-161578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351848B4DF0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603F81C209AA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C957B654;
	Sun, 28 Apr 2024 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GPw0UR8g"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC969479;
	Sun, 28 Apr 2024 21:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714340158; cv=none; b=bvFWBvrd6pEGPhuMcDDuBwn0hnSebECXdry6alhVwuwU2MCSUracSfSgCXuz8zysLGXHyLZ7B5H7bgMwikj0F80IJj3IxOPWS4mvtxs4qmUWZ54Yy1Bj6J57zAt7mBlQWJmUBQe0kT0YtFADxzjysnLNmCSBbm0EpfLh2mafD/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714340158; c=relaxed/simple;
	bh=464xYM43UzIAW7mCZoM8e4rtOGBL+f/tSwYc/26+JcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GwEuEiNv9j1iyBn3MBo++w+Xt6ipmfDplKs6AOYMPCcDnRn3JfQqDg/eRPM+1YngcDO8s8WMGmkOzNo4SFiSuZaI5oWy9FYQE6VgxK9JFuk10IqI7DaE8w1fIM5oxR43nXshn9vYz20K7hAkricbOIOAmSnHeEXGYg3dj0Y7UuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GPw0UR8g; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714340154;
	bh=aTxT264Zwpw8nb3WFxxae8z8cVsDaegAGyTf/tWVmjg=;
	h=Date:From:To:Cc:Subject:From;
	b=GPw0UR8gPA1GtEuYCOs1KC05JNn4ujCXS5LhHmoms537AUeU1/oYuZXLp8NxMzG2z
	 Byu6YT9+ZN8SyLHrhf82/p1eu8ZDmAluETkCQtReXulCTSd/vmFqnXGRpjbQ3vCEOu
	 g7bPc7KjCjgNh+vTGxbi08BUmNXkBWQlVmi3svUglOh2vXuI3JcdesWvQX6VjU6xRh
	 ZMfmr3yp+GIXTQEQkDgc5aAvyCknWdR6cRVvTQpcXn1t7cc0CZCowz7hROFzNZgOKx
	 0ZTrILeK5e+GZuf02yBlDniQw0yUiDY88NKtcSKF/xGM0MnerpKlnBRxl6puoM4H6B
	 HcWYhwalxE7RQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSKWs5zdnz4wck;
	Mon, 29 Apr 2024 07:35:53 +1000 (AEST)
Date: Mon, 29 Apr 2024 07:35:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the risc-v tree
Message-ID: <20240429073553.503958e8@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8=vDz=K/t4valu+bVLQHZUv";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8=vDz=K/t4valu+bVLQHZUv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patch):

  bac292e849d7 ("selftests: sud_test: return correct emulated syscall value=
 on RISC-V")

This is commit

  17c67ed752d6 ("selftests: sud_test: return correct emulated syscall value=
 on RISC-V")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/8=vDz=K/t4valu+bVLQHZUv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYuwTkACgkQAVBC80lX
0GzN4Qf+PS9oPGS6nwoB+2tfgLYZhuhdQSIuPhi2Q9OFjIQd74hQMo9P3BDttvh+
7i3q8QbtnAai9rqAb06wy6JDduVfcfUkf9CQcqWdemuuF4xddNPkDkwzl6mQa6yt
PAahwXZj1wNXo8iiawILSQtbzH2C1/A1AvgPrqq9U57qli3y/plF6yBwSAs/vPI6
s0doCNTXzJw8Jl+5sWWpOLdTTXSnCPgD4ZWN3cAFkrsvDMfbLg1Piy7e98YpZ9rD
+Lrscspwg3hgBtvqPuWOkat9ER0l1k1DJFTN8HaKXwhnLzqvd8CS/KZTi788ehgl
Ni9OYpzbSq2OIedDqvHRtQRGVyaEdw==
=U5/9
-----END PGP SIGNATURE-----

--Sig_/8=vDz=K/t4valu+bVLQHZUv--

