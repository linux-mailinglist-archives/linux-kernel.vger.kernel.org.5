Return-Path: <linux-kernel+bounces-105566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7959D87E067
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9482821D7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D1A20B04;
	Sun, 17 Mar 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="R/SiLy4A"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC51C6BC;
	Sun, 17 Mar 2024 21:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711349; cv=none; b=NxlByMVAWAfzkrUaL7IQvxUsb90Zm0TBQlgt48jYSwULQiVNbsIl7X60plTun0Vd5Kb7PUaAg0+quHG1ZGnvpbDi5GLi4f12+jZaKmkhl6yYV0pBj27bkj2yayhGH2bndNhRU5sORpVWVHh2rmtP0A0tyhrIReWIt4cbpzv/U8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711349; c=relaxed/simple;
	bh=yKbGbCXrBypOQAQC733roffe4K1OUMu/cmQ7H/CvZss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sJMnjkI/fsOOI3eYLH5+qh42TaokebS8P17AXLdh2xUsmcVbMZbsXWGDkHS3L+99/gIFMxhQzI2lgghsB7rH7jIE6JPy6AyBU5Qfnps5rV/0rqWSq7J23m7tJPtaUPixZ1tZE0ZTAkS14tgqafDwaDXxf2escYMlAuJpyQUaOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=R/SiLy4A; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710711338;
	bh=85a9ZhBFDqVSEG2SAI6nYfwOUOl0VEagD6vUcfzQ8SE=;
	h=Date:From:To:Cc:Subject:From;
	b=R/SiLy4ACUS8E1HgnyqDaT4miHr3kJwOdyy+E7wSc/MLRNDkfC2dj2YgNNyc+ZAo9
	 hbiM9bZvRtvfeFABwZJXs+Q6pWV6wC3gFlt9/LK6i7yuJsRmycHC4NKHk22U9g4kwB
	 cy5YPJkXwH8PLk0ftz9L7i04/azTxPogIDnv2PiIRXiXoj80D5tJ9dhVUJ7KMimlLZ
	 +FiR0uZzt8VxXPVthHkExvM3mB+DFhpoT6wo1xMm6s46ZOLfR4nUt3jgeQB7cMLmDn
	 jcHfug+EuCR0mMfooVnwT8YmbRC6cOziAeJoryMHbymXQT2WKtkhoGFkl1HoKeXT8e
	 CAnBJ4qP1y9pg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TyWVy3Cz7z4wcD;
	Mon, 18 Mar 2024 08:35:37 +1100 (AEDT)
Date: Mon, 18 Mar 2024 08:35:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the ftrace tree
Message-ID: <20240318083535.79501c6e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=i8Z1V_P+43qAAyF517Z+hN";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/=i8Z1V_P+43qAAyF517Z+hN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2fd814ad5713 ("ring-buffer: Make wake once of ring_buffer_wait() more rob=
ust")

Fixes tag

  Fixes: 5b37b7eb98a19 ("ring-buffer: Make wake once of ring_buffer_wait() =
more robust")

has these problem(s):

  - Target SHA1 does not exist

The Fixes tag seems to be referring to the commit that contains the
Fixes tag :-(

Also, pleas keep all the commit message tags together at the end of the
commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/=i8Z1V_P+43qAAyF517Z+hN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX3YicACgkQAVBC80lX
0Gxi2wf/Xs2cl5UB4O8lw507tU53iHX+JzstKihzv+iI3QVTKymR60yikrBBfFOR
JwyR4jr8kFnZFuAf3TfB17J/JKcpiwGRMplWNlKYir6DtybbstPnH0eWWhwBGvG1
5ik57zyNnFRicvbMKkKszfK5a2hOk1gLzii/d/y6PB2jlIech/mhYM22unt4yzem
F52mRfJpqHQvfwV26nvR8BHQUevjPXYKEDuAmlOzNOLSB7FfQvyNhk5OkBlaJr4x
c/mtHnDGRnl/A3C1ZygRA5XBg4s6PGKHu4gWLJghoQ0+t2NKEYfzyGrc9rHu1Qox
XUp1NVvzqPXF74W4Ujj5jPT0WXImow==
=hYsH
-----END PGP SIGNATURE-----

--Sig_/=i8Z1V_P+43qAAyF517Z+hN--

