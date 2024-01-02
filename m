Return-Path: <linux-kernel+bounces-13960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C1A8215F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 01:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA351F21837
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 00:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8462F;
	Tue,  2 Jan 2024 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Xdu6/ywH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223536A;
	Tue,  2 Jan 2024 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704154344;
	bh=CGoOSBU9Zg85UEaqs4Xq9ni/d+fKWQ0Dfzy0mR1B5O0=;
	h=Date:From:To:Cc:Subject:From;
	b=Xdu6/ywHc2HWcIRAovou8qaRZoloHTR/ThENMGdTcycB/PmKQaoZ/EerQo04JDDpt
	 japbm8EwBqFOC6ZsaZarYVsAxZexFrxVw1pxX52+gtv6fgYhGDVV63HPmoQS+4L6qx
	 kjUjLClwp9PR88JLkMtobuE94ucEhN0peQiBK1pQQzFXpMGJFN8/8P2I8+rlgeoC8J
	 RzwSS7g2iYhryoHpF9u78yrahCa1hLc04dFcyicAr7we7RG8jecum5z/2FLgZ61zOv
	 SjjAyLKWJ+hBuFiZYfHPhVnfAXwePB6zz+3lK0MY427MK5G3gD3fbTdr9LFf1tdQHz
	 2i7I1jle4+AtA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T3tZv3vnLz4wnx;
	Tue,  2 Jan 2024 11:12:23 +1100 (AEDT)
Date: Tue, 2 Jan 2024 11:12:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>
Cc: DRI <dri-devel@lists.freedesktop.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20240102111222.2db11208@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j2tnJW4BIy5hve+16tpwOc3";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/j2tnJW4BIy5hve+16tpwOc3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

In file included from include/drm/drm_mm.h:51,
                 from drivers/gpu/drm/xe/xe_bo_types.h:11,
                 from drivers/gpu/drm/xe/xe_bo.h:11,
                 from drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_o=
bject.h:11,
                 from drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h:15,
                 from drivers/gpu/drm/i915/display/intel_display_power.c:8:
drivers/gpu/drm/i915/display/intel_display_power.c: In function 'print_asyn=
c_put_domains_state':
drivers/gpu/drm/i915/display/intel_display_power.c:408:29: warning: format =
'%lu' expects argument of type 'long unsigned int', but argument 5 has type=
 'int' [-Wformat=3D]
  408 |         drm_dbg(&i915->drm, "async_put_wakeref %lu\n",
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
  409 |                 power_domains->async_put_wakeref);
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                              |
      |                              int
include/drm/drm_print.h:410:39: note: in definition of macro 'drm_dev_dbg'
  410 |         __drm_dev_dbg(NULL, dev, cat, fmt, ##__VA_ARGS__)
      |                                       ^~~
include/drm/drm_print.h:510:33: note: in expansion of macro 'drm_dbg_driver'
  510 | #define drm_dbg(drm, fmt, ...)  drm_dbg_driver(drm, fmt, ##__VA_ARG=
S__)
      |                                 ^~~~~~~~~~~~~~
drivers/gpu/drm/i915/display/intel_display_power.c:408:9: note: in expansio=
n of macro 'drm_dbg'
  408 |         drm_dbg(&i915->drm, "async_put_wakeref %lu\n",
      |         ^~~~~~~
drivers/gpu/drm/i915/display/intel_display_power.c:408:50: note: format str=
ing is defined here
  408 |         drm_dbg(&i915->drm, "async_put_wakeref %lu\n",
      |                                                ~~^
      |                                                  |
      |                                                  long unsigned int
      |                                                %u

Introduced by commit

  b49e894c3fd8 ("drm/i915: Replace custom intel runtime_pm tracker with ref=
_tracker library")

This would be an error except that I am building with CONFIG_WERROR=3Dn
--=20
Cheers,
Stephen Rothwell

--Sig_/j2tnJW4BIy5hve+16tpwOc3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWTVOYACgkQAVBC80lX
0Gz1dggAnbFmzzQkKRLKRVvSRO5q5JS+Gyiq+i5IVpHdwr/NYmYZ+cTE/2uASzNw
07s2PBBhBBVN25MSjZLuOcig/9RDeeS1IsnfwP2zKjEwhO7msCKfLhExIk3Jp8G7
Mpp9+Q7eZqst/23Gte5miB9v7lieEdQv9e94CtnzlJz7ZzB5dQYltPxivfYZL2uG
J6T2rm4UvSd9KHcI4s00dtzEAz2wggY40BPE4cPYAso+Z2PtrXBxHJSOOBNbV7eQ
NYxkr6Qes6hZovdjgRBIFxWqcT94CY1oZJr5pSH1QiZVo4/3dQ0/6EeLt7Geqo7w
i34MwlWtYz5PqsugP74zoOSn5putQA==
=HW3o
-----END PGP SIGNATURE-----

--Sig_/j2tnJW4BIy5hve+16tpwOc3--

