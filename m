Return-Path: <linux-kernel+bounces-127072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF5C89466C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CDC1C21B60
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D854BD6;
	Mon,  1 Apr 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="piV6ePZ5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023853380;
	Mon,  1 Apr 2024 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006019; cv=none; b=giTz5l77wGPUHbpm42JEPMjkEYjTktR+h2dUm8SquqJgH/Hkd8UDH069WLbH2IqyNhSalXCOYEfLMXsF8dmxpwko5sdhqUETqMKS/OOXILi6xcCKe35DOk44DsNNurzd+MbMjjKl+dKXSmosAfi/IXieREftIbhi37aXn7LSvk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006019; c=relaxed/simple;
	bh=sqO0nxLw4hQiQMs9lvX4EQHld4CGTL2RnA24u3DGhXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwch5/KuXWKDyzLpLgO134GDEljkwAAB1SMqckUhFQnTMzm4RMJPGzzxbIBQVwdo2gWV4i1ohk2Bu9ftt/Um5xgyTv1OwlpVfvKHYCV3IkOfnTGthDUjSnA0aezqro+lMno+YTmu04XJn19+e8lhmHg93HDrFsQYHs1ao2Hv4Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=piV6ePZ5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712006015;
	bh=5a7LXWD0N7/7gHgDKdN5JZT+yoVzkNotnJc2z7uZDFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=piV6ePZ5T3Lq6IHXDVw6uy5QBCPDEooW+rYI2CGMAfyIJkU3nv+JSxI4LF7I242Mz
	 2Fuyh6qEj1RE9bEkJE7G7xacI1Z0HUK7TNK4m0nQ5kBpc0rfXpBlowAsG1eOUF8/bX
	 /O+peHQ6eOMPT8KGkEzyk5QrrL6DScuCqj2rqarvdEbx9LAfuQ9MgkJx2k9gxab8LB
	 IZRCSbiUFIQc5GURawdJkft/CQ97N5Bmi+qfWWsHHdNQU1Zwz94thgwZ0IaRaHbEvI
	 VxORfa1XQvr1UVDQfU1ejxdXDbZXQGYwBwW8KnqRnII4LFiXdn80xDizh8RDxCmYnC
	 08yYr2TXTQoZw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V7kJY6R4Xz4wcC;
	Tue,  2 Apr 2024 08:13:33 +1100 (AEDT)
Date: Tue, 2 Apr 2024 08:13:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Eric Biggers
 <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Wiklander
 <jens.wiklander@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>, Richard
 Weinberger <richard@nod.at>, Theodore Ts'o <tytso@mit.edu>, Tyler Hicks
 <code@tyhicks.com>
Subject: Re: linux-next: trees being removed
Message-ID: <20240402081333.4a6557db@canb.auug.org.au>
In-Reply-To: <20240327101309.4e7d04f3@canb.auug.org.au>
References: <20240327101309.4e7d04f3@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gVOQY_wN3szY+sllcxbnfui";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/gVOQY_wN3szY+sllcxbnfui
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 27 Mar 2024 10:13:09 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> The following trees are going to be removed from linux-next because they
> have not been updated in more than a year.  If you want a tree restored,
> just let me know (and update its branch).
>=20
> Tree			Last commit date
>   URL
>   comits (if any)
> ----			----------------
> ecryptfs		2023-03-24 17:26:44 -0500
>   git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git#next
>   c1cc2db21607 ("ecryptfs: keystore: Fix typo 'the the' in comment")
>   a3d78fe3e1ae ("fs: ecryptfs: comment typo fix")
> fscrypt-current		2023-03-18 21:08:03 -0700
>   git://git.kernel.org/pub/scm/fs/fscrypt/linux.git#for-current
> fsverity-current	2023-03-15 22:50:41 -0700
>   git://git.kernel.org/pub/scm/fs/fsverity/linux.git#for-current
> modules-fixes		2023-02-06 08:45:55 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git#modules-=
linus
> rtc-fixes		2023-01-23 23:33:47 +0100
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git#rtc-fi=
xes
> tee-fixes		2023-02-12 14:10:17 -0800
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git#fixes
> ubifs-fixes		2023-01-21 16:27:01 -0800
>   git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git#fixes

OK, I have removed just the ecryptfs, modules-fixes, tee-fixes and
ubifs-fixes trees.  Please just ask if you want them reinstated.

--=20
Cheers,
Stephen Rothwell

--Sig_/gVOQY_wN3szY+sllcxbnfui
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYLI30ACgkQAVBC80lX
0GyzeAf/fFMPGbcATE8fmGkBS3WSdYocY9T+ecXv/6rrxKu4sGNvvGtfjsVA05gt
f3N5iKsm2aX6FVHZCVZTxQ2yrEXj7Y/gIcOffUdNLGT6Kj9V3xGVkt9hxOT2l+YC
2T8QBFB9kL/KaXooYNWCNsfCOrv+DmqPI/tezFUEc3ojRMa88bZNbJggwgLPT1em
wfBdsEMnJdwxMl/0M83szCTNBRj9vGlhoY3ATJdW5PoIYbILCqTqLLvJ7o0GkQPa
dN8yzdVffzKbaFldEpWAo1aA+0Vtt4U6L9KjdvHyu183fBi/RXqwSNBa+WRj7K/6
8fVDMMly+JqvW8vJwkSboPBavsZXDA==
=dte5
-----END PGP SIGNATURE-----

--Sig_/gVOQY_wN3szY+sllcxbnfui--

