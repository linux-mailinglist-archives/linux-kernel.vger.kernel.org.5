Return-Path: <linux-kernel+bounces-3022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C777A816638
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A805B2114A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF77483;
	Mon, 18 Dec 2023 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TDD714Fv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131477460;
	Mon, 18 Dec 2023 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1702879548;
	bh=W7xWmD1tcGQMNSwevlCe/BjI7YoyVi+BvIN4gvkDBhY=;
	h=Date:From:To:Cc:Subject:From;
	b=TDD714FvOiCOwW2iJgvxwaHaGLLgDQcQ6Fiwdci0ojp80LZfhvTwObOd2XesL/b+E
	 cPnFNvkxatWDNhOEOZlG6QXA9z+fIl0X13ebSlXchVodYPaNRXAia9VfHN7ghtsjQj
	 m76IYG+HsLPChHyiJ52eYOu6NdynawfASYK8wpuz0z3uQH7Oh4ixvytrFJ9GvHzYOO
	 Ub+0zWHFGJBNjmbuUOtYPPI3bJrPUjmScjU3FxlULMMzr/dRYt8UGQY5Ki4t+cuQgB
	 MtNkrkmq3KGsjN0LKXy6783+DR2EeNrYp7sHjt0qi6TNsulTeF6bzisgmC19K52Jcm
	 72i6cCPvdEa/g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Stq7c2hRQz4xSY;
	Mon, 18 Dec 2023 17:05:48 +1100 (AEDT)
Date: Mon, 18 Dec 2023 17:05:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Subject: linux-next: manual merge of the header_cleanup tree with the tip
 tree
Message-ID: <20231218170547.5714468f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4URytsaGC3wZacBtwRn3Fe1";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4URytsaGC3wZacBtwRn3Fe1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the header_cleanup tree got a conflict in:

  arch/x86/include/asm/percpu.h

between commit:

  0e3703630bd3 ("x86/percpu: Fix "const_pcpu_hot" version generation failur=
e")

from the tip tree and commit:

  863cc83ddcf8 ("Kill unnecessary kernel.h include")

from the header_cleanup tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/include/asm/percpu.h
index e56a37886143,5e01883eb51e..000000000000
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@@ -28,52 -24,13 +28,52 @@@
 =20
  #else /* ...!ASSEMBLY */
 =20
 +#include <linux/build_bug.h>
- #include <linux/kernel.h>
  #include <linux/stringify.h>
+ #include <asm/asm.h>
 =20
  #ifdef CONFIG_SMP
 +
 +#ifdef CONFIG_CC_HAS_NAMED_AS
 +
 +#ifdef __CHECKER__
 +#define __seg_gs		__attribute__((address_space(__seg_gs)))
 +#define __seg_fs		__attribute__((address_space(__seg_fs)))
 +#endif
 +
 +#ifdef CONFIG_X86_64
 +#define __percpu_seg_override	__seg_gs
 +#else
 +#define __percpu_seg_override	__seg_fs
 +#endif
 +
 +#define __percpu_prefix		""
 +
 +#else /* CONFIG_CC_HAS_NAMED_AS */
 +
 +#define __percpu_seg_override
  #define __percpu_prefix		"%%"__stringify(__percpu_seg)":"
 +
 +#endif /* CONFIG_CC_HAS_NAMED_AS */
 +
 +#define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
  #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 =20
 +#ifdef CONFIG_USE_X86_SEG_SUPPORT
 +/*
 + * Efficient implementation for cases in which the compiler supports
 + * named address spaces.  Allows the compiler to perform additional
 + * optimizations that can save more instructions.
 + */
 +#define arch_raw_cpu_ptr(ptr)					\
 +({								\
 +	unsigned long tcp_ptr__;				\
 +	tcp_ptr__ =3D __raw_cpu_read(, this_cpu_off);		\
 +								\
 +	tcp_ptr__ +=3D (unsigned long)(ptr);			\
 +	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 +})
 +#else /* CONFIG_USE_X86_SEG_SUPPORT */
  /*
   * Compared to the generic __my_cpu_offset version, the following
   * saves one instruction and avoids clobbering a temp register.

--Sig_/4URytsaGC3wZacBtwRn3Fe1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV/4TsACgkQAVBC80lX
0Gy6PQf+NZNjrD/XRrQft/EZePrWlfJCqBucqEtghgraAPkGudgosJ7zQIBTwLPg
VFnC4bFH7jFtEDPVxP0xpyGX+raafl04YVTcjdMeFH+FCxkLJe9633ZR5PdScSKT
5kPBhzV09smXJEZxQ6Pao1IC1xG4xwLBsOhkun4aKhkcQO974qQAF6alJ7ecjcUd
4393IZ4E9JM4OFTQknCUaMvx24FFxlh/yLEBYWyi6gc/EKMkPKbC0xszr2vFyCf5
8Je5GONwOOjYPW1BSYpmDvz0E66/tAm8IgxR98xtoPUSdB1p8Aj3NX0RUp8oZxbH
7jvSbn7z5uLLfgW1zYkEfFG22ZmIeg==
=86t3
-----END PGP SIGNATURE-----

--Sig_/4URytsaGC3wZacBtwRn3Fe1--

