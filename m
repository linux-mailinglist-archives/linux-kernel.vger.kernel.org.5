Return-Path: <linux-kernel+bounces-136400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33989D3A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89D2B22771
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C1C7D401;
	Tue,  9 Apr 2024 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kkUhHOmu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0337D09F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649543; cv=none; b=tv9X7IfxjWDsPgJdO7zgYDxucV4zG1qEpJTbQ5mbsW1z3Z//35UrfrtauzBW6ZBR0Yu/gIhAA5JQiw9VDFlMHQazSNCG5LlueuyuSxW/Lsg0tTa5KiF7j73PK0U+Y2ZMkRDix5CknPraRPK+NaDtqBbhqKSy7FwiFIxyc/GzMmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649543; c=relaxed/simple;
	bh=dLKOMyhtKmhlC3YbJoN0ohob8NnhABYeTzB/vfsW/vA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mx1qqoGukt7R8dcUvRRVhsXbcAEjIr1l2jhjIUfEyiQ9QTHKK+TVqTp3rcVb868xwd+9GwPmsbBVIJvlmVDLQxy4BdyJ4CTdl89b6pBslmR0yptXZ3hRHIy2LCagDjqPYQn9uLGun5QVL61bIAxI2vOivuEU5OdD4G/xQPCAcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kkUhHOmu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712649539;
	bh=dLKOMyhtKmhlC3YbJoN0ohob8NnhABYeTzB/vfsW/vA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kkUhHOmuTuZQOjlFPXplAS5apL8UN9YyYx00dw3Ol/wKR5xlbEg7SBwt+WQKfHwlL
	 N2W/45ZAQPjtPM+7tDcvm881xhKK4amLyuooeSz0RHRhlWl3eTRFZTEaP+nEiQrbiH
	 NhWLLUf0W81a1yxK0aWB9dHcMbUrXqroBvuuWtz0BYSp3qsTCWsdRWpEqH9Y8uE0vx
	 ikWixg+5tSAvQesBrMh++0Ud2RgvlnbqXwMEWrLARGc9zYlfHvQVrxidqduYecyXjc
	 3/E6+/m51sbFFOD6ZQkMZGIITLbEAGbyoC9k6xYe9a+AyGTc3UzBpSLrLN8bSjcwFB
	 25kXr0/NAAR8A==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C27D8378201A;
	Tue,  9 Apr 2024 07:58:58 +0000 (UTC)
Date: Tue, 9 Apr 2024 10:58:57 +0300
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
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com
Subject: Re: [PATCH v5 11/16] drm/vkms: Add YUV support
Message-ID: <20240409105857.67bc4ce4.pekka.paalanen@collabora.com>
In-Reply-To: <ZhOhuzllWYooTPa6@louis-chauvet-laptop>
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
	<20240313-yuv-v5-11-e610cbd03f52@bootlin.com>
	<20240327162307.4b9b6e45.pekka.paalanen@collabora.com>
	<ZhOhuzllWYooTPa6@louis-chauvet-laptop>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fVDdWk=FzgUFdnUcuMEw65J";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/fVDdWk=FzgUFdnUcuMEw65J
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Apr 2024 09:50:19 +0200
Louis Chauvet <louis.chauvet@bootlin.com> wrote:

> Le 27/03/24 - 16:23, Pekka Paalanen a =C3=A9crit :
> > On Wed, 13 Mar 2024 18:45:05 +0100
> > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> >  =20
> > > From: Arthur Grillo <arthurgrillo@riseup.net>
> > >=20
> > > Add support to the YUV formats bellow:
> > >=20
> > > - NV12/NV16/NV24
> > > - NV21/NV61/NV42
> > > - YUV420/YUV422/YUV444
> > > - YVU420/YVU422/YVU444
> > >=20
> > > The conversion from yuv to rgb is done with fixed-point arithmetic, u=
sing
> > > 32.32 floats and the drm_fixed helpers. =20
> >=20
> > You mean fixed-point, not floating-point (floats).
> >  =20
> > >=20
> > > To do the conversion, a specific matrix must be used for each color r=
ange
> > > (DRM_COLOR_*_RANGE) and encoding (DRM_COLOR_*). This matrix is stored=
 in
