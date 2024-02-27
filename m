Return-Path: <linux-kernel+bounces-84221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15D286A3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4358F1F25ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F0C57303;
	Tue, 27 Feb 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FKhiW4nR"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95FA56472;
	Tue, 27 Feb 2024 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076655; cv=none; b=q0YhmNrl4PWsm1ev14+DabeTjIkCxJpu9cTRNfjs9FCdfnp7NgzAP6DBYNBRaKltK8WHb0wny0aR0e/rnoENfLbQLaTAqbUPZc2VTYi8rr1cadCQP5s/6IaiW/dgY1bjP7/6FHGDRW6hOAzBKIPVfyjxvjPIRaq5kP/jBN4tsuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076655; c=relaxed/simple;
	bh=bUJHIJRg3POahLw0GfORsGHH1fd4pzb+GmAQDnwGjsU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mTkRzdvinqkW3bdmhJtHDmbZjpyjuWoVgYiv+iSLcdV/n3kPu5wH31S2G6a6rGo/iyJ7IMwXhe9Ea6x7HYKSvFqO4Ovfw2ImgofXf0rONpxbUNxp+l+srirYX/ETgIZjqOPFMI6fAyFfst+EWC6/8r3a2UJeWuUKgB8IVWamWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=FKhiW4nR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709076650;
	bh=MZchj47zYj+QSOmLHezdAMO1dxkIaLbd/TINPOfwfV8=;
	h=Date:From:To:Cc:Subject:From;
	b=FKhiW4nRfdjyM+u8+WdOkeXVvaRKG4pjk+Aw/Xny5s+23YMn4jvoI+wFzObH/tU09
	 DFpGv2+eQ/C5nu4NbZ2728E4V5rfa1NVzIqatGxbb2w0V+KgGv6tiVBGBM5jL6WrRe
	 9IRJWQpg/xmO+1pHUzQUh+ShJa+ce7FI5L3Cdfm37aYmHj80wwLOoYZqLUaXI+PA5/
	 +P95oa4hDre7glsxrUn+ToYzMqviKggtfTzVSCCeHIzJFYEv1s8gCkER/O3x3yKjmK
	 AXCfzgjtKPosHfJ+7pMPP8uAmlRqSv0ZidRtGPJtdJ2TWr4ZojJ/ETzP+Sqgo7M4GI
	 B/feo2gGFD03A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tktyd5Hj2z4wcH;
	Wed, 28 Feb 2024 10:30:49 +1100 (AEDT)
Date: Wed, 28 Feb 2024 10:30:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20240228103048.19255709@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5=YtmZs2k2MXH8fb2+owVj5";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5=YtmZs2k2MXH8fb2+owVj5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/mptcp/protocol.c

between commit:

  adf1bb78dab5 ("mptcp: fix snd_wnd initialization for passive socket")

from the net tree and commits:

  d440a4e27acd ("mptcp: annotate lockless access for the tx path")
  9426ce476a70 ("mptcp: annotate lockless access for RX path fields")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/mptcp/protocol.c
index 7833a49f6214,9df4eaddfd48..000000000000
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@@ -3242,25 -3204,18 +3247,25 @@@ struct sock *mptcp_sk_clone_init(const=20
 =20
  	__mptcp_init_sock(nsk);
 =20
 +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 +	if (nsk->sk_family =3D=3D AF_INET6)
 +		mptcp_copy_ip6_options(nsk, sk);
 +	else
 +#endif
 +		mptcp_copy_ip_options(nsk, sk);
 +
  	msk =3D mptcp_sk(nsk);
- 	msk->local_key =3D subflow_req->local_key;
- 	msk->token =3D subflow_req->token;
+ 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
+ 	WRITE_ONCE(msk->token, subflow_req->token);
  	msk->in_accept_queue =3D 1;
  	WRITE_ONCE(msk->fully_established, false);
  	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
  		WRITE_ONCE(msk->csum_enabled, true);
 =20
- 	msk->write_seq =3D subflow_req->idsn + 1;
- 	msk->snd_nxt =3D msk->write_seq;
- 	msk->snd_una =3D msk->write_seq;
- 	msk->wnd_end =3D msk->snd_nxt + tcp_sk(ssk)->snd_wnd;
+ 	WRITE_ONCE(msk->write_seq, subflow_req->idsn + 1);
+ 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
+ 	WRITE_ONCE(msk->snd_una, msk->write_seq);
 -	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + req->rsk_rcv_wnd);
++	WRITE_ONCE(msk->wnd_end, msk->snd_nxt + tcp_sk(ssk)->snd_wnd);
  	msk->setsockopt_seq =3D mptcp_sk(sk)->setsockopt_seq;
  	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
 =20

--Sig_/5=YtmZs2k2MXH8fb2+owVj5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXecKgACgkQAVBC80lX
0GzWfAf8CykVJwsWyy2zjDAdU3deB/xYDzGOFlDZDEmzx1vpa3mzjRlepP+/sdxF
ElCcrMu6nD9ILig+adgv6t1GOa1Vc68wvKaF7s8AUtnNLmKS2EyLwdM2lb6gEdQm
4i2HK+K+z+udh5kYZH3ZdsK+JEYCTR1lqYWtCsfJMM+44PKuCY4rHGJ5mLyvDkiN
og6QREDBY/ciVh62mWQqEJNF0hAXF6ykiBbC+T+zUQCH1m5lyh/pZ5gNMjp0BUqQ
/s6mRX+0fjNd5t6HhE9369Lm5I/yEznAgNcu/B5GYRX//TfpvbjEJrjROulYpoF0
Y8AVlBJiIxJkvcm890i9EBochmkmjQ==
=wdgr
-----END PGP SIGNATURE-----

--Sig_/5=YtmZs2k2MXH8fb2+owVj5--

