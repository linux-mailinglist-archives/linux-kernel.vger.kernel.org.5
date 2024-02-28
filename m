Return-Path: <linux-kernel+bounces-84302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B902F86A4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C67F282FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607884C9D;
	Wed, 28 Feb 2024 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="euJN3HZ8"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDE3FE1;
	Wed, 28 Feb 2024 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709082380; cv=none; b=WMIqmsndXRvKwhgwjlSe0TCISIxRiezw9v3Zx5Idhlqu5HZkbyRifyDY+ADTsEBPWPfNCDDOx1iso7zOcJc/uaTv8HsXrAkBIa5ns44Yd42/r95WKcx/3aGwoNRi0ZXVIuw1gaR6yIlQxjyFcqYOOj24R4EmyrTBsVZGWrZHALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709082380; c=relaxed/simple;
	bh=YS2pYE1GPnWlMWhWuj4MACHPGS3lXGICITby3+Zw2NY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sRcJo58Jm7t6cnhX88hu7ruuoTDo/PRLI3gAcAEn0lsKqhFCyBvPRajjxvV0o9EtZ7xaroGarNIvCIH6qDeg5QQ0DyaFfCYOgbCnViAcgKpwEZE6QahyzaD1wTyAlSK0OHLXyqi72TBhhN26zYAa2we+hjQN9doXRJIV6FzNh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=euJN3HZ8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709082373;
	bh=EsbLfL+LUdutNIIrkit75sjNOPvFzTu5+vzPbE+VRdc=;
	h=Date:From:To:Cc:Subject:From;
	b=euJN3HZ8oCmaPqlRWrxhp3GASuup2M+RKYBjdeU/qZnYDk3efXKobtFveeNDe6WCr
	 GJV9Qo48Lg8FxOOegzXdFy1an+KlmjFGtYlCr5D9c4uekS36BSUS9QFRATvVWyxP6p
	 LE5m6PgRC5ya7Egxw+9Lqequ2Azfg9tFKSrQvnHIwbddqa7omWfjUFvDQUl7zo0wf2
	 6Vb85wCqs434apvwt58J0Wi1he7CUkqxqXjmw6m3TUc3LJRKFzlqSy8UyO9q+6Luaf
	 OYYD0/1cvVKWazEOTWsnHEsLIChqkE2Dp1w7n4PtcdCfOlQEXoljIyzdw9Zwkvj5rD
	 j3izuVRDEeCmQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tkx4j0FXkz4wcN;
	Wed, 28 Feb 2024 12:06:12 +1100 (AEDT)
Date: Wed, 28 Feb 2024 12:06:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the rcu tree
Message-ID: <20240228120610.0fdd20af@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5TXCPMz9eZ+7mWf6HaRBaIk";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5TXCPMz9eZ+7mWf6HaRBaIk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the tip tree as a different commit
(but the same patch):

  020eee167cca ("x86/nmi: Fix "in NMI handler" check")

This is commit

  d54e56f31a34 ("x86/nmi: Fix the inverse "in NMI handler" check")

in the tip tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/5TXCPMz9eZ+7mWf6HaRBaIk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXehwIACgkQAVBC80lX
0GxzwAgAh5uVu9ue3N5Xzr2IEufz/54zo+ymBLNW/yCvDzvbr3MvOhmHnjQKgM74
eJn/Cv9X6/xT9pARQX+9lKWut7TM4WAiUDSHNu9sddDUi6n5FcVH8fzTRzossdeY
BG+GJiM7O3nQa6D0tpTbau0v85Tkar3iCmU0/NBSDzAJ2boD4uPg+3s2F2cUoW1y
YN/baMT8ECCkVdCmWsJ0UOz1SO/6j7p/hk0+KXs57ykI0wrXMm+HbTGPeeBCJ0Zj
35j/zDNp0ir4T72Y/LFVN9IZX5KaGZUeIIaHeAkQpidc+z8yAvCDb7wWfzC+gEnV
WBnuC+GNj8RussheX/M5jMd8Z18sKQ==
=TXNg
-----END PGP SIGNATURE-----

--Sig_/5TXCPMz9eZ+7mWf6HaRBaIk--

