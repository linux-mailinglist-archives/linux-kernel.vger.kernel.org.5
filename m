Return-Path: <linux-kernel+bounces-116367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA10D8898A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7B81C31EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F88D1C7371;
	Mon, 25 Mar 2024 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Nyz1hGG5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361984A5F;
	Mon, 25 Mar 2024 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711329479; cv=none; b=FA7lfs9YEnGjmiIEd1kymGRIZkVUw+5SGd7NFcQjS+4SYf40nPP+iOHsB4zKouYQ7SPkBA1QkvLbDKr8OFT9IK2KPNndRQDuQILkcLHJ74FcHsStyn8uT3IMb9IX9aos11Yu2QbVJ8xwj8IKz1/XURRAUrHyDPMZ+WOxUeXfkko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711329479; c=relaxed/simple;
	bh=2pjen+/QF94Vw+0dTn5AWmfHw5VFqfbIHXltOn7FJRw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=OhdVaYyaN2KGdpo1Jh5fWTesyJzr6JQT7DODU0HM0+j6VZBRg2WiyihsuQtkNUTWviSqGjtkg7RWxvRv098MEicFnHuwv9FfIXAkpSxuxusn4Q71aE1undAaxJNMaJcsFzKZWawH8l4JzJYIWS7Y+3AurbauvOw1h2HhI8jKgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Nyz1hGG5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711329471;
	bh=R3m7yjcZNycqnkg9NPCuJ7FZGvORJBO7WeUN/gWztRE=;
	h=Date:From:To:Cc:Subject:From;
	b=Nyz1hGG5yKNoJJeD8Fqvtg3aYokqNm78VjxSSV/kLqnKVlHNI4kbEGiPkJCQp558j
	 3i82T5rhjJ6P9bSTtJDgCJU2jqs4HYTAZALOPz3gCgeotG+fjS5bUe+Nw6Pw4J8srB
	 0A9TBxRqNemQwbMTIVc2FQuh06eOyiL8SvFL7uCGKMjl3Y4mSGxXGm0YWrBM8Xts0m
	 MP9RkbLDy0o61+aqUoKue2p17QUOgnSzRlpWlSUqZLGfTudtAboSJTAOrFu2+B89Np
	 d8szMY9HVjBaGLc4feoJ2tRT3V2DpDPxWZMWddKfOcDEjMXjMnB1KWlY9wQAVgIhUl
	 lfK+mjVqk+HBA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V2w6710Cgz4wc3;
	Mon, 25 Mar 2024 12:17:50 +1100 (AEDT)
Date: Mon, 25 Mar 2024 12:17:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Luck <tony.luck@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar
 <mingo@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the origin tree
Message-ID: <20240325121750.265d655c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qyAUH5IjvqiKN88G03lXbT5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qyAUH5IjvqiKN88G03lXbT5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Building Linus' tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/arch/x86/resctrl.rst:577: WARNING: Title underline too short.

Memory bandwidth Allocation specified in MiBps
---------------------------------------------

Introduced by commit

  a8ed59a3a8de ("Documentation/x86: Document that resctrl bandwidth control=
 units are MiB")

--=20
Cheers,
Stephen Rothwell

--Sig_/qyAUH5IjvqiKN88G03lXbT5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYA0L4ACgkQAVBC80lX
0GygZAf+Mvlj926dpwblPly2yOFu7R2Ss7+oM8XZBPrEaqTn/ULw094XZhIqdpxA
JqNQbmXu2bYPJ/KDX0gRq3BuABn/zHuEPZg//rY3MVmhkuVFxnQUvlvhjHeJxfA4
4njHWDdv02HJPL36D3h7HD5E7A23//exU6PNNFaZqFx9S8igrY3GGLqTwUKLY8AS
lIPuOQ7veBstGSPiNENw/zTEQ+V2j0GHgUtXDtGZ0gz4P4/vYSSRXvl6C6NG4hKv
1XT9fipwirRYS2pmjHjN+940i+qPemkh8kPpcJAA+vQLGMGMz7SoZYtky18mV7wV
FnuPsyEMpy9hj/DXy0iyj8HlBXezaw==
=znTC
-----END PGP SIGNATURE-----

--Sig_/qyAUH5IjvqiKN88G03lXbT5--

