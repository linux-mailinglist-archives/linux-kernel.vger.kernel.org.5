Return-Path: <linux-kernel+bounces-57036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8698784D314
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435FE282D28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E25200AE;
	Wed,  7 Feb 2024 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pJL1GQKn"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB81E51D;
	Wed,  7 Feb 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338365; cv=none; b=DZiNVl+IU1IFXA0PkVtqxvbtPYJCmfnURehAcKa5vXkZ7GyJtUIzZ7fQ9gkS8opm/yPQZ5KpkCUl+aHy5TC/ZNBNF8IdilxE7iZj4CJ3qwjtZB2c7U4zBrgK/mNlM3ViGhG38ecfseCNurfkSUjNTkUQUAWZHAM7Uw67cx0QEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338365; c=relaxed/simple;
	bh=+pV0+8qDdChKtmx0t9A64zywROHX0mVmd9jAAz3iw/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ff1rhvxrmFIaCN9weCZs6UgyZi3fA6XSqf7AVfL7QMDWfrnhJBkwhizxJPB4clXPMsIG0swJYjYZA+qgNjdIqYckglzPbqdIpLPYGJJDbR/J193xEPZpuMcYUZyAiO5raIQVHafEbV1mNHXZlydmg9Gp13OXUfAnrQDfUuLkKX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pJL1GQKn; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707338360;
	bh=53gF15hnCk5H9SyIfFOqImI82AGDVw+NBoAxcouD8NE=;
	h=Date:From:To:Cc:Subject:From;
	b=pJL1GQKngrXSSU2+7wMN1bG8kIN6JbROBJKAJC2p2fcjau6s3m1cb4rAlJKHNRVf/
	 Jd36/m7yxGUxm/e9jUEruZrUZhHvns8gh5tovXZ89eTM3Eh2/5gHGRkLklrH/tzcM5
	 I9e4XxPI3f7OYdGZfnhDlDi1FrafwDK9dTvYWn1333H448HZ6OWPZTagTKWqu796Ny
	 crf/J/XFbSHhe0U0fyJMh+XrwPyPzvMFY5mABm+IROiVtnDQS5hNJ6zx3qab/75V6C
	 KHzZX6aiORe/qtzrP6img+dnqJbNAyjInOWM4ONpmygB/v/PGKZBjTK6O66bA76I8U
	 gYvSGnLeikZvw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVX602Fg0z4wbv;
	Thu,  8 Feb 2024 07:39:20 +1100 (AEDT)
Date: Thu, 8 Feb 2024 07:39:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20240208073919.39bc9af0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/icilwj.e5yz3_e4Pw9s9TBa";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/icilwj.e5yz3_e4Pw9s9TBa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  cae00f2ab011 ("Revert "hrtimer: Report offline hrtimer enqueue"")
  9addc18fe8cd ("Revert "rcu-tasks: Eliminate deadlocks involving do_exit()=
 and RCU tasks"")

are missing a Signed-off-by from their author and commiter.

Reverts are commits as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/icilwj.e5yz3_e4Pw9s9TBa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXD6ncACgkQAVBC80lX
0GyiMgf/exNs2Vqoo5MnvFSvijBwMEjTNunRcUHM0PBu6o+FJrf9s2SFSjoS2CkW
hvPfvk1VmolnZUFc1C7ZYyEywtDhEpTBBSGKsXQf7exwYHlhGdbC2if+q9NluZGO
iDrpW2WqYn+D/WxXMuf4NoTrH3iWrx3SEeQfIAs5XDTlo3sKsvtR5StvYofz+w38
hHfcvNs8HKbZVXmwCVnQzUb5ZCVvEh40TL1Bvb1s1n/rabr16/qjMT79LzdO2IjF
jkET8rFzH1djIMLoXtuX3n83n2Sk5DmiitbpK5Q56yGq9mvudQTkUSZqr95kIri/
kuPJtvxigyhQGRdW+mpA2dT2fiAYwQ==
=BBYL
-----END PGP SIGNATURE-----

--Sig_/icilwj.e5yz3_e4Pw9s9TBa--

