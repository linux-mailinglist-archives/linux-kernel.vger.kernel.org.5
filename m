Return-Path: <linux-kernel+bounces-163186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC05A8B66ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BACE2837C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2D41870;
	Tue, 30 Apr 2024 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lKy4Ppkk"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F8161;
	Tue, 30 Apr 2024 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437503; cv=none; b=ehu7DTvS2bJiORB3qNFPgm8VUtdZ8s7FQ7sGx4Ff57ZmzkjzZ0xl8rt0qCOULD0WEXpBgVj+ZMVljB2zvFgSQasGJKELRHivjhwA9m+ouFcoLN4oQJchRIdf8FcWc4HHGCfkSzgCQtkqBjj9ZjehrnRsk1lWd4i/zph3Ql/nco4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437503; c=relaxed/simple;
	bh=QH5l3a+G8F0iTFaKvPMFfFJNxI7dvToCr8fL9uRPIxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=C98Yr+NRqaPcHXN5D5Q7aLAbWhURBYXfLOLQCO2B06s85yhshLWfLBTFe3bBocbxruwFkgi9gfQEu3z2Bnq9VbXItTBtTO/iJFhA+h5z+2H3AD+3ONeYBct5W8Rf/z1LRwh0mbb1k5MXR4kl+h3OMs0J0QcG6iwFOnJGxBi79so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lKy4Ppkk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714437495;
	bh=opOU+n89OsebG4FImot0wZHhPzHpLeEYGXOWhp0JX0s=;
	h=Date:From:To:Cc:Subject:From;
	b=lKy4Ppkkdix2L2uHd4SU0DMrKYeXluURZUu4hBx2Sw29vFklzOQpgqMdgfMlD2wh+
	 yVGtuew6bt7AAA5PnG2F+kH733tkq0KlwZv0sUunNtoNEAAwoN+cmYuDkePOlZeUUB
	 tIneh3ZbJIrDZ9jqpOE+UmbIxS3U7eWAeqFHuIFCKAQvYPVMq5A9odL+b1Tg8NrF/R
	 u+KdGZxvGopvbIwnNeZC9POzXa019e/9DubPYgR5DCWozDGTa1Bl9dNHmM6z/uns0T
	 z2tGO8VaLJg+eIbA1KrEz5WVIrPXjrOMbtbwDKuNcGM/Du+5u1WfVZpvlJuZpgA9Fx
	 FjzAI+WGNrOBw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VT1Wq33CLz4x0H;
	Tue, 30 Apr 2024 10:38:14 +1000 (AEST)
Date: Tue, 30 Apr 2024 10:38:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Lance Yang
 <ioworker0@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240430103811.6e313ce0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IyzjQ6x5taW=XsEuuXbE3.i";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/IyzjQ6x5taW=XsEuuXbE3.i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from <command-line>:
mm/rmap.c: In function 'try_to_unmap_one':
include/linux/compiler_types.h:460:45: error: call to '__compiletime_assert=
_344' declared with attribute error: BUILD_BUG failed
  460 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |                                             ^
include/linux/compiler_types.h:441:25: note: in definition of macro '__comp=
iletime_assert'
  441 |                         prefix ## suffix();                        =
     \
      |                         ^~~~~~
include/linux/compiler_types.h:460:9: note: in expansion of macro '_compile=
time_assert'
  460 |         _compiletime_assert(condition, msg, __compiletime_assert_, =
__COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_a=
ssert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_=
MSG'
   59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
      |                     ^~~~~~~~~~~~~~~~
include/linux/huge_mm.h:99:28: note: in expansion of macro 'BUILD_BUG'
   99 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
      |                            ^~~~~~~~~
include/linux/huge_mm.h:106:35: note: in expansion of macro 'HPAGE_PMD_SHIF=
T'
  106 | #define HPAGE_PMD_SIZE  ((1UL) << HPAGE_PMD_SHIFT)
      |                                   ^~~~~~~~~~~~~~~
include/linux/huge_mm.h:105:28: note: in expansion of macro 'HPAGE_PMD_SIZE'
  105 | #define HPAGE_PMD_MASK  (~(HPAGE_PMD_SIZE - 1))
      |                            ^~~~~~~~~~~~~~
mm/rmap.c:1651:41: note: in expansion of macro 'HPAGE_PMD_MASK'
 1651 |                 range.start =3D address & HPAGE_PMD_MASK;
      |                                         ^~~~~~~~~~~~~~

Caused by commit

  34d66beb14bd ("mm/rmap: integrate PMD-mapped folio splitting into pagewal=
k loop")

from the mm-unstable branch of the mm tree.

I have reverted that commit and the following one for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/IyzjQ6x5taW=XsEuuXbE3.i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYwPXMACgkQAVBC80lX
0GwpLwf9H1dOexj3AVtXVl3gosKxBz4JVWU9ozN4Xu3hKHIqJdg3PF8n/wh2pXht
JbnI8o9c2PqWhUIMSvjdhuyk+Sg2WNXRj+0hhnBSlweenfXzuvNWFZfyd0lFsfd6
Z3UC0ZyBAGzVoAZocsTxw+aOVQg9xY/ec8YbKGyq3DsPObO48ehcnA8fvyHv+V+1
nt+r/YlUdy+GSSzvqwh2BpBS1qlkB6SSyZjJkcf03Y9d48AtqWA32IGOOH7uO2Ab
03aEa95BALFeUF7V+TRTFi1fMXWUBRYGcxN5mzPanXo2GvyNrX83CDpdbIr6S/ww
IICaWcm5v7TS2waJ9S3Wicu8GS1gHw==
=qS9x
-----END PGP SIGNATURE-----

--Sig_/IyzjQ6x5taW=XsEuuXbE3.i--

