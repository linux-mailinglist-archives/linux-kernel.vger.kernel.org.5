Return-Path: <linux-kernel+bounces-122310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF56388F4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853321F2C9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45B723767;
	Thu, 28 Mar 2024 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LHWXxeR5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1E25757;
	Thu, 28 Mar 2024 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590916; cv=none; b=sSmau78tWRP2q2modaV51c1qCfZCcUFXBNFDqj85O5ih2URQ/h2zCvI1Y8swtOATqyT5iZ1FW+5ElF1QLdHVg7d6QHWZgSp+ebVq3CcB9Rp5OTnV8OjmVoWyleVsrer33W5DcD1y5JPBTB8pS5e8xyE909Kt1Ae7FVzQ/VSeN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590916; c=relaxed/simple;
	bh=xDB7sPWd4OnVmNLvMLUsrFbj890UIaBB83RsRg8BA1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=sGujQb2HZTDjSwaHQqWBJZdirWv3AvLGClocEHIABQCjVpObd0dXgKD92uycMt8rbm7OOuZFXB7GxbPyy0N3tXaitLWhsCklk5uHc+aun5zuNlrwTQuvWsSniJSA94uc6mGmwC08UCRAVD6TKX/0mLCGe3EhowvKilxAitoCvuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LHWXxeR5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711590905;
	bh=gQ5jvnXKjeGT+zlOUdI+tO76QxTh7Bb0Dm3E6LrAe0g=;
	h=Date:From:To:Cc:Subject:From;
	b=LHWXxeR5skiYg1Dpq0xI1mjqNEm3sKIm+Av+28ASdFE0bZFt+uuBnIJ/GHK3u+HTA
	 Ml1kpqSkkZP4p92DUGZk0R3pR68Gr6pTRS27zkwvssfqRXoA0ONrpRMT5iCI5HyHSt
	 7RZKLtZ867EzEZzbj1NANz35VjLGP4Xn68B//JxkkfZF+o4xM861vQhvj1BbqMX4NB
	 e1HE6Giu6+CMNRC7/MkGvtuCJRzvdzqFYDz3kAm9MImEFahMkr9hJgKF/ksBJ9Bg2k
	 LcszhxU7111BauleD11T71gyRMdOOU/+2pSHx/Gfi329CTe0UhqXQW03YGsrtH3rV5
	 aWQ2jCEHW0OHA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V4mnh1jTJz4wc3;
	Thu, 28 Mar 2024 12:55:03 +1100 (AEDT)
Date: Thu, 28 Mar 2024 12:55:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Haiyue
 Wang <haiyue.wang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the net tree
Message-ID: <20240328125500.2582492e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ss/gieERHw1WxJDgq1s66Ig";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Ss/gieERHw1WxJDgq1s66Ig
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  kernel/bpf/arena.c

between commit:

  ee498a38f317 ("bpf: Clarify bpf_arena comments.")

from the net tree and commit:

  45a683b2d815 ("bpf,arena: Use helper sizeof_field in struct accessors")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/bpf/arena.c
index 343c3456c8dd,af5cae640669..000000000000
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@@ -37,8 -37,8 +37,8 @@@
   */
 =20
  /* number of bytes addressable by LDX/STX insn with 16-bit 'off' field */
- #define GUARD_SZ (1ull << sizeof(((struct bpf_insn *)0)->off) * 8)
+ #define GUARD_SZ (1ull << sizeof_field(struct bpf_insn, off) * 8)
 -#define KERN_VM_SZ ((1ull << 32) + GUARD_SZ)
 +#define KERN_VM_SZ (SZ_4G + GUARD_SZ)
 =20
  struct bpf_arena {
  	struct bpf_map map;

--Sig_/Ss/gieERHw1WxJDgq1s66Ig
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYEzfQACgkQAVBC80lX
0GwTlAf+ODseBCg0yaiW+cSUeGlEO16EWDh/ubJdBthEL820EVsMhIyYOxXxg6zn
lfqimw2UtpyXTuY5pWbZ1++PDrU7u3ZI84PPCJrlcDEZ1jT2nk0B3Dv1NGuiX4s7
yuzJBAz1Gi11MTBjLnJGo1b0tuuiICL1jzrOmSWV8kaSi0x4QI7u1FpdZnpbeipr
QTEpYKjs7jk8BXOYbOKxlfGzg4UA6YP8Fhz/XUflBfa0fjsOm3vhR+a4L/OvUlmp
4pOYoKMW7GbwsH9KNsfccx6ZLWwV6oW7+3yAcaXYNKVySGQSLYOwkLqyLa7Vdpc8
EOOKPufZo14M9dWb1K7kHCz6kBYzLw==
=M0aJ
-----END PGP SIGNATURE-----

--Sig_/Ss/gieERHw1WxJDgq1s66Ig--

