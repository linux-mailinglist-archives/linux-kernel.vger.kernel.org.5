Return-Path: <linux-kernel+bounces-122761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000E488FCC4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5191C2EFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB264CE9;
	Thu, 28 Mar 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcPQ9Qyn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B235250EC;
	Thu, 28 Mar 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711621135; cv=none; b=g3KqfBaH1Un5/X4Lv/aZxX0y9Sradi7RKDF/MvK9kAtMsV7FcLZjuLU1/KzWtx8micAieoJTcqQQjULx9/vJo1Lzm4meps+OGT7eYeLfZyzMKcyx6eKVWxjNQweN2cPcCULA7O/KMUMzAFJUfo+lVYua2N6/+YmsGqZnf94u37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711621135; c=relaxed/simple;
	bh=fllq40obke4yqmFFH/hGjhHGyAfQokx4uFEG/x3BhtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvb/s+cpkto01wpOr5MGZMU076NQYl2EKtmiFGtaoU5KYyC+ZkVNARmX/V/rp/+CEWRR+zgqs5kh9++my93I2c4KqIkOOtyyYG5Og9mFssgEoPMHr00Ktk/B/EiRy8CZSFF2r1GDkEuZ3k5l2Iexs3RMpXz4k2M1J5mv2cpZlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcPQ9Qyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D80EC433C7;
	Thu, 28 Mar 2024 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711621134;
	bh=fllq40obke4yqmFFH/hGjhHGyAfQokx4uFEG/x3BhtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rcPQ9Qynni8fz9X4waD3XEQuC3TBb59cX/QCxy82usfAKOhzvj4v2pe5SGQi/+l87
	 f/NmRhWwqyp5X775DPbkx/rjnWv3CEDLFRjyJqiaOgBWC/K6FBcZ1Ze2m54vceKUn+
	 vtp08QMbRcfDH+eRer3Rm/BKVxbHnksrXleG+FGCUsf4ELL7oc0ynz9floguu+wUMv
	 uvB3bXRCyiQs1PyhUdPsBuPgUHg3jXOSA8svMGMh8ppCcxkbUTZY7gamm3xqJlO5DI
	 z2oa7L91udPTPjDyMY1/NbdcT5faUq41AD0ptjrKj/m1581NNMTPCvqvYCG4a7AuZx
	 bfjY841r65seQ==
Date: Thu, 28 Mar 2024 11:18:51 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Dave Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Alon Levy <alevy@redhat.com>, 
	Frediano Ziglio <fziglio@redhat.com>, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH 1/2] drm/qxl: remove unused `count` variable from
 `qxl_surface_id_alloc()`
Message-ID: <20240328-quantum-bettong-of-contentment-7c7841@houat>
References: <20240327175556.233126-1-ojeda@kernel.org>
 <CANiq72=kGWSQR7TgKDnAaef+FS3VGQeo3ri5vv1wxpW_88vdqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ciytvnzm6i4uvloj"
Content-Disposition: inline
In-Reply-To: <CANiq72=kGWSQR7TgKDnAaef+FS3VGQeo3ri5vv1wxpW_88vdqA@mail.gmail.com>


--ciytvnzm6i4uvloj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 07:14:12PM +0100, Miguel Ojeda wrote:
> On Wed, Mar 27, 2024 at 6:56=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> w=
rote:
> >
> > Closes: https://lore.kernel.org/lkml/CANiq72mjc5t4n25SQvYSrOEhxxpXYPZ4p=
PzneSJHEnc3qApu2Q@mail.gmail.com/
>=20
> Should have a [1] at the end.

I added it while committing

> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
> > Given there is a loop going on here, it would be good to double-check w=
hether
> > this variable was supposed to be used for something useful or if it was=
 just a
> > remnant of a version previous to v1.4.
>=20
> Also, I see Nathan sent meanwhile a message about these two that were
> also mentioned/reported a while ago [1].

"a while ago" here being 2 hours before your message :)

I've added a Closes tag for that report too.

I've applied both patches to drm-misc-fixes, thanks!
Maxime

--ciytvnzm6i4uvloj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZgVECwAKCRDj7w1vZxhR
xUBYAQC+f5qGWArfgMTJlTCdd+YDHQUdIGEO8Z0XTD7rNl0dAwD/d/mmblBxzwbp
0MrWW5gDzAsnFQV6rh7iIpJtTC8MyAs=
=4QIQ
-----END PGP SIGNATURE-----

--ciytvnzm6i4uvloj--

