Return-Path: <linux-kernel+bounces-75604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2C85EBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C84284F31
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9693C461;
	Wed, 21 Feb 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="txGPLxMt"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D112A166;
	Wed, 21 Feb 2024 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554640; cv=none; b=Z9NAylI/8LjSp1fbQ2IXixqtFT2G79gEBT1zDfgIGa3HX+LHMhBRd7PTsFaR/SikkVqeaRB/ZY7WK38UclslFHEbLRyAKYTt3rb4GrMDpMyRgcb+y1Q+J7uHPUQpJDg/E6kgIMfCBq6+h3jlQUJ8fW+SJkycvf8M0Q0loZhm7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554640; c=relaxed/simple;
	bh=bdS2FtnKbYxNW7PTSlxKVXVXWf6E45YksDvwx67f+vg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=V4ARh/x1HfvluGuuOw0+5/NepsLFQotbo7VsYx74AzjBgqleNp/FMJenjx2M0PFf559Xw9I1c7RhODdn/JcgxQgeUfcetzfFVMzTbEWJzXW5Gt2Fxjo0tVDgBHbpHPflbzwOTciZ3pX+GVxOhUF07LW5kj5WYmnjDX/OnL9doow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=txGPLxMt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708554627;
	bh=gh7laZzC56uFD3fUawV8vNFQ6cB/qxDm6SbST2hms60=;
	h=Date:From:To:Cc:Subject:From;
	b=txGPLxMt/jqcaEme21KUI7A+PMHMNAhU6CkN/jDmuWHS0zAY4tMUwKnwviZLsZ4is
	 qIpeChfjC35tk+pW3+8SJxteCT0V24ZiCu/Hq+pk/GHZ4Zy/RL8GQXcZZvDwkIMxYm
	 Hq4vUJpq7q7fRM+DGU/P9UUE4diH4Hcdj7G/AoGrj880imSvpXo/p2t39fGyi25hTl
	 YS8vz4xTUmCfThxueqfVWSnknQn8FqqDB/7J0EXDUUNrR2qGU175ops5wECROY6nv6
	 nBs0oC0PlIgSbUC1KyV42V+c4rsGuRgh1kCfeJrteaL35smHgyFqUTbxnbrsX98tRQ
	 SPqpl3Z2PDinA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tg9vl0Krjz4wcF;
	Thu, 22 Feb 2024 09:30:26 +1100 (AEDT)
Date: Thu, 22 Feb 2024 09:30:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the risc-v-fixes tree
Message-ID: <20240222093025.5f9d9ad5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ChZT8gv=IAY_ctlKzVP5U2M";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ChZT8gv=IAY_ctlKzVP5U2M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tty.current tree as a different commit
(but the same patch):

  481860974faa ("tty: hvc: Don't enable the RISC-V SBI console by default")

This is commit

  8b79d4e99407 ("tty: hvc: Don't enable the RISC-V SBI console by default")

in the tty-current tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ChZT8gv=IAY_ctlKzVP5U2M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXWeYEACgkQAVBC80lX
0GzCaAf9EtdjZ8KatCxNJ6rWg349gp95tf+2+8mfOObGuSDZ5LdFEj2kssg9BImd
a0YMHKEpL73SjVdvCtiNJrH8pqxOstKYAWU3BVjlUxWgAxRCefV40DdRAJp/uNgF
rJyqV6mH0IBEnLngmz44KrTyJqXMnvyLrFVbpOn7Zbcq7LkTgrmOa9n2nuYhBFSU
NOopSesQvM52rUcsfOgmk11uqfmLHKJVfIY/u2MeLEnnJok5q7MPx1VBC0XzIjS4
Iv3bsuItgHvtQ5BGea80oSQiNkaDHJjQ0D6QHDuZpJ7ai0Z7r0e5mgIBuuucFee1
zGN/kseChuRwwFhU182eTkSARn430Q==
=u13X
-----END PGP SIGNATURE-----

--Sig_/ChZT8gv=IAY_ctlKzVP5U2M--

