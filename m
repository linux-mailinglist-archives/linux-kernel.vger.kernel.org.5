Return-Path: <linux-kernel+bounces-122404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7641288F67C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C20D297961
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA1039FE9;
	Thu, 28 Mar 2024 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YUKGjwOi"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E572B9A6;
	Thu, 28 Mar 2024 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600794; cv=none; b=ntWVlhm/4OnrJkx22hbsBqyYJvKk0+HTrPvQeyel7oGyLBBn86X3BRqPvw4JHxtV5cnu0Sb+MOfoSF4mqlGYbw+lr5rJoBSt+lgBHdk4+jeEuSeRmJPfbLovzLgg5IK49RGiWKUNFOajDcR7Elo2YKstnV85z+8Wm+NkNVRXQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600794; c=relaxed/simple;
	bh=d9lVMBqip8Vlse1tnqzWa5D/+rQuj4kjXCm2F4hQayo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtHjyY0shR+02q7lvVlUWMdlsQlKZUzdnTf+Kw98fZA/wU9eFU+9HHy/UKMNH/0wvJ7vSHa2/ri0X+rWwehdz+Mgwc+EpRM0N3ewqDSH4t/UqPoScOE6M0yFZ766fI95we662FZU9PlVFPRW7dYpzcMB3Y+z+QWipCLSLzngISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=YUKGjwOi; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711600789;
	bh=d9lVMBqip8Vlse1tnqzWa5D/+rQuj4kjXCm2F4hQayo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YUKGjwOirTEYIK4hsG7Xye20iU/dXC+apRyDbdniRLLZXRSYHAC226cSIpDQ9i+a6
	 nOiTUQhHNwbt05MuzlRO+53kX1PmJEzpNltHijzX1rFZXJxbsMk1m1c0nFc3VDLeyC
	 yy/UD3TllFE3e4hVdeg7uSE/fk7US9x2fX3J09WrQ/eaiRPIpcpn5YJW0smadqAZ3J
	 6MeyqAm92hvGfs0l6HlWekefZanfj4KKJ2Wcbdti0Otq58N1dpsB1SjoqjtGdaCtBU
	 E3/E+7EkQ62/M2k+Q7faZFSiin6MT/uvrNJpC3GHEKPH1uQQk27d2RsiTzawAxatK9
	 2JzOVSVChZG/Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V4rRm1FnPz4wck;
	Thu, 28 Mar 2024 15:39:48 +1100 (AEDT)
Date: Thu, 28 Mar 2024 15:39:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew
 Morton <akpm@linux-foundation.org>, Kent Overstreet
 <kent.overstreet@linux.dev>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the mm tree
Message-ID: <20240328153947.3871cfdf@canb.auug.org.au>
In-Reply-To: <CAJuCfpFTOz8cNiJFiCU5tMM1u5L=wXRsXqxUhN9g-R0u77CyZw@mail.gmail.com>
References: <20240325123603.1bdd6588@canb.auug.org.au>
	<CAJuCfpH4Ee00hM9+B7=mi5Dwjrhov8vUK-KwPuoO3wsD7iJSAQ@mail.gmail.com>
	<5e1321ca-0d46-4e9d-a6e5-0560d99f65ff@infradead.org>
	<CAJuCfpFTOz8cNiJFiCU5tMM1u5L=wXRsXqxUhN9g-R0u77CyZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1atUFZUt6qVSh.rRHhnvYDD";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1atUFZUt6qVSh.rRHhnvYDD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Mar 2024 23:16:55 -0700 Suren Baghdasaryan <surenb@google.com> w=
rote:
>
> Thanks! I'll change back all the instances in the documentation where
> we replaced original names with _noprof versions.

I now have the following:

mm/util.c:128: warning: expecting prototype for kmemdup_noprof(). Prototype=
 was for kmemdup() instead
mm/util.c:613: warning: expecting prototype for kvmalloc_node_noprof(). Pro=
totype was for kvmalloc_node() instead
mm/util.c:724: warning: expecting prototype for __vmalloc_array_noprof(). P=
rototype was for __vmalloc_array() instead
mm/util.c:739: warning: expecting prototype for vmalloc_array_noprof(). Pro=
totype was for vmalloc_array() instead
mm/util.c:762: warning: expecting prototype for vcalloc_noprof(). Prototype=
 was for vcalloc() instead
drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comm=
ents found
drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h:1: warning: no structured comm=
ents found
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1: warning: no structured comme=
nts found
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'read_mpcc_state' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'mpc_init_single_inst' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'get_mpcc_for_dpp_from_secondary' not described in 'mpc_=
funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'get_mpcc_for_dpp' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'wait_for_idle' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'assert_mpcc_idle_before_connect' not described in 'mpc_=
funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'init_mpcc_list_from_hw' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'set_denorm' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'set_denorm_clamp' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'set_output_csc' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'set_ocsc_default' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'set_output_gamma' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'power_on_mpc_mem_pwr' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'set_dwb_mux' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'disable_dwb_mux' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'is_dwb_idle' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'set_out_rate_control' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'set_gamut_remap' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'program_1dlut' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'program_shaper' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'acquire_rmu' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'program_3dlut' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'release_rmu' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'get_mpc_out_mux' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'set_bg_color' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:547: warning: Function paramete=
r or struct member 'set_mpc_mem_lp_mode' not described in 'mpc_funcs'
drivers/gpu/drm/amd/display/dc/inc/hw/opp.h:1: warning: no structured comme=
nts found
drivers/gpu/drm/amd/display/dc/inc/hw/opp.h:1: warning: no structured comme=
nts found
drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no str=
uctured comments found
drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.h:1: warning: no str=
uctured comments found
drivers/slimbus/stream.c:49: warning: Excess struct member 'segdist_codes' =
description in 'segdist_code'
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
mm/slub.c:3969: warning: expecting prototype for kmem_cache_alloc_node_nopr=
of(). Prototype was for kmem_cache_alloc_node() instead
mm/util.c:128: warning: expecting prototype for kmemdup_noprof(). Prototype=
 was for kmemdup() instead
