Return-Path: <linux-kernel+bounces-164862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F378B8417
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E89C1F231D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4BB79FD;
	Wed,  1 May 2024 01:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSStSS/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2B4400;
	Wed,  1 May 2024 01:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714528583; cv=none; b=ZxMtIhrZ1TN+z7prdvuuTzUlLRoL5iQ4T7ajWkh1Co1AcQnELSBTzjWbY6YLKN0fKBytT+Xgr1u7Z9O5/gSP1fYE+YV0vk5larhJGSuKOFJqcjj1KRGILtRnGEKDPEsX0EEAVQkEReUi63NuHwvj2EWLetwj7DD8f4jSs53KY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714528583; c=relaxed/simple;
	bh=YHqNQfR2KzM3NdArIJMkOcJO9cdsTJsp3u0H/eNeyPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeYRhVwVnCzG6n7dgQLfb/XQr5Is6Li/azVH0lqwLNVBAMjkqg/U0OTd1hR2e911Xx61kA+dxSr2HsXI76mTh7n/JN6PBhrll/g9lwxeb2+zJzCeT1CC5XxLb4EPF0lNY2X/KmGVsumAFdMTsHL6qQBFLM3S6PewA86myp1NMko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSStSS/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD2CC2BBFC;
	Wed,  1 May 2024 01:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714528582;
	bh=YHqNQfR2KzM3NdArIJMkOcJO9cdsTJsp3u0H/eNeyPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSStSS/NICuFDdVh5b39LHmEYgRreHSqX8JHJYP/UBw7rK3B6MK/2TPkLre3fEHfu
	 tLQSNFeTvzu8j1h0d6CBrA6ZFZMH3z2AqRFdPJEalH2PHrSs64AmD3NPhOS1Zu/gcU
	 HBi44k60jAkcvP6MHmgniiYlLG1si5ZshpPh2azKd+8WEGrcyGtwLePwl5zYB49WIb
	 HeXw89okgcX3KnOeSqGEm1czuK2mdFp6t7IAES7cHMxRHuod9ZJHIPg+5YSCtAk+z1
	 bA9hZY9fouyoWtbyyiNt3kCY2+xGK03foFE7ETcr+bHYdSRxqXWF7BkBDziHtta/hE
	 Vmr6/qX+g7Fkg==
Date: Wed, 1 May 2024 10:56:15 +0900
From: Mark Brown <broonie@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sebastian Fricke <sebastian.fricke@collabora.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl,
	sakari.ailus@iki.fi, tfiga@chromium.org, m.szyprowski@samsung.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 00/16] Add audio support in v4l2 framework
Message-ID: <ZjGhPz-bokg6ZbDJ@finisterre.sirena.org.uk>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
 <20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
 <ZjEEKyvb02CWz3l4@finisterre.sirena.org.uk>
 <20240430172752.20ffcd56@sal.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1s5XZL2PHP3gK0J2"
Content-Disposition: inline
In-Reply-To: <20240430172752.20ffcd56@sal.lan>
X-Cookie: lisp, v.:


--1s5XZL2PHP3gK0J2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 05:27:52PM +0100, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:
> > On Tue, Apr 30, 2024 at 10:21:12AM +0200, Sebastian Fricke wrote:

> > The discussion around this originally was that all the audio APIs are
> > very much centered around real time operations rather than completely

> The media subsystem is also centered around real time. Without real
> time, you can't have a decent video conference system. Having
> mem2mem transfers actually help reducing real time delays, as it=20
> avoids extra latency due to CPU congestion and/or data transfers
> from/to userspace.

Real time means strongly tied to wall clock times rather than fast - the
issue was that all the ALSA APIs are based around pushing data through
the system based on a clock.

> > That doesn't sound like an immediate solution to maintainer overload
> > issues...  if something like this is going to happen the DRM solution
> > does seem more general but I'm not sure the amount of stop energy is
> > proportionate.

> I don't think maintainer overload is the issue here. The main
> point is to avoid a fork at the audio uAPI, plus the burden
> of re-inventing the wheel with new codes for audio formats,
> new documentation for them, etc.

I thought that discussion had been had already at one of the earlier
versions?  TBH I've not really been paying attention to this since the
very early versions where I raised some similar "why is this in media"
points and I thought everyone had decided that this did actually make
sense.

--1s5XZL2PHP3gK0J2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYxoT4ACgkQJNaLcl1U
h9Cdygf/bf6TAsptAknaEPQAw2Z5iLipMaPxhatnFylMl5K5iu0XYqQKgMjz9hzh
pGWiv30tMEb1WWSd01RSGVLhVOz6Q/BoFOLmnu8iqikc/Y9AXuMpznA5kR9n+frq
Vlmf+jK0/Yx/co+47MPq9h7wsuCHeavsUyinC7Iw+M5MkxLXy4ga/C/0tl2tDANc
Ev6nkmUcjKAhI2O6zqwyxvO+0fagaQevxsYwhxJGbcqNcXzaa+OYshVVq8y00ugk
paLFfitKTRz1J3qN5WfkELm40cyRulKxZIdJAQIO0VFwzCIWOdty1FYDs5GXlL0f
Ys8S/0aZLJEVbPqQA1tZML2Y+D99YQ==
=NaHt
-----END PGP SIGNATURE-----

--1s5XZL2PHP3gK0J2--

