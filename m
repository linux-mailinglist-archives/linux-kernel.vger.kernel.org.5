Return-Path: <linux-kernel+bounces-144491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979818A4703
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C961F21B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816D51C6B9;
	Mon, 15 Apr 2024 02:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PB/ibbAv"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D561BF37;
	Mon, 15 Apr 2024 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148379; cv=none; b=A0rxAGeB2K2N2zjcWv0CjHEtEWq1fhFUFYRoxiCEGdkCH1CW/w5LDs9ZRQ14t3+NnMnDRu6N7ngz/kRDiU3iL0inA48tdVMCe0HBnFstlIQOOi8vJByxk2/UXxOohlU4y9WbEgGws4RQ5TqwnXawqxRVb/dO+ZJ1YuPEoekPcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148379; c=relaxed/simple;
	bh=mPjr4V35iAleldslzQLkcJPCY9RS6IJeKiBC6PEarE4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QDWJcYParF+jqTnwOUmy3ylyWvzj/+Cbcv0T4ExFfOr1kR5sOJ1ryXAjwQkGOuGylxkpG3L10mnXl/chGm1gfj8p9ZiAcIQylwTykdDqonrJXLtH5EFFWma8DWE2ysg5N/CmxqBpev6sk/OXbevd1Rf5WzMo8+NnDEDLDkSnZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=PB/ibbAv; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713148372;
	bh=H0zlDhdJnuDtI6dEcV1Mj+Y/YJcSXzNO+hJ6qKa8+yU=;
	h=Date:From:To:Cc:Subject:From;
	b=PB/ibbAvQgI7udim9xxr1q/UnShCS5KhL9bv9/ow/j/5bigU2G3wNIFnv5+CYa9lx
	 LIMv7QrMVMOpwXXJBskdZ8vVa7+cv/0xtZbRkC2Jppj40TUuprxBa+v4aFBk1BdfZx
	 YmXPHC95LohMV6Z57bi7TTIKBQRvAV1OofSJJwPKcTyrTh9cjhKq1wrWar5eMOVB7G
	 a7OmrW2d0vuREkC7qLLjV4RW9Z6x1A7OS1icEjkdnk0Om9jdZK8oxxqy27DWKaZHP9
	 NmsjbUqIsAtnOx1wDZZGAbsGXkt/PKjPFXgcg4FnAji9gB3GxBkyLc0NiZ75qsQSam
	 YXE3XNvdMNqsQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VHrmx1g59z4wcr;
	Mon, 15 Apr 2024 12:32:49 +1000 (AEST)
Date: Mon, 15 Apr 2024 12:32:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc: Leonardo Bras <leobras@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, Yujie
 Liu <yujie.liu@intel.com>
Subject: linux-next: manual merge of the rcu tree with the risc-v tree
Message-ID: <20240415123247.0d27eb39@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6_AXiiHatTihk3suI47_m1t";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6_AXiiHatTihk3suI47_m1t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  arch/riscv/include/asm/cmpxchg.h

between commits:

  07a0a41cb77d ("riscv/cmpxchg: Deduplicate cmpxchg() asm and macros")
  54280ca64626 ("riscv/cmpxchg: Implement cmpxchg for variables of size 1 a=
nd 2")

from the risc-v tree and commit:

  b5e49f1af563 ("riscv: Emulate one-byte cmpxchg")

from the rcu tree.

I fixed it up (I just used the former as the latter seems to no longer be
needed - I also undid the change to arch/riscv/Kconfig from the latter)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/6_AXiiHatTihk3suI47_m1t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYckc8ACgkQAVBC80lX
0GxC2gf+JNExjXUcrttlNnOwyZXsicjF4f2W2MBiIqqqOvnUs5Q9cQp+Ufb7+4C8
XTw1+7a93rbdbTk4RLnJRQ+E8xDPAQubfrk0RwoGWeLNqsiTDMuqIHTFqN4Wi1QX
HloJX/0KR4uPPt2nivLOC/JQF41+0NTB6GP3yWP4dcXM2DXjxL7XaHYLhaaQwLzZ
c6C8Hy+GRgt55uYqybQ59w12aTQ6ULYhlg8YuzD1AAVYwMAm4hnpAY5bH1UIKcEO
0qRXkKwWXnzM+wJF2iHHc/aA4SmHEGvm6pGE8S1rHVXsFyOa7ZZsD/ZuDGwJdTXk
v0lZrxeQ7Y/H1MpTabV+bErHoyrRnA==
=V3Jf
-----END PGP SIGNATURE-----

--Sig_/6_AXiiHatTihk3suI47_m1t--

