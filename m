Return-Path: <linux-kernel+bounces-47550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD6F844F41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C829E1F2BFAA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD013A1BD;
	Thu,  1 Feb 2024 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sKMHctqj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7397439FD8;
	Thu,  1 Feb 2024 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756276; cv=none; b=ixVwq4x0k/op2YXLNBUIFhBCcK3NXqmW4ZdSAFqKumIF0O8M7MPwJecNywcI7D5m2vnDfUGI5+8l0HMMDzA58GpKuVhyTkNY/Kqx8BesIUA+xyYmfa9fMRZ4GsHvPHekoj6WKA7kuGg6CVxHPxt+LkvsGSgg+2ZEzr1Pgi29RSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756276; c=relaxed/simple;
	bh=Ckk4dA0lhTu8OCzSPVKAAtWrIpoweRypmk6TLFFp3tY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jB7hySA4mpZzi0W6FA53uC0FHrIczkC9mvHxctmZ4QTAODqachKqG7Kxq+UChPAtYE9vFffTpgYKGcl+w4BR3L8zPldFyYV09l0mTlI8lCOWxAHOlxXgf7vporQWDn0UACPPiIc6YYwdRm82Bqi3ZSLJNf/SerkaazeOdqXWqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=sKMHctqj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706756270;
	bh=IfwlPw1Ok0+Ig6svzdkR7FSpw9GH19cNnmEWdrPvCHs=;
	h=Date:From:To:Cc:Subject:From;
	b=sKMHctqjryXt60zpuDgUbw6yhyOSQIdfJGjfFh5kEm82zv+cAF2jiHDqab+mv46tR
	 41YAN9VWgJB7uX3UAgS5JFpDiHZxuuWHAsA2pJWCydtr53ncOBnYQjM8uadpcfH4OQ
	 wwWGVJHtI+Jp8DTJlj8SIaRv4ZGQIkVr2y9z69SpPA7B2M8MBRtGM2u4zXrYKE+eMx
	 JcMGtqmv/XbUb6yPkgr4Im6YStlPdtBelqnOmigFf/3aNAI/lZBHQdtb/YAv200QJo
	 vuxItKnRH96URiyPG80sOPUNkbNSxDvlTaqpM0O8knI7wpRBvi5u9yYgpAP70SMycV
	 N5PGEx3ZJbqAQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQNqy1QbDz4x5K;
	Thu,  1 Feb 2024 13:57:50 +1100 (AEDT)
Date: Thu, 1 Feb 2024 13:57:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20240201135747.18eca98e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dsqBj0nMlICd8gJX8CY2S6H";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/dsqBj0nMlICd8gJX8CY2S6H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (i386 defconfig)
failed like this:

In file included from arch/x86/include/asm/string.h:3,
                 from include/linux/string.h:61,
                 from arch/x86/include/asm/page_32.h:18,
                 from arch/x86/include/asm/page.h:14,
                 from arch/x86/include/asm/thread_info.h:12,
                 from include/linux/thread_info.h:60,
                 from include/linux/spinlock.h:60,
                 from include/linux/wait.h:9,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from include/linux/debugfs.h:15,
                 from lib/stackdepot.c:17:
In function 'depot_alloc_stack',
    inlined from 'stack_depot_save_flags' at lib/stackdepot.c:688:4:
arch/x86/include/asm/string_32.h:150:25: error: '__builtin_memcpy' specifie=
d bound 4294967295 exceeds maximum object size 2147483647 [-Werror=3Dstring=
op-overflow=3D]
  150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
lib/stackdepot.c:459:9: note: in expansion of macro 'memcpy'
  459 |         memcpy(stack->entries, entries, flex_array_size(stack, entr=
ies, nr_entries));
      |         ^~~~~~
cc1: all warnings being treated as errors

Presumably caused by commit

  d869d3fb362c ("stackdepot: use variable size records for non-evictable en=
tries")

from the mm-unstable branch of the mm tree.

I have reverted that commit and the following one for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/dsqBj0nMlICd8gJX8CY2S6H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW7CKsACgkQAVBC80lX
0GwhBgf/S8pw3lrXhEH1f9k4juzn0PrXKu3Sv62t9OFfYfettQCTmE0AvxK4ZOKR
ebU3u49ici6EJB7Y/yk/VBtMZSAHh21v7HbRpqoF4WWG/LlLecPqTT/8PzGCOhun
9Agx+sY22x/bNyUqyofAFxcf+cMLyzfZVfhWjqN69Jayq7kgsNIK628dFRM9p4PO
mkIcHU6WpnIO2MDPtumM+xjrJf34dDaVfbJutx08BX0q9gkc+KhXKJQgSHoCGB5g
sqCEwZQps2/qPUWxX79dCGLuGaZc7mL7KXHOTf0vWUNiauvzVMVCCqCw0JrojjXK
6MWvegiaJ9UWuvBJkQ0E4MDICJRw6w==
=ww20
-----END PGP SIGNATURE-----

--Sig_/dsqBj0nMlICd8gJX8CY2S6H--

