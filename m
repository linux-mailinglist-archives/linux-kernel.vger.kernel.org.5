Return-Path: <linux-kernel+bounces-32206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4CD83582B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004A61F21087
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B198638F9C;
	Sun, 21 Jan 2024 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jyv+MI1w"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57138DE7;
	Sun, 21 Jan 2024 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705875941; cv=none; b=YszetmINPp5VFXQHGqe6icK4P7xWSjI4AHFamADFaJpmRWYtJp3qeSRGbaZMqvces6zyWZ1gVDMBqN8FuXYi1W1dcr0TPqWAhj46mjB8SgfeVyL3fofvlMy8T5qi43LjvuOie6lbGW3YqF1zK3yEx9qc3eiDxW7dpmYGB0OLPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705875941; c=relaxed/simple;
	bh=E4gq6a9zOlIEmJ40gwnnHLl9HxWFk9Dhksp7/qOACdg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNBo/YPfuOO7W8qgF7mfTgmD3KLqkicEIi5oZTTZzjC/kM/tEf4nBrC9IWcWgBZmbOGyZ4b0FgSD6KFu0O8fsINdA/opQIOQSHTS7zr9oYrNg1pwxiG4+a8xH6VeeLtZKVVxP0743PYMTy/VNjJOSaMf7dBUIklXA17/ofzUu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=jyv+MI1w; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705875934;
	bh=r1mbkvsH1Tw6GErB5aGRuFX4QTAhmff/iRgdLLRbQds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jyv+MI1wWW+BA4ZFuA/cwmMAocUqbSHOT9RvEvqB2APqOyV3SPeLgANM9wjz8traO
	 4W4YslnVZei6GI+Xh6m605VjU7+ggypB8+laAoLXhf40ssme2G0IBHSBhxoyP99ULa
	 sovznKvecigIzs5kiSIFfGKpnXtFvePlz5hkpZ98dlT1jVHzgQe7DMHj3QxC9spv8I
	 rzl/7x0xKItkrdzuqGtxwS5X5eepG4U4JDnuy+Bl5SmzRmO7Hpq2q5JetXh2yHKNGy
	 0nIAupwnIu3DujY1ut0yIcN1K1f0IJDWDhnJHsB6SgWJTC5K4coX8v8UWVSv5ivust
	 DEmxH+54I8ZDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TJ7GN5N6Zz4wyl;
	Mon, 22 Jan 2024 09:25:32 +1100 (AEDT)
Date: Mon, 22 Jan 2024 09:25:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>, DRI
 <dri-devel@lists.freedesktop.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm-intel tree
Message-ID: <20240122092520.68a86f48@canb.auug.org.au>
In-Reply-To: <87y1f0sol1.fsf@intel.com>
References: <20231114141715.6f435118@canb.auug.org.au>
	<8734x8u4la.fsf@intel.com>
	<87y1f0sol1.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wRTTQqaNc4XzgCWXZZqmNJE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/wRTTQqaNc4XzgCWXZZqmNJE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 14 Nov 2023 10:53:30 +0200 Jani Nikula <jani.nikula@linux.intel.com=
> wrote:
>
> On Tue, 14 Nov 2023, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > On Tue, 14 Nov 2023, Stephen Rothwell <sfr@canb.auug.org.au> wrote: =20
> >>
> >> After merging the drm-intel tree, today's linux-next build (htmldocs)
> >> produced this warning:
> >>
> >> Documentation/gpu/drm-kms-helpers:296: drivers/gpu/drm/display/drm_dp_=
mst_topology.c:5484: ERROR: Unexpected indentation.
> >> Documentation/gpu/drm-kms-helpers:296: drivers/gpu/drm/display/drm_dp_=
mst_topology.c:5488: WARNING: Block quote ends without a blank line; unexpe=
cted unindent.
> >>
> >> Introduced by commit
> >>
> >>   1cd0a5ea4279 ("drm/dp_mst: Factor out a helper to check the atomic s=
tate of a topology manager") =20
> >
> > Imre, please fix this. =20
>=20
> Just noticed there's a fix [1]. Need to merge that via drm-intel.
>=20
> BR,
> Jani.
>=20
> [1] https://patchwork.freedesktop.org/patch/msgid/20231114081033.27343-1-=
bagasdotme@gmail.com

This is still not fixed.

--=20
Cheers,
Stephen Rothwell

--Sig_/wRTTQqaNc4XzgCWXZZqmNJE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWtmdAACgkQAVBC80lX
0Gx3RAf/YnenmQC4D8I1Oh5yglRdacM2m/Scpo+6Cw2VWloUSrj2PAKrU6+CjvI/
MJuf/g1YBhFLJeBvOhweBu2kTO0h+8+GbaD9SgEwixf+9jIdAZTx4Y3YYarXJ3u5
shAYBQwKwvo0ff0wqeC9LTth/Vg8RHKv8PV5L9XXA8K4qYWsxQc3cTQVJB3J1e8O
ktRUQyhv995RViXnyLMaIiM2hzjDF3Q5UcaPEGUpUrkUE8v6z0sElnrQNw2mkeTt
KfnPDpmcD/MtFXQA9Q5vCPzHTsSd96ea+C+pNPoYihMKvMPjzvqZJvz2I+3cAi02
t6UBTgpftELqtsgP/2t1nqaVE6vrEg==
=wuPD
-----END PGP SIGNATURE-----

--Sig_/wRTTQqaNc4XzgCWXZZqmNJE--

