Return-Path: <linux-kernel+bounces-164192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF4F8B7A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004EE1F2371D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116287710F;
	Tue, 30 Apr 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRoXQHpF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCC1527A4;
	Tue, 30 Apr 2024 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488366; cv=none; b=LdamtPPw8GL/rweQY6Bx27USDHW4xh1ve9rnVkdkVDp/PfrFPl5ptG/N249TANabJCPrA/R2bcoMIjB9E6642cU0/YoeQNdF9ti0vLJu3sGLayxBeL/DdSGT9ixDqOEs3fEkXFmWFo/7g1Y0N5VIPyohDrLhRb6Jiah5i6SpJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488366; c=relaxed/simple;
	bh=sBXF+gjdjkRUhUS5Q4VYAIn7ZZ0+/7CQzrsCxXjL5dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhpBoW0G5zbpiGyGtk5+IxtO8wvxOmt1rz4CpbEt9+4rRkDJkQZZGDNu2tYy9fdmNmlKIvbIjV7MdAdJTpbdUCtboQF8Y2K/V0JEbh8kcOZnbZu3HB1G2oBc9rQGYjuJ8MHDEEtJ1R7l1tOxApxFbp/AsCPJlK0l2xmlyEb0JOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRoXQHpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AA7C2BBFC;
	Tue, 30 Apr 2024 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714488365;
	bh=sBXF+gjdjkRUhUS5Q4VYAIn7ZZ0+/7CQzrsCxXjL5dU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRoXQHpFRApacG9ybBX6B95wKslmuE4UrGaFexMEbtIm4t0uAJWO5tcrZym/VeE6c
	 /S830uVslcO9IbwPhqveybIosTrozBqM7h3wLkepcAlo/OU8tSPtYbhSNFrRkBmJoY
	 coUyqlE3pvWN7L+ZADP0BArwUBwm0ZuPyscvkM+nbLTP2FFxQjOkqSGzrLP0nmF59c
	 HpkI+8ke0LG7xCL9EukPGz03r7pzDIngxJliSGTTyZzTiGidd9jyzpgZOskOd14X1g
	 RsWX+jRkJXkQXTcPdZpK1YXzqklzIBXOuEYb0AbCkvsNf+KksxsobnCLpsLMJhDf6m
	 zrcNcrPKbwG0Q==
Date: Tue, 30 Apr 2024 23:46:03 +0900
From: Mark Brown <broonie@kernel.org>
To: Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl,
	sakari.ailus@iki.fi, tfiga@chromium.org, m.szyprowski@samsung.com,
	mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 00/16] Add audio support in v4l2 framework
Message-ID: <ZjEEKyvb02CWz3l4@finisterre.sirena.org.uk>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
 <20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8QM/NXLseGhLxhjD"
Content-Disposition: inline
In-Reply-To: <20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
X-Cookie: lisp, v.:


--8QM/NXLseGhLxhjD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2024 at 10:21:12AM +0200, Sebastian Fricke wrote:

> first of all thanks for all of this work and I am very sorry for only
> emerging this late into the series, I sadly didn't notice it earlier.

It might be worth checking out the discussion on earlier versions...

> 1. The biggest objection is, that the Linux Kernel has a subsystem
> specifically targeted for audio devices, adding support for these
> devices in another subsystem are counterproductive as they work around
> the shortcomings of the audio subsystem while forcing support for a
> device into a subsystem that was never designed for such devices.
> Instead, the audio subsystem has to be adjusted to be able to support
> all of the required workflows, otherwise, the next audio driver with
> similar requirements will have to move to the media subsystem as well,
> the audio subsystem would then never experience the required change and
> soon we would have two audio subsystems.

The discussion around this originally was that all the audio APIs are
very much centered around real time operations rather than completely
async memory to memory operations and that it's not clear that it's
worth reinventing the wheel simply for the sake of having things in
ALSA when that's already pretty idiomatic for the media subsystem.  It
wasn't the memory to memory bit per se, it was the disconnection from
any timing.

> So instead of hammering a driver into the wrong destination, I would
> suggest bundling our forces and implementing a general memory-to-memory
> framework that both the media and the audio subsystem can use, that
> addresses the current shortcomings of the implementation and allows you
> to upload the driver where it is supposed to be.

That doesn't sound like an immediate solution to maintainer overload
issues...  if something like this is going to happen the DRM solution
does seem more general but I'm not sure the amount of stop energy is
proportionate.

--8QM/NXLseGhLxhjD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYxBCsACgkQJNaLcl1U
h9Cv4gf/cXnSe2CcRqekxdvf3QpCLrReELvBj5Ryx0es6jh5p0iXtGjTAa+m1l2U
Qn6JhhdVxr6YDApk3yXTkGvTElhB2RPjdxhHGklWqfXFTwKhZtFYKmx2GqfKxLXZ
6N4OhJv/OYSeLGuGQDh3WLEJW44PKKQUfDg6zdCCu2xeTqt42IeZOPA4NLU9lBvm
6vzvRoB9ddXzdqIJ5tPx89c3PXrCKBHhFIz9FQ1QLpE9p/26fkpsjYkB9cTQhAGq
kMvWcqfITh7e8JEEPsVzlYMNOcsCCegJqJwniSw2OV3fQDBUDoHaO/I1hYidAzVS
IndFbuEtQpfHjpRlfXAsGrrxDysAfw==
=/WXD
-----END PGP SIGNATURE-----

--8QM/NXLseGhLxhjD--

