Return-Path: <linux-kernel+bounces-156149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0372B8AFE8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CF71F23A24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A6F83A1E;
	Wed, 24 Apr 2024 02:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sRzESmNj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035129429;
	Wed, 24 Apr 2024 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926382; cv=none; b=gzGtBFhN0XKQqsxGb3JTr6TM0+Gq3mfeJZDqzPybi/k+aZjqOnyC7ZZ8tooFYUGLDLxeIcX5VSxJeTfj9lLqj7iIHU0Rzcu1txTY8JO4ESVlHJ0wxlvFASKouTuIiBDdxvomUTQ/PbXqhIM8PhbkRYk9K3UpH9WFVaPTbWpo0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926382; c=relaxed/simple;
	bh=k8qM7PrstiV2cDHpRQdgPyhbFe54D6SstrbFmJDIueg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HQa4AGuz8tepzu8O2Nkufj+l5iTwVRmIgiRYMGIqM7zJblWyqNmpW4o2Arnumjv9I5J2uTOP9I36x1c3Idsedg0o6YGm1Q8kFSnziEAaj0Tns4Y9NgVJC4H2f6Qj7rwNbTUuhnHbqWbfv/2wcgBW+PfdlDBr4LXUwU085+qsig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sRzESmNj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713926376;
	bh=X2TWpyW4Mn0iwnz/Jh16i53Y5d41hVw+Ty9heea+EG8=;
	h=Date:From:To:Cc:Subject:From;
	b=sRzESmNjkJQLN8QqAlMOuJkXeMNbOmdgKBBecVAeTVtNTL/TX06I/50TO/7k3+Txi
	 IOPJJQRXPzZtACvohj5kgyu4sIiJNUftOFmXvhwDL3h7EoXIBpHlkSQSNbFxUbgfUy
	 OgbBtSKsN3NJF23L5cdM6OUhGYgP6jawV1j/jBp4vJJms4FVPt5og5qvzGSehhVscs
	 jmpSYMRUR0WWAJ968m933XbaHPBe+6IIkDIU2xR5eNO7QcbSaS1vw8KK6NylJ+tI0l
	 yoPeCYAInZuqvYxGfCFYlzMLIAdoFn7Fx86IhmxeQRwQtZ68eDqoYffwTFpEWXvEYj
	 BlpR+XnP6PZuA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPNVc2Kwbz4x0H;
	Wed, 24 Apr 2024 12:39:36 +1000 (AEST)
Date: Wed, 24 Apr 2024 12:39:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Luis Chamberlain <mcgrof@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the modules tree with the mm tree
Message-ID: <20240424123935.2f65e886@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZUj3HUQoFMUtZppn.Smxngk";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ZUj3HUQoFMUtZppn.Smxngk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the modules tree got a conflict in:

  kernel/module/main.c

between commits:

  7f014cdda4cb ("lib: code tagging module support")
  5ab9b0c7ea5c ("lib: prevent module unloading if memory is not freed")

from the mm-unstable branch of the mm tree and commits:

  0746f9982603 ("module: make module_memory_{alloc,free} more self-containe=
d")
  18da532eefc8 ("mm/execmem, arch: convert remaining overrides of module_al=
loc to execmem")

from the modules tree.

I fixed it up (I think, see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/module/main.c
index 2d25eebc549d,91e185607d4b..000000000000
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
@@@ -1198,32 -1188,50 +1189,54 @@@ void __weak module_arch_freeing_init(st
  {
  }
 =20
- static bool mod_mem_use_vmalloc(enum mod_mem_type type)
+ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
  {
- 	return IS_ENABLED(CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC) &&
- 		mod_mem_type_is_core_data(type);
+ 	unsigned int size =3D PAGE_ALIGN(mod->mem[type].size);
+ 	enum execmem_type execmem_type;
+ 	void *ptr;
+=20
+ 	mod->mem[type].size =3D size;
+=20
+ 	if (mod_mem_type_is_data(type))
+ 		execmem_type =3D EXECMEM_MODULE_DATA;
+ 	else
+ 		execmem_type =3D EXECMEM_MODULE_TEXT;
+=20
+ 	ptr =3D execmem_alloc(execmem_type, size);
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
- static void *module_memory_alloc(unsigned int size, enum mod_mem_type typ=
e)
- {
- 	if (mod_mem_use_vmalloc(type))
- 		return vzalloc(size);
- 	return module_alloc(size);
- }
-=20
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
- 	if (mod_mem_use_vmalloc(type))
- 		vfree(ptr);
- 	else
- 		module_memfree(ptr);
+ 	execmem_free(ptr);
  }
 =20
 -static void free_mod_mem(struct module *mod)
 +static void free_mod_mem(struct module *mod, bool unload_codetags)
  {
  	for_each_mod_mem_type(type) {
  		struct module_memory *mod_mem =3D &mod->mem[type];
@@@ -1234,13 -1242,12 +1247,12 @@@
  		/* Free lock-classes; relies on the preceding sync_rcu(). */
  		lockdep_free_key_range(mod_mem->base, mod_mem->size);
  		if (mod_mem->size)
- 			module_memory_free(mod_mem->base, type,
- 					   unload_codetags);
 -			module_memory_free(mod, type);
++			module_memory_free(mod, type, unload_codetags);
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
@@@ -2309,7 -2287,7 +2299,7 @@@ static int move_module(struct module *m
  	return 0;
  out_enomem:
  	for (t--; t >=3D 0; t--)
- 		module_memory_free(mod->mem[t].base, t, true);
 -		module_memory_free(mod, t);
++		module_memory_free(mod, t, true);
  	return ret;
  }
 =20

--Sig_/ZUj3HUQoFMUtZppn.Smxngk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYocOcACgkQAVBC80lX
0GzEdAf/Yu8cPj7sFV2ReEuSmmPLd5YEDalgcVjcda6n0La49VrMDBSHBezdn+lT
WnLX1mN0t317o13Bo9x8oaNpNSDDheMbS16OUwxJYsvj9/EEHKi9wC27tZHAXJ3r
zkxpZa7iT3PS2s6RwDsVDt/We1kH3QkGM/IVMeDhdCnBkMESL0c0kPUA9UYbZC6r
9+PZLCVvmEaKTuDeCrckXJKzN22QRaqYFayp0Y/UN5Pjfj68g6lWQnKG4dhcCm1W
exMacNKM9zgTS1dmt5K3c6Ndu+BVNRw+nIFxEBvbmGwOorLVfUgEVzgFAVTmZFx6
dUHTBULSetzDFTs0fngPpyYEWg32GA==
=BtYa
-----END PGP SIGNATURE-----

--Sig_/ZUj3HUQoFMUtZppn.Smxngk--

