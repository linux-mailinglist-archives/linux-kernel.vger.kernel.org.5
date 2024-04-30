Return-Path: <linux-kernel+bounces-163688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0041E8B6E56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05C728387F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1923127E3F;
	Tue, 30 Apr 2024 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeU+hKT9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC15127E18
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469215; cv=none; b=AQfiVunHlUg1Vqe6+0onE2Av718oD46+Z/ZnXD3WlEL3furJJJmzpVMLC30tf8F+KwJIGphhRrPL5kq/HgYCSuAM7VZY0ADttNwiq5B5yCjmaLGkyER4VdqIlkvweSEjCpgboKkNvL3u+M7f2HxoRxLb7SpYVS2OKXY2K+Pxc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469215; c=relaxed/simple;
	bh=osYoF/+QhQnsuHtJ3Q0+vlbJuiLsDYYf88PkHc0kEE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLKg+1WnUrkEoS/A9/q5nklQepqEpS/nSwZm8OCl6nml2Ah7yL3Lguh1qghoYQ+ZwfDi/4AzpWGQwkxvOE19/kABGvxkwkw+CSNCdKm0qk+lmyhknJG+qpsBeBd8ghmjv6+JJ+9KbXbSBXtr4zrhy+uJqyKZG/NciRQXcKxQGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeU+hKT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F278C2BBFC;
	Tue, 30 Apr 2024 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714469214;
	bh=osYoF/+QhQnsuHtJ3Q0+vlbJuiLsDYYf88PkHc0kEE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eeU+hKT9wfRkFILUg9Ka2YlnjvNrn33Bx3DOUteKzMgthOmNB+2tQ5TRuskpA83Gd
	 j9aM23qQ7PI18H37woi8xiTv5zb+HigYPTD4eV75bUoDG0d5dr4sk35knue850Rr/s
	 0iy6ll8EVGYNWfxKko0eNmAyGrnYm8fEK4H086U+RJ+mhL2hOexTKunRcScK3t1x8g
	 Gd9lL2oviUkX5bNJ67AYOFNEEDsEXLPBEd1jqdO2qNysMuG6kU+GpXLmQ2MNjPacbc
	 ofPFaWVgzQN8T3AfO5CjsJSN5nrTQ57guV98k6zpWEjWZZDoV6mH8LtlNJHQbaY3yj
	 cLB0bqEiZjXwA==
Date: Tue, 30 Apr 2024 11:26:52 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: drm_of.c: Using EXPORT_SYMBOL_GPL instead of
 EXPORT_SYMBOL
Message-ID: <20240430-monumental-amazing-auk-c2c1a5@houat>
References: <20240429173521.709719-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="gszoyfbjymvekc4y"
Content-Disposition: inline
In-Reply-To: <20240429173521.709719-1-sui.jingfeng@linux.dev>


--gszoyfbjymvekc4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 30, 2024 at 01:35:21AM +0800, Sui Jingfeng wrote:
> Linux kernel puts strict limits on which functions and data structures
> are available to loadable kernel modules; only those that have been
> explicitly exported with EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() are
> accessible. In the case of EXPORT_SYMBOL_GPL(), only modules that declare
> a GPL-compatible license will be able to see the symbol.
>=20
> Since the whole drm_of.c file is declared with GPL-2.0-only license, so
> let us keep functions in that source file consistently.

You're conflating two things: the license of the code itself (GPL2
here), and the license of the users of the symbols exported in that
file (anything).

There's no relationship between the two, and you have to make an
argument for changing the latter other than just because the license is
GPL because, again, those are two different things.

Maxime

--gszoyfbjymvekc4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZjC5VwAKCRAnX84Zoj2+
drH4AX0Yc+tNrRH8v7q+wBO04sFF8tuXPLl3OJDc9YVVdQcKopJIVblT5B8B3hFP
ky1qAPABgKRDIFjl26BFax0qC0y7SwngqPB9+6uHiH6rb43lA+uGeU+v7He3mIYq
RtbytXJX+Q==
=Y0D6
-----END PGP SIGNATURE-----

--gszoyfbjymvekc4y--