> > > the `conversion_matrix` struct, along with the specific y_offset need=
ed.
> > > This matrix is queried only once, in `vkms_plane_atomic_update` and
> > > stored in a `vkms_plane_state`. Those conversion matrices of each
> > > encoding and range were obtained by rounding the values of the origin=
al
> > > conversion matrices multiplied by 2^32. This is done to avoid the use=
 of
> > > floating point operations.
> > >=20
> > > The same reading function is used for YUV and YVU formats. As the only
> > > difference between those two category of formats is the order of fiel=
d, a
> > > simple swap in conversion matrix columns allows using the same functi=
on. =20
> >=20
> > Sounds good!
> >  =20
> > > Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> > > [Louis Chauvet:
> > > - Adapted Arthur's work
> > > - Implemented the read_line_t callbacks for yuv
> > > - add struct conversion_matrix
> > > - remove struct pixel_yuv_u8
> > > - update the commit message
> > > - Merge the modifications from Arthur]
> > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_drv.h     |  22 ++
> > >  drivers/gpu/drm/vkms/vkms_formats.c | 431 ++++++++++++++++++++++++++=
++++++++++
> > >  drivers/gpu/drm/vkms/vkms_formats.h |   4 +
> > >  drivers/gpu/drm/vkms/vkms_plane.c   |  17 +-
> > >  4 files changed, 473 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/v=
kms_drv.h
> > > index 23e1d247468d..f3116084de5a 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > > +++ b/drivers/gpu/drm/vkms/vkms_drv.h

..

> > > +static struct pixel_argb_u16 argb_u16_from_yuv888(u8 y, u8 cb, u8 cr,
> > > +						  struct conversion_matrix *matrix) =20
> >=20
> > If you are using the "swap the matrix columns" trick, then you cannot
> > call these cb, cr nor even u,v, because they might be the opposite.
> > They are simply the first and second chroma channel, and their meaning
> > depends on the given matrix. =20
>=20
> I will rename them for v6, channel_1 and channel_2.
>=20
> > > +{
> > > +	u8 r, g, b;
> > > +	s64 fp_y, fp_cb, fp_cr;
> > > +	s64 fp_r, fp_g, fp_b;
> > > +
> > > +	fp_y =3D y - matrix->y_offset;
> > > +	fp_cb =3D cb - 128;
> > > +	fp_cr =3D cr - 128; =20
> >=20
> > This looks like an incorrect way to convert u8 to fixed-point, but...
> > =20
> > > +
> > > +	fp_y =3D drm_int2fixp(fp_y);
> > > +	fp_cb =3D drm_int2fixp(fp_cb);
> > > +	fp_cr =3D drm_int2fixp(fp_cr); =20
> >=20
> > I find it confusing to re-purpose variables like this.
> >=20
> > I'd do just
> >=20
> > 	fp_c1 =3D drm_int2fixp((int)c1 - 128); =20
>=20
> I agree with this remark, I will change it for the v6.
>=20
> > If the function arguments were int to begin with, then the cast would
> > be obviously unnecessary. =20
>=20
> For this I'm less sure. The name of the function and the usage is=20
> explicit: we want to use u8 as input. As we manipulate pointers in=20
> read_line, I don't know how it will works if the pointer is dereferenced=
=20
> to a int instead of a u8.

Dereference operator acts on its input type. What happens to the result
is irrelevant.

If we have

u8 *p =3D ...;

void foo(int x);

then you can call

foo(*v);

if that was your question. Dereference acts on u8* which results in u8.
Then it gets implicitly cast to int.

However, you have a semantic reason to keep the argument as u8, and
that is fine.

> > So, what you have in fp variables at this point is fractional numbers
> > in the 8-bit integer scale. However, because the target format is
> > 16-bit, you should not show the extra precision away here. Instead,
> > multiply by 257 to bring the values to 16-bit scale, and do the RGB
> > clamping to 16-bit, not 8-bit.
> >  =20
> > > +
> > > +	fp_r =3D drm_fixp_mul(matrix->matrix[0][0], fp_y) +
> > > +	       drm_fixp_mul(matrix->matrix[0][1], fp_cb) +
> > > +	       drm_fixp_mul(matrix->matrix[0][2], fp_cr);
> > > +	fp_g =3D drm_fixp_mul(matrix->matrix[1][0], fp_y) +
> > > +	       drm_fixp_mul(matrix->matrix[1][1], fp_cb) +
> > > +	       drm_fixp_mul(matrix->matrix[1][2], fp_cr);
> > > +	fp_b =3D drm_fixp_mul(matrix->matrix[2][0], fp_y) +
> > > +	       drm_fixp_mul(matrix->matrix[2][1], fp_cb) +
> > > +	       drm_fixp_mul(matrix->matrix[2][2], fp_cr);
> > > +
> > > +	fp_r =3D drm_fixp2int_round(fp_r);
> > > +	fp_g =3D drm_fixp2int_round(fp_g);
> > > +	fp_b =3D drm_fixp2int_round(fp_b);
> > > +
> > > +	r =3D clamp(fp_r, 0, 0xff);
> > > +	g =3D clamp(fp_g, 0, 0xff);
> > > +	b =3D clamp(fp_b, 0, 0xff);
> > > +
> > > +	return argb_u16_from_u8888(255, r, g, b); =20
> >=20
> > Going through argb_u16_from_u8888() will throw away precision. =20
>=20
> I tried to fix it in the v6, IGT tests pass. If something is wrong in the=
=20
> v6, please let me know.
>=20
> > > +}
> > > +
> > >  /*
> > >   * The following functions are read_line function for each pixel for=
mat supported by VKMS.
> > >   *
> > > @@ -293,6 +367,79 @@ static void RGB565_read_line(const struct vkms_p=
lane_state *plane, int x_start,
> > >  	}
> > >  }
> > > =20
> > > +/*
> > > + * This callback can be used for yuv and yvu formats, given a proper=
ly modified conversion matrix
> > > + * (column inversion) =20
> >=20
> > Would be nice to explain what semi_planar_yuv means, so that the
> > documentation for these functions would show how they differ rather
> > than all saying exactly the same thing. =20
>=20
>  /* This callback can be used for YUV format where each color component i=
s=20
>   * stored in a different plane (often called planar formats). It will=20
>   * handle correctly subsampling.
>=20
>  /*
>   * This callback can be used for YUV formats where U and V values are=20
>   * stored in the same plane (often called semi-planar formats). It will=
=20
>   * corectly handle subsampling.
>   *=20
>   * The conversion matrix stored in the @plane is used to:
>   * - Apply the correct color range and encoding
>   * - Convert YUV and YVU with the same function (a simple column swap is=
=20
>   *   needed)
>   */

