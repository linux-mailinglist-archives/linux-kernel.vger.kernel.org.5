Return-Path: <linux-kernel+bounces-49617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA07F846D1A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F35EB240F2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344BF77F10;
	Fri,  2 Feb 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVHC9lQt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5463099
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867620; cv=none; b=hwruN5ERo2Ue71MYyG3hwF+2hS2vcf0Nix7bVCqgFqnTpsSKMmPKA5+nqY3rJBlQ8XMnNYhs9XBIcDDHAVsAspUuXZSW6Ssu5vhheRleMQNMbDSLVBQLtgoE0PiN8o8e+E1kVTjNweRnNNlG6xgsY/xoxhHlsTCu8WSlwJbA7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867620; c=relaxed/simple;
	bh=Bfd/GkSJgdo+XNvnX3vfrEM+2s3tKVMNSvNG435RkV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3/MHxy4k8UK+fkZ1KvY3vL16V5EzFIozb4JF/91dZP0NF3fj8+EA9dRVZ+/ptn/eoLY/o4+Q15dzMcjEzaf8cf+X9VmQuI+4vMJKd/Gp7QjU3T5vUYHl7v0ZK46U31An+puukPlZcomYZycUuGQrMr9mDoCfI6ZR+aiFzm51vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVHC9lQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A2DC433C7;
	Fri,  2 Feb 2024 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706867620;
	bh=Bfd/GkSJgdo+XNvnX3vfrEM+2s3tKVMNSvNG435RkV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVHC9lQt9mU1obANrSeVdamsYY76q01QCeJgmuj4Op4N5qEpIs91Ylf59bTt/H0pV
	 keXz4Up2QyG6pKjjkx0q6lyABhoXp/zvH1lXdEmPsyb852qA0dhDKCjUuPr71nSVTs
	 +zwWYobiAkhZlPsC85fw5wS5UtVdD6qFT77P0FIYMNfvHrAzTHOKrkbL0d1fcLuKRd
	 r08sTsdJB7RwfkrAUMROx1ARM785L4Vzcr957zldDzYN7xgxbUr1dLdYvxFuZ29rN6
	 P6tePJ7EB7HNDokdhssmSpDldoyxfqxkhB6L3dKtXvOK4Ic6sky3bG+0KD2aHjPoH9
	 PKZBj9AtDgpcg==
Date: Fri, 2 Feb 2024 10:53:37 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pekka Paalanen <pekka.paalanen@haloniitty.fi>, 
	Louis Chauvet <louis.chauvet@bootlin.com>, Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, marcheu@google.com, seanpaul@google.com, 
	nicolejadeyee@google.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	thomas.petazzoni@bootlin.com
Subject: Re: Re: [PATCH 2/2] drm/vkms: Use a simpler composition function
Message-ID: <3nofkwzgnf4yva2wfogdbii47ohpi2wm5vp6aijtg3emxyoowt@twyreqz7ai3g>
References: <20240201-yuv-v1-0-3ca376f27632@bootlin.com>
 <20240201-yuv-v1-2-3ca376f27632@bootlin.com>
 <20240202105522.43128e19@eldfell>
 <20240202102601.70b6d49c@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zt2zjtvam7zfj272"
Content-Disposition: inline
In-Reply-To: <20240202102601.70b6d49c@xps-13>


--zt2zjtvam7zfj272
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On Fri, Feb 02, 2024 at 10:26:01AM +0100, Miquel Raynal wrote:
> pekka.paalanen@haloniitty.fi wrote on Fri, 2 Feb 2024 10:55:22 +0200:
>=20
> > On Thu, 01 Feb 2024 18:31:32 +0100
> > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> >=20
> > > Change the composition algorithm to iterate over pixels instead of li=
nes.
> > > It allows a simpler management of rotation and pixel access for compl=
ex formats.
> > >=20
> > > This new algorithm allows read_pixel function to have access to x/y
> > > coordinates and make it possible to read the correct thing in a block
> > > when block_w and block_h are not 1.
> > > The iteration pixel-by-pixel in the same method also allows a simpler
> > > management of rotation with drm_rect_* helpers. This way it's not nee=
ded
> > > anymore to have misterious switch-case distributed in multiple places=
=2E =20
> >=20
> > Hi,
> >=20
> > there was a very good reason to write this code using lines:
> > performance. Before lines, it was indeed operating on individual pixels.
> >=20
> > Please, include performance measurements before and after this series
> > to quantify the impact on the previously already supported pixel
> > formats, particularly the 32-bit-per-pixel RGB variants.
> >=20
> > VKMS will be used more and more in CI for userspace projects, and
> > performance actually matters there.
> >=20
> > I'm worrying that this performance degradation here is significant. I
> > believe it is possible to keep blending with lines, if you add new line
> > getters for reading from rotated, sub-sampled etc. images. That way you
> > don't have to regress the most common formats' performance.
>=20
> While I understand performance is important and should be taken into
> account seriously, I cannot understand how broken testing could be
> considered better. Fast but inaccurate will always be significantly
> less attractive to my eyes.

AFAIK, neither the cover letter nor the commit log claimed it was fixing
something broken, just that it was "better" (according to what
criteria?).

If something is truly broken, it must be stated what exactly is so we
can all come up with a solution that will satisfy everyone.

> I am in favor of making this working first, and then improving the code
> for faster results. Maybe the line-driven approach can be dedicated to
> "simpler" formats where more complex corner cases do not happen.

Which ones?

Maxime

--zt2zjtvam7zfj272
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZby7oAAKCRDj7w1vZxhR
xXwxAPsFVsJYK4xWIWUhq8+84+oxR2kLDVawImhl/tLFMgP18wD+Kf7nPl9alhHN
QaVk2lv/sl2IZKrDqGyRJ0lq8HVPXQE=
=qz9+
-----END PGP SIGNATURE-----

--zt2zjtvam7zfj272--

