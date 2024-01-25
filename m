Return-Path: <linux-kernel+bounces-37925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0744983B858
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4099285F34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3375101F7;
	Thu, 25 Jan 2024 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BDYpYNoP"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443D16FCC;
	Thu, 25 Jan 2024 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153617; cv=none; b=a/2dqGOL+juJgPsvXA3u5PZ4gdn2G+DvzWlrrl04dfDfmQkNDONIZOF8VJ/zTeMJUWGWbEfBEmzQGcFyvta25VdXzv85h1C/ePqoAAx+yCq/FJcp35T5+Fj02u1rB9OTn+gTmwtneleZw0fZsWK+4bYsT63zcvInaRWN53ZKbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153617; c=relaxed/simple;
	bh=H7NEf2YcHiZOpM3JHtXHkiCYY+h2h/ubcsnwGUGbO+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pYeUOg01GpsmWL5wvgg2Q84Fh/O23Pny0xvhCUGwJ/4K3ImF7r3WHlaPQeP2QzA27Ca0qfIl+e+O44lmYiYJQX5EgOu9oiasThrcTIkNZPi3QIGJgIyi5QpNb3GN46cy59g3LygkPqw4pQyqNC+elVskASbhsRa1UVPgxj4tHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=BDYpYNoP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706153613;
	bh=akJO31NPGa6kVoY15z7PGuCR8qZylspHNmpu9GK6JW4=;
	h=Date:From:To:Cc:Subject:From;
	b=BDYpYNoP8r9DNmaxYnQPTV9V7F4O1XqvgzPadOLLQmRx63mv8yuyKISm52vO8352l
	 UAMZd02Eg8ZzaQLLvR6Z3lTbEof0bUoZdkCecJYVMcznk7OMpawz+Jxbe1SRfYC2QU
	 DOZhTFZvtwFYpubqvxKzKUxATAqwgibcXpu0XTBcpukg/Zb5Dx7/9XyIa5aOZ8J7E1
	 +ubwnRqT2dRMe326gr+f/QiQEp7zbFjDcsQNDt6dzSi+XmOkGHUITFhLdA+t8+r3NG
	 8L7UA9+5OACDLl+Nrfrp5oD/YcK98ppccxli/fR4qti7/eit2OCyzbp6sXpZah6irq
	 sMcj2p8H9PC0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TL5yP27njz4xF3;
	Thu, 25 Jan 2024 14:33:33 +1100 (AEDT)
Date: Thu, 25 Jan 2024 14:33:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the rcu tree
Message-ID: <20240125143332.70c0866a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iMu4ZczDKkKeTGrAY_seqc.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/iMu4ZczDKkKeTGrAY_seqc.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/hrtimer.h:199: warning: Function parameter or struct member '=
online' not described in 'hrtimer_cpu_base'

Introduced by commit

  7525a3cbb106 ("hrtimer: Report offline hrtimer enqueue")

--=20
Cheers,
Stephen Rothwell

--Sig_/iMu4ZczDKkKeTGrAY_seqc.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWx1owACgkQAVBC80lX
0GxlLAgApi9bRVok5sZPp1kQgo2lUp+18i3VcYABrzhdJjHm1ZH6SHn8Xdh3k2e6
V51MUVUZCFD/Tb7yoVKsnNwFw+E3Rfn2/NhWrrQ/AH+Z9K+TiF/gg1r25MSIj/fB
KFHGRyplmtYLgIUTQuXg98+pdARxJrSei/LOGltA/X5O0ipFrv04U/GFVwqrgj3D
dhTCjWd9DEc/4RkOWcXqR7SUxjVmtxY691lp80X+QFM6YiNIFYCVRdYDViCx+3Nm
hnkFsZm5O1kc4sDmHHIPBj8ryyn/8ozvPkBJHlQobUPQgdFGiZU2nNP302FRmRuq
W3kYC1VJFMEbu5WGq61pCq4dgS7nfA==
=jGYE
-----END PGP SIGNATURE-----

--Sig_/iMu4ZczDKkKeTGrAY_seqc.--

