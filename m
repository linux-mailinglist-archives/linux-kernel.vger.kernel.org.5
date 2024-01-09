Return-Path: <linux-kernel+bounces-21421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EF7828EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9EE91C20AD1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F283DB93;
	Tue,  9 Jan 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G33cPK+T"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8671C3DB81;
	Tue,  9 Jan 2024 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704836083;
	bh=8/04E63srn8np1oGm6XxP5pwqRVE48cxY2WaKP8MpZc=;
	h=Date:From:To:Cc:Subject:From;
	b=G33cPK+TTUKUm8FLFbXVqJa386mBeHL/rERJg6TprCJRHipbBXhujuJqICRX9Iq1d
	 jYntvL0MnkDw1tmF+PyoGpjUoF6TI85tXuwUWC/Pm9JUZDaobhNvCaeTMeIyVDi/8l
	 FA/Riu6uQ1vQezIuUa0zxRY1v96LDHlq19bXUE7c73IEg+feE72p55UEJo0N9HLyjA
	 YAfCPMzby7kzApR+suLXAet7Hp3E4L9au3SgXwKgQdVop5BE/xRoXXNzSSWEPtgwa+
	 on0ncm9rRA0Fa32snDHUOuT7Hnb4ulGoI/PRCQIzOkeioevqWUICQ6twHUSikTu/PK
	 ACm3YmxIGFjSw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8kjH5SlTz4wnw;
	Wed, 10 Jan 2024 08:34:43 +1100 (AEDT)
Date: Wed, 10 Jan 2024 08:34:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the asm-generic tree
Message-ID: <20240110083442.6728646c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kCP/mRUD=6iINEutNxgJH=4";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/kCP/mRUD=6iINEutNxgJH=4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  e8cf41b96bc9 ("asm-generic: make sparse happy with odd-sized put_unaligne=
d_*()")

This is commit

  1ab33c03145d ("asm-generic: make sparse happy with odd-sized put_unaligne=
d_*()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/kCP/mRUD=6iINEutNxgJH=4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWdu/IACgkQAVBC80lX
0GyhQwgAksdfiO07WzqSTRdJWhlopi2GLVx1uNydBeTyyFa+oQECXetQ39mj1dyw
g27EfrlagDSy0a+ALkBLNHbibxhW+qjJ4FeNxTb3t/h5qXy4oL9Mt0kTG4U8HoEG
OJ7Eyq+HgLeomsApIZRr+Q4sIJqwqubot3sclLWLgf5vQG07E/fG9PNMt9lH/f10
UOJ8XfSe9uVCPQ9M+UHCD2paWzWJa5Rnkx+l4TlzDLMM6xKubLIKCe9TOri0T5Gs
ECXHC+w9N6KVVSA0EfCUzHexG2zNU7tNoLVZOuaTFr+2h0KVmTJeZHVoCpFnmeHg
5QCoOicMcSe3tG39FRTITr0NxT2tJQ==
=KX+F
-----END PGP SIGNATURE-----

--Sig_/kCP/mRUD=6iINEutNxgJH=4--

