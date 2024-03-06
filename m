Return-Path: <linux-kernel+bounces-94625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE97874254
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C97E1C2097B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB11B947;
	Wed,  6 Mar 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LB1+qNkt"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C686C14265;
	Wed,  6 Mar 2024 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762586; cv=none; b=GBP19MdkUY6oRHQVT27/vE6P1GV5gVazeBN+vUq1Ct8Tm8800io2gNrluNGsAkLxLmNNl0MHaQxyfErbqTQPAQKBbvqsEzYvboyT1M7Cr5e9FxyHrGebz/0WnfyYnjdnUXMUD1ukeWaLcKML0T+8AEiGVAhVipmaMC6e2DEb3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762586; c=relaxed/simple;
	bh=cEbUuXsZACViKDPcLAjXi3B8PzKkHg+TCY3LacfiDl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qrXdZenR1xHywRj+B2VDJC4+GoyHaW6njuDmqBe4la518KYvZ3YisFlNj+FsS6JzWGzknVAPTRmTc7CfrnCgVliFeqK5tmMzcz6wOm8Z/GATNgtgwH2bMjRri5wAVdqB5npuvxiI5wKSxzaeguTG+bb73patfYYTE2ykQ1ZFeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LB1+qNkt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709762580;
	bh=kUMpoFQbGCQarorx79BVdrmJa2tpnfUn3HLRzolwxk4=;
	h=Date:From:To:Cc:Subject:From;
	b=LB1+qNktKtBZIW556ltEtK+XKKv3yn3+wvTOWwTZivnFsLF+VxnNoAmr7VCn6IhPN
	 SDgA6pQY3S+YQjbeFMpFoGTuyN25SW6ghD6fYbbiSdigILCDn8Y0OQEPWYryJ5U7v7
	 DNoOeZ+zeouxmdpvrasH+qCmm9EI+x8KtxWgUyGwkYSXwNrDCxAghssqppIYE8ahpN
	 AzgvB+nm51/IvrX0LnguCtlobcorIYxdZGXxo9nk23fapMB6HcnDeIKcrSs9DevJmB
	 0ZWbTZuphOifsjlUyyJ/zzLJJ/bULGKA4eNa+a8u82h23s6CIwgn8icDjpFsVhlc3g
	 VxbrqhrgFy9ag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tqmdc1wWDz4wc9;
	Thu,  7 Mar 2024 09:03:00 +1100 (AEDT)
Date: Thu, 7 Mar 2024 09:02:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20240307090259.6ad93e35@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CQ0Q=+IN.dh1kQZhmxVlM0i";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CQ0Q=+IN.dh1kQZhmxVlM0i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  0b9887fae769 ("fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conv=
ersion")

This is commit

  961ebd120565 ("fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conv=
ersion")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/CQ0Q=+IN.dh1kQZhmxVlM0i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXo6BMACgkQAVBC80lX
0Gx0Pwf/c1dFvPnxrTzNQIdOjZUAIUjzacHT2CUGWqODHy0stbNU5kcxsod7Q0Eq
ksUJH925qqnL4AWN5z9LqALHjGyp121FCbqOOxx0UcjjANS4/miAV3od9hp5VLH1
mLlsbw6ueQlPtMtelr/7yvHQ4BBssP7JdSGTvxSiAZvoih+6TFBhMgyF261xvD3Z
tQGHaPfOlK0UM4bqdQc8JWRkoZWEEQcEbqewLJTY8m2ANmt/EF7QKokra5mf5BA1
Cwsch34XwrCsrDn2KQ6gbP+Hxq10o521nLl6PLWvsd7AhWvQ3BzEpHLZjo7Q7d1u
bbogEZOgOkXiKPQClmCh6oAfrl+5ww==
=5lG4
-----END PGP SIGNATURE-----

--Sig_/CQ0Q=+IN.dh1kQZhmxVlM0i--

