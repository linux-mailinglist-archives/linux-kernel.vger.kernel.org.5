Return-Path: <linux-kernel+bounces-89927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9363B86F762
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1BE28151C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAED77A728;
	Sun,  3 Mar 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="j2rZ5kfx"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028743AB5;
	Sun,  3 Mar 2024 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709504507; cv=none; b=pNWzgbDqk44BZ5hj/CCf7nX3iHxcNXvd/57HDCm1jqW0rZKJqWx9Gnvd/oN3Ojb/9yzffZRMEZjO1P5yPLvKqxKFmzSWnQzUjf6ouFMqOJzarhXmVKufl44d30jVzUGyuy+FW1utDBVhXDSGfFGbNgHMnK5fuCB5WvTgVkCaLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709504507; c=relaxed/simple;
	bh=EfzyKzAbgLFR2CzCYuX+dIcZmAUB/k0F/R/h9NFwYgA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uBHMjbm528RRPoXjQdqPOWG7BHdfqtjopboi83q9jdPw9I/ulFsJ56zot1csrj93WQa/LJA7uKJiNBKtCU7GbFHkX6Qhhg6xAlXBBjXWTFuxG5nh5EWg8YeTg58kZ6EVOap96Z9LMaJfzqq9bJUegLkueb69Zna0mpjXf/IlYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=j2rZ5kfx; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709504502;
	bh=6LkyvAnEgc4J2uuTOkK5dtl+jxBGj860xS/GXxjoqJ0=;
	h=Date:From:To:Cc:Subject:From;
	b=j2rZ5kfxlPtzmKnUS3q7EFYyf8jDjMIhPGBllYkDvaylZiQRNISJEtkesA4Rcv2At
	 ihLfDJ6dFwSNCj50a5XBcc2jnJLFPriAlgueElGTli8Xa+UzV1krykMksgiR/VIivo
	 sJmhd+9+PJd1ZjVqhNOv8KkmGlAGzXPG05KVYVli3grWtXpm5hknAkSkvdXKeYMB3Y
	 tOqjpdDBHE3DMiAStCfQmUEyksmrLgduFiXpcA3cjmsl3hAhf5XZvGkL1HNS4W8HXS
	 D2z4vnyVlXJiAcH7bRmHl+efFcthJLmKTQtDWzNFkdQ/CsaY4dt2t4VbkRniUOrsdp
	 4qvKyHn3GT4AA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TnxBY4XWtz4wc9;
	Mon,  4 Mar 2024 09:21:41 +1100 (AEDT)
Date: Mon, 4 Mar 2024 09:21:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: linux-next: duplicate patches in the tip tree
Message-ID: <20240304092140.0adb0f26@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UlOG3=sADHW0lw_S5vRP0lq";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/UlOG3=sADHW0lw_S5vRP0lq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  9e1daa3bfccc ("x86/e820: Don't reserve SETUP_RNG_SEED in e820")

This is commit

  7fd817c90650 ("x86/e820: Don't reserve SETUP_RNG_SEED in e820")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/UlOG3=sADHW0lw_S5vRP0lq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXk9/QACgkQAVBC80lX
0GxKvAgAiYMaGPsb7O9ti7ghVJlKDEn6GA1qyJ5vFaiJNBdD2VfRRjWTK0zfOQrM
81mPmS/Ol1zz6RfxC8hHJ/awRxbvXo1zWucb8uuWHWpnk1tGspkE0pwaakHq3FiX
G9eqkUlOUrPYrynQsGl4ty8qD5y/7Os+3PiFc3wp4cWcKOyKiEHKCeApeKSr8ZUz
zEvLvakBbefQrN1vgfNuCmbNmzzG+4uw2Fx8umJ3ynde+37OsUlgp/tG+mAkS8ZA
geAJ7y0EsrwcubHTh2y/zxPFJ9hNa7On7ZJUVeo76ykMaznBVEhli2zrwBMyIEua
LuRDzunJfO35rD/gWpnasbmnErlw9g==
=CFCS
-----END PGP SIGNATURE-----

--Sig_/UlOG3=sADHW0lw_S5vRP0lq--