mm/util.c:613: warning: expecting prototype for kvmalloc_node_noprof(). Pro=
totype was for kvmalloc_node() instead
mm/util.c:724: warning: expecting prototype for __vmalloc_array_noprof(). P=
rototype was for __vmalloc_array() instead
mm/util.c:739: warning: expecting prototype for vmalloc_array_noprof(). Pro=
totype was for vmalloc_array() instead
mm/util.c:762: warning: expecting prototype for vcalloc_noprof(). Prototype=
 was for vcalloc() instead
mm/vmalloc.c:3722: warning: expecting prototype for __vmalloc_node_range_no=
prof(). Prototype was for __vmalloc_node_range() instead
mm/vmalloc.c:3867: warning: expecting prototype for __vmalloc_node_noprof()=
 Prototype was for __vmalloc_node() instead
mm/vmalloc.c:3940: warning: expecting prototype for vzalloc_noprof(). Proto=
type was for vzalloc() instead
mm/vmalloc.c:3978: warning: expecting prototype for vmalloc_node_noprof(). =
Prototype was for vmalloc_node() instead
mm/vmalloc.c:3996: warning: expecting prototype for vzalloc_node_noprof(). =
Prototype was for vzalloc_node() instead
mm/vmalloc.c:4024: warning: expecting prototype for vmalloc_32_noprof(). Pr=
ototype was for vmalloc_32() instead
mm/vmalloc.c:4040: warning: expecting prototype for vmalloc_32_user_noprof(=
). Prototype was for vmalloc_32_user() instead
mm/mempool.c:383: warning: expecting prototype for mempool_alloc_noprof(). =
Prototype was for mempool_alloc() instead
mm/page_alloc.c:4991: warning: expecting prototype for alloc_pages_exact_no=
prof(). Prototype was for alloc_pages_exact() instead
mm/page_alloc.c:5016: warning: expecting prototype for alloc_pages_exact_ni=
d_noprof(). Prototype was for alloc_pages_exact_nid() instead
mm/page_alloc.c:6463: warning: expecting prototype for alloc_contig_range_n=
oprof(). Prototype was for alloc_contig_range() instead
mm/page_alloc.c:6627: warning: expecting prototype for alloc_contig_pages_n=
oprof(). Prototype was for alloc_contig_pages() instead
mm/mempolicy.c:2223: warning: expecting prototype for alloc_pages_mpol_nopr=
of(). Prototype was for alloc_pages_mpol() instead
mm/mempolicy.c:2298: warning: expecting prototype for vma_alloc_folio_nopro=
f(). Prototype was for vma_alloc_folio() instead
mm/mempolicy.c:2326: warning: expecting prototype for alloc_pages_noprof().=
 Prototype was for alloc_pages() instead
mm/util.c:128: warning: expecting prototype for kmemdup_noprof(). Prototype=
 was for kmemdup() instead
mm/util.c:613: warning: expecting prototype for kvmalloc_node_noprof(). Pro=
totype was for kvmalloc_node() instead
mm/util.c:724: warning: expecting prototype for __vmalloc_array_noprof(). P=
rototype was for __vmalloc_array() instead
mm/util.c:739: warning: expecting prototype for vmalloc_array_noprof(). Pro=
totype was for vmalloc_array() instead
mm/util.c:762: warning: expecting prototype for vcalloc_noprof(). Prototype=
 was for vcalloc() instead
mm/percpu.c:1745: warning: expecting prototype for pcpu_alloc_noprof(). Pro=
totype was for pcpu_alloc() instead

--=20
Cheers,
Stephen Rothwell

--Sig_/1atUFZUt6qVSh.rRHhnvYDD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYE9JMACgkQAVBC80lX
0Gyc1gf9G+Yw5SVExufy2gkhTVQcY3VfSUzpMaVlhXRzyVPVgVQXRoRQ2ZwIt+Vu
w1tXAza8CkV4odJvGnaFVYLPyI1xKOFz9PSndX2dN6T/kBxEAKkJMi2tMNouPxLc
aGhFLPIzM2Qf/enN2m//lrviGHbGxNzI0yYJkuRtJ+OOBnGnwx9+VAWdHd4Ep0vW
pmyqsDdDH0ih/l++2HF2XokieuBtXMd6f5aFfTpQw88kUQ/hXks14GCiY2h0L7pG
4aFUYGOF6/PM8BjpjM4sJnH+QtrgW6JDOF6lYMBf6QGEllFAc/T55inJD5J+elpd
zkfEGTx/yYqF0/yB62LezET2blHdhg==
=rqsu
-----END PGP SIGNATURE-----

--Sig_/1atUFZUt6qVSh.rRHhnvYDD--