Sounds good. I'd just drop the "It will handle correctly subsampling."
because all code is supposed to be correct by default.

If there is a function that intentionally overlooks something, that
certainly should be documented.


Thanks,
pq

--Sig_/fVDdWk=FzgUFdnUcuMEw65J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmYU9UEACgkQI1/ltBGq
qqeVQA//W+uatYYBrd6J4hsIz2TsJcNaj2djql15wCH0v2cQIi7TE9QiZdjqbY9m
B3zqn+XVkgDk9kPS0xHM6xoagJFhc7JSeWhyhJgKcIx4VLoWs/LTGswDw89vL0Th
KQ6ZIMAhBAiy1Dm020fGAFo9fsyhnVLd4tnazduBeBBz1HNiFzpLv+uy8V4a8hBc
2Gtgt+YXstUm5oOZGytGrkDjUi8Eat3HdEyBDi5/SVjv1kCIaspbvBHlTC19uXZF
VR4qJTbut5SbTXGCJOL9YZGnGwC4PBGDBUqJvB/iofLSL5sfmyV5dL7eg+VkBYMb
BVG6rm0dC9ptJuFnQVHTTHrvIPdBegDvdhb4U2kcqrNsuMp9Vv5tzOgiFxGBMxvP
c2+4akgcnXo9EFCtN5CKkL7WynuDPTxlusa3uqteG6R12tz9ueC6v7fNsXHv4JGH
ggFeDZ8YHG3YD/YGP4AKfWkPh3Q79YxFqF+9HHcX9VDc+aAok9GbaVRl2zvkM1rK
JHG+eRiGZ3pFwHKJgOCmiQDGOYzvVdesfbvxxj9a1n2fMdZeq3CYmZNFymoTYuMd
UnOtT9VhB4o2xJPeOdO4XGHwWI/VDn4c9/ajOjLGTFgu6mPR+bc3AnageOH2rh2k
TNrTtDSjWXa2LoN1c4DL8bZH58VYXDMKS/5cNildT2DlBWehasI=
=U4Ph
-----END PGP SIGNATURE-----

--Sig_/fVDdWk=FzgUFdnUcuMEw65J--

