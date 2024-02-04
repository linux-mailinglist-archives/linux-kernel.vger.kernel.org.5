Return-Path: <linux-kernel+bounces-51916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB058490AE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51031F21E07
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD92C69D;
	Sun,  4 Feb 2024 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QyXEZKdh"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D487376E1;
	Sun,  4 Feb 2024 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707082209; cv=none; b=cLPA/mcyu8EGANe0ngcE3CU8mQwbxsDc7rQV+csVXCNsL/cN6jNBjF2Rx54fxzfJ32WSEpl5mtU4UmlIhQfX0hSA8qO9X94lSlHV4ej53ZORydOJHHtKsnf5zXCgJOOdzmlYurvRFoJJaUZalGFfCUbRnqaECHjfD6Sb/0lw4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707082209; c=relaxed/simple;
	bh=JQ0zUz1l0mTDkk8bS6tBo39s7e+mi+NPDwnScOgeYcw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tteuGMNcRKLrE0xhxbzg9WSq1/XA2jbQuKyYd9bKFaS02Wl97j2Vk7d0Q64oUzLq8Gncn1fjC36rDCGOO/8Z4ixF9rGqBDkFNY/OhEpmS5F8MrfZM6XyzcN1n/gy0/7UWmMKbkUZYLOCQr6POgVB1MXMxRiIaS8edb/VzFWxhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=QyXEZKdh; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707082197;
	bh=rk1j7C6A23t5nXWPgqJXUtNrPH7V2Kfa7sANGsAkP6s=;
	h=Date:From:To:Cc:Subject:From;
	b=QyXEZKdhz4Snu0Nw6Svr8lT3i3YHA47TIM4Xl2qonyhH1V2nysfB6sqc7vdhANqiL
	 1dqiETVrzjgOHW73VBA6IbjzJFO5Olyjs6OCmzkJ+Im7JaU2wTBiKWz5SPc8LXxQ7T
	 PXpEes9gnVkstXE3LB6Tg2zBwdzbzMVTCGkPHBOayIsfRG+qa8Co/EySuMQIs/zfmQ
	 NAz0w1dmVfO5oA6tV0PhgyMPiiyzN5vFuvF5O+VOiehK645tIcHLE4tk6gT/s6O3sT
	 L9ys6Dq43cH/aU+VPY7el9J7l2ilJuOTnCrixzXiDm0QfQFlbwpGIPMDaGVQXe+8OC
	 JkI2VchO3RG9w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TSjMn2wcsz4wp3;
	Mon,  5 Feb 2024 08:29:56 +1100 (AEDT)
Date: Mon, 5 Feb 2024 08:29:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mm tree
Message-ID: <20240205082934.2a8b10bb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sL=JypT+KbJREMCx8JcYpnO";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/sL=JypT+KbJREMCx8JcYpnO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d2593cf2e3f2 ("mm: memcg: use larger batches for proactive reclaim")

Fixes tag

  Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive =
re=3D

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
        git log -1 --format=3D'Fixes: %h ("%s")'

Please do not split fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/sL=JypT+KbJREMCx8JcYpnO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXAAb4ACgkQAVBC80lX
0GwLtQf+OWksLdvFlSDBQKV1fp9UDkmwxulgjqW7LTQvA01oT5UgSiRzPLKGAf3+
neTBzDzWrolDqECt/9WHPcXu9AOmj/v4AqUZKk0zO30WMy8mlVcOxF7o9iUltFsl
bNbYRjsiHJ9iRpQsz7IzkWUJE09ZOB4snoXWRKyVVvwJjZNsTME4XID33HZSrgx+
mTBwxg19BGE712dgaTJRDkdZZnvdGEYoslDeTUjjcEhsxttifsHFRekoTxDEx58R
E7sojBls64UHJMtUryc2Y2m3mnLNMbfi/MlkUYxUZI5tkZQrRC3zpXMMuxRYhxj7
zIhaJ6YzoW0kJr3VFofx5nJXriN2UQ==
=YWra
-----END PGP SIGNATURE-----

--Sig_/sL=JypT+KbJREMCx8JcYpnO--

