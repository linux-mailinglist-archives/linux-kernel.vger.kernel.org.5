Return-Path: <linux-kernel+bounces-141799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C3F8A238F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F86E1C21B02
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E52D527;
	Fri, 12 Apr 2024 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="EJQwDDOn"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48738801;
	Fri, 12 Apr 2024 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887471; cv=none; b=XnTBb6MxBX295Tt2zFw5f6AX25AKQ+l+7sOgf+ICCOfNtaPWOpFidw9oKf/tF2RL848DijuTuif+aW519EQk3QTSZEiLrdXHW7h8g1mME1N7ve9DXbPE2jSsseTUVe8EgC9CUJjI1AZ/kdL5vh3CLnv065Nl1mTVDL5itJRpdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887471; c=relaxed/simple;
	bh=t9q+otk2Tc6NmYmjxqB1BgWWDc81IAO4Z0aG6aI6KQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kiMh4erJ2TPJ6S3pyKVf93Mb/k2Qgtkxlc/UWY4bthfhBbyOMswUHiJfgZ4fsnf7LfI83bxm5DgvgaY7wYHMUfyRRAdaaZKocdbiohgXLZ69ovFudSMGGW+XxX8yWLQ3ehGzFFCCyzWH9VSMujkapMek/iBaw5iatOmZ02nBTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=EJQwDDOn; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712887465;
	bh=DcuE7f9X1W1goW9Rw0CyhmG355kPpq2Gqbq8MdMXHsQ=;
	h=Date:From:To:Cc:Subject:From;
	b=EJQwDDOnAZZkWlKU+6Arj+Knp7t9fK9UCymNq/MT2dvBfs2T8aon9qUFF1+SBewY1
	 TrDJiV8LpBztvSgxVzEokRjGOW8QuMIw7Ph3Lb7SbB1nJ5OZP8tjKxla8ln1OMcNE6
	 BR+OK/x8cr4hKkc2O7VI1OEy2tOEaWmLAMF5r4U2GjOPuXKpFaOozisQxbNtPyz+oT
	 pa8GkCo23I3GouQ4mJm568eeVZwVNz/KtGg05Y7WT2W7wGSyPky2XJ6UGcsVZLcb07
	 B24R2neuwvmdmkRQgmzfRolDX3b698y0fweU3ySaPNFy+ER5Dv6IWSAhr7M4Cq1hcy
	 qb6TNYe3/PK4g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VG0HX6P8hz4wb2;
	Fri, 12 Apr 2024 12:04:24 +1000 (AEST)
Date: Fri, 12 Apr 2024 12:04:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Luis Chamberlain <mcgrof@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the modules tree with the mm tree
Message-ID: <20240412120421.27d86c34@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nVmWy2XDg2rYoS268/+W7Xr";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/nVmWy2XDg2rYoS268/+W7Xr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the modules tree got a conflict in:

  kernel/module/main.c

between commit:

  58782d7a7ccd ("lib: prevent module unloading if memory is not freed")

