Return-Path: <linux-kernel+bounces-139635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C13658A059D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F213F1C21600
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DFA6215F;
	Thu, 11 Apr 2024 01:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M0vq7m0X"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA629CE6;
	Thu, 11 Apr 2024 01:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799522; cv=none; b=q5QH0fOcJqVfJgI6Kq4GyHc6C41iUdVgcimQ6ukgsWU2Q+MRIb6+w5QspQ+zqqe+3xZs0pXjnpBa60LKpk4NrtNWx0ywfZQ2tE83bG7w7dtiLNFYcqK/ps4dNoQEoNAU2ABfxyIhtzc1rgWnUhskGzuns3rIL+gUNGrIoc326bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799522; c=relaxed/simple;
	bh=jT6pUYF+gNcGo47vf9X95umMLPeSkId51q5nzxueMJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZsW/+Tv9jYnRUtFVh1GqVVm47iwIU/LZjGnjxxLjuflJXDisaIqtrwXqUWgBiE4YqYC1wzh8e5Qs0uxmgb9bMZR2AEPqcnO5aKE7aP3Sk6yS+hrayiqysFms0zaezES6m3VKyv9gSCEsa0ZhzvSPiZR0UEsnrjbVJcNsJNVzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=M0vq7m0X; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712799517;
	bh=zeub6wzGgYoN50TfkzxBwUllVnK72jWbC8vD4JoZgDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M0vq7m0XQt85Xl44jMp1YvSljh8CBazhm/l9UwhMvQsustwRaodgHNxH2P06mpBQs
	 8u1aRgPt7iWa/Ef5iWDjCohsWAFqpkBD/B5C4XnqB1XoNy/O1AdapwHBLB4Y763Wsk
	 KrmGf5TDLSwr+rsujyQ/iobW76DJVbKESY0OjbEAoQ0vAgh1d2KTep0iDPz4XMynmU
	 ABAKCrtOwyqBfmbWCAtazUBDzGwkLnHqQ448ElfjdzVWQOx3lEZi5brciP6ujsYOUC
	 eJCLyn8C+nMKdniyb/y50vSS/wPbN/vmWLulo34PYtAHbA2JD8cMBdseqnSRyxuusn
	 dle41iOUv0ZKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFMmD4h8Cz4wb2;
	Thu, 11 Apr 2024 11:38:36 +1000 (AEST)
Date: Thu, 11 Apr 2024 11:38:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the net-next tree
Message-ID: <20240411113835.713ccf11@canb.auug.org.au>
In-Reply-To: <CANn89iJyXNKycL1kd_KP8NH-qU7siv8BGW5PGLexjmqaXXGciA@mail.gmail.com>
References: <20240409114028.76ede66a@canb.auug.org.au>
	<CANn89iJyXNKycL1kd_KP8NH-qU7siv8BGW5PGLexjmqaXXGciA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X+hQJFyq5z7MEux5de__XW/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/X+hQJFyq5z7MEux5de__XW/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 9 Apr 2024 07:10:40 +0200 Eric Dumazet <edumazet@google.com> wrote:
>
> On Tue, Apr 9, 2024 at 3:40=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
> >
> > After merging the net-next tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> >
> > In file included from <command-line>:
> > In function 'tcp_struct_check',
> >     inlined from 'tcp_init' at net/ipv4/tcp.c:4703:2:
> > include/linux/compiler_types.h:460:45: error: call to '__compiletime_as=
sert_940' declared with attribute error: BUILD_BUG_ON failed: offsetof(stru=
ct tcp_sock, __cacheline_group_end__tcp_sock_write_txrx) - offsetofend(stru=
ct tcp_sock, __cacheline_group_begin__tcp_sock_write_txrx) > 92
> >   460 |         _compiletime_assert(condition, msg, __compiletime_asser=
t_, __COUNTER__)
> >       |                                             ^
> > include/linux/compiler_types.h:441:25: note: in definition of macro '__=
compiletime_assert'
> >   441 |                         prefix ## suffix();                    =
         \
> >       |                         ^~~~~~
> > include/linux/compiler_types.h:460:9: note: in expansion of macro '_com=
piletime_assert'
> >   460 |         _compiletime_assert(condition, msg, __compiletime_asser=
t_, __COUNTER__)
> >       |         ^~~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:39:37: note: in expansion of macro 'compileti=
me_assert'
> >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond),=
 msg)
> >       |                                     ^~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_=
ON_MSG'
> >    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #co=
ndition)
> >       |         ^~~~~~~~~~~~~~~~
> > include/linux/cache.h:108:9: note: in expansion of macro 'BUILD_BUG_ON'
> >   108 |         BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GR=
OUP) - \
> >       |         ^~~~~~~~~~~~
> > net/ipv4/tcp.c:4673:9: note: in expansion of macro 'CACHELINE_ASSERT_GR=
OUP_SIZE'
> >  4673 |         CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_w=
rite_txrx, 92);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Presumably caused by commit
> >
> >   d2c3a7eb1afa ("tcp: more struct tcp_sock adjustments")
> >
> > I have reverted that commit for today. =20
>=20
> Yeah, a build bot gave us a warning yesterday, I will fix this today.

I am still getting this build failure.
--=20
Cheers,
Stephen Rothwell

--Sig_/X+hQJFyq5z7MEux5de__XW/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXPxsACgkQAVBC80lX
0GzuKwgAnkJD0uqw5ZtXjSDD8uCFvlBwEqSeumc2wsMbPKDqvz0f5SjYeKCfWrht
efuN+i8DZg7rbw8OszvdWIgyPU8Cw0lOn1+Ojv+kgHt0d4Q6iW/xQH5TlNOY8oGs
Zx2Ga9TB26Y2lHKAWrSx0TpvZS2hJNNdIdFuUkPBK0ukzOcppxl36b6jXm6V2qOW
S4pxr6imP33SQRO81f0ceJ5avNiCm887k4iGenYFvAbAISFV8Ew3mmzJarHJCD2M
y6dlqXr7bb1ev2E2BliTnCARHIqWHjn1fA+v5L5I1neShOTPt9BHCBzefolOm7mX
nyPDdnAxMobBWeMHD+Ly8w/XUwpeFQ==
=ZyYn
-----END PGP SIGNATURE-----

--Sig_/X+hQJFyq5z7MEux5de__XW/--

