Return-Path: <linux-kernel+bounces-152659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C729D8AC22D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 01:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECDA280E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 23:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC646441;
	Sun, 21 Apr 2024 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TgI1usEM"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03C1BC58;
	Sun, 21 Apr 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713743536; cv=none; b=olZ88++gnRjV9YuaS2uw5NF9Uji/JZW5r3Q7ZIw/OTcdnt6mccdFK3zex7d2drm+QXRfc8Re9INNsnHaZm64YEQ9QWFBwqwL/DesId1htTdSGHqyf7MkHGHlq7LgmDIZC7eG7bnoA/JG0A2Ofdf6sXBb8VFxe3SUqB9QAbhtwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713743536; c=relaxed/simple;
	bh=T6etywjw0IwBWFlvTeMRdhCIAqGkYqWSXXVJjePDlCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unliPAXftFOiIk4lXdUF40G9w0j20qYwjq4i/8iTnFh/Ni+HXW2oul4WuuSrGzG8S6ID/7qiLPdjcyx4ro/LUDYoKOlUFYPiXjDYTzwO3LyFF+iwuD4OYMz9TeieNGl/Z+OxUyRrDKxNMQ+el544D7Z2jDJOX/nNQ9pjhsWmWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=TgI1usEM; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713743533;
	bh=GFDnA8RAaFmaQWPRe1uMDS3Qva86eNx720/zbSSQwRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TgI1usEMwpAYqvlCBdwuqCNw39qrTyxDnuWMA1c+ApUc5QkQyW+D49U9dcpi2l7qd
	 egr9ZJwaOwwg0+yvDalGRvi/rxbV+LRMTbcBxDNHmZrSkT7EBjBfDOoS5Y11vbvfgJ
	 Eh976Gb7IyKMGNa1PGtvCL9RAH5onPy3U8HPe1R8JrdaPTPUrToxlHa74xEC3fgE5s
	 iw9JtbkiP+c9ee4VY4TowGt14QdW2hHC04E91XYd6rHxbIrY5LZ8tugsNXgQzd0lze
	 h8yx++ODxL5N67oZdSnhYgRfp8UG51V0ZoQ4E2D5l6vq2Nbvmu3/JrHogQE80/zra8
	 KklmldNl1K5dA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VN4tN1VzHz4wc5;
	Mon, 22 Apr 2024 09:52:12 +1000 (AEST)
Date: Mon, 22 Apr 2024 09:52:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@redhat.com>
Cc: DRI <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: linux-next: build warnings after merge of the amdgpu tree
Message-ID: <20240422095211.430ca108@canb.auug.org.au>
In-Reply-To: <20240130134954.04fcf763@canb.auug.org.au>
References: <20240130134954.04fcf763@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ckcj8uug5d9=EtWSFD+C/xV";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ckcj8uug5d9=EtWSFD+C/xV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 30 Jan 2024 13:49:54 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the amdgpu tree, today's linux-next build (htmldocs)
> produced these warnings:
>=20
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use o=
f kernel-doc format:          * @@overlap_only: Whether overlapping of diff=
erent planes is allowed.
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use o=
f kernel-doc format:          * @@overlap_only: Whether overlapping of diff=
erent planes is allowed.
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1: warning: no structured com=
ments found
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use o=
f kernel-doc format:          * @@overlap_only: Whether overlapping of diff=
erent planes is allowed.
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:162: warning: Function parame=
ter or struct member 'pre_multiplied_alpha' not described in 'mpcc_blnd_cfg'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:162: warning: Function parame=
ter or struct member 'overlap_only' not described in 'mpcc_blnd_cfg'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'read_mpcc_state' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'mpc_init_single_inst' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'get_mpcc_for_dpp_from_secondary' not described in 'mp=
c_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'get_mpcc_for_dpp' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'wait_for_idle' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'assert_mpcc_idle_before_connect' not described in 'mp=
c_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'init_mpcc_list_from_hw' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'set_denorm' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'set_denorm_clamp' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'set_output_csc' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'set_ocsc_default' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'set_output_gamma' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'power_on_mpc_mem_pwr' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'set_dwb_mux' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'disable_dwb_mux' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'is_dwb_idle' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'set_out_rate_control' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'set_gamut_remap' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'program_1dlut' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'program_shaper' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'acquire_rmu' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'program_3dlut' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'release_rmu' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'get_mpc_out_mux' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'set_bg_color' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:548: warning: Function parame=
ter or struct member 'set_mpc_mem_lp_mode' not described in 'mpc_funcs'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use o=
f kernel-doc format:          * @@overlap_only: Whether overlapping of diff=
erent planes is allowed.
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:162: warning: Function parame=
ter or struct member 'pre_multiplied_alpha' not described in 'mpcc_blnd_cfg'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:162: warning: Function parame=
ter or struct member 'overlap_only' not described in 'mpcc_blnd_cfg'
> drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:132: warning: Incorrect use o=
f kernel-doc format:          * @@overlap_only: Whether overlapping of diff=
erent planes is allowed.
> Documentation/gpu/amdgpu/display/display-manager:134: drivers/gpu/drm/amd=
/display/dc/inc/hw/mpc.h:3: WARNING: Duplicate C declaration, also defined =
at gpu/amdgpu/display/dcn-blocks:100.
> Documentation/gpu/amdgpu/display/display-manager:146: drivers/gpu/drm/amd=
/display/dc/inc/hw/mpc.h:3: WARNING: Duplicate C declaration, also defined =
at gpu/amdgpu/display/dcn-blocks:3.
>=20
> Introduced by commit
>=20
>   b8c1c3a82e75 ("Documentation/gpu: Add kernel doc entry for MPC")

I am still seeing these warnings (as of last Friday) but the above
commit is now in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/ckcj8uug5d9=EtWSFD+C/xV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYlpqsACgkQAVBC80lX
0GzFPAf/dlQjWpCZ5B638FddINhXYIY1Ip7dLT5ySruQ98lksCrb3mWDcDXNKtmr
g4td6/9oMCGrKxaLErL8oMSEtH0CFJXxK/n8AxkiGqOIH7lBghtgr1UrUuQE8GNm
RCidZWHijBPtpJQBUGkqeh/ePhx22GJrPeFS4dlCmUBecg4v4V2ufqYk3qKIYMVK
0PmIAnmDEyLwDUDeS+7Qo1qQKRalDhtgnp60G8G3KXPXF5Ca4EJvmcUokraR/ZfL
WuURQydbxnYTbQbutBxlnnv/zyorBqrMnWUsb2DU6uLXhGlyXcRRcvEzI7Gcw7g1
gt4jTH+CX3hp8xB+2uGL/LB3L5aYOA==
=oPvm
-----END PGP SIGNATURE-----

--Sig_/ckcj8uug5d9=EtWSFD+C/xV--

