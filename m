Return-Path: <linux-kernel+bounces-86342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD086C425
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A1C289157
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CC653E18;
	Thu, 29 Feb 2024 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gvX9AuuE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39D535AF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196518; cv=none; b=mzFTvqOo1bar79j3NBxhXUy41XnknG+bQRUg/vToXU5Lwy2Hs8Gd/gGKvcGaHiB2XZdg0jdtJQDGZXoczksx2vJyLXSc6BpD6Bdmm8w2it0OiESvnju1DIw5zf5p/yPrEc6sq5vSXjunhFYsSTxsh/j2f4I1YxYhUYr5JJ0jaYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196518; c=relaxed/simple;
	bh=kYHhmfnLG5HO9XeGNi2d/5YSdEu6N9g/zbGGaVRMKOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmwowPOKWrOZ4gslsGFU0w4izkxpYxCKL9C2f2FR66QzOqGd4cqJ/FxT2blgICd12RIHju10GE4o0HbytruVS5yrmu4DKI0Cq3faEM+hTVnd3OjbYSaDTvEgkEC77+s1uMZffcHXZ+m00wN1EskM5yUwJdCppBRZzrwL9kA4cbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gvX9AuuE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709196515;
	bh=kYHhmfnLG5HO9XeGNi2d/5YSdEu6N9g/zbGGaVRMKOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gvX9AuuEiHwkrntXGHzsmKj734fg4wfbGdKn4yAQMkFil9vXY4lJkIv5j2K4TVRaJ
	 ryFqWs9JcOV3h2RdIh/57XVu8wsho+piA4KoMqsLKnthXtfsLA/WcfNIGXLW44od5x
	 E09janHFHzDURjwqXth560VZsQZ7Eb10dgDmzggsxgBNQaD1XeihHsIiVcHgwPY/Iv
	 2I2j42a3rs6Ue5abbpDS94WrJRYt5B98JetPhU/cY5CRbHwWW7IPp4K9OyCkJqHxrz
	 Zg+TihLG0vg7xi5epI1bQevgyUdaEyUi5kteyeFeC5cMgUuKiYwOhvJg4k9TujgCIa
	 7U10ziiYpy20Q==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C8C4A37810EF;
	Thu, 29 Feb 2024 08:48:34 +0000 (UTC)
Date: Thu, 29 Feb 2024 10:48:33 +0200
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, Melissa Wen
 <melissa.srw@gmail.com>, =?UTF-8?B?TWHDrXJh?= Canal
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 3/9] drm/vkms: write/update the documentation for
 pixel conversion and pixel write functions
Message-ID: <20240229104833.2a404d6b.pekka.paalanen@collabora.com>
In-Reply-To: <Zd35cimh8BLICUuY@localhost.localdomain>
References: <20240223-yuv-v2-0-aa6be2827bb7@bootlin.com>
	<20240223-yuv-v2-3-aa6be2827bb7@bootlin.com>
	<20240226133700.3fef91d9.pekka.paalanen@collabora.com>
	<Zd35cimh8BLICUuY@localhost.localdomain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+HboMIL2MT+JY+7LlICC2fx";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/+HboMIL2MT+JY+7LlICC2fx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 16:02:10 +0100
Louis Chauvet <louis.chauvet@bootlin.com> wrote:

> [...]
>=20
> > > diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vk=
ms/vkms_formats.c
> > > index 172830a3936a..cb7a49b7c8e7 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_formats.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> > > @@ -9,6 +9,17 @@
> > > =20
> > >  #include "vkms_formats.h"
> > > =20
> > > +/**
> > > + * packed_pixels_offset() - Get the offset of the block containing t=
he pixel at coordinates x/y
> > > + * in the first plane
> > > + *
> > > + * @frame_info: Buffer metadata
> > > + * @x: The x coordinate of the wanted pixel in the buffer
> > > + * @y: The y coordinate of the wanted pixel in the buffer
> > > + *
> > > + * The caller must be aware that this offset is not always a pointer=
 to a pixel. If individual
> > > + * pixel values are needed, they have to be extracted from the resul=
ting block. =20
> >=20
> > Just wondering how the caller will be able to extract the right pixel
> > from the block without re-using the knowledge already used in this
> > function. I'd also expect the function to round down x,y to be
> > divisible by block dimensions, but that's not visible in this email.
> > Then the caller needs the remainder from the round-down, too? =20
>=20
> You are right, the current implementation is only working when block_h =
=3D=3D=20
> block_w =3D=3D 1. I think I wrote the documentation for PATCHv2 5/9, but =
when=20
> backporting this comment for PATCHv2 3/9 I forgot to update it.
> The new comment will be:
>=20
>  * pixels_offset() - Get the offset of a given pixel data at coordinate=20
>  * x/y in the first plane
>    [...]
>  * The caller must ensure that the framebuffer associated with this=20
>  * request uses a pixel format where block_h =3D=3D block_w =3D=3D 1.
>  * If this requirement is not fulfilled, the resulting offset can be=20
>  * completly wrong.

Hi Louis,

if there is no plan for how non-1x1 blocks would work yet, then I think
the above wording is fine. In my mind, the below wording would
encourage callers to seek out and try arbitrary tricks to make things
work for non-1x1 without rewriting the function to actually work.

I believe something would need to change in the function signature to
make it properly usable for non-1x1 blocks, but I too cannot suggest
anything off-hand.

>=20
> And yes, even after PATCHv2 5/9 it is not clear what is the offset. Is=20
> this better to replace the last sentence? (I will do the same update for=
=20
> the last sentence of packed_pixels_addr)
>=20
>    [...]
>  * The returned offset correspond to the offset of the block containing t=
he pixel at coordinates=20
>  * x/y.
>  * The caller must use this offset with care, as for formats with block_h=
 !=3D 1 or block_w !=3D 1=20
>  * the requested pixel value may have to be extracted from the block, eve=
n if they are=20
>  * individually adressable.
> =20
> > > + */
> > >  static size_t pixel_offset(const struct vkms_frame_info *frame_info,=
 int x, int y)