from the mm-unstable branch of the mm tree and commit:

  a4ee8c9b86bd ("module: make module_memory_{alloc,free} more self-containe=
d")

from the modules tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/module/main.c
index 2d25eebc549d,d56b7df0cbb6..000000000000
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@@ -56,8 -56,8 +56,9 @@@
  #include <linux/dynamic_debug.h>
  #include <linux/audit.h>
  #include <linux/cfi.h>
 +#include <linux/codetag.h>
  #include <linux/debugfs.h>
+ #include <linux/execmem.h>
  #include <uapi/linux/module.h>
  #include "internal.h"
 =20
@@@ -1204,26 -1194,51 +1195,55 @@@ static bool mod_mem_use_vmalloc(enum mo
  		mod_mem_type_is_core_data(type);
  }
 =20
- static void *module_memory_alloc(unsigned int size, enum mod_mem_type typ=
e)
+ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
  {
+ 	unsigned int size =3D PAGE_ALIGN(mod->mem[type].size);
+ 	void *ptr;
+=20
+ 	mod->mem[type].size =3D size;
+=20
  	if (mod_mem_use_vmalloc(type))
- 		return vzalloc(size);
- 	return module_alloc(size);
+ 		ptr =3D vmalloc(size);
+ 	else
+ 		ptr =3D execmem_alloc(EXECMEM_MODULE_TEXT, size);
+=20
+ 	if (!ptr)
+ 		return -ENOMEM;
+=20
+ 	/*
+ 	 * The pointer to these blocks of memory are stored on the module
+ 	 * structure and we keep that around so long as the module is
+ 	 * around. We only free that memory when we unload the module.
+ 	 * Just mark them as not being a leak then. The .init* ELF
+ 	 * sections *do* get freed after boot so we *could* treat them
+ 	 * slightly differently with kmemleak_ignore() and only grey
+ 	 * them out as they work as typical memory allocations which
+ 	 * *do* eventually get freed, but let's just keep things simple
+ 	 * and avoid *any* false positives.
+ 	 */
+ 	kmemleak_not_leak(ptr);
+=20
+ 	memset(ptr, 0, size);
+ 	mod->mem[type].base =3D ptr;
+=20
+ 	return 0;
  }
 =20
- static void module_memory_free(void *ptr, enum mod_mem_type type,
 -static void module_memory_free(struct module *mod, enum mod_mem_type type)
++static void module_memory_free(struct module *mod, enum mod_mem_type type,
 +			       bool unload_codetags)
  {
+ 	void *ptr =3D mod->mem[type].base;
+=20
 +	if (!unload_codetags && mod_mem_type_is_core_data(type))
 +		return;
 +
  	if (mod_mem_use_vmalloc(type))
  		vfree(ptr);
  	else
- 		module_memfree(ptr);
+ 		execmem_free(ptr);
  }
 =20
 -static void free_mod_mem(struct module *mod)
 +static void free_mod_mem(struct module *mod, bool unload_codetags)
  {
  	for_each_mod_mem_type(type) {
  		struct module_memory *mod_mem =3D &mod->mem[type];
@@@ -1234,13 -1249,12 +1254,13 @@@
  		/* Free lock-classes; relies on the preceding sync_rcu(). */
  		lockdep_free_key_range(mod_mem->base, mod_mem->size);
  		if (mod_mem->size)
- 			module_memory_free(mod_mem->base, type,
 -			module_memory_free(mod, type);
++			module_memory_free(mod, type,
 +					   unload_codetags);
  	}
 =20
  	/* MOD_DATA hosts mod, so free it at last */
  	lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
- 	module_memory_free(mod->mem[MOD_DATA].base, MOD_DATA, unload_codetags);
 -	module_memory_free(mod, MOD_DATA);
++	module_memory_free(mod, MOD_DATA, unload_codetags);
  }
 =20
  /* Free a module, remove from lists, etc. */
@@@ -2309,7 -2301,7 +2314,7 @@@ static int move_module(struct module *m
  	return 0;
  out_enomem:
  	for (t--; t >=3D 0; t--)
- 		module_memory_free(mod->mem[t].base, t, true);
 -		module_memory_free(mod, t);
++		module_memory_free(mod, t, true);
  	return ret;
  }
 =20

--Sig_/nVmWy2XDg2rYoS268/+W7Xr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYlqUACgkQAVBC80lX
0GxJqgf/YhyeAFTIWqGU0sA/nEexDdRUO7eO2SyZMYL2wq97P1eW1PoDfWq2OM+0
ESyjDL71qFdZNEyL49W2w5WQKfCBdxVaTUZo9x9Z+sSsF0frki7MUTyc5ggQP5yU
8Ya8Ww9ERg4jsQPqSYQliKRkwdR+ppjRAKKImxUp6/UVNd3qWLfmNspC+f3K+kmc
xZHs8aEgV3TjWLicYG5hSH0dka3zBDyq8HUVO4SqKm5Pa5TTZHBSEMg+4CX4pyN0
7HtV5kO/14Rq1vK5DcmrQAXM/zrICesPF8TbF+mU8//nWxW96cSGR+uHaon4ictP
HuZiOSvduv8/LO84DTrtuwlJ0G/L0g==
=JSMi
-----END PGP SIGNATURE-----

--Sig_/nVmWy2XDg2rYoS268/+W7Xr--

