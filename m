Return-Path: <linux-kernel+bounces-116373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB0A889922
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC6A1F32897
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7E4C63A;
	Mon, 25 Mar 2024 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xeew8ES6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F612DD83;
	Mon, 25 Mar 2024 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711330569; cv=none; b=qk3N8t/rEf9YAtPFV4rQXLEBgGnqblCVqIPZq7MRVzClnL/az6o/ThH06LDQCxbpWW9vapMyejw6SzCunWzQfH41Y/85YNlWW+mKJvAIhpaWS32ZwtU3oTk39wrvFT9MR9wt7m3Llk3Bwg5AZuEEVEW3kaTaeUVQIPy5ncmwmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711330569; c=relaxed/simple;
	bh=OS4+mR9MBUgdVBdHxvfGh2fZ2Z6lVEs+PKwWJnaxN2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RJ8Pc68o6DjgD0ttr9+iRl7DDbwMweQGrhA9QZaz1YosiJJUe5An6eBbfeEeVIkBgShv/6+ataPAbCCu2QeFXGS5AJwsHe9V+hbos26M8W6YV4FTvVZzoMc7KRLeoZO93cH3CzjN+wybHUgTL/cQNiqo8fmhIVzDZzryVN4C5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Xeew8ES6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711330564;
	bh=aYWWUE/YcntQdPo68ayaa1Od+PPqM7hwIBB7pGsroCE=;
	h=Date:From:To:Cc:Subject:From;
	b=Xeew8ES6WKvi47Kjnd+h4WA4/xym1OiTaU0JugmfTwpvnFMu14pS6npycGoVA5MwJ
	 JYKhVW1bAspbFqoNCwDsH/dNbmYQMmDDR9+xlIbwUciguBKAxso2ylUpniJqG9xG7I
	 JipU3mVsXUJ7Foem6kpvV6/FFQUWuu8vD1zlWz3XDqxfVZsb7QvTxlT6DrSVLGbypr
	 +7adOa6OoUY3Hax0fR+iocztCoOmMG0ueyLaG2qU1Hd/08mfvIVOBd3XbrqNkn2Vuf
	 uf5YEIZxHrrByC2BsesakT/DzlYs/xQgIVv0oeGogB+pE4L0d14xlkcJVuhZmVI6fM
	 NraCmmtxN0wmg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V2wW80Zf2z4wcd;
	Mon, 25 Mar 2024 12:36:03 +1100 (AEDT)
Date: Mon, 25 Mar 2024 12:36:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Suren Baghdasaryan
 <surenb@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the mm tree
Message-ID: <20240325123603.1bdd6588@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CkkzL_1wpP/itmWLzgt7CyT";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CkkzL_1wpP/itmWLzgt7CyT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
these warnings:

include/linux/slab.h:545: warning: expecting prototype for kmem_cache_alloc=
(). Prototype was for kmem_cache_alloc_noprof() instead
include/linux/slab.h:652: warning: expecting prototype for kmalloc(). Proto=
type was for kmalloc_noprof() instead
include/linux/slab.h:692: warning: expecting prototype for kmalloc_array().=
 Prototype was for kmalloc_array_noprof() instead
include/linux/slab.h:714: warning: expecting prototype for krealloc_array()=
 Prototype was for krealloc_array_noprof() instead
include/linux/slab.h:730: warning: Function parameter or struct member '_n'=
 not described in 'kcalloc'
include/linux/slab.h:730: warning: Function parameter or struct member '_si=
ze' not described in 'kcalloc'
include/linux/slab.h:730: warning: Function parameter or struct member '_fl=
ags' not described in 'kcalloc'
include/linux/slab.h:730: warning: Excess function parameter 'n' descriptio=
n in 'kcalloc'
include/linux/slab.h:730: warning: Excess function parameter 'size' descrip=
tion in 'kcalloc'
include/linux/slab.h:730: warning: Excess function parameter 'flags' descri=
ption in 'kcalloc'
include/linux/slab.h:774: warning: expecting prototype for kzalloc(). Proto=
type was for kzalloc_noprof() instead
mm/slab_common.c:1217: warning: expecting prototype for krealloc(). Prototy=
pe was for krealloc_noprof() instead
mm/util.c:751: warning: expecting prototype for __vcalloc(). Prototype was =
for __vcalloc_noprof() instead
mm/vmalloc.c:3897: warning: expecting prototype for vmalloc(). Prototype wa=
s for vmalloc_noprof() instead
mm/vmalloc.c:3916: warning: expecting prototype for vmalloc_huge(). Prototy=
pe was for vmalloc_huge_noprof() instead
mm/vmalloc.c:3953: warning: expecting prototype for vmalloc_user(). Prototy=
pe was for vmalloc_user_noprof() instead
mm/mempool.c:245: warning: expecting prototype for mempool_init(). Prototyp=
e was for mempool_init_noprof() instead
mm/mempool.c:271: warning: Function parameter or struct member 'gfp_mask' n=
ot described in 'mempool_create_node_noprof'
mm/mempool.c:271: warning: Function parameter or struct member 'node_id' no=
t described in 'mempool_create_node_noprof'
mm/mempool.c:271: warning: expecting prototype for mempool_create_node(). P=
rototype was for mempool_create_node_noprof() instead

Introduced by commits

  c64e38ed88d1 ("mm/slab: enable slab allocation tagging for kmalloc and fr=
iends")
  ea7b8933f21b ("mempool: hook up to memory allocation profiling")
  576477564ede ("mm: vmalloc: enable memory allocation profiling")

from the mm-unstable branch of the mm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/CkkzL_1wpP/itmWLzgt7CyT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYA1QMACgkQAVBC80lX
0Gz2Mwf+LcOXyavbrekarP0OPRI+VR3y3nS7s+4FL9H5yryP+StHR1dwrAGaFsib
iYCBtSvXDsTry5pafpLH8ZDXJ7bHZIj9E75KsxbOo0Tj7bYocqRm8+LDSyvbnnwu
9lHkwXq2UBoBMAunkkDwTPe6eCai6eo2vK5XUkxGHwxTiqqfbSf4f/7LZo1O3LO2
LHwO9/OZ+LGWmx/acrA5eZ77UG4AhUepzqyVusq11SefzW8AfOn2IXJqOLLkU3r/
M0PX3CyWBtjKao7wmn3iAQZLbywBzFk8OZLFNwW6sAQFrteGRoBs+ro7W3iwX5nG
ZgE2MvcAVpSX/3Y/aoJoU2ifZVS54A==
=oI8R
-----END PGP SIGNATURE-----

--Sig_/CkkzL_1wpP/itmWLzgt7CyT--