> > >  {
> > >  	struct drm_framebuffer *fb =3D frame_info->fb;
> > > @@ -17,12 +28,13 @@ static size_t pixel_offset(const struct vkms_fram=
e_info *frame_info, int x, int
> > >  			      + (x * fb->format->cpp[0]);
> > >  }
> > >   =20
>=20
> [...]
>=20
> > > +/**
> > > + * Retrieve the correct read_pixel function for a specific format.
> > > + * The returned pointer is NULL for unsupported pixel formats. The c=
aller must ensure that the
> > > + * pointer is valid before using it in a vkms_plane_state.
> > > + *
> > > + * @format: 4cc of the format =20
> >=20
> > Since there are many different 4cc style pixel format definition tables
> > in existence with conflicting definitions, it would not hurt to be more
> > specific that this is about DRM_FORMAT_* or drm_fourcc.h. =20
>=20
> Is this better?
>=20
>    @format: DRM_FORMAT_* value for which to obtain a conversion function =
(see [drm_fourcc.h])

Much better!


Thanks,
pq

> > > + */
> > >  void *get_pixel_conversion_function(u32 format)
> > >  {
> > >  	switch (format) {
> > > @@ -247,6 +280,13 @@ void *get_pixel_conversion_function(u32 format)
> > >  	}
> > >  }
> > > =20
> > > +/**
> > > + * Retrieve the correct write_pixel function for a specific format.
> > > + * The returned pointer is NULL for unsupported pixel formats. The c=
aller must ensure that the
> > > + * pointer is valid before using it in a vkms_writeback_job.
> > > + *
> > > + * @format: 4cc of the format =20
> >=20
> > This too. =20
>=20
> Ack, I will use the same as above
>=20
> > > + */
> > >  void *get_pixel_write_function(u32 format)
> > >  {
> > >  	switch (format) {
> > >  =20
> >=20
> > I couldn't check if the docs are correct since the patch context is not
> > wide enough, but they all sound plausible to me. =20
>=20
> I checked again, I don't see other errors than your first comment.
> =20
> >=20
> > Thanks,
> > pq =20
>=20
> Kind regards,
> Louis Chauvet
>=20
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


--Sig_/+HboMIL2MT+JY+7LlICC2fx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmXgROEACgkQI1/ltBGq
qqcOIA//aVbdxJehk47q1mIdt/oLv2wc2VwNal9EyfCqvqtOUgDvCzQBu/ZTrA8q
AigVdfkno5Zg80Uypzi+GPVnq16I4eeqG/KdhEe5Av2hVML5WX52fE2RHVJIkGyv
7CcROr/W8JLdELRr4q3P5UM616f/ro4O0m/570KimJv2OZsfTvAOnLjLPuxkSov+
QaMCpMwpTmxyPqokgiBl6VzYVzK/vvI2aae90e1e7WofOaDW+1XAtfj7DrzdsMWP
dq9KtZJDFR9Rurxqy90a5Kk1lmXQIxviRhK/jcSMyXkibqM7vNC21kgRjtYbcqbM
CplfADBP9O5N6uMdx0rq4sUKBOoGTwn9A3PcMRbec6YFd3kkDo7l1Q7idjpU0fJo
xtyP+h5kJfIfybCr8b7MHRp2pqYUbDtPa0bg0Ez7kmtI1kIR99PAf/bzH+JKYgAH
DoBfrBSg4m7mTjdFnPHMZPrVxChZc6QcPFtDa4YYajFv9idcnVCLnIwQ48nzr8ts
DokTuYJVjiwwrBlgwaWkRTTBNM6Chx0HYf30nhI8+6dTvITz9DLhrH83kuQ5oXx3
cXvagRFWixps/PEoYL2a85BMSfCZONvY25O0oHNoEoEuNEv3teqV6CS3h5iElN+5
VLpfLdWCOozCl0OlJIQXWlcELKOamxkICXPB1/+xP8DN5+yM2/c=
=x/di
-----END PGP SIGNATURE-----

--Sig_/+HboMIL2MT+JY+7LlICC2fx--

