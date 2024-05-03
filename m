Return-Path: <linux-kernel+bounces-167159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBBA8BA511
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A7FCB22923
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C1C12E71;
	Fri,  3 May 2024 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huJ8dvqB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33095125C9;
	Fri,  3 May 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700843; cv=none; b=G4Zn8Vc1dd8dwpZWmnQCfPotUXsOaKeoZTEJtOxrLjLrJkUx9XNILruxFdOXPw6/bBb80PGs3/hAkhaZlIfx+iP4Hc92GizjGdK58MaQzhHZ30MXbHZMuppxSAdIMEftwl74E5+mc4tCSHdIU8VAx/lDftZ/GmDKZWhp6XnWZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700843; c=relaxed/simple;
	bh=jnztmxuaRUJ/EUjiAcJ6LSXXmWw6auqF5LGM5XsjF8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXodj5zcdND99yW5yNsTCjvpTWtIijJ1o29wDKVDWSCPHZvq5y47zqnuI8PUBeKzZe5YyDhbepO3pYma6FmPTmEbKgQctZVOihdDOUDtaBXTRfkfmTOXBEDm5Z553UA6zRi6UwL6aZILpJycgSXYo4KORvEqReW6LTaIOAG1pKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huJ8dvqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB22C113CC;
	Fri,  3 May 2024 01:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714700842;
	bh=jnztmxuaRUJ/EUjiAcJ6LSXXmWw6auqF5LGM5XsjF8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huJ8dvqB+TN/5IgJ6rtnCXfVgXOlZfAdZYA/7vs7YuLO962TFb+avL/V+5+Rni204
	 u9/f/fRre6WsTm1XAt3biIJ7MtrAkKMlIcdBiezfCUBrbLhc4GQOvDOFdoMrywy15G
	 HVDUuTPVvWfCo/LWmMR/YAYd76bJuAAZMqubdIdTqLpUHdoyUTiJr/OhqWHi1DQwX/
	 TTfuZAYA+OBxUo5XMadmDCz6i1lMZq0CwsUh/khAN9yCvtk9LCjCamRsZktG50n/EX
	 TDY9n+egIwFoWC/EpRvSADEFoGvRx918hONbY9legxC9/dh+ROPGl1a4VHgQWky9Ab
	 R0tQiZIJgiz0A==
Date: Fri, 3 May 2024 10:47:19 +0900
From: Mark Brown <broonie@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl,
	sakari.ailus@iki.fi, tfiga@chromium.org, m.szyprowski@samsung.com,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v15 00/16] Add audio support in v4l2 framework
Message-ID: <ZjRCJ2ZcmKOIo7_p@finisterre.sirena.org.uk>
References: <1710834674-3285-1-git-send-email-shengjiu.wang@nxp.com>
 <20240430082112.jrovosb6lgblgpfg@basti-XPS-13-9310>
 <ZjEEKyvb02CWz3l4@finisterre.sirena.org.uk>
 <20240430172752.20ffcd56@sal.lan>
 <ZjGhPz-bokg6ZbDJ@finisterre.sirena.org.uk>
 <87sez0k661.wl-tiwai@suse.de>
 <20240502095956.0a8c5b26@sal.lan>
 <20240502102643.4ee7f6c2@sal.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YhSjxC/xCHptpvaf"
Content-Disposition: inline
In-Reply-To: <20240502102643.4ee7f6c2@sal.lan>
X-Cookie: lisp, v.:


--YhSjxC/xCHptpvaf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 10:26:43AM +0100, Mauro Carvalho Chehab wrote:
> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:

> > There are still time control associated with it, as audio and video
> > needs to be in sync. This is done by controlling the buffers size=20
> > and could be fine-tuned by checking when the buffer transfer is done.

=2E..

> Just complementing: on media, we do this per video buffer (or
> per half video buffer). A typical use case on cameras is to have
> buffers transferred 30 times per second, if the video was streamed=20
> at 30 frames per second.=20

IIRC some big use case for this hardware was transcoding so there was a
desire to just go at whatever rate the hardware could support as there
is no interactive user consuming the output as it is generated.

> I would assume that, on an audio/video stream, the audio data
> transfer will be programmed to also happen on a regular interval.

With audio the API is very much "wake userspace every Xms".

--YhSjxC/xCHptpvaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY0QicACgkQJNaLcl1U
h9DEDgf+OxkntU8LcfqnvW2Z51UqNQJ0p62Te/DmJ+wZWQotYcbwAQdb4fMKfeyw
TU+Kka5bvWBtYfhoCnXFlDqQUh4Ldk7wZEWfHS2KCCM+o3mr/WHvxCRqSvy2geXZ
+76U6qA5/RPQnAFUlNe9Kp4LK4LpvGg9KONljKpsIdFBEDvJG84wr+zLwDuboy4O
rVP1hJQmucWST9qsBWFT+7VmJt9tbK2I3iwIB2Z3utiJvBFvyyj8bVMx5I1ssxfj
Rh5yL+iQ+aEQkTwEBTzuAS055XYNxzl/eBa25iRWCgoYOrMiphGpWBDWp5qUoPiB
SWVL9dU2q9I5o4Y+GNohSdEw9Rctfw==
=OLs5
-----END PGP SIGNATURE-----

--YhSjxC/xCHptpvaf--

